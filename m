Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D196FF8873
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DCD080433;
	Thu, 30 Apr 2026 14:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RNeNxzOU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jgFz7QnX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5CB184666; Thu, 30 Apr 2026 11:52:10 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 577238464D
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 11:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63U8F6VB3636516
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 09:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=MreRJ1ZvnJKDnjeMWHgoh+kE
 Ep7mOIzZNpbegMJoVl0=; b=RNeNxzOUT5h2a2KOjpj0iwqwpIkFULphliXrkPFX
 1YCiAp2yQvvvKo0oaZWZ37MQsquNHZyyRJB+9kO6IJuHm5Isdsvl3GCIUf6s/b5t
 psRyKUvfj6m/qINNWn1WbWzKBA0pCTylFD8Pev6fw/eq7NZ82sgmjYUVlZAoNJaB
 gUm/a5yJ+TsimIrhwpv2h+V28YhsZacJ/xoCK5f8CmPWfqWDtTUezFRfVyq4pXl5
 7nAyfhhN/x8A0AGbW4wfqZUmJtPdTAJu2g+iyE/WdBI+G9IrEGp+nzVQJ13YYRI8
 VHzpJ6i9SMnCNKWRfLWGrB4wU1CGfPzni8uiAPyBP7ntqQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3q1x3u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 09:52:06 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c798fc1a426so325815a12.2
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777542726; x=1778147526; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MreRJ1ZvnJKDnjeMWHgoh+kEEp7mOIzZNpbegMJoVl0=;
 b=jgFz7QnXsXMzdW2v9QOGkpCfVZI8JW2DleNVB6OnONiogUb0sin8JyLHR5CPRuW+iv
 0SVAxhT3cgluqc6/vk9Me9Cn/aEgNHevlq9q2JBuRsP8bfsAwYvAwsx1IIFoeAM9oSxF
 r8d/tAxtNhpsbwx3gHkBCGPoTlOCkBanKwhszzOwpv/Rb/FDVSrnpxQR8yWMvRhsfUGC
 rDQabxG55McN1OqBvdEOmSe95nhBa5XhtnIHTU3KupRPicHpWpA/6I5T37YqBBKidwmD
 2uJ1izpZg8PI9AXX5aLSgzmokjGRdGyA6l2CRyxMxJ2Nkxw3ZHunBwkg4yVz4k5+Lh1g
 78Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777542726; x=1778147526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MreRJ1ZvnJKDnjeMWHgoh+kEEp7mOIzZNpbegMJoVl0=;
 b=c9fYnljaOzV9tX0xg1LnTxVkGp1exV2aWpUoXdmv9J1KVH+f6qzzVrOX5qJSlMWmg+
 SOYeY7WuBN6M4gwlsQOqCFReJT2tE3AymY4X1T6L3RYi4GNCmztfavazOF9t03qjrAHb
 GuudWsRNUypD5xl6G+/T1URVZcyEQHO3t/ahjm5yT+6Gx/dnSLWnOjPeengzYO/QQaNr
 xBgImrcAGSudeLNqxTMV/IVza2jOZGH2jIw5d2n9tFL54Au/sNMA451L82TnVDS6CqRm
 slZ3hD1WNmLxC/WIEhGiR7U4PEYxQck0RVtPy59Zw8AAbc42bb+5QZKxQv2rcAQ7OlRI
 gw+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wu8+ol2z6YN0/ciUcnWSqzvYYCXlnd++GrNKbwBgSoFC8WGK8B4BDIIhGzZ9BZYOW+eLxmXg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9VLPNaMj/EmJcWTgEOi78zeAcID8aVSmRZb9s45nA58v2FIZq
 3qCpSlEPBzfSwUVMMJlwU8FkHNDUbGtSTwwA+MlooBYow4ccKnx6D4lzYhC0jb/t+hUbZjtKgus
 WoGUY37cFJvnNDAb/2WWE3TzOuNm6NcVT5p0y31K6Aug5A/k+seEA2uf1
X-Gm-Gg: AeBDievL9xrui7HSZnHKdyg/sfXGCv+73IzP0vJm6nmrrZCRZlO8VG7LLL4MtINk8nj
 8L6c2YAeoKEMHRf4u3WI4ON86j4QfSoWes176sJXxTnFgzvuWA44f57B5foiSwaXkjVYy8d7xaE
 jirDvotRGyFR0ZPcttHg4A0NorTz6G9XLipPfh9L4K/0UGr63bqnN/FQBG3bexM5GqydendyP1a
 UUfW8WZUREjO7hTlrbTwKfO8Q1fVETnqMWjE8zEzpH2q02O1+AnhkEFcVE9Ke/WHTtl+rmHo7md
 gkCrXV+pMbDjrplDz3w4Rlt7o4gN+YYKfXsMdlFGLjyEYaGD2BXoZGhxJnmIVtr8CXWVZ8EpihX
 fe3dZ3P+9nmQy1BbyaMRh42vEAP+K/ElPor9bbL1ArvPmkYxy3J65+dS4NY+zXx5glhDxw8bE7p
 GR+zMzf03jb0tG45fyK9ys7YZAYtPdZu55OriwnlUOGzcImkJqo0eqb3or9AlB8g==
