Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2461ACA5FAB
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE44B81007;
	Wed, 30 Sep 2026 06:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hLpdjBLrQZnU; Wed, 30 Sep 2026 06:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 191F68102D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750123;
	b=S/Sp22E9YRfpmdOyBs7qxogXNP7Q5TtTIdGyNEZe3iz9dOmXfyq6ZLfr13Bvgonsiocz
	 2V2t40WiieXg5qGAEiL8gOLA8NmlN81UgS+//zkRVLx+HinJWejB2O822jm7TqUJiOKxk
	 twgWZkZtylZT+DJFYSjruPaA2IULF5yerbqEsMHpsCmvaS7GjzC1GTdeFtgG8O1fcA7tf
	 HMPiWR8JTqtN5zI8/tjZgmVczte2m5qDwu2S60cG9IA8h9mO2Bm2WTpZjKmCHdiY1KYiy
	 QKsjFgiXh1Vvnobm3kMxx1CQkPZqEzGrd6XReSgzxQPXJt32OoSFWA9bFH208ffeMuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750123;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HUEk/lK88BZhLN+JmNoD6V7EElU+fmTzH6h62AHalHU=;
	b=cw7rqZzAoe/YpEAUYv+R58xJjVuCtEEPDFdXYzOPEoBlsTQtKrKG4yERyg60S8CVgazP
	 QESgYBBZS2Kie3qYJ3j/QoQnfDmkUG3YGbBckLj9rtHRAnLRUgSY4LETluAHxlnXiPZB9
	 6oM47touA/l2MRfxuhrdGNAIwI8rk8P81e9KOD0KDOKkYPD77Q3VvSwWunmHsb1j4doAi
	 CCSfv4w8OJdGaowZ8OsQ1+QkZ5G2NrIS/FSK5xDu/zbdA2cPdcGoEEsRBX/WtziKb26oX
	 i6ogvAVOuvNSoY+SCVfcgz676VxJLWRPE0q2HXujn0Q/m8tZ3ua5bMJ4XxfuTmphGgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750123;
	bh=HUEk/lK88BZhLN+JmNoD6V7EElU+fmTzH6h62AHalHU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B/6fqLS7pXkdIIO6Ohd/7zqDemzdVRo06ykG04nhxDxyC8jNS8OIlPExij9lTYxNC
	 YeIDkZibabPzYZ6BfT/ixy9yWKIAWRcXZboGXS2FB4yRs8vqGLl4AJ9lkGMl7gNCSI
	 hPCNVON4yKCsVoiPLpwG9VFOPiCG8zvY2Y0NxxnXSUIYAStHC2IrUX4G5BJnl1jGsQ
	 2YAyE8fHfyUHvSAwt5XB7Lvlw4Nerct81+FD+jkfcIpzIRlrGS7NALRkvRlMv9X2yQ
	 Bf7edpudM++EH4PjwHD4K7Nh8U/97W1cb0H2k2mhPsVIncRa3c7EHj5cCDLCLLiYqA
	 NpF4pdLfq4sKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 191F68102D;
	Wed, 30 Sep 2026 06:35:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1675B3D8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFD0F6082E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P0gPJfQ85yHw for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C7503607E0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750114;
 b=IR2XFsiu9EvGm8Jbfv/Z4aB0H/PqMO6kEMnfgkkcDWupjGChgTANNz7EC/uHIRSYYg/4
 6Xrk+3NEW4B8a4RUNOMGyvktZcooa7jak+IbbCk0Zge+cL+Sr1papL9rcVOkRxRR7fD3H
 URb5tVJFfuc/8NMFpsIoJBVs6LyvkqgWcDtuVJF0GWHO4KY76z0exIwQ7Bpjj8hGSiSZk
 CPWPGDy15rXmRkiEEnWjkOO/I+u0a6OtsqX/u293zfGBd+L7XtdtkKOx1Yfd6MXFRFdUk
 W2EXFt2GRhuU75cqyfP9knrcAbkmlfUORQ9C+/8sg8EZm0HVRJMzPaJ7KVTtpIVjaog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750114;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=HUEk/lK88BZhLN+JmNoD6V7EElU+fmTzH6h62AHalHU=;
 b=VeVYOx9NEQzX2woiPW0NhZJ3SGeP7I/cn+PsxTeWTxlfYyiIegaxv8pVfCXjUb4fVSUt
 8AZXo+89wAkoWZsoKS+kTooLhGsz3GEOSzEmPx1xBkd8r8aiZ1E8u4bOihFLR/9GtAjNC
 r1xN4ud5Y5V7q4OwK+osmmJb24fZkB1W8cqdiE62rEKqOeaU6s/5Kx9toOKBlpYziD3Fz
 /IvAyGoqKRfZxltuFxuozCBURnVTp25tWCXMcqXdMhJL+AHTNwzmXrcuPfcFY+3SjPUJF
 ymHLOAY1Sp2FvhDkVYSz2ma7LoziiyLGpgVamKX700g0IO2FiwnUijFOeNTvFZqcKZg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="g5Wi/xS0"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VP3wwfrD; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=g5Wi/xS0; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VP3wwfrD
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7503607E0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:13 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6Eq6p2969038
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HUEk/lK88BZ
 hLN+JmNoD6V7EElU+fmTzH6h62AHalHU=; b=g5Wi/xS0Z6tdDQ6qHMimpv8cyEk
 6GJEOtOXVsKZfUjxEGWlPySMRPivg3BGWYIkxuomBLbmid0tgsPmsCmFnNa0N1uW
 HewS5fr0dZTNw4U7ZQ56Mtzyy8OL9cGPYF1G8sjxzIW5ZUQ6aNq42878q/QFIGhO
 w8zhRYkcaRH76NuFtDRpRcIdqDizvcvboGUZP8ACNblZMOKYvjrkmAYH8aDRTdAX
 lILol45+sAMnTIlPsoZlSIY6poP4CzjIVjFYwAltiO9FAEfIGgukpmcZp1M7GbH6
 JKe9R8nLZrZj5uFPyqN0HH8yklxSeTvQI43q6dPJXF6MSkuIolGXulH5WAQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0mfaa376-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34d18eee3dfso306278eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750112; x=1791354912;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HUEk/lK88BZhLN+JmNoD6V7EElU+fmTzH6h62AHalHU=;
 b=VP3wwfrDpVFZtwY75vjZip3wOcBoT2A1FPDZKXp2puzkDXg4ULrlcabICQU8vsHLvR
 T3Ei0RdwvZH0ML/MAh9BlgrDPW+TagIBRnqD8VLSCDkoPYOX42qSxofoeBf5HBwrb5Tm
 od86aAdPlnOtNg63dosyB2l0oNkY6CAQ7dDFiaJ+9SqFMkDZPtC3VrYtAv+Jo6kZi2VT
 tdIXiDs1ln76D5gZSbjODIcHV48KaaePjTQ27bG+AJ0SDSuPGS1iEttK3ZYrZ9NFhE0A
 YyrZc3FmJLAn42ow7XdJ8qR84qTkNF0xjUjgD3+XuVYRg1owRiSsqkXnwh8P5dg6maTP
 AfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750112; x=1791354912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HUEk/lK88BZhLN+JmNoD6V7EElU+fmTzH6h62AHalHU=;
 b=qvfg7AiemWRMEZ95+8WBJl0/T2G5RGy0b/M5wwdaA+k3b4qlmDOeX+QiuosXwu1fv1
 blZ8fanw6XCk7mUgZkMHmlqqvYYLrrOvBiS1aQ6LDBOfY5KXSz1hby7B78JoeuLXzG3m
 sSV4Wc22R7xvPb+7GnX6fTispyX9jW961G4pxAnmyhmdVRtOtOFoJj6IMw/bfOs84mQU
 RVrdeig82FXRhBTDomsA06Lo12y1yXnFP3StNC/a7DG8pCJfWV8sGpr8fweYsNbXEj87
 Up1bq5JUzkkpLrbmopm/xSYo8uuBRtjeNhqa8BoSVn+yUstIb17eYm0HGUTpX1VTscXW
 7kYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxofm68RvROI4Fzgxgp8rFXpcGq0x+fk5LpEBX/8Q5kuBqHLAqmL/5m7zGIuI3Z06X8I5LZa7g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI66Axz8ldG5pRhefQOOudcCTgtaOQ8R2bnZQXWrsucH90mSVzQ
 YNicAq2q41kyvewtN9wHoyLBlI/TxgI0YrO9aW8ELABWWZYMCOHrUFAqqxtuKu95w6y5KgVt17f
 RnBJXMnFtlGpUOXxbm6728yNkJ2xs/i6CMcGhUwCYA45tWVPkjF6NefEWiPP15UtphFhPDQE=
