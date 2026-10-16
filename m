Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97461CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 00:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41F8E8126A;
	Fri, 16 Oct 2026 00:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NqOLd2-x0S-5; Fri, 16 Oct 2026 00:51:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 774DF811D1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792111871;
	b=q9RJCaaegeBS186KZMhI5nYDXMPBhZUnwpO/8NQ+4lfe7mQ2285g0Rn7kQipKMhJSh+g
	 PXLEt7BsqX8W8ihVnmGLNitI4nbE+lHswe7NqWux28HKlciDy7tNzNWxTLNDknAWwdD3s
	 4e1p4Ivfbi7q7OFiCQK7zb4aJ1U+G4a4NWId4A7QJ/W07TiUlWxDCm6AD8prIjgdC8OV1
	 AKH5MzVM2Y7JWG2lBhQNN4ldeJGPF5qPQGMcKKpVV2n20l8OCPCJkZrP7YCZoloZLz7W8
	 BCpGRiKFSZIP5TYpeUlCnFSIgIlIqwoElk0ApRlIzwc3wLW0KsuzeW6xfgoeDF9KwMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792111871;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IcGwVF7ebgM0ct4IfhCK5hGgs83XqCFRMQl4AoOkhpA=;
	b=NA7J858UXvHS2fXBMtK6xfjGstx2BORfZqQHf02/vMNQCBtsW5KunSTj+TXwmLZRG1kj
	 8BSujhvbQNKJM7bPeXuLQyvZIlHUW/Vc35KHEbyOb5/xVadl+W0WSn2cY6sBQMmBE8+Ph
	 UZ17S2fALqYtu5w8qNyifeE2vksTbf4YR4+AlGQrJLvzFc8CVMjjiqvymbxBXz7DPMfzK
	 Zuz0+qvCNDUUD+Ggj+CVyysUURQw3jG60aZtJF3MtXQNZcyQr4svFpdWMZxRDto6TqVz2
	 RpuApVo3sHNzgN0XBDebjf4TKWp2w0eR9u+pBMSqvJZR8/2oVSrjyKg9ozwW2R9+fjQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792111871;
	bh=IcGwVF7ebgM0ct4IfhCK5hGgs83XqCFRMQl4AoOkhpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZDpEj4xDRu638Y8uTULtejteSo6Sq4DDX38G2HLKzu+im5w3tnRc6J5Pf4SD2t0Ro
	 U1cfo8q9eN9LB+0hpuktStu6GC9BsKJI+VikPwrEQlZlVIBBG1N8DYybEA9orOi/J+
	 ypHdVwrG9B6KjhI1wWYCbZCwuVa/X5YL9IuiTjABX6iPxFPYc4/POzZSMC7n+FrEqW
	 5YkVafvwoqP/D6emHvavtbSz+YQWMKT8QdMpoR+KJkpJ7e1JVlmCnz7Rn5Pjsw5W2z
	 etNqwXslHAl2wBoS1tkNHxlkS5l+cNxJ8MuKP4k1TX4p9RDomYuTKpgpa/AuTIvRg+
	 k0d4Ta+JXQq+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 774DF811D1;
	Fri, 16 Oct 2026 00:51:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1317F362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 00:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 050DA4045C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 00:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eTPBEjCXStcR for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 00:51:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EF7D34009C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792111869;
 b=a6KRuXPzmCRV5ibtV5fXSXVsGUb9rAexgcd2eqJbURRzjvhxH2/teai/hT0WneddLg7s
 vOxJl+Zq0TYV/vw5P+fqPHiefp46Nny5WzsAYziLL8r2rraUF6DMmzQMviFnHq5CgYlBa
 owsK5tD3KgNaDFyOoW7+1CiaPWt6J4dTsQ6zQXd29AVc3pz4OjzfWEMc1PKa2ohdRPngF
 AJS/JKXpGtUPO/NfQlzEWpn2o3QKpwbA1sGKpm8D/xGAf3jcKIcngaUskjqZahpal1opq
 rHJsWHoNat4uyETagsqktd/4ILLZ3dTF/50FQXPQAGorN3n8HtKQTkY5decwuT9j8iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792111869;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=IcGwVF7ebgM0ct4IfhCK5hGgs83XqCFRMQl4AoOkhpA=;
 b=XXXfOspy2s7dU7zg3eEzq+U5tESzJ/eiRHYZNwPxIRCPsglPGy7WlWqod8hS28lBC2/U
 YBMYUtAwkZrENoQncLDhd+BWrvxeebKRVNb+dX/Yoevc3b4GOpvnkzvyO5j4WbAxnN37X
 JlMBSwzzh9uaWeeNVUQGwjMtAf8yS4dWdcjXJeaLj9s1LJ6uRfZX1n9CH79mG9D+m6fKH
 MBuQmvf+jE3QVkUB2ZQbHlopz2XjyZHp9noLTL4GADTUGerO7DIlfwguB65qqz4zQQBew
 SQnEa40RycPyx8OQu2JHHGtz+8ey15RNvofD32Hu6X3fkrRMT6QqZFvcev83TaEi4TQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=UomGznAm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ICXbQ5Qi; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=UomGznAm; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ICXbQ5Qi
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF7D34009C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 00:51:08 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FNCchi557546
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 00:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IcGwVF7ebgM0ct4IfhCK5hGgs83XqCFRMQl4AoOkhpA=; b=UomGznAmvmUD8TgC
 K3v5m22kkYWc1NVJj5rqaKKw2rnRPftQEWP56rlw90XTKCYwtsq9z+7kaxsbduGy
 lG2aXIVeXPday++NjjDyGJC1KRjyQceCbpNuzD2FKUcGhd08zmKGpXB/Bo85g+6N
 zNPluYrhNBU8TuCondzQFgo6ZHiJvT7ZQLWug7wZeOLs6BPcmr8rlDefQjLeeVFJ
 jAue+3fD3r9I3s6K8YITumagJye+UEGu2VGmuPkSKYEpN6A5H/qyuWFpF9hTlOoG
 k2mOL38YhSJLqRit/TdKHd2brhIN20sTps7P3mUvRKTHDCLI2uy/2oa/nwGqOvC4
 fByZyA==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8a8886f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 00:51:07 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67686ccd1b6so7550359d50.2
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 17:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792111866; x=1792716666;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IcGwVF7ebgM0ct4IfhCK5hGgs83XqCFRMQl4AoOkhpA=;
 b=ICXbQ5QiTSLsRpghHK+Vq9NbraNHK63YWoqhQTHiJ33l1T6c7xMybgfOGTRN38aPHK
 9zfz4WIF20oADgbb/p3MrCd9EDZg9Q9GxyEz9Yo+heNlVSQs/OC0s6fRgfMcR4MWanRh
 qWsXNZomwzEnNzMWGSZr3J2jszQT4tHINF7bcKrWDLbeHsKCL9CBcFC7VIw40Jia9oOa
 EZav3SV4fdMgtmGKcZ2d1GazY3KQle3SbhMbAu5WmO9RCQCCp2EFEm4myn6FpVBalOBM
 cl9Nuq7K869yth73/KGEUhsxyE6rAx3GpEleOpbmIyx1pWoSw2XZUhNM/MEPu0Luno0l
 whCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792111866; x=1792716666;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IcGwVF7ebgM0ct4IfhCK5hGgs83XqCFRMQl4AoOkhpA=;
 b=kJKhHB0dg0Ese3MhtLOwxZ4svIBlk1f+tu9zpTWWnNcuLdiRzz50f3lIOrzSVC/bOq
 TMSI++/BtBYW+7CVskWtAz+ZKLwMqY4uZSGvN0/cM+XRVgPA/wEjX6Da7ixMSD29SV3U
 ldHX7BUPFihIddVxgFF/gBPjnL+ftO9rcLWBEHr2g0z0yH/C5GHAzwuIAns8VTl63Xid
 5qf9Dvo1LFe9uDa8Pbl78n52cpiD+KD3QVt1dVrn4OF0hFDVLy3XF/ImT5kPXTswdw1k
 oy2GE4iogH5oIYGUsZ7onVoUDAndgGp871APx2R75wy80Ma5b5RNn6HtCSNeUV6a/s7e
 ji7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdirOi6o+NaeII3uDuGvqNz6vnVmwilkO1RE7GRSg56ni9uIgU4QH6E6dL6R+KIsCm8xFokKQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL1HPodlFudxvQmMEcFj9FKJJkwkNVRWBHdVnkE5ivnsBsTvLwF
 GKi40nesRuTzOP0sspyQqHsJYhKl8eBzAItMF9L+/dzdvBXcMLIor7Yqk18gZEJWG/u2WY6pyu4
 87K522vAee/PTg+/EefwRd6oIxbtVf9Bz5iRKx6A7+NtEgu30wcLk6NPcO9KzWdtwzcw6wuE=
