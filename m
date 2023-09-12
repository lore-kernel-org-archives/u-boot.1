Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF60CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 05:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB5B86DC6;
	Tue, 12 Sep 2023 07:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MNzU/Yaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29AE86DF8; Tue, 12 Sep 2023 07:18:51 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B880D86D75
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 07:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c0efe0c4acso9320785ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 22:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694495927; x=1695100727; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yIgd11HnjJdr6+PqHOia4xOkNCkm0tx5nRClXv6QvbU=;
 b=MNzU/YaqUVXTDlkvKEWTAOWBeq3IDOv7XRKafW+R6aBPnuOvhIawqNSejF/T6IkMy1
 RV2BalcNQbtmODxe+Jq7rjvBtY3sbAzNqy+3umvpegH+V2+Vk2St6P6xh9F2ePOQdwZ3
 GkqePS9V4r2027JnS0+f0UKJqluJnBx0vmfiyPd2AclFc00jdE2a6WPMTYllrbmLuu4t
 9VC0lghoAzr4YTEFC+vVeF90PKd/vPpeNRD4TWYRM2zuh6gg74OroJ+Iy81/qpOU/jh4
 KGDc7e509nQNdGn4/vD5Ji9SjkDcOxvNYL/oVyo3Cx/K4NOr5HQZRGtGXc2d9Cd2Zrdt
 GDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694495927; x=1695100727;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yIgd11HnjJdr6+PqHOia4xOkNCkm0tx5nRClXv6QvbU=;
 b=AU6VozykxNdmxrhM209YsyJEyYxp0I7KPsOzd1GFynr1sWYCtNgHBUrXG2ChH9ZT1d
 B06ajvLbuE892niY3ROwE8x6No99T8VeKGp+8BSag/O/Q3KkNIbOxHp9uqO8ZvyddrLx
 2hMKmYyTDTJTfFcbsHZef5F3vvDIges+FojvT5ONATyc/AzCks59frKcYYyFePblZ/Ol
 Svps1yohmWfvRGtCj4IIok5IDX46RZNRQf244cG+Yn4/fLFCSyg3dAJmvqFqnYi1P2pF
 m1bqowFIEZAH/0RT9CUTh0bS13L04DwPOrOxTJiQH9kkbCocN6h83Lt2F3dlH4EzL+S/
 ZM2Q==
X-Gm-Message-State: AOJu0YyuqwzyjkXuTc3V+Wq+ovn1O5rjoP7E9XQoQ6oF3HQheXT0ReZ4
 27rG7AIwD1PuXpuULYz07DrMoQ==
X-Google-Smtp-Source: AGHT+IHDBmlD//60qRwrOR8jyzslRIZjxRMkmTCb5i3koAun0ERyTAtJAxUjqCIHXhE12tDjCUhAaQ==
X-Received: by 2002:a05:6a20:8e19:b0:137:3eba:b808 with SMTP id
 y25-20020a056a208e1900b001373ebab808mr12545878pzj.5.1694495926915; 
 Mon, 11 Sep 2023 22:18:46 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 x12-20020aa784cc000000b0068be7119c70sm2215956pfn.186.2023.09.11.22.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 22:18:46 -0700 (PDT)
Date: Tue, 12 Sep 2023 14:18:43 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Etienne CARRIERE <etienne.carriere@st.com>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v3 05/13] firmware: scmi: install base protocol to SCMI
 agent
Message-ID: <ZP/0s8b8GJMA20lr@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne CARRIERE <etienne.carriere@st.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
 <20230908025138.44405-6-takahiro.akashi@linaro.org>
 <PAXPR10MB4687DFB8262CD8214D40677EFDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR10MB4687DFB8262CD8214D40677EFDEDA@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
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

On Fri, Sep 08, 2023 at 02:19:22PM +0000, Etienne CARRIERE wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Sent: Friday, September 8, 2023 04:51
> >  
> > SCMI base protocol is mandatory, and once SCMI node is found in a device
> > tree, the protocol handle (udevice) is unconditionally installed to
> > the agent. Then basic information will be retrieved from SCMI server via
> > the protocol and saved into the agent instance's local storage.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > ---
> > v3
> > * typo fix: add '@' for argument name in function description
> > * eliminate dev_get_uclass_plat()'s repeated in inline
> > * modify the code for dynamically allocated sub-vendor/agent names
> > v2
> > * use helper functions, removing direct uses of ops
> > ---
> 
> For info, I see that this patch, as placed in this PATCH v3 series, breaks pytest.
> Patch v3 08/13 ("firmware: scmi: fake base protocol commands on sandbox")
> and patch v3 09/13 ("test: dm: simplify SCMI unit test on sandbox") should be
> picked before to have scmi DM pytest running.

Thank you for catching this problem.
Will shuffle the commits.

-Takahiro Akashi


> BR,
> etienne
