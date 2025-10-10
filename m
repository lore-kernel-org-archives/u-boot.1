Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54633CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9BEB8432E;
	Fri, 10 Oct 2025 21:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pSMGd/yw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB5EB8442B; Fri, 10 Oct 2025 21:23:28 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA4784057
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-64439bef307so705092eaf.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760124206; x=1760729006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXTuSpTzRX++g6ZnlXMimRdQCLL4Q7vktxN6CjJwR6g=;
 b=pSMGd/yw+0D/Un4CNmdCRyJpLuTMyrSn7pxWlgPTo+m99XOeSl/WImKYlCkqYImiBt
 H4AInxiN5W8qH3mdSwwqMVXB7wWeyCr9VUlfaFy4zABMJ9sKuBHrgqxnX+CUUoNDUWTv
 8bHl9sfl4Fg4ZDIa8bPr2Kexda03cpiB7DeMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760124206; x=1760729006;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KXTuSpTzRX++g6ZnlXMimRdQCLL4Q7vktxN6CjJwR6g=;
 b=VD/K5+ug0IIi6UgCIzoAx9O+lfg+PXISFxItDqw6Azf+k4Ajb5ra69iWVUNLFcJpui
 OBROKDSFwFcrk4b2Wv0CoAgLOIkiJ3PqM6LXHJEKATAOGPTmM91I5WrHB0ThbkZirT1o
 qK5uLccXfKmB8NlXGggj7vqRmg7bFqv0vOI8yLUWMqdu8upGn+tMxd82fdY6ysLuvXcy
 O9JL3B68SlKBynqIvhAi44VOiimRNPIImm3EALkB51Vq6fRWEfglH8PypYMTAKg1IVX9
 kmKClUow+QxHQzk14SK80cgfJWvR5t6ys+8ubq7g0uGijdKLCzbm/9XPo4lbjwuEMEGR
 UhXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbdjs84LL7wNWdcp+hqOWI85ssHzC2e8VE/pOPKaHHN7PmHGJpJrSDJ3xYVzdsd2eSw6GlJTY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw50OXkwCfvASaIAKtlgNUEYlwRK7RVpzshLGHmil6mUeVQCYcu
 HTsI8EZhqCG6e6ANs3u0pnP2o71Ozmn97gCsL1hjjmQAzSR0greukpVwRh5197BCclJhYLRdmMn
 xMG1Dwdw=
X-Gm-Gg: ASbGncveNvRVLqv7PiVsAS1bFzirt8SO58UphfbJNJXGicJd1JoUdJAViu8DyunUdJN
 KVVb5yuETWwgS7wVMdbBRE/uk4m4PSTjf6S1OsYdYEed7sGc76cGElDtXOvjLKDm7ytL0naqXzC
 I0iNnQ600e4MA68R2pmUMl+45gUkpKSyLOdfX/KqAJQMZDjzmwZo2ISZdPGTZvPgA5rO/Cw+ypL
 b7wMe8S74P4RGEycl1Nf+gkRmEBsT1hfLG9Rd2fGtNTCf7rdIJ1NnpfBiUVROzf5rFpTMUoOfYs
 7hnUo/7aHO1ojUuBbgE/NbnSXHvjjYKYiAVnRBF5TLVrtjrjhMdXf3u1A0agGlTniMojBtVyvyC
 cNDh3UV+YbnKZ1ovRFxUvqmas1X8j/6fjpRx/RcaoNJ3+5orCsuZaJZkRNSdZzA4aLmxGCBlAxQ
 7H2qpKhZT6jVyeQw==
X-Google-Smtp-Source: AGHT+IGZDAaBxmVSs+VutjNQ8PAEOo12mdPvNK02DG0MKyxoQpprR6EFATMLFx+h2fOHedHIJxntQQ==
X-Received: by 2002:a05:6870:330b:b0:315:ab22:8833 with SMTP id
 586e51a60fabf-3c0f8daf997mr6278191fac.38.1760124205605; 
 Fri, 10 Oct 2025 12:23:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f581ecsm1155832fac.25.2025.10.10.12.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 12:23:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20251001131839.1488633-1-ghidoliemanuele@gmail.com>
References: <20251001131839.1488633-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1 0/2] configs: verdin-am*: enable USB Gadget OS
 Descriptors
Message-Id: <176012420482.1180358.11552929433813063983.b4-ty@konsulko.com>
Date: Fri, 10 Oct 2025 13:23:24 -0600
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

On Wed, 01 Oct 2025 15:18:33 +0200, Emanuele Ghidoli wrote:

> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> USB OS Descriptors are used to install and configure the device without
> requiring any user interaction on OS which support them (e.g. Windows).
> Enable them in order to improve the user experience when fastboot is used.
> 
> Toradex Easy Installer takes advantage of USB OS Descriptors to load
> itself via USB recovery.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] configs: verdin-am62: enable USB Gadget OS Descriptors for fastboot
      commit: 5e1e08549bdb750b93028c0ab958964283d9ba62
[2/2] configs: verdin-am62p: enable USB Gadget OS Descriptors for fastboot
      commit: 6a22d03164c9e428753461ec560b144769ca1562
-- 
Tom


