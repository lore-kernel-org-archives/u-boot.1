Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C56CA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA04F405F3;
	Mon, 12 Oct 2026 13:36:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AAhF346C_2Ia; Mon, 12 Oct 2026 13:36:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2EB5405B1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791812211;
	b=TXDnhnbyuLrptZThXR1OJMnCj2AEbDcNPCi2H1kZaPItIW2wqvZ1nktnW4tQnKfoCWpe
	 pGd0ltHPwGOOhPDkH6pVZ8lC6oASl7XEWfswae8E/ExcuA2GdZBosoZGVfjLX+QGEr9Cs
	 oZy1LkPDSrmQ4spfzyNIsusC11ES1YiwyUZSs3Bov5s7AkGs5G7PEpLAY1c9nEASrsfmi
	 LmY+O5vn7fCntY90+sIgME1fucOzvsX/Nu979P/lvkcv+3l9Sn/tpDbZET1A01c2zwC+v
	 mgv+5JUXrAAqN+ZVomVGchx5rj7yrVfNrairu4cr05lPiTSqZ0LWX5c1UI1ev10cDug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791812211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ScQF0SKMld8hmbrdT0qvxBvvK4VqrzMpXENN03R1zkU=;
	b=lMYJGp6G9m2+356c1UZmtMXVeJlAS5y6Gqmarz/EMKOVSG0OuCIssUlqXp3O53zIVW0y
	 Zeas7LH99pJaChVgYywMIteQXcJ6YApsku0+NPDg3RDz+h5dShkhTrdBT1nu//84eLFkA
	 jXCpiorokflCA+Awk6grQYnPPayGvpwWuoWwnEpIzizfctjYkd5rQ4Ynsvgk6us42uJWl
	 kc7v1K+jxgZpdQ05h1djdCMYoQQ2Fjegwq95QuKVUzuNmXdyk8G0cLRZ1bm2sJIC9GKRl
	 kXeZRqmvuYbys0Wp//WNVnoDxoVkJvzQtMxBkX8WGBufzyMLJvh+CzQoSv1JPkb91RA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VeHTO4Zu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j3MeN6i8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791812211;
	bh=ScQF0SKMld8hmbrdT0qvxBvvK4VqrzMpXENN03R1zkU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WHCacDQqzeaT+H5puV8AAjX+mtBm1zJUw80H0h6ud9oVfJWd7DSWiNL4aAnbIzZOq
	 9qCOi6APvoetDJ6qDJvj5CSXHdusKN5FeaAzlIPxofAGXemxzjELQ9FBV8NKDj6E7p
	 BD+zFnZ4+fFfZ1SfEb1Eqkakh+leYCLzjsZ0z3Z1UBisGIl6RYLqEVPc66JBB5Bq9M
	 gc9WHUWzqAoswinHyfHglKf6dtXQXNXlPnOhwrS9S0gyXgfRcVxsTR73NiWHZVGLeu
	 GfCpv2TAuNFrzWReFr9mhDgkTlKGV0oYw5lFG6/tZXcHB02KqoYf0pAAh8JdB9iNlg
	 znpO7YDU4jLKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2EB5405B1;
	Mon, 12 Oct 2026 13:36:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CEAFA58
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E784405B1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tuxMhHEKQ1Lk for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:36:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B484240580
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791812209;
 b=Wtba3C4Nx2VgaZCxnzT+Dxb+wKkqktCYiYPoPCP/sFJvN9RELo4Ij5ZByhmFauWgUclc
 bZ0YjenlRfhZD3V2AE7XArGiW/g5yNhN4dE5VcNdQDnRYe6t1oyeT3dnzWMzo0Kh848g1
 xvANkJotMWyUuF+jd8N1tqfLCTjNW7AM5PRjmisi/3NtKhemlwhFyvn77TUQbqKx6Nf7G
 GCmjvZJ4jQtV9B6aiB8EcgfjGv2wng4xORF5KymGZTSPSuj6K1u9JFYls74TVEhYv0oIA
 044Cfd992qkgeeNaHTDfbyVP6LlTE93IVF/8aajNrOFqzlNQA2enxhpHuXJUxErcqMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791812209;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ScQF0SKMld8hmbrdT0qvxBvvK4VqrzMpXENN03R1zkU=;
 b=V+XBJu+cRwQ5eEQJ3sQ4o/SdxxzKNV8Qf7qib7jMoNS2FRCiA0qBu+XsH+YaouqNt1KO
 pWS4mtb/fdJgC0Rohk9LLr99HQjOPGYws1ZI03tstJ5pk0XZkM9bo40S+XP/qrKAITA1h
 1BN4R3kmGn29Ym2FOwDQqIMt3kFWxHIgZ8A7pcUFCVdnNH5Vbyv7yXwjACyD/Vu2BQy7G
 e7hwEuT+tKsG+x3eGkHTkBpj3olWH/4eKQ4B6nMJhTdHDevH9YY+yoiQXliU6SkNQyXip
 ueYv1UlAzYhukPhWnFBF8lRKBkYpTFr20W93oBJuqnzv0g8SsSIptzHNqqG/Ya0g/GA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=VeHTO4Zu; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=j3MeN6i8; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=VeHTO4Zu; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=j3MeN6i8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B484240580
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:48 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0ATC2275878
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ScQF0SKMld8
 hmbrdT0qvxBvvK4VqrzMpXENN03R1zkU=; b=VeHTO4Zu1Q7cy72T1v2NEo+i4EZ
 qq6PGgXJ5HbBmpYug4nscHkbUwXyDEcVgAg8WXmjnUPbgNA3kDE+g+GwgT1e+/qa
 pAQaOuDFKmBxt/MCv5DyTaBwBbsZmGqvYW0kILvjbWD1vGCGHULVtvpOZkRyw2Dz
 qzeUqFf1fI34NTlLVpd8r1V08noC4JO7nRG5YF62/0pLYimsbthAPpE62hD48Vpk
 jAzekz3/R1KcTnrEvKq6y1K5kUpvvHgK8Bsn2zBpSaiYyD4AuJeMtI+/ysWi9RDX
 U5wlyLxWO+5shEBj9zGTtRufxGmAUZH+fQEF5u1O1vRwczXvXQdOKwicVlQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq1jd1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso4851140eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812207; x=1792417007;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ScQF0SKMld8hmbrdT0qvxBvvK4VqrzMpXENN03R1zkU=;
 b=j3MeN6i8H34UMsm098uyeKDrwxIfKYJFuF14Q68myv2zTDz9HiEf7zURgvB0hPbdk7
 qJ/Jt4ZmxKQhywmOfXJBEDvfgwNLH4poOoNeDEcmUE1fE98Zj8GNYkRK8kD+FO69JIYx
 DMjhrUslbpCKfH0gMp+cTO1ggEQbs2MQrTO0FH/LCQYM+A8Ix0qMB3Mpxxm0KTtyMjhc
 5mvDTgNLcvfDUOCn74hupr2VZWxLbqPF1rGsh5zV9REf7HQNYjrk+aYBYRFdARgGv+Mf
 l3ryx5iOoELvZgMjdEkcqP0gwZmp1T13QJXF8pideWjEUVySB7JFwhQSdA6Sv4KULvk+
 7qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812207; x=1792417007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ScQF0SKMld8hmbrdT0qvxBvvK4VqrzMpXENN03R1zkU=;
 b=pL8ofXQKoQj/kIlhGl0gbPpOFdzLVqKYXnTr7A4gnhHDTqhemBW0Ezp1NT6Bmlikwg
 0GlxDGdCJ2Ad5VFax+h6swKW13+BFCGCV1xWbpi3sHxUj5tapk2Kd0auJldsXUh34tAx
 BJmeh5hw8yXCWt6LyNDn1+0EhZ81A47Nufk+N61ehgfsfY+cSoc520+vaLr4e6Sn0VIg
 KG2NuD2Pj7bdiSx8ywATQrBBHWqeJL0VIlvdGCqd2634XwpPJnQMgq0rWKCoouy7a3Pc
 CKhNAXOJ2BdHhroTxhVYqlQnOzE9ls3axO1YcnQlcFnKEQ0SkSGoivj/OL+KQDnu7w18
 hnhA==
