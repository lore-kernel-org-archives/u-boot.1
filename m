Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C15ACA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC619606BF;
	Mon, 12 Oct 2026 05:08:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v0CuZyYQeuLQ; Mon, 12 Oct 2026 05:08:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52F53606F4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791781725;
	b=KyJ2qtfr3i7w1ZpiOoHp2Q2AJzXBa9pY/WVYTXaRyASQb0j67K0OmL2NKQpw4o6syTmW
	 QC/G84w+a+IVjLPkDR/g4+25CMzLEUgqh8AJx/5i/PVGu3UC7XJXdWtTGHNBdwV+4Okkn
	 Y4USoYneolWW7NwsiuRqqZmjiX9u25t2yfDkoByv83hsSIcmmC3S8JYCHsJEnkzB/nl9f
	 89R0iGFPYJIb8KH4gGOt7ppRcoHv3JGZV7wdZ6EVOeFT0BTFHX0p5pGXvCNOdp+vZG6Jg
	 8SxQkqPCKcwSyKgVxB4VNMfu2MbLsvtsksJ27x6IzK+nn5LYa719YxHj04R58cTMhpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791781725;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1mPmMV52P0Di7JaIJobg3uXb4SVZmxcM1nT3rG5HBQE=;
	b=VZV+pV7youfxuICF0+mPzOd8BU8D376qTT4Q5dxxRsMEogqiItced2fIC01zpYcxIOjB
	 NUhnph4ZMNz33wFyzEDANshc4hZPHnbJc7YJEnQkzT2mRPl4XlN2ERBmkYlN8+q4CYUqX
	 kecdhZjUmDlwMce4seG2svycU8JjbVm4SLMqbXEdPeI0N2/CYj0wvp/bnO2R4ga/1YEE2
	 71/J0QWC54gusUZJqYMr/Us+qhWViCDDxCTaaJ+m8lRGAVtgD+PnY8M5/YclktFYS8VGC
	 gVhJkKi96R7KSQj8ABb4za6QKVcE7ciXZVmfnu1/p/2q0Nf3QzvIbV6bjrGAuE91U2Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791781725;
	bh=1mPmMV52P0Di7JaIJobg3uXb4SVZmxcM1nT3rG5HBQE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nvGt140MZ8yBp0C6ONisDLvwIGRI2nXskgZffEoiJz6sWWCW82TCybrs3zAezX0Ea
	 e1md8oj03UC6/fs2UyGaStv9I+6GCZz1lE8Orhz+52AGxFF7PNxBhKKba7afemJg7g
	 mWp/FuGbwm3F2J3jL7eu2qcX8a9XP8aCLKcX4IYay/4RTWpXFCfEMbT75vvIn/A5Uw
	 r4nAJvhm/VnTnyOKkNws7fNVufouE0XTV3AHLPsBeV9a4GcbWAQy1ZWfBDl0aylrxW
	 9o6iwlfVL+prlyN+UHIog4lMlBUR8Ni1Q0sXQuO9JWI1b2sYQDPe9dmZ0XIGUlq1rS
	 ojbZ8CIsEbC8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52F53606F4;
	Mon, 12 Oct 2026 05:08:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D2012194
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B7F124056A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id INEHFSV0d-OC for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:08:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F0D604052B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791781721;
 b=JlESFj+E2BE8B695b/ngPD4Ka9DWcSd1m4BKbZRKiEfQWxKLK+RuNgXemZBfh0/SF5u7
 09ur4521AYXjTK8lkKWDUwJTTGFlsl4EVwsNGe5sCBoIjp7Q41A1B/13Ez/0YnidIZct5
 0dlrTdSK3oWv8Ld9CR/UXQK16++S+NjIhDAiD3yDWVBKlAee4JnimkElWNJZ6zSHJzEL/
 JJ72f91WW0QpaOFh7DhV7F7RFPzwmgH9rU++PfiM4WlTMtuHBPARdvmAKxSX3yJv3pHt5
 uetByfRdP9m66g2b55K7Uo/yjh5jp45CsENz3X31S7Nup0NJeMWkXzpTkfwY1DxlwwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791781721;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=1mPmMV52P0Di7JaIJobg3uXb4SVZmxcM1nT3rG5HBQE=;
 b=Xb994RcEa4y8wzHXvV5DmDUGge+0VXW+EjGwAke8qIIQH39VuaTpXRuQMrBKSHlIhRMK
 +TRsPOd+K6cbPwLM7054+0a7EiyLoABgu7z0Wbwu+wWcHKYxJBwV1Q33hZb8/pHE5B6pX
 QqJBHEetw+Kz7U2YVnZE0Pagu09wxQgABSsc2xuU95PquB1F6+SsjYajrmAhGyCZ+bNai
 FakwojITL/epXaw+PN5w9wxJKWIJ1cLnw0Z4hRKuSw19mCdx8MShRYVJVSs2Mvi/VAPlK
 c+p915jWhwYr85owczqK5/oPqal5HBgyANQBT1dXyAJYZE+pYkbSTWytMVcHhWCT+MA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=dOT5CesL; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=K4C8FisP; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=dOT5CesL; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=K4C8FisP
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F0D604052B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:40 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55oLC1339374
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1mPmMV52P0D
 i7JaIJobg3uXb4SVZmxcM1nT3rG5HBQE=; b=dOT5CesL5fj+76g7HEKKYzuYJ/m
 bb+KQNWeJBYPJ0iOgvZsve6aRAh1p0xSJMSzDX130SJ+2gaHP+pGfzWbH9Ljop6W
 Zdzk03Pj9XZlVbTadaMt/OpZygJGHp4QJZbxENXxALPE3dHnJCVzHCerExMfqTCY
 E+6FmgG7RLLzIt6bCMcKXk4sLNUi/SM+LpyYtomvdSTmV+KbJWqnj42Eq9f69P+L
 AeP+t6GjhvQIpM0cHwnWJDJJk1Tql0jIBZdUT5zyMYc8OcrFU2HP0iX64b1js5B1
 tdebUVrSQmakYaH5sGOMubhpd9sPfNclyXZ3/X9OZrUcRAZqGn7xklg3Etw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dk24s7b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:08:39 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so4179174eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791781719; x=1792386519;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1mPmMV52P0Di7JaIJobg3uXb4SVZmxcM1nT3rG5HBQE=;
 b=K4C8FisP3ZupiqlgS4VqU39OweuIxBdkwiBozrNHjlHUsib9PeGuw1vwwZt+vo4/PL
 Q2bIqoFl2ypvg/p9tl0Luatigkc0sp8hfVT+XOo1/Vf6/012+ouQrluxbCYiMseaLHi9
 2hjZ9FJu06dimr4LF5gLdtfBBSuiYKUrVAk5W65/CIXw0KcYwakkybNPtGWjTCbpZYNa
 9+siI8TRKtRdUo+5zNW+Fz4WQbGZW8fcthtnCXnbp6mr0ESfTN1j3tJeBaAXC7kVSWYA
 doxvli11C1cuhew52IOl6R8dVGcIkXuKR+6hxPYZwzNb0AF4jaIaiRt3AI75pJP0Xziz
 MH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791781719; x=1792386519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1mPmMV52P0Di7JaIJobg3uXb4SVZmxcM1nT3rG5HBQE=;
 b=HO0msSqNoXBhrgPJAkmOWAkMcsus4wCxZdLqqUW1D1wqQ6PJ/okkpOmB4N8M9ElCxq
 In5BgAFMcZKJdh9JehhsMW2+pDbPKzh78xMyVipQ+Lmvn59TNShYju9LlH3bjziEsjaY
 C3TSA5jL31NxCwAHapSCbzgJLqk6wC7qWz+eB0NzUYTfmxc7CHl9EHNc+GJnFNOitbxo
 qckxd89b2NkNdtjxjQBiky7d2RUgKac+Qqyn0DvlUdVw9KsJzpJOksMephjC584FxGou
 h2b+4rfenVsx4b7d3xhhEbOer6srtklOkcio+LK5IJP5MJJVITrU/+0URZa9rIgl0h90
 YcqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzji8uf0KTAG4ZqlG/NfnsZctTaSCgUydQd74VqvPhSMECyfmb2Q15ZmfugR3NtVQqs0nImeB0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ3tBhUhYIlofWa42+Sr9jinBT4Z2exsZZisgnDpB1n1cxrJ/RW
 ZVikU8X76YF1o3eWGAs1x3gix/mNGomF3pgB4U5paVLcEHKLDXo+F4GkRXuf194ZUBQsmhyz1Lz
 zwLi8fOpevBmu3Ktq6AhPo8B0QDrlgacjj3TBo8zKWlhhhsjnaEM0Y9bA+83N0foHOnYXTI0=
