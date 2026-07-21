Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9130EC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:52:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CE8880E37;
	Tue, 21 Jul 2026 06:52:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 92fNgUW802DY; Tue, 21 Jul 2026 06:52:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E80D80E1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784616778;
	bh=N2hqNUgHBwAZFqANTcdYPU/piwxEwINtwsDl5IuS7m8=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qARU5tL5NZW7SBtBCOTkGio0Edvn3OvmNOhONkdq9q66kbxUuTUX+li3kg5JhKU02
	 WVh1TS7ORJao3ByyRDAHq9KSwrTEBW60nudOTRDpt/Yt0mxg5+hTFDEWe5sHREyUMc
	 kARhCGRzv3MwOpO79CF7nkZ1dWPI1J140vO0kks/zJUypsiXFgHtZYp/Jk6QZdnncx
	 9b0f0E7E7SMk7mi0mOo/kiOA52JypmqavHV54a8GXM0KlwVwzT28o7QBFi7UFoSh+g
	 deNo9fjjoreeUOcYMLxG1AmWSd6EMNqaJ6s8fylQfL/GnbJ1VPuuWd5sMzqCarPemB
	 8bNx0kGpwz33Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E80D80E1B;
	Tue, 21 Jul 2026 06:52:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A80039E5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E3FD80E18
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:52:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x-7nSC5WXL69 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:52:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8AA5D80E1D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AA5D80E1D
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AA5D80E1D
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:52:56 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L2T1LN091469
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:52:56 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj01a8ycv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:52:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso6351804a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784616775; x=1785221575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N2hqNUgHBwAZFqANTcdYPU/piwxEwINtwsDl5IuS7m8=;
 b=VO2htZ1/NrhAdtgSBKj5V/RAu9bv/F8xIqoGSEkcnce/ju+mtJedYEkDXUyzObRxPz
 CzKmVNtIWY+gp1T6kihH6nikpw8pROPk8dgH/3HOOJ+ofnNUMku2RHwGj198K40vgJGM
 41ROlzSU0i476WMtYQkdx/2rWvEC0YkosKEz70mwVr9afa9qB7/hjy7vIbq9vh+cX3M7
 mjvLAWzsGA5YuTUkuA+5eV0EkwZ6dBbvn8Tq7Fz0U2H1rppAQHhp1ng9PAU8eMeiXFTU
 g1J+vbrVBRPNU80n4bArLFEtXGHI80XQoyy/yjsITknoEzGU6IG9PB05p1E8vg3R8i+y
 ZRRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2DgFx1GbQvif6uNPQe+gYdsa5OJgZwOh4fYsooHw0HA9GXBeNpRgAPyba0IU3IW+uFweOWPg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyu8MzUf0i3W9DTkDiuzcauphIVpJbqb1SqAuIlCGrhlCTOzPuJ
 0A39/lBb4RS4LKbeysu7L+tpDEqZSv+HqWHcDxX5j82PKB3fFmcd84nYwz1LSSghgPh8cdOZm7N
 uMDnEoGkZV0ASOkQOBHVVNXaSYde8NvXeJ1/UNonAXs4S+RKdIWkAsu/KImmzkCTJnpRU39w=
X-Gm-Gg: AfdE7cl6U1cSAqgwy3XLylqEAwEzmDo3WdODlna5kFfHZuoHOw6d24zOrQL22+NsaAb
 6f/FghxUloQL0rLC+gUSLMDpScV25oCyMuDBWm+T37fjgDJ7XFtfd7d/hSogS00E+xYG+gJC4gr
 5fjpow81Zj7CODv44SN5Kjp1qN+doG+C2rzjUjL4PfhGwyhiAbNRpm1fj35s7I0UoLQam6CWwTK
 euzPn8ARshKB0fWrlTvrlybuAl3qutvMIqQtxob06KwXH/3Zpy25ccMz5zIGpFb7KXbCP/cov+T
 covucQxYjRIwwuXiRND9D+yqPrwDHv6fXlNvweW0bCIhFd+79hpskLGYNtAffjoBOYZq0ooTakQ
 8oX9+Iz/vfDA2yZS42zYBLidh66vTQDpugMd2sdTebsrebd+urf5j0K3e0Ip6ljt+rQEXBLePUI
 WnvDUsxfSTxGZs63d3xSvF2SJYXaI5
