Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29945C369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2EC083F7B;
	Fri, 11 Apr 2025 14:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ahZCDnqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA2083FF0; Fri, 11 Apr 2025 14:47:57 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 170AD83FE5
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so15933945e9.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744375674; x=1744980474; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rN2/t9X9csx7P8wW0eS4yF+EFxLwZyeSkdheVs30qJ4=;
 b=ahZCDnqPjH25wYo1i2efOLgTDJXaR069RiYDacoieMHmsBMv4pUKQ+xEjo8HVlfjoa
 SJMNxX6iuDjpYVSS8fZ+gkChwC7RYjqn0eMdn9cocy4EKvFmNaPTPbTGbskaLvu8qCQP
 p25M3+bVfrMAfWCUulsz8cnbb5HmbBsRmn7A5CGyTQB1Kt8Poz+YoYT28MM7t3YACq7y
 1Y2jjMsAysjmblPXMB0I9eck3HzMF2w0btxERj7ABSPQCafcQZs7W8CyFuI2kOuYUsvt
 b+LZL9VgkPYFNuY1PBwO347fJX8I2WBZIxGuZNcOU58+EjZu0I32ZI4lEIHdFck77rDX
 1fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375674; x=1744980474;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rN2/t9X9csx7P8wW0eS4yF+EFxLwZyeSkdheVs30qJ4=;
 b=dLKwhJeMFNA6dgRB3+5x3zZWC3oLlRWFcYCHLcfb+vmGhsxVdq4IzrbHgnieg3WnXZ
 wmKiVFtqnwhAbXn96zBABNnyCtpcdHsKAS83BhFNCDi1R78+yhTzYGxaOdo7b+f6f4er
 tp5vK76/FNhJvl8gFmAvsKiUP5WKZmMt4dBN21T/WConpCKhEihn+8+qP7nRzE9fOQ7n
 XMGyUHoT2vtSUk1EPkhUivLMvJh6jQ/YSb2vXA29gjxCuBCxNWABwKq+GilsejTGXkoU
 cD/FmXik/nLk9yzlwb5UH+gIs25Vfh6JBQrtpuKZskGNQT8m4FZaj331BMOSvVekfyH9
 GgXA==
X-Gm-Message-State: AOJu0YwIQR63zTRRhKoL/KyRxRuME91Tmo1ON21n8c5AO+vZcpZyMZyi
 zmBOQkZqu01sdh58V4oYMmpwEp/sMGjufPq92pYlRIIcWOxAnqWRsKzrbnh21/p6b5+x2y9hSuo
 kN4Q=
X-Gm-Gg: ASbGncuDxLsbJf8eYUX/tEoC47VIny9GxpNdvUEo2eoLZPZ4c2Uuxx47sjhh/0lKwF0
 4L/NCdVnvRE/5TRvtaqIJ8DrkJGgQS8Fpjr1Sdzz15CdRYGzLQjheC5p9qn79eWMhyX7WfmZFuY
 q0Yh0ou6+Vl8N8WsJQSQj4pMxTwIdqPjeS0fhZ95dPkY5QKD0jZV2z84xe5Rh0/HjZrsacFiWix
 ExWwCvBh5q1DU14u255SxRasBuGqcx2gSBsUTEnWp6IeuSn9NDibPiWS+ZvzhuY/J61aw1SAv2W
 Q1Mw8XKKdeSZZ4eA/Bkg3H2f4k86AHBVilgG41cJ5WGGVNWc7jD8piqACDC4XmEdb2uaZPPFylo
 87KlZdAjT6cw47hf4Lw==
X-Google-Smtp-Source: AGHT+IHl1GvSjizL+CGvsaHF11PWwRAiFSavfzyD3cFtadRpHdgVx8RmBO7Cu4XWUpEZQ/OyHbrDfg==
X-Received: by 2002:a05:600c:4e89:b0:43d:683:8caa with SMTP id
 5b1f17b1804b1-43f3a95979dmr22242145e9.15.1744375674573; 
 Fri, 11 Apr 2025 05:47:54 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f206264a1sm88299695e9.9.2025.04.11.05.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 05:47:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 11 Apr 2025 14:47:40 +0200
Subject: [PATCH v2 3/8] mach-snapdragon: of_fixup: skip disabled USB nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-livetree-fixup-v2-3-1236823377bb@linaro.org>
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
In-Reply-To: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=sONotuULnc7O3riBg9ZpcKSp11F2nFGIEsZmBRNwE/c=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+Q9zOEp/YYgUNrWEkJyJkmmOF2QuRMcRXGqZR
 HfhTn3LGZeJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kPcwAKCRAFgzErGV9k
 trCND/wPoMuqelW1LYpyTkIZs1M2WCOqLFfHrm/XBLwWshB5xPUdUukKk9NzBun36F/Ko1qghWh
 bR/afV/DdChH1sCY/75Vy+r3lEoqKuy31a8g7HWNVmeh+YdcWeonBahoOWC7IQfBWZb6EJl7BeK
 STbmlMkFUQMe4ibHPlOmTqnfhqlPu11cm6v0O49jtfXHTG4sPC4yNZKfAvi6DcukfmwEGA5C+da
 hEW9DnszepTwPQreWF3b3963or2UhUTumUXalivQlO+Cl5mKm/O+KblqKMsoz193rtERKrkUjKl
 6HrPZUF2H1sAqBHgssXDhnFMeklGE8iSNgcSPRR1o7D1h9BQuXs69hhmMc3YI8P3a2F+lpjgwam
 FecVOBNoVli5rAYbnnK9NlkqfqjelqQe9l5BgGXxPfj4cW4c67/q32vH722fSkV7vXzi78mvK7H
 57q7kT19/xjWqd+TKrR6qWMbvIWDJmL/orZb0AfPrJAWlOzf77zn9gK9gwZelikcWkD4HKhIdgW
 6+WGc2j5mAAm3d4O/QKy8kcb77Bxz/zmoRw9txPpUs0cztUTzynAQ/TLlf+TPd4E6iU+7EJv36h
 s1aDxfR2PnA1be06VgtHEkL8Nm+CRbY3QGkveEreFHVtYzfcU78UQ/xXqFMswapxHeAv4j+C4iG
 RP8WS6/MdmWZUDw==
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

There's no need to waste time fixing up nodes that aren't used on this
device. Skip them.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/of_fixup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 70399307bcbda1e067230f00af6ba859a98c7ac0..dcd09ee7cac3e02287647c9e6df5575651e18e85 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -107,9 +107,11 @@ static void fixup_usb_nodes(struct device_node *root)
 	struct device_node *glue_np = root;
 	int ret;
 
 	while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
-		ret = fixup_qcom_dwc3(glue_np);
+		if (!of_device_is_available(glue_np))
+			continue;
+		ret = fixup_qcom_dwc3(root, glue_np);
 		if (ret)
 			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
 	}
 }

-- 
2.49.0

