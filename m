Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD917606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bhDrng5d;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XMdMbKYX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZilgdrlL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A232380FA2;
	Thu, 29 Oct 2026 10:58:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ltVpsZM67LYi; Thu, 29 Oct 2026 10:58:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B04B980F9E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271478;
	b=rSceRT8nvJmn52WlKNpCnQ2Ow7S6iha0CZualrFTNKhuymRNfYwLY+Dr7mxFiIThPS21
	 cQMVYDYIlaZQnwUIpOVXMcbxXABWLn4h1ihoIYE98Z00pQUIiHUA6zCwBjXvdWZh4xDnN
	 aZyF41bl6XcBRdy/+rlFJy3WC3zMYHEK1tPMmAkctGTe9MhNKXIvhFU4t1Phu/IO86z+K
	 sNbyISSJ+lhVrbDnWjuEbKR5kY2WfsV8b8tuKL6k7G+YWZB0tcE1sLSkWmS8vjNcudEk0
	 HterT4Fv4Ugjk2b/wxnGuDpr0HQMIOXqDP7YTg+pgoRVuS/hFmu8NNco9O+FQA/4hzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271478;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0BO8RzI7cbN0lSfSjjgj5VDMeAum+h277tfbBNXSzAc=;
	b=ShnWFMQBPxWWcU4jahcfLe/JIXcHIpD6gto0JiMzQLZJ3PmNiQb5PuDlO4crZhzkSOQp
	 FpGryY9Ve4RFcSuXzc/qRCbgLgN5VOu8hvI0I0UGYDXxYd6LmtPh30VpsEEUV+QO9g4CR
	 lVEmuIfEDBXp/3GBsSHpsxsVioeRcFXvoko67Xi0IRvQN2KJNiiku8xxt8svjRW0PJMjC
	 1eZFSbLOICmFyO2phfPBY/mZAugMsuy6Lyodve95RX9AnoodAt5MZJE3yIHtX5MwDTkiJ
	 tFhYlxPryGaklUl+eFWYc44u8wL9MUkCxONJrXVpcxa/vWgQX3eqDHMWyUEt1ICBsYg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271478;
	bh=0BO8RzI7cbN0lSfSjjgj5VDMeAum+h277tfbBNXSzAc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bhDrng5d8A0+UO9HQS8i9JG2vYwEFr+bmw/9xXyKS1KjnhEsIpFuVW0Ep1BwDf+z5
	 ZNI16xBVjwtyt15NlJHHVmd5yG7NI43R3lgwOdSI94cBn9vJTuAUUaOrOni/hpZW7S
	 7+ZxsV3qZ9Jg2wBwFBlPida5gYmm951GKaQSzlVZDoygI6M+CPj8gJYpmtsZeeDoEc
	 lUqqY0nDuXGY7JasRu2fCcJks5kLQHYBDkfQmqd0nBph+17BQ46V/DaMK1Xl603zql
	 L2a+qnH4vKRhSDAAQDeg0Pj6/JJDPxStwWjOXELWtUd5vg3tHaP2yLFDtUl0vaSw45
	 xAc6RyFfKuDMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B04B980F9E;
	Thu, 29 Oct 2026 10:57:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60FE4D22
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E977606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m5H8okutwt4s for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:57:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 41AB86069F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271474;
 b=FXZJVzlEmpt70nTilkiDDIx5OxmRiz+JCVsX9qmSqCCbKEcs7CpJzcBs0sKmtrD4poON
 CwBIYvep1FZNL5SZNE0KkiXYX2ys5xXGtLUFUz4ptVeWp6IqTl7JQlSFQ7DxfCxzHzJzy
 RmN2WoSiPnKa0g7HilZdseHItYKbolrknMX3yh/CB9t70tPc4DiUBrvdCibR7O6Se8RWW
 oDUldsrR2NZpJancLGYSxNKhQxALgvU+zM50N9ownU1Waqb7EZCcfwVEMvaicun3+ZA2X
 FpAgLBO1ikTdlcMCi3mNC47J2uBf1oODLtUd3xLQX65x56iAnEKLNW8OrjZph9xyFhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271474;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=0BO8RzI7cbN0lSfSjjgj5VDMeAum+h277tfbBNXSzAc=;
 b=Faxpnv0Rj+rVcXobu4pde1B9kJhRQA8fs0HS2uoTYcVW30i9Jmy5LFlohB+gYr0euuFt
 VYunPV3H8ximEbAQAsL8wif7JxseIFk8uPPdCrvilVuXz2h1ZX79+Y9p2hpxbfZw99Ck6
 F5FTmfAeqogBDmyQJg6vUrK7tSGQ8BQQ7fHBPsPhPeqHmX3sXGDsj1kTwgrqKtk7r2yde
 XddnpGgDjNQQVUETAcs1EY1xPTHblGtF4wC/1jJ3EkBoGWsotRvDV1KWnlLJt3XcmdtV2
 exUDdz0+/kCtKW8vVTmCxhVVZDO80BbiTowfeZgEBTAbD9GL44ax1ugL6iaJ+0Uv+Sw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=XMdMbKYX; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZilgdrlL; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=XMdMbKYX; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZilgdrlL
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41AB86069F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:53 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TA8XKR821531
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0BO8RzI7cbN0lSfSjjgj5VDMeAum+h277tfbBNXSzAc=; b=XMdMbKYXin3SzL8c
 cbZmn+U2TTe9UPnBdcfnUZu3GBuJpnbwzlCDF8gvU9y3n9icote6aqRJO7+DMTTO
 Cr5giAg3jL3/J7A2/bYS0gNFjs316UoBIXsx50PKL6BhnLcZz1+bDNZQU0Mi1aP7
 u/FkjQtEq9D3p5Mbcdr4Xuq1zdjDeHidtIqGSZAxoFz4qLV43Y+OHJOg3CH6Infj
 6llxUDQaj07RLaVHqrtacc+YVh99NbFXSqkYo4xJNR5JhkHUod5X9KUarRU4a86Z
 3DJNJ5P0OiznILLa/FKdzBnGXrAlsgKnhOOhurPjGUiIz5dClBud+3ic0u4BmuGL
 IjScDA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q85fu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:53 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-19dbbe4b1d8so1863851c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271472; x=1793876272;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0BO8RzI7cbN0lSfSjjgj5VDMeAum+h277tfbBNXSzAc=;
 b=ZilgdrlLvSzWS3/2TUbyit0pFa98EU8ng/eChMLp8JqFOU3DYbBjkE+V4mV297etf8
 /rsDNVhoBPvxR1WFmqsbeFfqI3a9ytSGpiDoA0hpylIbkhL+TqFysBupBZDEWJZKa5eN
 vzi6twCBvGkVAnQdTfgagkeDIOfbOAAboSm8dLeHIlR42JfwKB8LGZYd4O8e1XhrxEBl
 VFKO81kbHCc4XBqaYQ737+a+zMdmFHW8pLluOAURzi0z0/SYBtd+IMCevCfCmHz9yqH6
 HHm6/uvW8vwsUIV2f1QAy9XojMSCdjdKK1LVtPq6asj1o27VFAMGtOCZBlZP9UhvskZX
 DTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271472; x=1793876272;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0BO8RzI7cbN0lSfSjjgj5VDMeAum+h277tfbBNXSzAc=;
 b=Qwo8zLJIw4BeY+UQD07aXysVrJWjIk+KcmzfOMG4vRow3zsUcoYrJZ+WpPf9a0Jm3g
 RqQWyyJCUPBYG2iUWITZtD29OZ5zw9hz8jmlSUqR6hr1WXXrJORcJVzxYY1Mro9sobWL
 muDH2RcpB1RmYTju9rYE+pc2/c5oEdeEU89qFXKVW63SkVYWPfUwUX4lRnsbVsLph3FY
 nc/gUJXp3mwm6tDgTF8NS8ex6sDPQDm0dCD/yeVWipjimBs4VKvj37f4UjYk7lZnP7ZZ
 YauZw/yF/BLDi40W6CYYeo627IVcrLuyPbyqBryU6NS580gLv1PQ6hK9msDcF4xUUuzY
 EIaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1BoUMR1eawzrlqGxKngdgX0WEbY4Z/d4LtdfrXkM275nGkmCjKs5YHX1r+tJBoie6jkbB4dw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKQ4aHCd54jgli/IIVpaEIJuTBfKExukBWbeAWqfcpr6zBDxYh2
 R6TouXWa0GH4JeAEWXG9ej7WMfAWOqaViztaANmSkBflevzmE807fUTAkghHhhfeON0k8TCFj5+
 MyO1+CbZ1ac0b/cYP9eRfa0Lnenw+0WdfS7hzjiWvkF6Hq9OfHWtTMegulFKazPFNz8gUAh8=
