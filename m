Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62016C25B78
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 00:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A37881D6;
	Wed, 15 May 2024 02:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="gEjZJkHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED7C880A7; Tue, 14 May 2024 22:21:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF9F8717A
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 22:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715718077; x=1716322877; i=fiona.klute@gmx.de;
 bh=mc7M0U2AJGXlOeokSWVtO8gBV4HbmqeScC8sDNcWwkM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gEjZJkHQZXbQd/otw4TC0M0u3SrQFp6oybe5P/1j3ZzQrnI6Y0Yw2TjLIgMBVVaK
 iiE0XsfRev2lXqST+OjWOvSg+zVB74Pz5ajaSs4y/WPAoTDbER0ZTnK525Ek0ump9
 fG3iDfVPBT/TIKr6GvznLLn4JSKYNJrvodvQAAUCuT7X2xCkgS+m3kC9V3sQMl/K7
 4hRdjbz0uaK4KF/Daj4SQO5Yf4NtIahg+ZlcExAIC9TybTmbhigJ+cC1EtjOqm9kO
 o7ISPyx4FS6CGORPwtPUrbvfusbcaObIPyh/6EcuaUAyJ7cgO1kb/eji3SYmpgPxI
 XMD5l29214p03Cg4Aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.125.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwwZX-1sUAOV2oPL-00yUFW; Tue, 14
 May 2024 22:21:16 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH 2/2] doc: Update netconsole examples
Date: Tue, 14 May 2024 22:20:41 +0200
Message-ID: <20240514202041.386027-2-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240514202041.386027-1-fiona.klute@gmx.de>
References: <20240514202041.386027-1-fiona.klute@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mzwb0yKXdZbVHWu1PXcvfUELGjkJ48/64qcwGTomxjuC2HPrAPz
 xAgvoGZ87VojIlDqdPaaZO/TQTwfFgk68G0kOj7uNUbIhmR9/6O4LsDPfJTDWmH6IGwok5z
 CmLk9I83UkQNm8o78kRd3ARweFXjKxMjMvBSKHIEtLmZHvePhR43ERx927UTeYWVb1OY/+V
 uz5L9p5HOrWMVkQGoVnBA==
UI-OutboundReport: notjunk:1;M01:P0:dQMw41TBBZs=;VmkhcXp/BneCxPEAiYTf6rLVnCI
 hB7g3ERWUTZM3gebysBg9oniw6frRVG4esMJXG3gMhjPARXu0tM3HBJDM08/g0cTKS5CNGDfP
 MSRewRajGE9vZHdciTbPWoaAvpzRCsTl17f5GVjJEIN7zTsOxm+hqfW/seuUM2la3nZrgj/ff
 RT7JV+51xTNM6Trx7bvcajWFjo6EFFfjf63whPsSdinTiXXJce4mgmXIX4B0X/rag7jqnVzDs
 HEmfchqLX8LE8m94E8BwoniB2dD6ApEbDU3ev65ajqpDZbWQUS1Wszx4iACzsmVqzyA0gQVqV
 +TTPZ9MtG8unmuwr2i+8bmF2sunXqe+12Y1w/Sy3H/MEXnkOgCik3DDP4haG6Ku6/M56iH1Fy
 Mn5uHvM4wnbplcjirxew5jWQuSZDdvOk9R7ko3NCsKX8wguj0sBP8BEeotqHcANj95OKNgrUd
 uKvwMN/DV+/0MobM/8ZW3/likVKxNT1CcVVO/Da6qTsouFrvHfWT/8F84eUtLHI50mblYcz9v
 4sc4jdv/gUPPPQKrHewrp2l1FI6zBrBh8ZKNml9QtGkuAQuSSP5e5CdGYZP2mHJJWwsIKbZX4
 a8r2Oi21urncr66ItcUx0/bwQELkxoY82BgfHWykSdvTCUJHwqFFsdDsVZ7jsHAMvPz5yfaxI
 J4lum7epLzyjpB4RfTHIhp11P2FR3M/G1Bp7UC+rWSLkBn9wdCYR78o1CN9ZDOnudXLONTX8+
 JXa9VteFrZk+Gu04NNl8QDWjf4iIX7PqvWXyNT+l/Yh7uzXqhhGkOHJ1bi8HfHWX6/Syf5rKJ
 CN22d1Y8PUmp5kAx/bbCLKzYxjHAiXb+uzyjmi6kBQtJ4=
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

As I understand the env command documentation the subcommand style is
preferred, though the old format is still fully supported.

Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 doc/usage/netconsole.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
index 0c983e6970..b5832843f3 100644
=2D-- a/doc/usage/netconsole.rst
+++ b/doc/usage/netconsole.rst
@@ -24,9 +24,9 @@ can be used for network console.

 For example, if your server IP is 192.168.1.1, you could use::

-	=3D> setenv nc 'setenv stdout nc;setenv stdin nc'
-	=3D> setenv ncip 192.168.1.1
-	=3D> saveenv
+	=3D> env set nc 'env set stdout nc; env set stdin nc'
+	=3D> env set ncip 192.168.1.1
+	=3D> env save
 	=3D> run nc

 On the host side, please use this script to access the console
=2D-
2.43.0

