Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95686C982CD
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C86B04075D;
	Thu, 17 Sep 2026 07:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qDZKFunn11tc; Thu, 17 Sep 2026 07:00:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 16982406D4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789628400;
	b=lt3sGpNARvLUAdRlWJ4xA63YuENLiwHa42Lqj454XqS+hEIeEH4BCpTPrE0lrhDJNtLV
	 uILmwFGub5yZ+zbSy6EiCbsIqHRxLcF9wVqXWWDyKGEuIA7spRAgGRlgQWLjrMvjUJpS4
	 hm0n8bgM1r2CFypw5UT+h+Wed7ZUfMm2pyae1oY1FJARs1zTVSl0WSoiOfPqMEN6wNhtI
	 CUSitLZjH9cRqmmMHPBbmAUljqVQmjAFXYFun3SEuV0PtrN1MZi2efQ8h+7RsI4dsMaaU
	 DjMBRbBKW8Upe7PXiihPR8NKI5lsKtRBIdFoG6J+QoPPAQAQzI0nVB56rrT2uG9tHlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789628400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QrFp5HS1eDys7EqePKJx7ZOyX9g7vI+36Ier2Ecbxvc=;
	b=tMiL77QWwUpxGaYt1PmS03giww4+5TJ+nwgXu4bzxoZnRQxe3G9VkeoAiEfQWmJFqbEI
	 X+ejFuUm3ERL3YgVgQdh2ojI/gbz99qMuOGEH2aMoCNTO2np2zEMea7Hd5Vi2es29npaR
	 3vG8wBEpBfrOxDGbmEXuZY3NT4BOEef9utiRGTZz/PB8rhsl/SIEzYdbhvmQCZrelAFdb
	 gEXBei3jU0xyd6FC9ETAHYUujPoizleda9aS8egh+T6iAYD5gMSQpmSqgYZqTSUpVQdGu
	 NkGyG23lWRp/Z0Og9DmCZyIWnuIDNBuk8Bbnr8vE2aqooEMeVYU9SYRYD4wyLcXhz3A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UJH8B3d0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tz8nn+Kg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789628400;
	bh=QrFp5HS1eDys7EqePKJx7ZOyX9g7vI+36Ier2Ecbxvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EV0tprbsR9U8FWFGYpJaZ44/x2I7FW5uf8JfKtDdGjMo1iusoWXJFXySwJcs14QDe
	 x7mlVu55e5jW4TfWUKIWzgCDakJwVDzM2XCdNsj/rA8ZxhqyYnwLiu4OJ3wouS5TiI
	 u52V+p5dL06sgPoxwvodbxsAX5P1nq53FNIdiHmm7DmVvyJM/mGVh5pgrVpHcpZf8T
	 KAtHnWhmczIwSTXdy6c9RcPfUs7GhsJkF0ZR5Tnv/T+t5eft4PibIko3/dhhXoeJyH
	 5yPiRn9LzC0wkB49lJyRe5xdhNmyaXzj3Ypxc7A2o3naiB6UU6iu2oNkfKL0vdxPdj
	 1lLVEB84TB0hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16982406D4;
	Thu, 17 Sep 2026 07:00:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 96C5A37A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94126406D4
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:59:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XnuBMhqipxDl for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 06:59:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E2A2C406C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789628398;
 b=gogL3/xFvJybRcqnkd/T7V3iuRJ5IHXaI5IXV8gUpzCznkJ2Xg/8GYFu8mp+O/5Vh5Jt
 C3ieCN+GpOlXlIHcDAGt85219+o7fZOzUd0X7SfKYpPk5xU7CdFzih+QilzUXNlg3Q5Rt
 0VnYElzlHH7E6cwIhAEKbMo5lAXwO9XyHKngmgQ/zSxJBtpg84++78qRTRI+ahUlAZEOu
 310tM7WxDf0ofJaWs8+1zmamMq9yIHFj2zXKcDoQD2bR9AGpQgGiNt3gmJgm4cKyoekff
 D3ktJBXup4Tq7P7jPoabbet7ZDiwDSGyz8n7M7L+jIU2fbfMtYL4D85oCZlZaRgOeTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789628398;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=QrFp5HS1eDys7EqePKJx7ZOyX9g7vI+36Ier2Ecbxvc=;
 b=NuwRuZe4+f3TK7pvitz5bzV+i7myMragtV6r/wHYZS/PYek4dyPXSpJiQ6YsC83LIoZ/
 uSKk2c5Q+2bHlKXENCX1PgcVc8qc0mLKifoEOI0+cP9xAaeo7G0rhP17f2xXbJUN8JEAm
 gwtNQOWtxoqpEq2z14fA38Ve+F/ZNzZMTQdHvyrj1Vx+txjZOWzXZ4sRxiFhqvmA4VJOM
 oC4KwypM1Gls438blPaT5B3qontRNmUA8KyjZpuNAahRo8WmvrnFVQa6Ct9ZN5Bt5eYrP
 8/AeXKFTzJ1jDTMKrMhocBdL9x73NGZpCpb3feDvDwltXK+U3VBcvpatjdIjBJY27Dg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=UJH8B3d0; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Tz8nn+Kg; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=UJH8B3d0; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Tz8nn+Kg
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2A2C406C4
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:59:57 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H61H8T133232
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QrFp5HS1eDys7EqePKJx7ZOyX9g7vI+36Ier2Ecbxvc=; b=UJH8B3d0Rx09ELdi
 orC4B5exmFSik60Wu8Vzb4qDltCc1s0x4KhXxlbX1f/VwvRfm6mDUMmpZJ7LN2d4
 jwO2pR/alFBnxb3q23FHCRVp6DYUfDaDvQtC5HJRRqaf1oSHqUsAlzbeMymUkfe9
 RQ9U6+QBlGx6HT+QveTfcFC51UkvaQc/TB8NXXR3CASuArnUDndf8D+HCojGfe1M
 nh5G1Pg3Q5R5zPHcKToCuvesJnd7F/aI9P1OquoYU+banU+z5gOiO5GIxFTh8Sc2
 rgoxmT8LBnBxVQhDDjQLpV0GjO3W1TsM0u7UY9DgBI32AsvNobTXS1rRTB+rkxmK
 R2L67Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqtn548ke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:59:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d9057fab9eso9189415ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789628395; x=1790233195;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QrFp5HS1eDys7EqePKJx7ZOyX9g7vI+36Ier2Ecbxvc=;
 b=Tz8nn+KgHvqrmLWK/DhkTRaEuxgbO0aywXbJiyROQjsGWTD9fworYssIp3jOmB66Uy
 icyaw8LlCWZ/eKFUc9/MIRwbBnEMRL7Z0PLORpk1bebfHOiia+OIyQ61EtWW3J8/Zw2Q
 t8uciJb0t7oUFe9hYFNQ8TCeZ9TtA+G6PpbSfGLBw4s/BTDgVIpk70QJTxIpOxI3vyP2
 1MhV67t8iZyQDtRjPuMCrJ6pKxx5VEknpM61NAM3Bp7vB77lJCJ4okz1r8W1ojOodzEQ
 eS5Uf0/v55GVrRDA4lqlcX1K+1jnq81qJH9k4rDiijLB23DAau+weWGVXNNjsp8QV7yA
 GWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628395; x=1790233195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QrFp5HS1eDys7EqePKJx7ZOyX9g7vI+36Ier2Ecbxvc=;
 b=LjyFFsReGiFrUkigQ5kXSLhVfdczyVKiiWWOpC4/zRjFx+IxlMDdcnXXLqzTPCIIFi
 4otRXa/XF8A3SEc3iP3u6il04LGkcUfddhxfFMhcq+9RuhhqkVB01l007/Az0ENFtHmC
 JaNU9ZUkWL1Rl/ug7+iOd9tWy6miZvBJUd1qHa2Np77oO4W1uWoqJPLtEVrT5e3NWir7
 CQdHFk5aXKHTF40y4hKyMp2xVaxQG+6z8wCnM9HIC9bUGLt0qiSvLn/t8Om1IpDqmGuq
 FyK4WvzYQZlgMpl7ge/HuNzzX88Ce+IhKK6cFcqNtQ188l4SYdTgkNLlVFXsjtasUlJ6
 Hg6w==