X-Gm-Gg: AYBFou1hWjLKH7CVZJ37D3EK5GnqHTXXsJ+TYCkiq2/Lj8ZmrGDcjJkydKpmy22UITe
 Pf851cJfZwe9H1MRAexdJ/vUYsrn15dhzPLKuZvcuY9CiHSodYLLUV5OVkZ7E7j2jbdtckMvEby
 /LgEiDQFUtMs9X2WGAR2iWRs6v5HHuwb5bMMJcAw/QsOrlon2Pst3NwdqGlaoNP+nKhdsVel9j5
 +bIX2md7yj41xhx7KA1kru1yTdA0QvNeh4iv+QGzZoWZ9FciZjJJlwh4ynPUTW/ZtN0uyOBFEtk
 uIf76nwOk7poG03/8ySe6f2cNt0Rc2mMD74Q82tAUY+ROuGhzgsYwF5YIEVQBF4XNbydIDCPvsg
 pBheqSnRIKF4mBBOQ08KHUwKZAGPm32nT1nLnZdbTkJgWtss3Q20TvZi1yakGBcdAJwJz9ByXs5
 5BgZC5uYUkX+mvmkA+O7e2Eg==
X-Received: by 2002:a05:701b:2515:b0:151:94a6:6f5f with SMTP id
 a92af1059eb24-1a6cd3a138fmr5894652c88.10.1793271472233; 
 Thu, 29 Oct 2026 03:57:52 -0700 (PDT)
