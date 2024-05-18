Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446D3C25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 15:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E140885DF;
	Sat, 18 May 2024 17:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Bs2e6928";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A956088670; Sat, 18 May 2024 12:47:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 401E688659
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 12:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716029233; x=1716634033; i=fiona.klute@gmx.de;
 bh=if+/q1/kWFf+4AXjAgN2uak+z/GGyPW4ACxoTm2iYec=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Bs2e6928iQEy6byIHN0VlvvF0nQ5RCwclJkc/WHOat8iAMHTLWlcgucYgMKh6owT
 AMO1MbEw1Q/t4KnRUqbJkiHQX4ZexJ3Rfb3pagAYsIqhpahnSW0TpnrNM3TOg0gkx
 6izlJcwcqxEPjK4Xlif4/bgYpUrvTKMwLxopQj9+zJ9R55nt+YabLq89PNlpXjlVq
 fcRiWPtZ8AGAmle2HSBZH5U5JsnI/LxLu5vMF4/60enQRaAX525yFllR2WvRN2YrX
 E+UpQY+ArIA4finfAczKJ4DzMRfZoCbhdlrMWzNOufKgtuafh9nh5P0BYq60UApMV
 OK1A6Og32DMwH8BZXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.125.1]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpNo-1shtKN12Mk-00ZvGG; Sat, 18
 May 2024 12:47:13 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Fiona Klute <fiona.klute@gmx.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v3 1/2] doc: Detailed example for netconsole setup
Date: Sat, 18 May 2024 12:47:05 +0200
Message-ID: <20240518104706.25283-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YpAezzAH4iYJtC0+fJ+kcwXzVuHHeNZLLJtGQ4ZHIooXje5CiEr
 6y9pluMH1eN/3tB12xS2ef5oHtIuZ42Nrh5kx9KyQQX3HQDeMC2SzubDbb8Mde3OUr4v/ri
 17Y2q82nVxjIRTuBSi9nEVrP9ahgGqBIyRpMopBIkbUh5Bbd1UIugzO2ZUo8fZjVZLPZ5fA
 GrLc+25RNKi/WdICvDsQQ==
UI-OutboundReport: notjunk:1;M01:P0:7aP60uQYSPQ=;neFgof8mNWZJ+KSFuTkmvjzAFu3
 3+oNSZykNFDlcGvR+SOZWn9lXJOEQh2VpUc1gYjQCKVT7ANm+UGKf3CYvJh4/2HZrqkRqm0Ue
 9JeYjn8JTcSOzbiLxy+dS2HU9Baxd526pVAUiACWTME/JNbHR8+Vs4s3A5qVBZZikZoTxoC5S
 WaFUR5tuqcj2sUw9rENeN1iIZgxmvdsuVenja+yKNVp4ZxJ9mJunMsYNWCxlsniNcm9qf7edb
 6v85JCv/LlpyE6ItPqB5KyMRA3ip1+w90XU1vY1vhZA9fUHiRnBMcSE98JJIrPUbTHQ0w7PmA
 3eGMq1NL5T5mICGImTvhpzo+ozs0TkmwAp3tVjn0HlN4KHWeKylG+/cl/BXs0Ik5GBWzIDACh
 xa+at5yzIH4ifG7s6SeYeCoFplWuYbv+yu5/xB/rfZpW8HK2clNPFbVzUjvEC4agL4aRFo6UX
 F3Mjq+mFTjPXaie2GLgTHYviEDyrpPlW/PoRfrGBn56ud4pWqzMJ+FHPGBRleD9gzbdvrVGc9
 KX0l5EuWQViKHusV2/DUR90QE7teolqra9Nslavv3EAPBhVLXzMOPFdtd4/DgBpeAD433Nzi/
 b22nD/JqiJrSj2YMgQqe5NB3GZOlWmasOZt9Qe76CzyD2ZpRZo8SGe2MwgWCUUV0r/WSUMAkw
 ykK1QW04UDoArEAO5wzbPbPS4qZcKftmC9QGgqtt7YAEaxMHmZ6cCJ5svZWKxFrpPRd+Vf8Gj
 yd2JpQHCpxGaTBvUAndA+vuyhczG9xGsK32psOdWUp0727hH/Q+duJjoYltXeodMVFh+flgbU
 q1KVQeZ+IXG3W4Bx7cYCk+fp09vBY9LXVcAlHdyzcgaw0=
X-Mailman-Approved-At: Sat, 18 May 2024 17:03:12 +0200
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
Reviewed-by: Tony Dinh <mibodhi@gmail.com>
=2D--
Changes in v2:
* Include stderr redirection
* Use 4 spaces instead of tabs for code block to avoid overflowing
  lines
Changes in v3:
* Use ".. prompt::" to make copying example commands easier

 doc/usage/netconsole.rst | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
index 2aa3b9ccc5..cb9a42d918 100644
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

@@ -107,3 +109,34 @@ as follows:

 Note that unlike the U-Boot implementation the Linux netconsole is
 unidirectional, i. e. you have console output only in Linux.
+
+Setup via environment
+---------------------
+
+If persistent environment is enabled in your U-Boot configuration, you
+can configure the network console using the environment. For example:
+
+.. prompt:: bash =3D>
+
+    env set autoload no
+    env set hostname "u-boot"
+    env set bootdelay 5
+    env set nc 'dhcp; env set stdout nc; env set stderr nc; env set stdin=
 nc'
+    env set ncip '192.168.1.1'
+    env set preboot "${preboot}; run nc;"
+    env save
+    reset
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

