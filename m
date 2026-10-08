Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9FACA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A697C8127C;
	Thu,  8 Oct 2026 09:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vKX18GPJaGOK; Thu,  8 Oct 2026 09:49:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9C0AD8127A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452988;
	b=iPA210+ZFpo112JI4Qe8sjgQnDFV32K/9/1fqBNTSSNzQt12NDeYIpFNP45GgK0cx5XU
	 kY+HQ/UMLV5T1XTLUWSIcUFAGsQ3Ajglj6OV57xz8O6GZ3AHVDoNVqx2F/XM6PBCCHnU6
	 z8DGsLDuvVjxxBTjyQ0A1fImQSiWNt8sjpCSK3u8PQqraQv2ME/dP9OTHkqjq8zO372OD
	 HiZxqlF4q2QTmb6o5KDCj6uBpeWXwrqAzU42Q/ueFwbkYdp2PKVDE4wXCPUTnsfNrbn2p
	 SVIbEtL0mgKKkrIo/6a7trKaavZY7DqnPoS24vG2en9Ae7eEpgN4UXMNBWM53Ou/svQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452988;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IFVnXQo80f/oWKnjVQM3A8d/WKjvIMMVEN9hv3O2eEE=;
	b=qz2xi3n81JPLELTCAHO0wRhMpNeDYaPrMbZi2iN9BNFJjwldBbocnKCFLFUH7cF9GFBo
	 so+ORrqEAvHJeSS0FGkpdLeFJk5BsNYZK2hoLDqnpC40/GD6MbzzpSGL1l0WzU81CMv+P
	 Vd1kNFx//kzTW6ttfmP7AD/99EoxJQqODTp/HWu36QZiAbguvWGYeh6sRd6uZf5rIAgNP
	 J+iMfe60vJ+K8Ja083dEgjxyqbKynXxTlR0z6xnM8dBUpcNm3aEKmZnDrS3G/ZgT2xXVZ
	 yFk63pdE3Ro6s8TgcpxrI+UNlDNb+jY0PBNyRQstJ1LI6JbHYlonYjNbJAh6xVa4Ovg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mR4ySzcM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HntzIXV9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452987;
	bh=IFVnXQo80f/oWKnjVQM3A8d/WKjvIMMVEN9hv3O2eEE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BOMASnq3CLzbndoBk47k182gvIDMzlw6m+UfOtkqIQx254L3IQIf/N045j1HMYpQM
	 p7D15Y27i67wyNxV7cXonBiNST5CSqWWlHwon2teCQNrVjszp12H4t+yEs2DND5u4/
	 HA+lEfczSe/h2QvoyCInjpX5j3ImThnryd5rJy36QoMS2IHHVKVwvjzNnDdgPo/w3O
	 2U7020jDylV72BiDhPUwX+Wv1+PNPKuB/dxnOSSQRT7H/SSsDEO7Jv8Wz87vr23Ozr
	 mGSzBdil/FAbPCyaNBgfyz0z05aOa6OEILjzlZ/RLqSiomIAxlGfUNKe1RVSnrWU1Z
	 RvZgP+D53gTgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C0AD8127A;
	Thu,  8 Oct 2026 09:49:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 83E322AA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 705B481226
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hG0JX27RNwFS for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4674C81218
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452973;
 b=DKiL8CXNH4DLZMbppVIH0cEj+bF/RhJTcukXJJlDo2/WpxSaoqa0GU6ToaefbvpJxWur
 mLm/lbw+q78k/C+L3RQFfFiDpDfOS7MF5nbliopvYD8OsipLEJ5maFhV4DhHzJ6v4RVvu
 DzR2Gi7iL/wwhI2EP3Vn2YNJLGxsurp5Qe6Efegv0mKAsaIkSUb0aZtytaUQKEMA8Sd4Y
 rQK4dnXeSUKgvRvoRnZoHa85bFux74HZ+4VNQhKhS/GxC/Y3v5ZJs5wQOpEgd8od8vLOK
 e6XtlVhazg/eaebBu/1e9auxQZew+TE+Q8N34wM2PsEq2AP1GWLUSlcQmZFFPyaWaqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452973;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=IFVnXQo80f/oWKnjVQM3A8d/WKjvIMMVEN9hv3O2eEE=;
 b=AFLZi5aTGL4EhGSLVG7dF6JYFEc5xCm8boWgsoNVJWxiU23c8Njbi656vQkhAEfMs9rV
 PzINETGInFOcANo/8qWvTYrrnM0QVKReK/tTeAqAA+cWt/69Hw4h2nitYJQQoIAD6K2fb
 ld3Jxpd59+35++UgTL8cyPpxbdO81yZMgn6QNFFehlqyiCNLupT9ci16dC7Dga7nWrrGa
 3/TzwBUC0tcSCwKNMCzH72Ia1cVfEdgdjuzU71g4Z+2w1BxhVxYQ4gvtYRMwT/inTtr3m
 qVnWQyo5pNYh5/4m6daFvfYpC/8NFBCOVhamuDizuix4sAfuR69NEtAT8buUS+ILL8A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mR4ySzcM; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HntzIXV9; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=mR4ySzcM; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HntzIXV9
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4674C81218
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:33 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987KNje3307923
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IFVnXQo80f/
 oWKnjVQM3A8d/WKjvIMMVEN9hv3O2eEE=; b=mR4ySzcMZsjGhR45KT7zODAPnf2
 YlD113l9J386WdYcTUSU/YJ69frLp9NGJZyjWU3x9A4VO0Hu9FlTdpfKlLGeBfYi
 1MboeO+8FbwaVE/t6TbiZzRbu1+JMp3GwSbY0DY9XWL8jL77wmTB5Tm13G0zDgQs
 Nwc5vJl3B8aQ6Dhjal2p3Se1DonIwF6rmZOCN3qNKntNJXZO67SdAUbSBb7cJaW8
 2cW2L2rPAqI68heIKFH/fk2xBkGjzM/sla52FIphiOWuKE5cpO8fMO1GaRKFWVp0
 3AuZ77ZDsYQ8UM7uUvLYPxlHGo4R6yI9DrDDG+p6FuWFBRM+Vw7te4wvk1w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h60sg9v1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:32 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1438fef603cso6788639c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452972; x=1792057772;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IFVnXQo80f/oWKnjVQM3A8d/WKjvIMMVEN9hv3O2eEE=;
 b=HntzIXV9p0pQ9QanBWlcUz/OuiWtt1C0fxFyq1IV4v91FATM6c8TwFGj4mPIxZ8eXs
 /YdJ7C0f08vZmExASiPyrNC8xoqOmlxbqVlgDJgDUN4EQDXMytzhPPxhxfK9G+JOS3PM
 voqh7bMTRjc2W9FXnQlIE/6/RJqUOzZA5kWS7IhUV58HuTM0s7rBn+1I+94FripwB77d
 2+JMn/Of7+/ByXZ0NFAkoa6fl0NKNb6pcjgDCqqdjvj4mrcV58xYNtunQbP1qWIRSlwv
 +ZssQaEE72BqDapHQdnW6bavGCKnmTESRaj9t/u1Hrs3cHUFilLELe9xfCk/5nsu72+G
 HsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452972; x=1792057772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IFVnXQo80f/oWKnjVQM3A8d/WKjvIMMVEN9hv3O2eEE=;
 b=g8CReecEg1ZxVaTT78Vk3bjMeHkk+qntrplC3aXHAP/Dh0kS4FLkGYnFHu3164gW1s
 bRUn7ZF0FESpLay10deunFAjjIO9VTXasSxjWNWjZoVliYHyxMMjKf9crkncIllfvruA
 PrxHNcCa6eIu4aQ/TySHPcP8dUlCnwkV/WqNBhf+qu/6O76YseuWvNYYcb7y7fA2U+N1
 mqG5iJr8xcIHRzXrDo525s07RCsuLp/UmQK0wUYL2YZkzX++DBVS4Yl4zDKIwo58zyRD
 mY6dU9umCQZVV5Q4Pj4xIqxCgWeyIvCyLuztCcPD+57FI9mmIzn3ZW+Dj/NjBITVFPzw
 nRQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw//OYyB94H4KpttYx7ZR+8WwX1CI9aS7zyrGTOhQRI89Bvr6566EDzl7N6eckTMoVTVdK2JuQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mCeTaZVA508CvJEbSBmMTPS2pwV/NJex8GhCZNb7C0gGhokHtu
 Gd4geMyiRcJ904qbWnSuAoHxI2UwvbFv8VduD4omOfZyAPdwCf2Jok4vwiwhnckxMi4OkqqXcX7
 uqTiIMajFv9rOuC+N2MXBgxY5ktGmaLezzA0SZ7Iygi6l/IVbEFcri8sgRefSuwwNskRcJ5I=
