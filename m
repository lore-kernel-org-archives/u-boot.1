Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422F6CA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CF8160758;
	Tue, 13 Oct 2026 05:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RVtbsbcmLGi5; Tue, 13 Oct 2026 05:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2ACD460743
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869599;
	b=tdRnIBRNluxIjubD1iUuTa/vMZ7Id3LhorHKNv2w8RMfHhLFLmW+YDs9RmR1f9yKJmD2
	 8ZWhUWewOllfGgzn/314gfQqJx5wAwPA5wLV2QTwTP0inUOYlWsxB8Ke1zrTIQvMFB8Pv
	 bRnY5GcKVfHpYUPvg03OAjvhd0Wjok5sBBPVRelEJQQZCJgdPyE1+lJe+FDAtJwicgyeO
	 DQZbp/jc8fS0fwDibgxWIdR/Z5Pd9rcwgxalXdNM0tmWtJCN0w+I97c0EQT7UZEBkhLRm
	 s0S9l3msia+oCtSSYZ6i7MQdt1l5zx2T5SaT1L4cvxjTxuOpETNt/EQX/yPcg7v6Dog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
	b=bdGaRoqNuEoh8+NCHFhmd5Sg1f7caXPyJYE4A7vI5NR/vd4tB7Ag1hJoKYHTS+SVcmvU
	 8smRUiSaD0rD+ZzeFqI78XkIMVkMlWLJEwswTjq36oLDSDGw1q0+9ZitxBZcU1hCLT4xp
	 UBph+qO0dJwvvI3bZImTcbDn/p93ZT+DDBVzU+ol4r8sTW7EjAeAlCeTvo8HlfCYBTfMl
	 YZE8hQy+30p0+leXVuwwomfGZ/pywi8JrClKlCJBCkCO+k1aWLuZ9hPHjTRnLevfw9E9z
	 3TkxTUuLQgr5QdV0OocMOamC4tsXlmi/QOxuomzlvjn931bSGZH9y4gjpJem67oL8DA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869599;
	bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b4uZo3G5czVG1Tw+OSsTHojHUmtgbL0aw7neZ2o3ke1gm8w6fG99b/5PmWIAYuFWB
	 wMM6CPA/yS0up+QdSHXIjIe2o9o7YqmpEXmuzHLmMHK/hMuqTejg58YHoo4Ipjd2FQ
	 kqa3U8Xr49FJ8LWd5MHur2Y97aehPjgD2sQDb3dWCSx+NXQkMyt4Rbq3qUtwfmnuak
	 QnN/2pIMAejp0SJBqA/nNVhgJe5SJnofLlPy+oGa15b8qLfMzV2FnIOwWYd35PrvlH
	 KpDxk+Evaxv1nELrWWUn37EA/Cq2b612b2+v8SmFxGeGSAiYbi3Qsms/MQH0RB3uzu
	 nRBHJ4VyAzYBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2ACD460743;
	Tue, 13 Oct 2026 05:33:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C1C37105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B12CA80C77
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pto9tKyPsQBT for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E9AA080C75
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869594;
 b=IEZmsO1V3yVR666EHJaxs8kTnTvyQouHjh0FsMaQffhMVRueh8VxuMMsa0XM3x18vP82
 +XKKDhY5xYDx6eVDV5Ak2lJ1eIWeZGZz5bUKRxSHaHhZjlVY1bVClzNyYZQfnk9Ks07dm
 4VHRgZCHyKggqaeKXU6HM4CZHA6udzXaMnN9r9y1rYAhTUNfbpfe6AloS1omSK19h0G+n
 562icQGVLpvQISaPGwzz8WC3HSJD9EgLAwJbS6RYdF523/yX5FKKGsxBqyziXxdGj4sRr
 HwEI1RbNLQJnsbSvsOPVZFJfVpDv1xVprDazM3MPs9zBTEZdk4P6WFGGPbfYazoH5mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869594;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
 b=TZSLLusIH7iE14yiipix77ur6X3MSjWeX58yIC6Sqm+aHr+5SmaBAttNafMRcxM7DstV
 IFP6/SeGiTf4J20iZFZBV1aORA7/lRXkpjIYaCfo4A9H3/YVqRz4YkIWCiO/IDtN6t3Vs
 g/fkgzfSnkqJjVHJnWyHWP9An/caeq8ceXLDlDA52gQ6cZbmtYozXQa0L7mleFfvcPugZ
 yKXuRMhRFxorZHsqvKXY8DJiO4O56FcbUbS5nRL4J+UcLYeROFiwxSeC38XlhVelpwFBK
 61PTqbDfMwnn604ra7t6jvJAeYzcakw/rjoeZlREvPOjn66fIZnxr0h/zZU9w9Y95Ug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ijzL0E8t; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FDx0uX6z; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ijzL0E8t; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FDx0uX6z
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E9AA080C75
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:13 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D45xMv173444
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6yrV3JbZef4
 GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=; b=ijzL0E8ttl8JC5KtI5H0MVBVbM5
 wvy7WCuZMverNE3fo5y9euiFEGethv4cmmCmuYJThYkyg23qKYACkmGmczpY+hP5
 NkD+atEZXXs5JIdhf4AurGHKOscdcGYcMf7fnCDLEss7KamMmRTbAdRLXlyOpqoS
 CN4JO23B3uXU1+KjnuFWOQ4Q3/Nv582JUWGjP/DolgTesDPC+knOK9yYHkZJCs7c
 YLBgPf6ibVc1BhLVrQ8/axy5ixTPLAhGcMQSmzK+GFDQVESWiNDA0RwoRLSy9+1+
 PehtoStHrUEJijz0bMWFPwUXYCC+Mreoi9NVuGLd6yoEHYg5bXIYipqwQBA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9daqr8tk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3592749a017so2297129eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869592; x=1792474392;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
 b=FDx0uX6zrTPyBuVv2y75gCmUbc+Lexgme6ij+IcKHwZ4QVG/N6N+hnuwIyYtZo1PYD
 5xQFIK74fMbxVuJgTHFBKkd239u3+gyIKefQLs0eWpJ2/pj6U8IzK0fEAqY5C6Nbco69
 hwey/DZP8Dqsgq2iL5nCtHbdqW1D6H8CKpgz796CFqMV2lDJILjwGuN3YPt+PQjRK8/i
 JzWakHAk4eBPBFJr+qVCCS2q4lwsjgEcHRSrPScaf6KdLs1lrakRqbFZvt97gXrJSRSN
 3n/OdqSJoF3LYbJ69Fw/yL1Z8cErzksyIBKFJyf76SYruvehalnVeGYCewCVkaM+eb61
 kuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869592; x=1792474392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6yrV3JbZef4GknAEhuzi7ZTQgr2H5RFwpAIrCaXjAds=;
 b=lrobyK/Jr/7Ink2A2B1Yim1IXsK7KZODDOLyzGrWDLdx2mlNun7VAznf9HofxeBIjI
 Cqk9S5Jm1V7J/9DB4sPtToZReg7ezZ6wNhNN0UbUHuC3hc8af6IO+EZVEuLCccNgB8fg
 F00M7tg9wXhXVvHA8Crxyoy98m7RfOQVHcjBAe4cizpdtaFDAtZFStwvdOY45Zo/d64c
 shIimetPKYa7D5wIocbGxHwLUiF+ciRacBUofK79leTUGvguULwAMpAsbkoCYHYyf88n
 IyxCXVI4U99tgk109wWmfBNLeDRBAfOsMtPFa1LEVd//yi+sSEWiyvMNXm9YvehFzYrW
 YJrA==
