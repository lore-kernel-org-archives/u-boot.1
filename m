Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44C606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aToIhxKN;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WjLuuZKR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iMKEWenM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67E2060A9F;
	Thu, 26 Nov 2026 19:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3AjTHWUN9wmH; Thu, 26 Nov 2026 19:01:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7C17A6066C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795719703;
	b=LTxGdyb8luREkXbdBXMaQ0Yfcsn7mPecM0xHDVHf0OUsHTkhX22y/R6PZsufTsjLH86o
	 dI9PPmzVU+bUaSyuM3y6rC8dJtOp2vqpxaqUpaPTvXHQGGerLKeeTu6R60Z6Pn6xeW4Pc
	 BrxCR38MY0RZ5l5dx5lpolUmgv/EJqr5h1m9wc84UP4V0a/Dihayzk6pZUFlOTsm/CU2w
	 NV4ocWfNn0Ao6pyYTBeLel8Ki8/6A4FRtwUoMQp5j87N+UbOb3Bgo3wu5Bhx36EPslMl6
	 z5REwx6VDa2zve12KDSDmIyirJ+ugRV6wVSuYnTua8eRVjCsrKg9PSeVx0l3O6X7TMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795719703;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+8bZ4djPdfCPHoYWKdohBJQOVuPRkdRO8qbsH/QEYKs=;
	b=nd42+M6Uay89GOrLbxNsFU46eVqxlfROBxRAXBFsGmxADzC3TST66Pal9YQYVIX5DBjC
	 FOtyT4VlPSZTodb87BTc9qFVf+7NzNOPY+EL3vwv3DJun/7EbgC3i0cghIYK/oI1Gnzfi
	 zkQ93KWfb70mUk+sp6BG/GbmbI7ZHQzZ4vYkPbQvxeWHadXrg8bnwDK1GmZTT5iVshG0Q
	 laqy5LutTIQaIBnjOBKoFzKjixBGhVhaOAugIwbBl2tRzMZy36w1QMujr+YTMEGrD7JNN
	 8Erd1/iTVFLAin4IwbewydZkwkIL2d4XuuTgD0kzyB28pB6e1Hpg/rf37+yg9wle58A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WjLuuZKR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iMKEWenM;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795719703;
	bh=+8bZ4djPdfCPHoYWKdohBJQOVuPRkdRO8qbsH/QEYKs=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aToIhxKN8b4aNjNxREvX3JoSjuGHwQTiEjRMF5wdLOpgS/H8//bIF4em9iC15miwT
	 CD+YonGQE6lAL7EmZ6bWvLKx2JdUFGmM7mm76hJF6pntZ05OuwPchGKpKhuebibqww
	 S73X3awVpIjLJF4hzWcuy/zFoRaskO8QT3Y2O6y+XYfUjzmJpJIrLnr/XR0fUHomuM
	 RYzWFKoLYj06tgb0QjRE/8kBp29B6rFB5HZ+J65ymXl0HG+1uFcQEqcnybarpUUCvj
	 q+uzuRPng4WCIe11BAVSz8KanucQhxZeyqaDws+hH4vWPgzmt3GOqhhaYVKIJvwTKg
	 jdDVLArTcDLmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C17A6066C;
	Thu, 26 Nov 2026 19:01:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E6A9222B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3C3460ABA
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TN9ahlceGUes for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 19:01:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6BC8160A9F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=WjLuuZKR; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iMKEWenM
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BC8160A9F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:01:39 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQFuKBC275895
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=+8bZ4djPdfCPHoYWKdohBJQOVuPRkdRO8qb
 sH/QEYKs=; b=WjLuuZKRD72mkgzrwMV3OVd4USW5xds/1/kYThCR6HLWfpNPS+u
 HTFwMVHcFc8PGuIRKriEgQNIy/Z04RbySzrAQ2r/frzevkw2vUDXL8mKJ9/k39Xp
 P8VcI64GbdX4f+9L60iX7eR4FGmNJ1TqzhUi1zABV6d13kY1VBKY+FwS9GD/buNE
 8jGcYhp4MDjLzFiZhKbypSKN35PHKpGOrZxChd3VTK3SSQ1NKrTdEFotIf8BboIP
 y5EcMsGjTjInuxp8fmIsHc7WiYxBBt8Fq1kLd7IHFO/CikD3R+es0lPvnkAGQ1J4
 k3Mz8GnJcEo2/mhMVZmd65ILQ4myIXObgbQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6hm822de-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:01:38 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b588e4bd7fso2391840c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795719697; x=1796324497;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+8bZ4djPdfCPHoYWKdohBJQOVuPRkdRO8qbsH/QEYKs=;
 b=iMKEWenM/a8NPi9/T5CX6i6W/69PmbHyAh/96jJtrz6slMRd1kxC4NIqXHb4D0NwMd
 NOK45EfDbVJpxOIKVDBb32YfQwqRL+snRlOn2QFnD7I6nttcnUjB/NBRFcn5QE2mboQ4
 szTU2gki5vNz+ELSZAEz5tqWXkIvtUqlJDkVE+NhR8ADVgIHAC97JYiTeve7tlGTwOD0
 wT5nfQoOnyx9N3aMgJfdAJGAdf7Rb+MAwAN687TUAXvJzUBIK7JU2S1hOrhspaduWQsr
 97e9LyCQCKn/k6t8iuHWGKOvQolTekIkGz+C26YrHseZ+GvK4B9P7XjPrMdIXR1TAybp
 jjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719697; x=1796324497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+8bZ4djPdfCPHoYWKdohBJQOVuPRkdRO8qbsH/QEYKs=;
 b=kO7uMxWsY88CfkjLJj4QhtMzX6L0XlQW/LpncdRWVvaa3ugDL+2tleyROir/VhOrI4
 gFdSt5zWD1KTzgowMYi362AbgtEAPOkKKl1JaW6flXAIjlEbO5X/SGeLgP6ZB7ePuNx7
 CWariR7XfIR5wzEHziZKchwmRjKoWdLx1qtyzEn0/yx6HHsGbT0AS1sV6XzKQP8EVeTD
 xjpLm4KvcUzGytwlmwqM+xRdn/idRS4PbKrZuHpqojIB9kz079qq3J/REzD16Yaf5UqJ
 0AwYDxXZs8MkcjwCEEH+v8wESXhNoeMl0ozPtF+pOCss+hLtq5EjpTtHupf8UbM+i4cX
 8uoA==
