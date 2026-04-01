Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AEDD2ED0A
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE4B84011;
	Wed,  1 Apr 2026 16:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KB3iFMf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A440C83D8A; Wed,  1 Apr 2026 16:15:28 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5BD83CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486507134e4so78576355e9.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775052924; x=1775657724; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5UDZeWD1hgkIxEpAFVWG629Po7D81XmsTKQGAdMwZVM=;
 b=KB3iFMf7ggC1H2f7xaiueJ0cOD5PlKXyuhBB0wi8TNXffC6XDXMtkzDZQPO+ndChLw
 xwLg2fVBUSg1X/22nb+nwLXAZB+2K1VRC6Ygm5mIx/sNHJE7fVOI/yFyp3Zk2FuXaKuk
 dWjyxiUmR1gdm5FyAMLkYJ6kSvh4IBRvRwlZvk7xSjDvQZTGD54RPxnOEOxz0GbtnEBl
 hoEr+xzSapYX+oL7pt2rb7cDbI9hwUwlhvSwdVSWzGBeskLbypCLFzuFYwfyc4JZE8/R
 sLlfc/PsUAUyhdOu9Ki0BfwuNptM0mMQP/ODM4qZnbTGywmiBdn2LbBSJYXU8oBd55ql
 rIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775052924; x=1775657724;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UDZeWD1hgkIxEpAFVWG629Po7D81XmsTKQGAdMwZVM=;
 b=AtL0dsD+2hXXO44/m9tGHOsAnep0MUO15cefOrDNRkkxNc8WYiGaJHqZa9FN7X00Qd
 5xUjCu7XHHB0fFlE61J4rfWEWfWxjY9znM/Ag+GoGR0A0GuYA80BacoJyKaiwxnP+g5O
 O31Bu6LGFBvz9LehU48tWREoOs8nX4FBxruNVaPpr00Q20j9FJUocqg9IqjxlG4SFr7I
 vtCgag3AGbF4MLe2zK7Ks5dnK2+6irniLHGEaSIQ7asRt8TIjUPMmbWywiBj6wUJNAXY
 POX+Tf63Uw+a3KqYTavKVyaHT9T/N+yKOWHrJxO5cJfmwoWepgCJpR/Wvs9Aft/LinlN
 d+FQ==
X-Gm-Message-State: AOJu0YziasGBKwyAvTDhrRKH2loG5mPg76CahjPopNn7hA4rJBMME2UF
 JW0yDP376w/rAPu5Mw64EcOrofrAR1p4h9hQD6HSET/9G64tL538jwWeOjzM0jcEWGk=
X-Gm-Gg: ATEYQzydT2bvo2dK/hxU6cwHyFtFO1eswQDSLsKFO9nW5IOBAR4NSQHwy2FV+FNPku2
 W49r1g9Q0X6DP3Qs30tOTa/6nkrBBDruXiuZ5RxEXtuJFWROzieQ+ZnZaPHEP6rt8zb5ynShWfc
 MNS1dxItq+7ly0HwG26MRPllo5v9Mf9bvce/bPvAyosFx2po8dTvOsc3WXzDjgbLKXAKmqAyS6c
 6ToKcYvOqfhQ33c6mflR92VucBKP7DuZjRNjMuiNunvBrz40bBjforPZd2V+3hNIhOqzQSWaZvS
 od6UKdgEMXaLspVNTBPAm0efvC02+QYOeZqeyOU8ZcLp4GBWbD61J0n0cDDLJ3cQO+m+zjqtt3g
 rVLqTdEZ8RRII7C5ayx1Z813cAQhaeu+hFJ8kwnh+kArRRDIGJjl+QlwpePCaeVo76cUIRQrkUu
 M+b3Ttx6afSTkfjeiW/T7vFZYKdHxV4yFk+oe43HE8mDRU59pR35clvGIEsLpDIpnVNIbC
X-Received: by 2002:a05:600c:4704:b0:486:fcc7:d6a with SMTP id
 5b1f17b1804b1-4888358931fmr62005705e9.13.1775052923855; 
 Wed, 01 Apr 2026 07:15:23 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm43224135e9.27.2026.04.01.07.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:15:23 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v2 00/11] Linux compat improvements and CCF prep
