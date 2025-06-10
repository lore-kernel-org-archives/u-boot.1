Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0B3C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EABD782B95;
	Tue, 10 Jun 2025 18:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="AYImMbdW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C0E82B07; Tue, 10 Jun 2025 18:38:51 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9518004F
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEgZ0h025679;
 Tue, 10 Jun 2025 16:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pps0720; bh=sCSwHYLFZnhEQ
 PqUGe/Luq2oGZCk9x+QHg+Ot1ErrJw=; b=AYImMbdWYvCzL5noDMxfFg8Xwxv89
 zkMxlX2pL1PgWKTyXw11JtdG7ohxTq7N+E84+IaOErgxLUnr9vufhRaun4yPKM9Y
 ZB2wAX4XZA01zreInltX68WhC+TBOYyiLJ9Bb407CCnl6hlMXsJvMV5zj0LBQjCB
 jmf/ufnjEhpo5jNHGcZA7ubzsQjH/chnUkyU6QmEYkQJumgu+b/Baa6ELjPl/+kb
 9WyJSXhZ1edeqgJ6Gs2VmcwZt1nGju6+6TT2lyFmpvdunIlM/n6BdSStNilwW8D1
 FARk58LKaY16e+uYqwO1wf4KyNJ3S55Z7uPRXVODxMuRFH5nQI5nba/gQ==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 476nv1hnr2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 16:38:45 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 10846805E6D;
 Tue, 10 Jun 2025 16:38:39 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id D07F780AA43;
 Tue, 10 Jun 2025 16:38:38 +0000 (UTC)
From: verdun@hpe.com
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v1 1/1] soft_spi performance enhancement
Date: Tue, 10 Jun 2025 16:38:35 +0000
Message-ID: <20250610163835.26874-2-verdun@hpe.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610163835.26874-1-verdun@hpe.com>
References: <20250610163835.26874-1-verdun@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EfDIQOmC c=1 sm=1 tr=0 ts=68485f95 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=6IFa9wvqVegA:10 a=MvuuwTCpAAAA:8 a=vDgps_oNwc7HqzpdexwA:9
X-Proofpoint-ORIG-GUID: 0KScEcC6FzuDOL1MID8t2ZRmqYW61Cxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEzNCBTYWx0ZWRfX0FjbwQ1XGfBg
 Cn5iiTRxh8wDR8eDvx53+IBHpo7S4KQjfkSaittyRCHvi/pDjmkP4VkGAmoZtwzGb7mZ7j8s8p0
 hKPYtFG4jwgopwGWGM4BhbhqaFoUkLxeB6tecLniSjG/HXYWuVwotHBpP3cFbQNF9hW5uj3qvZo
 TYwPYPvPqHrCcEdxoAPUo0s7zfgOZBpgLVVfdbEOBm3AqDls3MG0Zvvixr32j2K1ea4CQZX95Fp
 /9VD5NiYeCp0jd29PSpSHq+HMTBwXLMxGrCPSg5F1xmi4Tycl4jOfeftNObCliwz0rlwKLpazuW
 28xuLCEfKC/C36i93gvHttPrEGJs77lkNCOz1EXYloE5JgRaUPDWxBvnNZw6rcaPikOQX9fi7II
 +3xXgEQH
X-Proofpoint-GUID: 0KScEcC6FzuDOL1MID8t2ZRmqYW61Cxx
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100134
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

From: Jean-Marie Verdun <verdun@hpe.com>

Add a test when delay is set to 0 to improve performances
by 20% on ARM based systems

Signed-off-by: Jean-Marie Verdun <verdun@hpe.com>
---
 drivers/spi/soft_spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/soft_spi.c b/drivers/spi/soft_spi.c
index 50bd7be5640..e97352000f8 100644
--- a/drivers/spi/soft_spi.c
+++ b/drivers/spi/soft_spi.c
@@ -173,7 +173,8 @@ static int soft_spi_xfer(struct udevice *dev, unsigned int bitlen,
 			soft_spi_scl(dev, !cidle);
 		if ((txrx & SPI_MASTER_NO_TX) == 0)
 			soft_spi_sda(dev, !!(tmpdout & 0x80));
-		udelay(plat->spi_delay_us);
+		if (plat->spi_delay_us)
+			udelay(plat->spi_delay_us);
 
 		/*
 		 * sample bit
@@ -190,7 +191,8 @@ static int soft_spi_xfer(struct udevice *dev, unsigned int bitlen,
 							    &plat->mosi :
 							    &plat->miso);
 		tmpdout	<<= 1;
-		udelay(plat->spi_delay_us);
+		if (plat->spi_delay_us)
+			udelay(plat->spi_delay_us);
 
 		/*
 		 * drive bit
-- 
2.43.0

