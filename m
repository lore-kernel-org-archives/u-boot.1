Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6509BC61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6EB482A65;
	Fri,  6 Jun 2025 18:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B5j/TCtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D81EC82998; Fri,  6 Jun 2025 18:46:59 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB8ED807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 18:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-400fa6eafa9so1732750b6e.1
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749228416; x=1749833216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2mo/Hg0i5hqoiZoeqczgC651RTtWNvthTt+71/VfUY=;
 b=B5j/TCtE8680AWQrowOD1rH4aLsQBT7TDsWbiNURq0v1KXE5VgmaOUaVVVH4isY5b2
 zVQp2zpT2eLrxhQqRNUATfFTWRIvwKr/HF9LNilar8Skk0pzk/Rm/RVyVUg/G0IjVnwC
 JRQRovoxPtZYniR7tMLgMchkhB+veGybav4MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228416; x=1749833216;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j2mo/Hg0i5hqoiZoeqczgC651RTtWNvthTt+71/VfUY=;
 b=G0slqiA2+d+1gJPatocXPnZXouNSfenQ7xwsc95r9ZagvjZdMkLQSA/jiCRhgopxpa
 utbujjTdNyRNnglYtelzS3cKXFYwYvF4Ge8nYJ+leU4y1V52C5Wf3UZtx+kKnTSiJ26A
 ZkGmz4rEkFkkGpD9GYzpHZdXJekFMtvZZuqQJYcmzQXTsoh/TgBy8XtLYdPz4avMqAB/
 NYUUeyRdGjq+DfCnyYvCVdOYF483CwJbc0+h3JtxxgCnDZZDCIZUvL0lhUTS0iGZAzY4
 7lWo0A7sVSlKrFza9G4KqzpoQgfYqMN1deIBMZ28TUgBPJ7vbFU+j48FoBp34C3lpXEF
 0soA==
X-Gm-Message-State: AOJu0YxtTjRYGalFCiMuU+zhakOgJTRB6g5wj53qG/LQ++4x2+J+ONfH
 LsXT5vuYHi73PPDxLRnh31eE/4Pmn991GAYAQR4KkCftvcROYxzB6+cA/r2HXtvKKkE=
X-Gm-Gg: ASbGncswC/ohDH/ixN1chL0QskPVrzUvVfaXwhN2IA4GqveTs00VZXN/NYCv1iZPcGz
 wafYdO4sVPJ3WVmr6jBDgC/ycXsPqHJyHlBvF8ib90t6p6kNasMWlHvAlTAle01TFqtTnKA5TnP
 FYyuoyH41OKCSZC2QMVSqjhwLohSO0R5k0bRFU8Jr1Jf1MsnYPq2d6aWUB61F4XZf0ACkX30PXW
 PJWICEHiPKT8gPvd/uBQ73tqkPYErFqedWbFHd7d0OuZVIEzyCe1re3eU+rnD4aAeJ2X2BKC2Dj
 FjpsBvTYABGNynNYGjPPmDp41Gz+28fTjgsTpj7b8wiBrNzoz83F56uIDMiO7/9ueqlY1JuywLi
 VeGOc59l+HZFKiv7ZGFWo0w==
X-Google-Smtp-Source: AGHT+IGZuoo0bRsAMVck7LJ0FYOEzoezpBcvN9sjbd9ghMItTb+j/HIwW2xzVzT/tRhCdljaYFUFjg==
X-Received: by 2002:a05:6808:6f8d:b0:407:59ac:d73f with SMTP id
 5614622812f47-409051f2c1fmr2891860b6e.21.1749228416551; 
 Fri, 06 Jun 2025 09:46:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-409069418a9sm377808b6e.11.2025.06.06.09.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 09:46:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
In-Reply-To: <cover.1747991898.git.weijie.gao@mediatek.com>
References: <cover.1747991898.git.weijie.gao@mediatek.com>
Subject: Re: [PATCH 0/2] Add baudrate accuracy compensation for MediaTek
 UART driver
Message-Id: <174922841536.3195369.7096057379729054550.b4-ty@konsulko.com>
Date: Fri, 06 Jun 2025 10:46:55 -0600
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

On Fri, 23 May 2025 17:25:39 +0800, Weijie Gao wrote:

> This patch series adds baudrate accuracy compensation for MediaTek UART
> driver in high-speed mode 3.
> 
> Weijie Gao (2):
>   serial: mediatek: fix register names and offsets
>   serial: mediatek: enable baudrate accuracy compensation
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] serial: mediatek: fix register names and offsets
      commit: 6e15d3f91aa698798578d39a6d9e292fcc5c577f
[2/2] serial: mediatek: enable baudrate accuracy compensation
      commit: 6952209ef220138189dd261d06441e1b2d50e994
-- 
Tom


