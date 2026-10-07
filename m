Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC1DCA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 18:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90A6460BC8;
	Wed,  7 Oct 2026 18:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJ_lpW349c0f; Wed,  7 Oct 2026 18:12:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C160260B61
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791396719;
	b=pEei7Uy2KKWtFKTNSXc9nNKvHM1XFhC/i36uStyNQHcMPHU9fw+7QsNiSX9Xc33HPg16
	 mKyjYdrYcWWxaqW3sFfl3xNAUpDs6ntVOmfjIXKeNbL6ciCjlhoGKY/GByNfLC5NjUM5C
	 huVk7ZP+IgEotpBkJxG+2uNEyg1r5cDV5PKJcjok4t2Au4y321gTzUd4YwwKOj4IBo5m3
	 Qy2/3AXIy52A0kR5pqwjQjFScUu232kafydDUy2hQjoccggaJgVQ/4E30AkgWMqgflI0f
	 kN+UKCGULl6AUJQbbgNPHMQGrBQDMfj9uHeNYTtMYU+TptFxrHSrGxMjuUGPdLkg3Eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791396719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kk8Qxs60s+3h9oe4NTXy08kqqV1Dm3f/w1cbR1G/bU0=;
	b=MrAb/L1L/QsdR7dhvA+c95R/eWFvc7gfPQCyKIUpd/NESh6J4IxEK/yEaW9oAhZSP0Mk
	 zQxP7vb9h+F1TFhSkhCi84IR/TREXxO+q4p2RUElg2B2j42/bRrTHoSM97sSyMnJTrefc
	 Apvmhub/g1FgK9RlwXdzh5UAMuluUy7o2mKLRJFMjlTobLxO5LikmrXKrlw7ZPPaJ/iOS
	 SWKVv0pg8IGcECdxR3T93JiwUzazDcmmp6d6GHklK2jxrzl0+M3UFoljIEGsmswfPddKr
	 Laf35ywiRaOvjKTLzYGNwF7jwULlOtR2VVD5c1YTA/D5BkmCFZzJiDaJxByc+Qvc3hQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791396719;
	bh=kk8Qxs60s+3h9oe4NTXy08kqqV1Dm3f/w1cbR1G/bU0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rj7F+CzW/18gbP8NG4lreEywPI7Lqd4wI5kwVKPA3jbEvWS4ndInYaPQe7yg91D80
	 QSUpGJc7TPOcu3006aHInzi3fHLJ8SOCqJzY2fhD1QZGFrLVg0ZnxyFHBBqKmpT0qK
	 MkGLD5P11b4xyCZXizeUIfYckEE0A3TTAnPspmb3I9ZD0SMpULPssgSiCN0g1uSih8
	 2RjvdLtmhTvCwLzLaZXdiyMALHdOuBPvk6Cnk7QGJoX2BQXB/ZTobGAlgU3D8D9/DW
	 4+t/MBFtKThOCql7Vhzd54YLtCpu+8pIq17x+STDL/rWK2t1khS0oaF6W0p5GmJgy+
	 mFHHAxpD3REIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C160260B61;
	Wed,  7 Oct 2026 18:11:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C466032F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8FFA40D92
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:43:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3URwEzZE0TbN for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 17:43:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CC17E4F427
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791394957;
 b=aijQQKP/YSAzAh4jJjKcuAAem51r97Wu3CfHPTMdUyq25SLuK3Dx1vuHXWGdJYl2X67H
 IDHtsUdOafauEg0RI53T8xONyeS43CmGnq/VGuHmLUTg4d9/IHxXoQ6YFX56XWngYExvi
 yrS8C32Ph7gd9Aup2hzKaqRaBJqNKsWoyGSO+k3dU3XlBrjC8sA4mWz9H5xmrFNlHkH0N
 ejtpr3uAR7PioEjyblwz793exfvo+MukluUUM0IPvHtR/27dr7Qj9jv1YulXLCRmgHpDq
 TNuaK/4elLBAcFmnEtQ30nRaFt0OCxeIYz2htjiLMVJSnbCAE/juTVcg3suF36PkoVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791394957;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=kk8Qxs60s+3h9oe4NTXy08kqqV1Dm3f/w1cbR1G/bU0=;
 b=YnNU1BcnlPhboi6bf8G294UD7OifIXFknMcJbGm/SQIX9wdZ5nCOmEtRJq3w+/WVrJ3c
 4ysljIFwdH6TuF6Zc9d+uvPKrXgfRsIgWEzUeq49OhyQJPey4parUVl1kBzwzgJzBey8E
 APZgg9kAsnGIdF7C4s59pbkJqnLUiK+bmAn5KIjqcAxk8OI4ddeuHj8AdUzNUv/8apmxk
 ayhh3+W/76XsBMY2y1G/AkcGgaxZZXBKJP0Uwp4GRJZZk26rNOEqM54jDBydJqeaynvYg
 2kZuvYFNCp9FB8zWAXvi4pnYuPHD7ZF0zQGc2qngzbPUUGRayO54R4cPb+s6MlPjQ7w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hZWxYNri; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OGRDr3gp; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hZWxYNri; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OGRDr3gp
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC17E4F427
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:42:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697EtUun2809050
 for <u-boot@lists.u-boot-project.org>; Wed, 7 Oct 2026 17:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kk8Qxs60s+3
 h9oe4NTXy08kqqV1Dm3f/w1cbR1G/bU0=; b=hZWxYNriacGuKpqeIsfokNOZ3CR
 OJ8Gwi3+0mUqClmvH+rKB14N3xcKr85p8eECz6y71PCBSgeXyjzPn83V8hB9IDK0
 aFU1o80gW0uW0lAwUYZyKfloCLtInhezhMGaFupqah5EZF8l/nWTFvd0qwCaJoxB
 P2GEY6F+qxXs91J/wVQxa0EhAHV3WbEgSVxzq0R2vCInxFUUigoZQTY1wjvL40Qt
 pZC/trHFZsBLnyAqf65hl39PZFSoXN3KTAGEiwfuzWlHGPcA76c9jdg+iJYhNXVx
 Zw2yEt/KFqwlKIxzGQBEFkxir95Ja8K6XcoLKr7VHGedHVIEWejNhM4BTxg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8tnqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 17:42:35 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3515266f6eeso1560898eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791394955; x=1791999755;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kk8Qxs60s+3h9oe4NTXy08kqqV1Dm3f/w1cbR1G/bU0=;
 b=OGRDr3gpLB/OSzeTuH0RhPedHIXvs+2kW0pmvPyjlLufpXPS5W+CvAcz5maaR2dQ/Q
 VcvLYRcoBF7XGQ0wmYFlThnkN8M948G39LgdM8N5XRSDeSOQnkMNdIXAOW7AIV/hIRrn
 5DhCshGAuc3hAWGvu9ljuxH3ohBBCGt6q3IUy0oj8L2g2A97HdV9zo++Jv0F1TBpiFk5
 ckYjZ1JbSB8oASjeD7CHcXzfFdD22aIXE0YKgGh6Qbn1mNWlmG77ZWuQBhk/qiG5ig1e
 U6MV4vnAi3KTuYooR3L7diEH48STrneDb9QUbtdp/xkGTvZvmRnrf0g9vnr3YInRqKT6
 gYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791394955; x=1791999755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kk8Qxs60s+3h9oe4NTXy08kqqV1Dm3f/w1cbR1G/bU0=;
 b=rRlL8D9XUeOSETcd9npOAbhIW85640BlZU9Ny7CLAXQ2VHFS3lzeSCELePFfH9nExl
 7b+Kml5dek3h92O8DFxlAg+oRLgEwfZ0hSNJuaFcx4x5q+CEpzbHazxMtSRSKpxpXVUS
 YNyMCdfCNtr55N7G5+jwNMT1EbWdQz2bXdVOTZETVeBS0JBm2IsNAoDb+Eooanh4PFs4
 HiTTIRWd7hvTnIYf7+mnK1mFtYHxhUimeXT8He7WSD96zIGB43rx26NmT1k/U1/Uy2C/
 xKrtBYYnOtYYj8Ek+J4lu80OfSaI0x5xhLzA/eWe5Uox0o4f1J4GMRa3kAbPuuJLTGmk
 Ka9g==
