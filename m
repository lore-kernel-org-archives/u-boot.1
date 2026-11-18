Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FFD606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GwZapID8;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kZRjKJi0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gzFsdUXi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7ED6D60735;
	Wed, 18 Nov 2026 04:07:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZ9jzdADIdIn; Wed, 18 Nov 2026 04:07:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3FF760743
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794974856;
	b=sqL0gKoq5dD/B1dLgbMswDScIndpc5wouJEnHqY21FauRh+JOQlSx3qKprajhqi4uGYf
	 T10aAAKh10Ubl3af/a9LFq1egdD5MqFj4uA/r2KFnTKcjL0cfoP91qzAjoqTxvAHpHmnh
	 6jPkTDcKxijGMkzfTZSh3EDswBrqXpT5N7Pt1DcLy0ildkJuwLefh2Of9oAqORhw5BlF9
	 R54Rpzw0vEyoWpRv0HAUwslSjjDAOwaKOEuHj7As78PI3FBwg7/twQpyeAxnjQlG2L3+/
	 Hq8CN8KE/fNg6sQtO5EYIlC7oUH+Rz9bgQFBhbhdfdKYI9wGkDa5QLhqZBnci6eZ+Ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794974856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fysATPctE5Z29nub7qW7QpC1zL1j3wmTa5qcmspXSo4=;
	b=H2kwQBl5eb8ja6/T18MbfkGXl/NLgvC2P7UVRFNMVnTywFh/UMTlTNO/1JLiEe5Zl1Z/
	 SeTF0Z464dPcFfzj2BN3JhP2+0vgxVz4VJtlYfKnEkpRgXclv1QW0Dt8BuIfnciEZNv96
	 pLsYY/CHnkqeirQpABiqrA0XZZCjUilBX0GSMLbgNbJW4nmR7QG9aFz0FEZQoFR3iEG44
	 tF84ifFO6GdDvygnh9pXjNEWA6hE2g2hV5d6r60ga11JaImpdbWYFWjpU74SFMyuoCRE7
	 x9xmd+dOjh875XCT0VcIQ1CqqiRKO7IAWWRBcYtr4p8AHRk7uQDAjXgnUwLZ1ADfdMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794974855;
	bh=fysATPctE5Z29nub7qW7QpC1zL1j3wmTa5qcmspXSo4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GwZapID8hNS7HM8iXAAyOVdZhnlLP7vsKlNCzP9XXx7j8M5SUKCSrbJmPbWvcQzOL
	 QpJZsRSepsvA/O4H9sHKCFz3C/b3UlkS4+mW3t9jkeJaJTG8BsjGQ2YYjEUNbaX4L/
	 u0gAA8ds5fG35liT2PFqoR04nhMCJOjfln9xpRcmQIUzotsAO/nw1QvFHpioxlzdDz
	 WAory9BTIbd4kyF+/sldwYVKLuElG/JrkKxyNC4JqY42bcE4/kORW7o8OKVKb/DgTv
	 adspEWZ0PwxKGWSaDIy5iEcqrXQ8mOz40efF423951CzqpOhcABoC+CERmQ25uNRwH
	 5b3ajA6lBsTjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3FF760743;
	Wed, 18 Nov 2026 04:07:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 40E649F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26EC28108C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JEuXLiC2AeEu for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 04:07:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E1D648104C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=kZRjKJi0; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gzFsdUXi
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E1D648104C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:07:32 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI2Utco1959667
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fysATPctE5Z29nub7qW7QpC1zL1j3wmTa5qcmspXSo4=; b=kZRjKJi0F44bKpUA
 W4luj284aFw+iRN0qZ7GWW8nkx4kaO++lVue7iwmgvVU0wFUNELvgXZYNf/QPM2J
 JDJ2dasDw5/v5UKpD/RxH8kbSBdtgeNs8tTk6dBzZqgP/s+bm4Gm06Fw6218msIK
 rEGs6FHklFzeVwZwg8lHupJ1jgF5EwCiS0zlE+4RmGnxTdr4iXKvB+byErHhH2nZ
 qOwDAgarwQv0u5ZFMatHKHKheBFVd1xmxYRDQlc4pH/uC8HAWv+/Mi70Mhwx+QJj
 8z8PRP297Nya44CKidyTAM1oSRasmjD6cM9Wpnz4kiut2OD/+f7525V2+X7hymrH
 ayDZ2w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9h39h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:07:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so886985eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794974851; x=1795579651;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fysATPctE5Z29nub7qW7QpC1zL1j3wmTa5qcmspXSo4=;
 b=gzFsdUXiocRmLmJx6q9qHBDj4T9Jb+LqcvXHmRqgmq7iZw6dlmQ2Ag6XKM0yIKhWbK
 JoGhrcgX5oYhzCBSOMGBmq6a9KKpo/9Q8lj8u/S8tQUoktOXWmAszRk04tK1lxnBXTSx
 OCf1KS52GlP2bMWFx1JQDRxeGKm7IDobnAwGsFZsIvDasxacW5/eloFOB8smYLf0fB6C
 4K4hYnG7IPxMhkHtSLY6FB9VHvVL8qVx6om+d7nNgRKshiqz9RGoV8ELgPAvhh76eY3T
 t48KFVl8KC483ZyGY6RO+YT6xQQcS807vxCxmH7IDGW4A1t5vM2mNChZgwHgfI4lDNTR
 z4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794974851; x=1795579651;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fysATPctE5Z29nub7qW7QpC1zL1j3wmTa5qcmspXSo4=;
 b=DIXwAjs+0t6ohWKbybsQvyIfDBBDL4B55l7/VQaPe0lVm5DtIiYbpxErKylfKC9Gq2
 AmrP4efy/mCgvnYIgxYzRbozEP/6Uur6dt4/oE2nzffAnoBpjWCZRle8S7HPdkBpMbDv
 SHjR5w4KFH10IczzxJCJD1Drb4lFxBWvgJTz0Fml+n7BeeURoeoxwn5dSL4dxwnAUiSe
 nqFpQ10coefLT9hvByk33Bx1TxQFLL2iYqhcUNa+VoyxjO+tWc5jOliibq8CqA7MZILl
 PpS9CrdjQsRf7vZEoja6R9XE0xQO4Ijzu1MU155eB8FsfhG5So2NbcP5eZIJbeDFjf7q
 oewA==
