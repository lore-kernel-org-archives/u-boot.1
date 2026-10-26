Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15524606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fbTenA0f;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q8N7eZxc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E59A580CF1;
	Mon, 26 Oct 2026 13:40:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5AgYHvKGsa7O; Mon, 26 Oct 2026 13:40:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2ABD580BC0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793022028;
	b=B54LTWIyXNjcVI1lwcLhCLZKtDHpLFHIxF/LXNcr5kE7qON+TLjpPDlEMM2GoH1thzo8
	 ZLojLBIwWg1jjUZppVheiEXrdVJGPVgkSuEzxDeliO6jQ5sJXEmqcjMdhzuK/yOQz/Q5F
	 THYSFXL3iijZAqTA6VJCpFkVljMIo0Z3n0sUc/dDInGYcKrvNF4POXBt7pAmpCY3BGxcE
	 4DZlMSzkA+7VYWyLYT+NoU/eW13fJ6iNjpW5U6/6aaLUq2QMiEax4FuXqYBGRyGQvouyY
	 5DMKYT8R1mLGzmHtXwIrriZm3+FfPqDKT6plFu0mUtbc8Wf98z/xqbHgfrPph+DXQCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793022028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
	b=Vi8WRFB6HXWZSZdU9ejxCAFioKcD5VdmMmzi31AGM556OcnEIfxmiYqkrOXcN6HeD8dD
	 iMzt41EjwYyGmbYgBdzejdUtMLG/JnuKpt7Me1GYHgagXYTAWLuEz0MeKaLoX7mt2aHK/
	 kUKKLze0BOchpTKRn1L38Z6lZDQomBMhc3CO2+ydMm3M+4Gp9wjlq26FtNxmUlQD07YJF
	 8uiFj+Gc9Di8JSFOlBLpNrCK5n05X7pRPvQTm2Se1gxo04ka2uP+77cTPoyoZfrieA8tD
	 8lrnl0o5+AGSUsTXpmPAKrBfbvR0j/Z8JuACMhjKoRg4PEZc5zFQ2QnWHnjmT/ru/LQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793022028;
	bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fbTenA0fCJ/hO1x/UjVxhQQC6kti0bFdAt7zGIWGkSN/jAFStpig6Pxm+Jce4Y57V
	 9XSB38CeCkxpHSR9FSHs//g9y+gJ6ODvoYdfifFbv70n6qjH+Y4XNOgn+WcZYJIVet
	 5MzMKFpl2Lim0H+ErcNRihQqj1eHgMv34yxVK0o5l2KrJZJZ1R5DoSxV9yggqfU7sY
	 1ojxgbd+wrQcfCTvI4IM5DKHkh79qUEJFmJBdIP89yKfu/3jFOWx2LMK/UXqVWHvtP
	 yQOs8mY1XCiLM8+2/USbU7QHhjqbklIltQQXJrjUYBiTv0XpJSchwhzGN0+hLudVW3
	 w3ppSjBVMdlxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ABD580BC0;
	Mon, 26 Oct 2026 13:40:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BBB14356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD84B40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XRdakl0V8luS for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:40:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CDA1C400F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793022023;
 b=dbrzEN5OhjV3BELOnosL/029N67VFy9UqEY4wnIwG/d3qmzvyb0csAs9n0OOuEMDYSig
 VPDwBae1hjv4GZjTfg7wWgIFHagQd/nDkT8MzSuVeje7jPmsMBUmoMdeYHGZ4xOa3u0Dp
 MkNpD88ZAKbZn0jkwvqw5KJ5+OSvQjJ+74aipUV99qWmY8il51993bOI2ouGQHMPefcru
 IS3xqBXSzJ6irxrc5eukBA+VLn+7GGMztUkBkhSIZGiT5HlrvgMrS1vBOyczbbKdKU8Uh
 h3VfN1l0YOx3bAddC90b/O6YQs2XEAwqrZGmZzFW0GYhtZfVO8sxzYSLQEMOmd3Sz8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793022023;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=VnvUXBIQbot9fLmtR2/d0X7UusMDB4gQn3C8ERevNcHYUJc9Q7m556yHehghBZbZpftE
 XGg+yavTJQCCvpQETTZRn0KXNLgv/rkx17WF8/mH7HszCZqttc87SoXfi5kh00YOiWgjm
 RHAzuu3u0U76qst5269oWmMkw+eU/y+DU53TwwbaI+/YBE3W2RsAUZMbaelhjyCZUao/D
 QQwgoDc7L/37Lj1l4OvqEdeJqvogLbfKMMrMxbJdal/YbroUvg+i0wcpks4ZZ+dJGRUMR
 e1e/Z2BJY4zOts9exVpzfZpyPb5lNrPcONj4TXvavFa9QwePANaVH/KUaJ6CZkg4SzA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Q8N7eZxc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Q8N7eZxc
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CDA1C400F6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:22 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso23851455e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793022020; x=1793626820;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=Q8N7eZxcBhY+dKWwmBb6PFLVvb9ObkgVBlac1EVU+joKyi+SAYEQSU/TGZGzHthvj0
 hawb34IEXSaudmu57pZ3jKo6eqj0qEteCOh2pyQ/bwhYBXKnxMqjZBujFPBJajhxTXvQ
 Wnga538pOYFmIxGRJpl9CqdpD09hmuR82yfCQR8Sz8oVUgr4R04QlMrKz7SD0e6qGjs1
 7nNuL/4Nk99Wh0usodIafysNHAvy2szuctLA0etA8wH6Vj2prR++hC3/Y+nusKSwgAqX
 V9H4p09eQXycoUQ9il4kapuGcvifYWh5jQbroXs6+E3lgGQXbIvsxk5lNNb56wgpQoGP
 N7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793022020; x=1793626820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=DbCVN3azChEr9W9BGvCxNAkEJ5SIAQIo4QpO31Dboa1MYmWFx+XePchJMZ6vE6osw8
 nVbtPX/RePJUmtPrLnpQPryRyN7THz1ZiK7xP4A67LhLuvB7/UzxpEr+FUvQDl3gQnNZ
 EhjWcFKwzRX8tlyHulL5Wcp79wQl+aAm+OSVmZPohXjubtTIIv6Y8I6Z74PMgbu63VD+
 rzS/n7ZDx6FFMY9KTD/JFBzHHlw22tOvE2+81M6doDG+0M/rgQMVXxj+TCPPhzp0G8HT
 PMsSrd/TkAumAs6dQhtOm12dliIP23EB2pYnqYyMIAIo031sMKAqI72uUpj43E1rQ0r2
 NdCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0M8nXd+Cr/wBWCCXmePRmcvAYBVYuIXbrfiEablMvfGPqqhQ5pwNajHBRrB+whoKQlnif2xI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJA+cztWz6Vsny2ghocR5pGIeYXWZY9sEcJl7QSM5Ejhot7/5E1
 cdfFyfcK2uF4bgr1t7BA2YqExPlgNEJN9ifTAnoyBKThK35EUNSkif0y
