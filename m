Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4ADC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F0B582D7C;
	Wed, 18 Jun 2025 16:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OvLhsMd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A8AB82DA1; Wed, 18 Jun 2025 16:59:40 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A7E782D4A
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6fad3400ea3so67720996d6.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750258776; x=1750863576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HOx+ID8uDyjEI/ITolfjb+qMUZE3di3pHKkY3ylUcqw=;
 b=OvLhsMd0nepFmKw2BG9dtZcPDcpuaQNXVb41xBmFaoOPIQtENu7nctRTzsl1GQSwU/
 yG4/0vBpoJZp7v2EjRXnHi7KpIKtyZrfsJU1bLcLpS0d3OiDVZsoGhS9RVl8UPvjZ/5Z
 w9ORrBVZGl2B4c1nq7pb7G+rKxlUV5AGqVbh0AnS6G3LGhozupFPsi2iBBvPe51YXQZo
 woF0M8rCwfqWpwByFzYODgYn3OdwigK0Pejbqy52vuZzbfGMBnW20zBUq0cqtzReuvOG
 NbKSXixp6ynP1kV9azIdEysW3XOKEKJIaT+b3EtzKz16CmfQd2nM6XZn4vKzEcxwCNTd
 PViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750258776; x=1750863576;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HOx+ID8uDyjEI/ITolfjb+qMUZE3di3pHKkY3ylUcqw=;
 b=GRYWPZ27bWxJORnkeA7hVNIpHTmH0VQakp3aOeIop4shbaOvMvezfvOR2L0bOv5RYt
 6nEroyAYwGZArV+AjtQbZmzh7dAZFnu2lvF2vEAD8KardMeIXyAFFtbwNnlv41R74kBV
 YNjkML+0L+k38QMY+C2TdeisFXJvrT2Z/myNVibWXSsn7ErD6ddHEV1Hv14ZFzEHqXsB
 9wxF7JxVU3zvenxlz8nuK7B/bc0ivqaik00x/5jGPdYYXRJGjmrU3V+yGXi4T1g9fVFZ
 kDcy7V29OgHE8Nt6JBq46U4N6+rwJ7J2M8sneXC34qAfQsjh6gzRUzvW8bQ5fpgOr9VI
 1u2g==
X-Gm-Message-State: AOJu0YzSPfWYh2bLZtyLtbHj60IcIMVP4gjC8zClln+rtxGG2gm/kK5o
 wZyDHQi4QtBpBfXg90q6O3Z6cxdQynji7j0S/5dJnIoYeduJ6hLlDlN7dXOxPK+LiqLJ6dZkKSm
 qC8ML
X-Gm-Gg: ASbGncu7b/M83bMYgy6ESZ+NHXG58tkbQW3V9MYKCPz+DSGCHJWlDgMSdwXAYEEkzbL
 r14JOJ/AARdG+VlS33Jaj2cIEKHXY05Z5MlLVpLVg5PUUM9BuEpI8CiovVDJl7bD00rh8iWBoFI
 CEz+BAvq2Ur164O+IjVSwblV0nPcHX/TD7j1EKiHbRkMMVXSVteb7q73k9cBNDc5WMxYObb4TH0
 fLMaHSl6JKCDI/KYqoin/HcOP+eZEVUsv3FIbW4YSnJOpp4kdONdF+4PATs8UtAWVwECBbK2dd8
 5O30q9akLJSYsNFelEKEk/U8+hyOkPoT7Uf1n9XWlHn87HJPg7NRPmIDLDbkMnRAs3wPzwQQV7R
 tXw1ML2L0sn16ZvmJD6Mx0Tqwvs3lcud2n9KgFZN4mz1toSI=
X-Google-Smtp-Source: AGHT+IHxqOnljZeyvERCygXma+jCCiujIR9KtM5YGWWlIxgmAXa/M5K/MpOhhIwcZeZ/JOmV3iLWNQ==
X-Received: by 2002:a05:6214:5d12:b0:6fa:c99a:cdba with SMTP id
 6a1803df08f44-6fb47733c5fmr274978376d6.14.1750258776516; 
 Wed, 18 Jun 2025 07:59:36 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb4d627a14sm44736416d6.68.2025.06.18.07.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:59:35 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/6] Add support for DT overlays handoff
Date: Wed, 18 Jun 2025 07:59:22 -0700
Message-Id: <20250618145930.2652304-1-raymond.mao@linaro.org>
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

Currently DT overlay is not yet enabled in TF-A, but with the test patches
I provided for TF-A and OP-TEE build, importing a DT overlay blob file from
QEMU to TF-A reserved memory is supported.

Follow below instructions to build and run for test:
$ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
Replace your local qemu_v8.xml with [1], which contains all necessary
changes in both TF-A and OP-TEE build.
$ repo sync
$ cd build
$ make toolchains
$ make ARM_FIRMWARE_HANDOFF=y all
Copy and rename your DT overlay blob as 'qemu_v8.dtb' into out/bin
$ make ARM_FIRMWARE_HANDOFF=y run-only

[1] https://github.com/raymo200915/optee_manifest/blob/dt_overlay_handoff/qemu_v8.xml

Raymond Mao (6):
  bloblist: add blob type for DT overlay
  bloblist: add helper functions
  bloblist: fix a potential negative size for memmove
  bloblist: expose 'expand_by' as an output argument
  bloblist: add API for applying blobs with specified tag
  fdtdec: apply DT overlays from bloblist

 common/bloblist.c      | 68 ++++++++++++++++++++++++++++++++++++------
 include/bloblist.h     | 33 ++++++++++++++++++--
 lib/fdtdec.c           | 56 ++++++++++++++++++++++++++++++++++
 test/common/bloblist.c | 17 +++++++----
 4 files changed, 157 insertions(+), 17 deletions(-)

-- 
2.25.1

