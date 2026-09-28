Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E498CA5FA6
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E25980EC9;
	Mon, 28 Sep 2026 12:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rs82RgatfPK4; Mon, 28 Sep 2026 12:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 60BD580E82
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790596997;
	b=VpIXVb7ExI+t/9tFT0u9G5Fr/WwBlExhm6pjszneuaZ/8dogSEykrgna58IR69dXZKL1
	 pj8fe1Bq02H/gKGgqV0e9P2Z/gGxAe5CQOx38BXK2zDyuAooqf0DMfMn8j8+0tPy2fs9C
	 R6q20liMGyZf0T0ifh3NStU/noK83C4q2fT2qqciK/VGZ41nl+5NV6q82K9SpiKehtpvI
	 kpFwD4bPCAz2tYNH1lYcBfrNbYlhSKGioBeWmZpCTlut4IQI7zxnAbPknwzOxDaI3/NXF
	 O1wJVI927b0aEb2ZnVIVEavUF4ajF+Dt6cAKJUYkuZSIJp/Fa0Q2W3szLAyY4wMeogw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790596997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wgHezY5Ovx9OhbU6B0Icvh5SUZzaWHXC5UF/lwSDAD0=;
	b=QFGwzNbxvPhZ95TNaHutCS+N5eNhR77ODjasaHj6HucNMSvjMGllhY1sgIrAPd+yTDol
	 cI4PQAhDnPMK0jQKeZxL4F6WZbcF8ZFHBNmexGmfVfQ3dnkeZt6mYuFN+dhx6QwdaOiDC
	 8pjSRyb/GQ3omlAesYp/whSgnCaNp35tscj0mBWz8fI/f5LdTc2Hmp120SrNigDvU6fVz
	 vmeHWtKBBfMslXSPCkUIxtp7hxS/7MCHhQgBiFu1TSI59iFjZaq0YCpKjJfBS0a6Z3VUG
	 VswmFJplH2TqlDNgjcIv8skWohCQjrxKmK52qeisSfAq5Kcdieb5XjX2F0GrNYwtyEg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790596997;
	bh=wgHezY5Ovx9OhbU6B0Icvh5SUZzaWHXC5UF/lwSDAD0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RkahyNzoI9tL3G7jR76RoIUXHAjMIJ9GqSdEyP9GY3XJ0qDKWkIYqOfbYKSzz+crR
	 CwucVazTVs9Je9C34GQOaNMEyfH79T3dM+BBjHyeNeUXBdhKtEWzp005+R48i0rw6Y
	 GvQ/9rOHSKy0TurB1F7wdFtxmOc1TzqKdnSXQAxwmXEAWVSwEUD+gTKb70lM0Vcxw2
	 s27qjJT5iyxhXmJCvT5wfz+D81+qHa8vpMcMwRLZ2BsJr/2XVg+pemCRwaMYmpvqIv
	 Taeqsnq/ZfNYtYD2rZgTicr6hov2xifGCOXQWCBbXMEEzg6IFXfXh+YLgp8DT6fr5z
	 +E4uWNexVQ1tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60BD580E82;
	Mon, 28 Sep 2026 12:03:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D47E02B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5F804050E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c3O-INssocQK for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:03:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3A6344050C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790596995;
 b=fIY6kYWG5QXW15YacN+8KGaHEpglwBw6y0xRSEkjfRrppNJuhySSMkP+GRUFwccgFxj2
 8leNcxKsCsK0rW8K8Ng8QIMnzf6l4kd5VaLyNWWwPVRoTaezRNWqOqtifVjdHuCmwVWAz
 0LhCqlrKJtDXnTN+6cNk7AckqzGN5yK+DDAE5Z6+oAqF/xeNavjqNFhYTiD0ZwsHxjYM/
 hHuvWDDRLZGJweNv8RKc7yoPE9WTuxaRo7y7S/BkLsWZeNs/UXkjSzVuh9zxW/U3ezo0h
 B2DmkNlYpyLwaS8PlE3lXHOSokUqOhv5E8aCJduDzOvd4p0JzcLy6ucGIi/1v/0r//Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790596995;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=wgHezY5Ovx9OhbU6B0Icvh5SUZzaWHXC5UF/lwSDAD0=;
 b=pLLxGNMicBXasfTw55Bg1MyEI7+zcZAubfDWB2kSr1M6RW9nj7QGQWdaLiIYi8Wkv7uy
 2qz1xZlL8zYimZP1UFHxpyY0wej8auOO3uFOrFVbRoymhDYoakuPVbxwj903FepWiJg31
 YlySWOajugL02XEPdgYzpXVj1fyi6boZU4n0aWLvHRqGpJIUku1fiEsRZn2pw/bcBvWd6
 ZIeAUDhiLt7m5YNCygfYLcfdVNfxQchVoSsZoAE9uk6gOCbHXtDtVMehkSK36Hp5C8aeM
 brALKefZl+MSSwZWLMnfwG33xFTaIQG5GKRKg+bXk2v7uakUBl5NsSCbZKSY/V+bNIw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Hf8quwCo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NOrIDEIv; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hf8quwCo; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NOrIDEIv
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A6344050C
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:14 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBATl9782816
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wgHezY5Ovx9
 OhbU6B0Icvh5SUZzaWHXC5UF/lwSDAD0=; b=Hf8quwCoZbJXRioTXxv2S+t6G7C
 zN3omwaxZrOv5H3RtnkHn/tg/2SuJ7MjMT9w+0r5rW+8JdINU8As27ov5FAHX50J
 OTjBAtCCP4jyAL0yN/QSFeSy6/sL86sVWfZIdQJz4fmSvQyEAHDDZzSLH5ouxGJP
 +DU7yR++eo6pL82tNswTe5ItnBzore7dpNbT8Gz/PkDZMPshoFHgQ44JRUdtpN17
 +cI7KuTd1yQKhzN4KE6otSqlEO4wPOx+XLuWS9vyYhygoD+Z6zSq7JuuzUw0VHK4
 XEA9gon/ruBRKTzOr/NadfTipTsa9+RTgXMez5U9QFJAAozFpGf1DaNnUgw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4abgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:14 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30f1b904861so4350677eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790596994; x=1791201794;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wgHezY5Ovx9OhbU6B0Icvh5SUZzaWHXC5UF/lwSDAD0=;
 b=NOrIDEIvE5d9/kL2uix1Anmps7Zhf5K/cliGLe5ywkz7vb9kJ2cIV+G3uPmMkvqubq
 3WEd6ksZXh1avUngSbNh227XvXmhX2tQ4Z9Jsn7Doyn1YDH+wPGSKNdzVvmvyH5Mai56
 fKeITSi7Z/UZ4f1uDx6UwuZ2PQTH+a44MzRcvOYaTNMoFk8n/ljfd8drfiMaIxxKB2im
 xHc7Bwf0xq5g+j7IqXVIttXm1Kc1dh+oAgSTfaB0fdPkK9TvyFN4cPToMnqvAIMGGyz9
 0xdMeuqeBkRSEZrd4vbJIancNGF3ADncFuHAPodv9xVHGYSmfSijnAtODhHdux5FhNI+
 tq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790596994; x=1791201794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wgHezY5Ovx9OhbU6B0Icvh5SUZzaWHXC5UF/lwSDAD0=;
 b=s5i5e2Z6RoXkOzrnTueJrcVFY6akwTNqIaABoTsUL8WewZ6yKNYgF1PzNd+YFO4Hfo
 M7ibeFGvO/9B10rZUoOsUCg/9U67i+8vLay8stZ0muiI3kn5gp5sI6E1yEw45DJdYVvl
 czhD2VYi+lIHMwg7pnCE2rajO8e1SMrIc0N6BN1on4E2Oc5YWkAgr3Rg9gTh/qUD4Xeg
 xXEuxjfwRImtAFVJrGfzaHWsWuDNT15A1FbbmOQtKvEgwRPrw/kDgcQXNlzSl2czgabh
 hTqMsLTeRsyYSs/bEWgriFFnOH+YBEzxjCZZYQ/itWRnwJvvuw87TA1m0MiDLxDscLjr
 1bHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNp+I/Gpcqr5WMr8InNPMEsN2l5Cckl6Fvh7bsarLTEgmHkaqJC4FGwQrMUrOzMJdNeYgW9gk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLh/mQgqPCxfPGpEf3T/E1nvRRbzDtPbgaROT4j9T7pTSjpg9U9
 jkSc4zqZTwFKBXxigiFKRDY/L6XueWrjbgR3LynPvO+o6xNrzEbS8rxl/wuKUsRI4Uxg9a2wFQf
 aga6Xn+yaJ9nq6B+LJocbiLRTfcCyp8DgM2c6MHUcB9Al2akjhijH6oakq4wZ0oeNmLKrgL+8wZ
 RdHLo=