X-Gm-Gg: AYBFou0GHjxNnxP8L8q8ASF5haHGsOkNfmzDnlJMf2IgRxbgOd2miCW+7+yL5kcMs/s
 M2YYAXbNGJ9IoIhnilM179BrQ3JFlT2L2R3XXwgB1g9GgjqT82yoCbEGAEZO8tr9+gGE5rGfrNx
 QGTF3Fbw4ICrjWCLclBSU8aIx0ZNCrsEsc0AVXX2CoZHi65YDhd6bNpVMfQX0s2u9rRYHK4lWZR
 2rJJylOLq0uUC7kyvM5HqxXheSkGTCTmHxJVx3ip7RAfjblIqhCfZEmsxTo4I+mb+RwA1VT+En5
 cH3jMH+hImr6C3rMT+i+XAK7RZ3nNPspLmd3ZHw6ybISkh/xMGBiNNonp33SP9jz8gK0JYbjzWq
 7/+Awj41/qfKJu2BFNApeiqWl2sD4PyZp4jCLZR51PDizPkM=
X-Received: by 2002:a05:701b:2403:b0:145:152:b547 with SMTP id
 a92af1059eb24-16a56ab0d40mr11460373c88.1.1791781719119; 
 Sun, 11 Oct 2026 22:08:39 -0700 (PDT)