X-Gm-Gg: AYBFou37l7oxRaWFNuj1Bz3EcdXYjS6KF6YdOM0Xvad9YqM1BuJeloN7sQ04esaRhDc
 aiw8rmXySzejY4a+ybZupa5S7NJBoN+cRaAtlZT1ut60VxCQe1I0pyWp3K0/irB8dvJz3n3F9Hm
 X1Q+pshCiBJ/8hgVg/M8y5YJSH5a2cLEwu8wURYCFVfGut9NEWYlwRUS0MLEWKQ48XnJOfckRpV
 PBp25Zd26mCYYqxHhMKqNyCBRM19ey416njm2xY/fJgwFH8NbGU0Xonz+QOkn49pdxAFnaEtLjc
 NyptJ1vbBwYuK0gGsu8jh2n8YvJ8Fir1zVQgMBn1dUEyLpBkjv1MYZeQiRsMey1wlceyiYPVVSM
 nI5lkmpHh4YEZQ1h8rqGi0aCyqG+p9k+QYfHHRAVnP0kpR0M=
X-Received: by 2002:a05:701b:2619:b0:144:de98:eec1 with SMTP id
 a92af1059eb24-162058e7c34mr6778121c88.11.1791452971688; 
 Thu, 08 Oct 2026 02:49:31 -0700 (PDT)
