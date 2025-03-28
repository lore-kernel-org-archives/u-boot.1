Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3A1C36010
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E13A81E13;
	Fri, 28 Mar 2025 09:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iXBBPDF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 352F981ED8; Fri, 28 Mar 2025 09:53:30 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B1181E13
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso798676f8f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743152006; x=1743756806; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rH7UBaVn8w+E/NUgltN8XqvvOoXYlH6vkN3D1kmrdzw=;
 b=iXBBPDF3w/oV3TtdULKSmMUyTddnf7isq0honRE5QJ9vzQ5YKzyaZ4AGTV4+zHnm8V
 3DqIcQq/a50oSefELz7z9nzGVHb7pmNsO0ru7J9zvFox1JNxUgnu7ImqiQYt44WgY2bZ
 W+qv0u4T13qwPo3un/goyCBu8vkokYLdTymt5qfvWW+5VgCwgsxncCIGVv1P296J6VMG
 0RmQbNVQB+cnjtQ2xbv2Ugd7TbI1Oxb14dAv4NC7F9MAgop3Q8JS5Zo88638NsxmNGuB
 qfUy+Do8nrQNvGKv4qxpkAgvqyYyh1uQc6tkJK7flH/74G4R5CNrmTxJ2Lbb6vX0Jq56
 5esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743152006; x=1743756806;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rH7UBaVn8w+E/NUgltN8XqvvOoXYlH6vkN3D1kmrdzw=;
 b=OLYf6t1PP/9ZxVm75C+C7CeuFGsOrzVCrScHIax/t4nE3Q5TaIy/YnPC5q+LGmY7/4
 nzPsymY3JZfHJYDtZBX7k0wii/YlNHwL2C45/Jrb39sG6fVkkJTAqgANrfy4/lODmkhp
 JvzpZ/306f1LARTd/KvKqwDCAFbhxzOcNPLfaxUjKhCam85zCgtI862Qzw/foG4lsz/+
 nsoxYABdtILEBHOcA/QZ5VYxJFbVZa6dIc3D1c2vva2kidIkFarThNga88Uspm2nZEvT
 h4xuVE3W3MwWJdJ2lEdLARLyNQ37noouVPGJWRCa4Yd9fZqK5q7A06AXRMMd5SxswE3i
 XL9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ5VwtVP5Jl3W+vZ8aE70UFkGvrtA+odgMsDwawXR06vjn/6zi5WMPGj6zEBCO3vyvQuEPvDo=@lists.denx.de
X-Gm-Message-State: AOJu0YzvFcUVA7PzxJ35tNqH05Zg8K2tGqmSn5ykqmLEPpJqxF5YVq5N
 tpgHj9UznYnLRE7cGqywUIu+eRCMU24L0rSXoYlSDh7GFatJG7yECF7HsKgDR60=
X-Gm-Gg: ASbGncv0WeIfFcgryhvmaN2Hok7xr49Jv21c0Mdsh3Pyqz7Dn5EJJajklSzVK8M6yNX
 1Cp/4cR19hoC5sjNRSPGyJaIBoM5EhRlisJRaYrib8ozsLkCSRuceK5L9YtB73MZE/L9WLBrXcX
 xwwZ9lxCoI3Evn6g2iLwO1JAbPfDa3hcTDSjblLStL+vFRpqDGYlt1iCJYvkwC7DaEGwn9rv9wu
 ZUCWNxXQzGRmW1Oe3038A0nnG5LaTl7Q4YCW078lxeiEaBNJqaT3ZHgKtk8DbuZTVxGuiLafsNg
 k1MfHmz3onnTW8f/8+ywdvedT9GtcEMgK7kWkD6fA8K57CO0u4g1zgpLkBKaY6G510Q7Z1+UFvk
 o
X-Google-Smtp-Source: AGHT+IEHfOz+NGsu30CYz0BIgBs1KGKfu56HwNOeMBiLx0o/nJoGMhWPELZK5er6Fsnc44juQ5XGOA==
X-Received: by 2002:a05:6000:1f8f:b0:391:1139:2653 with SMTP id
 ffacd0b85a97d-39ad1788652mr5563844f8f.52.1743152006445; 
 Fri, 28 Mar 2025 01:53:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0basm1969794f8f.63.2025.03.28.01.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:53:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 28 Mar 2025 09:53:22 +0100
