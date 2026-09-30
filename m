Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0FFCA5FAB
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A398C81046;
	Wed, 30 Sep 2026 06:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HgN710oNQ8vD; Wed, 30 Sep 2026 06:35:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C0CB98104F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750128;
	b=R1nxnjHwwcWlqHNovYq8U6bPjWf+0vkgkgSWu8jULZzLnQMEDlEap2E4gULvM8SWLM8Z
	 f1aVHGRs5oZqkDjn0FT/ORnTEEf/WZqGcq1K8kQ8jDbH0SaKSNcaD5vyjWuVUurW6/Nkg
	 QR/B+WTmk++Uj+V1l6OQ0q9NYjPKGnyQb360lLHy/JmMghWBY//SiF7HFxYFzYn6/+drJ
	 0e1RXmRjd1LUPmCUSJz8ZTK1qA+AVjexbXK9W6NdCHxlG3tasuA9JkbTmza0CjJp0n+0Z
	 wLdmeaXBMeWcZmxrDw05U+P4rDR5tTGRA7Lcp4nnofGQA8hYBMyFts+IgFrmbbXXs7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750128;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OuU2b/La8IOgmt6Ei4mSlZEx1uxrWJdgxJX6X8P1U98=;
	b=qWwzTv4XEZvgoE1Day3XYAQDVIeEcpNq/cOguQcr4mlfmIdQiGzz5b2F164Sb9U3kx+s
	 AaTn2jiupwzx4bYcOtyNbHa1npfX0LtoeH0Nf7c0CKWric8dRb6pEtUW7ILi/QLruPDa0
	 4JPLYeVmjmXTBnS1ajvUJyIiN1A2VFrOCs/J2qkOuXAcy8JzfJgDCkz+B/avtoJpgSN8c
	 7PkFyLJF0qwM/DmoWmZf2AuPBWm2CdxHGlXP4S5DgQNNTysgcibsCWyCzFqWRVsNbX6Ws
	 GXsgX9vBMWG9mPOlo4StSHWutggg2PYUEfpB0+uu7nSbqCGmVtaK7aQ5WO5E07Ztafg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750128;
	bh=OuU2b/La8IOgmt6Ei4mSlZEx1uxrWJdgxJX6X8P1U98=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fF7zMAXOpC73zwtx3Mq7VUGOUr0lgpHs9MThBQYSMAMjbWouPsgFYVjC3kt1c1rC8
	 iiwpI0/d+ZTvOoqZB3yEeYN2vU81E8+XwjU/KHH5iAegRaBf1TtVRUN5bk1lmKSLtO
	 0dXBZW9E0dSVp5cRg5c4KC+xqoGiFObsgTrNWJL3WkGzWmaalma3Hpzfwu6EAjduXS
	 IfkkL8e9Ir9mzFBtiP0SrKgjkuY1DhNlpBFvB/UcRIJuPh+IMYayf9ciXWHp1rjDne
	 m7BdhdX0MD2yjciUiNNXDn3nTarJc/Fd5N3cPlh4bmytEEy1XOeA2bTPP2sju68WFR
	 oibKYp6EFpV4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0CB98104F;
	Wed, 30 Sep 2026 06:35:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DAE33D8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 724D240866
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zilj3WOdg2RD for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 720BD408EA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750116;
 b=kkgei0Ih6N9MicDOv6thuiwsiOeKhDlAYo7i+Do0mjIF+rltCIpnr5+hU/ZLi19MbotT
 d4i+H68QQGtGt54cOF5lQXzkthUGtKjbfWN5qcngqCtdKIJa8XyV1dJyjLv6pHBNps0xB
 wMtPGYY5etRvrRn4S8Qe4zvMyzph1430kc5d06C3yiJGERQgl8qI6eO72EsrqCEcaCav4
 Zcf9qnahdovYmzk7HuaG90lgbfXcyLBjRRbffQLHqcHTeIaV2wphlKOvKfV0alqrenwlQ
 6PpR/2CccxVDTbApBvteOwazcsh5GXfizqaB1EQAu9nU4eTFhTK0MCeX8SXH6Ew+VEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750116;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=OuU2b/La8IOgmt6Ei4mSlZEx1uxrWJdgxJX6X8P1U98=;
 b=QZDvYSM7GPi59gGpyj4+Yzem+6lTJlF2fYiYM6sE+XCkk0GXqeVoaq/kPhdUfbLG4jcE
 GF0DgQAM9U4a5pSRN0oBaoRY2JZXmeLe9QIuArKaBrqb737ktAxr9KM6Gj2ygK6nvF/NX
 1t5NJvFnzu/ZOQl3rgdTbpyI7nXqwvJjLX8Rf2BFc7nodIaQlIdMeWp+JwFi2sadHQXQ0
 0KSU0UvDrlI5asXpTeQTRHU3C1V9ezYr/joub7xRm8hPU0WZF9vGb09yQWWAXSn8qTJXs
 n+aQwBS8hphAb85cYovKfLdrbjmdUWM4TJk3Ce/niHfkL8ApOO8bRgPghCRev2dozxQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Xxlg+BNp; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CHKM1Orn; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xxlg+BNp; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CHKM1Orn
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 720BD408EA
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:16 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U3VZD81887256
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OuU2b/La8IO
 gmt6Ei4mSlZEx1uxrWJdgxJX6X8P1U98=; b=Xxlg+BNpLRtq6rIflPi8c83p3N9
 Na5ctaD4bd+NbzIGTEghiKN5lVHv4seX32XVI+UnmLstkEbw4aAAXScSOj3RdtPR
 LK7HI5t7iYiAITUg8nA18uzT5KrNQ7krPKigCcr+TOEQyo9RMcF/+w43GPSs44ua
 +PaWz5iWLbhAgAK5Xde/sBLcikda7nyCqhylenwoL8p8tNKVOZmIlgygm+TxNjGi
 1I8tOG38yQ9A0POGb0DZqjyEE7mUZyI+Gp9e9ouU5wOO74g2uIM10JaamrnMbe5t
 LUydrqPOiCQBJLvLKvx4mtShJ3Xdx74e1vNu9V79dWVxQHoxBm8dMbgd75Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn0nkb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so9887181eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750115; x=1791354915;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OuU2b/La8IOgmt6Ei4mSlZEx1uxrWJdgxJX6X8P1U98=;
 b=CHKM1Ornx4I+VyCA8Xos3chSNc4UlMC11tojr9CuelaslAwYGpsuB/AsAXomHJ69OB
 1h4gqofkIsXfCdH1SmyiuI++1QkYa4k/hwUo9r75Toj+dO9UXJOStAFF5CXcLctj2/wI
 K4TNIZPqpZHzT25tNeXzk45pTbEcx1gzv/K9eQeTy1qLZTWK3IISL8bxjTKMyZ1SvxFQ
 r+tfNMEWZo8GrgN2u66aDwDuuPv2WFgGVkxhJqLIauHT3d1cEu3SluzN9eD6YfFHKbgj
 +NwB2uEGAgDwDFxinaflvlwl1jRj2N7kK+T5T+zvHbdbE+UtMwXI/QaFM7pWI613LDQ7
 /2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750115; x=1791354915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OuU2b/La8IOgmt6Ei4mSlZEx1uxrWJdgxJX6X8P1U98=;
 b=dqdaRAWVOEf1lo/FEiphG6px2vCKPMdy1fAng+ZBuwViiJZy0ZO+LMHE972BWTlOTB
 xCQ8bvG32yz1vk4DPIyu/QZaW9msnApszDdI8lUwKMmJ5RF3TUKoh9xGGCIvjNgETFl9
 eLGjG70k9d+PCRmuNqyhGR0foj6HN3rdJ/1JHGP7A6YZ9WHb+yBo/vTBNtXpzCaE2QNK
 gfVaZI1VEAJxPk0hzL5l+C/v9pqc22uIbyloaLQ+sSgh2DF/DDX3usK9Xxg92b1DmOiB
 Hr+asy0lEDz7NOmzocTovrM5SAdMR+SAL/WjzKRee56gJu35bWUmwOjh6RecaT8dmgUK
 lZSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6gfn7Zw/+7nhh6hPgFUXHwTjRitXApuKP631l0iJ5OMxBXr9wPZIHuB9IPrKEVBVItMbVwXA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ2VKlBpvKxbBlzqFXEjObgiao0bfSIVMCMSW7lu3UzOgkbwLAp
 poZP0kASPlTgMEYJZc4vuFnQNQ1G0U8JkOInAfFhksxPWqWR4HcKRMFzWnXdwJPQlvYq6GC7LY4
 u/oNQJo8WVv4eM0Ds58OHP3GPijBefV3aY+2+QGGpG1+kR2TrzkzEpX8A2+T4VHxXMx1jxJufvH
 QlRXRGMA==
