Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8FDCC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB16B40944;
	Fri, 16 Oct 2026 06:43:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q6Ln__FuHRPk; Fri, 16 Oct 2026 06:43:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8416640955
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792132992;
	b=GR5b0ZZ/36SFAM87Ce8uRBs/7gz2B3bdSkIH5jbK6KyQDvpQ6IJrD3JFve2GtwQKZaon
	 JbBJf6A2WUeYLC64SJvMedMTwZvBwgtZAhwp7KSRk/K2pn/sru+4y9b5QPs332AwPOEBl
	 V+oaqo2YJnGMa1UWft15xjo7axnUdK4lHmRnSmQh2xEmi3aaREKGgICBSyCz5Z0pJ0elk
	 FnlefYPd985JgzpxV5DZjyPdauKaz+rHspDowXdYOXMrl1RnSWHyzBh2fqDyzFI5l11er
	 3c1qJ1Ki9AccYKsleYlYuHmxVPJIOv0g6HW/jWmfDJgTrS8t8HspiynoFcajd/qrxjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792132992;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Content-Type:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a9wQ1G6Q0RVEF3OnjlHtXM1mBao5wWhALQCbYhwQun8=;
	b=lr6MKcBVTi9E/lL3y/RTSqd7O/f37aeeca2mJcAxa2g1BvI/lE5XEdVde1LxLDDu4RTR
	 yH7dbrCyE8XHK6B8awP3IBXItpRfzNPqTPK75dsuO8N3iXMkQsuHb0iYA7zOqKa55gVuk
	 S48oJKhOrXv/NcGmM3sbiTATek7+Ew2C3lCrkuPvnbFO84l6nCR8SEoq0T5teSh2RCPwk
	 Y9eeoPVBzyc1C4nnx8PPhDn44DNRDM4cbcm4xr1GL+v4/XmDnhlxPvj0muIeUgnHGFj4R
	 4gsn0KRQCzAqjphmTxOe16A1/if/DVScKVO4LPLpRsmd0HoxqygUzf7zLFMMBblWj0A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792132992;
	bh=a9wQ1G6Q0RVEF3OnjlHtXM1mBao5wWhALQCbYhwQun8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nfIGtvGbCMME95R62u0c7mOz2/aWSqMFzdBdjVd1spBeAD9TRl/NtNAEyw8zUo+c9
	 yqLoLSUOYQ/k8sfhSguucuuFhN9P1V4Bg7zMW/GiDiJrFrQxNGagQ7/ze0Cm8FMe2E
	 W6Kgr56p+oZQQR3kx3mTWudodWCt3pzvD7yQA64pf9WiJWtrImgbdGA8DLXQ9Icj6u
	 PuAQtqL9UwN5N/gOJCKIypSn0Z+kyPm/YeCzgasVFJHpqceQPM/C0PdKZ3MjFUO0wn
	 12U6vpavTYWCFAZL3EGrxHoXmlN65X/FNwmuNrOtYzbUNQmo6FdSKllSPFkkuExqGl
	 Gy5rbpFC/0J4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8416640955;
	Fri, 16 Oct 2026 06:43:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0780879D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0DA481291
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rb0YLCwV5KLN for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:43:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E91C80A5A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792132990;
 b=VFeQMLnpYVRC/zgsNqc+/zqLLkEgb2HS+xvTa3xZLdBMNRE5XqVqglhV7Ie7cTq9HP9L
 1hHTi+2GFYBgYCxnPQ6GfchxrYkKguOXZj99HmXOVEQ91KOZeb23qyYn3DY7SUaPyFqcn
 34OuCI3Hr/f8dthQtaX2O2xQFEcRu9C5clSIXxhm6PW+y/lArNz4EM+gV1z6YmyB3Cq++
 u1qMJOyXQOI8dpm5B6DapzrHpvV0QN0FrY+uGUQGXSqBswLRACsghM32yj2+gYb56zlMX
 n0cyBDVsrlohk9/mTON5ztUclTofZOdUBBeSmvvicLOOUmyPfUcYGrPPVC9fEsodTGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792132990;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:
 Content-Type:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 References:Content-Language:From:In-Reply-To:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=a9wQ1G6Q0RVEF3OnjlHtXM1mBao5wWhALQCbYhwQun8=;
 b=oXDQDOfdsHUj35L6mmCnlk3Um2WNhiifQ3LOZRkEeUq7+wARHei1sF3VFOhZbnqm/cgx
 87go9udJRaD5qwHVOycTU+CTrR1xGq5XXPMyjWqoVEeDtFYxTKVKxVKWCC7RYFB9XbOny
 N/oo+SAhntbgEpMFH3gxc1vyYS5fMcO3NRpoZHTwLbfJBs66ojoxCl2+SJF6QjNvWWs5v
 4WlaemmOKQZ71SnJuCNqpH08oOFSH8eHyb1bU6TRYliMLE5wxwOEsFYnjss/IVULx2w//
 IXCdm1qYDm9RsNYIafxa0HaINU1K6malhfc0CyIfnI7wrtzH9BthbclCCoPilko5pHA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gaS8f76u; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NoHLF7OQ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gaS8f76u; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NoHLF7OQ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E91C80A5A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:43:09 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FNChYY557566
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=a9wQ1G6Q0RVEF3OnjlHtXM1m
 Bao5wWhALQCbYhwQun8=; b=gaS8f76us4QXKQKtcTRzGnBfaGi/Oc3OGnIjcZvL
 J9p0JPJILR+VRH7s01gEy6Jp+y2nCfW5xNTmtjizTyuLzOdceF1pjcCSIgVABw/e
 MpcscqG0SbW/ACzO9aSTgP8BfOms2p01e/IOOsvIIA1Hvl+uDudnt6MBLalPTZll
 TcaEKq8TYmep1DtDT09qXTtH8VjnaMEqzsUJ82lglzWo0RN+wkpJuGXgV+IU6/j8
 z3QsHKUJROU9SklOlUv9R4PLMK77uUsxp6CEc7hanmA7wsdTXgSwqn4padZBhrqn
 uIg8ekI2u0r0z/h+xY1rPYu/UoSHBEBse2OHW7fU2o+zjQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8a89adk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:43:08 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-143826c4a13so3754749c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 23:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792132988; x=1792737788;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=a9wQ1G6Q0RVEF3OnjlHtXM1mBao5wWhALQCbYhwQun8=;
 b=NoHLF7OQTtp4NBWDTqT/vhGv8sjOwGXY9DL+bn7c8aKET3x0lLtgWD/wFiVADIaYR3
 51wcT4Mh04YPzCTkG4m8pCJ/8hcAci3ZPRwZWopTAopAQNF0zh8205aqQff1OIj7dre/
 WnLfOeS+fhisFZuejS5UGPW0J6YJXwD/u3do5DjKch90xFWZM873cTDipmEhw05D9sN9
 XIK67JajmTiVFmrUGmQbvjmHWj50vDK9fmzWLAADhP5l7YuR0XlhZF9zmxZvdQsFq5eh
 +hFFgF6Lgwbs/unCjFfc6ndqdr9L2ph1cYtGxZ7jQozRaeJbB3EAB2qkTtGbASKQwQxR
 050A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132988; x=1792737788;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a9wQ1G6Q0RVEF3OnjlHtXM1mBao5wWhALQCbYhwQun8=;
 b=uMmEvicN9uPkKZv0+M9Ft9gtk6ZVWkyo/O/sJPNgHT1A1e4PLVP2SoJGK8RpB90Mer
 NBKBbP5Plq3q1sWczv9y+hDzefq9+ykl7+suT18LENQZnjSdqzsplrlLxKveXEVBgxKv
 EPWNgp1iCS55FK6VoYmicPqB6M7ubuXqlAa/y/9rvkZfMvJdsZCoRqVhKF9sUOphBCLv
 0knRFg49ehvu6BG5OOczqCb7032bdgCxCLNkX/EmMAZbmggI2LJqvVTuTJdIa1Nex0nw
 RxJbgcnxEpIx9kWcd8vlaNMPhe7uMCPEC+pfSn1TIZlcz6Qt6wqMfaqoDSCQ39CWGGQG
 phIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBypGQgPBniIxvagf+gwXX5UCuNR94s+vxD+kVQgS8Bazw6d386S5Q0nu53b5V9rw/KrhdoqeqI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL+RKLcq02oCEfnRzb0Kh4q994Zl64anZvOeaj7+YQuF6w89ZLr
 JQTUTMUFduqBy2WS1HWDGkzFk/o1aXaG9ekkuvYXLlcpOHxnARsOfD1zpWnbBgyyoXlo2PSXOfa
 dtwQ0RVxLb9aadgjSer+OvMvbyectXpvB6IcT2N4NaFe7JAZy3LKDMQFrdmpFMW1XcDMMk9M=