Subject: [PATCH 2/4] spmi: msm: factor out channel mapping for v5 & v7
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-topic-sm8x50-spmi-fix-v1-2-a7548d3aef0d@linaro.org>
References: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
In-Reply-To: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Iv0km4b+upQcceuAQpjzXgX5VpByJxSS8jurCBS4l2c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn5mODdvXkGePmlx2/7UzMbPCJTXfdVndBIblQHBNQ
 NW27ZbaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+ZjgwAKCRB33NvayMhJ0WegD/
 0Tvfr1tU+Bnkib5dMIRC361/qPyAfIMCirrx/paBciliJu4edmqil0ED+U5MgvjThbxLt7F/tS5/8j
 pEJx1juLhPJ2RNWbnnaHXeXKNGuU+0nUxW8h2FRWNOb99b5BEkYcvWXMszy+ebazoBYurzFgaTQaUX
 B+qYksFvn8gMpy0YZMuHl77JpGednG/ccBZetRZHr2sCJrftLbmkbOBXMwyC2izkb6ibT736Z0dL2r
 tzpazSQzNmmn1CBvGre/yiCtv+79wzGS/KvUNmc8160AEOHwVhpiIcZ4C+kLXQ8Ws6EtN6X6DFXzNS
 ptSnpNTg+cQZXP/e/JTbDEqoi22eDSQlr9Sfzfzr2OtpBkVnTjCsb2MVsKJM5sCsCF4GJckF2pffBu
 26BdqYCPVgtwwpoTcxD9esBsys2KsGzTqvUEE8CTK4mW+l7A9XCWCXbeXIWIJg3jlmGRk/x1QnLnhE
 Oy8nQZoiXwq0W90T9UdeoWaRPRV2QlTzBu7m/VMidjaIQohP/rTuObuANhSFjauWjQcjozAL8v+6Mq
 ao2c2Iczxj22i0LUTFOXHDtd1mDSzFgx2ErAN+zKLEIEEVStjfP21pl734BTXrhgyZwM6IYkotbifl
 zhBIzvxLYXLfE5rDz8swNsjRsjZtVjSUwASgo9Y8q5pzqW/qEK7y+ZCSEYww==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The handling of the table mapping for V5 & V7 needs more work
to handle the duplicate read-only & read-write mappings,
so to make code cleaner add a switch/case and move the
v5 & v7 mapping handler in a separate function.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/spmi/spmi-msm.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index 08be4517df189f320302e97334a371d370b36440..9b2be1c1b9e381985b621297774500dd97844963 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -249,6 +249,18 @@ static struct dm_spmi_ops msm_spmi_ops = {
 	.write = msm_spmi_write,
 };
 
+static void msm_spmi_channel_map_v5(struct msm_spmi_priv *priv, unsigned int i,
+				    uint8_t slave_id, uint8_t pid)
+{
+	/* Mark channels read-only when from different owner */
+	uint32_t cnfg = readl(priv->spmi_cnfg + ARB_CHANNEL_OFFSET(i));
+	uint8_t owner = SPMI_OWNERSHIP_PERIPH2OWNER(cnfg);
+
+	priv->channel_map[slave_id][pid] = i;
+	if (owner != priv->owner)
+		priv->channel_map[slave_id][pid] |= SPMI_CHANNEL_READ_ONLY;
+}
+
 static int msm_spmi_probe(struct udevice *dev)
 {
 	struct msm_spmi_priv *priv = dev_get_priv(dev);
@@ -304,15 +316,16 @@ static int msm_spmi_probe(struct udevice *dev)
 		uint8_t slave_id = (periph & 0xf0000) >> 16;
 		uint8_t pid = (periph & 0xff00) >> 8;
 
-		priv->channel_map[slave_id][pid] = i;
-
-		/* Mark channels read-only when from different owner */
-		if (priv->arb_ver == V5 || priv->arb_ver == V7) {
-			uint32_t cnfg = readl(priv->spmi_cnfg + ARB_CHANNEL_OFFSET(i));
-			uint8_t owner = SPMI_OWNERSHIP_PERIPH2OWNER(cnfg);
+		switch (priv->arb_ver) {
+		case V2:
+		case V3:
+			priv->channel_map[slave_id][pid] = i;
+			break;
 
-			if (owner != priv->owner)
-				priv->channel_map[slave_id][pid] |= SPMI_CHANNEL_READ_ONLY;
+		case V5:
+		case V7:
+			msm_spmi_channel_map_v5(priv, i, slave_id, pid);
+			break;
 		}
 	}
 	return 0;

-- 
2.34.1

