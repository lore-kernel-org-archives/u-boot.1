Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909E7C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 21:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 876728804F;
	Fri, 15 Mar 2024 22:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TpXQfgZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B4AE88069; Fri, 15 Mar 2024 22:16:26 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF1F8804B
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 22:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc09556599so19518895ad.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710537378; x=1711142178; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LHdTBkUV3AUE4fMtCi3+DrKebmCB207Vi6ubt8ny5uU=;
 b=TpXQfgZhqchNp5rwHAgiGtP8SQigL/ZNbapt1GKqc7j9XA2H4Zl/pi3Xmwtip09Z1r
 4ILHoqWaJeXMCrR6vxfpAodJzDCmOMC1KlhjtMzxmXJDZJT0ObW37/l4oIEJaVUVXzF1
 YAPaHhOxK6nK7Tl/tYH3HQKFM/JLoPSuGf2TuOzr00W2CY5ILmZMQeh8nIyZwdLgZ0KY
 pzarEGoPER9zzpUkOv6UDcg/gDUor8holzpXtcJrnQ/CxoLILb9iAZWXulS1vySRFY+d
 aIhVVuUrPixJJ/vu5JZH3oygctGg0Wwe3BczNVo0l+cyV+w2kgFuct+RkjmANMk8kq8b
 94Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710537378; x=1711142178;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LHdTBkUV3AUE4fMtCi3+DrKebmCB207Vi6ubt8ny5uU=;
 b=GRNC8+2xqAS8lKsPt9fG0maKIvyaTYFBe/SRIfB1Qwxdn7+YDsHN97Pj8p0Tj/Ubou
 gEp+icWjEWxZf2QYzBK2QmNOxmpdjkZ/44U8HXW2XxW0pQ/XgANZ0FD2oQwJw3VmkO/2
 neNrOxFG5FlYSH7LdufcxhfjtH9MdAaH3QJ+riMStdCL8KN88IGRlug+RF1Yn1kF72Bf
 K6zUSJc+ZmF/UjfncXrKs7vp56t3BWXStoQlD0JUPEBBgV0iGMIHe4MVMLZzwoRbUSHl
 p6jXv0gDuSARAeGVQQo7YRSKIc2YDkq44EnBlNq8MMj5vfkArvVDu+AxpvZkbO2jn1d3
 /ogA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfw8HLvwSMBy9iEGbURtR4bt+gMOy/73uc/JazCmFPAC4LvhMp18v2Kq7im23wmVTqwX9ysoFWQK3XAkexBAKdxru2Vw==
X-Gm-Message-State: AOJu0YxDOuy7S4nShvKVIxxTuIktumMVssa3fu8G9SgircHnJKQ9oZB0
 zFruhx1cxnvQ5G4l7pnsdtbSPI2KBwsZJLyauf7khG7KzziPmtHt
X-Google-Smtp-Source: AGHT+IGBKRFNzgOOzreF88G6y1HM4cdv7/QrLECIU4Zc0cIRpmQePNkQdqM+KOk3zbJvWS34mbcryA==
X-Received: by 2002:a17:903:25c2:b0:1dd:d88f:c79b with SMTP id
 jc2-20020a17090325c200b001ddd88fc79bmr3809135plb.49.1710537378021; 
 Fri, 15 Mar 2024 14:16:18 -0700 (PDT)
Received: from frhdebian ([2804:1b3:6602:ff36:f144:8c19:ce75:7f2f])
 by smtp.gmail.com with ESMTPSA id
 ku12-20020a170903288c00b001dc91b4081dsm4310633plb.271.2024.03.15.14.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 14:16:17 -0700 (PDT)
Date: Fri, 15 Mar 2024 18:16:14 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>,
 Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v1] doc: board: colibri-imx8x: Update and improve
 documentation
Message-ID: <20240315211614.qo6n43xl6k7uk4ry@frhdebian>
References: <20240315143930.29155-1-hiagofranco@gmail.com>
 <CAOMZO5A9ewwMP8MEtJLCjp-g8jjyNmBtBz3qf=KnmQokLWWWJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5A9ewwMP8MEtJLCjp-g8jjyNmBtBz3qf=KnmQokLWWWJQ@mail.gmail.com>
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

Hello Fabio,

On Fri, Mar 15, 2024 at 05:39:43PM -0300, Fabio Estevam wrote:
> Hi Hiago,
> 
> On Fri, Mar 15, 2024 at 11:39 AM Hiago De Franco <hiagofranco@gmail.com> wrote:
> >
> > From: Hiago De Franco <hiago.franco@toradex.com>
> >
> > Update and improve the building documentation of Colibri iMX8X.
> > The following changes were made:
> > - imx-atf repository changed to nxp-imx GitHub.
> > - imx-atf branch updated to 'lf_v2.6'.
> > - imx-seco updated to version 5.8.7.
> > - nxp-imx mfgtools link updated to GitHub releases.
> > - General writing improvements.
> 
> Thanks for improving the documentation.
> 
> One minor suggestion.
> 
> I have recently followed this document and noticed that the
> instruction to copy the
> mx8qm-apalis-scfw-tcm.bin to the U-Boot source is missing. Please add it.
> 
> Also, since you are updating several components, shouldn't
> mx8qm-apalis-scfw-tcm.bin be updated?
> 
> Currently, the version is from toradex-sumo-4.14.78-1.0.0_ga-bringup
> which looks quite ancient.

Sure, I will prepare a v2 and also include changes for Apalis iMX8.
Please note that I didn't do it now because I only changed Colibri iMX8X
documentation, but since they are very similar, I will do a v2 with your
suggestion.

Thanks,

Hiago.
