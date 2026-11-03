Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFE2606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 05:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BjnAj5aO;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PUSNx0W0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TKu9wwIo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18A476070C;
	Tue,  3 Nov 2026 05:25:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zdd2eJ0t-YXI; Tue,  3 Nov 2026 05:25:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2435E606E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793683555;
	b=R2Z6vRp2R5tejiswKXbZz+GrMmTcH2YcuzPqFH6HMcwUvfsidQptIjkxaXavG7C5+Blz
	 2tQ44LJT8/10Px2+l/x3Q7v0+lAZvpEnYYwHLbSXYljLJ8sHV4ORnqxM7WzysERIjP7wA
	 mcsOIgZI+V2tWH+7Hh9Gh7BgCyHyNI5PWHiHtQxKK6t/59TeBW4/QqRDY/e6UZBQWgBzp
	 XSl8AvxHJR+B8wus1jUg9iunYfLCD9eftzJnJVzVd2Tkbd7ZM3zj0RRez3et4fh4oyhFf
	 SGJDVBB2qW8fWsBvt8LVSKU8svvCLrDlwEUqe1F1rukPABvcaaKVB8q4JdFGAdKIkVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793683555;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VcRV+zBMUUea2dJriKOzWEEiBTOy0Am9QBuvitwo4BU=;
	b=VY6gaPQLMV5z74At0/l5J0mWGQhky62H4yyMoGrhGP/KfdHD7GhsFhQM3ycq0wC+DCEP
	 emicILFkDCuHeqlu4aL2HG+hHIYo8g0j00c5PC51gq4+/zHUjK4j+T4Asa4WX/jknktDZ
	 pMsJZSS45L0O7LEPDY43aRmQNfS617826AXYkjLpXH9xj9vsQsIuwVhVwdDMFMffupTjx
	 JJzBcKh3tpw0oNA8DDcyzBqZ0hu8ajNf6JKkfnKszdXwfLFj7p4ndAJPiT1ULA0KaZxSR
	 TZ4xlvtOeApR896iHl59NvNtBNMXe8c2dQsAI8zbtE6yZSUYPINw9uPZ0j3PlfNNSDw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793683555;
	bh=VcRV+zBMUUea2dJriKOzWEEiBTOy0Am9QBuvitwo4BU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BjnAj5aO9jTs+rMpvjoG2+g538ewsttNs3eK5optc8Og/OirMuRchlAQBIp3jCFOO
	 h9r4283oc36bviRkUmy2iOJer3UR8HiY/kAJxIbbxqKUyD9ZGK4kjyqjstbX6DAYIu
	 yJ9z4gLlvLYnT0ZEy0Rou/wlaijDImHNyfYlgLhHm4N/V9hOwhdlxf2SfxzPKbhlJz
	 8ipfWw9WSpw11xybUU+S43kFnMGO06jGOyf+gABviPFAQ4ayE1eF7UO4yYAJ8bOwxJ
	 r5nHP/nhk1CBlAlxlczR5NHHYDb4pfkDRlMm7X/KyAvT12gokXizAtF49g/2ydO4y/
	 NL2S0kiUCxbPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2435E606E9;
	Tue,  3 Nov 2026 05:25:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF7F0B00
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 05:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0EC480DB0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 05:25:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hHssDLOJ_Vnv for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 05:25:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2281380DA2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793683553;
 b=pWtcNpqgitPaUXAeK4BJf+y9bzjnSMu5vO7oWcMh8VqT/Qj7G9Uh4iHn0AyytnMHb3vO
 aMczSl351ppmpLzyiC5lfYcrmEP+MauOv2Y9ZptthfUOU0VrUMRh+dufWqCxztaRnnnEx
 3omhI60STCNXJuQnhxHtDNRs46Kpbvzd3v1/9gtp/I1nZ/y5rgMqaltrGOn1diHw8tR1M
 N7YbeQtwZOmeDa9bHmwVIm9r8dcLOO/tWtoFYgtU2p5NwrNOLPSI1lBuzT6+UP+wSMVOF
 0IkwqkBSdaAIrTVsN6gKYt6rr/NKcbrPhvt1qo4Y9MMKz64th2qZTad+Y/hTB/rtTMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793683553;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=VcRV+zBMUUea2dJriKOzWEEiBTOy0Am9QBuvitwo4BU=;
 b=V74dcp6FsFZIDjGn0lzOoOSsl2uO9o37g7uQkzJR7JhkhsBla4oN9p3tlgjnrP283v/f
 J9FOOEuAMgCMWo67qjCO3C6hxSA/R/s/hRSz32gHwcO+OIpf5b1Z5GaZ91go3EiRCXdra
 F1+0ahloYbeJkaNRWLUoscxJ/LCTi1bwqfYKIYoaf339vmPbBQIz1zlW7bCNMWb9yPuRB
 5eBCeM+oEj0zJAsZzEfrJUQBc9PRGSSDxrdMfErKfCdIK4TCqvHDG7WQSD6suNc3qz1hl
 dsUmSeo3HrFXWQSjJC7Nx0UmQE/8Nds3jRwI89HUeTnxxDOnd2leN/T8rM2PbtJ5OZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=PUSNx0W0; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TKu9wwIo; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=PUSNx0W0; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TKu9wwIo
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2281380DA2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 05:25:51 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A31eMQl1431334
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 05:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VcRV+zBMUUea2dJriKOzWEEiBTOy0Am9QBuvitwo4BU=; b=PUSNx0W0wWr3WRg2
 UX7keAwSVfarBR6A0c8k6Jnh5RbEheqL87R94QYd1BxHTanxk7RPCAXS2X/kGHjB
 F+Z8K6Xg4UGe9fn4764oMfTkH0Xp++C/Ro9ibtUYBHxJn5gDGNGABH+ERLdDR8Hb
 ckCywJRzXw6Sa0tw2OvXBu5sL4sLGhHfJ26L9eGRrEKSRegP1k/nmG7vdEdb0lQq
 c8F5xCxSBzW0SdGWWue7m96kGf1o5AQN+vgJDLBv3jrmE1NEz+qCHTW2AXLtXTlS
 66ZFSVn4CBOiZ8kOoIjfTFVAg73SqOcgc5Q7LNpCciJdYapAIGUyM4gc43RLsWmn
 z0ALmA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq08722kq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 05:25:49 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so5900383c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 21:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793683549; x=1794288349;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VcRV+zBMUUea2dJriKOzWEEiBTOy0Am9QBuvitwo4BU=;
 b=TKu9wwIoP7To/oz5NzwswpkbBwbshfJhmCB0uYPlfcwQMOcWKtUQpVM5FvIRgFTtSA
 Rt47RaikKO4u0Hlj9GHCx2LDOpV0eblHokQ23icQpRVBr5tbg1EqPiiUU60Lpd7eC+7k
 mbf+i90MqT1QiIkgObHJqzSDhWXYNJ74486mq0wqHefOk0B8BAAVrhf7SuP8RswxSTYo
 izUecvwU6tH4hEi3iBHlSYNRLIkVk+t4GsxUGu/GRQjSGBR0WXFl1aBOjT0VxSlhEi1r
 ZzuxGUBVGRb2V/fITuxyTDQWKQjMA/ImtiXckRKk8nUNmE+qbSjdBHOZ2OX3ULPu6lwF
 ffrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793683549; x=1794288349;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VcRV+zBMUUea2dJriKOzWEEiBTOy0Am9QBuvitwo4BU=;
 b=JoImlOtQhUNuGooU1Ukm9qELEZEmLn1szAI7Yo1GHTBDvR3u1hWsUMiNVXYVgKwPxP
 UoLMh6jZ07GXOPu7zig7ONbTTuMr46I4gvJRSIrnLRvVK28wekYgfNTYQXbhPdiNSvbW
 C3tlZGfuvNQ5wXxjzC9BIET3uZAQHO/AOYTUSbVwXrU6WchAzfLBXtzM/n/1EH0oQE7I
 FazKmmDQwX4uNCZCgu3/FUj+F3tRxT9NzdqTGrEvE75RzzgRODSgLwKEolcYiNsuCIZQ
 +E/MLM3RJ2NvwTHMO/f3YiWm/ftp4svmStEMuk5BXGvORICNsp+GUcfyMzM00W5TX1ru
 MLcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzT+qOYYJj7z8Wff1GTn4ZOGeQMW6+N9VutSKPl9NuVMSePXKXArMoBDHrO3BnX4fz3xKe1Aig=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8gs88LaOfjrjrd2ONSuTImUWqJARpHv5zgaxNDwKQW6VtTm8sB
 Q6dEZxLkkFfYmOuFpDK1GQtlhVv5NcABJPog3R7JX8FHwtzPTJC8eEQ0tGpe1EqKlCbrzhYuLGm
 c6vUe5lu6vcEcWfMZc3e4O2syMdwcD+YwTXIt9gPoACQNwiX0ZpIYVBjlRb7wc5zuyG/1100=