X-Gm-Gg: AYBFou0MKEkvUonY2fWfzjZ9g5+zvzO2sKoZoTNi3GZXEAnYFEvgHaZIMo+nTNN5Rvu
 Misc/e491isWLcCUqnNLQu+z7iRtXdNZju8qkvnGFB7Yjk43vKEC4zAq0Lk4+oXFDnYBxwUGTyG
 bI0McnCPoOF9lUYcl+7T9HxBiXsvUMNFw4yBNW4WEUVlo6TbP8I2gSbN6WzqmRNlULqRql2Zgah
 NDHjBLJJa7R8XQDdPJyCqvq8i4m06WjpKWlBqN8gtdDTvfunoKEsBLs7jY0qhM3msGlOtZl+9pR
 qjf3LwfGtDkt03M0QOJAjfbGSbC8VoUIgL7E/oEYy4guU1aAn3pr5wz5xDRzTCXAScweaDqy1M7
 cF3LULZxbQSbX70WJrKPSif/FVh710HrnY0+coC3Xh0bL0rhoQY1k9NMitv/LmFRfNIm1OjtL3T
 TF4Ximi9vA5I1EkgeCSkFSWv5pKHafBre3PAxJwmN5Kb3jssb0aTgBv+C0q1FwuBTptCbwR4v6S
 sfSBILlOsSft+BrMQGTCgPgMlllDbTp/BgmX2B4eYHDl0yZjlR95oJa3/amik2otAECop43xJeL
 ERDH+pPuk1W3eBTp9XUmTOu/8Pj7VsjNX1zJ8zuyQWesxSgsgXmxOET38H38