X-Received: by 2002:a05:6a21:48f:b0:3c0:9c1a:8948 with SMTP id
 adf61e73a8af0-3c3ada2682amr19163782637.64.1784616775056; 
 Mon, 20 Jul 2026 23:52:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:48f:b0:3c0:9c1a:8948 with SMTP id
 adf61e73a8af0-3c3ada2682amr19163748637.64.1784616774593; 
 Mon, 20 Jul 2026 23:52:54 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm73931642eec.21.2026.07.20.23.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 23:52:54 -0700 (PDT)
Date: Tue, 21 Jul 2026 12:22:42 +0530
Subject: [PATCH v3 1/3] clk: qcom: qcs615: Add SDCC1 and SDCC2 clock
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-emmc-v3-1-35cebc036994@oss.qualcomm.com>
References: <20260721-emmc-v3-0-35cebc036994@oss.qualcomm.com>
In-Reply-To: <20260721-emmc-v3-0-35cebc036994@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784616764; l=4199;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=/jIOfZulbL0tU4YZoPCFuoNm+Ru7SKWr3BKpuCQJQdQ=;
 b=DrteK1qeuuOjwWn+TXrd7TB8S2JeiPp+mInR7BhcClE6TZ56tTmOJ44DiPMQVQcqE+DxF7gIG
 /eG/e7WvT2zBbMcFjwuFP4zqBevC0e4iDApSHpXRts1dvCPiJBIFQMs
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=BL6DalQG c=1 sm=1 tr=0 ts=6a5f1747 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=W_8sr0Nl1AaytH-ITs0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA3MCBTYWx0ZWRfX7TRtQm7xA1/S
 SrDa61X5XOYuCnJI15jSuyqfQwhcbp2xZ3ay5dgbStPfyMZb1X4KwXEql9UPRq7E756MW6vm04I
 /TMuF2e2uwK1jhFNMyJSSB0sW47cFd3NGMGDUIhGnW983UOM0HJ0a5sgZPiBxuJCK1USWIby9PM
 /5U1d36qEDou4VjYoRcpcNdPpUQRvBpPUoZjvHisddvRx8pFwcy1H8K4PX6LRArvxiIrsY6i9Vh
 nKICWk9IsJNkB8GuqbL9TJfWshB+OGEP3pruMA3jD3X1yoY6FWhStVpLw2NrypBiORpb8HWo0LL
 3gpJyW37fJv+CEDu9G56ADQA0nClX2l2gBE7OxZ+XFZX0XMmtACctXEzXt4KNA3wYhUJigQfYgd
 tpOKMFoltz/V6PQFygLdMc1650LyWvo6MpSSvSovfyQKxlVfMF0LyQwZmSCKdh7iPDaks6QMi3c
 Ltg9hPY2kx/ux/HukwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA3MCBTYWx0ZWRfX/oApQxPMW/W6
 PLcNuZb8nBzGIWc9eO+aeHsg3FNzMkrD332TMOvyzjmyx23PwcqJmB0SjhGVVDdmrGovBGPeF6p
 EoKyXD4rVeaYK00EouR8/IqsdvLDhq4=
