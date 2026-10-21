Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D98606A329
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 06:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ffqviuYf;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cdOU6mI3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YwdRsy6A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAFDE810E6;
	Wed, 21 Oct 2026 06:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Q1p7F9oTZ_r; Wed, 21 Oct 2026 06:43:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE3DB80FB7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792565009;
	b=oSDVRZM7C7DFNfNVohPoRimoaShCM3SJtBbSPdnjIl4eWn/PkXv7YYeJcoyhv8mcfUFK
	 YMsisj1WB3+l0tCV3N+8HLykfC4oR8chhv+syY2rOx8Y+mOv7pEmRZq1vSrs43AHEP+T3
	 AvXfnkQujy1TDMBPMcGwcDf0AUlSrpG2r1hLLfp9SvY0AoI1pnJqNmNUqlfnkTXyt9nqY
	 Iob5dluS+eSZlVavfPDs/P2QYfHMUM5Jjlhmknv4COV3bIfMebp7yt25lI/YFzkdy4cfe
	 08pGqqrI3R4erwj8ZpQQRP75/FPPovGS7mJlq8lNiIEFXDEJ43gdg78xKq1C2j2n5Pw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792565009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t5Vlqhbp4aF4fw1/EY7XJ4OlaopnWZ8epJpgUBpCcPw=;
	b=V/dg/uheTnmibW+D/xSwoiJ923hahNRXc9cH0kzKzJc7ztlqFyrQxtg13e/f2MUtouTO
	 FO7m7JZnEE+IlkrxhoX3K8HK033YXktVE98bCcjdGqImfLEpFZU0QPQ/+5/kJu6DJc5bt
	 7Ftq1omXGBPknQFqC43caqz05xx7cD1xHSj3g/SbAKBP7A3cZyjd4uIJjUP+KMAfe8JSo
	 bm71uOKjGy8ln0VgqTyAO0lLaICvsgQhOjgq035Yc1ekVbtNqUjGFBfieW7o8d0wy9gFw
	 syd6Mv0t6kRKqifM8LwB/niEAeKg/O6enKbsC9r4mgu8Peu9cD7lj1jTCyF5tK7UcRQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792565008;
	bh=t5Vlqhbp4aF4fw1/EY7XJ4OlaopnWZ8epJpgUBpCcPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ffqviuYfDNItmjiZqHI2Od6L13qRGBRig3Yuu7OsdJbfY7k1+XmqV660r8MjpK/wK
	 Ulg+czWz5Lvum1Q0Am5m9cqQdSVkjtjmuHtze/frLLgZMHAym43TZNzzWi5J7wZ9mj
	 XKCol5s29QvTx6qUlK+/OXSbge/z3nkzFJXNlLFOsB0VKOrBGgvynP4t+j6vlNsDDS
	 ntT6RN6qQg31mvV6OC4713qu3D0CzWWDi2AjkZf42oyG1iRnHwn09ehTScH2iELuI6
	 FRiZrQoC6QMwBgGdEuqlHP2v5D2WgrOJQXbH6x++hEvrTkEcT6nlaB9TH3nS2SoLi8
	 6CFVUcQ7nvKQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE3DB80FB7;
	Wed, 21 Oct 2026 06:43:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E8DC93A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E665B6078A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fn8-eYKnRo9S for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:43:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FA28606ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792565006;
 b=V72L8bZF5OiWeS0U9WmAIlN+uOf3Yx+QTm8c9mtrPnImOLSrmbCm5TKM0+gsuagVmvao
 AOgGsWrDj523KcceM8XuxQbZ+z0BmPd6XcoVO50gECsp7x5GxzpGUh2tPcrBSuUrddTlR
 d28fd1FsqAlaHJclScWUDfcpH2hiPQHy7Tj9RzcTTtJMfG+aComzd0dGKd3+CHHnePdoh
 VBPYieT5PJhjSRC8vh51Zr8HguF3ogCyJTxU4NyVFEH/x57h4i5+PljEe3jl6NgSgk5MD
 GusB/J0NrcIpsm+2wTb6ZSk6ich3Ul3HeZyRkSnyNm0ZlWleG66aBJ9DuBhIEUIzaPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792565006;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=t5Vlqhbp4aF4fw1/EY7XJ4OlaopnWZ8epJpgUBpCcPw=;
 b=Oeu4YYAhVeyfGVDlVIArM8VxIRiBiGn10EliV2t5EcU3Cj3A0rz6BDQBtyFoGd5myBvG
 cDZYxVgHW/uqVW78ERAhkHHT5o7l+SmyVBkdfZVLXzvaf97la3+ohHd3TL5BaO9gaiSGu
 4NHqnwSm+sPhKp466Ho7t7rErtCveaKtWuflDmFB/smD+ziai3pJwFZUDfNlZpSTSqLxJ
 lXbWH1YaYVeqALmIfk9G3/tskXEy3RjYrLzJAZNpyc825F7sbUU7WRxlTArTdIE0AIuif
 Ke+Vd20ToDfDLT9KYY1ozYQOHYFd0h8+6mcQJZtFNNsWMf2noxJOKJFn/FMer7mSrug==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=cdOU6mI3; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YwdRsy6A; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=cdOU6mI3; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YwdRsy6A
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FA28606ED
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:25 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j6Fs793336
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t5Vlqhbp4aF4fw1/EY7XJ4OlaopnWZ8epJpgUBpCcPw=; b=cdOU6mI3zKi5C26g
 BgNKjbiVZC+Y9O9SC/f/otV/wMDwFyHD0xLjAZvBz16rRULdClC4A8h61t9jVvin
 xuezdeaTLnVtbxPSpZ6wPGDuawrlrDvKNDvCrwBpl2CevLOEOi3+PG7FZ815soWt
 Sd9+vOWGahFu3lgZlhpeSkXArjs1LZ2RWzwyfrJHKs2SgSZSFynL8v6toXbsmeVv
 8KqepyE9sr7dJnbgJNKAEHCVlIvXu2txo7ePjBXEf0m9lQDowsPOuEYl9o9KNEEJ
 Dn40nTGI2noAy5VrzURcuPXtmwe4wsQd036V512qVhdihbuktPu+q/iOMuZN6/Fv
 W161Ng==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabjdqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso606110eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792565004; x=1793169804;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t5Vlqhbp4aF4fw1/EY7XJ4OlaopnWZ8epJpgUBpCcPw=;
 b=YwdRsy6A4V0UX8onzEohV5lCl/7xWsaS8YwJB2gAprE2KfN3260Tc7QL7uuubwD+zP
 G0g4ghB8T1eSC9s2LuiAjPuUAzhBJI4goyogrUfwT1Wk3Qy5/M0gookcOJiqE7yRBZQE
 Qht694UGPNJgE9bOIxr2Ao+yTWzZ2PwjMTj4mSVwT9+Yqms6ofPWBzrNkaUFXtGc1QoB
 cRTfPtxbm4lHBSfNn8X/AhcAEDDXQE0QzJ0eslwu0rbOvJfr+PF4X8kfhmGRk1x4HR/R
 VvLox4onmXF3fhU8dvTLOo3+zlTJOyJfJj2bdQNh3uTHm5i+KeDoPOKCvER3n8c+9FsW
 Hf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792565004; x=1793169804;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t5Vlqhbp4aF4fw1/EY7XJ4OlaopnWZ8epJpgUBpCcPw=;
 b=d6Yb3cAeLRjKqsnHLMQZaMxVFc2pqkhLOSRd6cXCsemx3CSBFfv2PZxtlkxDpCD8F7
 G0V7fprTRjTO+UOuTQ16yU6yazqXsiUJSRCT24OcoRZjwxvRQY0TRsVerxusnyjcED7o
 gnGJHa0yNOx1qRF/PoNKgvpIKRNNjXNpiMNoE+XPGjRO43ZLbG8DSF1cIyI0X8GUgPas
 Snq/3267Ioi7Vlpk7h3lj9RYRn7x+ui15FBvymmudpP9cVLtetFgEFmeGFD0qLp4KUq/
 t6RXs4W6qa+Wuo+f8Oxj2+bb41xPiALdxFfp7HAms72QQw9MaStmn0uq8n/42HQelMve
 OGfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSm8MRXRJvyTui9stV1jQcN9Kh34dii7x9ZaPTcX36xrl/vmM4j2W1JtlsWBecxsTM1AhMSck=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIiAHhmhaXWzk0TJSANt5lk2XxFik8XcjY1NhzBHNaGf4MF6QgV
 E8gQcnIAgzDov6MSw6kycQlIgWfoQ+o5DI9UGugnTNr16mBopKwYqyPkEftp+cgQxW5m3lx4ZNV
 uyYIHTx6PSyRNrJSN5mWawh0qoFY6ch5OZE4uE8IzDYgUxlE9Prb5Flz4fgepJxp6uuhNydA=
