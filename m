Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0355CA601F
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 18:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8519360661;
	Fri,  9 Oct 2026 18:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b5dOPSVET_jh; Fri,  9 Oct 2026 18:13:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8DBAD6066D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791569624;
	b=T3N98kb4yC/TptFrmh7uu2mHUmV3zjoOyU4mNsohRRM0Ek2/LyaAh2hwUmDqhd3RUdXR
	 lNLFqee/pN/G92OpRKcv/hBHBmvOHq6IJyqH9Json7l0Z96pG9uYKFgERobGqVlnb7cDf
	 tpUcd6t9E7YFVQ26yvilOv/oA/8dAXSvlNsfzBQzPIT7dJfWrn8Wmr4w8oCruExKuaoMl
	 LjzYoY5713vBoGd8o2zTz69G9FuabFkmOnxbPaBr4o15HbtTkH7AwRAcLrXgQj+zUb9iP
	 aGQpxo6UFFxt4ErX2dbl9QRuX/+JI0PrfERYaGWvzIYBbytqwqqzCvPpZvAvjrld/Cg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791569624;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sIT/iM1dRNgmjoZDbPaCyHAbutw3zGUnFZxsqnUJWC8=;
	b=OK3aQ6UtXHanGpcGwr0Hbkm9a2DRd+q+A/DzorC15lC9jz1VW6MGVqTYxyxisqRHh6aT
	 slYKzKDSxJDTV02hzfbT2Cyl1eAfUUCr0KzcT76rg7AAJ15CLWtAK/V3CyXAfKjW629eb
	 XDqSJ4zIjpj6R7eC3Rncdp93L/h75wZA3919vLIPxk8DnsWQvaC5MBYcC/H8ic+dnZ/xh
	 PBhxbxHR8b8SJtNH1GvXMj0LPQtgj0kiUBKHOXpf3MH09GKu2ePbZnHDQnsPRLMI/uAmc
	 QNdhyGC4rluM/pHuwFReBDTif/3X5KfZElOkaCYDzBSory0J+8Czbq8w0Mc1IaiW2eA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791569624;
	bh=sIT/iM1dRNgmjoZDbPaCyHAbutw3zGUnFZxsqnUJWC8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zpRmiC8gYYrGdM8g0HQiiKD1xjhE67G4m1xEQFO05VGZTzMruF100FmuQnYMljhz/
	 FMzO4YrqROAi56blixVjxwIk7YCjvbjUJFfa92mYWRZeR+sVljzyuz1c/Q0uFvCsdH
	 JPlAq2/ADNtbu5yZOyRHfpdbadRkRLxWCuHabkdOkfvj7Tf+R/Kj8GEcZvjbhwzS0d
	 Ykq4Q569inqSCb+UJCFKgj+9UVx8ySTgqq/WfpJcPICWs8TdEbHU8y/T2ngFPlWjLj
	 YR+8D+jqqul6pNskwgNBdPAfRBlgrDE+HC5prWt/EjHrIvon4KdDU2X7qbQ1aGvUKq
	 ywIayBAs48P0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DBAD6066D;
	Fri,  9 Oct 2026 18:13:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ABDC7380
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DB8540954
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r8W22KW_K_4Q for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 18:13:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C06340931
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791569621;
 b=Ss/DNkAy/vAG3wSyM4uEgUNCuX7Rk5r6E1xoSyrNAiGjJuf7t9DM/IKgycH+QbpKN9kk
 tKvF++0O8o7GeRYsux2bo4b2VxS/wZkKdsM/IAqgjEP1m1l93MKBI7a09XygYB5vhhuUg
 rWIRHXKH2XaIoNyUQxcYHQ+0y6+MjqZzubZqFHSmGwF76+Dy29w1O77AkLpLvRuV84RMP
 tmgSZqaYQtB2BAK9g9L1PSwsBZTsBBl6K4bwRJ6m2Q4pb7TzT45d9A0y48grg4LUqq+L1
 bNedeHG9yxCj37Z7ufljw1wAmQokWTz4T1XZaC9ZMsd+ffDhp/a7j26LKauW0QuSyHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791569621;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=sIT/iM1dRNgmjoZDbPaCyHAbutw3zGUnFZxsqnUJWC8=;
 b=hOlueYSpIf/Y0E7cbjQu6giOjBabPKDmq8jBbh6lr5pPuCEz6yUdPYO8cl66kU8ECYKo
 3QPjTuvBOYEs4So6UFwBoFx+DGqVrG8V6MfNdk2y1N/WuZ553cMFM4cAqL9/cbQyepKQf
 T/yR72zs1jrw87JNmf4eqAHAUJUta2ixyTLY6pLjoVRxvzPZ7Jo482gE/W8RwAIyi5SO+
 y9RIV9UtlkhveMxA5+IQglRZRwxnH0prXdNZKkgXkBnLIvNHHSLnDaQiBA1SVtySGDjF/
 L+0Vri5mFdFg0FXc/grSe/POJYeXB1wO/ihJJfCc85Xos9VlCVb4lXGP+WWkKnogRHw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="TIIy/2a8"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=P6HpqpHw; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=TIIy/2a8; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=P6HpqpHw
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C06340931
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:13:41 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZdAT2967896
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 18:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sIT/iM1dRNgmjoZDbPaCyHAbutw3zGUnFZxsqnUJWC8=; b=TIIy/2a8dnKoxSVp
 zjjQcPCZbg3Oblg6YRskYGB1NY5brRgXLcIKkVeDwzOwGDdkqlPkEM/YZEsvE00W
 5DYk7k/f+Z+s7f/LrQw7kunoFRe1M/mw06Wg7X7gwlRRDb9WpoqZNs2HVpl0mfkh
 1eh5zbfzarB3pt/jfiiDvp3uaQw0Gw4cr/CARs6nfpP1/g/y4UgY0uhqi5VJ+Ljl
 V9RiEjb6YG8lKr/px0nBraKK6hV/EBazGHQZYqTa4N3q+jtzB9H+5EHCVnCvJlKu
 Ym1Ax2ZLU0ftu7qWnAML2cQo006W1rWDchp05U+6aDXPGjsiD4DH/wMTdqOyuo6j
 bi5t5g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8g5kt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 18:13:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e86af936fdso1681465ad.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791569619; x=1792174419;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sIT/iM1dRNgmjoZDbPaCyHAbutw3zGUnFZxsqnUJWC8=;
 b=P6HpqpHwqKO6KKKfyQGW0PDNtH04r3IckfTqyQBEHcIJciVRfKuJJfVwtCwqrrME3z
 5GUDDyJP2o9mOUSeRaPxE+gofu0tIJI77+XHlMv/BdJjcF80xDANjaf3Ll3Oe6hSQlr+
 7lbRfLunBPwt5iG5XiLCcAjh6/rZFl0CLRTTj6/dsGknuIGvkfkdzwlNFGg7xY3nvsmN
 gOHByNSNueLS4uCFluzCaZVvlCIaTXJynA3DrVHiQ+ZBJCwIx4S+9v4ZRHYDZ3zszflL
 N/gUYlfdtS9lhsmMNG5+NIe4/+JrDLTkRlayKqvaz68y8m1sIK1EeLcWBvlRfdGq6jrZ
 67XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791569619; x=1792174419;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sIT/iM1dRNgmjoZDbPaCyHAbutw3zGUnFZxsqnUJWC8=;
 b=RbIAk3kZxvdordq8RSfp7W/PwA3j1r8xwkDeL4IzTvYBrp+h9HwfHtbNMz+hXgb8u8
 HEZcQClrpVz9rK+468zfvC6ubVW2xcZZO3gtqo08NisBf6hYNvhpVuZL4v8NO5BDYsDa
 JpQhLwDottYLqgwh0x7BeCK30l9//795Wj713cckbSNK7Yage41+SFb58J5zL+ynO5sY
 4wxg6UqHsC9Cjp9q1dZHfPFMo/ejA6BXd5xxLiBjw5ztJWAhTPwRVg0HJL+eMmM/O/1M
 tPagshIhSJhsSOiKnWOBNoqP6bGwoZoTG+bFQwg95ioWzlGo738dePb/SZWcPMKjiFfy
 7Tig==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLDMkUJEPjDj3j0H+Brz+j40LqwFVGtLB1rrQNnkaTRcixHtwp+gVgt8VhtrcDNboEgsHYACM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL5NUdwVRXUA7/xNKwdgucsmxuu/Ta+rO+d1bmq0RyqKE2bBgA9
 qDJVHG5DrrTVqlZAlV77GR8xBjBMxf7/CXJ4n1uYpWvFY2jxIm2RwTOxc+/65MA86gpBFNIGSsh
 psYV8/aHwExClrqKAdBB5liK6E8a6YrEJJ9TTsESiMw4I+fqR3ihKMIbU1L1RsPNCJmEPw1M=
