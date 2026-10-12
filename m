Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC449CA9ED5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B51EC60735;
	Mon, 12 Oct 2026 05:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q0xxD8SjK6MK; Mon, 12 Oct 2026 05:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B4B160710
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783326;
	b=HwC5APrp8HcWgjzGnuOLPIwfjOW0XB4lv3cyWD4FkrCdIAIkNZt9jVcqI7FD7Q0FRECm
	 zfT0U3KMDLs4XuZO9y1j1B1b0P3m9fgb3mzi+5Zodg8rSN20cjMjBYbwQ7iwK828DYHiG
	 hHPa7pKyZzlveLfBw4+22nVwD9mKflWuuWORpTq1vLKDgcCXkGk/kcfNNaU7O6jZnp26Y
	 tCZBClpwQ7EXm9I/jlpWvA7syKJHeSr6oEfzZB2/OfDfxaBYxTrG3xtlmpKGXGKJIk8pe
	 UmXd9OD1/gFjREGv31hTKn96ErmLhh0tsbGR0FB8gqzMqGc/yyF6/Us9lDdZ26OAotQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783326;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IFVnXQo80f/oWKnjVQM3A8d/WKjvIMMVEN9hv3O2eEE=;
	b=NEe1JLJNKCQUO8+CeRD2fbzQ2uWrESccVKuqg006Dtw94Q2PnhiL3qrhBrcnjX+keeMT
	 DdrNRSoUNuWN+ZxxyjFglGns/5OsOV4GZ0XVsWzeau9tL5jf4VQmCL6Rx4P8cS6Fz90g/
	 1pFLfJnynkSFBdfkz5as4TvWBaB5q5uIsA/GeRFQANnUeregHHkrf6X5FiHP7pYLpQssf
	 7tNye2ffWGFEYj3OXx18i8hOsWDVktltqLgW4YhU1NfFh7238JpaneeLyl/vZ50yBKzKy
	 901ANDzgJOtziQHHCEPAf0U4pKblTYmrGq3QTFc+I25wH9jBfl8DwG7sYU0ljSN+l5w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783326;
	bh=IFVnXQo80f/oWKnjVQM3A8d/WKjvIMMVEN9hv3O2eEE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MiPRhsxXvk1GGYFvPDwKCvSDViK7KYA36GQ1umWxfIQnUd25TFQ1QrS8MNsoJVljx
	 CNpFxKrguepIAMPRe7e9tbSDl63/d1S3td4uDnGBUt78k0b9VlSQ210SP+S58GsIHb
	 EDuMBVsXviSqBafhSX5vgSp9dHbYmWSrzkQMEGjakkN9m+t6RQYDcz1DMohmYu+qMT
	 C14Nhsrua5HC5iJF8ty24Wot+JNqkwbd3LMujcYMaqeGP3M11PhNNNcs/SMRagGaex
	 ObnU7x9YcwudC0G0FlYpsIaw6+erMkcY/pQbsBRmqPoJM4CWriCwWklZMZmf+/qLpv
	 Fqz/Hqh/66R0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B4B160710;
	Mon, 12 Oct 2026 05:35:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 62B6A1DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47284400A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L_hW_rdORdqh for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 62EC74002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783309;
 b=Dnj4FwzZYZ/+jHrPIH9+VmqwHcgZADQk6ut0UKE7FGwawfjC6Zg0bqgFnoDBx/T1vghP
 Tsvc2xLgG/NBdvZagO9dy4GFdS3dxslhhkLhknqlCT8mwFFA+zxxLbwv5T3GC4d5Ylfeo
 phcOgfjt315qJpzNl7MavFNWiqIEF4+8u6G3lZnmo3nmzoHNY1Ra7wrWcyuFhCfcnng8Y
 8G8R+J2lXQUfqt+pCGLiEmdD9oHk5IMKBcO+M95KkUrmYK3WU+HzFdp/PTYxrzwCBTAHh
 UXGiSzNFaa4YV8m7JIHNVQ3o+phQr+t286UtAOW1JKPkP+gHJEgFKoxwVueHGhG8yww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783309;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=IFVnXQo80f/oWKnjVQM3A8d/WKjvIMMVEN9hv3O2eEE=;
 b=kwaDbYUdxABsdyx6D/sarZwNy44bIuqyFSu5B1wZdOAxR2AwkKuTJW3jd5KHvEE3x4Rs
 V5nR6lkZf0bGP33wYJ1Hyha/Yr2ChNplLET/xsgcUx6YPwZDYptQsJuN7E/8KG4ngjHyX
 5qgxOGWmijYECGHQGypsc4isPAfh7cjXafjyuV9ss3mO6SxI958glBnatvBZRSV+gNayS
 vhPK2eMnircseRJlEqvfv6iiN8gy5ilMHNrt9wNMKfsrbRsbhhsMV85fHSmvfPtjMzaYv
 0LD8dw6LsN9XtAcElLxm7gVib4Vttf5/YExBjvvvWPdg+nEyDWBUNZHlHLQjI25CT5g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=I9OlGmGV; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ePCOnQEN; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=I9OlGmGV; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ePCOnQEN
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62EC74002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:08 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C5670N1002377
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IFVnXQo80f/
 oWKnjVQM3A8d/WKjvIMMVEN9hv3O2eEE=; b=I9OlGmGVm78C0XCmFlPtW9UhoGi
 ylLvdD/XvjuNTw3zlr5+FsZ9opQn4CVCh5LCU237agnIs9Mp4JiUR5+dJI/fIwPZ
 2A1AVqE8vNJapexUkwXn09u5hj2mZX77AGBW1XTqQdmZVaAmY0QQd7ognC/WApz7
 SpSqG+GXspGnCrDI8mx+zo8bSkyqnV2WI+t0ApmL8ASGljkuwIajccFBAxbS4/Tl
 C2EXnBxQQgqZR/BXjL/ZO+Gg3jYT2bUgcEem0v712weHcBe0p1M1XqAHVeBupHG9
 fFENTxh8ia+TSg7bV3BL23oxsm3xQpJZmPHNA9m4TRmqj8/HwJQJ2QUMKTg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkgam4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:07 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso3306650eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783307; x=1792388107;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IFVnXQo80f/oWKnjVQM3A8d/WKjvIMMVEN9hv3O2eEE=;
 b=ePCOnQEN6Y/SqVErrdAF+xN6wq/2buLptoMTiy2Pc5KHP1PzAk2HMa9rFw2CKtv7O9
 d0V6gVNAC+l2rtvFnQut301faFJsSGabV19bk/42aE0qHg6rwP9f3nsECdK4kl+i9A7x
 jkQ8+QjVlOvXRjHV7j6BtAFzF3WqybKPHfcDaMUITvYS5q2vK/8WDSPF7lqVLWsUt0lN
 xut6T3RnM/ICSA9neKXAXiASmZliUrFPBLtGCa6XwrBSyXvA0lANwPucrBQ4OYZs/JMa
 /ryVYx8a0/UNEHZEO+tdPYu1ybkxd5VBLKNoznk8pYW9RBFlfGtOwcsjNn1ghmuk3cbG
 +8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783307; x=1792388107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IFVnXQo80f/oWKnjVQM3A8d/WKjvIMMVEN9hv3O2eEE=;
 b=EgetyZE5e/FH2VFGkreluKDb/rlPAADpMGOiSS5UIT64u3+OKF/3HU6hE7XYAuiQ5u
 zn2F3oAYj5Ftl2JWiP1xEHze+RhlSVzliwosJr19+lva7RiNx2L3NdRqDwnXJSfEJSPs
 XeSUf4eQIFePwR3X67dpDk77JMX8dQmMk9lt3AIeh/rPa+ptEwZYCc2H1iy1pp2ppRfo
 D2WHdl4xgZEzVI37w4NQu9Z3/APBZ/egxUV0xejliyaEWOGVcUwFUcfJO2TyZQWIZSlM
 miQIHsa/ZEq/XO9HzF+IHP3vDSqWqFkkhKfyEeXnxLpuZQqOmd5zjZnf8HY9LbcvpS8m
 nvOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzo7z8EpuEmhIyYoZDkcQ4YkGhE2m5sztYghYy56q5NjT1HiJvXpBSAhTeCMQCsULFxx0bJKCM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLLSBJG5CQKcq4QO9JXgFSK2FTghcL/PPerjYAs64lukWbX/W/P
 z0N0S2Ix0N2zUexs4ybv7IXsfT/UgdBEUGMMtABsoxSMg2HdHV69V5VRTJOj9BWPnB2L4DsvpzN
 MtfoYanXPyyKI++gj4qGZRJRvexJlv/Ef7xgAKteNZDv8mmOOgJnmv4YTFhta3x5YfC14zcc=
