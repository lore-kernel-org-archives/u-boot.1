Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41D606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kgvi8Ixs;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JC7PAMBw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bWWOOLwQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E06D4607DA;
	Tue, 24 Nov 2026 16:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n7cshP2fxWmN; Tue, 24 Nov 2026 16:29:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B2EFF6069B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795537798;
	b=OBrn5WFBSexKnznnFs20Jx0JrdmOnQ7gAWjfnuksFSr0tFhynepX5lpJ8kxuervuu8q5
	 QN3TxgK75GeWa9lRgG3pIBAlV+OY03OF4C3U8wzBUkzib89JqURdY2KG2U9zbk7gt+WcS
	 6a24QwYfZ1D4WcNBXxU0llJvOkelfMY9RX/nUh8EbSfsoJCiktin96rrvjBwkAXFqcWyf
	 FS6E7iaIixn+5c9LhIHPutlbHTC8jiMDM938JMyM7YMpiJbaixAO+m4nzr/0AfjXVrdah
	 KoKg2hKjZLgyO3aPhH6OFR1CbHGlxAp84bqTCrwE5TRG5qwtYhMi7xDMxNBisQs7vLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537798;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BT6QNUhaB8N2oWX+Y6PPygyq6mX9Vj1vDZck62TIots=;
	b=f9pQuAe3WeSuaC8NeqmhWj57ERO35CE7r64vwVq1P2I/bEmq/1axQ9HQJds1UCPhlfdP
	 79zS4c8zrjNP0uXTh4gq+uLrfFu3tewz4IdhqfY1osvDtF2AMmRTUZJf+hLG70aLAfl4n
	 uoEqRgw4RoycPCi56ZKfgsi2hKYltDkTOjaVUNE7gXm5hojv/nNScRW8HQ4eHE0wMkUkc
	 I0z/yOnI8C4wwgYBy3DvMrs8jywVSEvspkN4pAu0PbVCF77RKnptV1gyhW7vxv6DTy5x1
	 JhXhRmx9aA7ym/XoCBmKD6ufPcvYc0OOb49zPmWH13EXhYrf8f+3Y6fQYXXAwuK+OXg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795537798;
	bh=BT6QNUhaB8N2oWX+Y6PPygyq6mX9Vj1vDZck62TIots=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kgvi8IxsFJR9EoNZhMRRvyw3cYbvEEjVLhSGoCEzJQD1AP4I+uF1/zlq/80sgqpIM
	 vYJNmT+KJcoyJEGsxqrVV4M8rOBsUBanhF6ahmgbVprsPSCMMSlDepBjQ56Zw4R8T2
	 Ox75/aek+Tk0Wa5zqxq4kmu3ilFoaaV6GQlnwi2+aYmqSY4nWOnr3uMSlZYhn1DLnI
	 HLDLUc0K4tT3lumQL6BtN41hXtWZ9B9zvRZB0isRBqEpu67akwF/P8AOgmA3TPeAu+
	 09FoLRK+KJdcpe+eCFHyZ55FhFR8UxmproBtUHewkPzY5zr2iaXqiIpWitxiBvHnbm
	 o6lYSwS0MO3Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2EFF6069B;
	Tue, 24 Nov 2026 16:29:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 925D41C9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8444880C46
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uWo90yoz0qpL for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:29:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7CA1980C43
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=JC7PAMBw; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bWWOOLwQ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7CA1980C43
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL8uD2318164
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=BT6QNUhaB8N2oWX+Y6PPyg
 yq6mX9Vj1vDZck62TIots=; b=JC7PAMBwrKJNGq0MNVVVDwpkzOQ5xmZe73v0i+
 cf5h1t0azgJ6qwSZLWhuRiiHvG5ALxkRdIGZUxZdwV/K+T24ve2ggoGn/eehOiZD
 6QbsvPjHqM64KbViYRZ1UKxqz9a5gberpoxUu5x8QJYf0b0rJsScJ6G3zmQqH4UL
 TyfTiLrDraR07CWWlvp2oijHfRlHEYAAuRy398q2myLKdaiokXVOvREvmPr09bSa
 0E/ROFFKONL+cTEG1gjKLUDt2ZPAzwJj62c/VhyDEoNXsnOF1o/nuHS3xaAdmjvw
 rjAXH5ZgMHfBTghb9awSbHQlLR0mwtJYWGrSkuzrl24id+Rw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvd3tkq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:53 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99e109028b4so2793924241.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795537792; x=1796142592;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BT6QNUhaB8N2oWX+Y6PPygyq6mX9Vj1vDZck62TIots=;
 b=bWWOOLwQDpM/gliR20qNVPWDSf9ePSVwmGi+Y4501l8hMRQQellGbPWw5cci8V5Ni2
 qMI8FuGZft9q1DuuH6/3mZaXbpOK0Ulrh09U8bFa133wO6QOSV9dG0EFS2y7VdD1t4vu
 Ig/qqj4Z6prYroGzcghZPDcC+JucCxQdiDLkUCHM7V1WS9gI4mvG0/Q3B08m3+9RxKxW
 2DuwvSgPNa3qaVrKdU9dhHlSRiXv3FfakPQ8vxkqLPMU2quHHiUMqWBa595xZ1oYZpwN
 zMVOyzOg5YotTgemHWuOXlQGC+oXadP0yRzl3y6P8KdcCeaUgJ0FadCYdq7fNAzkNIW6
 /BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537792; x=1796142592;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BT6QNUhaB8N2oWX+Y6PPygyq6mX9Vj1vDZck62TIots=;
 b=It8kLkzi3zTDIoqusIEAepUaOsblUYGgXypng93ICmLNeQvCT7IL8Qf1ZQSdP4uKD5
 ZpOX446iZcHG3FLlvW71CyEtayeELp6RKVAIHSgWf9CBWKHLKpYSDVP92S4gulv2iLGw
 11KYuUoWBBfcRIoY7+Zr6DE5lt5aRK2kLNd7O2pvDXpYYcUHH/qsvdYgovSNZmAMlU9X
 z+Bzz5NiU1DEOLR2Y6FGXC3Nc5LgLVrrYrizFp6wQ6E3OFsET6X9S+VXTu0lMMt1k4zi
 msAeQkmcCblg5lR7q032hdg026ZlLSB4Vqd83eUZY2KKsNEPf9uhFtqWQRl++3YJzm/2
 vRnA==
