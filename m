Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE168C79F9E
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 20:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 850B94059E;
	Sun,  6 Sep 2026 20:02:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zSvjQOm7Gjrm; Sun,  6 Sep 2026 20:02:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7440040589
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788724936;
	b=Xu5DbUaiOfuKPR1j1Tk6uQKVnVcNs+ScZoO5+YEm6aloG4z4JrRLqLcabhuty+0WuwSK
	 FhuCDnCp9Su/EjPXbygivzs1mI1hlV0JT9oa60OvYRVTR5eIJnKp8wFW7E2JhHqMhDJ4Q
	 InkBwViQO/2s/wiVM8nOSTOgppOu8Fs87i7ooDi/ji41MHMkQE6lPHvycHAFTP6xXRunR
	 Uo3Ftp89gawfAJtfRChpowrbpNCynu86jiImo00eYAnT8SWVF8BOM6FDLHAUYlsadamDy
	 VWW012E7ripfhWw+Zi+hw0DNSlf4K3bbkO/GUdwqjxmeGJuDGeBLZ8MqqTJVc2sEg9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788724936;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wwMEoaxJPHQuhKDtcewvLaRN7l8YI622bb8k9xNWH2U=;
	b=nhRmCNsmjkhh4ZontljeASfLJ2SpqMB1jtqgRRS6tZJV3A6zfeuoqwnOEvxdXrpoBXHO
	 AGQ0tDULXoT3J1BZbLNVKLWJqHENeawFEWBhO55z6oLXR73fLoCZqULdQH6WJRYGZ5LNu
	 KOf7l8wMAX7WPZFezTlR81dnglx3P4lhk7MqucDqEjmqefvVLQ13hkCp/vT1jYUtoZ6Z4
	 X98TaDO9TKGHCQC4+fBpdctfzhn/ml4VTiEcNBnMpFxjNTWfK+gTL9yQ7t8QRdrRnoZgf
	 OH7gbtwMOSQXGGw75/yWLdRfppcQZIJ/qWc2iSMlPCTl+SFB1NinIuF++KA8bRPFwaw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788724936;
	bh=wwMEoaxJPHQuhKDtcewvLaRN7l8YI622bb8k9xNWH2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m8cKtM8q5WFjdL7G2bpUoCax+FuOvPIaE26q1GWojjws+9o00o+SrvtWw9aKbYo8c
	 rRsJMb9iJgYZYawxP6USNPPxzJPKTniRstYM4PrvUkXGnasEwVGUVDPVuMV+UcntZg
	 yKcqyBkPYxR97g10FDYrbRz09ll/GLJ5Sd6JZfJVw6+q8oNOEb7+aQfKvLJJg69Von
	 i4q9F4kE814+Og6V5AhpnjOw84Axqqis2vYNVPMFzyS7lXaERNKdp8jo06F4F3Sa1u
	 17G/ydwt56K8SShb0QmC5rQnVtfbuIVuho1hOQZDNdWtg+48/xretpyib6KSU6k9Xt
	 sf/xdz0ze97ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7440040589;
	Sun,  6 Sep 2026 20:02:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5C1272C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9749A60608
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:02:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5B8mxZAAarCX for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 20:02:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8CC27605DE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788724933;
 b=PGL5tGN300pN8V1Jxyiyni/ccktLetBo12DiniK+Uh8qgkDTKtGkDmnK6+nhCargTctj
 32XobCfQZ/YgSX3UFllNyHG/u0oLElaJkBJTN0IDbbq33Dhg7VJ6u1qrQ2jBXYX5bMJrr
 99cWxkJOVtpY3ka7v9Cg7N9Rs/rMgHm5bLmKbOj6nQ7EBC7WvNhH7iI1wkYJ8f2Qwec1a
 POL1prnf3jfeY6VWbT8jJmPRJ6SXg7Vdagbh5+5E2BY1E5YPkPG1IxMTH/e3Wgu3QQS5l
 MN8wL4apq9b0Ds+Vu+C7RX9g46unVvCmj8blZlhHXCPNjWKUeEmb73N5vAmAO/ahHNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788724933;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=wwMEoaxJPHQuhKDtcewvLaRN7l8YI622bb8k9xNWH2U=;
 b=Tw/DGRLio4z/DQk2LasBfjFO05YOm996R++H5vzaJFsrh3BHgJDC5VnMIJrUO9fcT4Qi
 v2cODpbtm3szgurCVEgfYIhTARhJdcDnTa4g1yBXVpyMUQfj9UU/xVlthOtxw1ZYOH9Ld
 GBbyMPFVIRSaID2JsIbdMJ2nzONxAlZVwvGouAedKbQvGwyiM4fPPh6qR+ztJGxN/+DXg
 cE7GtXne7WsJPfjQgLhwUy7pyAJ2Kp94eZCA9FNYu9aH8heMPx/pg/iFlqCkUoXityn5n
 MDFEutYob6yNcpLMOJVSoMb5+Sbrh0VzXNqOKjaASnms2CTJ3Nz/0rxwAvomzzkc/6A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=f0XNy7Lx; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=f0XNy7Lx
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8CC27605DE
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:02:12 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso29672865e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788724930; x=1789329730;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wwMEoaxJPHQuhKDtcewvLaRN7l8YI622bb8k9xNWH2U=;
 b=f0XNy7LxFjk/1rvEjg2oXnlCzYZNkNec2HljlyyDFFEIjbW7qvlJ4cGdQVmWY6OWJq
 nWxSkj5Vz+5+On3NztalIduMTcY8iFnSQIuq2bkf9KA60XsYmDj3g4sGJ148GrzKn/2a
 1oW2KLsW0/97IzYVuR3jmJtmrvfCTu8W5MJxYFdCj6JS1MuQCu1/E3t5fNLLh4y1UsxV
 OpsZ9ZP4tGapocPQLam91JGZMsYwgRCUf+zU/Q21wsPgFEySf0IUi1+/K4AHxXRATgDe
 IlGmejJpOMx21Uqml473bKbgxBA0opx5WejQWczS9ZNdu0tE/dA5pVfPxdTggzVrLPn6
 aPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788724930; x=1789329730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wwMEoaxJPHQuhKDtcewvLaRN7l8YI622bb8k9xNWH2U=;
 b=ZeAZyxRF4PKy7MMZiNhMbPrZ4NKBr84K51VaxgVB9YirXuFc2AzkIznsqsmjuflxxZ
 ZZjdSEyMSo9fsl1HVzv3deBj8fwnArZUh/cfGI5sHHbBzFzuI1zDyV27R2lLp5kOcdOe
 49DKP48Tcggn1C7Hgnkx1wxirusVGkiBzvuhXiX3eK6JiEcI4Z9eQDkgInjgv0/5qZvu
 yM6rcjxzf2gMidBglZ4ixcFZ8S4JXfr4WLA+icMdt/eUPRzVpkYIsOp5wSNwsKJ+P5fg
 TDzYl15Tdn7ZnL0pccS2L863tFAyagxs6D7JBaAKvRqY+vBsSi8qs4jA9pQBvHunGHxb
 UQPw==
