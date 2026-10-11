Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA374CA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 10:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B75360601;
	Sun, 11 Oct 2026 10:39:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gXNMDhi3UZSd; Sun, 11 Oct 2026 10:39:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D9156060E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791715151;
	b=VdxYYG8HlMV7j5eiZISpZgDYsEya6kTX4x0BqzI5sR5NK3Cu6gA80AKq29vLyzZKA1iT
	 lUV02txfzpuCMzqQjfCpmXboo9d7kLdf64rNFdZabWr4C0vYncYG5p8TaaMHzYzW3GREJ
	 2qEGrZYxUA8gHXrbDgtiw32I9ck1SO5O9n1wFxyWvJ1LBVp0gn/HO0AczWM/R4uDKpkug
	 ZgTJ3Y/P+gLORZaL483BAtWI9+9zZFVEhY8uExDQCqaZwVoQkzCP1OvdI2QXrKApR3+/w
	 Eq3MVnMWsW2bEMcNpWvR4PI9nDxVwJ0FccUDLIGlDNlj2wd2RZlAfugTVrhCbhFKMEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791715151;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=De4vMCN8mAWbL8zFfYUP66fRphodt5/FsIDJCImPFh4=;
	b=ZBCxPbYc4oA95MG/MTuXwzhA7g+z8oT2Fn8aSbKUQMO5KGz0gaZ3vc5DNFoEA07k7DaU
	 7yPIDJi04fUjQDYn19+ppinS2RdSLTCcr6EA/g+Ot/fBnMFmatsQSMDAvt4KuJMzWJflS
	 ZDueGdgV0HVIlmybYVnhWQYBsZ7/h60o3g7oEyLznzaWvwCZ3QbwlpMHTN44VlNi+/fEx
	 07O+15Jy/JkEmr4L/L91yeSWQHS1K+8YMJupiKHc4vQAmJyAcjN6ocX0vlm+CyMDoYg51
	 tEec9HgW7LqG8Ay2vmZ4QBx/a9zI/qyAoDXoXOPAnMDNNkmzNdElncUXE6pYvcjzAxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RfES1DJm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jrysEFPm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791715151;
	bh=De4vMCN8mAWbL8zFfYUP66fRphodt5/FsIDJCImPFh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bfl26tE46fImuRmnd5AVncjN5RlkJCDMMGAhnZAmfLYXfJQvrf8UP+s8RQSY3HCRY
	 VmysXpwqQG3ee+oMdaMPIKs7y/1TGA32b35d2Ox7S+1xGYlxe4EkcV3qqQyWO8QMbD
	 1hyTqTC6IL02o+PCzKirJh9y4Vm0m9zOqdXMJTx9bK0UEuMTRZ+G+F1O67F49g7ZY4
	 SHOYmw6yj7ZMMDjREog7mt4DUEA5oLy9rAKmOubp8qIJht8zu2uPT1r9FciOcMFdxQ
	 wCtTXnOx4wfCHF6bKIHTvBkZYWiZiHm9FYnfyK44B95KdCfYhrwJiES6TXL933OPjv
	 ri5oJdDjr1SRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D9156060E;
	Sun, 11 Oct 2026 10:39:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 860809DF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E0576060E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f8TBl7smzkh1 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 10:39:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DD19A60601
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791715148;
 b=b1lyvIY/giTvLF8dhBEVC6psz11DhlOmtLSoofjRTEMLFWcViDEkRMVo+zR0+hWNrheB
 iqc9nB5q4cYa3Bby8foZ2kDCOrs0+znLKkiyRjXj2idka/TmK6rAO2cuIjWiXLQEnSrV+
 0YBFSyNtkkcnhNBrcWbhCK2SB++YWX2OMS55HwIvoCc6XtRvurDYRHMeFJEdlvwlFAJrV
 nW4dXGsUit/AkCtHtnyM7DmP23LnlxEFAczK4ls4f3DGvl9CF7+27Qy8xmARFP5F1rfM7
 OrKZC3kV5bkqHOZGTwtWIZE+z5PGMAZ5Bf764B3cmNJIqFqZjt9T6OqKgZSEnWx3UmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791715148;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=De4vMCN8mAWbL8zFfYUP66fRphodt5/FsIDJCImPFh4=;
 b=qomEtYJTwdgqq6t/9sjNpYrduSmJTXNqTfdlnNLGgqtrKYxoYnTCKr8/cFhmu9Ny0APd
 V+tEvm34zEC2F9H4W5xAikChzEnkMctkwtm8G/vOOxs7PTDH0f2YaV4cjewIm4+OQ90Nt
 v5jtJtBOe0+A+k9WseZyU9a8HWVeFzz5G7C72Lxo/JkQxcGd11GRy25EXhPM46HE8usU0
 Uh7FWubhzyvResyEtE/7a1xTTRz+1xLuOZoD9qpgjz+j9r6TuaUPb1R975jOa/1iw9RTu
 JrELAha3FP0SMdsvkbtgi4V9uiuIN6CiEfnhvp0g7FKl+bSoxWNEJ0+UvlDkqoKrZVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=RfES1DJm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jrysEFPm; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=RfES1DJm; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jrysEFPm
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD19A60601
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:39:07 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85NkZ3982666
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 De4vMCN8mAWbL8zFfYUP66fRphodt5/FsIDJCImPFh4=; b=RfES1DJmnSm3/QQH
 GZgSBQCYEdK4QCqxFfD4E3qiSVNwpEr9Uh8jPysTIR/qP3qH2CtEMo0WtDQMz4+7
 ShzBJIQVTwteUBHJTcy5esq6iUNhKHtKmMGTt13Tk9c7EBW1TjSzgpzyKCpiZDqr
 1v3OLsZiqATvLBHsdDyQCAfJTubTR3cGTca3LqXy/LRPTilTc/rIEJ2u1ERT1/dh
 0DWoB42ny5tGqC955ziJj27fbLnCC0zeqjNq0dNPns11NIPAPk4FqEynlDZZYc7D
 mBlqEmDse8G7kaa/EI5wICXX3F5jG4sfDQ/HWOb+puTf+bNBld7bhzXy0owRPTmQ
 lbU0ig==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7casb01g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:39:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso1782643eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 03:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791715146; x=1792319946;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=De4vMCN8mAWbL8zFfYUP66fRphodt5/FsIDJCImPFh4=;
 b=jrysEFPmTVl/h0P8+SC3MEeHF9JKpMroKcgwh/0bGkchXH9axG3pSRG0sxzX8unOxx
 UqrKKxPjAcG2Vbmnlt2vl555anMPYAB5FEnq4WxAT+WJghM6czvMvVKX3OD/3NBNvtKJ
 jBkT5d8YSp1bGN9e50FtFMWNUEuLrGiXNTBumhejTZ7aH83kFmB/dBBTI7Z8G/I6xySf
 QHHGI75juux8avnu5XIPuryrm7fYNhk83vHMkCiXNNru0K9p4BH+umBGFkA9H3uzLHxP
 +meMRXwCJ463ypbHef4XBjwHDCU/PpLcPMrz8KvmCrhLLKQn09oIavR1Qg7dxh10ZlN7
 BnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791715146; x=1792319946;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=De4vMCN8mAWbL8zFfYUP66fRphodt5/FsIDJCImPFh4=;
 b=BwG5WxU4ke6jo3TvSOuUPB/Wb7/LeJeDED/pgJIi2KIyC5nxFG9JROh5dq/IpOtK6g
 /FcDjouxecFKxmBD1ugGSXbQcF96iXq2SBu5AEPcIrfAjDtzsOnTdlLQz83BXjZH/gNC
 dVDGhqXk6DKo3GG64U+cbBmoWSAApMneWuA9KYJHEkYWPEBc9dmS2IG1vW5ifCnJf+Lq
 ywJDSxFlS78aELxOzw+0eilW/S48fLU04jkmsdLZvLrxeiZf7nlZoV1o7/RHvSTztr4M
 IrSBq1bkeN6bksYJMXaZQlPOLezuiaqNW68hWS26K3vCU91dH+buhpBnf+rxu/sg0leH
 GDrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBytds30P9Zj8PXclNyas9TD2QninPFOhQ5ODeeIAPXEX8lSEy1L+cSxeJv2vQMPlwxhldofTa8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLDXuSmwRArPzNTKo6oT8w7deS1WvY/yjTsYKE5Abc0NvStoiAD
 5W7K9Dm5lUeMj7cGr6OyAndCOLiU8yoR2OXO1MJj2slbbCtxQIXsGE6r/+3Cenb74AUiaXy0K1N
 bOGudG5/roI7hIISbXmYCR91fQM/3RVA3X4SrtbMnsfWDi26wA4TnNtMsVycjgbdz4kmoJTA=