X-Gm-Gg: AYBFou3STykX/Mv3cbADsIn8RP6jye3tDFThWxUs2vjJefuKndCYkruwfnAFsw1XpuA
 l/1jjie1bFOzJQEG9ruIyhtjFKGEa/EZxnCLIeP/OdspRTILgi3vjpsYh0Rn8BWtySEgwAK7i3U
 r/NA9iAynV3ube2C9I/TMn5HA0bGl3OEq4PJQjcdt1Ydy3Cr/P1BTPAxXk33Tyj4PV7p2+3zbic
 CAE0uYwvVujEbLq9Mk1wrDbWFqN/sFezPRU4jI7f8ZGHEKmUAJuHe7O4Hf/u9kciKbbb3JdJb46
 xY05YenJOdCm3d5pmbDMgljE0PpiIqCBRy+cIvWOxU+HRdnBjmpMtp84KLEY2CDncKC/i+R5Lwz
 tcaIEZrXt8EGmWOn1mYvhtKG9bolE8SXVXrOgyeHgZ+PBvMkZ
X-Received: by 2002:a05:693c:6393:20b0:346:3fff:727f with SMTP id
 5a478bee46e88-34cdb8e3f8amr656587eec.9.1790750114679; 
 Tue, 29 Sep 2026 23:35:14 -0700 (PDT)
