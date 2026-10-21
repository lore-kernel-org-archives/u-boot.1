Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBA606A33A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GtZ4WUB0;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOJevb65;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rh6j1ld1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD2F9608DA;
	Wed, 21 Oct 2026 16:18:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gxJdqJRJtCec; Wed, 21 Oct 2026 16:18:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DCB7860856
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599526;
	b=qx6JCZb4wTO0yjqMmMyf+WfZcsk9JkPEwr3zy6Q5zRBbORrrc8m+B1jGjn77O24di6tL
	 9OZfCLiZDnRRMe8L6SczSmCkE2/5KW1DNHfDFgxvQwjtdud+6bBw5krAFPwaKMdvUa6LT
	 wTMMXhssvTCQFV/yB+fDl4g4AJEjoYCVHbV240fZl0WGtfJBGrQn73ZXfdGXFQrPWyKhV
	 PxBMg/YCgEBwZ2RpKHuRUxvADa1UWlBxUoMqfuNvvBDFFfdrLlRdxvKss2Nw8McX81afK
	 zUdSJ55/ddDVS24qrNA04SQV2SKdxokcf2M1lIA68LF2874j5NdePrLVtM04dmdRI+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599526;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
	b=UgI3oznod2QVU+JmkMGj1Abpa+44vuiGzHv3tGqatVzo6Bjf3Mwc1Vr5NcRpF9E2pz1M
	 t8jPYaRMLmhyvXR3DPrBoHMhPtCdwLH6t7LyIvWPSps5jWhWHTxWHg5xTz88p2bQX7hmi
	 skjL8HR/JeZzZiJDCjWAgNxC2xEL9B/BXWpvT9Y8ezU2A8PeXKPIIEprn/es93F/l4Xry
	 DOhKUGq+T/SHBqQPR6dc4qivMRMiQAv1gQlegnzMAJCzI7TKj0pSde8idKvieujV/u4dZ
	 KHVasK6OXMVlSa0D42xLMagN4k5cfDkPp+JyrK2pReJxrzdcg8tsTgXWGrde4tnfCqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599526;
	bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GtZ4WUB0O+tL0/hpYC5TlO87LkrP4/V3no/gyyptH0BilFQGr0NvL6zBZWb3y5KYk
	 G2PkK2b4QADYyFidnX+d/BjgMVSgZ60+bwbsDxVjNR3wmeww3tAGa9Lr0BpISJz/6Y
	 m8SxfAG//y7GLWkYf971sU5tGfGjQOrlkKoMYQIKf5dI4gRzAs9QD+ghy2j5XxvsZQ
	 nbcRirRVrw7toP0whAMi4s4XNyPbJR6qARv5jZTTarRTJZUkOx8YVgeHiAHW3FlHZc
	 fDsSNZpO3UMNJuBQKMklkHuI41ByOLo0gdoA+SYdEZOduRk68kYniqmSXDkQ29nHul
	 UmZ74nZdun4Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCB7860856;
	Wed, 21 Oct 2026 16:18:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB1C495C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E8F5B4053E
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WX_Hv6o0Jq3O for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:18:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E1EE404A1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599524;
 b=ovjzs6bO1h1U3yO/joMnHWrBkuSxznPdew7wd0DP8TXQaEciafi6OOYbjVJGH6IFprI8
 RsBoXbFcUNyHkCnztvprZgmHxPP/hpDgUt5RRWLMuAqIycyT6nx08t0TFBSFt3t5V57CD
 +uok7SVbQydEB7XCdnBalu7BV0vuvJam+oUy0XPI1BNuXL7nE7XjFyKQg5GaN8/GJsl+w
 kYD00eaG3NcQ/mvM2Cpni5j5ZjH2/dmn+vFvfXnZgdIpftD0n3r3373bY+YKlEH0BxdAO
 VCZCxz+d9GDqI/825VEISAKvw5BnL9Kgmdl1hgbu4izkAWShmLFUUM4G2pKa33LK48g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599524;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
 b=g1pWWnNyhbV3AXymMdSopheWjw/SON4hXMgrJmkZIuKJhwzCw9ps33YeCPHWp+wi4xo7
 wY/ELy5SGRevBSObp6XRCTPcjd0hbb2Sb4cSWIoMUuAlg0ZCAXMRwNtlqQiVjCgOUkv97
 VPx31PIDRgafNthrB/mQTeCuNliTktWJTNJLS3MF4M9O3oBGgzN5mFFDMdBHbONLDmpG/
 ghgpXkEBmwvOwKVbSpKGMXwJPeTLfYbG8lJeDn4iaFQy/JJuM0FaSYPKvThp0SnN1CAu4
 yNHLZFLxL8OLmeGPVy8WxHaebImLXQnp58lyf2MHiS9HF1w5aYdCrqZJpWfp0G3U5bg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=TOJevb65; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Rh6j1ld1; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOJevb65; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Rh6j1ld1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E1EE404A1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:43 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFTxf63726122
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=; b=TOJevb65k7DfMdf9
 d3o1znlF3279LytkTiTjp4oIL3lMzfgJbS4Z245yQw8iLuJ2rArBxZ8Zf+bL1T+g
 Dg4MuH+boecTaf5uqk0UvkFRKfhu43wN15LtmSXvGqnnOx3RBmLjezr2qd3KJfcf
 QTPsHe3ltCEAuojyG0Lgt6UvzeF4JknT11FURQZkfbucGdQNFYY051dYtVLYpJm6
 SsDRrA+EITgxXFGeBQodBRpcr5I3p/iOEtewc6pMMvIG9SVYpfqMEmdbVjSr81ff
 8M38yrwkiZe3QoRFOqmSQdOEBeabjyUSOnRRDSPqK9nXjRYHFezC3vDn+o2mToLq
 LeuqvA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy7a134-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:18:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36696c9f55bso12387eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599522; x=1793204322;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
 b=Rh6j1ld1pquToPhWknP4AuvwnJ93W79kLZJxCcLRnZ00tAg4/1JUtsMuz8QzeFbukW
 l54xHZD0Ol8qKocwl2YCO2MmthEs9NkL5gfVyzqBB93trMEnjcJs+Zw/Jzx0gozDCTRf
 KQ1NXrXvLcwk0TcJCXKDd92d1r8dl6RBq8meYMcpArbnvjCFJulXOE7Ox0+8fiH7IklD
 WlRQmb2E46Xv/5xFjkZzwlUVyVtfCh0dnV1GVcaUNIruvu/zEnY+iHA5BRFhG31NAjwB
 VfkvPnivKrMoAueLdvhh13lSAoEhDRtpmVzwexbSs4go6TSq4aGY+DiSrnqCqs2iRe7w
 jxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599522; x=1793204322;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FLuS+CpGAPSTbhzedsRVj9s9aLRtNoo1n/XYgqZRSBw=;
 b=L8htNODyEitG5271YZI0h+SkjhSkR/W9TATd1n4FNeVm/ygdDOCRXSfzlNrkJxAvJc
 AQDGO6sa2pZf6Gjv6IDKKO5OCawHujAId3gfP2smlkYudNhBQmDOjD1ygt4VPo23fgid
 yXP1RJGwN15TIuA51PV0QkGRi1uLQK8x7e+SdXDzSjudNt9NzsSnQHH+A3OobphlMOQj
 VYr5+YCjuzDkk0BTYvPh5WMWE99haDmCHBCfpdFbuWv0CNZ077OoUK8L9TjS9aYMrD09
 dPewSgDhEiZ8uuc9p0f4XPqzEvw1mNtVdDoIQsHDMnK2f4nzkMzPIrOzOkyrDdiH+Jw8
 EajQ==
