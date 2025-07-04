Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98814C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05C0A8206E;
	Fri,  4 Jul 2025 15:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rsmypV+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C0AB8277D; Fri,  4 Jul 2025 15:42:33 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89FA5806D8
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4a589b7dd5fso17419431cf.0
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751636549; x=1752241349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NPZTNau0USfRvJ11xGqu+ICj2fgFj9ElWh0fc9TGcPk=;
 b=rsmypV+LipsyiYdEJpd/wKDyQu7De5RCpP5pIiKCqegl3263crRHzFwLJmEr5rHtHd
 4p92UaAK8bvaqJG9uagiPQnYy+op8KWK+t1+uMKgWG5tWd8HYUlOXDKfIqvWhC89x0R4
 lVPozWFGUs+kpo5DOw3/kQTCL6xB+Xz6Em5c255Zy3leMcP0DhOqQCVhgvUgIyOObrbi
 U7+cCK4hKvWOFM1SrEMZ7pZUtXPs2hgmNavF536tNMFCDR/+zwX/NKOPV9KL7vxjJUNa
 CEXaRoy8/pePKTjA1IL8GSf2yeTz4+pxd6wRkhJ0/4HQvg5tnC1imX4oTOFOoAK9SD8q
 u6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751636549; x=1752241349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NPZTNau0USfRvJ11xGqu+ICj2fgFj9ElWh0fc9TGcPk=;
 b=lodqX9Y2LPDThJYtmmDUqlcLwXJWNEdY8/KnX9vWS6en8Lm9XZR7KpOhG1Nv3d9bkD
 2VuuRisgV5COnVJtCsEIkMme5lU5Qds5N3jVRo5cz5EfTM/VviAZHIFvG3PQfMw0dLa5
 LcCzpTTQIiUCJmCXLqEurp8EFvvq5UzuIJ13AzkHro3iXBnvCLUcA/zEd59w2+/KepRa
 uc2ohO8QphKtiG4H3HLpJeVIl5vhVmUNg/1gNac7Ppo3MQTC6DbvD81oox3SrysaIj1D
 6UvYqXB7dvidvS2nv0J0l6hOmRSyaScjDcuIyVhCkvI5TDuIrXwD6zknkFpstN7qjbXZ
 DVuQ==
X-Gm-Message-State: AOJu0YwJJt2DNPFhVCDO/XSNvynFt77wq9zArWl8h4rUiBJ05IG1GpB8
 czcGjpUS27jvumn/tn3P74bTJMnkaT6T6gImQ6GmPgVXgaLmJBS6+YDC6pw+M6i/NaticCVrSe3
 GDOcq
X-Gm-Gg: ASbGncsTsl3C2nXZjbos5TOkouwGPOPIYSVntZYPBGoqmw3ERI/b8BoxuVLSsaTBi9n
 lYL8sAHmJbISjb2VSRH+LWculQ2TuHxMDr6A9FCNRgkAfG5DYbYtmmyOyo49h/oCDTlLbuyuan2
 GjUON7YbOMIoqOmYcmXZJWKvnak9SbACLCAPxVYKEuwCz63CrJy3bZbq/S1kBbzy3/KVFhuUiae
 BvFcUebNN4YooRZY6Cb+H6CaE2wskr7O6QKsjyE6gymoJ1z5+wT6cnwsEFu4z5e9gmcMEolkIqO
 9B0ASP3rt3AXEmdzv3STbDDweuSnJ3LeKOsBlC2XhYwMpdxwvyLsZ1cJlKNClyyfwWHUvAnA/rf
 l1IKBYMJOTkEtuZG2YF5IYx0VtCDAKK8LKcnEa7lYcAAXh+8=
X-Google-Smtp-Source: AGHT+IEiGyk2k3P8N4lD5WueP+zB9MFiRNlz+HjkYfUNFT639V5bQFy8CKD3fK72F7RCYJkdVr8wwQ==
X-Received: by 2002:ac8:59c5:0:b0:478:f4bd:8b8e with SMTP id
 d75a77b69052e-4a9965191b5mr42336711cf.39.1751636549014; 
 Fri, 04 Jul 2025 06:42:29 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a79606sm14071051cf.37.2025.07.04.06.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 06:42:28 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 0/6] Add support for DT overlays handoff
Date: Fri,  4 Jul 2025 06:41:59 -0700
Message-Id: <20250704134208.2895595-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The series include refactoring on bloblist and fdtdec to support handoff
of multiple DT overlays and applying them into the DT base during setup.
All changes are aligned to the spec update for supporting DT overlay
handoff[1].

Notes for testing:

Currently DT overlay is not yet enabled in TF-A, but with the test patches
I provided for TF-A and OP-TEE build, importing a DT overlay blob file from
QEMU to TF-A reserved memory is supported.
Follow below instructions to build and run for test:
$ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
Replace your local qemu_v8.xml with [2], which contains all necessary
changes in both TF-A and OP-TEE build.
$ repo sync
$ cd build
$ make toolchains
$ make ARM_FIRMWARE_HANDOFF=y all
Copy and rename your DT overlay blob as 'qemu_v8.dtb' into out/bin
$ make ARM_FIRMWARE_HANDOFF=y run-only

[1] Add Transfer Entry for Devicetree Overlay
https://github.com/FirmwareHandoff/firmware_handoff/pull/74

[2] https://github.com/raymo200915/optee_manifest/blob/dt_overlay_handoff/qemu_v8.xml

Raymond Mao (6):
  bloblist: add blob type for DT overlay
  bloblist: add helper functions
  bloblist: fix a potential negative size for memmove
  bloblist: expose 'expand_by' as an output argument
  bloblist: add API for applying blobs with specified tag
  fdtdec: apply DT overlays from bloblist

 common/bloblist.c      | 83 +++++++++++++++++++++++++++++++++++++-----
 include/bloblist.h     | 44 +++++++++++++++++++++-
 lib/fdtdec.c           | 81 +++++++++++++++++++++++++++++++++++++++++
 test/common/bloblist.c | 17 ++++++---
 4 files changed, 208 insertions(+), 17 deletions(-)

-- 
2.25.1