X-Gm-Gg: AYBFou2Gka2N1rE6nddrLp+PahynNYkvtOWZfZXXX42XORR9Bwm1hqxRE4iDD8vp78Q
 okz4UgToy+Wt6faghuOnBuG4PizuSStVO9r8rC4nSTLv9m4XWZXfEf9dNeAoY3aj7P/WjpABC7e
 0LgOhwNsBWXZF0fLUYWxXgIItQgEZQs8UfFeO/zSy/WVtnBzLnqj/qhLNMpjJDcQK5C++nY6rg5
 DpAy7FFxAjui4AnnMj31KMwHMZ7cD1+qYAtGdlB/6XfZfNxqESdziCbgiObP08AVfnMO8YIKcCe
 1PWTgjY4FV0wKsA5aRRdg/zIspj249r6ufTh/+nQSWMyx5SxOPjmTa3GUqeJJ4SDFd1nyl6odsn
 NF1ZMxj4qV7RSUFPE7UR7MSd0kjJNBOYph8CSwB0FlZqEzO02gg==
X-Received: by 2002:a05:7022:7f04:b0:13d:974:a2c6 with SMTP id
 a92af1059eb24-16a5ad07499mr24153710c88.7.1792132988002; 
 Thu, 15 Oct 2026 23:43:08 -0700 (PDT)
