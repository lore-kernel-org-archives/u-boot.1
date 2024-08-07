Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F90C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 12:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59EFF889DC;
	Wed,  7 Aug 2024 14:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DJZixRnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C933D88B1F; Wed,  7 Aug 2024 14:10:48 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4B26866EB
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 14:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5a1f9bc80e3so794384a12.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723032646; x=1723637446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nNezL4QE/nmbwAtn2K1rAjmw8aFPBEZjLi6mtx/lVi4=;
 b=DJZixRnItDAM23yCd4NioPDzNWZjFVBJpWnFfcfiHVBiEqbWw7J1bCzdGGRnjRmXUy
 HXEYO1+R8ffCgz8EKR5t+sSvNKjOpMzB1Vp7X0SwgolG9/a6K8U5ln8gTq23tNgvAEGb
 DcShaO4dFYf8Iys7wP3cEIJiJYJheEIw94haLE3osVj+j5pYl0ZhB/QAYFPp/KPFXQXw
 w10djf3DHZUIvu5TcFfh7PkJKzfGVzWnETuQt9BO3Aa63OsJOjSzkWhio8jCsmpAp24W
 GAUnQTrjuh4jKGs/4mllFRL/lfkBxKhyUHoDNIzj263+597X4JORnZUOfc/pdrt0p92F
 qTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723032646; x=1723637446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nNezL4QE/nmbwAtn2K1rAjmw8aFPBEZjLi6mtx/lVi4=;
 b=BqY2o8jAe05NtNd0be6Il9LdqQI6yii6H/u46KM3NMIxaRr7D5cSYpHApQFFjYXALO
 uFRtH7xp037zmp6ajSP4rbpw037F5ld8rTNzHf4lVZMtJmjI3O3EgmGrmnWzcU1qwl8H
 9orstCATJdyCoEklXJCu/bbPqaUk1jcxdBD1+Zeh5tiOGjS4JeIEqMwZDruTqflXBjsQ
 OfmifpdxZrRIjiCHvVyDvO9jfisOvDXalte7jswz6q+Kwb10/n2PJ4UD9rpksoYAY+jS
 u0BLtLnFKCHXs92YyNYpBD4bGdxXK/r+hCx+NOP5n0Y09g/ZQMLSU50tBn9npifrnzHl
 +5jw==
X-Gm-Message-State: AOJu0YzSk+qB2Kpa5UKh3g0nYZSzEI70578ii68+drq/HXnIVi8D6or3
 H22ybrIyZrYF6Zvp97Ut0S3VBsK9Owahugj+uLX3xcfs4LWdwWFX
X-Google-Smtp-Source: AGHT+IFhJNoaIjYSwa/FmfysUNFev1MN9jEI/bt8H0fdjnp7XaXb7/q/WUKvKmny4eB/zayqeFcWCQ==
X-Received: by 2002:aa7:c348:0:b0:5a0:f9f7:6565 with SMTP id
 4fb4d7f45d1cf-5b7f40a665cmr15676348a12.21.1723032645992; 
 Wed, 07 Aug 2024 05:10:45 -0700 (PDT)
Received: from xeon.. ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83a152e4dsm7026597a12.48.2024.08.07.05.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 05:10:45 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/1] disk: add TegraPT support
Date: Wed,  7 Aug 2024 15:10:23 +0300
Message-ID: <20240807121024.11318-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Production Tegra20/30/114/124/132 devices use Nvidia's own
partition table, which makes them a bit complicated to deal
with. Luckily, it is compatible with the existing EFI
partition already available in U-Boot, apart from the fact
that it cannot pass Protective MBR check.

In order to address this without unwanted code additions,
I have come up with this solution.

---
Changes from v1
- fix typo in code comment
---

Svyatoslav Ryhel (1):
  disk: add TegraPT support

 disk/Kconfig    |  8 ++++++++
 disk/part_efi.c | 13 +++++++++++++
 2 files changed, 21 insertions(+)

-- 
2.43.0

