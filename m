Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129E7C98318
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 02:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D310B81277;
	Fri, 25 Sep 2026 02:41:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PGx9pNDLlnob; Fri, 25 Sep 2026 02:41:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0EDBE812B5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790304111;
	b=n6De7HbsAwO1+AFhQ0tq1Dhn7fwTuuwLp4r3Y4ZF3MF1YDdYRdSYTOzmEFF/dcAQfuF7
	 +Kv9vzxUNom3WtUr7sXPnw5xj5sB2VmK9crkMEx+xEXwfoqp6Y6uJdmX97FyHmSLp6DSb
	 2KF2QI8GmQpg306ug6usEVRzBJPx+b6Qv+qpy5/9ZNgGzFJPfSXgDYJH8GdUtbo2ZCN1s
	 RDceLw1a/5exdquS+CuvI1w7SRe7P5m6mUVePOEJFGqkENAXw8sNsrQL6iN34inPIiSLr
	 1sQYVNwpc3e1H34ukq6JhTRZtyD1mJQeweE8mBoIyqZ/QamZmDB/o1ArGdq157/S4Qw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790304111;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=k1PUxr6Y+2b+rYVqX1eNWP10mW/+XsqEyrkNooA4RNc=;
	b=ZbpdPZZ+/LpRI8cRxlwVP+sn7qMoie23DFRXUweo+ZQ3g2Zzuwz6IukE0E+F/R79tjW2
	 7hkc3mW1odhYLhJLAhy/Bh6nJWcBtil2IRfOIext4ZGhqANKlET9v6I0u67l28+2utvPY
	 LdbZqCu19CotJyAAIyLFs2Cq2/I9uAs6Fd2/QoPOQXAF/vXcxzX8RUGCkS4eRC2wXT3NZ
	 fz4+qKdCbyaGhqeMTSqGCrIox36kzg0qp09qVtDsz13dVKq3QvfYvKNC6+8SsNo8XTQOP
	 rVYjNgC9KdQzSXrRjIXNcj2Z9lNngzPtgMD+HULnbe71/E2OLDgbGDOXAIUBXHJpKdw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790304111;
	bh=k1PUxr6Y+2b+rYVqX1eNWP10mW/+XsqEyrkNooA4RNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BqET7VXpe9VfxjzuY+G/1oxlsIKwb/UKw/CgevTMgsBqOL5NKGDG0ij8dFsleq1Rw
	 cAS3/4mc8QN/JKL6G1T9ABIdtxkfYimqnASG1gHhVLNWnxbl9lm9XlCv159YCGknNG
	 SZQJ7PFa01x4GarGt9hFDF4/uc6Rt/4NY/mH8+gbRvC+7VyDbg7snMWOGedUltN9K5
	 rEegh/T28ncpmZKZ/fwbiEZWoe5TvOMCD0NSa15PsqlsG6Qs6/GyGFmkQ+u0OQCt5s
	 VSPTfmfeAtT5k6LvfovHMNcb9AlZgmYoGmXGyQpP/vrvCypo+6vxf71DKF/yxboMrx
	 1nvU6bfeWnNEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EDBE812B5;
	Fri, 25 Sep 2026 02:41:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F183E329
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2E7360BCA
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tORL7e-prdBP for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 23:38:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DF64D60BC7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790293099;
 b=TYbZpWG1dLCdy6mzBTzpofT7bprDO6lk+KFP5Ycv/CVEgWLToH5veNxO1jpFk3YubhkF
 pIrhw8b5W7zNfHW1kyLfaZmQ98b6uJkYg7ydPxt3P/z8KZAEAEqFqY8misk/DjWF7I3R0
 PskVBSCy2DrzFrQQ+2rRZwXjf5Z6lPML9ROczbxj0nE7OXmdZvUoBczhG4XVNqM+k4Tn7
 Ee0hWuxVxYQ0+em06C2WSg1uU4e9FNDZJ4dEBnw8fe8iHQKiP2lS3I0D3RdMic+8au3Em
 ofg/asl2OQjvLgwuyhTtGIRQuv1yLz5WRjRlxWbw6+RhB8p2rEJ2iQS2IBOTfMchzlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790293099;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=k1PUxr6Y+2b+rYVqX1eNWP10mW/+XsqEyrkNooA4RNc=;
 b=tejFcZM8+//hWCXi3bq/5Sg+Mc2q//ildRlTcgH6Jw5nlQIwcTRFq2o+CHb9WrPKqneD
 H6eBLTuf3XZbnjOVKzwsUx1HHm810VMeGUr12dQ0X54Sxdh8ih9LeaSBr6niV1/cRpKqp
 SVlMH0+ftSAjSkkYKoYWWzKhd3JHefB9Cy2l0OZIjG6f5pNNoVjr8do/HfGy2Od0Bc4b9
 xF1n4gAOvEVjqYkKUndom86/naCmp1cEp3MOIdvmNk+q+vdrpH8ip+8vDBnAMTr5PMhwU
 LMWzs+ZgKR0z5HQfIvYLKHl0gYtrvj9wveAzGVh37x0ur5zp+FSma5nwbFT+FIPJBzg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jaaBriQ6; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZIsdk6Df; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=jaaBriQ6; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZIsdk6Df
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF64D60BC7
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:18 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OMOvCK280386
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k1PUxr6Y+2b+rYVqX1eNWP10mW/+XsqEyrkNooA4RNc=; b=jaaBriQ6EvYbKMtT
 KEU/N7+mgFmY8GiMmUwwRONISc+mFbVlLn1oqiOep1jUDBG4K7+mto7oewB54Z+1
 wU6oKAi4L9PrwB8dTv9Nn534xEZUs0+vMGQdT2f89O2sHruey6kYEr9YD/rTpy9H
 EU1geGJfxhVkCKiMDtXs0wVq2o8eigsf9EMmsEgisj2aJsI8wtO1b8DBjQvWV0OW
 p6kCJtZ3KlKCgXGGejdPmzPBv1iypvDVuhjrktFBG8h8keDGOY7LYJrclg7F278Y
 0QZdrnOibqCadKzme5gQqWMhPv4x6NQiFhZHmdw5T+DwkaBg0pID8UGFt0+vz72U
 bFG7pw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7871j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:14 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-88e06764219so6022967b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790293094; x=1790897894;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k1PUxr6Y+2b+rYVqX1eNWP10mW/+XsqEyrkNooA4RNc=;
 b=ZIsdk6DfWtfF4zF2NzZusQ6mx4D3RwTPZaBynXGj0bLpfQrDRH4LOpKq4juuouEhup
 mO4Lx7lK0t9WyC93rLvehdbHDj9or5iARAQ0ZMedr/Fa+U/FQOh76WarYAZn1+LKd2U0
 2/AeKBL/eKBhr2wRd7AKFgUn21WI9uZUtMMj+8nTK8wF5RmHD/9j/ml9oEHfJTmKgbp+
 44avJB22L6oA18ZXdWfbBEeOZhIMfvng+77a1Z+zRfZtvHlbHBsv7MFCHdsHxbvIey2y
 rcOs4eIVVYjfHAxoqitMSMuE+Z1bRE8s9sMFA2/KQ6yCzBrbbZiXoV9HkDvToBp0uYwN
 2IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790293094; x=1790897894;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k1PUxr6Y+2b+rYVqX1eNWP10mW/+XsqEyrkNooA4RNc=;
 b=dbTqnKQDYBcZZNNtE+2PyuWPLwc+qaGKZuHLzW+ZUfOgckcHtzsiXfgaYs8Kr9JOv3
 8fFgGMctB0hzAGyIRCUU9s6rcecpVYvkD5qqEVk0DUsHiSDzZ93zdmlkgDLXR4ODKX3R
 jsECZS+7gnSVGTM/ghUDJUVJc/FUJvihdqPL2tTMgG9AyCNVHl2MC0OU8CEYJPYlTwh7
 yyodS5Etr+fVRCbqzJMWf2qb2i6NVLY06HIQLiaOpspZIdqF/D2xw26UQyyTQZfz5+Vn
 m9KspITnZogWlAlGyi0fBX2xkYknssflPLpMdXTDDYOLLrjueWGbj54mFwvwZKIhfI+X
 IFpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0tvSABmp8uloesVWPdwnbR+1MC5FD+3OHhg85hpqqNFbv/QXU0xkRMOqI6FaxYqv3o25Cqjg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kWSBYEd4rvbENJwb77qNkG8DP0lvE1jW8eg1SdmcZpFxnppCav
 t0g7N9dWTpbEMd3Iwu/i78pTlhWq/Z/DUK+CkO1Tp4xaNKWB29/S2F9K8l81xJH1OiXsP7yDaCi
 JQpmrp3vd5RsIRQtiK6hHujBUTxzfzV9Y2f0tzXZCJY8HA8FWQzzdYPPeje4qm0SmZIwQjN4=
