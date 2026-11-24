Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437C606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FWGGWN6x;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PTLDEcQi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hiWOpceP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AAF8407DA;
	Tue, 24 Nov 2026 09:03:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C8DlyUY_ZK0M; Tue, 24 Nov 2026 09:03:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 46FAA407D3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795510983;
	b=NQOaA7NXpcAtUvGpz+w+EsA6oN+ciXfIMVjkxo62KV2BUFHaXPvJyeEtU+T2/or+GyOn
	 iqJXh2chU1qxYdHt1KoW7QjOPWnss8kt8VmNnIZ4I481kRRebWR5q9VMJBq9pWUksXn0L
	 CMLXPwKctwRInubzdHBJyI2THuh5zG8YMHdHODN3j339V00IPNYjso2kmqYkX54FGzyZv
	 EUA53p4gA6vDT1zV3t2kxypvX2z31MRp4p0TBoS8o3xQvnCuvZwp9OMLfOHq206bjCSrv
	 0su5pL2MljtRqwhWJNltqANX4pajfX30nKtAqQwFCHDDVBvQWmF2UtITW/HPG70iioA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795510983;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/dO55xcB7zkzzRjKiqNwUJcECQEMrn6vIOyBj5Cd1AU=;
	b=eUl8UzF3od6ht1pKbruzK7LzkaMeLqDn7nRgHiwlqNRp4rdLpJso0PBew8/oS7nstnBK
	 ONmaF3gwLzefxqmR4StL8OASzw0dm/JeexCJjAbXekwktqnVtzldT4JiMPtu7YB9tM67b
	 ymGGUqs18uBpmuFpTOXu2P2C2p7FARPiYFv3Z/UtJ56rKFq8HHMYm1TvPoawcASu9WLiQ
	 dBs2ZhHuXLPbRmLXYREDcKw5YGq1IfqlgHik+6jaBoAlyBagcWEcv+9DMeHlmQWl8ra++
	 0c+SNcieUnJgGcNDg7eOJMJ27Ld2HDnmd2Q6AsjeY7wVhar7lqw+GFUSHYFyoosFf4g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795510983;
	bh=/dO55xcB7zkzzRjKiqNwUJcECQEMrn6vIOyBj5Cd1AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FWGGWN6xDMwvXjBHC0SjlTzMHEmlk3TJr6P8wmO4RYvH3I00IVTg7AR0mkiOTjKhd
	 SfEno0h+5y3Eu7s+urOtaLiLGo3iZIo3GMqd3wocsQgEHXq2AzSlSjvC7Dxmfvv3TH
	 d8KWYMoPIs4DMM5zU/3GMZKxZhz/gIEBd195xHpCJiP4DMoS0W0HW1PHB2Ve4jVqTW
	 z/rM/T9C2X0eVo/9mo2m9F7PM5FPzrrA5hUyUU8Ahhjy9pBbhcgZv78QttoWAj/NfZ
	 Dw5wTA9UvgKK8CKlvcxBNjI78k637of+gk96NYXIf6T9c3zAQM007epliXA0mh/1Yz
	 jPN1Zl/8EdBRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46FAA407D3;
	Tue, 24 Nov 2026 09:03:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB2491AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCFA1400AE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:03:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UM3phP1ZstlZ for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:03:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EB95340068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=PTLDEcQi; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hiWOpceP
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB95340068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:03:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8UZct4129069
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/dO55xcB7zk
 zzRjKiqNwUJcECQEMrn6vIOyBj5Cd1AU=; b=PTLDEcQikVrkjAWslWd3L3M3iVq
 3Wb2UNZK/mosBJ49sMnxpySScRrQZNzVWQcE+P4RkVbwPx/hnAKj+C3ahREjE9BW
 lPswYkV440txRTERky2akOKjvvWhOPvn3CzlQ/n90jqtlfi4n9wS8E7PA8d2RlYE
 4FLBqFJwobVTfpLa9NdNJOr3oa9+9a9Bi1/pCy9lKbOv6ghdtZ6rmqXiwUv7jF+L
 Fr33yezHyVgQ7NQU9f69gDUZPk+/Z1LB6RVF8RnCzwXJMqksPMCaly5KtG9PNgwJ
 6oX9tP6b6vo8BnDDNwOQSeEZv59/4Dn4JyVkLv0oxZXmgY6YGXQtdZXNxGQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yyt1thx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:03:00 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3846d5f54c1so5372137eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 01:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795510980; x=1796115780;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/dO55xcB7zkzzRjKiqNwUJcECQEMrn6vIOyBj5Cd1AU=;
 b=hiWOpcePv3I3G/6DV8zPIuI1o9jr5G34MIyHd/DDxEgshLE35+S7VqIKpRtwuZcRQf
 QloELTCHjTWKuoHD9rE+O+8cI+asbwPFNfcmCQ+qHOWCrmMmZaRPXy35VCOwJVruXUYX
 aUWYA4RBdoLfIZxrzZfo3qQAzLzwfsVX5SkkIk9CeyhIFVrm+n2TaQl30SsB5TmWsoeV
 308IUI1am4uZCDyUMbFIxtCXpvwTcMqDUOVPh2vRIt/aZIgf3czMAOdLAuJh0cShYcwI
 ynxr+HPq027Sulcq0njhMwaeYxLN2v6XIPA6+JQPD3E1hFNfergPFleBmaj+f3+aOCpk
 alug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795510980; x=1796115780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/dO55xcB7zkzzRjKiqNwUJcECQEMrn6vIOyBj5Cd1AU=;
 b=aUVpnWC28lUNw1MF500+2nlles/jMtBPkC6sqh6Z+tCF/gkn7Y5fP1yCQ+15R0eAWN
 lHTdBnwohD6t692pTG0N59GpadkhAJnXFQD8xpa+A7xeS7cBt+S97MauWeaUsEQ91PFh
 BaprMO5FcfZodKAyQS33BxyWjbr4EpvkrWG4aJ9Yvap7Xj6AjqUfBADhWYA1M3nfU8kV
 JCdm4+5MMvdmm7CvVw/BAobwL3umve7vnw454EJuPGpo2uvaKBS5pEe9OaakiLQzUmW5
 3zcvsCbZq93YgR/ZT3qBzAR1/bNyxP0J19qLu5pY2foCyvqJIIJYOoL7q+FvskWz56eq
 OB2w==
