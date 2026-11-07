Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C4606A32D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZCFfnmAy;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RmSMTHGq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AWimh50w
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37ACA812E9;
	Sat,  7 Nov 2026 02:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PoXU2uA_tPGR; Sat,  7 Nov 2026 02:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7240F812EE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794017167;
	b=VVNveV4tOI4BRYu7YzaVUI7nrCLoj5aMTVUMPfiCIs+Ewvz6XMQxvJFBn8YovdOh2tg6
	 606aPEs76mkA3zYQ4HGHVBbRaE9KXvCfO3yx4gXGxG/TqKvCw/Lduw8Y2o24fpyFfLqxI
	 aKYlwRuKZVKmB3Pzxj0BH5NqHOoiEw3ZHMLZfZoGGI5ODCutHvnMJbBymyYj7tU91Q2lo
	 NTEw6I6euNhBeaLN2cBq6KGjmq/3NkSxPrFLUv+A2sNA2htEYQU21wlQe/1pwQOD044fh
	 x7FenFC7ih+bLvQOtTQyCfYj7HDLyNBkoarJ9BUhd5xxscuE6odKoJgCMS7SdnZ2QNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794017167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wHx13ezgLB36GaUxLsBVJL6CKdpteLSqouRS9y3cfrM=;
	b=iIZRtT19aDH8wn2gP6qNCupB9pjYDvLoi/R8rdfp/bu16kc3+uOrLzEIBoDr+XI8D8SY
	 a95HHIryjB0W96l+TZxIU4vsgoOIJmPtrSp5EKPkCmMPaB0PTlm1drqlTL0HL/HkI59pN
	 N/DOlvT3oo1SH17OdEBT7xF2cxsnmLAXNQkvr3aSoEMZLG2bTu58H5VEg+uK8XxOuggpj
	 HfE5N/tZ8e/S3w1ccVh61e5lhvKWsKjjYz7ESGZThREZlbiKiMF8Uoh/2KGf17wwbfmH9
	 d54qCtsrnx/7C/m/773H7TJ/fhVc9qWFzf+aID04S49Z3vBuDQ2tk/Ug/ifKUQg2RnA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794017167;
	bh=wHx13ezgLB36GaUxLsBVJL6CKdpteLSqouRS9y3cfrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZCFfnmAyo1rHPl2qe3KvQETxp0Z/ixtJrvq4r5jOYlC6B75G3kOkk3CdsN94T+Q80
	 rXaP8om3tlPA3N3CY+XRk1GE1Yw0HB61BAUbfQjJ5sQBTTFlhmJysoLEY+UT1FGefg
	 eGyVGSIPMVRZi2XkQgBDkzZDtkEgbubo9kUJ07xoILv1MWVcPHN7E1W2i8btZAaG5I
	 KgeuEoSAIb309ytaMI6TkiWFb/G6eg7FtNRQfICxYaP1iYzJqsgv6KRE7wtu4gIaM4
	 v5gZFkGXhG4okdt1ZqFTc0ZL5Yi8nglr7l7HPPAh5zPaS5ykFUVsUOG5hQMbWWVzsE
	 9utU711W9WQBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7240F812EE;
	Sat,  7 Nov 2026 02:06:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A74272AC
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 02:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A48CA403CB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 02:06:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mfekfK9Mi78u for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 02:06:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D6F6040086
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=urvashi.sharma@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=RmSMTHGq; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AWimh50w
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6F6040086
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 02:06:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6MnwJe2144021
 for <u-boot@lists.u-boot-project.org>; Sat, 7 Nov 2026 02:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wHx13ezgLB3
 6GaUxLsBVJL6CKdpteLSqouRS9y3cfrM=; b=RmSMTHGqlpJo+3R4ODa25Fmmj0X
 o+CzmzGtXsluIp7obbEJrRhjDRWPE5eKTaSOv9fnEqWRL01YocpKK7x2tpY4/G6U
 evSPU2SbM8RdVeDhMSfzHQ7j891YW8jGvfnUbPnBT8Hty/5hehPtm0ZIxGSnkZ7k
 2wC/lx8oL7FmDkGf2tgZzSH+NZ7wxiuEPTBctfa+d6I7jH/A0BKjourvgfGaNaBc
 +9/0XV8DdI+lRgu2HwqoIpYt4kfbpXIe2/kPOUmWOmpn3sMXvhWoZylAwMbPtx7W
 yhu3z5ifC275O+/AAq3AJbr42r5R+uXwJvYr5RGR/v8r5tmboMk5qm0EoVA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyph43f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 02:06:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36fe0b57d91so1262452eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 18:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794017164; x=1794621964;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wHx13ezgLB36GaUxLsBVJL6CKdpteLSqouRS9y3cfrM=;
 b=AWimh50wAQ71EE/z3sPgHyCuS3uTvVyj1NL1ABlR8CwE+UraLrKUMYjJ9fLbvpBfpv
 8RXx9fxNgeI+DFUUWv3+OJQfOqNvkh59Fnw3FpQohRiSn9D8hUStdn3SQgQdhvy3E4FO
 5JSRIVeTmyWvUjo0Y0nWiMdoRoZM0kp+ZDD+Nvy8umKw960j5MaIZyr9aLnX0g+9PX/R
 sW8BsxH8i6xBILwVlrXEBQh8PdG5egJvrmd014orcy8M2OiwL0takIFFFdtc41MfCzg4
 TG2u/NvEAlqaSm0qph0iY9IptfDwcUFFgu5CCcteLze7uz4Mgnd2q0W911de+9vzSq2D
 7YFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794017164; x=1794621964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wHx13ezgLB36GaUxLsBVJL6CKdpteLSqouRS9y3cfrM=;
 b=FOuCHL6KM4XTh41yu3qjaIHUsqPKoWi7AgrB3eaXRPQqUQaBGHkWXkPs7i0C4AWU4d
 e5quf5vXI9PBgvqNU4wdrJGHkiWuqNoZljfH4wZmpr7IVCpq3dUgepPlTaI/Gjattki8
 vb7gUHnFiTDdsKfawddjxZHl/PezoTRA5u0P2iOiuZTR0l+Spn2xUbTuseiV3fX3L7Mc
 WXBZwrepeA1xOLvUilaoJn27X+jqZYCf4q01bLuBAYN/CbHKec8SFqNDAfnK+D3SU9XO
 NM1slIv3ZGRNUubr/ztrjqWrgErUBnsBqDaWAMFY9qdCx9ik90muZnDp9+xrNk04AsAI
 S6+w==
