Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C9606A327
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=imWvg4Da;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bdJeJ4fq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WvNf4Skv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6C386081A;
	Tue, 24 Nov 2026 16:30:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id maSO_eVFkId7; Tue, 24 Nov 2026 16:30:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C66AF60835
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795537813;
	b=QX3ig7fQHNpatPk2dQ7MCifZTYfj8WR2UxcmJyvfu71a7XS7gm3ZeuVsltCqE1VB5rua
	 svEtWc1Vrv1EizLlyxhoPK0dVjuDMSSB5aYpFT4x/XYGKVQmbFGwOJ0faH5zw2Dpcez/Q
	 OdObOrDF+fvU6e6K421dUElXsH55r+QdevOmPKS0wcjzQoIWx/wU4Wh3zK/HPcCBh+epP
	 DIrVI9l/bBCFfVxu8jTp51JgxS7zw5C+zB3Blqbrx17MDk4hPwrCa8v+cSfmGr91ZBD57
	 6h2oUd5oEF3pGzwBIj/tdHZPJF5Qizbd0y2kNiXBLnd4G9ECgP8737G4oZ2Xdb3Jxvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=W1KHz3GQBUJk37ySxziuIptGEQfRQvFP80TPYYANdxM=;
	b=JX8nDAXaMUzMMbO/+Tl7PLhft7qS5uZPZ1qIXivH8inLfzPTccXQbfwLUpT1wwBun+4F
	 yMITdHIsGSPm7+yfqIs4RmQaqb5hjy2WwRD/N2gHNnnqQ77dlJclbYhE5XizxYdIkao+8
	 430ekSUIW0VgdZKciYQHuMNhVEegXO3FyIr1HQLu2Fw9vFOvQzdoN5hVuRTkyrL/U7sYr
	 DjMFQ51IR2ZoOQALQDtz0GcKUesG3dtUnjaWEoYo2ckfc7iyiILrMgUuYv8IwITFRaGFc
	 7YDcDpK6MUvq7tIHrdd6pu7KYKD/6eSoIabGLPirD1E6lekJ1nFpmj2oehhENGBZndA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795537812;
	bh=W1KHz3GQBUJk37ySxziuIptGEQfRQvFP80TPYYANdxM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=imWvg4Da4TEhqOrEyLPVfm74vkslT8pFkbpvAJzwzlqFasEq91czdftUbYDQoAgkV
	 wy/qghW26KzGZu9yP75euLiVU1q1ZiO/2zuolLpPcFip6prR8jcIGqDzbGQZW2aee7
	 8Bc38fKgkcegg9xOOZDxY0Msim3ROeaY83nJ2hPn6p+GPO0uDV54dWKP+50Lo9IlLi
	 LrXNnedhEiiXUVZmHLwIqO9sW3+cdlSpGfpPpOrnq2vfQPpkmmto+GUZlwUqx6ziBL
	 tefeLe/uYYrlzdDviBVx8oYRddMt+maAV1P70zPxaW5AWZg9CLw+8NRgbDySgp1vuR
	 5MCN/Ur1XieIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C66AF60835;
	Tue, 24 Nov 2026 16:30:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35536499
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27AB640764
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_UT9t9BlMsl for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:30:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6883D405B1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=bdJeJ4fq; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WvNf4Skv
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6883D405B1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:08 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFtnSf1684117
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W1KHz3GQBUJk37ySxziuIptGEQfRQvFP80TPYYANdxM=; b=bdJeJ4fqOu+QiQtp
 BdXTS0mkCroV9zXWGaJHfh8OvZ2axkCU4OeL/9sf4ihuRFdvsf+aYMwQGe3Yga6s
 05/JrvqW1t9GiPOUKaCzGfxhVcmDE9H9J2+wL54a9u+WJDgq1IRJeg1ORDpBgEFe
 TCH4SHvCg6D6NpxCXUpNHcGfMlITdCmrhR1DIadZxLhm1aX3d4jywU4VihbXB2Sn
 6MHlhou9rXPNDua6DObQWuDNjSnbuuITa0KYRVECu0GRTYSLihiVpnmi3z9rWOYN
 fLx7ZPuJ4e27WB5yvZDndUODIJy/V2lT0d71MXOuut5Yhyh60EOmcB9UgH0MXSWv
 8ARaLg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5dngg5gt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:07 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98a829c43f3so889559241.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795537806; x=1796142606;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W1KHz3GQBUJk37ySxziuIptGEQfRQvFP80TPYYANdxM=;
 b=WvNf4SkvxiryQlOld33DtEFygtqyTDHlwlUKIX7ZQqg7FhR/aL9zS3LMOCUf239baj
 eLqKwktlplDa/R4XBULg0aQVZRJRcARWMaxNuVwZcG4HUIl6O0K+v4vY+7ASSzZ1rI3c
 xanYuGf0zrpzn2NLDOZnXqyygUd3EyJtyjU8EWiY2mgM85t0anmuKFGi0vbgGLfuln2u
 fHWi8yW7Cz4+wUfy2ts4RtypAGJ/Z+ZsfB/mBSJNsVGP92rQcfZezmM8Gu3VyMqhsLPc
 2QCt06Rs1ATTkmMmqkbfgjeRuC8WKGngoazHM6/ZxBXp58GFsyBgconfmdGZw8C8IBLd
 sSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537806; x=1796142606;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W1KHz3GQBUJk37ySxziuIptGEQfRQvFP80TPYYANdxM=;
 b=SbNk/Klp3TyUqKYk8pjw6qq17fwdZxIpd43QWRo0S4Ku6YPrV93z6MNHW2qHhIXqJb
 wkJrLAjuHHqkqB8TE+picKqIRv6wrzxmXfrXxtvubWbBwyTk0Sz99q9LJtGJ3JS3VSEW
 4vhL1CWiA9oeOmarBAS+hEXPqSByEGKYe8cx+OXIdJVHxFPp2lRblUAciurm0aN62O4c
 ChcrabTEcPzTaywROI7dcduxbzb07Kw97OuAMq0ggJ4L1e8EU85aB/yv6pbT0FVf6F2d
 21aG7J6VKk3M3p6aCBbhgakhsa7MLK0IPis2nCgU9zvIX0bNMlTw68BNtsWs90C+Fkob
 YwqA==
