Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3905DCC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE26680F71;
	Wed, 14 Oct 2026 20:39:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sh6kmSfZ_MdI; Wed, 14 Oct 2026 20:39:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED53C81005
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792010375;
	b=Ug4RX+R4frwsg7vNzkLAGooRTu6P0WTenW12F7gZ57R5r58kN3FUilkjGuhd6orOzakP
	 BOWwBOTNwLLAgyjk201Zl+KRcM5iFPvvwjc+k7Nr40cHyBbwbkIFdCkyVmFxnoK+Y6C+0
	 Z1UhGCyFV6DkZsc2AIQgpCv4wCzs7FSQRqNhrvV7SmD37jvKnSbfd4Plb9gD3wNiV9AE1
	 0vsDDfYVj4odEP+SMPtPfxAm0jlU43N0a6X95TpBlHHjujzKjBnEQAhRBU99eq+IsNMfA
	 V4/7YO9A796wiOO6NoCeLLb57lXUOy8Ol6FnhNGz2DgpJILWe8+JoiqJQMvhGSevGvQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792010375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/oQq9IlHHv4mYFZ+R6Q4D3ViRxECNv+1trWzswQaNDM=;
	b=T1dgErhasL20nBPVcvjlmcQ3YUHZjbyigCOom+snuAaRQL/6/mwxTvVPemng6aJ03eeO
	 suwr4uzzY9rTCyT8IooKs70XZzZ4kNkHzipjyR2HcAelASfqTXsvJmw8MSCVp68f4YdrJ
	 Zdx1tK+XkpOtP7Jjuxuf8IPkq4a1Xz6r+YcWXuumCAvPNP4sNJ5YyGaHalvUmeaw9YQxe
	 0T5IAlznsn8cAtwUJtN/mNmMdv2spWa38CBRphx/2prAyF4ojbUeGikwBml1OXX7bUGY0
	 nSl+9xsQ49gsTFKdvWQKbsa8bqZdtQQKHiOXPoUw9tV8HACUePE5/y09dbC6n0S3iWA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792010375;
	bh=/oQq9IlHHv4mYFZ+R6Q4D3ViRxECNv+1trWzswQaNDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bksqx4HCnjpLSu6O11F8QtnQg9IsLJ7DcXpGwl1GxjqElkweK4WPx8QyS1YIZsGE0
	 FTYIv65nuYi0kF4CHF5PLtRE3dXA84ofy28jfMjTnVWMYEb1U7lCnzNSW+BaCE4gW3
	 cQ7s+m/MiMXG3g0Pw88RFnyCCmKhn1PBnVRZbIxi8ckJq7um+vZHyTgjz4SsVyvUur
	 Uu6f42iWpaJJOmfn5MR9H/D1uhughE+jquCwFkPmcbM90GtbuZtJKw11+Y8GdIzHds
	 q1f4iaExub9Vca6Hl9L0y2v0pLzN4hALB8KQiO/XbwUP5JQtrxGfLTX8OwX6Pg9UNu
	 JARQQS6u54hcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED53C81005;
	Wed, 14 Oct 2026 20:39:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 96EB6A58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D041606F3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EEhJyQSV-jSh for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 20:39:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4F11D606C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792010372;
 b=pADWV3YmFpUmhlq0DvDJgkK2yo8HWiqiSxIz1R5DIeKqWi2KW0y+6i7gdyH/BXUJYRT5
 WRV7MhSJlAlOmV2rtF0LoZfk+6Bt5VJ09kbJvgkBwwOFLBwh6zTIakjojvUkLeKthYhVn
 7Jq/jURmp7jWrQJRfCUfWasu10bptxu2YHey0JseseFYHrbSIeRWm1NYrsiOTTeusgLpq
 1nrADMLgLLGsg8Kwki7MptK8H1plTJjZO3w3BaoG0A/Wbet4QtnufoaXh9p1y5LH1hECc
 iafM2D0YITrj8tKf8mLdZftUU3viBmFQIqblPXvAt82Em34vRM3SM0pKYROv58KkTOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792010372;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=/oQq9IlHHv4mYFZ+R6Q4D3ViRxECNv+1trWzswQaNDM=;
 b=X6cozh12CIY7ELi9VmDtGHI907mpkoB3leT0jFjMnn+ggyJ1QEG8bYb2JO5ULv3ySKU8
 bzC/97FFJ2JHdAsPWBN6gsuQqvDHQKVg8q/CekCcy0k/dZQjvd6Apw31V7OjTjmMI1kTg
 yHh3MFw5stbzQksnKBh9gJoORN49ie8nDNm0qgQSn97VebYYr0zFLAS092OHAIt829y35
 qZfMmkncpGukA1EgnpnsJ/jFs0+ROtC8o+gAd7eTShYBiQ4Zmehlf/XnvsYaAC2p+OzYl
 +qs40Dfntgy/vEE/8UEp+M3qNLvoyfdnD+fuEjJUc9WthfXaA8D3eQx0FlZg4L148Hw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=akAgIW7C; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=C4x+5lfS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=urvashi.sharma@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=akAgIW7C; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=C4x+5lfS
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F11D606C2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:39:30 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEabPu500271
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /oQq9IlHHv4mYFZ+R6Q4D3ViRxECNv+1trWzswQaNDM=; b=akAgIW7CoU/5K6jI
 sEu/8MF8lm5RK9kXqUXimig63Gygs0m9z6keaIwg6qK2vfMrfD3z4nUbQcy7/rP8
 eNGKwhH+U19dp4xfBjjT8SuRwCmYIMAa40CFVtOtNZRKErhagK2jgEJetQPKUM50
 bIYgOku8DvlGdBGJqt2N8Nd29qpVOLmpaZOjelbIjLQ8b0EIJ6hY+BWtu0NoarZF
 Z/FVOayQYvarhEgb/6MiAj4x8vds2DuxmB05alYIhH3Zx5TBm2id0anxhM/RyV2D
 WX7ktkPgf7SyYU0ugRRD6VfopKgxkeGm6j9FHPlnrmWBKK3QwcjlRwJ/fcmX3nnp
 XtIYCg==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf1pbw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:39:30 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-677ba0a4ea2so6101750d50.2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 13:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792010369; cv=none;
 d=google.com; s=arc-20260327;
 b=BohWNeDCG+2h6WJLhx9PV00ihPNwDbJOPEKwaCPgkKXw8vQ9EAh1Zz6iFz+Bv74osN
 czMhcYsSwQDl59mh5eDz+DyfALMqs57nXkSCupoc7xb3kW3F5AgUXa4uFYEwo/0N47HH
 7XznGM2fTmRXOKLU2P1KIQxnds6GCIvkmCuLKy70LYK1ZLzXfPsLZmijpR22mcOjpWI2
 Mz7E/LC/VMe5MezwW4B/ji5F4AbDATjugbEg+ndZFMy20Mb9IYCLaHaSdjRBivx9F4eg
 aSf+ieU+0R7WA/MokX8f4cq7MaunhDdcIn2CtqiVFtwBCGjboyfjNb/78kKWoev6/p7S
 fPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/oQq9IlHHv4mYFZ+R6Q4D3ViRxECNv+1trWzswQaNDM=;
 fh=RoF2nIqHIMEVEpzxd6d8DJWElzdNYySZU4kS7wVb4nA=;
 b=JTkSV/D5XB69975hBcpGsdsOEh9Mcp5edQbfUlaGAu6/eM+2jRpXb6Bb/Y/RaH7OuT
 KV93HoOSdvWoyuPGg2AfjCnIINK4jOiu6itNKfjT3N9ms2t3YJSpdMAhiytAOmWIDAQ5
 nMOEeVbT9pcsq8Ggt+XoGW+D7ZLTCklnt0ZWmWrTqNczfDNr4Z9nugLYTVU4gWHq16a8
 /BvpfMSuOHQ3pqpyXGGoPOW/IGCNh3NpaqQCgEXwvdOo1cCR/2i9+Vo+v/aPdwTiKPRt
 eWDQco5oKh1h99u2BqXoioFA45YvLt16xCYEAlfFx/fioUmxXcDwNZP9eCLi96O4q/ze
 W2Ww==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792010369; x=1792615169;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/oQq9IlHHv4mYFZ+R6Q4D3ViRxECNv+1trWzswQaNDM=;
 b=C4x+5lfSJz/8qPcqNf4Vf/U2tNE5HiLGLYDPRqjXXQbj+DSprvP+aYz7ImTGY8+qUh
 GTAGhSSPPa6+txbE+F7kGdZG0CY1xfhFpcXV4faZrQ9dyWlIndGhu/L5J8nKqnb7StGh
 cdzVE0OjAaCc+z2htRmIeoxNYHSY/dftKqsorgAnMU7s+OB7ZOxDxrBGXjatyvBH2rsF
 Gl0MJC+wUkV7hLyrGf8YlQvsiV/IqYBMJD7MqvWtyrad35zpSZGqop8vO8Mk0c0u1wRY
 iJn3WvfpY0T2cxlcgBUWh4znX1u6/EGsCQ0yd6UPMha0X8F94VmCg0BgvGyKpls4/T+q
 Uz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792010369; x=1792615169;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/oQq9IlHHv4mYFZ+R6Q4D3ViRxECNv+1trWzswQaNDM=;
 b=UYLn6X3tf+rCQavHVI7vMC3yQRTdhTjqhwTWTL4dQrREx6L5NyMIX+IBpL0TlV/Cj9
 Evv3hvOnkhqxnHPO8NEX2E6f+tuzy8+qQy+k8IFWdmzUUPCxZGBA1TWFk+HfRrz93HMx
 IZZ/FgGu8T1XWf9f3QSNdIXuzJdXiMwGyOV32p8g7bb/xrBwG01L1NqvheGCoDXzCj2o
 CCmDSIgw170dJiJvJJBJrP8cOQMNL6m5NWahpPNFLN5DilUPohVFzuJhy5P+J6Q+4kwg
 c20aMehLmWU9c12cfXA0hOTMXENDAWP35kYDOUW04ur1yqFZTluhcefzoNq3oeP/eX5u
 2LNw==
