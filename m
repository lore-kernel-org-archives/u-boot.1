Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDCBCA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 01:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24E38606B1;
	Fri,  9 Oct 2026 01:32:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F6N5FDwHtyGg; Fri,  9 Oct 2026 01:32:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60D146083D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791509559;
	b=NH0MQfEe5TwEerhU8LJbVhrraUSXIGp31wVDvJ3HcvOl4FJTeT4Cg9gxd1TKNe/b/ZuG
	 wfurlX3s0OxnBJriLwZ1Gh4wDe5bGAvL+lsOT7Yn7IGTaqcJLuxy5k4SLn6Ay4aldx4+S
	 z/dk5qO+iZJtodlvy6UNKeWoPO69Ub/fVpFrbMh4YgEsMAnG7PV6yxx1YaFDqBnrGY77V
	 SCL+b4ZJIVWbiw5Vte+9zR6rXuVgBydhlfpn15743bVOUwOJyALS9wkuF6E2SKrvmm4IQ
	 EMYt/CAkNRBg/TOcreLU05b8sLbeMPQ1UQGsoxNparBCG3kce5ap/pnPdcqBSQkmquw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791509559;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ou3QjVgHlJWh31sSyvzEQ+7P/UPVJhBMRURo6N6yCK0=;
	b=JoVbzxs7KEVMDJCC9ZC1lZfAKQZqvibBqFlzYrq2O+aSWDsbND25sErJeyo0O+a//54p
	 fOj2oC0cQrRtSiZ1al26EcXH6eWTHLXK2335dKseoBW/cF2X9/Grf+bbrMLCaFnUbZtqJ
	 9IsGHBQmdtt6hD5AY6K4dkO9K+g/JwU0cVfh4EzPA8o9mBOZhNVHO3oZR12XZupP/X6nz
	 eWLuWbRQNpn+7RKgKdz7U7QNwLwXBy6H3G92vPK6+cddqiIWvB6cLG+EM6lTuSFV5OUz0
	 T4UTcKd9HmKHT1PRfNRjILv2vFZNojBCNEDM8FMQK4KiAmgxl87FXOf9k15PYGanqEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FinPjDiK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h0sH2Oye;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791509559;
	bh=ou3QjVgHlJWh31sSyvzEQ+7P/UPVJhBMRURo6N6yCK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SgUKhp9xv/TNBaqbUa1BP/FvqjM0v8ibG3rZruFMLNnE5iwP1Cn9O2plavj1z9Ycr
	 GcT4LL2ixoH+Mef6osmVic0tTWY0H/qXw0Lxj8E31/pQ9GigxHoMKY+bBBTuKwcy4X
	 qR/JDkZ4XcP7iqQVFgdXJeWUcU0Q2JhIwUajMpyhD+5xVTxc27d5vBKQRRDKRYZWys
	 LAU2PXQW+ut/z3rLh/h44LlMPP6FMITNc4WJzIlQeeUHOMUVBBUh+MDvCIcOOVHtGD
	 64OFfg+rLoJDPjzOb7frG0AzTKmL7id9u0AFzubk/IBAvaGv4z24Pu0aHcfGu+aH9Y
	 o37+VBhOZAu2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60D146083D;
	Fri,  9 Oct 2026 01:32:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C9BE356
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4EDC6606B1
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CEK0Z4vj7Ayb for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 01:32:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC3A360674
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791509557;
 b=a3cHWebHsx6FLTAOfn1li8WnXnaX0oLbRwIov2r7JVk1asFPROAqM8oZrZj6/FQ6YvjH
 NmIuxiXLARyhObW66L1oNFczGXd2fEyFd9qD5rjZGJyQcpHbONdq/141PGTcGIToSeiFy
 QKkx+MfGA00Jk3wFAJFf/nb4GtLdw9T2dB96PwLQ5yR41HOxIVfsd8w3l2ZRhzgCKfg3J
 70c9vybpfsPMCh3exxLcbssrEbxGAbmlyKmmXm8NBOZmiZflpIVJmjwHvs+pmpj6siptt
 eTCs6ZdFjpRqX7095+k8ZJR2+sgWMXyTpOQSfcmZ5DyUPhj05mjJRCbMBoOOYl4d0yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791509557;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ou3QjVgHlJWh31sSyvzEQ+7P/UPVJhBMRURo6N6yCK0=;
 b=LkGu46kXR5MJbl9hXZLnlcIXW9kIvWoiWhRjp1o/ji5FVR/4B+sB2bSqa9FXdR9ZE7ca
 MFcNjxY0yJEGoyp1wGmAwR+ULUiSyCUBS8Ut64hMrTmW2EL/p5/aOQMG+Jw/ex9byMlrr
 rXiIL9eQWq4ECBHiqD6Ly2MENA02j5G0TUdXuZn9Gua2uayOLxSTvP7/+y2S8fA7Gu5pV
 SUPrSX7phVhhi6I59qmGcFXRO/6Yd7uOdv/ucqf76kMcsqsoumJB5C3RiJIRdmCv2hEkC
 hlMyOc59ujNWA75QmBUDyzJqFf+LD0d7XP/zoiAZdw/Fl2Dxx1MG0T6UupcTe27vfHw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=FinPjDiK; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h0sH2Oye; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=FinPjDiK; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h0sH2Oye
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC3A360674
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:32:37 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990PTf43813384
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 01:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ou3QjVgHlJWh31sSyvzEQ+7P/UPVJhBMRURo6N6yCK0=; b=FinPjDiKsHVnFSrm
 XEV3FQhMv35N1Kpp2tKFxcQwfhy3ApByJIFGZcSk67qhwfdPI5vGEI6PAKvQ9hxq
 Psl/1pXUmW3auVGNFeibTCK32DNDUWsk8vUh63pjrgacRRMOy88258iurpbOUK0q
 7fd78y67tZHTpmj0u31fD/k70Lez5fcKtif6zDL6TosdWHcp7HZRiX3GU3Uz8bbi
 8ccuvUVYbqkRbWCJCI2xcg5PmpJCWJHWeNEwxMuQRMPa4TrqsOo0pKVY9sDBBPPv
 sriWkLVPeKYbNdNbJrkhGmVDd1YhYzWITnLtrsJsBO9wYbhCi/4/pegEex3yKIk/
 Fe3c+g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrsbw6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 01:32:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-313d1015161so16849656eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 18:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791509556; x=1792114356;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ou3QjVgHlJWh31sSyvzEQ+7P/UPVJhBMRURo6N6yCK0=;
 b=h0sH2OyeS5T8hA9ky1R2MqLJ1tDlJDDRiu2JEoAxTme99PgUGMygZq3FoINYbc7fT5
 Gtss3ReunSNY4CaAtHHF3PzVNv2hZ2fcSwItpU2bAlYQUpn8D9vK08AcvURzaygwD+6V
 MO8VlNVCXL6L5WS3gee00P8RfbdAStkysvXV0MOldhOaFL/xQ5FGXNFoZr5Bw7darF3D
 qzljAq5Q1L5WM5fuKL+M2FqeWu0HrmBsvljtW9OV6HokwMX9ax75UDSekfHPWGrpWh+H
 ActEZ1L4TsI3qcJP7xRPPKQVXfi1X7vfBMZfbY5dSONz+JHXkIbrCBlLaxfAOZaba684
 ZuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791509556; x=1792114356;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ou3QjVgHlJWh31sSyvzEQ+7P/UPVJhBMRURo6N6yCK0=;
 b=zD0FzciEef5EoqIDKS/HWLviNLqTTzBscI0sVunp54jK7OBvCxbZ5kKfJKll48axKd
 81ZAS0h2662b/Q3sDXuaE5/PqUR6+4HNd0MXdnHaz6LuZelTakZIpyh/Pa+dg2mRlDWr
 Yj702Q1xrunks5I9mILZAxxitlVnAIuJVIcvtNdRJdhsKe+zsNNdEDGb4ge63oS9KjOP
 8SeSf8IAhioCcktsM3g1HaLUCrKcRjAdsQMKCVgypFrPKK5ux1rVuaZ49yu9/OswSjw0
 lN49i/j1tbcHHtDSCmfAnUZ00pUCE+9swaE6wYD42fazIwgFPV0tTWF+tx3EJy3HPUBM
 DfKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBySbF120LDQWG3FjpCDWX5UQU40nJoDhyp+BuJfC0THUEqqmUWieX3DMXWY3K7rvb+E8LAZQCc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKu4vE1ecLPmzpfhAmSGv4zO6JQgRKR8MJvS9SHcJaHCYTnoUXR
 4jV2RYZOEzzNKnR1iEBj3h098sEagcYmPqmR49mmgWzwI++2nhKCfv753kymlCn9HzNexffQfXm
 zBpBqlQnpnY9QTxst3foL+uOhw5q99EpgSfz//vQlsZs2MF6vi6W7APVFScsIAaj6Z2HKEi8=