X-Received: by 2002:a05:701b:2619:b0:144:de98:eec1 with SMTP id
 a92af1059eb24-162058e7c34mr6778076c88.11.1791452970902; 
 Thu, 08 Oct 2026 02:49:30 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:30 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 09/13] arm: qcom: enable MMU and cache setup for Shikra SPL
Date: Thu,  8 Oct 2026 02:49:08 -0700
Message-Id: <20261008094912.419090-10-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: r_QLYUDo_nq_dCxaKDiO7b1eN5811jCY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX8LQzyHJRp/TP
 oxXFDvMiePcOXe8lPXOS5aGpMSHb0ZZxR2MyXGL+ID/QIHw2aerXRV4YXdX1sULucJqJBpzvi4E
 4VATquv/ub/wERmUvS3bA6ZQqbKSbro=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX/rvCLT35+SVp
 fa4ev9wCNfWUUyiFyMucwQhG9vG+YRyKQVof4N+qndIUiunv8bN/zZc33wRAV/t03hyHJQSZc13
 gZGYz6sxBIjZoiIp6Fisqx5GZ0OKzjlyCpqY1Rhvdq39l594kYziEP0aIRoEIe2O4+VaWYUprBj
 6bcUq4aPhhLlmsFSUBzqpOccYDwsFowweeD/Uh8kLCta1C2/MImeA0M4S8yFiJVStpF0WblYZkX
 KURDADpZL9Pok6QWa+fyvxY+cjmmWbENWIRCZTRBiLqI4iST5ZMKmhG/VAfCHyqZB/g4kszBzA/
 Id2mjuTSF6HabejMZyRcyoDA14/o6Fzt0jQEj+vIA9clLsWA4zvI5Ahw5K7laSqgKY40w1ib2s0
 GigSi1lzf2Y5sve6ou/C6ARA+VFy/8KnpXuGGogla6sEn9yQiFLpNUs3Q5cUeZgLWH6TnC57fCt
 JWhOLOmmZQ7eFuZjzvw==