X-Gm-Gg: AYBFou0JFzbKVQVWRxql7zw8K3g6KdiSoy9ybLK8f0iXBC8r8IayrolfBDw5LfTLpYB
 7/kKPOSPKBuByhHV7TmBKR+XxKtFTD5T8CYpRlWODcQ/q0yfU9w5cuBZpjtjaSJrnbwG08rFPhR
 KkT+UHX3PecDK73ryaNXkMjQoA1iNjTopmPPYf1YEnB+Yf9SA+MohjYqJcl6GwIOaQmlwb/2trj
 LdkJlZRnND/K4aIOs5dOqG/5nWfbrKCAMsWbxTdN2p4crhiRBpa2ixDgX+dyX7qWd21DgBBvzzI
 hN0AflCzvKvBC59Puy+Q4XNlZ++bUeDseTM1utuGSa3O3L6NViZ9wxOoUNwg3eRgzPhD/hh/6tG
 igG22ZdTZHP3bj0zb8LecYt33bMPfwM6b0FcZdOA3U4UwprP1w/qudEDFqe5/gy/cKpuivV/j+w
 ajkMOA57R9JtdZ95lB9g==
X-Received: by 2002:a17:903:19e3:b0:2df:5b4c:b0d2 with SMTP id
 d9443c01a7336-2e842ab6dc4mr22099505ad.43.1791569618742; 
 Fri, 09 Oct 2026 11:13:38 -0700 (PDT)
