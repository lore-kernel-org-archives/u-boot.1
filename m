Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DE0C88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 12:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 276A260631;
	Sat, 12 Sep 2026 12:36:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QlDy6pxKtv-J; Sat, 12 Sep 2026 12:36:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 407EA60614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789216601;
	b=R9nt6qCDh+jT1msgYAv4mwAWsASxdts3hcGecGf1y6c+X1eBF4ziNotqdG7rSKY5j51b
	 OWNRedQiGys7vkl1sHsFtJOZRUSURH4/PaWv1vHivOwDNIp4RZ5YMsNoZLisrheZY7RKC
	 iz6l9tzao/EHVyeayuLELH2oEoW6dqe9wnU9oyZwXdOVhtgqYfe8zcdsiExL/l5IqYmUr
	 Kl8avnagsaxONBslFwMTkebBF6CjOhBNjUuorCBIrZ0jr2dpNl1k1OCd1q8O5khW70evb
	 hVRKGAfDHEX4+SqmjfcAe9zp86ssoQ8BRNqY3qn0WFzLytx7nfEHWHWGwGWaeajxrUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789216601;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=P55InfkPBOkmdhJOQ5Eh9s+VHeX2GaF8wsw33urLQew=;
	b=I/amq7IVH+Sba4fAgsVy3Mylx04loRabqD/Cbxz7tI+Axm6PS+BC8CFXp6h2juULcpqr
	 dreRxHVBQpPiYZa+VJl2wBIPCUZeKmfiBezVZU0lH9T5o1ZLNa4LyDW124ZgOtFGamY6R
	 DEoEjQYPqpy6ysHm15Ph/bQVWbzQp3vzzXZx7LEuHSG+gLSHk06B6NJfz7cbmIvZ4G5PC
	 lcGZsiaymJ6NeF1QZq4vA5gtTX8ybsSxmSNoXVjwe1FQl4QAbJp9sCV1pLxxA2wnHhOaL
	 RigCNhn4S8Hxmykzn7v9861fAK8P32ndbkmtXSSvWrNJxTJfRqwd3VrSm4jtCBEorUw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789216601;
	bh=P55InfkPBOkmdhJOQ5Eh9s+VHeX2GaF8wsw33urLQew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zmPCtWF++uTuuJsXA3WruoSzv7vGwGnAH8Z1Te0UvWJoo1ESRfD32yMxT4UQSSjDz
	 H4n7vyipMM0yaQiCeyYfsOMrjssMVkSNRXsV0MSMfZro3dqOkHH0zV+L+HXM6q0mD2
	 BtlGvbogPFcRxaphpo+THMBEZsP3gnSRTcMYVBSYb9N0K42w4KFA0vZPdHDtSmfHOs
	 GIvEkwjktdJgcLY1LvmsrdaOeW5XYAm30TwDVJr2J82ev7HpGKc0xcPgmOCNxEqnuJ
	 MF9X8hrf4+NNqBiSLxIlbN4hLiqxB8b0yFM6heXd85kmARyCybgx76ecKDjBYJqih5
	 QUHhBJYx/MgMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 407EA60614;
	Sat, 12 Sep 2026 12:36:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 487BD701
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E22380E70
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9TeYI1GGaI9N for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D784F80E6F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789216598;
 b=XytPTLXD2B0dyBlcWDnRWo13NN4+b9S0Shq2sAYreuY0/UnJr34XVTdboixWCJ9Wapev
 5XRRXZQ/KcFMdLBfl+kx7zHRpivpPHglEhFIIZZlosQjgst0t/nlpVIN0UVa5Dr4aNKFk
 Vz+8JCYAbL4Pi6EkHVobmz9iG5dl13uz9+7x43kb1fo8Zvqwml9h/y8rDBckfXbgQPvlz
 wzFSMIAAYCSwy6aiuX+X+eHq1b06zzGKNt4CBMDS1hIL/JCKIYUdw31U/MaewFD/x0ovq
 4iXSObrRHtvho+h1cYcwQvSxBEWEbrrHm0TfxfoFIWNBeaUlZ7HUCcREJTT5fCGUTyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789216598;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=P55InfkPBOkmdhJOQ5Eh9s+VHeX2GaF8wsw33urLQew=;
 b=NPPEGJKod+yWpA6YhKboU6ZnnmZblffcj4xmBqVyWh9s3juy3dgVkg5rgQu94zdTAYE9
 G4x6I2oyY7w1GXWpROf6aVqc4rK5SOVleCcFILhuj0ez1t07hdjpm12qsMe0hz/ekcjkL
 gIQIWoqMMpPxAceRxD7t2DupiivJrh9pxCxb+4YlsQVGIQ/ZBQorNcwthwAKozFD4wz7R
 pKsr73XeTbkVOEVP9JWQclIJE19z4PAzazeEma2SWFCPo8thyjNNUsdFXd7bhlg6pJcDI
 EVHN58GJHBzKrCk9ug/OAexR6qEe16EvpDiva4Hx9n5nNOod+M5o/WktOHYUNhH0/Cg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=H4xa9iPb; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Cn+XIJZM; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=H4xa9iPb; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Cn+XIJZM
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D784F80E6F
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:36:37 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBdXg41707161
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P55InfkPBOkmdhJOQ5Eh9s+VHeX2GaF8wsw33urLQew=; b=H4xa9iPbEarwJO0+
 Cf9VyWIZNXqcjlhNgNqS+6mJzvwF8RaCylaptmY17VGLj2D9EgXwnlCVSmI2L5RY
 o8pqnbq959esxFOOaNmFDj/63/vzJvK7RxK/7yvkRBWRXe/5AkIfYNRKEgTVdzUa
 LsYVhqrCA9RPy/qAxuZhVrYYSH8UsNN330dj64xoQQoeHFiMpiA5uVUHkbwk7puD
 S6N+pmW/Z3EP3QNTc3nIOoANKilTaqvN1nXjv5Z4AuPWdCHKcBMPxnrkmUW6hyL0
 HHePoZB219aqtxZdq/cH0uwScAJyxxXE+zyZHmfQSUxx15rbuvbDoZjz+lx8dJ7t
 EmNEeQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmywh0ugs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:36:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d63bad3d09so30032655ad.3
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789216596; x=1789821396;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P55InfkPBOkmdhJOQ5Eh9s+VHeX2GaF8wsw33urLQew=;
 b=Cn+XIJZMXbgywDnS9fKltAJZbA7DXQMe3cHj26PZlFu1yXhwD+wQNQw7efpw3PpFkj
 ZjziA8r4kKzcg68Qvpl0W91Y1fltQov5ePa3F99gtA92Y/RFZ2pJZ+FZBK955EO580YI
 1eCM0M9TXVmgx9dAtkIXeZwBc5DhwuWhMtmbAhL4ZocBre1vhYLfIYLSQLRMP/7oBuCy
 1++v8NXHLhZtX9TY0kW9lYSh8QMkwsvcNALCxLiQQVQoG6GEiR+UHqLuMjl3hfVL2s5/
 zHhjn3VJZLD8S7T7R36PvmTT50t9iPfNUpiN1d7wULFyaJYD1Ubho2f25OZkU7Kxmrdo
 3J8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789216596; x=1789821396;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P55InfkPBOkmdhJOQ5Eh9s+VHeX2GaF8wsw33urLQew=;
 b=STpBi4sxydCIJ7wEW0vQKbazdu6ott5QsmlNwIRHF8ptdM1WG1GFiJ83xqTKtVNh4s
 43JTFaRpiqM2NLC1gG0mXA7UtaaDOB+3oeAdg9Mp6y1/6Y/bKwe8I0A5dczM6QnyQcbE
 Ou8GRjwNbVqlzt1qZAv/tlrXsNq596ybVr3dV4HAZPfz6y7j9kKcA+/4H5Y2TqvSgKHS
 lGoKl+Dtk1pO8kJq9NmokOl8JT/NLqRzSbCWmexQj9iFWq4tnD5JiEeBu5UtuOEES2F8
 UgZxkzy/q3HrwbrPOMHml6gcCCdCvquHiWMSSkaYcsV4L/t52HMO+Ldgj6H+1h8JFsPA
 IoWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdJ/zmbLYNFXEUfa++5ja4S9NSh4IIoTAn2GBQB423DrPI7BZTaX8VWl32TTDBELv8JZw9gX0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k0HqarCM/5s7Xpfdvw3+9tP7dNpAyAmAV4gICiFlYAy46OxhSZ
 I8ZyagYWLMgKLAdcIHU8W1r6W71Ozy+xlGadIoicgJ148m0QOy7LlC5xde7pCYHiaYj9B+k8FMb
 WghKqUEx/XYt7qBQnvK/4c5bizg+MY2J7ByF8fGo0L1suStB2fAs+T+krvvvrtGA7rOEmRXY=