X-Gm-Gg: AYBFou0BhGC3oHYwwZIfEy+mls/ebskRdqnxtM64JwiOJDgPWQ3KWuFZtpGtEjd0+B7
 jvHda1anVrYEsGpKo1GJDrEzeQw88O3nfuwEd3UJfYzyIfj6idNdUEgAc+orKoYcYfqWczGbUsz
 N7BRfzeMzpg760+4M/nXJrsguU8gID2wbTH+IPYSVFyif2r96feB+welbZHhn/SltDf6p+zm4Re
 FNpiM4uxDbsQbCsAJNG9OhOwj2+RDd8dhNOXS5YEtsBN30dGEJyf+I7zVEhGi847d/cXDZKMjjL
 0XvW/3vS4M/VHcQFmHQG1T7uwiK/D9gF9XR7YhL35QIETC7uUc40In+NEH2PW0SdndPsNBjWS91
 BLcWhFCEKlR6w0TFaUlMzJhvKT1C7FFVamu6AvqU6Dn6Kz/xNDEL9dxZaBephS1ne2tytWuAU3A
 JvhPJO8jc8+TrQPVrE5vcBFqPhWt9M
X-Received: by 2002:a05:693c:8381:10b0:34b:c18d:c290 with SMTP id
 5a478bee46e88-3537e059955mr821217eec.15.1791509555922; 
 Thu, 08 Oct 2026 18:32:35 -0700 (PDT)