X-Gm-Gg: AYBFou0HPuAdFojpNbq+bscJTTkjmJWTLno7KeiawH7kmt/wHR1zIBu/KGApOT9Bh6c
 8h30SMqidMRXiUrcoI02JurzIJRzStLX8J9MeYkL1izoPc3QV8ZvuPObf7hmwh34ALiMqpDUOSU
 zsc/fNiYNUEk2c9nUsA/FTzmIe/pizpqWzKnFXCm2CZR6wnOy+6653GkAxUiRS0r1RidSzwY/FN
 /QWDw+2i1Tn8V/JaAwyCCNBjagxPe14caTOTkKNQszLliSMILiTAGq1gNlbkKFaYiqZmsDB8hT9
 wnK3/C7u+cBBwrNohe4GT9LOHjK0RHGm6dsMySZ7Pn4KNvUe1qoDNIq33VQkERsNZZ3Z/B5jvhi
 UNhRgafUOgSRmE3Ckodd2rtIsR/uf6TSQN2OKaaBDg+JDILJU
X-Received: by 2002:a05:7301:2624:b0:34c:7d49:35cd with SMTP id
 5a478bee46e88-34cdbbd5d9dmr829656eec.11.1790750112177; 
 Tue, 29 Sep 2026 23:35:12 -0700 (PDT)