X-Gm-Message-State: AFq9FYKqywUgPNq8aX/yhThvpsZIK4PPSunat8UfJj7S59qa0NFsJSJj
 M0IRAybV2RQjDCX1wV1dWChko4uf7fuNdWQAeh9Qywb/1Z9xty4sC+pkwXWtWGUtC3sq3rzkEhs
 D6hO3MAcgsJ4T17u0V1hlJduTnnba4UxranBYq4G8076uIlRhziD9t7MD9RI5iyHdRnY4mpo=
X-Gm-Gg: AYBFou0Zqn+xlPI9++RdUWUmntEWFeNAQ4vR5o9rdjL1sWXWnpj4NN54FhRh0hpG/+c
 pinnhDDSpTRfP2h98yVT7M47jILB2HeQEb3Ih81riMKyiC4hA+Vkik1X8wLIjVAnUe0xQ/N4ug7
 IqXEgjTbO16PZZ/Ww+VrJNq3+0nmi/lHeVhAI/R+AHFo8E9zjNK9Fpx8k/WwNdYjsFrLo49DoXu
 I5AW+3w5pfMn4Qg5Pb6e6cFeO5bcKGuwxHHlVYE6K30vI7ZCZTYKd9XkV9LutTaPsX6Dbsz04+A
 N7Zr2M9/4f6qZ1qDEh0fPX7mlrCk5hS6kGw5vs4BN6SAwBasbyigHw+RotYh/SRF26VEgsjPbiv
 Zv8O0eoW2NLU31UiWS5wOh4KOyNxb/RUNw+CuHBrCUi4fqtKsEteUEahxJqo/K+8qxFqyjnK2pS
 NJxWv3itGyBZkz3YvSK1YEWpZ+5bg=
