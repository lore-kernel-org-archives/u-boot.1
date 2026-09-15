Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F5AC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9A55605E5;
	Tue, 15 Sep 2026 12:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQjRVTpYqH-C; Tue, 15 Sep 2026 12:41:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E03C06075A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476060;
	b=da44VFdTZmN4/fb2tCMdCgRSuQX4Gaa2JfUb9/I8U+JWCKocfeX1ctMBYeWNQQFka02T
	 ucZo7SLliDiNBtBzquBcecEfp0mLXKbHPsMAqmmrCRjTjPC7ZBVNQaopL88dL2bcMQyAf
	 IUjrZs5mQk7RK0kriUEWXnwGn7WGNUogyZXWmiqx9j59bKazgqJ1vDcR0VW7EcKWFw1I6
	 C/mZN22hrvOTjV3MCVZ8D7Hc+2ILm3n6xN98cAGJNNzBVHc2PmE+kVfKrHuGj/891fA6U
	 pebz8P2GXM9Z9lDPhxDQkgjY0Ee0hXbU0Qwk4WSrd/I1yTXX/pHQlwcqcjOx1ogzWjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476060;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZRIRMbbHfFu7v+DTFMEDuUYLg3Aqpd/V+aoLZ24P6qs=;
	b=r5bl0xu690PHU2/jwHgwbz+DDWv30dsW4mG8cg96089lPVTSLqNsZ/cW+Gg/oZGm44y0
	 NW3oXGobVm2+X8VvZaMfGvW0qvC4Q8LkCbCVapR8KtOQUgbvl+gm7pfbNnaqvDcRuOK7O
	 wO8/47H7KgXtt5w68iUDOuEaNUjZ5zxwQqirX/3yUR2/0BcK4H7fiZZAQjAYQyrpxJNRX
	 FH4hqlJwD5YZB78Ob6aNylTgWy+IcxlZzkP3p4EbBg8ZNSGcQULXqKG7u1pl5mD4cPWv0
	 TvYklw/0xBPQIPRMGQ6VEzT/YbhJM1w056swZwhrUBL2uIvKt+x7Ryo/Atk/W6PQAAw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h2UtnylE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fuIUvIlr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789476060;
	bh=ZRIRMbbHfFu7v+DTFMEDuUYLg3Aqpd/V+aoLZ24P6qs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K+YKl2pz80Wta0sH0ra10GKOQzAjAHNZlRO97sh59io8j58DPrK6gixGx9nTHd26s
	 rO8QKF4YAtxfiaoKpP7vkIJsk/TZi6hp/1K3CE9vZrzLVzJosG1umHnZraNWDtoQr+
	 L8SYTa844/qKF4aqbFr19oK6qlUMggNxokmXn34m3PYNWPl9fBYaE/liIyyA7Z56rv
	 g0EGuzIB0zHJhSaIHg67ZdL/gid+JPNVqp8Bg2rYl+lwyn+zCsSx57112TpbjCTbfj
	 9i6cXD/RdcmV4IJ/WEDyMj/41Q3M/gOr5poqSskZ8IHfp1hJssKWCwyZ3bIexguYQ5
	 h1skCA9Axrvaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E03C06075A;
	Tue, 15 Sep 2026 12:40:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92397224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8388A6074D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:40:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fy0vEuMwYcvk for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:40:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8719D605E5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476058;
 b=GYcr56E9hIZkR/RPhdfhdYMFJMh4DgBWYMMjS7s1zQ9RwGPqU9LkX7j57e7jYWC5xbuI
 vVevbBcDxhYdXlPvNpUV+zfLmlrSG29MgR0TIwjGQVIK1lgT1URVN5TCchhgBcMysNYHp
 B5/xfpmiALvw6NYhjFwRri/no04/EQZcyAVebpKa9FJ9vGj3Ar7a9uidBqeIVHqv9xIUG
 UtP1ZtobRzplpaL7tYXs3I0+9LALVAJpMrCyoRMWjWeF5TYXdO+Y2xp+YBrhaZhOOIEwH
 denoubTFWATYrDNAHjbVnl1vit2fOYnmTmL2zuyWlbronb93/hYFIjaiz5/UowkxNNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476058;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ZRIRMbbHfFu7v+DTFMEDuUYLg3Aqpd/V+aoLZ24P6qs=;
 b=WuMGUu2u5v8mhKkiClQBHqB6gsZq+9PsFrSW3yS5gpFLKHDWkJG7xGYqjgi/8/8ivzUu
 J2lY0NDtTUlpvaB8kjjdGnPDZdtPWsAGtICz2XMQr9l0irN6aVJDtVSSMm8UYAwPAK3JQ
 a9mKzIOvtSnuODvBJ7x9CxrurMwwUMLi8c1Vmx+HfGKbSnEJMXisvDlvCzrAMraNS9Bxx
 lj0EjQE+sNJoapgqX0nYN5wqxRN3LVSLPWVHHYSOE//OzHC8CeOoWZwJpnY0v1gTKHz3B
 W9FS3WT/eqRRzHJk5XpP2BhNWYqFELRpp2mb/SWS+wzURHCTk8Jf5KznUUHQI14dSIg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=h2UtnylE; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fuIUvIlr; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=h2UtnylE; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fuIUvIlr
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8719D605E5
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:40:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F9hG0M3912039
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZRIRMbbHfFu7v+DTFMEDuUYLg3Aqpd/V+aoLZ24P6qs=; b=h2UtnylEFM/Fc0tK
 tEHDe3DgO3KmlHZMOUIUr5pNF77OEYZm9T3BEvpTzXU4iSCbq10tWKmsgp7jV0l/
 WJyNuYY0euEEuVPBBKyx/Erg+FjB2fdw4iKMS1vrNI9/0Tyl2cKxnnU6X5quI+22
 Bg0ljkrUHHRmrFP1kFC2br0JMbxAJOtzfMLh70uPSEevh5QrfTVLnsTedW88BZqo
 xaRfSlTYQbDeRXfbtx0scY1eoW2AJMRp+OsOwZoTNPq66LM35vDokYGTIWeiJ+uO
 ftq2dr5ZbYmbJ46n1L8Lhqr6e95uvscV4WtgsjnfA01Wt071TWc7GebHYbpyYzbU
 J6EnQQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq0jesjrr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:40:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39b6416441eso8525119a91.1
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 05:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789476055; x=1790080855;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZRIRMbbHfFu7v+DTFMEDuUYLg3Aqpd/V+aoLZ24P6qs=;
 b=fuIUvIlr2a6Bca77m05wIogryM7GQryG+mA4hj3vjGGisY0PBAPTC6LZlWYGTsFdX0
 QWlthZfDq40dIOXQng1uvUAu0zSG3pvuOJvwGS7O2ISyAI1FLned0fBVrGxjH7r6vsBK
 gujW6Sy/xWvPTum2XCaHMOQNTJfCbRv9dHb/VSIfcNdMWkkmQDgw8e49fO7KS03MQCve
 Fv9QFqjfcyNmioC39C3E7wI9ENMjsnoC9xJKUO3GyJaCoHLY+kP4yXOjzyvmWK8SSITL
 ARHYgrRXzWxtD8x75uYk7nV/LKz0u6v6/ZpqOG91EYNtzyRtfP8ZqhjeEpsqsDaR/iuG
 H0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789476055; x=1790080855;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZRIRMbbHfFu7v+DTFMEDuUYLg3Aqpd/V+aoLZ24P6qs=;
 b=JrlyRoilhE2gQwfNmeGg16uhleai2LM6hyfRDJwhz6dmDyfTOCfQ4A3GEWRUvV4lrb
 TTRedOvV2LU+JFdNtu0/HtqewpgA+Trifhx/k7L4nhwly77LOCrqq1pd4apjhyqNUxJz
 uuIgYEyHdhClX4Qr0Ln3Bx56Qo+gU+JqU8I7jZbzSI2gGeiYY8MWqxKuMVFOn4HKvnao
 zUJterZqrirhBVRPEp2iwOb6DCZFosVPm9Qn5zkZLtnBcKiYLCoY3DpTfEIp/a5evsB+
 g9I1K02WjANy9zCXWVdnLx4vp6CvdfCjqvmbfoeqqBAhHYOURS3gFh9qO57dKItEyRxf
 zE/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjrqdeA/JxtjAcseR2fPk1FjEPwfpxit6Cwj6vzJ1Wrc9JRgByrhdwGj+mjesv2Ie2Wl0ZmsA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lWghTEQm7/sZtnRECPdsBHQLR23zaSQ0lfxSNf3L1AlV++4mUn
 obEEnTf9nO7Y1tyHMnDKjVxQWBiBV0fyw5uaYANYC84K1DB5numQVnI37rlzKRJVSIcnGM6T9Vh
 E+1BC3aEoLDuIQyrs1/UHrEIGjpxWGlogHXNa7J2LLPuigBjsgHpOmJ0hwmdEqIP4uq4PnfU=
