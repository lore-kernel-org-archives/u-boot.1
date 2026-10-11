Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B022CA9EC9
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 10:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCA2580C8F;
	Sun, 11 Oct 2026 10:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gFzuto25xw2e; Sun, 11 Oct 2026 10:57:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1536280C95
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791716279;
	b=osCYit1zZ1lzSK88NQgcFzyGTRlFwIMElPmlDYZPA4XlNnvoZv9jRAsFjNuILoA8BQrP
	 M7OaiV+5jGnGeVlMgCsZp2fv1nB90jPHLmpiH9EKeZOprp24ihcTppSYq6m0sGqZwofyC
	 C4h3YP/Yuh3TAU/lNBekpzajioPg6f1qBeSt/zyPGQ7v2d4/gXGf97c7PpiOULvIa9KA+
	 CK5stTney861Tbxx1zBGbDDsy3Lmkio3hLMJ5BjuGRFk57SE7MEZeAtzt6hwUV4V2nEdK
	 MDQyxSentrXzg/xn3aacdHfZdkfTjauhkj9QKCFA9jhjD1SU7EbeK9e+77oKbI9FdBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791716279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7bbBKR8B05Kh4Kut1FrhvqMRrBMd1df80lsV0wnJ4Aw=;
	b=UxJ3wrpvJtPl/FvMca1xDpRfDKRGm1P1383B4x1KVYon0cKNIKsD/Z5KyeqZdBK61xXG
	 uOIFBOuekA4TVWDbw1C4ibRcZz6oiiwpFuyJfHkbiI6NkN5BOvBOS6u1RQC7damdZQXSr
	 DW/vyN03Ww5/33blYwcgigexTDkyv8AFSqwo7yQPPoNzLp8POSLThj9A/aa5mMPCGfuzA
	 UaMaFPQLlv3oL6Y6lGk4XCNsrFUGjNli69H8QlR8YE6KbEaf4BwzF6j2PbX765+cKc1dr
	 qHZTGZpoG+YNsUcULjiFS4JcDBg2m3iWpHb8jQzk3IZ6RQ9w3+Y0rtRkhpDGSas4HaQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791716279;
	bh=7bbBKR8B05Kh4Kut1FrhvqMRrBMd1df80lsV0wnJ4Aw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U0yCNz5InvmVIyh28/c5qjS5CDvVjhLIKE/2MBze0yWCPO9YCSr+GDNyPkIKGiUtr
	 hl26J2atMGUAWY+65ch8xsz06NjLluSMjUXE2nv0RG+LsxIU9ufYEuyvh29hjgXkZ+
	 R8d8MVoRlfezNrMXxUvsa0k01y/GLuVzPh6/Q/v5L2lEZhJLdKnYpRiuar2yLgKC2s
	 qb4d82IsLy4KgFfSRNGLuvIRoD72rfa34t+HweAK4huzMQbs5+ATxI3XZ/08Ti3Huc
	 HKrB48fqrhWj1uARt/qtTEn8IRbWNqzG/4fO8uJ+QnpP9QQgvau4EZEVeerrTobu6q
	 5QyLhYh0pEf1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1536280C95;
	Sun, 11 Oct 2026 10:57:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DDF3322B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CFD5960612
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQ77q9ctk6qQ for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 10:57:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F54760611
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791716277;
 b=F1WJ+aYShMLJPMux7bm7+hHCx75klIzB1HtT6o0MoQ5eFLu1oq8niCFnY7AY0ykdDidY
 k3j4L9h8Q0+wTKqTSJNHY+whI5SrvkSyjJ//A+Y+BPo80T2azvfXFafZ/O0nVLGC8bjHh
 +ddSjHQgO/V6DwvD3pemmN2+RUFP95x2axY6Tkcae0xrhT3XPXCCuDMpRIWAljSby2BCZ
 U+Mx+2Fp2We2cchaMAIsDEzDcdFqYqTWBG2+m028YKYn9GMiKeY5XhXStF+Qbn5A1gflL
 PE9lpaL7NRRWW7tPS0Mev9apmdkSwZJWH6RGzafEMgJ9q5MTvbKtkhBxH1zO/j8yDxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791716277;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=7bbBKR8B05Kh4Kut1FrhvqMRrBMd1df80lsV0wnJ4Aw=;
 b=Zx9UhEvMw/ejtXujDhk1owyGUnDoK6ffrDkC7MIvsapUhOXsPxvEuXC5aDgPuH2+yT0/
 B0j9QVvVRcf2oc4jKgazbSzUt4je6Z8+Ia0ToX7v0Y2wHLEy7vphbcJl3wu4L7uVk9HXk
 xluxaQU9rT6zUbSg3LEBAMuSOQx5iNwuju3XvQ4wmzKUBaDYc2zuyLVMreJfYW6v3LMEd
 rCuiDsZcCrAo9HyZgyMJJyeZ8tib//Eqvi8qFyQ6KAVKkimmZcruva/PZPI9/fqfYSpQa
 00134+p41iuxz2o7M3yxtg4vXILGqN8PXoM20l6Vxdb41gs5hfUO1uNqxTNxGqbWTUg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=VfRTpw0V; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Psjxex7K; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=VfRTpw0V; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Psjxex7K
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F54760611
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:57:55 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85HIW1512990
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7bbBKR8B05Kh4Kut1FrhvqMRrBMd1df80lsV0wnJ4Aw=; b=VfRTpw0VtVmD/Hqc
 Iwe6a4iadHag9dEN1Og88xDJHqew7Xge6bSiqWBS9qofHBaIRwwRJGDDAI1lA7Rv
 usESUjyg1hfBTIJ79LUqXFGMMdOjWPUjH5Jsv+7ucq2V32CDFfHEoydzSc2amxWn
 MOgcxgEwJRyZds2pra1gQNS1CXrHG5vS0mWNcwfsxd6uRL6i8GSUuAeYVUNqcGTo
 VVpuSWnKNihB3olQYlTyuu+BabHpGUq533CxCPKRjLBmt+O2djZbmWjJaW/eSqYr
 RJ3clXEX+Dmwx2pVOgXIncDEdVeeJbQE6UcjwpR+f8VYTQ63bwLn/UqTgxCwGfcJ
 1jcTng==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjjrg5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:57:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-358856e5105so6021595eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791716274; x=1792321074;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7bbBKR8B05Kh4Kut1FrhvqMRrBMd1df80lsV0wnJ4Aw=;
 b=Psjxex7KwW/nvlFcf3vb/xNhGPDzxVdhL2ivbYoQRLZiUGWYz8//FPSzKD5138/apo
 6Y3bZgW58KYiNNcY8SE501rd2GRsDxJNy2yvEVKD78IYx2oP2l7KXDyRD85p9Hd5XkmQ
 e/Oj3js6iedfHIQ5XaLb/KH+4OoDdzHHsxmt4lggjSa3pFv+NxCtlFoIOV7UjgJS8Kft
 mZWMFtdIcr42CaUrpMGfBJ802M9qWMpbuNAjspwg/0Gpf/Y4kFzfM3q8ayM2cPU4dImr
 z/DmqMupZZkorA57o5YXmatgBCwBBTNUi6A/L7iiswL0cINgW/L5ixraJXJTJbyFcnKC
 qv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791716274; x=1792321074;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7bbBKR8B05Kh4Kut1FrhvqMRrBMd1df80lsV0wnJ4Aw=;
 b=IZsZ7faMaiyRNAtFwxo5HmFKsghjaxKmDKC96JNiD4FtS6L93XsZ/3Iwv7IDH9YfZV
 jqD70PdxkcmA74BKK50Gmbh65oguPhOxofWjUP/ZhEISsn89t61uxTnAXjEEBq04ZeAw
 On938qwjX1OtU8R5DiyqMlolrsLHXHMDOQAN4VGYSsBZ2k9AsMsXbNs3evF4Gwmq0vP1
 ZAjQnJX2aTVPYvNGHqV+I6aT+yNtsIN5aFRDHAwyy8lwNsZb7T0HAW+9XSELGTVkrFVQ
 jg8kK3AZSUOGcV6/jthZaoe74/pXGGLtR0RZB+NdtIuyIZoU3Frq7+duXxhqaMq0PtY+
 fT9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAYgZGZsXJG7oXCBWgJAgNO8ZkeLm1+KFV3WYiN4y0LdlHDff7Z0FHSXBCETokYr3D6K/gkmM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI+q/II8gsERpeX1+BQrekdsDT8bp1uFYvqOAn/JnZqrASnPfxh
 sg4VSwpQuhgtOT3GS1D+KZtjrL2Ypin7mEwh8EP/Ndx51bJwQDvvmTpecvIE8fx8M6i1TNGtooG
 WvlI4wE/2xkUYBi+snv8PX/4b23tBo/hoTwnAsqDe3ZCJa5Q0lYatBPHVOvOF2K0R0nqRUI4=