X-Forwarded-Encrypted: i=1;
 AL+hErFiafg+wDvzrQRltRMWeRVgPmbJWRCQIzCNSFEWU6+MNsQLYTjgyO27TtAeHHZBxpYzJez1nSw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/8FFhlLz4EvOzPJQ1LKeIR5F9rvrX+TGnE7A2BJ11r505zlnqV
 iUslbRsgTbQpyJAyfvC0qdFC3haUDcUcQVdYlMbMcFChDdhSC3sMkTaYuWzqldCjM/IL6B74wS+
 fIirBGbS/Ve25LbwI8Nlx+x+2e19QzwLvAAISFkm0NfT+6UwvW1wsFQbQiJnIxRjCSC58HXE=
X-Gm-Gg: AZFdTZeb1XG+y/CTG/yMKqdgpm/ogWMtG1v/fyXJ8cFRveODWC8LpYQ0cW1Gq2fOq1N
 XZUmVAn7JABh996SFtUjr263ulRkv27dzm7FcfdgzcOGWAzOLQ3spN9y6SaZ9OgpeSv8yGNv1As
 g0hGo0I+ZYsUM9HA//3lkBbreNUdmiaicuFosdHcUpNFDzYOo9ebAs7Rb9KphD3w4luqaEZLf2r
 DJcvIkpRMm4J5Aidnb/mNKxCJVfiu0mTHO+2DuP4sU4MGYST7L4wT0YZjALlrPz0RTB36qTNEuT
 fTKH9bW0jPry/Ki4cgBmfWlWbCFSPPYo2VJkj3vhRISAN2kJXHJ+vMIAzs4CfzFpdgpQq69Qx0F
 K98b1H9CBKHyeeoApKvvDqzc/poLRz1tIUgTn9xH71A5KIyXcolIG8a4AwE/0tVw3pw8sjsbagL
 b2BOhe8IrVkXd+