X-Gm-Gg: AYBFou1G0HAsIyD2/gKe1YH3BuWtTpvHKBp/uo9D7eUqBNkRjUv2C7XcWNdU2Q/ZxKE
 XSmwOpI4hocYemi6ZVLIUxGYjPIj8v+0Ux61saOeb4/O/Qo7FOv3P46+9SSJ606KBAcx5NvdkCR
 tP1OB3e5DleTRKvD39HX4YS87IrLg736Ola2i2UeTVS/qtfktwJ71HdaErfywQRB+TsTzHW5f1I
 VgfHWYkRYSYvX79yiR8C3us+02wMT5GdY2pCOQbHrCiJa+EcXi8CZM5kyzVQrR/7Gd3Cb4MIirA
 sKEHcA6PZevCD84slwWIy72pQL+rumd73j/mafNIrVxOmL28OIDvR3l2jhwMoMdld2p+hMd4fZf
 JKuz/rRIG23RuPgnRYoyEEhdx3i2Y6iNkfztxzxnfr9DL5mBg
X-Received: by 2002:a05:7300:c7cc:b0:351:7dab:58e4 with SMTP id
 5a478bee46e88-3537e134b4dmr12035792eec.32.1791783306403; 
 Sun, 11 Oct 2026 22:35:06 -0700 (PDT)
