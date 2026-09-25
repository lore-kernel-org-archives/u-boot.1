Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490E8C98324
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:27:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EB7160E02;
	Fri, 25 Sep 2026 14:27:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ntgUy3QfOAjF; Fri, 25 Sep 2026 14:27:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5BEA160DE8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346428;
	b=iyoePQmhFt14cpFUsTqOAk1evVLC3VXkhNTX2eIfvNIuix7e/+p0JhWnDAnVWnnavPLd
	 68CYq00TzJCH0ZsZG0FrPC90F1b5E7Pvazi7YNBZmZQpo3EETH1rhNyO8EDWiCK8FYxwi
	 QRjIAiF5npD7cO5u01RsAdbSIh+zjC5ZQBN5bM/THaBnr3+EBtp3+vX6xoA1es3tLpxI3
	 BsimR1dMLzoZxyvehCBMAMN45Aq/Aw2SaUjkYPev9kr0c27PlhLM+eRKQ0vOjaTE33CtX
	 PrwHKCELwYNwmpbFlKItENrSAAuPs5Nh+PdbXQGwjv8Mvslvq0nlqWfBOKmn1zytgsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346428;
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
	bh=QB0WJI3jUP3YFtAKaLM1YbwsYwYgqthMLI3bu/YNa+4=;
	b=bDF8ZwUEyIgpyHthicM/c5rfveTnrV0kzsGTZhD5Uyh53KjSNIaGeqlYF/EQ8KsMyKuG
	 ewBf9dsq2dn0N3z2/zWzYohDNI7BgVLsOXAZH8yleHpwnvyd0mUBCe6i7WYpp9arp552b
	 6E9wcyb23uRgcs5EhwRwaZCqZhb3B8cezhUfj0yKpKVGFvMvtNrJT3pwy1WbHSEa60oxb
	 oW0aknORMLovv1xRDW3E/Am6uOVeFHEskYgju5sB14d+q3iwNLoewi/vRyVO2hwh4p1lx
	 fTCREDToAcfSDsgjTPValwFp0ftOnr+aqSBSsQT9hOosIrut1Jg2U5wHZmxjTzEnZbA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=qti.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Upyi+cJg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346428;
	bh=QB0WJI3jUP3YFtAKaLM1YbwsYwYgqthMLI3bu/YNa+4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dy8zx8sE85OIvvp8rTUmLtuw/uAirpMBapFOUZaxi9lGl2/q1GHyCCQYUK1cnmeHQ
	 Ugj4t6X2laVU023iBuuwzJ//8nGZP0zWatojTwzyd7m0OE+phjDR7J1yLHGKzDg1Yd
	 iHmjfvC31e8t5pezRle/xeiWrUlEudKhCT3v1EO6gp1oyzeXRBxgXm68hP6RQBIIHc
	 hgM1sY1+BBOSoLmxzOVkGO52489vqkWg+dkEDk9Qevuq4Lf90kKB2mvFp3BA+Hv20q
	 2dPw3F1fOwIYhL6eiLx6+eIr19I8ZmbCsMhFWdJaAAnwnMjNKTXYzjVGlVfvMIT9DB
	 YZxUgKkL/y8eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BEA160DE8;
	Fri, 25 Sep 2026 14:27:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C8F435A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4282160C13
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1nZ24taBu28a for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:58:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5EAAC608A3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790341107;
 b=PuUD7+J+L/WjwdgM0/hlyHY4u+WbS8wxr0Ls5dtXjoe0c7liLNsrf2mSiYnzNySq8tpK
 rz8fy6MPnpFTfAM4vyidirZB5+kCvECpHRE06PFN2FAz7hN2zTjaH7sm9JrChBpe3moF1
 a8P6jYiNzg2mI/X3zMIWMW0y5s1t7QB0u2yL/nEGzhWXDuJEjidYq+mve9KjByrJb+DpE
 BOUKEvDLFH9B9puPz8pHHMeFzZtahe3sPCtJOma4ISb7M6NA5jx45pAQpuo1JlgBcjiT3
 qnm3JYEweUFNpNd8kozuPJdk07cEBGK4P82jJjlSzBQhW7wyIC4YoT1N53gJ8Ou6u6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790341107;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=QB0WJI3jUP3YFtAKaLM1YbwsYwYgqthMLI3bu/YNa+4=;
 b=oEWzEX0iAgOoh+c0l2oPG+hHUpv0wyyFC8KDq04KdU3Wip6L9PTJ/W25lewrA4MNTsJr
 LMtJLUYvFl0O5wGL+2N7pgow6VFaJTPxwWk/iTmzVgdmn4Wluz8fBVht/c6Adhn1EwYIr
 CZlIU8KRVnz9djcK66LZbqzY2K68q5t1NvsacGE6y2q9LpReRjeJghLJzQAKs9OumG1wP
 THfeTIAOhA0iD65VwiBeE70+iP5kFJIBZ2wLOoQndnVus/lgoWOLWkdAGvOWHgMeSx/1E
 JEZ9xyxc7oM34nMX3TirYLHuAHlTn5F6UIpjMXG5racDQqsd37EoIoLnjo9v5U+QdDw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=qti.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Upyi+cJg; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhiv@qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Upyi+cJg
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5EAAC608A3
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:26 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P5J2tX756679; Fri, 25 Sep 2026 12:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QB0WJI3jUP3
 YFtAKaLM1YbwsYwYgqthMLI3bu/YNa+4=; b=Upyi+cJgEAcRaaki4Kp+AuxgARZ
 XzhmAF8Bpw4so+c0mtTwTIRASCG9z81Q4QjNgdUp2Xq8D3FGmC8DdYvwqT5J8mID
 MUfpI2jO2RbhGiI9dtZ4meTEocgJOxOszUgioO69LxNtEG3GF6A3LEcmAVzRUPqO
 KpKLjACtCa4fxpjE5MB8Dim5bNAv3fLqcRxn6iEKftj7rGy0V3vpKCnvFp8sZsjE
 fNGd8xQkcLLUSe6sJap3fkJ9OjzcI6BBnitQPwNpAZsEmhU8SfcOdFtIBUsdBpHb
 7i9Tg/OlizW3TPME4xxnJ3m8cwP75JQituzuf0zLpjDc3YPQBOPBY1kMoOQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq09ct5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCwD9l517664; Fri, 25 Sep 2026 12:58:13 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-abhiv-lv.qualcomm.com
 [10.81.94.242])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 68PCwDv1517650
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:13 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4779521)
 id A07D5619; Fri, 25 Sep 2026 05:58:13 -0700 (PDT)