X-Received: by 2002:a05:600c:c173:b0:4a2:1a:a129 with SMTP id
 5b1f17b1804b1-4a35acb9b05mr109989085e9.35.1793022020301; 
 Mon, 26 Oct 2026 06:40:20 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2c0458sm194344375e9.11.2026.10.26.06.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:40:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Daniel Golle <daniel@makrotopia.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Randolph Sapp <rs@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v10 3/8] misc: fw_loader: implement generic
 get_fw_loader_from_node()
Date: Mon, 26 Oct 2026 14:39:56 +0100
Message-ID: <20261026134002.109025-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026134002.109025-1-ansuelsmth@gmail.com>
References: <20261026134002.109025-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement a generic function to get a FW loader dev from a node.

There is currently only get_fs_loader() but that is limited to chosen
node and is limited only to FS loader.

Introduce get_fw_loader_from_node() that will parse the
"firmware-loader" from a specified node and will search and probe a
matching FW loader device, if found.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fw_loader-uclass.c | 24 +++++++++++++++++++++++
 include/fw_loader.h                       | 14 +++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
index 0d95fac8f42b..7f19d6c4af4c 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -7,6 +7,8 @@
 #include <blk.h>
 #include <dm.h>
 #include <dm/device.h>
+#include <dm/device-internal.h>
+#include <dm/uclass.h>
 #include <env.h>
 #include <errno.h>
 #include <fw_loader.h>
@@ -137,6 +139,28 @@ UCLASS_DRIVER(fw_loader) = {
 	.per_device_auto = sizeof(struct firmware),
 };
 
+int get_fw_loader_from_node(ofnode node, struct udevice **dev)
+{
+	struct udevice *fw_dev;
+	int ret;
+
+	node = ofnode_parse_phandle(node, "firmware-loader", 0);
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_FIRMWARE_LOADER,
+					  node, &fw_dev);
+	if (ret)
+		return ret;
+
+	ret = device_probe(fw_dev);
+	if (ret)
+		return ret;
+
+	*dev = fw_dev;
+	return 0;
+}
+
 /**
  * _request_firmware_prepare - Prepare firmware struct.
  *
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 56f5e3be6195..99c47380a172 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -6,8 +6,22 @@
 #ifndef _FW_LOADER_H_
 #define _FW_LOADER_H_
 
+#include <dm/ofnode_decl.h>
+
 struct udevice;
 
+/**
+ * get_fw_loader_from_node - Get FW loader dev from @node.
+ *
+ * @node: ofnode where "firmware-loader" phandle is stored.
+ * @dev: pointer where to store the FW loader dev.
+ *
+ * Search and probe a matching FW loader device, if found.
+ *
+ * Return: Negative value if fail, 0 for successful.
+ */
+int get_fw_loader_from_node(ofnode node, struct udevice **dev);
+
 /**
  * request_firmware_into_buf - Load firmware into a previously allocated buffer.
  * @dev: An instance of a driver.
-- 
2.55.0