X-Forwarded-Encrypted: i=1;
 AKwUvByabkmcX71FlD84xtlBaDbQ/c7UnMfYdXuPZunQn6ef+k2kJ6oTv7gaJ6OGygM+EzVBW0PSjEA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKsJ74zV/G0ygyWg3p1CNjC0KFEvbG5lE20jYzEEvuEjkq1Mc9B
 9H/TSfw0jCLLK2FnyoVTJ2jOV5jRVNH2SqiBsX2DNL5SUw4/krMu0UmVMZ6yynYXioPrGJFiJW0
 PEnrAZF0LBjr8BMh7VnJV5hngLTeEDLYRLr4np9jQfC8KH/N1GXX19xLs0HXwKr4tfrYIso0O7H
 es1IZW9A==
X-Gm-Gg: AYBFou2jxSp3VkIDrpvIoLnfk7wwADFKPjN3XOa/6RryPAlmZCducnCMehXxXE8o675
 QU8BzOrko3WpfxAiywdQpMU5xje37M6kUs2tvDGzBezEaMl/ZfXlLlzhdcihvqa4VT9pAp5CXtx
 kjP8NYj5CaL/NITrF2K5q+44RxwQxe3ET2ILrn83CvREyrhmGaEYykrd4KB7/bMI3609WFZvp3K
 M9kFU/KtmD92klr3A9b7v7QHsVGhTz7jbdWtEQYGT0y4vXxI1rxICEkenHDSGAAUWreUvbZbgUP
 tDfG7cIkdTDZewnrGIIG/k6kvMiOK1YBqlCglVQmlthfKN7YB159B6wuGid1nU/XKZ47y7loQeW
 ev9J8sG7YCo8y0a4TtsGdpV5BtkhlWU275RCn6+r0HwwHhrc=
