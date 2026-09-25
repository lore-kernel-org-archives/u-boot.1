Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9D3C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B22081109;
	Fri, 25 Sep 2026 14:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLFIEWdrkKOz; Fri, 25 Sep 2026 14:27:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 562D480BDD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346438;
	b=AWddWg9t1Ec4jz7RaTCXCYNqQpkS68m1hF1KpZAQyAjzCv2Q3qYTjgzN/gC9W4GxOm9B
	 DeV89mMY07hAO0A6GPbGwSfhhrg07XTgco+pCKvot9F4BqOWpkfYja1DJlUKItXDrBdj8
	 OrpbDqMqZaj+m7AxC857B2SmENC4T+xU2DH+lKHp0TuenmWsS19bgiquT0Zl06K2FDGSa
	 ltedQrjGvCUXj6UdSORhBHsx9w+ajV6fSzsDQd5nPky84LicvOScJm/HjnzbqPTgeqFAf
	 Ht7giNH9925rq+/LjD+Y1gfTiWsb+XG/DRyjyT7dJoiMbLjXInT8DPly5FSw+P/FV8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346438;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7noL0Cv97k4+w4n0sKg3Oxu9gHqYf8OunRPvfyJq5vs=;
	b=HXr+y3FLyQy95hOLaQq1il5EZgH3V524TMdzLA1MSNJzxbj/XdU+m30yUe6e0UmUuR8W
	 W0EhwD7wYcdd90XkSfbeKJzExbV5s2ykjk4E7DVu5ikWEn8no08k6dN2ca80gfAcB/DyU
	 6vEl/b526W0abW2DUaseIBh9Eg7rmdBiK2EUVC7UqDF71i+3rTLeu0wsZyhdHa/50gnJS
	 ymtMobuqCZCiFA6s7Vh1JnWzYMZt23m8/gzfGfILS2Bb40+ayh+/GQYnL+R5/kvR3NewQ
	 MKFgTroGKACW0lzOu4GTcM0gurPSHsNht7lzc8cM8KAOgxlq2PATSAgKwYVssXLNFcw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346438;
	bh=7noL0Cv97k4+w4n0sKg3Oxu9gHqYf8OunRPvfyJq5vs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KM/FYWEmAEfCkvVJUDSD5RYiJwk6LYyPFC1JpfUTtFtTrt6i39XklAbp26k1Gk4IL
	 X2APhbNAogdMyAXcBrbMs1uGC4siHkJAmLE3XJ9eaOhkylcAJMAku/oW1kkTRWnz+G
	 SHTSqq0DOQPuHiQchmOxGlUkeZDnutJt+vWtDGqM61MWrUB/1i7zhnJ0wwBilZUzgY
	 Q1GAOdtMnKw00IvtWpzy5b6EPGhqspMtfiSojmk3cm7+Uv3BJyn7jtScnyX9u5HmBJ
	 EwDGUuKcmqQUd7GA8S0JzOcLCyR8+QpwyEKd9un2CsxW/Ig0UEqCrzyOHhCa89duz/
	 Zl/R8v4mouhMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 562D480BDD;
	Fri, 25 Sep 2026 14:27:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3151A334
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16FBD60D6D
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZaNEw8GnreBC for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6159660C13
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790341108;
 b=DDdyj9W8QWPhfoJQzVuY2OYz8ZfHB2QolqFfw7hqAyQNTQH5pF/vocHb83VdkYlemEXA
 tFy/jeFtYQY7g5MXeiHACj93t9zovI9Blv17aCBdWvqBWHMOKoASzlsBPiJHSyhO5F63t
 tjQjnSnUJb4ve+fntTVmr4wNaARVcBiBYdkTaazY8o18eIoT3UiIC1MWM9gIiJ2CPI339
 Xd0bN9PZ7J28oAl2L/MvaNZIfhXmAgU4atu32hnT8OP9d9Bnr+DwgvOMRQf++dGBbaYMi
 S7XVEHkIa3GUqsX4URNDIpBiO1/ySXmBGZh0ELFxbU3y67f8+EPfb3KKCvmQFSw1uWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790341108;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=7noL0Cv97k4+w4n0sKg3Oxu9gHqYf8OunRPvfyJq5vs=;
 b=KndLLxXKf2bzuZc2puT2Gq+DKRHoUAhP/TNnUgJ/lqcfWg5XnT1s/89Q4SPTcc35B46Q
 nLZkLQ4ajWZVtLwGNUluguJv1SgOkklbOX4I2syhqtK8cWKls4pnrVwQqgekagdJtoHUx
 zBTa9e+xt5xH6VIRySwxRcGQncJMVbQyHVYICAdBN+/r+c0VHtc9kMFaQJxIP8OvURFHO
 4OSknleYBy6BsCm1+JmnBSHFbrATeANiU6EX3Aw9J4oaQGZjIwz4Nh/oYUMsa8U15KgMp
 cVNo/G01XAPXJ1d/dGAOyXDef7YIBaDWOAEabLuNV4ng9GR3jUiAKPsQMpSR0fIJikg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=qti.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CUJVuXLz; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhiv@qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CUJVuXLz
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6159660C13
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P5JDa43627520; Fri, 25 Sep 2026 12:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7noL0Cv97k4
 +w4n0sKg3Oxu9gHqYf8OunRPvfyJq5vs=; b=CUJVuXLzg5QajmvrcKA/NjMT4xH
 RjMiQjyXKMRR98Tbvyu3laUohkQXZbI7TnTZE+gxN5kS/20PPBOP003mLs9WKoKv
 lw4pnPKUQVdojm6Jl7/2H/Fc1pjnf2tzZkN2ldcel0kvVu3T/Pd2Bueor1lGHkiR
 mOOwOIRdVu623O16/FESphJm2mlt5JD7NOVQi6YIIe0z/BkhJjdIbpwD348tkAt5
 Y7l90kvhbkfd+4GDrrQOvSkK3Krgbd15jFwaMs5Sr0KDLM8YPzevAuRnldHSsWQv
 u6rJwTQy7qMI0e+CA+5bFHqwCG6zMNYBvD2DxGxZFa0x8VG0x2sABk8Ujew==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq39da9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCwENY552090; Fri, 25 Sep 2026 12:58:14 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-abhiv-lv.qualcomm.com
 [10.81.94.242])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 68PCwDBu552068
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:13 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4779521)
 id B6EB661C; Fri, 25 Sep 2026 05:58:13 -0700 (PDT)