X-Gm-Gg: AYBFou0a9QJBwZc1LhmWH6+ur8/dm2QxDba/hpDjuLADHdNQygZP+v05bOMsUV6Xi4q
 WZ8mK18qt5sABWMuOr1Wjs8l+qyOknid6Mavrvy5UK3gKGSYLR+3gBt+pdUaDuiCpQmIcxbk4a9
 aVbB52vbz6bYhi2JgCHKPD1LD8DyY+iFyjGy0uvk8uQKWKK49SYTjyqcNt7nN3ZHRA8Hh0nBkt4
 xp691FGUNQkTBUCxblAqI24PWNrjomwyRJdxU5RhD6fHfFOgDXsNdPBhigsBrU7h0UDMnRIUGHc
 Q2upyyVbw4O9vHzMsBRm/B0tfA2QYcyiKutAuoid8kufmF/3CYIgA5i0o8qOz7AIC3S0bc3KL6F
 6UliFtl/OaaQd3I4VKyIzE5RHj+9UBEadaZi7I3a/gGqB4/Xbq+JSFOlNca0e7W+Uvx68odbudV
 XtA17r
X-Received: by 2002:a05:7022:3c86:b0:1b0:4179:ee67 with SMTP id
 a92af1059eb24-1b04179ef99mr9793335c88.39.1793683548908; 
 Mon, 02 Nov 2026 21:25:48 -0800 (PST)
