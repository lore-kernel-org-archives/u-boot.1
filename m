Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE25C606A327
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dztHcMhe;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j43QrWuf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QXSyi7m9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46EA0406B0;
	Tue,  3 Nov 2026 13:04:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XmYbdWqTqSw6; Tue,  3 Nov 2026 13:04:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 116C34054A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711086;
	b=oLA3oJPEvvVZaYeuUXFYNa95GJShFGnWJ07O/y4OdTrdy7E1Gi1t7LVtxxb7zJrcalNg
	 xRbMKCPLrLymQnTzvUKKd8F8HsA75louc9fDUPThC1gbVQKpjAjCjhLEkBcC6yn9rczpP
	 Qi/L+6FaRRFJA+FbPTz8uRXAFQkHFYOIS+fMR9cvRhLYe0N2DKSZvAoFPPEcL4AW9HY1j
	 tjCooyLqy69j6Pr834MbujCgK5h7hQq1TgHAa4bcRW11s3PbGWb3Jf4NeeNTwZjuiGP8K
	 VbXIDnd2l4Jc+LUi/DGDvFdj3pKt2YIFUHszVMH/+7anhy40srycK22va6ElX8+PmsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711086;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5U1pJrXbsMuAdolEUeoW3qIp0OrpyXsirpZODX89XnI=;
	b=e3bkhgKo24MuJwR0SrTGXvF93FXXqyOWZgPXNxxsunM/WLQWISvbvd4HpGF62sc7++uf
	 zEySbdCg5cVvKwPXJyxNMCjjwE0z7Wqf7+B4NAAS81LIw83HqHbpQ3c+dpT611CejJsMU
	 b6KnSWwV19VH/0q/MdmxsNJ8zqUCBtK7q3SVKVVtiWAMW9gzZ1Nah+SGsnaZiomlmb95M
	 P2zMUaUeLlRlG8k9/QX/9mIQC+QmnAvkfaU9dcxvDvXHoM2HgD9w6b7OtaoZVSU0m3Lyg
	 SNuZqehN8dqgsAIj6gfIRSlwmfXUHsk4Sm6H/k/BiDkbAodbTI7p5osKSmykRuR0R/w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711086;
	bh=5U1pJrXbsMuAdolEUeoW3qIp0OrpyXsirpZODX89XnI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dztHcMheqOlUqUnln+Ve8+9N0CCwV2nO8l1EdCP9c09j+s6SbxwDAvYgZJgBUqzdH
	 vLARhz2u0NJplw31qPBfqrebWzJ3QZERlD2mUlYflJloGXB4IskYKp1rWv4jwbRbUg
	 3uJHy7X/eZdizEO2OlxHOMDD4FPWPKQyYzv0Kou/1TZSHciSZUsGlWlDx7G/VfzGrr
	 n77NPxXCJN+oQG5pFVg+kfuWd6xI9dFMKdaU0ODqSCMEdbiezXcOJD5voYgq9Q+NJF
	 EMXVVFYW3EmifX8b13aNgWZqxDTlE1Uke4iczi1Wns6fBaHlgBn93PYjCBklRDS4+1
	 u+cjPalzlHskA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 116C34054A;
	Tue,  3 Nov 2026 13:04:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 42F7BA15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3319E400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:43:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uEP_KHplbdG8 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:43:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E93424009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793691815;
 b=T1WHCA22xPxXbmKJM1e3UI4350PTyERdavHAJtw1EG1657kY5rKEfwrCciMVey6pNNRo
 Fek06dK67CHYQyDSWN4LiyJ/SBOZjdonFebw3My0qnZqlyE1jJhIfrZBAUGRwsiWFb9Zl
 AexKH0b158WdOq68B8NEZBbD08T1Kn39BznWZ73hZNbtpIL+3PyeXhGwrB8W+GAJUIdAs
 mXenMI4Si3hcjE1JXtZMGEA8R9aD8je4+dbgT5kQ0qqtXtEyWsqXvnL4lrmyMenmfoGcU
 xf2uI2ZpneP5P2MqkfYagCEhr9X5tPPlUl8DpGvMiIIQumdD+pM3TMyg+Vxzq7zcvTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793691815;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=5U1pJrXbsMuAdolEUeoW3qIp0OrpyXsirpZODX89XnI=;
 b=JbZ5gt3dqCHIPiJGOYhgF+Bf6UuvGZIsH9M/54Ewgi+RzgXPy8ryyjENOoozO1sA/peh
 +rQiOX2ucxKfAH17GZdk4SIOlQcPIgq4XaGog7B5UJqOUgKM/5DWgetJ3PMUgxCSlfQ/x
 VZj6oFkG2Hu2MR9QhTAmrbMeBkiZnbFTW/KDjOaOCscObY0zC3n9SEtveuJfYJ46jD9Zg
 yrc6Ng/VDoXCy2zMfCyhUWakngrCCwOAsNwsXQzd7Xm4DcNmahLeuNw3y4t/AlKBblyXs
 cBvMbvoz5gThstjpowUcN6qvK1zmI/T4AAjx6jI5EmADJ9ho1qvAz7NB8833y9olgZA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=j43QrWuf; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QXSyi7m9; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=j43QrWuf; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QXSyi7m9
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E93424009D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:43:33 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A31eDr71434036
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 07:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5U1pJrXbsMu
 AdolEUeoW3qIp0OrpyXsirpZODX89XnI=; b=j43QrWufOfvB8YCjnN5Fizk5FP5
 Xc/00OxaeAadsBWJzUGGj1bMVZGpkNowD70QuD524oZFwG6XKUsSjqaHpRbwQsun
 3GHwsJIdSfksq4HZ/uaWzlJC84UK+0Lc0mQHg7yWnbbToNB8e+0ywpmgdim1uU5k
 +ApWdNESKXRjf3O0Rr7psJeCaOWwm9C2nL/bXjl4M0xL2z9yPvKy+3W+1z/5/uYt
 CvQzWziCvIinF+qwaVd9zWOOVSNiOcOs8srF8ku5PBUrTRLv00YEtHnuUK7Fils9
 HrJecCNXNSxLVs9+5xYGSHthIezfr/cAAB3v8KiCwFn5a8quUYUlOK9/FYA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2achyv9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:43:32 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14373747468so5095568c88.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 23:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793691812; x=1794296612;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5U1pJrXbsMuAdolEUeoW3qIp0OrpyXsirpZODX89XnI=;
 b=QXSyi7m94rfXv1vO5zVNBmm6BDDwEUYXumeI1MC5bK5qQi/4sD833UL6XC09uxONE0
 BnJECxCEmwFkPe0gb5A1LXmTHx9IGtlhwzZs5RBSku2d7nA8wTnumZfZu1JwuOhuRl5i
 4dHwsSnTGdzGCI/uQmYVl2zV+TcnquamGwiigGd00oIX0Yd5T6bEK6x1RNZAWNHullo8
 4i/E3O/j4ztSpNdwjGfXL9jigm0ex3xve2STWMFEQu0ch3/yyc6xISK2IdPXKMQtD3xb
 HpDzJ22B9LWZ5P5S+E1rZuoJNKwop3ypm0xTsI99uNwowAvtX7dg0jJ8UBq00HXhJOJt
 K4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793691812; x=1794296612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5U1pJrXbsMuAdolEUeoW3qIp0OrpyXsirpZODX89XnI=;
 b=OeDN2xOzTikuhlKEok3xGRhV9+RfzkZMq2hR0YOpDUkmfZ1yeWh32x2NCt2RpuxhRb
 6AV4dzYJPTOWnxWnays2z59B9hih5zl7X5WNPpyVLONuHifYVKOSZJVKyzbf4JUdcrnr
 kZjli5AHN2thLwTQUq/hGSS9AkhoKsCBRuu7Al6mfDERAaaW/UK7ZDaxPpmTeauPnmcb
 32Y0iUOOPM+5TynFJk7/8UW7kBUqibZEf4eC38bTuA6luRbAyI9WjzdUzJ4fpjCnKNhF
 A0E9c79a/9i04NY4TpOLrbkjtr/vJ4dTQDVQXKdJjxjVe9Q88ZR5bZSCjlZKMxJD5YIS
 c/eA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsZvlJinklnznKD5DfvPUOx5927Tqi7s4wF9Hw6qI35PCkayAhm+54NJqrw4Qls6JFF9pIMJw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8eHr7WEop8AwzeXYiDta4+jYL8bQQqfiRUAQamUX5s8RH3omZj
 TXSfc+S7Oecwb9h/81EXL0DbHWiXTVxhn8YTw/zxYStmownG1p5FwGuM54z1KxGM/Xh2GE+bKUI
 ZX5gIKFpwJsDGDLsPvmGDvcmfwsRspuO/0o68xpI3uynNUpa3UhCmnPmSf+NiYFzp4O2uTCw=
