Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F36DCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 18:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C68980CCC;
	Mon, 28 Sep 2026 18:07:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmaArLGSsajC; Mon, 28 Sep 2026 18:07:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D38F080C6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790618821;
	b=RHqNaD4wPxurk+qcLJ/wah4XWWiFyev8YMs62DW+z6W97WqEwLvQ74FYbLVPtLK0UAxz
	 Mi07Xx6HQ1VqDtJRg0kpZ9uv7EN4CHgNWAqhZEygb/ZSmDyWALmaTWqEgcG0JL4pKdZxs
	 6n0qCim/naq1qTfw1IX1GcRIUhM0AoeeqPF5TgHcTHTZZFTynXiCc2SSmjCIqpOJiuRHJ
	 NGdJ6IChnnhM99UDFhN5FLg4HhQkliMDKhkpd+tQWAbUiBnxI5QaACBgdWX9l24SbqzFA
	 JMp2j5tgoiiLcnwTa91pDeKreMv038CW5+q8npPx/x7pGoy7H1fYu/6KZrXx9vAV2Ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790618821;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4RS+xQSIcaVZciIoIdDfl6RPQB0aoqa+Ghrhd3IWzFw=;
	b=ANkF3vfdY9ADTMNAQmyCvcinYYQjQX3x3Iq1S82w/ygI5oD2XfD9iUTf5NAX891H+qo/
	 lH7P8viuL8TldF9x8mkjLuPP0+XJF8Anv+WELU7kKe9wtmfMgsjGwE1ymP/euuRb4/g4Q
	 TV9S8feNJlIgqYf3dx9DK0K0U2cLBK1kdQ84f46EZZaSHSFYI5p9hmNBjXvchk6hEz0i0
	 k2nD863fPRCBLaNX1YzPG5t34A5wG1Ou4/Yg/5nh7k73HwjYpffJundRd8Pw65pETzuqb
	 qqsbX0zC7+6p5QL5z1cfFrQXh6U4VgFsuBRVPbadV3TT2Kufo5hLsvMmsvyX2cJ4Xmg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790618821;
	bh=4RS+xQSIcaVZciIoIdDfl6RPQB0aoqa+Ghrhd3IWzFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mYPxcDIWnCVNep7olP1qTgiCmwOXf3zNAqCh87YbJ2N/bTsmASVtURSMG3DNV93Ir
	 Ihe2SbE2vPzfwcoiX06n04diTwv8YJ8YNvk3pe630YE64kiMgTRj1v0nlvny8ajpK1
	 dDwAHW0Uvrad5fEtAjdFrvp9EWYF4b0uLPRO9br3upvbSFO9OES4SHROzPeQ6Nipxq
	 13hwlUVKcpFqBikSuTetrPuQQ0dQmxqfhe+JN1XEpZEDPOZJxKtUpgwBEC9NJjhGkl
	 KAOBOCNCthKBYfFIdjxBjzzvg1yevOhOgMaXKHn1+/QyoR/BKXFZJZtebb9ntQMqjK
	 Uq38ylB+iBV6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D38F080C6F;
	Mon, 28 Sep 2026 18:07:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A67072
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67F07400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hn4Iq0c5DzH3 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 18:06:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AEECC401E1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790618816;
 b=Lg1QF1zC7/Dnw8n+pLMKCFb/a5qT232RR1qoTTyDbhCgEhX+yA4yGBWb1kQSp/tHuN29
 tgHb9UFzk8yqvskxZmm1rim8Zd5GOznsYZFKULjtH1N+1E7CloChFVNPPFIDN/yeCZ4I9
 GrJSsFL2Aw8jDbjEWXF1iHAW1VX2Rx7cZBf516NFVpboVfiWsnqsMkAtLgbHor9XurRiX
 8Mg3g9+pn3mBw4/cWY461jif24qEaFyo36bSvBjqfDV1T7FhgRo5Ybt22YDLPlE/4B9Dy
 drl8xlpxbnUxaWcXQ1m/R0c26X77N1+Sc8vvEfbYVaVfgfZ8PDPFAoAMvaG280GZS8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790618816;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=4RS+xQSIcaVZciIoIdDfl6RPQB0aoqa+Ghrhd3IWzFw=;
 b=V5aFTD8l1VQKTJi1VaoMoxzSB4dsEFmZC6I1GKXuITGrwdpXnuHIqNxXLS1whRTs1q4h
 Rc4AB83r4byT+W2KA9QtThF0zcJXq/YgMiT8CtoeJss2uYAYWT9gZSMvRAw/JfczRqm1W
 eE+Jc61qwXAXxzxOwySnXKlQBDJclqrPDjjBaFAGDbRoFT8hh2Yxl+ZwJKBVPuDOVNTkB
 2X4jVWPZLt3Yd3Rrvaz/i9HJKCy7EVB7MWwFpEDVTcf0z6fLlhMJU36p+9XQCz2/6Ync8
 ZvXh2dNnOCztRKGmTuGE4q8Z+l5ecNQ1LayrS2WhjOP1RY0tpr7Z/dJsBzGrb948ogQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="BkdDr6/m"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Um9iQmhU; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=BkdDr6/m; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Um9iQmhU
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEECC401E1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:55 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SHwk9q2740698
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4RS+xQSIcaVZciIoIdDfl6RPQB0aoqa+Ghrhd3IWzFw=; b=BkdDr6/moge42Wdi
 t/eI/xV8BFFTOcnOzvaIhQ1vaw8I+X2TCnwoPCB8WZo/B137Oe1PzElmOX5iOfBq
 //Ewb3oja6Sp/IEnntvRK6q7d6w4IKMBbzhBjRrkpO91ulFhcbQWtb5Lhjip0kow
 2lwPCNS5tIkgjdHxMI/vchu6Wn5PuJXfCAttFkQM4rNr8oGyiQK/lYHKM4WZMuaM
 VxH5UzAtwWOjFBEBlSivj9nklr3Mo6toiJ9rxFV4DnthmrYwJE1qBv/PB7TjYbQk
 frE+PyJhGIq06+EUv+6h1EMMQuVCTOCmOrogV0omTwvizRGAsTUzWxHRH0lmK9qk
 fdiUgA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynb6j68s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:54 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8a9b387ed7fso36510947b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790618814; x=1791223614;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4RS+xQSIcaVZciIoIdDfl6RPQB0aoqa+Ghrhd3IWzFw=;
 b=Um9iQmhUofWUBgD8Y5zRX4T3rVgLLarFgWgnwwMSvGOgFoXF8zhWKPDbNHpSoG8eJw
 fc0kV9CcVy00omc8btJek3CuX3xHBWbcBrOdOtPAsRRfKioK/aoO5+H+VpwcWL3j9DSy
 jYx3OrqHvfdGukiosNaGttYaKKEd1x+jBqxgMV1+Flzls295JvDPE4rv4ZYL3rX1kr79
 2f+gnRSuDWCE2vPxGElnZQChD80gFNZjs8w5sxQCCxuNO7nOubuArrYhcTNw56wRZDz2
 KvBObmVuawUbKoK2xeqMpx2Y/GuJNkPtcorrA7hwyyk6e5ysPQgSxJi4tFWRpIcrT0up
 39Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618814; x=1791223614;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4RS+xQSIcaVZciIoIdDfl6RPQB0aoqa+Ghrhd3IWzFw=;
 b=nrPbacqfsu0tZ0Q6IzcqvMc9pGjYhuQeKUFQZwFqzwFqQW5ZId7aXzaqXadHAKzB0G
 UGH9XTaN1yuVbWLLLf8mkHA/dXFGPs+MVhN19u9yjM5YSbJgifBoZ2Fg5JaoANEY54Nx
 l8qb27pex2Opx4Ex91N17JmdJ2HhsJUrL1k7+ndLNiDZqbXnKX4iiL4/Vq7DWbT/+r4E
 uYffEqRjdTNQteCFyfGKled2SfEOBd2z0PhI2WriaKQOfb3tCY6oLg520XwLWqaJxdhx
 hpgRx+iCQoHnKwNJfMe30ZfQADIxmWy0rnxsSkl+/e+X/ez0wgUHvUGmiLCo1IB8P9ql
 gpxA==
