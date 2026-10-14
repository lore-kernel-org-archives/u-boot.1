Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E40CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F53580DEE;
	Wed, 14 Oct 2026 12:25:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EFNnx4RuU_af; Wed, 14 Oct 2026 12:24:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7EF2F80DC2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791980699;
	b=VT1/nj0zkHzojmI9BrGnJBz/I+iUxbYPgI2vNwWZHTgG1S+ggnwParJytOIRl9B1Mu/G
	 VwpSMQs0UQxaD0UerKXSbBc+gFtcfKE0iOQlMK00qTyHn3HC62c/um2Npl889Ywz3unDE
	 e6f7QWBufgotlQzttpo4f9/sgvBUeXX/hzcscvO8lpa/qfQUL/P4FUq4BHVsfyqSVjd1Y
	 daN87HqO2s8BX619IaZGKSPNVGSFnaXxXn2Aj3MofgAwOjR8OmafuBqaPuDz4kh/e7Ouq
	 WHL1i8Ji+vKrsMSJ+RewW2Kvctc82mmbuj7MIDe29R/LxfD9PeQnVxF122uIcGzBhtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791980699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=aQ44drZkdLa2QsLwoHSV3EsQC5jwO6uuRznIjMl5oqU=;
	b=a7O9F58rQsjcQoB4/0efNEM08olpw6Wp4fiqIidazyGBlx/7RXJQ1UuY/7X+wkyRzkEJ
	 z6/F8qbPIaMbnA98NvwxGtI95/pKwFDqxEQGdqCWY/loaygtjU1DwsNkEf/n5nF2OwFbb
	 W8ZjyRzHnJtKBOyOrY+HaXxjMEtkyJX9sFyI0myNPvaQPQx8jWiCT7SEdmzgA+/+SkdkZ
	 1YL2gR0jczUrl1Xfcg5AZ8Ij0Gp5dF1XD/oZFf7YvJii2pRwhvDwSr7ranx1E088wJAfM
	 hydjQLLQSJ2OPUcbaK1qyZeVwEpYPfeVSQiMtsA5L7YDSa2aBS5QiufyN+5iDfdOOUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791980699;
	bh=aQ44drZkdLa2QsLwoHSV3EsQC5jwO6uuRznIjMl5oqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G5zyQZHWFb5D27OqloDTjeUuvB9KYN+SYqHZwWcLa+v/cDMD+uR+WnyLhDJbMnaC/
	 TPgdxrYS1Kv4y7xpzDBf7QOdifA8rPydaqdkcGmXQj7xcUFg7um5P5XFUTRgXe9qF/
	 ysdQW6ie4X0YCZ0906iSuy494XV/klK1rAVA0TnSMaxSGfp/oKKplvljWwIvmKS6sE
	 bDLvheR8rVz57UskbbBUT8Zq/QXr/LMODN/99Ic458g6Vg7goC58T7YqIUuf8k1iOB
	 c4V+W+UdDr1Aw28GZuwJExnQVqP+kM79iJuGizqw2BwCdcAfxpU14Lz0YoUSVlG5tS
	 KeOtF9YlPgrmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EF2F80DC2;
	Wed, 14 Oct 2026 12:24:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF37B1DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCF064014E
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1fiM76rxuIiE for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:24:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E1B42400D2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791980694;
 b=QI8R9GO0UHDSZJ3nM7qY7vhATqVBxb4i1vE3b/N6vRihdyHsh64+YLn81Ap+odFAYwVR
 h1AJgGZbo9+2sD6P3zRfkyzOhaQGqhqgX5YUx85l9/g7mEqiEPIzVivwL4q/lPcQT4BLd
 ei9pTD/9rXoptyBRXRodK4o9yFiVRUHELD0OynVz7pmcq6987PZlLXT0btQ92Dm6dO9O7
 WGBfKVEaWgcWo9CQWB62EjpPrtxCbvCmo3prfT/drfLp29AdyhwjAv0+PYE9EBTWVXcUf
 p2WJ4ztp3+it9SiE5o5wE3ZUoiubWOy40zFQOFNlV+RsqxxLPY607uLnZzcCx+F2ULg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980694;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=aQ44drZkdLa2QsLwoHSV3EsQC5jwO6uuRznIjMl5oqU=;
 b=a8LqR70NRraQw7P2E2w5PJCT7FzL3xf4OYKR/xlFNrCjztSDqAwv8OrDTNU9rcC0e9mc
 4yIjYMxrsmVzq+P4cTpXkDkQXlwwSI8oxZCvkrNhg8DnLm3P4rZ8VekSDyh8TkteB/aRO
 z9eP9xZb6sthJjEJdy/Y7p9UFk824IZPvcUcb5ZYSChhkt1nmwJ/jquF7WNXhRHZ/k1sN
 DLxKZSL+BVZnOEMvlL0PF5JkeLo8GvdXUrkCsaoxCdshk5BKoReBEcwfXFjYVMFcrMiWY
 XKeKAg3BPIVMSDx8MnzIqjkPdwR2Abqg/U0yt7t9776ZI6QBe74a81VFVxqj52jVrcQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PgMYbWPx; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PgMYbWPx
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1B42400D2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:53 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso396801f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791980691; x=1792585491;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aQ44drZkdLa2QsLwoHSV3EsQC5jwO6uuRznIjMl5oqU=;
 b=PgMYbWPxIh5IERa+DafskHJVyyoFv2T2zQLPzFA1qom3dnlVWDtYCn+swD+fYH89kf
 kW0YuxnXAP6dGjcGAdfGnuDg0P4au66bX/+eqZ6zw9DBG4QeseOl53D/3z/4Fiw56W19
 Lv7JQf0+cas/6uuC42OOy1zt6Z6ZFwHrjp+56kic3ATP/wTfqr5Pg6I/UAxjgKZrwn70
 MnPT5hoQUWGWMo0XzPitQIx/efUlWu7KQJ2IZ+4sXpgN5NCsyK404u4cjnqDSYVGL9HB
 IkUvU9kbTafKeiDw0fpRUN+uiluOXCEhFZufvilo+C0ss4doxJRfYSnhF35LhSCSOlOv
 YfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980691; x=1792585491;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aQ44drZkdLa2QsLwoHSV3EsQC5jwO6uuRznIjMl5oqU=;
 b=1ZSpfrKXXsDJPnOKvffHe7ZdYo1d3IuOjtOb4Hd+0Y0svJbqncqYS5/LVedeWf/9dI
 J1fDOHYXfqJhmPno/2VSvQ+M1P5XQSJ9vFJJ3hHdqpdcoO2V3pRMaQm7PqgaalcES36+
 U9+qPTAP0BChJutMBLwMdXsHe35A09Jg8/tPwgAI9uYRWI3zyImZSWgqboHPKXEiH6yq
 hvN1dZpr6g4tUBM8l6z7rLTy1vbyEDmXReVyqtCo2zMZZYuJPssFWaw6FUkU9DAqXUNT
 b4s+GtNBixiI86Z7Bto1oWLFcWQCUtAuDlCmlUA6A+0UE8lrWymX6YMIEIfXrR+xv+BX
 3hQA==
