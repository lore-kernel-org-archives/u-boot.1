Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95337C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B3318131E;
	Fri, 25 Sep 2026 14:27:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g0y-EOTszfRZ; Fri, 25 Sep 2026 14:27:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7A453813A6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346444;
	b=DjN+5OZd8acAQV5KxSDUTbxEl1z8xuIdvdJQIY7YNqFEAXGJgr8FOsQhHYpyvswxAzd5
	 dNFmqULJlik0HJ12p+NdOkBTLskFAc0/Q0bkp3McIt+5lSlkh2FH/MM1Ni1UE17S9Bznh
	 atjyT89lwQ3g4tRcyEvqlA6Q2ugiVsdpgNjhxC7GKV+DUxAULmfjX9DO3tghYRyZc2JJo
	 CFOxB3AQJhABHK8WPA43Zp+60e6uUbuNusjSBr8smLbtJ56TIia17Cog13emICM+1Q+V4
	 jnbJ1COzeRvlOBk1bFdRzJnF620xWIlg+9gThD/XIma8lxBgamPJmQ5GO1hLKp7cf5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mWO5md+irjRmol+l291GSWwMEYiH36hPRB2T5ReipPs=;
	b=kb7FGwBdcOq9glPcaKHyJD0mcLujcc9DflFoNZn8DQuRePmfkHSl9T9uk222zU6son90
	 4KmieJupHOrPRcbRdLMrliBcPxaCG+jtZphMzXBb25Hzu8XvPKah5CCh6wnipCec6l+WP
	 3yYHGkvVEc3M0z0zwUMnVcM1vjFNEgx6Njo1K1mCmI8tJdqjvJVWTmCFEYaGpeIne6+xw
	 fjlnLb5czzyRDxKssK3DglaerjP7dxA/dNtGxYbfoIzKQ03m+eXkigXX+EiPtgdRJMiqG
	 Lsf7X/VRZJ9uvsqDT5kN0QuM/h1LEMYDNVpaJVT8eFRVQWTunIHA0DoagyBdX50VdDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346444;
	bh=mWO5md+irjRmol+l291GSWwMEYiH36hPRB2T5ReipPs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YsNqDICHedsndS80rc0As1yY7hTXwPRxMCSpnuYovK1txX+rZgA1aaRT+KsyGBOQW
	 XctikfyaqgxK83cvJczVsc4lmHEg0tgT/r1zMli62D6NqLBQigUXzhXN8hd3Zzrq/W
	 rgAsCiZRDHyQ82E6uJdSy2uF0mvJsQHRv2DGJOLH4KJN8J8ixKk5diI5CBITKRKwPU
	 LASy44HJPrDAcd/ysZsXPLip/xFjIGd7IU4kVwgRUtagYRcy5ADbWv/4/gxaibeqzo
	 JNuFYdcPdLMIgPwoHDrfTg2ELMLnYBzlfCyCSrffj/GQQIP/eKmvO6Gg7+Qbm8wXKD
	 2TAZP5VOnxuoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A453813A6;
	Fri, 25 Sep 2026 14:27:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 98F3B35A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E9D1608A3
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P71NN0TzvmZ1 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:58:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A548F60D5E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790341108;
 b=Yn3zWjHYV6Ym4i8m7voYeeN1uEtI+1V7Huc9/3fNAV0AZDNYEjjEewHdJRePuYncNRKn
 5cCG8GVT2cpTlEhblrXA+u4YJlBzXp5j2tu00lyGldrf/doFTRUGKrwaKylA8pJcKSjPD
 mdfGzGZDTFrp0NFVqmmgnD+vnrUmUSE3mgKEhux3kBy44niaJGEPpwfz8LommYA5GnQ2J
 wqo5ILBhEIm3GjHSCEuL40hzp3xB0mmwulhu905X4WwJ1q+BVrCe2nP1P48r+pszFg4Ft
 zxu1WG95KOCnZOzuZhksmSnv8Xmip1DBKWhxdTbvPnSJGA/Sis9WCuFasAcAyJljsVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790341108;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=mWO5md+irjRmol+l291GSWwMEYiH36hPRB2T5ReipPs=;
 b=J0WD7ZI1B6gSGr4mnkGweUtV4xdZ6Us1bY6oVwxdg71R8u7P4o//3NA2AngtZTtzwN+x
 5p7BL0ZM22VMKahamZTTOrZELJpCUo+geCY09M+k50gWrayq68mvem6sw+zPgRGK++3ip
 VYuttdaiUc09bHqi9FeVYVsi8uzX9KBuGHEIOfnZ3g/tt4WnEfX8lN+34gKimq0WmHSsB
 O/jI/Exhb3IyDACQD0Vsgk9HKOLXoWjgd7sUOwcD2mNnegtmve3m9LLUdX+zzWOC0lzg6
 vVWEzRklSH8aaS5WltZEpJOihLnqKzPvqik4ie81vTgLlvb3BVSOO8DNAqInl0M0DZg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=qti.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Fd3VYxK6; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhiv@qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fd3VYxK6
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A548F60D5E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PA4Df0609155; Fri, 25 Sep 2026 12:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mWO5md+irjR
 mol+l291GSWwMEYiH36hPRB2T5ReipPs=; b=Fd3VYxK6A1MMoNSRJk9QO8cyIPH
 cQvFC/RfXIrxh6QWwmMm8MApNabq6Ch0lMN2iMZVd9DhjSiy/lXaOBk13pjHjObj
 GMDEtXdLK1NXc3sHDnD2qz9zo3NtOu/3Q6PggEiKyYtOf3jtsbyeFK8++Dl9K761
 a34LZmqBrFGtopNBGVGXonYLq6x0knWhySY6weLflTwiTPQ755kFGAxtX1BC1waR
 zEj3yGThLxizezm5BwaCWsgFlii05TC0suNqlPVwXsx3bbfJW3DT/0e5q6k5XMIB
 P/7IRM+ovjXrWNqwdPnFebyFiiPBSJ2k0AjkO7w/++G+inLjmJAYwxjjcKQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvnrg8c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCwEmR518201; Fri, 25 Sep 2026 12:58:14 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-abhiv-lv.qualcomm.com
 [10.81.94.242])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 68PCwDnW518183
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:13 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4779521)
 id B0C7D61B; Fri, 25 Sep 2026 05:58:13 -0700 (PDT)
