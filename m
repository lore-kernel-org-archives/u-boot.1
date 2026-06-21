Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAC1CD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 19:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA35849D1;
	Sun, 21 Jun 2026 21:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KAITqocr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C4A84874; Sun, 21 Jun 2026 18:47:21 +0200 (CEST)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049E184873
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 18:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xerikasxx@gmail.com
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-660512d80b4so4245669d50.1
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782060438; x=1782665238; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=os6+pJEAzRg6OXnVIAxFIhGSkzIEpG/jfChBvBOzc6k=;
 b=KAITqocr8iq8KTYBAi55IlJDsbgFx3Rf+jqxwsLoF+zDybyjfglZddx+SXwGgIGIAC
 e8ys9vvHnphlxkW6pa9JLoAKv8TtKPNAgPZVqmjV2hxgMBvfaNb1/HoCQm8rhl/ORCG1
 jk7Hf3ejf77EZDKzx81t0Z53PlZrub2VBGNmBwKIK7ad/mJndGvWtpIOsBRmou8R4Oyd
 8xpbgcnS3ICpbESl0qpYGPrrtNDXZ8xqS1MTdGUfscdEYDbnrtthznRwZgk+NuD2LuSm
 RA8XtHQlLLZMCr7GjY665gV4Tt/nzHRFMY3Wu9XeHLCow2ZNLXQfB1uIyKT2NRtrolrs
 fFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782060438; x=1782665238;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=os6+pJEAzRg6OXnVIAxFIhGSkzIEpG/jfChBvBOzc6k=;
 b=eMesYhLWEXjMTr6C9Ob7Viddpbi9If6qyiKSxG6BHE+/FAiTc+Q+fHzHvYbGkHtftd
 OlVG1Xmju/xX6Se7KeuLM/MLr9UcTDRlghzpOma5vxFJtDzVgpAU5xMjUhyC1MSswqHv
 fhhi3iuPMIETQ3hWONYd4c+84kMYLqpF1zcqkvOl+w5DxTkUUrnDUOuypuaQ7V4/dV4J
 palDo+cSNBySrM6D8HQNKe4P6zs3PqG8+h9Jl5r08Z6y1hXQRsc38bcILSda9uuTVeeV
 TFsVhjgLtGY4lAIrJCStQhdSJPLbvAXOidLwhvGHMuorfU17FiCXI4jtxsnR4+R1pbbn
 mCbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZaw39E82sMq8Q+9NPmB6ia3szy469KI5lCGZBfAgCyW7qY19o91c09INw5VZbC5ZsSyGUOCY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyoy4BDwCdiDhgPaxKkJLE3ncp/NtEKesdnA7wLDerFaN2XHqhq
 58HdltJBrvt7eXQOyU0WSAn7zcDmpFyDCeooBzdswTgVG5d0ehv/qOKn
X-Gm-Gg: AfdE7ckqVqupVh1f8PQ72v3HtmwDyIfk4klP9zVdW80VV9DnBRHetyaSqx+O6Qw9OF/
 Pe/vybZ0rICE3pe3n53oeWcHtJ0m1q3azTRIAFz+7ADeCoUW4D9ejBjBgJWSryO4dpYWNf5BD7D
 IpFHYtYxA/qTZdtia0slwo/ZzJ0hKgMJzk3sQjOjN/WhdrSGNmdsxdR802tUczCt+uvHXcM/6Yk
 Af6z+K0TED+0Tot1qGIfb1EFG63zsmAxAOW/fwDKAHdK3Lv49w4tWKmQ4uwWdqlhK0zovAXlhl8
 EwwAEzq5UKK/HEgusi0TLDwzwU8gr/gIBx7g0DOGcTzEUTljruU2C/3x3w7zshgcu8Kd17CFWTK
 RVDs5r6MheCUHeDiFIl6xGMMK1H9UhImzDGLdOTSgB8vP7XDlaJD3+owP6MZIej8iT8lcL+MGIY
 8mWPJe95UcUNLwfO7WAmZePdvMPw==
X-Received: by 2002:a05:690e:120d:b0:660:6635:24d4 with SMTP id
 956f58d0204a3-662ff1bee1amr8761263d50.46.1782060437772; 
 Sun, 21 Jun 2026 09:47:17 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66314d8c3f1sm2498215d50.15.2026.06.21.09.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 09:47:17 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sun, 21 Jun 2026 19:46:24 +0300
Subject: [PATCH 4/4] phy: qcom-qmp-ufs: Add SC7180 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-sm7125-support-v1-4-5ad69a39781a@gmail.com>
References: <20260621-sm7125-support-v1-0-5ad69a39781a@gmail.com>
In-Reply-To: <20260621-sm7125-support-v1-0-5ad69a39781a@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Paul Sajna <sajattack@postmarketos.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 21 Jun 2026 21:02:28 +0200
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

From: Vitalii Skorkin <nikroks@mainlining.org>

The SC7180 UFS PHY is identical to the one found on SM7150. Add support
for SC7180 UFS PHY by reusing configuration for SM7150.

Signed-off-by: Vitalii Skorkin <nikroks@mainlining.org>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 3df88189a90..35fa38a5b37 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -1750,6 +1750,7 @@ static const struct udevice_id qmp_ufs_ids[] = {
 	{ .compatible = "qcom,qcs8300-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg },
 	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
 	{ .compatible = "qcom,sm8650-qmp-ufs-phy", .data = (ulong)&sm8650_ufsphy_cfg },
+	{ .compatible = "qcom,sc7180-qmp-ufs-phy", .data = (ulong)&sm7150_ufsphy_cfg, },
 	{ .compatible = "qcom,sc7280-qmp-ufs-phy", .data = (ulong)&sc7280_ufsphy_cfg, },
 	{ .compatible = "qcom,qcs615-qmp-ufs-phy", .data = (ulong)&sm6115_ufsphy_cfg, },
 	{ }

-- 
2.54.0

