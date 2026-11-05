Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C6606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gPwacE4O;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iMyyZoqM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aHR1uGug
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04D2640827;
	Thu,  5 Nov 2026 09:58:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MNc4xlgTVO2O; Thu,  5 Nov 2026 09:58:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D680240821
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793872719;
	b=aMo6SIKafu70CaWplX81Suzn9Et8vDSE7Lmgvq218HxV9IEntqz7AcZ8+6QRzfOWn+AB
	 FR4VDIjNHLU0HYPtllxAqUCKbxZBO89is0VyzC4oeWKrywpV/cW9gT4Eh5I73xZpKB1ct
	 cPxQUptzV6bQlIlY0wCYqUbhQXHjiYipfngtP01Q48cmbTmu4jlUNrDb7cHSeEahRnK+C
	 Yqyx6ha4xe6M+0+u9JaTvMW/kfmbbTEnAOHDnD0GhANLT+zz1QVdAjMiOJH8NDDpLd0yi
	 qsSNWL76EU4PUzwRj2R1N9Q4XJROOxdsG4ytL19F13epaMzXsry3zflYBL0vpULgLnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793872719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EOpBDlJxhosPVxqFYrEJVVPTgS7+/keEYfHw+y5SE3Q=;
	b=r87rjS9rOZLzZg1r/TrmQ9wPV1zue02gEVl+Fl8TyuY51Wh6o3l0I2nQ4+Af3D3181z5
	 OSKWU23HXBeBtVspDDDvYj9uE0eMuYZu/Oywnen3hZ+pwaH7smcl9adXBXwv0fzSdAsZm
	 xwX9kpuL4m0arTgoBe+tDRg2KejLAGPOvr0r2NSpELHarnYpAswHl4p0L/k0X2WSaXWju
	 4PqphaBo/tNrGvqkofR8zrN8zvOjKya77kBY04ZpkaotG7ZNvMWYziUXXxUbmEPAfWO55
	 qV1/RWAbYpuK9/Wc2/8QY+pimGoVASf2jv0EimWj52sYZwcZOjkJhEUNSNjj6MlKa0A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iMyyZoqM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aHR1uGug;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793872719;
	bh=EOpBDlJxhosPVxqFYrEJVVPTgS7+/keEYfHw+y5SE3Q=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gPwacE4Oqm6SknredhmZE/NNovaAfum3rADESQ5j9U1lt91/ZcQjAUGvwBXXZw9RW
	 8Dh98uvBzZSo7zHoTxqDuKs0hKm6+okm+lQWDX9csZkV/Ryb9VG4sKCklCA0Qgqrqq
	 uBtgfxFydg5v5owfBQUWFBNcxbcRBZVlvJT17yxv4DGpQj0ROzEJCPm3pGD9+DgOIn
	 ImymuLzHUaLEqkUG2wThvYpBNrFAvEVdO1oS0IDCDgsHwR5fzNgmHb/OTeoxdoI5U2
	 pTgf/P+L6bfsSAhlVjCXpQIYKmGHrFtgYX0oOskpKNuge5MtBeRU4AQ5TOXLJmPlaR
	 PjBAaQyLx0TVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D680240821;
	Thu,  5 Nov 2026 09:58:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 529DEAFC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3808240802
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:58:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b8k9uFwSXxoC for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 09:58:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B1C0407F5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=iMyyZoqM; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aHR1uGug
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B1C0407F5
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:58:34 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tFU0082962
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 09:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=EOpBDlJxhosPVxqFYrEJVVPTgS7+/keEYfH
 w+y5SE3Q=; b=iMyyZoqMZHv+0bSYiJ/E3e4zFWyEDhqPoQ1mdbaX8xUQOTHgPCL
 /b/ss3mkfDdl6e30Qd8pqLRyl5JDprVirZA3bJ1DsbvCWQobeGlRsORJBvfN1LOG
 G5ysYFF5FG4pn8xr7jofxoYXbZ8yzr0iCIYMwiPwTvzouzPRtR8QTny2oNlFI1af
 pRGTNuD+V1CcarBZc6g/rj9ZNN4mK/4JfUeoAFmp2bEA1+5MSvdQAZGYOA85OoFA
 jteR43TKu1gdCrqgjeQG0e/SY/sJ0CCkDAMXVS44jWHZJCtJq23lDZSFRIYjXI5E
 4TfVBjru1h2bRCBjnHRk5v/FQEebGMEHeIw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq1p05dx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:58:33 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so3671271c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 01:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793872712; x=1794477512;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EOpBDlJxhosPVxqFYrEJVVPTgS7+/keEYfHw+y5SE3Q=;
 b=aHR1uGugULKh6RUfR39gcboBTn1zaM5R4ZdVxpheM0qYJHBZ6XkzitZu0ChdWrE1f3
 BvCj4TMlExvnDuByu7Dp+FB+xSczbjeOHLTDVZdXXSn8mRAu3MohmeVKDJmk73VTVeAt
 B6dl/ssr6hyLh1vJIRzzMOYlTGIjX6FrYVRQljYiHsmgWbGIgZcEoHGbFJ3pjsAwglKz
 ylSOSd/lgTx8HSYE0ZXA/QXfKx3a3XfsxxiMDvO63CgJ4+AqW8/Dgc4y1ncZaR9KsOST
 MIC6R+8H0V3D1+J0i3TA+fcmwR+d3CRpllzBMGWIjN9HS9kRZOrZfiUxTn8e9wgpKwTg
 48mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793872712; x=1794477512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EOpBDlJxhosPVxqFYrEJVVPTgS7+/keEYfHw+y5SE3Q=;
 b=zUcfVQFb6SA261vIwbpCpUICJVKmBuLTTZThNoK/H0TI73hEbnEsLLWRakcjW9+duH
 7oV4LvJnl/Q1MS5wRIqus3HrkcyQ+2Ztiq7wiujdTrSdpA0R9eukriC5ThKROyMhD+F3
 4ZlIpcDJkxFQ4sSmjurDuBrNpnahs7yjfCjOE0KDIoHARSw2a/x1wIasnIl5j+MsiYrj
 yjcBlLVhh+VUg1qXTR+DgI3D4HfBPlJZpgO5nQGfB3H7TBuu4P3DprVvxoCgXw8SGbxr
 IgD2Yo8mo7VG1zq0WGV54hr0bFFCdZpiD6Xzi9tufLoinUumgrhDw+WGGsVvpGCcABwo
 SlQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0cg6ru3yu9ua3fcsdoZWwwpLq9PJngMGWEgu/lF4qFJnOEtO6k3hM8j2U2JloDGshC8un0z8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+lNWWScnxj3w4VFftNeCIbNls2BdWRhrBesP7l8uVsXzeF17BW
 6qy9ZiVvOhKg0AL6BXlsP+pzboFz5ktkxEaenDDFekhrEnOqxcF5qNKu0TxgaKbZu8MEQ0TYjXH
 An69yTuhisbeyfglSk/deJjKLYOBRdNJkByWrx6/4lrFIo5gRF4moHrq39kw6+sStKS10oDQ=