X-Received: by 2002:a05:7300:ea85:b0:359:fb64:11d7 with SMTP id
 5a478bee46e88-359fb64144dmr8327525eec.11.1791869591768; 
 Mon, 12 Oct 2026 22:33:11 -0700 (PDT)
X-Received: by 2002:a05:7300:ea85:b0:359:fb64:11d7 with SMTP id
 5a478bee46e88-359fb64144dmr8327502eec.11.1791869591171; 
 Mon, 12 Oct 2026 22:33:11 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:33:10 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 11/13] board: qualcomm: shikra: embed XBL-sec in SPL ELF
Date: Mon, 12 Oct 2026 22:32:42 -0700
Message-Id: <20261013053244.2954876-12-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mxePsRsGHUIfxTWC78-FM7sczYEa7iq9
X-Authority-Analysis: v=2.4 cv=FZuiV5+6 c=1 sm=1 tr=0 ts=6acdc298 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=v_ZaApmAW4vm0h-ULSsA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX1jjG91tg1oun
 50Zcngg1kMENk456nEbL+92VvpchFcSpJB+IkGtqpObdtM/CUprAwm06lGIQIaTWVCzywX5aAgu
 r8P7dFeGdo68O9pV2G8SrMiQOcJ8bVc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX6SLN1AbR98om
 sVW46HtETtzLB4nZJ8SDJXdnOxO+UKWaz1ck96iCl40RyBeDVjRjmAFsz5J/AUazJ9+8aEl0IDp
 nnm80XxECcvF0R++Je2SeWLFdNmR0/QhopBHOwKQAUZyElr4IfgQSFHFTn0CCqz209OdqGltf8V
 J86aYucWQ9cwbfuh4dBFVmbdhAGqO+oVh3CyICN49A+biywLOGGB6P/32FZD7jiiVyt3b3yEpdg
 rA8XKAHU6D7yH+mr+siOMDX2o9a1pJsM7gBTp8xUgd24K/jVF8EehJa3f6ll4gyCDrigJgv8oGr
 VpzZVpx0dqmn+Uz1JZoxnSNFcAKKAEDSOngPjT/eknlCFGtN6C66IqMSRKMXw9ohyi/0K3pB5xc
 CKPVSYDeoUBHyRwyRhNBWMs/u/9KYS6oycUAgGMkyJH6tzbLajZwe0X7Mjdkn6h0K3ZnQ/uezsx
 oqsQ3PWOnFOxNwWMqPQ==
X-Proofpoint-ORIG-GUID: mxePsRsGHUIfxTWC78-FM7sczYEa7iq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130021
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

Stage the configured XBL-sec ELF and embed it as a type-5
PT_LOAD segment in the remade SPL ELF. The linker script
places its complete ELF image at the configured Shikra
address, alongside the U-Boot SPL load segment.

