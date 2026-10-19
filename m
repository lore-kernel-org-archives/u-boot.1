Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCFACCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E9FE606CF;
	Mon, 19 Oct 2026 10:29:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ygWuos-ledFB; Mon, 19 Oct 2026 10:29:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96DDC606EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405747;
	b=OO/A5XWfi7ebCQyMWgctbjoWyjSbPGLvHZ9AePY0BlmLSamc5+PJQK+ccTGLHwkgcDMS
	 ukwwI5aWyAHrTH+irOTB9i+XZVwOiJ6dUeo3rjepnBDAsqO10Mcz5YIt8UPL8LkHOYSbv
	 w48adntIaZwiSkJTx2JB6qMoY+5gDf3ryQ2Gs/Lq6a7jLVq+gLEOViED9InVQIdly7sFS
	 H4XTvAWnMaD+vuery/cDO1bYbgGfqp62932E9kRBlri+QNjp/mcIhZTxy02U+bPoyyjbH
	 PXpCZXRZz0V+mDDLz1fJYOg3XUxJN3J0c4Oit0x/a6FHDAqaM3FwzughyeQGq7g+/gQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792405747;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YuqlYpe9D9e+WCtyUODdclXlv9i2YDGY3NHdjXw9N3M=;
	b=rjU0j6Gw6gy1exoU51CMuM73Bh5SQHvXA29Zw9Fk7KxAhlZ24B01APmSH7knw4GOdesB
	 Wynv+V/kTT0PdIZMlGdIGaRza+66zQ8c+03nrVuqLarSkFYoRBWVAj6zTHKf0IlZ+oYd2
	 yqrclaGHYrjj7CdGrDDrr3+zowrc58EQkq/2ktKYuOZGjnxoQJOg1y09YaABx4v8hoaQq
	 p/u03DE3hibQNJlrxjLoAW48rFjn6taXk6hfcBB2gAdp9eU41drOeGMze++ZobfwPGem0
	 ylEiTiqNqIDZMo3vFozJufrnepoxswmyiSQYD3s+CX5huU4N3IGN3dbVMssmM8FXH8w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792405747;
	bh=YuqlYpe9D9e+WCtyUODdclXlv9i2YDGY3NHdjXw9N3M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b/cuCeqPQ/y+cTyrjGqusprWKf1pm7QekPjl/iHir7Fw36a+a7ex+SPHMio25uLXH
	 WMCicGAeRx9OnhDL/V4c7KlnP/rNwTcCW1NRfuwzzxBJyZvPmDibkAyV3Cz0XIXqBV
	 /AUAWH7Y6+6T0HUVnFT9sPFsxJdFbEUaJmBB9yHLf1yYdnl6obPxgZ9WwMHx8sK+++
	 JdghG5AaXq1DnHpfBl3Vm8g/Rtuhoqb4Qs86kEq4+I2yk8Xz3XkilDbSYIjRXZjewm
	 TgIow7KUL+K9ZJhMv0PszhvdoufRH3UA5exM/ImAmwci4fCw0X3sOxODR0U5qEwVI+
	 55HqpaI4Xz9Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96DDC606EB;
	Mon, 19 Oct 2026 10:29:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 285E11E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E15540080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:29:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ZYoPviWsU5e for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:29:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 450E340079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405745;
 b=koX40UDGesHTCp1jxz1yUzAZNnWrTLpWV48qGEEJK0by14IB1CzLbV0ChIPx5uTaAQLh
 O2+wjc3sRc10T6yWhyS8922U590uRbsq0XhJEceXVfOGBRlDJjqHZMqKHQaMo0i5fHIYe
 sD82d8PNvVqD5ekRBtgaMZMmBFADJBJ+lWRNn6g+H73D4+hQX13OGd4yZ1avLN11x5vR7
 hWxRTcwgZrjaQdOHTzFj2gjJGfHBKFvFU3wUUaQ+YwbXdFfUumGusyjhm+AYW/kj1aRTE
 yU509m/3EFT4tZ9smkpU/YA8bRWfMbrY18E5zOZDSBBp73Pbr0l7u0q9amUystjO40Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792405745;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=YuqlYpe9D9e+WCtyUODdclXlv9i2YDGY3NHdjXw9N3M=;
 b=Hh6reAosDHT07DQ3cVaFtOjjGFwHZC8cNUqz8VYmdgNEyiIuLuVLHtC0D92wodk8Gqwn
 ukgtgcmg2NVDZu5SWOK0mWpzFiN1eIDf0mNj8XICu8109LW7OieHiE3PGMy8N4jsFRqgw
 9njTfZwcLSvbH2SRDpAvlaCF6K7hb/E5LuPSkxAV9IR3kxXJw0KYR/QjWKEmXDd/r6Y5y
 qr1yL6BzSVXgtSBgyB1QQBVY8/Q91q1eAuypGpAPSf5zaw/w9IAUBLSLFUQ88TneHXrNk
 N5T+uA0oy9EK88kiDF/Gmq84c5ctnUbaQOnhmZQW2/IiRMwntt2C/nbi8gFNterxpHQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=PutCtj7y; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=G2BRA2FV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=PutCtj7y; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=G2BRA2FV
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 450E340079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:29:05 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Os1R2752268
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YuqlYpe9D9e+WCtyUODdclXlv9i2YDGY3NHdjXw9N3M=; b=PutCtj7ynvTdP9Wv
 BIdgrZEBuVeqXeiNMwtQ16BnlJK4CQXyvHu/AbF3+cKlHu9CPMKpGV1QeCeb07sC
 ALnglzeVK0g03bVIIg1TO/B4+Z28iRfAIuJfEYx8tmZYW3JwwD74LSNabI+6pw95
 Zdo3LK93/RIcWMotDWma6KzD6S8XXmpzf5ysQ2NtFqIBmADQ4FUB6jbaB3N108YT
 OmwWllPZjvJvZD+Wh0kKun7kWw+7Gc5vxTVRWSSNcx7PVtv5HIMvJ/l0b96e7pSv
 5rupzaNza1jDG8aRuJBXXQTdnl708y0MA0D5C85TuSL0dPXJMGvDHVL5ZrgjI/Ov
 d9glOw==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48gm0b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:29:04 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-679a2297c50so639335d50.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405744; cv=none;
 d=google.com; s=arc-20260327;
 b=cfOpaMY6IUU2ioQllX6g1GE59j/LATsJqgQvyQ23owNj2XplwmnoYUopfu+IhfgAL6
 /Jy2L8gigp/4QmpK0CnNsdbbE9aBsFYboKymlWr6wty/sHOdkOFnulc3VxM0gnW6wMtG
 NxfxCUSrspX5iIYTS7eAJ8rCiPFzAb+Kep/CXxLyZfOOBAk3kYCKNtlt5ETQ6GSFlkLn
 Pri3e5OmZ49HWz5Dsgga28s7me5/w1NVSJisWEEWDVVLPrBeiF7lOVdVxOb1LyoYUUie
 v0GnWE9+oVMa+tHv/3+JqjuLHJpMGnGCqz7Ma2t/PYSJr6jjuMaRtUUNlTcWj+aip0O7
 EBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YuqlYpe9D9e+WCtyUODdclXlv9i2YDGY3NHdjXw9N3M=;
 fh=m3GeV6vpog8p9raMZOxzad19ubU90eEt4/0LORKpuY8=;
 b=RxNY12XkIAzY3HRiTM+btJYWCRN0KyeJy3HIUP0JPdBYBQq9ITKT1gZk2d9CIWV7og
 eZV0uphDbYVzsOT/2YeDk9CO8RL+3JJODi0Y3lPgt+9xkpiOKQLou8xc97V4aiyVzc/z
 BjsNY3QAa2Cn2VWGlsmHvUQwWDA0hEjtb+DNqYJXr8rva7xrjmhHNERTd0m5ygKczwFm
 z8Kri0ms7ZF9HkpPFTWdXf0yQYgcswxdB8f2LsMa2VTc3mFMGxXTT3xgDX5VPRLQVCVE
 k+N3wOsDiaFvKGyeUdS9PkWomrjspW2lR0p0aNxlDoxMH/lfs2EOoxVcs3d3hLQhHYyZ
 WuMQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792405744; x=1793010544;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YuqlYpe9D9e+WCtyUODdclXlv9i2YDGY3NHdjXw9N3M=;
 b=G2BRA2FV+7jAlTINQJKmwwOTYwRHIETSDra2Vhq0n35FEPH0/9DiLfuwYGAQGSRyo8
 JxCcXMIrSvoQI8tBk8f10GqSwKBA/MlxUhGJnxhDrJ8gwMjAyKKK7Bk0yKb82Jsb9Nqk
 wsLmLVLp6pMz07GIWSQIslwLhpM0jZB9n9pijtxFEGg6vde2Y8v46gU2WdQzxUn5w+tO
 N063WVsO1JAR/V7uni3JdaUAaaHuloAhE7hkJtT5m0cs/RvY0bVQnfZ6liKFE0KZ7CEC
 BlS1ySvCGhvqlM15AA2jhJBdFW0MA7JVv7V0bxLcjED7z/TmUAlecgFHH/Vb4mYyhE8A
 Ping==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405744; x=1793010544;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YuqlYpe9D9e+WCtyUODdclXlv9i2YDGY3NHdjXw9N3M=;
 b=sU6eLdWYSMnLI6tf9NXZfNvY9stG6kF9THv6fGSMyj8QxcNcW6jKGN5ExxB0cG5bzr
 PKfOmzOdylYBMOnKb8MZCop7C/LyzHE7G9+sR6mVqB8GYREZta+ZMpWRdlzl8fd5xMpT
 ohPyNHPm9v80h1nFHR8rsfnfNaRDGXeOtKU+Aa8kTiVJQi6vPL13qDLrdgSU3wGrEv+f
 kEf5I4DIRyqhvcH7V2hSQ422KaU8vdVxe2d3yMdQ3HQtkdlQTNYTR+ecDrb/IMHd9RGu
 t9IO2Jy6nIZR6P49guGVBOOzSUnCuIzZeISmDUMeHlP1Q397ufcAOcvlpc/+rrp6LUM7
 NrlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/9YWHGPxtPIGmsFk1QsJAypUzhPqCvPSMwPXpYtvSQkQXk+vRiqiNtU+42hRWhbxz7SKK8+s=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYICLofMsuVTxoX4FlAElLhsDPNsw1UIZIKg2hGyJoepNzt3+9GB
 sXzSZ+4hbKf26+8SE6mRJOcbKEUyS4pdNrrCi39BAsymBhlHNPX5EYEWYxdOn42GtD3xVlqXzVB
 1s9BF97xY3+3KZ+4oie14grnMUC8nKoy5jaBfSLAgZmvTpahHzhJM8GkV+691wrbO8aXoS75IDK
 gNvMXJWVbtB8IF+M6DhbTGNaLmCVzw96KAHLqjg7t3ZbFamQ==