X-Gm-Gg: AYBFou17idNdBTGtFzARbKNExtZ+otbUDiAYRjyVt5HppuQzMvhvt+9qh3oXQk8598W
 Iq689yi8eeADFjED3waCSeW8ewqEi7xcn7U33lFd68Pj9Pcs1vvbh+MrsWHSa2i4PFIjC18yRjy
 BJCSHIm83WJZ10q3236QSfD2x7S59CnZakQmAX7e204KlGUujlHVsi+Vln0edGTAWwHw102Ncky
 N88Vy5azMiWJdOA6D3Px66os611Mq3lEl7pSw/VDG+EVr4elFFkanG6cXIKJ51ugdfLQsRZbhTV
 JcNfgKGNBgCCUt0GtbCCCD4Z/IRsyTVcyyc3VlZMYQgiv/cd89C8R2kUKImoD37QzzEqwrJtVGy
 z0pNyPLpQtedySoZvAEPOhel9os2uxSgVe1iswgkgOb+C2NyJ1Fuv6ZuAkVxtOcdk/goJBO6JbH
 YDGveZJGVKQ2lIU6GgLkG1u7hm7BJdetPUflkOxs3mmscx7ydT5E4mtCmUpZ5ul2jDIA==
X-Received: by 2002:a05:701b:2087:10b0:143:7001:7645 with SMTP id
 a92af1059eb24-1ac5d889adcmr19111103c88.47.1793691811509; 
 Mon, 02 Nov 2026 23:43:31 -0800 (PST)