X-Gm-Gg: AYBFou0ribAw2945Z3u4gkb7Ovu7+rPwYfAMYc2vO/NKj+qH66mxL4mlVJIAsr0bLvW
 CyTAsc1CIElTRzTw0pNA93qHGLeSkvaF5++GqH9W+kQrN6eKQuCiHP3Dh1U4JuqYvw+Dq+4rPlR
 YeOX+KmqxFjb9/8U5SDjoHoRYL9z2qsg6Apaz92ikeW/kdLkGWTE0NkUalJR3yapdpgYomtgMR1
 HlwNTyCN28nZKkOa/IqV5PNQ72/ZVf4hGXan0SWNsXuClniGpbTy+jwEMxSwinlUVaWo2+MFVTo
 wmQ24PNiXF/TCC9PJFUxcVJeCsNWLO6GVeyIqIP/sHzMJVC/wj4D/B+R2syNuZWH8C4/iOVCYVE
 FdaAg+B7po6eG0FkaiOZJfEbyyM98sfm5mETr
X-Received: by 2002:a17:90b:1a92:b0:398:ba0e:96f6 with SMTP id
 98e67ed59e1d1-39dbc6f0686mr4885533a91.23.1789216596219; 
 Sat, 12 Sep 2026 05:36:36 -0700 (PDT)
