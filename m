Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC2AC982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13366810CC;
	Thu, 17 Sep 2026 17:01:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b09jz5DsVyXI; Thu, 17 Sep 2026 17:01:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 198D58108B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789664485;
	b=PVqoGODntyiKjB5YXVVLnyWTRs1u9rU+X9F/gQmtTKnz58ZglVsqBCwOGbPcXrEBGCLU
	 NZyNOxtpbt3zEhJcx4OWd41biVbQlM3HUppga+FDiVMH/FOTgXSuioLEHRAUd7tiTfknW
	 jOXP9p8FhqkxIev3zfwyOQ2ZennXhe28EPD3+K7GXh7tzzVZKflr+fhzaPP0Ho4HGTm0M
	 L6liPrtVY19UMecDDSlbz///apo2xaw0t2dzlviXXreH+qyAC6Ix6rSlrq83MezE8L62c
	 DKjKVuDMREyXnHwFFshqjuOco7btl8ixVPLwunh79hOrLP9QJnu+V2BHfuswQsOamsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789664485;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Pa/5P9BHjDc9snflhbHjOdC7f7tAFEUmkS2kthH83D0=;
	b=sERObX4LFuVxEZLbysIfHmk+4wjnR5IsLTqnysN9IDg5fYdMXQjAEK73HKL4yapw8u3+
	 RKT3Whp012kKjNakxOAHCz5ZdTxbeu2lIK6mKV6trn8ZhvqmUCoSXyT3NNBID7ru6fWvI
	 0/YbaIbfdG1CBo7JZdngBcwhIMQSKjWgVtGPHY89HAV/BIcBYTmpaGfLtqrXUOSYJyFNg
	 bL9kH2Ivhmh1C1Avw8FEyWzB6HCkhpb8FqWSGkrlpupXGPfxJatuHik0Rt0mTpWHqQpNh
	 IeaB3R09pv9maCC6gUdWdWvXWnfnf6y6dhSd3SzzWQxBHkA8XJWfHFTs55n6D2vSfhg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789664485;
	bh=Pa/5P9BHjDc9snflhbHjOdC7f7tAFEUmkS2kthH83D0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ygk3I8HqnYo0hlVbyvj//7ZvSwGHmZp8R95yWrbMmqi77fp7Xul0KYtRdXCQtfxpr
	 o0y5KHhaILXkJQCWI/w/yWcAJAuMsm32jXZ19PVCSaTs1C8VN+Fpc6jCP6ZEIdthcV
	 /KtN7+lU/OMcksVfl/4+kLu/R4QHhjar+33jzReP2dVE7weATU6hcArr6r80lGUJcX
	 vN4vToQEypsF2sBSRDyUxifqK+wpq+DHR9CvIDjxvCI2eRefKfkoscHsdHYyVCxT4/
	 aZXugSYrRPi0yvTNcdSqRqsnEI8Pf7yF/hweNPeaJLmYWsEry9FcOBQ68+F+Hyx8cd
	 aahDanrTyzmPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 198D58108B;
	Thu, 17 Sep 2026 17:01:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DDC513AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CFBBF403B1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yw-XhSQ_DOZ3 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:01:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 491FC40406
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789664481;
 b=HBJA4a3zXLcfmfXrI/dqm1vMvDjY8j5Mael88SIc5+EA+PRqiCFXcbYjqzhtD7Gs0D3g
 aE5wXav14WKFdTPTRfnxRvSzhIDRb7E6fPSVQLVfdLLJk7oROM5daFmsWaXb3a91//tAK
 RMcyqQk3CdEmJElR2vhgALTaW4qMwnJVjdmp6KVrXcuxdmzXSW6ZUxPm4Ti8sA+y20Hrx
 DDUfXb5y8yTZ+SuWyaIceVuRR/o41vX91DTy9AhupGMwfi0bIwAZoO3OqGzwspzKoBLB6
 IDZdwpWb8+8TYzjtPMflD/KHH6TNYh6yQgtuRbgF4uFC8NwPDwUZvphzRHxW58VQP6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789664481;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Pa/5P9BHjDc9snflhbHjOdC7f7tAFEUmkS2kthH83D0=;
 b=ly+R890woafFadJlbbMKQ/YH2uTl7tou7KbAaqdXAiZ0ZTdaxUfEv69ZkFDNNzuQteTT
 yYolXRKaG8sEybrCwK/wtd/fwd2kC7JDIBug61RTkGCu2xU/cnR9EwhDiL2qP3fw8mOcs
 aP6gu6NHe/2MzaD1EMHtqvwzxFjl1HX8bs+rKEVNvbO6dk7u9AZRoT+3zOm9/x74Pgra2
 hQOUoUKxge7RFSKWIizt2FbJMALcujgKBQxQCCnGLRDAawnxJXlmjaTobzy6SV84xVXGS
 kkQ45Z0P4ya8Lqq/F7o6kgl58hM/G6Wy18XMxr5iQRgFLL8+468jJgL3B0N1WQLgsZQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Yy8YHp12; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eAX3F7Wt; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Yy8YHp12; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eAX3F7Wt
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 491FC40406
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:01:20 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HDiRAf2086477
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pa/5P9BHjDc9snflhbHjOdC7f7tAFEUmkS2kthH83D0=; b=Yy8YHp12iMFUhdGr
 keEBGefTcWy+XNbzg637XgASMRfWj6mYjSRJx1y26yE27i4kfo1oFFnhH8IG0i5c
 063qwelfIU9MDuSQQqceD1O+LfFRmeTPAry4jDp5tY3yDvPQiiaav0iONlSMEbkn
 If3juJwaABoxvt75riUg7LE1mtZkb2csFjKtI7USqzImdumyY/iIeJAaYkJ4ckfp
 JlzuG6pTjEDnPE8yu5ov9dQPu0La2mwCNAh04emUk5t5yi50xavqLX2bB8FKVlKo
 EaKJtjq9xRaCXHmLbcTPorLkH7li5PHAsTBCDYwc4PBW73e/YDkf925gSF7EnZsN
 5X9Dmw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grfu41g4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:01:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc489e7a701so1557728a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789664474; x=1790269274;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Pa/5P9BHjDc9snflhbHjOdC7f7tAFEUmkS2kthH83D0=;
 b=eAX3F7WtXKqO8HKqDSlUq4BWq8d8YW/sHLOJ3OKf1gZIeBZkfH74ggXyGPvw1jPdA+
 7EPyND7vWc3EJpKhhHGp5FaaV+J4wWqKuE7RkvZtDFzYXfLcnZ/i3qcmtbxnl2cj/tbI
 BelCP1MkW35/bTXhfqU1ctUiR+PiKLPB5/rr9TAACcxw3s+69n41KmSKvhuTM/Ne2y/f
 BIbrvs8zMexKFMWPmN5CTUTcVPt02LqrgV1GZIk918MI1wY19gbqn1wCIwd9xdZECF4d
 7UMMOBQPFAF3iwh8dRt51AcFPgMM430yJqMd2kGetPPHWKLZkNCGtlKUO7jtFHnUnD5c
 0CdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664474; x=1790269274;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pa/5P9BHjDc9snflhbHjOdC7f7tAFEUmkS2kthH83D0=;
 b=m5k9TfMy8x+U2DUZCo7w352q7g6k+3idw8p6oMhPmXh2FjY9qfFN0Bj2PhBdVlv5Wh
 UXd0sFM7SaHv06GXCdgllFotP4J22lNvY9GlPv2gUOeyquQ7UZL3nJ2t0kq89clDZZZo
 lsDfmtdFiHTNiwrPMeAgQ2eL3mcqo5t+pShEyAUbptR1Zs4JfXAncoHL7J85NLdJ5/0s
 CDkN13zngGXl1jlROnbq0WwcrtOxRwdJ9u9KjdaH0UkmBJuFZ+QKzuiTMAgjftvycj2g
 rhwpV1qy+bsA8N2+R7xldPxY0SsFchowrOD1IjCjJoYJtx6dWodfcbRKFjyD5KvuQ5hV
 t17w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4x9d37hWVjjPL9++5RgA9kdSshQ8FHDAKAyobXc24gkpgrtxwzHETzxlmf0R7YpjbC/8h9eg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kQ3fUVBXIC7OMLcwGDth6hmwCDgSFRpToozjjpXZz2zgRd0w6X
 xRR2xjQHSvKlX2FtP4Y1wgrsBF9dtv9vpC3Rj2iG55XRy0dmqEiihF+ghnDrVrQRAyCI3PixUUg
 oWmBHZYAhlM3ciMae2ghDA0GsM4tr8LWTYYiUIH9BIPrdWdEAMmOouCTlLTfS6vW0RuUmqKpwwU
 qw/TU=