X-Received: by 2002:a05:701b:2087:10b0:143:7001:7645 with SMTP id
 a92af1059eb24-1ac5d889adcmr19111064c88.47.1793691810779; 
 Mon, 02 Nov 2026 23:43:30 -0800 (PST)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm72328207c88.7.2026.11.02.23.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 23:43:30 -0800 (PST)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, u-boot@lists.u-boot-project.org,
 kr.sowmiya@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 u-boot-qcom@groups.io
Subject: [PATCH v3 1/1] DDR training: enabled DDR training for Shikra SPL
Date: Tue,  3 Nov 2026 13:13:15 +0530
Message-ID: <20261103074315.2868454-2-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103074315.2868454-1-kr.sowmiya@oss.qualcomm.com>
References: <20261103074315.2868454-1-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae990a4 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=k1Jzc5MXYphDByd7_rIA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzMCBTYWx0ZWRfX1V7A45qN4Pxr
 3huDA52goYyxtJOTKJg4p1bpAUPgxLzXMz3JR8eLHNaGIn/KRFYsr2hY/XqsdtF3bcx9TOiT4lR
 J2VIhWtLKPJ6pd1oAM9L9tk3geTNvZn2Qr3K2GYv0zztzQI0Pheij5R8YaEfu/5v7tD1/1MNSoE
 IaqVUZvAwKOeije3ZmgurXOtB5yPA42WmeMW8N5YlJCB5fi4Vq7A8CwlU0xI+fdVyBw/ulJaVb/
 SXN59CSaiic/Whjqq+gnR2KdE78nS/H07qcZllNAqjeQlJKAsOupbgRulW6Obn5cD5gki476Anw
 zX2PfMMLmmc6Y/2T8W2gkK7w6xJNtPmr1Y6bGjI7zuY0U+K6D3uE4hduL/Jhf/vBUi0zUuR6UxF
 F+1frF04pDn3Y/VZlenHmzZMwpJnvGRDBxZzS8gsKEQlzcrfQTDEjyM8knx0kmzaOUlQdU3LkUQ
 u/NTeUNriQepC/ndxlw==
