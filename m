Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3309A606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qlo6cErl;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GcT6Y7Uo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PM8zCVYk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05DB140642;
	Mon,  2 Nov 2026 05:49:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u_eA6otXwKAX; Mon,  2 Nov 2026 05:49:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2B65D40639
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598550;
	b=B4bTr4nB5n5a4ljF0x1NfZK0ib2fbFxvu2tmMyd+UMje5RLA3HLlCX/GzKCj7OHaJi2R
	 ad3Bljq/7EloTtUtEJwCX+jRH2fLYVTdOk+90r39/spY6fJT3OCV/Cn16Xs0kYyB6diqg
	 26yt6Q+Ie29IVcmDJRByfqCmsXsVaZSKj43ckE/c3h3tH781p+B5DBmwlo4VkNmXt0HTH
	 givcSMLadNXfjwdiJsdRjyG60h1ZTlmL7gekpq4P9cNlbl6ZWezwggWIPxFrvA9rXC7Of
	 4PQ5+rYb2Spk3rehpQKpDX1aC0HNxRi5CnuVKeQe7zNnsVcXXq9Gd8DTeItPeYWpeFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
	b=pLteMf/H1PYvvBRyxfYdMlVLXWin9nrOwEmxwVUgjCaOumP8D2BJOPGKeeSTcH0U1YxY
	 mnvfafQYuud7XXELKusXdHShUrpEck6C0HU/xkeq09znyFtlFdTDd91iur05bwhaLGKHh
	 i5pev3AYPeHi3cMbrb/napaildVzGNgkUjjEn+qF91dIa3NAFUG3hAugeyEBKTwwYmhJT
	 c1P8bYbg+44/ZhYU1pp3Hh36CwH1uuxSqILuHd1dX4N3sN1zSo6LCna8wtmNtVukv5k53
	 uYGqzNtLf+I8mr576oj5UtQbDTCE2Z5zwDMGrJkc7mbrsafqhojmfD3rrk4fn0DQEsg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GcT6Y7Uo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PM8zCVYk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598550;
	bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qlo6cErlT2Jd7wvVVZUY9zjfAR9XTpmvHDVQ7pJ9yj5VHQI9jCqWKMoFJ2TQzg1g9
	 tMVIRYQCfn6lUYMR8Wue237euwVJcAvzIMSXMwExpVAX5a6nXh5X25bYarIy5pwPNM
	 DaQAT9mUqoF6g/dgj0NksgGu2UQ1nzRCXlxpl1IQyowhOwBwcEW4Sljzs0e8l6rdLX
	 VrWGt4nf+BFgbyVqCYf+mRqaY1M29Qj0Z035NAyXbtGftCtrMlT6vmgRm+50EQNbej
	 0Rnu69Alj63tQCmX4HhUlFRklEWyRnsB9mvbNrs/T92bvoJWPByS/JMm/VE4kzdIIn
	 qQOrOKIB5bFDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B65D40639;
	Mon,  2 Nov 2026 05:49:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 801802A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71D2A40639
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRUBk6poDhYa for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:49:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D234640632
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598548;
 b=RJAe4/loaJPHKaQFT21sHK3r8f5VWqJtXx/MVPgWeRLm8XkAxpDfxbXKyue8EvRUpv+s
 UuaIZK1qhUNdmVivPTY73+B0XE+4p64MBMZ3ocW8MZ7eSV4DPLomANx/lSQnZbJMqVlHi
 ren6HyE25RVdzh8aERLNi6Z8GeWn8k7Zl4+LJEhmgKHXHilFiaCp8oEO4RAmmf9RQ6nXr
 ajxloTUd9u2ohK5Ws4QmTJjRTL46nsiy2MbfPfQEjhAZohynOx+7QrlK0eKcv408tlT/6
 +iEW9R+1eWmiNrELilElszy4KJ+7u3hIkzU6+/r9fYTuupJOWlHv/G4/D15jYECGlGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598548;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
 b=rdw1iIZ3InEVVbEdMUC5L9xjq6xt14VjanWBAGNmTa0YK3LyyeqxdW29zllmsxCXtCbf
 SUfRpFDR6iyponPVCixM9a5KrGKKQRh9o9PSF0+ayT6P2Uzy/qWdv5D6i35tRM2URE3j1
 c8vz/nUCDm2NkRee/heGkG+VFP152ONwHQ6gz+hw9uwIBHUig37sTUwh8QIEFR9B8HwrW
 B/dFnHygQwKhBeMFs7sTuT6uvBXRMaGSuMVSPaIvCrpQFCKMvZ1XbIJPRAUQNB9WcJuSj
 /cBghMyRax6InPETUE5syumrMUTtYyL90X52sa4AdUMsHafbfebPlUcLpNujVlRTV4Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=GcT6Y7Uo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PM8zCVYk; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=GcT6Y7Uo; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PM8zCVYk
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D234640632
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:49:08 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A23vfbT2716183
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=; b=GcT6Y7UowS2a4snH
 Hvz+npxHWTMkNQK48w5v/vF/B1erUBmvXAeTOAmB7x+UI30i0X/G84DCsM3YzRNy
 nhqPaI8oi3o6SP0CKUmj0LzTFZktltMMF+p2u+S1c2mbPqoPmlcY56Kww6OGMM6E
 ioUFb8C7XT8gtkhRtgvCr/zBrfr2xnGHJ9Kh/J/55/98xfaAwhLWDyAOdJo+6IRB
 GHuYBrD+l0QlyWnbW8clzWqO3AO7GyGlAcaMytDNRcixwWDCpgYIBjHjDuAVNCCt
 s7cZoFt0LGUmMu+kXn9nfn6LmmWm5Usa+ArNMQ8+I+sP9SsnnXw7912W10gHJZSY
 5s1+sA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8j2wbd6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:49:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3425098ae4bso5806785eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598547; x=1794203347;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
 b=PM8zCVYkKkt+/JQuljlTDTtVFRFKZaHg23LQahjX2T9X+fMvn792YFrOabZjC6myoA
 UaWRslaAIuZsHv51suCii8IA/RJeEogoHoLUkunHs8nPneE5TGBd7ErobcBqhLeNM73Z
 1VJrbvU5uSp7zPpejZccQXIzp8P7gXgQC+l5nHmsmu1oRLqiZzujUYfCu0LDykg1myoY
 cb0UaFl16ogFyhlPtun0ZfkDKK4HLTMDIm/NzO9Krds8F58Ru0A0y+e/zU71qyMAUi3f
 cSz+hDibckzUrFWQzZi1ywcZcBhRizjHtEm9bSIANbMyzESc0oJyQaGM9EBgjy/5U+18
 fk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598547; x=1794203347;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X+3rcfp2uolGX03DvOFESOO6mo2XENhYY4k+K8cOtEI=;
 b=dsGxVeR3HyQ+uL6VKXFE+g+A4a0Qsd3VRsk41DB5tCOvvGFmaPQsW6H0Q0jgLwhfKL
 xQ0o30KoXRQMUhOGZju9ujZuR5leZ+rnU+t1N+fFodkwr4oK1Y7adBtPgNqtreJphalv
 zMWA2Zzm9iy15QcXh4gzkhQ9tc20PygGqTJZ62XgoJkpG8zPcGbbl4PI8IEYEryAVM4p
 BdT06v8pxF79zOUGSLp0gflGRSTgbkrJfxtgMS8iQc/uaCX/yhXMnVM3FPfjI5Ea3gsm
 k3k552n1eKv3M5UiYoCPJScpbOwDT5Z/Co/bFOSe3jtMOQKI4IZAL28C8VXXTq2Le4iP
 bg1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWASIKghkAv/MpPIVMQ6JdUkw+sRUyVr9jbTPZXAAkeKyAA6NUPq7qVE+I7MfIh/tJEtcPwaw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIEhLCYhQPIiKn0SMLfFI+O7Sz1H48uqR1YSrK5SRq108sa19fW
 f9ERyJ5B988h/4/yf1I98HSZbSDqQfVNu4h3mE/MkMhgtXZ566FSbeTq7Zi9NfRZb5m97miYnC+
 W89U2N1AIRE6Qxq6ythWA4sI+D7tnV/Yb5qHQY30rymY4BgRlU++pYb43HF3IPiDmt45O4KE=
