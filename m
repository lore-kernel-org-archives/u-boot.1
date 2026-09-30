Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B83CA5FAB
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B64BB40A55;
	Wed, 30 Sep 2026 06:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LK2N_S1aGnDG; Wed, 30 Sep 2026 06:35:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CC069408D2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750125;
	b=qSDwd/7iqzczv9twn6OISts4os2O/S9bRDuh8X0hIaH9eJLL+jYr902mzdYd6Bp965FD
	 US0okvxWKFZPfv1dYDXQhBlgP/8XqWNd2a3SJbFC7e79c0rOb/cWowBB+xcj8RoJgtJCf
	 WaU0hI0hQkHR0BRJuTSd+GddnDVCstsIKBjp5CmFs9Ve9RMeVI4WNvyOadcuujJGtcSnY
	 WhjeWXdTY8foLWbVMhqCyMNYyEVBXuOjLm8EPk24xvF62D8m1KO08D5qQdwS/z4pXQGe8
	 hg3euWW9+hw3c9bGsndqUC56+rdbfjwpnpizRJN9Q/JWeaJnbl5TVckfczjnDZiHDzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750125;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vkwzQMgC098HT0P2M+P8yzHYu6fceXgqRptra4YqdAk=;
	b=JeeH5wWjhlrAE/lFX9mQnYKJGkmEywW/U6STZ4sJuQjmvuTQcoe686TBWz36x/TxtUyn
	 pMQPbLW+D8FtkNxUEREKtSNMMdS/CIzeR9tdsR8KIOVB7UV6cgwLTrGjRGCerJR/m1nhN
	 FElFaTsf+hj7F4SDvCojIcVA61x92IcAyW34Yiwky8JS3Rg+eVQX6xAR7htmHzHxiL+HY
	 tigFzvB9Jt5eaVjwCOa8AoVyfJSULRct1RkbzyHEmRCqiOB+BlICKrEHre7EDpDbVfWTX
	 0zBlXaWJGuo2BZhgXDDsJBRvvsp2/DjhmzcZNpx42WxOj4w18ehBidaUQETXe7K5Iwg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CN9LAgW7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jxYLYEhp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750124;
	bh=vkwzQMgC098HT0P2M+P8yzHYu6fceXgqRptra4YqdAk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G/ABqLfwo3E+5lsketNho1iIWQDxLP28CEixS2nXj8MNoNxNIqXJXGDLiR4YP7yjR
	 YiDJHwXY643TL8zbr1fNKlDzeYA740JAaPc+AzcWOQTsgijkBJRsE08GJTGbOPjzI/
	 t3tkBaMk35LZTzWRkxYSMkl6gX1JdPqBXZ7EW72FvWUpp/tWd3cQVSh7HKAvY/oBy+
	 UbwF2Xnv0/0XVgd5eWOsi2a4VLxL2LymEPKqXHkCC6ZTEEk3WNBcmn1IPui8bE7u9v
	 LbAQHOlQO7UU4YIEIFUHZBJ7ulfMSGTrUiXmyews9d9gZgtbxwlUNIeDfzDt18RYWQ
	 4Ew/m0FcNB01Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC069408D2;
	Wed, 30 Sep 2026 06:35:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E6F932F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3403640844
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jtbsAylOuvc3 for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1990440944
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750114;
 b=VMg7TKfOxkIrbXGufjh5LaYOZ7H2j239/M2Ai5PJjFkOD8M2VXIwH7HlKmNhbm9J8KXk
 0Qkdlhwdm6vdY1JciMgcF4bkM375F+pud4MWN0N4v0x2KuPgS5zGGYJ55+SPJ6Ce3PkS+
 lllvv20l53vEc25G/aYxmsH/8rho6mB+c8ffMxco/1YwY31PZ9zjIWb1r884NyodGUPB+
 p4ntHYk4H3RYBUm2Gf+IJpspinapezEA4BNUy3gJ5t4+Sc2d+8p+lZ7+ezcHNLxoaofL3
 w1naXMkk5qNMJBrq2+xWbvzz5jAzgpxdvBEIVMdv4KM2wY6HUH8m26IfQRTcLlY5WlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750114;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=vkwzQMgC098HT0P2M+P8yzHYu6fceXgqRptra4YqdAk=;
 b=XBntnJlNyvJYXDrI9LKhRVFHLQUYWce/xKMhqDuXi5oRyyGS/4xjvx7KBV4BCwmAnJOf
 Tc3oVOnuIdl9gHAjbrUKHq30e23CIX2xRBtQH/udwuiLiRSwOvY1Fw25aSPTyLBFD+Zal
 7urITCHC1Zig8wf5uY7cl3deiCxgcezyEzTISaOuuRhP9LNIaP6N4F6T+iC/J7S3Ocr5k
 vCVOob8jYM2ODY915NcJAN7EaugkB47pNGsaZWu3Woyi1g8ht5fcxwa7qFHADE5pyAidV
 cjWycEdHsJjV7io03zFxKn9GInQpe9ZWY1ZZ6M6/V6b8pLzNix4FqdDV2UXBuW6Mb3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CN9LAgW7; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jxYLYEhp; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CN9LAgW7; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jxYLYEhp
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1990440944
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:13 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U2POrB1522937
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vkwzQMgC098
 HT0P2M+P8yzHYu6fceXgqRptra4YqdAk=; b=CN9LAgW7AjjMnO1c8Qve7jFVqhd
 rWCUf13pjQKsaL5Ka/EYSj7w6kSdBicGvRVIS1X12FQ7DUrbX6w9q/f6CAw75vV8
 nYbxDr9OPlpLp/UX0BOGcn7zR6qmbggOmzcGAxufUm4hU0FRDIbGDSJnim8Vy5wm
 edw0quZBsADwGSGbTbcN+ebXBV4mIwFNUh+V2Wjxe2vvxyLEFPcThTUBphA7KkG5
 8tGXzewKrEGY4tJNHHtvq0UiFnumIrZ9AuV5xSypCgOArCxWR1ZDlwEVU3pkXhsL
 nOk+m8ag3ApcWhp0w6qVxrcWtsA4LIK3dl1TxLIB0KzyxZ3m8plBANOZGxg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjgxhn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so5605925eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750112; x=1791354912;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vkwzQMgC098HT0P2M+P8yzHYu6fceXgqRptra4YqdAk=;
 b=jxYLYEhpCglOzo7acAgo7SBYKYbZogo3g2pCXTk86+ZYdQcqqvJ7IKvggPtIO4WJyD
 vc1jyu9jC/EUVznih/9gAqmAgrcDYoVQgeGlckLneiukgsIUOM8cL9hh8djjcQ6Nnol1
 yeMxOIgZOHB/SZ4F7+R2X23hUVg3MDZ1MSqZyTJcHfyJ4ECEl/GYa0Jvt61++Y4J2GL+
 cQvYXCENrtDzusLBaIyxBkxKe6zB6Dxkah2Sa/Zc0fijQbOVqzfqKBGtgZUh0bKCe+Qn
 7qUZAi9oeMdjqL1gvbbKPlFHphMGkiJWATTzMDM3wEAQ8GLvOdZArqhw+Hb+TVyPPmRf
 O5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750112; x=1791354912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vkwzQMgC098HT0P2M+P8yzHYu6fceXgqRptra4YqdAk=;
 b=LQonDDE0Shf4F8xaAtwRjVefuSyJzqi2zqGLa7ioA2PLcOmlZqyHDbn6cvhjYEYzis
 CzlUygNgr7e/CFKXFzNzAApqwVZWHaw+ieVdSYiTy93rIbWQUTcipCQURrbTnYuJ5L8C
 0B9n3OmwS3Ut5uAsmAO/2uCBa8bLinVv6fucNdqm77bucKyqYKsTJNlIoR+X6jZYytPw
 lFVjuuj1tYTNI2bxgMam/PrfA3250373JROweXaS4tF38IXBClmqeYU7ze4V7asrS37L
 RbZJIZfbtZBFdV6v879KTWwOVTbfhcRC4df5tqG15Vv7xry+KufLUEc2WJAZSeshwSmx
 rkzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwY8svsA+LzJmNk5w2mdh7scXFugfTvgptRI9CH6AreSRjB2b39JzcTrHYXaA63ilOuk0S3iUY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIIl1hMIQumB71CvheikHpuUizOTrSsMmuaEdkHnGscfUBrnxZG
 V8kQbXbSN3uj89hbBi3T6ltPPebFz70nrUdmHhpaEfvmh7ntJ6akJ+/v9pI0TT9yTFSjGMZr8wi
 kEEasTh9D9r1sZzFNo/l1rh7Ht15fKorsUGNSIT5iMNc8lbdwbl4TjTOl2DKnVT64NgL8mrA=