X-Proofpoint-GUID: Itu0Sg-RX8YJTxDISiqMRTomgrss4Ccv
X-Proofpoint-ORIG-GUID: Itu0Sg-RX8YJTxDISiqMRTomgrss4Ccv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzMCBTYWx0ZWRfX2w12uRaQOq5Q
 vaMkHlhKH4oMH6FsgaVy2BUPMyAWhfbjL7ZiZxBGF3XAuRqGn1bbwhlLYwZhftvHOdPsENj8Yvr
 IrZFXxWkoHmwrCqlgo/NvlaA0/H17lc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030030
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for:

Reading DDR training data from eMMC during Shikra boot flow and
sending it to QcLIB via interface table.

Saving DDR training data in eMMC when QcLIB performs DDR training
and sends the data via interface table.

Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig              |  67 +++++++++
 arch/arm/mach-snapdragon/board_spl.c          | 128 ++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/qclib.h |   3 +
 arch/arm/mach-snapdragon/include/mach/spl.h   |   2 +
 board/qualcomm/shikra/spl-shikra.c            |  35 ++++-
 5 files changed, 228 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 9e23d6d8948..64976c275f6 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -93,6 +93,73 @@ config QCOM_XBL_SEC_ELF
 	  The image is copied to the build output as xbl_sec.elf and embedded
 	  by the platform SPL linker script as a Qualcomm XBL-sec segment.
 
+config QCOM_DDR_TRAINING_SUPPORTED
+	bool "Enable DDR training data save/restore support in SPL"
+	depends on SPL && (SPL_PARTITIONS || SPL_PARTITION_TYPE_GUID)
+	help
+	  Enable support for saving and restoring QCLIB's DDR training data
+	  to/from a dedicated storage partition during the SPL boot flow.
+
+if QCOM_DDR_TRAINING_SUPPORTED
+
+choice
+	prompt "DDR training partition lookup method"
+	default QCOM_DDR_TRAINING_USE_PARTITION_NAME
+	help
+	  Locate the DDR training-data partition on the boot medium either
+	  using partition name or partition type GUID.
+
+config QCOM_DDR_TRAINING_USE_PARTITION_NAME
+	bool "Look up the DDR training partition by GPT partition name"
+	depends on SPL_PARTITIONS
+	help
+	  Locate the DDR training-data partition on the boot medium by its
+	  GPT partition name (CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME).
+
+config QCOM_DDR_TRAINING_USE_PARTITION_GUID
+	bool "Look up the DDR training partition by GPT partition type GUID"
+	depends on SPL_PARTITION_TYPE_GUID
+	help
+	  Locate the DDR training-data partition on the boot medium by its
+	  GPT partition type GUID (CONFIG_QCOM_DDR_TRAINING_PARTITION_GUID).
+
+endchoice
+
+config QCOM_DDR_TRAINING_PARTITION_NAME
+	string "DDR training GPT partition name"
+	depends on QCOM_DDR_TRAINING_USE_PARTITION_NAME
+	default "ddr"
+	help
+	  Name of the GPT partition on the boot medium used to persist DDR
+	  training data across boots. Locates the DDR training-data
+	  partition by GPT partition name.
+
+config QCOM_DDR_TRAINING_PARTITION_GUID
+	string "DDR training GPT partition type GUID"
+	depends on QCOM_DDR_TRAINING_USE_PARTITION_GUID
+	default "20a0c19c-286a-42fa-9ce7-f64c3226a794"
+	help
+	  GPT partition type GUID identifying the partition on the boot
+	  medium used to persist DDR training data across boots. Locates
+	  the DDR training-data partition by GPT partition type GUID.
+
+config QCOM_SPL_BOOTIMEM_DDR_TRAINING_BASE
+	hex "IMEM address to stage DDR training data at"
+	default 0x0c368000
+	help
+	  Address within BOOTIMEM where DDR training data is staged, to be
+	  consumed/produced by QCLIB via the interface table.
+
+config QCOM_SPL_BOOTIMEM_DDR_TRAINING_SIZE
+	hex "Maximum number of bytes to stage for DDR training data"
+	default 0x8000
+	help
+	  Maximum number of bytes read from/written to the DDR training
+	  partition and staged at
+	  CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_BASE.
+
+endif # QCOM_DDR_TRAINING_SUPPORTED
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 31a06b1e002..62db86fe628 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -77,6 +77,134 @@ int qcom_spl_get_boot_blk_desc(struct blk_desc **descp)
 	return 0;
 }
 
