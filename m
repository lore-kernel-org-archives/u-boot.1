Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03158C9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C47A880E17;
	Mon, 28 Sep 2026 12:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DI4zJPIRf_8V; Mon, 28 Sep 2026 12:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B3D5980E1F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790596993;
	b=aaLB+Odeg0rHuAax2xibYtSfgF/zmSZJC6Ajfq6MDO7PJnXymTBD9+TBkTrPOz3YqWsB
	 GAHFh2eukOCFtuFBZkQM3kb09TPR+4PLZYSBmBjfiOaG8uxpeDd+L63shtYzcRF2AWH72
	 aQKLYevxMrb967c0+23b9uPK3HNTkI7SgELJg2qYWYYx8NAk5YEVBIeuJYtS1TLFFNtyf
	 yecsmzBXAKM4LEf5YXEoUxawSiJcElOqyhcSCyRKeyY4dFnm39tEsQq1feJ8b80fGBdmr
	 aeXTJWoKQbzQYjPcCNJHsTcybp/sJCFagtOOUSpthLzXD6VtyzKDKgu3fuGA16N4r4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790596993;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EOe1jPcuE8+ZXtDnxeawW7MAjHLZaOfC2OUujAvehV8=;
	b=OCMaiDYEGpol//4uOt+iCMG5JXNHQD73r8qj1a//mryrk1WOsl7ce/afUdpkJGbReII5
	 e/BNXyn6AjUwDRL+7xjTwlwXuNXn73MtU3Nksc1x+2giN/wnJpCXVnq3LEuLHAA26fFKj
	 ifasTQqRbEBnZN0h5uaeHjojX0M2BHukBPF2ZLhqhPheswCXA2WH3ptYG2cZoLTaS6w7D
	 zR0Vlgmuueel+L8C+bMRu7611z9oerhPeSHNicLe/kMSksa8+jQRjzeOq46MK97ngmnV4
	 deVR9OxxtXuCEx9ipt29pDlMHWrL0141P0aKFtLcH0tV3A11eA7oIppJF1VCdX8Zoeg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k7Xq2efv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z6NGY7gq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790596993;
	bh=EOe1jPcuE8+ZXtDnxeawW7MAjHLZaOfC2OUujAvehV8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bvNlynx1//PTfrMQ+/lFboSzBOWPo/Nv20FhLG7/O4JznGXUWt13tJWiTI9u33xEF
	 xwfgnEi3x0afT2WeHp17qiTrz6OultLuDzz2kToM5NhK5R/xrQNeSEyVm9Kiu9ZJ1T
	 GTJJN8h8euNoSaHi9AXvNtSwOHtxY4Sg1IrPn8g3oGKIQZOd5P1D05LkJyY7HY3g5Q
	 f417QkwzR6vMA3ZOp9dExgRgiIq2rlIXgOy6p9BmdeGAfpWhHHDHAq7o5fsaqby0nV
	 lYFsJu1+IkBJisyTTWlDFUT5FP/gAC9SG3s1fiTAKGmMEee/cLwu3SpZZEL6mtHZfK
	 w52MHseF6bUXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3D5980E1F;
	Mon, 28 Sep 2026 12:03:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D9B23D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BAB380E2E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8o0NWh2I5Qbn for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:03:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8760880DEE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790596990;
 b=PNbbDfydnzFFwaXl2WKqc1qL36ADH2sCGEaJFTBOkwKSGxUGRroj5+NX99ArO168ojpB
 ulX5oEyN6t00Wak2SVql09rFIBhCPSlJY7o3SnB+cEOYX2ICA4fvDz2HY/5fezHBlgT1l
 SLlb54C8DuAEfNI5gtCKJmapOp/7wSAe6adCFR2v5TJrQSHCao4+KJ3v7Xn54+HJdq4W6
 /h9rMZO2xMeQcd28j0HkblM+m5gWFtb+tulmSPLXtfKZExCDpnMiczkBaB0H8tkhIybVO
 3JnxmCcxBu3EnFo5vFqvvJxB8ytXYzq04KIoSt3Mg847/tYbiPUn2lRTleuSk7oCtdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790596990;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=EOe1jPcuE8+ZXtDnxeawW7MAjHLZaOfC2OUujAvehV8=;
 b=a0eYDEVolk9cLTRQukcXVRzC1ASWOO77xGeq0tDnDnajwe+pwU0/aWHgBZwvg0d1ptCl
 Jl/juEaBXonETAuiRHe0raYT5tUA0z2U/XRPACvGLsc9H9pDVjfWA9fPZ2Uyl5RO+TKrU
 SW2HmyCIH+DwRtQTal91Mm5L/Icu0huiA+JEN7dAzAxe/JCgbCGMvExmf7vMgH5h2tVBr
 grqccmLPnwfYCyQKOHCY5cCjVaDCS6DG/XRh1HLx3SW39yMwHn0HLkExhtaIcWs679vG2
 XwwYxZDGV5Lg0sT8udcd4CJvZzaLmIlQTnj5WTXxvUtmwkQ+8sEVdTfLU1FG39UGSMg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=k7Xq2efv; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Z6NGY7gq; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=k7Xq2efv; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Z6NGY7gq
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8760880DEE
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:10 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBAQs9782765
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EOe1jPcuE8+
 ZXtDnxeawW7MAjHLZaOfC2OUujAvehV8=; b=k7Xq2efvhaVdcHbHA+IRMonKgYx
 h/j34WBQQz+X1jegLOFfJd9JDlaK/H7rffdzWscD+CZGkpKhu2Of3Ce/QQZkYVXm
 dzGUFw7gii5FlfAFd6OoHP5yGSyMQtttSATEPvW98eLyzf4mu4LnhtWElyIvRzPL
 Mg0Ec5McYDPuHAziEJRp9ndXaMPHC6BU1IOCc5w1ItFTfcV6w5/OznJ1So75Uhp7
 7W1WNC4HpKmzQIKOHWHlT7axqDsuJK2blSCRouMZLW0Qn0m+N6a0ZQFYDvXnR6JV
 I/yvBY43DK+MHzHEO64nUPdhMykjrNEucCr5cV9Ea2mN4LQaJnpyKw9yVhQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4abgg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-342138eeff2so7705742eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790596989; x=1791201789;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EOe1jPcuE8+ZXtDnxeawW7MAjHLZaOfC2OUujAvehV8=;
 b=Z6NGY7gqIIjDx4gZLbiyJuUcuyDcc+yuReMwgy8aqARjBt1wPPVHTtVeh7ivcxtawE
 uP4Pzd+Bo8SD/SWcCT959nt5zWyb8S7NlBs82WPkFyeG5e4MX92hIgnpcmyk4CwbSfQK
 DBLgR9mSHQgsVGk1Hljq96lha2llZufi/bjJ8tzs8p5yOXYaM4Wsss6gLQL71dZBi2Cu
 413e1jsUcBF/74HoNnIOOPGAPHO+DEY17ptg3gRFxzuXpfH2OFlOQuESbpKhJkN0Pmlg
 +9joHx9N0goiX5MEegJYDs8OmZx70tgBLgZPK43zoXcees4j9IGdLI2kqRxxL/gXAR8u
 W95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790596989; x=1791201789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EOe1jPcuE8+ZXtDnxeawW7MAjHLZaOfC2OUujAvehV8=;
 b=lonSZ1MqKjOTMfOJBSsAsED3n15SDUfH+Cw93uwQRoWNj5kChVwyWImDeTwqg0dCXy
 LbZM8wru965BFr/4JFfRQCrJwNaGnngwYVtdiX/xqE5Av7q44lISwQ6mOs3Rc4OGxy+I
 jhd+9MMrJW9DjHEQB8Mbc2uSwUa/0aD8h4/vqHjNIh+6cXlksWa+XXqum0P8uuF2FTqV
 yDK7KfIr1j+lK9XhWugBrqEbMDNN72qMVKQnz+u25U6XUvecu5K0CC6CvVRBEJP9njPG
 iIe1ZFVbvzVZLh61nyN1s0PJTYavsYg+2E/9Fvsg1cnX9m1i8TiXLnkSCq5kgkTnOWqM
 SWyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgo5NXpEq+5q4FQZLNVVG6hk2vffjXGXZeBfu/5BDpMpPzHqXYzCI0jpxNsMBY8Ii4A8HB6AM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIlAcvk+WrZsmF4icG5V86WPpx0M25hnctwmnd+rU4pvpNiQ/Pr
 Qij+Cuq1RCIvRUW9jYVxcsnmE++86dj6moM4eGqD22cjvFIuE40of1Q89dD6wLNNMxJdqLQ+9/t
 TnZ8sHu5HuqAVW/on4u+iG6N87feuKyq30a1LlkCfuQ1N3KClknTy3qcYlemDXMpxhXLijtA=