X-Gm-Gg: AYBFou2HBTTs56uKhxupRZjP8pLQwTqm+xA+olW96EMhAD22QVyEWyS0ZviW1IwtHDM
 3L23YkS8DoUag7QGzFxSR0+7CzgQL+UEDrsjqcqVU1kU/zeUb5Uix3n1WbnPWnsr9b7VuJ3Vkny
 WzQuRsD2ZtSAbI5y7+KiM9qM1zyLBrmzDVQ5VurTUUs8HJaHBxBrStw8MCpYMI7Vtt6GXhRUoKU
 GxNleX7jbY30AKu54mTrqjDBkysiQdgLqesAgYIFDuBG+NpbSkRjZgG6qrmJCiUHT548VhnlxJ7
 EzChYEr5JMlhVGBQeljFB+gC7aI+13eCyAAmpyltYe+zjnntf+NdJbEKVTExkERicSYvtCQkIRZ
 NDLtenCVIX+SLA1DZkpLh/ehcdjhsC6dhYe/4bBDBWORNR7SG
X-Received: by 2002:a05:7300:d193:b0:341:bd7e:da35 with SMTP id
 5a478bee46e88-34cdbfd8bd8mr723650eec.11.1790750112572; 
 Tue, 29 Sep 2026 23:35:12 -0700 (PDT)
