Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39B6CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 07:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50EA1833ED;
	Tue, 23 Sep 2025 09:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="mV+ZGABs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9855D83448; Tue, 23 Sep 2025 09:14:10 +0200 (CEST)
Received: from outbound.st.icloud.com
 (p-east2-cluster6-host6-snip4-4.eps.apple.com [57.103.76.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A71968004F
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 09:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 E1A9C1800610; Tue, 23 Sep 2025 07:14:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=BpDX2e1PVEcCdTa1AqPjZ5i/MJqKWv7OfdFrW0cOuqg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=mV+ZGABsLYUNE1h1+btXz230rT4Vsdsb5HL7Y9QBTcPSPlxI7lDSg6d/S2GKsrvC1WXPaeJXCbIvqAKaOdl4i+YQVmavwfbsZhTP/F6+SwI/YY7asshDZYvFZtZoU3CPpjkGvD7DGQhU3WesCOq/iaUoS3UYj/j/8ijFA4/zlIq6M7ROJwwMX/KQnD/RxwLVU/dFoYCwWfHJ3+89koP+mh+pfW5FBkcK9YXKUeeq7bHabWn8ViZXXeWoY3mlE5dMu5rvwYSDS7KDBoBWwi4haz1OoTN0CWHEYPcBPHOcUiyPYjJsec7l5jT4IrL3RtHs4i4OBKLvY0kKVy2y2KUOpA==
mail-alias-created-date: 1549370554000
Received: from debian.. (st-asmtp-me-k8s.p00.prod.me.com [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 D62E31800609; Tue, 23 Sep 2025 07:14:04 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH RESEND 1/4] net: phy: aquantia: switch to use phy_get_ofnode()
Date: Tue, 23 Sep 2025 15:12:58 +0800
Message-ID: <20250923071315.276114-2-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923071315.276114-1-root@infi.wang>
References: <20250923071315.276114-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ahfM3cNWOvY5wZI_5u-4TwUVQlNowSrv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA2NiBTYWx0ZWRfX3mnhS+aKtexq
 qoYTX4zEaB0kO823+4BBdc/MRNiiN7MJhz2RBC4QYSGhC6vLfg9SnwrXSbE6o2rzlPg4SkO6F13
 g1Ugf/G66rIDuY0v57GFnCkqnbvcHylz9/OKmd8OaHEz/h9qkTylPUDQ80y2Rmrjuk3uyZ91nTZ
 akGEvciz0e073H+KVHioyjJXfv1nAUviRuGBVd2vIB9I6Yg6HAQo0PACNtC2zUSma+T5wakMBAn
 2U7BjonMPmmh2gBo3QLTCC+soPgzmoW4tWDy2uuJHIYQAFeG+fON7CcfJRHn96o2VwyDBfiB8=
X-Proofpoint-ORIG-GUID: ahfM3cNWOvY5wZI_5u-4TwUVQlNowSrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=623 clxscore=1030 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2509230066
X-JNJ: AAAAAAABDdTV/4gYjzqSRg+3ECaMnhtFPQQRoY8qqE50UKaPfkQPytQT55XzploHn13HRdOPxrOFHc6EPWd6pmaLtpNTVqe6kCF9FhWS+cQTW23lgeLhjUXoZxNX5BMWeLM5RusI0hvm8gNqfuTLYR1AfhtxT+3tIQw8Ql2NeDgBYv24vJRZuV6bNsfrI4gqLG3eehCSAvIHOiXsgoIn572m/EDrUxoacztPa0lk6SSaoLFPML/Rynslv3eZXfd+onEWjJhyImcQvu79a0+7RnHY42y9d+uOubamajZPT31/3lsQpw8thiWBvOveLk4yn5dVlsMbflVnU4Vt6nYxcPkY09K9K/Qr5A+HfOVBLCDt2DZvn2p0J28ZMB4e0aHOHCKtqSZwEVi7DTdyWTO6L3jqnv7G/0cxvGNVt+IIug60oxNp1MIXLD5SANMLo3aQAv/fj/lAMBbLjGT6osCoU37DVpev2DW5yivw0R6SEH8GFE1DtELf1radqinODVhQ6vAuq1h2jhB+laFdyIBujAMdIKxXxa+v6ByR8SF7/f3sUCa36O1aRjhXcO9hbqtIcVog6m9MsnhQidKoMcu23G6YYwfUqlAK/EjM+Fj5r4fvth7eMs+ULLnzudOMHg==
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