X-Received: by 2002:a05:7300:c7cc:b0:351:7dab:58e4 with SMTP id
 5a478bee46e88-3537e134b4dmr12035760eec.32.1791783305809; 
 Sun, 11 Oct 2026 22:35:05 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:35:05 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 09/13] arm: qcom: enable MMU and cache setup for Shikra SPL
Date: Sun, 11 Oct 2026 22:34:48 -0700
Message-Id: <20261012053452.1567885-10-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfXyl9XDf9jq8Nq
 IHZv+3K4w9Li4cktDc+YwI32DRywZqGc7NdSS/8B1K7eqA1wmJwQCvhoUGz0CzeZLvo99X9VAJC
 i3teVxmXrMXTQdxqnvZjisvqt6TraM96+iLWvnXazWIkhplx8AMpGh8zmPd+le9BlLxtl445tQ3
 uaWU3zoOr/kAkY4gPbvvw90DVQmvOjq2YBjtGasIdt2eQJIXZLG5i5pCHoPWZJBAvtqL3GgFgPR
 luM7axwnvvjDfqnQsDuUKm6BCAJdIsvWAweTzK/5VeKbRfp9q9FAcQmhqCnRglYAu/p/ZxSPRmz
 EsTeuoB5yxAoXQcUI++GkQrGV7jyuxcduMDE4atYIyhI3KLdVNpYn+TwtbcUizBLHx8pY+AndRT
 mT/KwQbxCCweh7vtCuvOGIKEa4nVnEQL2BPR9+V8vsJzGZHngFAH8J4dIhkVFZQOogETC60rlbA
 RDB1RuWV9qNWzW0U0RQ==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6acc718b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=md-n7zwCLhyBqDs_0qMA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX5XALufCRkhFh
 5hrqZgl0/QW2SzsRBaHM6yT5NXHOcq1PiMaghm/BAJ5DeIwSwwa/8Eh8DMnMjjfhsVXJk1DBgM8
 FdCFwwrxoh1Am8B2wd7Opek7bjn86d8=
