Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8290BC79FA1
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 06:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B16FC60811;
	Fri, 11 Sep 2026 06:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qd0n68Z0OgMA; Fri, 11 Sep 2026 06:29:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7D0DD60603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789108185;
	b=Bn8Yp2Es8LTR7YVDF/HJKeRnzHDOTOs81E+2d9HprVNaI0MsuQnl3/UNlc0pYTdoGSVv
	 licKm8T21E735cBSNZXjlhrFkLQoPqf7OI4bSLuCD+E5XaACy2vUFP2HFnegYe3OglEUq
	 Tssse65gFG3DLJweccPd9nupQIJ3BDEHr8YxMwqyRcKjuDoJXUBa5up5+gfHPeGVyoNUq
	 7bn9RGJ6JOB5IP8IJrK3wO/b/TIgb4EiLB3mDt+8JvqRj+8bsUD7wIjVyA9Nckld1lbSF
	 zeq1523KvaWt7y975xNmh1N1yi75Iq7gpCIsuTD+C2Mk9/7qD089uRwATtSitwfa7XQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789108185;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sOpZDhy4pI+3gtYFa2CkmxKQH9X5HWS/1DCKvyGioXM=;
	b=q5x2yur7n+R/R97bfS9ficuJrQd9rCiN6wVqnayRJpfhfic8rEv80EkkEejTuw5aEJBm
	 IRyn/gnrc/S7w6f5s2hVOM4aVao6IhwVBdWv24TT/MBIQ/3ySmDFs8bSZ9yIRa2ZevTcZ
	 6GeYuhCAhgMM2yHYpFNEuUPLHVhejVdtJV/5aenWIdkDrim0Q4uDOnO404bmcLmdIG/zM
	 e6k9hSHida+DjZSKGdEInc1IWi43Y9iZ+SNEDHU70tLx3fIO0S6boIqi/81m0yN0sHOAV
	 ejZBp/LC6tLYsI/ul2i6U6TKJ+WVYvxjmpGgtBcDa7aq1QPBKm93ryIWfV5v0AuOKVw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789108185;
	bh=sOpZDhy4pI+3gtYFa2CkmxKQH9X5HWS/1DCKvyGioXM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HUDSohoYFqvBkShH2C7DnRrXIP3U70CeYCofHwJPFDdPkf/frzYfxA5R/1gkJxJ/r
	 3fMuNVqq2za4Cw8D2tTI5Febe9kHFGZCn97pFYP1gpdmf9sDbXrDSUhqP9uzclvHiA
	 St5/I7LaRJCUEt5eAtkOpY4i+dgZ7pD0VFOsVWvCCZQ7ZhUo2+hvyfzvuv6qJ/+rd3
	 4K69S3eEfKI2gPeBRZdUi4nocf+lmfpUlGB/H/f9+uEElipSU4aEcyO5Uo/ImFxeyA
	 aNu48lrWa8yxDE4XLm3LJ1h+vA5NNZ1atTGv99bGVXi3sNmZdZq1cyruV1S8blXk/8
	 6/XG/iqgXZ95Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D0DD60603;
	Fri, 11 Sep 2026 06:29:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CAF349D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02AE08110F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:29:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id itW0X0vqoHHo for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 06:29:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0A3D1810D5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789108183;
 b=Su8pNoJkjoOuEofOye16PXjdMwiInNiuYrYCCP0C+yVfgzZ0OJ3NRRFiNWTvFc31i2wI
 mrTkvkFPW9fCWDVlqDVi6tKqyKaz2s8RPBlgh3xPBiW5pjYVxL/9lXaScLEQOYHzkh4JT
 3GO8Dm6vAsYdIh2IJRJNRIPXxDrt9Hs25bAnSof68BQrh/zXrzMwVz4zZANDs3/Hr3i3B
 s/XhJ84/gG8h7a21vPyFz7di9+0nSLmdvj7xsX+rnAmiXCd9CFrNwn/+rs9r+lqF0IcbA
 tKq5HB0DN+BammCxmPFbZKhfq37GZX61FWkV1X9ATckN41OGrxTjoD0OhyyQN6/icIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789108183;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=sOpZDhy4pI+3gtYFa2CkmxKQH9X5HWS/1DCKvyGioXM=;
 b=ThkoA0yUURRqdFc+ZelW24bZR5VGHLvjqAFXQyvHJEruzcSZ7t3PPBdqTZHDliHt2UJe
 z5UvOPDJR3meTlLtSHxO+QtojZHo/HuvR/LXgmLwHRI4R6+b1uN4bQ0aC4FOKv4dcE9l1
 /r3PoG1R1jIhFbbst3sfjqM5ut3NP4N9a9DDTMBZD6vQF6Rrehcenr96yuc5/IBK6Emo8
 TBJ3KNvUgYTFP4a3Qwmm9Plf7Z3CiedQAQBW9kHkeKVSsjs/uaGV1COcMkdOOhgLM+86W
 EDmd6Df+nNR756IPbSERt8p9HWUK2GxWQy2el9loANPXeE0f9LDm/oPHqbyLUCGkU+A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=INAVVj5a; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CA5pLCDj; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=INAVVj5a; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CA5pLCDj
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A3D1810D5
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:29:42 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B4vG272422200
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sOpZDhy4pI+3gtYFa2CkmxKQH9X5HWS/1DCKvyGioXM=; b=INAVVj5aOcGbx/ix
 ofm3zQXXWwyturPh7sG5cugcZd7iaMlrlDu8KduMnX3r4b/KePBIqSyWQplsKu21
 BlRSgq3hd9lRd+HiwsEgfvmlLUFXgNFFyVTs9XikeuLS1VJtVFj2lABVjFKkV85I
 0+9PfI6jI0d4f2C83MH5oNMfND1NC0fyZY6r3s1weduQJeALCHdNAVTUHQdnczKt
 b4M3M7V6ugcigG6DYXRFGh7jCjTpkMWPjnyLqPy5r52RrMDa66LpBKnW8VDrOa4x
 jAz6XOAoacUo8T+jetedlYw9Lh9rK8kwwbT5qjrd/jd55t6k+LqNiJZdgqE5SvGE
 MqE5tA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm729h65h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:29:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8633c0d7353so825966b3a.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 23:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789108181; x=1789712981;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sOpZDhy4pI+3gtYFa2CkmxKQH9X5HWS/1DCKvyGioXM=;
 b=CA5pLCDj4ABNWjyas0vA5ZIK86mF7Dw0vMPnchR4GEQYF8DLCbkHZBqbrABXCEK5E5
 7WQAkeDiq7glJW4Os4QF2+cGLNKZMG9KQnKfv3GmLN9iJeMPRwGiM/2AaRUOUwR39/mO
 tEU5Ofe1/cjSb/2zJnfiOfTFLAiHBtBUZJkjpa0aptSMBbVcfYTn5x8pOBMwG6onVIen
 ROiQAgGG84vddD/9PuqYJPpqmVmrHGy47tThbYDVVf88V6JgQoLqymjgj8pzXj8jjVcR
 JyoJLINGuin6Feks2+BiEVlLVcEJuWe8YzR0eWlcZYY3A5chZ/VD+uHXNQWV2XsKmJv2
 BZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789108181; x=1789712981;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sOpZDhy4pI+3gtYFa2CkmxKQH9X5HWS/1DCKvyGioXM=;
 b=Ud4Q7QxO0R69mE6hzbHeCBNBlJ3IGh6dLk3R7GxcBpTSckJA7OgjlJtsA9zg9BQ53q
 D8b9QcDR8lzRTjG2VnxCNDSgYI9wdBFZ5GLJnL37maVAay27IBs2oG5MSHDa/hMveQm6
 QhSQi1u5kpjZKwHsDM5JmzAv5/RC6DXo3ssCjgmsVZcB0Y7JSLs0HTOheTtNMvYFlmzX
 /XC8d4jR8NShpccr2zr52ZN5DpOzbag4UdYU9duPBsrSKrz1l2HE5k1/0MbJ9nc9O2z/
 d4A2QCEZMavTjrkPLKSmsSJDWri7cvhEUl97RtE+W+yc1bBwkhd3/rjneL3AccnuTdA8
 FfZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwvWb1otDgX6hSinyIMJHAIvTLp7yZh/mYSSiOAbvws6v9vYZNHXKfrYJFxxIs5T9lai5MF0g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lHddELEbmx7Lio3cQBJLlFv5khzpQxanNBByIovykATESrGhpq
 dJF7gIO/yPs4wvfyJennBJtMoDamOJcYWGp4v2Z94NpKidR0wuDF5I8t7Wxit/nzau9/u4EGUca
 SlN5T6z2uym+B5iIOjpXxlAodSBu+YGq81nRvtOlWR9onFR6dHBHdwWsiyMpOVKfFt+5YDog=
