Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E61CC6B09
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69F5F405E5;
	Tue, 13 Oct 2026 05:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id felyFV7tKv13; Tue, 13 Oct 2026 05:35:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67FD6405B2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869737;
	b=pmerRV089EAAnZq3m9xKp5GOMuoN4HeNzqYSCingDgFT9qpu/o6bbfgCzJlh+uxQkQTz
	 PyyTNt19PA/DdDHWvsAy6hhrpLuwunAZh7eX0bl4iWTFANKPYtytIeUGrQzQfHlP/+z0B
	 CUZYYes0Gu+BkLsN0K80jwL2RjYlWrPX+y2ZX7Z98LFEqbjJtKz8ycpXNw1dN56HFbgz3
	 rZiN11fhEWkT6G8uehTNyK7xgo4ZV6gou/Vv56JwovBHtxzmhlUeyqRRJJyfXPWmLqXSp
	 z1LUSDVe66aWKuKFp8soIDO4JJDNql7kUIwNoYNAKZ+vNLZuIe5ebhuedJeEOXhQpNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ef1lPxaD0A2YeCbnEKNs54LHf3AuPsz5/FAuSyFDHuw=;
	b=Zkhq1JKLUxM5xNtkL/tsaWlCbz7z7VYU2ihDfM5zndmQlyU6VPMnZmYaXJpmnhH4rO/Z
	 4ceEpW5JxPC23Fl89KVChA7cQcd27rRWS4vFnRqPsdtc9r+7hXmyBpGpWIvHVWNV33bzE
	 CtWPDcT5cwHrC62OLDm9EylPbxkzBhHUy4fEaUrfLlkTF1eBxf/vYvsa+sFrQ2esPHvBl
	 pUlb4XdWvCtm4zzu8BLwyGLHG6vfpRtgMrAY+AfWUyNQ7okghTpGtiSy4uNFjOFl2cB6/
	 bp0FvrMHE0A72jooHeO1JGGxzwg2cc+Ny4l8K4uota+h2/avec5WQFKZcIknYWcV3mQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869737;
	bh=ef1lPxaD0A2YeCbnEKNs54LHf3AuPsz5/FAuSyFDHuw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cj6DEMWX+rUAz8MEBtpY9g41+HTCxqtFA6pgjPdwV+HhdRWmQS+/xLODMZCBrKqes
	 KYBoMMOHWkAjgYQa9q0gMFltuv0DScCNFYQhydXGvHlipDqRyTg1Ml+rRDKZl1YoxK
	 GOx4WZ2y+mTfxOf5fDOmIQk+vTCN/7YN+1NaaR4O7WvH5di8jYJoBHb57vWHFMGymJ
	 x8nO1d1hMtPR0fi79xNrpp4V8Efdah6lROVWGy/wTSrN2ufM6tbxiiVgtKuYYwUqed
	 xx/GbEKhPyWO2fCdqBAHAZMV48+fx8JG4jCvR8BGkfchEZ9j8bKf8MDvMVCREVAhyP
	 7IcK7FkAhnnHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67FD6405B2;
	Tue, 13 Oct 2026 05:35:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DEEBAF46
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C513740068
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id avVpO5FAXyjh for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:35:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DC5724008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869732;
 b=Fg2hmVDlzlLWoKT8ZxJ1s1ly+PXevZOuhlJFkkQ1gQ49ll6+4QFoO2Wi96jX3yjX9o15
 qpxeRzsi3WpXKA3dCAgcfZB2nBQ8ub0jI068P0MtZwa36JS9FXwo9TshkaMW8xAoJJJor
 B1SRVa+FZ3GJxYI92EBM052temaM+nAU7Um6QtJpnct0dOlSxp13EegIvB0RIXnqiGFVM
 CSYoxzquN2Vk3jTaCe7N3b9rgDoBFDUuFGVheYWGQyV3CEmtO0gXRnZe5u33z50YKNmH3
 Y7DZjEGpVOMp2Wr+6RXGMYS4x7QyccZ+QyX/u1/yWlMQVYTVyKN7Bcl+ZBJsToiQR0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869732;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ef1lPxaD0A2YeCbnEKNs54LHf3AuPsz5/FAuSyFDHuw=;
 b=kH09ZZmRFKRpzeSFWTSYLGdcq+lW61TGhl1R/j+SEdSJsMFqw2cWtylD4QRjeuNs5Q9s
 96hLWS54bycotuQkbdZ2rrFgFexN1F1sXMfBzRYpo6W9pBJ8Vf57hDJsRGsVDBxKh3taT
 Yco2kd7QzwUK8R8VSNm4QCI2ZC13s5b/0APs4EWCo4Tc4XdoEsnccaPP94bUbYJGrHtXN
 WiAnG39CAYpomFeHd/Y5BYZ5/+wlnggC/LfQ4m+HRuad7aTMPDEV9shD30s3l5A3ySVQj
 aJs+MlX72CZZB6Cwn+B8WJEJ7XT3RncKr/V1lQczZaiPhxavi5T/moWlD8fZfWpEGKQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ddt0v+QH; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="XHCY//dk"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ddt0v+QH; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XHCY//dk
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC5724008E
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:31 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D21D2m409280
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ef1lPxaD0A2YeCbnEKNs54LHf3AuPsz5/FA
 uSyFDHuw=; b=ddt0v+QHKuI2YJIRjU+dga2hF6339TSBpmAYwTii0I0pfRyBRyN
 c5Mbp42fhY/ubgWy/oq5w0oMTG8Fo7wmwoX0EDH8ScVVVUsNGcAoCk1yCyDdrelC
 aRYektg2MCn7ER3rt9P+N0rGBlxKak6PzH0A+HwH36wwBlHI/meDKF2RcWtfHwCn
 nLpD39qShwwWs/P29e6nWaDeQ44ipaMJYfpU0RH0JRd7VGXbmTS+pAsKWfOhkOiQ
 DxlRHTZgvCr9dMAdfW0nn6kOBnb2gfgkmUkytG8MuVh5Lqfe/r6X4oqebLodiMd8
 eOGYEaYDMlY+ZQlZ98KJwrE5mkKVAfL1UeA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wffmaxt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:35:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so7606309eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869729; x=1792474529;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ef1lPxaD0A2YeCbnEKNs54LHf3AuPsz5/FAuSyFDHuw=;
 b=XHCY//dklztXs6l3GhPOe3+usfNSAHmQ7Xp1RTm/1LuI/Hrxgq0GjMiU/CdtEQ8haN
 tuFQdKKYRnPKuTZT8+/XJ4manCp+NDM2t5Ic52wUIn8t11W3r+Yfe3z/G4N8tzcXzNVU
 LkVEtEt43IDTGt7roSWzCEEEM2H6gvz5e5Cgmn8b+kGWl0HEVMR9GgmwM0rP6JIUlVGb
 L+4feMju3LPlbgYMUbUIBFkmcSeJwpuYR4jn4D3UO/OKVIMd4kBmU/kH1Nz4u8/n1LEd
 6DPM/8WTrpQwxN9sSjGzQCZxZm2iOw3VEviZMU/PiuAOsMinl3C9VxkVJNpCQKhRlK/j
 0dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869729; x=1792474529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ef1lPxaD0A2YeCbnEKNs54LHf3AuPsz5/FAuSyFDHuw=;
 b=i7t8JUEswt61UI2hHlabtU39JckJCJxm7++IN+mtjdIucIjjoLVoNlcDC1wZZ03z+E
 PQk6lzHyUP+sR73JT4uAtoi18IsoEhR6YmjsTnF18t9SgHoQMv1c9gLaJaT6NMyDB9kt
 Z3vWbW6xwmZY9ykeVGzaiAmLGuG6HwheeEsmOXLd4uWtOPN6NwxqDVdc4GWCuum3r3JS
 HQgoIi5Ti+mnxW0ir0Zoyl0hOHxZBcEch/B8LPzc9gbKcLNlTUMeXUrmYDYVtOn68etj
 DZifFwBZJqjDd0pt05pZ2+mbMFS1O+TNn+FgiRhN1cPhw0cul+GhFOANpcA4nelhLEU4
 XlOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/ZvgFNlGfojbMxb2f2nV5B78paYwjSWpBUErTDsZXh7nZlDZ2byU2G553hqVW3PUXEUWXANQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKaWm5yh0U0IhC508Te3Ja7ZaoYIM9XwfjIAyQX6qlmVpO+3vmy
 Eeh4kADUjKe2/Utj+gnKL4swduXAGJb1fBHAErIB/yQ5HNZV1pc8N4SPKTCPtvcRZ8iqn0YRJg5
 CMtkZTXbykT6zLUcCfWDVsTGqPflI5LpwS9DdQKSvero/fVcUqfgUhyVwyiw4VGBzHprtFug=