From: abhiv <abhiv@qti.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 06/12] clk: qcom: configure Shikra GPLL6 for SDCC1
Date: Fri, 25 Sep 2026 05:58:03 -0700
Message-Id: <20260925125809.1360030-7-abhiv@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
References: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: HvjX2sALDUCArd5-o2NbOlIkU7FKrGyv
X-Proofpoint-GUID: HvjX2sALDUCArd5-o2NbOlIkU7FKrGyv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfXxiRC87Nz7Lih
 D/Ya6xyCO2JBVAioSTI1yNDRxbR5HNjYOF6dS3EslTbA12cwTeJBVTaSRFtzTNt3H1mOYMzBzAX
 ztdj2H5t6WXIrNfYQ819/9uAscD9/gY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX3lMkJSY7DIDd
 5XpdKoZOfS9Y+kFUeMpa46ZloPotBPAifcabu/IbG2SNvTwkflmI16/PYUi92YV7N6O17lMJ9hS
 cI5PKl6TAxwqM1gFmddp/afzo86iz/9IvMVCffSRRZcVgxun6846h/U/kRwjhaNuWH6M1eAwLcn
 Vf9V6q//FFF9j6isKzN2j99iKCMLNOEotxiFwFeGu1u1K7Fi7U3AhmmJ29LAcRCYviPGuoTq/QN
 sWj7AKDJstsiSKGvFWY0ln5JEh5t9km8ZmW/NX49vwdDikRSVo0noDDFHbhJ+xZXbP9QqfBwbtc
 i6yh2ZzydlwO0pFmFiAky5M829xMmexDjcg+XjrP0D32TiMtw324Yrt/Fu8k3lKrY/T+dkLXXbL
 yyUw+nsy7Mtfu8B/HOwx6cYe7voiXmEOve3x1gsRl1+isWw6hwVHoQoFwpUL8fcqp/L1CvTsZR9
 GfTmiE0fjHyZ9q+sOpA==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab66fe6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=OZbkP5GewEWn0qpCw8wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250051
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

Configure GPLL6 through the common FSM-voted PLL helper
when SDCC1 selects a GPLL6 clock source. This provides the
192 MHz and 384 MHz eMMC source clocks required by Shikra.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 61 ++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index a563e85cb02..9c803e6c181 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -20,11 +20,35 @@
 #define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
 #define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
 