X-Gm-Gg: AYBFou1q5kYI92/yfYFtaYPMR9kngahsM/zhZUGYKmxRkcEuWnPThv6LcvIzvhPmQhi
 xLar5psIMlAqbxM4afO8XMhGAmoy8uY9mPnLFjAtZc76zB9gGl08Xh/buAQLVqPc6S7uGbLB2Pr
 E8m9tcZjA44Lcbay1VejulMpMjjEdcGKtEpjIkqOBPWirCRXHszNFvSs4hBB5iNuXESCm0qSopw
 dCcUvvkCWoXSbI68/qAeDrRqh0MfqFCyV2OVI1j3zQytp6CF6E1qROaQj9TducLX5Iebc3Ql6Jd
 RLwF5yuRZ3cRmvNjl/RkSv4Tu4KnYpIxkAzVeI5OHAo6PouOuXLLUlDXfMoAybt4u10epiw8pTR
 QPQpg9b2AA5ipUbjDkM5FY3epJwry099CeEDl
X-Received: by 2002:a05:6a20:9f95:b0:3da:80a1:f2f with SMTP id
 adf61e73a8af0-3daed5d1801mr5095685637.14.1789108181256; 
 Thu, 10 Sep 2026 23:29:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f95:b0:3da:80a1:f2f with SMTP id
 adf61e73a8af0-3daed5d1801mr5095621637.14.1789108180735; 
 Thu, 10 Sep 2026 23:29:40 -0700 (PDT)
