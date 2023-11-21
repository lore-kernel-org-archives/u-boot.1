Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8818C61D97
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 23:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A979B875AF;
	Wed, 22 Nov 2023 00:58:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="bBZXTmth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11134875E9; Wed, 22 Nov 2023 00:58:30 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 289C0842D0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 00:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-332c46d5988so2031505f8f.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700611107; x=1701215907;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sixUjlZsNnw3fDlZeCsfmBl645WyP6eI+BW9D/r+0KY=;
 b=bBZXTmthwNXz9vIoKIKP7VTcqwbx0LG8z2N3t4rzRLYH5XAmMocdobBP1bPhE1BPHN
 eRnvQWMSvuJ8zSLQfsIHktymtLUkeWVh7cD+7Jc0zhTMqoev6it7SkeT99BiZ7CDz8Pp
 LaBKFdBbuexU574sKsnCvShTIUFjVV9RVC/JHw8khtAoJhjN7Dr2/+xR74CBtADEgqSb
 95ChGQ9vCHC7BNMJaGWYL3VvB8e/zbJyVNf1t6+rq5tCDkgFnj672/oXiT13x9DGpBP1
 XBDHOV3hbTiZb37LHYxRictJe6wTtt6w8d0S88ViGTVH8T1Sdh5Pjs0K2dptxPtxMldw
 Vv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700611107; x=1701215907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sixUjlZsNnw3fDlZeCsfmBl645WyP6eI+BW9D/r+0KY=;
 b=dwTWDen805YVqUVjdZmyaqmbI5gD3dIJvIG8mIL3vFkWu608OKYj6r9aDOzwRCLwRS
 2HrtLuFGBYOHuUihevTeVLqky+/jJbLQQ68RfngZbanZB9sWaH1bxDHFVt+mpv9G5OqG
 2Ap8HittenRnftNInDxCXjKkp3HT4F8H1N26mGUxoMLFu18zM4KLyFSwa3m3/7tsUi6R
 4jI4EWcAyM+sikKuFUszkmGSmVf6QoRaQfzPPCs1Tn3LyRr50QlsVT2z3UDGi78xHcrk
 zGaDtikelr6psW3NZqpDsMFyQlhf4v5mUoeOD5LA9SPisxqpvDFpkluOJw5TRVGkmV4n
 qMzQ==
X-Gm-Message-State: AOJu0YyaOfiBrFCDcE90e7hrk5iRzybXjApZzoL/3IgF289TVnii+T6E
 xf3E9cmBBcPGL5doaKanrdXz+z+JELRcMwr8hbF17Q==
X-Google-Smtp-Source: AGHT+IGNfuMX92yGOX/VM3xXUhQdqPvkBHBLXKmGrDIqn9q3eP4yE9Ua+o977RSMSI1YZHRmKvcL8A==
X-Received: by 2002:a5d:5986:0:b0:32d:8e54:29fa with SMTP id
 n6-20020a5d5986000000b0032d8e5429famr274914wri.44.1700611107270; 
 Tue, 21 Nov 2023 15:58:27 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 d1-20020a5d5381000000b0032f7f4d008dsm15625566wrv.20.2023.11.21.15.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 15:58:26 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Akash Gajjar <akash@openedev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v1 0/3] efi_vars: SPI Flash store
Date: Tue, 21 Nov 2023 23:57:10 +0000
Message-Id: <20231121235713.1530289-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

With this patch series we implement SPI Flash storage for EFI
variables.


Shantur Rathore (3):
  efi: filestore: don't compile when config disabled
  efi_vars: Implement SPI Flash store
  defconfig: rockpro64: Enable SF EFI var store

 configs/rockpro64-rk3399_defconfig |  2 +
 include/efi_variable.h             | 46 ++++++++++++---
 lib/efi_loader/Kconfig             | 18 ++++++
 lib/efi_loader/Makefile            |  1 +
 lib/efi_loader/efi_var_file.c      | 13 +++--
 lib/efi_loader/efi_var_sf.c        | 91 ++++++++++++++++++++++++++++++
 lib/efi_loader/efi_variable.c      | 14 ++++-
 7 files changed, 169 insertions(+), 16 deletions(-)
 create mode 100644 lib/efi_loader/efi_var_sf.c

-- 
2.40.1