X-Received: by 2002:a05:7022:7f04:b0:13d:974:a2c6 with SMTP id
 a92af1059eb24-16a5ad07499mr24153690c88.7.1792132987378; 
 Thu, 15 Oct 2026 23:43:07 -0700 (PDT)
Received: from [10.152.193.224] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa411sm3620326c88.4.2026.10.15.23.43.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 23:43:06 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------dB9a517vQT2ET7FWCDTuu0qf"
Message-ID: <0d4bbd89-e30c-4dfa-ab6e-9b84ffb00c65@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 12:13:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: sa8775p: Add QUPv3 wrapper 3 SPI clock
 support
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20261013-b4-sa8775p-qup3-spi-clk-v2-1-bd6365d81a7b@oss.qualcomm.com>
 <9993604a-8d24-4760-bf66-c77947b81f86@oss.qualcomm.com>
Content-Language: en-US
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
In-Reply-To: <9993604a-8d24-4760-bf66-c77947b81f86@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyNiBTYWx0ZWRfX0JXZonXZ9f3s
 2DY9qA0Ud3+2fdi+ZTDAmSSzerCbVo/0rCMrxhbCHzdiJ5ijVZHinrXBta/Q7LFvdXM+Yg7eXpt
 oQXYvNE8Tdf43yrHc34vhacCRqyh7jw=
X-Proofpoint-ORIG-GUID: zjpZq8d4L5Jq9H06JU-plGZV5kwNjzdl
X-Authority-Analysis: v=2.4 cv=GJadgeNK c=1 sm=1 tr=0 ts=6ad1c77c cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=bC-a23v3AAAA:8 a=r6LF-9bVAAAA:8 a=EUspDBNiAAAA:8 a=N6qlLznhqgA-bRTFu2QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pKXTFlbrzJDd-ySLThAA:9
 a=RxDeo7ExzyLyw_Mi:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=FO4_E8m0qiDe52t0p3_H:22 a=sL0kBDm1BSwOBZmmfnro:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyNiBTYWx0ZWRfX6Z1Lf9mb+ajR
 m2IVjaecx+GYJHNyz5QmZX8Z+clEOndl4aSs5u8/pP8985ySjyfVQ6fiKXBbzetqmaxp4nv4Ww/
 WjRCbjZ0lUjk6voLzx+eSBstnhQdX9wyLXVX1ficPGIjM7Wp0HmuUwrs10s7ajcyRA0YlXfKqxX
 iX/H6aKlfh5y3p3nvhcnAEzlgVb7efpyz402K3bR9+qpCAvUKloAw9xm8IOmJLrzAPKbmuZDSsS
 494o6bG1e0M78IZCPndEQ2IwRKHGWD5K/7s/59iyWbOF7LhSmpQJTTOf9t8EacUJ+rT+/ovyzqi
 fcZxOIRtd7bElni/9+T673kvclxHcFSbTXq6vHxkhVwSU3uXY+nGOkxUrx6o160r0zv0bhaQ0pg
 914CtzTW2FliTbs3YxDuQwDYwXtvFKKrGcGgkzdig/J+qm0uG9wsDPagxMyii3q/Ugt3oTFREa3
 6i+lkx6/1ghWnkrvtog==