X-Received: by 2002:a05:701b:2403:b0:145:152:b547 with SMTP id
 a92af1059eb24-16a56ab0d40mr11460347c88.1.1791781718521; 
 Sun, 11 Oct 2026 22:08:38 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2954bsm30362095eec.26.2026.10.11.22.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:08:38 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 abhilash.v@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v1 2/3] board: shikra: select SPL MMC boot source
Date: Sun, 11 Oct 2026 22:08:32 -0700
Message-Id: <20261012050833.1554624-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012050833.1554624-1-abhilash.v@oss.qualcomm.com>
References: <20261012050833.1554624-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DvgFXz7VoTEs0e2sVVawZ5eZhh9aVvaA
X-Proofpoint-GUID: DvgFXz7VoTEs0e2sVVawZ5eZhh9aVvaA
X-Authority-Analysis: v=2.4 cv=E6hYNqdl c=1 sm=1 tr=0 ts=6acc6b57 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=hAwZhLamoIMQkAxjX20A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMCBTYWx0ZWRfXzwsqsdBmLMw6
 J8xAnwEfCNEEr3afGzXEoz/gs1cenSXYrCEILBkaWwpZDXtPZR2x+pob7IEo0SYkbnS6HMPbJJJ
 kJuk1xgCjGqvL+3bItf72/MgHCLpIUDwlcVW/cD+WRkfgoUkMteSd+gcBi+32ZWBEsxwgWcmeDM
 lwEv4ISK0cmg2nj+cYhepjK+8tQXPu86LSfzco+nUGvQ34rA3OLIWTFbhDbWCHnPVbkiC+3gACT
 NzhxKFSqAVQnGmvJUknvjNgM8FS3HB1GYwuHHfGNbGG7y3wpNP/nrxtIhfwLbLrcnir7nLl/G3p
 gu7K0nIApi2OzoAV7G9uyB9JA0yIdIUQROu3dui5BZQvAIVx9HP4SYzw6tVMaIXQ9riUSLfbLPS
 iix5rPuUgTiw6OTxr9QeIyZjO3eriPTgxU74sRppVHg7IqgANjuC0+4wKgdmUrDKQQ7S3XQ2nos
 aDKsqnYaK53k4B6eI9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMCBTYWx0ZWRfX1KCNSGARnwtF
 RVdpLIJrlhOHbzj3bpFJqhASBVDyAd6OxbttWIgDdrKJitz+zq/q+0pWzGmhIYmB4HDEF5TGmGw
 4xLQznwbUZVAVftYVdvYk+sYzgeF88s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120020
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

Decode the PBL boot-configuration register once and
use it for MMC preparation, FIT partition lookup, and
SPL boot-device reporting.

Map eMMC to MMC1/sequence 0 and SD to MMC2/sequence 1.
When PBL selects SD, enable polling for that device because
SPL does not resolve the optional card-detect GPIO.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 board/qualcomm/shikra/spl-shikra.c | 99 ++++++++++++++++++------------
 1 file changed, 61 insertions(+), 38 deletions(-)

diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index 091a2a49e09..00952d7769a 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -149,6 +149,32 @@ enum {
 	IPQ_SPL_BOOTCFG_DEV_MAX
 };
 