X-Received: by 2002:a17:903:19e3:b0:2df:5b4c:b0d2 with SMTP id
 d9443c01a7336-2e842ab6dc4mr22099225ad.43.1791569618108; 
 Fri, 09 Oct 2026 11:13:38 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e2aa4sm14599845ad.71.2026.10.09.11.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 11:13:37 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 alchark@flipper.net, lucienzx159@gmail.com, daniel@makrotopia.org,
 michal.simek@amd.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, Michael.Srba@seznam.cz, jbx6244@gmail.com,
 marcello.bauer@9elements.com, anshuld@ti.com,
 tan.siewert@9elements.com, james.hilliard1@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 1/7] misc: Add support for bit fields in NVMEM cells
Date: Fri,  9 Oct 2026 23:42:46 +0530
Message-Id: <20261009181252.2334254-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
References: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX5xacs2gJx9Nu
 f03vz9T99gZCDZojc09kgb5Dhg2mDA8YL9PwOSC3KGzXw0XPFmt9Am9N9X8za0EdnfagghMXYH1
 ur2f9M6T9ivX1RVdav8F3wReH7zVrnU=
X-Proofpoint-GUID: 1C8U-FjxtW07Tvd2KPe-w4gV534Mzw02
X-Proofpoint-ORIG-GUID: 1C8U-FjxtW07Tvd2KPe-w4gV534Mzw02
X-Authority-Analysis: v=2.4 cv=AMIlxa6n c=1 sm=1 tr=0 ts=6ac92ed3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=77Gp4gJqd9K2asR3UTEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX67ks9nJ/JbI7
 lxgfPLOGWoacAq7oJk55SbngpexXfkvkyvcFqgGnzptGFAflGO98slfjq82AZ8zb4P6Vlh+Ywim
 hAvzZtFo6BV2c5dztjBMwbec6VkAilgFGLqur2R2GMCq5Hy1EcZz9pOc5F8arRLLGQB49WT30Z3
 ecSNvCmXtWAc9sR6Q62URYOPylQNarREjxzfLiLStVaq07MbJX+0NfSkIeEk9DWcYJEKGovrF8/
 mMRlehja7TUXlIcGU147vvs6oR746H94i6qCeR8bhu61TiJJ+6295KnrNz6TDSMD1yM7NQQ3fXE
 bwuZr1MwsQifL14wVWWtD6LvQq7HEHNs4vuw3EGAbQyQelt3ACYL8y6NCJf39GXlDWO5NhB0Pr7
 DcbmqBwbwUVF6C1bQCgtCFUc/cWXUDYCsPYZgjpBEJ2jQxoETAz/7bfRgQmK+h8/58WsuFk0MVe
 8i9mM/7nf5jsH60X8Ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
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

NVMEM cells currently only support byte-level access. Many hardware
registers pack multiple fields into single bytes, requiring bit-level
granularity. For example, Qualcomm PMIC PON registers store a 7-bit
reboot reason field within a single byte, with bit 0 reserved for other
purposes.