X-Gm-Gg: AYBFou06a1HAVxAvHOtQtyYqpXJCTs2S5UgGiBuMjl5OvPl3CvfbDk69iyPLRrmVsvU
 oLfQJ58dKeTHrc7QE2pwDKRrv+lFCZfrvVV9C48Ej678q8o3l4UrHw1xhl82vFJo5eVkyK7OfNV
 RMHNDnbeWBbyI7bxiNjUclXaOZ9ytM5ME7REjCN8SBPwvdNePUKI8Fi5czq2O3Qf1rD/TvQNK+y
 PdCH3D0TeLX2WG2ni0Si+GK3UicZLVhXQ5XsSdNRFkZTczjGmdPu0DA1r1XpBsjyCG5EL1X9sNb
 0/lyCeZN96yT1V/oqcgQYJ7HLiUFp2eykUyoMf1xuyAZENgsMFw1ZCKdDfObA84Qsy/ZGrciTwH
 oigafHZh2yhbltlQ5rf0+GR+hwnQkEk6K+dcK3Z6VlAf0fxJlUaXFKG5x1NUN
X-Received: by 2002:a05:690e:13cd:b0:679:a42b:f0dd with SMTP id
 956f58d0204a3-679a42bf8bfmr1122718d50.14.1792111866569; 
 Thu, 15 Oct 2026 17:51:06 -0700 (PDT)