X-Forwarded-Encrypted: i=1;
 AKwUvByrfEKrWga7XNGrapVp4RiVmax87bEGTlxkPsOuudj/WXQHK211Jmk2QioDACD/AE4mPMZT0wI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJApkCQ5I4Go5Oc0I532em0klDDOcN8WqWS3NyHCGbjkzza7nW5
 mEyqhf7QwoWqKxiqIlgeqcsqOk/x7dBPeTy9knNqevz+cSh0qDfUWLvPRLiLQwFoRk9PH2SIlBg
 l7yCBvHULbi+AZ5jMbhzoZulitrpR2TdmGPbN3XJHfSaBnjf16yn+51Ry7Sw+6mG00NeNroM=
X-Gm-Gg: AYBFou1sYcEplWmh1gDV8BKAvaOL3ibSbcyvHjaAXlZiWSa3zB6M9b4LjC5gLzpOmaa
 PHDK5iCtVGlGzSgsHF/zatXWYFSlWarZPshpOa4QVxme22lHxPcvQcxnxhIl1qMEyLk7v/f5QuT
 pkiazLmDPWTCkOOAu8fIFYyutRGKR2n3K+nBaBMizMMsHft3m4cz59eYeAhEsI/JmXrBLw3Qv5w
 9qhJ76pAOPxvjzee/6HSkPREwn8wpaEzRwekE44CfTZoX7XvTzh+myPJih90n9bRISQ3mys4d9t
 Z3Mr3ZBRQOSNX5C2sxjAyd2kMc2o2EqM4fnNWkFmLPfbe0CoYUPdS4Nb2iek2V47FXmyALf84/n
 ymruj6hFw8bnV8+FzkariV2BGhYSerGjYCRdZC+5ZfVR1ioEcbC0KYvzh4P3LAD9z1xI+1Jg9mo
 tMITdYTIRNakPK1+S4ls4e
