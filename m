Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5783C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF90B86518;
	Tue, 29 Aug 2023 00:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A65F864FA; Tue, 29 Aug 2023 00:02:12 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FCCB864A6
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
Received: from toolbox.int.toradex.com ([84.226.64.168]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MxE9c-1pmKVU23Bo-00xaCl; Tue, 29 Aug 2023 00:02:00 +0200
From: Marcel Ziswiler <marcel@ziswiler.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH v1 2/2] doc: board: toradex: verdin-am62: document update
 u-boot wrapper
Date: Tue, 29 Aug 2023 00:01:54 +0200
Message-Id: <20230828220154.483362-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230828220154.483362-1-marcel@ziswiler.com>
References: <20230828220154.483362-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dzqqvSkdNsPHjC70DOVW+lWG5aiFxTglj2lSEgb2XWQTQA92cWH
 652xcbFwLnhH8aXijWs3IyPwNpOuSF+50l00IYdT2yK0br4QlTf42YU9tVzGz38Y321n9es
 famTCt+yq26sMa7+9Oq3SNCJGGmAMptxhJyGlhZOsux7zWvuEXLNnt1/8ywwe4HI+BJfvC4
 1xmLGbeItaeisxibs/3xA==
UI-OutboundReport: notjunk:1;M01:P0:ah1NRcinNZI=;ThON2JtAl4NrtwXFL0X18yD3L9k
 Ds58alqQUU6fkZX4+UdwWqe+1v+kPpHowG78J3OPzwdVGKP4P8t18pK+rYGQkEPhFyCziM4u/
 Mkbp4/5aBUGRCyNWopP1XgJwtrOdMEg2c+t79RCShUtnFfY/H7imKYxspNUCyQ6xTmqMFSPvU
 7/TzJE8i9tSem3whZIvBVBQcs4q7H290cDjmyrfNmjBsaANgglQFoQamCU7UWpUxrXQop5exJ
 RGbsEDbrs/sECnWD0tKeIEi0m54KMOWCDir2zi7eArd0aLIml+OxLNnImPWfBjzZG9JpgaPNI
 v46bNxKuaakfcPUoYiHWwtbmbvXxbEiPYtFqajj272cY9YbScL+cs6hz7eMi+5BWfY2jTEa1+
 e0wQVq4xvkAHEl7soYu+RC4LwE2Bn8np2o5LOQi68xp/qC8hAlECczXr+sE8/D0CyBBFxV3gL
 3YbxW6T+DYX3IabiifA8tmOpbY3BaAJ7dpyZlIRkWHZ0G2iwjKK6tKtcEO0dbOD2zs2mCV4wm
 3jLYeyflPVYMOZdtsSu+vC+SE5TPc1zce0wOjMS9/H1Inal7IBBwH58aLhoV6XxtY9SleLFR4
 b1Amn0zKCRGNKToMLW/Px4PxinBI4rjsWn0iYD3oNaMn+7LuJNCyDvaNj1/ULMZsxfL3VW6MZ
 T2Ue90+ggosf8RNeGoFkx+ygmHPnTA3jo4dQYM65PtDP8DldexC2PyIsy3T1KUlFzI1929pfd
 jwsVBjxeBF020TfS+Axc4JLv21dlPQPROl+Ih+6p/tFBWWcB2LTx05K211+FgOx6FuEV5fSTu
 02qbCdgM6kJC0gYt5+DBHxau5oiEFW+as5xuuK8TWAYycIEX8DaHqUz9Zcigf6OgDTLGuSYDJ
 e6nPGIPbXYXAqIQ==
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

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Now with the update U-Boot wrappers having been sorted out, document
their usage.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 doc/board/toradex/verdin-am62.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/board/toradex/verdin-am62.rst b/doc/board/toradex/verdin-am62.rst
index ecc7e0777cb..e8d90273288 100644
--- a/doc/board/toradex/verdin-am62.rst
+++ b/doc/board/toradex/verdin-am62.rst
@@ -74,6 +74,20 @@ Flash to eMMC
     => fatload mmc 1 ${loadaddr} u-boot.img
     => mmc write ${loadaddr} 0x1400 0x2000
 
+As a convenience, instead of having to remember all those addresses and sizes,
+one may also use the update U-Boot wrappers:
+
+.. code-block:: bash
+
+    > tftpboot ${loadaddr} tiboot3-am62x-gp-verdin.bin
+    > run update_tiboot3
+
+    > tftpboot ${loadaddr} tispl.bin
+    > run update_tispl
+
+    > tftpboot ${loadaddr} u-boot.img
+    > run update_uboot
+
 Boot
 ----
 
-- 
2.36.1