+#if (IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED))
+/**
+ * qcom_spl_ddr_training_restore() - Restore the DDR training data from the boot
+ * medium.
+ *
+ * This function reads the boot medium for DDR training data which gets saved
+ * in IMEM location.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_ddr_training_restore(void)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	lbaint_t blocks;
+	int ret;
+	void *blk_buf = NULL;
+
+	ret = qcom_spl_get_boot_blk_desc(&desc);
+	if (ret) {
+		pr_debug("DDR training: boot device not supported (%d)\n", ret);
+		return ret;
+	}
+
+#if defined(CONFIG_QCOM_DDR_TRAINING_USE_PARTITION_NAME)
+	ret = part_get_info_by_name(desc, CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME,
+				    &info);
+#elif defined(CONFIG_QCOM_DDR_TRAINING_USE_PARTITION_GUID)
+	ret = part_get_info_by_type_guid(desc, CONFIG_QCOM_DDR_TRAINING_PARTITION_GUID,
+					 &info);
+#else
+	ret = -EINVAL;
+#endif
+	if (ret < 0) {
+		pr_debug("DDR training: partition not found (%d)\n", ret);
+		return ret;
+	}
+
+	blocks = DIV_ROUND_UP(CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_SIZE,
+			      info.blksz);
+	if (blocks > info.size)
+		blocks = info.size;
+
+	{
+		blk_buf = malloc_cache_aligned(blocks * info.blksz);
+
+		if (!blk_buf) {
+			return -ENOMEM;
+		}
+
+		size_t read_size = blocks * info.blksz;
+		size_t copy_size = min_t(size_t, CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_SIZE,
+					 read_size);
+
+		if (blk_dread(desc, info.start, blocks,
+			     (void *)blk_buf) != blocks) {
+			pr_err("DDR training: failed to read partition '%s'\n",
+			       CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME);
+			free(blk_buf);
+			return -EIO;
+		}
+
+		memcpy((u8 *)CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_BASE, blk_buf, copy_size);
+		free(blk_buf);
+	}
+
+	return 0;
+}
+
+/**
+ * qcom_spl_ddr_training_save() - Persist DDR training data QCLIB asked to
+ * save.
+ * @address:	Address of the blob to save (as updated by QCLIB on return).
+ * @size:	Size of the blob to save, in bytes.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_ddr_training_save(u64 address, u32 size)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	lbaint_t blocks;
+	int ret;
+
+	if (!address || !size) {
+		pr_err("DDR training: QCLIB requested save with no data\n");
+		return -EINVAL;
+	}
+
+	ret = qcom_spl_get_boot_blk_desc(&desc);
+	if (ret) {
+		pr_err("DDR training: boot device not supported for save (%d)\n",
+		       ret);
+		return ret;
+	}
+
+#if defined(CONFIG_QCOM_DDR_TRAINING_USE_PARTITION_NAME)
+	ret = part_get_info_by_name(desc, CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME,
+				    &info);
+#elif defined(CONFIG_QCOM_DDR_TRAINING_USE_PARTITION_GUID)
+	ret = part_get_info_by_type_guid(desc, CONFIG_QCOM_DDR_TRAINING_PARTITION_GUID,
+					 &info);
+#else
+	ret = -EINVAL;
+#endif
+	if (ret < 0) {
+		pr_err("DDR training: partition not found for save (%d)\n", ret);
+		return ret;
+	}
+
+	blocks = DIV_ROUND_UP(size, info.blksz);
+	if (blocks > info.size) {
+		pr_err("DDR training: data (%u bytes) too large for partition\n",
+		       size);
+		return -ENOSPC;
+	}
+
+	if (blk_dwrite(desc, info.start, blocks,
+		      (void *)(uintptr_t)address) != blocks) {
+		pr_err("DDR training: failed to write partition '%s'\n",
+		       CONFIG_QCOM_DDR_TRAINING_PARTITION_NAME);
+		return -EIO;
+	}
+
+	return 0;
+}
+#endif /*CONFIG_QCOM_DDR_TRAINING_SUPPORTED) */
+
 #if IS_ENABLED(CONFIG_SPL_SMEM)
 /**
  * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
diff --git a/arch/arm/mach-snapdragon/include/mach/qclib.h b/arch/arm/mach-snapdragon/include/mach/qclib.h
index 10865b03ea1..a643f3240c5 100644
--- a/arch/arm/mach-snapdragon/include/mach/qclib.h
+++ b/arch/arm/mach-snapdragon/include/mach/qclib.h
@@ -15,6 +15,9 @@
 /* interface_table.global_attributes bits */
 #define QCLIB_GA_ENABLE_UART_LOGGING	BIT(0)
 