X-Gm-Gg: AYBFou0jK92oU0orQOnLTGKFEFNHzNhIpFh2lKwbVd8RZ0aCV4MylwBg+JTgms53Je4
 SkgF8Kn8X8uj53qfxtqLQUyEUh1zwgVWfWSCdsztVXxGPl+5XW9ic/mIloEt0c4CiqaDfYanYdH
 ubq4i+uaUScd1jNNA+rMlio+k1cDiDojps7xOaecBSWq9iOijJhxoz/MiHG0O7K9qxpDGjZEaKS
 Sp9XVTFyVMtTIJJlRenRVoJEqGbrxlEp2Rxc99Yx3y5Z8UR4qyCUjsCqHpr9PP6jTju3XyBPerK
 snTwrOv6sPQVhUEd5rrXguv2SWOLGa5aex+IIfc1EEty7EDGAlMHUrdFlXIOHEN0oZKWUhb1bZa
 Voz1hKEZLYh5r2R/58lV/g8mhIglNmYgDd/tdEEfbbCZ5zlEo5nKUS6f9g+EQbbj1q0jNMoeBNX
 znjEcQTtF1o3kMd+m9tgMQc74z59lQ
X-Received: by 2002:a05:7300:d090:b0:351:7d5f:df26 with SMTP id
 5a478bee46e88-3674db5680cmr1681548eec.15.1792565003783; 
 Tue, 20 Oct 2026 23:43:23 -0700 (PDT)
