Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3CDC44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 02:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8E184C73;
	Thu, 16 Jul 2026 04:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oaw/VNC3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RQjf2Gcp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F78B84CC4; Thu, 16 Jul 2026 04:10:09 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80B6280087
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 04:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rahul.pathak@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G0XcVw1242819
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 02:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s09j4Ykzn+Sv1s0poskPSF8TdhHVwv9fVi34/R4XIec=; b=oaw/VNC3KU8fW4ER
 Wy9A0+zYZG1MfMBKHJkjhj6sCPoS/Z/i7wqFrF68aXg+WILKB/tw/sYfUwK8a3rQ
 hULPu7YQZcbdA7Y2YCIm0dEL/1w81RutNr+IhMOQWqjth6QAwRojEKs1SEh/LPE/
 rIcqADv+zbPH9tEjgSkMos6pIFF4jiypHsZw2EeTPk8TfNf5Imqn53EuWd1XsPQ2
 Ya+xBBiL9z1B0/YJZaI5sGTP51OeM6mrureUTR4q6ZO29FBrPug+lDph8DPAd4/s
 tHOQ1tZasc2ybMGLibZm+8e0j9OcVJ/M7bu4boljqsT1iw8xZw2pk0o6Uc+UkYsd
 R+wEJw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7nmkhsb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 02:10:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e56b2b350so1197202285a.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 19:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784167804; cv=none;
 d=google.com; s=arc-20260327;
 b=J0GMSuNBMX/PhkB6SRPPIiGpZFGcj/MqXSLFbVUSvm3+2O/DP5wppJpqQlweP/4A5k
 54NlxS88OSwJye9EhmS0P54/ZA0ZGcDEZoownsGNeRUw82PQr0/x93PiWzlpyF8qMUsB
 MYknhuNw386IzkOt01qow20rBoo+ynbKA2Kurq24frTl8PGRhdMC6gg2YDtOvvf29zuM
 vBCqNWgxHxbgzixf5nLjl4bjItGzhhJAgkbsMf39iUIzUgSgO8plTHOwGvbtqVSeV4Qo
 3zZ5nbuAP0ckgQZsaOUgGqrXLDiJ0FMdBbuoM9yZSZuM1wgc83XN8/7RBBMwrsw0mllV
 CPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s09j4Ykzn+Sv1s0poskPSF8TdhHVwv9fVi34/R4XIec=;
 fh=lKF8suJlCFCP9fZ6gCQfGg3jHgNxOnuuzuUhGi7d6ow=;
 b=HUSnBVfzx0EA+n2IPBMLvsJvgCDCiFV9nsN5JtqIqaxljMPGaYFS3s9r5I+f/btQJ+
 hDx6MySwnZsoESjWONFJ3kdpIQGLCY1irJygHRPBcM/2RdoBmLGsWGU9JimBTgFxUGLs
 fcVmGGbLSBzissud/mqs075eUcyCJPAmZOZHTiyMaz+9YRPnGLsttS1x4Ldx8LCNdJM+
 i0DSZD0Ox43SzYuX6g81gYWg8YfcR/cLxorI1LB8Z7vCmH215xIZAnXgFqgF6fv2Eu/X
 h6HNRRvwuvD6x/pWG7llbgDo1w52qdHyW9xD6K1q7gJofFDxwGe1nslyf8BHqsLh4KDs
 Jt4w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784167804; x=1784772604; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s09j4Ykzn+Sv1s0poskPSF8TdhHVwv9fVi34/R4XIec=;
 b=RQjf2GcpLXg855osrjAemzXRpsdLYctUvPpoZ/Fhf5rIlVg5hR03FVkatwF9zGTyea
 98eoY/ZI/k1ULPvoF5t+e5cJzJPPz/DvXkrhFQLIt+LHfmKzQBmJzuf9YQ5S4TQvroLy
 /1nC66dMOpXIn7ZMcDFKRZ4ZzvpTGtywW5Og0UyRMGzPtU7meb/Rg9BLFcteQeggLez0
 BYi0Puwh2G+kg7t6maYmfI72122hOd/2+FNRitZ602kp36ce4TuI9i7QJ0QmY1yB1mWT
 0fz2cUWQ/XC+SrGaBmRPg9NQLfMFUu1ZH30Blfl4Rpno8lHYR5BQi4l6SXlEK+2LAQQ3
 UsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784167804; x=1784772604;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s09j4Ykzn+Sv1s0poskPSF8TdhHVwv9fVi34/R4XIec=;
 b=EdDSCX52IBIDdRUwiaGh/npErm61e2Zmf6Tip0yES34hsv0TBMzd0KvS38pGLIegFz
 7ZlGVXEw/5bNP1tz8gCD6nl6Mdnu2YUSC8HEtOraU/ZRfLmJZasyoEyWJMdQahYCrRVp
 1ngTN3xWK4YrWdgySPuctOjp7RpH7HxQpx35ITlM11v5cwz0jBMkoS52HVavAUoHW+rO
 uF606uHQUbDBiG/S9+0KvN3DDXoRoWcVKVHPcPz5hEMEPwRPfLBKMpx5+yg7OAp0Adkj
 4aq/qEiqWnUEHqY+YpG0rlTdUqINd2n4Momrm2A3h1GEUv0DFH3jJIM8CvT6jhO8YKKK
 tCvg==
