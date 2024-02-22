Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F64AC54788
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 15:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C17987D26;
	Thu, 22 Feb 2024 16:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Jys1KZT2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D1788097; Thu, 22 Feb 2024 16:21:21 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE84387C56
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 16:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3bWbXZQYKBswts95sAy66y3w.u64C-t66B30ABA.vw5F.vw@flex--barnas.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-608575317f8so58646017b3.3
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708615277; x=1709220077; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TJUQEJ1K+3DB9oHj9V/11rwSgmrj8uAoNASRP+CG6mU=;
 b=Jys1KZT2nu9zO9K4hGp7uT4wW3rM7c2P0OZrVRQM7/9wJqeotcMRDN2+CdgR7fHg7D
 g1Ql9HlpoJ93NzRhdjbsUys+TlxJa/S3yrmrbq/+dFy+m9hcwmM2KOlNMXRDTJO5XOQ1
 JxU+ixMZf1ldj2swYXI8GDhbJ0LyPnM8N/vQScCjP+BpCJzgD4d41P+XrTSdO6axuDJl
 9yxcbPkVWMcmeDRLKZ0S5ImbbeCr09hw8HJeAJWUuxAmf07hiwDacvTFGEtM/mO9NdCc
 Qq84M0TDZQ6EznV1x7viIE7sA/belY2S20u9TSv/DwLzD8w6DYaXy/9qrrKPqaVQKAeH
 b6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708615277; x=1709220077;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJUQEJ1K+3DB9oHj9V/11rwSgmrj8uAoNASRP+CG6mU=;
 b=nRSGCrClVAA73wSkekcJCCF++uW56bNLj1Eq2nPEIx7pacyJt3JVCO5m5Po2lqfyFV
 44IpkwBrmW36KR2Zz4DlLI6H3CbJLrVkzHdfQmHs5dsBTbe3MWCemKn15ufL+BpaMLll
 YyiFttbktfgi9pjuAU8887sHxQ5MSoAhyHxUccJOWEotKnuzxPeqZ7lKTmluJ8J8TgV5
 g8UVLMAJ9MZFl7WrTtoiz/hY25geJISdKIzcPhW5EOP0XNFsPcYs/8FMEdsxzCsD+tdN
 lZeAOBWhzWBw3/qM4+QX99qg66fdytw52LJ/EKEIOi8bBazSkCgvMFaOSib07DC8pkSj
 4nig==
X-Gm-Message-State: AOJu0YzJp9RmmK1KGPvcRYLuniOn0V+rGGfng3U2Yqds/HHsldLxMJVL
 dbm7aWTWvyDj/DuwjkFQEFqVAaRYUDVVjJD2u53JHZnDHGuxwEI7vGsHz/NLxzlLRs4U0gcs8x2
 SDg2YVzmtTavLacCTytJZn+i9+sEfFcBbvLOEd5/W7BpDGBkWTnNW5QBaS5IrfNDajUVSNrobZl
 amOjv7dMc0+SdhGxSK1Fx/sTHzesXmsg==
X-Google-Smtp-Source: AGHT+IFxCzNLeKoPR5/mtLlBuVT6Y5VX3uYwTO495/ccN2x9TN9OuNCFU2QDaJNZdJ4RV6G7FRIYIPD8TNg=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:a81:4c41:0:b0:5e6:1e40:e2e3 with SMTP id
 z62-20020a814c41000000b005e61e40e2e3mr3694705ywa.5.1708615277339; Thu, 22 Feb
 2024 07:21:17 -0800 (PST)
Date: Thu, 22 Feb 2024 15:20:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222152102.1677445-1-barnas@google.com>
Subject: [PATCH 0/2] arm: socfpga: arria10: allow to reprogram FPGA with warm
 reboot
From: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>
To: u-boot@lists.denx.de
Cc: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>,
 Dinh Nguyen <dinguyen@kernel.org>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <pan@semihalf.com>,
 Simon Glass <sjg@chromium.org>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 22 Feb 2024 16:23:55 +0100
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


By default, the board requires power cycle (cold boot) to program the
FPGA with bitstream. This change adds Kconfig that allows to enable
reprogramming the FPGA with every boot. This makes the update process
of the bitstream on the filesystem to be applied with simple system
reboot.


Micha=C5=82 Barna=C5=9B (2):
  arm: socfpga: arria10: add option to reprogram the FPGA every reboot
  chameleonv3: set in defconfig for FPGA to reprogram every reboot

 arch/arm/mach-socfpga/Kconfig         | 8 ++++++++
 arch/arm/mach-socfpga/spl_a10.c       | 8 ++++++++
 configs/socfpga_chameleonv3_defconfig | 1 +
 3 files changed, 17 insertions(+)

--=20
2.44.0.rc1.240.g4c46232300-goog