X-Received: by 2002:a05:701b:2515:b0:151:94a6:6f5f with SMTP id
 a92af1059eb24-1a6cd3a138fmr5894609c88.10.1793271471611; 
 Thu, 29 Oct 2026 03:57:51 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:57:51 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 01/13] arm: qcom: add common QCLIB SPL extension helpers
Date: Thu, 29 Oct 2026 03:57:34 -0700
Message-Id: <20261029105746.3487456-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX338OXkZltYdj
 z22Kzw+06/+NUmuijrzrXh1zxBKPPqgPGMenZtc0JYc36uuBermhDi7StsqybawTZ4FI+WsNQe9
 WhpmAWY0tYrliCtx8coNYU9k0JdWPBo=
X-Proofpoint-ORIG-GUID: qTT9oGjww1EnhKVtYNbeOL7fvesk5NjF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX1NqavVTucwBX
 1PPvXs2Y0vt/V+VtZDbUR02evKVkUdDxkaErNUejz8Pd84S0NPRfFyCmydCQfS5l4wR5uMtmGep
 jR0Z6RLa67ufwY0Wzar5Fx2hajaykZtzNAfhl7LUsdcMwkOc54MozEmm81GZqUZL/V1lqDZhI9p
 7iFeN3l2SJmKWdFDJqY1r3dHUdXVSQYxnZfvmMLOhtogBFuzjm8fH13tNpqDJE1VslXzCNJ8Sey
 cpPquLn+J8UDYo73R4m9hkqQsCf1aPSsBnSWy9s/djMx1gy3s4lh7FhhaqfD6XWM0RPuUlD9ZN4
 v+BLNTdXiuEPZZN/QOXvnga5PnEWgewv4DPngYs/X3qfK1RMaE3JfgydccdyyvuWXNJQsyMCSMP
 QBmWOWaQJTpUyyHj7O1lLKXtuu0f6WqAgmFqNAX8LAQTcjc7DObVcsOD6N8OnzpHPgz49keKmYT
 jIaSuiSyLjW+xXOUPiA==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae326b1 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=WN52PlUurRMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=mk6k_5ylc47UFE0K2zwA:9 a=3ZKOabzyN94A:10 a=xE34mhsjmDcA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: qTT9oGjww1EnhKVtYNbeOL7fvesk5NjF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290042
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