X-Gm-Message-State: AOJu0YwkXpB8YiCESe4W+e7SgDv3C753hpEZiLXmM3+5bZSmAIZFMkeF
 8UdWR9+UgHJEPdQyfYcXTqmvSINgDdoWDUKvWxyMCY1OpUpbax6zHOSJfnJRdqYedYzfDsVrTw1
 7bIcd53wbrkGGSIYq//+0SrFWaLhVcHJ0LaHF+ygzcy2n4avl+CX4fHjqXjYuYUqLlOT1JrOnH8
 fEl9ACF976U7QOdWaNgRSW6OyWxaArrjxmJRU9iu4=
X-Gm-Gg: AfdE7cmHDmQ/jEjmTX5TtdInmBkD44w47T6v/88DR5avwq89tnA0nYW28kKNg4SSDLp
 rbh0WPay7w9LGwd1K9sl8E+mFGRUy648anzxKB/q4jug7VSyPF8cVgKiI92F8dO/N1LdgTQc8LK
 vu+rTBoRJR+79YDmY3ES1jXQ2FxsebytrFlA0E76aOL+ZWB8nFzOKLVBZucQ==
X-Received: by 2002:a05:620a:4008:b0:92e:c118:18bf with SMTP id
 af79cd13be357-9309641ede3mr551551085a.94.1784167804030; 
 Wed, 15 Jul 2026 19:10:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4008:b0:92e:c118:18bf with SMTP id
 af79cd13be357-9309641ede3mr551548885a.94.1784167803610; Wed, 15 Jul 2026
 19:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
 <20260709175605.1070755-2-rahul.pathak@oss.qualcomm.com>
 <alZzO78B4Jrouult@bby-cbu-swbuild03.eng.microchip.com>
In-Reply-To: <alZzO78B4Jrouult@bby-cbu-swbuild03.eng.microchip.com>
From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 07:39:52 +0530
X-Gm-Features: AUfX_mwNUqKqPh5HANBHKMM7TIztp36Xj4zOJjlChpD8NZkodWY0iyvm4C2_nOc
Message-ID: <CAFR3w37s_byoZH6u-YVLLfa9xcHi2nuA5vs-_=pMikZ=8_1NZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: Add SBI MPXY generic interface
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.denx.de, anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAxOSBTYWx0ZWRfX7gsEERFaOYWw
 JdflHXdoAVO8OmoUQiPHisQFfLb5wJmxtGKRCFNyhSgv1hHqLk+pmSVO4IQcKz6+BmN/1WJFdLf
 IIKyiVHnokNKanLD3EuHrUaPOGC+Mhg=
X-Authority-Analysis: v=2.4 cv=cuGrVV4i c=1 sm=1 tr=0 ts=6a583d7c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=XYAwZIGsAAAA:8 a=EUspDBNiAAAA:8
 a=3ubV3bapVK0pZEQrcAwA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: gVv3A0uExiM4Aqb3ISP0k8mjCo_mBWzz
X-Proofpoint-GUID: gVv3A0uExiM4Aqb3ISP0k8mjCo_mBWzz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAxOSBTYWx0ZWRfX7+NAafluX4Vh
 u/P2FmW5QJ2fFif2V52Fr4DFhCpWVNNlBTOKNCK3piRt1nMUDE2XZ8l/f1tJGhp+sPxsbL5ervC
 YEEL0hra22v/pe3aZrr11HlxbwyGPasOA4KLniYOP3ZNZy/NwlaEt4ltKInI++OpA0WVcKZCXNM
 RrvhNWbxpZvF5JE4PKcai/HltVTXMU12IlKURe7xMXyeeZt42791yQ/MZv5Plf/X39KYN31DShn
 UXye0j2GZZd1c4pNcoruS3/aoVmTbKs1xmX1u3cvkV3zIB0VfLbVYHkecW8PczXewR/WUAQQnwE
 6ZX2PFmRRcvQqvFbgACdfFUuS9kBjy6HymrgN8cGKTJNznwmG8m6XLVsZiVd9/7SoI/zAz8wjt+
 Kt3Lg/hJQiOwStMOOPoIiKYMg0XEcine/cChb/I7wjsY0m5r44x/4nYc1z9dZnrE1HR/hFrBzVL
 vP8G8WeCMZosCxLX/Zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160019
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