X-Gm-Gg: AYBFou2R0XViKLLRp/d2kqCcRSIaOx1sYCn53wu+auiNY6IQ2xMyllQDXjaPvQMvW7E
 JgGfQ3xGMmDhGvoLCsGNZ5KclrKRE6gXoNfVYIJUELJYX+/dNUW4x2e+adfVDbF0b9n8MAqOHL/
 O2fqNSbNF+RZpHHZK7+KdPdqM4HtTi8R3WcpIHcqcJqxeFVG349OGJT7xfABDQGMu22UagoMkMR
 k2ZMiWT2/O2cfD4y3kxtWej9LzjelR9MxBG/MxBO2J1VxcbOA4pkpDHxYtb3xFmyL3TxwCmck+n
 OJ670JwuKMNmYHyJgpW6vxzpykEuhyUOeZde5e8iMY+35yCA7mSt9wRdP/Cit7gh4tehkzfD9OP
 pkjJCJ7719nVcjXy9GX2SZ5dXF7Y4BDfvlFmnovU4qY8rRUIXpG6fYHCmIutqc+1BRYxgOcLs3E
 Gtv9mO8bgvZTEMpp1iNw==
X-Received: by 2002:a05:7301:1f15:b0:341:5da1:7851 with SMTP id
 5a478bee46e88-342703b8346mr13429866eec.12.1790596993386; 
 Mon, 28 Sep 2026 05:03:13 -0700 (PDT)