X-Received: by 2002:a05:7301:2624:b0:34c:7d49:35cd with SMTP id
 5a478bee46e88-34cdbbd5d9dmr829442eec.11.1790750107050; 
 Tue, 29 Sep 2026 23:35:07 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:06 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 06/12] clk: qcom: configure Shikra GPLL6 for SDCC1
Date: Tue, 29 Sep 2026 23:34:43 -0700
Message-Id: <20260930063449.3251317-7-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
References: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX7etcJWb4xFjO
 XOewSJQI0Bpu/8TKclTSAZ0yT2Uwuhi5mFl5ykE7isLBEK78gm2PykhQoZoeAclmFiW23XQctiX
 OmfNqFa1mn7MR8gQB5t8TYVfTDdZRzy+lwRYYmGok3b97Zsa10dxnlHOINf6fv6RVH29GJPL6aX
 nzIiOEp7nR6l6lc1nDhkXMQgXbrGL6zc+GjWVWF4fDzo69rIz4ngX8pgn8e9zEE1N10sXizUIw9
 nV9hdrJLDHohj90DNXZPKNGwp+qLsf4tue7kKPxiTZAgmB1dFPQeAkIqQnAHKqChv6oXLnlM4uM
 +OK1OqvBnzNi28BsEQ+nDZRByNuwU1Rsw1ZTJjz0nmjhxJBUdFZBKkcjvhX1aJ5lUEUo2rGQe7I
 CIzJ8VKibGuVfcvzVmwpJGL+jJ4WomdEevQJVM+zG4/jG8jyF7Q7xgluyBIBbSD3g1zRRY4oBCF
 TFEZgVIBJwVsU9pqcoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX3RUeyGVDchOJ
 8Lm2XF431X608cWuE/9QKSRms2o/ngM/YNbKruzJniKltfRybGlG3R9E3lx4+j+DTy1IMrMLx9c
 U//DjV51daLTEYNoZ0uZoFcDcwDj/Uk=
X-Authority-Analysis: v=2.4 cv=RZEFmFtv c=1 sm=1 tr=0 ts=6abcada0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=OZbkP5GewEWn0qpCw8wA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 0BPiqmGCc3EcaCBmb83gjm9nrctVXcE7
X-Proofpoint-ORIG-GUID: 0BPiqmGCc3EcaCBmb83gjm9nrctVXcE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300026
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

Configure GPLL6 through the common FSM-voted PLL helper
when SDCC1 selects a GPLL6 clock source. This provides the
192 MHz and 384 MHz eMMC source clocks required by Shikra.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 61 ++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index a563e85cb02..9c803e6c181 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -20,11 +20,35 @@
 #define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
 #define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
 