From: abhiv <abhiv@qti.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 04/12] clk: qcom: add configurable FSM-voted PLL helper
Date: Fri, 25 Sep 2026 05:58:01 -0700
Message-Id: <20260925125809.1360030-5-abhiv@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
References: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX9XqwfFyYffea
 OQau7Qex9ZUqTl51FzFKI5Qa4EwUP09zXu9G4Yut9JoO4FYz8X9lYgaqKlIGVqXk1yaQf2K7sqZ
 D4nMerlF5VNB2W1Sb1LppVm2CyZLNm0=
X-Proofpoint-GUID: 2_tIQURXbOmZ7z-W2eXlM4YUhszq3QrM
X-Proofpoint-ORIG-GUID: 2_tIQURXbOmZ7z-W2eXlM4YUhszq3QrM
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab66fe7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=enMxUgKZn3LVR2H3xcYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfXy9I2iPoPcYtK
 y7DydfRCdYjKcz+rGFA2BcNG6gfS1MMBMzUXMAKjswDfUAEeura61R1gxdJr9TPsh+6xD18HZcQ
 wPLZvNxMNWzpwC/LaniCCX0WEAYX9KGEEsyxcnTfp3MmdiJwVA7QB4nn57i9CURTr+8lzIXgZSr
 wV5txw45suxaYFECz2HaAIhDPVqPi3ZVAhA7T8cgKn1B9nc670D0uw/ZCz0DlInA9CAtMymMzfv
 XeMPL/EJDxLKIG+SwEkTKOg+Ms3mi7wVFtZfdaofpqj2hGsrqwOkABXSda9TC0EnGrG2jWkAn+s
 aVTX5FU4ycjBrN44JYPDKCf6zPMt54QjggF9233fU1sIaPzz4woXsco45ASep653nrylqCfZtpD
 dS6+STJ9YaXXuiKkomGUFithkpzmliQEAO1wcvWF3YlIWSBp3NyH1ukZpV0MElUv764IHMA+tE7
 wMJ91K/E/Rz3EDCC49A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
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