X-Gm-Gg: AYBFou3445swGJtdCHdFix3Y2DCJuulT9Z6EsfzYUGBusHYNyBiGbds3IJF7T8kK3Bi
 25rink5WT4koy4FpJMnm/5T/7X5QX89/um8zbjjFKMHCw5ZpDl+fwumfWSuJq1b3m9GFg0o/8xz
 hKTh4UqCbBDh+JRxxDSYSBz8SlWQ4INW+EvMmC7iAQ/JhyKU3F1yUvtfWCdcsjMk0l+8EL68aDH
 b7SuoUOZA3euwAWjn557BU5EukCw+PV6Rt5NVhGemCvNiJh0basmelpAUdNL/8ziX4DC5JNsktN
 jBXTOHkMtaFyflY80sNjQTClnlbCebVNDFprfHqBk9dOWYnNdauRjPh+FyHYDzxdkfgO9SavNdb
 lYh1H8UU/zMkxvDgcHBlHcEk9ycMNcohdv1COoOU/MXNbjfDEsxPkBHp0eGmsFeoT2bmn9zm37v
 yikzIvWmKIEQdUC2s87XZaD+gPxK5Qy2syrPX6jWwFSfJ8kuBZwzdtScZhzb1VZGLIppj04AKu5
 8rtaQ==