X-Received: by 2002:a05:7300:d193:b0:341:bd7e:da35 with SMTP id
 5a478bee46e88-34cdbfd8bd8mr723614eec.11.1790750112029; 
 Tue, 29 Sep 2026 23:35:12 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:11 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 07/12] clk: qcom: enable Shikra QUP wrapper clocks
Date: Tue, 29 Sep 2026 23:34:44 -0700
Message-Id: <20260930063449.3251317-8-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
References: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX2QH5yr8d7klt
 61I9HWmhX/Znv6hFOv2+ewaoWrWvlc8KyH/PD5NOqdGdkqvxUc/u7McAGv8gnvPiAVJx7+daPGe
 flzRHkUpvf+Aa/vmFxf1q4wee8HZAvI=
X-Proofpoint-GUID: 2PSJtp_4Azz4YKJbWXVQjUke83X3k2E8
X-Proofpoint-ORIG-GUID: 2PSJtp_4Azz4YKJbWXVQjUke83X3k2E8
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abcada1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=mb1s1FuMAeZDaavxsqsA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfXyBOS/MIU4JzR
 6qOG4QVrv84ldcQQI4k+6Q+7SovrPEPk730E873Z6sO1Gk/+3gW39ujPbU/PVfmYXvJ2wnzSPuA
 Z06srWcDtMkjM9nlH4eRCszNKZbdAN3W1G4u7P7MVAl7eNwMNW9MxqKqIRD0hUtLoz+/r4nkzfH
 H7SY+TNKT8e3wbO6lPFKQc81XLC/uLyIxvBy57eOOOQ9Nvhw2J2mySJcgmXkZ3k78jPga+zEDsG
 JDcsBTLu0H5VkDi73YPwHEkS1Q9g/FAg7mSQfhDLQfzA+Zgtq8uDIqjrTDVDRI1w3wmGrXqzzli
 PNBjpCNAKap1Q/ZfVq7+Ypb9uSOtAPMX9FrspP3W3EeTH92AGumVbrmVifCIzUOQzTIcxAbbE8W
 z7FyyAXvS0gIssoygFXWtYvNTeNxVW6fqMduputGlTQ14pkaR5xo39fki03942Tt1W9FlzjWV/U
 0GoNK04EbbEaF7WjALQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300026
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

Enable QUP wrapper CORE and CORE_2X clocks whenever
its master or slave AHB clock is enabled. The wrapper
requires these clocks for serial-engine register access.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index 9c803e6c181..ab07613aa1e 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -315,6 +315,18 @@ static int shikra_enable(struct clk *clk)
 
 	debug("%s: clk %ld: %s\n", __func__, clk->id, shikra_clks[clk->id].name);
 
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_0_M_AHB_CLK:
+	case GCC_QUPV3_WRAP_0_S_AHB_CLK:
+		/*
+		 * The wrapper's core clocks are required along with its AHB
+		 * clocks, but are not listed in the wrapper's clock specifiers.
+		 */
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_2X_CLK);
+		break;
+	}
+
 	return qcom_gate_clk_en(priv, clk->id);
 }
 
-- 
2.34.1

