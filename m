Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA490606A681
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=joaIcMth;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DhRp7bjq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Leip+nKv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C55D7811AA;
	Thu, 26 Nov 2026 14:32:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Lgy46fAyDfU; Thu, 26 Nov 2026 14:32:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C67CE80816
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795703530;
	b=tWKK/GXagj7mjqoeAdtKP+mXpgkQBVPS3w//mrTU9gA+f/PO9SgCRXjwD1off5ZQhvhh
	 AnSrxbZ+KeTto+KAtFZz2kEsrcDFfv88oSRP4gEV2HGY6li/0L/1GfSmzLEfx54cnC/43
	 dyBp4eyOZtWYEeoQvrfBHxHyZTq+tyK5gSiFAeGdpryzj9s2D3IT6RxukWwrqt8cFM4a1
	 cv2lWx2fpVlpsYb7wiXO/Bvgms95vUSjLgxa6ffEv3xrjLKS+bK501t8+YUc7r/ZWw9A8
	 cCf/aPmfdiYqBqgY3mhHtSwc2ZFU52aKxyyUA4IM3KREKi6macVly+bJVQ/Pbcj4SZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795703530;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7ld+Ji+MLGSdXt0kTlmXm4EosDkc9p0//HrGVhCm2pA=;
	b=a5+GvauYEfPgX7CrC+W2WKuRmp2jXRYV2Bn/OsWBA4H+2+WxuhyTFA4WJYDYzXGyCAKK
	 pIw1sXjly2M0BKsXPv3g95ahhVPH4xx9iB2/VTZz5oPmzm+d5z+sLd7njcc81fv+ojk3z
	 jRM0XNLJGBnPv9bTTqJ0HfugGi/irWq2AlrittrtRkxPaxgLI4X5+ayMvg84gVeiYnwcO
	 1F2t8wJGiK5DpdojZgV2aGnjJ7tW9sYv/Lv3MkBBLJ/Vn/GLMOYO/WyzcrvNCWP2vGnea
	 ACCxA7eHIVn3Yoyk9pZRZpTBLUaaPwBrWdtLjLL5/cmjTiKX4Xs8Ums246I1owV7Eow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795703529;
	bh=7ld+Ji+MLGSdXt0kTlmXm4EosDkc9p0//HrGVhCm2pA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=joaIcMthoEMetaruIjJ33WXxVlzoQhOEu+0i5JEL58kOkogb5j5u/0IkZZOnXbwzL
	 QLRuUKIcfLE2yf+HchLxKjpzcUIOSKz+bHNEJv1Vp+UuN7rCwV37Ft4i9kHLFyXWNt
	 JhUp3AZwKiKHYCleo1pecPA7Qe1QRggWyS8IjlG5xSJsEpA98g/qudBecZQc/+/0ze
	 ExNCNWMHO41dzPUqNpFBo/kIVtgflt/vmCIwcCzk80MP/kMU5nAzU06DoGAOiktQlf
	 8TT3wLqYi3+LCkPNPAqzIZY75Jmh38xx19RjVe7qjo/cVQVCb9Z2MgEufRqGkMFyQ1
	 wt7bfT5LmUOuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C67CE80816;
	Thu, 26 Nov 2026 14:32:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F310B1AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D90D5409D1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MLKzY6BxxYmM for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:32:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DF274409C9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=DhRp7bjq; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Leip+nKv
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF274409C9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:04 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEVbmK321595
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7ld+Ji+MLGSdXt0kTlmXm4EosDkc9p0//HrGVhCm2pA=; b=DhRp7bjq/WVQ1gnD
 ilgCSaY+FcNyzu2srIPxNyskPT9xfJC/gEUmHwPKyLY0HkUQ6M7gBFCzdmoH7sj1
 l2unEGfjjbRTYjlaVLHMAxh3aB5BQZez0KjHYEnYI8XMzLucpaVATrfHaGYEadfl
 fQTOD1FsvHyvICc3PsZVDj09kD4XaOAnZARZehB+hdD4yS2+rdN5wS6sY8FR1fcO
 OPT942N4X35uTKz2qCxoUHhK3eQmN9OyzWETpIhV/exPJe6cLPMZ5Tf4gUK1UzfG
 jUqlQuhuzctMhR33IoBE/x5ZBEKqd3ZJSmlgXBmODbHE4B3VQXiSkrK0lhdh240n
 YGttFg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62vavade-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:03 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9907539aff7so4441729241.2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795703523; x=1796308323;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7ld+Ji+MLGSdXt0kTlmXm4EosDkc9p0//HrGVhCm2pA=;
 b=Leip+nKv7m/eeg8AoqOebfhPQ9JxOcJ7JeA0f+J4LPc9oShaSlvqeKeBV795/syOf9
 wtOpYvuhik7Xw0GH9/kSHFuloQjAwchKjSHLN1qqNjNTZ01CmhgFxZN/5SrHk8MOxH+H
 8LGKa7JehMtOumyyxp0wMctveetZhzqAOedm7thgCveOMAdz6WxofPa+VEVpFDl5p/Um
 ICWKG+bBYbfC30oQYMyGdVHu969z6rsZD7WyalLfDsBHqV0d9Fo/NvPR+4WJ+NkVrTxX
 6680gbv8TBQqzD/30DbfxM9dr1WR5ii/fEJdqsSEq16xjKghTwpyKEmsCDFW9CAqMigg
 fGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703523; x=1796308323;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7ld+Ji+MLGSdXt0kTlmXm4EosDkc9p0//HrGVhCm2pA=;
 b=BvMFXrWfRWQNvcv4UN29G9XrVvjQGH6emxdjTayig2qJlFfwBv+cx6QXnIkmcShugt
 XBNL8HUzHN4VICqB+vRmcuBadnecfmsMlj7dfM/owpyXOWhMA69jrnG2mdLsmXRl5IIt
 dA4bHEdmT7pP6mL6cjOTPUc58hS3meKYoci2AQgSAYI3UYz1EZrYJUReinGoQu30L2uK
 QXs0QRLF+t6x4qKQI3oDL+xX0Kf36QKUvp+cG7hMsbgW1JsN5AwTXfIo6TqIhkF7AlQ6
 WfV7HLPf412xZQv0zIMefCNeqdzA5n+fHOc1wSopWMzvpUj0j5NXNwsgrBR3OfGMsSPx
 9Syg==
