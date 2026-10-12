Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B1ACA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 20:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEC8560600;
	Mon, 12 Oct 2026 20:25:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hJGka0FpLWrh; Mon, 12 Oct 2026 20:25:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E67FC60653
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791836728;
	b=UXZtvlW4TIEbWoZ5z3EgVSfzwgMPpzDajl+AluQ8lNngK1TeXsOeJt0zxwVQ6WKoMAEp
	 RUbGyzF1aLWAEcXqAv7anWOSmX1kMfjwyKnvAF8cmTXlYgHEjB6Q46/tXwBDENGztb5zH
	 RTJupP9kCFtT++AWpbMrbrzxvAoZL+1J5Ob77JR93dpDi5wCT8zgEy3ubuoTQZyNpCr1h
	 WHO5gn46UJ84MfQeN07Vz6SmAjzKPHG/v+1Rd1MvREP9i0AzNBtg06o/WTq5dGD09Jhe1
	 yq9NSvR9qmWF2H1Q+0sG27tRpc19G+OeD3PKbavvGnbaSUt/EsGd5lxwhQm51Zs7MrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791836728;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mUcPalVovv3svEUVIHDe+IxNEw1BR0L888bZgNFgvqQ=;
	b=g7j2NcgmBRKMtksFGpyvIIMcQx2vuVQxokKxqRiFEHpMlR5ch9jW//BptzG8JOHsjLLm
	 /LpheOzKU1K0UWDUzURY6C8n2re0auG4c2d9/lpcPXAXvzMEFmw6moXsA5xILPsNimvFM
	 fRkwmmitStvRoS1nDtUw8njf2Lmtnkr/Y6J7VCsBRJGyMSriWZ3Fk2FoHk4U3xS8yGSPw
	 T0Bn1TaMRJcD2bIXxpPsDYkgm/IeYu2DS5G/EzgLte6g/1RJOhTZONqno3bdHKmbwjeGU
	 459v/B7ZzpLd1N6Cx2ehTVM0ukYcpWMtDKVFNmMU01YCs3GWBESBcJ6+z2Xi2ifrARg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791836728;
	bh=mUcPalVovv3svEUVIHDe+IxNEw1BR0L888bZgNFgvqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MI8u7vVSHWCnd9ThAY9mkoxqahbLKaz7iCsnmkHqqdZwHmdwBP+H8ZbNdmhen1r31
	 f8ZO+ZQGLHoZl37BeqOlCixXvR3RC5IP8I+5scXjUGOgzhCwUZ4fbcudi1P8vKNmxC
	 M0ANExaT7odW2dKeZ5k6CpocrRZM7VhZxVWTOnLFpYrV1rk5xK1oqtMxxEOTk3jv80
	 XpzA9qDmBd5C4CxEm+PYr6ubty3o7hWKzQW740pmojrhmQeex9WdZd2nasHdZsshJa
	 wuRt/hLbtbsXn5uYMDq9SJ/JtEPdZe0sFjRe8Wqv+uFfFpGiyyWytopyLki27AT5d0
	 tfEayngLKaCZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E67FC60653;
	Mon, 12 Oct 2026 20:25:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 679A4105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D73D400B3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DuhYZahrbdbm for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 20:25:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 88FC84002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791836725;
 b=EU9zJEgTshOZbJH0lWYdfG0xNaAcvVQV+3BvBDIieCsKsw3kfMEl9icLId5/tTSkLmGw
 gNhbCfeFoOxo4qvvIJqk448BKSoSF4zL/A7D+R7tLj7H1pG5OGDsA6fgzj5EULuntZ8qY
 yyMJF4N4410qrR+jPXyIquFKT0of+DIyYcNq5fPtm5EhRbDBrYbO3XxJODKFbnepd6BDn
 2HBY+da/6TH5fXN/p0VY/bGNae3NEvKMfkbYPEllQv2KtSkId1z7c9oXC0Jw51GCwAqvu
 CnDZMT/PkrW633ZNdz/20hS5Jpy0tML4YVbHLLQZkle7l33uTWCqbIay47zL1WzTzOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791836725;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=mUcPalVovv3svEUVIHDe+IxNEw1BR0L888bZgNFgvqQ=;
 b=ZAbklyhGZnPFyuC0CxvQRimO1v2QI4WbJfVHzRU5WJ5JrnSK9RzrQpTynZvTbdIaKNE6
 47kFrIDQyNLznoLbb+Cz5HLmPy46FFuqwmUYfGGsP3zQrexqLMq8EOexv+gQcus+86B5U
 EVEkWKCyWimAoE8OTtWqX6bOmi2f8wRXilZAmIZAx7u/jd6yRBYHY8qw+lLxM0ZngDqkh
 nngBBrcb9mjWNjOkDWGTYmtb30p8V3tfZkv7Hr76tIHh4i2DU7SdQ7o4lZ0UscpzDG+/p
 f6dyEvWu94qJ0A3/RPqcxokiaE0JBZb47GGDvkO4vC0qmbjjZE09RV3sySFM4PuwNQA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="k04c/Oix"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Qq89nL3O; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=k04c/Oix; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Qq89nL3O
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88FC84002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:25 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJN2Jj3258397
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mUcPalVovv3svEUVIHDe+IxNEw1BR0L888bZgNFgvqQ=; b=k04c/Oixu/TFBMI8
 ueU7yiARHEK8K+Rs59g07YJfJ/MWUXLBlXmL2P5J0SInOeef0K3pFnAR4oG1EWEk
 ZA0MZHgwbXfex2Nsao3JgO7kCLY/MsUGLbMXnQOUvpMmsLKKzCZedr6KX+rAlQyO
 IWwzc121I/YPfTIV9Mt6/TpjE9AaAjUiV2AhDTStkOJt1F5wPKiCCEst8mvcJNf8
 yIaPtNhbyxZhwiPd1ydzixWBR020jICnEp3VL1k05DY88su2t4/6DGPta4Z5CyOR
 Hg2KcZgSMS6axl87wvUwIgcO8pfc0XybbT7SoGHbV4SWyxGjonAbfrGKTk5xKbje
 mvn31Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq3ayc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:25:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e46c120dfso227661985a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791836724; x=1792441524;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mUcPalVovv3svEUVIHDe+IxNEw1BR0L888bZgNFgvqQ=;
 b=Qq89nL3OV2AWlIFhljhnkW7sMyxA0uOcxfPyK4KVZUomj9Dzs3JR7rpo2fWRwHScQj
 7yeXnVQORzyt/jPFUIhJ/B7oAjsgnS0IVYCk6nr+b1q5EnQAE/pksAtzKkiVxMu5PCUP
 eiEwmUPZZ0oYORiFNhFi4a0LpM4dHd36HZZNH+wWU/35sKX3suPjtsQNSKAZGpR+BaA5
 I98Wxk++CdemV07eLTVuMmm4gELfd/0OGzirLe3noOxp55gk0OJrHvDuv98BiybdWnD4
 amwiDsl2n8Hdsrx0F5J3mddFiET9RO9v/uE/niw2eavaGbBPr/XdeZdsXc8yTq0/BI9s
 QkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791836724; x=1792441524;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mUcPalVovv3svEUVIHDe+IxNEw1BR0L888bZgNFgvqQ=;
 b=z488nFKiDadJR2UI86VAFII2ur1UxnLY8TcXpvLaj4q1laxWFFWsT3S6WgfjdWl8Mx
 hMiHp9Ucx4/Cagsf7ON+aoSNlfkLN8n6D/xORfwGfU/7fX7l++cyZrnP3pVg6t6fOFpp
 XSvB6apaiQNijtHCjc4NKWFwyDvFS+PIivmdak79tDjC+xxfkqyf6pMSjoQTavXY+aHK
 THQLJWT8nuW4vwoV3bBbuTeNn4COkGh5gMcaIb0H1j0YbTID2Dnb0FXPoHTTgopZIZPH
 d2erXjHE9mSQkf+OF0IrC1W1ddbcXbCmmubc1ljJBWAat/1kN/dBiQkAPwV0lSL7npoO
 9bFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxV8gsI2Gw09OoYYnNEMl086NFRJ1jOyMuRkl3CT5dZj+k95q+8UbdWXSJcjWT4LktBsVxcXeQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIbbgf16H3UDU4cBTicdCvfTcyeOV/nHgGM32f/Y3db6HTAFh82
 lwHFj9Kc//W4/UFCZT/18iZ/t1h+Gnjx2apXjXEAzpxn3FfxF39fOEGPDU2CBgJy5dcUD3+ygCd
 uyfCfU85dFktmqRbxsJQTmYkF6L6MTpUnxaQdfa5BvKQtTuM/3u9eJdYIBNvlS+aknnPdbnJPdF
 rbC01Lb+5x