X-Gm-Gg: AYBFou3FZhMkxBAZrjVHnG40o0EvxNpThOuiCRyVvD3X1BA2V7nlA6MhPWzXtXFvmoQ
 fWLNNP/BkhupHqALoD+A442lIHsuKC5qGe+88NiyXLeWqI2tZLp30uJuy+26TrWPPlu3gvqJu9f
 pJ5i7EumO4anjTTazcJACY69fDjGXiqFhdW9tl7UBTlRHpwPMlehgU3A3UDbTC/zKwjmIYJm9+z
 q3LAdHB/2oWPI73P3Uo+bu39hBzVXOuHFp+2WJfvPGYXGopRD1120dbHntZc8NOiXGRskhm9vuv
 csQlnSAYt21nLLZyQPYiAnG6JU1QaXy8YC9ykyWH3HRWvl13kdUPSdKVUYnVXv2N1fN35Jf+45w
 gpPQwnMkj0hl/XPxTWwfgQHQKD3ItNqrSaA==
X-Received: by 2002:a05:693c:66c1:20b0:351:1b85:e139 with SMTP id
 5a478bee46e88-3537e0cefcdmr9665575eec.23.1791715145352; 
 Sun, 11 Oct 2026 03:39:05 -0700 (PDT)
X-Received: by 2002:a05:693c:66c1:20b0:351:1b85:e139 with SMTP id
 5a478bee46e88-3537e0cefcdmr9665538eec.23.1791715144606; 
 Sun, 11 Oct 2026 03:39:04 -0700 (PDT)
Received: from [192.168.0.6] ([183.82.24.21]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35977229a6esm5890152eec.8.2026.10.11.03.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 03:39:04 -0700 (PDT)
Message-ID: <61d20732-834f-4415-b37d-bcd17ec5bca6@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 16:08:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] spi: Add Qualcomm GENI QUPv3 SPI controller driver
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Sean Anderson <sean.anderson@linux.dev>
References: <20261008-spi-v6-v6-1-2a8f6c05ebb8@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261008-spi-v6-v6-1-2a8f6c05ebb8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA0MiBTYWx0ZWRfXxZmeVgK26lly
 s7IfnmqecQ0b6LvAo4jSYY2eq03sd+d6d389BNA8Kjedp1yewcs9Xpsy9ApL0nI7sC54znV/8OY
 tp8vSBywi9JZ0AWCzUvyE+/hV0vmVcM=
X-Proofpoint-ORIG-GUID: kLg3gZrD-Q0DEl0_GrM__NYqC5UrJk5N
X-Proofpoint-GUID: kLg3gZrD-Q0DEl0_GrM__NYqC5UrJk5N
X-Authority-Analysis: v=2.4 cv=eMWGH3p1 c=1 sm=1 tr=0 ts=6acb674a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=pwXowC3vr/RyD1rplAmAbg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1VxDqnHFAAAA:8 a=TkMjIAjhtHhBfVffSOEA:9
 a=JutqKRNgYwafejv_:21 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA0MiBTYWx0ZWRfXwlwn8+HJlmfd
 7g2hfFXDGc3b85VK4mCLaA6RyPkN2C2PAbj+wfCT8ukHS+wVnhlR/EhyhX+PNvkDA9emnHZF7iJ
 2FNdphKjfCr45yaWGCFnsvW+8x65WdKZ6KSIq1JdaE5+Madbr6RH8pQTRzBzUFIWWSOS4aCOVeC
 IYe2jqahxOsgKkryIWNwreq6cLRswkB30xX81F+9GjF7GarNxqbGiSox+M36X2fJ6j+Cx5TYsHC
 pu12zrPhkrw4tuQ+7w7EDUH5H/8XgsWDOf+KonZJxA+V0HY6e/5wOh3PBKtgyOwpt3l0Fydbx4F
 uTt9591K8+CuE0/Z8m09evtKqXv9Vov10KNzm2XF1biDdPjtQ06Wwmrrd6ZMw1cFF46eiZZRbdT
 KSB4lfxSCjqqrDmtifPD5cWPgUiv0jf/gyTlKxFtR4VH8PhefJf7sILC16ioY/yj3LOtmzmFz05
 1LM3JTWPkgMhQrWkMog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110042
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

