Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68B5C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 13:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D74D4887F5;
	Thu, 15 Aug 2024 15:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="KnnuRnM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F2D88A16; Thu, 15 Aug 2024 10:21:31 +0200 (CEST)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch
 [185.70.40.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03DCB889C9
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 10:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=emil.kronborg@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1723710088; x=1723969288;
 bh=fnQI5/5muuCcB11L+xlTbx2XW94Vvbah2UibiVPqsK8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=KnnuRnM1MjVEHLz3M2xGdBN/ZYZRuYl8gMFqOEnf7pGEklz8eYBQv0dEJZ64fg+UN
 6m63EizCxhXTNj6HXnW+mm0f0tSCyw7dqHyedXfQaXsU8ze4RysH81P72IH/RMMGiS
 eKsT1FNpmkwSWDz+ozjtIff1s1J9FzijE+CVeFKzxR5ZxlMXxnlTXEoJ753FxB9cJM
 aIZktcXp9rBR9iXFWAd3STPW4pIyzeDGL1hmn9YALr5XTyFP/xND2XIAanC9pVtLcU
 O9lYUqmlxpwd0g6JodPfLlpVt1M6v8X58UZHOVIugxTByEGtzwexn3/ZFohTgL7Nr3
 VPl2ebFdY5Yrw==
Date: Thu, 15 Aug 2024 08:21:22 +0000
To: trini@konsulko.com
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: heinrich.schuchardt@canonical.com, quentin.schulz@cherry.de,
 u-boot@lists.denx.de
Subject: [PATCH v4] doc: document the pwm command
Message-ID: <20240815082101.15612-1-emil.kronborg@protonmail.com>
Feedback-ID: 20949900:user:proton
X-Pm-Message-ID: 1b36d28f3ab5a6c463c59e90fd83b06d1cb2f43f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 15 Aug 2024 15:29:55 +0200
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

Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
---
Changes in v4:
- Changed license from GPL-2.0+ to GPL-2.0-or-later. Also, removed
  trailing colon.
- Simplified the descriptions in the Synopsis section by removing the
  text following the '-'.
- Reformulated the description of the invert subcommand to be more
  precise and correct.
- %s/duty cycle/duty period to be consistent with pwm.h and to ensure
  correctness, as duty cycle is dimensionless and <duty_ns> is given in
  nanoseconds.
- Moved the common parameters, pwm_dev_num and channel, to the bottom of
  the Description section, and added the remaining parameters.
- Added a comma in the Examples section and used '=C2=B5s' instead of 'us'.
- Rebased on top of master.

 doc/usage/cmd/pwm.rst | 91 +++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst   |  1 +
 2 files changed, 92 insertions(+)
 create mode 100644 doc/usage/cmd/pwm.rst

diff --git a/doc/usage/cmd/pwm.rst b/doc/usage/cmd/pwm.rst
new file mode 100644
index 000000000000..522acb5afa33
--- /dev/null
+++ b/doc/usage/cmd/pwm.rst
@@ -0,0 +1,91 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. index::
+   single: pwm (command)
+
+pwm command
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Synopsis
+--------
+
+::
+
+    pwm invert <pwm_dev_num> <channel> <polarity>
+    pwm config <pwm_dev_num> <channel> <period_ns> <duty_ns>
+    pwm enable <pwm_dev_num> <channel>
+    pwm disable <pwm_dev_num> <channel>
+
+
+Description
+-----------
+
+The ``pwm`` command is used to access and configure PWM (Pulse Width Modul=
ation)
+signals.
+
+pwm invert
+----------
+
+* If the value of ``polarity`` is 0, the default polarity is used.
+* If the value of ``polarity`` is 1, the polarity is inverted.
+
+pwm config
+----------
+
+Configure the period and duty period in nanoseconds.
+
+pwm enable
+----------
+
+Enable output on the configured device and channel.
+
+pwm disable
+-----------
+
+Disable output on the configured device and channel.
+
+pwm_dev_num
+    Device number of the pulse width modulation device
+
+channel
+    Output channel of the PWM device
+
+polarity
+    * 0 - Use normal polarity
+    * 1 - Use inverted polarity
+
+duty_ns
+    Duty period in ns
+
+period_ns
+    Period time in ns
+
+Examples
+--------
+
+Configure device 0, channel 0 to 20 =C2=B5s period and 14 =C2=B5s (that is=
, 70%) duty period::
+
+    =3D> pwm config 0 0 20000 14000
+
+Enable output on the configured device and channel::
+
+    =3D> pwm enable 0 0
+
+Disable output on the configured device and channel::
+
+    =3D> pwm disable 0 0
+
+Invert the signal on the configured device and channel::
+
+    =3D> pwm invert 0 0 1
+
+Configuration
+-------------
+
+The ``pwm`` command is only available if CONFIG_CMD_PWM=3Dy.
+
+Return value
+------------
+
+If the command succeeds, the return value ``$?`` is set to 0. If an error =
occurs, the
+return value ``$?`` is set to 1.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 1f6518b77c4b..6a218c46b4e4 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -93,6 +93,7 @@ Shell commands
    cmd/pinmux
    cmd/printenv
    cmd/pstore
+   cmd/pwm
    cmd/qfw
    cmd/read
    cmd/reset

base-commit: 90270e0f71c53cca9c0347ce3baedf26b8ec4cdb
--=20
2.46.0


