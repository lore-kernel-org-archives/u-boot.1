Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0974CD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 11:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F07D880F0E;
	Tue, 12 May 2026 13:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ip7KS5Y3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1E48341A; Tue, 12 May 2026 13:13:15 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49FB2801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 13:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45297094718so4313900f8f.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778584393; x=1779189193; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g/ljgWoRBo4G3p0KNasqgY/IcaSImKDvMgUJG8bisw8=;
 b=Ip7KS5Y3zB47QJLUwrOLXTxnbpdrbe2p5KJhnyG9VdAFH7Rt7FTdOag/FV9LNSUYyP
 Gbp0RD2F5yDhHb6/aa10CjGjL/I5cY9C7SvbJ44jfR0VGGXyLNkCZZf/BcIHm0GBXG0e
 n/YOBgDGM+767Fs03WfH6EkRaqhxAa5PFSFDrPlPDqzz+XIJb26rdJwgTgtY0szIAA/u
 lkG5uL0b5we8uxR59+T/EIgpCL5z3ONCheUr+xt6aF8ravwHZ4Y+jNex0gJX3Yw+/Ra5
 VUYqSuder/0TXuq4qXulk6R6FfiX7KkuMH8LZy9OmU0RKgUHr7P/TIQnVRPuMXCv3BzH
 2G4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778584393; x=1779189193;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/ljgWoRBo4G3p0KNasqgY/IcaSImKDvMgUJG8bisw8=;
 b=QhlSU8PJV7DhAjifzJf95kWQ9Du2lEpwNmQCDsOcp4mrpfb2OS9/o5psnvpYJJJr9R
 s41qxOhdLHPwgpAEn6CJvACJvsJUmSTZRZZwMk+ZnWxLr8AlqnptAaLExEa4/Z/U44xc
 2i6acBKTWaVwk3qCAY6BBUZyay3Mr+skRAWSGEWcPXVZijRW1EpoVMoa+HDUZ73/dLPN
 iS5niQoVol3X/WtVI2o1Eet7JULXUt0ZLQXSD5eskButZSwp5Cg+/RtdOFMiNqamVmz4
 y9c+Xi98hmWWI9heH9NF5PXqCfFHatVLN/dhQpRFjaw+YBdz408h+Z7CxD329Ne13Hlu
 kg3g==
X-Gm-Message-State: AOJu0YxXloZ9GMdQ73L1bf3Cls/Co7i2p8IiDx/afUdD1jnfgY9YBaJj
 m1Sen48QpMMSSBVNu1q7n2YecYioAD0G34bN0Xbl95IK/swHWxi57vKcbEBYolqyuqY=
X-Gm-Gg: Acq92OGvKyvBEA/7T0WDylfvWMnCmu75Owgho6nLsF7sj8l1GkLJhGdXhBSEFyODA6i
 Wfxz2XahExyUQEZeDMDzRoVEnJ9pPm7VVWCC3uvWgmS8ChUZnlL/FRtQ4Z8NwPTiSRHG+rO5pw0
 keGCqnPPGujoZ1oGuJ8I/L+WkOJSZ+59yvR4stG5JWByie6Qv5wPQBiiKCDidTLrURqoBDebA5V
 X90TEWd79ZkZD3jd9z/GLWzAE8JbGKfioKoxz+0GXyyDaqbZiJUeXw4K1p9q+fZ9tohnlv1iP1y
 ayiyTPmm8q11jTTiweHOkyH2uyWkDInvOTzDs7SV2m/PGoFMMrduFgQxMUinG06RWt84f6pUGcK
 0Y5bv8ihTU6asNhlvoj2DKCcvGLkjT4Z/HyLKWtrTEfvKGbOPSepi7hRYg4LmrKIl5N9l6hotqr
 ayoOzlqP6FzbcKBWgslSLe/e8VqgaKzHWbbnAXbcDxr6JfpjmItPxni7UFxT0TyhmNhfiu
X-Received: by 2002:a05:6000:4008:b0:452:11f9:bc40 with SMTP id
 ffacd0b85a97d-45b115c7d57mr3432415f8f.2.1778584392672; 
 Tue, 12 May 2026 04:13:12 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6b00fsm35124259f8f.11.2026.05.12.04.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 04:13:11 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v4 0/4] armv8: mmu: fix region unmapping and optimise
 set_one_region()
Date: Tue, 12 May 2026 13:13:09 +0200
Message-Id: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ6CMBCEX4Xs2TW1/NR48j0Mh9IusEZa0gLRE
 N7dgnePX2a+mRUiBaYIt2yFQAtH9i5BccrA9Np1hGwTgxSyEqVQ2BQ4DDPObtAjtvymiJdWkZC
 mMoVtIYljoCNI3qP+cZybJ5lpX9obPcfJh8/xuuR77+/BkqNArY1SsrJXZcv7i50O/uxDB/W2b
 V93sfzpxwAAAA==
X-Change-ID: 20260507-b4-mmu-unmap-fixes-1f7e02c6c4df
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Vpc+3LLyaLfFUOHvLdw2/+f3oTX0/SQP30hOeXd7fXk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhixmbreG0Cn/jsyLf1qdq/+S/ZzXYonoxirtT8J6jwQjg
 1cb95V2lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIkEtzIyTNzzwHfWpEvKgaq3
 9gksbjKoU99wsntWk2tnoCvjgy17rjEyLIk6VZEd++Z9yol1WgEymfprpM/GxCkZyYTsXscU/+h
 FFAA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Currently trying to unmap a region results in slow and largely broken
behaviour as we unnecessarily split blocks and manually set thousands of
individual 4k pages instead of higher level blocks.

This series fixes the behaviour of set_one_region() so that it works properly when called to unmap regions. See patch 4 for details.

Patches 1 & 2 improve the existing debug functionality, the pagetable
dumper will now print most explicitly unmapped regions (since they still
have their PA intact), as well as adding a new function which does a
very basic software TLB lookup to help with debugging.

Patch 3 de-duplicates some code by moving the loop that always surrounds
set_one_region() calls into its own function, this also helps with
readability in the calling functions.

Changes in v4:
- Fix the new set_regions() common function to never call
  set_one_region() with level = 0 to match existing behavjour.
- Link to v3: https://patch.msgid.link/20260507-b4-mmu-unmap-fixes-v3-0-aac7726d87d5@linaro.org

Changes in v3:
- Reworked entirely to be correct, v2 would cause unrelated pages to
  get updated too if the region was inside a block.
- Added additional patches with debugging improvements and code cleanup
- V2: https://lore.kernel.org/u-boot/20260504183721.646712-1-casey.connolly@linaro.org/

---
Casey Connolly (4):
      armv8: mmu: add a function to help debug TLB lookups
      armv8: mmu: teach the pagetable dumper to show explicit FAULT maps
      armv8: mmu: commonize the set_one_region() loop
      armv8: mmu: fix and optimise explicitly unmapping regions

 arch/arm/cpu/armv8/cache_v8.c    | 170 ++++++++++++++++++++++-----------------
 arch/arm/include/asm/armv8/mmu.h |   7 ++
 2 files changed, 105 insertions(+), 72 deletions(-)
---
base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6

// Casey (she/they)