X-Forwarded-Encrypted: i=1;
 AL+hErHw/j3hGqwPaNTof1moyHW/idV0FO1ZZ+uhuscZCFA/WHH8asqEymUshooQKGBDEG+zwc42v38=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/RHKOfeAj/JdC6fzv9kyNj+oA8RrP2qgSv+JEPauJg3UVeea7s
 7WHR9aVGJVrFZgkJY0WdA2T+Euo/cW0YC0Qoy1JWr975Si0+T2NhsPYnJb4+wS+BYbmMwppYB52
 gv8W0nDWr1YETmUXEJ3+3wmYVbYjNWffFcvQwERRyK52jRgwsUK5lCzpFaabXYAKueskZYJg=
X-Gm-Gg: AZFdTZf0q5NFGzmH4rVkFUHB+diuh2s3vB7NDzeVZwzObHLvThy581YnM3/1VPQYWOM
 y5Ux8z1m6Px5u8uFx5bhTCKGrDfT2bkoPSOd00wOVCmp87MpSjt+ouEQfwOjvHUqxn8OzdW0/Cc
 wfZj+TFZMB1rHrVPWPUSCm2n38SUu2OqjKqUUiVwJ3Nh5FDCdnLpvAWeGcagRQGvidBPvwau9Vo
 xVr4MqXcBXdAuFp3AfYqx79U8cjBdg/edVYu4qAU4H4NOchxoTOwK6BPiOdG8rbr7lpOGKLWLS6
 p+xk2nWjdB4Sjq57X/mnbg8mQMdWUU1HI1oFtBPKi5uPEsQiG1D0COk+/+abp05jJhKaXUGnqZr
 /tPgBOi7vOqRASKC8DwCzuUhZe7ScwL0AWrf+X+pW+CtQ1Gmd4wXpmmRaVvJzHsWNHLtJYp2Z7y
 U5
X-Received: by 2002:a05:7301:3d19:b0:376:ce6a:a499 with SMTP id
 5a478bee46e88-3857122312dmr19750604eec.36.1795510979462; 
 Tue, 24 Nov 2026 01:02:59 -0800 (PST)
X-Received: by 2002:a05:7301:3d19:b0:376:ce6a:a499 with SMTP id
 5a478bee46e88-3857122312dmr19750546eec.36.1795510978626; 
 Tue, 24 Nov 2026 01:02:58 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566fdce48sm46429154eec.14.2026.11.24.01.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:02:58 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, royzah@gmail.com,
 deepak.g10@oss.qualcomm.com, dlechner@baylibre.com, 3305708832@qq.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, jbx6244@gmail.com,
 dlan@kernel.org, anshuld@ti.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH v3 4/5] net: dwc_eth_qos: qcom: add SA8775P support