X-Gm-Gg: AYBFou05xlSyNr/aMEvtM0oB8AVULZ43BFeu+Aa1CEfBjm9GlBtIT7mDZ026KNI8K/V
 7rVMqv9dWHyjrtxpoH6+1CnmsvFomrt/2uGcJUi/XTuXXSOLojSNv4UZtCFCS5xT4NSWQOfAHas
 uhxIO07G8gXyROXVTgeRMSPA/VFRTL0/XSkcaUsAdKx52JEtZbDK9pixxGw3dokYbWVkRvTnDYA
 L+46fsYbmngB7PlAClCLDz0QP85N3p/eBkzLjHeOSbETEHTRoS9ErO+rHsgsDyor1mrp4ymWxDx
 NtxpmDbx6i4dd+4O99V0+niHbdQ5NadgPyeZ/uIJTxTAgLXOj78JTEoeLDgSdyWtdNLvbUYtd/5
 b8TtMNE6Fuq8L8OykEuE0145BYCshh3a+Bos9nishxD1dzWw=
X-Received: by 2002:a05:7300:c00c:10b0:35a:22a4:12a with SMTP id
 5a478bee46e88-35a22a420demr8615145eec.18.1791869728217; 
 Mon, 12 Oct 2026 22:35:28 -0700 (PDT)
