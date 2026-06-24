Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3DCCDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 13:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A69BC8460E;
	Wed, 24 Jun 2026 15:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EnY9Fu5F";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Aw/a1vzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 278C6848DC; Wed, 24 Jun 2026 12:08:08 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D57846E1
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 12:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O5u5jI1892538
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 10:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U2R6eJ0BRhBHoqNkdHXoB0cv4LtRD3xXtXbAfGe3ACM=; b=EnY9Fu5F1safLoAm
 kIeR+CqjzoVTQUfaXvRdK+tN0b/thI0D7NG0JHn/Es1MZUhXEiD4e+VS7yIULuBT
 rOK5Hr9bhLGtGJIORQQZb3mIX9k4sZRCQGpPyod/4pDCJKiMJRiyrSk2+sIJ82Bs
 TwF8E+kuPxbYqcs5TnN+c59YkNrAbK4FoHrqGgY5CLERVj+Luj3RzVvf3SykUUEU
 7DShqLzW7eRqESGbFJC3k8SWI1w8sdWF7iAEwCHp59hwbjho/r+t1n4QmKda3+Ud
 F68FA3arKZqBF17N0hY/frzpz5TNE9oU9FSGtxi93aMQ76+WNYDVgF6iCkuDDvBj
 R9GOeA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05bf9ny9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 10:08:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c7ef3cc6d4so765695ad.0
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782295683; x=1782900483; darn=lists.denx.de; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U2R6eJ0BRhBHoqNkdHXoB0cv4LtRD3xXtXbAfGe3ACM=;
 b=Aw/a1vzQE9nZ5sDUAPDawNbIsDCu8Z4YXXJ1G9vIOZDcwk6rnfuDCPpbw5OBThofEz
 7RGroa8twOCqwsV+zpibHyPyqqy5Ns7IH6f+Rma1IoGkTnbrwzR9FC3Tk4z2WLByZ1Uy
 GkOjUI3c7kMLn7n6cSUfAHSC6KKRT5Di5eoEiTTUsbNg7riQmxYccQvXXJVF0ektSsQ8
 O8v+HCgpymK308z84le42aN4jSaOpp3sGZOo8VzvcY3JieIiK+am05RYQtNAvUJlmpKM
 5HzZn2gF2rWJcU4geeCBRJ5dj1WtVRrlV1ocwCelSjJ2jhvfq8CUatOaakrLi6Yf/Z4Q
 H/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782295683; x=1782900483;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U2R6eJ0BRhBHoqNkdHXoB0cv4LtRD3xXtXbAfGe3ACM=;
 b=V1R3AZmwCaAqFs7wG2aS2+4rnA92ASC+6t3nC2yraIfp02LHddivnfhX4ABMHlnf8A
 cEGSeMt3I8atGJIET8Qst4c83UpG6ieJs3Gx4heywojFzKEYxiHSNv+XcFZxyC+dAzpc
 ItxYkOKodnUR1Pt2SluQQPJdFn4eVPnP50GC2CJ6SyrsWWcj/SW1mp7M+V/BVGHVwYFn
 66yGvHCr4eBkDCmmlOdvtZvne81c2vG/Cn/5olukmlNlw7myEl98dzIH43Wo04mN/W+H
 dk2/dp4QzYofT73Tpsnotm6QkpEdBnqlUeM2HLDf52VEmaAqiHFuEqvDcCJ7gZoYSbty
 uuGw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqg2jpD0BMGXtImouj7Xdxf+U0qNaeg9iuOA594Tqc+KK5HazecjQzH/reyOKhcPjqe/ITegw4=@lists.denx.de
X-Gm-Message-State: AOJu0YyIMMlbsAIkB1puiSP8rd98rrQv+78up8X2d9uOgTCU9/GKuo2b
 cYOlXpvlZ2m1fsJIPAF3nH1h1CzQs0Ad/1tPLd9jRRVQWrsx3rmonIvY+VRjigd5mFfZGD5dPJj
 10z4h6jdac1qsL3SQO0wYgvQ2NUEXiwgYW9/eY86FjuGvTOKSYpNMeWPW
