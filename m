Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC17110AB825
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 20:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE5681E18;
	Thu, 26 Mar 2026 21:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TCs1r1+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBFC838BB; Thu, 26 Mar 2026 21:40:07 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1424080517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 21:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-673ee2a98b1so816372eaf.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774557602; x=1775162402;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oqk6CsKtaPl0De8iZAYsRePyHANYoDGV/OKyqT0+R7Q=;
 b=TCs1r1+MTJV8u3okfUHfB7pgjs2yfOCXHvMZCpREX/9f01uUcxl3tWH1RbE8GSehho
 +VId61qYdlPBhiJ5q5P3IW0LCYf1NPYCCff4JfQ54bXtT4bm6Z/nkJbOfIHJAuc837ze
 Y8L1Wn0T+mVSZyDJ2mb5I6QK3CjtB/6oCFoLN2WHW2mc7DBvkxG42oQLJ62NdvVFJGMl
 aIgECcr2AmzczFOUazx3AtJjqeYrDuTtQ+9vbCd3NINSHzx4/E955umHFgIbZFWL3zUq
 fmKqtn5sSTQIPtbaYfxdXjl0iVdzmrMQ2H4eTtGXIW8vTi93MHeBoulomAtnVcFUH4cZ
 tzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774557602; x=1775162402;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oqk6CsKtaPl0De8iZAYsRePyHANYoDGV/OKyqT0+R7Q=;
 b=l45Nwc3L+8jEMD8kBRY2RAtDirSWF+V5yYJTIuFu5z61mDm9LbooU6RjEV5JGTqnvz
 G72o4n/EXN4wQhdgNs82dOJ3jjZNH4mQtZmBkPBmGjJVm1qCekeEv6jKXH5r2sx7FubA
 +DI4gQ/qxizBwr1ORlU2FErPULa1cHL/Z1tUt9VaGbJjV2dCTYINeWIctLXR3iXpypsr
 Jo7UNNhLGun/LAxO08rbNCJyW9bmN5Ci6a1VQC1bBgKtq6ghF7becF5uD1MyJtEqcY/s
 G57YSLhD8SSfBzDZz5rLBNuQFGZNHeA3Vbv127y3Q+HRZzPPMhtJXoon/DJQyvDYn9qM
 h/9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYVEMz4UwGF3ypFOV4YBSceU9AqOQPUcDKp/Dnez4IHkirmdXjlvf/SotYSTrxQCET+cLGrvY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywzzghnjg1EdW++FyNsPyyflOuBhDeVUkrDRbsnmi/25mlg5J/4
 A+TrEVjmq7z9o42bN1LapGNQG2hFgswgsrDWzDQP45AMKVTwih8YyfzpS8NejbnOPrpWKB3cHIg
 Ocn9F
X-Gm-Gg: ATEYQzwbeullOxKJ0gcgN5+0L7AjfKsAyity80zv3e3BGthf6yVXp3V2ULuYw0Klywp
 NL6F9Ux/iqIC7nifsqr1Niy7NCGDM8qLvVHoKA8BJU+QU7xGMW1XjySmBKXE41BAEZyCaEBgrtL
 d0uTD/PL8aA6lTPpMyU6Hk8I6qgawSQe7dRucOLvGI3K+UYRZy4Vvb+eUDbERQUPiuvY1LISJeW
 f9HiBQCKRJ+nlcp6vV1AyCz84gDM86ThhxxmcOVUm1ZmlxVNuMnWtn/7Z5oksTD7+C5ZnyBE0a8
 CTW9sXZbe8adgrx85BMU6Dj7MX0Ab0cAVVdSeTmmQ3R7UrLfa1uXcSTY3XDMX2H8Bq/PzypKN+2
 6v5P90pxBrKHgMmY/6U85/UMFtY2PjRiUPlVPul2zoFTE4ZXsZZ4RfmhosZoy3LlvU3Tmz6xpka
 WFA2dc+paUIumEmQfB1OxNptt/0byS
X-Received: by 2002:a05:6820:1344:b0:67d:f88f:d853 with SMTP id
 006d021491bc7-67e185f6571mr56199eaf.6.1774557602108; 
 Thu, 26 Mar 2026 13:40:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:5200:5612:f63e:1681])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67e0aaf8185sm2539014eaf.11.2026.03.26.13.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 13:40:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 26 Mar 2026 15:39:52 -0500
