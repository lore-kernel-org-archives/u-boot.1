Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30EBC44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 05:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 290BE842FC;
	Sun, 19 Jul 2026 07:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rp1QzGv7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CjlmEI+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D7C88460E; Sun, 19 Jul 2026 07:06:02 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62170838D7
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 07:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rahul.pathak@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66J4lbkS2779556
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 05:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xk1VlVE00HwiCbSLoMsM9tRKiBv00DAwxmEsyUa/RYE=; b=Rp1QzGv7rj4qf48Y
 LTT7P9o1Jo492tioh7zO6F8h4Q60XFkid3lvnlPPXhXQdaLpP/khFvFbyE8xN7fb
 HGdVSF5JDRbQNWvoF5VqC1P056XL7ybERuPcEcHG5OL7P2R6+dGbMAwiNhkAZ6fA
 PS2md2rMu0eAB+7La4Gd4xgKm7F6vfKl+6mg0b1xLoAzLaaC7J4Z3POxyht6/E0a
 vsiuW59aEzAZc/Ih7qh+buwWu0axBy4V0sk8OYFcUEW7ttB04Rii7CMF81ZPbqp4
 aZG9SvTrLX49iCvI0G8FTze/JQPEOmkVcXp//G8DBRCGdliWG1oPzMfjlXagrFrp
 DhiL5A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2c6a65p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 05:05:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92d1cae5939so1568150585a.0
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 22:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784437557; cv=none;
 d=google.com; s=arc-20260327;
 b=ZoB8df207ByqH8+0eFgped0ZgtHGyw/pzOhtd+l3Ig9tJ/HLRn7B8G7m8hUeyzlxb/
 Ed8Zy0geQgfJDGPUV+jUbcXzneRsxhtXo9y0xfUVY4zDEJywa/nRg9NwSeeLkOR46cPe
 oH/MAuvUp4k/OF6tAvBOdOBI+EedKhuiwL2VMdvtwJYQB9cPMByyQ5AOece8O4mAh4Ui
 fmuXm+LFtXYaYL7wf052AB6uTlPdXocsFMKRXpMlBVNMFJwPNsVOqIwUNO4rKcZOCiP+
 TlPeiJTM9WGfy0zurbRqxphxlmcxzKErqEqfySglExSquQo9HIEFVU9q4/Zn8evYlSbq
 Lkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Xk1VlVE00HwiCbSLoMsM9tRKiBv00DAwxmEsyUa/RYE=;
 fh=lKF8suJlCFCP9fZ6gCQfGg3jHgNxOnuuzuUhGi7d6ow=;
 b=C/BA1GEKcFtElJ6kX40c7XQak8lYxLxfwGeCZ5UWHVdgTHxxe8CePi+7000m207Gzi
 rFcz/qZBvdhppiHuMdPymzmqtKgyaLWl5phFTlPP6qP3y+A7lVqMj5DHpNfLfSs0Y6Ru
 C5TTyCFxWXlyH+V68rBAX5kjULzy+FRQepS6vF40zRKZVHQqOjyd28xI4CSA4R7EkG25
 jyf0IbT3dweb7ucDjyqHiXJxtXE7whRxVw/i2U+wEoBMMiMkqzP+0RSB7YncZzjHPQg0
 wBn5Si2AaeVXjgo7zH8L+DP2lAHOKC9jAGVSjzvVZMdF7yXFB8yNDYncEdHxblRgnfjM
 GjLQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784437557; x=1785042357; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xk1VlVE00HwiCbSLoMsM9tRKiBv00DAwxmEsyUa/RYE=;
 b=CjlmEI+0By2lWkNVn0sEeXqZkBKqdypGBhNsPMv3wdheg8m2ImduSZ+CtL4gc6y9fn
 lJYnQotZtDYPXkN5MDOe3yc8NdEU3moN+HdTkrNQhiz/oHUDvGRVN8VgvFcGOJJ9jeDa
 G+IIlf1y4tdpYnTbu6nPREM0xlD+Qbni/HTv2EXy9DwsXc0I1v1QzMPWvpJaWY/qfEGi
 9aIX/oSOrVM9aAhQuk9XonpzzhOibbC+lsCiY/f0qbet/Y8hFC/fAKmy8lR7FZMzzz7q
 8d7Km+YhbK5fyQ4iLf+JUYSPHjinSQid5U7PM0g8kFyXkms2kMrW8Wv54dnIdumNug3a
 hSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784437557; x=1785042357;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xk1VlVE00HwiCbSLoMsM9tRKiBv00DAwxmEsyUa/RYE=;
 b=L+mYByxBOy0FWeWySWBYJpDzqTAMD/RVsJw58TN1VTiMQrPwCZ61JhUFOYJIe7dJ7v
 fhrKHJarw99WAuyc5wS6M+HW14JLQZ5Aax9peHyyQt1osIYbuc1eDC2XQDJRD7BkDMid
 8dXTcjZtZdMUooPTdavyCsEavzrxZG0gIMQ1snQPOIM2kzUcNJmmxQc708fA7PRk/ToB
 TTNW9I52imbgCps9oDGmcCDFGhCrRSTKSxa2ddZt9SUfmgWZHwRHUVQep0+FLU+vBH8W
 Ev28VA/Y8rM9/WSnpSf9ybsvyEGw/SkNRw/Xb+K0uh5a7ufd+YtDitUz3nsNij5/CXXG
 pDaA==