X-Forwarded-Encrypted: i=1;
 AKwUvByV0DzGtVgwDFOJ3kUSfTFLzHg4FVaIlt4kJ18y9YbMQQYECmjoiz8Igpd40PfAA+PAG0cKHfU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKijRz0L+OP1gggNeU4viF7gD4uH9RxuR6k85dM7YPlCN/eDj8T
 Kr1UYUzryhvzaaaFjmuwJi9X4r3mbo33Uh4d/spOH5M4E7hU2aJzg0arD5gTqlaeZo3yFmfQ/v8
 cnHotJWZJR3E+vnxry7zFK+whMu7ERpC8sUtd6jtmiCIP1WVOs7IxGwS21KWAJaLGrh2YG0xVIf
 Edr1s=
X-Gm-Gg: AYBFou0oRbYGy4Pxg+PKn0H408vIPz62fieBCl3IET7vr82RA9+fb8tPH3nUjxlabjn
 gzf7rsFB04La2ja6XczA3NuGDxDUD6E0kNS012pWoXrHd+Ew3Wrj3B5PN9EKN8F1F7f2ftQazKI
 wNyi3qovitvSFsFtlByr7Br1mfWXulQDMdaOuUxNeff19inQR6iBuELCKkTZGmRF2/lzfhl8WEB
 eOvGEftJ21UfTYKc+KpJtDipvdcrrbx8/nP758ws52DvTFIQzM1b8UG1gMLWl9BTUpkogHAEtbL
 gpAw00603OGvxrsM6qrmJ2Y1KVnoaNIc3WEKQDPSSQABZdiWeqU/DvvR7GAZThYSLspcJzajb1w
 bnzGRI3mZKaD2H5gkxaMpW1ln8s85lotzLlsSMw9gU/pHQSC3ikOBWlRBxGMvuwUmNkIlGryK