X-Received: by 2002:a05:693c:8381:10b0:34b:c18d:c290 with SMTP id
 5a478bee46e88-3537e059955mr821178eec.15.1791509555268; 
 Thu, 08 Oct 2026 18:32:35 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm1950600eec.17.2026.10.08.18.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 18:32:34 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 07:02:24 +0530
Subject: [PATCH v2 2/2] qcom: qcs615: store environment in eMMC logfs partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-talos_mmc-v2-2-5d01c3428bee@oss.qualcomm.com>
References: <20261009-talos_mmc-v2-0-5d01c3428bee@oss.qualcomm.com>
In-Reply-To: <20261009-talos_mmc-v2-0-5d01c3428bee@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791509544; l=982;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Lcfp+AzipdLraEPJ37YcMnrTqXFyZ7OliVAKwDQS6Lk=;
 b=5+oJ1t6xMaEE81PdIK8lIUFAwzIfnmJqfzSrnLUUmh74OtLrpjlfkO7DGXT6LKMh0beVTk5ly
 A0TFbd6UAe3CEaxh7xPFS41C1v5/0i2LVvq6rL8cdaAdvM3SpR0tEdy
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac84434 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=lVVytI09pit5tGijhQcA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dCxzX9iLJrZ69eDcXz_ceUgU7YVAXVet
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwNSBTYWx0ZWRfX4UmImw5meUdI
 wMuZ9uRLYIoIm253pVvYK+tYJWBSZrlE7vyiBCOJS71MwrdvMIeuJNiLD4XfAwJxET1WqNm7OJl
 6SVdUi3med/sNj5/UcbOeaxIDxSc63AtUtswM9ABaLAvjKdf9RvvZxQI1J0CAK6/Obh/CY+NbM2
 hebrpbfleBgo1LErk/lR2+5rPCr7fe4QobxT4qDlntEaoXoZoIaOzLKWRo1Xucthx7WwgXDFPNF
 MtF5YYVfMF+RUKFpKMalp8oYV0hLbKdRIFY4Yqa5y3gK1uC0icloXdvogUhry2R+GzqMcPu8cfv
 RSXWjDhKC3RPLcTjNRBQV6fWvu4kaYPPQageVPEKa0H/IdgPyKjiq3pvkGLl+EsQtoe4tx4lbAS
 ueHaM3dRlX7QnaUR3+ryqN7zMuSeOm1mdd048PojspmzupXeRx2vogAhMfzcNh+vKY2scUlg04f
 qJ02gpWxYn1MLC1Tulw==
X-Proofpoint-ORIG-GUID: dCxzX9iLJrZ69eDcXz_ceUgU7YVAXVet
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwNSBTYWx0ZWRfX4IZ+A/VskDcm
 fvtWXZD/qams/m5xYfDvCBIubyZ4iKy+Zp+hQqcMXijG6TFkK1T/lRDQQZPz7J42qQedFslaSBP
 9hbb5d8dWIVxM42pMrbyeT2OBimi5l4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090005
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

Configure QCS615 to store the U-Boot environment in eMMC using
a software-defined partition.

The environment is placed in the logfs partition.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs615_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index a0aa019316c..a08c8eef186 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -30,3 +30,10 @@ CONFIG_WATCHDOG_AUTOSTART=y
 # QCS615 has eMMC only, not UFS/SCSI - override qcom_defconfig settings
 CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
 CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0
+
+# Environment stored in eMMC logfs partition
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_MMC_USE_SW_PARTITION=y
+CONFIG_ENV_MMC_SW_PARTITION="logfs"
+CONFIG_ENV_OFFSET=0x0
+CONFIG_ENV_SIZE=0x4000

-- 
2.34.1