X-Forwarded-Encrypted: i=1;
 AL+hErH4j2KmB/oarNR3D/XwtmPXHvjIerrRb4uLGuKLsWMmTjd/LMh43OOJ9aQhuaWBxbUdWYTT5s8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z87Cc/iP+Gr1NHpl0xLqZ5qpq5PJ73vcJc0LDU7Rymd7HUJ3wxV
 227qDnw2xBaYrc4z8UFGWo0clWL5HzP69EpXInZv6G3mMI5uszDMaIRfMHEX60AZc/FElpYCOVB
 d26YYhUQYhtK6SWnLaHotjgJcD2GDHdfJVijLq9qVwlpzHcxr3It7SPZuCp7empgaREuLf24=
X-Gm-Gg: AZFdTZcqNjPovcYZ5ZbJRiwUe+JKtZs76gOmqgMxg0lhFmAueBH19QV1kpGX4JvyhNa
 yEudWdjeJAThvV/GpVAXM0+a+uwHKeCnJIXCLoqbFfeY3WCTEzJIyyl3U9YTGepOi3+o/LihUpZ
 Vxy2LlpeABzOxOsNgWc67nUqBoaO5hm7E27ArMO1k0FPH7aeC+8kqiJTWspSRswNFR3/vQlvk7o
 gM+qgVWoi2eSKQpuGfmcbbRQTBQFRzQQfdVF1w9YRRZelj2Uzm6KLlWrkbBzy3WZiLLoaNsJ/FK
 KAw48YHV+zW8nYrtryC3SgmRzvAE+OefY+rncSUQiH21UK1xRWdAlqvy6worQzrhLgSKk4J1VAM
 7jPzp4mZjcVrWe+h5pmNzSoypDjqIEaateSqEWW8KhJEF5hpmsGCZtpiqxNyBh5dgPU5spTNtFa
 4sCyo9Z6CRol6r
X-Received: by 2002:a05:6122:4201:b0:5ee:a81:e77 with SMTP id
 71dfb90a1353d-5ee8af0e023mr7991163e0c.6.1795537792537; 
 Tue, 24 Nov 2026 08:29:52 -0800 (PST)
X-Received: by 2002:a05:6122:4201:b0:5ee:a81:e77 with SMTP id
 71dfb90a1353d-5ee8af0e023mr7991121e0c.6.1795537792001; 
 Tue, 24 Nov 2026 08:29:52 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370fbf0esm7058223a12.23.2026.11.24.08.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:29:51 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v2 0/7] test: cover the AVB lock state and preloaded
 verification
Date: Tue, 24 Nov 2026 17:24:57 +0100
Message-Id: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNUQqDMBBEryL73UgSrKn96j2KyKprDVRjszG0i
 Hdv6gX6M/AG5s0GTN4SwzXbwFO0bN2cQJ8y6EacHyRsnxi01KVS0oh14eAJJ4GxbQJx4KYtBEo
 aSuwQy7aHtF08DfZ9eO914tFycP5z3ET1a/8ZoxJSVMoYbUxxvgzVzTHnrxWfnZumPAXU+75/A
 UZK0jDBAAAA
