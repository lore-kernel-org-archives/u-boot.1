Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8722FEE020B
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 15:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C090383F39;
	Tue, 30 Dec 2025 16:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hIlmsR9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1457D83F53; Tue, 30 Dec 2025 16:10:46 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2E0083DA9
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 16:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45085a4ab72so5497439b6e.1
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 07:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767107442; x=1767712242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5m3hMRPyyC5s9tSlHV1TZVF2fiYHVwM6fexScUUnU/8=;
 b=hIlmsR9D2uU0KQX+NZJP5Id05PCWOYv+JPayMKIepnmG/gX7vSULaog7cL7YSvLRM1
 uk/vbqr3PkcDHwMsrk9tgPhidJ6r1kmegbA7Mi9m1lGgCVgiwvrGnKYt46KU2t21OpWa
 fVaQLN7RcEg1BL6nTo8ltf3UYB1PCgxHHpb0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767107442; x=1767712242;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5m3hMRPyyC5s9tSlHV1TZVF2fiYHVwM6fexScUUnU/8=;
 b=lzxQnqasbpwDm2k4tL5Tptv3K3DMldPsgSRYU478TVu37Wvyf+jUUQMV4RDQDJXWpS
 DQrtsEgguc4GSY7tu4f5gafL2Xt39aV0Rk+bC3ARMUtiphVUJ585ZNPaii3SA2UhYZVv
 uQ37Gr5lE7M9Mz4IiZ7O7NZrmsCPFIM9vv7+SS3TJza7k9D58H2MBvnsyNVtwoCsSccC
 PJSS5rNy/Nfbthom1YxgsnXsfc/Vxvd2NzzWr1F3IJEJT5wolWOOitmwCH3dpStHPVGA
 G9tvbVmAP/YKZZGEl53hYrMQwAp5amF+mQ6hAj7/3XgBc27TuhbO2uwOVGNcwm/8Z5A2
 JGxw==
X-Gm-Message-State: AOJu0YyTMPKABpCX/vPiX4uH3xsU1DJy+i74e6/O2J5axIvbEWhhEk7T
 Un3Q5kcCXJVPrVCRyKr+EtYYyFC3C6ZUeABv6xX1sHPkNMqRsxJIsCXU7qr8lxkmfBhozD4dfz9
 nUvoSPk8=
X-Gm-Gg: AY/fxX5wZtGgoZ1S7eP9SRa/yG3ho2i3hgvwdnP/sbardMN0kBFRXSqMjGBQqk9sVGY
 tsZeU+R/haHAwfzUn7ypvkSIlvBI/P9WCiAptUtGimNeQEsaMk5sVVgUpUjsVXCnLJMwP4bHQQN
 W839eJC/D33YRwaqtQ0bKvTnETFwysBw69N/z8Bvdd0AK3WJ1zCKP0jgFuTy3QVFNSTqJaVyeoJ
 62fyI3aulB8GE5gvPY9R6M+31KQilVIEpKhKX0jLuwAyiOu/UNe5M/w8nq232oK+d9Hy6LvdeZM
 rsMBKntxkzHqtCIz0dFyW3pD+p8o9st2EsSOtMHq7Nh5u/7/1zlhxfWgrBtpLvIy1rRAX766Lq9
 CwiyqBV9LAhzY1D3pqueRQIjQqb0ifwtwlkrbotzOtu/OSpli5oKk+TriXQX4Mao4YAfuKCOIZ/
 yGw/cj4zh2gW3n43hB1GV+8a+Tvehju5aae7SUvSWVkIF9g6v4dTSlKulSulHll77u4+94cinMD
 Tw/ziw77u8Wdwmo/y6W37RBNENOSgdhDctzV//oOlAQWHDz
X-Google-Smtp-Source: AGHT+IFDNsvWM6yqSKMHg6plno6+t2hxwnee7Ajlrec6KjWMHMe8L47OYe0P89qVlF0Nnr8jQiArAg==
X-Received: by 2002:a05:6808:c114:b0:450:760b:cc98 with SMTP id
 5614622812f47-457b1e54d3emr14176568b6e.14.1767107442319; 
 Tue, 30 Dec 2025 07:10:42 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673bdabsm22447361a34.10.2025.12.30.07.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 07:10:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20251229205431.89734-1-marek.vasut+renesas@mailbox.org>
References: <20251229205431.89734-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <176710744162.4060105.12613689596943788991.b4-ty@konsulko.com>
Date: Tue, 30 Dec 2025 09:10:41 -0600
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

On Mon, 29 Dec 2025 21:53:59 +0100, Marek Vasut wrote:

> Fix R-Car D3 ability to boot Linux kernel. This is for 2026.01 .
> 
> The following changes since commit 56cac250b0839ddbad1311d3ca4231f532b5aadf:
> 
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-12-23 11:17:37 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


