Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F9FC25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 12:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FE5F8833A;
	Thu, 16 May 2024 14:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="NXnoPjz4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A896188286; Thu, 16 May 2024 12:43:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4532F87F65
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 12:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715856184; x=1716460984; i=fiona.klute@gmx.de;
 bh=nOh+/z8sGeE6Azsd0W7e3u8P49sPN3lc4LBaMH+YQPo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=NXnoPjz4mz/++oeG8ENl5U8g/1VCV15qjiSSpZzTUnGninTJifCHZ8DFm6uefPFv
 CPZLrqPDoOkLvPHpeqzL8wjdaL4r/r1EQvggMuhO5ulxTuKf2LxOEN9wutqRXQSly
 jHEhNnQLkhQcOTWE5A4yxTb3I+1WubbZmTlPPXXltZrEyjze483QpvKWRH2lk8tgu
 JVTSjzbqyJbmfa7/oEDcIbygSLebRV6iAKzWTuXksOc2ks3OdIj/ikH1IWfCRmBu9
 DK2+SovBIzanKGWiDILTuPo7Mb87I46aeP8GSmmoJZEpGAphX8WrM83V+5l2i100V
 wU7m8muNVnoXOfO2fQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.121.157]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MO9z7-1rwEqn0tth-00Obeb; Thu, 16
 May 2024 12:43:04 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: mibodhi@gmail.com,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH v2 1/2] doc: Detailed example for netconsole setup
Date: Thu, 16 May 2024 12:42:44 +0200
Message-ID: <20240516104245.2075748-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9c5rwITMaORuZmIE0crMCbxFPYl6P8tNs4ohaDk9uyZBAQ1Ty5y
 n2WnLSztI2mZ7vpGfrQK3Ee4UmjkQ6j1ov/ZzsTrYV1JEMUrQ4tpZwv7pvvEdPKLp7Q0KNE
 qQq64FbRXYnNlnOcZquZmu4hjsbsfny0N0iiZA2s0a9dF5vMRE3yhK/G9ktl4MCHdv/cbiO
 cyTKaE07YodLfWn/KCjxA==
UI-OutboundReport: notjunk:1;M01:P0:+3k5ZorUwWo=;KEMcWCSrZczO6O5RrTh2qSh7UAZ
 HeWyJ+aBu2Fmc4AidhoefsM7YMUcmaaAamkDaePiyUuhRNy9xJg62Pkh1776hfSM5FznbXzLA
 Zc7W6jdF2xrFKlXuONRjcI7x6PLFPvyI4Y4zNrgrTlMhNhMRsobsrifemaAF0W8KIb51AtsEl
 wZx0+9VfbuGBQLJjhGdodH4PiIlmFAOb0cj+LIyYYbQWIhSN0PJ9ObRytZkGxCGxoNtq2Orda
 mZ6YPkq1RM9VKN5ctyGyu7DLnBduIYCGROuA724TZKE3zuktd3xI6+HZPstVg2scgtF0ZG4UQ
 7u+GogsmJPwJ2MqLwSTGFDPfSxxY0KPitkLgVpPRhARgURWcx/QtO3f7IiTh/u9eD563rSKsJ
 16UmVIpTym80VJRWO9Kv975e7nwQLDSGxzpnFThHAkzxOLI1k9QaVM4/HXpc6sX1+RPm2DQ+1
 +DlXqs/6VfA9VkImk9L2Z0bf/slKK83ykbKCEJoCmF5bDkzeeZHffMsEgOHTOn7VaTk+Zg8Xg
 YSYlnseJqLHNQdka8GPCCTTnkwbj64Ihdc9LhKtq1C2U/Dg7egA5aaGNk7/KK7im9aNXlrd1B
 WjLPsv/KBvrGx/Ate+L0hBFEmMnMpoFLcgkPaOPdiqRvIkx3gLceLnT025CAKP88obteqEhuo
 kJF9K/ikTYz7yUHMKN0IfToHQbx2r0CtHepfkka0Z8VVXHHycUcuA5od6AsB7jQ+jcgX+rmZk
 obs9OnbRAmyxAO7kjtxhLoKS+R2lj6gEV5DgYEm1sEJ7lVEG9lUDsOj6jJ/Q71BxLpEzmtl5L
 DDOQmwVcQj5dyOsgoh/h6etOLcCDLuJgyT20JLOBBeASo=
X-Mailman-Approved-At: Thu, 16 May 2024 14:50:16 +0200
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

This adds details that I would have liked to have readily available,
in particular how to activate the network interface before enabling
netconsole, and how to integrate netconsole so you can use the U-Boot
prompt.

Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
Changes in v2:
* Include stderr redirection
* Use 4 spaces instead of tabs for code block to avoid overflowing
  lines

 doc/usage/netconsole.rst | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
index 2aa3b9ccc5..647f0c220b 100644
=2D-- a/doc/usage/netconsole.rst
+++ b/doc/usage/netconsole.rst
@@ -18,7 +18,9 @@ broadcast address and port 6666 are used. If it is set t=
o an IP
 address of 0 (or 0.0.0.0) then no messages are sent to the network.
 The source / listening port can be configured separately by setting
 the 'ncinport' environment variable and the destination port can be
-configured by setting the 'ncoutport' environment variable.
+configured by setting the 'ncoutport' environment variable. Note that
+you need to set up the network interface (e.g. using DHCP) before it
+can be used for network console.

 For example, if your server IP is 192.168.1.1, you could use::

@@ -107,3 +109,32 @@ as follows:

 Note that unlike the U-Boot implementation the Linux netconsole is
 unidirectional, i. e. you have console output only in Linux.
+
+Setup via environment
+---------------------
+
+If persistent environment is enabled in your U-Boot configuration, you
+can configure the network console using the environment. For example::
+
+    =3D> env set autoload no
+    =3D> env set hostname "u-boot"
+    =3D> env set bootdelay 5
+    =3D> env set nc 'dhcp; env set stdout nc; env set stderr nc; env set =
stdin nc'
+    =3D> env set ncip 192.168.1.1
+    =3D> env set preboot "${preboot}; run nc;"
+    =3D> env save
+    =3D> reset
+
+``autoload no`` tells the ``dhcp`` command to configure the network
+interface without trying to load an image. ``hostname "u-boot"`` sets
+the hostname to be sent in DHCP requests, so they are easy to
+recognize in the DHCP server log. The command in ``nc`` calls ``dhcp``
+to make sure the network interface is set up before enabling
+netconsole.
+
+Adding ``nc`` to ``preboot`` tells U-Boot to activate netconsole
+before trying to find any boot options, so you can interact with it if
+desired.
+
+``env save`` stores the settings persistently, and ``reset`` then
+triggers a fresh start that will use the changed settings.
=2D-
2.43.0