X-Gm-Message-State: AFuF++nbPM2k43n3J8hAPL9QVmM11CqnihKcc604Mn6T7OJD/GXnLggp
 1N09xgeuMPcxPCV7AIzNvSzobLax5R8IVrzTpRRfoapXQWp1MmSv4xhhGu+XY95pq1VvmGUbeMH
 q+4VTtXN+PgSYzKjM5ISTWPN4cE2f+WrCh7zMofOXnzRo2aPd5tciTc80kWpt/aMy7f07EIo=
X-Gm-Gg: AYBFou0I52iO+ODoA+Gn4Jh9PLE0dXOMQjYYc604Lp8z062gXeGyhGQstd/vgfjPnKZ
 O7K7sgg0xtVeJjf4e3rAQtcnVpTlRPpmqWEitiIJA7ByOS4geE6Mc61ZVY2RiH59yhnx3NcNqYY
 Gp0Z+/jd7PY8RzVanKLVI5pC+LTys23DNG7OokYjbVpxtIjdGAzfQ+hcHqbexUVjnu8lAzgi9Pu
 ACl7EI+/cbNC6fsV1QwDDtsYRMGqHs1EUijvfJG3+l8l+qZ8UfuTnqKhwNJqfVfjfeuahI4U1X2
 MyAT1bvP3XiAS0u5I1BwehoCoTCXYvKxlB2kVrhuiqtk1qg01EQ/7mopG6XHtWuZZMTRfkd1pLZ
 hn3WDub/vRsCZWhd5ZS9UzubJKnq9B32JJ2fxG7dAea0SFv1pZzq6uBtwnN2HQKMSjrMRkuQEeg
 VeQzGGocGcPCQCYOSncBZ+VujdqDp9zHi7N/U9KDg=
