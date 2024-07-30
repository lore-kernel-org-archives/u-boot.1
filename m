Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B8DC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 12:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E0C88607;
	Tue, 30 Jul 2024 14:32:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="O06xbNAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA64887E4; Tue, 30 Jul 2024 13:07:51 +0200 (CEST)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6FD388747
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 13:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=emil.kronborg@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1722337668; x=1722596868;
 bh=XmfXA00lZj0LvNwlmgnGqF9TA1ClBuuzgCBWssnQ9M8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=O06xbNALq/SlGENeAkymNgFVPHfTIJ+ec5NMgEo6dBLkabbIn8KIbF1WI1ql5beBK
 aND3C90ZJR3coomvBwQ0AzAgStSHxuLLNUcDG5JhNvSF/9Bez7D0N5GGmNpxb62wGc
 g0w0/UIr6wOOvZbEfB7PoEVNSUSfbHX0H6FbONJPTt1VMaR6AMgchpTNwu2WWigqL0
 mORWXI8e9sBnMeq7R2+0XGrH0MiE0dX+cWTVMjeaNL9VRLE3hfgFcAR/SayDuxfD88
 0cK0yRMcdDcq4Rp1+VIlD6/fkm1/6kk7CNAqCtjkPZ9C0f0ia1NWLnLPCYunDQTe8Q
 Hd3tgxOunyXXw==
Date: Tue, 30 Jul 2024 11:07:45 +0000
To: trini@konsulko.com
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] doc: document the pwm command
Message-ID: <20240730110741.37418-1-emil.kronborg@protonmail.com>
Feedback-ID: 20949900:user:proton
X-Pm-Message-ID: 1362e2807b007682937138d6e82bfa350ea6e3f5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 30 Jul 2024 14:32:32 +0200
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
 doc/usage/cmd/pwm.rst | 80 +++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst   |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 doc/usage/cmd/pwm.rst

diff --git a/doc/usage/cmd/pwm.rst b/doc/usage/cmd/pwm.rst
new file mode 100644
index 000000000000..208bad487aaa
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
+Configure device 0 channel 0 to 50 kHz period and 70% duty cycle::
+
+    =3D> pwm config 0 0 20000 14000
+
+Enable output on the configured device and channel::
+
+    =3D> pwm enable 0 0 20000 14000
+
+Disable output on the configured device and channel::
+
+    =3D> pwm enable 0 0 20000 14000
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

base-commit: c0d269da3c8492d4b81bbcb79a66f6d4a49f7610
--=20
2.45.2


