Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9EECCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC88783DDD;
	Fri,  7 Nov 2025 15:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VkW2hhiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C57083DCB; Fri,  7 Nov 2025 15:17:10 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75AF783D90
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c2948b774cso455152a34.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 06:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762525027; x=1763129827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gG2RvMb6iiFc47pWjDTcjEo5puQFtoo8DBqGMig3SSw=;
 b=VkW2hhivXtDnmN5tVZm889na8D7pqx/a6jCGchJ57LIprQMsX1JoEszFXpBNofg9O5
 mSrkuJMkG5YChz9Af7uEiwbspdeHbIyANtSSC0D9mcFMplVtw9txqXrIXbysh4TFVKIo
 P8T8pGsLe3i5eY8ARPdgP/2u3c+Id7qcs6k+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762525027; x=1763129827;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gG2RvMb6iiFc47pWjDTcjEo5puQFtoo8DBqGMig3SSw=;
 b=bpq6/ejKoOHBbXvKiJKccRc/YJ6Qfp5hkLifWDiivuKoHsCdh7uYuPeutF5Kn31WKg
 F9lPnaPQA1rZIgn5Zexp+GUyMMv2kB1dH9hDYpOaqowPL6AsC6KFpUqaIzop+NtGiW4n
 mtlGzPHfwbZAAGbfS6wx3CtmR4cF7vtLz/uFshqPgSdqGLTWuFskGjAkpFvRiTQg7rYd
 0I4o9U2c+2zE/qQVO+sv6F3ubC0hmw/Fr7Atzyt/vNI/CB4WGvsJX/ZXBdx4JQG7tsEO
 lREwaWrVdPc3PphymaszDXP2I06h1kovxns6NLiO8QPMcs0R9wEAtaNfX5I9MYse8Q1v
 c90A==
X-Gm-Message-State: AOJu0YzhpKQD9sQedEh5933cVa4EHT+PbcYpn11SRQw4vlGObUcoLbmC
 SerJh2KXhVmH1loM1uthFgv829Y5dYY0SQFPHYvayxHThPs+VCg/dGrcmA2Relc8mA1uCgiBMP7
 apkMYL6lgsg==
X-Gm-Gg: ASbGncsX2yqOETNpNnHsa9L/YYDAjAdJHJKOkvfcvf6KiLusoBo5hQrWnN336lcLcIP
 dhpLr7YNB5hlreq0VHH5aCfXQCTcL7SHYluDZLBJDujuRGN/Rz4jxtigzHbmuxK2f2UPgTnmKwF
 peWdwZjjcWdxij/SfyBI7tuP4JD9XPdGlf0HK3pQgvjJRWF9fKTJyiQdB8rO2nwXhERAzV8FRTG
 LuGU2epWFi1CWa0cBq9ju/T2LNGD2y32m9cLwLlyfHk4bUDgeWRIuf5nP5X4Vy3X6E8yTmnhlpP
 lnr6wXovGTouwc8WQipC9kciDDPW/R9wObFo43xqfAq8kMaH4d5cP4F7lEt38pIqy9UVeEzxIzg
 rBvb5JPg8jEYN+lzHUwrWbIxcq9BmktKhftWUDBpe3wEhjfN26A3X+CqD3AI2xGNRY6jpcctAJK
 UYsz/Ksw8JSO80EH1aeUER/emZ5ri8JgtlZKw0XxNFrPpj8DFN
X-Google-Smtp-Source: AGHT+IFMzp9iTuW81dHlYACakexB2g48QoKzBi/t6CfAIwdv686GLdlszvSGbdNqiN9cBrY/pENYIA==
X-Received: by 2002:a05:6830:448a:b0:7c3:e07f:568a with SMTP id
 46e09a7af769-7c6efd909d1mr2607398a34.11.1762525027220; 
 Fri, 07 Nov 2025 06:17:07 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0bb8dsm1479692a34.6.2025.11.07.06.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:17:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Quentin Schulz <foss+uboot@0leil.net>
Cc: Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251029-vpl-dm-serial-v1-1-7117f541511f@cherry.de>
References: <20251029-vpl-dm-serial-v1-1-7117f541511f@cherry.de>
Subject: Re: [PATCH] serial: make VPL_DM_SERIAL depend on VPL_DM
Message-Id: <176252502618.3410992.8678868005810108652.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 08:17:06 -0600
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

On Wed, 29 Oct 2025 12:17:43 +0100, Quentin Schulz wrote:

> I have a hunch VPL_DM_SERIAL should not be selectable if VPL isn't set
> as implied by the prefix. Additionally, still based on the prefix, I'm
> assuming VPL_DM should be a dependency. Since VPL_DM can only be
> selectable when VPL is enabled, only depend on VPL_DM.
> 
> This mirrors SPL_DM_SERIAL and TPL_DM_SERIAL so seems right to me.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] serial: make VPL_DM_SERIAL depend on VPL_DM
      commit: 9c23910f665d262f3d3894551c9c731a24d2f0be
-- 
Tom


