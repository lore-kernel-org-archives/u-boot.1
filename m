Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C468AC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 226F140E89;
	Fri, 14 Aug 2026 14:57:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pv11_lsCz73V; Fri, 14 Aug 2026 14:57:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93C4940E06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786719427;
	bh=e1xI4aBhHs9LKu8Gw1OMIK1beJgrX2NRcU+0VR8gB+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MKQBIq3DbyooqPFVul0Eo/mxfpNcqpStZWEJKpa6Eu5S56eil7tenTydlNnLYSQTn
	 GmlY6DqoWGhvnWZsPTIqnUy+AIX1O14Ku/H63J92QgFwdj4fQzcb1pSBZumOfBbFAA
	 9l8LrPU9C+oyuQj5/H5qkXb6RLlx96Kd1ehEWtyrNdHFRZxqpBdGwBGX1yd2K3IHef
	 Pkd7O8+0dW7cyB1OfJIloDATybANR8XeP0f/IjwfWXLeOnI723ZyrJu42MoFCQnlN3
	 D+R/VYI8qU6wjJ8+HFTILzkllENQWQzUJHjnYHkK5+EGtlN2PNmvRPdYWMP3qNlrRG
	 KhrGqt2oG109w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93C4940E06;
	Fri, 14 Aug 2026 14:57:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9ACF6194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8151B608BA
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SHuKFo7puooh for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:57:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BB862608AF
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB862608AF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dDzeDLkq
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB862608AF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:02 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7ee4399c3abso788566a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786719421; x=1787324221;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e1xI4aBhHs9LKu8Gw1OMIK1beJgrX2NRcU+0VR8gB+M=;
 b=dDzeDLkquJ5Q73EXbbddv1ZVfWNY1b0cNrc+Z4crzL2PsArA1E8/9CTljV0uw3ssdS
 84numo4XrmuRF/zTVm6Rthr1bxnquwFl/3k0MHj+cvu5pgxT53yA9E+xSfGAqpBhRygq
 NC1Hizyf5PGZoVYvqAZAiAzgJQGevw0UZkoGa/P64I/dXEYSJsNHWnfksRK08Jevn4pK
 liFRrOGEgbk/o3b1A9+Iy/Mtf0toL7828iYvfTmj8B4kU9rm5qUuDO4OxbBElSKkArHp
 PIMYAaFKbwHYKp8s4YasY6PMGXFseRERIPONk0EFk2ZoznIcRnWL8le/XHy42kfv2Jf1
 MsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786719421; x=1787324221;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e1xI4aBhHs9LKu8Gw1OMIK1beJgrX2NRcU+0VR8gB+M=;
 b=SQ1DrY6Aav/AV9h8Yuflh116ftVgoO9HqAZHNDfAtuS9ByqOvOSsNYSD9KrcG9SA8H
 3O6Z4YBIhzqMEN0QdrIMJhA297gC1RTzdzC/u9bgcwZ9p7jfU3ozxf6VnZWk3yL/ImsO
 4m57DWKLcmHe0ls88sjXSJ5s8pIwM4lXLzLeKtsi1HcaVvK2ZGHShHlOhcTTcsjE/zY7
 fsvrWcjW1pMXuxJeMcdMj4pi4yVrRbZM77z79c9gG41TGmHA7OXEqzGssbmLx0BbAI4X
 yGKL5STxLTiHnMdUbdDDUH2/Hf2VmUIAS8P0l1itcn4w28KMqtmkR1S/9qiLSoFW27sH
 f0dw==
X-Gm-Message-State: AOJu0Yzf1lYQXqzt1javJwNpWfCodT7aMsZzavSIwBwfDgH4Znfq0zBu
 6mtR3FqvYGNcecGFBlPWZt1ip0aKe+3ro5X9PzKQ5wwYRWGvd8T8611Lfc32sf1QOaE=
