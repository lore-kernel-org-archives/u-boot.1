Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E5606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sQl3PyXL;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eqtHePW6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q96xj3nv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0B3340711;
	Mon, 16 Nov 2026 16:52:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7e8OqZ3q2GlN; Mon, 16 Nov 2026 16:52:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD1DE406ED
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794847949;
	b=ODAU8mg4W2DIdM3FSBqZjIqeg87DRQ404oAxR8PdjZTZt6GAfEak7zu5zrZfKbVp0oLY
	 PR67upK3TlfGUOc8W5z0PuJM4F1pGv9qGV0Ui5H3ZV6X3T2g940BQ74PpjtkHxlnWc2+5
	 00lOjJn2WLR20vYm5AOXvwHZFW/7LeQMkfRAADx/GImhvyVIzE3NaSOE8EFyEbdE7YSfH
	 JAvxLVc62HmsF8bYaEpaa/qz62CG4cwm7IEZU25IkVg1/A+sjRfhXD07PI1KnEHADM7zS
	 2T5Cvn1yY8eWVhlqmDr7cx8WVDE1paNzyGaCSTS8BYVQVHTKE/W/lNhcxXABNpXk4kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3jpJTovELPIBDUGe2Yftb1Wr7TxdNdZ71+uGwmDwWVw=;
	b=RrCsHHo8+Qubc2eXIcKcihBgOV/y3uQv661Kui51YTag6haUlfT6P6Hsifbuo3ODSir4
	 uS1p2p5oYU01XbdZv6oDZseToS4g+YkjaXX1RL3euR7X0uOtZ8EbKJ8AUFDjIYkaLsAYt
	 y1pY5HgKG59/Y0uxH7zaRsR6cZEDjfQq7RRDyNiOaDen33z6Pb3fowTdWfFlkbrtHx0b6
	 A+sW1zSwDcbQmRvQrXqPdTlXffDulS3o9eVV+7wUMVdN1u16LWTAnbK75XpFHkvyaDiZW
	 NNlO3qlJZJk6qdoxXP0jz/kEs1EuK1Y6uyB3YVHg3+IyytovDoCZKpJB9okrApC9oOQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794847949;
	bh=3jpJTovELPIBDUGe2Yftb1Wr7TxdNdZ71+uGwmDwWVw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sQl3PyXLfAKuER1uLvF40tGAcR5g0JQfLHSRJnmF2Dj6fJ5FLhrA/eaasQcPZUgE9
	 kZM63z6NzeYFcLYzpB69HYUW+SKLs/CoIeY3OglL5ABb4Ny94EVHOJ03tuJp6x2ILs
	 E68+Xi5eL4+V8zDUYBA//osVnIidhA4VeZWomfG2FM9NBSC1M3kRA1E60oSE2BbsBw
	 NwNObtoitudGSb5Hm1+Me/zgpPMpMTESlHVCNYm+Amq1dLjpaVFWiFYFm6V0FRHYCB
	 6iLUfYcdx4zoC4KX8cFCoJtDk++zIeqPoRWqBS3grU0grQl3OejJUEbr69JLvqPoXz
	 iprsZOaloDfLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD1DE406ED;
	Mon, 16 Nov 2026 16:52:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AB9D81E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0B6560721
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3mRTmIvdn-20 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:52:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9A24B605DB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=eqtHePW6; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Q96xj3nv
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A24B605DB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:52:26 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGISUs2790077
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3jpJTovELPIBDUGe2Yftb1
 Wr7TxdNdZ71+uGwmDwWVw=; b=eqtHePW6Nb04zQG3F5G+Ev4QlWLZMXdc5Y4LsP
 ROxvz9OYAc7ZXiKEETebRDk0ehf1+SoxDLpieWwCNgiOzda5NCrmUMUfkwfXmMcw
 Zhho8b2Giw3Hdb2zx81E8xI3cXaVKA1c+6Cs/LD0iccDyeZmux7gtw4TXA3m73lC
 lcF1woxuTSdF9pePEPlgD/zdXqJMlcsrn4TX9k8Yf3AitcSudi8GGtErVNjtnvo4
 JCWnWToWog6E7Ek3RxhUJGmneVgbr1lqJmEf/1norj0r43tzKHM/mbZre/0MujpI
 O1g6+fSGZ4vtKgXtbB815E4WV3dqH0Lp4xT8nBhEpVtAgtLQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j00nfhbvt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:52:24 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so4366610eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 08:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794847944; x=1795452744;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3jpJTovELPIBDUGe2Yftb1Wr7TxdNdZ71+uGwmDwWVw=;
 b=Q96xj3nv1Xb9raMqHd3QJ0fBN1RwEM5GOWUPzSq03iwYopv4SFGJAYcV27LDKHC94P
 jm2fDGLWyCKVtpZyZDQwoF2YIcXSM3plImrFBrxywOuqsqKSodPg8pzohO+KJluIoRdP
 1Y10kTAJC2dNwG0idOvnG1fMx5yzmXzzT3CE+rYRI2WWtkBy2lwok2M5CvtESWfZhuxa
 51JjgBobYAQrZJCobU/KfUgpt5LplDfAfpWs4i2+clrELXCIvyJW7CH1yBMnyGkkMpFx
 eAG5h4IQ60CjWcL05SsJIdoWAoimHY/IR7ITIviJCuagXy6OEpzqUdnQEMas+rbtNP3X
 kqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794847944; x=1795452744;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3jpJTovELPIBDUGe2Yftb1Wr7TxdNdZ71+uGwmDwWVw=;
 b=zOdcApbux3hrEVNGpe7bSMHlxGexgXhgJqtYN8PI3xtg/bYtu3xKuK7gy+Bniq7/uC
 uVIvzcvUOIBbjmleW0JRpo+HNKpzBNuYaOR+AWi78i59s1VbcG73uRvAaDKOAFdyK6Qv
 y9NPjxHnuMxArPz9et9ItSKMcXbe5FHX6ekeUi28hYlkwWaF1TKZdBdT9tT5aYTat2Y2
 g7RF2vZoc9+Unu3RmWiq0jkZjM7hjErSMAexmymGzX205IMJouPaMbLpwaQagrCdEFJB
 g5HEG99ZDZLFoYEt0N1Y+w/f5cXY6j8PX1nW8daSz3bywe2S0mqeLoDi1wk+iUUjXmUH
 Gh8g==