X-Gm-Gg: AYBFou2axE0guKBblSMZM3coMT0duqFYpw9seNDzvyMogA/UFigwvTzibowTvvv1j7f
 3Whlpwct2snmyhPh541O7Nh9rcJWSVb+ITRXdYUX9HvLwrCQ7agTKtnSVkjjvb0PjHwUr/r7Qk2
 7aq8RQ5bBM+AonUF9GeE6HhYef5YteSzzuetK17aOA+jXVtXEOE3hImA4AuA==
X-Received: by 2002:a05:690e:419a:b0:679:c6ba:920f with SMTP id
 956f58d0204a3-679ca759fccmr1222969d50.18.1792405743624; 
 Mon, 19 Oct 2026 03:29:03 -0700 (PDT)
X-Received: by 2002:a05:690e:419a:b0:679:c6ba:920f with SMTP id
 956f58d0204a3-679ca759fccmr1222963d50.18.1792405743136; Mon, 19 Oct 2026
 03:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-8-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-8-9e5b82644359@kernel.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:28:51 +0200
X-Gm-Features: AclHuK859pHMPv_Fg16GE0GiUDII_uV1H7PJG3_HTeoE_zDW6_COXoYqpErnFqY
Message-ID: <CAPzfCAY7ftcwEqFqemb0=QiS3++r=jZsNNU+j7oUp6vgKR7OjA@mail.gmail.com>
Subject: Re: [PATCH 08/10] test/py: avb: Move mmc device number to a pytest
 fixture
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX08VxbmpBmSd9
 GdFzVoD6DjsZ1JNuTS4Y/rdgrhnuc7M6605I2y5ymOl/qweAO1WzEevTNmxGQQdr5nUUYA7pBwU
 YFFZN8VnKFb8tyNzod1Q+m3TR1x7tdvXrL7y/M0PdSCS9MagX2s8QOxd4xOnyZzbVIbojL0tEx0
 S3M7t0BuLBPr6AwPqJWkH/MCpDzclmmkTGorvaCXd7v9Aa7Z2zzczgSV0QyRarKJLtdbrdaQ/Lf
 4h5X8dKpDE2AvkwY7Rb6tOSLinXt+7Q08q2IbBNjijLlRJ9V3pwz73kUDFCFLYGTB9HXUTbxws9
 LjQ3Xulb+5ixdMbJm5bqpkARXdktwe491P3up/RyxU+ExUEjqkbySdIaSFXxuUiyJHNP+LEQIFj
 w3bd1pOoNiKhAp006j4CJmz8Jl6ksViiR9ir6yqW3/RlgYZAEVoGRL2KHXUz4GiqnDpPttCvltE
 U7RgrE6d5EslnmD5Kjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfXzL7op4HOCyJk
 BnCiFDVW1DwCM5tJeeU5KgnNMomO5YFl+UnW8Bmjl06zM07u9iRFkkpliaIsG2XqqCIKCLtXnqI
 G3rFbJyRMNIDuo04wjbgTW6v0vOmDI4=
