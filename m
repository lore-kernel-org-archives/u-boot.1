Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D81F1075286
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 09:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D95D83F8A;
	Thu, 19 Mar 2026 10:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iC7OZaaL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QtlLzebr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CFF683F9B; Thu, 19 Mar 2026 10:37:57 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3718F83F00
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 10:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J74aEW1772607
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MlxAbpqFbFvz8k8uYlbJJljaWseuIYIkVA63wez6bJw=; b=iC7OZaaLlkSC5aq3
 g2oli/ZlEP/7gwmYl7QLRRhsXOyVUFVsDTSCQR6IRVhzwVagtHj9WacT2Q4rZuvd
 Q9KhRvZ6ZHctT+4+sqYmaXBGiZa++w7hU/ttOMYXG4pL8gWVZBfVGYLgvhix8+2Z
 fowpK1iQXbBZzOjbR7xtbwbZChUeDYBzjUcoEicZJrIS+KoU5m2/wK9LgNgOVZk9
 ueNCYQHvl/iHVCdDgzKKh3o6tIfJLDcPSyLRFEQaBdQKIzGgdC/wIvHbw7vhSvMv
 GdWT9uIUDG0kdUajrrJOWPfC6X9DIoU1cN5b50wv1AZXoBR1hvweli2Io21PzY7W
 fuczyA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyy75txnb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:37:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ae3badc00dso9047565ad.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 02:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773913072; x=1774517872; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MlxAbpqFbFvz8k8uYlbJJljaWseuIYIkVA63wez6bJw=;
 b=QtlLzebr1CaaxXx4YdGskBh3tiac2zBogtvtQBnqccZDvs5Zt5dnaIWspkWgjapVJX
 BS5BX0sJgzdVFycJsa8ymieT/t7SiWoHly+ujygfz5IlOen3hl3hUjNCHhuXUIJU1sxP
 iuxPO7OY/E92OZB9sOkm0fA5hDlPhBYka6GjVD74BK60/EWb2xyMcqHi+NIGdYHZQxIr
 KRZLOmwcYsUD+sOwqZmeiJbjK0/6YSh8HSVTXRGdny8BIxBU/A16UGf0AV32zmKgh+Sq
 NhkkCrjla+IMaSTeSGHmKoZKt/rglILzlb+TXCCMnnFPh5v4Ws+KZKB5s/dWtmeUHSNT
 MerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773913072; x=1774517872;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MlxAbpqFbFvz8k8uYlbJJljaWseuIYIkVA63wez6bJw=;
 b=f5V4jkVuSCGiJclYyIwDmWyyrnrdDyimVdL7SJPAZWfG70z+KSXifJ9Q5Iq//PSZUk
 SmOiX3Wmq4pM2j5ZcVsa3cgF9HZhuakxfWGsdzVDfWsKeS05rKxa4zug76IMMtjS7mFK
 1W7ICFtucwjaUBSDdLQ64FmH6m8Xp/LKQt0A7VYqGOfonal6vPInGKkTPrECPDmrvO86
 UbuvAD/4tUHy0XDcrUDeWQqvwms+l/E5TE8hlrDpz+rSdb/pVHtT4oNjygyDbzD7yuWg
 youOQaiGw4RN+9oBfkLzOwbcpD5vBm0lTqiNXV8GXmAPFBLRyvqtxl25UDgn2qcQ6Htl
 CuIw==
X-Gm-Message-State: AOJu0Yy9+LsK1Rf2OEXwtGDygQbcGx0cntHy+/fhLyk7mpU/Ec9bJBvZ
 Dg7hJVu9DO2wbP+tJ5DbBEtUGsu/DaLYD/3t4VlCt2IPUj32w0u9UdnGatwLVRQG1ud2b6eSWj6
 MgmUcTmCIDZR4xB7/PcCW0pgLSjcKNuNZK9rJzmCVFWSrE67pItnc5FIs
X-Gm-Gg: ATEYQzywxolGk/0J247puoQJx8LD3rr6Wh3QJtu6/baH+AU8t2NajiPhHiPleroOUXU
 OJwbYWmqTK6MdQPw5hawffkPs76dgyjVa3ZNvd+CrKspW34YUYjFJc6y4uCq/ZhF4pTfmMfNjj3
 1slU9HseSXx0AwCSzhuPRE0f4Z9AeSArZr2Y9U6L8dypbeck0igUtWAf7gRVXu+2Kryi7bj1Szd
 V+kiZ/z4AqKStbzq41xbDUAJIc6MPrsLy35o9SINaq35LstcxsowRVbAdlAVk42D22jwQVw1AYD
 RtdsXiJLZDstHW9Wiwpp0oUNekP8VFPmG5nmSF+SUJ+ehI3Tfh2O7k+3D7lQWcHgK1xzIL3ANSZ
 Ng8sY725uWMJAFTyKygQnCnnHF1aOJwPTXCIjZyp6pmI1+A+xUlCSoT+g0Ootqrg6h+t6zW6L1/
 kiQgjs1SxQC7p7nNtZ8otX7mDVz20Qcscl6x48jh9kRJBgHEgbhA==