X-Received: by 2002:a05:693c:6393:20b0:346:3fff:727f with SMTP id
 5a478bee46e88-34cdb8e3f8amr656568eec.9.1790750114070; 
 Tue, 29 Sep 2026 23:35:14 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:13 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 09/12] arm: qcom: enable MMU and cache setup for Shikra SPL
Date: Tue, 29 Sep 2026 23:34:46 -0700
Message-Id: <20260930063449.3251317-10-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
References: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abcada3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=f8ITsPQRx6dYy5KBENUA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: vSlYLHeIDush_Hk4pJpsLUoSF7gbYF47
X-Proofpoint-GUID: vSlYLHeIDush_Hk4pJpsLUoSF7gbYF47
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX/O5hss1C7Q9h
 TD9GJB9qCaEXnEzK+Aln2MG+FP0/BJgfNavbf9F1lQPzq9ZacsAnL4URsagJ6LAR4YypjTnWeds
 StcdNpL0mcT2cEjq3rBDen5w6+IVNn9nXWuG++Mr9tFbj6xcaovt602/UbxOFEI9EAiNMRETKb9
 2pOZGpj5MyJtKJM3R8vxqTk6r2E/QRwM9MMICLqenQ+IzRI5CJdq97zc/RYS81L4L4RopO1GeV3
 wk0DQ/FNvPFeeunt2IlObJALeQQAQGRJ9GcT34nKuliF2Ahnfu8S4IoztiZ9OfA1XYJ1if/iyMN
 VKs0GyEhXvmZrFfWbDhrJ0YhnQRieZ0mJa/uetVyRTSac1f0j72xnm3Zi6birnRtr3jmthss+ZO
 te2aJwoY7RxHKiEyItVHcy2IrdnKmX+yKrK6PHSGtthnJDtmMJS5d40MHlIgatF1Fg8LcJ05lzb
 TxFqsamPdbdEoUzkIOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX8gdUnzFMbN5u
 1tetA7qxP5afxq3QNouoxld1CtmftLEYKTK+SoQvGSDuY644M1E3DS5sdy9tnkRRcFxyD2jP4+P
 OYdL6OcBELK7CohNK7jveCtk8ZI0TIw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300026
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

