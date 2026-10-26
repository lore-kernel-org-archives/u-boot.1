Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E3606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kluFecSJ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oQSywYd/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Khso1y5J
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 074FB606F4;
	Mon, 26 Oct 2026 08:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ocbexfHuYEqq; Mon, 26 Oct 2026 08:54:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4858D60649
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793004861;
	b=cFNMMLZKsXpyyRrgbeg2/z4gnfbDa4fwjD/OYVuWdk8ZLUCbdt5SoueUel9E4WpjtgCT
	 9YdQuxx62m86/z3fuO8Gaar2yEPwh+gzmSq7tWwB262HGkFyqWr7FnJUojIr+bNR+3R0/
	 32DPjpWtvaE1OzH3IgKXOXsJw7n5mNphE4sUhz+TqPm4fPEaiXly7RdltpXbYm7MPch29
	 J/iCqQNAwvzp/6rjhakNFogXR/PDzCLti+MU2Br9E5IbCKzjMzQK0TMJMTQRaiCtnvHE0
	 8+n+aV2HQYXIGl/9ldXgx7uywwSQQ6krpfXVa8rnntrIm2jvBBcshMNhi0bKLTJTQHw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793004861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/klcVPa5lWikzhsjQnwc6pnege6TpaIMfnKe/omQ4wc=;
	b=EgTCmLEIyGnNHfB9sR9c9BvG/Wnx8SlEpS3h6UPrrJOW0jHqPi5m7frcKIOq2tapnGUo
	 cwxynmcGfGYxFmPvRcpN7faaRkqKPSorB08eosIfAq82+Abeqtf2aizSAal/hRql/s4Ps
	 d5i/UwD9pfLEa6IGkl2hLuqcO0qzYImmVIz2gLxj+XrxUOUK3P/xlmGZPnk/PsMdpsouu
	 PI2ukdGk3AGy73fAOC3QzoUtn+1WKul6tLQVbp7ZawvkgLggWUI/n/Umv2tE2uZag5vl9
	 XcMMMMGUuDL1Ztb1jSvb8TVKsOTQn/nUondMQHwXVwax91frqduvuJxQXZSUsL6KgTQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793004861;
	bh=/klcVPa5lWikzhsjQnwc6pnege6TpaIMfnKe/omQ4wc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kluFecSJBrxnMFNovriWn6jOz53TefWcpGZdIwGQhp6L5MrHQrEvdJMfjSCcAiuUf
	 hntfNJnQs+3dvYVZK9rgq52wvAGf6+Fl/fSCIy6u8ljOXdIj9ImXhDJU5EeZ2PrgYH
	 mLq+MriUUuUyuikCFcaDGQiVHW+cQH1/2ucufSmzdIm3YxBy/uDNIafovWGzIFGCPf
	 baeuAZzFhCe4jnDfaMgDz8ZKl4KqGRwGKMpAoRQ/1uuDBcLcqDQccg8luQW+7T5dPd
	 kGhs5VCS0H16/51sD3er2jqx6qEABbEFDtr6rtz6kTfTwqjP33HTmeuzwwu9ubUMY6
	 XgLOHzwWA0FkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4858D60649;
	Mon, 26 Oct 2026 08:54:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E285334
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80089405A7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:09:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D_j012hHYDCO for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 07:09:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A138B405A6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792998550;
 b=IkNnLSA4PXKB1HnJZASlcLrhsqOfnLevTkEooYSofMh4T1fzBO5SXSjhcMPzIgJbLynb
 mrm5xPjMMZBeU7nqN0i53S5C9B7+cU0iOOZVKu/qZIwCkd3kHkoTcLwtsiio0BpLT+15f
 kUjX+gRi2uOnXgw8PDkn6hau8NSP8uPeFB2+NVo/DX9cRbqlq0xSissVbXjWkroFLVe24
 HMHxRnuPVA39HM1/JQxykaQwSx0XX9r4ocSBqUJiqSEMTGnpEyPS4HS5e0Bm2/+LUV9Hy
 2LsMtqxgiiqfw4cwc7JXVfBR4+3T+MoCaw/QgKJKg/bG5W2p7eXl34gIxkglt4dp2uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792998550;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=/klcVPa5lWikzhsjQnwc6pnege6TpaIMfnKe/omQ4wc=;
 b=BSmiz1Maqetxlj7dKIAHvWCkJaCrbXTX7DH34S5XGi6tAv1lQUfvOR+4bOxyDawh8bMw
 +it6hxUhYzstd/5y672gpkc5Aeh6ccorlflm0S1ZaZLP3gEa5RTe8ily7weQcYHgMTl8J
 4URM8QOW6V2WMoICtjjXz0MYwMk1BthsV7gHxBKR+ihOQW75KMno5vP1oYsoapc1SVZib
 g+TS+KZK1rYTwmVpk9mkzWLmFgT5q7ZolXRlb6yhf5+KUvnWjqT6Oocf3I2xi7/p6JTM9
 XjZcsijrAdo94jqv9FbhF44EtcOg+wAsBPTmxhJXnMB82Tp4H0Vjnj9S3udiEl+TxwA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="oQSywYd/"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Khso1y5J; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=oQSywYd/; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Khso1y5J
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A138B405A6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:09:08 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aPRS2222515
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /klcVPa5lWikzhsjQnwc6pnege6TpaIMfnKe/omQ4wc=; b=oQSywYd/iB0fNLJb
 l2A/5xNCD3g653hhd+kDgS9i0NMI2ljvQcpqjT0EfHi9eoLDv4ksRDnDOUwsYyQx
 OJtDn7W5Geb1VZvJ7K6yQ+3qoEnyRBnDo4+57xNN8RJfHnj2su23w6NZoz2OWucD
 cK3yRc1eBGPSOmC0wE/Rjm3MTHZzhKLPijvs7KOaeygLHy/RRnaojAsmM4pB91hV
 4Sq5c6d6dRpv59w0JxVGwTVBKQJqFHn3yldUlwJdbCyb6kO66CLVENUxhmW3n61s
 V+BlymY5R0nee2OZgZbKjQ75gO5Ok7ytxnkkZ/9+y8YvskSwlJSgle0iTUzVfgo2
 LxO1Rg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd8yxa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:09:07 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-988b6210181so22442241.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792998547; cv=none;
 d=google.com; s=arc-20260327;
 b=RbkCsCZMv25no0cIGE0O8X13z27EaVrq9QpSblpXytZr1s1NMSn3ZmIt7VBSTmkyrA
 L97sIfyLyDUKHGYTL/RUD/OJz71h01rWacFLpqLt1God5iEH1MqJVy/nDwB0dCW8STiq
 BPqBI7gRZFTEZehuaZU3UmxjOt9TespSKDF3d3Pqq6326UWOz7ObkFCXHzqenUdDL/jf
 HiOfajx4Kz1Q0XiHgqGKSTnLfZJ9afUqgiy0cca7+nfkCWPvwdKFpRm2qcXh7P+GnTA4
 lipE1Nfs+U/Tj9i5O7TcAgtzGtVEWp+0ei9Y3MkEvCk5pxHmTpbjKet8c4cz1N7FdikK
 SwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/klcVPa5lWikzhsjQnwc6pnege6TpaIMfnKe/omQ4wc=;
 fh=GKDlMD+5P3E+S7j9MXtKsi6vW3O73Ar5s2d+QJMDjMo=;
 b=spHu3DW35JyMsGJfYZT13cTEeVqbmlI7yxZ8//uCjv2jQIqdTRXlZAuVwsgNILMidK
 uf9InwtgcGoGi0tQuzzFsvVA2uCmVMEyyo3ZmXIb+NXsqrvy4HmNACxOFXA8Nyl9UuRe
 EPDGNzurEBqTuu6mKh5IrRnZA4wWf98pgFAoBV1tNS4TEYt2vpIumXpgCmFegMxvp9a4
 UsLBlWhxkyeuXlwmw1ca1OXJkK1/S686WHCnStuK9WbGGl2TjIiEY8BwlgLYIXhvcVr3
 70gZUgNXzXwGAdieQ+vLDG5BUua5eqXYUeVCFxvXGaup5sqfBFGks9JvqXoaACB9L3hQ
 SwRw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792998547; x=1793603347;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/klcVPa5lWikzhsjQnwc6pnege6TpaIMfnKe/omQ4wc=;
 b=Khso1y5JL4D6kYlDGRcC/FlpbsHx9BikHkv93V0TOeUtyPNRQTjbdohgEZS5MJkrZE
 xEyZCcF2Vpud6MhGVtyYVurpJ/Ar1CY0Evd+++gobwUFMv+/crsO/nzf2DZMKJABedyE
 e/glBccWjyrUt3Iqi9vmsdx3iQS9pvVUicUejm45M/62E9m+FMZHpQGJWgrI547nSGYA
 QMu5JFqAVr5UhXVYKoRMi7yLxBGfcRu3WvaoQ7/3WFgjLcbE3vNchTlm1lbuLtKeGvxN
 NLMXcdKkSF+dd/nYPXGdSJGphw8mNanZZ3B0+/e98nt7L3VIMj8tR+tiY/frgaRxF0yN
 D4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792998547; x=1793603347;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/klcVPa5lWikzhsjQnwc6pnege6TpaIMfnKe/omQ4wc=;
 b=uJaXTga1XBG9MPYT98Fi/kI9kkPbYT5VNWC/hi7JxIObCVJf3XGLma8ZMCmtwWU4q6
 grER3tgXfZFSzP5T7TGRhwg9Ejym5kjSlyyqKHhdOBvnQrue1TUQgLc3nMsBV9hCLqn+
 kqCRFVxd0u+lxKWQxFCTAntN6RjYHjNvl+gZXmvQX8xJUjyI4Me3UYHlgoGRMvNnXoHu
 C3rWoRyy+TDCmG7HkkJEj7QzkAO2FXh7DIfp6jEDp1GUYkege8vEADtRrglcC10eDPAM
 FLDv1VpQKVNglsAx8wtLZ5+Z4eYpz1nzrzAhL10AUWB+RSzEoHcowMuAwP+lCPFQIlCB
 Nj5g==