X-Authority-Analysis: v=2.4 cv=DfWCOftW c=1 sm=1 tr=0 ts=6ac7672c cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=md-n7zwCLhyBqDs_0qMA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: r_QLYUDo_nq_dCxaKDiO7b1eN5811jCY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080038
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

Use Shikra fixed pre-DDR memory map when enabling caches in
SPL. Allocate page tables from the early malloc-F heap and
select the board map through a common Qualcomm hook.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/mem_map.c   |  22 ++++-
 arch/arm/mach-snapdragon/qcom-priv.h |   4 +
 board/qualcomm/shikra/spl-shikra.c   | 140 +++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
index f64ec0c674e..9df522f7a4e 100644
--- a/arch/arm/mach-snapdragon/mem_map.c
+++ b/arch/arm/mach-snapdragon/mem_map.c
@@ -28,6 +28,19 @@ static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
 
+#if defined(CONFIG_SPL_BUILD)
+enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
+#endif
+
+/*
+ * SPL platforms whose pre-DRAM address map differs from the common Qualcomm
+ * map may override this hook.
+ */
+struct mm_region *__weak qcom_spl_mem_map(void)
+{
+	return NULL;
+}
+
 static void build_mem_map(void)
 {
 	int i, j;
@@ -65,10 +78,12 @@ static void build_mem_map(void)
 #endif
 }
 
+#if !defined(CONFIG_SPL_BUILD)
 u64 get_page_table_size(void)
 {
 	return SZ_1M;
 }