X-Gm-Gg: AYBFou1CHuR9oU2nfDeEDi2f9iwUESvE/zYsWKR8iqXWanoCLEl/5XOl8ypj9j9qw99
 YURrzbYuwdGdWL9vkiNIPTH+XXVPhTJmjy1Mt/R0Q0f3n1ktbpZr0qgSz7wV1ozrQiMWfFPaIsV
 1zmNir/VHyjsNAUXCMu6BBc99/YOHnjTEpW1wLAymnUHakH/T6tblsmpujooajfDYiTtQ+cDZ+h
 4qDo2Udj/6Ppw8zKHLWgNojVu4394OpVRleOQ42ESZR5Bvmh6iEYimjY93Z5aejNEgRhxtUNg1X
 biKt1Kdyt2KGqXERu9JHGHzgQ7nhAJYQbrqV5f50hmrnqcp3vxB1JOwcCp2P+W7Oq12K+Kwr0Hf
 WpDOdJf7KqDL+uWEXBE0p1rOYNFQ4dTnukyUIWOAaHRfjNtJA
X-Received: by 2002:a05:6a21:1805:b0:3dd:85a8:cb81 with SMTP id
 adf61e73a8af0-3dd85a8d015mr2070616637.36.1789664474117; 
 Thu, 17 Sep 2026 10:01:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:1805:b0:3dd:85a8:cb81 with SMTP id
 adf61e73a8af0-3dd85a8d015mr2070548637.36.1789664473522; 
 Thu, 17 Sep 2026 10:01:13 -0700 (PDT)