X-Gm-Gg: AYBFou28o/wKUkl/4NzjzO7aKj96AxvwwDF/Re1opgU0k0Uq15jNZjpCbczreT2xf1P
 D+KVWbkYPDC3UTQp31z34U1hUVSNxl8mm6zayu/P3HFjxqnUPs+Dbk5hVzRxUXiLL5oifzv+5tp
 rhj2AbvDUojgactSVmPicfyyz7XncEm7dWv80gzGzV2uYn9xF904jXE7nhUZGHW3YvFFyRkYRJk
 j9JpkINRCSlxpOEGM+twwbRUbgvKTTRhn37AxEpECMMFMpVeQTOeXwrYWiba3jyOxc0cgx4K/bu
 r0voFPgr4abAlJkFIkRh3obToKLeBMpX9W9f0jrNnFtngLvTfSx39pJ9K+3Fy09yptCm01Gdqxj
 TwImRfOsUJFQJ//266pXZkvlEpchqVTpoPg==
X-Received: by 2002:a05:7300:6cac:b0:339:7b3b:236d with SMTP id
 5a478bee46e88-3537dfc8fd8mr13231398eec.15.1791716274092; 
 Sun, 11 Oct 2026 03:57:54 -0700 (PDT)
X-Received: by 2002:a05:7300:6cac:b0:339:7b3b:236d with SMTP id
 5a478bee46e88-3537dfc8fd8mr13231330eec.15.1791716273364; 
 Sun, 11 Oct 2026 03:57:53 -0700 (PDT)
