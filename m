Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC51606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 05:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hvr0uam9;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pK+LQ4x/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HV4JjZd6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03A5860AA0;
	Fri, 30 Oct 2026 05:52:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DG7Gss-c5A8b; Fri, 30 Oct 2026 05:52:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E587B60A70
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793339553;
	b=qqOtUCeFgNj+J07EI2M1MPW1+XlcT6AZ/YCIpyJA/+qwk4DFpR3Y30q5ZFW4FtdF0Gxh
	 oZNMvMH0F3WHizfUraeIJnsc9cSdtmVpu7H+Pf9j278PEQnJHbsV/1D47AC1OIIgDt5cr
	 M5J1FEhFDkYf1NNxlSMIDQaHFxNhrEDFToUrWnntPV5NPqMustNjM9IkHznHClZqrs1GW
	 rFtSPy0tGcrpUNgikBQCWWNwcrOlWlmXMRnnr2y8lMV20p0JQpOj1M6sLYJmaLz+X39sk
	 k+vq2qMntsx59hZ73wSC4Ho3T43zRJIO0KaaJ7pAek9BZGb2HssdnrzcIWlKMsQ8x6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793339553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0oeIo3HbT900x3GOyjCfXPC//4ZMzBig95fjQd2pqoo=;
	b=gAY1TyEmW3akQn1W21Fr1hRuHsPYrFAYD/E2G/xOzUXNyHT7BlNcnV+1nuZJyyRosfqe
	 HveDuTlqonstzp/UeMDODgLg6XKCzstAJ5EH5tYSnMLitl2T8wjLq5X12Sm9AapQHnEEy
	 XMXP9yFWXeXaKaeaEfHevh9wyMyCwPgfbnkIcvRHVmlhI6q0hlY0KkgnIarE+TO25ucv5
	 aDynaV94bT2HMVtTBghqz7nTizmEjD0t7lxeXH+skPjAYG+fsliCS/nRYEb53WAEIcHBf
	 8eI2Q3n4SB2cLR1IubHHbDDCTT/H9CUv1vHRT4gIx4CYCMXTexUeCDWaE8tlYA93ATA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793339553;
	bh=0oeIo3HbT900x3GOyjCfXPC//4ZMzBig95fjQd2pqoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hvr0uam91YUQsLrA1DH5IKw0bIxRbNTV8R4iXvMtZgVIPU5n1LoAqsFJrCAdBRZon
	 juBWsroyMHdOZ2jtF+CcyuTaZabl69DB9f88zq/DW3qKP3Rnzc1HSDU9YmPeEkyx7H
	 Es0OjNt5GhbMstf2pVnJnFci49o7oipyaJUx4dvOJMfp4qFxL2G7Iz9Mg9WNOnT6Ps
	 +2jF6ElddtmbCM5svoDzSIGxWxsep0H+7yJGxpmxMDEb0I8mlSpfC/lo0a8UmME7xZ
	 kZEe8IMEpag/E2YougL5OH3Znb9I8grHgGJIfUF+zlbuUO9N9N5gYfm2KdxH43W/Uh
	 Ll2sl1jHOTC5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E587B60A70;
	Fri, 30 Oct 2026 05:52:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F33381DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9776810AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:52:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QOSebBCGlKfw for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 05:52:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D8EBA810B0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793339551;
 b=kCP+BNcfg8lMOVKNE4fxwWQGy7tpe8SQzNPPD2K1wbmXNYzuGeVPDmCY9d9WuOaloSFx
 8KFuhzzWNnmK2gEZ56b5IV59jHRFn0WyNXjn79tJ+CmKR+kLUX14muWkprBbJrNKRrC65
 Otb+jTysJ4//Ri9qD6jcmCj9fAUa3qm9TlUY1pHwh1RPD4NR+k3BjVsCmuvaAHAxSJcVY
 wowTiZq46FcZzNaFWccL+Y2FV3uu02olIVC55dfc2GypNPJXPVw6iJ9cmXLdwkdk6T8ud
 k5HTcWd8yYRJga68HxZhPryPaG9dnSbiJyjgZ6YHldI8HgF5hNnHYGX17bDzDpDFkew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793339551;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=0oeIo3HbT900x3GOyjCfXPC//4ZMzBig95fjQd2pqoo=;
 b=BFuhy5630yEg1vwlB8Ofy9H3CR5PDR4H+fD6TlSO3kClq6xnvXHCKlYF/CRT/VpYnuza
 cOzmcPU7AaKIN6MNJQD6TKIvkCOSPHw20ak4jTPHW3Fw0BGTeye3k2QkoFTjGuzMv2yey
 h+fBiru+5PPa4NwZxkKEUHoxsKdVBiauZXchw9tTVweJOcmBxCMF83vtpV/jIOA9Ba4Su
 ciKD4182Z+Kf4uJzFFHXUEWmAjWt6GCLL8rqAUgat4r6aABsjZO0nBH8+/IMfym58Ho3i
 0V5Vc40vNC9Tp6QeP1r1Si/ZQLTXrHauo4JefWiVusgfQ3gZ3T1ZFh/0s4iDbtVG9ng==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="pK+LQ4x/"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HV4JjZd6; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=pK+LQ4x/; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HV4JjZd6
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8EBA810B0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:52:30 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U5Evou1367071
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0oeIo3HbT900x3GOyjCfXPC//4ZMzBig95fjQd2pqoo=; b=pK+LQ4x/XFP/iORi
 ZJChsjDqS4kUbhLfXVgkbPFlhCleJrPhri8lBAD/l8Wv3SY30HSuC7UEX1HOQzQr
 NtCh0HxxF5Jo46mZiNaHme52R4jdk+ZSN9t3kAGLmC0K1X+ILQ9zJ0DGmfRVlajN
 iCfzQ+HuKsr8vuMU4sWVt/Y6Re5KFI3/DrzDoiGyi9XWvV24qEtpqGxafoNrpbn4
 BATsiGvkMHbQttI2V/87ZNJHRqqp7rs935Hw7YySmXRNH7AZijp7/FTsfzEfT6Lw
 cieELTNzIkpLuFwdN8JcSDbYJUV1ny9A7RB9lTlY0J4QaBTmBiVV5SWvz85rACGz
 HmDd+Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p9d9r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:52:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso548433eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793339549; x=1793944349;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0oeIo3HbT900x3GOyjCfXPC//4ZMzBig95fjQd2pqoo=;
 b=HV4JjZd66K+Blg2wQveZqM7ZhAOQcl6oAQ+MeDd5fmuPBkXilPAFg22K5sFAoIRBX+
 JPtsoCKDNiD+qoodulmMlA/qPEkRsOYRBsoJ0nubzFVs/3zTk26egu4X7a98xOREkDGe
 Na/jHMiyMB3LcLtIeNZu1Ajj/cjWAwXsFMYU0m1aQJNmuAve6zOLBtpkdwb5Ux8+x2LC
 +GmdrApT15fhWX8bwy8mQIG5366PxDqu8B2Ozh2f9NDmYqyz3LviwfEM5gMcfkXp4BK0
 z6FDagJpmON/Nz5yMiuMV/Q3J0IkRbQmsePappJ9kBCCMb3E2+vJi6HdTBWsmi/7nbL4
 BXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793339549; x=1793944349;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0oeIo3HbT900x3GOyjCfXPC//4ZMzBig95fjQd2pqoo=;
 b=vgpHmomTJyiHEeV6o1oxN5LzcF0e/v+iDRuR7c/QlzEl//iXVGCZzZW9cc+c0jJMPt
 5QH7/ZPXARphgOCY9oyIhr8Tekm9jGcG6g1MwAfiuUsR1A9fofN+8THk1TT6s2LZMUnA
 gxk90XVQnykH3Zb2EpzFQC824v0EilPClxevj8xcuH67bhu3Tu81RUItdzHAd8YbctYC
 2FICyD4bMtMXzI/ao+ZCRGG9ESO/62h0o9WrSHmqEHT5w/eIthcAVryStwoiqjgGZZPm
 m8sCGqjEjwl5cLF8kSSy6G9DqWo+SWgvhTJtG8/9r1pR2kUSJs09/TvmwJb0TQMDNKNN
 AQdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxChq1cucXbDJug/rvn/xVVNo+hdhEJIXnuNtJ/AD+8IyV60Sw6qCi84msV/gruazZJYGArXK4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLnxDnyrj7q3KXPV9rjdtENkpZy1XJj+ErzLgT5MXs6PJtM3jvH
 7WrvIxhf+maWPnFUhJkKVQcyyTjNqixziNbCRuWSWE+by5xlCvU2DCq9ef4SFlmXuk2Di+6NJ5x
 ZV31Kz8T46MjjqsL0EVX7Z8uiAHqUOsXEd+4xW8WVybNQb+ZsuGG5NsPkM7DnQnvsJEiSSDQ5cv
 hOqd8FpQ==
