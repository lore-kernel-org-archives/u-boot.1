Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F2CC79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 10:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18E8E60AFC;
	Thu, 10 Sep 2026 10:29:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C-eDWN2a2c-S; Thu, 10 Sep 2026 10:29:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4C37060809
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789036193;
	b=bXDLKd0dY+yLtddpada6jmNTwGY+0Ml1xrg9Ux0PbTfHIoHDgyHXJmCakIvQYmYv2JXX
	 oGA6+VHfojKr7nelVR7/fEtlSl0zWdTffI0yfRoa4G5VxmzqH1LJP/7E3M9FZ8TJeAYNn
	 j8Cyu2G/3CqRX05XnuZ5NSJJDLiIH/Av57+C1sWsLFWYp5wVemOvhPSKTtIpjeDD2duST
	 mb/GpAUurTTNcjuo7sEjdAE71w9xRh00kFerECJCKid/ukfX8prczrqyKJueQnf+oUIcB
	 b5BWOSspVq2VCe8iV6usizQSk/RY3UHkS2/PdgJGpMlPvVydVPjtRdEwoOvwlz1Hgow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789036193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xWZZE3xYKe23Z79woKd8BI8HHaFaF83jyHv7BB2u1VY=;
	b=bRsVIiudJuX/xPRAkS2BEm4TTo6evy9LiaaLKt+N/FWaibZSQbskKGCLxlPFJTcQ9IvV
	 wM0mPXDQ5x5SdAPeE+EoRInlcry82YdZkkgZiNKS6Vm/GKnED47ib7U6PDhFuuot7+u8/
	 RkixHQZzr5fXaByFz+nmB1vEpwvfj6Rr4bHLCqqhQ3psIoEG/PoreX83MVKKJ4BSKAJaF
	 bnFGwmTcOSpm1ndqZaCAD6kLdOl70YQ88/OVXPNFY8qD45XsoO5YolzZ85TXQF+D1ic03
	 P942L8FZuzfslKNfg8pQdFpfAbji0rAY6Z3RLQWj0CsZ6j7DE0fZ7xQfE7DGvmLvxNQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789036193;
	bh=xWZZE3xYKe23Z79woKd8BI8HHaFaF83jyHv7BB2u1VY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FwwO0psSIbrmxu4tp7rRDwhJ07922908Q+KOsYudwl0YRG286ItAlMK89Q8sc5M4p
	 xlwickk9tc4F+q2KCa+z2bYZepQ1Bc+KQyyOsM16/ZCaGwH1FrEXrn+VZ3H3jScaA2
	 mAYFOjtOGLiNiETJcxP/uT4ntWnSy6eMFYMaU50AoBqFtNHzMe3Q6Qze5d9ZaYDLEg
	 KwOAeRhQL6SzKTpz1g223qHwOvvjvTeOiJdrzBIXbnpdaidQBpDo7ZMx8KRjedNEBF
	 oVdPqb6ysNNmlQQx9i7OktEWN1oy+RHXCfWrJsxJ1IrUyXZhLNBtbxnvTkW6NO/8Ea
	 cPdUSUvByZ7fQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C37060809;
	Thu, 10 Sep 2026 10:29:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D68243F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47337401DA
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZfRhYZXv3csy for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 10:29:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5BB654006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789036191;
 b=hemQifAwQrl8/69h2UtpPDiEkj+8ZFZv6qFFY/rtnYO3jlGzE1diK+zu4UgcfD0Cfe5y
 1rBh1b7jrl0h4vgAf8mKbxvzURuJLdbDyguiE3uNQ5zErE47//Mw4pNBoLMap6jyZ1ios
 TH6wVFnmRGxEB2rmDvpXomVn9PypaEkLtCB8cfOtfdjXQdhO026rghhSndboqRXq8OUPZ
 l8vkIeMbqbul47PQKinw3jg02i96FlqodjQ0j3tQiVNGQGTaRiEEOOwiAY5zDFAgda0w3
 dsRLeyaaGZrVoeArd5HKDwpFHNlbxyfDKo6W5nzdvTofhlKEvAEODzlRmoGLQd0vCIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789036191;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=xWZZE3xYKe23Z79woKd8BI8HHaFaF83jyHv7BB2u1VY=;
 b=HdZUzR4wC2H8NnjJP/+8z7Qx6e0z9IlmrKEuDbP07naYB4bK2rVkw8RXeLCPD1C6TWFd
 xFzvIM+P4JH4FMMVPihpjcp0a/6TH4HDUVwuKcX9zyctC+t3eJVPK8FKlRrP444JEteHc
 YlfzMJHExhI5Fzai9WKsFxbtmNllay2sMOHAcobq+M5eml5aXRPlgjnFnD4dWOPuC4SkA
 Cl1vgFDHCZox56NLOLA2c3/wY0JH/EUuoKzUBDsQP2zzQ5OSowrlmx8hwIN7iG3cyAXt1
 dgj4rXwoqsbpHb9I9SoxP3in4bvoQqp7K8yyJrAOV0MCgeVL+b1Y3KR2tN1sysnY8yA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=U4q5aF+H; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=abrbH8Vf; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=U4q5aF+H; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=abrbH8Vf
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BB654006B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:49 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68A8pdle3967637
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xWZZE3xYKe23Z79woKd8BI
 8HHaFaF83jyHv7BB2u1VY=; b=U4q5aF+HK5Jayj4JpsnH62wHMxctDc5YPt8a0R
 DAt1sWH46vJbkKTgqhCW++ad5F9gC7QO0J1nMA+7LF43sHTuf93NL7ISSTnBfRFr
 3lOR9hhXDMAIMl3n6WplTY+0qvChDPnvT9/+vPWpYCXQKrJILXccaYGmMr+nw6g0
 BI8H3L5RSdTmiCEzSqkjtVDyGPEazwsp79I+3kMWTjkOTuqK9cMLdmTjFvVMTje2
 3LXasInmDx+ZyZ3kBUvpWbNh+x5Q+tOdLTJ7mbcUDGiN9yFEy4Q63oa4xlharIGh
 ZptL/mY62NjnM59J0WcKbfXOnwbSyKYcOPhBLRFeiKux8CbQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrdn8n41-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:29:49 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc4922b7c31so3348218a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789036188; x=1789640988;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xWZZE3xYKe23Z79woKd8BI8HHaFaF83jyHv7BB2u1VY=;
 b=abrbH8VfCEUnqL0oqmMxXOHqF4eWaKLDn+ckTivXj/xrT04XlDKl5uNXKTGu+Y6bNG
 tzZ+VAhPWXfDV7poabd1Cb0XJFxQvPYQJDRPUo7hbl3HiRkTwPYginbs02uReCna0MT6
 8xhNmAD8nh4lRKjPJTpHCQ2cDNJUzrwKoP/wZys/6O+veBBxMA47KoyIHJ4Pop/EBQOv
 EKC7hIILBh/vuALHxU+yWgm/WSTawNBMXGtuKECtK7wEQjlHPbzJsfQXIP/jMZOnDl1w
 wvt/qEz8e4XSFATbFUZpCmKD0VtVga4yMeu7QxD1Xaql0wpwHpj5ikD0Fkb+axsBRwt9
 SDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789036188; x=1789640988;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xWZZE3xYKe23Z79woKd8BI8HHaFaF83jyHv7BB2u1VY=;
 b=A0au6MioU/d7JKd7aN3RY6CaAms8opPrGfKqiA5sAE8X1vZAJQ/6IPc+u2LcuSfXTC
 qb0xt6FXmvKwX77NjCTo+n0o5bIp7+QYyMIAxceYba1AxgcwZ4m4tGRx99wxNHc4VP1X
 D6M8j7k6MnMLQkVzUdisdmQxqUYK6uJGeGn70hKYoYnZYYLH6fNDL1u0GayS/U8Sd7ZM
 PgcNu58zGuABF3nPWWoSyM8k20vdopRw0wkbLSKRpqnNC2TEmXZcy1ze1ESY3qHsQjAY
 85fGVd4dcQm0D4+AEcmBUFO6E4xxus1mgEFRLTr6WxxMLa1pKW6c5MKYJL2AXOLjv+XU
 lqEA==
