Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30722F34C4E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7D384206;
	Mon, 13 Apr 2026 15:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="At5qMXQB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FcdPbaRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA7A839D5; Mon, 13 Apr 2026 13:05:33 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D45283DC9
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 13:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DAVFJn2231027
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SmkxxarzV/CmO0YQt6ECMWbF
 VpqRSqlihlmPkthfmN8=; b=At5qMXQBfJfWG/DxQx6/Kxb1EhVkmBcFP7x8nGMN
 wHtXjagkyjwyJbU9PgFXjQ/5AVZabrN7WvMlDc/ErctJRge1gf/TXvq8c/g2CSS4
 6GsQxhUh3w75ldbP1zsOPi6izJwbCzbZvEp1rb5Ept1Nsj7eVe7fGHfB32gjO13G
 wq4QQhrNYBKCzeJ3ro1p7KejXWno4lyF7wNMcDqhuyLjutwC9ylOGoqC7Oq/MM4o
 uqfPkkOviwvk+hN4Hzk+AQp+9M8lnXdoIeqNLxKFJg8DXalEqU1SLxukly+6BC7+
 L5NtAPnhiMyn/HXhaXIVxNo2KvkneiO+47j4f1OQ1ZV2uw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dgxt603kp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:05:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-354c44bf176so4148536a91.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 04:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776078329; x=1776683129; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SmkxxarzV/CmO0YQt6ECMWbFVpqRSqlihlmPkthfmN8=;
 b=FcdPbaRu3izHcENRDanVXzYNzKrLHuU3cyoOdmxCjV+aiOkvizoT0VEBs1A7dVnyME
 YJzdNDUAyj6cX2dszMLv6T/YvbsX7XHHJl2oJI/fnWxTjmJLzg3LlWI9CkatViOxtMqS
 EoqXtDZeXxfMhd8ORaf922nFAiSjKW8ouwyMaF+RIz6g8dRwkZ8wborShH5tlGqZE3tb
 pmcMAhezBjud2pig3XAMB7bZvVCquHdoyCxzjeaky0Evg+QNxIq8Om3acGpf2KOH6f3N
 gfK5zd29it2aDNp8NraP0JJrd4+z259nvzI7kExI0A1kWoojnxWD8wQM3hsdwXoAjoQl
 XiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776078329; x=1776683129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SmkxxarzV/CmO0YQt6ECMWbFVpqRSqlihlmPkthfmN8=;
 b=RxR3FGfUQHq4l4EUnHQ/gpoTX6MFbUFcEuCQYyXDwpiGFKTxW7bVjmnt3FX8idF628
 HURjK/W75hDpeGUiVNUM7IZz22ZFIpWCHphRLzSGDKWkzQos8pKDsiNuLovN/dCU+/86
 p4qH1FPcEQdGNkSL8QGezyzPV0zxFQZ7u4vkraja6epTZIYafxwIqpEsEjfHmj1JRBJB
 X5+AbgMb0LPGdyJgS87sckUbY6M5U/qb7ASiwDwPnuRpvaGhc7puJK5bXh0hcBRFDBLY
 OST5gUf72tZhCBgEfhhBAGJDiFTweoA3nb1Yw547Ap/zuJi7GQqCxU6fDbBMdo+tZNjb
 pp9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gDKy3AUHOMVRR38JrvtqLuvmCSZhuUuCpxZpwSYZkpciPemd1P9ZLVHjs1WYIFzqh9axmICk=@lists.denx.de
X-Gm-Message-State: AOJu0YwqNZNF9hDb3Eec3LUl18q1y/QX1LXijTVIVbmhbL1d1WmYEBJw
 z4g88aFvGFklwl9Y/K9LlCwo5esua9IEQU1or6wLD191S3AinJ9U6/WUgr2QGs6ae/AESy6JVaa
 ebabJJY3Pjmqb4TwdIvGiKDyZba2eF93far4k8Ty9U8NoWtPSOAyETfNL
X-Gm-Gg: AeBDiesf/uoQJn8F6R0QLU4FeWR4jWLUQ4CPHR8OHTZnwJ0DUShxG6i4Ln0ewSJW6Ri
 YURSa10Iv2XDQetrzs0enC35GfwOaWQwUqsPuklXAtgeT4jfJYo1trcxyNDvipDC8X7wgmOzfQA
 pgYDmqd51e2n7ElCMrKDtwaL8ZU1dzhdt7H0Ixb4uUGvQJMAgpWmzgkTS8UgGyrOxLo/NxC3lOh
 RsYVGdaltdcU7xm/3W4j0oJnfP93uT9xIhhI1J+1Aonr2VGEma+Vc7Z7UbS5hrZH9mtPrtRNWlG
 rEu+wKzkp9cI2ZYhEkPuSR5VWmgA1ObbyEPRVa9RUO399tKl1+j/fQlbxp8n6GXjQu7aZzuV6V4
 NciI3F2FVB2FyYLM6amnnUP/brbOOws9wrvcwQkDAmTnMbFEaMKOd1Xhcul3Ria8xSMu8dAMBYx
 M2kH7Ju3oaGaLGdh/+HnQRApu4q16GYRVqc+c19wEFuznkdMaIEFY=