X-Received: by 2002:a05:693c:895a:10b0:351:1e72:7470 with SMTP id
 5a478bee46e88-3537e04414emr13762653eec.13.1791812207356; 
 Mon, 12 Oct 2026 06:36:47 -0700 (PDT)
X-Received: by 2002:a05:693c:895a:10b0:351:1e72:7470 with SMTP id
 5a478bee46e88-3537e04414emr13762600eec.13.1791812206585; 
 Mon, 12 Oct 2026 06:36:46 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-359789fde97sm18323802eec.20.2026.10.12.06.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:36:46 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com,
 badhrinath.s@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 2/4] phy: qcom: snps-femto-v2: Add IPQ9650 init sequence
Date: Mon, 12 Oct 2026 19:06:26 +0530
Message-Id: <20261012133628.1569010-3-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012133628.1569010-1-badhrinath.s@oss.qualcomm.com>
References: <20261012133628.1569010-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6acce270 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=E5kL15_kmtNO7nmjp6oA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX7O8L90j+TFol
 +CZ5V9+QnjoMBlLUHUxA0Zbqhm8tTyx+fXh2dRCHxP2FDlRnEonw416Gj0U4yiv6WR5oDVpXaut
 NmFQSG6zfY4sxU8wVlMXbO3ZHSX6UrA=
