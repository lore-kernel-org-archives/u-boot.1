Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F46606A339
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z8/LfZz9;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QBnzA8Ko
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C24940693;
	Mon, 16 Nov 2026 14:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zaQRHxfOKqbK; Mon, 16 Nov 2026 14:01:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C05E94069A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837664;
	b=A1oOnpgvzIF5IylIEX1/lbvLdFBnWyE8RnVZeiYo6sEHEhZlWj0763QGblDTNiwlNlm/
	 KPCWJLDP/HR/WFNKQ3XddmzRpTuUn4pCNKdVg84Ycjf6FxQU4IeVm0BQtGfJpi4cbIGjR
	 vS/fj/dtnYZJ+epDRMhjaZXPAN93gWd7U5Wu1Je5PCJnrrSWMHpSe550ChGPJ26IcAny9
	 HJd8z3OPKeHi1ryc5XcSxGUtI2D55wz7XvhRrMI8JKEW/2MxU/XihR73YjagkyZMGjc8H
	 5KM15GXMEWc3N1Z85s79zR2iaYtnnLKBJmJi5b36MjH0rXg50lLO2ufo6BuNqfZt64A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FiAF9BvFmRjgEUwkbp/eNax4pZwharKY+eps4zXB1KY=;
	b=fHWifckl65n/rFhpZtlbjcUJKwc00w+YLi5BcNldqc2gXDM3Mk+0+Za/ELNxVO6JvMUy
	 IWQ0xoExL7YiFazcI5ISeZED1mmW5jYP7Kak2eIC5+Pp/qbAWZojaQXhSNXGZLWgR0yjs
	 aL1tRqW5vZcdmXJBsDgARoxfsDBplFRJ479zqRNAH0at18y3uphtRos6ndbDGGK1+Mb8w
	 AVEyu+cFVleTb2Djtm9MLQsGTKC7oi+P/YsfU+gRR/itrVzDdwm9aad9i08PJoA8n9Ml6
	 ARcoa2dzjtDkVCWNdvGS/Aln4mm0Vjt0SnyEmNsK/Xhn9k6PcvlNxJC+W1Hoquz4vpQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837664;
	bh=FiAF9BvFmRjgEUwkbp/eNax4pZwharKY+eps4zXB1KY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z8/LfZz9za+QWhKI9u0vM9lPF9EDo2lhVFu+zjL9fE/S1AGUHrExufkLHkQTXBIQl
	 xQCpxFfTbCOwcej2E81NtGlKyBGLAGzkbd5plOOhirnQ5FvhJEwm22lKiwPN4l7vUZ
	 KHL8WpfTFYt9sNcS217fte9VPsp7t9M2M1+YSbTkbq6BoSvObaeCnQH+xgPDPoDUjq
	 Dfr/nlwvfpJS9uW+ckcUV+mgacMmIjtWd+ALE/hG/Nysmc3zjG7hH+/fOG2SgYTA0z
	 qiNhW9oe4If/z5wTohnAetVD/Igea11Rjxqaf89QZD4Guw6/Jna6FPYgyeiljDoJJ0
	 +GnY6ue7jycVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C05E94069A;
	Mon, 16 Nov 2026 14:01:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 18151109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A737400D5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iy8_D_cvEtcA for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:01:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6445E4009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QBnzA8Ko
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6445E4009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:01 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so3757672f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794837659; x=1795442459;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FiAF9BvFmRjgEUwkbp/eNax4pZwharKY+eps4zXB1KY=;
 b=QBnzA8KonLGWCetU88LE7NyUWn7Wm8fpXY26mOIJp0v5CrtJW4JM9ULkadLvjmjJQ+
 2THvlSEySNd7qlSd73+GaTtuO33MbgW0znGZyMkoWrNhOFm9AzFKCORhDu1qzJlYAlQN
 zOV9ZjY5lKaR5h+02uOIdn1NzCDQ7GFFuJ0QQ2hYLkEHZmm9GPVHz/CBOtZ6ica5TohP
 y/09JzFW9TaoZY5QlHQ5ruKKI4ca7lUv0551pq99/vbrrSxzYmDU5lRCVC9grneF0hX6
 RQ9AtrDpj56qP81z+hpM944/QmqbICuCessVMke2TPMC8/Tt9ykQMpMY/ZhRr7DDjBIg
 e7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837659; x=1795442459;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FiAF9BvFmRjgEUwkbp/eNax4pZwharKY+eps4zXB1KY=;
 b=iyz2DDWAbVWB0XO/niPo4W7XGz1cBfq1HKbFw79a5BkYhl/ydR8aI2DJaMMwxG669W
 Yl8byL2UaHZnsXB4H9YjFLL4esxILaNaIMu5H2SuR8jK3C1kGvNNPZGXGSk6LraqYGXn
 PS297y/3hX0Y2aie1zkiOPFps+NMtlZPBYAOifH7Df47CteXCgWFt/WrPELGNYTlfqt/
 qwdjGZXWNaOYqDkb4kgSThBRowqVUSErXQm+kQpakr5QFGQcu8UCW7zIYiAhR4WDr62K
 Epd8WkTpAk8nsN43jBOVTds+PSh/CfmYLOy5G/YNZ1UNNRin3GW8iePsQRv/pL1icUb8
 pmCA==
X-Gm-Message-State: APuU4Z9HprMz6biexjyVi5pcGN+zRgzlkDkzuGQdBUGn9uQcolLXjwit
 Yr0PSufdhH8Y8difKOaRO2VQT1kN1iEnKfESHYKbiNo7EIrtPnOy+Oa+Wahz4CsCGao=
