Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5687E606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ai7Oib1f;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iA9kLWiA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZV5UOgGm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B8FB60725;
	Mon, 26 Oct 2026 08:54:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ohzFtlm-D9a7; Mon, 26 Oct 2026 08:54:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 71E85606DC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793004866;
	b=pNIQBkTTDS8574xHv5C74sGQoW7d9RQWsElM/szarC/KkX5Tl5Px4VZ6S+9ypo+4Cz+1
	 nxLKCWxlLOR4OvJ21PFQC+jFKQ6C/8XToAqEBa+K5GMfTOW7Hpn+CPb9y/P5K4QUqu6uv
	 xt63514VJNk+bAocleHYUeHQAdW4KoDocetFlfF6vV8vdxlzfS4zWq5HSoUDHRBFQ8WDf
	 fFp+j8WwWrSyNm3ON2qA2fSOL7N0dojHZI5fRQ/4LqzzS1nzh3B7Gc8UQZjsX62e1Kv/G
	 tCzYdshOzjB75SlmyHaT4Fl7Cx7aeJAq8H75/mpy5zDW32Dx8lt5b1WclOiuxAqBL+g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793004866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tEYJXlyclRU8+cjG7EQF6vcR8TIWv8aEaifME5sWx74=;
	b=VUnMvkGb/Khhpvn1MjdogXfsHDmVEcLq6xwkAZGbD4pDN5lHT1vuxzrBPfXGzpbYIe4s
	 C6/fUb15jBNRxXgr7fPK0DaHzLrlVdR4A9NTrpHm/i2FH4AaW3pGr6Ym+LaoDrM6hD4o+
	 8ZDFDN+4UfA9V3DfObkxnLsQZIe9+CxTBkVqZPFemOGImYZhcC2I0q9G5uCqfG5d+QWTN
	 pQPbRXg70U3lYs0afPtBxZ6QOS0T9JXuyK0kcnhvzNpFb5jvlndOUlVBgtEH1nFDeO7cH
	 BFdliBHOlAVg/OrP0jciiWHGh37LD6S35SL0GOuoFVrASnrSmuSkfFve3NK21GUk7Cg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793004866;
	bh=tEYJXlyclRU8+cjG7EQF6vcR8TIWv8aEaifME5sWx74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ai7Oib1ffBvHl7S+YkMOnUFfAk4e96wfH2v3RaOvmeNpXAeSoBkf43rgiU99roedQ
	 b9gpqfm5kBWmfDEWaXh3ODrTm3P2xDrqnaQ14l/HMeEjdOnEcc6h8THw6J4N3fXvqT
	 IcsY+51CehdelzfrjIzlAxSOPCDbgv8nAsPYYR6aXBV+sxOvd+X3cWDbj3zlO7UQ9i
	 +OxNuDb1hZtQzTPttxEtOHf7r9ncCQnxqPxyiLOhecIpj+4npTPp9/mgIsq6XT6b5q
	 drit6f9YcCAblNjCakcMpDDLTrkeZsZ7AcJIsGnfvWoEYfm9XYnugOzv3u0DEsmlN0
	 qUiBuJHJif5bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71E85606DC;
	Mon, 26 Oct 2026 08:54:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BEB88334
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AFFEA4004D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:21:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bSY7nXlwUdf9 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 07:21:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5A75D40049
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792999313;
 b=qy+Yt62crUt5UtKm/Wy90ChSlDXq50/Pw3EhQWL/+0fBd9pfoBHqHFBPabVLaKKHUIcp
 1iJ/lWa26NIYTM6WXBHeBSw8+QSvrhAgt7NLPIHLsP6XaXITYD0Upaxxmhh0zl0yVnH7q
 0Qe0JJN7ASes+jMJ0uryzQqHuHuvmF6q/zZTTUoxPweadzrWCATZ+GdvZ1TqFetBb9o0x
 gpgS7803yklvxaduGCkXrG5ukv59TkfSFdMPp/EQfJpXurmpT+lLTbpMlV2Sg7jybo2ly
 q6kukqwHB1apyLT6XdparYKJmTsWUwLkSKW/+Zko/OMNeTMRhO3v/1AhIatGwLM4nKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792999313;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=tEYJXlyclRU8+cjG7EQF6vcR8TIWv8aEaifME5sWx74=;
 b=dwYh7cMMAKCy8u25gq6oPgk499OR2u4hZT4Ilv92f9T70Gh6+qejhVMIxGEfDZFidK8w
 1WeDgYidNzobprhC8spQHNP7knIUFK69UVZLKiueeXLbhZ2HmC4+OZpKoV2Z4AzFrfyO6
 O6LIPo44TJ4Q0IPSZZupgVF2QY4r+vprIeRLo9YXNkpCC3zDHUJrZoJGSuUc3LmTvl04Z
 jVkhm1O5ePzHLI65q1k/TJp0/V0aQ91TiM1rzOuFIm042RLJhshH+3cC4VdEOV8dbfMZT
 DhFDb2YabEiFvo5R8/FqezV1W74vt9u4/BMKtKNp9z2xgk+yF5GKk5GhMopAaCwGshg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=iA9kLWiA; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZV5UOgGm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=iA9kLWiA; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZV5UOgGm
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A75D40049
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:21:50 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aP2Y3300575
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tEYJXlyclRU8+cjG7EQF6vcR8TIWv8aEaifME5sWx74=; b=iA9kLWiAl+VGrk9J
 pZvd8bjxETQgoFEpT/Jbf+npm+wDteBvJxw0YL7WACmpXtvXmsRTVg8DmRfRLFMp
 VuBlrD+Z6kEXpEL5Hy37dJLogf/NLcDkIei+QNT/n1f6dQjI1BCuGxdPAtAIYqHp
 +s6u5hMMxKkhi7CaXN0ZJ1xnH3sJhTchQJlxzujw2CXdVEZ7t1Fit9yLY8IMeXX+
 UisYDFAoIKVH2pgmwiyDJnZ/Ze627QDpvNFqf5+eNAO7XH3BO+Vue2timycgKvU0
 TvtK9BugzW+GZsIi2Xwj4i4MwMV06fV34ZdQnkpKUDRuJGzsMKB1OnorPQd3gdog
 5onhyg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshps9wf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:21:49 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9901689384aso32245241.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792999309; cv=none;
 d=google.com; s=arc-20260327;
 b=nr3uamYJGHEB/6UURKNUU5Xk9j8LuL6RhpoQPNc5zR1ZQuQuDvcEgvf+0DuRkAYtYF
 SVYD/518ol7Qv24kcy698F/yvjFpP9XJkvcrMPWlzguSIm/NLFHqGVOUK5URyz/FcIVy
 uHz5H2FJ3riuj5NZHzkJ3KGtJGZ4uFa2PW7e/jBl544QDSHeE+kgoFB6K2dkg2xlq/Xy
 QsxYIkerTg44uj7N7z1+/gu1N7TPYU4NdbhLOVHsqKNCn/XmKewbL37Podi3yEzZS/bJ
 ynRx9JQyvVC5utCquIkWA9l0nMEMk4PHtMJr4QVtLtAn219a+J8eI7adopBcnuHb8pwm
 LniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tEYJXlyclRU8+cjG7EQF6vcR8TIWv8aEaifME5sWx74=;
 fh=0EkNQQZB6aL/O2XFtkCjO3oRWIHrCMXKkqmrhsva2ww=;
 b=maFVd7ctAFMPizkV6f3rHSG0LQgQymOm14FuzZrCeCHm4rByG8zp2l5Cl71P8+f26u
 UFnWxFALhbzm59/fo3qi5HdXMTYkSCzCjFx3JeJUcDS1btn7+T3QFQV430lW7gL0QmPo
 qr1bJAtYaTa/l6t2g7/qWkTWWjfW/iIa5ojQ/vVE1B3yqNfqarKf5yiDB6l+h8DggJyd
 wBe0JzVO5fsWproAGRnC4zpGyfEbvIscM95OtxPD7mb4oT4C5xV5a3i8CXIpw2eOmtr2
 xZQFSxbALGr2PpR9AHdhsqm4Y3d8ymtKndAJezyai/SHkP72NwZjldK7jDD5HTzbGuoa
 xhsA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792999309; x=1793604109;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tEYJXlyclRU8+cjG7EQF6vcR8TIWv8aEaifME5sWx74=;
 b=ZV5UOgGmzfI8jBunVxftg3QmTDsS7UzVZ8LZw+CspCzp3+a1x+th6XnwFu2dn6sNpP
 80S6EjyQt+ExkTWQglwSbBbVSV4+OdRUHzHTnHDDjEYYXc1J0BDs/OX0FCETU2Br9HrL
 /Ox6kJ+H9103sQQI8BWDJROAFf24zSROyLvPGTkn1ijL8miqQCEAJ3F3+n/M2qRBjKhA
 CyKo51PlXxGcA7YhNQlHKRdfzWkHTWAQ6srpCVv3Ql2URU+dRYzr5r0p2gs+Xc6rsves
 8XBgVYQu/0Xr8qiAu76UxP4FgqtSuHmvKJ5sjPX5J+ahi/0KG3YfwT1hEEKI8hdWD5gR
 o13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792999309; x=1793604109;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tEYJXlyclRU8+cjG7EQF6vcR8TIWv8aEaifME5sWx74=;
 b=u4W4TaI7mXqzrKHG/JAGxtwXpAYCvx8oRl90uITGdWfKX/trrSafmQevKNqBJ9pUJs
 BO8uNx9ngjitzt5hKRu23nfvJrEIgC8PgHzjGUjqme5S8+T9rd7lrSCoaVYa0lME6VPb
 PI1/tiUuPjD4uwQQDE89Xk+MCS4Yrgzee3Nurkju9MWgOmXER4LobMt0s1DULawvS3Sm
 OLi/DetNo6AKERaNy08qX2QnJUBcKwT9uh8DEoj1QfKftRxu7A+YAgq9SWAf2I4d7lvG
 fyDh62r0K5Ob7E7kNepOMH7Gxr9Gfw5WScQVYXcOzeJS91RM4Bk7wPdaZ7MUkTesV4dh
 ubBw==