X-Received: by 2002:a17:90b:1a92:b0:398:ba0e:96f6 with SMTP id
 98e67ed59e1d1-39dbc6f0686mr4885467a91.23.1789216595751; 
 Sat, 12 Sep 2026 05:36:35 -0700 (PDT)
Received: from [192.168.0.5] ([49.206.97.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9a3casm13311560eec.12.2026.09.12.05.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 05:36:35 -0700 (PDT)
Message-ID: <e34d629a-214b-4ee7-b5b6-ee01372ea3ed@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 18:06:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: lmb: return -EFAULT for partial bank-boundary overlap
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>
References: <20260907-lmb-alloc-addr-efault-v1-1-7a5b73c2318c@oss.qualcomm.com>
 <6e0b7172-b3c5-455e-b00f-370d43083b2b@mailbox.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <6e0b7172-b3c5-455e-b00f-370d43083b2b@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BAo3kjARGt4lOVNoKJWaAKAfU8kBfyiJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4MSBTYWx0ZWRfX9jmOhkuCZKGU
 p7ZgwZYudkOTmWsRq3xcOMayld060LQbd1ahm33eqJJjfv6aKhx03/2q107R6Gc20o5OOiUoRHB
 GvZB/SRy1eXqBeUt9nrqRSiErVdUmU7u/KX+vsMxP/H5R7ZiogSLL0yrOed8DxDyxg+zSL6uq10
 BfKUSgqdWg+K68qOlxlD7R2iF85EILifGwlbhd0CmFLyFGRfzZxusCBVdkORlUSxm/Mu0xrAsQC
 09iyJ5VF5S2Mjab0Q+ddfh2zWYvb6cFK4lgbApYmkvf1a/AT4Sne5rz6R+A+ueJU8kkYNbhwDMO
 0w0RK43copOyH0f2TrWoL/BWVWSRomNBe5hX1rzffPdJw50zLOTfecZ2CSv5iHytGwfhgWjfggU
 UiiYeWytCg6QIph1EcgP0/q/pWQ4vGmww9E2VNeoRp0/KBiEzXbLFFGQDDa0NVoaBw1V9DWj22K
 zQCR1KEBf4322RidZ7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4MSBTYWx0ZWRfX2JUFkKJtym5W
 bsldz+uOGTrYYGfanfQvaHkbpjMrloHs527eM82ZWatvU8FkjCDhoaML93MR98nwrIliEJuSIJQ
 vGDgw7zVtwXsMUIYTq6W7rDjSRhKoGA=
X-Proofpoint-ORIG-GUID: BAo3kjARGt4lOVNoKJWaAKAfU8kBfyiJ
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6aa54754 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=1IKUSu+PbHJT5A3Gsa905w==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WCtdS4lb7JPxUEYmCZUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120181
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

Hi Marek,

On 9/7/2026 5:43 PM, Marek Vasut wrote:
> On 9/7/26 1:56 PM, Balaji Selvanathan wrote:
>> _lmb_alloc_addr() returns -EINVAL when a reservation overlaps an
>> available memory bank but does not fully fit inside it, and -EFAULT
>> when it does not overlap any bank at all.
>>
>> So for the partial-overlap case, it returns -EINVAL and
>> boot_fdt_handle_region() in boot/image-fdt.c prints "ERROR: reserving
>> fdt memory region failed" during boot which makes it sound like a
>> serious error.
> The commit message does not explain why do you think the overlap is 
> not a serious error, and why it could be ignored.

Understood. Have reworded the commit description to better explain. Pls 
find v2 here: 
https://lore.kernel.org/u-boot/20260912-lmb-alloc-addr-efault-v2-1-0a796adfd99d@oss.qualcomm.com/

Thanks,

Balaji

