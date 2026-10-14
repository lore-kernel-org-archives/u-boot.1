Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6C6CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1EB8407C9;
	Wed, 14 Oct 2026 16:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IC1PZrTd9tK2; Wed, 14 Oct 2026 16:53:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FA4B40776
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791996813;
	b=WeR+GDYaMkDPLSnPh3Ua1+k7yi19aK/Iz3aVliKxmsVZG1+BIr5e6rDSbWmUp4sMCYfr
	 3Bb5cqzVs6QOltAXxKH2VhFP1POioEuuHicxrZDxtogM+lEJFsYboKuUgJyje6ZPXR2zO
	 DdShYg4aOUBDQ8ceOYfoSPK5FrbJo/uh3nqECLZmzC2x/YUrfjwjkfx8KyrPrBRmHl4TX
	 SZUO8rRBjmwZ71ZOczAynW/7b71YA/X9zHQNqLMKnwTll0iXDlbKZ+fgsKjpXCUI1a4fG
	 TOjBQY/CSZxiwBv9xO+QQBla560ueSxst3cNVaXBUlw2YbI+8rATMnbolHsaf9gn9zg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791996813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FsKNSl2memNxmkPGDIVUpccH0yWmY5Dp9Spd1i+t9o0=;
	b=JZLeF/kbDcge4pe73TBG+eZyTY311g3JO93xXWvYLh8wH9a8n6n9ozPGMVpGFQ25JGXa
	 I9+Gt7inpinR441SZKHrjj+Hd3+iiQqRuvZWQekJkj+/7vTT6GOI8EWgwM+fXNlNDBxl7
	 YIyTNpieyiOGk05xi9uBZdqBdd5R92InI4xgYe+ZvqUJC0748FQ8dK/DfIWxqP9TpG/yv
	 2G9hgD7ERDhClVoAZIsIk1WDJKv7PUFQzH5hpjRTRcO0CgGUGW86yUqb+sZdvpb0TQFnn
	 mkeJlxzKBpKCTvYbtzZTmVs14SVRpD5qvqwccgoAdl2u7MwgEY/EgFs+eBSkBH3hIyQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791996813;
	bh=FsKNSl2memNxmkPGDIVUpccH0yWmY5Dp9Spd1i+t9o0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X7iFB4/KG/Wre/yb3CuUgOtQaMN11VyJxtTxNYQDWR8XooqzL0O/ZSxmDMRxQMRtK
	 4y5lZC0w2LTqcij8vNMW5urzEn/AOoJDE9RaMfvZSsDev/YuBRVJkxc2VfiMAGBXhH
	 xYZgIiggFjovek4DEKaDMI+lAfsK4zJqZVkdorzSX3CpMNBvDUlML7XZq2pRfrz9X2
	 1WW0HeuXzxMkSTCP1XyShKnioznI2+tzzdgyEg4w4zKTI5NwptZq4LR0bmxhYtiCkH
	 Kls+tpNba9R7QJy14GE84Mo633YHWcJE281oPDbzzq1dZ/JISrNgS1+JwfwK0aNqAH
	 EuqlKBUOawzzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FA4B40776;
	Wed, 14 Oct 2026 16:53:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C995A255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFCFC80E4F
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MpEnF-R4ZF7d for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:53:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8188380E1D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791996810;
 b=NeWBVRIc5yLwj0l8XJLBo7ZnYFgFwwPAToW0n4tL3IztAAbsvL8hLXemZvXQh/fd36Z1
 esBDbV1JPVDgyz+JxmipMJdp6wFpVoycGuN43dl4AGUaCiIf49BQPQxzce6IVh2d3C+fJ
 RTCc+UScFFGXjmCq1Rb4X/L2b2zkLfF5iGcUt+qro/N/sPkbgEiQOT62CyMHBwgAB88Pa
 kx1RpVihdMD3e2X0bQFqgwvnx2hZ/VvUtc27GeANi1D22KcUa8iv1FQNk0JwIcKriZis7
 xGXyc98MGQEIRqtOFANevtC6L0PZYoL2M0yaBp3H45isY6dKi+JBcI4u9CrU4khrsQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791996810;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=FsKNSl2memNxmkPGDIVUpccH0yWmY5Dp9Spd1i+t9o0=;
 b=bBYz4FpCdU3AIrGVk8HsYeXFgBNsybrrZqRxbQ9JjN+73SANJXQzz+djEBWzpf8YMSxi
 eNXqV64UBWtnxYl5mGK/wO69O7Xx2wGPols03OqVN1f2NlZIEeRvzdnFZXgrDZpOtRMPj
 7r+fAqPKxEFh/I9Imy//ZXuNgPe/Sy1pI7brvSB7NWeXi0oWczs3anVTecDLhOcNCbh/O
 6lNES88JIVTAobfLSvnit7wGg3x2goxIP+vy8gd8eS0qvZ/N+jrBaNAntoj72DNJJRpdh
 Zg81MFb2ZdaOjMheFOrAQ1XHwlBA144QE76p8HuwciewGOJSxOgEdiLWk7tBsJjnrGQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=o0NHWWr1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DUE5tR4S; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=o0NHWWr1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DUE5tR4S
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8188380E1D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:53:29 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbUOA3813218
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FsKNSl2memNxmkPGDIVUpccH0yWmY5Dp9Spd1i+t9o0=; b=o0NHWWr1x2Yb2CKo
 vzJb2Kj5najVM82rP0/ZCHeRYaL4oY6dpZfIL09EKUpghj/KOy71a62iKOwonr1X
 fzj+zfLIm534uTHaCKleA12rEv7kkDMR6bxj3X5u5UsLDXb0tnhPes6iW79uOUDY
 VBiF0kZWVkHlpZWNv95csuLbJc8Q/ZY6sstZ0s6arwZUA9EVjq0rcKlmOkrh+s+p
 AvcPwQEpD8ki7lt8cklRvdjjrK6DvDM8j3eG8pIIEy2Il6LMbSP3/Q4oSMKrSPAl
 t0xYNjDUz6V/QGwTLNCpbUgsJcuyv9NEsqLaGI1AaRabWNmvK+Zx9hnxxT5TMBOH
 utOwGw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u2md2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:53:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so12058849eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791996808; x=1792601608;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FsKNSl2memNxmkPGDIVUpccH0yWmY5Dp9Spd1i+t9o0=;
 b=DUE5tR4SYS0xDBKGUMMzUO/MSbebcdfsBfc5mGYNPfa4Y7YZ2L+Bm7XC2KWGiu8IsZ
 pRqRtFma/cROJUoyG6E1ygxtjOe4y3GcX/7Cd/+rH/52HNLGjJ/yoYLNivylG09NZt/D
 m0sOtJKgexVb5/2EHGPUR7SRJnMamnp/xrt8OmMn4wgDAdItKVYhbDnakKfs6tct8oPj
 lMlx7wk9o0rkg3DTwP1PzZat0/qANErJIjfeRCyqBeK0x3yOLjaVpa8gqbkKrRy1pa2y
 9JaXBvvDN8qmzS32Tco2ETGA6wOtj4gGdb7VfupEja3XepktgiOC4UIlLjIJLnBVc+rv
 +PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996808; x=1792601608;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FsKNSl2memNxmkPGDIVUpccH0yWmY5Dp9Spd1i+t9o0=;
 b=oky5iBy5rqb/9Jh4DxEvtw2VFhaIDfRyOS7MyIhazCvvLpu9cqgi6n++xy6QaPEupA
 SOLpSJPRkTL4zrhEJ0NRKG9CBs2mgfpCA/edfSDxCRm9ASFXBrWu0/DLWPeFw8Y+uUV/
 +s7+Pse+diI8L3RmUeWveh44rFOQ9IY5MlXVlB9EOf4iWWmAj7TCaxPjKSkX9QmK/FWE
 sju3sPwlZ7yy8PJWgAsjL02f3Db+1evRwmJGIOQSMPZYL5atgWDRv1IGk4U9UXLGPZOE
 FsaSUrr5eZvRHScwONB5a6M26N2CUXiVjAV6p8O4hd7tX4a3JvlYX+aCE4i8aOi3o8Fb
 I7oA==