X-Forwarded-Encrypted: i=1;
 AL+hErHtzG6SId97VdnHCLMRPkS0GjOpRHXMq3cswOFMAPjwAn3xRCUXvzMm78Zy8OIfckuAh8zVQtA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/IEwNdPU9+jK6fBvdGPSEgaXLejBl7mpx832t+hhUFyV4I69eG
 ULimTLIqWpH44jnKjkCcpFRHD8awhsiWtGPsswsq1Tn7yQkCfCSaOxgDyUE5KNoxAZYfBTe/3PG
 jc5R4M3Ltwy++cGHbJC6OWzGUCky73ERuDaogN9QGSdhw+/69y+HAMGGPvrV3l4rMsfpHc564HW
 +UF7E=
X-Gm-Gg: AZFdTZfMit7M2z0CRBtvl7muoEETT0p2mOYQrzPoz5Yl9ZxvobRdqUj00c5G3Io70U0
 KbbzeH3VVTjmA5BmQjdkiSTTjXlJXkw/cIRmyvWrCGbR+mNeycEHpyqko4/vSowzKMde3WRzPl0
 74g7gax6o17ipzOdL0A7sGb8eL9EE4BoNp4OvNWK3W9aKIbt4vV6rR5pye7SHZQQrAJuYtlumPm
 9a6/V8tQEaZpRQ6NiN80QRLbDLPEBNsvYKFyaYbKE3PA9bEZnpFjJJ7flxEkaZSlQy+2I9A7VwB
 pIKCW0jisklFARuCXEVnQOf7mWC1JNeMUKHJLOj7G97hmJWtoPk0Tlfok8QgpktnG3X2mOu1CgX
 7IfD+4vM0MxiJagOdG5lM9BnWnQSXd769ku/w9LV5jPw2u2Gw1q+GF7aAdXQLeqeXFHpDDrt69h
 hDljt4Ks/lF9nj
