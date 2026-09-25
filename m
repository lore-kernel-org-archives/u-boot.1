Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B6FC98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D7EC60E08;
	Fri, 25 Sep 2026 14:27:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CXWwotSWLtg5; Fri, 25 Sep 2026 14:27:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 11BA860E01
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346430;
	b=WYDRhXDzRJxGgK1JnCvYHqHitXjXnJ4lhmQHaqN4jYisxjLNBto++P06lFpn1+FqqfMV
	 GOZaT19mU2mK471aGPEyj/H9JwYw14v95poWDw67IOa4ICi5SFGQT+0UGie89Wd1aHLFP
	 RdBbviq6iN/InET1SDZUFYw6lQ8Ot5lWpyObQm5hwnL2rDUJTVhMF1y2UL6gQMsjOqMZ3
	 PF7JKX+pRXp9lKZGZRXOVFqG/FXbGbA6dv74MYp83RVicYuf6H0jPpTuKjferPv26muJM
	 ONCe2Cdu77/ofr83ABofoRmu2vHCpc9Ej+Vc44011mr1UN6M3PJHwQlv8XANVo9jj1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346430;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZwaOccREeAaqCRH7v2y4WON4hQuYCKI/tH99B/y0RLs=;
	b=qjXQd6XE45AOzF0z1OmEqKhlPqKRdUgImOohXTgACjrc6+afSSwo7VKpGKgPcPSMe9J4
	 L+42vu4Wd6wKS89fAjtg/VVONCmAn0LaJzwq3w3BcgqvStUr5EiTufPZJLCOu97+YFYgg
	 Jtm/xiF8N1bnYNJx4ibpYiETg1R/o0d6Hw4fiF2/KbRwDgd42uF1qZ3GYjqt02zilp5JT
	 MN2UM4d/JYSszBAP/VMXGxd/6y+xIzvgm0/Bs1FIO0uqBpmkKMGhlZov/gdWSeZee7LYQ
	 GEhS/LOe9gbS39nnOdDNXBDoU/PB82r+QW2qWFEoiYfCme8/cGvKpKEvJOwHmFmubZA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346430;
	bh=ZwaOccREeAaqCRH7v2y4WON4hQuYCKI/tH99B/y0RLs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ahTT8PeyWbVYgCVlVX7/yoeA+Wm65nFiXy/PhygeojsY9oUb7OPNpTZYIeLwo8a39
	 E9lbwT1MvvHJQJ6kljGCwK9Xaq6rw6dC14F0j2IOtT3bh78VZEi5yrjtxrS/rfLO6E
	 xZ3jqScorMOvt+HRroO+bZRh250yoXwH9sg45zyvsBMK5KSVIbw1o7NWY09CRpbD0A
	 i+wcLoZ6745CRHkgMyZsHN1UKH3NXxspv2/MYXRhy11GMUGF+GRCGrRTAcJreiz2d/
	 uahhPkMVCGkz2pTNIyYFXn9Ze5/QIM6UOFTAhSntkq2zPdYDW9XiEbW/tyNorwJiLd
	 i+7LtVUbXhBBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11BA860E01;
	Fri, 25 Sep 2026 14:27:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7296EB00
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63FC740B27
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7x1Igq_jZ-g8 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B01FC40AE5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790341107;
 b=a/YBz+e9Fyr1kjeOB7ZqrBQnXrhueOGLqykZGLhI/pYHYKNK072U2YbKWbWvFG0Zsp/G
 NeeMBOvh+aOApd3Pv2Wys7xWLik3TI2LPyCifHlnQ1jCNKoZdREwZmPebDOq9DPI0jP7B
 lH2jEF8MaBJAAaAGnnwIuUZ3Y158QVtBcrl50YKzkaGsVI6M8cVO3sdScH6W3jJUcG+ko
 FO7+GQ02BoBnYJqj+i5iRVHRH/a2dE4e0EeetxRHzP6Z7e3vC0h/9Aa8pL5eyq6uyg33M
 JaS6Ry8BTgsgKqbAYnx8nM8VoCUqSQFmnnnWXvNHNPgTY4W2NRYj7yF4Yz0cxyYamXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790341107;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ZwaOccREeAaqCRH7v2y4WON4hQuYCKI/tH99B/y0RLs=;
 b=qjseLa0EwSq0yZn/jL4LgbL4oc94943uF/q2L9ptIsSYjmrJU0pmmtxQThc9hIifxK0u
 wbB8RY0+q1DLpiUHZPKeCN8/tz4HynmSQZBMzcuo7UtTQI8DxN/FnbG6bZzSzzAq2zG8B
 WONSK5VlN+QHIuGIfK6sc8jfJSnveLFshuQwADFUr0MaXfa0yKBxOFiO5mlj1SOTPTZ3u
 UIZ80QqKYI5vUZLjgVrkmYKIQDdXeb6Epi2dVSVr/cNCwx47Ngw4CsTn0OPNVnzOpl6YZ
 gxSibJKM63QuhJ1weQyGwyZW1At2Qn+tPCoHqqN5QTkMCZ0pZosXNhrbONwiYH8MlgQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=qti.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=b4kTWETu; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhiv@qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=b4kTWETu
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B01FC40AE5
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:27 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P5J2tW756679; Fri, 25 Sep 2026 12:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZwaOccREeAa
 qCRH7v2y4WON4hQuYCKI/tH99B/y0RLs=; b=b4kTWETuTLyrYfQb3HScXbl9NlF
 nz4QHFdlejwA7bNpz2gz6SA+cTbBxioOStSB5b4lX+4HQfe9m13gaMxpGqbqvLjd
 +dfKXZnRpHoZJj0hYpwg7C92tjlaU/R2KaRo9+r7pyvKDYuvCF5nv9+oEi6fgQSU
 xDpYSzNOpdOA7TMQdFm92tctgsy7PK4Uw24s82FyH6r9qhn28ERo3mx24e9zxMcD
 m6Fy8qb8QZoLNnpN3796L11Y38q2i8n/ezkQ83OkPNOHX7TrHQexff+sxa3fyqpO
 jc+xXHU2XVHyezL1i9lu2BA2VX2fe8OyK2JCb5V3XwL6SFiEBlSJLnbkUqw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq09ct6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCw7sc517529; Fri, 25 Sep 2026 12:58:14 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-abhiv-lv.qualcomm.com
 [10.81.94.242])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 68PCwDxS518049
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4779521)
 id A7BAC61A; Fri, 25 Sep 2026 05:58:13 -0700 (PDT)
