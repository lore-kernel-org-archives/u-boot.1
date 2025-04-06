Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A171C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA9682B4A;
	Sun,  6 Apr 2025 17:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GiwCEtk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA3ED82BAB; Sun,  6 Apr 2025 17:38:07 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D29D82AA3
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6021e3daeabso1763976eaf.3
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743953884; x=1744558684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQ2IpsOAmiSJ8mggW4nvBhRLOa68h5JyzLX9q5jD/Po=;
 b=GiwCEtk+Hhwri2kROUAc3Qt5RIphiQvkNs04trlBfazXM/7yXY9oyc9/HxKaajDGDi
 VtBuw9gLwWjYtYX2eTHp99EWoLhn2fRQ5sAkSbWjFrHOuFqNOveS/T6CZrYCBN4I14Zf
 9J6M1Su9hgcs2/BOcASDqsIvay1Kml5DcRpMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743953884; x=1744558684;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQ2IpsOAmiSJ8mggW4nvBhRLOa68h5JyzLX9q5jD/Po=;
 b=TdDxRrdVrAterykKWgczzLZRj50U92Afq/sMj9xQRiR75G2o/HNBHqc8GV0NAXrI62
 zdOuIL7FPIAGU06QrTGjqDc9Q5+FRz5VX30kvfdlXRP+Xp19C3dNDYUTT/89/Gg1nZkC
 g1PZPRBWbjFHBy4yBJ5P1wiMeF4o7I3AJygJe0eNFNT1v0oOneT7DKNLbiBNuc4YhXjZ
 6jm4dgMHJCYKSCeIhQzbcSsTTrFASOYHbqU3j54C3K2GvbDVWbwXThJyzx8KADrXgZfI
 FG9p7PuSruFONqv372kUtegPc65y7ZZYZflvrHEIM9sMuThZLQ4ecOkMrjN7FS6ELyQZ
 pTew==
X-Gm-Message-State: AOJu0YwpvstSSETI829kQHdwux+ALsCGdI+umMYE3E+aEcpWpveA8Fl3
 iY0QHpoiEPveiYNJvsfsddE9NNsk22E6FUZ0qh4zM3HY8y99BN/yUy4yqDVCVeGWnW+DoIiUwPu
 I
X-Gm-Gg: ASbGncsvpfTLzgBE1NWTD9CboQaBuHHebd36CPB9Xt3onPgqhjEW65Q1E9v2WHfCD2r
 lDAXJz7rcBSrQJ8LYBzhFgO0dS1dQvhop4yLi8CoKqQ2SdMmSUlLVXxU8TE3l34O4+Y3ABLNZt9
 ClYQpXU0bo5spJkf8AzT9R1nfIOhFVsdYPnyCQ10i9aTUolv1GjjCmkJWBeVeciJdDMjN4K5DaG
 yxHAzKwOFLKPF6FZ9isq5Rz9G6FnbWenLHxJsVoHN3fgRD1LdP/U+14x4PkyfaSouSbcYFDri5j
 0XOFKwKz8rEbkd4thRC9aTA9WvS9zD9OxIN38UwUdhraBW9TFvhWfN52V2I4m1DG0W3mVzTT4Ut
 rYVfTT+xibCBQUaU=
X-Google-Smtp-Source: AGHT+IH2frg5IUR2XNplp/QSbvqWhX3ZzDuAqVpNO+njZ6F9wgWD9ukp6HCbWtfTbMwsC1jtvwaRTg==
X-Received: by 2002:a05:6820:228c:b0:603:ff71:aef9 with SMTP id
 006d021491bc7-6041ff57d0amr2785645eaf.4.1743953884303; 
 Sun, 06 Apr 2025 08:38:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4cddd6sm1447384eaf.15.2025.04.06.08.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 08:38:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250319192958.276563-1-afd@ti.com>
References: <20250319192958.276563-1-afd@ti.com>
Subject: Re: [PATCH 1/3] arm: mach-k3: Remove undefined Kconfig symbols
 BOARD and SPL_BOARD
Message-Id: <174395388263.154794.8379316174474046535.b4-ty@konsulko.com>
Date: Sun, 06 Apr 2025 09:38:02 -0600
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

On Wed, 19 Mar 2025 14:29:56 -0500, Andrew Davis wrote:

> These are not defined nor used, they seem to be leftover or a typo,
> remove them.
> 
> 

Applied to u-boot/next, thanks!

[1/3] arm: mach-k3: Remove undefined Kconfig symbols BOARD and SPL_BOARD
      (no commit info)
[2/3] arm: mach-k3: Enable BINMAN Kconfig symbol for all ARCH_K3
      (no commit info)
[3/3] arm: mach-k3: Make K3_LOAD_SYSFW and SYS_K3_SPL_ATF default enabled
      (no commit info)
-- 
Tom


