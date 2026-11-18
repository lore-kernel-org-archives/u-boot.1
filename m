Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E6C606CA47
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eaCeRbD9;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jytS5GPy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC60280D3E;
	Wed, 18 Nov 2026 17:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d7VT7DsGZ8hz; Wed, 18 Nov 2026 17:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7129180E70
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795023227;
	b=JoAq0IOy+ZwpzpV2u1+FJHlbgBiHzrnJHapm9qcr279lE3Bo+MidOcM/r4jRT0vTCoLW
	 WyJj8CPzAe8pfraedckxvhth+HjTtaRtpk/TrlWcFcPBbby1iHoXqqmh5ZvyT2Csz2vN8
	 x7MVpIvkAYG1zrSDAbzuNgslCBggZg+gMvbPc2KTnGqafK47MW2CC0GmtuOeBEow9OgBZ
	 2znaci8O1DyquARELpASYl1UHu8qDn/Ve0HY0B7esTpHxXc0Db3FI+TjU0x3Ru4IUx00W
	 TX7LeJs+9gHsFT1sl8Ht05z7SSIf+RRdHrmJ7++aVwiEb91CBYVPGB8CrCQezMHhkog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795023227;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uWlmmOIbcRdYvxaJY4gjgeSsWki0qX8E7WwCdb27D0A=;
	b=GH0KIimXd9t9WJ9aC3fcg/E/MOBsdehqaKYxlSjqj2bGxNq4IF0ZkBWXJS0Uhj6HGhJ5
	 zgkzOQ6+7xo7pxCghPoARpQ5fl4MmXsylBdhpxEyXnupAXlQGn+P/WWk0XU6DZO0+XbkV
	 jpohFEw2bz+2D51ahvoL6yc1YYpnk46hGzk1yjcGFxFC95ADoxKr9VN1oxWJKLUUm7O2O
	 8pS+FNP3JoybDHRYg6f/5OVEuaDChFxpYXG3RCmWsKz4leYptbOGUoaTdJ7dJHehxvddO
	 wJY1fU0GZFmaXejEY69CIY/RxBf4gI3pMBJu1/m72SplEj+4HrAPPD8nohgv4WDTDmA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795023227;
	bh=uWlmmOIbcRdYvxaJY4gjgeSsWki0qX8E7WwCdb27D0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eaCeRbD9ltI8NvqgyMOz59Hh7zWmeHLbqIBx1Vh+qs4Pe5OaFbQn98/I874Yh0sW5
	 87IxhrEPlELTlwT3nzxjYvQGZs7/riAtcBYs8EmV5L6mNxOy4BmF2cx/XcX2pMf0Hu
	 IOrDMlBdEVwHVbmsSyGlkHhPMSyiLgTFTJtxf3o3hA2Y/9hMklXtG3zYklvTuDCBb8
	 EyIX84/hlzjKcGMOhrOb1Bpdi81qE5grRBrOqt1hYBKvQyYZ+qTcU1sdSlzau+tWqe
	 b3fHBOMhRVjAnE7X32gMA7kAbXjYov5n5g6ao7SmCewP/iACgfxhEVrp4XUvkuikEl
	 CL8Md8G7F/C/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7129180E70;
	Wed, 18 Nov 2026 17:33:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A72C977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C7266069B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0esL5XRU-2wa for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64C19605D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jytS5GPy
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64C19605D2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:33:44 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4af173320f9so630987b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795023224; x=1795628024;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uWlmmOIbcRdYvxaJY4gjgeSsWki0qX8E7WwCdb27D0A=;
 b=jytS5GPyBxA5PMtaxgUy5KRDZVTZbTHGHL1akEtvnIp45egRUQSqmYQ6PKsWKfg5ty
 JoE7hU++1nvwxZaSOv06OqnVMIQnNyYyEf2xAExrDZhN7vCpQdT9kdvJJ3rKJ0srX4Pm
 0KmaXsBIkpjSYAEcc9n1MVWoqioah13BXweLCgfD7xnEetWJZs//Lgw1hw7weFcLgyig
 dukSJmwO+9zPiyDG33J2Ob05n9Eta8hGNTczt9M39bvR6F943UMzQ4aL/B9Qwpey60HN
 L5wDrKG7rz5hitJmloZSWwZP6AUWGq7dOPuv9CUxEG5CUMXA3y3u/S78dLimoSITTsTg
 2oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795023224; x=1795628024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uWlmmOIbcRdYvxaJY4gjgeSsWki0qX8E7WwCdb27D0A=;
 b=RtBL4/cEVei2xk0RUuIdmv7QVjfpo/liLzDscR0EovMHYaZvUP9pcYqIsrqgPSYwui
 PkqsixcSV02iBqmIZp0A4Ua8niRC51Idetvw0C+egSVO7No6oNZVWuI8ugZotvt/EnBc
 1XTpxWInRtRlkEqhOb+7tZFktYfPs5sszN1kpyXiTjZ3sPFowRaNG9idzbZ9FPN7PLUi
 7jv/pDUO8uP3Hzy69pkF5gNxtLD7Ls1RPbAgkRBsTXc3KbyXVi5o++Q+LwCcf8cxF+0u
 TmUCGADviZ1icTzQFi14GacEmeBDoFwKXAABpPJnRVU7db+BgkYlMQs9hL2LIJJLFx8Q
 1u3Q==