X-Gm-Gg: AYBFou3FKd92MCHA4m4UkB62bZuVISe3VSS0m8tVjHc+sxKzUxrSb1fpFpuFUP+v+sk
 fYA7SuDa7A5zpQbhvPykpf4agA/P7CuCmJQqPwdNeyTyGcR9+xRBt3njiqpJtoMssAr6+5XGJUj
 zGhc/0A1pinyzEOgU8A1cshlisHzoTRnyd+ttndF9Aj6TdNS/HgIXwB9SVVP8phAk8Kj5DLFRnp
 eZOG03xD9nXL6/Wqqn2M1RlPyfFLx60GGFccjntXZTlrarhREgPzQTULvR64MOQRLa+tAZDGw4F
 k/433h5N1/3yrnWJk0C6KscZvPTjwR+HdxJ37iUIu6VXji5lNf40PBxGCtBvLsb46KU22Vj439A
 IyWhpRPXiKte1lDZ8DdkfMgSAw+DNSiyGKnbB6BWbYBtAk4l+BoKYNKMa+3TdEmqm8CWbPdLrPm
 olJg==
X-Received: by 2002:a05:7301:3a95:b0:36a:12c4:8bdd with SMTP id
 5a478bee46e88-36a42389979mr2722320eec.21.1793339548977; 
 Thu, 29 Oct 2026 22:52:28 -0700 (PDT)