X-Gm-Gg: AYBFou1BWMhvS4+XdIfa2jViihQwJE3pxfBeajy8WnmOuDIpuIgna3+J0+jarMFWdG/
 X6n7xKJ665M539NzT/UZ8DN7sSfGsgTci+n4McxH+anSTZdvq+cCjGGDSlz1ak/z4Bxytg9dRIm
 Xw0HVDvt8P7NK+WW0YJXdXMtJQ8pgKF9yq3mOmgLuDOdShwE5587TlVbDlgXHmv8UE+r8Wx8BQx
 nzD0Krf+ZfQGHpcKxejYATYeAl4QWuIvHDtLtAct/ccNzgIczcZTncLz28lJl6TBJq1pNduVoKm
 bJSOpFK2A4VcsrrDKGRdQZJQWdfkfHoPL94f/BZZ5LaWJvYkVR3+XEX2Uqq9r3FA7GXjiUEHxbi
 x2bX7QEmiXnKL7YRILKucgHPEr/HBizn9cJPndsY=
X-Received: by 2002:a17:90a:1c09:b0:39d:efa9:cd20 with SMTP id
 98e67ed59e1d1-39defa9d5f9mr7915796a91.7.1789476055142; 
 Tue, 15 Sep 2026 05:40:55 -0700 (PDT)
