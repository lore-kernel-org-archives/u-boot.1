Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1129606A32A
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fzuNdudC;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ItS8LzCF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f8Vo2YIN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F7DA6080C;
	Wed, 11 Nov 2026 17:37:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jhPuspl1DJAD; Wed, 11 Nov 2026 17:37:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5CBE060774
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794418668;
	b=QhHLUcWao/Kc7bn9QZuQhhZ7F0JU17FZKkbkr0o48e7Q3pQoF7E19Iz2WLc0eBSnhOxT
	 HJiWTvjySYw0E2DawLsocpC70LR8LgJ/I789nr6Yo1wVOwZZNgXv26ajbWcx5JYJoqwmO
	 WmNBVUg1bxK1tajhvGKghQvNy/w9cuZuoqdLDzG/ph/YzdYMgpI0oOa0w+ShgV6lhyqgL
	 rcduADyObrTqaN4CNi5RYVDhcZFHsN3+Ro2M79spRCdJKpS1TmloCJ4GcpxKud0ttod1K
	 vpYK7h2US8EtkopM4fgk0yf1TM+gJR41PtrooZ82C8mn7LR8f1AAtfqsyWEmsBkIuEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794418668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cmJe063bpbybLvoukhLMNDXFqb1vpnSLkIVSqGZ8/04=;
	b=tcIlznjzdp9YoFyvt87APiiUMgysBMHG8JZsRfV6XaHZ2B9hozu7RwTmRIDyhvdIH400
	 XmcA1D8v+4Evv90SCLfrABQl57FC8SrJa6wz1RiRm1A4DeYyHyrZ19bq6IYuCk6QI2ajz
	 F8wBunDQ55JCfeimdsER9rt7vB0h8Zo1jZR0qdIifJgmllQBNn0DGQngQZorJYKOj+afK
	 0Z+euWAtHaNc35fRNykEs7AC820hEPBmK20R4C6n26T65Y5RgfY1SKdw0NUktbmHcEj+p
	 x9v9XiVONGOIHCUUPj11gRDqBgSewtpp4ndzjaMWShmr7CE8+AM5bbMPILjgyQ5NOOA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794418668;
	bh=cmJe063bpbybLvoukhLMNDXFqb1vpnSLkIVSqGZ8/04=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fzuNdudCaOjkIAiQ/Yf4MIfhw1Sirk+eCtm9BXGewtcpnnGJDjCVFLjJACnkNvFnm
	 ayp+uhOBy1voFWnbgXQ8fEvzOKnamQPxuB8HQwGYKdHXulhon0/eEYXmlIh1LLYKuk
	 I3PoLcmMcV7hRkFlOXJoPc4vpKKFAk80AgRGiBFajNV2OiGvYbSnyFmbatc1ymATFq
	 4xQWlQDKsUaDPOQzwbod0SDnMzC7kUGZasNrdl5G+jYixRPd9KwH4R2RilOK7+iXkh
	 Qz4I29scJiQaGAHmvZC6WqmmGZBwqhHuoZB1jX9cN+To3yXEtThCZqQgNgHxf+vkKl
	 6v9l8VZfYs5dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CBE060774;
	Wed, 11 Nov 2026 17:37:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DA2D335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1ED138105C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ft09-ku8C8O for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 17:37:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4FE78101D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ItS8LzCF; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=f8Vo2YIN
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4FE78101D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:37:44 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHZA3E2663105
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cmJe063bpbybLvoukhLMNDXFqb1vpnSLkIVSqGZ8/04=; b=ItS8LzCF9wWpaI+k
 v3ISHwfhn5IVrBXA3d1w9mHzIUX3V/tQ8vW/a0GpSG0Y0b3uTuMkVnkaTaD6olPS
 w3DfvLze8n2vi3cL03cVaS936KQ3aAWAYaeWeIKuBNMINd9Em1iCHPe3kzuXxJGT
 AFEsXoumWFWFmQMALPvoP70dmiZSXtB0/cFUnZlmg+Pj7zyAz19P8mlrQ1btGCuG
 mWAQkIhlplSeDJcZiyl9KEdL18uhWNNqpBwWHwjNKisyCpwsvc6izPtjZZ8RMR2j
 1/pSEYrMr/wq03AS/JJg+DfxJ0lGXKM1h5DHHkBmZuihzOQkkf93zV8wqQNvTaLd
 SIRixQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvvw0g0cs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:37:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-37628596fc9so295724eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794418662; x=1795023462;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cmJe063bpbybLvoukhLMNDXFqb1vpnSLkIVSqGZ8/04=;
 b=f8Vo2YINHoAUNO6cOcbDVzYoIfhw9HG6hUHzqWFooX2wfbmMhDL/Z9ipNqIDGAymbH
 Mxx8NbBrm0i8g0kwwVxIvbbCYVGNsszc7nywr/LKqcmMRajrBnrY/xIM6K/at5Ee6Ckv
 aKFcZIb4iaye5vjXHf1bbcyEWCF1G4SJ9PwlFnFf9S5rzI+agFCF4Z8SCEEO/HVniJ0V
 xZbfzVzhuBxsrszBCpmBnzPIDyUyXfy8WBsOy7J0uISXqnVO0gHh5ws9yRpBC6+mi81i
 sgEZVQ6A0LlcYrDlv0MnzrhFJmKEnzX3mplNePEAbhjRFLdU0Av/T1sOFvKEXGBIr9vX
 JkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794418662; x=1795023462;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cmJe063bpbybLvoukhLMNDXFqb1vpnSLkIVSqGZ8/04=;
 b=Q2l9ABMG4cUOG2RK7p5rs9Ucv3+khR9jb7FrBPLphJNRmW4fLP/2lG7cs5Jg05nAqU
 I+MVTAyo+j/gbrVp7UThAXsQ3YFUqW2MBFADBps3Er8AijGoiyz1LrWxrFmyKu71ce9O
 DoDyR+msMJwbQ0Z1zj+H8yhV54ZM6U6D5OExKi9rMlTd3fTynq7qxq+fsskndbYqwBXx
 y9Ri8kmu5wD/L8MiYcOfkFohwbjIdrq09C/6zvxmSM0zdO48z/WFq0TZHCF+QO/hgen9
 kIF3TAdwrN5U+nIlO8SebSPv4NV8pTOdMiGxTyb1YZxLxzbjPMOIhoT2rxAIyciTHYYJ
 995A==