Date: Tue, 24 Nov 2026 14:32:09 +0530
Message-Id: <20261124090210.2560500-5-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124090210.2560500-1-mmanikan@qti.qualcomm.com>
References: <20261124090210.2560500-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX+VCTAjYYnxja
 FzmQLUo+QcrJwIgHcfJiuyhTJVmqqSfUuYOcPk98IiekwhfPYxi4MC56Qv0OSORUv4LM1b6QWhh
 M2DDh8l6wpYrUW1qGZYy0w7c0gjVp2k=
X-Proofpoint-GUID: rCqjrwyhpF3yVORmb7Am-6UGeo2KaNyT
X-Proofpoint-ORIG-GUID: rCqjrwyhpF3yVORmb7Am-6UGeo2KaNyT
X-Authority-Analysis: v=2.4 cv=W9OtxhWk c=1 sm=1 tr=0 ts=6b0552c4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=RN49KxeIwWVS5ikiMusA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfXyQBNngHbNBOy
 XYH+G/U9ptBjnpxKa0i0vcpNfnQ7NY0C5HZlQGPolnzbFVC4dRVOIRVsqiJprqtv44wnexpWw4R
 rA2Y4VXg1eybAYxsh4Ww4AN3Ft5shqvibOeU4BmTaxr/gu1lLwVUk3XnYqs24G1MtNr2aYwGLn2
 YhEEXjedKDsX7NGEUJkt0fC4Z/pmC49Z3QfYnYf7uyBD7J8h8HTouF/XAtSVin4vTgsQuY1Hwmr
 XG2PN+xsD1mWXvN90O3fu+RX6VVN+9T4Hh3fNMMDvdxsSZwjKobG6tA6uT1eSYMH+m5tk9bC3uz
 9HAsjYVvg6bWrTbbniJF6awdHSo5M8l7DzKnjrA7TuLvOHdEA46LUX7+mFnyMj/L2u15KkuokWY
 hnJPTrN6KioICeOLQvs1IG1R/8ypI26ZGlMV+HRvuXSXb8XBYCweGEbvWt2BmtHqfFfy7j47SGU
 oF3mlH/YD49S2hW6Dxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240034
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

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

SA8775P uses the Qualcomm EQOS wrapper with an external SGMII SerDes and
relocates the MTL and DMA channel register blocks to offsets 0x8000 and
0x8100 respectively.

Add SA8775P platform data and resource handling. Bring up the SerDes with
the Qualcomm clocks, use the wrapper loopback during initialization and
configure the MAC, wrapper divider, PCS in-band negotiation and SerDes
mode for 10, 100, 1000 and 2500 Mbps links.

Enable PCS in-band negotiation for SGMII and keep it disabled for
2500BASE-X operation.

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
Changes in v3:
- No code changes.

 drivers/net/dwc_eth_qos.c      |   4 +
 drivers/net/dwc_eth_qos.h      |   6 +
 drivers/net/dwc_eth_qos_qcom.c | 276 +++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 09c6c2e30e5..4781a853229 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1659,6 +1659,10 @@ static const struct udevice_id eqos_ids[] = {
 		.compatible = "qcom,qcs404-ethqos",
 		.data = (ulong)&eqos_qcom_config
 	},
