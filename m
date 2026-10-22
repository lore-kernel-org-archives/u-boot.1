Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9037606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CZPS7OfH;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SuUCdR7d;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HQV6lPHO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8610D608C9;
	Thu, 22 Oct 2026 23:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FvjWE_Ht7n1b; Thu, 22 Oct 2026 23:24:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D89256064B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792711454;
	b=VGk16CbL1+RqMLMboTcGo+z1vjTld9OvkpvrO3iGCRPazHtXy1+fDENbZIEMvcF1puyN
	 RVKOYvGKY4NjitvEUAhQowYlmVy07GkAT4Wj83EE6UEdBmyMMzrX1IYo06owTiQsH22Fp
	 7s0S7IJvaL57YMIxTw28Zhyn+Ex9WL+sDyJIkoKHxHu9pnGt8twl/jHKv7Oer9LdrRP23
	 4sNghQBJ3uy4IVno0MzzUPmgp50RRZdTVDXoTK8EnvvLu35gyDLFZ5wAgTZ04l3l+Aatv
	 L3bPCJgM6qMyefoYFN7HoZIZl6Ct8AZwl/03fKbTYLhGuXlLMDSWvCpbm+frbgX+7BQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yHYOBui6u5HejRqr9w/4WJDCK6xkUszaNA5um3/KQS0=;
	b=duWYD7zLvwmoDt1Skdhpsb4Ml8AbArd/i/ZHzoutIKQMqJA9UDEEGR3ME1ilehc7QXgJ
	 CWNwqPnvQ+492jTyEzaClg7cGNaG4dk4YGXisy603vrzH9+NDjlw7ME2+CgoaxJ0r0Tay
	 EMq4p072zN4JEPrUCS6wIRvDO2NqB/znurEx9h1NGlm28DBBNjASrMtX6ixcreI1jVWqT
	 z1114t7pSimZ7I9NgsYybGUkEK8kIfYjnju/ERD3HP/8h6S/FxHMT47kTAssfYs0/6q0i
	 /MulxLgvnIMZliAUm9vqKp4Iyk7GN1fAanQSWOaWQFjw9wylzcFaWNWOKy4+nwj9q/A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792711454;
	bh=yHYOBui6u5HejRqr9w/4WJDCK6xkUszaNA5um3/KQS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CZPS7OfHtNA3tTZ65kaiHpDkzuHykwqsRR6iB/m6GyGzjZvl7fnifH8wNePq1mdnO
	 +Rl4m7UnhRlUyr5TzvI8Jio4qQgHbxuFqDqFmaxVatriGhWUJxiUklvMSGvVzUUsdr
	 xrxExbHJECXHj6gfKUKruqBkGnGvM/T5VoFyU2a4YYGEYprhfoUoS6kdT2qIELMk4I
	 g7ouVthm+Dow6eKutGAVSDbIMfPy235itNRDkEyXYY6w3waBn7ZdI1gap1itaW78nd
	 iEOwb2cRF3u+zQmBB6W8wzkmDpcyHqUoYXrbmF7kMmNQx6vUj2IuIMMvGtIgzy+pt4
	 fZsKUZW5L03bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D89256064B;
	Thu, 22 Oct 2026 23:24:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 255E4356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B5DB811CB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MPaLcQIat3_1 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:24:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3DB6881136
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792711451;
 b=eDDlouVsinNhZW3iMLy7ACf41mD3XBkUK4Gfh8+/xbWNDL94J9VOdEbnZHkMmqcRPJR1
 bODN16KP40Lr6oy1tX5qLcAwKHoZ9qUkinqdy/YtMTXVb7uQqcTTtQYlmYTx7+WkAp3MN
 Dx6Q+DjjVftRQzzdyuO3d/Uj+Iu1sSBLM9hY5hLy4k1VrFZKiJTJi2iK3haZdK0egbGTh
 5C+ArlHYxhvi9Uf08jTnYs4+Il49497mFo7qcvLS1OKkOcA7cEq/4qGmDGtGaOEUPpzuk
 9hRE0uLinR83twuRmCjRU/zdq/5uJAwK7QGf25VFHwxosvx8v61lKMjPyTGRwNORpEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792711451;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=yHYOBui6u5HejRqr9w/4WJDCK6xkUszaNA5um3/KQS0=;
 b=g1o5BFokANWLrG7AvMkDXWGDav86TV7Ln9zP7c2H/m8zd3x6dE4jHjNRrBlsWYoghrcf
 fj/OH8TjI5jyxpVUWBtXRSo8xP7QAR8ebzrOR97rRwvHjFG3RgBgO45gqZvKwMhQqF1oi
 LQexJCWcWx60DRnxa3RHDd3QwD6BbwE2oRP+J1UW2qNZjVgT9zz/83VEdf4MsL2Owj5Ta
 jj0NzdXBmKF9u1IWFmDl2mdm64VWmqVH8KQ065+Fu1r5UCmPNgunxYdOYU2F4e/sal+V3
 p10o76YMxGGWWFFqwRB2BIMeeUCaRVcn/QyX+sF7bXv8Opb5xvuAg0x36q6ldtMF94Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=SuUCdR7d; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HQV6lPHO; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=SuUCdR7d; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HQV6lPHO
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DB6881136
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMFCaA1412337
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yHYOBui6u5HejRqr9w/4WJDCK6xkUszaNA5um3/KQS0=; b=SuUCdR7dksGXUrnP
 9eTdqcgwD9pxrRpCmyuuMQ0RN3JKGCSbmkVJjyRZARK2yv47V471VDblI4Bw/odk
 LpWpLNAbFwE0sNaqJtS4V+lvvkSrAKWJeZ2QXJVdqsbbYxPw+J85u9tFA7mIPJlH
 h2zV9Au7K0tc4D6ED91riXnmfYp4pZ5eWDAJLYPSBReVsap5aHX/qUv/pTMIaxhm
 i+/74raK5nZVQCH/+/nJ/NNOsRwJT1fsWaj1PsmsgiiPsmnZo+kq5HM1CiwNqCGo
 3XsUaPMEE25mjVuLE6DtG93txaIRLi1wwqlvZpVGNVIllaqxEWPAwHQPby+rJV0+
 216eXw==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0hjj3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:24:06 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-6799288480dso722225d50.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792711446; x=1793316246;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yHYOBui6u5HejRqr9w/4WJDCK6xkUszaNA5um3/KQS0=;
 b=HQV6lPHO9ERoupDz+8zSBILkM6Kq8ms90L9Ab3u3pD96ppEh0NjNDN6dC1DCvwbKdJ
 2KhulJFEaa1Ml0/pj61RfScWq7sbwAJe6a/mGU1sbZXhDdJMrXCvcTeghgFefSCym/Xk
 Ut5srgYexsSMbOAwy5fiahYqwf+ginc/fbjK+yLbXJMSkF9fsyRZbJp94UTMa92ECAHy
 H0Hv3F8pL64ZXAwZUzth4yv14xwUXH5qg1ku5gZcE7KuMdZqsIf9pk4Uot7WidoLKC4t
 bG+1lM1WlpBLc5+9voRY2U21OUESfoG6docGbuJINjMPk9C3/ecqUYOTNjOjT6qsLVxl
 yVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792711446; x=1793316246;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yHYOBui6u5HejRqr9w/4WJDCK6xkUszaNA5um3/KQS0=;
 b=r1RZn8I7aQL6Lu1oen3DJNzqecIvcYjyAM7/Pcnr04t7bDy88ysgoL/7PhD5CqXypG
 qA9QKlvBcMrvqbqUzEIvuY5JSjeXVNPe7LXS8sbYV8JMB23nhgEtl/Eq3BJfr4VvaMBM
 NwgafWxeZagfNCPTZvrxfE8HljrnX9JGbZjkAZ6KNfPNOg0HYsDoMNcwWEVgXzj1lJkb
 kCmq+JjNXIMY/Fj/DR3MwfjyFRx2K2UHNRMb2UEW1V1BuH9COHytRf0VGB21CheL3Iic
 JTonjjwFwKu+rKxcm7OF8pGmHkXbs5lvKFGVYCTcP0QMxGunF70FsHIussocoORZHwh7
 PJOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBznzB1m4u8fy9q1jz7jhSg9PFi+6UgXnxtXELE9JH1/L+nh/gUs4td0jm8ldMdWyEZYXfVZEr8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYINWHFbaSo6HWisuARZPq5K+TXHeXxpDVJEQ1KAEDflEwa/CVdd
 eJbwxHL4R8dkB975qOZleiq0va+Ubv0WIXLC0vxDnP07QU1giTHVpCGM9yNtDwqUIjLdN1zlUhj
 2HkQj1PJUHTQdMM85ZtxCUyNCf3O4WCkX3D/nHfzgTQAeia1bt5E60c1iutF6PkI1gDoyXOJVZ+
 TZu/8=
