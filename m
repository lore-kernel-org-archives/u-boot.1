Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9D8C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4199E83710;
	Wed,  9 Apr 2025 19:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uto2anOq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1210B8392C; Wed,  9 Apr 2025 19:17:44 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F004781CF0
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so6663808f8f.2
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744219061; x=1744823861; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R3wfo8bJVUWVI2DcWj2cqDWQYQT7gOuep3tT+yYlKjg=;
 b=uto2anOqgNJBlthXCC3VvtubQJltBuQzehxMSPgwZvP+IfLqLw25xMQI+9xetO0NnD
 Zv2rZiCkKL6gvW6MPsHkUZkmNx1LMISTZIW1RTW/zlTWui7aIPbvqU8PNT/WYu8tIjfF
 uE+ils9N84HGfuq5zycuRgBKRgXhbXqDjlo8en5Sclt1AqBgmA7dVH82rhUxPhzXIGvj
 e/07fn2MVVAVtxdCBHr16Qp0uY1cIa6f9zN6KEEn6Xsh/1Yx2Z1WzMW78OC7EDW2hyFE
 NQ/uO80AGVe+n4J3NgLnkTTyv1Zx7TPZHF709DUrgbVNeUB2XGHnQQmj6ksMNWRGmWDJ
 HyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219061; x=1744823861;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3wfo8bJVUWVI2DcWj2cqDWQYQT7gOuep3tT+yYlKjg=;
 b=S4qDotW8C0Hpe1wNN9YnTvevMqGDmdMlWvmJa3XsgOM2ypRvqYTGWCmpWkih0cKtv0
 Kz3imjZSpXpNo81b+MLqMr+9upjMWnEP13az2sjT4YTGzKAP8frZ7X8y6C2niGRZweaH
 7GHAlgL7JLlBcFGMPDFXwpxd3PnwypftNDuyIgS00OXeiZcEQc2ho1Mykrb1+kB4iIGp
 gtpYjr3aPFFwyC2SHUWkFl092bjeIgtr7TFPW9pd+wMh5U/md/b0MGKR/dW79kfmiLCt
 sfJ4KDLixm4VeEWUdcWSdajUJxuT60C9bk5k3u0vw1XzAgJlhfSY8Vf3qk1yLk6i+uME
 hqtQ==
X-Gm-Message-State: AOJu0YxRZkDZXo8s31l4sl561kXorlLWdNmWxOSxNWE0LQLrabDT3aUL
 7r7yFVYdTNeGZqwWc3J6KH2I6J8nRwgbZjXFJyFnTNqiRMRaq3aD/yIMSNH6g8rjYlJjnewiTpK
 c+m0=
X-Gm-Gg: ASbGncsddTzjmzEMiEBBpP2xyoWUdMujBLKTeN/AkLs1ekyFVFmK0cC1LHKkaxdMiah
 4j6tXXA0JbebU8a5mfEo+j/IKKnZGX0ZLKEqyai1iAUMTbYmSFyTQY83dV6xq2vG7cdzMOwKPAx
 SQInvh/rGKZderOXOyf7VQ2Y9adn6Iw2fGqZFQMcCL4YKEdmJALPQr05wg2/pDB39EdlbaXGLqM
 +piLG4n8AEQKQ/cef3WzIDXuCFqsXvohiAgJBKi/BbXediO8bmHxtmUJuxsIBqLA/JNuJ8vgYVn
 7VtMNIoCaMyKfqKBK4vtMtKx+3ITHzp1OYMDf4/VdKqPg5z9i8kuGlvMRde7YLDXju9GCfF+ZMk
 pA9ffIw==
X-Google-Smtp-Source: AGHT+IGj9kjR2k9xABvyRmFfuei7Hv4vQlb2sBuZ55HS6+62J+s/H6o84yPbxccagEV8+0kvjmZaZA==
X-Received: by 2002:a05:6000:1448:b0:39c:1f11:bb2 with SMTP id
 ffacd0b85a97d-39d87ab1387mr3389282f8f.22.1744219061142; 
 Wed, 09 Apr 2025 10:17:41 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c817dsm21916455e9.23.2025.04.09.10.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 10:17:39 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 09 Apr 2025 19:17:26 +0200
Subject: [PATCH 3/6] mach-snapdragon: of_fixup: skip disabled USB nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-livetree-fixup-v1-3-76dfea80b07f@linaro.org>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
In-Reply-To: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=894;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=I7IWAGQQIsBl57XDymH1nBOnJz0DJITHXlWuSKcf66Q=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn9qutmR1633rPAokeXy2DyQ5MQF9qwGalKY1hJ
 R3HtHLlL6iJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/arrQAKCRAFgzErGV9k
 tjfqD/9Vd3dQp7GIfYGC3FMaHILmkfdaXpuncpN+qz6RehtboSqKSEWqsdXy2s6GdAslLTtyFAN
 G+a2beQ7S3gDCLpRDG0urCDjYUm0C1b/rJBkoFi7RPIDFY0HnuEXPxN8EKWpwOaW5iIjbjXhTmX
 xjkCn8zAICob2hB8Rl1q/5gAZWl9B8j/O/ECb3ilof/y9NWU6M0t6mvU0Bjw+28pgJhH3r+nBbd
 hL3OqefrxXtWPZ2DsL58GUtkSix37xEzrqeebcB6jGk6PTfHxE/PdvEdHCV9rngtyvOi4j3dY32
 sbu2E5ohKSYAa1b/VhP2RzR37cXlqqPsyXmnJBRZR/WXxJo82Q4ueSOekJ6FTW/4bghXdJ2ptDI
 H1vZ57pM7WpSZlUUi+0SeVdLdVx3HoIdLq3YRLw4FObzuwt2H5NT8298oPAK2YHyuKIkNFHeG+W
 eqKeiHzRkLJvlmEgGPVkbwMI9oFRpKvXnsbK8CMRkPyf/IOAZ7s26Ga3s+bvY86NiR15n0cWLiH
 MvsF3Htn+lk9+Pp1Ff3D+UVUQV8u75lU3uHt4Jbt3o0a8xV+gEMKkDnIAteSD+NatfQIi3H/DFQ
 uYsd4eXu7EusNOtkX/GS+Go9mJwz/He9VlVy58AF+GeLF9wygdxcqOgnGzjx23/GXu3CoJDrxQs
 wxsQD6z5akBhlMA==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/of_fixup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index d4e24059212c552de7fa7555d2ab8a1ea4fc4cb2..b39036e8e0890fdf834a0dfe6966ef3dd365f3d2 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -107,8 +107,10 @@ static void fixup_usb_nodes(void)
 	struct device_node *glue_np = NULL;
 	int ret;
 
 	while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
+		if (!of_device_is_available(glue_np))
+			continue;
 		ret = fixup_qcom_dwc3(glue_np);
 		if (ret)
 			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
 	}

-- 
2.49.0