X-Gm-Gg: AYBFou39oG63EEbhY2NDxOOJsIo6d2MJWPhZbNfvcpj2dtPAQZtiH7RA9xVEeeDgH08
 D3ljteZ4gcDpikoF0ZG1cJ1myw+8kRmxOMjQiyNJq6sf9urjYaD8Mug7Uzi3g+0BZasrgU/uhLY
 XBtsrPULkKMpxjWRUDzc945QY/WiyX+kQqYfYn99waWdgx6VnOBKNnFWplakb0wlxWRIZfqlFK3
 F3SX2zrpITfzDB7GzACHI2giqQYcSHIlHaPzurqyrphK56VpsPb4U3500r4YT0+NS5MSlHi9586
 eWY4wsk/AUyUkcgxigbECUzxNSmzf9t0rHzI0Vq8I/V0dQrtQFP3oE8qbvE98zBsGf3UUwB9J7q
 rJQ70TCwon9M/NWpAb9g4eTQy+I1xvPQL1ODElNigJyEa
X-Received: by 2002:a05:620a:1a0e:b0:93a:2611:270f with SMTP id
 af79cd13be357-93ebd20ecaemr1807476785a.13.1791836723476; 
 Mon, 12 Oct 2026 13:25:23 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0e:b0:93a:2611:270f with SMTP id
 af79cd13be357-93ebd20ecaemr1807472285a.13.1791836722779; 
 Mon, 12 Oct 2026 13:25:22 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ae6fb7sm491260966b.84.2026.10.12.13.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:25:21 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 22:25:03 +0200