+#endif
 
 struct mem_resource_attrs {
 	fdt_addr_t start;
@@ -185,6 +200,7 @@ static void configure_reserved_memory(void)
  */
 void enable_caches(void)
 {
+	struct mm_region *spl_mem_map;
 	u64 tlb_addr = gd->arch.tlb_addr;
 	u64 tlb_size = gd->arch.tlb_size;
 	u64 pt_size;
@@ -192,7 +208,11 @@ void enable_caches(void)
 
 	gd->arch.tlb_fillptr = tlb_addr;
 
-	build_mem_map();
+	spl_mem_map = qcom_spl_mem_map();
+	if (spl_mem_map)
+		mem_map = spl_mem_map;
+	else
+		build_mem_map();
 
 	icache_enable();
 
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 27e5c54e512..c267c0d9aec 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -5,6 +5,8 @@
 
 #include <stdbool.h>
 
+struct mm_region;
+
 /**
  * enum qcom_boot_source - Track where we got loaded from.
  * Used for capsule update logic.
@@ -40,4 +42,6 @@ static inline void qcom_configure_capsule_updates(void) {}
 
 int qcom_parse_memory(const void *fdt, bool fdt_is_internal);
 
+struct mm_region *qcom_spl_mem_map(void);
+
 #endif /* __QCOM_PRIV_H__ */
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index 99bb670bdf5..9c7068497de 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -3,15 +3,107 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <blk.h>
+#include <cpu_func.h>
 #include <asm/io.h>
+#include <asm/sections.h>
+#include <asm/system.h>
+#include <asm/armv8/mmu.h>
 #include <dm/uclass.h>
+#include <init.h>
 #include <linux/err.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
+#include <malloc.h>
 #include <mach/qclib.h>
 #include <mach/spl.h>
 #include <part.h>
 #include <spl.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
+#if defined(CONFIG_SPL_BUILD)
+/*
+ * The SPL device tree does not describe the complete early physical layout,
+ * so use Shikra's fixed map when enabling the MMU.
+ */
+#define SHIKRA_SPL_DEVICE_REG_LOW_BASE		0x00000000UL
+#define SHIKRA_SPL_SYSTEM_IMEM_BASE		0x0c100000UL
+#define SHIKRA_SPL_SYSTEM_IMEM_SIZE		0x00020000UL
+#define SHIKRA_SPL_BOOTIMEM_BASE		0x0c200000UL
+#define SHIKRA_SPL_BOOTIMEM_SIZE		0x001c0000UL
+#define SHIKRA_SPL_DEVICE_REG_HIGH_BASE	(SHIKRA_SPL_BOOTIMEM_BASE + \
+						 SHIKRA_SPL_BOOTIMEM_SIZE)
+#define SHIKRA_SPL_DDR_BASE			0x80000000UL
+#define SHIKRA_SPL_DDR_SIZE			0x80000000UL
+#define SHIKRA_SPL_DDR2_BASE			0x880000000ULL
+#define SHIKRA_SPL_DDR2_SIZE			(SZ_32G - SZ_2G)
+#define SHIKRA_SPL_DEVICE_REG_LOW_SIZE		(SHIKRA_SPL_SYSTEM_IMEM_BASE - \
+						 SHIKRA_SPL_DEVICE_REG_LOW_BASE)
+#define SHIKRA_SPL_DEVICE_REG_HIGH_SIZE	(SHIKRA_SPL_DDR_BASE - \
+						 SHIKRA_SPL_DEVICE_REG_HIGH_BASE)
+
+static struct mm_region shikra_spl_mem_map[] = {
+	{
+		.virt = SHIKRA_SPL_DEVICE_REG_LOW_BASE,
+		.phys = SHIKRA_SPL_DEVICE_REG_LOW_BASE,
+		.size = SHIKRA_SPL_DEVICE_REG_LOW_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_SYSTEM_IMEM_BASE,
+		.phys = SHIKRA_SPL_SYSTEM_IMEM_BASE,
+		.size = SHIKRA_SPL_SYSTEM_IMEM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		/* SPL and QCLIB execute directly from BOOT_IMEM. */
+		.virt = SHIKRA_SPL_BOOTIMEM_BASE,
+		.phys = SHIKRA_SPL_BOOTIMEM_BASE,
+		.size = SHIKRA_SPL_BOOTIMEM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DEVICE_REG_HIGH_BASE,
+		.phys = SHIKRA_SPL_DEVICE_REG_HIGH_BASE,
+		.size = SHIKRA_SPL_DEVICE_REG_HIGH_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DDR_BASE,
+		.phys = SHIKRA_SPL_DDR_BASE,
+		.size = SHIKRA_SPL_DDR_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DDR2_BASE,
+		.phys = SHIKRA_SPL_DDR2_BASE,
+		.size = SHIKRA_SPL_DDR2_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		0,
+	}
+};
+
+struct mm_region *qcom_spl_mem_map(void)
+{
+	return shikra_spl_mem_map;
+}
+
+int arm_reserve_mmu(void)
+{
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	mem_map = qcom_spl_mem_map();
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	gd->arch.tlb_addr = (unsigned long)memalign(SZ_64K, gd->arch.tlb_size);
+	if (!gd->arch.tlb_addr)
+		return -ENOMEM;
+#endif
+
+	return 0;
+}
+#endif
+
 #define IPQ_SPL_BOOTCFG_REG_ADDR	0x1B46070
 #define IPQ_SPL_BOOTCFG_DEV_MASK	GENMASK(5, 1)
 #define IPQ_SPL_BOOTCFG_DEV_SHFT	0x1
@@ -55,6 +147,54 @@ enum {
 	IPQ_SPL_BOOTCFG_DEV_MAX
 };
 
+#if defined(CONFIG_SPL_BUILD)
+void board_init_f(ulong dummy)
+{
+	int ret = 0;
+
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	event_notify_null(EVT_LAST_STAGE_INIT);
+
+	preloader_console_init();
+
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	ret = arm_reserve_mmu();
+	if (ret) {
+		pr_debug("arm_reserve_mmu() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	enable_caches();
+#endif
+
+	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
+	if (ret) {
+		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = qcom_spl_invoke_qclib();
+	if (ret) {
+		pr_debug("qcom_spl_invoke_qclib() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	board_init_r(NULL, 0);
+
+fail:
+	if (ret)
+		reset_cpu();
+}
+#endif
 int qcom_spl_soc_qclib_override(struct interface_table *table,
 				const void *fit, int images_node)
 {
-- 
2.34.1