X-Received: by 2002:a05:7301:3a95:b0:36a:12c4:8bdd with SMTP id
 5a478bee46e88-36a42389979mr2722271eec.21.1793339548237; 
 Thu, 29 Oct 2026 22:52:28 -0700 (PDT)
Received: from [10.152.198.236] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a504c6sm3990211eec.21.2026.10.29.22.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 22:52:27 -0700 (PDT)
Message-ID: <8f0c88d8-c19e-4506-8b47-a9a939326930@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:22:21 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mach-snapdragon: Kconfig: add CDT configs
To: Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, kr.sowmiya@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261023084019.3722376-1-abhilash.v@oss.qualcomm.com>
 <20261023084019.3722376-3-abhilash.v@oss.qualcomm.com>
 <20261023140242.GF3596691@bill-the-cat>
Content-Language: en-US
From: Abhilash V <abhilash.v@oss.qualcomm.com>
In-Reply-To: <20261023140242.GF3596691@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyMyBTYWx0ZWRfX73VYrklqef2S
 31y6/c0Mw2FXD9mmTRkt7/L3975mga2Zp26dCDdNh3M+OUXVC2T+d4pwenV07CyBWdXU1efuV+4
 OD0RA8B6rg/8mwyl5LHYbc/AJ9EtSb2iuPeGUfTAwbdYTpX1QpvRhKM4feD3lwCDHxUXmUmIhlY
 I1uvSxaPSPT/eOKRWCtxzurCREazDlaos6jPcvmQ90aqvIxzlE96Hsh+o4AujsD7IfpWOgarRp0
 Lch5EWo1xqxSGoaE4pVEuxzjzqgVnpnZitZ8Z5YTpDGflSyhRoODCZyDIvfA1n1Hf7oz3H9h4MK
 jAmPrAO2IHPh88PLaKYUaMSKP6o3cYrE2fSTWGwrlkqhBXilNFmGNZ3vWT6vjjYCwJSpt7kbeFj
 bpz0w+Vx0/rTP8KjjU14Nlt/BppbQfgmWGXmow0PqxP+qm1R9s1LG1tRhUUEhoSbw8b3KCFiTzq
 1kLsX2fwANk+UgjCKiw==
