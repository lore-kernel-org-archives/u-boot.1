Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F68CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 11:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63729830E4;
	Tue, 14 Oct 2025 13:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="Mn0cvHas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ABA382FC7; Tue, 14 Oct 2025 13:56:28 +0200 (CEST)
Received: from outbound.mr.icloud.com
 (p-west2-cluster4-host5-snip4-5.eps.apple.com [57.103.69.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 645C482FC7
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 13:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPS id
 865791808A1E; Tue, 14 Oct 2025 11:56:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=i5NARKSZ+8fzmHvnrkQdZ2Bm5H0aQz3YrLz7iEvMrkQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Mn0cvHas8xCZE4sE0E5H/rT5EgC2v2Y8C7LOK40s/1+7vJ1M9ugK731FU1uw8STo2F5xO2lu2mbR+yCIaCchuezqCIvnBCWQEnt5+/Gt0YyL7yzeNlfp9V4t+OaFWbsO7+I1rtMwKkanWkRZGxDU7DovQQvdxoIBb5/G7Gjmwq4ff2j5PBOtPU9qjfInRKqEsFn2Rp2lkqCBjhjC303+TatWieYkdJmyzkOcNpc2EZbQcTfLMggZh6SF2WLFiVl6kzo9cC2x6D7e53GlCk4joaoRv5yAmplIcIcLI4sXFI75O/SPgOhdAmPuUgdqjpzRGwWDXVPWBh6MBtdRHVcFpA==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPSA id
 EB6B01801BCB; Tue, 14 Oct 2025 11:56:19 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v2 1/4] net: phy: aquantia: switch to use phy_get_ofnode()
Date: Tue, 14 Oct 2025 19:53:57 +0800
Message-ID: <20251014115604.194150-2-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014115604.194150-1-root@infi.wang>
References: <20251014115604.194150-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: csrQjrapTF4bTHmiNG2-uMRF0UoL0XYe
X-Proofpoint-ORIG-GUID: csrQjrapTF4bTHmiNG2-uMRF0UoL0XYe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA5MyBTYWx0ZWRfX3YMDsedJIhD3
 Tx1R7FOoKD5YETY/ibkPgOA/5sivYeyb8QOGdyXjBpDfV0dlE3OoIu+xtOMUMluAE2g+NuoPx95
 IN3X4PZxR04jnO6PHeDl4nplRbty3JxkP/0W57UbMYl226mvI6T9FmiozVdihz94ONPk0DXVok6
 qrPrHalzqub6BrhEdNtB4eCkiW/LLl7oYoN1h1dbMMk5XrBowvWlGuYc6KqTAb1t8JLGFXZAmbr
 JOUy1necOIL9sir0yUi+iBXcYtaQXBedWq/+TTGK9fcMoSSbBw77OmzCNSAf8Pe8Vlx/+NzxM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 mlxscore=0 mlxlogscore=649 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510140093
X-JNJ: AAAAAAABq4vZQHKKiY3Iw24hkQm6af4lIBkzxlsjvol0N6W2txZhRp5xkQM4QVgsiJ6nnNvt4nW2zd21ahhsmbRm3QC9m/La3dUiAPNpUhVUNoBlObbmHRU9XPWuCSRsmeDGlzaVqaF+ofWSyH1le9dMERtUjepyTRyiKbA3zv+lmIJuPvYjB8UlBU8hIV4afqMLLBWeKxa8HVMkEMHwhBPt6O9N2XpiugmQSNo7a8C6O22D4PUAMxCBoTy0SjiqdWEaXHNsT0o4fiz1KIeXuOv3NqsnJ5Y12CSCo09bRl3xiefJA6aC45Ccin6mRR5jjgRxtKWdzOp3s5vVwSmre4Rf0jx/Mcs2BQVherQ0VgcuI2/97Qy935apTagyqPC/jx3k8+OMLFJjGaRZOVyyPBL+KrDe2Vop5guaa10JJmuvsJ8ARXkJX6b7SCSBI//b1OrV2fJOGcV8x6H0PgyY5iYJwf4fCviiHxD2izOikHoup2+dWdl7saUZ1spzSOaCY7ozS2c3Tj6EJ8u9vda/HShiJ4qTSczBkXnQ/pacSeqlDx0J1tdXQjw2EjRVodNj474rfLWhFsHt7eONDl+1UxdC0p9LEmmWfRSUjZkpQODVdwjU/RadwwxaK+mSE95+KGNaUSJS0GxjQXTQdU0GtLoeWivkm/0MXFNLh5NBQQPW+G5jaNYbY2rw
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

Use PHY API phy_get_ofnode() helper to get PHY DT node.

Signed-off-by: Beiyan Yun <root@infi.wang>
---

(no changes since v1)

 drivers/net/phy/aquantia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index f63a13824ca..903fcd667f6 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -338,7 +338,7 @@ static int aquantia_set_proto(struct phy_device *phydev,
 
 static int aquantia_dts_config(struct phy_device *phydev)
 {
-	ofnode node = phydev->node;
+	ofnode node = phy_get_ofnode(phydev);
 	u32 prop;
 	u16 reg;
 
-- 
2.47.3