X-Gm-Message-State: APuU4Z+DJDXd3yWCk0hqz4qqSsy0HgGayUce9WVXn30mZrCTsr8/ffdK
 aw76zs06J0ZzsXoRnw0v/rmwvblmPJ5xD9ViahtwlOAOpNcM3ma02J8M0WFcx5r19H2PSTPYJ81
 yGO08Gv4=
X-Gm-Gg: AYBFou3Ic9i1GRDowSN+yawHZ2dHNTVjkyCvCzGClf7VgMrbaMMcMSwIVJoYmmDjrDH
 PlnMrnPhev1h4Pdmm4qP+vggpp966slWFr/6OUc6utM2w7AT0ii5eumvPj3q4JnmXyiXk01QrZ3
 ng4XAI48yJ57jMdTwI1S9sK0Gyv/B/OmESeUd+SPDabHXn+y4ZH+KpoJvVq0DcpOx8EvWacQ+vU
 R9scGwT6XmBnQPZOopYqYVK5pXF08jNZCJ0wGishWcWyelz+5ccB331IPgCNZHFWT1GIOVyEQU0
 Go/mJ3bGt3x+rMajr8E7dkPMZOJtWeYDRKy9u1nP+e9RUYrzDlaDgZ6ngiXrDSdh9QjdNXAWkdt
 c4Qfb3DX3QSAyUyWf09kJtgTKRjl6kn64dyH5cNf65fGClRtU2RTpEVK0XbWez9OGm9uLkv2rnk
 cVDAAY/TG2sbBdcVQ2d8WOCiLy5XoD7ZWYafZRJiEkkKHWWcjYdeYsIXUpYOAWjDFxrLy2Rey5A
 +hnmXdmuIs0R+yqN9gREJPkZAd5APwt16dzcV+ln/2p3o38LpdTjvroNFfSzajsramD6UjgRMTG
 NMgIjVm1uOPnFLIMyWDi7mshoca7sU9p
X-Received: by 2002:a05:6808:50a8:b0:4fb:90ae:2b0c with SMTP id
 5614622812f47-5774240ae99mr3759057b6e.68.1795023223665; 
 Wed, 18 Nov 2026 09:33:43 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-5777ae93f99sm2193865b6e.14.2026.11.18.09.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:33:42 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 18 Nov 2026 11:33:11 -0600
