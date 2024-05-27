Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88141C25B78
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 17:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D87F488377;
	Mon, 27 May 2024 19:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QIW0Luh+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB11487DAB; Mon, 27 May 2024 19:17:57 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 295208837B
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a626777f74eso708966b.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716830273; x=1717435073; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TsLrwe77MphWY0YcELWYdgLVdM7F1B/rZUAF0i5P55I=;
 b=QIW0Luh+b8vi/F0llp2xsCn1MeCRg+gqDzrNUkm8Xt6uPCXOj07Ejh+7rolgRG/b7c
 ACIz5bYwNpaJ0uiivpccAP7un5AsX2k8M7N/SKXEaQquZswVhAoewdaODjGdbyuFpN7a
 5PAPzTxZcQTKRxVPILh9dk4mg01+7SimrJU4ZlbcI2m0c1LthjnUkoNLxZ0nIWTHLEJO
 57Qj3Q7s5hKPMFurSRDca0THJK28rF8Du4JCLfYo0xWwlpg7amT8fuoGFTqwATMAvq3n
 irapLahITBiWZ24mpNrW98Wxrx8VgjtowtFLh5XX21lOI8rDFaf/jnZpGyEpsc9aHfT/
 wPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716830273; x=1717435073;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsLrwe77MphWY0YcELWYdgLVdM7F1B/rZUAF0i5P55I=;
 b=jCWps40Kaa9wRDMb5A9CgLq6I1uK9MInHm20kMuRutvkLpvCi+10DC6wyVxc9AnKR4
 SnOLrQONW6vD2rJXmKwWzuaudwHTwk+NBqlDJgOj7NXFVZzfVuRVzfNdFnlDXTtFK9p5
 5OAXvKTd7GddJiRuD/aBqqPsoXIktvSHG5B7/g5H3Vxm+GDy56DOlXNqj8iWtvQfkfkr
 VdquXaBO7Jz8uN5Tro4y6WIGwDG37Gi9Yz8JhGkID9YzAHxR65f6v3xj9L3PmDZywDeQ
 AG4mOcDVCP+wgVhPB2NM9MByVbwluxdGwqrgE6MfNkdsFsS5h/c9oX3mxKOiOshkW42j
 SD8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMTVJx66LuLNLK1LmR0vulkAFg4O3OiIaB3XH/wdykOEz8+0O+/atD431Gzoo9MbqWUAtascH9/UxX4eDHBP5i+0nEQA==
X-Gm-Message-State: AOJu0Yzk1EvjsSFIJXZPHBBPnmLrINNwCCvOQgJJdb1eDEvPHttDxxH8
 WlxBvn2iNUJpzrQIXt3syn4t4a78gbXUOHYoB9qN9JCnSCM2F11mtVwP3nN0Cms=
X-Google-Smtp-Source: AGHT+IG7nk0q0zNzv1LtaM+JeJhuIaLdLeadaY14Tu+NrzYvF7KjsLk0eOxHlZ7dOVdr4nlMcnhVJw==
X-Received: by 2002:a17:906:4bcb:b0:a5c:daf2:1cfb with SMTP id
 a640c23a62f3a-a626514e9e3mr922115466b.63.1716830273728; 
 Mon, 27 May 2024 10:17:53 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8b874sm509469266b.163.2024.05.27.10.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:17:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 27 May 2024 19:17:50 +0200
Subject: [PATCH v2 2/8] disk: expose partition type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-b4-qcom-capsule-updates-v2-2-47583d7ad428@linaro.org>
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=6r6o+LARxoUfqXvO6HRYgyNJUDpuL2kNJVwCc7gQ/4M=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmVMA90roUX6XIzzFuBtK74G47OttbJ1Nx9pRXN
 6dWxDDCXcWJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlTAPQAKCRAFgzErGV9k
 tuYOD/0ctRIqCF7YOsI7mn8BABGOyPxH7JiEVy/+4BdO8Mj+xv7UFo9DcNc2HwNJgqnpMQhLrm0
 4fAzbojF7KxWKSLcQ7f6ssoKliQSPRa+Jk3XSqptYCZSayIt2bj8yeL9ND0q4IHJh/B2gzC58TE
 pNeAjYzrM+BaxkZJ3K6nXGWLre9n80sJ/zlcvsyNbeTUqbLKupZIK5Kscnzk7qYnQGGnxb7irJi
 txKZPiUjE/XXw/SiiPXtWllhqu5rBNQoaXVRAXA+NRh8jPsXnjCoWjJlkkKQ8MELtLh3ovQlZW/
 m9gSM6LlpHbdTjyeU+RqFk6CAV54S/7jAnKrcfqK1XaLpKZ1lNP8/daU4qra9cK9cMQ3SX2OM1Y
 YhGoI8epv2+9xVule/6U+v0d9G9tdJRJM2Cl5iCnDBaJdYeft7QS8h8qGSIHgXIOZcDjsDdkLHo
 7zDPkdIvCvouudQvtQOvBdEm3GoihAcDn1Fnp2F/+WsaH7yGVfOYaUAv5XjgRDuYCcuEoDXNJOY
 qiHT+mXU5gbPJ16aCU+11u5E/qz7frQNfdZE67MdR++TGkPo4TZdtRBDSOKgjIZXw0G5puTvC1G
 C0avedQ41BN42NS0JnNVK1j+xu6mX/olskxlc0R79jc8yE7qz+tWFhGP0wFAmhPVPaDv0sPsCpl
 DnsdYtwg5FCL8fg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

GPT partition tables include two bytes worth of vendor defined
attributes, per partition. ChromeOS and Qualcomm both use these (with
different encoding!) to handle A/B slot switching with a retry counter.

Expose these via the disk_partition struct so that they can be parsed by
the relevant board code.

This will be used on Qualcomm boards to determine which slot we're
booting on so that we can flash capsule updates to the correct one.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 disk/part_efi.c | 1 +
 include/part.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index b1a03bd165e0..bde4adcfa087 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -291,8 +291,9 @@ int part_get_info_efi(struct blk_desc *desc, int part,
 	snprintf((char *)info->name, sizeof(info->name), "%s",
 		 print_efiname(&gpt_pte[part - 1]));
 	strcpy((char *)info->type, "U-Boot");
 	info->bootable = get_bootable(&gpt_pte[part - 1]);
+	info->type_flags = gpt_pte[part - 1].attributes.fields.type_guid_specific;
 	if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
 		uuid_bin_to_str(gpt_pte[part - 1].unique_partition_guid.b,
 				(char *)disk_partition_uuid(info),
 				UUID_STR_FORMAT_GUID);
diff --git a/include/part.h b/include/part.h
index 32ee40488563..afae51f1b933 100644
--- a/include/part.h
+++ b/include/part.h
@@ -68,8 +68,9 @@ struct disk_partition {
 	 * PART_BOOTABLE		the MBR bootable flag is set
 	 * PART_EFI_SYSTEM_PARTITION	the partition is an EFI system partition
 	 */
 	int	bootable;
+	u16	type_flags;	/* top 16 bits of GPT partition attributes	*/
 #if CONFIG_IS_ENABLED(PARTITION_UUIDS)
 	char	uuid[UUID_STR_LEN + 1];	/* filesystem UUID as string, if exists	*/
 #endif
 #ifdef CONFIG_PARTITION_TYPE_GUID

-- 
2.45.0