X-Gm-Gg: AYBFou01DvQyAQmVAmKR/LHBhGY8m+o91i9AcmjR85U7dvxcfUhBLNMIhGf7r17XRmy
 ATFoYLpRctvTmekle+EPkHWEtLwe6r4YJgNgr6VXYc9iYl+b0W8WTyOUylJ+zN0nT7NSyLnFVWk
 mymg6jyHLmBiXSq5BPzc00pRM6faSxdT/YXcszi9XvblmzxsyOQn4AWd12HLoTDYKf5FtbgsF2T
 va4vy8FlfqMqao1mgqIBGBIl0NsVqcaQD84Klcpnc3tfOJqSzyFnp3FnoM7/ERBuAWaS09e6/sO
 DENZrBLr5n3gXcnfbAtswsks48PPlcVziJfDdRisgyhy1BCWhBhIqmJoh3gbGoTHEFAZFuYBZDw
 H1KK1KK7awDgxPg6uoJqGDWBCh9EoTeh5EhmkMacOcVFDrmU41RUUP4vlA35pcwUoGEq2qLBeQK
 mbC/CrOGMrmkban03irNoq9MIM06UZgqLSb1m80dUbILimCCKTI4l56N1kRmozDzExNcznEA==
X-Received: by 2002:a05:7022:1181:b0:154:e9d2:d741 with SMTP id
 a92af1059eb24-1ac5bbb4870mr24318094c88.8.1793872712139; 
 Thu, 05 Nov 2026 01:58:32 -0800 (PST)
X-Received: by 2002:a05:7022:1181:b0:154:e9d2:d741 with SMTP id
 a92af1059eb24-1ac5bbb4870mr24318055c88.8.1793872711576; 
 Thu, 05 Nov 2026 01:58:31 -0800 (PST)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245ac2f44sm15844487c88.0.2026.11.05.01.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:58:31 -0800 (PST)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 lukma@nabladev.com, Michael.Srba@seznam.cz,
 badhrinath.s@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 nathbappai@gmail.com, nikroks@mainlining.org, jbx6244@gmail.com,
 xerikasxx@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v8 0/3] Add U-Boot support for Qualcomm IPQ9650 SoC
