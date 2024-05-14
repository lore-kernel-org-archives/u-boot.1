Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40565C25B78
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 00:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39AB881B8;
	Wed, 15 May 2024 02:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="pp7tAqL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF6EE87C75; Tue, 14 May 2024 22:21:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 072A08717A
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 22:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715718072; x=1716322872; i=fiona.klute@gmx.de;
 bh=ucUl7b5in+chSEB9g0wAjDfPvzc0t3WY3/nIyOgUDwc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=pp7tAqL7lEVWJki2plxNz/rCLOoI6k4xx/7pdvb79WjkN1NzHCjowEeWUnCy1she
 kw/fK4ieWNOIGAD9J8XnO9/6gMltsw2AT0+LoUeSjmKvtCZNr4+ObKCWIUHoGR+Hu
 Q7frfWgjuHLPT1RwcFHgKeyH/Ty27Tx8Ob7sar4NbdrHMrb4UKIel83VdIGkPn/1v
 lBfu8kl8tjeowwq3SV24Z8sSsaS1GoXul1+6XN8a2WKECADUHwMzOJiRtoqOIrNIF
 JqSRd+1jwT7KpoZymHyNbVB9EcfUXAuYhj7eIXGMlxjH+q3GUjmdJQIg9ADmiUObX
 i/hF3lsCKOm6JCcebw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.125.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOREc-1rwTjl3cSM-00Pyyl; Tue, 14
 May 2024 22:21:11 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH 1/2] doc: Detailed example for netconsole setup
Date: Tue, 14 May 2024 22:20:40 +0200
Message-ID: <20240514202041.386027-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fx8ddMhokoaLOZxT7oJe5HIGf2LUIBnZ/sCrobhY8wjLiDpqNhq
 ORg0JsI6aX90xr9Nuk5QlCL1vZrZCKmOQAHPhxUXdCXghqi6X36eI79T07cN6GsXM6Day4m
 5Dv66NI7cYhrWMLpBPnc6jshoXj010y1MeR90pZNSUZI/pLjRYr7vFyDG0KRUbBIDjOst2o
 lYuJ/FC2zGJpSaRdF8BNg==
UI-OutboundReport: notjunk:1;M01:P0:4b/ASIlAPvA=;cyadcIqB8kXxjO2/2iJmxWn4kx1
 UldaCNf8y0AIyP96EB9MDWt13hoC2LmkBS4usZzCI9+/7c8KE0/xtUISJnD+kDL7KZ350GN/G
 MI6YfeKptWhk5gXuk/LTwMiVA0t5sf1QKGuwVhN84CS2HGYdbx9c6DgiZYtwftu/GkHFT8fKK
 JkzctmGOtaeveOQ6C/626fkp5cWmhFkxfEKlhENW9VCnUEeEnYXjTrn4G+v/lHVSpSJIOJ/Of
 oS6b90f8koKDePt8l0Y+Wr8GV6D9T5umcgq0XRcphkK/xY87oD87HEYiLsSD5EfBNlxl4hIxN
 4VtS2TUCgv0t3YEZvanBj1HYun3MA7DiuVjSlCIZNgCfLdoPT9SbU99kqOhjSTfzA9A42Szm4
 cOtoEZlXtQbBd5FnyJVFiIDEzeYpgd+zuCd8RyPVFeQfOzeCwWIvZxTjjLLnByE09UMMkWRnX
 Y5uFfrSKQ5CmEY+BI2OMo8wJaAhXFII2r1DbUKquJHBky4t1YW4Mu0UdwcPMPM14hjVMV857y
 jnXV8ecRKFVNVuowzhGaq7uEFfTP9Ep8atag/Uv11SAx40zYZJ6Q2eXbOFdoVF4D+pn+2bDrn
 zZh71oPe8cDelo1E9fQnNXyBfhxrrlMHLGKqleuguX7Kl2h+xUgjjHSrY26ALzOLgF50G+v9T
 bb65D/Hk8Dk+/7NO4dUyvAxGlhwlFBJo2fqcQ9/0dpW5L1S1e0Gp8N9V9OGMQOA/MVMf450pM
 DnBznc1X15jHrffpRVES4fMHfA2zS+UjHIyC2AhWa9ceuuBAlNnf1gQedd7n9Dn9SBiiogTBv
 EXKWVMTLjLuB65YT/fsfghne9BL5b1Hpf8SUoGI4Dq+PI=
X-Mailman-Approved-At: Wed, 15 May 2024 02:28:00 +0200
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
 doc/usage/netconsole.rst | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
index 2aa3b9ccc5..0c983e6970 100644
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
+	=3D> env set autoload no
+	=3D> env set hostname "u-boot"
+	=3D> env set bootdelay 5
+	=3D> env set nc 'dhcp; env set stdout nc; env set stdin nc'
+	=3D> env set ncip 192.168.1.1
+	=3D> env set preboot "${preboot}; run nc;"
+	=3D> env save
+	=3D> reset
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