X-Received: by 2002:a05:6122:1c88:b0:5ea:f399:781d with SMTP id
 71dfb90a1353d-5ee8afd7156mr13841269e0c.23.1795703522781; 
 Thu, 26 Nov 2026 06:32:02 -0800 (PST)
X-Received: by 2002:a05:6122:1c88:b0:5ea:f399:781d with SMTP id
 71dfb90a1353d-5ee8afd7156mr13841209e0c.23.1795703522267; 
 Thu, 26 Nov 2026 06:32:02 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b030ed9sm772664866b.86.2026.11.26.06.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:32:01 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:31:53 +0100
Subject: [PATCH v2 3/4] power: domain: add the Qualcomm RPM power domain driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-qcom-rpm-glink-v2-3-15707dc6f396@oss.qualcomm.com>
References: <20261126-qcom-rpm-glink-v2-0-15707dc6f396@oss.qualcomm.com>
In-Reply-To: <20261126-qcom-rpm-glink-v2-0-15707dc6f396@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfX6j8XVVs9Mh2E
 FKxce9fM0XXF8vQxmW0arnaFESNamDp01xX+fyCT/2NR0RcYa5ohq/0uwILE3ruZTzwkVrb1iNf
 jWr+9DvTm/OrgrgMhNJV9IeiA/xvAcQ=
X-Proofpoint-ORIG-GUID: FQ9afTTzd1SWOTYC-z80br8paO5abcxZ
X-Proofpoint-GUID: FQ9afTTzd1SWOTYC-z80br8paO5abcxZ
X-Authority-Analysis: v=2.4 cv=QZPzLcbv c=1 sm=1 tr=0 ts=6b0842e3 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8h4KQf4pH4XkToucUegA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfX0mXE0vUJYBeW
 Y5zWqNqRjsxn7O/jiqRnZVLPH916KzaukN531jVjIaH0TyttAMF6V9ML1mDCOOyIG30zo1ShdBj
 6jJe+vx18t/YafaWImmp9lf8sFsrKsqBfZWr5qrGpZPpCU68gpllf3RDpS3/izx/DqZv1pNbj2q
 4fdel0jfxP0yRtscAMiX1s3pEZNr1Il/n+iYVZat7oxkpINZ0Y0K5NmQdCP46BSt57M0HIs9+hp
 +AOumv0f3feuuZyyTVh6iFRUN3xPZd+Y9CzFuDORaY5NduACVGD/ymrIwtlWDbTwbHcr106t5/v
 9f3dJQHWoxP3PkDH6cZYzXGrMlHuGyHV2kK4eJyQrGGJIBZMl3PNw4ugfMHvlpDo8iFFFVbJsd1
 3rm1OgoccODM/chLB8gm+N3SQ03u5Ew2ngx3ythhgKlP/GjHLyH00kT5ohvSi8LMphZHGmoxMlP
 MZ2MFni8rnfY/ZVHSdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260056
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a power domain driver for the CX/MX rails of RPM-based SoCs, with
the QCM2290 and Shikra tables of Linux's rpmpd.

Powering on sends only the "swen" enable vote, like Linux's
rpmpd_power_on() without a performance state, so the level voted by
the boot firmware stays. Powering off keeps the vote: dropping CX or MX
before the kernel starts would take the buses down. Without a usable
RPM link the probe fails with -ENODEV and consumers carry on as before.

Tested-by: Biswapriyo Nath <nathbappai@gmail.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/power/domain/Kconfig      |   7 ++
 drivers/power/domain/Makefile     |   1 +
 drivers/power/domain/qcom-rpmpd.c | 169 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 13a661ce04f..7a469468298 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -102,6 +102,13 @@ config QCOM_RPMH_POWER_DOMAIN
 	  The RPMH power domain driver is responsible for managing power
 	  domains on Qualcomm SoCs.
 