Received: from [10.151.41.57] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e52a60sm3470308eec.6.2026.09.10.23.29.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 23:29:40 -0700 (PDT)
Message-ID: <8cc5f24a-9acd-4ed7-b53c-c135fdb0bcd1@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 11:59:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] clk: qcom: Add Global Clock Controller (GCC) driver
 for MSM8917
To: Reza Kurniawan <imkyufie@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
References: <20260910095339.110427-1-imkyufie@gmail.com>
 <20260910095339.110427-5-imkyufie@gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260910095339.110427-5-imkyufie@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDA4OCBTYWx0ZWRfXzy1n+aSuazMq
 HWmx+kbzQC1P/DGaqEsxJDYMCIsIZOJ5bl2mKHIciP+sTY/OR2RbYRPHJj24pjmyPNnsle+XykW
 eLXWGbWx5TykEl2JCTxPXF2iovpfwwU=
X-Proofpoint-GUID: qNT_B-LSRSkRn3LRRh7faheJBny9CAzY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDA4OCBTYWx0ZWRfX/PQtUiWl7a9T
 YBG7cTkO6e4l4yqg7xcdFqNXkQJK131uMGuyyatJseiKzVRNfu+GnOGcaWZPa5Pifl4IpZEopFC
 IF3irJrFsR+aGP78OZmX0gwbgNcYQ3DGCXFUaUJLgs0h/p7kpmD/HHmrFfoDkN0Yu7X8ZLH9kL1
 px8g+faxy9R0mtZinQBXeKzOHpVX0N8+566xaAThRN5E/o+IU/WKIy5lDsb8kdbnAnLiThTkqUI
 abS0ZXv1YVmX8BpmPc2KQFlAtz1YNUfprjYrO1S4kgaVGU+87RDQo57PQD8W3e95T/it4f+Ix9b
 SoGwVYbU5r1bdK9cWmE9orVtpmtH1HFdg3mAnw3z4FUCRoATd9jlRqHZcwHrM4HcA/fta9IBgD8
 OYL7t9iXqHHn+Hp4qvd7yT0jnh/2rlWneADVyeaNKGW7BqP3W57u2JH/keyOgf3qDOglae9mdID
 2SBFKThUNeZY4LzHhnw==