X-Received: by 2002:a17:903:26c8:b0:2ca:d91d:d3a7 with SMTP id
 d9443c01a7336-2dd8e3f57edmr125597055ad.10.1789628395510; 
 Wed, 16 Sep 2026 23:59:55 -0700 (PDT)
X-Received: by 2002:a17:903:26c8:b0:2ca:d91d:d3a7 with SMTP id
 d9443c01a7336-2dd8e3f57edmr125596795ad.10.1789628395132; 
 Wed, 16 Sep 2026 23:59:55 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5ac47cfsm11974416eec.17.2026.09.16.23.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 23:59:54 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:29:45 +0530
Subject: [PATCH 1/4] mtd: mtdblock: fix lba not being set on MTD block devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-series1-spinor-mtd-gpt-v1-1-d065abbc7454@oss.qualcomm.com>
References: <20260917-series1-spinor-mtd-gpt-v1-0-d065abbc7454@oss.qualcomm.com>
In-Reply-To: <20260917-series1-spinor-mtd-gpt-v1-0-d065abbc7454@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anurag Dutta <a-dutta@ti.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789628386; l=1017;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=T9fsNkvfhDvatX4qk06Z9bMctC/6dFj1+gM8K3pGBik=;
 b=UHt77p9wPjSPjAP73thgyrKfGqcC6LTpuP4odsgbFJfQqCqZGFbMH15yROl3uArZs0QxJ6tg6
 YgpfFlmcYEcBhk4g0gqbf2w1o9ERML6NBmdOv8dcdi63JWEFD+6En0D
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfX3u+pGcr495KF
 GibPhYQlnVr6JFpw2DsjjxPr898OQK7Vo52s66yO+ii2Tlsh5KJjSr4Xo0OfBfMDnpjCqgS4sjo
 mXE5I86dNk6pxrpfxy95s9ULZGMowhTyzAQ09ovo/VN4T2l68t2j2mM8kEuABxiCUpfczb7Dlnz
 Y6HjjMS+w0wSl2mqHGrcCLidatWGFT/PsaPxymKPJj/U0Gm8gDQn1aRoMSYgQPgKlSh6bccQHiM
 vdAygH9TT68egh/uTVlnH9jpKpqDSGOl0LRtfok1YuowPGKlX8oAK+WsucR1rzPtwPlNV1i+mPm
 4HtzZY5GweA40EOikuzUlOtmhzkZC3Owy2jdvmRhOa2PjIyfhkijBNiEaujejkIX8r0RTDNXPoj
 Kzsnp9t+gD8ZqFacbt1qxG2HgixH/rvwX4mEn0fTkct5rJ1lRy7PaGn37Lg1QTBORvmZCBtBA8f
 s7nung92ojOl/JDnaqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfX0phtJE4a4wL3
 D0fR7Uro6kg8Rr8WaAYTAq0nByYICOR3oI/XS1z801uBa++L94cVSbIUncM2gPCO+IKPJ5CrahC
 MlFVCXjGJxPM2KhVSnR8p5fYV9JbQ14=
X-Proofpoint-ORIG-GUID: ZH8Pf4qwETiRarNmjeXXcGudsCRj6pw-
X-Authority-Analysis: v=2.4 cv=K7O3jCWI c=1 sm=1 tr=0 ts=6aab8fec cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=BSfsrHN3kqvq7MAp68UA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ZH8Pf4qwETiRarNmjeXXcGudsCRj6pw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170093
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

mtd_blk_probe() never initializes bdesc->lba, so every MTD block
device reports a block count of zero regardless of the underlying
MTD device's actual size. This makes MTD block devices unusable for
partition table (GPT/MBR) scanning, since partition code relies on
lba to know the device's extent.

Set lba from the MTD device's size and the block descriptor's
blksz, mirroring how other block drivers populate this field during
probe.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 drivers/mtd/mtdblock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index 66a79b8c56a..27ba0830460 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -211,6 +211,8 @@ static int mtd_blk_probe(struct udevice *dev)
 		pr_warn("MTD device '%s' is NAND, please use UBI devices instead\n",
 			mtd->name);
 
+	bdesc->lba = lldiv(mtd->size, bdesc->blksz);
+
 	return 0;
 }
 

-- 
2.34.1