X-Gm-Gg: AR+sD10B6I80la9iPRojbF8qUBa/qmHcOvVjiao7MRi90HSOjajePTI7AKS/Nz+0hOh
 0YWy6762qvx2vP+ob+AsVoRhk3MIQl9CAm29GTfCr90JWE/S1z8ds+V1sSB0HR1qpiNs2mac4tU
 +aOhCrIw6FLp/PEwu01zmrit1+/iNeGR6DuAMk3nPmEN8nER4/mO90RoMPbhkuHmS0/7/yivFzR
 XMe3JHEHu/zXSrcq/KqLlOvPVhbAFSXXMVJunBWxwdrZ6JMW1ROwvzspSdmMFWKI66zxNGYIjcj
 ezRJGM+uV+voXbKKFInIKixKJ55gEmjhL/Ew4YYna3OE1lkEZN7+TZxCNFdQDRqCdsLvzU9RWCx
 C2XqyasQeky/MOBEIx7aNpRsnfqWosLt8vJhpfoGWEJF8tthb5QHchIQpjR+6GmVHf6MjshPzWv
 peMJ+op3IeJZXymIluzySOhJ2xikG9eBFDZTL4rsoiDudpxa84PQG0ZufBUgL608YI7INr+ODA9
 Xb3cA==
X-Received: by 2002:a05:6830:67d9:b0:7e6:fe3a:b777 with SMTP id
 46e09a7af769-7f3de5f1619mr5281804a34.13.1786719421547; 
 Fri, 14 Aug 2026 07:57:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7124:5000:3b37:b131])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e8668831sm1065949a34.22.2026.08.14.07.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:57:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 14 Aug 2026 09:56:22 -0500
Subject: [PATCH 2/4] power: domain: mtk: add BUS_PROT_WR_IGN() macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-mtk-power-domain-mt8366-v1-2-6a0bb4a766bb@baylibre.com>
References: <20260814-mtk-power-domain-mt8366-v1-0-6a0bb4a766bb@baylibre.com>
In-Reply-To: <20260814-mtk-power-domain-mt8366-v1-0-6a0bb4a766bb@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ivKHXm41X9cGtLtkZjnzZPFYAGTt/64ZkJogxKOuxUU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqfyynhVpQyP9+zRQXSb9rIqnBoItHjA5b1nt+R
 aB7Rtpp9OqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan8spxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2+oH/jRNfjLtvYGhuG6Z3YtiFMStmzPlQ309JgBPR8r
 bSwVvDtofw6+iSarFAI5RtVPVsmeCRDwkjSvwCAyXkvOzFxkgLZK0IyXM+00s5XlRpAnz5VURhy
 KJdGyqUni4OBXx++YwYtsflB+Qx+Nc0V5ClWVetlonwpURCJRU7ADc+KXe+MOeVnzQE+iXE9l0R
 0mpaKuHgngu/V6pmpJK7wrnqimVOCzj//q004Fl5j/1quGttG+st4gSaf1QnTll5XmLjkoPPs8k
 as1zgI5FM165mYz7e1Wnc413dIgMiUYnvQcZiaQFrS5gBc0nCt9jpHatK10KPHpqniWPBYixQfB
 Ity4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a pair of BUS_PROT_WR_IGN() macros that will be used by domains that
have the ignore flag set to true.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/domain/mtk-power-domain.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/domain/mtk-power-domain.h b/drivers/power/domain/mtk-power-domain.h
index da7ffa7b722..09f9fb3e5e9 100644
--- a/drivers/power/domain/mtk-power-domain.h
+++ b/drivers/power/domain/mtk-power-domain.h
@@ -125,9 +125,15 @@ struct mtk_scpsys {
 #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
 	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, false)
 
+#define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
+	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true)
+
 #define BUS_PROT_WR_STA_MASK(_mask, _sta_mask, _set, _clr, _sta) \
 	_BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, false, false)
 
+#define BUS_PROT_WR_IGN_STA_MASK(_mask, _sta_mask, _set, _clr, _sta) \
+	_BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, false, true)
+
 int mtk_scpsys_probe(struct udevice *dev);
 int mtk_power_controller_probe(struct udevice *dev);
 

-- 
2.43.0