X-Gm-Message-State: APuU4Z8bQntGFcexoMNG58V7osF5lSmqV/H8gfvWU6Zk65+gCIDQdWYS
 AXMU0Mz7dnZvuDdsB9+zkzbxwS1y+SGx+rLify4rQBHhlRjV0kf5+UMGN3AQg81KryZX+uAaA4m
 fwlvfEO1M//1im1aefS4EXxxMZqu/CDgIhMRcpAL5fRhuH/7OXzRyNjQ5ZBQVpdiIGExMYcg=
X-Gm-Gg: AZFdTZei35rBEQgqjrWi20cYF5obVXUtkJyE2C3pwqlRWuRJAQ0wfuwk/Xgfs+KjUhj
 S+5qY7H8NoA87nzb56vZi7GWUUQPdU4itm50WczESQCF9zGUKzc8iYdEJ57RuFhsqE4w1jLTnk0
 D+aWrIBITs43+ep2b0MGqbcKePLtqCfynOmyDWTuG2/Zavz4rkXadcdXhmks7++WUjQZWmcuZOj
 v+Rl5/+V390/J1qigDvJEx99bpKkcIOBPyjWUfpdNoE2XvpbO9ZRZc41cSSwpU9gcczGga+p/Ze
 WbaZe8Br7zJ3+0QqX26tR36y1azLjGL2shnt0O0FZ0+KtdOI5hoMWMChmrUrWtshU0iIgsY+elz
 BTlyO0dPBOyTalPQmgtF43ewOZk1YBLGrj1fUgMq97TgO2WyYNlnxrYBedjvvoHE8Y797/vrPsi
 odXZb+D0Ua6O0=
