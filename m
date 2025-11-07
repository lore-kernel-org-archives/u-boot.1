Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2D0CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD37083DDF;
	Fri,  7 Nov 2025 15:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RP2zeVCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E966D83DF2; Fri,  7 Nov 2025 15:17:13 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D037983DAE
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c5333e7033so260306a34.2
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 06:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762525030; x=1763129830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZncefrrGhcmFzFLkr+LQ+Q3qgcsOPOYTdmtVF2CHots=;
 b=RP2zeVCq0e9BeOs0kzHSwdedx0urYrn18Is9QOhYErtPaPivzW3KkMbkKToRsiW5XD
 8RIpFHJin9IjUOnKGlwHO8tTxjW9WVzi3bMDDMlcvUci0z7CmPFHp+ZPOCMe9JxgedFM
 mYqieAzOWlb4QX+2/RUcBoU9Cd5f0/fgn7Wcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762525030; x=1763129830;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZncefrrGhcmFzFLkr+LQ+Q3qgcsOPOYTdmtVF2CHots=;
 b=Qm+4i8HHH/pYf0r6peec0L6jvXKHpMSgbTSz+xEn96UH4JeYbatRwquJ8part3YyFa
 lMgevDb+xP8F4e2uHRa8w/2Xa/KyANXCkscZXitDJuZGcIFKhH6iwQmnPDGL3uR1V+md
 7GESuOi/yEpWHbpFY6Bdh2mWLHEeTdt58uDvuyQCZl64PPISwRi24bj1+akFdr9PjRE/
 CcQpLTuyluiHJKRo5S2Dds4qcHGjN0h+a2fxtUaDPzL39IFhEmX3Dl94uyj2ftKUuiSn
 U5+niQcXu8q/dPt3nqxJxaRp8R05IP7Kk3vgatfqnTonKPZH3/9y1iI6f1BuNSL/RlMU
 ebqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFdtP0cH4oLfT2m5duD1jarrH4FZEg/9zplV16cjya4XtGhIvkERyO7iCk9ElSlgBy+ABO6Vs=@lists.denx.de
X-Gm-Message-State: AOJu0YzgXTJHkRKa7FHYFC5Szg5dODIz3rNWaoT4SyoGdo/CHHb7Aesv
 c6QU3WpvZ6WzVC97iao0Reri4bJdDRHV6Mhb8MRcD5rjCHwgsx6sjacFH+0LZvbL730=
X-Gm-Gg: ASbGncsV72cGGIQJG0pS/BIrHB8y/3WPB3xgSW0uCA4tOqIt8BifWWzprm1A41T9nH1
 OyVmlSjubcTZ2we1gfZ4nBwVwXHjUEYGAcpSGZ+z3m04Q+RxbozuwJbyUymqSwpzl08n1zpmImd
 q1sNDFeZMMA/Hl6TE6UTQBouRNN2Vzg1GDri2B55cf3esLkNfOGo6hk6Nc9hHocGwL30eSwqjqU
 hBBUZzcneWax5OSOhM3HFNjyhv0UyC1Y6mA/PW2FlFFYT6lO1filPVlR3rXlB1F/uwDaBM6sOd5
 BNSlI1fPGrlexyy7kjVNBT+sZCecbp8lSbBAXAr+jPHzCMoTv7YBGtgqy9PwXnY/odo9tQg7Ryf
 84rm5cEj48OvQuwDLAXfvXFK+GXkpxsi4V9kCoXtg5scEPuWMwscb9kvEgGZEGu5spBo12B2sJq
 V50z57C9aGaZVxO4Z7oCfJfblEKUBIVGQqjFKS3A==
X-Google-Smtp-Source: AGHT+IE/onSCO3y1nxmdsyarlZVO9SdYtJjut5tdbUK+4DS8HArkm1c9JAWym26CgQhsl+yfDmdMMA==
X-Received: by 2002:a05:6830:44a6:b0:7b8:f2a2:46b8 with SMTP id
 46e09a7af769-7c6eff33e3bmr2858078a34.17.1762525030554; 
 Fri, 07 Nov 2025 06:17:10 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0bb8dsm1479692a34.6.2025.11.07.06.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:17:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: afd@ti.com, b-liu@ti.com, bb@ti.com, m-chawdhry@ti.com, 
 n-francis@ti.com, nm@ti.com, u-boot@lists.denx.de, vigneshr@ti.com
In-Reply-To: <20251031073800.344500-1-anshuld@ti.com>
References: <20251031073800.344500-1-anshuld@ti.com>
Subject: Re: [PATCH v10 0/7] Allow falcon boot from R5 SPL on TI's AM62 devices
Message-Id: <176252502960.3410992.14466616777254451871.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 08:17:09 -0600
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

On Fri, 31 Oct 2025 13:07:50 +0530, Anshul Dalal wrote:

> This patch set adds support for falcon boot on AM62a, 62p and 62x by bypassing
> A53 SPL and U-boot.
> 
> Existing Boot flow:
> R5 SPL -> ATF -> A53 SPL -> U-Boot -> Linux Kernel
> 
> Updated flow:
> R5 SPL -> ATF -> Linux Kernel
> 
> [...]

Applied to u-boot/master, thanks!

[1/7] arm: k3-binman: add tifalcon.bin for falcon mode
      commit: 4f9765d943437c9139399c03dfdd7864d8c3488b
[2/7] configs: add falcon mode fragment for k3 devices
      commit: 197459d198c710e9cdab203270be68137ee90955
[3/7] mach-k3: common: enable falcon mode from R5 SPL
      commit: e40c406914aeadbb82cd84fe4d9f48efbcb1c68b
[4/7] mach-k3: common: support only MMC in R5 falcon mode
      commit: 18a3a7a9b82a8f01ca22f5c1979145a28805ad46
[5/7] mach-k3: r5: common: add fdt fixups for falcon mode
      commit: 518d8c1bec4cd78d3dc2ef574ae99f0918913175
[6/7] mach-k3: r5: common: add bootargs to kernel's dtb
      commit: 2da694254df2f061b4f5c7cecbc8a32ce77c6e68
[7/7] doc: ti: document R5 falcon mode for AM62 platforms
      commit: 489ec1ee14a87afa6c8a1a996878c5ac58b6827c
-- 
Tom