X-Forwarded-Encrypted: i=1;
 AL+hErFUUu7bMKpzfDadxg0ZgjMcZye3kMUrddvvBSPxbgZqK/VZjQ5RzZTBv1+6r39nyZhyggDJ3+M=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z95COzv52IYfphGWyI8KWZkvF/JVzb1iylYZnp4bv5VVlOAv0Hm
 UvojAnMo4kcLq7Wjf5xstM4l3J/4Z5uHKejkXRWxadWWK1+IkdxYten3oDU2KI650RxpbFC0Z55
 93dHaNzqMvgkHwTY44mN32wCZJM1QgaXdvHjKKtXxEV1hwJYL79Ebwel3chPg1sQ7D+SUUQI=
X-Gm-Gg: AYBFou26kcW62GR03AH4+8ToyQGQ5eKa1Viu6niPgYq/GQA4gRhY9F392c34AWkaZXc
 b408VMI+vljrIj18q+vfcx7rTtLPGQ02+5bP/nTrV/J+8GHSxTbQE666V8Q/5QK7H46Y35DUU7N
 HTyUmNasdCTVpJjz7KCXUt2iUydjCMdNDz7JnFU7padK77HYvz3LyTAbrgmxN0feBh2Wr7yjTd5
 iR+x22vDN4GJR9xiDcg2Wmg5jtGO4u9tSR2SwUpO25Q5Ye2Ico7PNHvYVu/Dxh8EjAH8Itm2VYk
 ev3otmh8UT7ckLC00h2QFRlaiWK6TE8RN6HTNE2sVM8UIMUZXkf8PgToewXG63fyY6hPlNA3vKE
 RL2dOtMptdeglj5T48UWcJCBf4rAkYJ441Ul/ct8+S+tepkY+799Btz5j/fx6PVnvmnKbNABQVd
 hTwzSIZSaf6W9Uh1rPdDCGyOI+GQIRAjaXPdSXJTB7Lw==
X-Received: by 2002:a05:7300:8345:b0:362:fa87:2aa6 with SMTP id
 5a478bee46e88-3768076cbc1mr3298947eec.0.1794418662043; 
 Wed, 11 Nov 2026 09:37:42 -0800 (PST)
X-Received: by 2002:a05:7300:8345:b0:362:fa87:2aa6 with SMTP id
 5a478bee46e88-3768076cbc1mr3298927eec.0.1794418661358; 
 Wed, 11 Nov 2026 09:37:41 -0800 (PST)