X-Gm-Message-State: AOJu0YxhP04VQ3m1qj6+/5S/R6027uBEAZltVql5nSGuXdY8DiBKA/LO
 6qWD8XIzHfGu16RQDqqKv0A2mhUbSuFu2oFavC0j1Jl9t/i2+Mhz6zLL/8NU1kwO8KvaYejKLWx
 xBPc0nxBRKr62DogyS3lr1PJTkrbO5dsJSCMKqVYNz+ja5IvRmhIJSlaggOXPnJ9D2bZe83zG4i
 BRl4DZecLApaz2abjnR+mCh1PHT3tfJER1aHIz49o=
X-Gm-Gg: AfdE7ck+1XKtMSKSZ09zleh0vmwFugR7ReE2nmbACormVtfxDV5iU9bmi8Fl/y1oblG
 t/uxY0laWvNU6sssfQkNa+masu83VTFzw2YtIlgtHylYKEKX0lnPuKN8AAbkNjMyJIHqQtcG0XW
 9h+o0ina/q06FfC2ZnS+QSdLr3haJ/u3QI8CNfG6QLAiIuluOJo4KpCTgJ2g==
X-Received: by 2002:a05:620a:4049:b0:930:912b:7a38 with SMTP id
 af79cd13be357-930b41b207fmr957127985a.51.1784437557213; 
 Sat, 18 Jul 2026 22:05:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4049:b0:930:912b:7a38 with SMTP id
 af79cd13be357-930b41b207fmr957127085a.51.1784437556823; Sat, 18 Jul 2026
 22:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
 <20260709175605.1070755-2-rahul.pathak@oss.qualcomm.com>
 <alZzO78B4Jrouult@bby-cbu-swbuild03.eng.microchip.com>
 <CAFR3w37s_byoZH6u-YVLLfa9xcHi2nuA5vs-_=pMikZ=8_1NZQ@mail.gmail.com>
 <alj4yyk6xYb1SyTa@bby-cbu-swbuild03.eng.microchip.com>