X-Gm-Message-State: AFq9FYJ44snnmRDvAIb4yMlfhZ1PYfOxj+PUbYJiIjHyOjkcKWnFlGuY
 j+my0oIcSrRiYAAYqGvm101tElxtcTanyDJQBhJBTvk6l4H871k2b4h22YArqiBRcZx/9hvM/ai
 jiohhp4sv+IUq2BFvZPqVHPrnadIaBBLx/lbNRXpwmKUSm3AvoNjmo7ee3uVLArK6Y5EUT22g47
 zfydwpvn5lj6n3xAy9gLjVGqXngp7A5oSOglkZz35hr83TaQ==
X-Gm-Gg: AYBFou0+7ZgdspbQRgaejtWjUZwpzMiMXDsww/gYQoLXZYT4iGVESDqagptFE5c+9du
 0PyobXEQ8hWIScZm6v3z1shf4MXFde48o1hHGTi67bNTXg2XFV5TCaxs5oO7bs1A+nLeJe2N67r
 GEyMdEPhSxKBss6XTiU9B4cVAxB/26sfDAF8nWFs6/puIaigkDfNPhgL1gZGo=
X-Received: by 2002:a05:6102:a1cb:20b0:7cb:fef7:3763 with SMTP id
 ada2fe7eead31-7ce5cca7bc1mr1154407137.3.1792999308741; 
 Mon, 26 Oct 2026 00:21:48 -0700 (PDT)