X-Proofpoint-GUID: qbcFGvLRCskf1JOvc08JbPD6nUOHTvJN
X-Proofpoint-ORIG-GUID: qbcFGvLRCskf1JOvc08JbPD6nUOHTvJN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfXw9gMqrehnbco
 O+QT8mDeiPW1zM5nhGrqlAo1pb2OBfx+RIk3EC8bIgJNIQWoO74fSTtBL84baxCA5SgqczJYBip
 xn6Irf62LOYkVGVUlF4WGdHrjMyyRlvw3CBCLl1Usww6FLRtcc+VKavefto0RlK2CWumjA4rSaq
 6Gwmh7qxoCaD3YAvaYyjfZio8zzicCHoUOMv+nqidQBNTv8ViIyVnvjES8z20dodusb1oRHahP8
 6qkVd2LmJ6rw3fMt/wQ46sdch4S/SoB8kf4Tp2zKXGgpA/Cp3exFY5+iVq4L9CurTJMUG45S0Tw
 FmxZQWWlOvmW4/Zfxg6oxhIjIwgD8SHrvq1JvhaLlJMUCeyVdMCONKEp9r1pdQeEyqlpKXZQFe3
 pIYLQkw38JAlP+AHIJYhbAlc61Y5/DsXidOW9U+4JX8u6t3PMffsa1nq9lq0bkbYM9519ZMzrxL
 UpDzCBNTpHMWajvhGXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120054
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

IPQ9650 requires a different PHY sequence compared to the existing SNPS
femto v2 PHY init. Introduce a per-compatible init callback and add the
IPQ9650-specific sequence, selected via the new "qcom,ipq9650-usb-hs-phy"
compatible.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 122 +++++++++++++++++++++-
 1 file changed, 117 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
index bf1f16e4a22f..489bc8706975 100644
--- a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
@@ -28,12 +28,15 @@
 
 #define USB2_PHY_USB_PHY_UTMI_CTRL5 (0x50)
 #define POR BIT(1)
+#define ATERESET BIT(0)
 
 #define USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0 (0x54)
 #define SIDDQ BIT(2)
 #define RETENABLEN BIT(3)
 #define FSEL_MASK GENMASK(6, 4)
 #define FSEL_DEFAULT (0x3 << 4)
+#define FSEL_24MHZ (0x2 << 4)
+#define VATESTENB_MASK GENMASK(1, 0)
 
 #define USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1 (0x58)
 #define VBUSVLDEXTSEL0 BIT(4)
@@ -50,6 +53,16 @@
 #define USB2_SUSPEND_N BIT(2)
 #define USB2_SUSPEND_N_SEL BIT(3)
 
+#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1 (0x70)
+#define TXPREEMPAMPTUNE0_MASK GENMASK(7, 6)
+
+#define USB2_PHY_USB_PHY_HS_PHY_TEST0 (0x80)
+#define TESTDATAIN_MASK GENMASK(7, 0)
+
+#define USB2_PHY_USB_PHY_HS_PHY_TEST1 (0x84)
+#define TESTDATAOUTSEL BIT(4)
+#define TESTCLK BIT(6)
+
 #define USB2_PHY_USB_PHY_CFG0 (0x94)
 #define UTMI_PHY_DATAPATH_CTRL_OVERRIDE_EN BIT(0)
 #define UTMI_PHY_CMN_CTRL_OVERRIDE_EN BIT(1)
@@ -58,6 +71,12 @@
 #define REFCLK_SEL_MASK GENMASK(1, 0)
 #define REFCLK_SEL_DEFAULT (0x2 << 0)
 
+#define USB2_PHY_USB_PHY_FSEL_SEL (0xb8)
+#define FSEL_SEL BIT(0)
+
+/* Special delay values */
+#define DELAY_MIN_US 10
+
 struct qcom_snps_hsphy {
 	void __iomem *base;
 	struct reset_ctl_bulk resets;
@@ -135,16 +154,108 @@ static int qcom_snps_hsphy_usb_init(struct phy *phy)
 	return 0;
 }
 