+	{
+		.compatible = "qcom,sa8775p-ethqos",
+		.data = (ulong)&eqos_sa8775p_config
+	},
 #endif
 #if IS_ENABLED(CONFIG_DWC_ETH_QOS_STARFIVE)
 	{
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index b2e35c72423..7f353a8e174 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -5,6 +5,7 @@
 
 #include <asm/gpio.h>
 #include <clk.h>
+#include <generic-phy.h>
 #include <linux/bitops.h>
 #include <phy_interface.h>
 #include <reset.h>
@@ -289,6 +290,10 @@ struct eqos_priv {
 	struct clk clk_tx;
 	struct clk clk_ck;
 	struct clk clk_slave_bus;
+	struct phy serdes_phy;
+	phy_interface_t serdes_interface;
+	bool serdes_inited;
+	bool serdes_powered;
 	struct mii_dev *mii;
 	struct phy_device *phy;
 	ofnode phy_of_node;
@@ -319,6 +324,7 @@ void *eqos_get_driver_data(struct udevice *dev);
 extern struct eqos_config eqos_imx_config;
 extern struct eqos_config eqos_rockchip_config;
 extern struct eqos_config eqos_qcom_config;
+extern struct eqos_config eqos_sa8775p_config;
 extern struct eqos_config eqos_stm32mp13_config;
 extern struct eqos_config eqos_stm32mp15_config;
 extern struct eqos_config eqos_stm32mp25_config;
diff --git a/drivers/net/dwc_eth_qos_qcom.c b/drivers/net/dwc_eth_qos_qcom.c
index de0ae090c5d..ab4b088e459 100644
--- a/drivers/net/dwc_eth_qos_qcom.c
+++ b/drivers/net/dwc_eth_qos_qcom.c
@@ -11,9 +11,11 @@
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <generic-phy.h>
 #include <phy.h>
 #include <reset.h>
 #include <syscon.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
@@ -70,6 +72,23 @@
 #define RGMII_CONFIG2_DATA_DIVIDE_CLK_SEL	BIT(6)
 #define RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN	BIT(5)
 
+/* RGMII_IO_MACRO_CONFIG field used by SGMII (same register as above) */
+#define RGMII_CONFIG_SGMII_CLK_DVDR		GENMASK(18, 10)
+#define SGMII_10M_RX_CLK_DVDR			0x31
+
+/* EMAC_WRAPPER_SGMII_PHY_CNTRL1, offset 0xf4 in the "rgmii" wrapper region */
+#define EMAC_WRAPPER_SGMII_PHY_CNTRL1		0xf4
+#define SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN	BIT(3)
+
+/* MAC_CTRL_REG bits -- same register as mac_regs->configuration */
+#define ETHQOS_MAC_CTRL_SPEED_MODE		EQOS_MAC_CONFIGURATION_FES
+#define ETHQOS_MAC_CTRL_PORT_SEL		EQOS_MAC_CONFIGURATION_PS
+
+/* DWMAC4 integrated PCS auto-negotiation control register */
+#define ETHQOS_MAC_PCS_AN_CTRL			0xe0
+#define ETHQOS_MAC_PCS_AN_RESTART		BIT(9)
+#define ETHQOS_MAC_PCS_AN_ENABLE		BIT(12)
+
 struct dwmac_rgmii_regs {
 	u32 io_macro_config;		/* 0x00 */
 	u32 sdcc_hc_dll_config;		/* 0x04 */
@@ -614,3 +633,260 @@ struct eqos_config __maybe_unused eqos_qcom_config = {
 	.interface = dev_read_phy_mode,
 	.ops = &eqos_qcom_ops
 };
+
+static void eqos_sgmii_set_loopback(struct dwmac_rgmii_regs *regs, bool enable)
+{
+	clrsetbits_le32((void *)regs + EMAC_WRAPPER_SGMII_PHY_CNTRL1,
+			SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN,
+			enable ? SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN : 0);
+}
+
+static void eqos_sgmii_set_inband_an(struct eqos_priv *eqos, bool enable)
+{
+	void __iomem *an_ctrl = (void __iomem *)eqos->mac_regs +
+			       ETHQOS_MAC_PCS_AN_CTRL;
+
+	if (enable)
+		setbits_le32(an_ctrl, ETHQOS_MAC_PCS_AN_ENABLE |
+			     ETHQOS_MAC_PCS_AN_RESTART);
+	else
+		clrbits_le32(an_ctrl, ETHQOS_MAC_PCS_AN_ENABLE |
+			     ETHQOS_MAC_PCS_AN_RESTART);
+}
+
+static int eqos_start_clks_sa8775p(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	int ret;
+
+	ret = eqos_start_clks_qcom(dev);
+	if (ret)
+		return ret;
+
+	eqos_sgmii_set_loopback(eqos->eqos_qcom_rgmii_regs, true);
+	ethqos_set_func_clk_en(eqos->eqos_qcom_rgmii_regs);
+
+	ret = generic_phy_init(&eqos->serdes_phy);
+	if (ret) {
+		pr_err("generic_phy_init(serdes) failed: %d\n", ret);
+		eqos_stop_clks_qcom(dev);
+		return ret;
+	}
+	eqos->serdes_inited = true;
+
+	ret = generic_phy_set_mode(&eqos->serdes_phy, PHY_MODE_ETHERNET,
+				   PHY_INTERFACE_MODE_SGMII);
+	if (ret) {
+		pr_err("generic_phy_set_mode(serdes) failed: %d\n", ret);
+		generic_phy_exit(&eqos->serdes_phy);
+		eqos->serdes_inited = false;
+		eqos_stop_clks_qcom(dev);
+		return ret;
+	}
+	eqos->serdes_interface = PHY_INTERFACE_MODE_SGMII;
+
+	ret = generic_phy_power_on(&eqos->serdes_phy);
+	if (ret) {
+		pr_err("generic_phy_power_on(serdes) failed: %d\n", ret);
+		generic_phy_exit(&eqos->serdes_phy);
+		eqos->serdes_inited = false;
+		eqos_stop_clks_qcom(dev);
+		return ret;
+	}
+	eqos->serdes_powered = true;
+
+	return 0;
+}
+
+static int eqos_stop_clks_sa8775p(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	if (eqos->serdes_powered) {
+		generic_phy_power_off(&eqos->serdes_phy);
+		eqos->serdes_powered = false;
+	}
+	if (eqos->serdes_inited) {
+		generic_phy_exit(&eqos->serdes_phy);
+		eqos->serdes_inited = false;
+	}
+
+	return eqos_stop_clks_qcom(dev);
+}
+
+static int eqos_probe_resources_sa8775p(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	phy_interface_t interface;
+	int ret;
+
+	debug("%s(dev=%p):\n", __func__, dev);
+
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		pr_err("eqos_get_base_addr_dt failed: %d\n", ret);
+		return ret;
+	}
+
+	interface = eqos->config->interface(dev);
+	if (interface == PHY_INTERFACE_MODE_NA) {
+		pr_err("Invalid PHY interface\n");
+		return -EINVAL;
+	}
+
+	eqos->max_speed = dev_read_u32_default(dev, "max-speed", 0);
+	eqos->tx_fifo_sz = dev_read_u32_default(dev, "tx-fifo-depth", 0);
+	eqos->rx_fifo_sz = dev_read_u32_default(dev, "rx-fifo-depth", 0);
+
+	eqos->eqos_qcom_rgmii_regs = (void *)dev_read_addr_name(dev, "rgmii");
+	if ((fdt_addr_t)eqos->eqos_qcom_rgmii_regs == FDT_ADDR_T_NONE) {
+		pr_err("Invalid RGMII/wrapper address\n");
+		return -EINVAL;
+	}
+
+	ret = generic_phy_get_by_name(dev, "serdes", &eqos->serdes_phy);
+	if (ret) {
+		pr_err("generic_phy_get_by_name(serdes) failed: %d\n", ret);
+		return ret;
+	}
+
+	debug("%s: OK\n", __func__);
+	return 0;
+}
+
+static int eqos_remove_resources_sa8775p(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	debug("%s(dev=%p):\n", __func__, dev);
+
+	if (eqos->serdes_powered) {
+		generic_phy_power_off(&eqos->serdes_phy);
+		eqos->serdes_powered = false;
+	}
+	if (eqos->serdes_inited) {
+		generic_phy_exit(&eqos->serdes_phy);
+		eqos->serdes_inited = false;
+	}
+
+	debug("%s: OK\n", __func__);
+	return 0;
+}
+
+static int eqos_set_sgmii_speed_qcom(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct dwmac_rgmii_regs *rgmii_regs = eqos->eqos_qcom_rgmii_regs;
+	phy_interface_t interface = eqos->phy->interface;
+	int ret;
+
+	debug("%s(dev=%p): interface=%d speed=%d\n", __func__, dev,
+	      interface, eqos->phy->speed);
+
+	if (interface != PHY_INTERFACE_MODE_SGMII &&
+	    interface != PHY_INTERFACE_MODE_2500BASEX) {
+		pr_err("unsupported interface %d for speed %d\n",
+		       interface, eqos->phy->speed);
+		return -EINVAL;
+	}
+
+	eqos_sgmii_set_loopback(rgmii_regs, false);
+	eqos_sgmii_set_inband_an(eqos, false);
+
+	if (eqos->serdes_interface != interface) {
+		ret = generic_phy_set_mode(&eqos->serdes_phy, PHY_MODE_ETHERNET,
+					   interface);
+		if (ret) {
+			pr_err("generic_phy_set_mode(serdes) failed: %d\n", ret);
+			return ret;
+		}
+		eqos->serdes_interface = interface;
+	}
+
+	switch (eqos->phy->speed) {
+	case SPEED_2500:
+		if (interface != PHY_INTERFACE_MODE_2500BASEX)
+			return -EINVAL;
+		clrbits_le32(&eqos->mac_regs->configuration,
+			     ETHQOS_MAC_CTRL_PORT_SEL |
+			     ETHQOS_MAC_CTRL_SPEED_MODE);
+		setbits_le32(&rgmii_regs->io_macro_config2,
+			     RGMII_CONFIG2_RGMII_CLK_SEL_CFG);
+		clrbits_le32(&rgmii_regs->io_macro_config,
+			     RGMII_CONFIG_SGMII_CLK_DVDR);
+		break;
+	case SPEED_1000:
+		if (interface != PHY_INTERFACE_MODE_SGMII)
+			return -EINVAL;
+		clrbits_le32(&eqos->mac_regs->configuration,
+			     ETHQOS_MAC_CTRL_PORT_SEL |
+			     ETHQOS_MAC_CTRL_SPEED_MODE);
+		setbits_le32(&rgmii_regs->io_macro_config2,
+			     RGMII_CONFIG2_RGMII_CLK_SEL_CFG);
+		clrbits_le32(&rgmii_regs->io_macro_config,
+			     RGMII_CONFIG_SGMII_CLK_DVDR);
+		break;
+	case SPEED_100:
+		if (interface != PHY_INTERFACE_MODE_SGMII)
+			return -EINVAL;
+		setbits_le32(&eqos->mac_regs->configuration,
+			     ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE);
+		clrbits_le32(&rgmii_regs->io_macro_config2,
+			     RGMII_CONFIG2_RGMII_CLK_SEL_CFG);
+		clrbits_le32(&rgmii_regs->io_macro_config,
+			     RGMII_CONFIG_SGMII_CLK_DVDR);
+		break;
+	case SPEED_10:
+		if (interface != PHY_INTERFACE_MODE_SGMII)
+			return -EINVAL;
+		clrsetbits_le32(&eqos->mac_regs->configuration,
+				ETHQOS_MAC_CTRL_PORT_SEL |
+				ETHQOS_MAC_CTRL_SPEED_MODE,
+				ETHQOS_MAC_CTRL_PORT_SEL);
+		clrbits_le32(&rgmii_regs->io_macro_config2,
+			     RGMII_CONFIG2_RGMII_CLK_SEL_CFG);
+		clrsetbits_le32(&rgmii_regs->io_macro_config,
+				RGMII_CONFIG_SGMII_CLK_DVDR,
+				FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR,
+					   SGMII_10M_RX_CLK_DVDR));
+		break;
+	default:
+		pr_err("invalid speed %d\n", eqos->phy->speed);
+		return -EINVAL;
+	}
+
+	eqos_sgmii_set_inband_an(eqos,
+				 interface == PHY_INTERFACE_MODE_SGMII);
+
+	return 0;
+}
+
+static struct eqos_ops eqos_sa8775p_ops = {
+	.eqos_inval_desc = eqos_inval_desc_generic,
+	.eqos_flush_desc = eqos_flush_desc_generic,
+	.eqos_inval_buffer = eqos_inval_buffer_generic,
+	.eqos_flush_buffer = eqos_flush_buffer_generic,
+	.eqos_probe_resources = eqos_probe_resources_sa8775p,
+	.eqos_remove_resources = eqos_remove_resources_sa8775p,
+	.eqos_stop_resets = eqos_null_ops,
+	.eqos_start_resets = eqos_null_ops,
+	.eqos_stop_clks = eqos_stop_clks_sa8775p,
+	.eqos_start_clks = eqos_start_clks_sa8775p,
+	.eqos_calibrate_pads = eqos_null_ops,
+	.eqos_disable_calibration = eqos_null_ops,
+	.eqos_set_tx_clk_speed = eqos_set_sgmii_speed_qcom,
+	.eqos_get_enetaddr = eqos_null_ops,
+};
+
+struct eqos_config __maybe_unused eqos_sa8775p_config = {
+	.reg_access_always_ok = false,
+	.mdio_wait = 10,
+	.swr_wait = 50,
+	.config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
+	.config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
+	.axi_bus_width = EQOS_AXI_WIDTH_64,
+	.dma_ch_regs_base = 0x8100,
+	.mtl_regs_base = 0x8000,
+	.interface = dev_read_phy_mode,
+	.ops = &eqos_sa8775p_ops
+};
-- 
2.34.1