X-Received: by 2002:a05:7022:3c86:b0:1b0:4179:ee67 with SMTP id
 a92af1059eb24-1b04179ef99mr9793310c88.39.1793683548335; 
 Mon, 02 Nov 2026 21:25:48 -0800 (PST)
Received: from [10.152.202.155] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1a9e2ed3sm37779756c88.19.2026.11.02.21.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 21:25:47 -0800 (PST)
Message-ID: <9a7226ec-060f-467f-852a-6819f4c6e17d@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 10:55:40 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] configs: add shikra defconfig for IQS board
To: Tom Rini <trini@konsulko.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, marek.vasut+usb@mailbox.org,
 Michael.Srba@seznam.cz, william.bright@imd-tec.com,
 luca.weiss@fairphone.com, nikroks@mainlining.org, nathbappai@gmail.com,
 macpaul.lin@mediatek.com, jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
 <20261021160916.3894471-10-aswin.murugan@oss.qualcomm.com>
 <20261022165536.GD3621697@bill-the-cat>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261022165536.GD3621697@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyMSBTYWx0ZWRfX00tydrTMAhNe
 9rbjklt78aENeRj+RBSJTaYzGXVAGBsH+3dOnE+XlRb0eEo1y1eJW/m+M4w+ybWaRCm9nKNpJ/8
 HbKy+47n1aOZVNPxW4dYpUMEj2/SJfU=