X-Gm-Message-State: APuU4Z+RRGCI+JU9HjroyFSN4vt2qoBsS8dMVAHxA27EvGiFcKRjv8Ih
 0Dd6TKkzev3L1BK4F04Q6OBAwk6ygS8dLiq2tmMw821ZXhN47nYWgMCeHJP+qPo/CmbwqcS0CeQ
 QVui7ecL/VMtBMFYN7ffzpCe02+HpJWK2KY07oEnCQAMb861GzXMEbQhWpgaVsevJwdrb9hinRu
 bcTak=
X-Gm-Gg: AYBFou2WgQIWNHUCSpq0fPZh22d4XwjlQr21N0iPqAZflsvqaLBFHLoL6a3RD0SUx5b
 X5a9hMviWE50EXuO7/mVPGPGgP/M9HFFw5mKe+1MfpvA5lAiCdzVzdf/6Aa0/FnPqxC/Hsc2Rpv
 pIrDV2ASCsToB28Zk/W7r7XxpP9GwdVY+Gj5xn619OdFRRusAZ5Eb2Bqa36Yvq6SOloB5NzLd0B
 LEOtSrjg8kyQdIcq6a5i4aAfKpINVSkD3Kt0Jju+8Cu2J+tjbOqe2GpDpRLDInrrPF/xdOcOtUE
 L2fe8WZNeA/vonz3MAxjVit/LxJstxjrt4ZcNU/lCRL02UGtXi6KYoRNIyODG0tK/HxSzIsYj1U
 FGzNyt5sALUFgDUr2mTXjVzjxVnoiJBpJxGMGQyA5tHDBYrEBx9QLIVH2qEH4HnaTzJG3edI1jr
 J7krqiuz5YR4zoNU/w2zZI6O5HwC95nA==
X-Received: by 2002:a05:7300:22cd:b0:36e:3ebb:7ef3 with SMTP id
 5a478bee46e88-36f784c0a40mr5607522eec.39.1794017163506; 
 Fri, 06 Nov 2026 18:06:03 -0800 (PST)
X-Received: by 2002:a05:7300:22cd:b0:36e:3ebb:7ef3 with SMTP id
 5a478bee46e88-36f784c0a40mr5607469eec.39.1794017162784; 
 Fri, 06 Nov 2026 18:06:02 -0800 (PST)
Received: from hu-urvashis-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8d44500sm10922798eec.5.2026.11.06.18.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 18:06:02 -0800 (PST)
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, rick@andestech.com, ycliang@andestech.com,
 e@freeshell.de
Subject: [PATCH v3 1/2] riscv: spl: Move BOOT_DEVICE enum to asm-generic/spl.h
Date: Fri,  6 Nov 2026 18:05:46 -0800
Message-Id: <20261107020547.2021618-2-urvashi.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107020547.2021618-1-urvashi.sharma@oss.qualcomm.com>
References: <20261107020547.2021618-1-urvashi.sharma@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAwOCBTYWx0ZWRfX1T0DbYLXeoCv
 CQbt/o95pTeN9UxkvU5cQS6qX4xiNLw9WtML2aqJAaU7B2sRMUf+fzEqg47Z+8E1l21JO78rN6/
 siFIQZUVtdyS7Op50CYhBQ042li888ILMtZKawxTALWOC/fbRE8nMwg/JDPo+zBr4D7Zrr/Xanz
 KfZcF/ZZLiRHOlH4qZ5LnBxuTrpa9FM3AXYmz8zuoMX0qLi7VMfUFTZ5XLO0+bfg8om+W2aoQRs
 bnMDCJdybJkWNr7lAolxChiyQ2sW599bYsu22i9bMh7Am2uzTAtHiiflayfJgQho6hlm9jgK9pS
 J/laMJFbPOcrJpG+izFaFzWACMdm6IaSGZCGG/hAdIUI0feHjnh3b38WH6GTbLsRSWoL2puDNKK
 FhWgi60snNnw+Xlbg5AtzcspdhVQAGESaerZfBnSbqokpRCNZOL7IlMu4+/6YO13v0PdnCdbAXN
 Wap/oy02V972sgW8dnQ==