Date: Wed, 01 Apr 2026 16:15:16 +0200
Message-Id: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHQozWkC/yXMQQqDQAxA0atI1gbGCMX2KuJizERNoSoTLRXx7
 h11+Rb/72ASVQxe2Q5Rvmo6jQmUZ8CDH3tBDclAjh6uJIfsTTZk7pCnz+wX5NB6InFF9QyQsjl
 Kp79rWTe3bW3fwsv5geP4A7iPGOh0AAAA
X-Change-ID: 20260320-casey-ccf-compat-cdba22e0189d
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3887;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=eOF3UEX6m4DnajkYCbA/5uFEz1cOtYC/d+dZiCPclnI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzGpVNX34+2V9xeMKLS04TDUX26Wqqb/rdOOmNb+L6L
 06/Q9wudJSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJCHxm+MPX+Si1eeOMlqsW
 Cw4HFGk9fr0jMLrY38YrrGzep585bS2MDMunzv7Cyh19Tu74l78XlmmH7Ntcxan4ZuIWrfuWvDX
 y9ZoA
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

This series implements various improvements to Linux header
compatibility, largely in preparation for a full port of Linux CCF but
many of these changes would also be helpful when porting other drivers.

Beside the basic header/compat stuff there are a few larger patches:

Patch 1 adds the "%pOF" format specifier to vsprintf, this behaves the
same as it does in Linux printing the name of the ofnode, but notably it
expects an ofnode pointer rather than a device_node.

Patch 2 adds an option to skip doing a full DM scan pre-relocation.
Some platforms like Qualcomm don't actually need devices to be probed
prior to relocation, it is also quite slow to scan the entire FDT before
caches are up. This option gets us to main loop 30-50% faster.

Unfortunately it isn't possible to totally skip DM since U-Boot will
panic if it can't find a serial port, but the serial uclass code will
bind the serial port itself by reading /chosen/stdout-path, however any
dependencies like clocks won't be found so this should only be enabled
if the serial driver gracefully handles missing clocks.

Patch 3 adds [k]strdup_const(), this works the same as the Linux version
saving a small amount of memory by avoiding duplicating strings stored
in .rodata, this is particularly useful for CCF.

Patch 4 adds 64-bit versions of some 32-bit ofnode utilities functions,
making it possible to parse 64-bit arrays.

Patch 6 provides a simple implementation of kref, this will be used
by CCF.

Patch 9 adds devm_krealloc() support to devres, it relies on storing
allocation sizes in the devres struct which will add a small overhead.

---
Changes since v1:
    * No changes
    * V1: https://lore.kernel.org/u-boot/20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org

To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>

---
Casey Connolly (11):
      vsprintf: add %pOF
      common: add an option to skip DM pre-relocation
      string: add strdup_const and kstrdup_const
      ofnode: add read_u64_array and count_elems_of_size
      compat: add PTR_ERR_OR_ZERO
      compat: add kref implementation
      compat: add dev_name()
      compat: add linux/regmap.h symlink
      regmap: add regmap_assign_bits
      compat: regulator: add enable/disable macros
      compat: math64: add abs_diff()

 Kconfig                        |  12 ++++
 common/board_f.c               |  11 +++-
 drivers/core/of_access.c       |  52 +++++++++++++++++
 drivers/core/ofnode.c          |  48 ++++++++++++++++
 include/asm-generic/sections.h |  19 +++++++
 include/dm/of_access.h         |  20 +++++++
 include/dm/ofnode.h            |  50 +++++++++++++++++
 include/fdtdec.h               |  16 ++++++
 include/linux/compat.h         |  13 +++++
 include/linux/device.h         |  29 ++++++++++
 include/linux/err.h            |  25 +++++++++
 include/linux/kref.h           | 124 +++++++++++++++++++++++++++++++++++++++++
 include/linux/math64.h         |  19 +++++++
 include/linux/regmap.h         |   1 +
 include/linux/string.h         |   2 +
 include/power/regulator.h      |   3 +
 include/regmap.h               |   9 +++
 lib/fdtdec.c                   |  18 ++++++
 lib/string.c                   |  31 +++++++++++
 lib/vsprintf.c                 |  37 ++++++++++++
 20 files changed, 538 insertions(+), 1 deletion(-)
---
base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7

// Casey (she/they)