X-Forwarded-Encrypted: i=1;
 AL+hErF3U/mEAktwHUxS5u7eWhMx9afQRtFxXe7duNCAVzQMDpDxt4kf+738EpQHXe4OSk9N8/zaq4g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8P1ALMxNRcC4QTzTM0bbDleo7z4JmrsfUIMJdeYCNz9/svTOQ2
 pweMzzS4lt39TBbVnjTxA5cJYv/56NhniJ5UqiPNftnH7NLDgwZ7cSDpAoaEqJ8S2JNUgtDN5+/
 Sm+YDkyb08urnotJGjv+6Dc1N0crAbPxlHvuabrkVLYtoYLhuG5n4KRV2rVUoi6orpMCTKzYwRj
 xKLtI=
X-Gm-Gg: AYBFou0pQcyi8uqFkI1QIOojLWqZ27Kl5QzD+icjYF8ady106EsrjLI9EIaHdrusPad
 f5c9xyqfywq1aOGl6TDa/KWfQyNZzjvPK0rqV99RKLq9xSkC4WO3xC3VwfOH0RPwlkqZclgdTzB
 TPyhULvPle3S67KzVomAbREz+3T+zpMoeuSx5/+FzV8WUZM8ApVNs+ohPwKsh0bsd99SgoXwM/X
 EgjW+rQgqnLEKP8KgwtcxdsxuLI1+cgSpvUJhRTxRK3YL82xZ+8OtmP6PpU0++5rXu+gT7eF3/j
 CvMfa2/2RH9uCtQ6dTiV1nUyqXtK9TUDFLlTgem2gyVFblanDE94MtuRswmZC1onWftKHweVCSc
 8MHfQS1Nib5AOVZnkjmc2rlO0Srz2PYP5aTF+SlfvU2/Dx7au3rkX0mfyBqgcRZSIVgYEvEhriK
 j7xVFbdq80rlfypyWNGzRubLYOM9E/C8UAF4DFVZtr8MOnLhNPdTvsozSLBgzYpTK190OK2S9ZM
 JZb
X-Received: by 2002:a05:693c:69d0:b0:36a:15ee:c20e with SMTP id
 5a478bee46e88-379675fd90bmr11127006eec.33.1794847943817; 
 Mon, 16 Nov 2026 08:52:23 -0800 (PST)
X-Received: by 2002:a05:693c:69d0:b0:36a:15ee:c20e with SMTP id
 5a478bee46e88-379675fd90bmr11126982eec.33.1794847943272; 
 Mon, 16 Nov 2026 08:52:23 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795591f4f8sm35279106eec.13.2026.11.16.08.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 08:52:22 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 22:22:03 +0530