X-Gm-Message-State: AFq9FYIHn3AFL5lM/n6XBgvzEeZFn635yBHdbkahaauE3PX/qCX9bhWJ
 M6vUme1ZxJIBNNxwK66p3+GSPuUTgKi5E1bUmtqksdji5cHZ/JianlfIRfmQTML+r4P5hAE7Cd4
 Vtuhbg1g/BWh4vNlIJphIkLH2K43f/cY99V73JjlQq+AsnQ6WxVoNjZNFY+advwd3QW9jjg2n/e
 fITjZfyPlF0YXcmZD8ghQ/8WWB/8Nto42krlvGYR0wArjdUw==
X-Gm-Gg: AYBFou27Uh1eWdbPwD2QPr6pZ5wfVJ/qAdNf48CfagWMFXwiAAlJ4kgq7NtfVWjuv3f
 OPfTy+g+MXtwMz9gWULG0wHt8/6AQ/4dZEYtOIZgF00ECMVO1Z2h/f5yjjZoLmsV3nYBiKW6aK8
 6wMfJAXezwhJ00D+AmsOiQwVsr8LkBZf+cIW6RZyj/o4RPXLnivsI9gEN9sQQ=
X-Received: by 2002:a05:690e:4190:b0:677:c369:ff5b with SMTP id
 956f58d0204a3-67936a42e7emr5994175d50.63.1792010369167; 
 Wed, 14 Oct 2026 13:39:29 -0700 (PDT)
