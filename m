Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64598606A32E
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kyHpKfKC;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sl2IDSI+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NXqd7G25
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE30A608F1;
	Thu, 12 Nov 2026 06:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0DLIoUgi1F9T; Thu, 12 Nov 2026 06:52:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C7306608BB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794466329;
	b=nyV7t7jEbmnsGR/P4s1V6ihBZLkr1e5Cpm0V/Toqu6aud8WqUVcvYi5oiM+JFZey9Y/t
	 Atq7F3io+Y/zUc67jw9pe23gGsjBiG1dWtJKbdqQMnheuLkmteEeb5R1Td+ftnfzYvSZ0
	 zqHYD77lLt+Edme9T1l6SDZ4OPA183IE6jYz86sxYz84WJfuPvZblf5bDyKxE8wJm7vm4
	 nOqOW+7Sl0EKsXvr4ueS0m48MqtO7YU1f6gJO2+83GYEajxVBrhcJcaLpcm2xSYChXkN+
	 z/GHe7zi4TYKxPaADgXA9hygxdjaDVRRCouG7u12MbzqB5gJWmxtaSa5TVu2XLn10xQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794466329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qwTJz99Amyv2E8e73qraPEvGFRNOdt5g3jRbmQEnXbQ=;
	b=jAsauxnfSwOYh9B7VOSZVut73Bwmx0CobbWz1QNQV3yJ1fVPZ0FfCM6cVn9/xC0EVj5U
	 d4gbzUcRmbgVEA9jlargBu1TaJ1lDNtNtCilXhFMlmcH/mzknCknEuOJzs150ju/LVAEK
	 1uSxd0GrMocUy5aVi+PHqld3w5MVX64/Hwok/F2g2N5YYmYzFIjYPjGFlW0OwkaJPguH9
	 xdiEMZp+ND0ZSD7eSEhqwM+wK5gk6WlmrmdlSSj2a8rdKdaAaq5+HFd9+EtDE3DHJV27Q
	 1zVnJFrTLsA/uJWg8ffyZRuZHj6y+A1iRGzN/HohkPBSLX7anubMOq72qpyvsgnfCIw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794466329;
	bh=qwTJz99Amyv2E8e73qraPEvGFRNOdt5g3jRbmQEnXbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kyHpKfKCM9lc5KqG0pSQmxoW5A5c1HJLua+H9AIzDwXzMlGzDq48f8ur+yJx5ZPVy
	 U1Ptg5BnPW+25+BC9B7uYCheGgcis8qg4WCMD5bfBCuwqOjiQni4UXkuaHoW3Eq13x
	 hQIPOg/yZvXjrVLdLcV98SAYQz5DN9zHjfSBCCNXLsAS0nIwbztiON/UYnpB75BmcW
	 fuVUkmNJA0F3rFSgaW02FDG4grBe6IQlg+8FMOaDrbzyGYyrr3BDYThT/R9NHQ2li8
	 z+gbaxYw+P1T3AEfYm5MXOWBlmttDD4QBqI7j8cideESOuKk+9KV+DuFYdvfQ3awdH
	 yh9rGodpprGXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7306608BB;
	Thu, 12 Nov 2026 06:52:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C7F9ED7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD3C7815D5
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1j2yEZ9iGzsI for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 06:52:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F1E2D8128B
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
 header.b=Sl2IDSI+; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NXqd7G25
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1E2D8128B
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:52:06 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2ZWcG2514154
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qwTJz99Amyv2E8e73qraPEvGFRNOdt5g3jRbmQEnXbQ=; b=Sl2IDSI+OfxTCrUH
 HDFb0WZJTDG7Rhti/VZz4PO9BJOHQSeeaDoQoZClspawUywGLP6CI5feBMNGk+7V
 i/Wf3MIlXSy8h34/co+l53RD4P0zdefKMPaZSZoKZ/QdV2oxM/sr3+5ckBwvmrka
 +7Mg016Ck5yqauQ5rF9ahrIKicSrjCgM0aBmnfH3Xq6lLBQsxHRwm/bAmSlvHaV8
 UguOBG9oREzHPqkqNeCTos3EVc+UjN7+R4AI0/ovn1OcSOIIIp6ujtLhHOJu0+YH
 TKSnhdHUvrFNhZK1LP89F9O1fyXNdWqezt8QaBzDJ5bo5qxYU6w9PSUyLFHGigPI
 15ZRjw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvwm1taxt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:52:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso7405850eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794466325; x=1795071125;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qwTJz99Amyv2E8e73qraPEvGFRNOdt5g3jRbmQEnXbQ=;
 b=NXqd7G25l0xYneji3Jh+vtoSUHL11toYrWtL4TPZWQmnw4Grvb1/PMMKnMB8EHqxmd
 Q8eII10ghBBNUgw1LVOqt2x9JmF6muLIdwhW50cxAN833iVTx7GnX5445i3YgOFeCZNW
 7RihzwpT8CAx5egdpaPPi6aZH8o1RexZ8WE2NPdwCETTEReeowfUfsNgxi4eID7QVX6f
 PeIJjR5GokOGaUTQ6Kv6dOeDs1y/UQIFYxnr51J2s7on8ryvU9lLhhgaA4Lmt9zUaCZ7
 KzGqbSZvGZYq5A3GR09G+znBmaXTthS9U8D1QuO0SmIzpPixVdjCRiNTtfA7fjHmUiwL
 H7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794466325; x=1795071125;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qwTJz99Amyv2E8e73qraPEvGFRNOdt5g3jRbmQEnXbQ=;
 b=jb9EgRU1W4At7RFCUVjA8fFtA9r49d6glLLGH0uBqF9iZNtU6QuOAfqOgKV3Or2W+8
 raszu4t8cX0mP48TrzX7NZi5/m8DZ2eZBtARAfB1JL52eF0eg+7lnJm3p717ur46NLhm
 xnvQ2Lk7Vh/+o5Jljf5+q1R7CtM6NIN9SOVaGZtwDbl9P33T8wRs2fsxGbMUcVZKqSL/
 nucn8+UCKTFrRR81zjjLK17pVchqiUxB6RE1IkYx+v8eQ4Qj+/bcKyVCHNMGJLw2iz7w
 CUxZIEWfLJ9IRL4a/RvyK4SLbLvKTlqKMcb0N0UpBUZBwm/LjCFoPNkN8Okbv8AMJwJv
 O/Ow==