Subject: [PATCH] regulator: qcom_usb_vbus: add support for qcom,pm4125-vbus-reg
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-pm4125-vbus-regulator-v1-1-a582ae58962a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALI0+2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mz3YJcE0MjU92ypNJi3aLU9NKcxJL8It1Ui2SDNGPzJLNEA1MloN6
 CotS0zAqwudGxtbUAjRve22cAAAA=
X-Change-ID: 20261116-pm4125-vbus-regulator-e8c0f37b6a05
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794847939; l=4841;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=pfdfCsDdOFaXuxdTHE67yWnYbt4kZN8rH20iVRVpCUQ=;
 b=ki4VizofFUfyCdOpTZbZzmk1EiLi0+dKQ4BSWzrAcRmuHrf2eLF5wi6zcSEln0gJ0F0rz4fr7
 6bWuwbJZKWwAE897s8xMF0NPuXNF2nTXIHHj+s0gCi8KxDT2fO/Pb1n
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=BrEIUoX5 c=1 sm=1 tr=0 ts=6afb34c8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pPRojBQfMEIOPXmw-iIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NyBTYWx0ZWRfX8mrl7COSEMFw
 po5y94Om9zwoYCpTk2xnPSeVZwWHOYP7U9dwqBib2ouzPyA+poZ1gfpJdzm/rJ2lE35iRCtgsJB
 EkZvnvFoKPCRH/BYD4sLqJnPsI0Biis=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NyBTYWx0ZWRfXwKNQhL4/d4wb
 le/1mfwVmUNhGypSXiyCrjWQ6ekOQ9ENJ13TWo8TDmI+UbOBwHfDKx1uf0g0exXcsRYG6ip1Zfw
 SFpdQ//yyxluS9d4GXFNhohPyKdPHjdx6zguSbwKz5HwnI1MDXR97AeAnKamEG7PFnqgyOhq2Yj
 9Tbj2YXv8klhaUQfedo++BbqHC1V8LBCY3gszT4wYlt1S5env+1DcytRTgVsT7M50Icmg5CQhH+
 JFjct5C2plLobYC/xoiZu4LLIYN7k7JAcmW3Y4CYPmF4Kh6WCdnm7pl91HeaE6pHVbnc/0g+u/+
 9mSNoM78DCy/A0+0JyfSfP/SgjCft5qMg7uraIv2EMxgVjzEUNN1dPPevavJIxWIhblh8I/xueU
 pdQHvTJZiOUh9bPwigR+EugM6VDN1FXhdh0W5xHFoRrHV2moDUxrTZRPq5sjMmOjtITTg9Qbl5C
 bKJDv1Wg3pUdI7cypDw==
X-Proofpoint-ORIG-GUID: 2Wk0eWjf8iqVjLrT_YqRA7zKyL6NrWYx
X-Proofpoint-GUID: 2Wk0eWjf8iqVjLrT_YqRA7zKyL6NrWYx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160067
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PM4125 uses a VBOOST block instead of the OTG one. Add the register
layout, get/set value ops, and pick the highest supported voltage
within the regulator-min/max-microvolt range from the DT at probe.