X-Proofpoint-GUID: fnZz2i_1uY2yC5D27eI71llPJbfMMo-7
X-Proofpoint-ORIG-GUID: fnZz2i_1uY2yC5D27eI71llPJbfMMo-7
X-Authority-Analysis: v=2.4 cv=TZ4DJhQh c=1 sm=1 tr=0 ts=6aee878c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=k-42gJp3AAAA:8
 a=EUspDBNiAAAA:8 a=sozttTNsAAAA:8 a=UXDFgFJlzvmjgy0K6JwA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAwOCBTYWx0ZWRfX2XQoTWygmsHJ
 IwcMR8SKTvQS2RbDHWTirxw7DW3DR8XGurWIKqxwyidtViZmtnLPWbGOvELOzU3kjkRWK0StbG8
 NVRiBSic59upxdo8sg7OCaDUp33PQn4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070008
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

Some architectures, such as omap3, need BOOT_DEVICE_* values that match
their boot ROM. RISC-V does not: U-Boot works out the boot device itself
and returns the matching BOOT_DEVICE_$dev, so the values are only used
inside SPL.

Move the list to include/asm-generic/spl.h and include it from
asm/spl.h, so that new devices only have to be added in one place. Other
architectures in the same situation can switch to it later.

No functional change.

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
---
 arch/riscv/include/asm/spl.h | 22 +--------------------
 include/asm-generic/spl.h    | 37 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 21 deletions(-)
 create mode 100644 include/asm-generic/spl.h

diff --git a/arch/riscv/include/asm/spl.h b/arch/riscv/include/asm/spl.h
index 9c0bf9755c9..1e0dfafc281 100644
--- a/arch/riscv/include/asm/spl.h
+++ b/arch/riscv/include/asm/spl.h
@@ -8,27 +8,7 @@
 #ifndef _ASM_RISCV_SPL_H_
 #define _ASM_RISCV_SPL_H_
 
-enum {
-	BOOT_DEVICE_RAM,
-	BOOT_DEVICE_MMC1,
-	BOOT_DEVICE_MMC2,
-	BOOT_DEVICE_MMC2_2,
-	BOOT_DEVICE_NAND,
-	BOOT_DEVICE_ONENAND,
-	BOOT_DEVICE_NOR,
-	BOOT_DEVICE_UART,
-	BOOT_DEVICE_SPI,
-	BOOT_DEVICE_USB,
-	BOOT_DEVICE_SATA,
-	BOOT_DEVICE_NVME,
-	BOOT_DEVICE_I2C,
-	BOOT_DEVICE_BOARD,
-	BOOT_DEVICE_DFU,
-	BOOT_DEVICE_XIP,
-	BOOT_DEVICE_BOOTROM,
-	BOOT_DEVICE_SMH,
-	BOOT_DEVICE_NONE
-};
+#include <asm-generic/spl.h>
 
 /**
  * spl_board_init_f() - initialize board in the SPL phase
diff --git a/include/asm-generic/spl.h b/include/asm-generic/spl.h
new file mode 100644
index 00000000000..7b4789596a2
--- /dev/null
+++ b/include/asm-generic/spl.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Based on arch/riscv/include/asm/spl.h.
+ *
+ * (C) Copyright 2012
+ * Texas Instruments, <www.ti.com>
+ */
+#ifndef _ASM_GENERIC_SPL_H_
+#define _ASM_GENERIC_SPL_H_
+
+/*
+ * SPL boot device IDs.
+ * Add new entries before BOOT_DEVICE_NONE, which must stay last.
+ */
+enum {
+	BOOT_DEVICE_RAM,
+	BOOT_DEVICE_MMC1,
+	BOOT_DEVICE_MMC2,
+	BOOT_DEVICE_MMC2_2,
+	BOOT_DEVICE_NAND,
+	BOOT_DEVICE_ONENAND,
+	BOOT_DEVICE_NOR,
+	BOOT_DEVICE_UART,
+	BOOT_DEVICE_SPI,
+	BOOT_DEVICE_USB,
+	BOOT_DEVICE_SATA,
+	BOOT_DEVICE_NVME,
+	BOOT_DEVICE_I2C,
+	BOOT_DEVICE_BOARD,
+	BOOT_DEVICE_DFU,
+	BOOT_DEVICE_XIP,
+	BOOT_DEVICE_BOOTROM,
+	BOOT_DEVICE_SMH,
+	BOOT_DEVICE_NONE
+};
+
+#endif
-- 
2.34.1

