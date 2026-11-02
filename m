Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13AA606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bBN9Ax/Y;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VieMl3ac;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TJP/mPpI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A42F4406E2;
	Mon,  2 Nov 2026 05:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HFSIdamZNDOC; Mon,  2 Nov 2026 05:52:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C12E2406C2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598760;
	b=QxrVX/7brgNM6s0TaAOnyYxvnhvmPtwgQ6tuXPUDe/3GEEzydQxrENv4UAAgRAnlnCBH
	 fHSUSNhyopQvOVOWLt9Zu+6thWk2RepBmfBAJEv/aVQrqrMDdxziSGA9AfCg46pDJEEEE
	 ELG9/YKI/zom41NrnPflwV8N/heN6oiuyC1uXFwKKnZlLNppeWLz1dEntaRU3l7c+ON6E
	 1vIiSLnff3scJFi0xE+/kMegPjMprYKGx4r+PDch4ycRHzzWBvPyz2NmOVKesaUsXGHvA
	 +vh9cQA2yTVk0o+gLZfE4bmoro9XlFonwu4+ddIyCE2DSL3rzjU0BISxqRZTHjy1UPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
	b=BnJkjp8VtBDq/+EtKe3fifnz25P6EdyvaC7GetoqG1Bd033lBRkOykKaUiRtY4/6X3RB
	 9IL8Vc7apbVd/RM2Y5boaE/7I7rTLu7gEZ8qLCHAGtbLvYU9Lg9FwEMLUiBo7osJylf8+
	 jt6/JWyaESGkustfsndZ2qGMvyBdVcLiIXUYp6dmAEfwFVK/42JTy3iub4nxXgPKI5K7O
	 viNspqbI3UF0TwSUCxDh/u2ClVFJNxI2WrMkot5uG2FyKzCEetAjpvorzo7Mvtby2vcsw
	 j1/+biJLoffCjdPr5J+VovL3kgQTtDt0IhVTOzb2yYpxOkzJ9QM56Zg1tKhsVrFPXYw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598759;
	bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bBN9Ax/Yx2YY/ptWlKyRgtyNo8Fdt/pYwa1R4StUEd7BeKGaM7F+N6mxn5HTq5fzX
	 n7JTKHv8p7LWhWBbICgTE6R4nSo9TuvF/NQ2rGeWkR+ToZvBF2ysJcp6lzHuvwI2Uk
	 yuLQUgKiATXkkq0WcFwtPNmPrqnRyQfuBb0vKv8ftCod4dSK/A/wYUfG8DHEKTUjop
	 0OwCQYxmmG/K50pDWmhAbLIOAIgCoIXBRhRJHaz38BruoShcLW0szIxYxp5PzS11hH
	 HTMtgogLLKpMe0m+5FFSVqYCqDCRYSTiZ0rRss8UFCX+t0j58io0ZKVBG18F01b/eJ
	 Y/Qq1CwNwR7MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C12E2406C2;
	Mon,  2 Nov 2026 05:52:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BFF7435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D3D240112
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VAP6RInrwyXo for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:52:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CCBFE400C8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598758;
 b=UtktshDVPkF32D8gEyMMBSetllaVOiUw1S3Fnz2GDz+0UdVPIocUmhFn08/SM8+8RPK/
 svali98EDJl0ixkWzrgc9HQYKPjfczUPi01VapIdqboFMjE99WTz5MzyELavCQyy5GPGI
 MgSwW6mgo3am79ifa4BzNL6mcJpM3qbz+2E4QuVMOyE1I1fWCwl+P9vVAbWu5mcoHY0Uu
 5JfS98gLAhu5HNOwn57aU29OXwdZa/Fx1gw1f4WzQTw4ek+14ky9ue5Hkrmy+FZF1Wcq+
 xgaHONy5uw9HPGCOPUQl3LHEHj2BxfD1lvdYZLkP9oXpODfViB0RcC6R+5xLlfvrozQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598758;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=G1JdIiz2sk/Xefyn0UJ/nVvSSiQJeJYe4H66cirRmWfu/IgFoO965ffBfpJ7JUorC4Eo
 2FoGwRYJmF+aG71lnHDxaG/5qgxBGF/GZlGfd1GpLx/XtiB5CIq3MZhG9nGYfbZN8buvM
 dQLRD+oSK5pzdy1/zN9nJZ73VCpSnlesBf2id5NpaQSqOD84VG0QjTXUjzrTU1S44ImPb
 qabXJND3VJLX7Yo8tsd/Qi83D3Mhfl2yxIEJz4gC8gEFroJIQEx33I8pItsgyF+OjcMSg
 ieljCf33ivI4I9nxw4FervMvXuyfrgO9xTM0rAXvLcnTowyXAEfUM9+UEz+vykXlKyQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=VieMl3ac; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="TJP/mPpI"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=VieMl3ac; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TJP/mPpI
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CCBFE400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:37 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vUXH2192519
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=; b=VieMl3acgq0O+ZZL
 6k1/i3UztvzEscy9juoqQmvYbtiPYkdRCBZtnAz4wTie343k7sefWJrB8YXbni9I
 sHsB+G6AEUdPnS32X/oBG1U/HSYxQXRwff66WPt1DOyxx29FVdAI8B/3uKbv/wi2
 nsMU5JkSJqnFSce0u5qoPtmIQ0QgAHRkzIk3K2gIXlllnuVGgZY1Rk7pamX+P0Fs
 0WPS3Oq9kAujQ5Os9xa3FUV0WAwG8fWI446cM4j3RlwnrdkGSJRZ9hfkuAeohOas
 GvYcuet0cHGtTZ77OWT4ndb5Z1V4xYuLpqzswpUk0Fg6V1mLcHD5p3R1DHcJkgwV
 WsWDEg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn93en6pw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:52:36 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso3741781c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598756; x=1794203556;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=TJP/mPpICTlLZ9jnwz2siSezAtmzXezH2kDc6lGmwZXMqcugNiqbkEcTnWg7Kto6Zj
 TFXrxwQe4QG6p9CUwLZKb/aM7cBoyjhp+bFvQTx8X7m1dszxrh93XMvj95IMNYAnOwLh
 Mt1TWnPuTo15s7uSR4YrSmdwiAg1GKpLgLnAz5LBTBb15RRd8WhSb4cDxjYW9Qt47qul
 oiwkd2cnjbyalYgZG+hPDTplSI+jBlElGZjPhsGYNIQzRi8OZ+7PbzJmdqTKG7AWnGLO
 kwuxwg1dHsQRYboS1G+774Rh+VSSC9fCv85tOUw1E9H57HQzs3RB9Qb5LPeER4ISlxqy
 Kfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598756; x=1794203556;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=DWHv7yxlyI9LDS983EPw47ZpUuQvcg+7Uq6QnxYze4auOyHf1DxjhWo8nfVsSt5rPi
 rVuBWVssviQZzW75uolJEO8IZAQ8IYpqBpj10SY0BxiDCH5e0zup1u7YnXELaypgNuDO
 kowfRjzIzueQzT5q8TfxvAVBibLYsm8Ne+z5fa2gkLgUTOLP4h+dQed4q7AIREHJjmhJ
 9M09gMHCpeMPlGzpzWCy/xJMsr/Q2yf56QwguhVbs8ZupoquQn5nYYDG1iuqVWe2ffiu
 12Cu5j8TuXc+PSp4Qe9iqWserNxt5JScDjESGukeDxXxzYdoFXnBMXt2zPa8buIqvgxu
 sgnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBytvaixXjSFBzWTR5ebN98FBWDqHxDE+EW1Kt8kt+lKnPrm9iCvE+PL+BGNJppD3LFMEdWTCyg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKQQGY3xXrrQ048vZdDEsufm74j5Z0A+w1h+uW/ZcWEU5Pkduib
 SUgL5+5H6XEIlO4u0PjGDoPSAoc5GQsXQIVQcd4S7sLTBMZjNx0AZsMcnxXPZGBUIV7Zda2WKW+
 Y5kepFBhylYwJ3Wk/85ljhHakUAKKDVG21lmAUniFKimyAUokWeUK00J5EMA5DFxvXWjPUUA=
