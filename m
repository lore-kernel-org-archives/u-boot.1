Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D741C61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 10:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D36638070C;
	Wed, 11 Jun 2025 12:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ne2pROuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D40382B20; Wed, 11 Jun 2025 12:53:04 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6EB480050
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 12:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DLI3011142
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 10:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MWjWZOXgJHNO75H8ZxKMxX81kKL1lydkOQ8H5/xrMyM=; b=Ne2pROuwOeueyMvK
 1xAjn1tTwalKndhcmXl568/JuKn61uHdIE4nNrfZsdZukzAt9GwAUcO2esH+tAEt
 NodE4E18Q3X64vMtNbWpNXx2yT49AHkIsOli+ne3k0jvPKgwT9ibMYN9GFrU0N44
 GnoAAnxPJY4ZbhttQH/EetZhCxaMIvEo3bWio4Xh0t8OxkLtzk0b+HgpjTdSiuTX
 XACdF70w89UnUrp95AFXZXrVWAGAgHxD+WMgHjBlT4JIQ3pKCzdkPGfiAS4Wqk3Y
 SsAzM8W1kjVJz6O2gq4CgFwiTzmNa41/JDi16ULY6egnPudsi19QIEs5KNfNGt/a
 0aNXYQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ekpvbpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 10:53:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2350804a43eso101867005ad.0
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 03:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749639179; x=1750243979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MWjWZOXgJHNO75H8ZxKMxX81kKL1lydkOQ8H5/xrMyM=;
 b=sMfXQSlvIV2MrqG4fXbSsYQle/V2IXk7aum3IZIGvNeAm590EzEHjbgNB6rH63bIBK
 /u3sHOPC9NyaPWXw1NTtDdfnLCRgaaJZPTdXbMAWxj2hZ+EkbSB1R58qE+ygSfF7sqPZ
 iuDtZZZz8ovfkgDdFM5f6jyxRXdbIHMHJ1jMYAZbJqKknWuQwXkDfr4C06IyJp7oQzN3
 krCgNGi6szIyv6NUVU608J8cY41K/w/v8hqIB3JJF70nQR3IYat0ulg222ojy2lRYUfi
 U4PL+8LjjWiU5CDU1xcbwZkp3I0ah3ro7kUdbiluUx7lZpPxDfGN6IdoShk1rAeCI5rd
 3E8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuOJqCylCGA8dLuGHX4s5/xT+EKRwVYu9VbFfhOnk3kOIaakDcUd+W2anXO4/uEg04o7NWlM8=@lists.denx.de
X-Gm-Message-State: AOJu0YxgVm92CLjroosqmR3PU6C7DeI1pDC8+jEE1/Vx8MFuLTvfZQKM
 +XKMVDKPkEmo8hJvVwDxoYZu85Jq+ltgRm0n4k4X5Qrt5cuHYcATq9FAbC1/sO8HHjn09xAibal
 YcBmJsl++wOBfhRzPRX1edX/R24ANO0FzrW9qSLOoBbJaps/e1GkZOvCN
X-Gm-Gg: ASbGncuud2rLj8RIvmGsgpeWQhhcnjTJbRKoiYzrKLwAaigxnJ0+SNTngOXFb7jJsG0
 bx0h5f3Ol38xSNHxOJJs96J0PPgIQtP1F6uU+ptsbd3RDYuLwpGM4RGEmKZLPxijnUU5BRrXkDQ
 miv/kUhdM8z0hR1xPS35EDyIvn2v+gyG7DFMrQeMgHWDnjcxxkPjPImD6ZvDEl7i/EDheGQ4/wQ
 IA93S04DGlQE2rSQPh2rj62aUkKxyT0VA31c55gPF3CEQ/oO+9md+xCRXebk/KSl6bqP/awDI2K
 KZ1ZUBtMgiyoygQw70KQgY0ajvWBFWkOoX3zsWs5OEDElA/xuwYj2wA=
X-Received: by 2002:a17:902:f54c:b0:235:ea0d:ae10 with SMTP id
 d9443c01a7336-23641a9a44amr44907865ad.12.1749639179163; 
 Wed, 11 Jun 2025 03:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb63OuvvP4Ols2HnIZj63pjS5jZBpRvjv+rci+igtomyArihgWJKigIb/NP6LSPYvE897v+g==
X-Received: by 2002:a17:902:f54c:b0:235:ea0d:ae10 with SMTP id
 d9443c01a7336-23641a9a44amr44907505ad.12.1749639178754; 
 Wed, 11 Jun 2025 03:52:58 -0700 (PDT)
Received: from [192.168.0.5] ([49.206.97.124])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603504eb8sm85336185ad.225.2025.06.11.03.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 03:52:58 -0700 (PDT)
Message-ID: <9fb6ab2f-5f61-44a0-bee5-5a429f8d26e6@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 16:22:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: qualcomm: Add MAINTAINERS entries for
 Dragonwing platforms
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, casey.connolly@linaro.org, 
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 quic_varada@quicinc.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250611091607.3512332-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20250611091607.3512332-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JcO8rVKV c=1 sm=1 tr=0 ts=6849600c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=265LD9mWUadjYELWBiwYpg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=Aa_4p8kJ_L2R_C4o18oA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA5MiBTYWx0ZWRfX1hfSQkSSf+bk
 iMjg+IGqAKKlnAJE7N6KVY/KDiNDwIKQqaGMvcJlCZ2olg7jPkd9ObjSdOqP7FxUaD8f5clFIi2
 LhyIN8+1yt99HW2oKHIqWURsVj7NrrKeIUV7Yxz8udGG72YNnT8i/0tPbLhyOqCQ0/mMz+C5w+6
 vMdwIPbY58UBIrFqCrj93JgUOynWSk5H51h5CZ7gZZnPCkp6otFMTnMQuLfIpr41x76+OFW8TXX
 oV7+SMReHsgg8jAZDBdJSt4R3AORG5OznUhTCknyfZePydmMnxOtWP/7rdEnfj4N2H7IksTblex
 I16eA9Lx+Sy0xcCGBu9Kds/L7iawX2GTTh1WSkEaCWbe9u39aXXueVggUSuwK/ZwGjf74sCecyM
 vHOE+g4CqrSowUOZOrbXU6x39goOr24bFBqN/ooGgH3mpaTUv48Pm8nhIo4LjY3qD1Dbxbu2
X-Proofpoint-GUID: W1mZ0sUwgESsMf6LMC_t7ifU47nTVSeO
X-Proofpoint-ORIG-GUID: W1mZ0sUwgESsMf6LMC_t7ifU47nTVSeO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=649 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110092
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Acked-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com

On 6/11/2025 2:46 PM, Aswin Murugan wrote:
> +QUALCOMM DRAGONWING QCS8300
> +M:	Balaji Selvanathan<balaji.selvanathan@oss.qualcomm.com>
> +S:	Maintained
> +N:	qcs8300