X-Forwarded-Encrypted: i=1;
 AL+hErFg4+afaxS9KvhuiAImbSYBvhGhdID3G16D6SlygCjNSOIH99ajv4jy4qlLj2HvBQzjHSdWHBg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8fVLoT9SjXrxaQeIHJu9yveO5Eko4tCYburp/DGyzcZom0MviW
 9X9h9mc5wbOWOPk21c618gCWoZx7LDVTstavef/wF89Tjz6A37GKxxJJ4HLnFdpDEjhbPBWQ7/h
 rOqtqLEIndcK8923W31EtHCRjITlJ0Y1WJzh/ELnJXIoABhIa2uGXu0kX/nUeUKTEmGQxXK6TIu
 cy7Bg=
X-Gm-Gg: AZFdTZdFXT9MvgelWMvX2V1LEeRTQc9002ykp83cx2a3rc6HwqDiecXeqZWgEGNCWy0
 +KhZeKUCKD0Vu2hv7Rrd42pTneU9X37Bp144IcBBnxCniNvZHFQHWTll4WtyWTCqVk7Hztbk5US
 iWfJOgq38+I8ANICVvxMN6uq9H+d/JOsl778uAeuG9vz4jmzcAmE+USIfoE4CI+ODAg4lV5pOzC
 7qjoYDfkrVSiQVtALxtvk34jQwnCDtLGT3q+9ZNIkwjdFoH9QQ7T4i6cLFZpJrNHuH7prsptLsT
 jsD6EkywL0ZC9KsfYFwegvYipbqt1MTgSLRylBGDn/Y9NdVv4TZfn0riapYy40jX5TKMpuHuIIJ
 3rGb+cgUqoS053mwe68hS+MAiz7Lkl0MZWtkWh99KAf5UBTzB+sefeIM8xxx699NxZBf+dtt9Dm
 ccNgzQbB+Jggfjhov0TPRgJmbKFmElRWNyrwVP86HRZ32cnCIkwFEcyxE8f1VStlMtquFD