Received: from [192.168.0.6] ([183.82.24.21]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35a68b14c11sm420368eec.11.2026.10.11.03.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 03:57:52 -0700 (PDT)
Message-ID: <9c89fa71-457e-4483-ac3c-eb95295fcee1@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 16:27:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-snapdragon: enable SPI-NOR in Snagboot mode
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Antony Kurniawan Soemardi <linux@smankusors.com>
References: <20261006-review-lemans-spinor-fix-v1-1-f61b32c1a79b@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261006-review-lemans-spinor-fix-v1-1-f61b32c1a79b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA0MyBTYWx0ZWRfX64G5mHgC7VVT
 IdB6VI5aYmVBiSJHJeGzKm2mJXAdLi7oy5QaXnQTLKvFLKaFUZphi9rGauRnKCQ+vn9GSzblvki
 AlLHBptEs3RLSm2NIP0Hdt2s+9Aup2GvkXHT8GLu3iZhNCuPxb5isqgblYlZC6ZAAlTwUNYqhqu
 5PaG3lnkzZ4huOOLg1KjVLoks/hYtEK8rRyiIwMLPXK9fuWCUfGd66uvT2BT37SvnABXnDwWNQR
 w+M544C6DD2g5LNrTeUnaS5uwNhzaOhwMPUNDqAuQj9tQBery62AIgCZCLxlJSPexWmroa+jOU9
 x2T9ssg0hL+XZ6AcEdA+HhNqB67qgg+IC+4MXWF8MPSXoZfoYRkBsfAgExF+Q8P5KlZBOshtkdC
 6w1Zho/A9pHLNUQ2al4eiC/qfEFZUR5bO+3D4Rm1E3SS2HYxu1kF2paaCkWwizc1rRyKMrFI/aM
 S0jrPyFnpi0ImCK73kw==
X-Proofpoint-ORIG-GUID: RmCaRNjuqFBIF7faUdh_KU72lTgPKmOx
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acb6bb2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=pwXowC3vr/RyD1rplAmAbg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=nm_g3Ki7lvh59gT_KRgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: RmCaRNjuqFBIF7faUdh_KU72lTgPKmOx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA0MyBTYWx0ZWRfX+PlmWVInrOts
 3Y20nf6KbHe4E/bsDWeU2xR/dYwmOCPq3rGxiH4Xx4S1SUoNFRD1s9ZIFCAUcDfipzAS7FXn0Lq
 faOmYvg3+CrgrUXZGWaG/hbXS9aerzk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110043
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

Hi Vandhiadevan,

On 10/6/2026 10:35 AM, Vandhiadevan Karunamoorthy wrote:
> Some Qualcomm platforms use a dedicated subsystem to own and manage
> SPI-NOR during normal operation. Consequently, the SPI controller and
> SPI-NOR nodes are disabled in the application processor device tree.
>
> In Snagboot recovery mode, the application processor requires direct
> access to SPI-NOR for provisioning and recovery purposes. Enable the
> SPI-NOR node referenced by the "spi0" alias, together with its parent
> SPI controller, when CONFIG_QCOM_SNAGBOOT_SPI_NOR_FIXUP is enabled.
>
> This exposes SPI-NOR only during recovery mode and avoids affecting the
> normal runtime ownership of the device.
>
> Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
>   arch/arm/mach-snapdragon/board.c | 21 +++++++++++++++++++++
>   2 files changed, 31 insertions(+)
>
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 3cfac19188c..6e318733fe3 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -78,4 +78,14 @@ config QCOM_SNAGBOOT_MODE
>   	  Build U-Boot to be loaded in Snagboot mode on Qualcomm platforms
>   	  for device/factory provisioning using fastboot.
>   
> +config QCOM_SNAGBOOT_SPI_NOR_FIXUP
> +	bool "Enable spi0-aliased SPI-NOR node for Snagboot mode"
> +	depends on QCOM_SNAGBOOT_MODE
> +	select OF_BOARD_FIXUP
> +	help
> +	  Enable the SPI-NOR flash node referenced by the "spi0" alias (and
> +	  its parent bus node) when booting in Snagboot mode. Boards that
> +	  use a different medium for Snagboot provisioning should leave
> +	  this disabled.
> +
>   endif
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 6a66f5e3096..8f841888466 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -760,3 +760,24 @@ void enable_caches(void)
>   	}
>   	dcache_enable();
>   }
> +
> +int board_fix_fdt(void *rw_fdt_blob)
> +{
> +	if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_SPI_NOR_FIXUP)) {
> +		const char *alias;
> +		int spi_off, parent_off;
> +
> +		alias = fdt_get_alias(rw_fdt_blob, "spi0");
> +		spi_off = fdt_path_offset(rw_fdt_blob, alias);
> +		if (spi_off >= 0) {
> +			parent_off = fdt_parent_offset(rw_fdt_blob, spi_off);
> +
> +			fdt_status_okay(rw_fdt_blob, spi_off);
> +
> +			if (parent_off >= 0)
> +				fdt_status_okay(rw_fdt_blob, parent_off);
> +		}
> +	}
> +
> +	return 0;
> +}
>
> ---
> base-commit: 911260be07649563b2f98555f56779a76a99c534
> change-id: 20261005-review-lemans-spinor-fix-7c063cbfafb0
>
> Best regards,
> --
> Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