X-Received: by 2002:a05:6a00:1403:b0:82f:37e3:ae6e with SMTP id
 d2e1a72fcca58-834fe1b7572mr2521404b3a.31.1777542725639; 
 Thu, 30 Apr 2026 02:52:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:1403:b0:82f:37e3:ae6e with SMTP id
 d2e1a72fcca58-834fe1b7572mr2521360b3a.31.1777542725134; 
 Thu, 30 Apr 2026 02:52:05 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3cdsm4703647b3a.19.2026.04.30.02.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:52:04 -0700 (PDT)
Date: Thu, 30 Apr 2026 15:21:50 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, tien.fong.chee@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com,
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de,
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
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 michael.srba@seznam.cz
Subject: Re: [PATCH v2 2/9] doc: board/qualcomm: Update RDP build instructions
Message-ID: <afMmNjz2u37Xy1yl@hu-varada-blr.qualcomm.com>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-3-varadarajan.narayanan@oss.qualcomm.com>
 <aeYpRSg2S6p8dNZt@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeYpRSg2S6p8dNZt@sumit-xelite>
X-Proofpoint-GUID: eURxBqx2Ln4GoGIowr7beBWaJe2P_q6Z
X-Authority-Analysis: v=2.4 cv=dOyWXuZb c=1 sm=1 tr=0 ts=69f32646 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yUGEEzE4qia7Vm6UmT4A:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA5OSBTYWx0ZWRfXx7Vsvoqc/ZYJ
 X2yyV8gfuk/Tsckc6WfIy6itSVW/40Ac+7Cl+3+RjZdJYU+9iNUV+4Bv5+GUntNynZa6vnsbnmk
 b1+T+AahzohHncbwKrsBV0Kk5gFE8dHWuAJS/fuvzBehUL2vdJj+Y4ztCuMYwL5owBIjdDAZibW
 vxLzZUl5nZJHbKqNJDH/BFGOoHfeZFf7LxYgUyrJUVhvt92xxcIg3afRSnAnfGct9SI4aKCtn7a
 Y+Es+cPWQ2QRq6M7A18jO5COjykhScBj04CK5pMmytcKKXJLEjeyN3BPntnZ4fHTvvIWkFLhw8i
 fyW4mP375PF15QlXi2SfKyVS8uq2/rvwInGRHdYjshaITZ39Z3BCFminPW6C9eY0jCjJu+/na3n
 lVUrtDQBuyyTvSAAfSb7dQkeC6X3CrIZEBQE0WNx4HiZ08oyfR+E0AZ6qNfO7MvZQ9xTX040nfK
 q15RAEJy+yZKXAiZbvg==
X-Proofpoint-ORIG-GUID: eURxBqx2Ln4GoGIowr7beBWaJe2P_q6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_03,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300099
X-Mailman-Approved-At: Thu, 30 Apr 2026 14:39:51 +0200
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

On Mon, Apr 20, 2026 at 06:55:25PM +0530, Sumit Garg wrote:
> Adding Michael
>
> On Fri, Apr 10, 2026 at 02:41:47PM +0530, Varadarajan Narayanan wrote:
> > Add details about the SPL & U-Boot proper build steps, converting to
> > flashable images, source URLs for the needed binaries and scripts.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
> >  doc/board/qualcomm/rdp.rst | 69 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >
> > diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> > index 99cf8eba57c..d09dba52044 100644
> > --- a/doc/board/qualcomm/rdp.rst
> > +++ b/doc/board/qualcomm/rdp.rst
> > @@ -42,6 +42,67 @@ on your device with::
> >
> >  U-Boot should be running after a reboot (``reset``).
> >
> > +Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
> > +====================================================================
>
> Rather than just the build steps, please describe the overall boot flow.
> And since you have created a common SPL file for all the Qcom platforms,
> can you ellaborate on how the boot flow is going to be reused across
> Qcom platforms. Maybe we just need a dedicated spl.rst document here.

Ok.

> Also, how does this series align with one for SPL support on SDM845 here
> [1]? Are there things that both SPL ports can reuse from each other?
>
> [1] https://lore.kernel.org/all/20260411-qcom_spl-v2-0-9609557cf562@seznam.cz/

As I understand, board_spl.c and spl.c (in arch/arm/mach-snapdragon) of
Michael's patch and mine can reuse spl_boot_device() to include
BOOT_DEVICE_DFU and reset_cpu().

However, I still have to figure under which conditions spl_boot_device()
can return BOOT_DEVICE_DFU.

Thanks
-Varada

[ . . . ]