Subject: [PATCH] cmd/scsi: drop scsi reset command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-cmd-scsi-drop-reset-v1-1-01956d061acc@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAxA0atI1g3oiCP2KqWLTiZqhKokWgTx7
 k51+Rb/72CswgbPbAfln5hMY0LxyID6z9gxSkwGlzufl84jfSMamWDUaUZl4wULX1eh8jW52EA
 qZ+VWtuv6et+2NQxMy38Fx3ECXqSBxncAAAA=
X-Change-ID: 20260326-cmd-scsi-drop-reset-1675b567c2d9
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2631; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=qlIgHBDBALp8rpnEprF6sqVWx8IDfU0MCTX83ff5q9Y=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpxZma1P1tEBsk3Sb1KQfFIF+ry8WCd+1pn3ltK
 AOH4vQeCRaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacWZmhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1CEH/0NCqU95B/6+Ym6oHeFdPyks/rWUq5kyxIkET7f
 5KkHKjzEqy+IymSZSVXZTvrJJ4A12y/sXDBrMND22XgUwhR++equfxXBgaDUFvI+MaSX3je5isJ
 Sr5aIZeY5sGGnKcquns3LejUj0gM1HwN6csmIK3xCu2HjJeVkRbbJU0srCMmZGwoMs7pI3E3LlC
 UfpiAYOuZiaStH9h7NbEf6Np6ExF83dJLJrhdOI1yaiZuloobmirezsrDhNgdwRF6WCd/xXnNQQ
 NLG6HRIswhmm7S3EJinEF7mMmU0MdMczFRV3W3QE2WuE4T0HWif89XNPC0Rlhoef9Mo0Lo9JcK+
 aNQQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Since commit b630f8b3aefc ("scsi: Forceably finish migration to DM_SCSI")
the "scsi reset" command has no possibility of actually resetting any
SCSI controller. Drop the command to avoid confusion that the command is
actually resetting the SCSI controller.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is just something I noticed while inspecting the code. Since it
has done nothing for a couple of years, it seems likely that no one is
using it, so hopefully can just be removed. And if anyone actually is 
using it, removing it should actually make them aware there is a problem
vs. currently silently not doing what was intended. In that case,
someone who actually uses it can re-implement it properly.
---
 cmd/scsi.c                 |  8 --------
 test/py/tests/test_scsi.py | 10 ----------
 2 files changed, 18 deletions(-)

diff --git a/cmd/scsi.c b/cmd/scsi.c
index 9f7613424e5..ad7d8a4b664 100644
--- a/cmd/scsi.c
+++ b/cmd/scsi.c
@@ -31,13 +31,6 @@ static int do_scsi(struct cmd_tbl *cmdtp, int flag, int argc,
 	int ret;
 
 	if (argc == 2) {
-		if (strncmp(argv[1], "res", 3) == 0) {
-			printf("\nReset SCSI\n");
-			ret = scsi_scan(true);
-			if (ret)
-				return CMD_RET_FAILURE;
-			return ret;
-		}
 		if (strncmp(argv[1], "scan", 4) == 0) {
 			ret = scsi_scan(true);
 			if (ret)
@@ -52,7 +45,6 @@ static int do_scsi(struct cmd_tbl *cmdtp, int flag, int argc,
 U_BOOT_CMD(
 	scsi, 5, 1, do_scsi,
 	"SCSI sub-system",
-	"reset - reset SCSI controller\n"
 	"scsi info  - show available SCSI devices\n"
 	"scsi scan  - (re-)scan SCSI bus\n"
 	"scsi device [dev] - show or set current device\n"
diff --git a/test/py/tests/test_scsi.py b/test/py/tests/test_scsi.py
index 2a35e47e558..4390ff65845 100644
--- a/test/py/tests/test_scsi.py
+++ b/test/py/tests/test_scsi.py
@@ -38,16 +38,6 @@ def scsi_setup(ubman):
 
     return dev_num, dev_type, dev_size
 
-@pytest.mark.buildconfigspec('cmd_scsi')
-def test_scsi_reset(ubman):
-    dev_num, dev_type, dev_size = scsi_setup(ubman)
-    output = ubman.run_command('scsi reset')
-    assert f'Device {dev_num}:' in output
-    assert f'Type: {dev_type}' in output
-    assert f'Capacity: {dev_size}' in output
-    output = ubman.run_command('echo $?')
-    assert output.endswith('0')
-
 @pytest.mark.buildconfigspec('cmd_scsi')
 def test_scsi_info(ubman):
     dev_num, dev_type, dev_size = scsi_setup(ubman)

---
base-commit: 80a4c49a4ab2ad06fa84a8b7bdf6e33b3b5101bf
change-id: 20260326-cmd-scsi-drop-reset-1675b567c2d9

Best regards,
--  
David Lechner <dlechner@baylibre.com>