X-Received: by 2002:a05:7300:d090:b0:351:7d5f:df26 with SMTP id
 5a478bee46e88-3674db5680cmr1681504eec.15.1792565003128; 
 Tue, 20 Oct 2026 23:43:23 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367411bd27dsm4547476eec.17.2026.10.20.23.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:43:22 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:13:10 +0530
Subject: [PATCH v4 1/5] clk: qcom: Add shared RPMH clock driver for
 SM8550/SM8650/SA8775P
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-monaco-v4-1-c90f0c01d312@oss.qualcomm.com>
References: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
In-Reply-To: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 William Bright <william.bright@imd-tec.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564992; l=5697;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=dR17IlIc3NEqTUT0/ENIhKHkMY43PlbbAgMBEp3mrxU=;
 b=vMT1H3lqw2zLHmHCynOF5YUoqvO2VVQuU1NBKZTetEIHzmI+o4/Cswvf0/d2eVPZyiAZ/H2H4
 4Bm7jI3eMpxCx3zxZr4h09lMyZyG1Z5skVP6H9rdX4vvOsLr7AlZ0oA
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX9yb0Yp1TqWVP
 MPz1o/VF7FCoTw/ktMv2XMWPDXgmGXn2WrRM1WXodGrnFN/TCksdVhwH8Q3KdnnOfgNsvsCyfQL
 q7sUPFZIq+kXMFqirOzMqj3xPVBwBc8=
X-Proofpoint-ORIG-GUID: zDtgjITvptnEn0YuDQV8h5DFig8hz7ot
X-Proofpoint-GUID: zDtgjITvptnEn0YuDQV8h5DFig8hz7ot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX4Zn3oQZG9Q4U
 QbTTe87J5PVouZDihZ7M8S6tCG7p5jpukOGkl3OlJmnI0oxGGLUta5UA+jaAh6EyrHjbbUsfCZz
 fgCBQm34mDfhkmIEtHoUrvxUVXG5uZNkZIbBjGDijYfPdg8dzz1qpzY0yR5rygGW/cMfRfivc79
 XOAsX7db2/HdkzaOJL34cvx5LRgjIH9+o2gahgZIH803kggKaO+2maVCT1ZFonE86ue7E+I9BoK
 GOdKKm1KxekzJ1pEaxXXvBnhALVINbHcxfMtJyX1m/ZYfEPqckWwmxaLfwaEKAhAZqshUR9Teg4
 arttbXDUo9PS1ma/82j0qDxfkHwY3ODBMpYvem61ipHbHqAl7g1q16kQK0Ep54q5RQwNNxNCg6z
 XbfnBUGtBCxFI1M7DcrS3uecMR+H6Zj/YZfkOHvdQOE31AMGXKxKPPxW/n3LnrPV2mLeyLc0tg1
 hqHePGciUuDT/6VTsBQ==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad85f0c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1c2JhAons3WoXjmucV0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210026
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

sa8775p was being handled by the generic clock stub, which just
no-ops every request. The RPMH_CXO_CLK (bi_tcxo_div2) it exposes is
identical on SM8550, SM8650 and SA8775P, so rather than bury it in the
sa8775p GCC driver, add a dedicated standalone RPMH clock driver shared
by all three SoCs. It reports the fixed CXO rate and accepts no-op
enable/set_rate requests.

Monaco-evk also uses the same RPMH clock driver as sa8775p (it's
rpmhcc DTS node has compatible "qcom,sa8775p-rpmh-clk").

