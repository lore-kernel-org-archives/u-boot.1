Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D415D25930
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 04:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B850F83F75;
	Tue, 27 Jan 2026 05:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODRxcr4D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VilTwdVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD2183F75; Tue, 27 Jan 2026 05:18:22 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B1D83F6E
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 05:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60QKgJv52880235
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 04:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FcOnGbaq+xfUfZ8tTxfQgqoB
 BCFvuSp7pUzjSGVze0Q=; b=ODRxcr4D8vUBeUkjZDqyQWMvW/DtmVv0PatfpMiV
 ICPIQ1YHjso2+u8qVhj6qKleYaglrArMEA3xd/W58gD1OwQwRCyrIgWQuWIlrfAv
 FWmV7rSQMLTa5WEPuM9y52EVMV1Ux4APfGJdxeBnhtEC17ZwEBiDvSozM2BknLrQ
 O1v3hRcdD2o1Z1CNuKhN0dNTjR6kmRyATW/or25JMJSceuH1Ml+vUGOpmTSyZMbb
 GVagDiMcfBg8jCMjmqm+bu+e6qR0G9qUpCMS0IHqiV2agL70mHO44ymK5bfpBW7h
 qaKCJ3HyRETaLn1572t8ugZWZqtf7CuklBZ649snqauPxA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxffs1273-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 04:18:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-81f2481ab87so4126169b3a.0
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 20:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769487497; x=1770092297; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FcOnGbaq+xfUfZ8tTxfQgqoBBCFvuSp7pUzjSGVze0Q=;
 b=VilTwdVuKfZu+0Hxzv3mM2MECXAJdMpuKopLbV/LoOZIB7IfcAu3kldQYh7cIeuyYt
 OOjtIdeS8/a97v1Q7DdgtLDke+hHJGIizRYpRuRgnms2+gsWSbHl+RSXYWjgMGZ94z+C
 /3gNM8uUIap/V+n5Umh7f3ctVWkS8/4n6BiwXBmK6rI+89OwtcyidgsgkaCIXJ4WU3pL
 XCmZUMKXpm2tXpXxvjW88q0VD4dbuu6JDLTLMiuk8zLcKBuouV2q/b39y6wcz/tj08zv
 oRO+7b0llPzcWze0pxT3b5agk4NUgFhPVKkkx90e5ptBxBNjmdGmXyI8zIp/2eYPSUG8
 ngvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769487497; x=1770092297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcOnGbaq+xfUfZ8tTxfQgqoBBCFvuSp7pUzjSGVze0Q=;
 b=PMIoBOAw55SjXMmgjoaa2ptK8+H7vbCe9BjC2ySPOAEaNCmnBpR4vAi4y4B4Kte3JI
 95zaBEGbTHmrf1ml+upGBaVf6oZtKrh5vObtNEq0hFhIwtFLYPbSpolJY/2YEL/3PNRL
 T/9chfQzJvW5BDXKJv+LtmuzDoofF8T2PFDCBybvhS4lFjLGRFaqyDNZf0/v7CLEh6g9
 aOsQA5FBxA8bXqcNsKMoVfJoQQSiPcXxjqU+ao7baKyc5BFfr5ujGTVl8t9g59Nsi59W
 E0qh4UvxCW3Rm5whNpz0UOe+ybczYG4GlS73A6OFX1OfkjY05nVIrtuy+0v+4g5HwFwk
 106w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXufSz63IFLu8HKHGy2y3/NwI5/5QQ68sJ3pnf9tRrVT8cRsmuKOyE+08IBYV9Fng8S4tjaD4s=@lists.denx.de
X-Gm-Message-State: AOJu0YynBTQWbgUwUpUpZ/+yQ4oC637EzFq+sRGkrEP1imW+yqhrhecG
 NBa3RDNy/MDNeEvNHwVF/tisuEQU23tk+YISaqN7M9F2a7W0pugEkyObI8Ftysw+i2Hs6Hykx9b
 zTdJXCBFsSBXVdqNzss1BfUSrpPEcD9JfZe+F/wbS0RsXovYc3rFeXsck
X-Gm-Gg: AZuq6aJmEmVd0INXg7hOHuE1YugvkhybEiS0W0a1oFOYiUCgFQFCPtPgKl5lchZDnG4
 9k4sN27m+Qo0tDF37/mW4tMBAFoUDNeQ2ejQfOzvyWicP20efBWaSJhyOrw3jqiSctlX76QSwU9
 1pnY1PzTFgRRYduwwYP3GRwXrphKkK7E3xQHagfT1VGIYGJV8264n1TFNuGqHSssQWIeYsLffNH
 r6DGo+HwvLUb9ob6pE+oscRpNs4qGRA/AIEVTJ5dAE6nmDC1HSntft4SC1a/NQ92+gc3+ckFLbw
 vlcRIxmWqE0RT+yKrjBvOv+j1n5NHrVZoYzEw48t/+U6U/8JhkGitK93WDC5Z7QjlXZmX0cYcbx
 G+SpOqCnY0JadG90SaVw9hCI5aYHZVetAVZrC/lqTnoHOs6GLbIaAC0OvBYasFlucTCpb0QpQkY
 ear2Sqm0Bo7lL8Le9QKn22V2Sc3MifSGmMF9N4/4c=