Use Shikra fixed pre-DDR memory map when enabling caches in
SPL. Allocate page tables from the early malloc-F heap and
select the board map through a common Qualcomm hook.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/mem_map.c   |  24 ++++-
 arch/arm/mach-snapdragon/qcom-priv.h |   4 +
 board/qualcomm/shikra/spl-shikra.c   | 140 +++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
index 17c18e5096a..9df522f7a4e 100644
--- a/arch/arm/mach-snapdragon/mem_map.c
+++ b/arch/arm/mach-snapdragon/mem_map.c
@@ -28,6 +28,19 @@ static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
 
+#if defined(CONFIG_SPL_BUILD)
+enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
+#endif
+
+/*
+ * SPL platforms whose pre-DRAM address map differs from the common Qualcomm
+ * map may override this hook.
+ */
+struct mm_region *__weak qcom_spl_mem_map(void)
+{
+	return NULL;
+}
+
 static void build_mem_map(void)
 {
 	int i, j;
@@ -65,10 +78,12 @@ static void build_mem_map(void)
 #endif
 }
 
+#if !defined(CONFIG_SPL_BUILD)
 u64 get_page_table_size(void)
 {
 	return SZ_1M;
 }
+#endif
 
 struct mem_resource_attrs {
 	fdt_addr_t start;
@@ -185,6 +200,7 @@ static void configure_reserved_memory(void)
  */
 void enable_caches(void)
 {
+	struct mm_region *spl_mem_map;
 	u64 tlb_addr = gd->arch.tlb_addr;
 	u64 tlb_size = gd->arch.tlb_size;
 	u64 pt_size;
@@ -192,7 +208,11 @@ void enable_caches(void)
 
 	gd->arch.tlb_fillptr = tlb_addr;
 
-	build_mem_map();
+	spl_mem_map = qcom_spl_mem_map();
+	if (spl_mem_map)
+		mem_map = spl_mem_map;
+	else
+		build_mem_map();
 
 	icache_enable();
 
@@ -223,4 +243,4 @@ void enable_caches(void)
 		debug("carveout time: %lums\n", get_timer(carveout_start));
 	}
 	dcache_enable();
-}
\ No newline at end of file
+}
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 27e5c54e512..c267c0d9aec 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -5,6 +5,8 @@
 
 #include <stdbool.h>
 
+struct mm_region;
+
 /**
  * enum qcom_boot_source - Track where we got loaded from.
  * Used for capsule update logic.
@@ -40,4 +42,6 @@ static inline void qcom_configure_capsule_updates(void) {}
 
 int qcom_parse_memory(const void *fdt, bool fdt_is_internal);
 
+struct mm_region *qcom_spl_mem_map(void);
+
 #endif /* __QCOM_PRIV_H__ */
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index b967b0137b1..9bab677cce5 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -3,15 +3,107 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <blk.h>
+#include <cpu_func.h>
 #include <asm/io.h>
+#include <asm/sections.h>
+#include <asm/system.h>
+#include <asm/armv8/mmu.h>
 #include <dm/uclass.h>
+#include <init.h>
 #include <linux/err.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
+#include <malloc.h>
 #include <mach/qclib.h>
 #include <mach/spl.h>
 #include <part.h>
 #include <spl.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