X-Received: by 2002:a05:7023:888:b0:1b3:ad63:b9c2 with SMTP id
 a92af1059eb24-1b5568ee910mr23106079c88.22.1795719697182; 
 Thu, 26 Nov 2026 11:01:37 -0800 (PST)
X-Received: by 2002:a05:7023:888:b0:1b3:ad63:b9c2 with SMTP id
 a92af1059eb24-1b5568ee910mr23106068c88.22.1795719696583; 
 Thu, 26 Nov 2026 11:01:36 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55682d301sm52248845c88.10.2026.11.26.11.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:01:36 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1] iommu: qcom-smmu: derive used context banks from stream
 mappings
Date: Fri, 27 Nov 2026 00:31:23 +0530
Message-Id: <20261126190123.591256-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NHJj3WO0o_w5EEyzuEF6hXSqxzJFOEub
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfX9lkeqamQLZmC
 WFQ2VLZRxn0C+w8xrXD4yBH8d2Coxbzh5UwZMuDpAULIFtdPpK9IDMqjbRNgMipxQrRALFtNfjp
 oxmqhalb8yXIuZC9vtpnIkGxwg1NuZM=
X-Proofpoint-GUID: NHJj3WO0o_w5EEyzuEF6hXSqxzJFOEub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfXyYsGssumvwvb
 vQnEAe0VxgI4yr63o1MtmYc+QpvP/eQoufim/orbLLQ2mySR1unTyQJyqa24vS1Pd3jNSVNKQw4
 YIYfC0A0jdOAghPns2sZFxegDv2fO7yWYPgkmXKqgmeDjt0KWVjUxfZjvoh65wVCADAa+I+nneF
 nXTgSQ2EPCw1KnkBP/6OmAAhAh+iEGx71e5WD+/einliTdFV/c74bQUpN4rGkTvkgknXOnUp5ac
 DZvIfsk3npergpKYSgebIfCQ3J4YLyH3cW6N0nSmeHcL5hVOzUn/31qNU1XZepoI+Pt9/sTU2wc
 xIRLW9Bp5ZeGv57emz25zlpgDQIom0GR07B8QVnF42u5oRl5xhlpQiHunZPJ2H/uHn1uSiY1hcx
 TfsOGlPpxjfAh4nnFOpasjb2I8ZEjHruM4AlLkD0jeC4+CxKbQocyDWEuPCosWfxLegYWmlTEDj
 qXBiDmyk4KGIyHWOlsw==
X-Authority-Analysis: v=2.4 cv=O/usLx9W c=1 sm=1 tr=0 ts=6b088212 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=ocz8Ny-be4e2-HX_-FcA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260074
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

Some firmware enables the SMMU without reserving a context bank and
leaves all CBARs programmed identically. In this case, CBAR contents
alone cannot reliably distinguish unused context banks from those
configured by firmware, causing alloc_cb() to incorrectly treat all
banks as busy.

The stream mapping table provides a reliable record of context bank
usage, as only valid TRANS entries reference a context bank while
BYPASS entries do not consume one. Determine the set of used banks from
the stream mappings instead of inferring it from CBAR state.

Also extend the stream mapping debug output to print the associated
S2CR type and context bank for each stream ID, making context bank
usage easier to inspect.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/iommu/qcom-hyp-smmu.c | 71 +++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index 5b37c21f66c..5043a0626db 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -177,24 +177,55 @@ static struct mmu_dev *alloc_dev(struct udevice *dev)
 	return mmu_dev;
 }
 