X-Received: by 2002:a05:6122:1d4a:b0:5ea:f1eb:b9e2 with SMTP id
 71dfb90a1353d-5ee8af546a5mr8210574e0c.19.1795537805361; 
 Tue, 24 Nov 2026 08:30:05 -0800 (PST)
X-Received: by 2002:a05:6122:1d4a:b0:5ea:f1eb:b9e2 with SMTP id
 71dfb90a1353d-5ee8af546a5mr8210505e0c.19.1795537804670; 
 Tue, 24 Nov 2026 08:30:04 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370fbf0esm7058223a12.23.2026.11.24.08.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:30:03 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:25:03 +0100
Subject: [PATCH v2 6/7] test: avb: test verification of preloaded
 partitions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-upstream-avb_tests_b4-v2-6-ed7136c3767c@oss.qualcomm.com>
References: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
In-Reply-To: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfXzNdOSFXW2zXm
 aWzEEvBt3BpXF0Qw06SgHa7FjrSW5Tynzca3Gs5Y1s+CyHYU6HACFAlfywNIJLHG12j9F+v6wWJ
 tL82Zkv49W/8BqHPb5sFIyzNlwXreIU=
X-Proofpoint-ORIG-GUID: 3es-7Nouy2mbcPlhiTOsIXxeCB7h0kzk
X-Proofpoint-GUID: 3es-7Nouy2mbcPlhiTOsIXxeCB7h0kzk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfX4Rr0MNACZ8JB
 yUYDemP8S2b6i2eO76z7xNLCbwT8oc2o48ljLqFin0UHdxwIbSBtiF7EiFYxqxECcHNJXLddw0D
 o7CstI/w8I+mPO4zgTwSQvaYroD2EU2TQ5UuHYcy+1ADHTIh8y8g9BDQXRFB+IZF4130Vxghi5P
 nkf3VJwm+nALJEcqTaX8+60Cex1ny36PZi8HbiYyA/3LvukzzqBtnuzbSjB9HmrnkqPJl/YK4vt
 FWPq7e40IKnGsUuAAVwEgdord5ADbFDFfB/SaPOkueyF2p5TXNLpgGh9yZm7fAV5QFq+LRKLvuR
 0CPHIpKYWwvIwvFR9Y5WhUk4OIFQjphnKHF59vmi4HWt6nYgZ7eFz55eCvdxi/yH5C5hyfJ9gT8
 rfKicrEKIvZYi9L24zkWTWa3SFknqrKC1kXodpAwdPpJNocCGIhW1sNCpYMAOScQYEaw2U3VCcd
 rddzn4zH6cyGka3gw+A==
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b05bb8f cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pb6jiW_T4zwQh3vISIMA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Android bootmeth hands libavb the buffers it boots from, so that the
bytes it verifies are the bytes it boots. Check that libavb hashes the
buffer rather than a fresh read of the partition, that a tail the boot
image header did not announce is read into the same buffer, and that a
buffer too small for the hash descriptor fails instead of overflowing.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 MAINTAINERS        |   1 +
 test/boot/Makefile |   1 +
 test/boot/avb.c    | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6edf740a9ce..e51dc102a99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -119,6 +119,7 @@ F:	common/avb_verify.c
 F:	doc/android/avb2.rst
 F:	include/avb_verify.h
 F:	lib/libavb/
+F:	test/boot/avb.c
 F:	test/py/tests/test_android/test_avb.py
 
 ARC
diff --git a/test/boot/Makefile b/test/boot/Makefile
index a8803ded814..8214151bd1b 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -4,6 +4,7 @@
 
 ifdef CONFIG_UT_BOOTSTD
 obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
+obj-$(CONFIG_AVB_VERIFY) += avb.o
 obj-$(CONFIG_FIT) += image.o
 
 ifdef CONFIG_VIDEO_SANDBOX_SDL