X-Proofpoint-ORIG-GUID: qNT_B-LSRSkRn3LRRh7faheJBny9CAzY
X-Authority-Analysis: v=2.4 cv=AfwkjHXG c=1 sm=1 tr=0 ts=6aa39fd5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=-CfRnPQAjtzJA4Dl2IQA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110088
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

Hi Reza,

On 9/10/2026 3:11 PM, Reza Kurniawan wrote:
> Add Global Clock Controller (GCC) driver for MSM8917 to manage clocks,
> resets, and gdscs. This driver includes the essential clocks and
> resets for U-Boot to function.
Same here, pls mention kernel commit.
>
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> ---
>
>   configs/qcom_defconfig           |   1 +
>   drivers/clk/qcom/Kconfig         |   8 ++
>   drivers/clk/qcom/Makefile        |   1 +
>   drivers/clk/qcom/clock-msm8917.c | 196 +++++++++++++++++++++++++++++++
>   4 files changed, 206 insertions(+)
>   create mode 100644 drivers/clk/qcom/clock-msm8917.c
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 7d4a2b589..59cad58a9 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -57,6 +57,7 @@ CONFIG_CLK_STUB=y
>   CONFIG_CLK_QCOM_APQ8016=y
>   CONFIG_CLK_QCOM_APQ8096=y
>   CONFIG_CLK_QCOM_MILOS=y
> +CONFIG_CLK_QCOM_MSM8917=y
>   CONFIG_CLK_QCOM_QCM2290=y
>   CONFIG_CLK_QCOM_QCS404=y
>   CONFIG_CLK_QCOM_QCS615=y
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 95b650831..d8469ad5f 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -55,6 +55,14 @@ config CLK_QCOM_MILOS
>   	  on the Snapdragon Milos SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_MSM8917
> +	bool "Qualcomm MSM8917 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon MSM8917 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>   config CLK_QCOM_QCM2290
>   	bool "Qualcomm QCM2290 GCC"
>   	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 1adca029b..6478ec322 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
>   obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
>   obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
>   obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
> +obj-$(CONFIG_CLK_QCOM_MSM8917) += clock-msm8917.o
>   obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>   obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
>   obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
> diff --git a/drivers/clk/qcom/clock-msm8917.c b/drivers/clk/qcom/clock-msm8917.c
> new file mode 100644
> index 000000000..2cb1fa961
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-msm8917.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0+
This should be GPL-2.0-only i guess
> +/*
> + * Clock drivers for Qualcomm MSM8917
> + *
> + * (C) Copyright 2026 Reza Kurniawan <imkyufie@gmail.com>
> + */
> +
> +#include <clk-uclass.h>
> +#include <dm/device.h>
> +#include <linux/kernel.h>
> +#include <dt-bindings/clock/qcom,gcc-msm8917.h>
> +
> +#include "clock-qcom.h"
> +
> +#define CFG_CLK_SRC_GPLL4_SDCC1 (2 << 8)
> +
> +static const struct gate_clk msm8917_clks[] = {
> +	GATE_CLK_POLLED(GCC_BLSP1_UART1_APPS_CLK,	0x0203c, BIT(0), 0x0203c),
> +	GATE_CLK_POLLED(GCC_BLSP1_UART2_APPS_CLK,	0x0302c, BIT(0), 0x0302c),
> +	GATE_CLK_POLLED(GCC_BLSP2_UART1_APPS_CLK,	0x0c03c, BIT(0), 0x0c03c),
> +	GATE_CLK_POLLED(GCC_BLSP2_UART2_APPS_CLK,	0x0d02c, BIT(0), 0x0d02c),
> +	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK,		0x4201c, BIT(0), 0x4201c),
> +	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK,		0x42018, BIT(0), 0x42018),
> +	GATE_CLK_POLLED(GCC_SDCC2_AHB_CLK,		0x4301c, BIT(0), 0x4301c),
> +	GATE_CLK_POLLED(GCC_SDCC2_APPS_CLK,		0x43018, BIT(0), 0x43018),
> +	GATE_CLK_POLLED(GCC_USB_HS_PHY_CFG_AHB_CLK,	0x41030, BIT(0), 0x41030),
> +	GATE_CLK_POLLED(GCC_USB_HS_AHB_CLK,		0x41008, BIT(0), 0x41008),
> +	GATE_CLK_POLLED(GCC_USB_HS_SYSTEM_CLK,		0x41004, BIT(0), 0x41004),
> +	GATE_CLK_POLLED(GCC_USB2A_PHY_SLEEP_CLK,	0x4102c, BIT(0), 0x4102c)
> +};
> +
> +static const struct freq_tbl ftbl_blsp_uart_apps_clk_src[] = {
> +	F(3686400, CFG_CLK_SRC_GPLL0, 1, 72, 15625),
> +	F(7372800, CFG_CLK_SRC_GPLL0, 1, 144, 15625),
> +	F(14745600, CFG_CLK_SRC_GPLL0, 1, 288, 15625),
> +	F(16000000, CFG_CLK_SRC_GPLL0, 10, 1, 5),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(24000000, CFG_CLK_SRC_GPLL0, 1, 3, 100),
> +	F(25000000, CFG_CLK_SRC_GPLL0, 16, 1, 2),
> +	F(32000000, CFG_CLK_SRC_GPLL0, 1, 1, 25),
> +	F(40000000, CFG_CLK_SRC_GPLL0, 1, 1, 20),
> +	F(46400000, CFG_CLK_SRC_GPLL0, 1, 29, 500),
> +	F(48000000, CFG_CLK_SRC_GPLL0, 1, 3, 50),
> +	F(51200000, CFG_CLK_SRC_GPLL0, 1, 8, 125),
> +	F(56000000, CFG_CLK_SRC_GPLL0, 1, 7, 100),
> +	F(58982400, CFG_CLK_SRC_GPLL0, 1, 1152, 15625),
> +	F(60000000, CFG_CLK_SRC_GPLL0, 1, 3, 40),
> +	F(64000000, CFG_CLK_SRC_GPLL0, 1, 2, 25),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_sdcc1_apps_clk_src[] = {
> +	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(20000000, CFG_CLK_SRC_GPLL0, 10, 1, 4),
> +	F(25000000, CFG_CLK_SRC_GPLL0, 16, 1, 2),
> +	F(50000000, CFG_CLK_SRC_GPLL0, 16, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0, 8, 0, 0),
> +	F(177770000, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
> +	F(192000000, CFG_CLK_SRC_GPLL4_SDCC1, 6, 0, 0),
> +	F(200000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
> +	F(384000000, CFG_CLK_SRC_GPLL4_SDCC1, 3, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_sdcc2_apps_clk_src[] = {
> +	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(20000000, CFG_CLK_SRC_GPLL0, 10, 1, 4),
> +	F(25000000, CFG_CLK_SRC_GPLL0, 16, 1, 2),
> +	F(50000000, CFG_CLK_SRC_GPLL0, 16, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0, 8, 0, 0),
> +	F(177770000, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
> +	F(200000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_usb_hs_system_clk_src[] = {
> +	F(80000000, CFG_CLK_SRC_GPLL0, 10, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0, 8, 0, 0),
> +	F(133330000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
> +	F(177780000, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
> +	{ }
> +};
> +
> +static int msm8917_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv;
> +
> +	priv = dev_get_priv(clk->dev);
> +	return qcom_gate_clk_en(priv, clk->id);
> +}
> +
> +static ulong msm8917_uart_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
> +	u32 cmd_rcgr;
> +
> +	switch (clk->id) {
> +	case GCC_BLSP1_UART1_APPS_CLK:
> +		cmd_rcgr = 0x02044;
> +		break;
> +	case GCC_BLSP1_UART2_APPS_CLK:
> +		cmd_rcgr = 0x03034;
> +		break;
> +	case GCC_BLSP2_UART1_APPS_CLK:
> +		cmd_rcgr = 0x0c044;
> +		break;
> +	case GCC_BLSP2_UART2_APPS_CLK:
> +		cmd_rcgr = 0x0d034;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	freq = qcom_find_freq(ftbl_blsp_uart_apps_clk_src, rate);
> +	clk_rcg_set_rate_mnd(priv->base, cmd_rcgr,
> +			     freq->pre_div, freq->m, freq->n, freq->src, 16);
> +
> +	return freq->freq;
> +}
> +
> +static ulong msm8917_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
> +
> +	switch (clk->id) {
> +	case GCC_BLSP1_UART1_APPS_CLK:
> +	case GCC_BLSP1_UART2_APPS_CLK:
> +	case GCC_BLSP2_UART1_APPS_CLK:
> +	case GCC_BLSP2_UART2_APPS_CLK:
> +		return msm8917_uart_set_rate(clk, rate);
> +	case GCC_SDCC1_APPS_CLK:
> +		freq = qcom_find_freq(ftbl_sdcc1_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, 0x42004,

Can we have macros for the addresses? Same for below.

Regards,

Balaji

> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_SDCC2_APPS_CLK:
> +		freq = qcom_find_freq(ftbl_sdcc2_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, 0x43004,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB_HS_SYSTEM_CLK:
> +		freq = qcom_find_freq(ftbl_usb_hs_system_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, 0x41010,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 0);
> +		return freq->freq;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct qcom_reset_map msm8917_resets[] = {
> +	[GCC_CAMSS_MICRO_BCR]		= { 0x56008 },
> +	[GCC_MSS_BCR]			= { 0x71000 },
> +	[GCC_QUSB2_PHY_BCR]		= { 0x4103c },
> +	[GCC_USB_HS_BCR]		= { 0x41000 },
> +	[GCC_USB2_HS_PHY_ONLY_BCR]	= { 0x41034 },
> +	[GCC_MDSS_BCR]			= { 0x4d074 },
> +};
> +
> +static const struct qcom_power_map msm8917_gdscs[] = {
> +	[MDSS_GDSC] = { 0x4d078, true },
> +};
> +
> +static struct msm_clk_data msm8917_gcc_data = {
> +	.resets = msm8917_resets,
> +	.num_resets = ARRAY_SIZE(msm8917_resets),
> +	.clks = msm8917_clks,
> +	.num_clks = ARRAY_SIZE(msm8917_clks),
> +	.power_domains = msm8917_gdscs,
> +	.num_power_domains = ARRAY_SIZE(msm8917_gdscs),
> +
> +	.enable = msm8917_enable,
> +	.set_rate = msm8917_set_rate,
> +};
> +
> +static const struct udevice_id gcc_msm8917_of_match[] = {
> +	{
> +		.compatible = "qcom,gcc-msm8917",
> +		.data = (ulong)&msm8917_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_msm8917) = {
> +	.name		= "gcc_msm8917",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_msm8917_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