X-Received: by 2002:a05:7300:c00c:10b0:35a:22a4:12a with SMTP id
 5a478bee46e88-35a22a420demr8615103eec.18.1791869727421; 
 Mon, 12 Oct 2026 22:35:27 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm38347170eec.13.2026.10.12.22.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:35:27 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, abhilash.v@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 0/2] arm: qcom: shikra: add SPL SD-card boot support
Date: Mon, 12 Oct 2026 22:35:15 -0700
Message-Id: <20261013053517.2955571-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfXzgh7QwsZncvw
 VkE6vir8Mh65R9SWWqLLZcUAlnm8tJ37/5MZP/hulgcyL429K0/I5aSXtKs5u47Y2u3wrv8NDS/
 dOtU8jFFbkGGSd63VpTvR3SbesFSW12my3zpAzomGN4eqxQ7rHjU2B61YAA27baC/rypAmqTJc6
 6pirAlEC4GOnbripBYKTMkH3Id4V6LTWXBsrr4gp6YEfcrRGh3Ktfd3nklqqqjFXYVvQv+GWBrS
 NaHefE26yXWY38HWtLd1YVtjXEumIB4Zo+3ogvqbhKvPOjOikfkvWvSjp42q+NlPWQqjTNjeQGs
 wu/0xeq92hyhABAxmhmuEkNPKg08CdX/1A5RFeg7YH2legMBnyncdVZe1U0Mu5xrvHqcFQvMGNr
 xtUhcLxC1XsxZ9lkanUt88OWnb5luicOmG5FQqaRM7l3URju2Ev+w1ji1dD4vW481AcnhQyR/Sc
 nbEZj8J4yPrhcMfur7g==
X-Proofpoint-GUID: lF-JwHoZiS0mIlBqGcOMiBZOaBeCS0Dd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX703V0AbLYBNw
 bwmuUVKD6M8T9QvcgreSgNKV9IcfMYAqZDZD1sq+vOtdyh7ye4uxAclsF2Pdd4wu/0hIOUcQSTI
 xQZ3tKWuZ0asI4Wriwq8x9WeHdYWmiY=
X-Authority-Analysis: v=2.4 cv=ZcWIpcVA c=1 sm=1 tr=0 ts=6acdc322 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=FyMrTz-39pYPKDxiwqsA:9 a=zgiPjhLxNE0A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: lF-JwHoZiS0mIlBqGcOMiBZOaBeCS0Dd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130022
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

Enable booting the Shikra CQS EVK from a removable SD card in SPL.

Add the required SDHC2 device-tree support and select the eMMC or SD
boot device. Update clock handling so only the PLLs required by the 
selected clock source are enabled during early boot.

Depends on:
 - https://lore.kernel.org/u-boot/20261013053244.2954876-1-abhilash.v@oss.qualcomm.com/

Changes in v2:
 - Rebased on top of the updated Shikra SPL series.
 - Dropped the standalone MMC boot-source patch, now included in the base series.

Abhilash V (2):
  arm: dts: shikra: enable SPL SD card boot
  clk: qcom: shikra: gate PLLs by clock source

 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 19 +++++++++++++++++++
 arch/arm/dts/shikra-cqs-evk.dts         | 14 ++++++++++++++
 drivers/clk/qcom/clock-shikra.c         |  7 ++++---
 3 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.34.1