X-Proofpoint-ORIG-GUID: BLwUfmiCnodB1-jl5e9tH9knjzsxD8dX
X-Proofpoint-GUID: BLwUfmiCnodB1-jl5e9tH9knjzsxD8dX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120022
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

Use Shikra fixed pre-DDR memory map when enabling caches in
SPL. Allocate page tables from the early malloc-F heap and
select the board map through a common Qualcomm hook.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/mem_map.c   |  22 ++++-
 arch/arm/mach-snapdragon/qcom-priv.h |   4 +
 board/qualcomm/shikra/spl-shikra.c   | 140 +++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
index f64ec0c674e..9df522f7a4e 100644
--- a/arch/arm/mach-snapdragon/mem_map.c
+++ b/arch/arm/mach-snapdragon/mem_map.c
@@ -28,6 +28,19 @@ static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
 
+#if defined(CONFIG_SPL_BUILD)
+enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
+#endif
+
+/*
+ * SPL platforms whose pre-DRAM address map differs from the common Qualcomm
+ * map may override this hook.
+ */
+struct mm_region *__weak qcom_spl_mem_map(void)
+{
+	return NULL;
+}
+
 static void build_mem_map(void)
 {
 	int i, j;
@@ -65,10 +78,12 @@ static void build_mem_map(void)
 #endif
 }
 
+#if !defined(CONFIG_SPL_BUILD)
 u64 get_page_table_size(void)
 {
 	return SZ_1M;
 }