X-Proofpoint-ORIG-GUID: dPzWLfupAlRD5HxDRprvPWOAtTELYUYL
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad5f0f0 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=LZyrh9Zj_ppcXQmena0A:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-GUID: dPzWLfupAlRD5HxDRprvPWOAtTELYUYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190041
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

Hi Mattijs,

On Thu, Oct 15, 2026 at 3:55=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> The AVB tests hardcode mmc device 1, which is usually correct on real
> hardware. On sandbox, this is not the case because mmc1.img contains a
> fedora image.
>
> Replace the module-level mmc_dev constant with an avb_device_id
> fixture so that a subsequent commit can override the device number
> for sandbox.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  test/py/tests/test_android/test_avb.py | 38 ++++++++++++++++++++--------=
------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_=
android/test_avb.py
> index c66ef0cc52d5..34cddc485ebc 100644
> --- a/test/py/tests/test_android/test_avb.py
> +++ b/test/py/tests/test_android/test_avb.py
> @@ -16,20 +16,26 @@ For configuration verification:
>
>  import pytest
>
> -# defauld mmc id
> -mmc_dev =3D 1
>  temp_addr =3D 0x90000000
>  temp_addr2 =3D 0x90002000
>
> +@pytest.fixture(scope=3D'function')
> +def avb_device_id(ubman):
> +    """Returns the device id number for AVB
> +    """
> +
> +    # default mmc id
> +    return 1
> +
>  @pytest.mark.buildconfigspec('cmd_avb')
>  @pytest.mark.buildconfigspec('cmd_mmc')
> -def test_avb_verify(ubman):
> +def test_avb_verify(ubman, avb_device_id):
>      """Run AVB 2.0 boot verification chain with avb subset of commands
>      """
>
>      success_str =3D "Verification passed successfully"
>
> -    response =3D ubman.run_command('avb init %x' % mmc_dev)
> +    response =3D ubman.run_command('avb init %x' % avb_device_id)
>      assert response =3D=3D ''
>      response =3D ubman.run_command('avb verify')
>      assert response.find(success_str)
> @@ -38,15 +44,15 @@ def test_avb_verify(ubman):
>  @pytest.mark.buildconfigspec('cmd_avb')
>  @pytest.mark.buildconfigspec('cmd_mmc')
>  @pytest.mark.notbuildconfigspec('sandbox')
> -def test_avb_mmc_uuid(ubman):
> +def test_avb_mmc_uuid(ubman, avb_device_id):
>      """Check if 'avb get_uuid' works, compare results with
>      'part list mmc 1' output
>      """
>
> -    response =3D ubman.run_command('avb init %x' % mmc_dev)
> +    response =3D ubman.run_command('avb init %x' % avb_device_id)
>      assert response =3D=3D ''
>
> -    response =3D ubman.run_command('mmc rescan; mmc dev %d' % mmc_dev)
> +    response =3D ubman.run_command('mmc rescan; mmc dev %d' % avb_device=
_id)
>      assert response.find('is current device')
>
>      part_lines =3D ubman.run_command('mmc part').splitlines()
> @@ -70,11 +76,11 @@ def test_avb_mmc_uuid(ubman):
>
>
>  @pytest.mark.buildconfigspec('cmd_avb')
> -def test_avb_read_rb(ubman):
> +def test_avb_read_rb(ubman, avb_device_id):
>      """Test reading rollback indexes
>      """
>
> -    response =3D ubman.run_command('avb init %x' % mmc_dev)
> +    response =3D ubman.run_command('avb init %x' % avb_device_id)
>      assert response =3D=3D ''
>
>      response =3D ubman.run_command('avb read_rb 1')
> @@ -82,11 +88,11 @@ def test_avb_read_rb(ubman):
>
>
>  @pytest.mark.buildconfigspec('cmd_avb')
> -def test_avb_is_unlocked(ubman):
> +def test_avb_is_unlocked(ubman, avb_device_id):
>      """Test if device is in the unlocked state
>      """
>
> -    response =3D ubman.run_command('avb init %x' % mmc_dev)
> +    response =3D ubman.run_command('avb init %x' % avb_device_id)
>      assert response =3D=3D ''
>
>      response =3D ubman.run_command('avb is_unlocked')
> @@ -96,17 +102,17 @@ def test_avb_is_unlocked(ubman):
>  @pytest.mark.buildconfigspec('cmd_avb')
>  @pytest.mark.buildconfigspec('cmd_mmc')
>  @pytest.mark.notbuildconfigspec('sandbox')
> -def test_avb_mmc_read(ubman):
> +def test_avb_mmc_read(ubman, avb_device_id):
>      """Test mmc read operation
>      """
>
> -    response =3D ubman.run_command('mmc rescan; mmc dev %d 0' % mmc_dev)
> +    response =3D ubman.run_command('mmc rescan; mmc dev %d 0' % avb_devi=
ce_id)
>      assert response.find('is current device')
>
>      response =3D ubman.run_command('mmc read 0x%x 0x100 0x1' % temp_addr=
)
>      assert response.find('read: OK')
>
> -    response =3D ubman.run_command('avb init %x' % mmc_dev)
> +    response =3D ubman.run_command('avb init %x' % avb_device_id)
>      assert response =3D=3D ''
>
>      response =3D ubman.run_command('avb read_part xloader 0 100 0x%x' %
> @@ -121,11 +127,11 @@ def test_avb_mmc_read(ubman):
>
>  @pytest.mark.buildconfigspec('cmd_avb')
>  @pytest.mark.buildconfigspec('optee_ta_avb')
> -def test_avb_persistent_values(ubman):
> +def test_avb_persistent_values(ubman, avb_device_id):
>      """Test reading/writing persistent storage to avb
>      """
>
> -    response =3D ubman.run_command('avb init %x' % mmc_dev)
> +    response =3D ubman.run_command('avb init %x' % avb_device_id)
>      assert response =3D=3D ''
>
>      response =3D ubman.run_command('avb write_pvalue test value_value')
>
> --
> 2.56.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