X-Received: by 2002:a05:6102:a1cb:20b0:7cb:fef7:3763 with SMTP id
 ada2fe7eead31-7ce5cca7bc1mr1154396137.3.1792999308163; Mon, 26 Oct 2026
 00:21:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
 <20261014-rpmi_v4-v4-6-d53d34a49780@microchip.com>
In-Reply-To: <20261014-rpmi_v4-v4-6-d53d34a49780@microchip.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 12:51:37 +0530
X-Gm-Features: AclHuK8f1-5xHa2Irv3MIVwiXRLI-FfZLSbjOhqbCdNn-RURovFYmEtNfWOTeDs
Message-ID: <CAPxK-6frZ8xx5xzh-GVdd8drzjaEmH+HNew0mWNc4zY3kCBb4A@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] drivers: firmware: rpmi: Add the mpxy command
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyOSBTYWx0ZWRfX27EDhS8igm4f
 5HTQUTSQ788HU6kcPnsv/8Vpr+3+xCz9N7mdXZf0Rf2VsNqoMS20C1WdPR8OBDajdpvhy2kOPMr
 AGFz2FbxKba4+lsx7xAUg0FMOR00ZX4=
X-Proofpoint-GUID: TgsrSsRr-JMGThU4DpKvad5oqpYwPU5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyOSBTYWx0ZWRfX6P1eY7DxIMzY
 X61V9sWvy/cgKRgdOG1dRDyusSVlaW932ONLapVUiua3a41mfx87VlsxIfPzsMP9StHj9f2ND5H
 boh26IztXsPJSpZdX+utEF4/QvfoZM20UlyRdD0HYkJASGoMNHP5VuKAKwEWwbxpOBlD7iX6JCT
 ckiNFcHpn8QjzoVFX8S8TcJKiTLGcW1GcuDk6200PLxo8L3pKx5TI8kVMmjD+HkSWorz5VVjOx3
 uOancaEmhzeA3shcQ4hhxlOkk+8FAXLp/ffcRdvvejydVVCr9LkeuC2ehVH5Y3cZTizL6ZdD8VK
 3NO/uuXVDP5han64vJLbJKI5zK/13DnkqhlsHJe1zFksr3+/rvUn8HYvPdheIyDPA8CR9JGHOQO
 JMPXFh6rAmI9qZKR0stFgN9ODwJtm8NspCLK2tmUagLu5V32wxUtZAlTxctlqld9LsIRQkN6/Bj
 lR/RXjxfmRITzHjiElw==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adeff8e cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8 a=XYAwZIGsAAAA:8 a=EUspDBNiAAAA:8
 a=7sgoVQ89rOCltnI_w2UA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: TgsrSsRr-JMGThU4DpKvad5oqpYwPU5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260029
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:54:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Charles,

