Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A74C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 523E788B29;
	Thu,  1 Aug 2024 16:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="b5MbI9UZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C1388AE4; Thu,  1 Aug 2024 12:08:02 +0200 (CEST)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934788874D
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 12:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=emil.kronborg@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1722506879; x=1722766079;
 bh=AiG2zbHmg1QDlD/Z7vcncYJWQrx02I0U4bO2kRtKXuk=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=b5MbI9UZbHrWDD1C6/FnpY80f7v2/X99rJhV0TxzyaKE90DO/yvnMcA7emIE7OfCk
 1Ujm74x1m6t2UwmLtNAa7R8kBg4KlJQtwYmmdcBJlxj8jy6m2D6dL5OxnY7l3o+UXD
 3CUH0ZWG6Cqz1ZR4fjHMScBCX0XvSyYQA8rs8t/VjXkyHXmd2x2U8+UF7cuQRhRcX7
 c1c0mcVOTJWk/gthwjNxoGSCbHbIJJr7cGZY3mFHQ5RbBlrIhwxwfBax3d+yKvnwjE
 oi2DPI+Y1xlBJXk0edon6ObWBZ7ZifKQIOBN1ibf7tNRRrWSa09DJ35hInmDSZf+nT
 Jnrs0DX18FrgQ==
Date: Thu, 01 Aug 2024 10:07:57 +0000
To: trini@konsulko.com
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de
Subject: [PATCH v3] doc: document the pwm command
Message-ID: <20240801100754.44732-1-emil.kronborg@protonmail.com>
Feedback-ID: 20949900:user:proton
X-Pm-Message-ID: f1496347ff59bdf78ff2de085e42ae311e47c226
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 01 Aug 2024 16:06:21 +0200
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
Changes in v3:
- The help text for 'pwm config' in the examples section is more
  explicit about 20 us and 14 us for the period and duty cycle,
  respectively.
- Fixed 'pwm enable' and 'pwm disable' in the examples section to only
  expect 2 arguments.
- Rebased on top of master.

 doc/usage/cmd/pwm.rst | 80 +++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst   |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 doc/usage/cmd/pwm.rst

diff --git a/doc/usage/cmd/pwm.rst b/doc/usage/cmd/pwm.rst
new file mode 100644
index 000000000000..bd1255d82186
--- /dev/null
+++ b/doc/usage/cmd/pwm.rst
@@ -0,0 +1,80 @@
+.. SPDX-License-Identifier: GPL-2.0+:
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
+    pwm invert <pwm_dev_num> <channel> <polarity> - invert polarity
+    pwm config <pwm_dev_num> <channel> <period_ns> <duty_ns> - config PWM
+    pwm enable <pwm_dev_num> <channel> - enable PWM output
+    pwm disable <pwm_dev_num> <channel> - disable PWM output
+
+
+Description
+-----------
+
+The ``pwm`` command is used to access and configure PWM (Pulse Width Modul=
ation)
+signals. For all subcommands, the following arguments are common:
+
+pwm_dev_num
+    device number
+
+channel
+    channel on chosen device
+
+pwm invert
+----------
+
+The signal's active and inactive states are swapped.
+
+pwm config
+----------
+
+Configure the period and duty cycle in nanoseconds.
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
+Examples
+--------
+
+Configure device 0 channel 0 to 20 us period and 14 us (that is, 70%) duty=
 cycle::
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
index 49b354e6ffd2..1adab5283950 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -92,6 +92,7 @@ Shell commands
    cmd/pinmux
    cmd/printenv
    cmd/pstore
+   cmd/pwm
    cmd/qfw
    cmd/read
    cmd/reset

base-commit: 7010f22eba35b2a6b66ba37ce565e566ca08c68f
--=20
2.46.0