X-Gm-Message-State: AFq9FYLK5oVcORrBwBgiNEicCadzGzfSNHmxWRYJT4nCtw9fejd+TV8e
 SUKHw2i0QfR6YZALiKTyxQumi4tCGhvlUnRNeauXAs/fg3BbslTD+qWlKyALHYSe/O2jRyO5QLq
 Brcv91AmQlfm9r+85La1SFRNB8yTeFZ4NIxetNbYSZAyu0h0EVQBQmXoJKBf0PSVURpplygdmg4
 QjI2s0DAMg/q7+Qxl5bE1mqRnB+xrt+yiEUo9tAtvR7R+ysg==
X-Gm-Gg: AYBFou0Em/4crD75fecek1ctIVdixjBKQTg7T1AF0i7GdR5v8iUL6LLMDaQ8k7jqjF/
 V7GZuV4m81pb4vP+vug6YET4WXccJt8ALLEaw9PbCkb6UZRnoM65R4kjAd7PLK0/ejoi1g6usJ4
 HAHSfzwoZ/bSmbDX+ff0HW3IUUffb0YY8R2rChlkqTBA10IUI+IXD9kruBy1o=
X-Received: by 2002:a05:6122:1d01:b0:5ea:9c73:eddb with SMTP id
 71dfb90a1353d-5ec2bff5089mr1209543e0c.2.1792998546556; 
 Mon, 26 Oct 2026 00:09:06 -0700 (PDT)