X-Received: by 2002:a17:903:b8f:b0:29f:301a:f6cf with SMTP id
 d9443c01a7336-2b06e4073ecmr65537965ad.35.1773913072236; 
 Thu, 19 Mar 2026 02:37:52 -0700 (PDT)
X-Received: by 2002:a17:903:b8f:b0:29f:301a:f6cf with SMTP id
 d9443c01a7336-2b06e4073ecmr65537645ad.35.1773913071768; 
 Thu, 19 Mar 2026 02:37:51 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e441374sm52098825ad.29.2026.03.19.02.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 02:37:51 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 15:07:38 +0530
Subject: [PATCH 1/5] clk: qcom: clk-stub: Add compatibles for
 QCS615/SA8775P/SC7280
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-ufs_probe_clk-v1-1-08c085d6b15d@oss.qualcomm.com>
References: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
In-Reply-To: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773913061; l=1018;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=SDClNDKe+5mWs2RbKMT9QKrS5lcS1QkJ/+nnNcNOitE=;
 b=yR4vKcirnLUxjsvjSQT7w6ve/gpmhrpPj1Xhh8MraPZ/il3tg37QgyoG42O/PLuksweLFA635
 ckoQYFywqTtB5b78kUWV39h2KjCvPH/MFVyx1kUFtLnrb4ouBLZcdzP
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3NiBTYWx0ZWRfX4cJe2R+9iiNr
 JWvWHs1ajyXdmyE73h+8SF4utihDsPDtBk1K10AALtEZUxRyIkzjxOCPVx3gIFNzmIWE8m+ZMDa
 JcKUrcLf+rvsFYTPe0yzlW5e1GNZ9htJvuPUMviPYpWFBXz1yO1CVKoPBbuiFKCwkdOdlJ5sUcY
 bR/gPVOUEHqnmJ3ASOcVS279OVUz8OFBtOFiBlU1iS3BPjZ470g0zFTXoEg1buSbZy7goO6vSYR
 VB2v/G6Uqo2vOJqoyGF7OiONCqMVOiv/JpnrEQVDfhjffLTnqwn6tjUpJ9rPamkpQv0Bj/XOOnq
 DqMyB2l/OSyzwPmY9PK6YuNRKcXUN9B0v9b3ur283Tg2ro2HGj/r6ORtr3x79ZaUcmCe9RlH+nK
 qVOqsF/OQnKWVubnYdF/7CGIZ79OY+qBhMLzhfU2qjXb9KKsvdl+URnQHbV1ANZ+8HhErx8eJ9N
 /LGs2PVrMYrxgO46xvw==
X-Proofpoint-ORIG-GUID: iG8rEsBtIawmNNAcWS3TiofL-zESSBXj
X-Authority-Analysis: v=2.4 cv=A7hh/qWG c=1 sm=1 tr=0 ts=69bbc3f1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=90p6pT0qxzC6BDmp-ocA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: iG8rEsBtIawmNNAcWS3TiofL-zESSBXj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190076
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

Add RPMH clock compatible strings for QCS615, SA8775P, and SC7280
SoCs to enable clock framework support on these platforms.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/clk-stub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 117266ac778..6a178976cc3 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -49,7 +49,10 @@ static struct clk_ops stub_clk_ops = {
 };
 
 static const struct udevice_id stub_clk_ids[] = {
+	{ .compatible = "qcom,qcs615-rpmh-clk" },
 	{ .compatible = "qcom,rpmcc" },
+	{ .compatible = "qcom,sa8775p-rpmh-clk" },
+	{ .compatible = "qcom,sc7280-rpmh-clk" },
 	{ .compatible = "qcom,sdm670-rpmh-clk" },
 	{ .compatible = "qcom,sdm845-rpmh-clk" },
 	{ .compatible = "qcom,sc7180-rpmh-clk" },
@@ -69,4 +72,3 @@ U_BOOT_DRIVER(clk_stub) = {
 	.of_match = stub_clk_ids,
 	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
-

-- 
2.34.1

