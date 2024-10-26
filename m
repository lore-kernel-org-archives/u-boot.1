Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE21D10C01
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 18:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA7C588D94;
	Sat, 26 Oct 2024 20:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="YS29LpBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4503188D94; Sat, 26 Oct 2024 20:07:01 +0200 (CEST)
Received: from smtp6.goneo.de (smtp6.goneo.de [IPv6:2001:1640:5::8:31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19D5688D70
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 20:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id B602024089F;
 Sat, 26 Oct 2024 20:06:54 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id 9DFC0240569;
 Sat, 26 Oct 2024 20:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1729966012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YpINJllwe7J+fVByCyQiOJlCt9RGalj2HqQTIjM2+xU=;
 b=YS29LpBoWoVD2DI8KkbqnldvmiSf+tqIyavLbSQ4XXHurqsbsSgQdU2WkuK0XOvabI3Ska
 5TLyCOz0j4cN+Q/YKsQ5MYi9SviEYWdwK8CH3gCTbu8C8VDk66CG1exZEcEcz7Qgv0zg6L
 Un6oZAHFUU6rkHGA1IfOtxDUFKGBLA5O31x9/GfCaWw06vec+sT772D+4A+W+xl4esnWnT
 6tqRKuiMPBmjvUQVaLFnpjNpL4tMvQGWdmSLIkVY8M38OCpXNGHm0GJsQZhqDLVPUgfXXq
 8z+KZVQi/ade3SwVS0yB12LqNAxB+vBpLWtVR2odB0j/tUrL5I9pgXAEtV6Zfg==
Received: from p200300cbef0f7d100000000000000193.dip0.t-ipconnect.de
 (p200300cbef0f7d100000000000000193.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef0f:7d10::193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id 5090C240560;
 Sat, 26 Oct 2024 20:06:52 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
Date: Sat, 26 Oct 2024 20:06:44 +0200
Subject: [PATCH v2] scsi: fix disk capacity too small by one sector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-fix-scsi-disksize-v2-1-bc6be9a6043d@devpi.de>
X-B4-Tracking: v=1; b=H4sIALMvHWcC/32NQQ6CMBBFr0Jm7ZgWS7CuvIdhUTqDTEyAdEyjE
 u5u5QAu38//76+gnIQVLtUKibOozFOB+lBBHMN0ZxQqDLWpnTXW4SAv1KiCJPpQ+TBSewrGtjH
 Q4KDslsSltDtvXeFR9Dmn936R7S/9Z8sWLRqm3vvG983ZXInzIkdi6LZt+wLrF7ppsQAAAA==
X-Change-ID: 20241014-fix-scsi-disksize-d73a017cadf4
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Julius Lehmann <lehmanju@devpi.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2465; i=lehmanju@devpi.de;
 h=from:subject:message-id; bh=bhxjrggtUu74DDAeRUtT13/xsH4epq3rS/NzuN5sn8A=;
 b=owEBbQKS/ZANAwAKARK2S7xC0EEDAcsmYgBnHS+8cv5AiTKfJvDiODYBJY6QfyWEOwXYnc/qy
 aK+vfLIA/OJAjMEAAEKAB0WIQTCqoxFzEvlxm0XalUStku8QtBBAwUCZx0vvAAKCRAStku8QtBB
 A7kvD/9qZTNp5KDdutYkYOTV70a41xcDosjkBK+siauMZu/sd/zIgorE1JOElv12faLJfnlDPFx
 SQTnUne3qtvu2AmHt3F4CsjgnZNhzbV4ugTsOczo6Emgz6iifwt868eiRI+VWSzQgMB1wQ7vrvv
 x8N9w5E7lFiqfQW7SfdhciQWj397Ufo5TAIFpQrKtnDsug4niCxzULBmHxuciBOrkjdSbzSxyp6
 pwJAkIfrDZukCYlrjxG/DcKylaPVmsxfkpO2hOGKB+MbQhRKF4DaN4w+EU8G0s5zIzjE/NIhxWk
 a006xxhKJySoj73DpVtS03/xkrG8I+h4fkRviHpPEFwlziFwbrlkilICcMwxZc4ZEeU5prch03W
 +nwVOZFcUPYThYrtNpN3CZZbKrOmLekdv3z433wgbd96qhoxpNcansUuvGkZSWwRnRSFioDyvcH
 0MQYIZ5LxLcqv0z+RoOb805/PNpzPvivyLs4rtjgIjbs1GMWXvmwwShP96YcAbIIgvOhFJI/FzU
 OAfRgADEw5+MQnB9l8ifNp3Dq8UUHCmH3oATTQGMD6FCKPTyPpfBJCh/MOMxUORKuhH/K9wBcmb
 Z5VXCgmpfbn7R6XQSlfAh4jqCFE9FLWGGTEN/dgRZLHH+wn3nvShLqN0DoKI3wEqJKeVC5XVDAV
 i8Q8eR/v8Jaegkw==
X-Developer-Key: i=lehmanju@devpi.de; a=openpgp;
 fpr=C2AA8C45CC4BE5C66D176A5512B64BBC42D04103
X-Rspamd-UID: fbe3fd
X-Rspamd-UID: 039e83
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

SCSI READ CAPACITY reports the address of the last block and the block
size. The total number of blocks is thus last block address plus one.

This also fixes the corresponding test case.

---
This patch fixes the disk size reported by scsi. Up until now, the reported disk size is too small by one sector. Read/Write operations on other sectors have not been affected. Trying to partition scsi backed storage via ums has resulted in "storage too small" errors.

doc: https://linux.die.net/man/8/sg_readcap

Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
---
Changes in v2:
- fixed corresponding test case
- Link to v1: https://lore.kernel.org/r/20241014-fix-scsi-disksize-v1-1-0edb9959b580@devpi.de
---
 drivers/scsi/scsi.c | 2 ++
 test/boot/bootdev.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 51cacf3479236be6c6ea3e7d15b87e03f10e7f3a..bcdeda95ed1514119057cc67974fec465cf5672c 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -309,6 +309,7 @@ static int scsi_read_capacity(struct udevice *dev, struct scsi_cmd *pccb,
 			 ((unsigned long)pccb->pdata[5] << 16) |
 			 ((unsigned long)pccb->pdata[6] << 8)  |
 			 ((unsigned long)pccb->pdata[7]);
+		*capacity += 1;
 		return 0;
 	}
 
@@ -332,6 +333,7 @@ static int scsi_read_capacity(struct udevice *dev, struct scsi_cmd *pccb,
 		    ((uint64_t)pccb->pdata[5] << 16) |
 		    ((uint64_t)pccb->pdata[6] << 8)  |
 		    ((uint64_t)pccb->pdata[7]);
+	*capacity += 1;
 
 	*blksz = ((uint64_t)pccb->pdata[8]  << 56) |
 		 ((uint64_t)pccb->pdata[9]  << 48) |
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index c635d06ec25d4bf274099f153648d34f5a845436..bc632a3d14124f5f821c4625e5b29b7d352f7161 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -621,7 +621,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 	ut_assertok(bootdev_next_label(&iter, &dev, &mflags));
 	ut_assert_nextline("scanning bus for devices...");
 	ut_assert_skip_to_line(
-		"            Capacity: 1.9 MB = 0.0 GB (4095 x 512)");
+		"            Capacity: 2.0 MB = 0.0 GB (4096 x 512)");
 	ut_assert_console_end();
 	ut_assertnonnull(dev);
 	ut_asserteq_str("scsi.id0lun0.bootdev", dev->name);

---
base-commit: 29e5dbc55c64c6450f066c55a5bc48bd1717aa1b
change-id: 20241014-fix-scsi-disksize-d73a017cadf4

Best regards,
-- 
Julius Lehmann <lehmanju@devpi.de>