Add helpers for adding QCLIB interface-table entries and FIT
blobs, expose the DDR self-refresh exit address, preserve
U-Boot global data across the QCLIB call, and provide weak
reset hooks for SoC-specific SPL code.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c          | 50 ++++++++++++
 arch/arm/mach-snapdragon/include/mach/qclib.h | 16 +++-
 arch/arm/mach-snapdragon/include/mach/spl.h   |  3 +
 arch/arm/mach-snapdragon/qclib.c              | 77 +++++++++++++++----
 4 files changed, 130 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 3293eab8f81..4e3b2527a7b 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -6,8 +6,11 @@
  */
 
 #include <asm/sections.h>
+#include <blk.h>
+#include <dm/uclass.h>
 #include <hang.h>
 #include <init.h>
+#include <linux/err.h>
 #include <mach/qclib.h>
 #include <spl.h>
 #include <soc/qcom/smem.h>
@@ -27,6 +30,53 @@ __weak void reset_cpu(void)
 	hang();
 }
 
+void __weak qcom_spl_soc_shrm_reset(void)
+{
+}
+
+void __weak qcom_spl_soc_rpm_reset(void)
+{
+}
+
+/**
+ * qcom_spl_get_boot_blk_desc() - Get the boot medium's block device.
+ * @descp: Set to the resolved block device on success.
+ *
+ * Maps the already-detected boot device to the uclass/devnum pair.
+ *
+ * Return: 0 on success, or a negative error code if the boot device is
+ * unsupported or its block device cannot be found.
+ */
+int qcom_spl_get_boot_blk_desc(struct blk_desc **descp)
+{
+	enum uclass_id uclass_id;
+	int devnum;
+
+	switch (spl_boot_device()) {
+	case BOOT_DEVICE_MMC1:
+		uclass_id = UCLASS_MMC;
+		devnum = 0;
+		break;
+	case BOOT_DEVICE_MMC2:
+	case BOOT_DEVICE_MMC2_2:
+		uclass_id = UCLASS_MMC;
+		devnum = 1;
+		break;
+	case BOOT_DEVICE_UFS:
+		uclass_id = UCLASS_SCSI;
+		devnum = 0;
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	*descp = blk_get_devnum_by_uclass_id(uclass_id, devnum);
+	if (!*descp)
+		return -ENODEV;
+
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_SPL_SMEM)
 /**
  * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
diff --git a/arch/arm/mach-snapdragon/include/mach/qclib.h b/arch/arm/mach-snapdragon/include/mach/qclib.h
index b44874c514e..10865b03ea1 100644
--- a/arch/arm/mach-snapdragon/include/mach/qclib.h
+++ b/arch/arm/mach-snapdragon/include/mach/qclib.h
@@ -65,11 +65,25 @@ void qclib_set_qcsdi_address(u64 address);
 u64 qclib_get_log_buffer_entry(void);
 void qclib_set_log_buffer_entry(u64 address);
 
+/* DDR self-refresh exit address accessors, populated post-QCLIB */
+u64 qclib_get_ddr_sr_exit_address(void);
+void qclib_set_ddr_sr_exit_address(u64 address);
+
+/* Interface-table entry helpers */
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size);
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size);
+
 /*
  * __weak SoC extension points. A board's spl-<soc>.c may provide a strong
- * override for any of these; the defaults in qclib.c are all no-ops.
+ * override for any of these; the defaults are provided by the common
+ * Snapdragon SPL implementation.
  */
 bool qcom_spl_soc_check_dload_mode(void);
+void qcom_spl_soc_shrm_reset(void);
+void qcom_spl_soc_rpm_reset(void);
 int qcom_spl_soc_pre_qclib_routine(void);
 int qcom_spl_soc_qclib_override(struct interface_table *table, const void *fit,
 				int images_node);
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
index 50cc8dc4e8f..a32a85c48fd 100644
--- a/arch/arm/mach-snapdragon/include/mach/spl.h
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -6,8 +6,11 @@
 #ifndef __SPL_H__
 #define __SPL_H__
 
+struct blk_desc;
+
 void qcom_spl_malloc_init_f(void);
 int qcom_spl_loader_pre_ddr(u8 boot_device);
 void qcom_spl_error_handler(void *arg);
+int qcom_spl_get_boot_blk_desc(struct blk_desc **descp);
 
 #endif /* __SPL_H__ */
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
index 7f25f37b5d9..b9a74863c1c 100644
--- a/arch/arm/mach-snapdragon/qclib.c
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -2,7 +2,8 @@
 /*
  * QCLIB interface-table protocol: generic, SoC-agnostic orchestration of the
  * hand-off to the QCLIB firmware image, plus __weak extension points a
- * per-board spl-<soc>.c may override to populate SoC-specific table entries.
+ * per-board spl-<soc>.c may override to populate SoC-specific table entries
+ * and provide SoC-specific reset sequences.
  */
 
 #include <cpu_func.h>