diff --git a/test/boot/avb.c b/test/boot/avb.c
new file mode 100644
index 00000000000..94313513c6d
--- /dev/null
+++ b/test/boot/avb.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the AVB operations used by the Android bootmeth
+ */
+
+#include <avb_verify.h>
+#include <blk.h>
+#include <dm.h>
+#include <malloc.h>
+#include <part.h>
+#include <asm/global_data.h>
+#include <dm/lists.h>
+#include <dm/ofnode.h>
+#include <test/ut.h>
+#include "bootstd_common.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* mmc12.img: boot (boot image v2 with a hash footer), system, vbmeta */
+#define AVB_MMC_DEV	12
+
+/* Size of that boot image, which is what its hash descriptor covers */
+#define AVB_BOOT_IMG_SIZE	0x2000
+
+/* Bytes of the boot image left for libavb to read from the partition */
+#define AVB_TAIL_SIZE		3
+
+/* Verify boot with the given preloaded buffer, return the libavb result */
+static AvbSlotVerifyResult avb_verify_preloaded(u8 *buf, size_t size,
+						size_t max_size,
+						bool *used_buf)
+{
+	static const char *const parts[] = { "boot", NULL };
+	AvbSlotVerifyData *data = NULL;
+	AvbSlotVerifyResult res;
+	AvbOps *ops;
+
+	ops = avb_ops_alloc(UCLASS_MMC, AVB_MMC_DEV);
+	if (!ops)
+		return AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
+	if (avb_ops_add_preloaded(ops, "boot", buf, size, max_size)) {
+		avb_ops_free(ops);
+		return AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_ARGUMENT;
+	}
+
+	res = avb_slot_verify(ops, parts, "", AVB_SLOT_VERIFY_FLAGS_NONE,
+			      AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
+			      &data);
+	*used_buf = data && data->num_loaded_partitions == 1 &&
+		    data->loaded_partitions[0].preloaded &&
+		    data->loaded_partitions[0].data == buf;
+	if (data)
+		avb_slot_verify_data_free(data);
+	avb_ops_free(ops);
+
+	return res;
+}
+
+/*
+ * The bootmeth hands libavb the buffers it boots from, so that the bytes it
+ * verifies are the bytes it boots. Check that libavb hashes those buffers
+ * rather than reading the partition again.
+ */
+static int avb_preloaded(struct unit_test_state *uts)
+{
+	struct disk_partition info;
+	struct blk_desc *desc;
+	bool used_buf;
+	ofnode node;
+	size_t size, head, i;
+	u8 *buf;
+
+	node = ofnode_find_subnode(oftree_root(oftree_default()), "mmc12");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, NULL, NULL, false));
+	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, AVB_MMC_DEV);
+	ut_assertnonnull(desc);
+	ut_assert(part_get_info_by_name(desc, "boot", &info) > 0);
+
+	size = info.size * info.blksz;
+	buf = malloc(size);
+	ut_assertnonnull(buf);
+	ut_asserteq(info.size, blk_dread(desc, info.start, info.size, buf));
+
+	/* The preloaded buffer is what gets verified */
+	ut_asserteq(AVB_SLOT_VERIFY_RESULT_OK,
+		    avb_verify_preloaded(buf, size, size, &used_buf));
+	ut_assert(used_buf);
+
+	/* A change to the buffer fails although the partition is intact */
+	buf[0] ^= 0xff;
+	ut_asserteq(AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION,
+		    avb_verify_preloaded(buf, size, size, &used_buf));
+
+	/*
+	 * The boot image header may announce fewer bytes than the hash
+	 * descriptor covers: the rest is read into the same buffer...
+	 */
+	buf[0] ^= 0xff;
+	head = AVB_BOOT_IMG_SIZE - AVB_TAIL_SIZE;
+	memset(buf + head, 0xa5, size - head);
+	ut_asserteq(AVB_SLOT_VERIFY_RESULT_OK,
+		    avb_verify_preloaded(buf, head, size, &used_buf));
+	ut_assert(used_buf);
+
+	/* ...but never past its end */
+	memset(buf + head, 0xa5, size - head);
+	ut_asserteq(AVB_SLOT_VERIFY_RESULT_ERROR_IO,
+		    avb_verify_preloaded(buf, head, head, &used_buf));
+	for (i = head; i < AVB_BOOT_IMG_SIZE; i++)
+		ut_asserteq(0xa5, buf[i]);
+
+	free(buf);
+
+	return 0;
+}
+BOOTSTD_TEST(avb_preloaded, UTF_DM | UTF_SCAN_FDT);

-- 
2.53.0