In-Reply-To: <alj4yyk6xYb1SyTa@bby-cbu-swbuild03.eng.microchip.com>
From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Date: Sun, 19 Jul 2026 10:35:44 +0530
X-Gm-Features: AUfX_my-Slw8nagTaLl0LmXH7ethOcBjDVmYMmsU9fO4g80W5ZiDOOJKYuf8Ylk
Message-ID: <CAFR3w376PoJ4UO6UUSUpwEWigU2+rTwaO=_C82SkNYnfcRAR8w@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: Add SBI MPXY generic interface
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.denx.de, anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ssphHqvDN8TpdAhSgdfbv1lAjKzpF8Tz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDA1MCBTYWx0ZWRfX8ODVKixOgAvx
 pVUIRON2Og/hkgU/L20ntZ1fmChyh3rcx67Ee2NZyWPsHJMjCbo3fNy3+17owafWyLvAmU4z1n7
 z4EL6U66MZpqXYsPLtCRWurADgifSHol6SvvZjBwSNeCXJ+jP5gC6LvBg4racSkCtIZ/8nZJmuZ
 7WEVRSXm1p125e9AeYDfCFmgd8UPidt/hFct8gZaAh4sGZKjgOQi9vcNAehB0+aEpQYZmWixE0U
 zRNACfVrsf4DZ1OUP73RR07RsyTzHpgYSqf3BuTAiknqvlZ3ql3rnVQNm6qT6p+ZFbjUY7vRucu
 otvrY+KOcSHM2372aZlzfdjNOtUpu9CaZLd0n5c7qbslKmFA0gx3NPVZbpqXfE+Mpl4S6U2HshA
 ZMnTbJLsyvoCr2EJ8IP3A46/jnTv4jouDlN8ajyZnnpX1soM4CQbqZt/fNucDVKrGCcvWCQSuZW
 wZm7V7Z4/rpzlpcmmGw==
X-Proofpoint-ORIG-GUID: ssphHqvDN8TpdAhSgdfbv1lAjKzpF8Tz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDA1MCBTYWx0ZWRfX2lLVyaC3hWS+
 LDnIA4PQCmzpqwwQLgBezkGSwpFeJyKiCGBzRDOzr87W25O5ZTBH55A1eOHJ55jKUeOtRi4aGc1
 N+9WExLKgtIhrwpoY+tRk4KHE6/1HIM=
X-Authority-Analysis: v=2.4 cv=CJQamxrD c=1 sm=1 tr=0 ts=6a5c5b35 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=XYAwZIGsAAAA:8 a=EUspDBNiAAAA:8
 a=LD3NjR0hWIX_ulMpcKcA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190050
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