Subject: [PATCH v2 1/5] cmd: avb: add read_pvalue_hex/write_pvalue_hex
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-upstream-avb_lock_unlock_b4-v2-1-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6acd4234 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=CZvO8b3GW2mycMafNwoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfX0he/Q6WrQII/
 G/GZLMWB6VxMYSBy7sfHxm+/8/bnU+9PZhazbwms8CqAWeKTPQYrf5My5zvAXRZ3LgqD+znf2HW
 iLNEL8Jj/4Ud6VWbZYnnZUM4qSxpFyM=
X-Proofpoint-GUID: aEFNnp9iwGzqj6MyMxt-SiC1x6CFqC0y
X-Proofpoint-ORIG-GUID: aEFNnp9iwGzqj6MyMxt-SiC1x6CFqC0y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MSBTYWx0ZWRfX9Y9Y0xStADD4
 kNAFuaU+rvDyAhH66BJuq38Rg06J638dLJIEwqQOIuaqPGE4hdhQFSSwV1o8orPogTI382M1eaz
 39SLMIlsxvBmGeue5BSS6AVWRx0gNZ5vRtutv1olKC0Ila2/4YtdNmQSiz/skJgFpq6+gGnQVXw
 D32EeYu47hqfcrYMrJKzzNxjr9qDFf17eEz7VXUe5np7bEM5j4nW0jtGBlBuvpLna1OcAOvyecM
 OUKPORMVDCSWo5TWx7T0kLWdY8k7u8xswpkGARp0zMgaXG096GiM34qGXb8VDUZkf7E5Bcu4Crz
 D7zm9N6/ZCOP5zyVoR2ISgkptwni7BWUrpQSkv0g2y/q20AYw8s8f6JjmXdV4vOsz8BnMY/p71v
 4ErQdLaxBapWTG7VSTQCuRK9j17H4yUNCBSKsozIGIK0QS7xkIM26EyIRDtk+nbyxebdI0Lylxf
 VdiVzih41uW5ffciMug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120081
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