X-Received: by 2002:a05:690e:4190:b0:677:c369:ff5b with SMTP id
 956f58d0204a3-67936a42e7emr5994160d50.63.1792010368139; Wed, 14 Oct 2026
 13:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261009215008.2796804-1-urvashi.sharma@oss.qualcomm.com>
 <ab9ae53b-1939-4a68-8af0-b7b17709bded@freeshell.de>
In-Reply-To: <ab9ae53b-1939-4a68-8af0-b7b17709bded@freeshell.de>
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:39:16 -0700
X-Gm-Features: AclHuK_iUua2X68Q9A3niIVZrZDsMwPg1oEGnB_T-NnVVt7oR7a-QeL1cVsQBoE
Message-ID: <CAJM1RwOUkgmJWN5aSnbbjtUKoGEb=CPUPU2hw8RAD0=k5-q=3w@mail.gmail.com>
Subject: Re: [PATCH] riscv: spl: Add BOOT_DEVICE_UFS
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MiBTYWx0ZWRfXxC8SgJ1KXRCs
 z4fqw+8lcCpyD7HFif8dbpUuLVZ2IpZtFqhHsMlw6404TKa3jGw6+qd130TVusiLNrdU4NKOhD9
 8IWpfoT/ct75VaeKjz1GGjMi6xUB1KXIpriNkdAIH3xLe8BK7YOQjipgSDEYHx+busnC/63SH5M
 yKfoX71OWd9F01uS1wlPTDXUjBr5E55fQeTvs3hkZ+aSugxkge20ULktQjSy+nuCyMX+F+8HFVB
 FO5zk9oeOM0HtWCo/4qxjn2V5IdaHNLJ2V8wfmJudQTRzpyFFEs0S8OWByBtC18HGsFHk4c2H5k
 okGIWqp/WOt+UbHw4GDaSyuZLvunRQdhln8bW8p0Eg/lfAe7sqCky1YnNWKPvp0ADjQMq/RbBXy
 hlydvzMN9XSbO+Y3N1AZGuUnciFK0W4kHW8LAPfppmRtH5iZxc1OyVN6wRGlVlPb7FXwMZwnhGp
 pI1I2FeLwlIFg0+kDdw==