X-Forwarded-Encrypted: i=1;
 AKwUvByzIVePhr3uPohH3Wtgv+U6figQwegbVf7+pwxzayTpfDQOtgi/IaaWAY/z3mc5QoBMJlo3JsI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLcYn4cMun+B/MXbKvt8OpicSyuuiP5jHeLUHj89sQ8PYN27bqz
 51aqr4m623NipkpjQK1w0xTPf84LRUJz418Ipoy1nfUS/WORDCaDezxusZo8SWCPJGF5VW3KuKo
 XFnkjTBJM4lVKB+oDm6hyeLtB1XIWvcV2N7VB8juJwMd5MmLw6oaJKWijbl7/Vf+5THqHCHA=
X-Gm-Gg: AYBFou0IVi1eUa7jMleLIn9T8AaLK1OLMtPEMsvQjsWxaLfm5faxs3bNKf2D+mik9HA
 y2t4BABhaojjVOWqLhFQUWubWm1JA+eYHQMZbU4lUREAVC14xCUo4R0k7eZAkoskc40u4AoUm13
 TqiRqB6utxiaRIaKe4qVvVZstC17tl2BoHmsDHCElhJvnge//1YriWmFImvAPexJTKQcwogou/X
 BFsirCIIReb7uVnEiYJoBf55oIGCit8PI9YMhYvVQ7ft+BcOehU2HVsash6w5BITJScVlH1mzi2
 88nzYmqGLIZfnUiL8MlxVcmXfjz0MPY9jSXV5lAxScbBoPybcucpmxwxIRTBLR+KcWgJXaLYNCn
 y4ALDy0BdaLxR7b3Vgg516H7ZUmBcaqXOAolNF+yJtAGO0aN1k1cT39JrJDrhr89sQW2rn9rkVM
 /lfJVo74/It9rSEy5m0iycNwcF52od3pAoRw==
