Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CD3EE0AEC
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 00:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B516183BFE;
	Sun,  8 Feb 2026 01:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q1xHjD//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E9CD839A5; Sun,  8 Feb 2026 01:27:49 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73184839A5
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 01:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7cfd6f321b5so2082624a34.2
 for <u-boot@lists.denx.de>; Sat, 07 Feb 2026 16:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770510466; x=1771115266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7fLdrEij73annmAM9EJgc1ruPWdKFLVe7L+Us4LZP8=;
 b=Q1xHjD//x63faiBgbN7KeS7TgzhaodwdtRxDy8yYa8ARQ8SgFvASH0HHxorgi3yus6
 fKAsq2DRx6lH9z0/c0vP9Ij2UAhgGdlt8cqJBVga3MKpZMbTVUKgVPfL2yFwq17h7zg6
 TouU7YHRMqcu/fe90f9Qb1QSmeOwAoDwE9u3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770510466; x=1771115266;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+7fLdrEij73annmAM9EJgc1ruPWdKFLVe7L+Us4LZP8=;
 b=RYEmiDp8UUSqgqBB2wiywtTbUOkNuvDruO4BMMtj0sNzQ+Ikca62exSy0nayr3o3d4
 TELJ5xTvQgNhV1/K/rT2TyK6YvAGkClbrb4auGRcpxPiCj0a4vd30yEpPesKwc8X3A7i
 VbLOfxjmnJDMcm5xYDF2HphW0hpMkR1FIopn+Yt2ep/awpz/nZkYBe9D69uGfiZuNUdc
 L8Ph6zFDrAzgZS/nRso0U/QWfKbTByQ8kyLyUu57DkQs+tig+bhsRDWAwatJl9ivVF4C
 RfgdSOkJeLyaoW7PVjXQ5JDqDeN2YnQcaQk+KVBvElwbZuK7acl+5CysyOS0AudGx5AV
 8Cqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHeBjpRuG8A9IBso7OIbdTYdMBHsbssfflJ1ZzU6Jd4XyV/eg0E/0oPXXNiOuAIHqyDK06ZJc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz31w1JkDLmzkR2s0M/30yWGgMQTlJUUsB6gnMO6YdP2JJEzINx
 T1vWU4fjAhl9YKwUtgYS7Mi2kB3xUivQDuPEYJapfqw6kGOzD+WB1aqPWS81WgPviEOmzxUrUih
 sJrI8
X-Gm-Gg: AZuq6aLyoMuSGT842ekUpAP3suJi0pvKXHr63BqM5IaBU9ob3Q6kHZ6eH4xPdYNeBzt
 FoYfqDia5du8xXIEf8jLGacmLSUWnt+WJqpw7A7VCs9XPONgQMT4/7xTxrU7hIez3bzylW0kBx6
 ArXfq5I/bltlfnlsdTmJEWRs4dcjlMXDsXwozABNr4KPcINDNP8UKuFTkG1/z8gvblNbss1clIm
 H5idA8glW1m4XfV+V0u/3ULa3onyebPw+e1swAP4W/JWMr5G0u4QTSIg0V8ETAKXFtUvDVE+G+P
 luuX9xJFh97XbTj+6vXG3tjEd20LrwrRnJUrYasYIFJjcKr7/UzavRNP6Yr9U2U87wcOCad3nAC
 L0r0IrLXnJiJ0aoD6iinqRCwhs80Hifh4/dEZuroCIruRQb6dsd8ioJ8mE8VpZq9d3tZi+TnoHL
 IcjyzRbVI18KA4UZgcC5KhHfhRjon8OIVSywCxSd0QY2TCU1PExz/bRd9Xo06KpV7gXvf/glzwN
 xLnW5grzQ37bVMxfURNAyXdlSykmsRwExSGLg==
X-Received: by 2002:a05:6820:88f:b0:662:fef7:4dba with SMTP id
 006d021491bc7-66d0a66a003mr3528031eaf.32.1770510466130; 
 Sat, 07 Feb 2026 16:27:46 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3b2a6c16sm3552448eaf.16.2026.02.07.16.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 16:27:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260204184045.111808-1-linux@fw-web.de>
References: <20260204184045.111808-1-linux@fw-web.de>
Subject: Re: [PATCH v7 0/3] Add command for getting ramsize in scripts
Message-Id: <177051046491.295305.2849993254932528626.b4-ty@konsulko.com>
Date: Sat, 07 Feb 2026 18:27:44 -0600
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

On Wed, 04 Feb 2026 19:40:41 +0100, Frank Wunderlich wrote:

> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add command for getting ramsize in scripts
> 
> v7:
> - add guard for test to not fail for x86_64 qemu board
> - extend doc and config help text
> v6:
> - add missing return for error in env_set_long
> v5:
> - move msize to meminfo and drop first param (always display as MiB)
> - rename msize to memsize
> - add doc and test so it becomes a series
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] cmd: mem: add command for getting ram size for use in scripts
      commit: e202eca183b0f1d6747b934482dc6249abdd742b
[2/3] test: cmd: add test for memsize
      commit: 8acc8a654643ca26b0bdd4af37010da7cc796753
[3/3] doc: cmd: add usage doc for memsize
      commit: b4842032d542cfde271aab61b80ab870b27b07b2
-- 
Tom