X-Received: by 2002:a17:90a:1c09:b0:39d:efa9:cd20 with SMTP id
 98e67ed59e1d1-39defa9d5f9mr7915760a91.7.1789476054674; 
 Tue, 15 Sep 2026 05:40:54 -0700 (PDT)
Received: from [192.168.29.107] ([49.47.242.47])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdcb6a7fsm5375855a91.3.2026.09.15.05.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 05:40:54 -0700 (PDT)
Message-ID: <63a69d31-a246-41ef-8f39-ae6e69a80732@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 18:10:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rng: msm_rng: Acquire optional clock even when
 initialization is skipped
To: Reza Kurniawan <imkyufie@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Cc: Robert Marko <robert.marko@sartura.hr>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260915-qcom-rng-fix-v1-1-c7405eebba63@gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260915-qcom-rng-fix-v1-1-c7405eebba63@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE4NCBTYWx0ZWRfX5urWeMnwpIex
 XfRsPuCynPMOd1SV1tg2uX7vOhsR0a0sZOutPPjt069nW+LhnOfSo6F4iD1y1fpTHFiTkzbVWcl
 0kSiRlJjAZj9+EpFRyh75LqM03vbLNQ=
X-Authority-Analysis: v=2.4 cv=Kr/YSmWN c=1 sm=1 tr=0 ts=6aa93cd8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=5Nx5MsSwb4TrFb0eIr6Pyw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=zEICLF_ETr5viRTTAQ4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: MuWupzfxWtYwfux7jMrrAoEL6X3bO_z6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE4NCBTYWx0ZWRfXzCkVo/OOekEn
 ynsyagas7dTvDYkDXLDoqnQEa8eeguBmifn0myBU9AKSBm6S7DIz/PbItFEd6mWZw3SQ12FUiU8
 40NBxU5NwQLC2Id0HQfo9cH2osKLhIEZKAJnERo2o3Um1lgMAPxddpRUB8sg2D4uxEZNn2QcnOK
 kg+GxhC3I6FWkVpvm2x6aeVZn0St6E5Vz5C+2ZF++1qD1KkYFEFYqzsWUeDCW/ZksnUZoek9g4n
 Uip0GcAk/XLV3/i/Pun47f6B5NKylpX75ue362r3mQomDRe+1hsJ3Zy9ugYZy8Soqfpd2RQfaCg
 iCNRABrn5ToA93r1A/EjqT+tsiB8LyCtWQ0ZDPyGBr6d8d/tpsC6RtSFfTDkTxRq6kw9p0wtCdy
 cyjutz3A+Jf9MeRvUb7smPh/bTXQ5Ii13LHGxjL7rOFZjlV55hslLEmM4ITcaBPNt98LJctrPdc
 P9jFQ/fTWB9szMzyKgA==
X-Proofpoint-ORIG-GUID: MuWupzfxWtYwfux7jMrrAoEL6X3bO_z6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150184
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

Hi Reza,

On 9/15/2026 12:01 PM, Reza Kurniawan wrote:
> For devices marked with skip_init ("qcom,prng-ee" and "qcom,trng"),
> msm_rng_probe() currently returns early before retrieving the clock.
> As a result, priv->clk remains uninitialized, causing subsequent calls
> to msm_rng_read() to skip enabling the clock which may cause failure
> if the device boots with the clock disabled.
>
> Move clk_get_by_index() before the skip_init check so that any clock
> specified in device tree is properly recorded. Additionally, treat
> -ENOENT as non-fatal so the clock remains optional for devices (such
> as some "qcom,trng" nodes) that do not define one.
>
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/rng/msm_rng.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/rng/msm_rng.c b/drivers/rng/msm_rng.c
> index aab602c5e..68f25ac51 100644
> --- a/drivers/rng/msm_rng.c
> +++ b/drivers/rng/msm_rng.c
> @@ -114,13 +114,13 @@ static int msm_rng_probe(struct udevice *dev)
>   	if (priv->base == FDT_ADDR_T_NONE)
>   		return -EINVAL;
>   
> -	if (priv->skip_init)
> -		return 0;
> -
>   	ret = clk_get_by_index(dev, 0, &priv->clk);
> -	if (ret)
> +	if (ret && ret != -ENOENT)
>   		return ret;
>   
> +	if (priv->skip_init)
> +		return 0;
> +
>   	ret = clk_enable(&priv->clk);
>   	if (ret < 0)
>   		return ret;
>
> ---
> base-commit: 0e2a0ceeefa0ae10118b8364da62f1fb86f286c0
> change-id: 20260914-qcom-rng-fix-a7dabc760daf
>
> Best regards,
> --
> Reza Kurniawan <imkyufie@gmail.com>