X-Proofpoint-ORIG-GUID: al0DIIy004MoHcxL_aEQ1IssZQaiqyyt
X-Proofpoint-GUID: al0DIIy004MoHcxL_aEQ1IssZQaiqyyt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N2hqNUgHBwAZFqANTcdYPU/piwxEwINtwsDl5IuS7m8=; b=nyqGqomwYjBLO3Q4
 Gl1zucjVP84UFF56i8Of+PupvIW6H8tFWoC42qfzEPEHoUnjNQQTHEKwqNP53uH2
 184FeUZZoR1Ni3I3WFwu0MEK1MrcKtrW6x8UfyAv3sSSuckgWwFwu3+JyGLjObDi
 /FFzfMjfLTxs3fsAIpFFAZ7LZ6qU1XFTQ7cFYO0RH4cu2BGSjWDd4c8udDrjuAkE
 7hwukpAl9M9meYJq8E3EQW/ScvYEw40NvjxW96yYOCEDWs/aex3qDWy+pP6Xv/oD
 Obi17S12t74Qjk3ApnBHrdLU53F0u1zkXQ0TVqyyGglYdKOzPrGQ0JRnFva/w5nu
 Vq21Dg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784616775; x=1785221575;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N2hqNUgHBwAZFqANTcdYPU/piwxEwINtwsDl5IuS7m8=;
 b=aayaSfcSn915rctCKdQWDPCv5Gm6O+Wa0jy03J5UMSp9gE2SwYohF+OakyXTZTM++W
 rYxEGonqrhUi22cL0SvWd0QKr10OYROL6G+26N627RmoCX/UphOGou9vdVmQG0Dx2TgD
 wnQrYhDWm3zzefCwhnMwCU6jnxQvlg1HkBQ8spprKGX6BjBwP5JO4xdOvkKdG0frQnER
 0tI5w3uxOkeucZ1kAo9Ew1ngmsleRIsfg8oAWI7qwQRNDZi1yIaYZ1VPwuCcHivsWhPC
 vS6wXGHESAoLQ1FEX0VQJDr/mSfOJchqFu9ICg++DxlbUhnRMHrd8GK6Olu7r6EOg9mv
 BDSg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=nyqGqomw; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aayaSfcS
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add clock support for SDCC1 (eMMC) and SDCC2 (SD card) controllers
on QCS615 platform. This enables proper clock configuration for both
storage interfaces.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes

Changes in v2:
- No changes
---
 drivers/clk/qcom/clock-qcom.h   |  2 ++
 drivers/clk/qcom/clock-qcs615.c | 46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 3a4550d8536..9899cd28aad 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -14,6 +14,8 @@
 #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
 #define CFG_CLK_SRC_GPLL2 (2 << 8)
 #define CFG_CLK_SRC_GPLL2_MAIN (2 << 8)
+#define CFG_CLK_SRC_GPLL6_OUT_MAIN (2 << 8)
+#define CFG_CLK_SRC_GPLL8 (2 << 8)
 #define CFG_CLK_SRC_GPLL9 (2 << 8)
 #define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
 #define CFG_CLK_SRC_GPLL6 (4 << 8)
diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index 7b3fe49de9c..e9572951e7d 100644
--- a/drivers/clk/qcom/clock-qcs615.c
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -24,6 +24,34 @@
 #define UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR	0x77060
 #define UFS_PHY_PHY_AUX_CLK_CMD_RCGR		0x7707c
 
+#define SDCC1_APPS_CLK_CMD_RCGR			0x12028
+#define SDCC2_APPS_CLK_CMD_RCGR			0x1400c
+
+/*
+ * Frequency tables for SDCC clocks
+ */
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 1, 2),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL6_OUT_MAIN, 2, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL6_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(202000000, CFG_CLK_SRC_GPLL8, 2, 0, 0),
+	{ }
+};
+
 #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
 #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
 #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
@@ -85,6 +113,7 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
 				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
 		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
 		return rate;
+
 	case GCC_UFS_PHY_AXI_CLK:
 		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
@@ -103,6 +132,17 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
 	case GCC_UFS_PHY_PHY_AUX_CLK:
 		clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
 		return 19200000;
+
+	case GCC_SDCC1_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
 	default:
 		return 0;
 	}
@@ -143,6 +183,12 @@ static const struct gate_clk qcs615_clks[] = {
 	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x7701c, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x77078, BIT(0)),
 	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK, 0x8c000, BIT(0)),
+
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x12008, BIT(0)),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x12004, BIT(0)),
+	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x1200c, BIT(0)),
+	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
+	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0))
 };
 
 static int qcs615_enable(struct clk *clk)

-- 
2.34.1