+#define SHIKRA_GPLL6_MODE_REG			0x6000
+#define SHIKRA_GPLL6_ENA_VOTE_REG		0x79000
+#define SHIKRA_GPLL6_VOTE_BIT			BIT(6)
+#define SHIKRA_GPLL6_L_VAL			40
+#define SHIKRA_GPLL6_USER_CTL			0x01200109
+#define SHIKRA_GPLL6_USER_CTL_U		0x00000004
+#define SHIKRA_GPLL6_CONFIG_CTL		0x4001055b
+
+#define SHIKRA_PLL_MODE_ACTIVE_FLAG		BIT(30)
+#define SHIKRA_PLL_MODE_BIAS_COUNT		GENMASK(19, 14)
+#define SHIKRA_PLL_MODE_LOCK_COUNT		GENMASK(13, 8)
+#define SHIKRA_PLL_MODE_VOTE_FSM_ENA		BIT(20)
+#define SHIKRA_PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+
+#define SHIKRA_PLL_L_VAL_OFFSET		0x4
+#define SHIKRA_PLL_ALPHA_VAL_OFFSET		0x8
+#define SHIKRA_PLL_ALPHA_VAL_U_OFFSET		0xc
+#define SHIKRA_PLL_TEST_CTL_OFFSET		0x10
+#define SHIKRA_PLL_TEST_CTL_U_OFFSET		0x14
+#define SHIKRA_PLL_USER_CTL_OFFSET		0x18
+#define SHIKRA_PLL_USER_CTL_U_OFFSET		0x1c
+#define SHIKRA_PLL_CONFIG_CTL_OFFSET		0x20
+#define SHIKRA_PLL_LOCK_TIMEOUT_US		200
+
 static const struct pll_vote_clk gpll6_vote_clk = {
 	.status = 0x6024,
 	.status_bit = BIT(31),
-	.ena_vote = 0x79000,
-	.vote_bit = BIT(6),
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
 };
 
 static const struct pll_vote_clk gpll7_vote_clk = {
@@ -84,6 +108,29 @@ static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	{ }
 };
 
+/* GPLL6 configuration required by the SDCC1 clock in SPL. */
+static const struct pll_config gpll6_config = {
+	.mode_reg = SHIKRA_GPLL6_MODE_REG,
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
+	.l_val = SHIKRA_GPLL6_L_VAL,
+	.alpha_val = 0x00000000,
+	.alpha_val_u = 0x00000000,
+	.user_ctl = SHIKRA_GPLL6_USER_CTL,
+	.user_ctl_u = SHIKRA_GPLL6_USER_CTL_U,
+	.config_ctl = SHIKRA_GPLL6_CONFIG_CTL,
+	.test_ctl = 0x00000000,
+	.test_ctl_u = 0x00000000,
+	.l_val_offset = SHIKRA_PLL_L_VAL_OFFSET,
+	.alpha_val_offset = SHIKRA_PLL_ALPHA_VAL_OFFSET,
+	.alpha_val_u_offset = SHIKRA_PLL_ALPHA_VAL_U_OFFSET,
+	.test_ctl_offset = SHIKRA_PLL_TEST_CTL_OFFSET,
+	.test_ctl_u_offset = SHIKRA_PLL_TEST_CTL_U_OFFSET,
+	.user_ctl_offset = SHIKRA_PLL_USER_CTL_OFFSET,
+	.user_ctl_u_offset = SHIKRA_PLL_USER_CTL_U_OFFSET,
+	.config_ctl_offset = SHIKRA_PLL_CONFIG_CTL_OFFSET,
+};
+
 static ulong shikra_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -91,20 +138,16 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP0_S0_CLK:
-		/*
-		 * ftbl_gcc_qupv3_wrap0_s0_clk_src[]'s last entry is
-		 * GPLL6-sourced; vote defensively even though this port's
-		 * only requested rate (debug_uart_clock, 14745600) resolves
-		 * to the GPLL0-sourced entry.
-		 */
+		/* The QUP clock table includes a GPLL6 source. */
 		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
 	case GCC_SDCC1_APPS_CLK:
-		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL6)
+			clk_configure_enable_pll(priv->base, &gpll6_config);
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
-- 
2.34.1