+/**
+ * find_used_cbs() - Mark the context banks the boot firmware translates through
+ * @priv: SMMU private data
+ * @used: array of at least @priv->num_cb bytes, zeroed by the caller
+ *
+ * A context bank only ever sees the transactions that a valid stream mapping
+ * entry of type TRANS directs to it, so the stream mapping table is a complete
+ * record of the banks in use. The CBARs are not: their reset values are not
+ * architecturally specified, and firmware that claims no bank of its own
+ * leaves every one of them at the same value, which no test can tell apart
+ * from in use.
+ */
+static void find_used_cbs(struct qcom_smmu_priv *priv, u8 *used)
+{
+	u32 val;
+	int cbx, i;
+
+	for (i = 0; i < priv->num_smr; i++) {
+		if (!(gr0_readl(priv, ARM_SMMU_GR0_SMR(i)) & ARM_SMMU_SMR_VALID))
+			continue;
+
+		val = gr0_readl(priv, ARM_SMMU_GR0_S2CR(i));
+		if (FIELD_GET(ARM_SMMU_S2CR_TYPE, val) != S2CR_TYPE_TRANS)
+			continue;
+
+		cbx = FIELD_GET(ARM_SMMU_S2CR_CBNDX, val);
+		if (cbx < priv->num_cb)
+			used[cbx] = 1;
+	}
+}
+
 /* Find and init the first free context bank */
 static int alloc_cb(struct qcom_smmu_priv *priv)
 {
 	u32 cbar, type, vmid, val;
+	int ret = -1;
+	u8 *used;
 
-	for (int i = 0; i < priv->num_cb; i++) {
-		cbar = gr1_readl(priv, ARM_SMMU_GR1_CBAR(i));
-		type = FIELD_GET(ARM_SMMU_CBAR_TYPE, cbar);
-		vmid = FIELD_GET(ARM_SMMU_CBAR_VMID, cbar);
+	used = calloc(priv->num_cb, 1);
+	if (!used)
+		return -ENOMEM;
 
-		/* Check that the context bank is available. We haven't reset the SMMU so
-		 * we just make a best guess.
-		 */
-		if (type != CBAR_TYPE_S2_TRANS &&
-		    (type != CBAR_TYPE_S1_TRANS_S2_BYPASS ||
-		     vmid != VMID_UNUSED))
+	find_used_cbs(priv, used);
+
+	for (int i = 0; i < priv->num_cb; i++) {
+		if (used[i])
 			continue;
 
+		cbar = gr1_readl(priv, ARM_SMMU_GR1_CBAR(i));
 		debug("%s: Found free context bank %d (cbar %#x)\n",
 		      priv->dev->name, i, cbar);
 		type = CBAR_TYPE_S1_TRANS_S2_BYPASS;
@@ -206,10 +237,13 @@ static int alloc_cb(struct qcom_smmu_priv *priv)
 
 		val = IS_ENABLED(CONFIG_ARM64) == 1 ? ARM_SMMU_CBA2R_VA64 : 0;
 		gr1_setbits(priv, ARM_SMMU_GR1_CBA2R(i), val);
-		return i;
+		ret = i;
+		break;
 	}
 
-	return -1;
+	free(used);
+
+	return ret;
 }
 
 /* Search for a context bank that is already configured for this stream
@@ -333,9 +367,16 @@ static inline void dump_boot_mappings(struct qcom_smmu_priv *priv)
 	debug("  SMMU dump boot mappings:\n");
 	for (i = 0; i < priv->num_smr; i++) {
 		val = gr0_readl(priv, ARM_SMMU_GR0_SMR(i));
-		if (val & ARM_SMMU_SMR_VALID)
-			debug("\tSMR %3d: SID: %#lx\n", i,
-			      FIELD_GET(ARM_SMMU_SMR_ID, val));
+		if (!(val & ARM_SMMU_SMR_VALID))
+			continue;
+
+		debug("\tSMR %3d: SID: %#lx", i,
+		      FIELD_GET(ARM_SMMU_SMR_ID, val));
+
+		val = gr0_readl(priv, ARM_SMMU_GR0_S2CR(i));
+		debug(" S2CR type %lu CB %lu\n",
+		      FIELD_GET(ARM_SMMU_S2CR_TYPE, val),
+		      FIELD_GET(ARM_SMMU_S2CR_CBNDX, val));
 	}
 }
 #else
-- 
2.34.1