+static int ipq9650_hsphy_usb_init(struct phy *phy)
+{
+	struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_CFG0,
+				   UTMI_PHY_CMN_CTRL_OVERRIDE_EN,
+				   UTMI_PHY_CMN_CTRL_OVERRIDE_EN);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL5,
+				   POR, POR);
+	udelay(DELAY_MIN_US + 10);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_FSEL_SEL,
+				   FSEL_SEL, FSEL_SEL);
+
+	qcom_snps_hsphy_write_mask(priv->base,
+				   USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0,
+				   FSEL_MASK, FSEL_24MHZ);
+
+	qcom_snps_hsphy_write_mask(priv->base,
+				   USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
+				   PLLBTUNE, PLLBTUNE);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_REFCLK_CTRL,
+				   REFCLK_SEL_MASK, REFCLK_SEL_DEFAULT);
+
+	qcom_snps_hsphy_write_mask(priv->base,
+				   USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
+				   VBUSVLDEXTSEL0, VBUSVLDEXTSEL0);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL1,
+				   VBUSVLDEXT0, VBUSVLDEXT0);
+
+	qcom_snps_hsphy_write_mask(priv->base,
+				   USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1,
+				   TXPREEMPAMPTUNE0_MASK, (0x1 << 6));
+
+	qcom_snps_hsphy_write_mask(priv->base,
+				   USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2,
+				   VREGBYPASS, VREGBYPASS);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL5,
+				   ATERESET, 0);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_TEST1,
+				   TESTDATAOUTSEL, 0);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_TEST1,
+				   TESTCLK, 0);
+
+	qcom_snps_hsphy_write_mask(priv->base,
+				   USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0,
+				   VATESTENB_MASK, 0);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_TEST0,
+				   TESTDATAIN_MASK, 0);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
+				   USB2_SUSPEND_N_SEL, USB2_SUSPEND_N_SEL);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
+				   USB2_SUSPEND_N, USB2_SUSPEND_N);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL0,
+				   SLEEPM, SLEEPM);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL5,
+				   POR, 0);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
+				   USB2_SUSPEND_N_SEL, 0);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_CFG0,
+				   UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 0);
+
+	return 0;
+}
+
+struct hsphy_data {
+	int (*init)(struct phy *phy);
+};
+
+static const struct hsphy_data hsphy_data_default = {
+	.init = qcom_snps_hsphy_usb_init,
+};
+
+static const struct hsphy_data hsphy_data_ipq9650 = {
+	.init = ipq9650_hsphy_usb_init,
+};
+
 static int qcom_snps_hsphy_power_on(struct phy *phy)
 {
 	struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
+	const struct hsphy_data *data =
+		(const struct hsphy_data *)dev_get_driver_data(phy->dev);
 	int ret;
 
 	ret = reset_deassert_bulk(&priv->resets);
 	if (ret)
 		return ret;
 
-	ret = qcom_snps_hsphy_usb_init(phy);
+	ret = data->init(phy);
 	if (ret)
 		return ret;
 
@@ -186,10 +297,11 @@ static struct phy_ops qcom_snps_hsphy_phy_ops = {
 };
 
 static const struct udevice_id qcom_snps_hsphy_phy_ids[] = {
-	{ .compatible = "qcom,sm8150-usb-hs-phy" },
-	{ .compatible = "qcom,usb-snps-hs-5nm-phy" },
-	{ .compatible = "qcom,usb-snps-hs-7nm-phy" },
-	{ .compatible = "qcom,usb-snps-femto-v2-phy" },
+	{ .compatible = "qcom,sm8150-usb-hs-phy", .data = (ulong)&hsphy_data_default },
+	{ .compatible = "qcom,usb-snps-hs-5nm-phy", .data = (ulong)&hsphy_data_default },
+	{ .compatible = "qcom,usb-snps-hs-7nm-phy", .data = (ulong)&hsphy_data_default },
+	{ .compatible = "qcom,usb-snps-femto-v2-phy", .data = (ulong)&hsphy_data_default },
+	{ .compatible = "qcom,ipq9650-usb-hs-phy", .data = (ulong)&hsphy_data_ipq9650 },
 	{}
 };
 
-- 
2.34.1

