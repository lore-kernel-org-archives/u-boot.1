Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0315DC83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 14:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 559AD8366F;
	Fri, 18 Jul 2025 16:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ci9ykNEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B212F83675; Fri, 18 Jul 2025 16:16:33 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511E0835B0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 16:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4ab6646476aso13992281cf.3
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752848190; x=1753452990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wP5jVOWtDc028IZglu9NEelTuaE/eI/ppGq5cuTXn1A=;
 b=Ci9ykNELru8bIC31HpogV/ivcU5esMaU6P3LY3xvN8rKvQZEFB3xFGi7q7EANcMqvr
 m/uJTQ1aALg9D8rsGcxYamH+tIBu6DYgxRK1hfygeYV/IPIXWjbfza3jeLXfA/RlPc8I
 Ie0y5kr9KSrV4uOkIozLO4mXCgyXDrycxVPNGKUEElXA7XQMeBqgPJRk7YU2NqSRedwD
 1so96Rrkbe/E48k8d47RXBvGq1JOhr3TvZDbX+R72Xq8ObundkqapzXt+zSqkpSUK0MF
 H4AGwt2a6b3Wwv6XW1QDF0Lrr6e66RCKHmzOq8ZijkxSgHvOz5/Dtkc24rrdI/7nEL4H
 nhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752848190; x=1753452990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wP5jVOWtDc028IZglu9NEelTuaE/eI/ppGq5cuTXn1A=;
 b=AHwzNMNhdF4gHzqF8wZAcfDvTs9laNDS0Q4yHkemxBKz3BBaeXf2ZXvM6lVVCuVR7H
 aASYVZO8uMOpF0Tpg0t6ovWpf6N9LHqx6YvT91oVqP+A3COh/Dltqb1xYinyGXP+GSM0
 PursjgIiAyvXKPTUXDPFhOArqZTVZJylYRyrB2eOm90seor9JwW7SEC+y4UqSnYJ2p6q
 alCbdy2ALvxVOAg+9JzNOQCsg+1+3l8t3IKbVu5RWcfFFmgNHCOOMhdx9MHxfZM9r5ou
 ZdxbflZTComwBkRlEHfQcpGjkSfHzw3wf17V/zJoPV5tWos6AYykN3sTinNQzr6xTRv1
 bhMw==
X-Gm-Message-State: AOJu0YxlF4niD/ZhdxQnVPY5PFK+E5ucmfr8cO+8bxyIvuiXLeyV+SMF
 GpWnKkS56AZ0lNsxZinWaN8RkD9Nn36snCPTZIh/UwY56s+fB9uhasRPB4HWAxRfhT0nnT3Wlp7
 FgOc7
X-Gm-Gg: ASbGncu5pEI2eGGimobs2bdZ3zKkRvy6nPXUXj3+qCrjWDiamBqygOxJ7DEck5e2PJi
 oU8Yd4l87c0paM55YmR0i4bCKfwYzEKdZi9ZVebl/Kbz3nhSeWZqjsvOjbFKDBHitXVVVs0OtNM
 BB2mDwNMwxwoDn4no9eth4Am+figralSttYQ4jsM2nfxWHVTRrzBoNjG+B7H3QJVpbSczb4U3gy
 3PtARC93vTXbC0NsmZVKs1wRaXbIbt1obtYacNwbuZTUhqCQq8lgf29ixBCZ1YoaW45B1QuViy3
 iYWmmXOU/VDLN3z217YfyECo8xcziF273MktMeA35tCLC0hrozi7hYKVPiXuBzOEPC4pxFCiOVC
 RAvBvcCVbv1sq3qQfLIBFy4g8wB+IcRfF0Jig1K2kZJfDNKozFk9Zand5vTOrOkt3+KFaP57WcO
 P55rSA4KM=
X-Google-Smtp-Source: AGHT+IH5Z4Qo1LXnYur/hsk82dKwbXWwO+Gn3GyFmOuJKURthiiZgEoNp20uvHyV6RH/kUfro2qwTQ==
X-Received: by 2002:a05:622a:206:b0:4ab:65c3:37d0 with SMTP id
 d75a77b69052e-4aba3d93e26mr105264521cf.31.1752848189147; 
 Fri, 18 Jul 2025 07:16:29 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb499e91csm7558341cf.19.2025.07.18.07.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 07:16:28 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/6] Add support for DT overlays handoff
Date: Fri, 18 Jul 2025 07:16:13 -0700
Message-Id: <20250718141621.3147633-1-raymond.mao@linaro.org>
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
  bloblist: add API for applying blobs with specified tag
  fdtdec: apply DT overlays from bloblist
  configs: Select OF_LIBFDT_OVERLAY to hand over DTO via bloblist

 common/bloblist.c                       | 67 ++++++++++++++++++++-
 configs/qemu_arm64_defconfig            |  1 +
 configs/vexpress_fvp_bloblist_defconfig |  1 +
 include/bloblist.h                      | 34 ++++++++++-
 lib/fdtdec.c                            | 80 +++++++++++++++++++++++++
 5 files changed, 181 insertions(+), 2 deletions(-)

-- 
2.25.1