X-Gm-Gg: AfdE7cn/BBhcRavbTD0AmH50ofgmcdlbkXA2YF9yZ5m803Kv56EtK2gt5HZ19k5Iji/
 oD8yok76aoQr2PkqKSN7JATJPcLxiapPuTOvAZUYe4rDdVCJ0UCI1oC4YpllWKnZZhMLAVF0UeK
 gJhk8CXxh8vWrH84rqaOnQ8PHVm6Jrr0pOW78bD+8U+0IhH29r9n56N0E0gjP+dCLYEj78BmX+C
 5FSAZS4iusruUB9yA9Fj74IWdpPfXPmw6gCbdgdASuZF5vWNuVkIshh0rBmMPMMnnSkO3zs1lBS
 xseVsMn4kYLsjWQfD4Bv+GrQZDOib2B/nzOmt07Km6TRyAw7r6FGEvd2Y4osjOXjLQQRZdmBeZE
 XBORpYfcXq+/o9XMHBH8qUWzRAZL6y6VPxyfJIKOvdjCPn3PpvHVnHj3b8oTTmLjN+jNsQ5TlZ2
 Yj8WrfTJybosc4umal7zNCEexdiYKn6bBBCo5pFOe6
X-Received: by 2002:a17:902:d48b:b0:2c2:27be:39a7 with SMTP id
 d9443c01a7336-2c742b4bcb6mr192558045ad.29.1782295682802; 
 Wed, 24 Jun 2026 03:08:02 -0700 (PDT)
X-Received: by 2002:a17:902:d48b:b0:2c2:27be:39a7 with SMTP id
 d9443c01a7336-2c742b4bcb6mr192557605ad.29.1782295682246; 
 Wed, 24 Jun 2026 03:08:02 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7439f86aesm129263115ad.49.2026.06.24.03.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:08:01 -0700 (PDT)
Date: Wed, 24 Jun 2026 15:37:48 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Simon Glass <sjg@chromium.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, alpernebiyasak@gmail.com, tien.fong.chee@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com,
 tingting.meng@altera.com, marek.vasut+renesas@mailbox.org,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, mkorpershoek@kernel.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, n-francis@ti.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 bdklingerman@gmail.com, richard.genoud@bootlin.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 02/13] binman: qcom: Add type definitions for Qualcomm
 binaries
Message-ID: <ajusdLwkl7v49mvZ@hu-varada-blr.qualcomm.com>
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260617101812.299586-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThw0BNAqzJuqWNRwViyTi6-Ez1e=d2jnV9QhWbDrGQgRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszThw0BNAqzJuqWNRwViyTi6-Ez1e=d2jnV9QhWbDrGQgRA@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=X8Bi7mTe c=1 sm=1 tr=0 ts=6a3bac83 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=1KQRXri8A6WFA-ZAn_0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: vDLjPuE4NI7F0WmdCZGA3CIHLVr3RZo_
X-Proofpoint-ORIG-GUID: vDLjPuE4NI7F0WmdCZGA3CIHLVr3RZo_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4MyBTYWx0ZWRfX5wT7Ft0s7zQa
 Ovoz/BiCziRBfK+RklE5/H1U/FbxpR5ujRNlKWE/56xjtH8n9cJ2HaaU0OMCfbPvcnc7yYhOqdf
 p0w/iuRdBuX6XkY8+sERA7roLTBXVFQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4MyBTYWx0ZWRfX+vs0r65NMz27
 cIoAbXNueYMoOXR5YK77KzSi3/z4iNULjrPdOHOwHaLhh5N8972rOs6UWGAYUwUlBaIB+9RVuti
 3TDW+Dz2bCUzzqRGy6JUNCAihhNkMstLr36WiIqygATi8l+nIexhhb52Dl8HblKQwDoU+79ggM3
 0dNpwITI9+ddi10ACUi6GjGJNBQvIZsmWVju7xq9e26R+dmQvqMhU4fRH8tlZj4gebnItCiPj2L
 JTsubgM5hHJltppizOVUhWPx9tf0ds3vYa57pwJ95F2dgEm93snRUNe5CR8MIXnyB56I6TJx0FP
 Cqn4nsAI2ViOHgDOACtdJ2g7gC78FtMWoy8GCJKy7qY6NYI3rZZ7Y+nYmpC8EVQzxJQ6vXK31pS
 l/f/Zv9u4ZeB7ncoACsCvSUSY/s1fd0Zv4R49gM4tqqUOHDEyl/wvoXW4leLfbg+G9rBc68DJUT
 TQfkqksuLvZBugrzanQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240083