Subject: [PATCH 2/3] fastboot: spi_flash: fix missing failure responses
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-fastboot-spi-flash-fail-response-v1-2-98c2a4748bae@baylibre.com>
References: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
In-Reply-To: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2668; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=2Vr2QJCLrZnCYuNj5d4QVYd25eY3gCioXrcCZUaf4M4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/eFkW7sKCb13meW/SqoCXObqF3Q1CNaVKR3BS
 N/3FJI1W26JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav3hZBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Am6sIAJObVzNeYusq8Zog+Qqj+pa61+7swC/Yx4Bhdo1
 Els+AQ+PcYQ6j9JGAEywSpmG7l9Viuq2AmzePRynLhZ60pCRJsC1OAvudAx6BlFnK8o47LYdwU1
 IDZvXeqy/wktbiaJK+VczFvkdqtcsQtUUxVbunTXPlqudBHvIfGNzLRdEjpRHP1JBMa7EpZ9uGJ
 1x/R1eCk+ksbM8r2XYGX2+NAFZgFpuZwi0S0lvZfJYCx7naoIObDZUs3ZXLk0Rq3kwrYVutU0Ce
 G49miliSi9F85ovLMLNxdJ5wBPCLXkB2yiqNcXqDyGnXdHKjP+r1eACwgr1wEgV7+d36S66a1lg
 dtAI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Send FAIL to the host on every failure path instead of returning with
an empty response.

Every fastboot command must be answered with OKAY or FAIL. When probing,
board setup, unlocking, or a raw erase or write failed, the response was
left empty, so the host got an empty reply and could not tell that the
command failed.

Fixes: afca60620ad7 ("drivers: fastboot: Add support for SPI flash memory")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/fastboot/fb_spi_flash.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/fastboot/fb_spi_flash.c b/drivers/fastboot/fb_spi_flash.c
index 37da1d203fd..68a794b871e 100644
--- a/drivers/fastboot/fb_spi_flash.c
+++ b/drivers/fastboot/fb_spi_flash.c
@@ -173,13 +173,13 @@ void fastboot_spi_flash_write(const char *cmd, void *download_buffer,
 		return;
 
 	if (fastboot_spi_flash_probe())
-		return;
+		goto fail;
 
 	if (board_fastboot_spi_flash_write_setup())
-		return;
+		goto fail;
 
 	if (fastboot_spi_flash_unlock(flash, &part_info))
-		return;
+		goto fail;
 
 	if (is_sparse_image(download_buffer)) {
 		struct sparse_storage sparse;
@@ -204,21 +204,25 @@ void fastboot_spi_flash_write(const char *cmd, void *download_buffer,
 				      ROUND(download_bytes, flash->erase_size));
 		if (ret < 0) {
 			printf("Failed to erase raw image (%d)\n", ret);
-			return;
+			goto fail;
 		}
 		ret = spi_flash_write(flash, part_info.start, download_bytes,
 				      download_buffer);
 		if (ret < 0) {
 			printf("Failed to write raw image (%d)\n", ret);
-			return;
+			goto fail;
 		}
 		printf("........ wrote %u bytes\n", download_bytes);
 	}
 
 	if (ret)
-		fastboot_fail("error writing the image", response);
-	else
-		fastboot_okay(NULL, response);
+		goto fail;
+
+	fastboot_okay(NULL, response);
+	return;
+
+fail:
+	fastboot_fail("error writing the image", response);
 }
 
 /**
@@ -236,20 +240,23 @@ void fastboot_spi_flash_erase(const char *cmd, char *response)
 		return;
 
 	if (fastboot_spi_flash_probe())
-		return;
+		goto fail;
 
 	if (board_fastboot_spi_flash_erase_setup())
-		return;
+		goto fail;
 
 	if (fastboot_spi_flash_unlock(flash, &part_info))
-		return;
+		goto fail;
 
 	ret = spi_flash_erase(flash, part_info.start, part_info.size);
 	if (ret < 0) {
 		pr_err("failed erasing from SPI flash");
-		fastboot_fail("failed erasing from SPI flash", response);
-		return;
+		goto fail;
 	}
 
 	fastboot_okay(NULL, response);
+	return;
+
+fail:
+	fastboot_fail("failed erasing from SPI flash", response);
 }

-- 
2.53.0