+#if defined(CONFIG_SPL_BUILD)
+/*
+ * The SPL device tree does not describe the complete early physical layout,
+ * so use Shikra's fixed map when enabling the MMU.
+ */
+#define SHIKRA_SPL_DEVICE_REG_LOW_BASE		0x00000000UL
+#define SHIKRA_SPL_SYSTEM_IMEM_BASE		0x0c100000UL
+#define SHIKRA_SPL_SYSTEM_IMEM_SIZE		0x00020000UL
+#define SHIKRA_SPL_BOOTIMEM_BASE		0x0c200000UL
+#define SHIKRA_SPL_BOOTIMEM_SIZE		0x001c0000UL
+#define SHIKRA_SPL_DEVICE_REG_HIGH_BASE	(SHIKRA_SPL_BOOTIMEM_BASE + \
+						 SHIKRA_SPL_BOOTIMEM_SIZE)
+#define SHIKRA_SPL_DDR_BASE			0x80000000UL
+#define SHIKRA_SPL_DDR_SIZE			0x80000000UL
+#define SHIKRA_SPL_DDR2_BASE			0x880000000ULL
+#define SHIKRA_SPL_DDR2_SIZE			(SZ_32G - SZ_2G)
+#define SHIKRA_SPL_DEVICE_REG_LOW_SIZE		(SHIKRA_SPL_SYSTEM_IMEM_BASE - \
+						 SHIKRA_SPL_DEVICE_REG_LOW_BASE)
+#define SHIKRA_SPL_DEVICE_REG_HIGH_SIZE	(SHIKRA_SPL_DDR_BASE - \
+						 SHIKRA_SPL_DEVICE_REG_HIGH_BASE)
+
+static struct mm_region shikra_spl_mem_map[] = {
+	{
+		.virt = SHIKRA_SPL_DEVICE_REG_LOW_BASE,
+		.phys = SHIKRA_SPL_DEVICE_REG_LOW_BASE,
+		.size = SHIKRA_SPL_DEVICE_REG_LOW_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_SYSTEM_IMEM_BASE,
+		.phys = SHIKRA_SPL_SYSTEM_IMEM_BASE,
+		.size = SHIKRA_SPL_SYSTEM_IMEM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		/* SPL and QCLIB execute directly from BOOT_IMEM. */
+		.virt = SHIKRA_SPL_BOOTIMEM_BASE,
+		.phys = SHIKRA_SPL_BOOTIMEM_BASE,
+		.size = SHIKRA_SPL_BOOTIMEM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DEVICE_REG_HIGH_BASE,
+		.phys = SHIKRA_SPL_DEVICE_REG_HIGH_BASE,
+		.size = SHIKRA_SPL_DEVICE_REG_HIGH_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DDR_BASE,
+		.phys = SHIKRA_SPL_DDR_BASE,
+		.size = SHIKRA_SPL_DDR_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DDR2_BASE,
+		.phys = SHIKRA_SPL_DDR2_BASE,
+		.size = SHIKRA_SPL_DDR2_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		0,
+	}
+};
+
+struct mm_region *qcom_spl_mem_map(void)
+{
+	return shikra_spl_mem_map;
+}
+
+int arm_reserve_mmu(void)
+{
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	mem_map = qcom_spl_mem_map();
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	gd->arch.tlb_addr = (unsigned long)memalign(SZ_64K, gd->arch.tlb_size);
+	if (!gd->arch.tlb_addr)
+		return -ENOMEM;
+#endif
+
+	return 0;
+}
+#endif
+
 #define IPQ_SPL_BOOTCFG_REG_ADDR	0x1B46070
 #define IPQ_SPL_BOOTCFG_DEV_MASK	GENMASK(5, 1)
 #define IPQ_SPL_BOOTCFG_DEV_SHFT	0x1
@@ -55,6 +147,54 @@ enum {
 	IPQ_SPL_BOOTCFG_DEV_MAX
 };
 
+#if defined(CONFIG_SPL_BUILD)
+void board_init_f(ulong dummy)
+{
+	int ret = 0;
+
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	event_notify_null(EVT_LAST_STAGE_INIT);
+
+	preloader_console_init();
+
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	ret = arm_reserve_mmu();
+	if (ret) {
+		pr_debug("arm_reserve_mmu() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	enable_caches();
+#endif
+
+	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
+	if (ret) {
+		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = qcom_spl_invoke_qclib();
+	if (ret) {
+		pr_debug("qcom_spl_invoke_qclib() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	board_init_r(NULL, 0);
+
+fail:
+	if (ret)
+		reset_cpu();
+}
+#endif
 int qcom_spl_soc_qclib_override(struct interface_table *table,
 				const void *fit, int images_node)
 {
-- 
2.34.1