X-Gm-Message-State: AFq9FYJCPlU1tYTBdpTBgHTpG9AaAcK5SVdiulqc0FvuvPeZD+ee6PuS
 8RyfpsSzxMj+UR6y1z466UhLgzncM3lOuVKHF0R6rOfkZgCNicKumZMIn5b2isjiEaE=
X-Gm-Gg: AYBFou3eYu4GbjksQXsfdglSBqYsuDHmSNyUqddSopwzH/Pbh8IWU9em0ECOQgrGSw7
 H5HN3kfWgbLx0Y6LdeNmzPlGWqdQxedv7MyZTkbPVoYdl9V04Ptz3UYx7RIQWMFkIJEMJU6+IJl
 n07xCBYOhX3jeYXB6WgfohtR6HQFC1RUzjX6PKcY0CB2IuEBFNOtC6VCEOMimhCpFshUPgTbuqq
 E7UXflSZtymEVCzukhyx67L38I1uLil5t4PmXz09VxSwNU0OSjf0pr3/F5GeFnR6Q7QfRJXZFGT
 C1/E4u4/0bnfX1IsAzzLsK+Dw2P+aicyb7/u1+fvC0ZOt0s1ytAbdrxs8GgreOMUFWuqlEfsInk
 29+R2xq4aUuP/J7eUgIEG63pd/fBlkzHyrlqYBC0FNDrT5BlXa9G/0oVug3KLCTcqauTqGMRk6d
 LHbBgLTHEtpeUR1ezR/uMIbOKcbDduv9l6TKUDP+hePNKVWmwexrPA3CKrd8xW8SFbgVpjVJ12U
 NMzEJ4RW8o5LAi7Z6oY6j9Oa4HlLhkFTcvr8QjFdXOzU87/+eCYQhjw8ZoL87PvezXekerV9I0Y
 DFpG+Jv9425eies=
X-Received: by 2002:a05:600c:a4b:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4a1af68d397mr93682375e9.2.1791980691411; 
 Wed, 14 Oct 2026 05:24:51 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2fc4724sm50351815e9.2.2026.10.14.05.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:24:50 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 14 Oct 2026 14:24:30 +0200
Subject: [PATCH 2/6] fastboot: invalidate stale and incomplete downloads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ccaione-upstream-spl-fastboot-boot-v1-2-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
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

A new session or download must not retain the size of an earlier image.
Otherwise a failed transfer can leave commands operating on stale or
partially overwritten data. Only mark a download complete once all
expected bytes have arrived.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/fastboot/fb_command.c | 14 +++++++++++++-
 drivers/fastboot/fb_common.c  |  3 ++-
 include/fastboot-internal.h   |  3 +++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index a2a89fc04f8..68983f5098a 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -272,6 +272,13 @@ static void getvar(char *cmd_parameter, char *response)
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
@@ -282,11 +289,11 @@ static void download(char *cmd_parameter, char *response)
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
@@ -370,6 +377,11 @@ void fastboot_data_download(const void *fastboot_data,
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

