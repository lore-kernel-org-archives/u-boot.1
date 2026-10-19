Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D37CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B0D46067A;
	Mon, 19 Oct 2026 10:28:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XxjdHbtzZKxm; Mon, 19 Oct 2026 10:28:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6483A606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405688;
	b=PRjL6MmI6uLjmdw0hDspLxHvEPNKuKmHVAZ4+pTumpIATVAxTQDlY4jpSrA1JrXiFv8d
	 WaVzmoCF6a+WCDiIJKAH2NE/TYAkHNUvPonBuJoUmYWwfSKhDMaHusI+RQKKfDAEhrTb4
	 wvLN1d2bGkLUVOmmEuZRfd7CxJcFsP9Tyxa1vRUq2kn0gzSZsHph0/mLhmAHC0ULeSyfV
	 vUB2wdXUOZHnWelMgRpTU3/6b5dGRmrOyqgucxthFgcNPhYQdZc0gxKglfOgDeh2DMM3U
	 KHEihihUO5IWJSrZpPjtilQac36TIaprO4KkfRw9Gm1ak8fgO3kddFOcnsGVMu+A3xg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792405688;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1HyhBpsh+zkvR8/AkM9YKgongpZh4kUWsz9XBkGJgLk=;
	b=Nau2iGrnqVLwI3g30nk4/0S9tfNgaXhTENPP5MF2EcODBGf4Z7Rx8Ez/jsMmjUSgIC7i
	 h2k+PRazF+Q3YMUXi4nYfTdbsYFdL0UvCu+Ilrzx741kiG06YxWtX/c/sObriHnarbwbg
	 aSiT4i6SuKdhZAFW8w6jcoSh3vS/NLfT5j+3ZFNqQZWoBIOMOPvjKukntaA5OV8q8lih9
	 3yffa8zObdKxz5zd1YzHwy5Ro8XYbjrMGiDgWfyAH+dBuiacw2H0cp/npMmioEnoqxNFF
	 o7s9vQ3c5K3zttw/nGUyHHpDkrpXg3M1tQR9QDHUt4DUxVqxdceLzlpvSWNxC55AlSA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792405688;
	bh=1HyhBpsh+zkvR8/AkM9YKgongpZh4kUWsz9XBkGJgLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MlcCmcnixBmE77IdGsqPDK7vYQV9broC1QJiTffWNLMOmLPYv7+VneEZ3bk+iY358
	 plD2Cb1kuse2tZC8/40Gfq2+178liAqY0fs7LKw2+RlIpruWEKD4DYygVRYrr/Nf5a
	 t/hOlk9puVjnbOWgQ4psxMdUsie/jvS1OG6/wXSqL8cnIoaqzb1cjmESwiokzaRrIn
	 lDl4uRKF0Hljv4g1Wf1jKuJz4WXHdTEm3R/jfyQ3rw8QXpgOCnCKruIZJeYivaYfsC
	 xmkkXS2gck6B2qNd/L+wOAu80/eFPjMz+UdXSrZOle4/EPTakQegc2cgtnL6a5Ln5W
	 pdPYrsTf5DrZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6483A606CF;
	Mon, 19 Oct 2026 10:28:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3B86279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B99F040080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m2X87wXL62PQ for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:28:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EF4DE40079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405686;
 b=IY406Ev8/GKZ/spjtCgzB4K5tg0XPWmXg068jDls5OWsa3O65IAaGb0aCvDP8JT+pwXI
 gGU88fBAZOltRKfylWaVat3UFKuvS8sTmuQOJXRJPorOqYnTyr2s5KcyOriTv0G2oBn3h
 xbKt7jZhSACWLlGQBDO/XXoOrJh7d/cujmLNerex3NueQ7xCfFFOT2BKi3ecOJXZzn48f
 3b7NkFeDbySnO8HskzNKdVPQLxmDwZGwlLTzjMSJoS6p3yXRe8rVzmW7WIQrKf4s3PvEp
 WqfVGvpMN7WSNjtuVNAtqaRWjFqJHNdf1Y0KtDCxfiQyBwabrGrathjPI5pUxTKa+YQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792405686;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=1HyhBpsh+zkvR8/AkM9YKgongpZh4kUWsz9XBkGJgLk=;
 b=fCjy1PrIFYCPgirdy6wuah9Mfu7EuOFuMNQovuQXxS/DHIvJPMrtxk3UnWKWUUFmnH32
 qxex6hC1PwxEraOYXqWloJOJ1e+euWbSw3Ti8sDO9HP0OpaaCG+cmzHrxkzGqqx9EVGDM
 mXyp+LWvABfyR9CI2tV7NdSUWDnKh4itREsUB4t9FQtEyWhRD2eqFtBiMJwQ0t+5qYezj
 j+IoG9l3MDdz34f7Ky6XXgyVuUNja7FFD6IUZQdAodF8pvV0uY6xcoAFtEOeZJswj8sTk
 EUDeeXLEyVe3w6t6BCRcWMVsM65eDEn8ye8oX++pehJr3bGH61JPKmV4za+hGLy9/Kg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=nU1SCIQC; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Tt248eQD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=nU1SCIQC; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Tt248eQD
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF4DE40079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OrAR1665443
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1HyhBpsh+zkvR8/AkM9YKgongpZh4kUWsz9XBkGJgLk=; b=nU1SCIQCLJa+8mHB
 kYif+Sj9ytHlgifE6NLOjjBxq08cxjyaYdQf+HuW0/Hurnd7h5xaHoXXnKvRdM1y
 B+iuIyDzRhj5UbfEzh9FCVMDQeOpGE2GyemEAhz74fWfxe10qdvPxTbZ/pBLcBuG
 5jCK6u19xKMnP/5zTo2jYWBNu79h2JVoAOoSaXztmULmW0CHKtX27ZeR1iLoB/do
 e3f4Ocfacjmd48V8bm7fdol/NYnNwMKmTbLHCzN5CBiOsSyDSMSxPOWsvvEfoEuA
 xCkUXE4eFaO6CtDfvHwDdAEjUxKPHQc2uHGZuufXi9UJu/eWna/ruNEOtrPEazUT
 Sr7iBg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n0kyk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:28:04 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8afde3fe132so22566287b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405684; cv=none;
 d=google.com; s=arc-20260327;
 b=E8NdEHTiQTwKUtaiCPdqFjmr8AFE06Pipky2zptXX2O3dgeIvu+JfYhgvHaCHwTSDK
 yE6WY9U7f0l1GMPRjumUlP3NnS8Rg4+N9WvvvgpJ66RvWb+uuZG0XUBOXsQEfHmmodAf
 X1jNmgSraMhYXaHU6ZgnuHJzW2bZTeC+owyA4ntr6GGtCio4lTyofDDSa+CXeGziKJUc
 sTSyaxUmn7qNlMJtzIBw1N8Z75vBnZwqCR947RahjK7q8AebGxTFAfjm//ZzGo6CR+Px
 2gHLxdfpG/wxDB2vJEdNmBTwCY+YAx42BQMGPZzfDtHnjB3Vpawan6U3hy+YhCYvYiYq
 2Ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1HyhBpsh+zkvR8/AkM9YKgongpZh4kUWsz9XBkGJgLk=;
 fh=W3fnFLlrASevLctr3svMHNvP10rvFRp7Q+xTMcuD7CY=;
 b=MEgC+WjbmacUvFqFEy08M7aCcKYKROyq8CIOiW0950Cl2DtqHxVmXw+WGlY+Z18ydW
 uoL9GsMrFoSH4teMo1OTYs7Auil2S/ZdCTG6++WFhEkfeAGwOovOCbA7Br/ul3dooDZ+
 kac6hRbLeCyacvgrGScYSUD/mwfX/lht5JNhuY/aKeSr7CTl63cJctLGyh89SCjE0OyH
 chmENym/WazaZidGClm3nSkmZJB8kOJdxFr9Viq6vGVHiZXIMDHN/FwTOjaY/Zp5iSOv
 +CgmaywHnam02sKBzuWoPWiHMtg4HRJWwqefYXyUkdQRaIhsS7NunWAaFGXb9KBFET9N
 U8aw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792405684; x=1793010484;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1HyhBpsh+zkvR8/AkM9YKgongpZh4kUWsz9XBkGJgLk=;
 b=Tt248eQDaFtDXSbZ7PqRBSzxWM/JKbTF/4KMgDIDMaN9zZYrMhfHUUy0v9GPtTT1ds
 5XMhiJpqmhuCBCH++1+Z/2TLjuZ3tvVmInziLEHehjCBOZj2QB0wZw0LN+2IQqrSSHLT
 4mzQuWHMS+WBIlW37tkf/jx6Y+w1xX7x8S/dTny+aptkbPxuBEQL5zmAEIxBJLmbsDpb
 gBcM8Q5YCzbYRAh9xfZ1cK9z1VJF5CYdoirD56/tfh/xr9/7QnklAA4B6UC26UtLJHvV
 nMuKmET3P6RPYhBNlC5BrlLDjwzzAvhOT+N98hAtRtnVDk/pbRYwTtiUsBKy6Tcw7IH+
 V6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405684; x=1793010484;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1HyhBpsh+zkvR8/AkM9YKgongpZh4kUWsz9XBkGJgLk=;
 b=tWjOh6txNpF77t6MltG0bNdWn/8EDBmgkj9euxoV4MNIEHd1vU+6JKyjDoJci5Vqtl
 SS4JWAdE401jLNVnSpOtAgmam2cBtID7Sr+BQq6g9vDU3d/P0CLplCDBdRJTKJbazTLG
 CJAcl4dwHhzMNJhpd0grkcAwAB16Hv7ncYxOKDD0OZ69aoo1WY4cB/GvcC/vHF2Iht4u
 b9X1gohSQdLjxy4tAHebzqmPySoLB/vJT8kJ2dTr+HTulgp589T+KuoZJhHyY3psWG1U
 M4QwMkd4ns7YiY6l7GiyE2rmDwH+rRpxyUZ8H9yDRCMiEi70fAz6+4CGIsjcR0Vks1nf
 4mRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFDHkdfjKwd4L83nDcKJ2ZeP7OniePVcnwzkVDdSOJSIzDE9OFZRhWtC3Xgvbitm7Uz8SVO4U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKDwvbKmThgy+3IQ4oeNIqyfqXRpQD+RxMItgHQ67weO6Nc08Wn
 DUl8KdDFmZbZJ45kXH+MKbuqfN8yzkbdQFIkPcjHvO+7KjXaMfSW505NTrOnV0EW2Q0Oil6qG5O
 f/shgXy++/ZU+WrGQPy5IIjt4st60MxI6uUml+G2wMkVsaEnw52nygjUM2uV/eWCkZDO7avjp7A
 Abn5VjYqDLU6eBaEO9eWm11VGNDc75q7PjGBHRDA6RZwy0VQ==