X-Gm-Gg: AYBFou0Gf+TGxks/JFjLkxsp09UwVcWhqh2moYjVlaL8zeWR4QkZ8Pl7r+784KH69qU
 yX+HKJ6DBeQ4A+Wt4VtckSWaOTqNChsS/Yl2DGD3oWRDF2ZwJN5VYQG/5d/GMW5zxbHo6/q5/w4
 b+0uKaO9sbEk5M68fqmB7t1Z05JQb3jsiBeSFOL8RYUCPkBQAz8dnGL72tnHSvuWkunKpgLxWuE
 cyyF47xySgtRV9ClrLGlNXYYfW2l5WnNIQhOW6BmVfKp8Zpw8NL3GQmE7grsbEQnZnFJpfAIHu/
 iqMZmd975rTEqlOg+rOscLJkBZC/0MySPxAdfuBuQX0APkTHPkMXx4gFuikn7wxDAHnCP38K/5X
 3opyHXNw8TpcuAM7TnjLR1mCBuXQBUHm84syAt1JC6EltI7RAolHf78HsWYhT
X-Received: by 2002:a53:accb:0:20b0:676:bf92:2520 with SMTP id
 956f58d0204a3-67a35ca7b05mr215651d50.89.1792711446166; 
 Thu, 22 Oct 2026 16:24:06 -0700 (PDT)