X-Forwarded-Encrypted: i=1;
 AKwUvByg5ZTzEgskPGZHd+AopygR3L28CBZdFf4jFOyfaoBrt8xxo9WVVJdbLu1YTQF+VHa8WjH1ej4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLpP8r7aoDiEcotNq4wtGRgkz0k+kECV7FfZ9LaIEZ/8FTaUvWm
 iBZH+m1EE2s2Xbet2+IY0IBx31KAP8wUpgE5XZbPjVOD3KDqn+oe3IfyBMebKmvOoTHcXuoVOAf
 zSBFQGNahdQFaatdWcSmyejSeIFWDhU1zRMVVMoAgVplAi35TqYvnmr6MVjWxn2yVkLNNaf4=
X-Gm-Gg: AYBFou0vlxwGVNNCI+UaryZvpfCTkn7KWwmE/jEzBgvDuSr1bPhXLIWqxFOKxl59gO9
 7dmz3Av9+Og8FwGbmpRWm3O3Po0d0CD39+YxklJjcLPnUGxDQt/6L/wW0j2n+lq7wNCiJAxIlvf
 zbXEIr1qvqoEB7DuNGecSJmJZsXveOgpQO88nROcStHmfROTYXyLUZ4VYyXQVLwdUbPPIfppwJv
 joNHb0okzXsy2ghguEAB8dUKE7tAwdz92DnjbRYiCTGu9tFA+UnWeLXDHUU/T6paCAzGlSTQlCx
 kcunlN51VQHN1p44rwMB5kFmCosjVCrQw/vuc2Y0/2dJzMD+piUcsIzkuzcps15AtT1ojOGxSTB
 Aox7xlAYx67ClIdat7auOtK3PdSj/e94+m7j6