Received: from [192.168.1.2] ([106.219.183.89])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af6593sm16076026eec.25.2026.09.17.10.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 10:01:12 -0700 (PDT)
Message-ID: <009abac6-415f-4848-a41c-d8c79f7bcb6b@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 22:31:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastboot: block: add 'oem set-block-target' command and
 runtime override
To: Guillaume La Roque <glaroque@baylibre.com>,
 u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260917-series2-fastboot-block-target-v1-1-fc8328bc2d12@oss.qualcomm.com>
 <487435d1-9d9d-4e18-a2a6-ed631760fc25@baylibre.com>
Content-Language: en-US
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
In-Reply-To: <487435d1-9d9d-4e18-a2a6-ed631760fc25@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PB9mNIInl1KMiTA3-QZBtKwNmYTxYxd6
X-Proofpoint-ORIG-GUID: PB9mNIInl1KMiTA3-QZBtKwNmYTxYxd6
X-Authority-Analysis: v=2.4 cv=LbipeTfi c=1 sm=1 tr=0 ts=6aac1cdb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=0Aw5K/wcCdqPyoy4oKtDDg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1VxDqnHFAAAA:8 a=k-42gJp3AAAA:8
 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=a_U1oVfrAAAA:8 a=p-LfKV-GAAAA:8
 a=kC5fe5xK8fLfOA5QRTkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=aZ5uHUMKh6B-zo3GvD48:22 a=uCSXFHLys93vLW5PjgO_:22
 a=cvBusfyB2V15izCimMoJ:22 a=97BuGM4RKn6GwmfqMd6i:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0MiBTYWx0ZWRfXwYpGqVW8nCXd
 +Bln6PXjzvhPiyedG50R/VAlvqNH5dkHK5T3fKTxFTiLu9r0Hh3BXHUVKUnEzqYAucyn4O70kid
 r9uKT7B2jaVq2v8VuGH8oFKb0MeMTp0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0MiBTYWx0ZWRfX8rW8XIX5hOxv
 h49AfI7frgg41KBBih0s95kW5nRDzfL0yoylw8epgEptP28VFpGswLQZ0SAAmoqCoRQmttBT4zB
 yZc4IkblN781QNZ0qSLhr9Lqg3Nprt9EgbjGEEO/wT4Eiux/8oUY2vIBlJvXWOZlGCusTKIQFWj
 gtBFRiQ+GFbAlwm2ic53kzUWzXjaLNyr12gGyD9D+cklyGg0EofhrKyCEUSos5WAEbX8Qq8L7bY
 eh7mc68llJHKORWE+gCUDi09M7sOFHYZW5DWJd1NH+wX9xCs3Su/ymkP/aJ/HKx997Y4n9ZEeER
 qmTJQVshklKDcej6nKLAG2Iqbq4ST/6XAcP8fOKLPcfRWdRE7VbJjOkEUwefTP7I0FSmJr8FILP
 /OSgM0YodjcKIi3S3JJL3BjXcxxyYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609170242
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