+static int shikra_boot_device(int *mmc_seq)
+{
+	u8 boot_device_cfg;
+
+	boot_device_cfg =
+		(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
+		IPQ_SPL_BOOTCFG_DEV_SHFT;
+
+	switch (boot_device_cfg) {
+	case IPQ_SPL_BOOTCFG_DEV_MMC:
+		if (mmc_seq)
+			*mmc_seq = 0;
+		return BOOT_DEVICE_MMC1;
+	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
+		if (mmc_seq)
+			*mmc_seq = 1;
+		return BOOT_DEVICE_MMC2;
+	case IPQ_SPL_BOOTCFG_DEV_EDL:
+		return BOOT_DEVICE_USB;
+	case IPQ_SPL_BOOTCFG_DEV_NAND:
+		return BOOT_DEVICE_NAND;
+	default:
+		return -EINVAL;
+	}
+}
+
 #if defined(CONFIG_SPL_BUILD)
 /**
  * shikra_prepare_qup_clocks() - Enable QUP wrapper clocks.
@@ -197,23 +223,11 @@ static int shikra_prepare_boot_mmc(void)
 {
 	struct udevice *dev;
 	struct mmc *mmc;
-	u8 boot_device_cfg;
-	int seq, ret;
+	int boot_device, seq, ret;
 
-	boot_device_cfg =
-		(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
-		IPQ_SPL_BOOTCFG_DEV_SHFT;
-
-	switch (boot_device_cfg) {
-	case IPQ_SPL_BOOTCFG_DEV_MMC:
-		seq = 0;
-		break;
-	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
-		seq = 1;
-		break;
-	default:
-		return 0;
-	}
+	boot_device = shikra_boot_device(&seq);
+	if (boot_device != BOOT_DEVICE_MMC1 && boot_device != BOOT_DEVICE_MMC2)
+		return -ENODEV;
 
 	ret = uclass_get_device_by_seq(UCLASS_MMC, seq, &dev);
 	if (ret)
@@ -223,6 +237,13 @@ static int shikra_prepare_boot_mmc(void)
 	if (!mmc)
 		return -ENODEV;
 
+	/*
+	 * SPL cannot resolve the SD card-detect GPIO from its live device tree.
+	 * PBL selected this device as the boot source, so poll it for the card.
+	 */
+	if (boot_device == BOOT_DEVICE_MMC2)
+		((struct mmc_config *)mmc->cfg)->host_caps |= MMC_CAP_NEEDS_POLL;
+
 	return mmc_init(mmc);
 }
 
@@ -404,13 +425,20 @@ int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
 	struct blk_desc *desc;
 	struct disk_partition info;
-	int partition;
+	int mmc_seq, partition;
 
 	if (!IS_ENABLED(CONFIG_MMC))
 		return -ENOSYS;
 
+	/*
+	 * The MMC core selected @mmc from @boot_device.  Confirm that it is
+	 * the device PBL configured before searching it for the FIT partition.
+	 */
+	if (shikra_boot_device(&mmc_seq) != boot_device)
+		return -ENODEV;
+
 	desc = mmc_get_blk_desc(mmc);
-	if (!desc)
+	if (!desc || desc->devnum != mmc_seq)
 		return -ENODEV;
 
 	partition = part_get_info_by_name(desc, QCOM_SPL_FIT_IMG_PARTITION,
@@ -428,33 +456,28 @@ int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
  */
 u32 spl_boot_device(void)
 {
-	u8 boot_device_cfg =
-	(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
-	IPQ_SPL_BOOTCFG_DEV_SHFT;
-	u32 boot_device_smem;
+	int boot_device;
 
-	switch (boot_device_cfg) {
-	case IPQ_SPL_BOOTCFG_DEV_MMC:
-		boot_device_smem = BOOT_DEVICE_MMC1;
+	boot_device = shikra_boot_device(NULL);
+	if (boot_device < 0) {
+		pr_err("Invalid boot device configured\n");
+		return boot_device;
+	}
+
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
 		printf("Selected boot device: MMC\n");
 		break;
-	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
-		boot_device_smem = BOOT_DEVICE_MMC2;
+	case BOOT_DEVICE_MMC2:
 		printf("Selected boot device: SD MMC\n");
 		break;
-	case IPQ_SPL_BOOTCFG_DEV_EDL:
-		boot_device_smem = BOOT_DEVICE_USB;
-		printf("Selected boot device: SPI-NAND\n");
+	case BOOT_DEVICE_USB:
+		printf("Selected boot device: USB\n");
 		break;
-	case IPQ_SPL_BOOTCFG_DEV_NAND:
-		boot_device_smem = BOOT_DEVICE_NAND;
-		printf("Selected boot device: SPI-NAND\n");
+	case BOOT_DEVICE_NAND:
+		printf("Selected boot device: NAND\n");
 		break;
-	default:
-		pr_err("Invalid boot device configured: %d\n",
-		       boot_device_cfg);
-		return -EINVAL;
 	}
 
-	return boot_device_smem;
+	return boot_device;
 }
-- 
2.34.1