X-Received: by 2002:a05:701b:4286:20b0:152:dd1b:4fa7 with SMTP id
 a92af1059eb24-1ac5bda456bmr13626571c88.19.1793598546744; 
 Sun, 01 Nov 2026 21:49:06 -0800 (PST)
X-Received: by 2002:a05:701b:4286:20b0:152:dd1b:4fa7 with SMTP id
 a92af1059eb24-1ac5bda456bmr13626499c88.19.1793598545979; 
 Sun, 01 Nov 2026 21:49:05 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm28960066c88.12.2026.11.01.21.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:49:05 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:18:34 +0530
Subject: [PATCH RESEND v10 02/15] mach-snapdragon: Kconfig: Auto select
 options based on configs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spl-v10-2-224d421c6201@oss.qualcomm.com>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
In-Reply-To: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: rpuelMyT368sihOCxf73DWqwDXxjZ0Pr
X-Proofpoint-ORIG-GUID: rpuelMyT368sihOCxf73DWqwDXxjZ0Pr
X-Authority-Analysis: v=2.4 cv=S5RMU4sP c=1 sm=1 tr=0 ts=6ae82453 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=BYZ-A9fJ0MEHusibbq4A:9 a=RW3EtsfI09ntgIjO:21
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX+fdI3+DxFBmO
 PeJqXODLlJS8/6y98FAtWHioQy7kU9vcHxA3iG85VtjuLMo87CVCiO/s9E0NoES0bjZe4vdocKS
 JcBPJsAEW6mAgLpNTuMHs2+mEc3Djjo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMiBTYWx0ZWRfX3UyyEGOJfI1H
 o7na35q40iCGNGgk5gUwGHWfN0+phHWtS47+/eW30iyqSfJr1t8JOuVurEi10ET9+XQBFU2J7ve
 bRILpgaBtE5rMaP7Sd27dVaYs9Pmw2SfdbjRVTFtqNaRePkc+haBv7Sg1KDU4Q7x7su6CdiVlnz
 VYshxR/4vNf7v4vH8MOdNtTjc/zrRNJffgs2YA4hek7O5yIEKwEIJgWkGvoPNyFRgrT3LqBXahE
 iNz0gRXsQenw06x7EyMK8ZtgU7asV75fWxTErolIYYVRH1tmExdtqwfXZQ1HsIwSsX0l4ZwC8fR
 WLMljVEkVuxxaPiD2PP1hrhzJ/U5eZFVscfKY607vvbFwM4+Uxyr2t9q9NEsG0rvDM2XGHuHhvp
 pnKuA5FoCcW5QkmDNf50x/1eSXr0PFMEMswY+ixE7KmN9gnY4VqNLvyC7UykjOHWb9c81aqzW91
 GJvrTW3R99Q1dCUPQiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020022
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The commit d38787bb5dafa ("mach-snapdragon: Kconfig: changes / additions to
support SPL") auto selects options that may not be applicable to all
platforms. This results in warning messages during make xxx_defconfig
and/or waiting for user input for on/off or values for certain configs.
So auto select options based on the enabled configs in xxx_defconfig.

Fixes: d38787bb5dafa ("mach-snapdragon: Kconfig: changes / additions to support SPL")

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f307340e3aa..51d60ef65fe 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1147,8 +1147,8 @@ config ARCH_SNAPDRAGON
 	select SPMI
 	select BOARD_LATE_INIT
 	select OF_BOARD
-	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
-	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
+	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
+	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
 	select SYSRESET
 	select SYSRESET_PSCI if !SPL
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
@@ -1161,12 +1161,12 @@ config ARCH_SNAPDRAGON
 	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
 	select SPL_DM if SPL
 	select SPL_DM_GPIO if SPL
-	select SPL_DM_PMIC if SPL
-	select SPL_DM_USB_GADGET if SPL
+	select SPL_DM_PMIC if SPL && DM_PMIC
+	select SPL_DM_USB_GADGET if SPL && USB
 	select SPL_ENV_SUPPORT if SPL
 	select SPL_EVENT if SPL
 	select SPL_GPIO if SPL
-	select SPL_HAS_BSS_LINKER_SECTION if SPL
+	select SPL_HAS_BSS_LINKER_SECTION if SPL && SPL_SEPARATE_BSS
 	select SPL_LIBCOMMON_SUPPORT if SPL
 	select SPL_LIBDISK_SUPPORT if SPL
 	select SPL_LIBGENERIC_SUPPORT if SPL
@@ -1181,7 +1181,7 @@ config ARCH_SNAPDRAGON
 	select SPL_SPMI_MSM if SPL
 	select SPL_SPRINTF if SPL
 	select SPL_STRTO if SPL
-	select SPL_USB_GADGET if SPL
+	select SPL_USB_GADGET if SPL && USB
 	imply SPL_MMC if SPL
 	imply OF_UPSTREAM
 	imply CMD_DM

-- 
2.34.1