Hi Guillaume,

On 9/17/2026 5:59 PM, Guillaume La Roque wrote:
> Hi,
>
> Probably a stupid question but in your commit message you speak about 
> SPI-NOR  but fastboot support flash spi , why not enable it or update 
> it if it's not exactly work as you want instead of create a new command ? 

This patch is not intended to add SPI-NOR support itself. I have a 
separate change that exposes SPI-NOR through the MTD Fastboot backend.

The purpose of this patch is to allow switching the generic block 
Fastboot backend between different storage interfaces at runtime. On 
some platforms multiple Fastboot-capable storage devices can coexist, 
for example a default SCSI/UFS device and an SPI-NOR device exposed 
through the MTD block uclass.

Today the block backend is selected through the build-time
CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME and
CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID settings, so only a single target
can be accessed during a Fastboot session. The OEM command allows
changing the active interface/device at runtime and accessing either
storage device without rebuilding or restarting Fastboot.

SPI-NOR was mentioned only as an example use case for a runtime-selected
target rather than as a replacement for existing Fastboot SPI/MTD
support.

Thanks,
Vandhiadevan
``

>
> Thanks
> Guillaume
>
> Le 17/09/2026 à 11:01, Vandhiadevan Karunamoorthy a écrit :
>> Add fastboot_block_set_target() so an OEM command can point the
>> generic block fastboot backend at a different interface/device at
>> runtime, without requiring a rebuild. Falls back to the existing
>> build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME/
>> CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults when no override is
>> set.
>>
>> Expose this to fastboot clients via a new "oem set-block-target
>> <interface> [device]" command, gated behind
>> CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET (depends on
>> CONFIG_FASTBOOT_FLASH_BLOCK).
>>
>> This is needed to target storage devices, such as SPI-NOR exposed
>> through the MTD block uclass, that aren't known until runtime or
>> that coexist with another default block interface on the same
>> board.
>>
>> To: u-boot@lists.u-boot-project.org
>> To: u-boot@lists.denx.de
>> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Dmitrii Merkurev <dimorinny@google.com>
>> Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
>> Cc: Heiko Schocher <hs@nabladev.com>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> Signed-off-by: Vandhiadevan Karunamoorthy 
>> <vandhiadevan.karunamoorthy@oss.qualcomm.com>
>> ---
>> This series lets a fastboot client redirect the generic block
>> fastboot backend (CONFIG_FASTBOOT_FLASH_BLOCK) to a different
>> interface/device at runtime, instead of being fixed to the
>> build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
>> CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults.
>>
>> This is useful for storage devices that aren't known until runtime,
>> or that coexist with another default block interface on the same
>> board -- for example, SPI-NOR exposed through the MTD block uclass
>> (see the companion "mtd: spi: Expose SPI-NOR as a GPT-capable MTD
>> block device" series).
>>
>> The patch adds fastboot_block_set_target() to the generic block
>> backend, plus a new "oem set-block-target <interface> [device]"
>> fastboot command (gated behind
>> CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET, which depends on
>> CONFIG_FASTBOOT_FLASH_BLOCK) that lets a client invoke it.
>> ---
>> Depends on: [PATCH v6 0/8] arm: snapdragon: Add snagboot support for 
>> Lemans-EVK
>> Link: 
>> https://lore.kernel.org/u-boot/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com/
>> Depends on: [PATCH v2 0/4] fastboot: block: Add GPT/MBR and device 
>> selection
>> Link: 
>> https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/
>> ---
>>   drivers/fastboot/Kconfig      | 11 +++++++
>>   drivers/fastboot/fb_block.c   | 75 
>> ++++++++++++++++++++++++++++++++++++-------
>>   drivers/fastboot/fb_command.c | 51 +++++++++++++++++++++++++++++
>>   include/fastboot.h            |  1 +
>>   include/fb_block.h            |  9 ++++++
>>   5 files changed, 136 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> index a4539844d89..c7e0509eaad 100644
>> --- a/drivers/fastboot/Kconfig
>> +++ b/drivers/fastboot/Kconfig
>> @@ -225,6 +225,17 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>>         Device identifiers are numbered starting from 0 and the most
>>         common case is to use the first controller on the system.
>>   +config FASTBOOT_CMD_OEM_SET_BLOCK_TARGET
>> +    bool "Enable the 'oem set-block-target' command"
>> +    depends on FASTBOOT_FLASH_BLOCK
>> +    help
>> +      Add support for the "oem set-block-target" command from a client.
>> +      This allows switching the block interface (e.g. scsi, mtd) and
>> +      device number used by the fastboot "flash"/"erase" commands at
>> +      runtime, instead of relying solely on the
>> +      CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
>> +      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID build-time defaults.
>> +
>>   config FASTBOOT_GPT_NAME
>>       string "Target name for updating GPT"
>>       depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && 
>> EFI_PARTITION
>> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
>> index a8c74e35d0d..d3e5f6ed1f3 100644
>> --- a/drivers/fastboot/fb_block.c
>> +++ b/drivers/fastboot/fb_block.c
>> @@ -125,6 +125,66 @@ static lbaint_t fb_block_sparse_reserve(struct 
>> sparse_storage *info,
>>       return blkcnt;
>>   }
>>   +/**
>> + * block_interface_override - runtime-set block interface name, 
>> empty if unset
>> + */
>> +static char block_interface_override[16];
>> +/**
>> + * block_device_override - runtime-set block device number, -1 if unset
>> + */
>> +static int block_device_override = -1;
>> +
>> +/**
>> + * fb_block_interface() - Resolve the block interface name to use
>> + *
>> + * Returns the runtime override set via fastboot_block_set_target() 
>> if one
>> + * is active, otherwise falls back to the build-time config default.
>> + */
>> +static const char *fb_block_interface(void)
>> +{
>> +    if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
>> +        return NULL;
>> +
>> +    if (block_interface_override[0])
>> +        return block_interface_override;
>> +
>> +    return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>> +                  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, NULL);
>> +}
>> +
>> +/**
>> + * fb_block_device() - Resolve the block device number to use
>> + *
>> + * Returns the runtime override set via fastboot_block_set_target() 
>> if one
>> + * is active, otherwise falls back to the build-time config default.
>> + */
>> +static int fb_block_device(void)
>> +{
>> +    if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
>> +        return -1;
>> +
>> +    if (block_device_override >= 0)
>> +        return block_device_override;
>> +
>> +    return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>> +                  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
>> +}
>> +
>> +int fastboot_block_set_target(const char *interface, int device)
>> +{
>> +    if (interface) {
>> +        if (strlen(interface) >= sizeof(block_interface_override))
>> +            return -EINVAL;
>> +        strlcpy(block_interface_override, interface,
>> +            sizeof(block_interface_override));
>> +    }
>> +
>> +    if (device >= 0)
>> +        block_device_override = device;
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * parse_device_partition() - Parse and validate device:partition 
>> format
>>    * @part_name: Input string in format "N:partition" or "partition"
>> @@ -140,8 +200,7 @@ static int parse_device_partition(const char 
>> *part_name, int *device,
>>   {
>>       const char *colon_pos;
>>   -    *device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>> -                     CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
>> +    *device = fb_block_device();
>>         /* Check for colon in partition name */
>>       colon_pos = strchr(part_name, ':');
>> @@ -190,9 +249,7 @@ int fastboot_block_get_part_info(const char 
>> *part_name,
>>                    char *response)
>>   {
>>       int ret;
>> -    const char *interface = 
>> config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>> - CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
>> -                           NULL);
>> +    const char *interface = fb_block_interface();
>>       int device;
>>       const char *partition_name;
>>   @@ -385,9 +442,7 @@ void fastboot_block_flash_write(const char 
>> *part_name, void *download_buffer,
>>   #if CONFIG_IS_ENABLED(EFI_PARTITION)
>>       if (is_partition_table_name(part_name, 
>> CONFIG_FASTBOOT_GPT_NAME)) {
>>           int device;
>> -        const char *interface = 
>> config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>> - CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
>> -                               NULL);
>> +        const char *interface = fb_block_interface();
>>             parse_device_partition(part_name, &device, NULL);
>>           fastboot_flash_gpt_partition_table(interface, device,
>> @@ -399,9 +454,7 @@ void fastboot_block_flash_write(const char 
>> *part_name, void *download_buffer,
>>   #if CONFIG_IS_ENABLED(DOS_PARTITION)
>>       if (is_partition_table_name(part_name, 
>> CONFIG_FASTBOOT_MBR_NAME)) {
>>           int device;
>> -        const char *interface = 
>> config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>> - CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
>> -                               NULL);
>> +        const char *interface = fb_block_interface();
>>             parse_device_partition(part_name, &device, NULL);
>>           fastboot_flash_mbr_partition_table(interface, device,
>> diff --git a/drivers/fastboot/fb_command.c 
>> b/drivers/fastboot/fb_command.c
>> index 18d86988f4c..235fae74fee 100644
>> --- a/drivers/fastboot/fb_command.c
>> +++ b/drivers/fastboot/fb_command.c
>> @@ -45,6 +45,7 @@ static void oem_partconf(char *, char *);
>>   static void oem_bootbus(char *, char *);
>>   static void oem_console(char *, char *);
>>   static void oem_board(char *, char *);
>> +static void oem_set_block_target(char *, char *);
>>   static void run_ucmd(char *, char *);
>>   static void run_acmd(char *, char *);
>>   @@ -120,6 +121,11 @@ static const struct {
>>           .command = "oem board",
>>           .dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, 
>> (oem_board), (NULL))
>>       },
>> +    [FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET] = {
>> +        .command = "oem set-block-target",
>> +        .dispatch = 
>> CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_SET_BLOCK_TARGET,
>> +                          (oem_set_block_target), (NULL))
>> +    },
>>       [FASTBOOT_COMMAND_UCMD] = {
>>           .command = "UCmd",
>>           .dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, 
>> (run_ucmd), (NULL))
>> @@ -589,3 +595,48 @@ static void __maybe_unused oem_board(char 
>> *cmd_parameter, char *response)
>>   {
>>       fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, 
>> image_size, response);
>>   }
>> +
>> +/**
>> + * oem_set_block_target() - Execute the OEM set-block-target command
>> + *
>> + * @cmd_parameter: Pointer to "<interface> [device]" command parameter
>> + * @response: Pointer to fastboot response buffer
>> + *
>> + * Switches the block interface (e.g. "scsi", "mtd") and, optionally,
>> + * device number used by the fastboot block backend at runtime.
>> + */
>> +static void __maybe_unused oem_set_block_target(char *cmd_parameter, 
>> char *response)
>> +{
>> +    char interface[16] = { 0 };
>> +    int device = -1;
>> +    char *space;
>> +
>> +    if (!cmd_parameter) {
>> +        fastboot_fail("Expected command parameter", response);
>> +        return;
>> +    }
>> +
>> +    space = strchr(cmd_parameter, ' ');
>> +    if (space) {
>> +        size_t len = space - cmd_parameter;
>> +
>> +        if (len >= sizeof(interface)) {
>> +            fastboot_fail("interface name too long", response);
>> +            return;
>> +        }
>> +        memcpy(interface, cmd_parameter, len);
>> +        interface[len] = '\0';
>> +        device = simple_strtoul(space + 1, NULL, 10);
>> +    } else {
>> +        if (strlen(cmd_parameter) >= sizeof(interface)) {
>> +            fastboot_fail("interface name too long", response);
>> +            return;
>> +        }
>> +        strlcpy(interface, cmd_parameter, sizeof(interface));
>> +    }
>> +
>> +    if (fastboot_block_set_target(interface, device))
>> +        fastboot_fail("invalid interface name", response);
>> +    else
>> +        fastboot_okay(NULL, response);
>> +}
>> diff --git a/include/fastboot.h b/include/fastboot.h
>> index b106d617749..13dcdf919bc 100644
>> --- a/include/fastboot.h
>> +++ b/include/fastboot.h
>> @@ -51,6 +51,7 @@ enum {
>>       FASTBOOT_COMMAND_OEM_RUN,
>>       FASTBOOT_COMMAND_OEM_CONSOLE,
>>       FASTBOOT_COMMAND_OEM_BOARD,
>> +    FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET,
>>       FASTBOOT_COMMAND_ACMD,
>>       FASTBOOT_COMMAND_UCMD,
>>       FASTBOOT_COMMAND_COUNT
>> diff --git a/include/fb_block.h b/include/fb_block.h
>> index 189c708e2f0..fd981d95316 100644
>> --- a/include/fb_block.h
>> +++ b/include/fb_block.h
>> @@ -102,4 +102,13 @@ void fastboot_block_write_sparse_image(struct 
>> blk_desc *dev_desc, struct disk_pa
>>   void fastboot_block_flash_write(const char *part_name, void 
>> *download_buffer,
>>                   u32 download_bytes, char *response);
>>   +/**
>> + * fastboot_block_set_target() - Override block interface/device at 
>> runtime
>> + *
>> + * @interface: New interface name (e.g. "scsi", "mtd"), or NULL to 
>> leave unchanged
>> + * @device: New device number, or -1 to leave unchanged
>> + * Return: 0 on success, -EINVAL if interface name too long
>> + */
>> +int fastboot_block_set_target(const char *interface, int device);
>> +
>>   #endif // _FB_BLOCK_H_
>>
>> ---
>> base-commit: 4d3823469724bca19ba4ed3a5a38fc8e951775e2
>> change-id: 20260824-series2-fastboot-block-target-c8e9418babdf
>>
>> Best regards,
>> -- 
>> Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
>>
>