X-Received: by 2002:a05:690e:13cd:b0:679:a42b:f0dd with SMTP id
 956f58d0204a3-679a42bf8bfmr1122697d50.14.1792111866095; 
 Thu, 15 Oct 2026 17:51:06 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b0e59451fbsm3007467b3.39.2026.10.15.17.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 17:51:05 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Tyler Baker <tyler.baker@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 3/4] board: qualcomm: add Arduino VENTUNO Q support
Date: Thu, 15 Oct 2026 20:51:03 -0400
Message-ID: <20261016005103.34144-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3f4648b3-ccee-466b-b209-fb429aaee803@quicinc.com>
References: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
 <20260928-monaco-ventuno-q-v2-3-0e046c8242be@oss.qualcomm.com>
 <3f4648b3-ccee-466b-b209-fb429aaee803@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAwMyBTYWx0ZWRfX/ZrN7QMD7pB3
 1Sl3PV8csfm5BiQ+jXKScKdlbr0fgbiQLrFqNTI/8mZZaqDatnmHD2f0FyumouND2qcLRztmTon
 CKCUc9ES5fc4NUcCaA2hAlbbdIddFF0=
X-Proofpoint-ORIG-GUID: xp2zJeViTNaA5cBEIQS6WZ69vacPiAma
X-Authority-Analysis: v=2.4 cv=GJadgeNK c=1 sm=1 tr=0 ts=6ad174fb cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=6jbKIeu7AAAA:8 a=NffwasRCjmsnxzSRhiIA:9 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22 a=-0VUF4iAjVmhXKmeMUOz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAwMyBTYWx0ZWRfX3DnPZnBhXR7J
 4npfO9m4+f3KL6HzxKpgpW0xNCZT6BZov4KWOWQkw/wnaNDbflXuCQIR/+2qY1c73jYD2tPPNQi
 FUJ5rnUzrCc18BS5s19/iZmlygJsUIEG4DpUZNTxAFzhM01G0Qsh9x8uqplWuOSsVtpqdBX8MDF
 AbHx83ImjuKdUhj4mN3PXr/D2Ss5n0VK0MbWePS5Nhcx2nOpspniw91P+kd/9TJHUxuTHOKCX2/
 iqVz/gH9k3nrYQyEC3IXlVsOtcjgP6UTrbEYZX6KEv+lhJ+3YWKqgoVpN7/jiR+uZPxNrf1Xz4m
 AbdQ94bQq8WBMQtX+7mbDcn3klG6yFAKs5AcaVikiQQ9EMek2HruNHq+B6aPDlmyKQTSQKFCYaL
 P6WpAY4UxFWQ0iqEj9Acrjl2jeBv+KJAqRzb8Q1vNcB5sI1xQBmUwl265yQKz+mkrFVDjGima5O
 eit9KRkyjVcxqwcOJZw==
X-Proofpoint-GUID: xp2zJeViTNaA5cBEIQS6WZ69vacPiAma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160003
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

On Mon, Oct 12, 2026 at 09:45:41PM +0530, Pavan Kondeti wrote:
> IIUC, Linux makes CPU with MPIDR ~= 0x10000 as CPU#0. This is
> conflicting with the `reg` mentioned at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/monaco.dtsi#n53
>
> Do we see any issues with that? Also, what would be CPU#1 in Linux?

No issues. Physical CPU 0x0 becomes logical CPU 1; the rest follow the
DT order. All eight cores come up at EL2, and cpufreq, hotplug and KVM
pass [0].

> Do you plan to patch the Linux DT as well when this change is enabled
> in u-boot / bootloader?

No, no DT change is needed.

[0] https://lava.infra.foundries.io/scheduler/job/491249

Tyler