+#endif
 
 struct mem_resource_attrs {
 	fdt_addr_t start;
@@ -185,6 +200,7 @@ static void configure_reserved_memory(void)
  */
 void enable_caches(void)
 {
+	struct mm_region *spl_mem_map;
 	u64 tlb_addr = gd->arch.tlb_addr;
 	u64 tlb_size = gd->arch.tlb_size;
 	u64 pt_size;
@@ -192,7 +208,11 @@ void enable_caches(void)
 
 	gd->arch.tlb_fillptr = tlb_addr;
 
-	build_mem_map();
+	spl_mem_map = qcom_spl_mem_map();
+	if (spl_mem_map)
+		mem_map = spl_mem_map;
+	else
+		build_mem_map();
 
 	icache_enable();
 
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 27e5c54e512..c267c0d9aec 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -5,6 +5,8 @@
 
 #include <stdbool.h>
 
+struct mm_region;
+
 /**
  * enum qcom_boot_source - Track where we got loaded from.
  * Used for capsule update logic.
@@ -40,4 +42,6 @@ static inline void qcom_configure_capsule_updates(void) {}
 
 int qcom_parse_memory(const void *fdt, bool fdt_is_internal);
 
+struct mm_region *qcom_spl_mem_map(void);
+
 #endif /* __QCOM_PRIV_H__ */
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index 99bb670bdf5..9c7068497de 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -3,15 +3,107 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <blk.h>
+#include <cpu_func.h>
 #include <asm/io.h>
+#include <asm/sections.h>
+#include <asm/system.h>
+#include <asm/armv8/mmu.h>
 #include <dm/uclass.h>
+#include <init.h>
 #include <linux/err.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
+#include <malloc.h>
 #include <mach/qclib.h>
 #include <mach/spl.h>
 #include <part.h>
 #include <spl.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
+#if defined(CONFIG_SPL_BUILD)
+/*
+ * The SPL device tree does not describe the complete early physical layout,
+ * so use Shikra's fixed map when enabling the MMU.
+ */
+#define SHIKRA_SPL_DEVICE_REG_LOW_BASE		0x00000000UL
+#define SHIKRA_SPL_SYSTEM_IMEM_BASE		0x0c100000UL
+#define SHIKRA_SPL_SYSTEM_IMEM_SIZE		0x00020000UL
+#define SHIKRA_SPL_BOOTIMEM_BASE		0x0c200000UL
+#define SHIKRA_SPL_BOOTIMEM_SIZE		0x001c0000UL
+#define SHIKRA_SPL_DEVICE_REG_HIGH_BASE	(SHIKRA_SPL_BOOTIMEM_BASE + \
+						 SHIKRA_SPL_BOOTIMEM_SIZE)
+#define SHIKRA_SPL_DDR_BASE			0x80000000UL
+#define SHIKRA_SPL_DDR_SIZE			0x80000000UL
+#define SHIKRA_SPL_DDR2_BASE			0x880000000ULL
+#define SHIKRA_SPL_DDR2_SIZE			(SZ_32G - SZ_2G)
+#define SHIKRA_SPL_DEVICE_REG_LOW_SIZE		(SHIKRA_SPL_SYSTEM_IMEM_BASE - \
+						 SHIKRA_SPL_DEVICE_REG_LOW_BASE)
+#define SHIKRA_SPL_DEVICE_REG_HIGH_SIZE	(SHIKRA_SPL_DDR_BASE - \
+						 SHIKRA_SPL_DEVICE_REG_HIGH_BASE)
+
+static struct mm_region shikra_spl_mem_map[] = {
+	{
+		.virt = SHIKRA_SPL_DEVICE_REG_LOW_BASE,
+		.phys = SHIKRA_SPL_DEVICE_REG_LOW_BASE,
+		.size = SHIKRA_SPL_DEVICE_REG_LOW_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_SYSTEM_IMEM_BASE,
+		.phys = SHIKRA_SPL_SYSTEM_IMEM_BASE,
+		.size = SHIKRA_SPL_SYSTEM_IMEM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		/* SPL and QCLIB execute directly from BOOT_IMEM. */
+		.virt = SHIKRA_SPL_BOOTIMEM_BASE,
+		.phys = SHIKRA_SPL_BOOTIMEM_BASE,
+		.size = SHIKRA_SPL_BOOTIMEM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DEVICE_REG_HIGH_BASE,
+		.phys = SHIKRA_SPL_DEVICE_REG_HIGH_BASE,
+		.size = SHIKRA_SPL_DEVICE_REG_HIGH_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DDR_BASE,
+		.phys = SHIKRA_SPL_DDR_BASE,
+		.size = SHIKRA_SPL_DDR_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		.virt = SHIKRA_SPL_DDR2_BASE,
+		.phys = SHIKRA_SPL_DDR2_BASE,
+		.size = SHIKRA_SPL_DDR2_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		0,
+	}
+};
+
+struct mm_region *qcom_spl_mem_map(void)
+{
+	return shikra_spl_mem_map;
+}
+
+int arm_reserve_mmu(void)
+{
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	mem_map = qcom_spl_mem_map();
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	gd->arch.tlb_addr = (unsigned long)memalign(SZ_64K, gd->arch.tlb_size);
+	if (!gd->arch.tlb_addr)
+		return -ENOMEM;
+#endif
+
+	return 0;
+}
+#endif
+
 #define IPQ_SPL_BOOTCFG_REG_ADDR	0x1B46070
 #define IPQ_SPL_BOOTCFG_DEV_MASK	GENMASK(5, 1)
 #define IPQ_SPL_BOOTCFG_DEV_SHFT	0x1
@@ -55,6 +147,54 @@ enum {
 	IPQ_SPL_BOOTCFG_DEV_MAX
 };
 
+#if defined(CONFIG_SPL_BUILD)
+void board_init_f(ulong dummy)
+{
+	int ret = 0;
+
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	event_notify_null(EVT_LAST_STAGE_INIT);
+
+	preloader_console_init();
+
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	ret = arm_reserve_mmu();
+	if (ret) {
+		pr_debug("arm_reserve_mmu() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	enable_caches();
+#endif
+
+	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
+	if (ret) {
+		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = qcom_spl_invoke_qclib();
+	if (ret) {
+		pr_debug("qcom_spl_invoke_qclib() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	board_init_r(NULL, 0);
+
+fail:
+	if (ret)
+		reset_cpu();
+}
+#endif
 int qcom_spl_soc_qclib_override(struct interface_table *table,
 				const void *fit, int images_node)
 {
-- 
2.34.1