X-Gm-Gg: AYBFou10hKR7DansUtCEW1uIEgdUirnCBd/5xHuzkOiFqIRSGBNiGtX38HgOGh567Yi
 rFndlVQQ75zuMPpb0LT52vKUMxAIHTGwmQ1SM+3axkNo0j7U7zXLT/Za4UurX8Razpbjj2XoYbJ
 27vbVVy3QcBv5pJJtbcCWhgm0NJkphgx3hfTY7Ybkt9eFUiXs5EtZKYMZ+8A==
X-Received: by 2002:a05:690e:4198:b0:678:80a8:9a23 with SMTP id
 956f58d0204a3-679ca8c7e72mr1726869d50.89.1792405683768; 
 Mon, 19 Oct 2026 03:28:03 -0700 (PDT)
X-Received: by 2002:a05:690e:4198:b0:678:80a8:9a23 with SMTP id
 956f58d0204a3-679ca8c7e72mr1726865d50.89.1792405683308; Mon, 19 Oct 2026
 03:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-5-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-5-9e5b82644359@kernel.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:27:51 +0200
X-Gm-Features: AclHuK9XEIlPBliZS2oi2Fb4Mxvfn9RlQI8U4GOJfz2e_dnbICHRQyIxglHlgUo
Message-ID: <CAPzfCAa1h0Mm50JRaCevgJ_j2wBqbkm2m1E0DxnEN8OVj=KzTg@mail.gmail.com>
Subject: Re: [PATCH 05/10] test/py: android: Add create_gpt_image() for image
 creation
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX85Q/ckAMFf7d
 htZ+SgxeM2E9SfIGa4W6Ums20iR3jCxh1RcA3ve5YkpmDTGzaWL0pOO7xhUKxRx54vWng+PTngi
 +wZOMADCHXiYSEBLBTKGgO5T0vRrVjU=