Hi Vandhiadevan,

On 10/8/2026 10:50 AM, Vandhiadevan Karunamoorthy wrote:
> Add a DM_SPI driver for the SPI-protocol personality of the Qualcomm
> GENI Serial Engine, found inside a QUPv3 wrapper on Qualcomm SoCs
> such as SDM845, SM8250 and SA8775P. The Serial Engine is shared
> across UART/I2C/SPI protocols and needs firmware for the desired
> protocol loaded into it before use, via the existing
> qcom_geni_load_firmware() helper.
>
> The driver supports both the CPU-driven FIFO transfer path and the
> Serial Engine's own DMA engine (SE-DMA). Whether FIFO mode is usable
> is read back from hardware (GENI_IF_DISABLE_RO); SE-DMA is always
> available. The driver picks FIFO for small transfers when FIFO is
> available, and SE-DMA otherwise, matching the mode-selection logic
> of the equivalent Linux driver.
>
> Add the register offsets needed by the new driver to the shared
> include/soc/qcom/geni-se.h, and wire up the new driver's Kconfig entry
> and Makefile rule. The TX/RX fifo-depth helper it uses,
> geni_se_fifo_depth_mask(), is provided by the RX_RFR_WATERMARK fix
> this patch depends on.
>
> Validated in both FIFO and DMA modes on IPQ5424 and LeMans platforms.
>
> Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Depends-on: https://lore.kernel.org/u-boot/20261006-geni-rx-rfr-watermark-fix-v3-1-b368fe3fbf70@oss.qualcomm.com/
>
> Changes in v6:
> - Update Depends-on to the RX_RFR_WATERMARK fix v3 posting (v5 pointed
>    at v2); it still provides geni_se_fifo_depth_mask() used by this driver
> - Fix stale u-boot@lists.denx.de recipient to u-boot@lists.u-boot-project.org
> - Drop stale Link/Message-Id trailers carried over from the v5 posting
> - Link to v5: https://lore.kernel.org/u-boot/20260913-geni-spi-v2-review-v5-1-b80cef576afa@oss.qualcomm.com/
> ---
>   drivers/spi/Kconfig         |   9 +
>   drivers/spi/Makefile        |   1 +
>   drivers/spi/qcom_geni_spi.c | 780 ++++++++++++++++++++++++++++++++++++++++++++
>   include/soc/qcom/geni-se.h  |   8 +
>   4 files changed, 798 insertions(+)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index cfbedd64c4c..99870085f8d 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -463,6 +463,15 @@ config SPI_QUP
>   	  mode supports up to 50MHz, up to four chip selects, programmable
>   	  data path from 4 bits to 32 bits and numerous protocol variants.
>   
> +config SPI_GENI_QCOM
> +	bool "Qualcomm GENI SPI controller"
> +	depends on DM_SPI && QCOM_GENI
> +	help
> +	  Enable support for the SPI Serial Engine of the Qualcomm Generic
> +	  Interface (GENI) based Qualcomm Universal Peripheral (QUP) wrapper.
> +	  Used to access SPI devices such as SPI-NOR flash on Qualcomm SoCs
> +	  that have a GENI/QUPv3 wrapper, e.g. SDM845, SM8250, SA8775P.
> +
>   config RENESAS_RPC_SPI
>   	bool "Renesas RPC SPI driver"
>   	depends on RCAR_64 || RZA1
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 13d9c5dce80..c1ade77c75a 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_OMAP3_SPI) += omap3_spi.o
>   obj-$(CONFIG_PIC32_SPI) += pic32_spi.o
>   obj-$(CONFIG_PL022_SPI) += pl022_spi.o
>   obj-$(CONFIG_SPI_QUP) += spi-qup.o
> +obj-$(CONFIG_SPI_GENI_QCOM) += qcom_geni_spi.o
>   obj-$(CONFIG_SPI_MXIC) += spi-mxic.o
>   obj-$(CONFIG_RENESAS_RPC_SPI) += renesas_rpc_spi.o
>   obj-$(CONFIG_ROCKCHIP_SFC) += rockchip_sfc.o
> diff --git a/drivers/spi/qcom_geni_spi.c b/drivers/spi/qcom_geni_spi.c
> new file mode 100644
> index 00000000000..c0c1d08d724
> --- /dev/null
> +++ b/drivers/spi/qcom_geni_spi.c
> @@ -0,0 +1,780 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Qualcomm GENI QUPv3 SPI controller driver
> + *
> + * Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <log.h>
> +#include <dm.h>
> +#include <dm/device.h>
> +#include <dm/read.h>
> +#include <dm/device_compat.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <asm/cache.h>
> +#include <asm/io.h>
> +#include <cpu_func.h>
> +#include <spi.h>
> +#include <clk.h>
> +#include <time.h>
> +#include <soc/qcom/geni-se.h>
> +#include <soc/qcom/qup-fw-load.h>
> +
> +/* SPI-protocol-specific SE registers, on top of the generic ones in geni-se.h */
> +#define SE_SPI_CPHA			0x224
> +#define SE_SPI_LOOPBACK		0x22c
> +#define SE_SPI_CPOL			0x230
> +#define SE_SPI_DEMUX_OUTPUT_INV	0x24c
> +#define SE_SPI_DEMUX_SEL		0x250
> +#define SE_SPI_TRANS_CFG		0x25c
> +#define SE_SPI_DELAYS_COUNTERS		0x278
> +#define SE_SPI_WORD_LEN		0x268
> +#define SE_SPI_TX_TRANS_LEN		0x26c
> +#define SE_SPI_RX_TRANS_LEN		0x270
> +
> +#define CPHA				BIT(0)
> +
> +#define LOOPBACK_ENABLE			0x1
> +#define LOOPBACK_MSK			GENMASK(1, 0)
> +
> +#define CPOL				BIT(2)
> +
> +/* SE_SPI_TRANS_CFG */
> +#define CS_TOGGLE			BIT(1)
> +
> +#define WORD_LEN_MSK			GENMASK(9, 0)
> +#define SPI_WORD_LEN_BITS		8
> +#define MIN_WORD_LEN			4
> +
> +#define SPI_TX_ONLY			1
> +#define SPI_RX_ONLY			2
> +#define SPI_TX_RX			7
> +#define FRAGMENTATION			BIT(2)
> +
> +#define SPI_ERR	(M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN | \
> +		  M_RX_FIFO_RD_ERR_EN | M_RX_FIFO_WR_ERR_EN | \
> +		  M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN)
> +
> +#define SPI_XFER_TIMEOUT_MS		250
> +
> +/* SPI-NOR reads/writes are page/sector sized; skip DMA setup below this */
> +#define SPI_DMA_MIN_XFER_BYTES		64
> +
> +struct qcom_geni_spi_priv {
> +	phys_addr_t wrapper;
> +	phys_addr_t base;
> +	struct clk se;
> +	u32 tx_wm;
> +	u32 tx_fifo_depth;
> +	u32 bpw;
> +	u32 bytes_per_fifo_word;
> +	u32 oversampling;
> +	bool fifo_capable;
> +};
> +
> +/* Bytes packed into each 32-bit FIFO word, based on word length */
> +static unsigned int qcom_geni_spi_bytes_per_fifo_word(unsigned int bpw)
> +{
> +	if (bpw <= 8)
> +		return 4;
> +	else if (bpw <= 16)
> +		return 2;
> +	return 1;
> +}
> +
> +/* Scale the wait budget with transfer size instead of a flat constant */
> +static ulong qcom_geni_spi_xfer_timeout_ms(struct qcom_geni_spi_priv *priv,
> +					   unsigned int len)
> +{
> +	ulong rate = clk_get_rate(&priv->se);
> +	ulong ms;
> +
> +	if (IS_ERR_VALUE(rate) || !rate)
> +		return SPI_XFER_TIMEOUT_MS + len / 1000;
> +
> +	/* len is in bytes; add generous margin for controller/DMA overhead */
> +	ms = DIV_ROUND_UP((u64)len * 8 * 1000, rate) * 4;
> +
> +	return max_t(ulong, ms, SPI_XFER_TIMEOUT_MS);
> +}
> +
> +#define NUM_PACKING_VECTORS		4
> +#define PACKING_START_SHIFT		5
> +#define PACKING_DIR_SHIFT		4
> +#define PACKING_LEN_SHIFT		1
> +#define PACKING_STOP_BIT		BIT(0)
> +#define PACKING_VECTOR_SHIFT		10
> +
> +/* Configure how the SE packs/unpacks "bpw"-bit words into 32-bit FIFO entries */
> +static void qcom_geni_spi_config_packing(struct qcom_geni_spi_priv *priv, int bpw,
> +					 bool msb_to_lsb)
> +{
> +	u32 cfg0, cfg1, cfg[NUM_PACKING_VECTORS] = {0};
> +	int len, temp_bpw = bpw;
> +	int idx_start = msb_to_lsb ? bpw - 1 : 0;
> +	int idx = idx_start;
> +	int idx_delta = msb_to_lsb ? -BITS_PER_BYTE : BITS_PER_BYTE;
> +	int i, iter, pack_words;
> +	unsigned int ceil_bpw;
> +
> +	if (bpw <= 8)
> +		pack_words = 4;
> +	else if (bpw <= 16)
> +		pack_words = 2;
> +	else
> +		pack_words = 1;
> +
> +	ceil_bpw = (bpw & (BITS_PER_BYTE - 1)) ?
> +		((bpw & ~(BITS_PER_BYTE - 1)) + BITS_PER_BYTE) : bpw;
> +
> +	iter = (ceil_bpw * pack_words) >> 3;
> +	if (iter <= 0 || iter > NUM_PACKING_VECTORS)
> +		return;
> +
> +	for (i = 0; i < iter; i++) {
> +		len = min_t(int, temp_bpw, BITS_PER_BYTE) - 1;
> +		cfg[i] = idx << PACKING_START_SHIFT;
> +		cfg[i] |= msb_to_lsb << PACKING_DIR_SHIFT;
> +		cfg[i] |= len << PACKING_LEN_SHIFT;
> +
> +		if (temp_bpw <= BITS_PER_BYTE) {
> +			idx = ((i + 1) * BITS_PER_BYTE) + idx_start;
> +			temp_bpw = bpw;
> +		} else {
> +			idx = idx + idx_delta;
> +			temp_bpw = temp_bpw - BITS_PER_BYTE;
> +		}
> +	}
> +	cfg[iter - 1] |= PACKING_STOP_BIT;
> +	cfg0 = cfg[0] | (cfg[1] << PACKING_VECTOR_SHIFT);
> +	cfg1 = cfg[2] | (cfg[3] << PACKING_VECTOR_SHIFT);
> +
> +	writel(cfg0, priv->base + SE_GENI_TX_PACKING_CFG0);
> +	writel(cfg1, priv->base + SE_GENI_TX_PACKING_CFG1);
> +	writel(cfg0, priv->base + SE_GENI_RX_PACKING_CFG0);
> +	writel(cfg1, priv->base + SE_GENI_RX_PACKING_CFG1);
> +
> +	writel(bpw / 16, priv->base + SE_GENI_BYTE_GRAN);
> +}
> +
> +static int qcom_geni_spi_fifo_xfer(struct qcom_geni_spi_priv *priv, const u8 *tx,
> +				   u8 *rx, unsigned int len, ulong timeout_ms)
> +{
> +	ulong start = get_timer(0);
> +	unsigned int tx_cur = 0, rx_cur = 0;
> +
> +	while (get_timer(start) < timeout_ms) {
> +		u32 status = readl(priv->base + SE_GENI_M_IRQ_STATUS);
> +		unsigned int i;
> +
> +		if (status & SPI_ERR) {
> +			writel(status, priv->base + SE_GENI_M_IRQ_CLEAR);
> +			if (tx)
> +				writel(0, priv->base + SE_GENI_TX_WATERMARK_REG);
> +			return -EIO;
> +		}
> +
> +		if (tx && (status & M_TX_FIFO_WATERMARK_EN)) {
> +			for (i = 0; i < priv->tx_wm && tx_cur < len; i++) {
> +				u32 word = 0;
> +				unsigned int p;
> +
> +				for (p = 0; p < priv->bytes_per_fifo_word && tx_cur < len; p++)
> +					word |= tx[tx_cur++] << (p * 8);
> +
> +				writel(word, priv->base + SE_GENI_TX_FIFOn);
> +			}
> +
> +			if (tx_cur == len)
> +				writel(0, priv->base + SE_GENI_TX_WATERMARK_REG);
> +		}
> +
> +		if (status & (M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN)) {
> +			u32 rxstatus = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
> +			u32 rxcnt = rxstatus & RX_FIFO_WC_MSK;
> +
> +			if (rx) {
> +				for (i = 0; rx_cur < len && i < rxcnt; i++) {
> +					u32 word = readl(priv->base + SE_GENI_RX_FIFOn);
> +					unsigned int p;
> +
> +					for (p = 0; p < priv->bytes_per_fifo_word &&
> +					     rx_cur < len; p++) {
> +						rx[rx_cur++] = word & 0xff;
> +						word >>= 8;
> +					}
> +				}
> +			} else {
> +				for (i = 0; i < rxcnt; i++)
> +					readl(priv->base + SE_GENI_RX_FIFOn);
> +			}
> +		}
> +
> +		writel(status, priv->base + SE_GENI_M_IRQ_CLEAR);
> +
> +		if (status & M_CMD_DONE_EN) {
> +			/* Drain any residual RX words after CMD_DONE */
> +			if (rx && rx_cur < len) {
> +				u32 rxstatus = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
> +				u32 rxcnt = rxstatus & RX_FIFO_WC_MSK;
> +				unsigned int i;
> +
> +				for (i = 0; rx_cur < len && i < rxcnt; i++) {
> +					u32 word = readl(priv->base + SE_GENI_RX_FIFOn);
> +					unsigned int p;
> +
> +					for (p = 0; p < priv->bytes_per_fifo_word &&
> +					     rx_cur < len; p++) {
> +						rx[rx_cur++] = word & 0xff;
> +						word >>= 8;
> +					}
> +				}
> +			}
> +			return 0;
> +		}
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int qcom_geni_spi_abort(struct udevice *dev, struct qcom_geni_spi_priv *priv)
> +{
> +	ulong start = get_timer(0);
> +	u32 status;
> +
> +	writel(M_GENI_CMD_ABORT, priv->base + SE_GENI_M_CMD_CTRL_REG);
> +
> +	do {
> +		status = readl(priv->base + SE_GENI_M_IRQ_STATUS);
> +		if (get_timer(start) > SPI_XFER_TIMEOUT_MS)
> +			return -ETIMEDOUT;
> +	} while (!(status & M_CMD_ABORT_EN));
> +
> +	writel(status, priv->base + SE_GENI_M_IRQ_CLEAR);
> +
> +	/* Reset TX/RX DMA FSMs so the next transfer starts clean */
> +	start = get_timer(0);
> +	writel(1, priv->base + SE_DMA_TX_FSM_RST);
> +	do {
> +		status = readl(priv->base + SE_DMA_TX_IRQ_STAT);
> +		if (get_timer(start) > SPI_XFER_TIMEOUT_MS) {
> +			dev_err(dev, "DMA TX RESET failed\n");
> +			break;
> +		}
> +	} while (!(status & TX_RESET_DONE));
> +	writel(status, priv->base + SE_DMA_TX_IRQ_CLR);
> +
> +	start = get_timer(0);
> +	writel(1, priv->base + SE_DMA_RX_FSM_RST);
> +	do {
> +		status = readl(priv->base + SE_DMA_RX_IRQ_STAT);
> +		if (get_timer(start) > SPI_XFER_TIMEOUT_MS) {
> +			dev_err(dev, "DMA RX RESET failed\n");
> +			break;
> +		}
> +	} while (!(status & RX_RESET_DONE));
> +	writel(status, priv->base + SE_DMA_RX_IRQ_CLR);
> +
> +	return 0;
> +}
> +
> +/* SE-DMA: the SE moves data directly to/from a physical buffer */
> +static void qcom_geni_spi_dma_tx_start(struct qcom_geni_spi_priv *priv, const u8 *tx,
> +				       unsigned int len)
> +{
> +	phys_addr_t buf = (phys_addr_t)(uintptr_t)tx;
> +
> +	flush_dcache_range(ALIGN_DOWN((ulong)tx, ARCH_DMA_MINALIGN),
> +			   ALIGN((ulong)tx + len, ARCH_DMA_MINALIGN));
> +
> +	writel(lower_32_bits(buf), priv->base + SE_DMA_TX_PTR_L);
> +	writel(upper_32_bits(buf), priv->base + SE_DMA_TX_PTR_H);
> +	writel(GENI_SE_DMA_EOT_BUF, priv->base + SE_DMA_TX_ATTR);
> +	writel(len, priv->base + SE_DMA_TX_LEN);
> +}
> +
> +static void qcom_geni_spi_dma_rx_start(struct qcom_geni_spi_priv *priv, u8 *rx,
> +				       unsigned int len)
> +{
> +	phys_addr_t buf = (phys_addr_t)(uintptr_t)rx;
> +
> +	/* Discard stale dirty cache lines before the DMA write lands */
> +	invalidate_dcache_range(ALIGN_DOWN((ulong)rx, ARCH_DMA_MINALIGN),
> +				ALIGN((ulong)rx + len, ARCH_DMA_MINALIGN));
> +
> +	writel(lower_32_bits(buf), priv->base + SE_DMA_RX_PTR_L);
> +	writel(upper_32_bits(buf), priv->base + SE_DMA_RX_PTR_H);
> +	writel(0, priv->base + SE_DMA_RX_ATTR);
> +	writel(len, priv->base + SE_DMA_RX_LEN);
> +}
> +
> +static int qcom_geni_spi_dma_wait_tx(struct qcom_geni_spi_priv *priv, ulong timeout_ms)
> +{
> +	ulong start = get_timer(0);
> +	u32 status;
> +
> +	while (get_timer(start) < timeout_ms) {
> +		status = readl(priv->base + SE_DMA_TX_IRQ_STAT);
> +		if (!status) {
> +			udelay(1);
> +			continue;
> +		}
> +
> +		writel(status, priv->base + SE_DMA_TX_IRQ_CLR);
> +
> +		if (status & TX_SBE)
> +			return -EIO;
> +		if (status & TX_DMA_DONE)
> +			return 0;
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int qcom_geni_spi_dma_wait_rx(struct qcom_geni_spi_priv *priv, u8 *rx,
> +				     unsigned int len, ulong timeout_ms)
> +{
> +	ulong start = get_timer(0);
> +	u32 status;
> +
> +	while (get_timer(start) < timeout_ms) {
> +		status = readl(priv->base + SE_DMA_RX_IRQ_STAT);
> +		if (!status) {
> +			udelay(1);
> +			continue;
> +		}
> +
> +		writel(status, priv->base + SE_DMA_RX_IRQ_CLR);
> +
> +		if (status & RX_SBE)
> +			return -EIO;
> +		if (status & RX_DMA_DONE) {
> +			/* Force the AXI write to retire before trusting the buffer */
> +			readl(priv->base + SE_DMA_RX_LEN);
> +			invalidate_dcache_range(ALIGN_DOWN((ulong)rx, ARCH_DMA_MINALIGN),
> +						ALIGN((ulong)rx + len, ARCH_DMA_MINALIGN));
> +			return 0;
> +		}
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int qcom_geni_spi_dma_xfer_wait(struct qcom_geni_spi_priv *priv, const u8 *tx,
> +				       u8 *rx, unsigned int len, ulong timeout_ms)
> +{
> +	int ret;
> +
> +	if (tx) {
> +		ret = qcom_geni_spi_dma_wait_tx(priv, timeout_ms);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (rx) {
> +		ret = qcom_geni_spi_dma_wait_rx(priv, rx, len, timeout_ms);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* TX/RX_TRANS_LEN and DMA_TX/RX_LEN are 24-bit HW fields; split large transfers */
> +#define SPI_GENI_MAX_XFER_BYTES		0xFFFFFF
> +
> +/* RX DMA requires a cache-line-aligned start and length to invalidate safely */
> +static bool qcom_geni_spi_rx_needs_bounce(const void *rx, unsigned int len)
> +{
> +	return !IS_ALIGNED((ulong)rx, ARCH_DMA_MINALIGN) ||
> +	       !IS_ALIGNED(len, ARCH_DMA_MINALIGN);
> +}
> +
> +static int qcom_geni_spi_xfer_chunk(struct udevice *dev, struct qcom_geni_spi_priv *priv,
> +				    unsigned int len, const void *dout, void *din,
> +				    bool use_dma, bool last_chunk, ulong timeout_ms)
> +{
> +	u32 cmd, m_param = 0;
> +	int ret;
> +
> +	writel(dout ? len : 0, priv->base + SE_SPI_TX_TRANS_LEN);
> +	writel(din ? len : 0, priv->base + SE_SPI_RX_TRANS_LEN);
> +
> +	/* SPI_TX_ONLY | SPI_RX_ONLY is not a valid opcode, use SPI_TX_RX instead */
> +	if (dout && din)
> +		cmd = SPI_TX_RX;
> +	else if (din)
> +		cmd = SPI_RX_ONLY;
> +	else if (dout)
> +		cmd = SPI_TX_ONLY;
> +	else
> +		cmd = 0;
> +
> +	if (!last_chunk)
> +		m_param |= FRAGMENTATION;
> +
> +	if (use_dma) {
> +		setbits_le32(priv->base + SE_GENI_DMA_MODE_EN, GENI_DMA_MODE_EN);
> +
> +		/* DMA: issue M_CMD0 first, then arm DMA descriptors */
> +		writel((cmd << M_OPCODE_SHFT) | (m_param & M_PARAMS_MSK),
> +		       priv->base + SE_GENI_M_CMD0);
> +		if (din)
> +			qcom_geni_spi_dma_rx_start(priv, din, len);
> +		if (dout)
> +			qcom_geni_spi_dma_tx_start(priv, dout, len);
> +
> +		ret = qcom_geni_spi_dma_xfer_wait(priv, dout, din, len, timeout_ms);
> +
> +		/* Clear M_CMD_DONE so status doesn't accumulate across transfers */
> +		writel(readl(priv->base + SE_GENI_M_IRQ_STATUS),
> +		       priv->base + SE_GENI_M_IRQ_CLEAR);
> +	} else {
> +		clrbits_le32(priv->base + SE_GENI_DMA_MODE_EN, GENI_DMA_MODE_EN);
> +
> +		/*
> +		 * Set watermarks before M_CMD0. Only set TX_WATERMARK when
> +		 * we have TX data, since SPI_RX_ONLY doesn't use the TX FIFO.
> +		 */
> +		if (dout)
> +			writel(1, priv->base + SE_GENI_TX_WATERMARK_REG);
> +		/* RX_WATERMARK=0: SE fires RX_FIFO_LAST at end of transfer */
> +		if (din)
> +			writel(0, priv->base + SE_GENI_RX_WATERMARK_REG);
> +
> +		writel((cmd << M_OPCODE_SHFT) | (m_param & M_PARAMS_MSK),
> +		       priv->base + SE_GENI_M_CMD0);
> +
> +		ret = qcom_geni_spi_fifo_xfer(priv, dout, din, len, timeout_ms);
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_geni_spi_xfer_once(struct udevice *dev, unsigned int len,
> +				   const void *dout, void *din, bool xfer_end)
> +{
> +	struct udevice *bus = dev_get_parent(dev);
> +	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
> +	ulong timeout_ms = qcom_geni_spi_xfer_timeout_ms(priv, len);
> +	bool use_dma = !priv->fifo_capable || len >= SPI_DMA_MIN_XFER_BYTES;
> +	u8 edge_buf[2][ARCH_DMA_MINALIGN] __aligned(ARCH_DMA_MINALIGN);
> +	unsigned int head_len = 0, tail_len = 0, mid_len = len, done = 0;
> +	int ret = 0;
> +
> +	if (din && use_dma && qcom_geni_spi_rx_needs_bounce(din, len)) {
> +		head_len = min_t(unsigned int,
> +				 ALIGN((ulong)din, ARCH_DMA_MINALIGN) - (ulong)din,
> +				 len);
> +		tail_len = (len - head_len) % ARCH_DMA_MINALIGN;
> +		mid_len = len - head_len - tail_len;
> +	}
> +
> +	if (head_len) {
> +		ret = qcom_geni_spi_xfer_chunk(dev, priv, head_len, dout, edge_buf[0],
> +					       use_dma, xfer_end && !mid_len && !tail_len,
> +					       timeout_ms);
> +		if (!ret)
> +			memcpy(din, edge_buf[0], head_len);
> +		done += head_len;
> +	}
> +
> +	if (!ret && mid_len) {
> +		ret = qcom_geni_spi_xfer_chunk(dev, priv, mid_len,
> +					       dout ? (const u8 *)dout + done : NULL,
> +					       din ? (u8 *)din + done : NULL,
> +					       use_dma, xfer_end && !tail_len, timeout_ms);
> +		done += mid_len;
> +	}
> +
> +	if (!ret && tail_len) {
> +		ret = qcom_geni_spi_xfer_chunk(dev, priv, tail_len,
> +					       dout ? (const u8 *)dout + done : NULL,
> +					       edge_buf[1], use_dma, xfer_end, timeout_ms);
> +		if (!ret)
> +			memcpy((u8 *)din + done, edge_buf[1], tail_len);
> +	}
> +
> +	if (ret) {
> +		int abort_ret = qcom_geni_spi_abort(dev, priv);
> +
> +		if (abort_ret)
> +			dev_err(dev, "abort failed: %d\n", abort_ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_geni_spi_xfer(struct udevice *dev, unsigned int bitlen,
> +			      const void *dout, void *din, unsigned long flags)
> +{
> +	struct udevice *bus = dev_get_parent(dev);
> +	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
> +	unsigned int len = DIV_ROUND_UP(bitlen, 8);
> +	unsigned int done = 0;
> +	int ret;
> +
> +	if (flags & SPI_XFER_BEGIN)
> +		writel(0xffffffff, priv->base + SE_GENI_M_IRQ_CLEAR);
> +
> +	while (done < len) {
> +		unsigned int chunk = min_t(unsigned int, len - done,
> +					    SPI_GENI_MAX_XFER_BYTES);
> +		bool xfer_end = (flags & SPI_XFER_END) && (done + chunk == len);
> +
> +		ret = qcom_geni_spi_xfer_once(dev,
> +					      chunk,
> +					  dout ? (const u8 *)dout + done : NULL,
> +					  din ? (u8 *)din + done : NULL,
> +					  xfer_end);
> +		if (ret)
> +			return ret;
> +
> +		done += chunk;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_geni_spi_set_speed(struct udevice *bus, uint speed)
> +{
> +	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
> +	ulong parent_rate;
> +	u32 div;
> +
> +	if (!speed)
> +		return -EINVAL;
> +
> +	parent_rate = clk_get_rate(&priv->se);
> +	if (IS_ERR_VALUE(parent_rate) || !parent_rate)
> +		div = priv->oversampling;
> +	else
> +		div = DIV_ROUND_UP(parent_rate, priv->oversampling * speed);
> +
> +	div = clamp_t(u32, div, 1, CLK_DIV_MSK >> CLK_DIV_SHFT);
> +
> +	writel(0, priv->base + SE_GENI_CLK_SEL);
> +	writel((div << CLK_DIV_SHFT) | SER_CLK_EN, priv->base + GENI_SER_M_CLK_CFG);
> +
> +	return 0;
> +}
> +
> +static int qcom_geni_spi_set_mode(struct udevice *bus, uint mode)
> +{
> +	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
> +	u32 val;
> +
> +	val = readl(priv->base + SE_SPI_LOOPBACK);
> +	val &= ~LOOPBACK_MSK;
> +	if (mode & SPI_LOOP)
> +		val |= LOOPBACK_ENABLE;
> +	writel(val, priv->base + SE_SPI_LOOPBACK);
> +
> +	val = readl(priv->base + SE_SPI_CPHA);
> +	if (mode & SPI_CPHA)
> +		val |= CPHA;
> +	else
> +		val &= ~CPHA;
> +	writel(val, priv->base + SE_SPI_CPHA);
> +
> +	val = readl(priv->base + SE_SPI_CPOL);
> +	if (mode & SPI_CPOL)
> +		val |= CPOL;
> +	else
> +		val &= ~CPOL;
> +	writel(val, priv->base + SE_SPI_CPOL);
> +
> +	return 0;
> +}
> +
> +static int qcom_geni_spi_claim_bus(struct udevice *dev)
> +{
> +	struct udevice *bus = dev_get_parent(dev);
> +	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
> +	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
> +	unsigned int cs = slave_plat->cs[0];
> +	unsigned int bpw = slave_plat->wordlen ? slave_plat->wordlen : SPI_WORD_LEN_BITS;
> +
> +	priv->bpw = bpw;
> +	priv->bytes_per_fifo_word = qcom_geni_spi_bytes_per_fifo_word(bpw);
> +
> +	writel((bpw - MIN_WORD_LEN) & WORD_LEN_MSK, priv->base + SE_SPI_WORD_LEN);
> +	writel(cs, priv->base + SE_SPI_DEMUX_SEL);
> +	writel(slave_plat->mode & SPI_CS_HIGH ? BIT(cs) : 0,
> +	       priv->base + SE_SPI_DEMUX_OUTPUT_INV);
> +
> +	qcom_geni_spi_config_packing(priv, bpw, true);
> +
> +	writel(0xffffffff, priv->base + SE_GENI_M_IRQ_CLEAR);
> +
> +	return 0;
> +}
> +
> +static int qcom_geni_spi_release_bus(struct udevice *dev)
> +{
> +	return 0;
> +}
> +
> +static u32 qcom_geni_spi_get_tx_fifo_depth(struct qcom_geni_spi_priv *priv)
> +{
> +	u32 val, hw_version, depth_mask;
> +
> +	hw_version = readl(priv->wrapper + QUP_HW_VER_REG);
> +	depth_mask = geni_se_fifo_depth_mask(hw_version, TX_FIFO_DEPTH_MSK_256_BYTES,
> +					     TX_FIFO_DEPTH_MSK);
> +
> +	val = readl(priv->base + SE_HW_PARAM_0);
> +
> +	return (val & depth_mask) >> TX_FIFO_DEPTH_SHFT;
> +}
> +
> +/* QUP v1.0 undersamples the SPI clock and needs 2x the requested bit rate */
> +static u32 qcom_geni_spi_get_oversampling(struct qcom_geni_spi_priv *priv)
> +{
> +	u32 hw_version = readl(priv->wrapper + QUP_HW_VER_REG);
> +	u32 hw_major = GENI_SE_VERSION_MAJOR(hw_version);
> +	u32 hw_minor = GENI_SE_VERSION_MINOR(hw_version);
> +
> +	if (hw_major == 1 && hw_minor == 0)
> +		return 2;
> +
> +	return 1;
> +}
> +
> +static void qcom_geni_spi_hw_init(struct qcom_geni_spi_priv *priv)
> +{
> +	u32 val;
> +
> +	writel(0xffffffff, priv->base + SE_GENI_M_IRQ_CLEAR);
> +
> +	val = readl(priv->base + GENI_CGC_CTRL);
> +	val |= DEFAULT_CGC_EN;
> +	writel(val, priv->base + GENI_CGC_CTRL);
> +
> +	writel(DEFAULT_IO_OUTPUT_CTRL_MSK, priv->base + GENI_OUTPUT_CTRL);
> +	writel(FORCE_DEFAULT, priv->base + GENI_FORCE_DEFAULT_REG);
> +
> +	val = readl(priv->base + SE_IRQ_EN);
> +	val |= GENI_M_IRQ_EN;
> +	writel(val, priv->base + SE_IRQ_EN);
> +
> +	writel(priv->tx_wm, priv->base + SE_GENI_TX_WATERMARK_REG);
> +
> +	val = readl(priv->base + SE_GENI_M_IRQ_EN);
> +	val |= M_COMMON_GENI_M_IRQ_EN | M_CMD_DONE_EN | SPI_ERR;
> +	writel(val, priv->base + SE_GENI_M_IRQ_EN);
> +
> +	writel(0xffffffff, priv->base + SE_DMA_TX_IRQ_CLR);
> +	writel(0xffffffff, priv->base + SE_DMA_RX_IRQ_CLR);
> +	writel(TX_DMA_DONE | TX_SBE, priv->base + SE_DMA_TX_IRQ_EN_SET);
> +	writel(RX_DMA_DONE | RX_SBE, priv->base + SE_DMA_RX_IRQ_EN_SET);
> +
> +	/* We always control CS manually, don't let the SE auto-toggle it */
> +	val = readl(priv->base + SE_SPI_TRANS_CFG);
> +	val &= ~CS_TOGGLE;
> +	writel(val, priv->base + SE_SPI_TRANS_CFG);
> +}
> +
> +static int qcom_geni_spi_probe(struct udevice *dev)
> +{
> +	struct qcom_geni_spi_priv *priv = dev_get_priv(dev);
> +	u32 proto;
> +	int ret;
> +
> +	priv->wrapper = dev_read_addr(dev->parent);
> +	if (priv->wrapper == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	priv->base = dev_read_addr(dev);
> +	if (priv->base == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	ret = clk_get_by_name(dev, "se", &priv->se);
> +	if (ret) {
> +		dev_err(dev, "clk_get_by_name(se) failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_enable(&priv->se);
> +	if (ret) {
> +		dev_err(dev, "clk_enable(se) failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	proto = readl(priv->base + GENI_FW_REVISION_RO);
> +	proto &= FW_REV_PROTOCOL_MSK;
> +	proto >>= FW_REV_PROTOCOL_SHFT;
> +
> +	if (proto == GENI_SE_INVALID_PROTO) {
> +		dev_dbg(dev, "firmware not loaded, loading now\n");
> +		ret = qcom_geni_load_firmware(priv->base, dev);
> +		if (ret) {
> +			dev_err(dev, "firmware load failed: %d\n", ret);
> +			clk_disable(&priv->se);
> +			return ret;
> +		}
> +		proto = readl(priv->base + GENI_FW_REVISION_RO);
> +		proto &= FW_REV_PROTOCOL_MSK;
> +		proto >>= FW_REV_PROTOCOL_SHFT;
> +		dev_info(dev, "firmware loaded, proto=0x%x\n", proto);
> +	} else {
> +		dev_info(dev, "firmware already loaded, proto=0x%x\n", proto);
> +	}
> +
> +	if (proto != GENI_SE_SPI) {
> +		dev_err(dev, "Invalid proto %d\n", proto);
> +		clk_disable(&priv->se);
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * SE-DMA is an inherent capability of the GENI SE core (mirrors
> +	 * upstream Linux's spi-geni-qcom.c, which never gates SE-DMA by DT
> +	 * or hardware version). Only FIFO availability needs checking here.
> +	 */
> +	priv->fifo_capable = !(readl(priv->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE);
> +
> +	priv->tx_fifo_depth = qcom_geni_spi_get_tx_fifo_depth(priv);
> +	if (!priv->tx_fifo_depth) {
> +		dev_err(dev, "Invalid TX FIFO depth\n");
> +		clk_disable(&priv->se);
> +		return -ENXIO;
> +	}
> +	priv->tx_wm = priv->tx_fifo_depth - 1;
> +	priv->oversampling = qcom_geni_spi_get_oversampling(priv);
> +
> +	qcom_geni_spi_hw_init(priv);
> +
> +	return 0;
> +}
> +
> +static const struct dm_spi_ops qcom_geni_spi_ops = {
> +	.claim_bus	= qcom_geni_spi_claim_bus,
> +	.release_bus	= qcom_geni_spi_release_bus,
> +	.xfer		= qcom_geni_spi_xfer,
> +	.set_speed	= qcom_geni_spi_set_speed,
> +	.set_mode	= qcom_geni_spi_set_mode,
> +	/*
> +	 * cs_info is not needed, since we require all chip selects to be
> +	 * in the device tree explicitly
> +	 */
> +};
> +
> +static const struct udevice_id qcom_geni_spi_ids[] = {
> +	{ .compatible = "qcom,geni-spi" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(qcom_geni_spi) = {
> +	.name	= "qcom_geni_spi",
> +	.id	= UCLASS_SPI,
> +	.of_match = qcom_geni_spi_ids,
> +	.probe	= qcom_geni_spi_probe,
> +	.priv_auto = sizeof(struct qcom_geni_spi_priv),
> +	.ops	= &qcom_geni_spi_ops,
> +};
> diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
> index fc9a8e82cd8..41d5b921d1c 100644
> --- a/include/soc/qcom/geni-se.h
> +++ b/include/soc/qcom/geni-se.h
> @@ -64,10 +64,18 @@ enum geni_se_protocol_type {
>   #define SE_GENI_RX_WATERMARK_REG	0x810
>   #define SE_GENI_RX_RFR_WATERMARK_REG	0x814
>   #define SE_GENI_IOS			0x908
> +#define SE_DMA_TX_PTR_L			0xc30
> +#define SE_DMA_TX_PTR_H			0xc34
> +#define SE_DMA_TX_ATTR			0xc38
> +#define SE_DMA_TX_LEN			0xc3c
>   #define SE_DMA_TX_IRQ_STAT		0xc40
>   #define SE_DMA_TX_IRQ_CLR		0xc44
>   #define SE_DMA_TX_IRQ_EN_SET		0xc4c
>   #define SE_DMA_TX_FSM_RST		0xc58
> +#define SE_DMA_RX_PTR_L			0xd30
> +#define SE_DMA_RX_PTR_H			0xd34
> +#define SE_DMA_RX_ATTR			0xd38
> +#define SE_DMA_RX_LEN			0xd3c
>   #define SE_DMA_RX_IRQ_STAT		0xd40
>   #define SE_DMA_RX_IRQ_CLR		0xd44
>   #define SE_DMA_RX_IRQ_EN_SET		0xd4c
>
> ---
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> change-id: 20261006-spi-v6-1caa26821d6a
>
> Best regards,
> --
> Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
