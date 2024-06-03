Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEB2C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 12:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09310882AF;
	Mon,  3 Jun 2024 14:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mMxGUfit";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3918088324; Mon,  3 Jun 2024 14:49:24 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5BAC882AC
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 14:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6302bdb54aso565509466b.0
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418961; x=1718023761; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TsLrwe77MphWY0YcELWYdgLVdM7F1B/rZUAF0i5P55I=;
 b=mMxGUfitaKrJHgT/F8E9MzOaUXgjWjV1DjrSPOvmuAyOEY682awRpf4lWQ16pvzdCi
 Y3vOHlxzS+dO20458wkp1lYJIqL01hacoI6G6Tv/YtKczcSgLLhPBj4naV/dy0plExq6
 2sup+zQs+ZJure3Pfex6dtlXfkr1jiW068M+d6Y++uZbXOOiKBBwOcdUVuVE8XtWTlvU
 ceFK9cICJDWYj564OzEfk19hj+jbmMy2HwMUdEAQx5OBq+uMpqpq/4FaxIdLtY95N/Vb
 Hhd+FipFfv1PFDfokFKGp526MI9OHjKR/ag45v8cTe/3UTTIvtTuCWOf2XTt8E64y/7f
 LEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418961; x=1718023761;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsLrwe77MphWY0YcELWYdgLVdM7F1B/rZUAF0i5P55I=;
 b=Rr0/abfA3FwtAv8LjxqfZd5DL9U2gKxoIB06HKtgkDk0rhW2dtKe0ztG8YwLv5bhoJ
 V5dlD0sExTGgfmNJJ+W1sxMfVCFWEdEPnhW1+Ln/cHgVbctVT5ryhunF1KIJqD1OYVpO
 Q6mumZPEeL9Li1GrGtaK0pHQi+FsBX3RQfK2koYGscmCExiGfUf3I4WPTevOfn/p26pA
 wYYVfe8I3LlbQZnyykSu2rVA539pCBt3KL5DkOLvLyfW+loHf+Lgff5YGj+Wcb2fw+P2
 BMl8AeYmg44nGBDP6FS1hiGG6B08gqdGBslNBF68EIVvIlWRuKIR63hkIyGb8b815LbM
 6NCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWOikZ0kfnlM3nFlazpCUQxRt28YAvT6V3+NRDpflyUpUGHlm9EGt5nqfvq2MMEvseRdLKzkA3enNSBdVPVXNAB0YKWw==
X-Gm-Message-State: AOJu0Yx2lKYROao3y9vdl1X8HIoNKlGcurelOMf+bUcvdlhJvoadae3F
 IiwCrVOi8LvzmjYsJWQYTQZheR1ZTN6xQandomxjFea3IJhL7LHcNg9RRE1X6wU=
X-Google-Smtp-Source: AGHT+IHXFRCZVY6IWJCLgavoMQmXjOOZWHuR0g47OZeuBS85JRQPXyt/dJnMEtFkSjrPEReFODy0ZA==
X-Received: by 2002:a17:906:27ce:b0:a68:f8b9:ffa3 with SMTP id
 a640c23a62f3a-a68f8ba0035mr210645166b.46.1717418961361; 
 Mon, 03 Jun 2024 05:49:21 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a691cd07c72sm98917066b.170.2024.06.03.05.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 05:49:20 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 03 Jun 2024 14:49:17 +0200
Subject: [PATCH v3 2/8] disk: expose partition type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-b4-qcom-capsule-updates-v3-2-fe2e083289ec@linaro.org>
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
In-Reply-To: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
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
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmXbvNAJ2Jfm3J8hw8bYT0Lk+zvfwvCoq6WP61l
 80Pu7qH7cyJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZl27zQAKCRAFgzErGV9k
 thuZD/wNvsSqR0r0EOrVxGpHjhu+ExvMV1GvqYbcxOmUu3ipp/4ZkbDzdyoBnLUhihQJWnLHcTB
 tCiKR2dLWottkBsUZ9zw11xnzhSmtFk/PDpTt8els64QIlPMIroz27t8PbBwN5PJj4aeMFn55IJ
 XPk21sloQfR2JlExPLlsGtICzctsCMkMF5Wn+w/3eNluCfETJAJk+oK7BMl/PrG3lMlA/TT6San
 lDRplKOaE5wlPgLWHwicnsmE9PL/e2AoqH8JPU6Vxu7uoNSvi+RSzJaEGN3IVDgr3U5xbjkEQ/+
 FZptqghTY9eQT1H8FxiTVsxPpngcLgiPYId86ksz3JSq39DM/mB3kjcNNy498Z0wWZxU+ncNwyE
 nQa4Y4YiA9eJWUV+Qvjrf+0Cpd2p/5dGUFoKAkzRAu95L/vZJqyd6DljZp0jMC7SNkZNVo+YQjT
 mVgm3iP4iScigoh+eM4AK/XN6dgfzxztvq5f6K95iwPjrP0Bu10OZfEAHngOwvK+gnyvAD1oACB
 PRDudCOG6RD3h23tFyK0dHZYpKHFGj7dy6RMj4fOf18EIckQ9LGo4HBCy+GQws2/0rgZf/JJMHT
 rQ0WLbnNOko97BXopAI9xe8HRw/lKy/0qH0+CYqZwFa2op2pYQ7qIX0wTA9sUtLwzljM8scAgqB
 GFB1UxshE5rQoOA==
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