X-Proofpoint-GUID: zjpZq8d4L5Jq9H06JU-plGZV5kwNjzdl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160026
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

This is a multi-part message in MIME format.
--------------dB9a517vQT2ET7FWCDTuu0qf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Balaji,

On 10/15/2026 11:18 AM, Balaji Selvanathan wrote:
> Hi Vandhiadevan,
>
> On 10/13/2026 12:05 PM, Vandhiadevan Karunamoorthy wrote:
>> Add the clock RCG, gate bit definitions, and frequency table needed
>> to enable and configure the SE0 (SPI) serial engine clock on QUPv3
>> wrapper 3, GCC_QUPV3_WRAP3_S0_CLK. This is required to bring up the
>> GENI SPI controller on QUPv3 wrapper 3, e.g. for SPI-NOR flash
>> attached to that wrapper.
>>
>> Also add the wrapper's M-AHB/S-AHB clock gates, and the QSPI/AGGRE-NOC
>> gates that are auto-enabled alongside the SE0 clock.
>
> Pls mention the kernel commit this was taken from.
>
> With that,
>
> Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Thank you for the review. I have posted an updated patch incorporating 
the suggested change and mentioning the corresponding kernel commit.

Regards,

VK


>
>>
>> Signed-off-by: Vandhiadevan Karunamoorthy 
>> <vandhiadevan.karunamoorthy@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Rebase on top of upstream main; no functional change
>> - Repost: v1 was sent with a wrong author/Message-Id domain (test.com)
>> - Link to v1: 
>> https://patch.msgid.link/20260924-b4-sa8775p-qup3-spi-clk-v1-1-8e9c297a20b6@test.com
>> ---
>>   drivers/clk/qcom/clock-sa8775p.c | 35 
>> +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clock-sa8775p.c 
>> b/drivers/clk/qcom/clock-sa8775p.c
>> index a7bd6c43004..9ac914802a3 100644
>> --- a/drivers/clk/qcom/clock-sa8775p.c
>> +++ b/drivers/clk/qcom/clock-sa8775p.c
>> @@ -18,6 +18,7 @@
>>   #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR    0x1b040
>>   #define USB30_PRIM_MASTER_CLK_CMD_RCGR        0x1b028
>>   #define USB3_PRIM_PHY_AUX_CMD_RCGR        0x1b06c
>> +#define QUPV3_WRAP3_S0_CLK_CMD_RCGR        0xc4154
>>     #define UFS_PHY_AXI_CLK_CMD_RCGR        0x8302c
>>   #define UFS_PHY_ICE_CORE_CLK_CMD_RCGR        0x83074
>> @@ -50,7 +51,27 @@
>>   #define GCC_QUPV3_WRAP2_S5_CLK_ENA_BIT BIT(9)
>>   #define GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT BIT(29)
>>   +#define GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT BIT(20)
>>   #define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
>> +#define GCC_QUPV3_WRAP3_QSPI_ENA_BIT BIT(26)
>> +#define GCC_QUPV3_WRAP_3_M_AHB_ENA_BIT BIT(27)
>> +#define GCC_AGGRE_NOC_QUPV3_AXI_ENA_BIT BIT(28)
>> +
>> +/* QUP Wrapper 3 SE0 (SPI) clock frequency table */
>> +static const struct freq_tbl ftbl_gcc_qupv3_wrap3_s0_clk_src[] = {
>> +    F(7372800,   CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
>> +    F(14745600,  CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
>> +    F(19200000,  CFG_CLK_SRC_CXO,        1,   0,     0),
>> +    F(29491200,  CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
>> +    F(32000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   8,    75),
>> +    F(48000000,  CFG_CLK_SRC_GPLL0,      2,   4,    25),
>> +    F(64000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,  16,    75),
>> +    F(75000000,  CFG_CLK_SRC_GPLL0_EVEN, 4,   0,     0),
>> +    F(80000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   4,    15),
>> +    F(96000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   8,    25),
>> +    F(100000000, CFG_CLK_SRC_GPLL0,      6,   0,     0),
>> +    { }
>> +};
>>     /* UFS AXI clock frequency table */
>>   static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
>> @@ -148,6 +169,12 @@ static ulong sa8775p_set_rate(struct clk *clk, 
>> ulong rate)
>>           clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
>>                        freq->pre_div, freq->m, freq->n, freq->src, 8);
>>           return freq->freq;
>> +    case GCC_QUPV3_WRAP3_S0_CLK:
>> +        freq = qcom_find_freq(ftbl_gcc_qupv3_wrap3_s0_clk_src, rate);
>> +        clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP3_S0_CLK_CMD_RCGR,
>> +                     freq->pre_div, freq->m, freq->n,
>> +                     freq->src, 16);
>> +        return freq->freq;
>>       default:
>>           return 0;
>>       }
>> @@ -190,7 +217,11 @@ static const struct gate_clk sa8775p_clks[] = {
>>       GATE_CLK(GCC_QUPV3_WRAP2_S6_CLK, 0x4b018, 
>> GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT),
>>         /* QUP Wrapper 3 clocks */
>> +    GATE_CLK(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000, 
>> GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT),
>>       GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, 
>> GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
>> +    GATE_CLK(GCC_QUPV3_WRAP3_QSPI_CLK, 0x4b000, 
>> GCC_QUPV3_WRAP3_QSPI_ENA_BIT),
>> +    GATE_CLK(GCC_QUPV3_WRAP_3_M_AHB_CLK, 0x4b000, 
>> GCC_QUPV3_WRAP_3_M_AHB_ENA_BIT),
>> +    GATE_CLK(GCC_AGGRE_NOC_QUPV3_AXI_CLK, 0x4b000, 
>> GCC_AGGRE_NOC_QUPV3_AXI_ENA_BIT),
>>         /* UFS PHY clocks */
>>       GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0), 0x83018),
>> @@ -230,6 +261,10 @@ static int sa8775p_enable(struct clk *clk)
>>           qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
>>           qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
>>           break;
>> +    case GCC_QUPV3_WRAP3_S0_CLK:
>> +        qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_QSPI_CLK);
>> +        qcom_gate_clk_en(priv, GCC_AGGRE_NOC_QUPV3_AXI_CLK);
>> +        break;
>>       }
>>         return qcom_gate_clk_en(priv, clk->id);
>>
>> ---
>> base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
>> change-id: 20260924-b4-sa8775p-qup3-spi-clk-6c01d31b33ea
>>
>> Best regards,
>> -- 
>> Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
--------------dB9a517vQT2ET7FWCDTuu0qf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Balaji,</p>
    <div class="moz-cite-prefix">On 10/15/2026 11:18 AM, Balaji
      Selvanathan wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:9993604a-8d24-4760-bf66-c77947b81f86@oss.qualcomm.com">Hi
      Vandhiadevan,
      <br>
      <br>
      On 10/13/2026 12:05 PM, Vandhiadevan Karunamoorthy wrote:
      <br>
      <blockquote type="cite">Add the clock RCG, gate bit definitions,
        and frequency table needed
        <br>
        to enable and configure the SE0 (SPI) serial engine clock on
        QUPv3
        <br>
        wrapper 3, GCC_QUPV3_WRAP3_S0_CLK. This is required to bring up
        the
        <br>
        GENI SPI controller on QUPv3 wrapper 3, e.g. for SPI-NOR flash
        <br>
        attached to that wrapper.
        <br>
        <br>
        Also add the wrapper's M-AHB/S-AHB clock gates, and the
        QSPI/AGGRE-NOC
        <br>
        gates that are auto-enabled alongside the SE0 clock.
        <br>
      </blockquote>
      <br>
      Pls mention the kernel commit this was taken from.
      <br>
      <br>
      With that,
      <br>
      <br>
      Reviewed-by: Balaji Selvanathan
      <a class="moz-txt-link-rfc2396E" href="mailto:balaji.selvanathan@oss.qualcomm.com">&lt;balaji.selvanathan@oss.qualcomm.com&gt;</a>
      <br>
    </blockquote>
    <p>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style>
      <div