X-Received: by 2002:a05:7300:f0ce:b0:34b:b410:9352 with SMTP id
 5a478bee46e88-3537de1ce96mr21649533eec.1.1791996807396; 
 Wed, 14 Oct 2026 09:53:27 -0700 (PDT)
X-Received: by 2002:a05:7300:f0ce:b0:34b:b410:9352 with SMTP id
 5a478bee46e88-3537de1ce96mr21649444eec.1.1791996805587; 
 Wed, 14 Oct 2026 09:53:25 -0700 (PDT)
Received: from [192.168.0.6] ([183.82.204.175])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b29c2f861sm37522473eec.11.2026.10.14.09.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 09:53:25 -0700 (PDT)
Message-ID: <fa1b28bb-68e8-4e8d-a5ca-1972ee74e4ed@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 22:23:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] doc: qualcomm: Add snagboot mode documentation
To: Ferass El Hafidi <funderscore@postmarketos.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org, sumit.garg@kernel.org
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
 <20261013-snagboot-v7-8-fc296a32836a@oss.qualcomm.com>
 <DM3NZDMWLXUO.3BY4A60QYUEW1@postmarketos.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <DM3NZDMWLXUO.3BY4A60QYUEW1@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX89L13BFk9Ady
 xxhj5+MPHuIg8eI6OrNqMJitPlvTV1VgeAB7707SQYpbW/FMAiSRe/Qb0jSJa1yOPqr/FMf04PV
 fRf59c4fOI+fUQpBjtJqmR4e9ExKz/s=
X-Proofpoint-GUID: uMdHqKI__cgojZO4W0QEEdwssKc1fgIB
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acfb388 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=W16dESUZREjBzS9ijiA/Gw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=cSziVDP4AAAA:20 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=1N6bBq8Zmelz02OXVmYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX9JjX4vqTNqEP
 y17+JG4Qk6ts0yhHra3LMCZpsE0fJv6L6BRTjyOd4mlx6n0/B4PuAGtDjtkrDm97s9qq+sxRpnc
 Vl3Uzx2nu1O+f1zUTyN2CSSSyQvLb9lxBXkF/2y7v0HAXWXAVwz4+4wB7IVe+E4ivUW8rzS9KzJ
 Db6leHdH1Buqkk5xJ7uJlXwudIL+fxBxyEsOirZtaJkEx9h8BZy8WVHi4onev1a1dvxhsjR/FZv
 KLp5E4wMr6Tzo4BpeNONxgR8TaZ+TGPZJg1+0jqtbJaDdJJwwXRP5xMJpHb1+O4MhpMJMogMKsy
 G/5Mh3xi7JtS8phZypvd2ywNLzjB+5TgQpcjZyuZ9cL4xODkxMKHpj88ft4EtFlhsPNQQivdx4Q
 h/CUPUVwTdwtYL1QmfBNrgE3CYXYwCeYV4FDhZ++PzoWjQQxeZtAUX850ihyk+SvS8CLS/oIx5j
 CZrIOnjQn7wX19JImgg==
