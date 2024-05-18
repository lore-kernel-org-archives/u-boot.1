Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94617C25B75
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 15:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC0688865C;
	Sat, 18 May 2024 17:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Ke0RNYSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FBB88666; Sat, 18 May 2024 12:47:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C67988659
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 12:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716029236; x=1716634036; i=fiona.klute@gmx.de;
 bh=mPcVaDOUPW0AmWpksa1C9euURhJhsb7sX7HocmQ0MPg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Ke0RNYSbgXSYJXMbIr587qTOqFurskl/strHiYuAL8y8O7AzQdBLf5IFXTpZtzsU
 KAJfNvj37Ko8AOVVcLBCX1Q4nIYX7InXxpw2tYnXFvl98HKURquvyi1Hi9lTv7hS6
 rRQ8+yl+Snr7B6TggNE9TlqDONdFqxsxOLEoGsgyw6tKdFvglKBa7IrCuXJyhrYoF
 647EAIpZzLwHu5u06qHYB7i+DpyFatneYljQC1aEWK/uSFqkzCiLkP6PEIoB4QvEP
 VSqt8UnPK/ZpVlG6wN+JZK1DrFQD4DFtwm0EfFBOUVA3fzUyp4TVtYUata0o5fPJx
 OGqERmdRkjXLFQ28/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.125.1]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfYw-1sEvQS1xY8-00B0Yo; Sat, 18
 May 2024 12:47:16 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Fiona Klute <fiona.klute@gmx.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v3 2/2] doc: Update netconsole examples, mention stderr
Date: Sat, 18 May 2024 12:47:06 +0200
Message-ID: <20240518104706.25283-2-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518104706.25283-1-fiona.klute@gmx.de>
References: <20240518104706.25283-1-fiona.klute@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7gFKoXYicd0+CxW1jBR3D5AsXF+h8EvsqZ5zIsyxAnHbe6h2mRK
 NQiQAkkCq9Jl8XQ3ZiTWeOOwXa6WDfdLN4FEh2rz55Q/K2SXEwHj5n/9+gCnYtCgdIulfE1
 +Br1b02KCSoUqdsF8BIuVUIDq48c7/9DMIzqark10RTfSQOIhPOyDZju8W4aGI6ZmdXIrQT
 uz0GaFJi4PDfevMFnEk6w==
UI-OutboundReport: notjunk:1;M01:P0:6qoUKCPsMdU=;G8EobCJ26Dh+k8cvo9EJde/hotH
 PXF3vTw+i4k28zK8ip/mAjO6f7L+MBdF38kCftpBDP5bGd8rTrAEpPCon7AVlOBLwYVBkmRKw
 0GyYatljhmthJ9UKOqpURidnBaSqAj8ZByvY1S3m1aw2/aEQ+lonNF8g+9ckaez6D65mnTMKk
 tpCd14hsb+pg07jHXrP+FO5HtKvcX8nQWAhTAelurr7f5oBDP3624pUL5jbYdMPhHo0iSpDnH
 gLp6c8/27EVS4x513POB0H48KCk4gEU4Aa2tX+PUtYr8rzQvzFlx/tBKVXhU/ztD2cAZe8n14
 v9bKVF4NgV9mPXI2me/uzAfyCwIxzEcDMYlV2d6GgZx9GnKtd63ZKfkdutAKRTFHdlUPvFGFC
 j12vM+Qqs9Pv400gPQ3W01PddmvaghLzybULQoF4IhJYOfTBbOdyklC/DvlscGozRsWSiVqqO
 oq3oHJxEs7bLZAIKzZkWFxepLx+wxqA055Srf/Ac3QxFuM8CfRAb5aTOCWxM9H+/EZLa8bNjs
 1ADVgJLMEzhjIyei83seEdgbBtnhNEqFHaNRvB/7NUQzhF5uCJw/JxGxD4/l74ahoqSoB9mT/
 +WrJplL12c1yYot1MCpZrddAQtwWWLTqRcbVvc4ZGIMqsNnKOw8hplEWXz0RA6YJ1bGB8/W9w
 HIFQjYmcyPyrZqwN3jyHHcwx+ZmJLEjcR7OL5aXAbx0FuPEFMu2MONcs3tQ7vsYMsI4L15Loa
 mjeRflWgUHLOlleWa223/16A4K2l8AoHj1/d44FYMvcovEKBzvuTmVEGNK1Ds0o1YF7RqSm/s
 Ln2xDhFTpauEiXJ5KOsK7dlU3mfTyrT+ByCWWUWXP8VDM=
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

Stderr was missing from the initial description and example.

As I understand the env command documentation the subcommand style is
preferred, though the old format is still fully supported.

Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
Reviewed-by: Tony Dinh <mibodhi@gmail.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
Changes in v2:
* Mention stderr redirection
* Use 4 spaces instead of tabs for code block to avoid overflowing
  lines
Changes in v3:
* Use ".. prompt::" to make copying example commands easier

 doc/usage/netconsole.rst | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
index cb9a42d918..df27b78342 100644
=2D-- a/doc/usage/netconsole.rst
+++ b/doc/usage/netconsole.rst
@@ -3,10 +3,10 @@ Network console

 In U-Boot, we implemented the networked console via the standard
 "devices" mechanism, which means that you can switch between the
-serial and network input/output devices by adjusting the 'stdin' and
-'stdout' environment variables. To switch to the networked console,
-set either of these variables to "nc". Input and output can be
-switched independently.
+serial and network input/output devices by adjusting the 'stdin',
+'stdout', and 'stderr' environment variables. To switch to the
+networked console, set either of these variables to "nc". Input and
+output can be switched independently.

 The default buffer size can be overridden by setting
 CFG_NETCONSOLE_BUFFER_SIZE.
@@ -22,12 +22,14 @@ configured by setting the 'ncoutport' environment vari=
able. Note that
 you need to set up the network interface (e.g. using DHCP) before it
 can be used for network console.

-For example, if your server IP is 192.168.1.1, you could use::
+For example, if your server IP is 192.168.1.1, you could use:

-	=3D> setenv nc 'setenv stdout nc;setenv stdin nc'
-	=3D> setenv ncip 192.168.1.1
-	=3D> saveenv
-	=3D> run nc
+.. prompt:: bash =3D>
+
+    env set nc 'env set stdout nc; env set stderr nc; env set stdin nc'
+    env set ncip '192.168.1.1'
+    env save
+    run nc

 On the host side, please use this script to access the console

=2D-
2.43.0