X-Received: by 2002:a05:690c:c047:b0:8a8:7fda:15db with SMTP id
 00721157ae682-8a87fda33admr33062837b3.22.1790618813882; 
 Mon, 28 Sep 2026 11:06:53 -0700 (PDT)
X-Received: by 2002:a05:690c:c047:b0:8a8:7fda:15db with SMTP id
 00721157ae682-8a87fda33admr33062747b3.22.1790618813452; 
 Mon, 28 Sep 2026 11:06:53 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860e5e9besm49390177b3.11.2026.09.28.11.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:06:52 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 14:06:51 -0400
Subject: [PATCH v2 1/4] board: qualcomm: tfa-optee: enable the OP-TEE library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-monaco-ventuno-q-v2-1-0e046c8242be@oss.qualcomm.com>
References: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
In-Reply-To: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3MiBTYWx0ZWRfX053gInLUji8G
 haqMAhFVpgp3OJeP/g8m2nj4cGWl8KZPdUApm4rk8N1GJsCwmi/g3lwAySPkqSdb3/TSVtG7mQ/
 cD1QBhuc1zX4oCdEUHOMgF8CiZZTHulEXn7iZ6bEJUutOH0UcuuPIJ7ATEzv466Y6YCfZl3iu10
 tfiJ0BDFTNMoX5x2l8nHk0flRaZz4Hixd32xOVmKGuCeTA1IBCzcQJw/qB5PepXbL+DiPrZTjb3
 Roqdbv2EcA9GKnCjJgqV+cX4qkADTNswKsPg+uYNz8/lwtTegqeWL1uFJXmBq3qGgiqPmhmtJRB
 P7baBnHfM3kMxuSyx9BR9DXpIwWH8PS4GtzRm1m3mPXR6GjNekFF7xcENfKNGxx4owb9NjjkiBj
 77q6uVfBxw10E8KJaFT50E3GaVWCZtV2baDzbJQtlKuuwotrFv9wtm/qfnAKdgDGGqOxDC0k4ZC
 V66dT09GFuBrKfx+SOg==
X-Authority-Analysis: v=2.4 cv=K+e3jCWI c=1 sm=1 tr=0 ts=6abaacbe cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Ia7xkCombuEEcTx4gQcA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3MiBTYWx0ZWRfX4fJlZOBaya0Y
 ljvvF56C/Qx/zWSVRHPbKhZENIDkQIo9AZLRZ/mgtix4yJ5JpvUbj3+UWHXtt791b/Gxsf3rgea
 YbKG9HSzDydKEiV/BhnsXK+5zeN63kI=
X-Proofpoint-ORIG-GUID: EHX4_iGzGbsvvhACFAlAZ6mMya_rpo1N
X-Proofpoint-GUID: EHX4_iGzGbsvvhACFAlAZ6mMya_rpo1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280072
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

Merging tfa-optee.config after qcom_defconfig leaves OPTEE_LIB disabled.
Enable it so U-Boot copies the OP-TEE node into the OS device tree.

Fixes: 8459d9c3b415 ("board/qualcomm: Introduce TF-A and OP-TEE config fragment")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
Changes in v2:
- Reworded the commit message and the comment.
---
 board/qualcomm/tfa-optee.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/qualcomm/tfa-optee.config b/board/qualcomm/tfa-optee.config
index 1e8364c114..ef13d68803 100644
--- a/board/qualcomm/tfa-optee.config
+++ b/board/qualcomm/tfa-optee.config
@@ -2,3 +2,5 @@
 # source TrustZone stack on Qcom platforms
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+# Copy the OP-TEE node into the OS device tree.
+CONFIG_OPTEE_LIB=y

-- 
2.47.3