X-Gm-Gg: AYBFou0KxV1AO7NFJfBpwtI+NCJiVIipbbx/PShtuwTAVedTn2goMhEZGWgHgk6XYHF
 /QeehIVWlkHsgvsglc+JB9NHCmS5O3H17A0HXFznjrcEYn6Kua7zFqVnq1Yj0g5Oh751FPLKCVo
 xt5ioAoFn7J6OuuwTUZvSdJQffuJpHcGvXPlSetHtCapIMUfW/+rCUxwapEvld55hnwIfgJC9oh
 g1b3cCGQ0HgFgIy08WK+YCGH9JDAAa8U2/UkFKkd0ZJykKlop9N297WTQkapnqtYyfwGC7gVqC1
 nUC4hRcVL/zVibQ3DYaty/IOeFzdudTgvoKoML2Sn0qcnFbHhDXlto+GYXuQqK036QvvXTHisPP
 /ctgtqXL0JUvquSruLaIghE0QSVQ5Y1LIe0wPX0QwxU1ExiV5lpCuvT5fNdeOaw2VoESLTn0k
X-Received: by 2002:a05:690c:ec7:b0:864:6fab:adff with SMTP id
 00721157ae682-8a64c34310dmr20005177b3.14.1790293093892; 
 Thu, 24 Sep 2026 16:38:13 -0700 (PDT)