Date: Thu,  5 Nov 2026 15:28:18 +0530
Message-Id: <20261105095821.3009544-1-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AaYkjHXG c=1 sm=1 tr=0 ts=6aec5349 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=AckDw2-rnu9HBJosMKEA:9
 a=vBUdepa8ALXHeOFLBtFW:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzOSBTYWx0ZWRfX0zXq39hfqEMD
 opnOiKSUSALAif1OCLaj6RCbjmXvwHq3rn4aVCnjyJ6qfTcVzJb09ynL11sJBcKRMpo0n1XIfgG
 ivgJFtYTzZNyw3i9X2b54QIOHRwrO77SVGdqZKf5flAKRb8Az49dtzWFge0BBLbgHk36/1xKkp2
 XXuxpcmdddSa/kQayz+7Onic5xuOY0mQ2QrrTZMRsONUePVI1C91lPPFBKDOTTiwMyd+Gs0nu57
 lqF7eSjsiHzEc3nrLHaKmAXR3WYH7jsNliwv/kS1+FHmUbUY7YGh5utjK0Frf1OfSDJhzbu50hZ
 8aEt8ET7bXRO23A7nT49cArh1L1BMW4z1b3Tw04ibJWX3zFmLy0jAFHG/E2WoGNSh0Eass0+cLn
 huGbd9Ql4mOGVRKzIo+iDQGLI1UZV8JU0ONpJmNNro4ZhOMH+/aO68uQj6Ljd2MkrvuknLOlVHm
 RkFFKitrTj4ZnGhTbFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzOSBTYWx0ZWRfX94mjMM0f+nbj
 bGUtcQHq4MuKM1iTgLMnE6bEhvjK3dSgSVNNr7I99GnDIvgXWpeX2lmiYxlQkkjqEuMS5xikcmk
 3aUwtIAYLuAhKIIwbKTF32GCztU/CDs=
X-Proofpoint-ORIG-GUID: FNwh4Rxa2eiQfo8zQMG2NFjkTU-I3Rrt
X-Proofpoint-GUID: FNwh4Rxa2eiQfo8zQMG2NFjkTU-I3Rrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050039
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series adds U-Boot support for the Qualcomm IPQ9650 SoC

This series enables:
- Clock control via GCC
- Pin multiplexing via TLMM
- eMMC boot support via SDHCI
- Serial console via GENI UART

The relevant DT files are available in linux-next [1].

Testing:
- Successfully boots to U-Boot prompt on IPQ9650 RDP488 board
- Serial console functional at 115200 baud
- eMMC detection and read/write operations verified

1 - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq9650.dtsi
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq9650-rdp488.dts
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/clock/qcom,ipq9650-gcc.h
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/reset/qcom,ipq9650-gcc.h

Changes in v2:
- Fix SPDX license identifiers to GPL-2.0-only across multiple patches
- Address review comment from Ferass
- Link to v1 https://lore.kernel.org/u-boot/20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com/

Changes in v3:
- Removed the sdhc node from this patch as requested. The SDHC-related changes will be upstreamed
  separately by the kernel team.
- For the defconfigs, the common IPQ settings have been moved to qcom_ipqdefconfig, while
  qcom_ipq9650_mmc_defconfig contains only board-specific options.
- Link to v2 https://lore.kernel.org/u-boot/20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com/

Changes in v4:
- Renamed qcom_ipqdefconfig to qcom_ipq.config
- Removed optional DEBUG_UART configs
- Link to v3 https://lore.kernel.org/u-boot/20260716062318.4121929-1-badhrina@qti.qualcomm.com/

Changes in v5:
- Replaced deprecated GATE_CLK with GATE_CLK_POLLED in clock driver
- Return qcom_gate_clk_en() result directly in ipq9650_enable()
- Link to v4 https://marc.info/?l=u-boot&m=178471712422519&w=2

no changes in v6, just respin

Changes in V7:
- Rebased to latest top of tree

Changes in V8:
- Updated clock driver
- Link to V7 https://lore.kernel.org/u-boot/20261009122736.1185878-1-badhrinath.s@oss.qualcomm.com/

Badhrinath S (3):
  clk: qcom: Add initial Clock driver for ipq9650
  pinctrl: qcom: Add ipq9650 pinctrl driver
  configs: Add defconfig for ipq9650 RDP488

 configs/qcom_ipq.config                |  36 +++
 configs/qcom_ipq9650_mmc_defconfig     |  18 ++
 drivers/clk/qcom/Kconfig               |   8 +
 drivers/clk/qcom/Makefile              |   1 +
 drivers/clk/qcom/clock-ipq9650.c       | 164 ++++++++++
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9650.c | 430 +++++++++++++++++++++++++
 8 files changed, 666 insertions(+)
 create mode 100644 configs/qcom_ipq.config
 create mode 100644 configs/qcom_ipq9650_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq9650.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9650.c

-- 
2.34.1

