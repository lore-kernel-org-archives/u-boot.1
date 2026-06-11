Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90E3CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D88D1848B0;
	Thu, 11 Jun 2026 14:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XOJN5UEH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="br/4deHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102298407D; Thu, 11 Jun 2026 07:59:32 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B404780086
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GSoS3835182
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 05:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lX62f1CQRlYvR7IQk7pXhtvw6zxiurdf1CaKYaQ8Cbg=; b=XOJN5UEH6UixxMaC
 ZrXF1Ckuh0dR+Ls2LaxMgbjxc8qY2KMp2mQ4b086PQ7jJWRINSayR+A2bO8tWviQ
 Zm/PSI0N3a3wOgEh6alavE3k1UBYBCgz414b1gqptUR3KlxLn1DmGopqEAevJXBl
 O9oQPh7IC/Wz373Q322ihbhyDdwTxv527EulY+q3HPok+VnHat9tL7h9CXoKKsGy
 9ZSVRZn/R/ituM/4fVGhN8kud2mruc9/b3kHM8zOGIQ5ZrNj61aQsmMi57FWnBbN
 eht/P7HUJDHl2z02zlzTUd2k9FslIbJEGk2ODFL9yQjfs8qkK/KbpcrUcFwey5Ne
 rij7iQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6thvps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 05:59:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bf3636d6c0so79933145ad.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 22:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781157567; x=1781762367; darn=lists.denx.de; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lX62f1CQRlYvR7IQk7pXhtvw6zxiurdf1CaKYaQ8Cbg=;
 b=br/4deHo+z9EftdJxKzP4JIOWfQkBZLrmkHDBABJXK6zbAfcmDOVOxtj/IiwOE3miW
 qq40iFHQMVKXgAhtROGAvNXsN89Dx4fmZYm1GbCbIq9nDGdmywPHiu4GYzPedIh6hmKX
 aK36e41uGXrOo5NS6wZn3IO3EEZnD9wvHdFaOs1/hd8N0Jz0A4Vg3Yywaom1/ZN0Q7Hr
 A62H1EZNL5CIL8/KZTcsqk1PcKvF2RB7RTzY0UonC3zKy5xSu/Dfs9nssqz3ubqRJU7p
 F1Pecdn0tVAmolGBY2H0s6/GYt833iUwNWDaS3LGAov1dxLuDbS+m+UKVhUhIgFRB9/6
 apGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781157567; x=1781762367;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lX62f1CQRlYvR7IQk7pXhtvw6zxiurdf1CaKYaQ8Cbg=;
 b=cLhUeznKuesS/FrrhSBriIWbvK2lW7Kxq+lAnzM6zUStf7Y1Ik0nyykEzDsP3Pfbrn
 xStT/48CdwHEk/7IO3VMt3MeoOpO/jXod4mIaaGmossErpzHkxs0UgKLKZmM3EhNcZcm
 roOhdZQi8+UtWp8fnMU/E0/iVOIObSaRnKs01cP0HwaRadAI4p5agcf715GhF+WejsSv
 hGrqHtj30WG+B0QkejD6dL+a2baqkQTF424wUJ8ewSEApMR/cpHpbNltz/xOmIsXstZl
 hQtLxo8IgstWS8TA9hlM8tF52hGLYuqneOnlE8gaLy8TJTHPnEIJA61AxW0X/lIOqvho
 uwbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8digOMWKiD4ADZZZfN2ywPAhenE/mkXbtWoEHqOF1LWwXLnioKnhtuTGkBAbS7Nfi0zOwulXo=@lists.denx.de
X-Gm-Message-State: AOJu0YzRPRzLzThvdgvx8E4IXIHi0EK1IKbqwEZH8FGFDD0ZWzgwf/Qo
 +tpyFupX0FwE78+eoIxRVsflnisy0lDEkTAbFVTO0LuysXPZgrL7C6DN6G/3S0VWGKMAGtWT4ay
 /0mOi3/+adTRtBdDDlVEFQMNeE/ZZiy/PA3WIZWlxse5J8ozTeTqIOjJ8
X-Gm-Gg: Acq92OELakBPGqK2uQL446AdGLJdP0sUbmMe35FkwSZ7bA7pNahNNzpG9I8t6kqHMLv
 6c40xnUI6TyJ+rJt2NJL5LXN/ypkFuUdCpD1OiGX0eyLO2hYm3n6SrpFeZrh2zl5Qk4QJHAMPD1
 YhDd+GkrXyvQ/8bcQZ+miaY0Fu9Qm+WSpUejKb47fEWUONj9riIgxn4pj8fGIcdAk9j2AdtQ1c5
 lRaqAd/E2ozI6DYljEjKibNyJ6tRg0QEIdImOWvVN7S9aJUdc1bBhQIN88GOCZzsbnurW00o4fz
 86mEIrJhZo+pxM3KJ9Wwe2XtMRGoZHgTFp0iYX6uZ0eXxoeXTnsC1oUdxwWmwvetdhmVdFPVwH2
 0YX+vmLtHzS4OcJO67jhUixr98Ixji/QU54vqk9pLo2GAFvZvoPfD+enKyfFLl4mCTGwurvUQc5
 goEiier5rTycDlxgKUsoanRwRZ0VyqGlMEWdBofpJ9T5TONbZOXB0rpB6vtyo2Zg==