On Tue, Jul 14, 2026 at 11:04=E2=80=AFPM Charles Perry
<charles.perry@microchip.com> wrote:
>
> On Thu, Jul 09, 2026 at 11:26:02PM +0530, Rahul Pathak wrote:
> > SBI MPXY interface implements the SBI MPXY
> > extension to interact with supported message
> > protocols for platform management and control
> >
> > Signed-off-by: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
> > ---
> >  arch/riscv/Kconfig           |   9 +
> >  arch/riscv/include/asm/sbi.h | 268 ++++++++++++++++++
> >  arch/riscv/lib/Makefile      |   1 +
> >  arch/riscv/lib/sbi_mpxy.c    | 529 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 807 insertions(+)
> >  create mode 100644 arch/riscv/lib/sbi_mpxy.c
> >
>
> ...
>
> > diff --git a/arch/riscv/lib/sbi_mpxy.c b/arch/riscv/lib/sbi_mpxy.c
> > new file mode 100644
> > index 00000000000..f95cedaabac
> > --- /dev/null
> > +++ b/arch/riscv/lib/sbi_mpxy.c
> > @@ -0,0 +1,529 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * SBI MPXY (Message Proxy) Generic Library
> > + *
> > + * Copyright (c) 2026, Rahul Pathak <rahul.pathak@oss.qualcomm.com>
> > + */
>
> ...
>
> > +
> > +/**
> > + * sbi_mpxy_read_attrs() - Read a contiguous range of channel attribut=
es
> > + *
> > + * @chan:            Target channel
> > + * @base_attr_id:    First attribute ID in the range
> > + * @attr_count:              Number of attributes to read
> > + * @attrs_buf:               Output buffer (attr_count u32 words)
> > + */
> > +int sbi_mpxy_read_attrs(struct mpxy_channel *chan, u32 base_attr_id,
> > +                     u32 attr_count, u32 *attrs_buf)
> > +{
> > +     struct sbiret ret;
> > +     __le32 *shmem;
> > +     u32 end_id;
> > +     int i;
> > +
> > +     if (!chan || !attr_count || !attrs_buf)
> > +             return -EINVAL;
> > +
> > +     if (attr_count > mpxy_ctx.shmem_size / sizeof(u32))
> > +             return -EINVAL;
> > +
> > +     shmem =3D (__le32 *)shmem_base();
> > +     if (!shmem)
> > +             return -ENXIO;
> > +
> > +     end_id =3D base_attr_id + attr_count - 1;
> > +
> > +     if (base_attr_id < SBI_MPXY_ATTR_STD_ATTR_MAX_IDX) {
> > +             /* Standard attributes */
> > +             if (end_id >=3D SBI_MPXY_ATTR_STD_ATTR_MAX_IDX)
> > +                     return -EINVAL;
> > +
> > +             ret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATTRS,
> > +                             chan->channel_id, base_attr_id, attr_coun=
t,
> > +                             0, 0, 0);
> > +             if (ret.error)
> > +                     return -EINVAL;
> > +
> > +             for (i =3D 0; i < attr_count; i++)
> > +                     attrs_buf[i] =3D le32_to_cpu(shmem[i]);
> > +
> > +             return 0;
> > +     }
> > +
> > +     if (base_attr_id >=3D SBI_MPXY_ATTR_MSGPROTO_ATTR_START &&
> > +         end_id < SBI_MPXY_ATTR_MSGPROTO_ATTR_END) {
> > +             /* Protocol-specific attributes */
> > +             if (!chan->proto || !chan->proto->readattr)
> > +                     return -ENOSYS;
> > +
> > +             ret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATTRS,
> > +                             chan->channel_id, base_attr_id, attr_coun=
t,
> > +                             0, 0, 0);
> > +             if (ret.error)
> > +                     return -EINVAL;
> > +
> > +             for (i =3D 0; i < attr_count; i++)
> > +                     attrs_buf[i] =3D le32_to_cpu(shmem[i]);
>
> Shouldn't you call the ->readattr() callback here instead of manually doi=
ng
> the read?
>
> Also, I'm not quite sure I understand what purpose those callbacks serve.
> From what I'm seeing, attributes are always read/write using
> SBI_EXT_MPXY_[READ|WRITE]_ATTRS because the transport layer is always mpx=
y.
> Would a non-RPMI protocol do something different?

Reading the attributes is simple and can be achieved with or without
the callback but
writing the attributes may (or may not) require any further protocol
specific validation
which is not assumed here and hence used the callback to keep things generi=
c.

That's why I didn't use callback for read but for write. I am fine to
use callback for attributes read but I would prefer to not assume
anything and keep write attribute callback.
