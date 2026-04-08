Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8829CEA3C55
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1738D841F2;
	Thu,  9 Apr 2026 15:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="A929HMS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A52883936; Wed,  8 Apr 2026 21:25:09 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECE084129
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 21:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.cisneros@hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638I9d771798174; Wed, 8 Apr 2026 19:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps0720; bh=G9
 mt+ZuvUdrE0O+9AI1JMC65xlbhmVA4+fUQ3tNV9SM=; b=A929HMS6r0CiLP4JXH
 n12prg96Hvf0lePhevOvoXPEAODp7gl+MqprL4rOyMms8YzVRYymMwIdO3kkZhmF
 cbdkszcU5JpJfE7uGfEpd7Sx2TWP+87AqG0X6IZ317BLpp5IfSgnfr4aNSn2Fl1h
 2Wyyni2vb73qXj+/BgsL2SZtf9kYxZmrF2Zl7ICEcVGYo0Ej8S+1HHHQ39hm8WH3
 JbvErJe4zPrPPI9pAc2aU5LWfWyEitEnxXiPCpSVL/JWUgw9l0kd1/+hoPlq2Dpf
 aLUD+RZt4HqE1x2yHkWksburNG2ErqUSf3BtmSGfYJwvPDaVTW+G7yOTjKB00IeH
 GW+A==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4ddm57fbwv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 19:24:28 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 7C869D1E1;
 Wed,  8 Apr 2026 19:24:27 +0000 (UTC)
Received: from [127.0.1.1] (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 5CB1380171E;
 Wed,  8 Apr 2026 19:24:26 +0000 (UTC)
From: Jorge Cisneros <jorge.cisneros@hpe.com>
Date: Wed, 08 Apr 2026 19:24:21 +0000
Subject: [PATCH 9/9] MAINTAINERS: Add HPE GSC files and maintainer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-hpe-gsc-upstream-v1-9-2be1fb7cbbfc@hpe.com>
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
X-Proofpoint-ORIG-GUID: 6q1-vH7fxMzWnCdnyVxrm6RnZhFJT55s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MSBTYWx0ZWRfXyuG0h+R4XxOg
 /c2DNTAuAGJJfVO5QkHoUo3lGApOU9VEOzlor5kTm7IFpLdaubb2e3q1SY1SLpqwZTkpDfvjeJn
 bqEZ33d+5RWcJEF98MJjKB8D6k2DhOruH1EQxrBzzwL405pQHOKumesdcmesbfGRrcJlzVN9dgb
 zA4gQXaKhBIsHpJp+2Kwczy5YfJ7yI2Hh5C/8QR2hwL9HrzBBF7hnJW1bwdxTtj1jawpXm6aVJ5
 U+M/kg/Xmw8EZqxhvyrwvS4y/G6y1gbHXHz6RZJpM+3X+8PcHrKqc/KEm/iqAPJABHUtvxsngzu
 tK14vSgVC4iHuaZPFYLv9+dzNgvgaeecEWDby7IXwtUGhovmmjyhM1juTuhfzP6KCucfsVukdx7
 5LEVi++T+R0o5e29CHpwD+QWUZVnip2qqATA1L6ekmWcOGCm0OjVBMg2e3CQ9xIgIvpsP8ZbUB+
 sMDjX1PqIEjDpNZg3Gw==
X-Authority-Analysis: v=2.4 cv=Q53iJY2a c=1 sm=1 tr=0 ts=69d6ab6c cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=_ZmgHqWwjZUDpi_pur5s:22 a=MvuuwTCpAAAA:8
 a=ekVZeIWMJ2JNVtDKdkgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6q1-vH7fxMzWnCdnyVxrm6RnZhFJT55s
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
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

Add Jorge Cisneros as maintainer for the HPE GSC SoC support. Rename
the section to 'ARM HPE GXP/GSC ARCHITECTURE' to reflect both the
Gen11 (GXP) and Gen12 (GSC) BMC SoCs. Add file patterns for all new
GSC-specific files.

Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
---
 MAINTAINERS | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d2040fee252..70e98732c16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -334,18 +334,24 @@ F:	arch/arm/include/asm/arch-hi6220/
 F:	arch/arm/include/asm/arch-hi3660/
 F:	arch/arm/mach-histb
 
-ARM HPE GXP ARCHITECTURE
+ARM HPE GXP/GSC ARCHITECTURE
 M:	Jean-Marie Verdun <verdun@hpe.com>
 M:	Nick Hawkins <nick.hawkins@hpe.com>
+M:	Jorge Cisneros <jorge.cisneros@hpe.com>
 S:	Maintained
 F:	arch/arm/dts/hpe-bmc*
+F:	arch/arm/dts/hpe-gsc*
 F:	arch/arm/dts/hpe-gxp*
 F:	arch/arm/mach-hpe/
 F:	board/hpe/
+F:	configs/gsc_defconfig
 F:	configs/gxp_defconfig
 F:	doc/device-tree-bindings/spi/hpe,gxp-spi.yaml
+F:	drivers/misc/gsc_mem_eeprom.c
 F:	drivers/timer/gxp-timer.c
 F:	drivers/spi/gxp_spi.c
+F:	drivers/watchdog/gsc_wdt.c
+F:	include/configs/gsc.h
 
 ARM IPQ40XX
 M:	Robert Marko <robert.marko@sartura.hr>

-- 
2.43.0