Add a reusable helper to configure and vote for Alpha PLLs
controlled by the GCC vote FSM. Per-PLL register offsets
support targets with different PLL layouts.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcom.c | 48 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h | 24 ++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db744..30127c1fffe 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -59,6 +59,54 @@ void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0)
 		;
 }
 
+#define PLL_MODE_ACTIVE_FLAG	BIT(30)
+#define PLL_MODE_BIAS_COUNT	GENMASK(19, 14)
+#define PLL_MODE_LOCK_COUNT	GENMASK(13, 8)
+#define PLL_MODE_VOTE_FSM_ENA	BIT(20)
+
+#define PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+#define PLL_MODE_LOCK_COUNT_VAL	(0x0 << 8)
+
+#define PLL_LOCK_TIMEOUT_US	200
+
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll)
+{
+	u32 mode = readl(base + pll->mode_reg);
+	unsigned int count;
+
+	if ((mode & PLL_MODE_VOTE_FSM_ENA) &&
+	    (readl(base + pll->ena_vote) & pll->vote_bit) == pll->vote_bit &&
+	    (mode & PLL_MODE_ACTIVE_FLAG))
+		return;
+
+	writel(0, base + pll->mode_reg);
+	writel(pll->user_ctl_u, base + pll->mode_reg + pll->user_ctl_u_offset);
+	writel(pll->config_ctl, base + pll->mode_reg + pll->config_ctl_offset);
+	writel(pll->test_ctl, base + pll->mode_reg + pll->test_ctl_offset);
+	writel(pll->test_ctl_u, base + pll->mode_reg + pll->test_ctl_u_offset);
+	writel(pll->user_ctl, base + pll->mode_reg + pll->user_ctl_offset);
+	writel(pll->l_val, base + pll->mode_reg + pll->l_val_offset);
+	writel(pll->alpha_val, base + pll->mode_reg + pll->alpha_val_offset);
+	writel(pll->alpha_val_u, base + pll->mode_reg + pll->alpha_val_u_offset);
+
+	mode &= ~(PLL_MODE_BIAS_COUNT | PLL_MODE_LOCK_COUNT);
+	mode |= PLL_MODE_BIAS_COUNT_VAL | PLL_MODE_LOCK_COUNT_VAL |
+		PLL_MODE_VOTE_FSM_ENA;
+	writel(mode, base + pll->mode_reg);
+
+	setbits_le32(base + pll->ena_vote, pll->vote_bit);
+
+	for (count = 0; count < PLL_LOCK_TIMEOUT_US; count++) {
+		if (readl(base + pll->mode_reg) & PLL_MODE_ACTIVE_FLAG)
+			return;
+		udelay(1);
+	}
+
+	WARN(count == PLL_LOCK_TIMEOUT_US,
+	     "PLL @ %#llx [%#010x] never locked\n",
+	     base + pll->mode_reg, readl(base + pll->mode_reg));
+}
+
 #define BRANCH_ON_VAL (0)
 #define BRANCH_NOC_FSM_ON_VAL BIT(29)
 #define BRANCH_CHECK_MASK GENMASK(31, 28)
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 9899cd28aad..47930ae9d5e 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -36,6 +36,29 @@ struct pll_vote_clk {
 	int vote_bit;
 };
 
+/* Configuration for an FSM-voteable Alpha PLL. */
+struct pll_config {
+	uintptr_t mode_reg;
+	uintptr_t ena_vote;
+	u32 vote_bit;
+	u32 l_val;
+	u32 alpha_val;
+	u32 alpha_val_u;
+	u32 user_ctl;
+	u32 user_ctl_u;
+	u32 config_ctl;
+	u32 test_ctl;
+	u32 test_ctl_u;
+	u32 l_val_offset;
+	u32 alpha_val_offset;
+	u32 alpha_val_u_offset;
+	u32 test_ctl_offset;
+	u32 test_ctl_u_offset;
+	u32 user_ctl_offset;
+	u32 user_ctl_u_offset;
+	u32 config_ctl_offset;
+};
+
 struct vote_clk {
 	uintptr_t cbcr_reg;
 	uintptr_t ena_vote;
@@ -107,6 +130,7 @@ struct msm_clk_priv {
 
 int qcom_cc_bind(struct udevice *parent);
 void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
+void clk_configure_enable_pll(phys_addr_t base, const struct pll_config *pll);
 void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
-- 
2.34.1