X-Received: by 2002:a05:7301:6184:20b0:36c:a44c:1763 with SMTP id
 5a478bee46e88-38281813f4emr1346150eec.32.1794974851007; 
 Tue, 17 Nov 2026 20:07:31 -0800 (PST)
X-Received: by 2002:a05:7301:6184:20b0:36c:a44c:1763 with SMTP id
 5a478bee46e88-38281813f4emr1346121eec.32.1794974850476; 
 Tue, 17 Nov 2026 20:07:30 -0800 (PST)
Received: from [10.152.203.87] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a6800338sm3131535eec.11.2026.11.17.20.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 20:07:30 -0800 (PST)
Message-ID: <1dc0a453-9635-4e40-9838-e86519038644@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 09:37:21 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] env: scsi: Add partition type GUID support and
 choice-based selection
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Denis Mukhin <dmukhin@ford.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Carlo Caione <ccaione@baylibre.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Fiona Klute <fiona.klute@gmx.de>
References: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
 <20261115-type-v5-5-79e76209457b@oss.qualcomm.com>
 <20261116183545.GD554944@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261116183545.GD554944@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QenzLcbv c=1 sm=1 tr=0 ts=6afd2483 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=zWS-tMU0tXKGsNKVhrEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: Yo3UO6HmhkoEp_hnMKJy5Ha38nYd5PjF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNiBTYWx0ZWRfXzlzFFslNVxC7
 FZwWNfppA4xUwSLatf0qE28ZgGkLH3/Cpbze2flGkBDXk8b7WYywgdsgIuioKCNpZNpGyozHmoN
 37JP9u5ENBu60dJ5A7FrvuhKfFHmMqbVaM5/1IgLoSGjWY3c6vCVSk8M56WH5pOQB9rXhOmPGZT
 vjYlIlL8Z4GaDK8SKwK7jKrrP0tPdY33W2cdZ7/OrwMr1lg3HXtUN8cSoDP5ngPKeuQCPE62qAb
 geS6bkqzZpnffrBUnOseoMPqZkp2uxyuVXF7OqQuvvk7KH0mfDjKpQu0etw2mqGwYBQKtSB6iZV
 iTadn3de2UG/LIMdxiJ72VkPmaY42HsO6fnWtWAZQPgnJ4FhHICZdxzH4YsICvh1/Z8uhGlfG1C
 HU7ozio+VwWEKbBeyuzubxXK/vHnUh2fe4Unn4fXlL7xqcXmfaJx17HqNu+2U64+uChHs74rVJL
 pfMwtCmFAiG99C9PiqQ==
X-Proofpoint-GUID: Yo3UO6HmhkoEp_hnMKJy5Ha38nYd5PjF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNiBTYWx0ZWRfX20xpAfDHRTJV
 hKQWWX22t+GmXfLptngwzSUl+tCc2/8pyDPdl/3NkpSuPjuxBdmKZG/Nl+q6x6M4twDZiQWECP/
 yX/qLG0+AZChXXfvXwKkyUcAwaDRs4g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180016
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 11/17/2026 12:05 AM, Tom Rini wrote:
> On Sun, Nov 15, 2026 at 11:56:07AM +0530, Balaji Selvanathan wrote:
>
>> Add support for locating SCSI environment partition using GPT type
>> GUID.
>>
>> Introduce a Kconfig choice statement to select between three
>> mutually exclusive partition lookup methods: UUID-based (default),
>> type GUID-based, and hardware partition number.
>>
>> Reorganize existing configs to depend on their respective choice
>> options. Update ENV_IS_IN_SCSI help text to document the
>> new configuration structure.
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> This patch should just be reworking the existing options in to a choice,
> not doing that and adding the new one. The new one should be added in
> the next patch, which introduces the support too.

Makes sense. Will keep the reworking of existing options as seperate patch.

Thanks,

Balaji

>