X-Proofpoint-GUID: OlaIMcoNrv9FIe6GOn0eHbej7pRIoaLJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MiBTYWx0ZWRfX4peyOp0pEa/p
 ZImiXuOqsTxSJYEqofe4RV0GqCKB6uCYBRT+q7IG8a0i8yRXgsMdLaF5y6J99TxsXR2YDxEUKTt
 9CVRRSvWzRLaTAhMlY/s8is0qELV2tk=
X-Proofpoint-ORIG-GUID: OlaIMcoNrv9FIe6GOn0eHbej7pRIoaLJ
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acfe882 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=ZT-azI6cAAAA:8 a=k-42gJp3AAAA:8
 a=a90SCSoVo6UWs9-VGl4A:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=MMnepr4wVL9Sz6vaZzge:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140082
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

Hi E,

Thanks, and sorry about the old list.

Agree that "same as arm" isn't a correct technical justification. The
real one is
that BOOT_DEVICE_* is SPL-internal.  As I can check, it isn't passed
to the next stage
in any form (handoff, global_data, bloblist or FDT), so mixing SPL and
U-Boot proper builds from different trees can't be affected. Adding UFS
before NONE leaves every existing value unchanged; only the terminator
moves.

If you recommend, I can send a v2 with that reasoning in the commit
message and a short comment in asm/spl.h documenting the ordering rule.

Thanks,
Urvashi


On Fri, Oct 9, 2026 at 5:52=E2=80=AFPM E Shattow <e@freeshell.de> wrote:
>
> Hi Urvashi,
>
> FYI: substituted for the new mailing list address in my reply; Please
> check your mailman subscription and any MAINTAINERS file that
> get_maintainer.pl may be acquiring from
>
> On 10/9/26 14:50, Urvashi Sharma wrote:
> > common/spl/spl_ufs.c refers to BOOT_DEVICE_UFS, which RISC-V does not
> > define. Selecting CONFIG_SPL_UFS_SUPPORT therefore breaks the build.
> >
> > Add the missing enum value, keeping the arm ordering.
> >
> > Signed-off-by: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
> > Cc: Rick Chen <rick@andestech.com>
> > Cc: Leo <ycliang@andestech.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >  arch/riscv/include/asm/spl.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/include/asm/spl.h b/arch/riscv/include/asm/spl.=
h
> > index 9c0bf9755c9..4eb799d2237 100644
> > --- a/arch/riscv/include/asm/spl.h
> > +++ b/arch/riscv/include/asm/spl.h
> > @@ -27,6 +27,7 @@ enum {
> >       BOOT_DEVICE_XIP,
> >       BOOT_DEVICE_BOOTROM,
> >       BOOT_DEVICE_SMH,
> > +     BOOT_DEVICE_UFS,
> >       BOOT_DEVICE_NONE
> >  };
> >
>
> Is keeping the same ordering as ARM any correct justification if making
> a breaking change on RISC-V? Would this be considered an ABI change,
> since U-Boot SPL might be a different boot phase than U-Boot main app?
>
> I don't have an opinion for or against the change. Obviously it resolves
> a compile-time bug.
>
> I am wary of causing unexpected behavior for mix-and-match of mainline
> u-boot and vendor forks from circa 2020/2022/2024 -era, and if we're
> anyways doing something to cause unexpected behavior then may as well
> have some style guide or technical justification and not "do as we've
> always done it on unrelated architecture (x)".  Maybe it will just be
> "do as we have always done on architecture (x)" eventually but I'd like
> to hear your thoughts on this because there are in-the-wild uses of the
> mix-and-match situation and a little more information would make this
> change easier to discover if it does break some ABI (which is fine in my
> opinion).
>
> -E Shattow