X-Received: by 2002:a05:7301:3c9b:b0:34b:b3e1:c926 with SMTP id
 5a478bee46e88-3515df416ebmr4751918eec.28.1791394955017; 
 Wed, 07 Oct 2026 10:42:35 -0700 (PDT)
X-Received: by 2002:a05:7301:3c9b:b0:34b:b3e1:c926 with SMTP id
 5a478bee46e88-3515df416ebmr4751853eec.28.1791394954336; 
 Wed, 07 Oct 2026 10:42:34 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515abb779dsm8486756eec.1.2026.10.07.10.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:42:33 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, hs@nabladev.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 2/5] arm: dts: ipq5424-rdp466: Add GENI I2C nodes
Date: Wed,  7 Oct 2026 23:11:48 +0530
Message-Id: <20261007174151.2590649-3-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfX4460uTz50cvm
 ObTuhEr8OMevtrrbRKgl+yv42LTOk1cdnksUdxMu4wHNDNVO7vef96PrezlLcm4DadPk9QMSpUx
 YnVt+FVs/y8Y0U6A/Roh2fQ9MdpVF50=
X-Proofpoint-ORIG-GUID: IwXZb97j6G8sn7xM7G0SxAvg3Gt26GuE
X-Proofpoint-GUID: IwXZb97j6G8sn7xM7G0SxAvg3Gt26GuE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfX2Yx4l/lNFtwl
 QqGUnSVrpQZTFasiAQoBC0/dIIEmZIqQMI8OeDTxERxk5N9jnyi1Hwbyr1A914Qma6uFMdMbj7Y
 T+LlMgnf2BQbZ63Yvh9mvL53A8su1HHAYCQOsvyt+c++MuBmcCcFgo9n5cR9nxxJ3mj6VKUCpZM
 vcAOpsSFmT4xCcRGpRgm9VWknKe2gOdq6l65Vw8ykXNqM6buSous228bclw5mabgCkVrU5IdMnY
 hFY+5WvBIPp2z7ee/4pSoIC+jg2igBbl/9OePpw3JaSrbxJKwx2uu6ny+90xnTwjs11r+sw8jDs
 QxLqH4L6rcZzJQXVCpii5OX9SKOrCLJ1IV8VefWQBQb7DqgHKUbDWJoi39LqOivtDHgMB76+jG2
 L0Sy0zsfR513EGhHR+hOiHEjyndR2NcvEe2j67gNYk73Fbom4LrF5sO1AnGhQp2+aDMHmdrVzPE
 ZHA/QEeL3qqJiCZwa4A==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac6848b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=61F7cs77CxNXTB8BUUAA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070070
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

Add GENI I2C0 and I2C1 nodes with 400KHz bus speed.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi | 65 +++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
index 56677cd6f6d..5c9a7384f04 100644
--- a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
+++ b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
@@ -38,3 +38,68 @@
 		status = "okay";
 	};
 
+	&qupv3 {
+		i2c0: i2c@1a88000 {
+			compatible = "qcom,geni-i2c";
+			reg = <0x0 0x1a88000 0x0 0x4000>;
+			reg-names = "se_phys";
+			assigned-clocks = <&gcc GCC_QUPV3_I2C0_CLK>;
+			assigned-clock-rates = <64000000>;
+			clocks = <&gcc GCC_QUPV3_I2C0_CLK>;
+			clock-names = "se";
+			clock-frequency = <400000>;
+			qcom,geni-se-clk-32mhz;
+			pinctrl-0 = <&i2c0_pinmux>;
+			pinctrl-names = "default";
+			status = "okay";
+		};
+
+		i2c1: i2c@1a8c000 {
+			compatible = "qcom,geni-i2c";
+			reg = <0x0 0x1a8c000 0x0 0x4000>;
+			reg-names = "se_phys";
+			assigned-clocks = <&gcc GCC_QUPV3_I2C1_CLK>;
+			assigned-clock-rates = <64000000>;
+			clocks = <&gcc GCC_QUPV3_I2C1_CLK>;
+			clock-names = "se";
+			clock-frequency = <400000>;
+			qcom,geni-se-clk-32mhz;
+			pinctrl-0 = <&i2c1_pinmux>;
+			pinctrl-names = "default";
+			status = "okay";
+		};
+	};
+
+	&tlmm {
+		i2c0_pinmux: i2c0 {
+			i2c0_scl {
+				pins = "gpio14";
+				function = "i2c0_scl";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			i2c0_sda {
+				pins = "gpio15";
+				function = "i2c0_sda";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
+		i2c1_pinmux: i2c1 {
+			i2c1_scl {
+				pins = "gpio16";
+				function = "i2c1_scl";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			i2c1_sda {
+				pins = "gpio17";
+				function = "i2c1_sda";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+		};
+	};
-- 
2.34.1