X-Gm-Message-State: APuU4Z/JX5lTmu4EaehouptLFNHVNLn4tWE5/wmsd09/Zp+9pUpHRXW0
 BWCHtYRMLCfXOf9XzApIQAyU1erZ7BQHhRG+Z4dgMgwnJRtydb40UfpLvnxsLf6NURdg2zspDjV
 evwWXMdv2yCIRPYNzVaEJQccb1HbPauYqdl+3ZkfnSVDry9Yhnn0lExJzRCh3pdK/i0CZlBg=
X-Gm-Gg: AYBFou1by6GY1xWV3ANlL+CgT1LKPYmqBFvBsq1+1AeWirHP6flcMTheZASufOQvjbN
 sezol36CVI9XUbHx2Qm5bByh7JVyXP7ti7e/+1alwcO12WEdpcr1MQH1HTKVM4RCCQKHAyuzVyg
 BlzDRkvfpgIMiK6HyG4W2YqdSZf3uQsEgvHUTJVDnTqwinJ47LYptK2ZBL3mMT88sDh7jGu1Cts
 98aUATOElFAYP//TnBULrTN+abMHJElptk2jsLH4Dzd9zkiwzTIle5gTRTw8psLWueiUNJcTxDS
 YtN+cWgVguF4qy/PNNLEfF32zlE1aggZW3NRTRiKMFRlUNa8M5to9n/Byy/xbAxn5mO+/63z/JW
 gINew31sZ5yhV84wF7KCg93oFMfbYYZ+A7KOGx8zkJmB73+25svanz8V9xcxmLBi+XXtP43hYwB
 lVCgVVw1fjr4c=
X-Received: by 2002:a05:693c:66d9:20b0:376:682d:bf1c with SMTP id
 5a478bee46e88-37686b42abamr5181496eec.41.1794466325216; 
 Wed, 11 Nov 2026 22:52:05 -0800 (PST)
X-Received: by 2002:a05:693c:66d9:20b0:376:682d:bf1c with SMTP id
 5a478bee46e88-37686b42abamr5181468eec.41.1794466324411; 
 Wed, 11 Nov 2026 22:52:04 -0800 (PST)
Received: from [10.151.41.168] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520cfdfadsm27215845eec.19.2026.11.11.22.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 22:52:04 -0800 (PST)
Message-ID: <38e586c6-0350-4c51-a63b-1244d09379df@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 12:21:58 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable U-Boot SPL support for Lemans EVK
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Guodong Xu
 <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>
References: <20260928-spl-lemans-v4-0-007635cc4667@oss.qualcomm.com>
 <20261102195900.GA506741@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261102195900.GA506741@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6af56216 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UcrxqIhXtRQzHO4K1FAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: FNh12c8jXWyarjR6TFkBT98n6KrMxeFF
