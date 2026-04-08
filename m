Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D031EA3C55
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF8B2841D7;
	Thu,  9 Apr 2026 15:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="Tyc9g4dJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B20684118; Wed,  8 Apr 2026 21:25:08 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF2A784132
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 21:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.cisneros@hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638G5T0U2028843; Wed, 8 Apr 2026 19:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps0720; bh=Qj
 sISXxmb0TxxNpE8rrNI/5TitVgEXucfhYcgyd43HU=; b=Tyc9g4dJn/SdVxUf4q
 nQFMqVZzz/ZxkiVhG+jOjTD4Xl8FEkIkupSDPUEOG+/WyHamFqyL5sfBv6t6XkmV
 fmkw3337ZOvUBDKGouB7c4THn1JxSteX5j+qFEudtkWj9um3o5aKIGtWrilxsO8K
 QfsVGlode6MgBuuQ2S5szKNKPNdlAjGuND6rH5II1eHmbNkusKO82bbHGvg9pSIv
 wo//qcedIfb0H0EOK3rVr7tPi9ZyA8r7yajAqNOWDVzzuGyfaGPQjocRBMLD/mPQ
 ZHYpWtSVmHX/aICo7mQnlEVVhFCZUl/GHcr9i9joH9VehbdLo5v9r+HoUN1JiXze
 dA5Q==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4ddnu8e09e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 19:24:24 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 3808F295FB;
 Wed,  8 Apr 2026 19:24:24 +0000 (UTC)
Received: from [127.0.1.1] (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 15CE4810AC5;
 Wed,  8 Apr 2026 19:24:23 +0000 (UTC)
From: Jorge Cisneros <jorge.cisneros@hpe.com>
Date: Wed, 08 Apr 2026 19:24:18 +0000
Subject: [PATCH 6/9] net: macb: Add HPE GSC GEM Ethernet support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-hpe-gsc-upstream-v1-6-2be1fb7cbbfc@hpe.com>
References: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
In-Reply-To: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Jean-Marie Verdun <verdun@hpe.com>,
 Nick Hawkins <nick.hawkins@hpe.com>,
 Casey Connolly <casey.connolly@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Shmuel Leib Melamud <smelamud@redhat.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Chen-Yu Tsai <wens@kernel.org>, Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jorge Cisneros <jorge.cisneros@hpe.com>
X-Mailer: b4 0.15.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MSBTYWx0ZWRfX+qnlXVq5LDoV
 70AKbZsseKbDjD4y2zguLpiyelZBpO6vPwFObY4xJydAg1EiUBA6lOEl4pecce3fauWik6m5UhO
 O8YNzP3dOFdsk4f1jGqb+ymqbjVVAiAl0zjNM0SdqkMVJUevOkYceNH45WFIRrhwn7DSsoxDgZD
 kKmWIjeNJYHT4cIds6Ot+5UzjJ6rsFnuW7ZLDd23cARtvJbpx1+DAEC/bEX7OBd4rJy1p8PVrsO
 T00am1rBDMxHs89ra0sXaAu6Z9efKI3qO+dtE+oF+5+s2kU97WfyZDK7aeUgMptZJ1gBIaOUc5D
 5qzEt4NONY9qlZjco74KzZcYdzCVqnvRXk8VOIEmXgxhmZUCruTe5wUrPO+TobNMTjPrfh1URti
 n+70d0Dtl90gWsLS6f/++aI62xqLOvA53wJrP4uvehWB7KUWyeTYoBbn+TwGgYTl5J0Ya4K7gMp
 ovgXAzX04APOj4oDAGQ==
X-Authority-Analysis: v=2.4 cv=LJhWhpW9 c=1 sm=1 tr=0 ts=69d6ab69 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=ModqzXLkJJ0tFyq98apW:22 a=MvuuwTCpAAAA:8
 a=vO0c-VuOld7Sq2BhZ90A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kYkVazncC0-rx3oU2Y1sAF2KKIS2xMFm
X-Proofpoint-ORIG-GUID: kYkVazncC0-rx3oU2Y1sAF2KKIS2xMFm
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080181
X-Mailman-Approved-At: Thu, 09 Apr 2026 15:00:51 +0200
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

Add support for the HPE GSC SoC's Cadence GEM Ethernet MAC. The GSC
integrates a GEM controller with SGMII interface, gigabit capability,
jumbo frames, and PTP timestamping support.

The GSC GEM instance does not require software clock initialization
as clocking is handled by the SoC integration layer, so the clock
init callback is a no-op.

Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
---
 drivers/net/macb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index cbf5f605518..c1e7044e7bb 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -619,6 +619,12 @@ static int macb_sama7g5_clk_init(struct udevice *dev, ulong rate)
 	return clk_enable(&clk);
 }
 
+static int macb_gsc_clk_init(struct udevice *dev, ulong rate)
+{
+	/* Clock is handled by the GSC IP block, no programming needed */
+	return 0;
+}
+
 int __weak macb_linkspd_cb(struct udevice *dev, unsigned int speed)
 {
 #ifdef CONFIG_CLK
@@ -1360,6 +1366,15 @@ static const struct macb_config sama7g5_emac_config = {
 	.usrio = &sama7g5_usrio,
 };
 
+static const struct macb_config gsc_config = {
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
+		MACB_CAPS_JUMBO | MACB_CAPS_GEM_HAS_PTP,
+	.dma_burst_length = 8,
+	.hw_dma_cap = HW_DMA_CAP_32B,
+	.clk_init = macb_gsc_clk_init,
+	.usrio = &macb_default_usrio,
+};
+
 static const struct udevice_id macb_eth_ids[] = {
 	{ .compatible = "cdns,macb" },
 	{ .compatible = "cdns,at91sam9260-macb" },
@@ -1374,6 +1389,8 @@ static const struct udevice_id macb_eth_ids[] = {
 	{ .compatible = "cdns,zynq-gem" },
 	{ .compatible = "sifive,fu540-c000-gem",
 	  .data = (ulong)&sifive_config },
+	{ .compatible = "hpe,gsc-gem",
+	  .data = (ulong)&gsc_config },
 	{ }
 };
 

-- 
2.43.0