Received: from ?IPV6:2401:4900:1f2d:ce5c:2174:149c:18f8:34d6?
 ([2401:4900:1f2d:ce5c:2174:149c:18f8:34d6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375218c7c50sm34711826eec.29.2026.11.11.09.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 09:37:40 -0800 (PST)
Message-ID: <d00b0c77-7f2b-4555-ad2e-a5eec1c60abc@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 23:07:35 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mach-snapdragon: skip reserved-memory regions outside
 DRAM
To: Casey Connolly <casey.connolly@linaro.org>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, Michael.Srba@seznam.cz, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261105171752.2344459-1-aswin.murugan@oss.qualcomm.com>
 <7600fb5d-d245-438b-8e26-4a1261c47acd@linaro.org>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <7600fb5d-d245-438b-8e26-4a1261c47acd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5bWNECMrsEwsvrzIHL9Owb5Npe1TGRWx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MCBTYWx0ZWRfX9p70It218Sfi
 XoKUX2zj+x9jeA+fvIERJ9l+EcTsJF11xkMfrpGi3ReHAMWpvP2LBjfUvNAhu/4UZOXggI9ugSF
 15XBUwmSg7qq3KRIqeHEREabEFtO0AjfOmWs6sHxFvuOIA6d+s1V59ATKl5KCiCU9RreFfrDmNs
 LPLPy7DvccN3kssjVhPKq+MhqDoDDyfrIFlDSZ6l8qb/RgC4kEwGuz+Ksd+vpNr78QqwleBiM9L
 i3fS7GfSVKXeVi0EgcZd0FY0xw9cWk78zwG1fo6WjjnglaDi9yEo19Kaqn6M/i4wrNGKvAg7S9R
 I+e9Ocqos62jAFA5cX8TxKiZUTuHEBb2z8QGxjMjZFiEiVhsnHUuPcL3dM9eDAhkam5qcV2Wfos
 /X9DMJHGzfRccQAR1pmnAsiCFnf6CHFiUpM11+uDaEK1bP0KxPsn/79GCNu+YiHUarQmdMW5we2
 0AHrhlgI15SKr/DCllQ==
X-Proofpoint-ORIG-GUID: 5bWNECMrsEwsvrzIHL9Owb5Npe1TGRWx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MCBTYWx0ZWRfXzhWHzxzVg6MU
 Wf28KUI4dkv3vrd6wxkhVvXqJ6DJrvX8c5HQu/QRuKVOi9zWbfrDtsoDjtKNUBFE/Wtt2cv6h4f
 RlY0XOEQo1anoCDQkZIICtBPPw3Vvr4=
X-Authority-Analysis: v=2.4 cv=ct8OAF4i c=1 sm=1 tr=0 ts=6af4a7e7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=snklHaHbM7KCVM-WJBkA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110070
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Casey,

On 11/6/2026 10:12 PM, Casey Connolly wrote:
> Hi Aswin,
>
> On 05/11/2026 18:17, Aswin Murugan wrote:
>> configure_reserved_memory() updates PTE attributes for every
>> reserved-memory node, but regions located in inter-bank gaps were
>> never mapped by build_mem_map(). Attempting to update such regions
>> causes find_pte()/split_block() to fail.
>>
>> Add region_in_dram() and skip reserved-memory regions that are not
>> fully contained within a populated gd->dram[] bank before modifying
>> PTE attributes. This preserves unmapped DRAM gaps and avoids MMU
>> setup failures.
> this still sounds like a bug in the MMU code to me. Does this diff fix
> it? Not sure if the second hunk is needed
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 1c1e33bec24f..7b717413c297 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -891,8 +891,13 @@ static u64 set_one_region(u64 start, u64 size, u64
> attrs, bool flag, int level)
>   	int levelshift = level2shift(level);
>   	u64 levelsize = 1ULL << levelshift;
>   	u64 *pte = find_pte(start, level);
>
> +	/* Don't panic when unmapping a page which isn't mapped */
> +	if (pte_type(pte) == PTE_TYPE_FAULT && attrs == PTE_TYPE_FAULT &&
> +	    size < levelsize)
> +		return size;
> +
>   	/* Can we can just modify the current level block PTE? */
>   	if (is_aligned(start, size, levelsize)) {
>   		if (flag) {
>   			*pte &= ~PMD_ATTRMASK;

with this change, the issue is fixed.

Thanks,
Aswin