From: abhiv <abhiv@qti.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 07/12] clk: qcom: enable Shikra QUP wrapper clocks
Date: Fri, 25 Sep 2026 05:58:04 -0700
Message-Id: <20260925125809.1360030-8-abhiv@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
References: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX5Jo3Uz1DSdH0
 nvlujh/oLlK/IaUWvkg87PNnVK4mOaisp2GGCHosbOczPvFD3mmnffRZrZV1xIUWM5+noMOTn/P
 Hz2kHPYxry4qjhB4Kx+wc1nH23qbmt4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX2YV2tniEg7Bd
 rTdCOabrL8EkSckn1mGOVtrC10G076ygPI4tgI19Xd2XLVxYTdzXiOB1gtKJSRqiec/youndFFd
 P5R/lmYPTaJS2RPZEHecZ1auob4QGRC8+pLWgYkJoLXIv+Uk6oU+1josGrpBYehLyn5pAj+r8Rg
 683Lm329R/bj4nOU5JLRKNwyoVvMaTkPJS0+E8+Nis+pp4fNd/z69Sp8WjxWKtyQ7DBq7QNaw4S
 DQiQW/NzJK2hn2Bz+WY1wf3l7mlDu5z1gvhmb88GMMC56Gbq82IEH5D5gSG94bJE0HM98ok8Lop
 pqftwFooo7P6upNAfd6YXU1ZKJjhQJnlepkhOyohte6GoOcjo7Xql1r1NckGnaE2PPitcEb/Q6p
 oTjgOCNnMJAi6C5EbpRYLinDB0W+AfdQf177IGBEe6VNOELqqtEJdu9ZIZPhAwxQgnVVpBwQ61D
 pzcE97hgKbVs6hNUggg==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab66fe7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=mb1s1FuMAeZDaavxsqsA:9
X-Proofpoint-GUID: sTNn4BMY4WBsEcAxpHLxWh6fD8b0mZ1Y
X-Proofpoint-ORIG-GUID: sTNn4BMY4WBsEcAxpHLxWh6fD8b0mZ1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Enable QUP wrapper CORE and CORE_2X clocks whenever
its master or slave AHB clock is enabled. The wrapper
requires these clocks for serial-engine register access.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index 9c803e6c181..ab07613aa1e 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -315,6 +315,18 @@ static int shikra_enable(struct clk *clk)
 
 	debug("%s: clk %ld: %s\n", __func__, clk->id, shikra_clks[clk->id].name);
 
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_0_M_AHB_CLK:
+	case GCC_QUPV3_WRAP_0_S_AHB_CLK:
+		/*
+		 * The wrapper's core clocks are required along with its AHB
+		 * clocks, but are not listed in the wrapper's clock specifiers.
+		 */
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_2X_CLK);
+		break;
+	}
+
 	return qcom_gate_clk_en(priv, clk->id);
 }
 
-- 
2.34.1