X-Gm-Message-State: AFuF++nTRWiI7U5vdZ6/Xoex8dZ02gZfO33TIn7/VotPjemufDV/KgxU
 aQuqWOtRVr9QUBQRgalR4pk4G+/CppwL7PrcE/UPHDyN3R9iDj7sS6mNsA0zYCwpRPQ=
X-Gm-Gg: AYBFou2oYCCEsSkGF6xJhmwM7xirj+7KRPjKSbIVJ8y4bRgwxP+HH8Y73l5KZ5a0EnO
 gT3UI+BjU2xDXk5pORdGqqMrsZq2soWqQPAC9CjXAssSkVt1dUOB2181FwMk20AcOCnfZBXegCb
 /mJv8m7WdoQS1yxK+xVjlkPwud+xnQe2a6hKoUQzYIXI9AhGISz2gkwaFemNMR2zCTFv+fkbfbp
 TFMZlgWW4BRzUw8tkngB8FMT2vjEL44mg0+laEjTTSZiGQFqLBarL0ICO7oZawBd4TwEy9c1+bP
 GbEwUWCmk3oktBUF5URGHJW3DGAYKAkDfOdkNIv4EeWUiSKrr16vq0s6XqQLwfFABkeiV0uTRv3
 VhYmrIKfvd9GuZnIWEcrrwA5xgw33+0d9OO1GanApMqVLCVHnH32CRlgzQ3H1FaK1RAiGQLWNUs
 1FvTYlq6uVBPXY/JX6CHsr3f8Io1DHVAjDQIc1IsZ2IP554kvs77daaeqV+hXv4M0R/YDwgaqRO
 Dg6NHWk+BxnWXdHiFDJrsoR+kDYEAVzbwsu/YpK65HolLNCzBAQ