X-Mailman-Approved-At: Wed, 24 Jun 2026 15:15:53 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

[ . . . ]

> > diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_appsbl.py
> > @@ -0,0 +1,23 @@
> > +    Properties / Entry arguments:
> > +        - filename: Filename of U-Boot MBN (default 'u-boot.mbn')
> > +
> > +    This is the U-Boot MBN image.
> > +    """
> > +    def __init__(self, section, etype, node):
> > +        super().__init__(section, etype, node, 'qcom-appsbl')
>
> Not quite. blob_named_by_arg looks up an entry-arg called
> <blob_fname>-path, so the actual property is qcom-appsbl-path
> (matching what your doc patch passes with -a qcom-appsbl-path=...).
> There is no filename property and no default. Please update the
> docstring to match the other two new etypes.

Ok.

> > diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_appsbl.py
> > @@ -0,0 +1,23 @@
> > +    def __init__(self, section, etype, node):
> > +        super().__init__(section, etype, node, 'qcom-appsbl')
>
> qcom_config and qcom_lib set self.external = True, but this one
> doesn't, even though u-boot.mbn is supplied via -a qcom-appsbl-path=.
> Should this also be external? Otherwise a missing blob produces a hard
> error rather than the usual missing-blob warning.

Ok.

> > diff --git a/tools/binman/etype/qcom_config.py b/tools/binman/etype/qcom_config.py
> > @@ -0,0 +1,26 @@
> > +from binman.entry import Entry
> > +from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
>
> The Entry import is unused - same in qcom_lib.py. Please drop it.

Ok.

> > diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_appsbl.py
> > @@ -0,0 +1,23 @@
> > +# SPDX-License-Identifier: GPL-2.0
>
> The rest of tools/binman/etype/ uses GPL-2.0+. Please align (all three
> new files).

Our legal doesn't allow GPL-2.0+. If that is not acceptable, let me know
will talk to them and see what can be done.

> > diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_appsbl.py
> > @@ -0,0 +1,23 @@
> > +    MBN is a Qualcomm‑specific signed firmware container that packages
> > +    executable images (typically ELF) along with metadata such as hash,
> > +    signature, and certificate chain, enabling the secure boot chain and Root
> > +    of Trust (RoT) to load and authenticate images.
>
> Just to clarify - the doc patch shows this entry is fed u-boot.mbn
> produced by running elftombn.py over u-boot.elf, but the binman node
> in the dtsi treats it as an ELF (fit,operation = 'split-elf', os =
> 'U-Boot'). Is the input actually a raw MBN container or the wrap-elf?
> The docstring should describe whichever binman consumes.

Input is the MBN container. wrap-elf is for the SPL. Will update the docstring.

>
> > diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_appsbl.py
> > @@ -0,0 +1,23 @@
> > +class Entry_qcom_appsbl(Entry_blob_named_by_arg):
> > +    """U-Boot mbn image
>
> New binman etypes normally come with an ftest entry and a small test
> data file. Please add coverage for these three.

Ok.

Thanks
-Varada