write_pvalue stores its argument as a NUL-terminated string, which cannot
carry binary data such as the 32-byte SHA-256 root key digest consumed by
CONFIG_AVB_ROOT_KEY_TEE (persistent value avb.root_pub_digest). Add
hex-string variants to provision and dump raw persistent values from the
U-Boot shell.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 cmd/avb.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/cmd/avb.c b/cmd/avb.c
index 8fbd48ee5a2..6f8df7ecb6d 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -6,6 +6,7 @@
 #include <avb_verify.h>
 #include <command.h>
 #include <env.h>
+#include <hexdump.h>
 #include <image.h>
 #include <malloc.h>
 #include <mmc.h>
@@ -427,6 +428,100 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_FAILURE;
 }
 
+int do_avb_read_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	const char *name;
+	size_t bytes;
+	size_t bytes_read;
+	size_t i;
+	u8 *buffer;
+	char *endp;
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+	bytes = dectoul(argv[2], &endp);
+	if (*endp && *endp != '\n')
+		return CMD_RET_USAGE;
+
+	buffer = malloc(bytes);
+	if (!buffer)
+		return CMD_RET_FAILURE;
+
+	ret = avb_ops->read_persistent_value(avb_ops, name, bytes,
+					     buffer, &bytes_read);
+	if (ret == AVB_IO_RESULT_OK) {
+		printf("Read %zu bytes, value = ", bytes_read);
+		for (i = 0; i < bytes_read; i++)
+			printf("%02x", buffer[i]);
+		printf("\n");
+		free(buffer);
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Failed to read persistent value, err = %d\n", ret);
+
+	free(buffer);
+
+	return CMD_RET_FAILURE;
+}
+
+int do_avb_write_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	const char *name;
+	const char *hex;
+	size_t len, bytes;
+	u8 *buffer;
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+	hex = argv[2];
+	len = strlen(hex);
+	if (!len || len % 2) {
+		printf("Value must be an even number of hex digits\n");
+		return CMD_RET_USAGE;
+	}
+	bytes = len / 2;
+
+	buffer = malloc(bytes);
+	if (!buffer)
+		return CMD_RET_FAILURE;
+
+	if (hex2bin(buffer, hex, bytes)) {
+		printf("Value is not a valid hex string\n");
+		free(buffer);
+		return CMD_RET_USAGE;
+	}
+
+	ret = avb_ops->write_persistent_value(avb_ops, name, bytes, buffer);
+	free(buffer);
+	if (ret == AVB_IO_RESULT_OK) {
+		printf("Wrote %zu bytes\n", bytes);
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Failed to write persistent value `%s`, err = %d\n", name, ret);
+
+	return CMD_RET_FAILURE;
+}
+
 static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(init, 2, 0, do_avb_init, "", ""),
 	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
@@ -440,6 +535,8 @@ static struct cmd_tbl cmd_avb[] = {
 #ifdef CONFIG_OPTEE_TA_AVB
 	U_BOOT_CMD_MKENT(read_pvalue, 3, 0, do_avb_read_pvalue, "", ""),
 	U_BOOT_CMD_MKENT(write_pvalue, 3, 0, do_avb_write_pvalue, "", ""),
+	U_BOOT_CMD_MKENT(read_pvalue_hex, 3, 0, do_avb_read_pvalue_hex, "", ""),
+	U_BOOT_CMD_MKENT(write_pvalue_hex, 3, 0, do_avb_write_pvalue_hex, "", ""),
 #endif
 };
 
@@ -478,6 +575,10 @@ U_BOOT_CMD(
 #ifdef CONFIG_OPTEE_TA_AVB
 	"avb read_pvalue <name> <bytes> - read a persistent value <name>\n"
 	"avb write_pvalue <name> <value> - write a persistent value <name>\n"
+	"avb read_pvalue_hex <name> <bytes> - read a persistent value <name>\n"
+	"    and print it as hex\n"
+	"avb write_pvalue_hex <name> <hex> - write the bytes given as a hex\n"
+	"    string to persistent value <name>\n"
 #endif
 	"avb verify [slot_suffix] - run verification process using hash data\n"
 	"    from vbmeta structure\n"

-- 
2.53.0