X-Received: by 2002:a05:690c:ec7:b0:864:6fab:adff with SMTP id
 00721157ae682-8a64c34310dmr20005087b3.14.1790293093416; 
 Thu, 24 Sep 2026 16:38:13 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860325fbesm3025817b3.5.2026.09.24.16.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 16:38:12 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 19:38:08 -0400
Subject: [PATCH 7/7] doc: board: qualcomm: document the Arduino VENTUNO Q
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-monaco-ventuno-q-v1-7-290b6a4d10c0@oss.qualcomm.com>
References: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
In-Reply-To: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
To: Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
X-Mailer: b4 0.16.0
X-Proofpoint-GUID: DJVqlH8bGHe5ETiBHRfr2nAT8IhjNK9o
X-Proofpoint-ORIG-GUID: DJVqlH8bGHe5ETiBHRfr2nAT8IhjNK9o
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab5b466 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=wc1G-8gzH6XItzunGAkA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX71VtI3Vxi7Rf
 H3nkD3D9uPMxEdw0H/ZbQoGP3bkcerUu4EFAdEUN5RSOWjR/4ZolISMKWps/zVJe3D1FYNPHExB
 /QGxFhEzzdZ4FNB3uMghrU4K8qqko0lYh3/uykxtUw4iAYraqNgUxZGc5KlUKAdOAN6bkxYw0nF
 o8He3SJguT0b0BdCacuVg0rb05QCzOHe5mgPD5y5yRpFr0h8k2MSheJPCBcVCZXqxAuCR5eG3wR
 Vlnt3M68C2de931gYAg1qUho5zy2vxezhgmzGxJ42eSqYXkZ2jhuiC5dp6qYoc3RCdIEvoPuRLU
 /rv++4XArzcIj4XdsobBZMPPtJgddGytcPwzyn0/ZEn93oDp2FQ/q8m27cuHmcayZ8ZDAKGa9tb
 kt9RqTfM2+g9cZkExRFoIuOqqNUQINs/K0gy7uQYz16+30dtr2YGK/4laUj8XyiRyzo34XhIxF0
 yd8l8DFYyuo6i6VODHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX29lo8qdZv3Z6
 wSiVZAB2KLNy/QtoubekoPehS6LxnUjdaKUhV1mFNCKkNbLsJIoMrjoonsnumhycLNpZYusgqF0
 nAUreIB4p2JQqJ00A33yXcSbYkgymcs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240096
