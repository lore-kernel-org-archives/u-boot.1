Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BF6C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 00:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9605F84AC3;
	Sat, 11 Jul 2026 02:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EPHqt2Ga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1139184BB8; Sat, 11 Jul 2026 02:17:32 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 020AC84A92
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 02:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7ea9c6ea7deso1195587a34.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783729048; x=1784333848; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e/vhfpQf4OV2qMLQtG4Mk/3KvquVjRSLEAPXaxUkjFc=;
 b=EPHqt2Gasw7ybiCE7SQLuReNYoJUx8mTu5WwLuccF7p6uNPiBSNdN8Wog/UGnFYArA
 YzGsZfQuOm5UoozdEkDL2OVAaZ4qnDiY2jOKeFHcGinNbNtUSLZfPlKKvdyK9eC0QXrn
 +zCQJfXxOEd2fCojPSeVBxlfV6V3mdlSxeCMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783729048; x=1784333848;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e/vhfpQf4OV2qMLQtG4Mk/3KvquVjRSLEAPXaxUkjFc=;
 b=jIFFDduTOzYoZMZjRDqfWksMqGbLyBH6s202K10B/zufC1xpWQlmVMlWFEcc/L4xo9
 147/wbIY+G7aGHoYr+pvXPtDsSyIlc0HPWextwKhpPSHIKs6YCcc/1BrJ+3q7QV2cUkt
 7o0aTC46jDnqB90vGyGv2B5/2BJQN3nvfDS51JMxDWkF+DuTeQyjdDJv0q08p1RWKz76
 paCrfr6gRqDe9kQOyL5+ylw6cSd2/NtHhvzUeDvIKzTgBtU+8UZPwG1i99soMUkY6IyP
 hJRhzKFkfhbNFh+GFHJjmX2Tyq9FXuUrBt9LKhgaDG2cy3mJNqnYhtyDR7z+Jt+Basgw
 wfTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+D76guIRCrEgjkNavdg+KhRYKVLfZoefQK2he3zi1l6PvGAhWEmbGK397qyX+p/8KWxjYmwCA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy61R8P2dPnjRQqYONOeqsFi4d1b6a9I59FoSnTqKQpkOT9jRhn
 7oIWDTe4GI56f0EVlz7na2Lsg3g0roUAxa2AJNO7zQJmrd9c5luwE/6IVvZPpvfLrlQ=
X-Gm-Gg: AfdE7cmxz1qGKRTTrRXBcxQd9kDs7P/GP5rS2uCkCzPjmlrDGjPkc8boK89y+Mp2RTp
 yfjHF2H1TAyiq82M0Q9q9VmAL25k35it7Q4rG+GFveevzQf7+6jYBAv5Tj7JHi7Ws+g5NFpglQw
 ngJpYQHpO5aLJap5H5LiyobsORX2vN865V8t31fId7p56no+BUHOQ8GNR1Mmq0jk59FlIh7/cIz
 gXBVp4+xxdj/RDsLeNg+HdZvob8huOzT//8F0T0pXeKp9JWNAnNZ+RuYFOF2EF7b3Vwc5gQi+zh
 i57oxlo811ZacsA4m+qKauB8ZmD3AJdGUdo9gs26YDK6yrb2TsbFJ2qgCMlE6F485x2eFYxr82N
 KXbG5Uuykw5H+wBRcWyyCocM3flenkEfkBp3HsCbggLcF7i0Rj9z5hc8rmfCzFK8iWS3yWGGBUS
 RHM63BJtGCFyeFuKwazBd4uEt7BBM8+1EwyofFO4UaAQzwAuIQH8/4v+KJSBIplpHxd4rGOfmK9
 TKJd4YTwSc5rG+SvxHFFLUzfdhGq6x+F5o+1gcCNnlgNfA=
X-Received: by 2002:a4a:e845:0:b0:6a1:77ce:1b09 with SMTP id
 006d021491bc7-6a39a56f825mr947347eaf.6.1783729048128; 
 Fri, 10 Jul 2026 17:17:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a39af0e953sm651312eaf.3.2026.07.10.17.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 17:17:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
 u-boot@lists.denx.de, Alexey Charkov <alchark@flipper.net>
Cc: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>
In-Reply-To: <20260626-btrfs-readdir-v2-0-7dd43f72d1b4@flipper.net>
References: <20260626-btrfs-readdir-v2-0-7dd43f72d1b4@flipper.net>
Subject: Re: [PATCH v2 0/2] fs: btrfs: add support for readdir
Message-Id: <178372904690.2905849.8798963092987519032.b4-ty@konsulko.com>
Date: Fri, 10 Jul 2026 18:17:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 26 Jun 2026 19:18:20 +0400, Alexey Charkov wrote:

> Btrfs in U-boot currently uses a custom callback for ls and doesn't expose
> the standard opendir/readdir/closedir interface, making it harder to use
> in generic code. One area where this would be useful is in discovering BLS
> type 1 entries [1] on a Btrfs filesystem.
> 
> Add support for the standard interface, and implement ls in terms of it.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] fs: btrfs: implement opendir(), readdir() and closedir()
      commit: 5f064aef5d766e291982f9cba6dc728dcdb53868
[2/2] fs: btrfs: use fs_ls_generic() and drop custom implementation
      commit: 31cf3f177823362a42bf4630ec85370ea768ddf1
-- 
Tom