On Wed, Oct 14, 2026 at 7:47=E2=80=AFPM Charles Perry
<charles.perry@microchip.com> wrote:
>
> From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
>
> Add the mpxy command which allows listing MPXY channels, reading/writing
> arbitrary channel attributes and sending raw messages.
>
> The mpxy command is useful for interacting with custom RPMI service group=
s
> that have no associated driver. It can also be useful for debugging and
> testing SBI proxy drivers as well as the PuC firmware.
>
> Signed-off-by: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
> Changes in v4:
>  - Force a device_probe() of all UCLASS_RPMI devices if g_mpxy is NULL
>  - Remove the unnecessary edit to "cmd/riscv/Makefile"
>  - Fix a printf placeholder for 32 bits %ld -> %zu
>
> Changes in v3:
>  - Add this patch
> ---
>  drivers/firmware/rpmi/Kconfig         |   7 +
>  drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 404 ++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 407 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfi=
g
> index b462d3693987..c6a6b6fe61de 100644
> --- a/drivers/firmware/rpmi/Kconfig
> +++ b/drivers/firmware/rpmi/Kconfig
> @@ -18,6 +18,13 @@ config RPMI_SBI_MPXY
>           specification for the MPXY extension is available at:
>           https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
>
> +config CMD_MPXY
> +       bool "mpxy command"
> +       depends on RPMI_SBI_MPXY
> +       help
> +         Enable the 'mpxy' U-Boot command for listing MPXY channels,
> +         reading/writing arbitrary channel attributes and sending raw me=
ssages.
> +
>  config RPMI_SHMEM
>         bool "RPMI over shared memory transport"
>         depends on RPMI_FIRMWARE
> diff --git a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c b/drivers/firmware/rpm=
i/rpmi-sbi-mpxy.c
> index 9ccca0eb59b2..5f01a6303323 100644
> --- a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> +++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + * Copyright (c) 2026, Rahul Pathak <rahul.pathak@oss.qualcomm.com>
>   */
>
>  #define LOG_CATEGORY UCLASS_RPMI
> @@ -16,6 +17,7 @@
>  #include <malloc.h>
>  #include <rpmi-uclass.h>
>  #include <string.h>
> +#include <dm/device-internal.h>
>
>  /* SBI MPXY channel IDs data in shared memory */
>  struct sbi_mpxy_channel_ids_data {
> @@ -60,10 +62,10 @@ enum sbi_mpxy_attribute_id {
>
>  /* RPMI message protocol specific MPXY attributes */
>  enum sbi_mpxy_rpmi_attribute_id {
> -       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID,
> -       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
> -       SBI_MPXY_RPMI_ATTR_IMPL_ID,
> -       SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
> +       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID =3D 0x00,
> +       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION =3D 0x01,
> +       SBI_MPXY_RPMI_ATTR_IMPL_ID =3D 0x02,
> +       SBI_MPXY_RPMI_ATTR_IMPL_VERSION =3D 0x03,
>         SBI_MPXY_RPMI_ATTR_MAX_ID
>  };
>
> @@ -87,6 +89,24 @@ struct rpmi_sbi_mpxy {
>         struct sbi_mpxy_chan_desc *channel_descs;
>  };
>
> +static struct rpmi_sbi_mpxy *g_mpxy;
> +
> +static __maybe_unused struct rpmi_sbi_mpxy *mpxy_get_global(void)
> +{
> +       struct udevice *dev;
> +       struct uclass *uc;
> +
> +       if (!g_mpxy) {
> +               uclass_get(UCLASS_RPMI, &uc);
> +               uclass_foreach_dev(dev, uc)
> +               {
> +                       device_probe(dev);
> +               }
> +       }
> +
> +       return g_mpxy;
> +}
> +
>  static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 chan=
nel_id,
>                                     u32 base_attrid, u32 attr_count,
>                                     u32 *attrs_buf)
> @@ -105,6 +125,24 @@ static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_=
mpxy *mpxy, u32 channel_id,
>         return 0;
>  }
>
> +static __maybe_unused int
> +rpmi_sbi_mpxy_write_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
> +                         u32 base_attrid, u32 attr_count, u32 *attrs_buf=
)
> +{
> +       struct sbiret sret;
> +       int i;
> +
> +       for (i =3D 0; i < attr_count; i++)
> +               ((__le32 *)mpxy->shmem)[i] =3D cpu_to_le32(attrs_buf[i]);
> +
> +       sret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_WRITE_ATTRS, channe=
l_id,
> +                        base_attrid, attr_count, 0, 0, 0);
> +       if (sret.error)
> +               return sbi_to_linux_error(sret.error);
> +
> +       return 0;
> +}
> +
>  static int rpmi_sbi_mpxy_send_message(void *shmem, u32 mpxy_fid, u32 cha=
nnel_id,
>                                       u32 msg_id, const void *tx,
>                                       unsigned long tx_len, void *rx,
> @@ -368,6 +406,8 @@ static int rpmi_sbi_mpxy_probe(struct udevice *dev)
>                             desc->attrs[SBI_MPXY_ATTR_MSG_MAX_LEN]);
>         }
>
> +       g_mpxy =3D mpxy;
> +
>         return 0;
>
>  err:
> @@ -408,3 +448,359 @@ U_BOOT_DRIVER(rpmi_sbi_mpxy) =3D {
>         .ops =3D &rpmi_sbi_mpxy_ops,
>         .flags =3D DM_FLAG_PRE_RELOC,
>  };
> +
> +#if CONFIG_IS_ENABLED(CMD_MPXY) && !CONFIG_IS_ENABLED(XPL_BUILD)
> +
> +#include <command.h>
> +#include <hexdump.h>
> +
> +static const char *mpxy_proto_to_str(u32 proto_id)
> +{
> +       switch (proto_id) {
> +       case SBI_MPXY_MSGPROTO_RPMI_ID:
> +               return "RPMI";
> +       default:
> +               return "Unknown";
> +       }
> +}
> +
> +/**
> + * mpxy list
> + *
> + * List the mpxy channels
> + */
> +static int do_mpxy_list(struct cmd_tbl *cmdtp, int flag, int argc,
> +                       char *const argv[])
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D mpxy_get_global();
> +       struct sbi_mpxy_chan_desc *chan;
> +       u32 proto;
> +       int i;
> +
> +       if (!mpxy)
> +               return CMD_RET_FAILURE;
> +
> +       for (i =3D 0; i < mpxy->channel_count; i++) {
> +               chan =3D &mpxy->channel_descs[i];
> +               proto =3D chan->attrs[SBI_MPXY_ATTR_MSG_PROT_ID];
> +               printf("Channel 0x%x: proto_id=3D0x%x (%s), ver=3D0x%x\n"=
, chan->id,
> +                      proto, mpxy_proto_to_str(proto),
> +                      chan->attrs[SBI_MPXY_ATTR_MSG_PROT_VER]);
> +       }
> +
> +       printf("sbi_mpxy: found %d channels\n", mpxy->channel_count);
> +       return CMD_RET_SUCCESS;
> +}
> +
> +static void mpxy_print_capability(u32 val)
> +{
> +       static const struct {
> +               u32 bit;
> +               const char *name;
> +       } caps[] =3D {
> +               { SBI_MPXY_CHAN_CAP_MSI, "MSI" },
> +               { SBI_MPXY_CHAN_CAP_SSE, "SSE_EVENT" },
> +               { SBI_MPXY_CHAN_CAP_EVENTS_STATE, "EVENTS_STATE" },
> +               { SBI_MPXY_CHAN_CAP_SEND_WITH_RESP, "SEND_WITH_RESP" },
> +               { SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP, "SEND_WITHOUT_RESP=
" },
> +               { SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS, "GET_NOTIFICATIONS=
" },
> +       };
> +
> +       bool any =3D false;
> +       int i;
> +
> +       printf(" (");
> +
> +       if (!val) {
> +               printf("none)\n");
> +               return;
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(caps); i++) {
> +               if (val & caps[i].bit) {
> +                       if (any)
> +                               printf("|");
> +                       printf("%s", caps[i].name);
> +                       any =3D true;
> +               }
> +       }
> +       printf(")\n");
> +}
> +
> +/* Decode well-known field values for selected standard attributes */
> +static void mpxy_print_std_attr(u32 attr_id, u32 val)
> +{
> +       /* Standard MPXY attribute names, indexed by attr_id */
> +       static const char *const mpxy_std_attr_names[] =3D {
> +               [SBI_MPXY_ATTR_MSG_PROT_ID] =3D "MSG_PROT_ID",
> +               [SBI_MPXY_ATTR_MSG_PROT_VER] =3D "MSG_PROT_VER",
> +               [SBI_MPXY_ATTR_MSG_MAX_LEN] =3D "MSG_MAX_LEN",
> +               [SBI_MPXY_ATTR_MSG_SEND_TIMEOUT] =3D "MSG_SEND_TIMEOUT",
> +               [SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT] =3D
> +                       "MSG_COMPLETION_TIMEOUT",
> +               [SBI_MPXY_ATTR_CHANNEL_CAPABILITY] =3D "CHANNEL_CAPABILIT=
Y",
> +               [SBI_MPXY_ATTR_SSE_EVENT_ID] =3D "SSE_EVENT_ID",
> +               [SBI_MPXY_ATTR_MSI_CONTROL] =3D "MSI_CONTROL",
> +               [SBI_MPXY_ATTR_MSI_ADDR_LO] =3D "MSI_ADDR_LO",
> +               [SBI_MPXY_ATTR_MSI_ADDR_HI] =3D "MSI_ADDR_HI",
> +               [SBI_MPXY_ATTR_MSI_DATA] =3D "MSI_DATA",
> +               [SBI_MPXY_ATTR_EVENTS_STATE_CONTROL] =3D "EVENTS_STATE_CO=
NTROL",
> +       };
> +
> +       printf("  [0x%02x] %-28s: 0x%08x", attr_id,
> +              mpxy_std_attr_names[attr_id], val);
> +
> +       switch (attr_id) {
> +       case SBI_MPXY_ATTR_MSG_PROT_ID:
> +               printf(" (%s)\n", mpxy_proto_to_str(val));
> +               break;
> +       case SBI_MPXY_ATTR_MSG_PROT_VER:
> +               printf(" (v%u.%u)\n", (val >> 16) & 0xffff, val & 0xffff)=
;
> +               break;
> +       case SBI_MPXY_ATTR_MSG_MAX_LEN:
> +               printf(" (%u bytes)\n", val);
> +               break;
> +       case SBI_MPXY_ATTR_MSG_SEND_TIMEOUT:
> +       case SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT:
> +               printf(" (%u ms)\n", val);
> +               break;
> +       case SBI_MPXY_ATTR_CHANNEL_CAPABILITY:
> +               mpxy_print_capability(val);
> +               break;
> +       default:
> +               printf("\n");
> +               break;
> +       }
> +}
> +
> +static const char *mpxy_rpmi_proto_attr_name(u32 attr_id)
> +{
> +       switch (attr_id) {
> +       case SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID:
> +               return "SERVICEGROUP_ID";
> +       case SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION:
> +               return "SERVICEGROUP_VERSION";
> +       case SBI_MPXY_RPMI_ATTR_IMPL_ID:
> +               return "IMPLEMENTATION_ID";
> +       case SBI_MPXY_RPMI_ATTR_IMPL_VERSION:
> +               return "IMPLEMENTATION_VER";
> +       default:
> +               return "UNKNOWN";
> +       };
> +}
> +
> +static void mpxy_print_proto_attr(u32 attr_id, u32 val, bool is_rpmi)
> +{
> +       u32 rpmi_attr_id =3D attr_id - SBI_MPXY_ATTR_MSGPROTO_ATTR_START;
> +       const char *name =3D is_rpmi ? mpxy_rpmi_proto_attr_name(rpmi_att=
r_id) :
> +                                    "UNKNOWN";
> +
> +       printf("  [0x%08x] %-24s: 0x%08x", attr_id, name, val);
> +
> +       if (is_rpmi &&
> +           (rpmi_attr_id =3D=3D SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION =
||
> +            rpmi_attr_id =3D=3D SBI_MPXY_RPMI_ATTR_IMPL_VERSION)) {
> +               printf(" (v%u.%u)\n", (val >> 16) & 0xffff, val & 0xffff)=
;
> +       } else {
> +               printf("\n");
> +       }
> +}
> +
> +/**
> + * mpxy readattr <channel_id> <attr_id>
> + *
> + * Read the attribute on a channel
> + */
> +static int do_mpxy_readattr(struct cmd_tbl *cmdtp, int flag, int argc,
> +                           char *const argv[])
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D mpxy_get_global();
> +       u32 chan_id, attr_id, attr_val;
> +       int ret;
> +
> +       if (argc < 3)
> +               return CMD_RET_USAGE;
> +
> +       if (!mpxy)
> +               return CMD_RET_FAILURE;
> +
> +       chan_id =3D simple_strtoul(argv[1], NULL, 0);
> +       attr_id =3D simple_strtoul(argv[2], NULL, 0);
> +
> +       ret =3D rpmi_sbi_mpxy_read_attrs(mpxy, chan_id, attr_id, 1, &attr=
_val);
> +       if (ret) {
> +               printf("Read attr 0x%x on channel 0x%x failed (%d)\n", at=
tr_id,
> +                      chan_id, ret);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       printf("Channel 0x%x: attr[0x%x] =3D 0x%x\n", chan_id, attr_id, a=
ttr_val);
> +       return CMD_RET_SUCCESS;
> +}
> +
> +/**
> + * mpxy readattrall <channel_id>
> + */
> +static int do_mpxy_readattr_all(struct cmd_tbl *cmdtp, int flag, int arg=
c,
> +                               char *const argv[])
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D mpxy_get_global();
> +       u32 chan_id, attr_val[SBI_MPXY_ATTR_STD_ATTR_MAX_IDX];
> +       bool is_rpmi;
> +       int i, ret;
> +
> +       if (argc < 2)
> +               return CMD_RET_USAGE;
> +
> +       if (!mpxy)
> +               return CMD_RET_FAILURE;
> +
> +       chan_id =3D simple_strtoul(argv[1], NULL, 0);
> +
> +       ret =3D rpmi_sbi_mpxy_read_attrs(mpxy, chan_id, SBI_MPXY_ATTR_MSG=
_PROT_ID,
> +                                      SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
> +                                      attr_val);
> +       if (ret) {
> +               printf("Read attr on channel 0x%x failed (%d)\n", chan_id=
, ret);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       /* Standard attributes */
> +       printf("Channel 0x%x standard attributes:\n", chan_id);
> +       for (i =3D 0; i < SBI_MPXY_ATTR_STD_ATTR_MAX_IDX; i++)
> +               mpxy_print_std_attr(i, attr_val[i]);
> +
> +       /* Protocol-specific attributes */
> +       printf("Channel 0x%x protocol attributes:\n", chan_id);
> +
> +       for (i =3D SBI_MPXY_ATTR_MSGPROTO_ATTR_START;
> +            i < SBI_MPXY_ATTR_MSGPROTO_ATTR_END; i++) {
> +               ret =3D rpmi_sbi_mpxy_read_attrs(mpxy, chan_id, i, 1,
> +                                              &attr_val[0]);
> +               if (ret)
> +                       break;
> +
> +               is_rpmi =3D mpxy->channel_descs[chan_id]
> +                                 .attrs[SBI_MPXY_ATTR_MSG_PROT_ID] =3D=
=3D
> +                         SBI_MPXY_MSGPROTO_RPMI_ID;
 `chan_id` is an external MPXY channel ID, not necessarily the descriptor
 array index. The descriptors are stored by discovery position, so a valid
 non-contiguous channel ID can cause an out-of-bounds read here. Please res=
olve
 the channel ID to its descriptor index before accessing `channel_descs`.

 Regards,
 Subrahmanya

> +               mpxy_print_proto_attr(i, attr_val[0], is_rpmi);
> +       }
> +
> +       return CMD_RET_SUCCESS;
> +}
> +
> +/**
> + * mpxy writeattr <channel_id> <attr_id> <value>
> + */
> +static int do_mpxy_writeattr(struct cmd_tbl *cmdtp, int flag, int argc,
> +                            char *const argv[])
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D mpxy_get_global();
> +       u32 chan_id, attr_id, attr_val;
> +       int ret;
> +
> +       if (argc < 4)
> +               return CMD_RET_USAGE;
> +
> +       if (!mpxy)
> +               return CMD_RET_FAILURE;
> +
> +       chan_id =3D simple_strtoul(argv[1], NULL, 0);
> +       attr_id =3D simple_strtoul(argv[2], NULL, 0);
> +       attr_val =3D simple_strtoul(argv[3], NULL, 0);
> +
> +       ret =3D rpmi_sbi_mpxy_write_attrs(mpxy, chan_id, attr_id, 1, &att=
r_val);
> +       if (ret) {
> +               printf("Write attr 0x%x on channel 0x%x failed (%d)\n", a=
ttr_id,
> +                      chan_id, ret);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       printf("Channel 0x%x: attr[0x%x] written 0x%x\n", chan_id, attr_i=
d,
> +              attr_val);
> +       return CMD_RET_SUCCESS;
> +}
> +
> +/**
> + * mpxy send <channel_id> <msg_id> [payload_word ...]
> + *
> + * For RPMI, msg_id is the service_id. Payload words follow.
> + */
> +static int do_mpxy_send(struct cmd_tbl *cmdtp, int flag, int argc,
> +                       char *const argv[])
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D mpxy_get_global();
> +       u32 tx[64];
> +       u32 rx[64];
> +       unsigned long tx_words, rx_bytes;
> +       u32 chan_id, service_id;
> +       int i, ret;
> +
> +       if (argc < 3)
> +               return CMD_RET_USAGE;
> +
> +       if (!mpxy)
> +               return CMD_RET_FAILURE;
> +
> +       chan_id =3D simple_strtoul(argv[1], NULL, 0);
> +       service_id =3D simple_strtoul(argv[2], NULL, 0);
> +       tx_words =3D argc - 3;
> +
> +       if (tx_words > ARRAY_SIZE(tx)) {
> +               printf("Too many words (max %zu)\n", ARRAY_SIZE(tx));
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       for (i =3D 0; i < tx_words; i++)
> +               tx[i] =3D simple_strtoul(argv[3 + i], NULL, 0);
> +
> +       ret =3D rpmi_sbi_mpxy_send_message(mpxy->shmem,
> +                                        SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
> +                                        chan_id, service_id, tx, tx_word=
s * 4,
> +                                        rx, sizeof(rx), &rx_bytes);
> +       if (ret) {
> +               printf("Send on channel 0x%x failed (%d)\n", chan_id, ret=
);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       printf("Response (%ld word(s)):\n", rx_bytes / 4);
> +       print_hex_dump(" ", DUMP_PREFIX_OFFSET, 4, 4, rx, rx_bytes, true)=
;
> +
> +       return CMD_RET_SUCCESS;
> +}
> +
> +/**
> + * Subcommand table and top-level dispatch
> + */
> +static struct cmd_tbl cmd_mpxy_sub[] =3D {
> +       U_BOOT_CMD_MKENT(list, 1, 0, do_mpxy_list, "", ""),
> +       U_BOOT_CMD_MKENT(readattr, 3, 0, do_mpxy_readattr, "", ""),
> +       U_BOOT_CMD_MKENT(readattrall, 2, 0, do_mpxy_readattr_all, "", "")=
,
> +       U_BOOT_CMD_MKENT(writeattr, 4, 0, do_mpxy_writeattr, "", ""),
> +       U_BOOT_CMD_MKENT(send, CONFIG_SYS_MAXARGS, 0, do_mpxy_send, "", "=
"),
> +};
> +
> +static int do_mpxy(struct cmd_tbl *cmdtp, int flag, int argc,
> +                  char *const argv[])
> +{
> +       struct cmd_tbl *c;
> +
> +       if (argc < 2)
> +               return CMD_RET_USAGE;
> +
> +       c =3D find_cmd_tbl(argv[1], cmd_mpxy_sub, ARRAY_SIZE(cmd_mpxy_sub=
));
> +       if (!c)
> +               return CMD_RET_USAGE;
> +
> +       return c->cmd(cmdtp, flag, argc - 1, argv + 1);
> +}
> +
> +U_BOOT_CMD(
> +       mpxy, CONFIG_SYS_MAXARGS, 0, do_mpxy, "SBI MPXY channel debug com=
mands",
> +       "list                              - list discovered channels\n"
> +       "mpxy readattr    <chan> <attr>         - read one attribute\n"
> +       "mpxy readattrall <chan>                - read all attributes\n"
> +       "mpxy writeattr   <chan> <attr> <val>   - write an attribute\n"
> +       "mpxy send        <chan> <msg_id> [payload_word ...]  - send mess=
age\n");
> +
> +#endif // CONFIG_CMD_MPXY
>
> --
> 2.53.0
>