X-Received: by 2002:a05:6a00:9295:b0:822:1dbc:e75d with SMTP id
 d2e1a72fcca58-8236913d467mr699660b3a.1.1769487496664; 
 Mon, 26 Jan 2026 20:18:16 -0800 (PST)
X-Received: by 2002:a05:6a00:9295:b0:822:1dbc:e75d with SMTP id
 d2e1a72fcca58-8236913d467mr699614b3a.1.1769487496119; 
 Mon, 26 Jan 2026 20:18:16 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231873e77bsm10582782b3a.56.2026.01.26.20.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 20:18:15 -0800 (PST)
Date: Tue, 27 Jan 2026 09:48:09 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 me@samcday.com, aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
Message-ID: <aXg8ge6z7EMWliSd@hu-varada-blr.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
X-Proofpoint-GUID: tvRhH5x9hC1aX2KpbxCnGtEzRt0zHQRA
X-Authority-Analysis: v=2.4 cv=YpcChoYX c=1 sm=1 tr=0 ts=69783c89 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=rUtflgmsl_lXZPX_w_YA:9 a=CjuIK1q_8ugA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: tvRhH5x9hC1aX2KpbxCnGtEzRt0zHQRA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDAzMyBTYWx0ZWRfX+Kk2ZaLdDPjr
 nYwik1Mvs+5ZML4Meu4DBrJeUdKfkfTewPK6UsTqPkgu9auKrqmmGvWWtWkyIXgBbk5axlUIWEE
 0HX5QQQndNJ82fbuFMUPMrbUn21LuAuB9/K83YyMug6uPLltJlbdZ+Hkk82ASvfgpgO+kMixrGP
 edO40qDoO1laKxtjkC+Xe8VjmbgkbMnAqoeQOYpTT5j6Bq4zsEG+WwkheP8z2099TXYD8TgAMeW
 tZrJ/CXRXdQxctQscAwRC2exdKexhKbryphKfTDl/2z31h/I9IXkZcTux43q6+PSkujH6iwfyDH
 YVZw9UqOUFA92J/Xg8VEtmQuSkbGTb6q65/hZGrT3Kg9Tmw2/+2eC9YyIt/Slaa98udF4uXuLvv
 UviZc8pD2LAhmv9t/M4yaR4i/yTurkfCzxSSf70TYzqLTNKpcBhT56bULgM9U5HXLYrVM7cl53d
 Go15aA3MhbTkdB5mywA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270033
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

On Mon, Jan 26, 2026 at 06:15:34PM +1300, Simon Glass wrote:
> Hi,
>
> On Wed, 21 Jan 2026 at 19:39, Varadarajan Narayanan
> <varadarajan.narayanan@oss.qualcomm.com> wrote:
> >
> > Add a 'request_arg' op to struct sysreset_ops to enable sysreset drivers
> > to receive arguments given to the 'reset' command. Process the
> > request_arg() op before the usual request() op.
> >
> > Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
> > v6: Wrap this functionality inside CONFIG_SYSRESET_CMD_RESET_ARGS
> > ---
> >  drivers/sysreset/Kconfig           |  8 +++++++
> >  drivers/sysreset/sysreset-uclass.c | 37 ++++++++++++++++++++++++++++++
> >  include/sysreset.h                 | 18 +++++++++++++++
> >  3 files changed, 63 insertions(+)
> >
> > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > index 0181f6cd581..6fb0ca81dc6 100644
> > --- a/drivers/sysreset/Kconfig
> > +++ b/drivers/sysreset/Kconfig
> > @@ -49,6 +49,14 @@ config SYSRESET_CMD_RESET
> >         help
> >           Enable sysreset implementation of the reset command.
> >
> > +config SYSRESET_CMD_RESET_ARGS
> > +       bool "Enable reset command to take arguments"
> > +       help
> > +         Pass on the arguments received by the 'reset' command to the
> > +         sysreset driver(s). The sysreset driver(s) may make use of the
> > +         additional arguments for implementing arch/board specific
> > +         functionality.
> > +
>
> I haven't been following this, but what sort of args are you planning to pass?

As of now, an argument to indicate reboot to emergency download mode.

-Varada