X-Received: by 2002:a05:6122:1d01:b0:5ea:9c73:eddb with SMTP id
 71dfb90a1353d-5ec2bff5089mr1209528e0c.2.1792998546064; Mon, 26 Oct 2026
 00:09:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
 <20261014-rpmi_v4-v4-2-d53d34a49780@microchip.com>
In-Reply-To: <20261014-rpmi_v4-v4-2-d53d34a49780@microchip.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 12:38:51 +0530
X-Gm-Features: AclHuK8OQTgEzGmJxVx9krxyTkqMjjd-IP67HspQrZ7B0u3hDmfDvj-fvHVYUWM
Message-ID: <CAPxK-6eEg4AdPOB70gBM6_tZt6y-CurTc44UYxydBqWAFNPepw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] firmware: rpmi: add support for the SBI MPXY
 transport
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ufSJFfgipA9I7CjrIcG72z5hqr1A90Xl
X-Proofpoint-GUID: ufSJFfgipA9I7CjrIcG72z5hqr1A90Xl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfXw162bEDtobL4
 PcYmQdG6BdzSv1But4Me6PT4kmE3+edPwWifR7y6qW61wsyClIcvHICtBvDhdpB9Giu1oujJl2x
 bPCZ1vR7MzJzGvnNkhcDYBLZTMEa3wALQjgYrz4KulaxfGT3LJWjutYpQXmbtYvAUtiEVGbFc3y
 PjdenKNnkjlzxg+1Z3sGGC4PQIQ52Wn7nyXSQaspvs9sS6V+kXWUx5N1fbdRr6L7NUmuB2IEVr5
 SP1ETi4qWQdONo0IMnB2UGUtzrx1z+5xMauopAaj2W+G36WCL0FmIdaVSAonWF+6ZjyOr22tKmH
 aam0yKjO/gsRrU+s9fjBYyzfkGj4aufMLO9nF6m502IUkz2KzkuiwWK/ua9jAa03KWuH+qeJuSu
 tg+ii613Cb6qBVkoUqDfnBobefpX6dgrXhCjRrF3uWFFqhYxTjj3ThyZrjm9KUZ/JhhQuWvFTBh
 ma2eCaIydGsDBCUnawQ==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adefc93 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8 a=XYAwZIGsAAAA:8
 a=Wqw0UAraFnB7B5Dxd3sA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfX+uxMVKVg3Kcg
 /i+0SKdPmpJcfI/DQmS2/vJrqIVsmyeWEYFi5hn1XWh0dVdmbcjU9VcHAoxNoXFOVurK512+fhc
 7MwMXlyNqtv2nSB8AZ+HVXS/IDgyvHE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260028
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:54:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Charles,