X-Received: by 2002:a53:accb:0:20b0:676:bf92:2520 with SMTP id
 956f58d0204a3-67a35ca7b05mr215640d50.89.1792711445775; 
 Thu, 22 Oct 2026 16:24:05 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a33fd78fasm475044d50.5.2026.10.22.16.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:24:05 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH RESEND v1] mach-snapdragon: smem: Use available_length for
 RAM partition v2+
Date: Thu, 22 Oct 2026 19:24:00 -0400
Message-ID: <20261022232400.845241-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012173227.1615249-1-aswin.murugan@oss.qualcomm.com>
References: <20261012173227.1615249-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9g5fINRlTBo-cZJyMsHhqbPAVo37dBqN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MyBTYWx0ZWRfXx3447IcpKnMm
 k9XT8RcjstCDpUvoGg90wsQSPZAoi/TOZ9/WesCGfj21u0Jl7cHCkbxZodE6zKEyG9wN/J4FlSJ
 IjmhqTJvFpItg20HlMNNYahpowFrtuMXNURB64knGKHP1N464rE0oFXItKXpaZ6+bLmvNtm33Im
 T4i2iOz2BVPabmNC+ghTjMPPBwvgyp9rEv8yd//Dhz+F/UtnL9btfrC4LKhjlKtRgjardC4y9vy
 BvnGHp4aBzTGtcT3KNUN4h1fzYQ8AM0+w7pdTS9oYuTYTBQUnl8Cmae6BlBM8fvOMw7+CgA5xdN
 MuXLOOZGnGL6onLhgH8a/U/lCWeQuA6fxqY2aJFxdmZBdRBfeBlfWjWUAW7RzvMjjRQqw73QbIV
 kpOooHr7bF/EYrHoK1QyA9H6uxHXLR/hpUqh+q3hPXYnwRWN08WFj+wjZXCXUc8xO5uv2OfZ+kO
 y71qe6lCVqYu+oohmuw==
X-Proofpoint-GUID: 9g5fINRlTBo-cZJyMsHhqbPAVo37dBqN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MyBTYWx0ZWRfX63a7kiICMjeU
 Q1cfrwsm6zcFHbUoYxkibd6pGyyBk3mdYtFQtwMUenm3Ql3cELGI+nIt6V+HLmz+DMJEt4hBBH2
 nbGPAX0cfiowdP06yU1ZK8YtsNWGnsE=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6ada9b16 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=sOnDfXEmMANyBQqeG2kA:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220093
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 at 23:02, Aswin Murugan wrote:
[...]
> +                            entry_field(v, e, length))

Spaces, use tabs.

Reviewed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