Drop the sm8550/sm8650/sa8775p rpmh-clk compatibles from the generic
clock stub now that they are handled by the real driver.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/clk-stub.c        |  3 ---
 drivers/clk/qcom/Kconfig      | 12 +++++++++
 drivers/clk/qcom/Makefile     |  1 +
 drivers/clk/qcom/clock-rpmh.c | 61 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 4a6c71016da..85e54841386 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -51,7 +51,6 @@ static struct clk_ops stub_clk_ops = {
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,qcs615-rpmh-clk" },
 	{ .compatible = "qcom,rpmcc" },
-	{ .compatible = "qcom,sa8775p-rpmh-clk" },
 	{ .compatible = "qcom,sc7180-rpmh-clk" },
 	{ .compatible = "qcom,sc7280-rpmh-clk" },
 	{ .compatible = "qcom,sdm670-rpmh-clk" },
@@ -59,8 +58,6 @@ static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,sm6350-rpmh-clk" },
 	{ .compatible = "qcom,sm8150-rpmh-clk" },
 	{ .compatible = "qcom,sm8250-rpmh-clk" },
-	{ .compatible = "qcom,sm8550-rpmh-clk" },
-	{ .compatible = "qcom,sm8650-rpmh-clk" },
 	{ }
 };
 
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 95b650831a3..37455798e2b 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -87,9 +87,19 @@ config CLK_QCOM_QCS8300
 	  on the Snapdragon QCS8300 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_RPMH
+	bool "Qualcomm RPMh clock driver"
+	depends on CLK
+	help
+	  Say Y here to enable support for the RPMh-managed clocks found on
+	  SoCs such as SM8550, SM8650 and SA8775P. These clocks are owned by
+	  the always-on subsystem; the driver only reports the fixed CXO rate
+	  (bi_tcxo_div2) and accepts no-op enable/set_rate requests.
+
 config CLK_QCOM_SA8775P
 	bool "Qualcomm SA8775 GCC"
 	select CLK_QCOM
+	select CLK_QCOM_RPMH
 	help
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon SA8775 SoC. This driver supports the clocks
@@ -153,6 +163,7 @@ config CLK_QCOM_SM8250
 config CLK_QCOM_SM8550
 	bool "Qualcomm SM8550 GCC"
 	select CLK_QCOM
+	select CLK_QCOM_RPMH
 	help
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon SM8550 SoC. This driver supports the clocks
@@ -161,6 +172,7 @@ config CLK_QCOM_SM8550
 config CLK_QCOM_SM8650
 	bool "Qualcomm SM8650 GCC"
 	select CLK_QCOM
+	select CLK_QCOM_RPMH
 	help
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon SM8650 SoC. This driver supports the clocks
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 1adca029b11..73cafc3f938 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
 obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
+obj-$(CONFIG_CLK_QCOM_RPMH) += clock-rpmh.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
diff --git a/drivers/clk/qcom/clock-rpmh.c b/drivers/clk/qcom/clock-rpmh.c
new file mode 100644
index 00000000000..69f2a751441
--- /dev/null
+++ b/drivers/clk/qcom/clock-rpmh.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RPMh clock driver for Qualcomm SoCs
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
+
+/* On-board TCXO */
+#define TCXO_RATE	38400000
+
+/* bi_tcxo_div2 divided after RPMh output */
+#define TCXO_DIV2_RATE	(TCXO_RATE / 2)
+
+static ulong qcom_rpmh_clk_set_rate(struct clk *clk, ulong rate)
+{
+	return (clk->rate = rate);
+}
+
+static ulong qcom_rpmh_clk_get_rate(struct clk *clk)
+{
+	ulong cxo_rate = dev_get_driver_data(clk->dev);
+
+	switch (clk->id) {
+	case RPMH_CXO_CLK:
+		return cxo_rate;
+	default:
+		return clk->rate;
+	}
+}
+
+static int qcom_rpmh_clk_nop(struct clk *clk)
+{
+	return 0;
+}
+
+static struct clk_ops qcom_rpmh_clk_ops = {
+	.set_rate = qcom_rpmh_clk_set_rate,
+	.get_rate = qcom_rpmh_clk_get_rate,
+	.enable = qcom_rpmh_clk_nop,
+	.disable = qcom_rpmh_clk_nop,
+};
+
+static const struct udevice_id qcom_rpmh_clk_ids[] = {
+	{ .compatible = "qcom,sa8775p-rpmh-clk", .data = TCXO_DIV2_RATE },
+	{ .compatible = "qcom,sm8550-rpmh-clk", .data = TCXO_DIV2_RATE },
+	{ .compatible = "qcom,sm8650-rpmh-clk", .data = TCXO_DIV2_RATE },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_rpmh_clk) = {
+	.name		= "qcom_rpmh_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= qcom_rpmh_clk_ids,
+	.ops		= &qcom_rpmh_clk_ops,
+	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.34.1