X-Mailman-Approved-At: Fri, 25 Sep 2026 02:41:35 +0000
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

Describe how to build U-Boot for the Arduino VENTUNO Q as BL33 of TF-A
and OP-TEE, how the boot moves to a Cortex-A55 core, the memory layout
and how to flash and boot a UKI. Add a MAINTAINERS entry for the board.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
 board/qualcomm/MAINTAINERS       |  7 ++++++
 doc/board/qualcomm/index.rst     |  1 +
 doc/board/qualcomm/ventuno-q.rst | 53 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
index 3767a2a794..85c92f4007 100644
--- a/board/qualcomm/MAINTAINERS
+++ b/board/qualcomm/MAINTAINERS
@@ -1,6 +1,13 @@
 # This MAINTAINERS file is for folks with an interest in a particular platform
 # or board under ARM SNAPDRAGON
 
+ARDUINO VENTUNO Q
+M:	Tyler Baker <tyler.baker@oss.qualcomm.com>
+S:	Maintained
+F:	arch/arm/dts/monaco-arduino-monza-u-boot.dtsi
+F:	board/qualcomm/arduino-ventuno-q.config
+F:	doc/board/qualcomm/ventuno-q.rst
+
 QUALCOMM DRAGONWING QCS615
 M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
 S:	Maintained
diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 56b8d894c2..85b01f7bf6 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -13,6 +13,7 @@ Qualcomm
    rb3gen2
    rubikpi3
    iq8
+   ventuno-q
    phones
    rdp
    signing
diff --git a/doc/board/qualcomm/ventuno-q.rst b/doc/board/qualcomm/ventuno-q.rst
new file mode 100644
index 0000000000..80d76f1f99
--- /dev/null
+++ b/doc/board/qualcomm/ventuno-q.rst
@@ -0,0 +1,53 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. sectionauthor:: Tyler Baker <tyler.baker@oss.qualcomm.com>
+
+Arduino VENTUNO Q
+=================
+
+The Arduino VENTUNO Q is built around the Qualcomm QCS8275 (Monaco) SoC, with
+four Cortex-A78C and four Cortex-A55 cores, and boots from eMMC.
+
+These instructions cover U-Boot as the BL33 payload of an open TF-A and OP-TEE
+boot chain, where XBL loads TF-A BL2 from the ``tz`` partition and the FIP
+from the ``uefi`` partition. TF-A support is described in the TF-A
+documentation (``docs/plat/qti/monza.rst``).
+
+Boot CPU
+--------
+
+XBL and TF-A enter U-Boot on CPU0, a Cortex-A78C. The Cortex-A78C cores have
+pointer authentication and the Cortex-A55 cores do not, and Linux only brings
+up CPUs that match its boot CPU in that respect. With
+``CONFIG_BOOT0_QCOM_BOOT_CPU`` U-Boot powers on the first Cortex-A55 (MPIDR
+``0x10000``) at its entry point with PSCI ``CPU_ON`` and turns CPU0 off, so
+U-Boot and Linux run on the Cortex-A55 and all eight CPUs come online.
+
+Memory
+------
+
+SMEM describes all of DDR, including the regions the boot firmware keeps for
+itself (SAIL, the SAIL mailboxes, the pIMEM vault with the trusted
+applications, CPUCP firmware). ``monaco-arduino-monza-u-boot.dtsi`` gives U-Boot
+a memory map that leaves them out, so the OS never uses them as RAM.
+
+Building
+--------
+
+Build U-Boot with the TF-A/OP-TEE and board configuration fragments::
+
+  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+  $ make qcom_defconfig tfa-optee.config arduino-ventuno-q.config
+  $ make -j8
+
+Then pass ``u-boot.bin`` to the TF-A build as ``BL33`` and turn the resulting
+``fip.bin`` into ``fip.elf`` as described in the TF-A documentation.
+
+Flashing
+--------
+
+Put the board in EDL mode and write the FIP to both ``uefi`` slots with
+`qdl <https://github.com/linux-msm/qdl>`_ and the board's eMMC firehose
+programmer::
+
+  $ qdl --storage emmc prog_firehose_ddr.elf \
+      write uefi_a fip.elf write uefi_b fip.elf

-- 
2.47.3