X-Received: by 2002:a05:600c:4712:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-49cf8248cd3mr308713255e9.13.1788724930090; 
 Sun, 06 Sep 2026 13:02:10 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bfdf6sm24592173f8f.34.2026.09.06.13.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 13:02:09 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 06 Sep 2026 22:01:59 +0200
Subject: [PATCH v5 1/5] fastboot: factor out the USB session runner
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ccaione-upstream-spl-fastboot-v5-1-023516e77321@baylibre.com>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The fastboot command currently owns USB gadget setup, protocol
initialization, the service loop and teardown. This prevents callers
which do not use the command line from starting USB fastboot without
duplicating the same session lifecycle.

Move that lifecycle into fastboot_usb_run() and leave cmd/fastboot.c
responsible only for argument parsing and transport selection.
Initialize network sessions in their transport path so their existing
behavior is preserved.

Keep the command-line diagnostics for a missing USB cable. The helper
returns -ENODEV in that case, which the command maps to its existing
failure result. Unregister the gadget before releasing the UDC so no
registered function remains attached to a released controller.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/fastboot.c            | 53 ++++---------------------------------
 drivers/fastboot/Makefile |  1 +
 drivers/fastboot/fb_usb.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 include/fastboot.h        | 10 +++++++
 4 files changed, 82 insertions(+), 48 deletions(-)

diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index f3929f88dfa..ace877b6e28 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -7,12 +7,9 @@
  * Rob Herring <robh@kernel.org>
  */
 #include <command.h>
-#include <console.h>
-#include <g_dnl.h>
 #include <fastboot.h>
 #include <net.h>
-#include <usb.h>
-#include <watchdog.h>
+#include <vsprintf.h>
 #include <linux/printk.h>
 #include <linux/stringify.h>
 
@@ -27,6 +24,7 @@ static int do_fastboot_udp(int argc, char *const argv[],
 		return CMD_RET_FAILURE;
 	}
 