X-Change-ID: 20261107-upstream-avb_tests_b4-a0ef6acaa6bd
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6b05bb81 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=NGV5Nt-krMV8bjwPpt8A:9
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfXyw134UNMPx9y
 x7djTiJFWScjupefN96hESumOvPeSOOwjU89uRDc8FtFtXloP1R8xDE4obxvlZG+U7ey9Ep0Jxg
 c1ATLYXd4TBhov83+ZnhFyOIeEfTlBRbPCdBbWfQhtHkvlkHBbr8WuPjI7YSUL6u4hS7fQokZKm
 qfcA6GI+iM+S1Npf29KWI9RA40boTMi2ReZWsqNHKQrJY5LImlKCEj0X97kpni1VXYKKpIRNeOy
 5zokZXZAQlGs1cO499RN2E4WvWx9Ltk+8cdGGuyVFWft5VXtxM2NrYg2fKt0pN8Ok1rczEBhsPZ
 Jxj7WTdEIXHpgI9Kpdnf3cArzcx0urlQ8ZsgsVAuUEB6LwMppMTB6sTX+DphuUgRGobQK1cr7mZ
 poJ9INdSskNe84tTyHL+AK35/4FDY8jPngiCnetZDiHuIGgHMs943l8bfVonu4g61fNMmKCVyx0
 lvXPriQLnXJA8mWGFsg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfX3cSxElAkA5pP
 0iQ5HW3CVO0a1REwY95yBRpFd9lc5bKVQmxz7toCzdzzSYjSZkitNKwVk0fSMSco1Uu3vJHfFPC
 OMwcyZs4cy1MQ06DqrgeElM3VvLj8Eg=
X-Proofpoint-ORIG-GUID: iK3crhbhCm7NCdI13U1Gd5PXamqse1pi
X-Proofpoint-GUID: iK3crhbhCm7NCdI13U1Gd5PXamqse1pi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240064
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AVB lock/unlock series [1] came without tests. Add them for the hex
persistent value commands, avb lock/unlock, the verification of
preloaded partitions used by the Android bootmeth, and fastboot's
flashing lock/unlock/get_unlock_ability.

Patch 1 fixes the sandbox TEE, which cut persistent values short at
the first zero byte, so that binary values can be tested. The last patch
enables FASTBOOT_CMD_FLASHING on sandbox, which the fastboot test needs.

The lock/unlock test checks that the stored rollback indexes are cleared
on a lock state change, as AVB requires. The sandbox TA emulation does
that, and so does OP-TEE's AVB TA since [2].

[1] https://lore.kernel.org/r/20261023-upstream-avb_lock_unlock_b4-v5-0-6453a6f63028@oss.qualcomm.com
[2] https://github.com/OP-TEE/optee_os/pull/8224

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Changes in v2:
- Patch 1: encode the new value before the old one is dropped, so that
  a failed allocation keeps the old value
- Patch 2: also read into a larger buffer, to check that the stored
  length is returned rather than the buffer size
- Patch 3: run on sandbox only, as on a real device the test would
  clear the rollback indexes and leave the device unlocked; also check
  that the first lock clears an index
- New patch 4: build the Android disk images under a temporary name and
  rename them, so that a test never reads a half-written image when
  another worker recreates it
- New patch 5: create the bootstd disk images when a ut test is run on
  its own, so that "-k avb_preloaded" no longer depends on
  test_ut_dm_init_bootstd having run before (Mattijs, Guillaume). They
  are created once per run, also with parallel workers, and a test that
  doesn't use them still runs if they can't be created
- Patch 6: leave only the last 3 bytes of the boot image for libavb to
  read, instead of the whole image (Mattijs); expect the I/O error for a
  buffer that is too small and check every byte past it
- Patch 7: check that unlocking wipes metadata too
- Tested-by: Guillaume's Tested-by, given on the v1 cover, is dropped
  from patch 3 (the lock and unlock test) and patch 6 (the preloaded
  test), because both changed in what they test after he tested v1, and
  patches 4 and 5 are new. Patches 1, 2 and 7 keep it, as their changes
  are small: a reordering in patch 1 and one more check in each of
  patches 2 and 7
- Cover: OP-TEE's AVB TA now clears the rollback indexes too
- Rebased onto u-boot-dfu, collected tags
- Link to v1: https://lore.kernel.org/r/20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com

---
Igor Opaniuk (7):
      tee: sandbox: keep zero bytes in persistent values
      test: avb: test the hex persistent value commands
      test: avb: test the lock and unlock commands
      test: py: android: replace a disk image in one step
      test: py: create the bootstd images for a ut test run on its own
      test: avb: test verification of preloaded partitions
      test: dm: fastboot: test the flashing commands

 MAINTAINERS                                 |   1 +
 configs/sandbox_defconfig                   |   1 +
 drivers/tee/sandbox.c                       |  22 ++++-
 test/boot/Makefile                          |   1 +
 test/boot/avb.c                             | 117 ++++++++++++++++++++++
 test/dm/fastboot.c                          | 146 ++++++++++++++++++++++++++++
 test/py/conftest.py                         |   7 +-
 test/py/tests/test_android/android_image.py |   7 +-
 test/py/tests/test_android/test_avb.py      |  93 ++++++++++++++++++
 test/py/tests/test_ut.py                    |  63 +++++++++++-
 10 files changed, 448 insertions(+), 10 deletions(-)
---
base-commit: e578056c766d653270b14557c2a9d8daec414c17
change-id: 20261107-upstream-avb_tests_b4-a0ef6acaa6bd

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