+config QCOM_RPM_POWER_DOMAIN
+	bool "Enable the QCOM RPM power domain driver"
+	depends on POWER_DOMAIN && QCOM_SMD_RPM
+	help
+	  Power domains (CX, MX) of Qualcomm SoCs with an RPM, such as
+	  QCM2290, voted over SMD RPM.
+
 config RENESAS_R8A78000_POWER_DOMAIN
 	bool "Enable the Renesas R-Car MDLC Power domain and reset driver"
 	depends on POWER_DOMAIN && ARCH_RENESAS
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 3b816ed3bed..b57fe297d44 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_TARGET_MT8365) += mt8365-power-domain.o
 obj-$(CONFIG_TARGET_MT8366) += mt8366-power-domain.o
 endif
 obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o
+obj-$(CONFIG_QCOM_RPM_POWER_DOMAIN) += qcom-rpmpd.o
 obj-$(CONFIG_RENESAS_R8A78000_POWER_DOMAIN) += renesas-r8a78000-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain-test.o
diff --git a/drivers/power/domain/qcom-rpmpd.c b/drivers/power/domain/qcom-rpmpd.c
new file mode 100644
index 00000000000..59910d0a84a
--- /dev/null
+++ b/drivers/power/domain/qcom-rpmpd.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm RPM power domains (CX, MX and friends) voted over SMD RPM.
+ *
+ * Powering a domain on sends the enable vote only, as Linux does until a
+ * consumer sets a performance state: the level the boot firmware voted
+ * stays in place, and U-Boot neither raises it nor clobbers the sleep set
+ * an always-on peer shares with the domain.
+ *
+ * Based on the Linux rpmpd driver:
+ * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <dm.h>
+#include <power-domain-uclass.h>
+#include <dm/device_compat.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <linux/errno.h>
+#include <soc/qcom/smd-rpm.h>
+
+#define RPMPD_RWCX	0x78637772
+#define RPMPD_RWMX	0x786d7772
+#define RPMPD_RWLC	0x636c7772
+#define RPMPD_RWLM	0x6d6c7772
+
+#define KEY_ENABLE		0x6e657773 /* swen */
+
+struct rpmpd_req {
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
+};
+
+/*
+ * The AO and VFL variants of a domain vote different keys or sets of the
+ * same resource; for the enable vote they are all the same resource.
+ */
+struct rpmpd {
+	u32 res_type;
+	u32 res_id;
+};
+
+struct rpmpd_desc {
+	const struct rpmpd *rpmpds;
+	unsigned int num_pds;
+};
+
+struct rpmpd_priv {
+	const struct rpmpd_desc *desc;
+	unsigned long enabled;
+};
+
+#define RPMPD(_type, _id)		{ .res_type = _type, .res_id = _id }
+
+static const struct rpmpd qcm2290_rpmpds[] = {
+	[QCM2290_VDDCX] =	RPMPD(RPMPD_RWCX, 0),
+	[QCM2290_VDDCX_AO] =	RPMPD(RPMPD_RWCX, 0),
+	[QCM2290_VDDCX_VFL] =	RPMPD(RPMPD_RWCX, 0),
+	[QCM2290_VDDMX] =	RPMPD(RPMPD_RWMX, 0),
+	[QCM2290_VDDMX_AO] =	RPMPD(RPMPD_RWMX, 0),
+	[QCM2290_VDDMX_VFL] =	RPMPD(RPMPD_RWMX, 0),
+	[QCM2290_VDD_LPI_CX] =	RPMPD(RPMPD_RWLC, 0),
+	[QCM2290_VDD_LPI_MX] =	RPMPD(RPMPD_RWLM, 0),
+};
+
+static const struct rpmpd_desc qcm2290_desc = {
+	.rpmpds = qcm2290_rpmpds,
+	.num_pds = ARRAY_SIZE(qcm2290_rpmpds),
+};
+
+static const struct rpmpd sm6125_rpmpds[] = {
+	[RPMPD_VDDCX] =		RPMPD(RPMPD_RWCX, 0),
+	[RPMPD_VDDCX_AO] =	RPMPD(RPMPD_RWCX, 0),
+	[RPMPD_VDDCX_VFL] =	RPMPD(RPMPD_RWCX, 0),
+	[RPMPD_VDDMX] =		RPMPD(RPMPD_RWMX, 0),
+	[RPMPD_VDDMX_AO] =	RPMPD(RPMPD_RWMX, 0),
+	[RPMPD_VDDMX_VFL] =	RPMPD(RPMPD_RWMX, 0),
+};
+
+static const struct rpmpd_desc shikra_desc = {
+	.rpmpds = sm6125_rpmpds,
+	.num_pds = ARRAY_SIZE(sm6125_rpmpds),
+};
+
+static int rpmpd_request(struct power_domain *power_domain)
+{
+	struct rpmpd_priv *priv = dev_get_priv(power_domain->dev);
+
+	if (power_domain->id >= priv->desc->num_pds ||
+	    !priv->desc->rpmpds[power_domain->id].res_type)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* As Linux's rpmpd_power_on() with no performance state set */
+static int rpmpd_on(struct power_domain *power_domain)
+{
+	struct udevice *dev = power_domain->dev;
+	struct rpmpd_priv *priv = dev_get_priv(dev);
+	const struct rpmpd *pd = &priv->desc->rpmpds[power_domain->id];
+	struct rpmpd_req req = {
+		.key = cpu_to_le32(KEY_ENABLE),
+		.nbytes = cpu_to_le32(sizeof(u32)),
+		.value = cpu_to_le32(1),
+	};
+	int ret;
+
+	if (priv->enabled & BIT(power_domain->id))
+		return 0;
+
+	ret = qcom_rpm_smd_write(dev_get_parent(dev), QCOM_SMD_RPM_ACTIVE_STATE,
+				 pd->res_type, pd->res_id, &req, sizeof(req));
+	if (ret) {
+		dev_err(dev, "failed to enable domain %lu: %d\n",
+			power_domain->id, ret);
+		return ret;
+	}
+
+	priv->enabled |= BIT(power_domain->id);
+
+	return 0;
+}
+
+/*
+ * Keep the vote, unlike Linux's rpmpd_power_off(): U-Boot switches its
+ * devices off before the OS starts, and the RPM holds the last vote until
+ * the kernel's driver sends its own. Dropping CX or MX in between would
+ * take the buses down under the booting kernel.
+ */
+static int rpmpd_off(struct power_domain *power_domain)
+{
+	return 0;
+}
+
+static int rpmpd_probe(struct udevice *dev)
+{
+	struct rpmpd_priv *priv = dev_get_priv(dev);
+
+	priv->desc = (const struct rpmpd_desc *)dev_get_driver_data(dev);
+
+	/*
+	 * Without a link to the RPM report "no driver", so that consumers
+	 * carry on with the votes the boot firmware left.
+	 */
+	return qcom_rpm_smd_ready(dev_get_parent(dev)) ? -ENODEV : 0;
+}
+
+static const struct power_domain_ops rpmpd_ops = {
+	.request = rpmpd_request,
+	.on = rpmpd_on,
+	.off = rpmpd_off,
+};
+
+static const struct udevice_id rpmpd_ids[] = {
+	{ .compatible = "qcom,qcm2290-rpmpd", .data = (ulong)&qcm2290_desc },
+	{ .compatible = "qcom,shikra-rpmpd", .data = (ulong)&shikra_desc },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_rpmpd) = {
+	.name = "qcom_rpmpd",
+	.id = UCLASS_POWER_DOMAIN,
+	.of_match = rpmpd_ids,
+	.probe = rpmpd_probe,
+	.priv_auto = sizeof(struct rpmpd_priv),
+	.ops = &rpmpd_ops,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.53.0