X-Proofpoint-ORIG-GUID: eeBdEZ3TSIAIang0u2_QPTKVw4hOGRuh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX+FyZDZRIZMW8
 yXXjEhmGztBT6uhJM0HyU6c+pLFpIOp01K2je7u0NZB46WVo80F+zeOeXOBqNgeE3YZTo2usz8b
 Z3Htl490UmzKqEUzQGC+vcedDKRffdS81Tm2WM7gES626iioMHPeUlJ6jtr7F9k712v8xVCsz8J
 bucbtdR4hW2cgspL2abTGKbmrkY0sMaU5YhOwLPT71Rf2PEw6NGPnUzmiDcW0aFrXxXsA0ygWcv
 upaGn/DxsXfMUvTLnCaq6M3lR2cKFh1Lhx48wWv/Zn7bgb315mbaIvT960ASLgPz5oyqhXNnCvP
 SPqBLMfFVsvh3egBtrlAk+R4oW+YexC3L7bE7DhOOJziGR//36uvbhsLkR+Z79xXrBIIGXDlzGx
 au2754NMBeYvB1UuWfvhNnu+gHH8zFwgbHTZ8OEMrsBm4bXL6R0qZD6KyvNh+/zk/P8Uf9oBUD4
 gu4t7nxJG85b1sAp02Q==