From: abhiv <abhiv@qti.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 05/12] arm: dts: shikra: retain QUP firmware dependencies
Date: Fri, 25 Sep 2026 05:58:02 -0700
Message-Id: <20260925125809.1360030-6-abhiv@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
References: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX9YInWaihw3z7
 akcjxBM2VLNuqerhVN5MwFWVUEa1n4GiQVLFof6NRkt3n1j97FZlzrSVecWTi9If8WjtnArOHE3
 6GYMs5C+pESdxyaI3TNFdb1AHP8Xa7U=
X-Proofpoint-GUID: g9O1hl2CyKv-8QyNPshkl2FDakpn9tiH
X-Proofpoint-ORIG-GUID: g9O1hl2CyKv-8QyNPshkl2FDakpn9tiH
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab66fe7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=2C0Fo42jjqOf0kNrVtIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX78FIV24++HaQ
 idguevbwsAd7FJ2Whjc+X7pop180blb87cYiOnP4/Wi4BDXlhd806GZ1NSlY0VkvcpN1JoOkqWW
 HCtr0tUvzgl5Jgovemwuyo/HxqGp7YSJyvW5RAlBvKqHpEND5cfxByGNEYm0ROHSVq0agITOn8b
 cxu0daxRzdiA+ahcA1OjUdmd0VtkbVz7MNbYRnFVvR/0IuayNrRPTivAGTzK1uq80ZuDGIRDL2j
 4b4lovXq2uShc80XuOURTZicWDFvoois5iBujCg2KnkT6I5tin9x8FjmNAhOFGtxWd8eZI8J/bj
 yQ7jyulAY/VgFtUP1E9C55ABGSeeHDWmZVZbgtwFJDFtKH75IamUb6oRsGQ+3uUoIaGXNSoLS1/
 HzdP6IWEs1xHLsg09RIVWVcYE94n08fx3RCjls3TXRym2kJYUuXcg1uD/KXLCGLuHEb7BS8hEaX
 GmtzP2IWQa1W+LC7YhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250051
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:47 +0000
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

From: Abhilash V <abhilash.v@oss.qualcomm.com>

Keep QUP, storage, console, pinctrl, clock, power-domain,
and RPM dependencies in the SPL device tree. Describe SDHC1
as the QUP firmware storage device.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
index 056268a009d..12519649c20 100644
--- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
@@ -25,3 +25,46 @@
 &{/soc@0/sram@c11e000} {
 	compatible = "qcom,shikra-imem", "syscon", "simple-mfd";
 };
+
+/* Keep the console and QUPFW storage paths in the SPL device tree. */
+&gcc {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;
+};
+
+&qup_uart0_default {
+	bootph-all;
+};
+
+&sdc1_state_on {
+	bootph-all;
+};
+
+&sdc1_state_off {
+	bootph-all;
+};
+
+&sdhc_1 {
+	bootph-all;
+};
+
+&qupv3_0 {
+	u-boot,qupfw-storage = <&sdhc_1>;
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+/* Retain the RPM clock and power-domain providers for boot consumers. */
+&rpmcc {
+	bootph-all;
+};
+
+&rpmpd {
+	bootph-all;
+};
-- 
2.34.1