@@ -15,6 +16,17 @@
 
 static u64 g_qcsdi_address __section(".data");
 static u64 g_log_buffer_entry __section(".data");
+static u64 g_ddr_sr_exit_address __section(".data");
+
+u64 qclib_get_ddr_sr_exit_address(void)
+{
+	return g_ddr_sr_exit_address;
+}
+
+void qclib_set_ddr_sr_exit_address(u64 address)
+{
+	g_ddr_sr_exit_address = address;
+}
 
 u64 qclib_get_qcsdi_address(void)
 {
@@ -36,6 +48,42 @@ void qclib_set_log_buffer_entry(u64 address)
 	g_log_buffer_entry = address;
 }
 
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size)
+{
+	uint entry_idx = table->num_entries;
+
+	if (entry_idx >= table->max_entries)
+		return -ENOSPC;
+
+	memset(&table->if_table_entries[entry_idx], 0,
+	       sizeof(table->if_table_entries[entry_idx]));
+	memcpy(table->if_table_entries[entry_idx].entry_name, name, strlen(name));
+	table->if_table_entries[entry_idx].address = address;
+	table->if_table_entries[entry_idx].size = size;
+	table->num_entries = entry_idx + 1;
+
+	return 0;
+}
+
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size)
+{
+	int node, ret;
+	u64 address;
+
+	node = fdt_subnode_offset(fit, images_node, name);
+	if (node < 0)
+		return -ENOENT;
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, node, &address);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, name, address, size);
+}
+
 bool __weak qcom_spl_soc_check_dload_mode(void)
 {
 	return false;
@@ -43,6 +91,8 @@ bool __weak qcom_spl_soc_check_dload_mode(void)
 
 int __weak qcom_spl_soc_pre_qclib_routine(void)
 {
+	qcom_spl_soc_shrm_reset();
+
 	return 0;
 }
 
@@ -60,7 +110,7 @@ int __weak qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl)
 int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 					  const void *fit, int images_node)
 {
-	struct interface_table_entry *log_buffer_entry;
+	int ret;
 
 	memset(if_tbl, 0, sizeof(struct interface_table));
 	memcpy(if_tbl->magic_key, MAGIC_KEY, strlen(MAGIC_KEY));
@@ -68,17 +118,10 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 	if_tbl->num_entries = 0;
 	if_tbl->max_entries = MAX_ENTRIES;
 
-	/*
-	 * Reserve the "qclib_log_buffer" slot — common to every SoC.
-	 * QCLIB fills in the address itself; SPL just allocates the entry.
-	 */
-	log_buffer_entry = &if_tbl->if_table_entries[if_tbl->num_entries];
-	memcpy(log_buffer_entry->entry_name, QCLIB_LOG_BUFFER,
-	       strlen(QCLIB_LOG_BUFFER));
-	log_buffer_entry->address = 0;
-	log_buffer_entry->size = 0;
-	log_buffer_entry->attributes = 0;
-	if_tbl->num_entries++;
+	/* Reserve the common qclib_log_buffer slot. */
+	ret = qclib_add_iftbl_entry(if_tbl, QCLIB_LOG_BUFFER, 0, 0);
+	if (ret)
+		return ret;
 
 	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
 }
@@ -146,9 +189,13 @@ int qcom_spl_invoke_qclib(void)
 		register void *x0 asm("x0") = &if_tbl;
 		register void *x1 asm("x1") = NULL;
 		register u64 x8 asm("x8") = entry_point;
+		u64 saved_x18;
 
-		asm volatile ("blr x8"
-			      : "+r" (x0)
+		/* U-Boot keeps global data in x18 on AArch64. */
+		asm volatile ("str x18, %1\n\t"
+			      "blr x8\n\t"
+			      "ldr x18, %1"
+			      : "+r" (x0), "=m" (saved_x18)
 			      : "r" (x1), "r" (x8)
 			      : "x2", "x3", "x4", "x5", "x6", "x7", "x9", "x10",
 				"x11", "x12", "x13", "x14", "x15", "x16", "x17",
-- 
2.34.1