+/* interface_table per entry attribute bit */
+#define QCLIB_ATTR_SAVE_TO_STORAGE		BIT(0)
+
 /**
  * struct interface_table_entry - Meta data for blobs in QCLIB interface
  * @entry_name:	Name of the data blob (e.g., "dcb_settings").
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
index a32a85c48fd..868e19cfcd7 100644
--- a/arch/arm/mach-snapdragon/include/mach/spl.h
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -12,5 +12,7 @@ void qcom_spl_malloc_init_f(void);
 int qcom_spl_loader_pre_ddr(u8 boot_device);
 void qcom_spl_error_handler(void *arg);
 int qcom_spl_get_boot_blk_desc(struct blk_desc **descp);
+int qcom_spl_ddr_training_restore(void);
+int qcom_spl_ddr_training_save(u64 address, u32 size);
 
 #endif /* __SPL_H__ */
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index c2a5d2d692b..76b69932062 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -119,8 +119,6 @@ int arm_reserve_mmu(void)
 #define SHIKRA_DCB_LP5			"dcb_lp5"
 #define SHIKRA_ECC			"ecc"
 
-#define SHIKRA_DDR_TRAINING_DATA_ADDR	0x0c368000
-#define SHIKRA_DDR_TRAINING_DATA_SIZE	0x8000
 #define SHIKRA_PMIC_COCOS_SIZE		0xbc00
 #define SHIKRA_PMIC_WAILUA_SIZE	0x6000
 #define SHIKRA_DCB_LP4_SIZE		0x4800
@@ -357,11 +355,14 @@ int qcom_spl_soc_qclib_override(struct interface_table *table,
 			return ret;
 	}
 
-	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_TRAINING_DATA,
-				    SHIKRA_DDR_TRAINING_DATA_ADDR,
-				    SHIKRA_DDR_TRAINING_DATA_SIZE);
-	if (ret)
-		return ret;
+#if IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED)
+		ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_TRAINING_DATA,
+					    CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_BASE,
+					    CONFIG_QCOM_SPL_BOOTIMEM_DDR_TRAINING_SIZE);
+		if (ret)
+			return ret;
+#endif
+
 	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_INFORMATION, 0, 0);
 	if (ret)
 		return ret;
@@ -383,7 +384,11 @@ int qcom_spl_soc_pre_qclib_routine(void)
 {
 	qcom_spl_soc_shrm_reset();
 
+	if (IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED))
+		return qcom_spl_ddr_training_restore();
+
 	return 0;
+
 }
 
 void qcom_spl_soc_rpm_reset(void)
@@ -417,6 +422,22 @@ int qcom_spl_soc_post_qclib_routine(struct interface_table *table)
 		return ret;
 
 	qclib_set_ddr_sr_exit_address(entry.address);
+
+	if (IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED)) {
+		ret = qcom_spl_get_iftbl_entry_by_name(table, SHIKRA_DDR_TRAINING_DATA,
+						       &entry);
+		if (ret)
+			return ret;
+
+		if (entry.attributes & QCLIB_ATTR_SAVE_TO_STORAGE) {
+			ret = qcom_spl_ddr_training_save(entry.address, entry.size);
+			if (ret) {
+				pr_err("DDR training: save failed (%d)\n", ret);
+				return ret;
+			}
+		}
+	}
+
 	return 0;
 }
 
-- 
2.43.0