X-Gm-Gg: AZFdTZdXAmFTb06mGS1RwJoUhtnqvSZrVV1JEVeFWaN8U4XB0UDXJSjDDbWSp08JXu9
 2RAf4r9+bL3KAfSr9fJz5wO/pfx+cO1Zn/ayGocy4fNTgWpRGVNI65+0XbwMSphWmktCBMDRqRG
 lnrzrqgPpZ9Xbeg6uPgeQq+FyiKrwrBU1XKEi5xnB6VyXU6urTx9qjMO1O43TXbH8HcibNpI/qD
 71OYMHNvZymyR8+m7071fotbiBbkVlnYLtJ6kPAy1VSh2uwxXBwRu2bCuWeUOc/vzcxNL6HdJwh
 9MFmjDgTiF9XMWGISHMUdi+u55LWwffhQfNMaW/KXE6k42Rj2bGJgMcWqEQa25vcz9XEZCPkOVk
 WxFGPmkz+UpuPH5O/lkDCSM9Wx2/cFMiMsF2fPXmzDpioC21eGtU0hT1G5bjXaDb9k4IwtbVkOF
 fEhEn1oqvPfA2E3fiYfvNmrx4cDcIWTUdeUiX8jjHrZvUR96X1cVmwXATHB4Li2bvkxNdtnVRFD
 rj14k9pGra0SMpzycR4s3qKgieEP1fw5mcDAFZOo7njAacT5lVCakcGe0l+2LEqbP4tjcgbCu0K
 C1W4HIYQj6Ls5UPB9wXZ+b01HiSMUK5sHK+enPv4AUqX9AOkkpeDYVBo2Hf422yTghrBZOPTNJo
 5hc/KPrfCM0i9OobTSIUGZH/3Fdm/KRdB0kX6Lr2zBfR8KQ==
X-Received: by 2002:a05:6000:4201:b0:490:9fe2:6a37 with SMTP id
 ffacd0b85a97d-49c70ed8f15mr26213894f8f.17.1794837659052; 
 Mon, 16 Nov 2026 06:00:59 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c69406640sm22119355f8f.12.2026.11.16.06.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:00:58 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 15:00:48 +0100
Subject: [PATCH v3 2/7] fastboot: invalidate stale and incomplete downloads
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ccaione-upstream-spl-fastboot-boot-v3-2-7b39e7a348c6@baylibre.com>
References: <20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com>
In-Reply-To: <20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>, 
 Rob Herring <robh@kernel.org>, York Sun <york.sun@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A new session or download must not retain the size of an earlier image.
Otherwise a failed transfer can leave commands operating on stale or
partially overwritten data. Only mark a download complete once all
expected bytes have arrived.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/fastboot/fb_command.c | 14 +++++++++++++-
 drivers/fastboot/fb_common.c  |  3 ++-
 include/fastboot-internal.h   |  3 +++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 63b0f5705fe..056d95cb1f8 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -318,6 +318,13 @@ static void getvar(char *cmd_parameter, char *response)
 	fastboot_getvar(cmd_parameter, response);
 }
 
+void fastboot_download_reset(void)
+{
+	image_size = 0;
+	fastboot_bytes_received = 0;
+	fastboot_bytes_expected = 0;
+}
+
 /**
  * fastboot_download() - Start a download transfer from the client
  *
@@ -328,11 +335,11 @@ static void download(char *cmd_parameter, char *response)
 {
 	char *tmp;
 
+	fastboot_download_reset();
 	if (!cmd_parameter) {
 		fastboot_fail("Expected command parameter", response);
 		return;
 	}
-	fastboot_bytes_received = 0;
 	fastboot_bytes_expected = hextoul(cmd_parameter, &tmp);
 	if (fastboot_bytes_expected == 0) {
 		fastboot_fail("Expected nonzero image size", response);
@@ -436,6 +443,11 @@ void fastboot_data_download(const void *fastboot_data,
  */
 void fastboot_data_complete(char *response)
 {
+	if (!fastboot_bytes_expected || fastboot_data_remaining()) {
+		fastboot_fail("Incomplete download", response);
+		return;
+	}
+
 	/* Download complete. Respond with "OKAY" */
 	fastboot_okay(NULL, response);
 	printf("\ndownloading of %d bytes finished\n", fastboot_bytes_received);
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 9184bc6346d..59a08018a79 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -15,6 +15,7 @@
 #include <cpu_func.h>
 #include <env.h>
 #include <fastboot.h>
+#include <fastboot-internal.h>
 #include <net.h>
 #include <vsprintf.h>
 
@@ -261,5 +262,5 @@ void fastboot_init(void *buf_addr, u32 buf_size)
 				       (void *)CONFIG_FASTBOOT_BUF_ADDR;
 	fastboot_buf_size = buf_size ? buf_size : CONFIG_FASTBOOT_BUF_SIZE;
 	fastboot_set_progress_callback(NULL);
-
+	fastboot_download_reset();
 }
diff --git a/include/fastboot-internal.h b/include/fastboot-internal.h
index 610d4f91414..41411601da3 100644
--- a/include/fastboot-internal.h
+++ b/include/fastboot-internal.h
@@ -13,6 +13,9 @@ extern void *fastboot_buf_addr;
  */
 extern u32 fastboot_buf_size;
 
+/* Invalidate downloaded data when starting a new session or download. */
+void fastboot_download_reset(void);
+
 /**
  * fastboot_progress_callback - callback executed during long operations
  */

-- 
2.56.0