X-Received: by 2002:a05:7301:1f15:b0:341:5da1:7851 with SMTP id
 5a478bee46e88-342703b8346mr13429811eec.12.1790596992343; 
 Mon, 28 Sep 2026 05:03:12 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144b4ae50sm28658382eec.17.2026.09.28.05.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:03:11 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, luca.weiss@fairphone.com,
 nikroks@mainlining.org, jbx6244@gmail.com,
 krzysztof.kozlowski@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 9/9] phy: qcom: snps-eusb2: add Nord compatible
Date: Mon, 28 Sep 2026 17:32:09 +0530
Message-Id: <20260928120209.1064781-10-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
References: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: H5dnHEMhEL2unUqxg1yrjaME2ZSOZqHl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX7iT/vB6yeaaD
 cLEvWMOpvU2vTeKT0x9eFewSo67+54w1DGZhlVRpWFBO8Q0U2yYIZQHlErYzawTSrQGKuYOfYgk
 zPjIl5gt5oYkVOQhipWok0+QIJYrmJO/6CEIBufSJYuaBBRTN7Ky9tk6J+xEwkP7fr+u7lZFP7D
 gmDz8QelXmeY8TqCqSt9mCw8ab125+PxIY9WnJQXQ8eaMVcLKr3MDmkWC37PbkDSYr7HzMpz6rs
 tGxQZkNXzttSB8ZbOxOneZNywQRYxJiX2GA3PTC7ZuTxwg/k2IOzVny7RTOcEU9JSC/NuWRa18r
 L8d1TClkVI8ltHHTVuhFxsvc0IN30Q9ZqceyQDosvogWkmRr+AxdhVDtyIQ3Yej5oWSrI6Gg+FN
 F8csy4QPGnuQRQpf+c7pxwvbDPZ3YhjdkNwGI0AasE6AXyTRrcg/sfRs4qQ2FfpKDjm8+gmVbga
 gC/XyHMx+yXT6XWgncQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX0c13xkZYyMCy
 nCTAO4/pA3zfeYUa9ITRDnXrZM/MxQAv/XClkjfVAcwBaWYEpdvGm5FFiB8vMHBtfLo0bzDbKFX
 K7TTjda7OCCsJ54GOouYEUtl+xA7UJ4=
X-Proofpoint-ORIG-GUID: H5dnHEMhEL2unUqxg1yrjaME2ZSOZqHl
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba5782 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=2eSpjYXTIbo4t31u8wEA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280047
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

Add qcom,nord-snps-eusb2-phy to the match table so the driver
binds directly on Nord.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/phy/qcom/phy-qcom-snps-eusb2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-snps-eusb2.c b/drivers/phy/qcom/phy-qcom-snps-eusb2.c
index 28502c46f67..8bdd2544443 100644
--- a/drivers/phy/qcom/phy-qcom-snps-eusb2.c
+++ b/drivers/phy/qcom/phy-qcom-snps-eusb2.c
@@ -354,6 +354,9 @@ static const struct udevice_id qcom_snps_eusb2_phy_ids[] = {
 	{
 		.compatible = "qcom,sm8550-snps-eusb2-phy",
 	},
+	{
+		.compatible = "qcom,nord-snps-eusb2-phy",
+	},
 	{}
 };
 
-- 
2.34.1