+#define SHIKRA_GPLL6_MODE_REG			0x6000
+#define SHIKRA_GPLL6_ENA_VOTE_REG		0x79000
+#define SHIKRA_GPLL6_VOTE_BIT			BIT(6)
+#define SHIKRA_GPLL6_L_VAL			40
+#define SHIKRA_GPLL6_USER_CTL			0x01200109
+#define SHIKRA_GPLL6_USER_CTL_U		0x00000004
+#define SHIKRA_GPLL6_CONFIG_CTL		0x4001055b
+
+#define SHIKRA_PLL_MODE_ACTIVE_FLAG		BIT(30)
+#define SHIKRA_PLL_MODE_BIAS_COUNT		GENMASK(19, 14)
+#define SHIKRA_PLL_MODE_LOCK_COUNT		GENMASK(13, 8)
+#define SHIKRA_PLL_MODE_VOTE_FSM_ENA		BIT(20)
+#define SHIKRA_PLL_MODE_BIAS_COUNT_VAL	(0x6 << 14)
+
+#define SHIKRA_PLL_L_VAL_OFFSET		0x4
+#define SHIKRA_PLL_ALPHA_VAL_OFFSET		0x8
+#define SHIKRA_PLL_ALPHA_VAL_U_OFFSET		0xc
+#define SHIKRA_PLL_TEST_CTL_OFFSET		0x10
+#define SHIKRA_PLL_TEST_CTL_U_OFFSET		0x14
+#define SHIKRA_PLL_USER_CTL_OFFSET		0x18
+#define SHIKRA_PLL_USER_CTL_U_OFFSET		0x1c
+#define SHIKRA_PLL_CONFIG_CTL_OFFSET		0x20
+#define SHIKRA_PLL_LOCK_TIMEOUT_US		200
+
 static const struct pll_vote_clk gpll6_vote_clk = {
 	.status = 0x6024,
 	.status_bit = BIT(31),
-	.ena_vote = 0x79000,
-	.vote_bit = BIT(6),
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
 };
 
 static const struct pll_vote_clk gpll7_vote_clk = {
@@ -84,6 +108,29 @@ static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	{ }
 };
 
+/* GPLL6 configuration required by the SDCC1 clock in SPL. */
+static const struct pll_config gpll6_config = {
+	.mode_reg = SHIKRA_GPLL6_MODE_REG,
+	.ena_vote = SHIKRA_GPLL6_ENA_VOTE_REG,
+	.vote_bit = SHIKRA_GPLL6_VOTE_BIT,
+	.l_val = SHIKRA_GPLL6_L_VAL,
+	.alpha_val = 0x00000000,
+	.alpha_val_u = 0x00000000,
+	.user_ctl = SHIKRA_GPLL6_USER_CTL,
+	.user_ctl_u = SHIKRA_GPLL6_USER_CTL_U,
+	.config_ctl = SHIKRA_GPLL6_CONFIG_CTL,
+	.test_ctl = 0x00000000,
+	.test_ctl_u = 0x00000000,
+	.l_val_offset = SHIKRA_PLL_L_VAL_OFFSET,
+	.alpha_val_offset = SHIKRA_PLL_ALPHA_VAL_OFFSET,
+	.alpha_val_u_offset = SHIKRA_PLL_ALPHA_VAL_U_OFFSET,
+	.test_ctl_offset = SHIKRA_PLL_TEST_CTL_OFFSET,
+	.test_ctl_u_offset = SHIKRA_PLL_TEST_CTL_U_OFFSET,
+	.user_ctl_offset = SHIKRA_PLL_USER_CTL_OFFSET,
+	.user_ctl_u_offset = SHIKRA_PLL_USER_CTL_U_OFFSET,
+	.config_ctl_offset = SHIKRA_PLL_CONFIG_CTL_OFFSET,
+};
+
 static ulong shikra_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -91,20 +138,16 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_QUPV3_WRAP0_S0_CLK:
-		/*
-		 * ftbl_gcc_qupv3_wrap0_s0_clk_src[]'s last entry is
-		 * GPLL6-sourced; vote defensively even though this port's
-		 * only requested rate (debug_uart_clock, 14745600) resolves
-		 * to the GPLL0-sourced entry.
-		 */
+		/* The QUP clock table includes a GPLL6 source. */
 		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
 	case GCC_SDCC1_APPS_CLK:
-		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL6)
+			clk_configure_enable_pll(priv->base, &gpll6_config);
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
-- 
2.34.1