X-Proofpoint-GUID: eeBdEZ3TSIAIang0u2_QPTKVw4hOGRuh
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad5f0b4 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lgSpjSMEJTgu7Er1arMA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190041
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

Hi Mattijs,

On Thu, Oct 15, 2026 at 3:55=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> There is quite some code duplication between the image creation for
> mmc7.img and mmc8.img. If we want to add more images, this will be even
> more duplication.
>
> Add a common function, create_gpt_image() which removes all the code
> duplication.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  test/py/tests/test_android/android_image.py | 78 +++++++----------------=
------
>  1 file changed, 19 insertions(+), 59 deletions(-)
>
> diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/=
test_android/android_image.py
> index 14dfd26fffd8..b5fede8ebf0b 100644
> --- a/test/py/tests/test_android/android_image.py
> +++ b/test/py/tests/test_android/android_image.py
> @@ -7,13 +7,12 @@ import os
>  import utils
>  from test_android import test_abootimg
>
> -def setup_android_image(ubman):
> +Partition =3D collections.namedtuple('part', 'start,size,name')
> +
> +def create_gpt_image(ubman, mmc_dev, required_parts, images):
>      """Create a 20MB disk image with Android partitions"""
> -    Partition =3D collections.namedtuple('part', 'start,size,name')
>      parts =3D {}
>      disk_data =3D None
> -
> -    mmc_dev =3D 7
>      fname =3D os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
>      utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
>      utils.run_and_log(ubman, f'cgpt create {fname}')
> @@ -24,14 +23,6 @@ def setup_android_image(ubman):
>      sect_size =3D 512
>      sect_1mb =3D (1 << 20) // sect_size
>
> -    required_parts =3D [
> -        {'num': 1, 'label':'misc', 'size': '1M'},
> -        {'num': 2, 'label':'boot_a', 'size': '4M'},
> -        {'num': 3, 'label':'boot_b', 'size': '4M'},
> -        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
> -        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
> -    ]
> -
>      for part in required_parts:
>          size_str =3D part['size']
>          if 'M' in size_str:
> @@ -54,10 +45,6 @@ def setup_android_image(ubman):
>      with open(fname, 'rb') as inf:
>          disk_data =3D inf.read()
>
> -    images =3D [
> -        (2, 'bootv4.img', test_abootimg.boot_img_hex),
> -        (4, 'vendor_boot.img', test_abootimg.vboot_img_hex),
> -    ]
>      for partnum, img_name, hex_data in images:
>          test_abootimg.AbootimgTestDiskImage(ubman, img_name, hex_data)
>          img_path =3D os.path.join(ubman.config.result_dir, img_name)
> @@ -69,55 +56,28 @@ def setup_android_image(ubman):
>      with open(fname, 'wb') as outf:
>          outf.write(disk_data)
>
> -    mmc_dev =3D 8
> -    fname =3D os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
> -    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
> -    utils.run_and_log(ubman, f'cgpt create {fname}')
> -
> -    ptr =3D 40
> -
> -    # Number of sectors in 1MB
> -    sect_size =3D 512
> -    sect_1mb =3D (1 << 20) // sect_size
> -
> +def setup_android_image(ubman):
> +    mmc_dev =3D 7
>      required_parts =3D [
>          {'num': 1, 'label':'misc', 'size': '1M'},
>          {'num': 2, 'label':'boot_a', 'size': '4M'},
>          {'num': 3, 'label':'boot_b', 'size': '4M'},
> +        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
> +        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
>      ]
> +    images =3D [
> +        (2, 'bootv4.img', test_abootimg.boot_img_hex),
> +        (4, 'vendor_boot.img', test_abootimg.vboot_img_hex),
> +    ]
> +    create_gpt_image(ubman, mmc_dev, required_parts, images)
>
> -    for part in required_parts:
> -        size_str =3D part['size']
> -        if 'M' in size_str:
> -            size =3D int(size_str[:-1]) * sect_1mb
> -        else:
> -            size =3D int(size_str)
> -        utils.run_and_log(
> -            ubman,
> -            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['lab=
el']} -t basicdata {fname}")
> -        ptr +=3D size
> -
> -    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
> -    out =3D utils.run_and_log(ubman, f'cgpt show -q {fname}')
> -
> -    # Create a dict (indexed by partition number) containing the above i=
nfo
> -    for line in out.splitlines():
> -        start, size, num, name =3D line.split(maxsplit=3D3)
> -        parts[int(num)] =3D Partition(int(start), int(size), name)
> -
> -    with open(fname, 'rb') as inf:
> -        disk_data =3D inf.read()
> -
> +    mmc_dev =3D 8
> +    required_parts =3D [
> +        {'num': 1, 'label':'misc', 'size': '1M'},
> +        {'num': 2, 'label':'boot_a', 'size': '4M'},
> +        {'num': 3, 'label':'boot_b', 'size': '4M'},
> +    ]
>      images =3D [
>          (2, 'boot.img', test_abootimg.img_hex),
>      ]
> -    for partnum, img_name, hex_data in images:
> -        test_abootimg.AbootimgTestDiskImage(ubman, img_name, hex_data)
> -        img_path =3D os.path.join(ubman.config.result_dir, img_name)
> -        with open(img_path, 'rb') as inf:
> -            data =3D inf.read()
> -        start =3D parts[partnum].start * sect_size
> -        disk_data =3D disk_data[:start] + data + disk_data[start + len(d=
ata):]
> -
> -    with open(fname, 'wb') as outf:
> -        outf.write(disk_data)
> +    create_gpt_image(ubman, mmc_dev, required_parts, images)
>
> --
> 2.56.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
