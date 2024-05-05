Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4A6C4345F
	for <u-boot@archiver.kernel.org>; Sun,  5 May 2024 19:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 679D2885E3;
	Sun,  5 May 2024 21:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hj+cebKM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E4F3885F7; Sun,  5 May 2024 21:11:48 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99ACB885D8
 for <u-boot@lists.denx.de>; Sun,  5 May 2024 21:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ec400f9afdso3612415ad.0
 for <u-boot@lists.denx.de>; Sun, 05 May 2024 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714936304; x=1715541104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FqtJUuzS/MSlpoqA2jv/EJ8vm7DAT0Ni1FWWLmFGQvY=;
 b=Hj+cebKM0vq8YDKUODhrzCml5nodpn5QqdvyhMq6WGnrIbCu0DM8Hk2m4igdzM+CJD
 De/5MurBNxxp+fRf+kYrRfBTiFACflns6FfpGcUCKDaouvIq5Qbt8T8Qh6X46BSnIb4H
 cejQ6f/q5uaKN3oCi7p8eMINrZ46hSXjUKCfAK9JZ/QBsZw9AeFNt2niQC0DkXln+JLx
 Am04cOd1No5kOxdrzJYaLqL4XQcIO/9nuS7jz3rYRiXw2/s0FqYeu3qZWOJbKY0Zwx24
 7Fthpw9PcY68Fu5DcelDphqWS+uPkXzhOWAV7VrxS9cvx/vHZyr9H9ltgP1l2QPLoheX
 E+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714936304; x=1715541104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FqtJUuzS/MSlpoqA2jv/EJ8vm7DAT0Ni1FWWLmFGQvY=;
 b=NYRTUNgy+U8Nx30qUPXDeIBMb5yeGcvulqAosHLuw6Jxll+B6a18Pji5Lzu/ELsP9/
 qXAIngYly9Hlj8cmvimjUPjfcuzW+Lz/aQ9EsGP9n/tQYguGBElM4BxFcv8JwBz674QM
 deSoZX9RY0GujVBhJYtTu/WhVL/dHfEygAwCiHBtdMZUYmKNxwkgGd+Iqzpu+/RngTr0
 R/uYJ2bXy+W8dilb1AikvrtCzijnG7/zqtCUkBlO06MFepg37iQhPOGd9iipI1TXigAw
 nq1SXi9EPLMUqaJMx/E7XIs7jZLhwS8NO6qnxfDY8QHmrTixdHRnhPlq+ro1SRevvEBz
 x9fg==
X-Gm-Message-State: AOJu0YwpoAprW9Cw8Hw2wN2VNjKE+INGImfinxN26qGC2vZ01rdE9uju
 X8vAgovMWOtk0UMZQGbo2rmgp6bCmqcFe8PPFGE1WkaHEKXW3Txc
X-Google-Smtp-Source: AGHT+IEz208nxOKRqzhyb4xUNYTcvGcxafAW+Kz/opyGVKaYKo1Hq/C6GlBjAxRyhhbWtoipIlWrjg==
X-Received: by 2002:a05:6a20:96d2:b0:1af:667b:44ff with SMTP id
 hq18-20020a056a2096d200b001af667b44ffmr9123780pzc.0.1714936303781; 
 Sun, 05 May 2024 12:11:43 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:901f:c82:3f15:83a9])
 by smtp.gmail.com with ESMTPSA id
 x22-20020a62fb16000000b006e567c81d14sm6323751pfm.43.2024.05.05.12.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 12:11:43 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240505
Date: Sun,  5 May 2024 16:11:39 -0300
Message-Id: <20240505191139.3024264-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.
The following changes since commit 2f1e76bcfee75b9f99ade63002c05ffaaec86afb:

  Merge branch '2024-05-02-assorted-updates' (2024-05-03 16:18:51 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240505

for you to fetch changes up to cecb5fbb42c8b3de3d5a7df40bc01d1fdf4731d3:

  crypto/fsl: Differentiate between CAAM and DCP in Kconfig entry (2024-05-05 11:21:39 -0300)

u-boot-imx-master-20240505
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/20614

- Add SPL variant of DM_RNG so that the DM_RNG can be disabled in SPL
if necessary. This may be necessary due to e.g. size constraints of
the SPL.
- dd SPL variant of SPL_FSL_CAAM_RNG so that the SPL_FSL_CAAM_RNG can
be disabled in SPL if necessary. This may be necessary due to e.g.
size constraints of the SPL.
- Differentiate between CAAM and DCP in Kconfig entry.
----------------------------------------------------------------
Marek Vasut (3):
      rng: Introduce SPL_DM_RNG
      crypto/fsl: Introduce SPL_FSL_CAAM_RNG
      crypto/fsl: Differentiate between CAAM and DCP in Kconfig entry

 boot/pxe_utils.c            |  4 +---
 boot/vbe_request.c          |  2 +-
 drivers/Makefile            |  2 +-
 drivers/crypto/fsl/Kconfig  | 11 +++++++++--
 drivers/crypto/fsl/Makefile |  2 +-
 drivers/crypto/fsl/jr.c     |  4 ++--
 drivers/rng/Kconfig         |  7 +++++++
 drivers/rng/Makefile        |  2 +-
 lib/uuid.c                  |  2 +-
 net/net_rand.h              |  2 +-
 test/dm/Makefile            |  2 +-
 11 files changed, 26 insertions(+), 14 deletions(-)