On Wed, Oct 14, 2026 at 7:47=E2=80=AFPM Charles Perry
<charles.perry@microchip.com> wrote:
>
> This adds an RPMI transport driver for the Supervisor Binary Interface
> (SBI) message proxy (MPXY) extension [1].
>
> This is for S-Mode U-Boot where some supervisor software (such as
> OpenSBI) runs in M-Mode and handles the low level communication with the
> PuC.
>
> [1]: https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
>
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
> Changes in v4: None
> Changes in v3: None
>
> Changes in v2: (from Yao Zi review)
>  - Reorder headers
>  - Remove struct sbi_mpxy_rpmi_channel_attrs and struct
>    sbi_mpxy_channel_attrs for simpler u32 arrays
>  - Don't null check pointers before free()
> ---
>  arch/riscv/include/asm/sbi.h          |  57 +++++
>  drivers/firmware/rpmi/Kconfig         |   9 +
>  drivers/firmware/rpmi/Makefile        |   1 +
>  drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 410 ++++++++++++++++++++++++++++=
++++++
>  4 files changed, 477 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 47124dbaac84..10e03257d8e6 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -10,6 +10,7 @@
>  #define _ASM_RISCV_SBI_H
>
>  #include <linux/types.h>
> +#include <linux/errno.h>
>
>  enum sbi_ext_id {
>         SBI_EXT_0_1_SET_TIMER =3D 0x0,
> @@ -104,6 +105,17 @@ enum sbi_ext_dbcn_fid {
>         SBI_EXT_DBCN_CONSOLE_WRITE_BYTE,
>  };
>
> +enum sbi_ext_mpxy_fid {
> +       SBI_EXT_MPXY_GET_SHMEM_SIZE =3D 0,
> +       SBI_EXT_MPXY_SET_SHMEM,
> +       SBI_EXT_MPXY_GET_CHANNEL_IDS,
> +       SBI_EXT_MPXY_READ_ATTRS,
> +       SBI_EXT_MPXY_WRITE_ATTRS,
> +       SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
> +       SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP,
> +       SBI_EXT_MPXY_GET_NOTIFICATION_EVENTS,
> +};
> +
>  #ifdef CONFIG_SBI_V01
>  #define SBI_EXT_SET_TIMER              SBI_EXT_0_1_SET_TIMER
>  #define SBI_FID_SET_TIMER              0
> @@ -132,6 +144,14 @@ enum sbi_ext_dbcn_fid {
>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
>  #define SBI_SPEC_VERSION_MINOR_MASK    0xffffff
>
> +static inline unsigned long sbi_mk_version(unsigned long major,
> +                                          unsigned long minor)
> +{
> +       return ((major & SBI_SPEC_VERSION_MAJOR_MASK)
> +               << SBI_SPEC_VERSION_MAJOR_SHIFT) |
> +              (minor & SBI_SPEC_VERSION_MINOR_MASK);
> +}
> +
>  /* SBI return error codes */
>  #define SBI_SUCCESS                    0
>  #define SBI_ERR_FAILURE                        -1
> @@ -139,6 +159,43 @@ enum sbi_ext_dbcn_fid {
>  #define SBI_ERR_INVALID_PARAM          -3
>  #define SBI_ERR_DENIED                 -4
>  #define SBI_ERR_INVALID_ADDRESS                -5
> +#define SBI_ERR_ALREADY_AVAILABLE      -6
> +#define SBI_ERR_ALREADY_STARTED                -7
> +#define SBI_ERR_ALREADY_STOPPED                -8
> +#define SBI_ERR_NO_SHMEM               -9
> +#define SBI_ERR_INVALID_STATE          -10
> +#define SBI_ERR_BAD_RANGE              -11
> +#define SBI_ERR_TIMEOUT                        -12
> +#define SBI_ERR_IO                     -13
> +#define SBI_ERR_DENIED_LOCKED          -14
> +
> +static inline int sbi_to_linux_error(int err)
> +{
> +       switch (err) {
> +       case SBI_SUCCESS:
> +               return 0;
> +       case SBI_ERR_DENIED:
> +       case SBI_ERR_DENIED_LOCKED:
> +               return -EPERM;
> +       case SBI_ERR_INVALID_PARAM:
> +       case SBI_ERR_INVALID_STATE:
> +               return -EINVAL;
> +       case SBI_ERR_BAD_RANGE:
> +               return -ERANGE;
> +       case SBI_ERR_INVALID_ADDRESS:
> +               return -EFAULT;
> +       case SBI_ERR_NO_SHMEM:
> +               return -ENOMEM;
> +       case SBI_ERR_TIMEOUT:
> +               return -ETIMEDOUT;
> +       case SBI_ERR_IO:
> +               return -EIO;
> +       case SBI_ERR_NOT_SUPPORTED:
> +       case SBI_ERR_FAILURE:
> +       default:
> +               return -EOPNOTSUPP;
> +       };
> +}
>
>  struct sbiret {
>         long error;
> diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfi=
g
> index 54fd77ad8f48..708d931263ff 100644
> --- a/drivers/firmware/rpmi/Kconfig
> +++ b/drivers/firmware/rpmi/Kconfig
> @@ -7,3 +7,12 @@ config RPMI_FIRMWARE
>           protocol for communication between an Application Processor (AP=
) and a
>           platform microcontroller (PuC). The RPMI specification is avail=
able
>           at: https://github.com/riscv-non-isa/riscv-rpmi
> +
> +config RPMI_SBI_MPXY
> +       bool "RPMI over SBI MPXY transport"
> +       depends on RPMI_FIRMWARE && SBI
> +       help
> +         Enable support for transport of RPMI messages over the message =
proxy
> +         (MPXY) extension of the supervisor binary interface (SBI). The
> +         specification for the MPXY extension is available at:
> +         https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
> diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makef=
ile
> index d69c718d150e..71c4aeaed910 100644
> --- a/drivers/firmware/rpmi/Makefile
> +++ b/drivers/firmware/rpmi/Makefile
> @@ -1 +1,2 @@
>  obj-y  +=3D rpmi-uclass.o
> +obj-$(CONFIG_RPMI_SBI_MPXY) +=3D rpmi-sbi-mpxy.o
> diff --git a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c b/drivers/firmware/rpm=
i/rpmi-sbi-mpxy.c
> new file mode 100644
> index 000000000000..9ccca0eb59b2
> --- /dev/null
> +++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#define LOG_CATEGORY UCLASS_RPMI
> +
> +#include <asm/io.h>
> +#include <asm/sbi.h>
> +#include <asm/types.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <rpmi-uclass.h>
> +#include <string.h>
> +
> +/* SBI MPXY channel IDs data in shared memory */
> +struct sbi_mpxy_channel_ids_data {
> +       /* Remaining number of channel ids */
> +       __le32 remaining;
> +       /* Returned channel ids in current function call */
> +       __le32 returned;
> +       /* Returned channel id array */
> +       __le32 channel_array[];
> +};
> +
> +enum sbi_mpxy_attribute_id {
> +       /* Standard channel attributes managed by MPXY framework */
> +       SBI_MPXY_ATTR_MSG_PROT_ID =3D 0x00000000,
> +       SBI_MPXY_ATTR_MSG_PROT_VER =3D 0x00000001,
> +       SBI_MPXY_ATTR_MSG_MAX_LEN =3D 0x00000002,
> +       SBI_MPXY_ATTR_MSG_SEND_TIMEOUT =3D 0x00000003,
> +       SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT =3D 0x00000004,
> +       SBI_MPXY_ATTR_CHANNEL_CAPABILITY =3D 0x00000005,
> +       SBI_MPXY_ATTR_SSE_EVENT_ID =3D 0x00000006,
> +       SBI_MPXY_ATTR_MSI_CONTROL =3D 0x00000007,
> +       SBI_MPXY_ATTR_MSI_ADDR_LO =3D 0x00000008,
> +       SBI_MPXY_ATTR_MSI_ADDR_HI =3D 0x00000009,
> +       SBI_MPXY_ATTR_MSI_DATA =3D 0x0000000A,
> +       SBI_MPXY_ATTR_EVENTS_STATE_CONTROL =3D 0x0000000B,
> +       SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
> +       /*
> +        * Message protocol specific attributes, managed by
> +        * the message protocol specification.
> +        */
> +       SBI_MPXY_ATTR_MSGPROTO_ATTR_START =3D 0x80000000,
> +       SBI_MPXY_ATTR_MSGPROTO_ATTR_END =3D 0xffffffff
> +};
> +
> +/* SBI_MPXY_ATTR_CHANNEL_CAPABILITY bits */
> +#define SBI_MPXY_CHAN_CAP_MSI BIT(0)
> +#define SBI_MPXY_CHAN_CAP_SSE BIT(1)
> +#define SBI_MPXY_CHAN_CAP_EVENTS_STATE BIT(2)
> +#define SBI_MPXY_CHAN_CAP_SEND_WITH_RESP BIT(3)
> +#define SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP BIT(4)
> +#define SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS BIT(5)
> +
> +/* RPMI message protocol specific MPXY attributes */
> +enum sbi_mpxy_rpmi_attribute_id {
> +       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID,
> +       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
> +       SBI_MPXY_RPMI_ATTR_IMPL_ID,
> +       SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
> +       SBI_MPXY_RPMI_ATTR_MAX_ID
> +};
> +
> +/* Possible values of MSG_PROT_ID attribute as-per SBI v3.0 (or higher) =
*/
> +enum sbi_mpxy_msgproto_id {
> +       SBI_MPXY_MSGPROTO_RPMI_ID =3D 0x0,
> +};
> +
> +struct sbi_mpxy_chan_desc {
> +       u32 id;
> +       u32 max_xfer_len;
> +       u32 attrs[SBI_MPXY_ATTR_STD_ATTR_MAX_IDX];
> +       u32 rpmi_attrs[SBI_MPXY_RPMI_ATTR_MAX_ID];
> +};
> +
> +struct rpmi_sbi_mpxy {
> +       struct udevice *dev;
> +       void *shmem;
> +       unsigned long shmem_size;
> +       u32 channel_count;
> +       struct sbi_mpxy_chan_desc *channel_descs;
> +};
> +
> +static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 chan=
nel_id,
> +                                   u32 base_attrid, u32 attr_count,
> +                                   u32 *attrs_buf)
> +{
> +       struct sbiret sret;
> +       int i;
> +
> +       sret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATTRS, channel=
_id,
> +                        base_attrid, attr_count, 0, 0, 0);
> +       if (sret.error)
> +               return sbi_to_linux_error(sret.error);
> +
> +       for (i =3D 0; i < attr_count; i++)
> +               attrs_buf[i] =3D le32_to_cpu(((__le32 *)mpxy->shmem)[i]);
> +
> +       return 0;
> +}
> +
> +static int rpmi_sbi_mpxy_send_message(void *shmem, u32 mpxy_fid, u32 cha=
nnel_id,
> +                                     u32 msg_id, const void *tx,
> +                                     unsigned long tx_len, void *rx,
> +                                     unsigned long max_rx_len,
> +                                     unsigned long *rx_len)
> +{
> +       unsigned long rx_bytes;
> +       struct sbiret sret;
> +
> +       if (tx)
> +               memcpy(shmem, tx, tx_len);
> +
> +       sret =3D sbi_ecall(SBI_EXT_MPXY, mpxy_fid, channel_id, msg_id, tx=
_len, 0,
> +                        0, 0);
> +
> +       if (rx && !sret.error) {
> +               rx_bytes =3D sret.value;
> +               if (rx_bytes > max_rx_len)
> +                       return -ENOSPC;
> +
> +               memcpy(rx, shmem, rx_bytes);
 `rx_bytes` is checked against the caller's buffer, but not against the
 allocated MPXY shared-memory region. Current callers pass bounded response
 buffers, so this is defensive hardening rather than a demonstrated overflo=
w
 in the current clients; however, the helper itself accepts an arbitrary
 `max_rx_len` and trusts the SBI return value. Please bound the response by
 both the shared-memory allocation and the channel's maximum transfer lengt=
h
 before copying.

Regards,
Subrahmanya

> +               if (rx_len)
> +                       *rx_len =3D rx_bytes;
> +       }
> +
> +       return sbi_to_linux_error(sret.error);
> +}
> +
> +static int rpmi_sbi_mpxy_get_attr(struct rpmi_chan *chan,
> +                                 enum rpmi_attribute_id id, u32 *data)
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D dev_get_priv(chan->dev);
> +       struct sbi_mpxy_chan_desc *desc =3D &mpxy->channel_descs[chan->id=
];
> +
> +       switch (id) {
> +       case RPMI_ATTR_SPEC_VERSION:
> +               *data =3D desc->attrs[SBI_MPXY_ATTR_MSG_PROT_VER];
> +               break;
> +       case RPMI_ATTR_MAX_MSG_DATA_SIZE:
> +               *data =3D desc->max_xfer_len;
> +               break;
> +       case RPMI_ATTR_SERVICEGROUP_ID:
> +               *data =3D desc->rpmi_attrs[SBI_MPXY_RPMI_ATTR_SERVICEGROU=
P_ID];
> +               break;
> +       case RPMI_ATTR_SERVICEGROUP_VERSION:
> +               *data =3D desc->rpmi_attrs[SBI_MPXY_RPMI_ATTR_SERVICEGROU=
P_VERSION];
> +               break;
> +       case RPMI_ATTR_IMPL_ID:
> +               *data =3D desc->rpmi_attrs[SBI_MPXY_RPMI_ATTR_IMPL_ID];
> +               break;
> +       case RPMI_ATTR_IMPL_VERSION:
> +               *data =3D desc->rpmi_attrs[SBI_MPXY_RPMI_ATTR_IMPL_VERSIO=
N];
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
> +static int rpmi_sbi_mpxy_request(struct rpmi_chan *chan, u32 service_id,
> +                                const void *request, unsigned long reque=
st_len,
> +                                void *response, unsigned long max_respon=
se_len,
> +                                unsigned long *out_response_len)
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D dev_get_priv(chan->dev);
> +       struct sbi_mpxy_chan_desc *desc =3D &mpxy->channel_descs[chan->id=
];
> +       u32 caps =3D desc->attrs[SBI_MPXY_ATTR_CHANNEL_CAPABILITY];
> +       u32 mpxy_fid;
> +
> +       if (!request && request_len)
> +               return -EINVAL;
> +
> +       if (request_len > desc->max_xfer_len)
> +               return -EINVAL;
> +
> +       if (!response && max_response_len)
> +               return -EINVAL;
> +
> +       if (response) {
> +               if (!(caps & SBI_MPXY_CHAN_CAP_SEND_WITH_RESP))
> +                       return -EIO;
> +
> +               mpxy_fid =3D SBI_EXT_MPXY_SEND_MSG_WITH_RESP;
> +       } else {
> +               if (!(caps & SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP))
> +                       return -EIO;
> +
> +               mpxy_fid =3D SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP;
> +       }
> +
> +       return rpmi_sbi_mpxy_send_message(mpxy->shmem, mpxy_fid, desc->id=
,
> +                                         service_id, request, request_le=
n,
> +                                         response, max_response_len,
> +                                         out_response_len);
> +}
> +
> +static int rpmi_sbi_mpxy_of_xlate(struct rpmi_chan *chan,
> +                                 struct ofnode_phandle_args *args)
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D dev_get_priv(chan->dev);
> +       u32 channel_id, proto;
> +       int i;
> +
> +       if (args->args_count !=3D 2)
> +               return -EINVAL;
> +
> +       channel_id =3D args->args[0];
> +       proto =3D args->args[1];
> +
> +       for (i =3D 0; i < mpxy->channel_count; i++) {
> +               if (mpxy->channel_descs[i].id =3D=3D channel_id &&
> +                   mpxy->channel_descs[i].attrs[SBI_MPXY_ATTR_MSG_PROT_I=
D] =3D=3D
> +                           proto) {
> +                       chan->id =3D i;
> +                       return 0;
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int rpmi_sbi_mpxy_get_shmem_size(unsigned long *shmem_size)
> +{
> +       struct sbiret sret;
> +
> +       sret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_GET_SHMEM_SIZE, 0, =
0, 0, 0,
> +                        0, 0);
> +       if (sret.error)
> +               return sbi_to_linux_error(sret.error);
> +
> +       /* The shared memory size MUST be at least 4096 bytes */
> +       if (sret.value < PAGE_SIZE)
> +               return -ENODEV;
> +
> +       /* The shared memory size MUST be multiple of 4096 bytes */
> +       if (sret.value & (PAGE_SIZE - 1))
> +               return -ENODEV;
> +
> +       if (shmem_size)
> +               *shmem_size =3D sret.value;
> +
> +       return 0;
> +}
> +
> +static int rpmi_sbi_mpxy_get_channel_ids(struct rpmi_sbi_mpxy *mpxy)
> +{
> +       struct sbi_mpxy_channel_ids_data *sdata =3D mpxy->shmem;
> +       u32 remaining, returned, channel_id, start_index =3D 0;
> +       struct sbiret sret;
> +       int i, ret;
> +
> +       do {
> +               sret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_GET_CHANNEL=
_IDS,
> +                                start_index, 0, 0, 0, 0, 0);
> +               if (sret.error)
> +                       return sbi_to_linux_error(sret.error);
> +
> +               remaining =3D le32_to_cpu(sdata->remaining);
> +               returned =3D le32_to_cpu(sdata->returned);
> +
> +               // Allocate memory on the first call.
> +               if (!mpxy->channel_descs) {
> +                       mpxy->channel_count =3D returned + remaining;
> +                       if (mpxy->channel_count =3D=3D 0)
> +                               return -ENODEV;
> +
> +                       mpxy->channel_descs =3D
> +                               calloc(mpxy->channel_count,
> +                                      sizeof(struct sbi_mpxy_chan_desc))=
;
> +                       if (!mpxy->channel_descs)
> +                               return -ENOMEM;
> +
> +                       dev_dbg(mpxy->dev, "channel count =3D %i\n",
> +                               mpxy->channel_count);
> +               }
> +
> +               if (remaining && !returned)
> +                       return -EPROTO;
> +
> +               if (start_index + returned > mpxy->channel_count)
> +                       return -EPROTO;
> +
> +               for (i =3D 0; i < returned; i++) {
> +                       mpxy->channel_descs[start_index + i].id =3D
> +                               le32_to_cpu(sdata->channel_array[i]);
> +               }
> +               start_index +=3D returned;
> +       } while (remaining);
> +
> +       for (i =3D 0; i < mpxy->channel_count; i++) {
> +               channel_id =3D mpxy->channel_descs[i].id;
> +
> +               ret =3D rpmi_sbi_mpxy_read_attrs(mpxy, channel_id,
> +                                              SBI_MPXY_ATTR_MSG_PROT_ID,
> +                                              SBI_MPXY_ATTR_STD_ATTR_MAX=
_IDX,
> +                                              mpxy->channel_descs[i].att=
rs);
> +               if (ret)
> +                       return ret;
> +
> +               if (mpxy->channel_descs[i].attrs[SBI_MPXY_ATTR_MSG_PROT_I=
D] =3D=3D
> +                   SBI_MPXY_MSGPROTO_RPMI_ID) {
> +                       ret =3D rpmi_sbi_mpxy_read_attrs(
> +                               mpxy, channel_id,
> +                               SBI_MPXY_ATTR_MSGPROTO_ATTR_START,
> +                               SBI_MPXY_RPMI_ATTR_MAX_ID,
> +                               mpxy->channel_descs[i].rpmi_attrs);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int rpmi_sbi_mpxy_probe(struct udevice *dev)
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D dev_get_priv(dev);
> +       struct sbi_mpxy_chan_desc *desc;
> +       unsigned long flags;
> +       struct sbiret sret;
> +       int i, ret;
> +
> +       mpxy->dev =3D dev;
> +
> +       /* Probe for SBI MPXY extension */
> +       if (sbi_get_spec_version() < sbi_mk_version(1, 0) ||
> +           sbi_probe_extension(SBI_EXT_MPXY) <=3D 0) {
> +               dev_info(dev, "SBI MPXY extension not available\n");
> +               return -ENODEV;
> +       }
> +
> +       /* Find-out shared memory size */
> +       ret =3D rpmi_sbi_mpxy_get_shmem_size(&mpxy->shmem_size);
> +       if (ret) {
> +               dev_err(dev, "failed to get MPXY shared memory size\n");
> +               return -ENODEV;
> +       }
> +
> +       mpxy->shmem =3D memalign(PAGE_SIZE, mpxy->shmem_size);
> +       if (!mpxy->shmem)
> +               return -ENOMEM;
> +
> +       /* Setup shmem in OVERWRITE mode. (flags[1:0] =3D 00b) */
> +       flags =3D 0;
> +       sret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_SET_SHMEM,
> +                        virt_to_phys(mpxy->shmem), 0, flags, 0, 0, 0);
> +       if (sret.error) {
> +               ret =3D sbi_to_linux_error(sret.error);
> +               goto err;
> +       }
> +
> +       ret =3D rpmi_sbi_mpxy_get_channel_ids(mpxy);
> +       if (ret)
> +               goto err;
> +
> +       for (i =3D 0; i < mpxy->channel_count; i++) {
> +               desc =3D &mpxy->channel_descs[i];
> +               desc->max_xfer_len =3D
> +                       min((u32)mpxy->shmem_size,
> +                           desc->attrs[SBI_MPXY_ATTR_MSG_MAX_LEN]);
> +       }
> +
> +       return 0;
> +
> +err:
> +       free(mpxy->channel_descs);
> +       free(mpxy->shmem);
> +
> +       return ret;
> +}
> +
> +static int rpmi_sbi_mpxy_remove(struct udevice *dev)
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D dev_get_priv(dev);
> +
> +       free(mpxy->channel_descs);
> +       free(mpxy->shmem);
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id rpmi_sbi_mpxy_ids[] =3D {
> +       { .compatible =3D "riscv,sbi-mpxy-mbox" },
> +       {}
> +};
> +
> +static const struct rpmi_transport_ops rpmi_sbi_mpxy_ops =3D {
> +       .of_xlate =3D rpmi_sbi_mpxy_of_xlate,
> +       .get_attr =3D rpmi_sbi_mpxy_get_attr,
> +       .request =3D rpmi_sbi_mpxy_request,
> +};
> +
> +U_BOOT_DRIVER(rpmi_sbi_mpxy) =3D {
> +       .name =3D "rpmi-sbi-mpxy",
> +       .id =3D UCLASS_RPMI,
> +       .of_match =3D rpmi_sbi_mpxy_ids,
> +       .probe =3D rpmi_sbi_mpxy_probe,
> +       .remove =3D rpmi_sbi_mpxy_remove,
> +       .priv_auto =3D sizeof(struct rpmi_sbi_mpxy),
> +       .ops =3D &rpmi_sbi_mpxy_ops,
> +       .flags =3D DM_FLAG_PRE_RELOC,
> +};
>
> --
> 2.53.0
>