The resulting u-boot-spl.elf is unsigned; external tooling
performs signing after the normal build.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig              | 10 +++++
 board/qualcomm/shikra/config.mk               | 24 +++++++++++
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds | 42 ++++++++++++++-----
 3 files changed, 66 insertions(+), 10 deletions(-)
 create mode 100644 board/qualcomm/shikra/config.mk

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 5718b66cde1..b4fb05eec09 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -66,6 +66,16 @@ config QCOM_TMEL_ELF
 	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
 	  boot rom expected multi-elf image
 
+config QCOM_XBL_SEC_ELF
+	string "XBL-sec ELF image"
+	depends on SPL && SPL_REMAKE_ELF
+	help
+	  Name of the XBL-sec ELF image in the U-Boot source-tree root to
+	  embed in the SPL ELF.
+
+	  The image is copied to the build output as xbl_sec.elf and embedded
+	  by the platform SPL linker script as a Qualcomm XBL-sec segment.
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/board/qualcomm/shikra/config.mk b/board/qualcomm/shikra/config.mk
new file mode 100644
index 00000000000..51480059410
--- /dev/null
+++ b/board/qualcomm/shikra/config.mk
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Shikra secure SPL image generation.
+#
+# The XBL-sec image is provided to the SPL linker script as xbl_sec.elf.
+# The generated spl/u-boot-spl.elf contains the XBL-sec type-5 PT_LOAD
+# segment.
+
+# The input name is selected by CONFIG_QCOM_XBL_SEC_ELF and is resolved in
+# the source-tree root. Signing is intentionally performed outside the
+# U-Boot build.
+QCOM_SHIKRA_XBL_SEC_INPUT := $(srctree)/$(CONFIG_QCOM_XBL_SEC_ELF:"%"=%)
+
+QCOM_SHIKRA_XBL_SEC_ELF := xbl_sec.elf
+
+quiet_cmd_shikra_xbl_sec = XBLSEC   $@
+      cmd_shikra_xbl_sec = cp $< $@
+
+# Stage the configured XBL-sec image in the output directory before linking
+# the SPL ELF.
+$(QCOM_SHIKRA_XBL_SEC_ELF): $(QCOM_SHIKRA_XBL_SEC_INPUT) FORCE
+	$(call if_changed,shikra_xbl_sec)
+
+spl/u-boot-spl.elf: $(QCOM_SHIKRA_XBL_SEC_ELF)
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
index b2922cd2c2c..387b83ae6dc 100644
--- a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -1,18 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
+
+/* The boot ROM identifies XBL-sec by the segment type in p_flags. */
+#define PF_SEGMENT_TYPE_XBL_SEC 5
+
 /*
- * SPDX-License-Identifier: GPL-2.0-only
- * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * The XBL-sec segment address must match the address encoded by the supplied
+ * XBL-sec image:
+ *
+ *   entry address  0x0c350000
+ *   LOAD offset    0x00002000
+ *   base address   0x0c34e000
  */
+#define XBL_SEC_SEGMENT_ADDR 0x000000000c34e000
+
+/* xbl_sec.elf is staged in the output directory by the board build rules. */
+TARGET("binary")
+INPUT("./xbl_sec.elf")
+
+OUTPUT_FORMAT("default")
+
+ENTRY(CONFIG_PLATFORM_ELFENTRY)
+
 PHDRS {
-	ptype PT_LOAD FLAGS(0x7);
+	data PT_LOAD FLAGS(7);
+	xbl_sec PT_LOAD FLAGS(5 | (PF_SEGMENT_TYPE_XBL_SEC << 24));
 }
 
-ENTRY(_entry)
-
 SECTIONS {
+	. = XBL_SEC_SEGMENT_ADDR;
+	.xbl_sec : {
+		"./xbl_sec.elf"
+	} :xbl_sec
+
 	. = CONFIG_PLATFORM_ELFENTRY;
-	_entry = . ;
-	data : {
-		*(.data)
-		. = ALIGN(4);
-	} :ptype
+	.data : {
+		*(.data*)
+	} :data
 }
-- 
2.34.1

