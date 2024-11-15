Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A50D68BD8
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 21:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04AF896EC;
	Fri, 15 Nov 2024 22:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gcQdYFXw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53694896D5; Fri, 15 Nov 2024 22:39:24 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A997D88E32
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 22:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4609beb631aso552901cf.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 13:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731706760; x=1732311560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hm8gyQ6carZfqA1UxuPCB9E2frscgKdGqZLxGMT0g0=;
 b=gcQdYFXwk2oq2W/Xsw281Lhv43mdIdeVxrQjzjsS0F031zZl023Thz9w0cyjx/GlHh
 YJ8Dk6pA4fMFcPGc8yBa666SNS3sgp0OtUKm1YEXEYRiGBUDaFU9d0ebLES6q5Lyhj0y
 wItVPNFJvZxLqZmAOPVMg8kmm9YwFRgAnQ3Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731706760; x=1732311560;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9hm8gyQ6carZfqA1UxuPCB9E2frscgKdGqZLxGMT0g0=;
 b=omBMXp5nMiB0nWm0ctPVhN2IdE47mKdC4LxYxoS0xR3r554wCcnfPLWwq3/dAez5/4
 uNe1ksrl0lIUsYkND4R+A3Od27bGQ1+N3yB97LQPnls65qHpajgQ3IU8Ut0PniafeywO
 R28pBGY5mM5DfpU+wlelnc5z1oM46VnDNr5d9waX24vtQzbcz/B1AKijPKuiedacLEH4
 rcJt4wxg+w4KP5n9rGrupMbrY214X6BElb2aTvz7iPnS1MoILgXM12tACncXWgSpuWk4
 UekLswX1iKaQgRjlmhs+SAbglR6BBxcL6fKApiUt1TMRzgEzbzd1IDMWzdoB2/hvS0+j
 ZlcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3fvOjfcbgLXkufz5pRrofhv9aQuAFE6pyY9R9ixRgmEkyVJCJQrxJzlia/ROlb37eWkuVX+8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0MYshsHJFAclA0HqNfXCNad6VpVK4tW2DM4We376nXtsQbotd
 uO6jFSiPoqLEaJDXowMUGmQ4y9dYun2X4JhgD1aEsk4RpaxjCZbArna2XfDn9Ug=
X-Google-Smtp-Source: AGHT+IGfk9G8PoTPySKrCQBPuzkdP4jCr2rcaGZCfabomz6xGDBpBnHelXBYPZjtIsPJ+bCK7yupAg==
X-Received: by 2002:ac8:5753:0:b0:460:a037:edba with SMTP id
 d75a77b69052e-46363eb2747mr54904631cf.46.1731706760511; 
 Fri, 15 Nov 2024 13:39:20 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca68b71sm201771885a.125.2024.11.15.13.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 13:39:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Qu Wenruo <wqu@suse.com>, Dominique Martinet <asmadeus@codewreck.org>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>, 
 linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
In-Reply-To: <20241115021549.671932-1-asmadeus@codewreck.org>
References: <20241115021549.671932-1-asmadeus@codewreck.org>
Subject: Re: [PATCH u-boot v2] fs: btrfs: hide duplicate 'Cannot lookup
 file' error on 'load'
Message-Id: <173170675838.2851979.15988769611030245565.b4-ty@konsulko.com>
Date: Fri, 15 Nov 2024 15:39:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 15 Nov 2024 11:15:47 +0900, Dominique Martinet wrote:

> Running commands such as 'load mmc 2:1 $addr $path' when path does not
> exists will print an error twice if the file does not exist, e.g.:
> ```
> Cannot lookup file boot/boot.scr
> Failed to load 'boot/boot.scr'
> ```
> (where the first line is printed by btrfs and the second by common fs
> code)
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