X-Gm-Gg: AYBFou2l6InM197YCY+odT1hb4z8XAJjt2SRqcMJqtBp0fZjoWGPOfXEDSdBXr/NCT/
 COrkOmaDHiBte+LRq2fzQP2nxq7UlLfjXbYfpB6cfMpotiqCv7KPLdyWOO54eAbxPklM/Au4d4p
 808+51HCrJd/m3G/nmZHudrExCElzEvW6Ty2BUT2dxN/8cklY1ZGwo19SDnN1/ZuFACWuz1U17B
 ZYjDSRW6RkdrZcu1I12Qipk9nE6Puh/62wkCfLu2v8wJxaK79vKiJ1l61aTNsXK56LRJWO+TnWO
 4TtZtijtVA9KoBwluanPmi5gv/gV6tTwIvefw64KJkMGJ1ld6ekZC6JqtNQQ3MB870ATzKlq9Ao
 XpjUp5vLwXDWhzB6aKjP8OWMjPoo/LQ1VmzYTCy0/mMlCNweraEbJdrX8VwRqLvRwQfqJzp+S+5
 dHp+Q0wl5J5DHzoGMHrA==
X-Received: by 2002:a05:7300:bf9b:b0:33b:bd89:26d1 with SMTP id
 5a478bee46e88-342703bf6a0mr9445383eec.12.1790596987848; 
 Mon, 28 Sep 2026 05:03:07 -0700 (PDT)
X-Received: by 2002:a05:7300:bf9b:b0:33b:bd89:26d1 with SMTP id
 5a478bee46e88-342703bf6a0mr9445293eec.12.1790596986485; 
 Mon, 28 Sep 2026 05:03:06 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144b4ae50sm28658382eec.17.2026.09.28.05.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:03:05 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, luca.weiss@fairphone.com,
 nikroks@mainlining.org, jbx6244@gmail.com,
 krzysztof.kozlowski@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 8/9] pinctrl: qcom: add TLMM driver for nord
Date: Mon, 28 Sep 2026 17:32:08 +0530
Message-Id: <20260928120209.1064781-9-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
References: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _lPj5svyq4EG5qopFAB5Ln0UTfnl2cM5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX6DwwEGazC42M
 57zCiJEtWrd3L+Dtm6+yVjAiM0iRQxKrVyHvNmlcmw+XL50seuyjunYoUg2tYzzHNWYNn7ZtSPb
 YM4DtDrKxuB0AarXM7Dlh5yBcSdifHjBwAcVuBYGN8BKK6gnpX97zaT3rqIb1r06cv0/sBdBAuF
 o/iZ5PGPWGsHMlCV7Faq9xUz4IL/Qw7G9n2gDcW4AGbM/TutYvVkZV6xDJJXEO7pb3D3keAxHpT
 yfn9gwqo9+ioOqPh2HmeY4Xc/5VzDQtV1LL6QhZSG1AKWunBOdi9TbJs5U1n9L9KX5qkuPq+AIm
 lMUz3jvB+t0wbHDAZYmUmUyKeRhG0vZo3YeTX82ihcq+h9pQF0ODwMEsC0/GJnjCDIGiIGl7+nE
 eOyXIu+JtWLRhZHgOJpQ8Wa40lHxMIAcbEFwTWHXacFIF61L+gmn/pVLVOYDivPge+rngBMnXuh
 sVRDfrsuZW1Y+xwg9Hw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX0urbFszpSBLA
 W8qsXIOEVXzPY+sua9r/i/hftBbq9InCb1cBwA022in8XSX27YswOe2IW3AgIl3HvVSuSpNwoNu
 ZTFG4+lMuF5DabjJuktm7FExE3EF3ew=
X-Proofpoint-ORIG-GUID: _lPj5svyq4EG5qopFAB5Ln0UTfnl2cM5
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba577d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=plr6cxIssS0Fq1ZbCCsA:9 a=O8hF6Hzn-FEA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280047
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

Add support for the nord Top Level Mode Multiplexer (TLMM).

Implement the qcom,nord-tlmm pinctrl driver to provide pin
configuration support required by nord peripherals.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig        |   8 +
 drivers/pinctrl/qcom/Makefile       |   1 +
 drivers/pinctrl/qcom/pinctrl-nord.c | 626 ++++++++++++++++++++++++++++
 3 files changed, 635 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-nord.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 7dd3782c14b..9dc9fc7d783 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -62,6 +62,14 @@ config PINCTRL_QCOM_MILOS
 	  Say Y here to enable support for pinctrl on the Snapdragon Milos SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_NORD
+	bool "Qualcomm Nord Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon Nord SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_QCM2290
 	bool "Qualcomm QCM2290 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index a7a9ad03569..b9dd476f53b 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