X-Gm-Gg: AYBFou0WNhtUSMBrs/hbdh0EUTkzHFQs0JvJWf5fC7A/2/cVrstEwMqtQQjM/zuwRg2
 qwkhvkXLmhiieKvKUlcdNbj/qtRMqvF4ZOLukjKlk4CmPkvtaYttf7il1X87xfqw5nb1nykIXng
 FtTpWtntKQFw+4ahHtTOJytgNVCQriw+3QU5747IvklXNNUWpqrdPkJplOq5OavCmlkFPER2CNE
 Ivm4fUWJfJClVKhnqb3Ap//n8F8EVE0W6rHSaPR3xtwj+RD0TKh4ssiyD7IQMekc/UnlDnEnvla
 uhN6FonaS3Z/QEkHLWBCxArSfn4prowj83AYxsPbcabP4HjBceJF5LWlIipl4w7OtkvRhPfc+Os
 a2DRDGmL8e+WOPz5VFImhzLtmcLCwT1m6MW91ka0HhA5QJl7AscKNepwnVM1aMxGMPpdLSAy2OD
 V6a9TSXiaqtVnLbCUSlEZaScDwN4bynjLxOtubW78PI35JsSmCUy9OaFzPpu8quCgmGbzxqnsHm
 EdxSw==