X-Forwarded-Encrypted: i=1;
 AKwUvByUFIf6+StZYR4/uwYvmDjR6p0Jfpy1w5zI30YfRISJ72mOsyLw446suZjg5a2ci+0McggLYJg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mKfsgulH0ZKbfesl7R1zusgKiMYOEmG7L2gyP/Nbn3aCC5m4VQ
 uoUVPH3AiTbOZvvkt/dCiif9/0/B7N9rTTZEJ1qv7+WFr4XQVc9YhLHx30T4hHjcfpLyLy6ArsN
 tMb/GV6jR9xHJQoEtTSjomtnR0a98ZioEwsKJR0pvdK2QL2UCa6XZ6RBn8RK4JTo12L5VWIo=
X-Gm-Gg: AYBFou1RL84pRkN32otP58ob1JGDuqyjXHa04CWtEB92poIjHO3mlkIT6+0H82f+9oG
 YVN5UECre/MtFdjEWZY5eGobUX1x4UeRDioLFx+SSZrBR0+wMiZEPhGZeB6HBGchC+5CyJmhnDx
 6rDyoMRxK19EW8LLhSwLCNK4VUPWqUd0YAcNU/nqFp4N7gOYqOs65zVHAUaePl8VFei9CsYr67H
 zNUfQT7u3IZTJ/4TyQ7lsspqpKegLLlYp753l2exOt+AK1DdoH1/1VxaNcJSQXk6bOAT78HklEw
 gfJ+2HNCnz0srpFklc2v3zObEOmKj8rjHbF4NhRodb2epToBLYesila1g4Ztfl5jn+F+uPYU3K9
 qPAJzyQe2WHBOD+X2DOVCX7u4jPizuFovuFrzpG7QS/j9VW/moP+tFA5RJDD1nud3dgHyYQsm1l
 0e9aDWGH1n83kSzAjTaEk9qfsJKy8cgw==