X-Proofpoint-ORIG-GUID: uMdHqKI__cgojZO4W0QEEdwssKc1fgIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067
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

Hi Ferass,

Thanks for the feedback. Modified the doc to focus on only the usage steps.

On 10/13/2026 4:42 PM, Ferass El Hafidi wrote:
> Hi Balaji,
>
> (sorry, I didn't mean to send this off-list)
>
> Some drive-by feedback following:
>
> On Tue Oct 13, 2026 at 1:53 AM UTC, Balaji Selvanathan via groups.io wrote:
>> Add documentation for snagboot mode support on Qualcomm platforms.
>> This covers build steps to compile U-Boot for Snagboot mode for
>> Lemans-EVK along with the architecture, execution flow, and Snagboot
>> enablement requirements.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v7:
>> - Rebased on top of latest file
>>
>> Changes in v5:
>> - Added build steps for U-Boot in Snagboot mode
>>
>> Changes in v4:
>> - Newly added in v4
>> ---
>>   doc/board/qualcomm/index.rst    |   1 +
>>   doc/board/qualcomm/snagboot.rst | 224 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 225 insertions(+)
>>
>> diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
>> index 56b8d894c2a..b8bc37bb384 100644
>> --- a/doc/board/qualcomm/index.rst
>> +++ b/doc/board/qualcomm/index.rst
>> @@ -17,3 +17,4 @@ Qualcomm
>>      rdp
>>      signing
>>      spl
>> +   snagboot
>> diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboot.rst
>> new file mode 100644
>> index 00000000000..0cbde61253d
>> --- /dev/null
>> +++ b/doc/board/qualcomm/snagboot.rst
>> @@ -0,0 +1,224 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +Snagboot Mode for Qualcomm Platforms
>> +=====================================
>> +
>> +Overview
>> +--------
>> +
>> +Snagboot is an open-source, scriptable flashing framework that provides
>> +an alternative to the proprietary Firehose protocol for device
>> +provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
>> +Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
>> +and execute bootloaders. However, instead of using the proprietary
>> +Firehose programmer, Snagboot loads U-Boot into DDR and uses the
>> +standard fastboot protocol for device flashing.
>> +
>> +The framework consists of three modular components:
>> +
>> +* **snagrecover**: Downloads XBL/QCLib to initialize DDR and load U-Boot into RAM
>> +* **snagflash**: Communicates with U-Boot over USB using fastboot to flash system images
>> +* **snagfactory**: Orchestrates parallel factory flashing tasks
>> +
> It might be worth just linking to snagboot documentation. This overview
> makes it seem like Snagboot was made specifically for Qualcomm which it
> is not.
>
>> +Why Snagboot?
>> +-------------
>> +
>> +* EDL + Firehose remains the default and supported factory provisioning flow
>> +* Customers are requesting support for Snagboot, an open, scriptable flashing framework,
>> +  as an alternative option
>> +* Snagboot reuses Qualcomm recovery primitives and standard flashing protocols,
>> +  minimizing platform disruption
>> +* Provides an open-source alternative to proprietary flashing tools
>> +
> I would drop this whole section, it's not useful.
>
>> +Architecture
>> +------------
>> +
> This IMO is better suited in a different doc? I would personally try to
> keep this solely for usage instructions.
>
> Or at least put usage instructions first, since that'd be what most
> users are interested in.
>
>> +Snagboot Execution Flow on Qualcomm SoCs
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +The snagboot execution flow consists of two main phases:
>> +
>> +**Phase 1 - snagrecover**:
>> +
>> +1. ROM code enters recovery mode (EDL)
>> +2. Snagrecover uses Sahara protocol to download XBL/QCLib to internal memory
>> +3. XBL executes and initializes DDR
>> +4. Snagrecover downloads U-Boot into DDR
>> +5. Control transfers to U-Boot
>> +
>> +**Phase 2 - snagflash**:
>> +
>> +1. U-Boot runs in DDR and enters fastboot mode
>> +2. Snagflash communicates with U-Boot over USB using fastboot protocol
>> +3. System images are flashed to non-volatile memory (UFS, eMMC)
>> +
>> +Boot Environment Considerations
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +In the snagboot execution flow, ROM code in recovery mode loads
>> +snagrecover, which downloads XBL to internal memory. XBL executes
>> +and initializes DDR, then snagrecover downloads U-Boot into DDR and
>> +transfers control to it. At this point, XBL has left the MMU enabled
>> +with its own page tables and has not initialized PSCI firmware or
>> +populated the Command DB. U-Boot must handle this non-standard boot
>> +environment to enter fastboot mode for device flashing.
>> +
>> +This is why several standard U-Boot features must be disabled in snagboot mode.
>> +
>> +Comparison with Traditional EDL+Firehose
>> +-----------------------------------------
>> +
>> +**Standard Device Provisioning Path Using EDL and Firehose**:
>> +
>> +* **Emergency Download Mode (EDL)**:
>> +
>> +  * EDL is a special boot mode built into Qualcomm SoCs Primary Bootloader (PBL) in ROM
>> +  * Triggered via hardware strap, software command, or recovery from boot failure
>> +
>> +* **Sahara Protocol (Stage 1)**:
>> +
>> +  * Host PC uses Sahara protocol to communicate with the SoC's PBL
>> +  * Transfers Device programmer (Firehose) into RAM
>> +
>> +* **Firehose Protocol (Stage 2)**:
>> +
>> +  * Once the Firehose Programmer is running on the device, it establishes a Firehose
>> +    protocol session with the host
>> +  * Host sends XML-based commands to flash firmware images to specific partitions,
>> +    erase or read flash memory and manage partition tables
>> +  * Integrated into tools like QFIL and PCAT
>> +
>> +**Snagboot Alternative**:
>> +
>> +Instead of loading a proprietary Firehose programmer, Snagboot loads U-Boot into DDR
>> +and uses the standard, open-source fastboot protocol for flashing operations.
>> +
> I as an end user don't find this whole comparaison section useful, I
> suggest dropping it.
>
>> +Supported Platforms
>> +-------------------
>> +
>> +Currently supported platforms:
>> +
>> +* **Lemans-EVK **: Initial platform with snagboot support
>> +
>> +Additional platforms can be enabled by following the board enablement guide below.
>> +
>> +Board Enablement
>> +----------------
>> +
>> +To enable snagboot mode on a new platform, follow these steps:
>> +
>> +Using the Config Fragment
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +A reusable config fragment is provided at ``configs/qcom-snagboot.config`` that contains
>> +all common snagboot settings. Include it in your platform-specific defconfig::
>> +
>> +    # Configuration for building U-Boot for snagboot/recovery mode
>> +    # on <Your Platform> boards.
>> +    #
>> +    # For normal production boot, use <platform>_defconfig instead.
>> +
>> +    #include "qcom_defconfig"
>> +    #include "qcom-snagboot.config"
>> +
>> +    # Platform-specific settings for <Your Platform>
>> +
>> +    # Address where U-Boot will be loaded
>> +    CONFIG_TEXT_BASE=0x1c100000
>> +    CONFIG_REMAKE_ELF=y
>> +    CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
>> +    CONFIG_DEFAULT_DEVICE_TREE="qcom/<your-board>"
>> +
>> +    # Timer frequency for your platform
>> +    CONFIG_COUNTER_FREQUENCY=19200000
>> +
>  From here to
>
>> +Enabling ``CONFIG_QCOM_SNAGBOOT_MODE`` (via the fragment) automatically selects:
>> +
>> +* ``CONFIG_QCOM_BOOT0_SNAGBOOT_MODE``: Early boot initialization
>> +* ``CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK``: Enable boot0 hooks
>> +* ``CONFIG_SKIP_RELOCATE``: Skip relocation (U-Boot runs from load address)
>> +* ``CONFIG_ENV_IS_NOWHERE``: Ensure recovery works even with corrupted environment
>> +  storage, since a recovery mechanism should not load a potentially broken or
>> +  untrusted environment from the board
>> +
>> +It also enforces the following at the Kconfig level via ``depends on !X``, so these
>> +configs cannot be enabled together with snagboot mode:
>> +
>> +* ``CONFIG_PSCI_RESET``: Not available in Snagboot mode (XBL doesn't initialize PSCI firmware)
>> +* ``CONFIG_IOMMU``: Not initialized by XBL in Snagboot mode
>> +* ``CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR``: Previous bootloader context is not preserved
>> +  in snagboot mode
>> +* ``CONFIG_ENV_IS_IN_SCSI``: Not available in Snagboot mode
>> +
>> +``CONFIG_QCOM_SNAGBOOT_MODE`` also requires ``CONFIG_COUNTER_FREQUENCY`` and
>> +``CONFIG_TEXT_BASE`` to be set to a non-zero value.
>> +
> to here, I would drop, it's not very useful. I'd expect developers to be able to
> look at the source code for these kinds of details.
>
>> +You still need to set the following platform-specific values in your defconfig:
>> +
>> +* ``CONFIG_COUNTER_FREQUENCY``: Set to your platform's timer frequency (e.g., 19200000 for Lemans)
>> +* ``CONFIG_TEXT_BASE``: Set to the address where XBL will load U-Boot (e.g., 0x1c100000 for Lemans)
>> +* ``CONFIG_FASTBOOT_BUF_ADDR``: Set fastboot buffer address for your platform
>> +
>> +Example: Lemans-EVK
>> +^^^^^^^^^^^^^^^^^^^
>> +
>> +See ``configs/qcom_lemans_snagboot_defconfig`` for a complete example of a
>> +platform-specific snagboot defconfig.
> I would drop this section.
>
>> +
>> +Building U-Boot for Snagboot
>> +-----------------------------
>> +
>> +Build Steps
>> +^^^^^^^^^^^
>> +
>> +First, setup ``CROSS_COMPILE`` for aarch64. Then, configure and build U-Boot for
>> +the Lemans EVK platform::
>> +
>> +    $ export CROSS_COMPILE=<aarch64 toolchain prefix>
>> +    $ make O=.output qcom_lemans_snagboot_defconfig
>> +    $ make -j8 O=.output
>> +
>> +Expected result: the build completes without errors and ``u-boot.elf`` is
>> +available in the ``.output`` directory.
> Drop this sentence.
>
>> +
>> +Signing Prerequisites
>> +^^^^^^^^^^^^^^^^^^^^^
>> +
>> +* ``u-boot.elf`` (generated from build, located in ``.output/``)
>> +* ``swiv_build_utility.py`` — download from:
>> +  https://github.com/qualcomm-linux/boot-firmware-ci/blob/main/tools/swiv_build_utility.py
>> +* ``qtestsign`` — clone from ``msm8916-mainline/qtestsign``::
>> +
>> +    git clone https://github.com/msm8916-mainline/qtestsign
> It's not useful, just tell people commands to fetch these two latter
>
> Additional tooling
> ^^^^^^^^^^^^^^^^^^
>
> In order to generate a working image, we need ``qtestsign`` and
> ``swiv_build_utility.py``::
>
>      git clone https://github.com/qualcomm-linux/boot-firmware-ci/
>      export SWIV_BUILD="$PWD/boot-firmware-ci/tools/swiv_build_utility.py"
>      git clone https://github.com/msm8916-mainline/qtestsign
>      < installation instructions for qtestsign >
>
>> +
>> +Step 1: Generate SWIV ELF
>> +""""""""""""""""""""""""""
>> +
>> +Add the SWIV segment required for TZ-based signing::
>> +
>> +    python3 swiv_build_utility.py \
>> +     .output/u-boot-swiv.elf \
>> +     .output/u-boot.elf \
>> +     lemans
>> +
> -----8<-----
>> +Output::
>> +
>> +    .output/u-boot-swiv.elf
> Drop
> -----8<-----
>
>> +
>> +Step 2: Sign Image Using Qtestsign
>> +""""""""""""""""""""""""""""""""""
>> +
>> +Sign the SWIV-enabled ELF using qtestsign (test-key signing)::
>> +
>> +    <path_to_qtestsign>/qtestsign -v 6 -o .output/u-boot.mbn tz .output/u-boot-swiv.elf
>> +
>> +Output::
> Drop this line
>
>> +
>> +    .output/u-boot.mbn -> Final Binary to be flashed
> and this line. Instead I would say:
>
> This generates the final ``.output/u-boot.mbn`` binary, that can then be
> used for snagboot.
>
>> +
>> +References
>> +----------
>> +
>> +* Snagboot project: https://github.com/bootlin/snagboot
>> +* Snagboot documentation: https://github.com/bootlin/snagboot/tree/main/docs
>> +* Qualcomm EDL mode: See your platform's technical documentation
> May I also ask, if you got help from AI to write this?

Yes.

Thanks,

Balaji

>
> Best regards,
> Ferass