X-Proofpoint-ORIG-GUID: FNh12c8jXWyarjR6TFkBT98n6KrMxeFF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyNyBTYWx0ZWRfXxDOwkmL2tSkS
 5OBQXgsHGcEwJJTYLuhBB3TwgBQ12y0kNtj8KKPWT4+BGoleFwmfRY2YKNkKFZLa1gwnoA2Ra1d
 xLIMZyRlUR4eaI0cX7S19h+I0TRUW8kURa1EnG5IGiyuN/FMNxQ3WAaml3cyI/G7Qe1daYf0+MC
 0Q3CGhTLRvd9gAN10Lu0iS0hOym08YbbisTGXRr/JezdADFL2zNM5FlqDS1KzYB5KjSG5WSWCEA
 5o5iMPQ+toyCViid9L+OagPlXu9aDRyFd0dM/Y3YbUuXM9e9mXr/5P8aqN7ItgDqMRDwi52r/3j
 mnyTXdASlvsxzm7L863G1anTBVGWjQfD9SJhgD1fRZlqYts6MTOjt7F9qOcylbsPk7f0Wlwa3ri
 hodD4mdWtO2/H8iNT058sWJXQ3qnuG+tMueWkjBYVJvY4nQSk4W1Bghbsl9vEgXtuXTt3Qb3uwM
 XBd+qj2bP5wT3BsuqHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyNyBTYWx0ZWRfX/lB0UziDPpn6
 hN6+SuI/4hE/+MG7GD8uhTxMqHPCRIR4yKDScEVyru1HJL4XgoPYrk1433RK0W8freS2e/CC0Fm
 sq1txM4hQI4kc7kRhdNdgtWctFf5d3k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120027
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

Hi Tom,

On 11/3/2026 1:29 AM, Tom Rini wrote:
> On Mon, Sep 28, 2026 at 03:58:13PM +0530, Balaji Selvanathan wrote:
>
>> This series adds U-Boot SPL support for the Lemans EVK.
>>
>> In the Lemans SPL boot flow, the sequence is as follows:
>>
>> PBL -> XBL -> U-Boot SPL
>>
>> XBL initializes DDR and then hands control over to SPL. SPL loads the
>> TFA-OPTEE-U-Boot proper FIT image from a UFS partition.
>>
>> This differs from the generic flow assumed by the new Qualcomm SPL
>> architecture, where PBL loads SPL directly. SPL initializes DDR using
>> QCLIB and then loads the TFA-OPTEE-U-Boot proper FIT image.
>>
>> This work is part of enabling SPL support on Qualcomm platforms,
>> specifically targeting the Lemans EVK board.
>>
>> This series depends on Varadarajan Narayanan's "Qualcomm ipq5210 SoC
>> bringup" series, which introduces the mach-snapdragon SPL architecture
>> used here:
>> https://lore.kernel.org/u-boot/20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com/
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v4:
>> - Remove memory node as now the available RAM regions are taken
>>    from SMEM
>> - Link to v3: https://lore.kernel.org/r/20260921-spl-lemans-v3-0-de4b54320c71@oss.qualcomm.com
>>
>> Changes in v3:
>> - Rework the series on the new mach-snapdragon SPL architecture
>>    (board_spl.c, fit-handler.c, qclib.c, pbl-shared-data.c), replacing
>>    the monolithic arch/arm/mach-snapdragon/spl.c and the
>>    SPL_QCOM_BOOT_FROM_PBL Kconfig option this series previously used.
>>    Lemans SPL support is now a board file with strong overrides of the
>>    new architecture's __weak extension points.
>> - Add board/qualcomm/lemans/spl-lemans.c and include/configs/lemans.h,
>>    replacing the earlier SPL_QCOM_BOOT_FROM_PBL-gated code path.
>> - Drop CONFIG_SPL_FRAMEWORK_BOARD_INIT_F from the defconfig as now the
>>    framework board_init_f support is removed.
>> - Link to v2: https://lore.kernel.org/u-boot/20260615-spl_lemans-v2-0-d15746f4a64c@oss.qualcomm.com/
>>
>> Changes in v2:
>> - Rebase changes on top of already added arch/arm/dts/lemans-evk-u-boot.dtsi
>> - Link to v1: https://lore.kernel.org/u-boot/20260606-lemans_spl-v1-0-ead97dd5b515@oss.qualcomm.com/
>>
>> ---
>> Balaji Selvanathan (3):
>>        arm: dts: lemans-evk: enable SPL support for UFS and dependencies
>>        board: qualcomm: lemans: add SPL support
>>        configs: qcom: Add qcom_lemans_spl_defconfig for Lemans EVK
>>
>>   arch/arm/dts/lemans-evk-u-boot.dtsi |  51 +++++++++++++----
> For clarity as I try and clean up patchwork, this series needs to push
> the dts changes upstream and then be re-posted once we're either on the
> correct devicetree rebasing tag, or can cherry-pick from there the
> required changes. Thanks.

yes, will push to kernel dts upstream first.

Thanks,

Balaji

>