X-Received: by 2002:a05:6300:83:b0:3da:bea4:6219 with SMTP id
 adf61e73a8af0-3dacbf15124mr11594923637.20.1789036188539; 
 Thu, 10 Sep 2026 03:29:48 -0700 (PDT)
X-Received: by 2002:a05:6300:83:b0:3da:bea4:6219 with SMTP id
 adf61e73a8af0-3dacbf15124mr11594826637.20.1789036187976; 
 Thu, 10 Sep 2026 03:29:47 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a62be87sm42824576eec.6.2026.09.10.03.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 03:29:47 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v2 0/4] tools: qcom: mkmbn: Updates to support ipq5210
Date: Thu, 10 Sep 2026 15:59:38 +0530
Message-Id: <20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJKGomoC/yXMywrCMBCF4VcJszaQGRq1fRXpImYmOoveklaE0
 nc32OV3OPw7FMkqBTqzQ5aPFp3GCroYiO8wvsQqVwM5urobNlbnxRM660mQgw+pTRHqe86S9Ps
 vPfrTWZatBtdzhGcoYuM0DLp2psWGmZJnvEN/HD9LzynXiAAAAA==
X-Change-ID: 20260714-ipq5210-52e1da5af9fc
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEyMSBTYWx0ZWRfX//LpJLxHfjIn
 CVzavAO6oQr8f+eOHKTCR0up8AHGg9pufjgA4/mwu1CWBsg7tYn6bp+kZigXI1PZ7uJjZsreBW6
 HL09jlGgqqK93otAvae94q8UbzhR7+5p/cDsUtnViOkJIM4yHfZF0I86H5itsS8IxeSLM96Da6Z
 25OYGM185R5N4tZxSbSn0/lG538tLCdn8RkjIvtc0DBPLnp3U0gI/zXAfgLxRahW+bVQVoyDGIX
 MoJI3CXhsPRh7wlrSCoPIVf5oIcJlFU+pF364V4yqck+hs3UdL72oUtEnvYthSxAJdx4IonpctA
 Cn1krXMDZxmaNMP9bmS0Hp4m+wK2WzZdJnn4MwHkbWSH8aJu6ktCbObxd5RZpaJ5JrQAc0XHmr0
 yJr/HfI12wE4w3wXxVBC5kE1e1ShUXDmUbhT1sNjFMNWTfAFvqIn1251NV34koF+8LnRS4oRgCJ
 QF2+bJqFIqPFYdOrx0A==
X-Proofpoint-GUID: -4Q3GTXQlmEbDG_jSYWixg_0G8Ol9zRi
X-Proofpoint-ORIG-GUID: -4Q3GTXQlmEbDG_jSYWixg_0G8Ol9zRi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEyMSBTYWx0ZWRfXyArsdZJbDPZc
 +CAEUHwIUok7z1+hit3NDmvz3Nh1gNtLFSDEScD26vh8AM0Ji5uEiTygHoy8+4q0DDNqKCNrne6
 josDAkt/JClA2Kf7bgyR954OO1WI4qU=
X-Authority-Analysis: v=2.4 cv=eOmGH3p1 c=1 sm=1 tr=0 ts=6aa2869d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=p580P5g6mWtK41y3Ph8A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100121
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

As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot proper support,
the mkmbn script has to be upgraded to create images that can be used
in the ipq5210 SoC.

These changes are to address the feedback in the 'Qualcomm IPQ5210 SoC
bringup' series [1] to use mkbn.

1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71b8f9c6cf@linaro.org/

While at it, fix the MBN version number for ipq5424.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

v2:
- Remove 'load address' from MbnData and get it from .config
- Add qcom_sm8550_defconfig
- Use 4K alignment for padding the MBN images
- Remove '--melfs' option and make them positional
Link for v1: https://lore.kernel.org/u-boot/20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com/

---
Varadarajan Narayanan (4):
      tools: qcom: mkmbn: Fix ipq5424 MBN version
      configs: add qcom_sm8550_defconfig and debug fragment
      tools: qcom: mkmbn: Add support for ipq5210
      tools: qcom: mkmbn: Add support to create multi-elf

 board/qualcomm/config.mk      |  2 +-
 configs/qcom_sm8550_defconfig | 15 +++++++++++++
 tools/qcom/mkmbn/mkmbn.py     | 51 +++++++++++++++++++++++++++++++++----------
 3 files changed, 56 insertions(+), 12 deletions(-)
---
base-commit: 914dd2f5d18a3a89e4ddb6d1d97b2743618ae5ee
change-id: 20260714-ipq5210-52e1da5af9fc

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