+obj-$(CONFIG_PINCTRL_QCOM_NORD) += pinctrl-nord.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
diff --git a/drivers/pinctrl/qcom/pinctrl-nord.c b/drivers/pinctrl/qcom/pinctrl-nord.c
new file mode 100644
index 00000000000..8f622165ec0
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-nord.c
@@ -0,0 +1,626 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Nord pinctrl
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+typedef unsigned int msm_pin_function[10];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)\
+	{					        \
+		msm_mux_gpio, /* gpio mode */		\
+		msm_mux_##f1,				\
+		msm_mux_##f2,				\
+		msm_mux_##f3,				\
+		msm_mux_##f4,				\
+		msm_mux_##f5,				\
+		msm_mux_##f6,				\
+		msm_mux_##f7,				\
+		msm_mux_##f8,				\
+		msm_mux_##f9				\
+	}
+
+#define UFS_RESET(pg_name, ctl, io)			\
+	{						\
+		.name = #pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = io,				\
+		.pull_bit = 3,				\
+		.drv_bit = 0,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = 0,				\
+	}
+
+enum nord_functions {
+	msm_mux_aoss_cti,
+	msm_mux_atest_char,
+	msm_mux_atest_usb20,
+	msm_mux_atest_usb21,
+	msm_mux_aud_intfc0_clk,
+	msm_mux_aud_intfc0_data,
+	msm_mux_aud_intfc0_ws,
+	msm_mux_aud_intfc10_clk,
+	msm_mux_aud_intfc10_data,
+	msm_mux_aud_intfc10_ws,
+	msm_mux_aud_intfc1_clk,
+	msm_mux_aud_intfc1_data,
+	msm_mux_aud_intfc1_ws,
+	msm_mux_aud_intfc2_clk,
+	msm_mux_aud_intfc2_data,
+	msm_mux_aud_intfc2_ws,
+	msm_mux_aud_intfc3_clk,
+	msm_mux_aud_intfc3_data,
+	msm_mux_aud_intfc3_ws,
+	msm_mux_aud_intfc4_clk,
+	msm_mux_aud_intfc4_data,
+	msm_mux_aud_intfc4_ws,
+	msm_mux_aud_intfc5_clk,
+	msm_mux_aud_intfc5_data,
+	msm_mux_aud_intfc5_ws,
+	msm_mux_aud_intfc6_clk,
+	msm_mux_aud_intfc6_data,
+	msm_mux_aud_intfc6_ws,
+	msm_mux_aud_intfc7_clk,
+	msm_mux_aud_intfc7_data,
+	msm_mux_aud_intfc7_ws,
+	msm_mux_aud_intfc8_clk,
+	msm_mux_aud_intfc8_data,
+	msm_mux_aud_intfc8_ws,
+	msm_mux_aud_intfc9_clk,
+	msm_mux_aud_intfc9_data,
+	msm_mux_aud_intfc9_ws,
+	msm_mux_aud_mclk0_mira,
+	msm_mux_aud_mclk0_mirb,
+	msm_mux_aud_mclk1_mira,
+	msm_mux_aud_mclk1_mirb,
+	msm_mux_aud_mclk2_mira,
+	msm_mux_aud_mclk2_mirb,
+	msm_mux_aud_refclk0,
+	msm_mux_aud_refclk1,
+	msm_mux_bist_done,
+	msm_mux_ccu_async_in,
+	msm_mux_ccu_i2c_scl,
+	msm_mux_ccu_i2c_sda,
+	msm_mux_ccu_timer,
+	msm_mux_clink_debug,
+	msm_mux_dbg_out,
+	msm_mux_dbg_out_clk,
+	msm_mux_ddr_bist_complete,
+	msm_mux_ddr_bist_fail,
+	msm_mux_ddr_bist_start,
+	msm_mux_ddr_bist_stop,
+	msm_mux_ddr_pxi,
+	msm_mux_dp_rx0,
+	msm_mux_dp_rx00,
+	msm_mux_dp_rx01,
+	msm_mux_dp_rx0_mute,
+	msm_mux_dp_rx1,
+	msm_mux_dp_rx10,
+	msm_mux_dp_rx11,
+	msm_mux_dp_rx1_mute,
+	msm_mux_edp0_hot,
+	msm_mux_edp0_lcd,
+	msm_mux_edp1_hot,
+	msm_mux_edp1_lcd,
+	msm_mux_edp2_hot,
+	msm_mux_edp2_lcd,
+	msm_mux_edp3_hot,
+	msm_mux_edp3_lcd,
+	msm_mux_emac0_mcg,
+	msm_mux_emac0_mdc,
+	msm_mux_emac0_mdio,
+	msm_mux_emac0_ptp,
+	msm_mux_emac1_mcg,
+	msm_mux_emac1_mdc,
+	msm_mux_emac1_mdio,
+	msm_mux_emac1_ptp,
+	msm_mux_gcc_gp1_clk,
+	msm_mux_gcc_gp2_clk,
+	msm_mux_gcc_gp3_clk,
+	msm_mux_gcc_gp4_clk,
+	msm_mux_gcc_gp5_clk,
+	msm_mux_gcc_gp6_clk,
+	msm_mux_gcc_gp7_clk,
+	msm_mux_gcc_gp8_clk,
+	msm_mux_gpio,
+	msm_mux_jitter_bist,
+	msm_mux_lbist_pass,
+	msm_mux_mbist_pass,
+	msm_mux_mdp0_vsync_out,
+	msm_mux_mdp1_vsync_out,
+	msm_mux_mdp_vsync_e,
+	msm_mux_mdp_vsync_p,
+	msm_mux_mdp_vsync_s,
+	msm_mux_pcie0_clk_req_n,
+	msm_mux_pcie1_clk_req_n,
+	msm_mux_pcie2_clk_req_n,
+	msm_mux_pcie3_clk_req_n,
+	msm_mux_phase_flag,
+	msm_mux_pll_bist_sync,
+	msm_mux_pll_clk_aux,
+	msm_mux_prng_rosc0,
+	msm_mux_prng_rosc1,
+	msm_mux_pwrbrk_i_n,
+	msm_mux_qdss,
+	msm_mux_qdss_cti,
+	msm_mux_qspi,
+	msm_mux_qup0_se0,
+	msm_mux_qup0_se1,
+	msm_mux_qup0_se2,
+	msm_mux_qup0_se3,
+	msm_mux_qup0_se4,
+	msm_mux_qup0_se5,
+	msm_mux_qup1_se0,
+	msm_mux_qup1_se1,
+	msm_mux_qup1_se2,
+	msm_mux_qup1_se3,
+	msm_mux_qup1_se4,
+	msm_mux_qup1_se5,
+	msm_mux_qup1_se6,
+	msm_mux_qup2_se0,
+	msm_mux_qup2_se1,
+	msm_mux_qup2_se2,
+	msm_mux_qup2_se3,
+	msm_mux_qup2_se4,
+	msm_mux_qup2_se5,
+	msm_mux_qup2_se6,
+	msm_mux_qup3_se0_mira,
+	msm_mux_qup3_se0_mirb,
+	msm_mux_sailss_ospi,
+	msm_mux_sdc4_clk,
+	msm_mux_sdc4_cmd,
+	msm_mux_sdc4_data,
+	msm_mux_smb_alert,
+	msm_mux_smb_alert_n,
+	msm_mux_smb_clk,
+	msm_mux_smb_dat,
+	msm_mux_tb_trig_sdc4,
+	msm_mux_tmess_prng0,
+	msm_mux_tmess_prng1,
+	msm_mux_tsc_timer,
+	msm_mux_tsense_pwm,
+	msm_mux_usb0_hs,
+	msm_mux_usb0_phy_ps,
+	msm_mux_usb1_hs,
+	msm_mux_usb1_phy_ps,
+	msm_mux_usb2_hs,
+	msm_mux_usxgmii0_phy,
+	msm_mux_usxgmii1_phy,
+	msm_mux_vsense_trigger_mirnat,
+	msm_mux_wcn_sw,
+	msm_mux_wcn_sw_ctrl,
+	msm_mux__,
+};
+
+#define MSM_PIN_FUNCTION(fname)                         \
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(aoss_cti),
+	MSM_PIN_FUNCTION(atest_char),
+	MSM_PIN_FUNCTION(atest_usb20),
+	MSM_PIN_FUNCTION(atest_usb21),
+	MSM_PIN_FUNCTION(aud_intfc0_clk),
+	MSM_PIN_FUNCTION(aud_intfc0_data),
+	MSM_PIN_FUNCTION(aud_intfc0_ws),
+	MSM_PIN_FUNCTION(aud_intfc10_clk),
+	MSM_PIN_FUNCTION(aud_intfc10_data),
+	MSM_PIN_FUNCTION(aud_intfc10_ws),
+	MSM_PIN_FUNCTION(aud_intfc1_clk),
+	MSM_PIN_FUNCTION(aud_intfc1_data),
+	MSM_PIN_FUNCTION(aud_intfc1_ws),
+	MSM_PIN_FUNCTION(aud_intfc2_clk),
+	MSM_PIN_FUNCTION(aud_intfc2_data),
+	MSM_PIN_FUNCTION(aud_intfc2_ws),
+	MSM_PIN_FUNCTION(aud_intfc3_clk),
+	MSM_PIN_FUNCTION(aud_intfc3_data),
+	MSM_PIN_FUNCTION(aud_intfc3_ws),
+	MSM_PIN_FUNCTION(aud_intfc4_clk),
+	MSM_PIN_FUNCTION(aud_intfc4_data),
+	MSM_PIN_FUNCTION(aud_intfc4_ws),
+	MSM_PIN_FUNCTION(aud_intfc5_clk),
+	MSM_PIN_FUNCTION(aud_intfc5_data),
+	MSM_PIN_FUNCTION(aud_intfc5_ws),
+	MSM_PIN_FUNCTION(aud_intfc6_clk),
+	MSM_PIN_FUNCTION(aud_intfc6_data),
+	MSM_PIN_FUNCTION(aud_intfc6_ws),
+	MSM_PIN_FUNCTION(aud_intfc7_clk),
+	MSM_PIN_FUNCTION(aud_intfc7_data),
+	MSM_PIN_FUNCTION(aud_intfc7_ws),
+	MSM_PIN_FUNCTION(aud_intfc8_clk),
+	MSM_PIN_FUNCTION(aud_intfc8_data),
+	MSM_PIN_FUNCTION(aud_intfc8_ws),
+	MSM_PIN_FUNCTION(aud_intfc9_clk),
+	MSM_PIN_FUNCTION(aud_intfc9_data),
+	MSM_PIN_FUNCTION(aud_intfc9_ws),
+	MSM_PIN_FUNCTION(aud_mclk0_mira),
+	MSM_PIN_FUNCTION(aud_mclk0_mirb),
+	MSM_PIN_FUNCTION(aud_mclk1_mira),
+	MSM_PIN_FUNCTION(aud_mclk1_mirb),
+	MSM_PIN_FUNCTION(aud_mclk2_mira),
+	MSM_PIN_FUNCTION(aud_mclk2_mirb),
+	MSM_PIN_FUNCTION(aud_refclk0),
+	MSM_PIN_FUNCTION(aud_refclk1),
+	MSM_PIN_FUNCTION(bist_done),
+	MSM_PIN_FUNCTION(ccu_async_in),
+	MSM_PIN_FUNCTION(ccu_i2c_scl),
+	MSM_PIN_FUNCTION(ccu_i2c_sda),
+	MSM_PIN_FUNCTION(ccu_timer),
+	MSM_PIN_FUNCTION(clink_debug),
+	MSM_PIN_FUNCTION(dbg_out),
+	MSM_PIN_FUNCTION(dbg_out_clk),
+	MSM_PIN_FUNCTION(ddr_bist_complete),
+	MSM_PIN_FUNCTION(ddr_bist_fail),
+	MSM_PIN_FUNCTION(ddr_bist_start),
+	MSM_PIN_FUNCTION(ddr_bist_stop),
+	MSM_PIN_FUNCTION(ddr_pxi),
+	MSM_PIN_FUNCTION(dp_rx0),
+	MSM_PIN_FUNCTION(dp_rx00),
+	MSM_PIN_FUNCTION(dp_rx01),
+	MSM_PIN_FUNCTION(dp_rx0_mute),
+	MSM_PIN_FUNCTION(dp_rx1),
+	MSM_PIN_FUNCTION(dp_rx10),
+	MSM_PIN_FUNCTION(dp_rx11),
+	MSM_PIN_FUNCTION(dp_rx1_mute),
+	MSM_PIN_FUNCTION(edp0_hot),
+	MSM_PIN_FUNCTION(edp0_lcd),
+	MSM_PIN_FUNCTION(edp1_hot),
+	MSM_PIN_FUNCTION(edp1_lcd),
+	MSM_PIN_FUNCTION(edp2_hot),
+	MSM_PIN_FUNCTION(edp2_lcd),
+	MSM_PIN_FUNCTION(edp3_hot),
+	MSM_PIN_FUNCTION(edp3_lcd),
+	MSM_PIN_FUNCTION(emac0_mcg),
+	MSM_PIN_FUNCTION(emac0_mdc),
+	MSM_PIN_FUNCTION(emac0_mdio),
+	MSM_PIN_FUNCTION(emac0_ptp),
+	MSM_PIN_FUNCTION(emac1_mcg),
+	MSM_PIN_FUNCTION(emac1_mdc),
+	MSM_PIN_FUNCTION(emac1_mdio),
+	MSM_PIN_FUNCTION(emac1_ptp),
+	MSM_PIN_FUNCTION(gcc_gp1_clk),
+	MSM_PIN_FUNCTION(gcc_gp2_clk),
+	MSM_PIN_FUNCTION(gcc_gp3_clk),
+	MSM_PIN_FUNCTION(gcc_gp4_clk),
+	MSM_PIN_FUNCTION(gcc_gp5_clk),
+	MSM_PIN_FUNCTION(gcc_gp6_clk),
+	MSM_PIN_FUNCTION(gcc_gp7_clk),
+	MSM_PIN_FUNCTION(gcc_gp8_clk),
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(jitter_bist),
+	MSM_PIN_FUNCTION(lbist_pass),
+	MSM_PIN_FUNCTION(mbist_pass),
+	MSM_PIN_FUNCTION(mdp0_vsync_out),
+	MSM_PIN_FUNCTION(mdp1_vsync_out),
+	MSM_PIN_FUNCTION(mdp_vsync_e),
+	MSM_PIN_FUNCTION(mdp_vsync_p),
+	MSM_PIN_FUNCTION(mdp_vsync_s),
+	MSM_PIN_FUNCTION(pcie0_clk_req_n),
+	MSM_PIN_FUNCTION(pcie1_clk_req_n),
+	MSM_PIN_FUNCTION(pcie2_clk_req_n),
+	MSM_PIN_FUNCTION(pcie3_clk_req_n),
+	MSM_PIN_FUNCTION(phase_flag),
+	MSM_PIN_FUNCTION(pll_bist_sync),
+	MSM_PIN_FUNCTION(pll_clk_aux),
+	MSM_PIN_FUNCTION(prng_rosc0),
+	MSM_PIN_FUNCTION(prng_rosc1),
+	MSM_PIN_FUNCTION(pwrbrk_i_n),
+	MSM_PIN_FUNCTION(qdss),
+	MSM_PIN_FUNCTION(qdss_cti),
+	MSM_PIN_FUNCTION(qspi),
+	MSM_PIN_FUNCTION(qup0_se0),
+	MSM_PIN_FUNCTION(qup0_se1),
+	MSM_PIN_FUNCTION(qup0_se2),
+	MSM_PIN_FUNCTION(qup0_se3),
+	MSM_PIN_FUNCTION(qup0_se4),
+	MSM_PIN_FUNCTION(qup0_se5),
+	MSM_PIN_FUNCTION(qup1_se0),
+	MSM_PIN_FUNCTION(qup1_se1),
+	MSM_PIN_FUNCTION(qup1_se2),
+	MSM_PIN_FUNCTION(qup1_se3),
+	MSM_PIN_FUNCTION(qup1_se4),
+	MSM_PIN_FUNCTION(qup1_se5),
+	MSM_PIN_FUNCTION(qup1_se6),
+	MSM_PIN_FUNCTION(qup2_se0),
+	MSM_PIN_FUNCTION(qup2_se1),
+	MSM_PIN_FUNCTION(qup2_se2),
+	MSM_PIN_FUNCTION(qup2_se3),
+	MSM_PIN_FUNCTION(qup2_se4),
+	MSM_PIN_FUNCTION(qup2_se5),
+	MSM_PIN_FUNCTION(qup2_se6),
+	MSM_PIN_FUNCTION(qup3_se0_mira),
+	MSM_PIN_FUNCTION(qup3_se0_mirb),
+	MSM_PIN_FUNCTION(sailss_ospi),
+	MSM_PIN_FUNCTION(sdc4_clk),
+	MSM_PIN_FUNCTION(sdc4_cmd),
+	MSM_PIN_FUNCTION(sdc4_data),
+	MSM_PIN_FUNCTION(smb_alert),
+	MSM_PIN_FUNCTION(smb_alert_n),
+	MSM_PIN_FUNCTION(smb_clk),
+	MSM_PIN_FUNCTION(smb_dat),
+	MSM_PIN_FUNCTION(tb_trig_sdc4),
+	MSM_PIN_FUNCTION(tmess_prng0),
+	MSM_PIN_FUNCTION(tmess_prng1),
+	MSM_PIN_FUNCTION(tsc_timer),
+	MSM_PIN_FUNCTION(tsense_pwm),
+	MSM_PIN_FUNCTION(usb0_hs),
+	MSM_PIN_FUNCTION(usb0_phy_ps),
+	MSM_PIN_FUNCTION(usb1_hs),
+	MSM_PIN_FUNCTION(usb1_phy_ps),
+	MSM_PIN_FUNCTION(usb2_hs),
+	MSM_PIN_FUNCTION(usxgmii0_phy),
+	MSM_PIN_FUNCTION(usxgmii1_phy),
+	MSM_PIN_FUNCTION(vsense_trigger_mirnat),
+	MSM_PIN_FUNCTION(wcn_sw),
+	MSM_PIN_FUNCTION(wcn_sw_ctrl),
+};
+
+static const msm_pin_function nord_pin_functions[] = {
+	[0] = PINGROUP(0, _, _, _, _, _, _, _, _, _),
+	[1] = PINGROUP(1, pcie0_clk_req_n, _, _, _, _, _, _, _, _),
+	[2] = PINGROUP(2, _, _, _, _, _, _, _, _, _),
+	[3] = PINGROUP(3, _, _, _, _, _, _, _, _, _),
+	[4] = PINGROUP(4, pcie1_clk_req_n, _, _, _, _, _, _, _, _),
+	[5] = PINGROUP(5, _, _, _, _, _, _, _, _, _),
+	[6] = PINGROUP(6, _, _, _, _, _, _, _, _, _),
+	[7] = PINGROUP(7, pcie2_clk_req_n, _, _, _, _, _, _, _, _),
+	[8] = PINGROUP(8, _, _, _, _, _, _, _, _, _),
+	[9] = PINGROUP(9, _, _, _, _, _, _, _, _, _),
+	[10] = PINGROUP(10, pcie3_clk_req_n, _, _, _, _, _, _, _, _),
+	[11] = PINGROUP(11, _, _, _, _, _, _, _, _, _),
+	[12] = PINGROUP(12, usb0_hs, clink_debug, _, _, _, _, _, _, _),
+	[13] = PINGROUP(13, usb1_hs, clink_debug, gcc_gp7_clk, _, _, _, _, _, _),
+	[14] = PINGROUP(14, usb2_hs, clink_debug, gcc_gp8_clk, _, _, _, _, _, _),
+	[15] = PINGROUP(15, ccu_i2c_sda, _, _, _, _, _, _, _, _),
+	[16] = PINGROUP(16, ccu_i2c_scl, emac0_mcg, _, _, _, _, _, _, _),
+	[17] = PINGROUP(17, ccu_i2c_sda, emac0_mcg, _, _, _, _, _, _, _),
+	[18] = PINGROUP(18, ccu_i2c_scl, emac0_mcg, _, _, _, _, _, _, _),
+	[19] = PINGROUP(19, ccu_i2c_sda, emac0_mcg, _, _, _, _, _, _, _),
+	[20] = PINGROUP(20, ccu_i2c_scl, emac1_mcg, _, _, _, _, _, _, _),
+	[21] = PINGROUP(21, ccu_i2c_sda, emac1_mcg, _, _, _, _, _, _, _),
+	[22] = PINGROUP(22, ccu_i2c_scl, emac1_mcg, _, _, _, _, _, _, _),
+	[23] = PINGROUP(23, ccu_i2c_sda, emac1_mcg, _, _, _, _, _, _, _),
+	[24] = PINGROUP(24, ccu_i2c_scl, _, _, _, _, _, _, _, _),
+	[25] = PINGROUP(25, ccu_timer, tsc_timer, _, _, _, _, _, _, _),
+	[26] = PINGROUP(26, ccu_timer, tsc_timer, _, _, _, _, _, _, _),
+	[27] = PINGROUP(27, ccu_timer, tsc_timer, _, _, _, _, _, _, _),
+	[28] = PINGROUP(28, ccu_timer, tsc_timer, _, _, _, _, _, _, _),
+	[29] = PINGROUP(29, ccu_timer, tsc_timer, _, _, _, _, _, _, _),
+	[30] = PINGROUP(30, ccu_timer, tsc_timer, _, _, _, _, _, _, _),
+	[31] = PINGROUP(31, ccu_timer, tsc_timer, _, _, _, _, _, _, _),
+	[32] = PINGROUP(32, ccu_timer, tsc_timer, _, _, _, _, _, _, _),
+	[33] = PINGROUP(33, ccu_timer, tsc_timer, _, _, _, _, _, _, _),
+	[34] = PINGROUP(34, ccu_timer, tsc_timer, _, _, _, _, _, _, _),
+	[35] = PINGROUP(35, dp_rx0_mute, _, _, _, _, _, _, _, _),
+	[36] = PINGROUP(36, dp_rx1_mute, ddr_bist_start, _, _, _, _, _, _, _),
+	[37] = PINGROUP(37, emac1_ptp, ddr_bist_complete, _, _, _, _, _, _, _),
+	[38] = PINGROUP(38, emac1_ptp, ddr_bist_stop, _, _, _, _, _, _, _),
+	[39] = PINGROUP(39, emac1_ptp, ddr_bist_fail, _, _, _, _, _, _, _),
+	[40] = PINGROUP(40, emac1_ptp, _, _, _, _, _, _, _, _),
+	[41] = PINGROUP(41, emac1_ptp, qdss_cti, _, _, _, _, _, _, _),
+	[42] = PINGROUP(42, emac1_ptp, qdss_cti, gcc_gp3_clk, _, _, _, _, _, _),
+	[43] = PINGROUP(43, emac1_ptp, gcc_gp4_clk, tsense_pwm, _, _, _, _, _, _),
+	[44] = PINGROUP(44, emac1_ptp, tsense_pwm, _, _, _, _, _, _, _),
+	[45] = PINGROUP(45, usxgmii0_phy, ccu_async_in, tsense_pwm, _, _, _, _, _, _),
+	[46] = PINGROUP(46, usxgmii1_phy, tsense_pwm, _, _, _, _, _, _, _),
+	[47] = PINGROUP(47, emac0_mdc, edp0_lcd, tsense_pwm, _, _, _, _, _, _),
+	[48] = PINGROUP(48, emac0_mdio, edp1_lcd, tsense_pwm, _, _, _, _, _, _),
+	[49] = PINGROUP(49, emac1_mdc, edp2_lcd, tsense_pwm, _, _, _, _, _, _),
+	[50] = PINGROUP(50, emac1_mdio, edp3_lcd, tsense_pwm, _, _, _, _, _, _),
+	[51] = PINGROUP(51, edp0_hot, clink_debug, gcc_gp1_clk, _, _, _, _, _, _),
+	[52] = PINGROUP(52, edp1_hot, clink_debug, gcc_gp2_clk, _, _, _, _, _, _),
+	[53] = PINGROUP(53, edp2_hot, clink_debug, _, _, _, _, _, _, _),
+	[54] = PINGROUP(54, edp3_hot, clink_debug, _, _, _, _, _, _, _),
+	[55] = PINGROUP(55, dp_rx0, clink_debug, _, _, _, _, _, _, _),
+	[56] = PINGROUP(56, dp_rx1, _, _, _, _, _, _, _, _),
+	[57] = PINGROUP(57, aud_intfc0_clk, _, _, _, _, _, _, _, _),
+	[58] = PINGROUP(58, aud_intfc0_ws, _, _, _, _, _, _, _, _),
+	[59] = PINGROUP(59, aud_intfc0_data, _, _, _, _, _, _, _, _),
+	[60] = PINGROUP(60, aud_intfc0_data, _, _, _, _, _, _, _, _),
+	[61] = PINGROUP(61, aud_intfc0_data, aud_intfc10_clk, _, _, _, _, _, _, _),
+	[62] = PINGROUP(62, aud_intfc0_data, aud_intfc10_ws, _, _, _, _, _, _, _),
+	[63] = PINGROUP(63, aud_intfc0_data, aud_intfc7_clk, _, _, _, _, _, _, _),
+	[64] = PINGROUP(64, aud_intfc0_data, aud_intfc7_ws, _, _, _, _, _, _, _),
+	[65] = PINGROUP(65, aud_intfc0_data, aud_intfc7_data, _, _, _, _, _, _, _),
+	[66] = PINGROUP(66, aud_intfc0_data, aud_intfc7_data, _, _, _, _, _, _, _),
+	[67] = PINGROUP(67, aud_intfc1_clk, phase_flag, _, qdss, _, _, _, _, _),
+	[68] = PINGROUP(68, aud_intfc1_ws, phase_flag, _, qdss, _, _, _, _, _),
+	[69] = PINGROUP(69, aud_intfc1_data, phase_flag, _, qdss, _, _, _, _, _),
+	[70] = PINGROUP(70, aud_intfc1_data, aud_intfc9_clk, phase_flag, _, qdss, _, _, _, _),
+	[71] = PINGROUP(71, aud_intfc1_data, aud_intfc9_ws, phase_flag, _, qdss, _, _, _, _),
+	[72] = PINGROUP(72, aud_intfc1_data, aud_intfc9_data, phase_flag, _, qdss, _, _, _, _),
+	[73] = PINGROUP(73, aud_intfc1_data, aud_intfc8_clk, phase_flag, _, qdss, _, _, _, _),
+	[74] = PINGROUP(74, aud_intfc1_data, aud_intfc8_ws, phase_flag, _, qdss, _, _, _, _),
+	[75] = PINGROUP(75, aud_intfc1_data, aud_intfc8_data, phase_flag, _, qdss, _, _, _, _),
+	[76] = PINGROUP(76, aud_intfc1_data, aud_intfc8_data, phase_flag, _, qdss, _, _, _, _),
+	[77] = PINGROUP(77, aud_intfc2_clk, phase_flag, _, qdss, _, _, _, _, _),
+	[78] = PINGROUP(78, aud_intfc2_ws, phase_flag, _, qdss, _, _, _, _, _),
+	[79] = PINGROUP(79, aud_intfc2_data, phase_flag, _, qdss, _, _, _, _, _),
+	[80] = PINGROUP(80, aud_intfc2_data, phase_flag, _, _, qdss, _, _, _, _),
+	[81] = PINGROUP(81, aud_intfc2_data, aud_intfc10_data, phase_flag, _, _, qdss, _, _, _),
+	[82] = PINGROUP(82, aud_intfc2_data, aud_intfc10_data, phase_flag, _, qdss, _, _, _, _),
+	[83] = PINGROUP(83, aud_intfc3_clk, dp_rx0, aoss_cti, phase_flag, _, qdss, _, _, _),
+	[84] = PINGROUP(84, aud_intfc3_ws, dp_rx0, aoss_cti, phase_flag, _, qdss, _, _, _),
+	[85] = PINGROUP(85, aud_intfc3_data, dp_rx0, aoss_cti, phase_flag, _, qdss, _, _, _),
+	[86] = PINGROUP(86, aud_intfc3_data, aud_mclk0_mirb, dp_rx0, aoss_cti, phase_flag, _, qdss,
+			_, _),
+	[87] = PINGROUP(87, aud_intfc4_clk, phase_flag, _, qdss, _, _, _, _, _),
+	[88] = PINGROUP(88, aud_intfc4_ws, dp_rx0, phase_flag, _, qdss, _, _, _, _),
+	[89] = PINGROUP(89, aud_intfc4_data, dp_rx0, phase_flag, _, qdss, _, _, _, _),
+	[90] = PINGROUP(90, aud_intfc4_data, aud_mclk1_mirb, phase_flag, _, qdss, _, _, _, _),
+	[91] = PINGROUP(91, aud_intfc5_clk, phase_flag, _, qdss, _, _, _, _, _),
+	[92] = PINGROUP(92, aud_intfc5_ws, dp_rx1, phase_flag, _, qdss, _, _, _, _),
+	[93] = PINGROUP(93, aud_intfc5_data, dp_rx1, phase_flag, _, qdss, _, _, _, _),
+	[94] = PINGROUP(94, aud_intfc5_data, aud_mclk2_mirb, phase_flag, tmess_prng0, _, qdss, _,
+			_, _),
+	[95] = PINGROUP(95, aud_intfc6_clk, dp_rx1, phase_flag, tmess_prng1, _, qdss, _, _, _),
+	[96] = PINGROUP(96, aud_intfc6_ws, dp_rx1, phase_flag, _, qdss, _, _, _, _),
+	[97] = PINGROUP(97, aud_intfc6_data, dp_rx1, qdss, _, _, _, _, _, _),
+	[98] = PINGROUP(98, aud_intfc6_data, dp_rx1, phase_flag, _, qdss, _, _, _, _),
+	[99] = PINGROUP(99, aud_mclk0_mira, qdss, dp_rx00, ddr_pxi, _, _, _, _, _),
+	[100] = PINGROUP(100, aud_mclk1_mira, aud_refclk0, pll_clk_aux, qdss, dp_rx01, ddr_pxi, _,
+			 _, _),
+	[101] = PINGROUP(101, aud_mclk2_mira, aud_refclk1, phase_flag, _, qdss, _, _, _, _),
+	[102] = PINGROUP(102, qspi, qup3_se0_mira, qup3_se0_mirb, _, _, _, _, _, _),
+	[103] = PINGROUP(103, qspi, qup3_se0_mira, qup3_se0_mirb, _, _, _, _, _, _),
+	[104] = PINGROUP(104, qspi, qup3_se0_mira, _, _, _, _, _, _, _),
+	[105] = PINGROUP(105, qspi, qup3_se0_mira, gcc_gp5_clk, _, _, _, _, _, _),
+	[106] = PINGROUP(106, qspi, qup3_se0_mira, gcc_gp6_clk, _, _, _, _, _, _),
+	[107] = PINGROUP(107, qspi, qup3_se0_mira, _, _, _, _, _, _, _),
+	[108] = PINGROUP(108, qspi, qup3_se0_mira, qdss, _, _, _, _, _, _),
+	[109] = PINGROUP(109, qup0_se0, qup0_se1, qup0_se5, mdp_vsync_e, smb_alert_n, _, ddr_pxi,
+			 _, _),
+	[110] = PINGROUP(110, qup0_se0, qup0_se1, qup0_se5, qdss_cti, mdp_vsync_p, smb_alert, _,
+			 ddr_pxi, _),
+	[111] = PINGROUP(111, qup0_se1, qup0_se0, smb_dat, _, _, _, _, _, _),
+	[112] = PINGROUP(112, qup0_se1, qup0_se0, smb_clk, _, _, _, _, _, _),
+	[113] = PINGROUP(113, qup0_se2, qup0_se3, ccu_i2c_sda, mdp0_vsync_out, dbg_out, ddr_pxi, _,
+			 _, _),
+	[114] = PINGROUP(114, qup0_se2, qup0_se3, ccu_i2c_scl, mdp0_vsync_out, _, ddr_pxi, _, _, _),
+	[115] = PINGROUP(115, qup0_se3, qup0_se2, ccu_i2c_sda, mdp0_vsync_out, _, ddr_pxi, _, _, _),
+	[116] = PINGROUP(116, qup0_se3, qup0_se2, ccu_i2c_scl, mdp0_vsync_out, _, ddr_pxi, _, _, _),
+	[117] = PINGROUP(117, qup0_se4, prng_rosc0, _, ddr_pxi, _, _, _, _, _),
+	[118] = PINGROUP(118, qup0_se4, prng_rosc1, _, ddr_pxi, _, _, _, _, _),
+	[119] = PINGROUP(119, qup0_se4, _, ddr_pxi, _, _, _, _, _, _),
+	[120] = PINGROUP(120, qup0_se4, _, ddr_pxi, _, _, _, _, _, _),
+	[121] = PINGROUP(121, qup0_se5, lbist_pass, mdp0_vsync_out, _, dp_rx10, ddr_pxi, _, _, _),
+	[122] = PINGROUP(122, qup0_se5, mbist_pass, mdp0_vsync_out, _, dp_rx11, ddr_pxi, _, _, _),
+	[123] = PINGROUP(123, qup1_se0, qup1_se1, mdp1_vsync_out, jitter_bist, _, _, _, _, _),
+	[124] = PINGROUP(124, qup1_se0, qup1_se1, mdp1_vsync_out, _, _, _, _, _, _),
+	[125] = PINGROUP(125, qup1_se1, qup1_se0, ccu_i2c_sda, mdp1_vsync_out, _, _, _, _, _),
+	[126] = PINGROUP(126, qup1_se1, qup1_se0, ccu_i2c_scl, mdp1_vsync_out, _, atest_usb20,
+			 ddr_pxi, _, _),
+	[127] = PINGROUP(127, qup1_se2, qup1_se2, _, atest_usb21, ddr_pxi, _, _, _, _),
+	[128] = PINGROUP(128, qup1_se2, qup1_se2, _, atest_usb20, ddr_pxi, _, _, _, _),
+	[129] = PINGROUP(129, qup1_se3, qup1_se3, ccu_i2c_sda, mdp1_vsync_out, _, atest_usb21,
+			 ddr_pxi, _, _),
+	[130] = PINGROUP(130, qup1_se3, qup1_se3, ccu_i2c_scl, mdp1_vsync_out, _, atest_usb20,
+			 ddr_pxi, _, _),
+	[131] = PINGROUP(131, qup1_se4, qup1_se6, ccu_i2c_sda, mdp1_vsync_out, _, atest_usb21,
+			 ddr_pxi, _, _),
+	[132] = PINGROUP(132, qup1_se4, qup1_se6, ccu_i2c_scl, mdp1_vsync_out, _,
+			 vsense_trigger_mirnat, ddr_pxi, _, _),
+	[133] = PINGROUP(133, qup1_se5, emac0_ptp, mdp1_vsync_out, _, ddr_pxi, _, _, _, _),
+	[134] = PINGROUP(134, qup1_se5, emac0_ptp, mdp1_vsync_out, _, ddr_pxi, _, _, _, _),
+	[135] = PINGROUP(135, qup1_se5, emac0_ptp, mdp1_vsync_out, _, ddr_pxi, _, _, _, _),
+	[136] = PINGROUP(136, qup1_se5, emac0_ptp, _, ddr_pxi, _, _, _, _, _),
+	[137] = PINGROUP(137, qup1_se6, qup1_se4, dp_rx0, _, ddr_pxi, _, _, _, _),
+	[138] = PINGROUP(138, qup1_se6, qup1_se4, dp_rx0, qdss_cti, jitter_bist, ddr_pxi, _, _, _),
+	[139] = PINGROUP(139, qup2_se0, emac0_ptp, mdp0_vsync_out, ddr_pxi, _, _, _, _, _),
+	[140] = PINGROUP(140, qup2_se0, emac0_ptp, mdp0_vsync_out, _, _, _, _, _, _),
+	[141] = PINGROUP(141, qup2_se0, emac0_ptp, mdp0_vsync_out, _, _, _, _, _, _),
+	[142] = PINGROUP(142, qup2_se0, emac0_ptp, qdss_cti, mdp0_vsync_out, _, _, _, _, _),
+	[143] = PINGROUP(143, qup2_se1, qup2_se4, ccu_timer, mdp0_vsync_out, _, _, _, _, _),
+	[144] = PINGROUP(144, qup2_se1, qup2_se4, ccu_timer, qdss_cti, mdp_vsync_s, _, _, _, _),
+	[145] = PINGROUP(145, qup2_se2, _, _, _, _, _, _, _, _),
+	[146] = PINGROUP(146, qup2_se2, _, _, _, _, _, _, _, _),
+	[147] = PINGROUP(147, qup2_se2, _, _, _, _, _, _, _, _),
+	[148] = PINGROUP(148, qup2_se2, _, _, _, _, _, _, _, _),
+	[149] = PINGROUP(149, qup2_se2, _, _, _, _, _, _, _, _),
+	[150] = PINGROUP(150, qup2_se3, qup2_se4, ccu_timer, _, _, _, _, _, _),
+	[151] = PINGROUP(151, qup2_se3, qup2_se4, ccu_timer, _, _, _, _, _, _),
+	[152] = PINGROUP(152, qup2_se3, qup2_se4, ccu_timer, _, _, _, _, _, _),
+	[153] = PINGROUP(153, qup2_se3, ccu_timer, _, _, _, _, _, _, _),
+	[154] = PINGROUP(154, qup2_se4, qup2_se1, _, _, _, _, _, _, _),
+	[155] = PINGROUP(155, qup2_se4, qup2_se1, _, _, _, _, _, _, _),
+	[156] = PINGROUP(156, qup2_se5, qup2_se6, _, _, _, _, _, _, _),
+	[157] = PINGROUP(157, qup2_se5, qup2_se6, _, _, _, _, _, _, _),
+	[158] = PINGROUP(158, qup2_se6, qup2_se5, dp_rx1, _, _, _, _, _, _),
+	[159] = PINGROUP(159, qup2_se6, qup2_se5, dp_rx1, _, _, _, _, _, _),
+	[160] = PINGROUP(160, wcn_sw_ctrl, _, _, _, _, _, _, _, _),
+	[161] = PINGROUP(161, wcn_sw, _, _, _, _, _, _, _, _),
+	[162] = PINGROUP(162, qdss_cti, _, ddr_pxi, _, _, _, _, _, _),
+	[163] = PINGROUP(163, qdss_cti, _, ddr_pxi, _, _, _, _, _, _),
+	[164] = PINGROUP(164, usb0_phy_ps, _, sailss_ospi, ddr_pxi, _, _, _, _, _),
+	[165] = PINGROUP(165, usb1_phy_ps, dbg_out_clk, sailss_ospi, ddr_pxi, _, _, _, _, _),
+	[166] = PINGROUP(166, _, _, _, _, _, _, _, _, _),
+	[167] = PINGROUP(167, pwrbrk_i_n, _, _, _, _, _, _, _, _),
+	[168] = PINGROUP(168, bist_done, _, _, _, _, _, _, _, _),
+	[169] = PINGROUP(169, tb_trig_sdc4, _, _, _, _, _, _, _, _),
+	[170] = PINGROUP(170, sdc4_data, _, _, _, _, _, _, _, _),
+	[171] = PINGROUP(171, sdc4_data, _, _, _, _, _, _, _, _),
+	[172] = PINGROUP(172, sdc4_data, _, _, _, _, _, _, _, _),
+	[173] = PINGROUP(173, sdc4_data, _, _, _, _, _, _, _, _),
+	[174] = PINGROUP(174, sdc4_cmd, _, _, _, _, _, _, _, _),
+	[175] = PINGROUP(175, sdc4_clk, _, _, _, _, _, _, _, _),
+	[176] = PINGROUP(176, ccu_async_in, pll_bist_sync, atest_char, _, _, _, _, _, _),
+	[177] = PINGROUP(177, ccu_async_in, atest_char, _, _, _, _, _, _, _),
+	[178] = PINGROUP(178, ccu_async_in, atest_char, _, _, _, _, _, _, _),
+	[179] = PINGROUP(179, ccu_async_in, atest_char, _, _, _, _, _, _, _),
+	[180] = PINGROUP(180, ccu_async_in, atest_char, _, _, _, _, _, _, _),
+};
+
+static const struct msm_special_pin_data nord_special_pins_data[] = {
+	[0] = UFS_RESET(ufs_reset, 0xbd004, 0xbe000),
+};
+
+static const char *nord_get_function_name(struct udevice *dev, unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *nord_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	if (selector >= 181)
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "%s",
+			 nord_special_pins_data[selector - 181].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static int nord_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = NULL;
+
+	if (pin >= ARRAY_SIZE(nord_pin_functions))
+		return -EINVAL;
+
+	func = nord_pin_functions + pin;
+	for (i = 0; i < 10; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u pin\n", pin);
+
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data nord_data = {
+	.pin_data = {
+		.pin_count = 182,
+		.special_pins_start = 181,
+		.special_pins_data = nord_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = nord_get_function_name,
+	.get_function_mux = nord_get_function_mux,
+	.get_pin_name = nord_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{
+		.compatible = "qcom,nord-tlmm",
+		.data = (ulong)&nord_data
+	},
+	{ /* Sentinel */ } };
+
+U_BOOT_DRIVER(pinctrl_nord) = {
+	.name = "pinctrl_nord",
+	.id = UCLASS_NOP,
+	.of_match = msm_pinctrl_ids,
+	.ops = &msm_pinctrl_ops,
+	.bind = msm_pinctrl_bind,
+};
-- 
2.34.1