style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">
        <p>Thank you for the review. I have posted an updated patch
          incorporating the suggested change and mentioning the
          corresponding kernel commit.</p>
        <p>Regards,</p>
        <p>VK</p>
        <h3></h3>
      </div>
    </p>
    <blockquote type="cite"
      cite="mid:9993604a-8d24-4760-bf66-c77947b81f86@oss.qualcomm.com"><br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Vandhiadevan Karunamoorthy
        <a class="moz-txt-link-rfc2396E" href="mailto:vandhiadevan.karunamoorthy@oss.qualcomm.com">&lt;vandhiadevan.karunamoorthy@oss.qualcomm.com&gt;</a>
        <br>
        ---
        <br>
        Changes in v2:
        <br>
        - Rebase on top of upstream main; no functional change
        <br>
        - Repost: v1 was sent with a wrong author/Message-Id domain
        (test.com)
        <br>
        - Link to v1:
<a class="moz-txt-link-freetext" href="https://patch.msgid.link/20260924-b4-sa8775p-qup3-spi-clk-v1-1-8e9c297a20b6@test.com">https://patch.msgid.link/20260924-b4-sa8775p-qup3-spi-clk-v1-1-8e9c297a20b6@test.com</a><br>
        ---
        <br>
          drivers/clk/qcom/clock-sa8775p.c | 35
        +++++++++++++++++++++++++++++++++++
        <br>
          1 file changed, 35 insertions(+)
        <br>
        <br>
        diff --git a/drivers/clk/qcom/clock-sa8775p.c
        b/drivers/clk/qcom/clock-sa8775p.c
        <br>
        index a7bd6c43004..9ac914802a3 100644
        <br>
        --- a/drivers/clk/qcom/clock-sa8775p.c
        <br>
        +++ b/drivers/clk/qcom/clock-sa8775p.c
        <br>
        @@ -18,6 +18,7 @@
        <br>
          #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR    0x1b040
        <br>
          #define USB30_PRIM_MASTER_CLK_CMD_RCGR        0x1b028
        <br>
          #define USB3_PRIM_PHY_AUX_CMD_RCGR        0x1b06c
        <br>
        +#define QUPV3_WRAP3_S0_CLK_CMD_RCGR        0xc4154
        <br>
            #define UFS_PHY_AXI_CLK_CMD_RCGR        0x8302c
        <br>
          #define UFS_PHY_ICE_CORE_CLK_CMD_RCGR        0x83074
        <br>
        @@ -50,7 +51,27 @@
        <br>
          #define GCC_QUPV3_WRAP2_S5_CLK_ENA_BIT BIT(9)
        <br>
          #define GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT BIT(29)
        <br>
          +#define GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT BIT(20)
        <br>
          #define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
        <br>
        +#define GCC_QUPV3_WRAP3_QSPI_ENA_BIT BIT(26)
        <br>
        +#define GCC_QUPV3_WRAP_3_M_AHB_ENA_BIT BIT(27)
        <br>
        +#define GCC_AGGRE_NOC_QUPV3_AXI_ENA_BIT BIT(28)
        <br>
        +
        <br>
        +/* QUP Wrapper 3 SE0 (SPI) clock frequency table */
        <br>
        +static const struct freq_tbl ftbl_gcc_qupv3_wrap3_s0_clk_src[]
        = {
        <br>
        +    F(7372800,   CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
        <br>
        +    F(14745600,  CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
        <br>
        +    F(19200000,  CFG_CLK_SRC_CXO,        1,   0,     0),
        <br>
        +    F(29491200,  CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
        <br>
        +    F(32000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   8,    75),
        <br>
        +    F(48000000,  CFG_CLK_SRC_GPLL0,      2,   4,    25),
        <br>
        +    F(64000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,  16,    75),
        <br>
        +    F(75000000,  CFG_CLK_SRC_GPLL0_EVEN, 4,   0,     0),
        <br>
        +    F(80000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   4,    15),
        <br>
        +    F(96000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   8,    25),
        <br>
        +    F(100000000, CFG_CLK_SRC_GPLL0,      6,   0,     0),
        <br>
        +    { }
        <br>
        +};
        <br>
            /* UFS AXI clock frequency table */
        <br>
          static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] =
        {
        <br>
        @@ -148,6 +169,12 @@ static ulong sa8775p_set_rate(struct clk
        *clk, ulong rate)
        <br>
                  clk_rcg_set_rate_mnd(priv-&gt;base,
        SDCC1_APPS_CLK_CMD_RCGR,
        <br>
                               freq-&gt;pre_div, freq-&gt;m, freq-&gt;n,
        freq-&gt;src, 8);
        <br>
                  return freq-&gt;freq;
        <br>
        +    case GCC_QUPV3_WRAP3_S0_CLK:
        <br>
        +        freq = qcom_find_freq(ftbl_gcc_qupv3_wrap3_s0_clk_src,
        rate);
        <br>
        +        clk_rcg_set_rate_mnd(priv-&gt;base,
        QUPV3_WRAP3_S0_CLK_CMD_RCGR,
        <br>
        +                     freq-&gt;pre_div, freq-&gt;m, freq-&gt;n,
        <br>
        +                     freq-&gt;src, 16);
        <br>
        +        return freq-&gt;freq;
        <br>
              default:
        <br>
                  return 0;
        <br>
              }
        <br>
        @@ -190,7 +217,11 @@ static const struct gate_clk sa8775p_clks[]
        = {
        <br>
              GATE_CLK(GCC_QUPV3_WRAP2_S6_CLK, 0x4b018,
        GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT),
        <br>
                /* QUP Wrapper 3 clocks */
        <br>
        +    GATE_CLK(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000,
        GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT),
        <br>
              GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000,
        GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
        <br>
        +    GATE_CLK(GCC_QUPV3_WRAP3_QSPI_CLK, 0x4b000,
        GCC_QUPV3_WRAP3_QSPI_ENA_BIT),
        <br>
        +    GATE_CLK(GCC_QUPV3_WRAP_3_M_AHB_CLK, 0x4b000,
        GCC_QUPV3_WRAP_3_M_AHB_ENA_BIT),
        <br>
        +    GATE_CLK(GCC_AGGRE_NOC_QUPV3_AXI_CLK, 0x4b000,
        GCC_AGGRE_NOC_QUPV3_AXI_ENA_BIT),
        <br>
                /* UFS PHY clocks */
        <br>
              GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0),
        0x83018),
        <br>
        @@ -230,6 +261,10 @@ static int sa8775p_enable(struct clk *clk)
        <br>
                  qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
        <br>
                  qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
        <br>
                  break;
        <br>
        +    case GCC_QUPV3_WRAP3_S0_CLK:
        <br>
        +        qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_QSPI_CLK);
        <br>
        +        qcom_gate_clk_en(priv, GCC_AGGRE_NOC_QUPV3_AXI_CLK);
        <br>
        +        break;
        <br>
              }
        <br>
                return qcom_gate_clk_en(priv, clk-&gt;id);
        <br>
        <br>
        ---
        <br>
        base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
        <br>
        change-id: 20260924-b4-sa8775p-qup3-spi-clk-6c01d31b33ea
        <br>
        <br>
        Best regards,
        <br>
        --
        <br>
        Vandhiadevan Karunamoorthy
        <a class="moz-txt-link-rfc2396E" href="mailto:vandhiadevan.karunamoorthy@oss.qualcomm.com">&lt;vandhiadevan.karunamoorthy@oss.qualcomm.com&gt;</a>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------dB9a517vQT2ET7FWCDTuu0qf--