X-Received: by 2002:a17:90b:3f8e:b0:35f:b647:d973 with SMTP id
 98e67ed59e1d1-35fb647dbbamr3403414a91.0.1776078328660; 
 Mon, 13 Apr 2026 04:05:28 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8e:b0:35f:b647:d973 with SMTP id
 98e67ed59e1d1-35fb647dbbamr3403358a91.0.1776078328145; 
 Mon, 13 Apr 2026 04:05:28 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e412233ddsm12050789a91.5.2026.04.13.04.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 04:05:27 -0700 (PDT)
Date: Mon, 13 Apr 2026 16:35:13 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Simon Glass <sjg@chromium.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, alexeymin@postmarketos.org,
 james.hilliard1@gmail.com, michael@amarulasolutions.com,
 richard.genoud@bootlin.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 2/9] doc: board/qualcomm: Update RDP build instructions
Message-ID: <adzN6eXgqWCXwatZ@hu-varada-blr.qualcomm.com>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszTjj5HqMPpFiLY4gaLRNdZngRO3DWh81+1OczBL8Fh+04Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjj5HqMPpFiLY4gaLRNdZngRO3DWh81+1OczBL8Fh+04Q@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwOSBTYWx0ZWRfXxL2fRlQ3mYEM
 eYP85mr2MuHhZZfIlTgfS/oflZd0D7gCMaC8RkO9s4JERp936ohaa7V306uf2ZBYfYnxjQI4EGt
 e4oM5Z1CmYs+Q7GOTvxFqcAmFRe00+kFwtMHCzVucw3gDdB9R+VxJUq3BgP7fBQyD7i4HdKy4LV
 Cjy7UO2gXs2dbIvxRJ6g+6uWT95EjNeyJFRW40RdwMdaLu7owe0fmyWRCW12rFFIMkzH3FV1Q4g
 SPPXy34rEScO9llOojUgjXPijfl3Pz7nODs0Pp0L1V69zMR7k5nsXmKERsuQOy4e9KGH9MKu/p3
 Uae/ex9RLTzx68ZFJSn2ebRruRu9yxgdigdD4J1oDG6iLOis3x+23EF4p7wGtPKsxbizlKSTexn
 qbnMday19Yx5HOoGuKw76cnWGtt6NFUV73UowwLVkGtYf/i0oxkmSb33l1vFEr98GdCpXmW248i
 2lT9CE2BEElR4Lx4L9g==
X-Proofpoint-ORIG-GUID: ZMHdmm5czdhU_7TLcTUQ--Wtr7g_OX8D
X-Authority-Analysis: v=2.4 cv=br58wkai c=1 sm=1 tr=0 ts=69dccdf9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=wymJIEiuuitwIUvy1gIA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: ZMHdmm5czdhU_7TLcTUQ--Wtr7g_OX8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130109
X-Mailman-Approved-At: Mon, 13 Apr 2026 15:49:01 +0200
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

On Sat, Apr 11, 2026 at 07:15:55AM -0600, Simon Glass wrote:
> Hi Varadarajan,
>
> On 2026-04-10T09:11:45, Varadarajan Narayanan
> <varadarajan.narayanan@oss.qualcomm.com> wrote:
> > doc: board/qualcomm: Update RDP build instructions
> >
> > Add details about the SPL & U-Boot proper build steps, converting to
> > flashable images, source URLs for the needed binaries and scripts.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> >
> > doc/board/qualcomm/rdp.rst | 69 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
>
> > diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> > @@ -42,6 +67 @@ on your device with::
> > +Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
> > +====================================================================
>
> The section heading uses "====" which in RST is the same level as the
> document title. This should use "----" to be consistent with the
> existing "Installation" section.

ok.

> > diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> > @@ -42,6 +67 @@ on your device with::
> > +     $ make -j8 O=${out_dir} qcom_ipq5210_mmc_defconfig
>
> This defconfig is added in patch 9 - can you move the docs patch to
> the end of the series so the tree remains bisectable.

ok.

> > diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> > @@ -42,6 +67 @@ on your device with::
> > +             --template template.its
>
> Where does this file come from?

Same location as gen_its.py. Will update in next version and post.

Thanks
Varada