X-Authority-Analysis: v=2.4 cv=K9m3jCWI c=1 sm=1 tr=0 ts=6ae9705d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OS8BP3P7qmf99cVHhKEA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyMSBTYWx0ZWRfX/N+eqxWF4DVW
 O38g5cMKAKnuVlouq7gNCQY3XaBovDDHrPCsSCnCbeSwCP3iK5aVNTJ3zwzkDi7HMaAK1S5ysfs
 3UUC3xy1xGkVzKmdxqRJIeOfGE4vFDiuSW7Do64QO97wmpaMqL+V+A5TfsLFKSjnvF56XJgLQ4y
 HnO7wb6aq0uP9bbHnTJcvkR2HjzDtgpQRJ6QHEHtFH/4gpiksbSM/Yt2dLg2qQzNt/9LJ2qoMoE
 tIh1BcvNJKZnwWWFQCTNfTrtcAxncNFM6/cbIjOn8Q6cs1uk5DmWaK6Vwe4F4GefZmVL1ROlayL
 euyPfWoS09H4yt6NeogvclOvXrWRlSP544MLhooERTJWvfnFZ3SUrjLbtePJZWLhFUCqLl7K8Wt
 vpGwdg1shClVvOb7qzTd90tbQwUV4VkEmt0Hjprsbt/fPmowxfUu5iC/W9Jzk6H3GsJ0Kg4V2EA
 8Q8hRAvo8jLnzY9whqw==
X-Proofpoint-ORIG-GUID: KnXUuNg3Uf1CRLoiNh1Pk_tcaDB1vaow
X-Proofpoint-GUID: KnXUuNg3Uf1CRLoiNh1Pk_tcaDB1vaow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030021
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 10/22/2026 10:25 PM, Tom Rini wrote:
> On Wed, Oct 21, 2026 at 09:39:13PM +0530, Aswin Murugan wrote:
>
>> Introduce a defconfig for Shikra IQS board.
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>>   configs/qcom_shikra_iqs_defconfig | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>   create mode 100644 configs/qcom_shikra_iqs_defconfig
> Aside from "should be with the board" comment:
>
>> +# Address where U-Boot will be loaded
>> +CONFIG_TEXT_BASE=0x9f400000
> Is POSITION_INDEPENDENT not needed here, or not working or what?

There's a change posted [1] that makes mkmbn's load-address lookup for 
Qualcomm boards depend on CONFIG_TEXT_BASE, so it will need to be 
configured correctly in the defconfig going forward.

[1]: 
https://lore.kernel.org/u-boot/20261102-ipq5210-v3-3-aacf3930848b@oss.qualcomm.com/

Thanks,
Aswin

>> +# Shikra has eMMC only, not UFS/SCSI - override qcom_defconfig settings
>> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
>> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0
>> +
>> +# CONFIG_SCSI is not set
>> +
>> +# Environment stored in eMMC logfs partition
>> +CONFIG_ENV_IS_IN_MMC=y
>> +CONFIG_ENV_MMC_USE_SW_PARTITION=y
>> +CONFIG_ENV_MMC_SW_PARTITION="logfs"
>> +CONFIG_ENV_OFFSET=0x0
>> +CONFIG_ENV_SIZE=0x4000
> These kind of changes being made repeatedly tells me that qcom_defconfig
> needs to be split up in to a fragment of the really common qcom things
> and then a defconfig which works on a wide variety of qcom platforms. A
> general enhancement would be to make it easier / possible at run-time to
> determine that you need to use mmc device 0 and not UFS, and so forth.
>
> There's also quite likely a number of things which should move to the
> Kconfig files themselves as select / imply, rather than be in a
> defconfig itself.
>