Taken from Linux commit d37664f99ef9 ("regulator: qcom_usb_vbus: add
support for qcom,pm4125-vbus-reg")

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/power/regulator/qcom_usb_vbus_regulator.c | 82 ++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/power/regulator/qcom_usb_vbus_regulator.c b/drivers/power/regulator/qcom_usb_vbus_regulator.c
index 07f118d4797..adba3376119 100644
--- a/drivers/power/regulator/qcom_usb_vbus_regulator.c
+++ b/drivers/power/regulator/qcom_usb_vbus_regulator.c
@@ -18,15 +18,24 @@
 enum pm8x50b_vbus {
 	PM8150B,
 	PM8550B,
+	PM4125,
 };
 
 #define OTG_EN				BIT(0)
 
 #define OTG_EN_SRC_CFG			BIT(1)
 
+/* PM4125 uses a "VBOOST" block instead of the OTG block */
+#define PM4125_VBOOST_EN_SRC_CFG	BIT(0)
+#define PM4125_VBOOST_SEL_MASK		GENMASK(1, 0)
+
+static const int pm4125_vboost_uV[] = { 4250000, 4500000, 4750000, 5000000 };
+
 struct qcom_otg_regs {
 	u32 otg_cmd;
 	u32 otg_cfg;
+	u32 en_src_cfg;
+	u32 vsel_reg;	/* 0 if the voltage is not selectable */
 };
 struct qcom_usb_vbus_priv {
 	phys_addr_t base;
@@ -37,10 +46,18 @@ static const struct qcom_otg_regs qcom_otg[] = {
 	[PM8150B] = {
 		.otg_cmd = 0x40,
 		.otg_cfg = 0x53,
+		.en_src_cfg = OTG_EN_SRC_CFG,
 	},
 	[PM8550B] = {
 		.otg_cmd = 0x50,
 		.otg_cfg = 0x56,
+		.en_src_cfg = OTG_EN_SRC_CFG,
+	},
+	[PM4125] = {
+		.otg_cmd = 0x50,
+		.otg_cfg = 0x56,
+		.en_src_cfg = PM4125_VBOOST_EN_SRC_CFG,
+		.vsel_reg = 0x52,
 	},
 };
 
@@ -95,6 +112,41 @@ static int qcom_usb_vbus_regulator_set_enable(struct udevice *dev, bool enable)
 	return 0;
 }
 
+static int qcom_usb_vbus_regulator_get_value(struct udevice *dev)
+{
+	const struct qcom_otg_regs *regs = &qcom_otg[dev_get_driver_data(dev)];
+	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!regs->vsel_reg)
+		return -ENOSYS;
+
+	ret = pmic_reg_read(dev->parent, priv->base + regs->vsel_reg);
+	if (ret < 0)
+		return ret;
+
+	return pm4125_vboost_uV[ret & PM4125_VBOOST_SEL_MASK];
+}
+
+static int qcom_usb_vbus_regulator_set_value(struct udevice *dev, int uV)
+{
+	const struct qcom_otg_regs *regs = &qcom_otg[dev_get_driver_data(dev)];
+	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
+	int i;
+
+	if (!regs->vsel_reg)
+		return -ENOSYS;
+
+	for (i = 0; i < ARRAY_SIZE(pm4125_vboost_uV); i++) {
+		if (pm4125_vboost_uV[i] == uV)
+			return pmic_clrsetbits(dev->parent,
+					       priv->base + regs->vsel_reg,
+					       PM4125_VBOOST_SEL_MASK, i);
+	}
+
+	return -EINVAL;
+}
+
 static int qcom_usb_vbus_regulator_probe(struct udevice *dev)
 {
 	const struct qcom_otg_regs *regs = &qcom_otg[dev_get_driver_data(dev)];
@@ -103,21 +155,49 @@ static int qcom_usb_vbus_regulator_probe(struct udevice *dev)
 	int ret;
 
 	/* Disable HW logic for VBUS enable */
-	ret = pmic_clrsetbits(dev->parent, otg_cfg_reg, OTG_EN_SRC_CFG, 0);
+	ret = pmic_clrsetbits(dev->parent, otg_cfg_reg, regs->en_src_cfg, 0);
 	if (ret < 0) {
 		log_err("error setting EN_SRC_CFG: %d\n", ret);
 		return ret;
 	}
 
+	if (regs->vsel_reg) {
+		struct dm_regulator_uclass_plat *uc_pdata =
+			dev_get_uclass_plat(dev);
+		int i;
+
+		/* Highest supported voltage inside the DT constraints */
+		for (i = ARRAY_SIZE(pm4125_vboost_uV) - 1; i >= 0; i--) {
+			if (pm4125_vboost_uV[i] >= uc_pdata->min_uV &&
+			    pm4125_vboost_uV[i] <= uc_pdata->max_uV)
+				break;
+		}
+		if (i < 0) {
+			log_err("no voltage in %d-%d uV range\n",
+				uc_pdata->min_uV, uc_pdata->max_uV);
+			return -EINVAL;
+		}
+
+		ret = qcom_usb_vbus_regulator_set_value(dev, pm4125_vboost_uV[i]);
+		if (ret < 0) {
+			log_err("error setting %d uV: %d\n",
+				pm4125_vboost_uV[i], ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
 static const struct dm_regulator_ops qcom_usb_vbus_regulator_ops = {
 	.get_enable = qcom_usb_vbus_regulator_get_enable,
 	.set_enable = qcom_usb_vbus_regulator_set_enable,
+	.get_value = qcom_usb_vbus_regulator_get_value,
+	.set_value = qcom_usb_vbus_regulator_set_value,
 };
 
 static const struct udevice_id qcom_usb_vbus_regulator_ids[] = {
+	{ .compatible = "qcom,pm4125-vbus-reg", .data = PM4125 },
 	{ .compatible = "qcom,pm8150b-vbus-reg", .data = PM8150B },
 	{ .compatible = "qcom,pm8550b-vbus-reg", .data = PM8550B },
 	{ },

---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20261116-pm4125-vbus-regulator-e8c0f37b6a05

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