X-Received: by 2002:a05:701b:42c3:20b0:1b2:366a:e7d1 with SMTP id
 a92af1059eb24-1b2366ae854mr1044008c88.32.1793598755980; 
 Sun, 01 Nov 2026 21:52:35 -0800 (PST)
X-Received: by 2002:a05:701b:42c3:20b0:1b2:366a:e7d1 with SMTP id
 a92af1059eb24-1b2366ae854mr1043976c88.32.1793598755298; 
 Sun, 01 Nov 2026 21:52:35 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1dfsm35456366eec.7.2026.11.01.21.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:52:34 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:22:26 +0530
Subject: [PATCH RESEND v3 1/4] tools: qcom: mkmbn: Fix ipq5424 MBN version
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-ipq5210-v3-1-aacf3930848b@oss.qualcomm.com>
References: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
In-Reply-To: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX6yBDnn/M57Q7
 CiKDcu2vOEw9gIxCwqlwLfzcG34c7mMqzMUWauaAbM7XjB7BgTRZEdERD4hznSjEP9Yx6C2TkjA
 h3fLC8npfgrrkVVSdmAH4ME69nQLcYl95m6jzUWa24ZwDDKIbxLmt62K3E+1eJj93J7IPBznJqU
 kwpUjTWy4zEtdYCBsrruz1M8V3MEKBtkL+VfX44AYjdRwN8VaHbKh357hvgZ6br0zgBAyXKSb54
 eGcn6hQllqLAX8/pe9F9/rEA2OcsaHIIqBSOZAzBAM/4oqd1tuZMStN2+h3pKEK8rHwFH/gRj7P
 weqGa8rfUXXscbSvyxLN6noKmR5MBXdi7D51jH5O8cRHz9oDRwvaVbFGYLZ4aH1+U7QC4IM+GLJ
 LGaUNsRbogV4zFYvc+4kT4+vBshRNQJor4wu91I7+20di/0YfkhzKfImav0eGGdTInc7mlNtWaO
 4Q2k5Iuy1XqMyUPFBVA==
X-Authority-Analysis: v=2.4 cv=FciiV5+6 c=1 sm=1 tr=0 ts=6ae82524 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=5oOYJkjiZhHqBJ3UFLIA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: Uc0NTEzJfTnXNHhyfrkH3vUyL8xoXeOv
X-Proofpoint-GUID: Uc0NTEzJfTnXNHhyfrkH3vUyL8xoXeOv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX+BlxeGSgZ1IZ
 oZ5jrQmFKUVkU/DyyJCTvkUcgJ1fqpizaVeIzJMVj4deJTGmMYQzeebCuKAuzi2YFwMqUX1E4dk
 XL/RIF4ssLO+xYSDoB+yc6856qzIIVI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020023
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since ipq5424 uses MBN version 7, update the ipq5424 entry in the 'boards'
table accordingly.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index e4484b539b0..8d2078acc30 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -85,7 +85,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
     b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
-    b"qcom,ipq5424\0": MbnData(0x8a380000, 6, SwId.aboot),
+    b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same

-- 
2.34.1

