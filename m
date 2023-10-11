Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66ECDCD6E54
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDC2786C8B;
	Wed, 11 Oct 2023 12:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yL7Dz0lF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEFD786CF2; Wed, 11 Oct 2023 12:07:24 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600D786C66
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:07:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7a29359c80bso23725339f.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697018841; x=1697623641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a9pA3N2mLaavnmoLIQXFeIPIcdX4kqVShAUOqB7XaiE=;
 b=yL7Dz0lFiwNl8gf8+SWaXP7+X6QL06Zbm5CY2cvoQftGp/GjuB+OG5ORo9Qa/C86Si
 8hPeHsX78wrj14Bwlm0v6DHHzAfeURDHZZUNopnm+OBCep9UqwpXEeUG1lM3c+l74McG
 gOAmfHVOSJ65Kqfgbjb7CWyZKsBlGw67LcelWkUQAn9rWvBI0LEurzDNDy2E5HTkMAjX
 NmpdM5+Ge98dU0s42IoOfmMDWqXZ55GG3m6DZTX3THKoWmQcFwoEKVqd8oVEN4oXOAVk
 HCDlAB88bCnCVSAzHL/zaLD9gNEBo63Nj9bYotQILYxOonKzJ+10d0z2CZglvWsmSTa9
 f91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697018841; x=1697623641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a9pA3N2mLaavnmoLIQXFeIPIcdX4kqVShAUOqB7XaiE=;
 b=e4pw71n0eOQBU+ys9CNqtFIG39enbVK4sfUWLfUOfmdFdXB2Vm8dGS45vPyHVFy1Gz
 jldjTjksjJkT/p+u8WquZBtUINEexr+5Hj54liIJJWEwXIY5Gt7oPIWD05b+QLcx66RQ
 ipFuMbAhLrRA9ZXeUfslbEWYsuIzUL8MvFEudnhFt3/NKh42mazogaY6ucAhqZD1fXhh
 1HKIWxXbepX+GLiWdR5Me+06XXr3n387mEHR9V2Y+/VlRCyrZ53SMRLVT2KaDLNe+PEB
 /52vDKu9hckurltbhRzVC1+/VpjBG1DWmWYNhSJ5W+XSAcxmHyKBkvoWIsKrZNvKQgdo
 4zPg==
X-Gm-Message-State: AOJu0YzRbRLV0JpUGeeLDVuEHtT9Ai8S/U3pdRHFbDLm3rBn+tSF+fTy
 9Yj4DclxcfcJzxOEvN+pNVKImg==
X-Google-Smtp-Source: AGHT+IHKFPJUqiTQ0HACRgk/Q39b/Dwg5Zp+bXXJCP0bKj0889S3djY3LFd3PxVsyh/bX3vTjCwmsg==
X-Received: by 2002:a6b:5d01:0:b0:794:cbb8:725e with SMTP id
 r1-20020a6b5d01000000b00794cbb8725emr20221045iob.2.1697018840894; 
 Wed, 11 Oct 2023 03:07:20 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm9663358pfi.5.2023.10.11.03.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:07:20 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v6 00/14] firmware: scmi: add SCMI base protocol support
Date: Wed, 11 Oct 2023 19:06:53 +0900
Message-Id: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
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

This patch series allows users to access SCMI base protocol provided by
SCMI server (platform). See SCMI specification document v3.2 beta[1]
for more details about SCMI base protocol.

What is currently not implemented is
- SCMI_BASE_NOTIFY_ERRORS command and notification callback mechanism

This feature won't be very useful in the current U-Boot environment.

[1] https://developer.arm.com/documentation/den0056/e/?lang=en


Test
====
The patch series was tested on the following platforms:
* sandbox
* qemu-arm64 with OPTEE as SCMI server
* confirmed CI check (pull request #439)


Prerequisite:
=============
* This patch series is based on v2023.10.


Patches:
========
Patch#1-#6: refactoring & bug fix
Patch#7-#9,#11: Add SCMI base protocol driver
Patch#10,#12-#13: Add SCMI base protocol device unit test
Patch#14: add a protocol sanity check


Change history:
===============
v6 (Oct 11, 2023)
* shuffle the order of patches to fix a bisect error
  (No change on the code)
* drop scmi command which was intended to be used for debugging
* add patch#8 (version check)

v5 (sep 26, 2023)
* fix a per_child_auto size (patch#1)
* fix an existing bug (not using a protocol's channel) (patch#2-#4)

v4 (Sep 12, 2023)
* shuffle the patch order (patch#5,6 prior to patch#7)
* several improvements/cleanup thanks to Etienne
  (Each commit message has more details.)

v3 (Sep 8, 2023)
* import patch#6 (protocol availability check) from my followup patch
* fix an issue on ST board (reported by Etienne) (patch#1)
* minor code improvements
* fix various typos pointed out by Etienne
* revise function descriptions/comments 
  (Each commit message has more details.)

v2 (Jul, 26, 2023)
* refactor devm_scmi_of_get_channel()/process_msg(), removing uses of ops
  (patch#1)
* use helper functions, removing uses of ops (patch#2,#9,#10)
* add more descriptions in scmi command doc (patch#11)
* remove 'scmi base' sub-command (patch#10,#12)

v1 (Jun, 28, 2023)
* initial release

AKASHI Takahiro (14):
  scmi: refactor the code to hide a channel from devices
  firmware: scmi: use a protocol's own channel if assigned
  firmware: scmi: support dummy channels for sandbox agent
  firmware: scmi: move scmi_bind_protocols() backward
  firmware: scmi: framework for installing additional protocols
  test: dm: add protocol-specific channel test
  firmware: scmi: implement SCMI base protocol
  firmware: scmi: add a version check against base protocol
  firmware: scmi: fake base protocol commands on sandbox
  test: dm: simplify SCMI unit test on sandbox
  firmware: scmi: install base protocol to SCMI agent
  sandbox: remove SCMI base node definition from test.dts
  test: dm: add SCMI base protocol test
  firmware: scmi: add a check against availability of protocols

 arch/sandbox/dts/test.dts                  |   5 +-
 arch/sandbox/include/asm/scmi_test.h       |  19 +-
 drivers/clk/clk_scmi.c                     |  27 +-
 drivers/firmware/scmi/Makefile             |   1 +
 drivers/firmware/scmi/base.c               | 664 +++++++++++++++++++++
 drivers/firmware/scmi/mailbox_agent.c      |   5 +-
 drivers/firmware/scmi/optee_agent.c        |   5 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c | 469 ++++++++++++++-
 drivers/firmware/scmi/scmi_agent-uclass.c  | 412 +++++++++++--
 drivers/firmware/scmi/smccc_agent.c        |   5 +-
 drivers/power/regulator/scmi_regulator.c   |  26 +-
 drivers/reset/reset-scmi.c                 |  19 +-
 include/dm/uclass-id.h                     |   1 +
 include/scmi_agent-uclass.h                |  89 ++-
 include/scmi_agent.h                       |  29 +-
 include/scmi_protocols.h                   | 495 +++++++++++++++
 test/dm/scmi.c                             | 195 ++++--
 17 files changed, 2262 insertions(+), 204 deletions(-)
 create mode 100644 drivers/firmware/scmi/base.c

-- 
2.34.1