On Thu, Jul 16, 2026 at 8:59=E2=80=AFPM Charles Perry
<charles.perry@microchip.com> wrote:
>
> On Thu, Jul 16, 2026 at 07:39:52AM +0530, Rahul Pathak wrote:
> > On Tue, Jul 14, 2026 at 11:04=E2=80=AFPM Charles Perry
> > <charles.perry@microchip.com> wrote:
> > >
> > > On Thu, Jul 09, 2026 at 11:26:02PM +0530, Rahul Pathak wrote:
> > > > SBI MPXY interface implements the SBI MPXY
> > > > extension to interact with supported message
> > > > protocols for platform management and control
> > > >
> > > > Signed-off-by: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
> > > > ---
> > > >  arch/riscv/Kconfig           |   9 +
> > > >  arch/riscv/include/asm/sbi.h | 268 ++++++++++++++++++
> > > >  arch/riscv/lib/Makefile      |   1 +
> > > >  arch/riscv/lib/sbi_mpxy.c    | 529 +++++++++++++++++++++++++++++++=
++++
> > > >  4 files changed, 807 insertions(+)
> > > >  create mode 100644 arch/riscv/lib/sbi_mpxy.c
> > > >
> > >
> > > ...
> > >
> > > > diff --git a/arch/riscv/lib/sbi_mpxy.c b/arch/riscv/lib/sbi_mpxy.c
> > > > new file mode 100644
> > > > index 00000000000..f95cedaabac
> > > > --- /dev/null
> > > > +++ b/arch/riscv/lib/sbi_mpxy.c
> > > > @@ -0,0 +1,529 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * SBI MPXY (Message Proxy) Generic Library
> > > > + *
> > > > + * Copyright (c) 2026, Rahul Pathak <rahul.pathak@oss.qualcomm.com=
>
> > > > + */
> > >
> > > ...
> > >
> > > > +
> > > > +/**
> > > > + * sbi_mpxy_read_attrs() - Read a contiguous range of channel attr=
ibutes
> > > > + *
> > > > + * @chan:            Target channel
> > > > + * @base_attr_id:    First attribute ID in the range
> > > > + * @attr_count:              Number of attributes to read
> > > > + * @attrs_buf:               Output buffer (attr_count u32 words)
> > > > + */
> > > > +int sbi_mpxy_read_attrs(struct mpxy_channel *chan, u32 base_attr_i=
d,
> > > > +                     u32 attr_count, u32 *attrs_buf)
> > > > +{
> > > > +     struct sbiret ret;
> > > > +     __le32 *shmem;
> > > > +     u32 end_id;
> > > > +     int i;
> > > > +
> > > > +     if (!chan || !attr_count || !attrs_buf)
> > > > +             return -EINVAL;
> > > > +
> > > > +     if (attr_count > mpxy_ctx.shmem_size / sizeof(u32))
> > > > +             return -EINVAL;
> > > > +
> > > > +     shmem =3D (__le32 *)shmem_base();
> > > > +     if (!shmem)
> > > > +             return -ENXIO;
> > > > +
> > > > +     end_id =3D base_attr_id + attr_count - 1;
> > > > +
> > > > +     if (base_attr_id < SBI_MPXY_ATTR_STD_ATTR_MAX_IDX) {
> > > > +             /* Standard attributes */
> > > > +             if (end_id >=3D SBI_MPXY_ATTR_STD_ATTR_MAX_IDX)
> > > > +                     return -EINVAL;
> > > > +
> > > > +             ret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATT=
RS,
> > > > +                             chan->channel_id, base_attr_id, attr_=
count,
> > > > +                             0, 0, 0);
> > > > +             if (ret.error)
> > > > +                     return -EINVAL;
> > > > +
> > > > +             for (i =3D 0; i < attr_count; i++)
> > > > +                     attrs_buf[i] =3D le32_to_cpu(shmem[i]);
> > > > +
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     if (base_attr_id >=3D SBI_MPXY_ATTR_MSGPROTO_ATTR_START &&
> > > > +         end_id < SBI_MPXY_ATTR_MSGPROTO_ATTR_END) {
> > > > +             /* Protocol-specific attributes */
> > > > +             if (!chan->proto || !chan->proto->readattr)
> > > > +                     return -ENOSYS;
> > > > +
> > > > +             ret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATT=
RS,
> > > > +                             chan->channel_id, base_attr_id, attr_=
count,
> > > > +                             0, 0, 0);
> > > > +             if (ret.error)
> > > > +                     return -EINVAL;
> > > > +
> > > > +             for (i =3D 0; i < attr_count; i++)
> > > > +                     attrs_buf[i] =3D le32_to_cpu(shmem[i]);
> > >
> > > Shouldn't you call the ->readattr() callback here instead of manually=
 doing
> > > the read?
> > >
> > > Also, I'm not quite sure I understand what purpose those callbacks se=
rve.
> > > From what I'm seeing, attributes are always read/write using
> > > SBI_EXT_MPXY_[READ|WRITE]_ATTRS because the transport layer is always=
 mpxy.
> > > Would a non-RPMI protocol do something different?
> >
> > Reading the attributes is simple and can be achieved with or without
> > the callback but
> > writing the attributes may (or may not) require any further protocol
> > specific validation
> > which is not assumed here and hence used the callback to keep things ge=
neric.
> >
> > That's why I didn't use callback for read but for write. I am fine to
> > use callback for attributes read but I would prefer to not assume
> > anything and keep write attribute callback.
>
> The only hard requirement that I have is that we shouldn't have dead code
> and the ->readattr() callback is dead code in this version. I don't have
> strong opinions on whether it needs to be called or removed.

If that's really bugging you then I suggest removing the RPMI
implementation of readattr only and not the callback pointer field from
the struct mpxy_proto_ops.

>
> Thanks,
> Charles
>