X-Received: by 2002:a17:902:cf11:b0:2c0:f807:a760 with SMTP id
 d9443c01a7336-2c2f14f6cc3mr17596725ad.13.1781157567183; 
 Wed, 10 Jun 2026 22:59:27 -0700 (PDT)
X-Received: by 2002:a17:902:cf11:b0:2c0:f807:a760 with SMTP id
 d9443c01a7336-2c2f14f6cc3mr17596245ad.13.1781157566721; 
 Wed, 10 Jun 2026 22:59:26 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16629cd24sm330474885ad.57.2026.06.10.22.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:59:26 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:29:12 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Simon Glass <sjg@chromium.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, alpernebiyasak@gmail.com, tien.fong.chee@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, afd@ti.com,
 marek.vasut+renesas@mailbox.org, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, andre.przywara@arm.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 danila@jiaxyga.com, n-francis@ti.com, ycliang@andestech.com,
 mateuslima.ti@gmail.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, bdklingerman@gmail.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v4 02/13] binman: qcom: Add type definitions for Qualcomm
 binaries
Message-ID: <aipOsPHycEvZLuV6@hu-varada-blr.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260604093132.757583-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszTivKopo8v0v3yad5HCvSSaDygkQ-u7QJ5QR0WkKsTi-4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTivKopo8v0v3yad5HCvSSaDygkQ-u7QJ5QR0WkKsTi-4A@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1NSBTYWx0ZWRfX9Eq/4QBPbU+v
 rwZCoG57Qbv/rtEmjLKzJNvlIGP3uT+lDBN/gcUOCBapy2b++9U1kHnw1FPPoK7APg3qU8YgR07
 4DNt5IHlU0MAezZYV/xkaEJEYEifdE4Df37KDd0PlIU2yzV6OljQlgYvEL+TwowOddkYUwmCaul
 oMPl2Qx7Zrz4YIJNPOOxURT1yOOupQ+ALLX5291LIHzN9nFnJ/YkDEpAxOseiF9KAhbzLZsRTMG
 eXlw6GXW2mM/3JkzOuftR178EU7GlwAGYPYgpFw6E0+NgK2cWonaUvaaMxlyTkG9YdNsuT+zk30
 va1N7uZopeuALbIFrtX+AM2ZV4RKRdYTYKnfJDASgJHEI+qvI7aP++7nqGl6xLvxo5SP9ovp/C+
 lQxi6NgBuQ5k0mfFGpqZe2vmUdAUUHyERy/KI6jQnscqMdoaJsuUErTvc+VTHVhV9tFPfBkReJ0
 6PIYOyfRdm9cADd1gxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1NSBTYWx0ZWRfX5ugK4aRz9pq3
 QpxUAINf/6o4Z4/im/XDx7aAx5DSXLOm3D2jI/FaQXxtRpMrO19CaCUFxcRLzeHfIq29SxS/1s1
 ZFDH8/uCBpYmxNcBdMZTRvU/ztj02lk=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2a4ebf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=t_TJ78FWKnDeFVG0vNcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: rwPKQP_FkohL4kRurunl32BwHXR6N4uc
X-Proofpoint-GUID: rwPKQP_FkohL4kRurunl32BwHXR6N4uc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110055
X-Mailman-Approved-At: Thu, 11 Jun 2026 14:44:23 +0200
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

Simon,

[...]

> > +    Properties / Entry arguments:
> > +        - filename: Filename of u-boot MBN (default 'u-boot.mbn')
>
> U-Boot (not u-boot)

Ok.

> > +    This is the U-Boot MBN image.
>
> It is good to have this etype, but please document it properly. We
> need to know what MBN stands for, along with a link to the spec, etc.
> Also please describe its role in booting.
>
> Please do the same for the others below too.

MBN is a Qualcomm‑specific signed firmware container that packages
executable images (typically ELF) along with metadata such as hash,
signature, and certificate chain, enabling the secure boot chain and Root
of Trust (RoT) to load and authenticate images.

[...]

> > +class Entry_qcom_config(Entry_blob_named_by_arg):
> > +    """QC Config ELF
>
> Does QC Config mean Qualcomm Config? Is this a configuration file? If
> so, why is it in elf format?

Although the QC Config image primarily contains configuration data that
could be represented as a raw binary, it is maintained in ELF format to
ensure compatibility with Root of Trust (RoT)–based image authentication
during the secure boot process.

The current implementation aligns with standard verified boot requirements,
however, support for full secure boot is planned for future enablement. In
that context, retaining the ELF format allows the image to be processed and
signed using the standard Qualcomm image signing infrastructure, ensuring
seamless integration with the trusted boot chain.

Thanks
Varada

[...]