+	fastboot_init((void *)buf_addr, buf_size);
 	err = net_loop(FASTBOOT_UDP);
 
 	if (err < 0) {
@@ -47,6 +45,7 @@ static int do_fastboot_tcp(int argc, char *const argv[],
 		return CMD_RET_FAILURE;
 	}
 
+	fastboot_init((void *)buf_addr, buf_size);
 	err = net_loop(FASTBOOT_TCP);
 
 	if (err < 0) {
@@ -63,7 +62,6 @@ static int do_fastboot_usb(int argc, char *const argv[],
 {
 	int controller_index;
 	char *usb_controller;
-	struct udevice *udc;
 	char *endp;
 	int ret;
 
@@ -82,48 +80,9 @@ static int do_fastboot_usb(int argc, char *const argv[],
 		return CMD_RET_FAILURE;
 	}
 
-	ret = udc_device_get_by_index(controller_index, &udc);
-	if (ret) {
-		pr_err("USB init failed: %d\n", ret);
-		return CMD_RET_FAILURE;
-	}
-
-	g_dnl_clear_detach();
-	ret = g_dnl_register("usb_dnl_fastboot");
-	if (ret)
-		return ret;
-
-	if (!g_dnl_board_usb_cable_connected()) {
-		puts("\rUSB cable not detected.\n" \
-		     "Command exit.\n");
-		ret = CMD_RET_FAILURE;
-		goto exit;
-	}
+	ret = fastboot_usb_run(controller_index, (void *)buf_addr, buf_size);
 
-	while (1) {
-		if (g_dnl_detach())
-			break;
-		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
-			if (tstc()) {
-				getchar();
-				puts("\rOperation aborted.\n");
-				break;
-			}
-		} else if (ctrlc()) {
-			break;
-		}
-		schedule();
-		dm_usb_gadget_handle_interrupts(udc);
-	}
-
-	ret = CMD_RET_SUCCESS;
-
-exit:
-	udc_device_put(udc);
-	g_dnl_unregister();
-	g_dnl_clear_detach();
-
-	return ret;
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 }
 
 static int do_fastboot(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -167,8 +126,6 @@ NXTARG:
 		return CMD_RET_USAGE;
 	}
 
-	fastboot_init((void *)buf_addr, buf_size);
-
 #if CONFIG_IS_ENABLED(NET_LEGACY)
 	if (!strcmp(argv[1], "udp"))
 		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index a341af076d1..32e8e072c88 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -3,6 +3,7 @@
 obj-y += fb_common.o
 obj-y += fb_getvar.o
 obj-y += fb_command.o
+obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += fb_usb.o
 obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
 # MMC reuses block implementation
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
diff --git a/drivers/fastboot/fb_usb.c b/drivers/fastboot/fb_usb.c
new file mode 100644
index 00000000000..5c62bf42e72
--- /dev/null
+++ b/drivers/fastboot/fb_usb.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 BayLibre SAS
+ *
+ * Copyright 2008 - 2009 Windriver, <www.windriver.com>
+ * Author: Tom Rix <Tom.Rix@windriver.com>
+ *
+ * (C) Copyright 2014 Linaro, Ltd.
+ * Rob Herring <robh@kernel.org>
+ */
+
+#include <console.h>
+#include <fastboot.h>
+#include <g_dnl.h>
+#include <usb.h>
+#include <u-boot/schedule.h>
+#include <linux/errno.h>
+#include <linux/printk.h>
+
+int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size)
+{
+	struct udevice *udc;
+	int ret;
+
+	ret = udc_device_get_by_index(controller_index, &udc);
+	if (ret) {
+		pr_err("USB init failed: %d\n", ret);
+		return ret;
+	}
+
+	fastboot_init(buf_addr, buf_size);
+	g_dnl_clear_detach();
+
+	ret = g_dnl_register("usb_dnl_fastboot");
+	if (ret)
+		goto err_put;
+
+	if (!g_dnl_board_usb_cable_connected()) {
+		puts("\rUSB cable not detected.\n"
+		     "Command exit.\n");
+		ret = -ENODEV;
+		goto err_unregister;
+	}
+
+	while (!g_dnl_detach()) {
+		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
+			if (tstc()) {
+				getchar();
+				puts("\rOperation aborted.\n");
+				break;
+			}
+		} else if (ctrlc()) {
+			break;
+		}
+		schedule();
+		dm_usb_gadget_handle_interrupts(udc);
+	}
+
+err_unregister:
+	g_dnl_unregister();
+	g_dnl_clear_detach();
+err_put:
+	udc_device_put(udc);
+
+	return ret;
+}
diff --git a/include/fastboot.h b/include/fastboot.h
index b106d617749..f02d2559f2b 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -125,6 +125,16 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg));
  */
 void fastboot_init(void *buf_addr, u32 buf_size);
 
+/**
+ * fastboot_usb_run() - run a USB fastboot session
+ *
+ * @controller_index: USB gadget controller index
+ * @buf_addr: Pointer to download buffer, or NULL for default
+ * @buf_size: Size of download buffer, or zero for default
+ * Return: 0 on success, or a negative error code
+ */
+int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size);
+
 /**
  * fastboot_boot() - Execute fastboot boot command
  *

-- 
2.55.0