Add support for the optional 'bits' property in NVMEM cell device tree
bindings. This property specifies <bit_offset num_bits> to define a bit
field within the cell's register space.

Implement bit‑field handling in the driver to max u32 size

Example device tree usage:
        reboot-reason@48 {
                reg = <0x48 0x01>;
                bits = <0x01 0x07>;  /* 7 bits starting at bit 1 */
        };

This reads bits [7:1] from the byte at offset 0x48, leaving bit 0
untouched during write operations.

Cells without the 'bits' property continue to work unchanged, ensuring
backward compatibility with existing device trees.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/misc/nvmem.c | 166 +++++++++++++++++++++++++++++++++++++------
 include/nvmem.h      |   4 ++
 2 files changed, 148 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
index 33e80858565..03538343a29 100644
--- a/drivers/misc/nvmem.c
+++ b/drivers/misc/nvmem.c
@@ -12,55 +12,163 @@
 #include <dm/ofnode.h>
 #include <dm/read.h>
 #include <dm/uclass.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <asm/byteorder.h>
 
-int nvmem_cell_read(struct nvmem_cell *cell, void *buf, size_t size)
+/* Maximum supported NVMEM cell size */
+#define MAX_NVMEM_CELL_SIZE sizeof(u32)  /* 4 bytes */
+
+/**
+ * nvmem_cell_read_raw() - Read raw bytes from NVMEM cell without bit field extraction
+ * @cell: NVMEM cell to read from
+ * @buf: Buffer to store read data
+ * @size: Size of buffer
+ *
+ * This is an internal helper that reads raw bytes from hardware without applying
+ * bit field extraction. Used by both nvmem_cell_read() and nvmem_cell_write().
+ * Caller must validate buffer size before calling this function.
+ *
+ * Return: Number of bytes read on success, negative error code on failure
+ */
+static int nvmem_cell_read_raw(struct nvmem_cell *cell, void *buf, size_t size)
 {
-	dev_dbg(cell->nvmem, "%s: off=%u size=%zu\n", __func__, cell->offset, size);
-	if (size != cell->size)
-		return -EINVAL;
+	int ret;
+
+	memset(buf, 0, size);
 
 	switch (cell->nvmem->driver->id) {
 	case UCLASS_I2C_EEPROM:
-		return i2c_eeprom_read(cell->nvmem, cell->offset, buf, size);
-	case UCLASS_MISC: {
-		int ret = misc_read(cell->nvmem, cell->offset, buf, size);
-
+		ret = i2c_eeprom_read(cell->nvmem, cell->offset, buf, cell->size);
+		break;
+	case UCLASS_MISC:
+		ret = misc_read(cell->nvmem, cell->offset, buf, cell->size);
 		if (ret < 0)
 			return ret;
-		if (ret != size)
+		if (ret != cell->size)
 			return -EIO;
-		return 0;
-	}
+		ret = 0;
+		break;
 	case UCLASS_RTC:
-		return dm_rtc_read(cell->nvmem, cell->offset, buf, size);
+		ret = dm_rtc_read(cell->nvmem, cell->offset, buf, cell->size);
+		break;
 	default:
 		return -ENOSYS;
 	}
+
+	if (ret)
+		return ret;
+
+	return cell->size;
+}
+
+int nvmem_cell_read(struct nvmem_cell *cell, void *buf, size_t size)
+{
+	int ret, bytes_needed;
+	u32 value;
+
+	dev_dbg(cell->nvmem, "%s: off=%u size=%zu\n", __func__, cell->offset, size);
+
+	if (cell->nbits) {
+		if (size != MAX_NVMEM_CELL_SIZE) {
+			dev_dbg(cell->nvmem, "bit field requires buffer size %zu, got %zu\n",
+				MAX_NVMEM_CELL_SIZE, size);
+			return -EINVAL;
+		}
+
+		bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, BITS_PER_BYTE);
+		if (bytes_needed > cell->size || bytes_needed > MAX_NVMEM_CELL_SIZE) {
+			dev_dbg(cell->nvmem, "bit field requires %d bytes, cell size %zu\n",
+				bytes_needed, cell->size);
+			return -EINVAL;
+		}
+	} else {
+		if (size != cell->size) {
+			dev_dbg(cell->nvmem, "buffer size %zu must match cell size %zu\n",
+				size, cell->size);
+			return -EINVAL;
+		}
+	}
+
+	ret = nvmem_cell_read_raw(cell, buf, size);
+	if (ret < 0)
+		return ret;
+
+	if (cell->nbits) {
+		value = le32_to_cpu(*((__le32 *)buf));
+		value >>= cell->bit_offset;
+		value &= GENMASK(cell->nbits - 1, 0);
+		*(u32 *)buf = value;
+	}
+
+	return 0;
 }
 
 int nvmem_cell_write(struct nvmem_cell *cell, const void *buf, size_t size)
 {
+	int ret, bytes_needed;
+	u32 current, value, mask;
+
 	dev_dbg(cell->nvmem, "%s: off=%u size=%zu\n", __func__, cell->offset, size);
-	if (size != cell->size)
-		return -EINVAL;
+
+	if (cell->nbits) {
+		if (size != MAX_NVMEM_CELL_SIZE) {
+			dev_dbg(cell->nvmem, "bit field requires buffer size %zu, got %zu\n",
+				MAX_NVMEM_CELL_SIZE, size);
+			return -EINVAL;
+		}
+
+		bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, BITS_PER_BYTE);
+		if (bytes_needed > cell->size || bytes_needed > MAX_NVMEM_CELL_SIZE) {
+			dev_dbg(cell->nvmem, "bit field requires %d bytes, cell size %zu\n",
+				bytes_needed, cell->size);
+			return -EINVAL;
+		}
+
+		ret = nvmem_cell_read_raw(cell, &current, sizeof(current));
+		if (ret < 0)
+			return ret;
+
+		current = le32_to_cpu(*((__le32 *)&current));
+		value = *(const u32 *)buf;
+		value &= GENMASK(cell->nbits - 1, 0);
+		value <<= cell->bit_offset;
+
+		mask = GENMASK(cell->nbits - 1, 0) << cell->bit_offset;
+
+		current = (current & ~mask) | value;
+		buf = &current;
+	} else {
+		if (size != cell->size) {
+			dev_dbg(cell->nvmem, "buffer size %zu must match cell size %zu\n",
+				size, cell->size);
+			return -EINVAL;
+		}
+	}
 
 	switch (cell->nvmem->driver->id) {
 	case UCLASS_I2C_EEPROM:
-		return i2c_eeprom_write(cell->nvmem, cell->offset, buf, size);
-	case UCLASS_MISC: {
-		int ret = misc_write(cell->nvmem, cell->offset, buf, size);
-
+		ret = i2c_eeprom_write(cell->nvmem, cell->offset, buf, cell->size);
+		break;
+	case UCLASS_MISC:
+		ret = misc_write(cell->nvmem, cell->offset, buf, cell->size);
 		if (ret < 0)
 			return ret;
-		if (ret != size)
+		if (ret != cell->size)
 			return -EIO;
-		return 0;
-	}
+		ret = 0;
+		break;
 	case UCLASS_RTC:
-		return dm_rtc_write(cell->nvmem, cell->offset, buf, size);
+		ret = dm_rtc_write(cell->nvmem, cell->offset, buf, cell->size);
+		break;
 	default:
 		return -ENOSYS;
 	}