X-Received: by 2002:a05:693c:6385:10b0:35f:ab1:4792 with SMTP id
 5a478bee46e88-365fa48f4edmr6808757eec.6.1792599522202; 
 Wed, 21 Oct 2026 09:18:42 -0700 (PDT)
X-Received: by 2002:a05:693c:6385:10b0:35f:ab1:4792 with SMTP id
 5a478bee46e88-365fa48f4edmr6808720eec.6.1792599521665; 
 Wed, 21 Oct 2026 09:18:41 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc88b5sm8764143eec.10.2026.10.21.09.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:18:41 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:48:21 +0530
Subject: [PATCH v9 2/8] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-snagboot-v9-2-18ce3e431320@oss.qualcomm.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
In-Reply-To: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599504; l=1447;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=LB4JLdu0EwvljUsiEw/wbtHkBd6leAp7LUyhNhIrloc=;
 b=+lteHheK0SM0QCZS7sijxZKOPchsjMd6egAAP4uwOWYEhggkCa93g3B/K1AT+lJWrCuDXsbWC
 H9zFhfplaJYCoN7iBvtoMhNOxCdtXcTNcGtYp/++Lnittjt4mH5QTuL
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: viifx0CN1r171KW2-g1_PkeQIvZDpr4V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX4Vwkm1zL+4Oe
 VeMLVZcFq1acJNKNmcsHGZMS9n0hwnJXUZzYqn53ZU0xx09CtKbbJmaYEXO3691Lbx+olR/VLDY
 K+XwB0MFsQxVlaPtWskrBidrb7pujkdCBL5BsD5fOcmLu4xosP8UhMRsUbK6AA23/n9w/KuTS1/
 RqgwvzTP0/HAe28neXpwvJCzOizu+AopB+6roh9/m6nfgyq089penvaHUETM2erDTyg+brnhUms
 YK8PQZENIW//t5TBBmLa6pwcDjhkG5fiMRKMHen00/VvZYgn3C3RNYFBKTmWOOycxKM2bn2gXE+
 QGHFLlC0DZTcpdk2MT5ffcXW8498uRIC9v76PFQNEP08etefNuHa8eaoLvi5e3o6yDfQCF756da
 z2pw+dmVrWJB1vyggNe7uM1/sd+DHTbhWeiRhnjxDplc0ZWFY2WK43qou1sIbSomjzNk8AJxENL
 ud3nlY8uwl3N0uUDB9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX3xXingN3qs9x
 zPLup7FiOXO8MXlgk6WV4r66XqRQwCIsyMJeb9EpKXkC2gNdnmGWPPgTdrJTDDoH82BYgqiq+SA
 gata2Ow4qx+r7KgI/Z1x3naXr8lxTfI=
X-Proofpoint-ORIG-GUID: viifx0CN1r171KW2-g1_PkeQIvZDpr4V
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8e5e3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=xAI3I7ZSbV2oIbCD5NEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In snagboot mode, U-Boot is loaded directly by XBL without PSCI
firmware support. The functions show_psci_version() and
qcom_psci_fixup() call arm_smccc_smc() which is unavailable when
CONFIG_ARM_SMCCC is disabled, causing build failures.

Hence, added CONFIG_ARM_SMCCC guards to both functions.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- No changes

Changes in v4:
- No changes

Changes in v3:
- Added CONFIG_ARM_SMCCC guards

Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/board.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 87adb100edd..daee2ed4fa0 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -35,6 +35,9 @@ static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
 
+	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
+		return;
+
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	/* Some older SoCs like MSM8916 don't always support PSCI */
@@ -58,6 +61,9 @@ static void qcom_psci_fixup(void *fdt)
 	int offset, ret;
 	struct arm_smccc_res res;
 
+	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
+		return;
+
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	if ((int)res.a0 != PSCI_RET_NOT_SUPPORTED)

-- 
2.34.1

