Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B003EC87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 10:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D79A18394E;
	Wed,  6 Aug 2025 12:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tc5+xSPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E1D8395B; Wed,  6 Aug 2025 12:19:20 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA0083314
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 12:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b79bd3b1f7so3596835f8f.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754475554; x=1755080354; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S8sP30FK9x0Zb7i50H78wGNNFouNuAbfd9Kn3q9WMk4=;
 b=tc5+xSPmD7oB1o++evTPacalXVlxFOkSrqxE/dxlvjRfKLhWD+MenAZV1ZRNkTEsvd
 0l5QPkcY7sYwaJ3YKexVipa2P4BcXhKlxdCMzXxCa9/dXmEgxQhp5232gmdpQt9a4H77
 2d/O9fPk/O1sW/1u3xuFyxguDhhOjVc8FPeLceD3eHZVtDJLGKafuwkp5u2dW+hRtcbc
 VCnMqdqxJLRid2mi7fDfLaSwLsDg2KOHJJHFOk1wZNJ8OcLnebAbWFTzbNScLi12Uzix
 zyQZKOP8QLBFPhbHG+2A7Iu7NEcJBTGOk1mh1rov8R335wqwStwUsBaKgntzdMbjSPZ4
 OCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754475554; x=1755080354;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S8sP30FK9x0Zb7i50H78wGNNFouNuAbfd9Kn3q9WMk4=;
 b=P7DGj4OQOy6B0AegboOBOkjZ6LLEE0GTmNWaiydAe7msGHHpBe7J0wu/EuCMepNdwM
 8qKim/dG1d8M8QnA7N3NiYza6yUC0wM2FpHuj8Jenjp8Mq8HDlHhksD7V4Iw+VIFMJ1z
 zVHPjTvg4WEmoAuAq58TGnoNJFKqMoWy6DntxV0LFM+Qa5QkJGZen7XM0pauyPOFNRhp
 2aOk7eyGX3dLDJHUCc/7JtZ/D2ajXo5h+jq4a7BSbMjbAyuctaII12aDM9V0xuu0hrDx
 +K9rv4ae7l9Bk2BLvciMpWHaHAxDFLnwRZD4eCVLgwHHURzj01jv9dn4F91S7uVaYSX8
 Js3g==
X-Gm-Message-State: AOJu0YyChx3JmzuLLtxPH9xV3N8q/Bu8+5xX/FBg/QKucNP0wcSbz12Q
 RExm59jhPpKCHX27x35mK8TuOMXcu/IM+aCEDwkwDXb9NdW7hK7kSUbMdgTz8Kkb4pQ=
X-Gm-Gg: ASbGnct9r+wpf32qXEwmbnjognaQN/uLjZajGCp+0qIp/bRMA2y6hymLiKjDJjjR2tF
 dWYGS33aber/Gpgd1w04wYN4JPxXQq2dRSx+Vz28nr27oXKRZ60oy/WAZt8r9uoHuXDDi32QdFC
 IKFt6/6E6WH9rZElouhvQGDIk/2dDApeBvVVnqQydgqKRD7XQcL+cBx13r9bl+6bytnCnoTFWyj
 twyavK6juxUlglmdGmbZ30cVpslTKM//lHL0vOziN6CTufk48/DnY2bVg2M8gXNt46jS6EB05k+
 lsu/ITm1LCfXnCvNzn6LVrwmoqn1czuQYGBNMYQDhN0n7P6EOEz0VOv7t2zKcCWQoNkfoytAZos
 6segOnauzxc4r+6QCUml+v9Ttqze0ryZGsCrkctT4BMZ2zZzHhyGF1OV++iNr0w==
X-Google-Smtp-Source: AGHT+IHlowKateOuZkLxNJNah04wLeS7AukBLcGAUZMO/o4SNM5eQqrOI97ARoXIeFyWZa/qx2k/Ig==
X-Received: by 2002:a05:6000:22c2:b0:3b8:dabe:bd78 with SMTP id
 ffacd0b85a97d-3b8f41d5335mr1856114f8f.54.1754475553511; 
 Wed, 06 Aug 2025 03:19:13 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dc900606sm106397305e9.15.2025.08.06.03.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 03:19:13 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 11:19:11 +0100
Subject: [PATCH] net: rswitch: Fix error detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-net_rswitch-v1-1-5fb64805803d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAB4sk2gC/x2NywqDMBAAf0X2bCA+quKvSClrXM0ejLIbWkH8d
 2OPwzDMCUrCpNBnJwh9WXkLCYo8A+cxLGR4SgylLV+2s40JFD+iP47Omw5xaorK1q2bIRUjKpl
 RMDj/NCtqJHnELjTz8d8M7+u6Ae7lbXF2AAAA
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In rswitch_probe the error detection after the call to devm_clk_get is
very wrong. It checks the value of ret which is uninitialised at that
point. Instead it should be using the macros for including errors into
pointers.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/rswitch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 62d3f39f071..f27587ac8bd 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -1110,8 +1110,10 @@ static int rswitch_probe(struct udevice *dev)
 		return -EINVAL;
 
 	priv->rsw_clk = devm_clk_get(dev, NULL);
-	if (ret)
+	if (IS_ERR(priv->rsw_clk)) {
+		ret = PTR_ERR(priv->rsw_clk);
 		goto err_map;
+	}
 
 	ret = clk_prepare_enable(priv->rsw_clk);
 	if (ret)

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-net_rswitch-8aad613047cf

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