+
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 /**
@@ -128,6 +236,20 @@ int nvmem_cell_get_by_index(struct udevice *dev, int index,
 
 	cell->offset = offset;
 	cell->size = size;
+
+	ret = ofnode_read_u32_index(args.node, "bits", 0, &cell->bit_offset);
+	if (ret) {
+		cell->bit_offset = 0;
+		cell->nbits = 0;
+	} else {
+		ret = ofnode_read_u32_index(args.node, "bits", 1, &cell->nbits);
+		if (ret)
+			return -EINVAL;
+
+		if (cell->bit_offset + cell->nbits > cell->size * 8)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/include/nvmem.h b/include/nvmem.h
index e6a8a98828b..dd82122f16f 100644
--- a/include/nvmem.h
+++ b/include/nvmem.h
@@ -26,11 +26,15 @@
  * @nvmem: The backing storage device
  * @offset: The offset of the cell from the start of @nvmem
  * @size: The size of the cell, in bytes
+ * @bit_offset: Bit offset within the cell (0 for byte-level access)
+ * @nbits: Number of bits to use (0 for byte-level access)
  */
 struct nvmem_cell {
 	struct udevice *nvmem;
 	unsigned int offset;
 	size_t size;
+	unsigned int bit_offset;
+	unsigned int nbits;
 };
 
 struct udevice;
-- 
2.34.1