X-Proofpoint-GUID: n0t0BvIeCUhmFi8AwV82FZ1EjDwvK7-q
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae4309d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=q96kCtdxJ7iQOt2b3yYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: n0t0BvIeCUhmFi8AwV82FZ1EjDwvK7-q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyMyBTYWx0ZWRfXwX/d3LqgRohP
 ntZavpGF7pl4vHRdO4rvgtI1y3xjG5iXBZl+dWeofnGaAg14a6DZT2OTgKtQ6xORSz0cnKirnZ2
 au3RGhGp5QX8ace3mL2BlJWvUQ4sKl0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300023
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HI Tom,

On 10/23/2026 7:32 PM, Tom Rini wrote:

> On Fri, Oct 23, 2026 at 01:40:19AM -0700, Abhilash V wrote:
>
>> From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>>
>> Added CDT related config definition as part of feature enablement.
>>
>> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
>> ---
>>   arch/arm/mach-snapdragon/Kconfig | 47 ++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
>> index 9e23d6d8948..8ad9feb50a7 100644
>> --- a/arch/arm/mach-snapdragon/Kconfig
>> +++ b/arch/arm/mach-snapdragon/Kconfig
>> @@ -76,6 +76,53 @@ config QCOM_HWDETECT
>>   	  Hardware parameter detection from SMEM and TCSR for
>>   	  DTB selection and other platform subsystems.
>>   
>> +config QCOM_SPL_CDT_SUPPORTED
>> +	bool "Enable CDT support in SPL"
>> +	depends on SPL
>> +	help
>> +	  Enable support for reading the CDT off the boot medium during
>> +	  SPL and staging it in IMEM, so that QCLIB can pick it up via
>> +	  the interface table.
>> +
>> +if QCOM_SPL_CDT_SUPPORTED
>> +
>> +config QCOM_SPL_CDT_PARTITION_NAME
>> +	string "CDT GPT partition name"
>> +	default "cdt"
>> +	help
>> +	  Name of the GPT partition on the boot medium containing the CDT
>> +	  (Config/Chip Data Table) data.
>> +
>> +config QCOM_SPL_CDT_PARTITION_GUID
>> +	string "CDT GPT partition type GUID"
> This should have a default, yes?
>
>> +	help
>> +	  GPT partition type GUID identifying the CDT (Config/Chip Data
>> +	  Table) partition on the boot medium.
> These two should be in a choice with a reasonable default.
>
>> +config QCOM_SPL_CDT_MMC_PARTITION_NUM
>> +	int "eMMC hardware partition containing the CDT partition"
>> +	default 0
>> +	help
>> +	  eMMC hardware partition number (0 = default user data area) on
>> +	  which the CDT GPT partition is located. Ignored for non-MMC boot
>> +	  media.
>> +
>> +config QCOM_SPL_BOOTIMEM_CDT_BASE
>> +	hex "IMEM address to stage the CDT contents at"
>> +	help
>> +	  Address within BOOTIMEM where the CDT contents read from the boot
>> +	  medium are staged, to be consumed by QCLIB via the interface
>> +	  table.
>> +
>> +config QCOM_SPL_BOOTIMEM_CDT_SIZE
>> +	hex "Maximum number of bytes to stage for the CDT"
>> +	default 0x200
>> +	help
>> +	  Maximum number of bytes read from the CDT partition and staged at
>> +	  CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE.
>> +
>> +endif # QCOM_SPL_CDT_SUPPORTED
>> +
>>   config QCOM_TMEL_ELF
>>   	string "TME Elf to concatenate with U-Boot SPL MBN image"
>>   	depends on SPL && QCOM_GENERATE_MBN
>> -- 
>> 2.34.1
>>
> Addressed this comment in v3: https://lore.kernel.org/u-boot/20261029062431.3117727-1-abhilash.v@oss.qualcomm.com/
>
> Regards,
> Abhilash V
