Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23723CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 12:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4841D83E81;
	Tue, 12 May 2026 14:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hifiphile.com header.i=@hifiphile.com header.b="hhMSBhFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A391B81E18; Tue, 12 May 2026 12:23:42 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C051F801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3939d2bd7ecso42923611fa.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 03:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778581420; cv=none;
 d=google.com; s=arc-20240605;
 b=ESoxNiVkUptN1b/hP3U09whguaHPzo4u6l0ujdnMyaCtzZNZ8GChbFXSX1btqGx7L0
 3LEVCfDqXx4FzMUPzBg7ryQ+7yJaTakOCptdyn85+M7ySie3U+4WUdU+W9FpLlRC1hZk
 D4hdp03+WJBOKd53prn9MRqL9sv96vFkenrmaBbOdrEfUHwuDZxol9s5lZOpTm78t6Hh
 FlFbbDRSmVFEm7q9ISys+m0h+A4NJqHYMvIDJu2hxbBaAJ9QYRi6ai1hJ4HpPY0qieFU
 9nfjvlfxJWQqvz9qtxhyMNItEBwc4ZhjSRHk/eOHzHQXBih5+y6A52Z96hoBk7nF8o+M
 1B6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=ue4dOSh7yr7u4ruig26S4WJ8xN8DzsiaGLBaTfdReJU=;
 fh=MUharowI/13G2MyHrvqELjjln9Mtz23I2BsvDWhAs5k=;
 b=Q3ElrfN03fA1tC/td0iUjm6SovMBNn1q298ZhjhphKEOYAgkJ2NtfAy2kq9y8bYWP1
 FRy0WtaiV/K4WD2kdY/qwbxcZT9g9ypbWqabb524t6UM5yKgsm0WqgVGcwchvGFQ1wZk
 vuMdxaCRRmKeDGzecIXfpv7l9jYw2SbeDiKBnNcGBh3+/FToYO/TOCtgUSWeGche/2aJ
 JiW39r8YAzlEHCdz2Q2LeypERel0YzScemJai4jlpHUKMnxRnsC4F4TnSGPN/iAkC23b
 kfBF8aZOxTVUI3c73y6KZenCAzk5YuI+cHiqOC/2Z0ie83hQ6Qc3jfj4P0ev8LbGYq64
 aXRg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile.com; s=google; t=1778581420; x=1779186220; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ue4dOSh7yr7u4ruig26S4WJ8xN8DzsiaGLBaTfdReJU=;
 b=hhMSBhFmU5+VIa0be8hIyKMSowjkbeNj+c9eoLJdJrWBN2kCwmR9RSieVV0FgGYYpB
 cPO5fGm7mjuB8QIn0T8v2eLr310lw05s7BB1ZPlL+YL2ESdc9ey0KUwJO1DpjFl791ue
 joh7sXxhdMx2ilAxGd2vpq0EDcQ5OrE1Uu7cul9gdivRzWSKJEAWQ4NnJLsMqR1SNaRa
 /Tak5/jpfieSzKZDfOApgcc4MjvGDHJFejE/1/fhqAcEnw8iCozmCVVCDLODKLCySWnU
 vAmMVUuNbpJTvy/QgyGr6dm39YWiGicP053hUAIY8tHleYqstNrzVPcpF7LZqPfoPl2h
 B96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778581420; x=1779186220;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ue4dOSh7yr7u4ruig26S4WJ8xN8DzsiaGLBaTfdReJU=;
 b=OAdMIsmW1f85WCTZIzk94nv629gIg/QsioUOTXxsl0xI8miPV3pTQKOXHdJWFbVlAd
 FTOZtB19rMljaBg3hi4DN/r9qHweg5SATF01EVC4S4fXQsEX+QZH6/WSuB4nxpDJGzeb
 VDHXdJqV2dcuH5J/w+rwwHSE25Q1LvBJPKO1JiADb25ifh2oDHC1brj54TbqdXSDGRm3
 zFvK6hAKdMVAbGkbePQT9PnLDKcGn3Q7VY68cJLluu1QM0U7xvaDU2K2Qdd6+/bt1qtU
 ZCAz2TIDhVw76f873NzxbhcGe8U4dsUS5fKD/RmjQSfJkXlKM8QIjAeu3eNOS0UOvLf6
 gr7w==
X-Gm-Message-State: AOJu0YyMLzqFsFPv9WLaiD0DxhvmvSIR7FUWzNdKFZniTbcXTPVJSFFC
 vXe9yj5P2yVq/Lxfsi9LAmleojBBSeSHmdGIRISMs+knrgeUAXFxc4gi/0YygP1LDAL+Wiexv0b
 VYeaWcrCSPR5EW9HQGz+OrGHlyZ3E1/X9Sesd3b2mGg==
X-Gm-Gg: Acq92OFB1FI3qIosa/5vmro+C9l1WcO98SBhez/NlK4duLUQKk10TB/xXoOQUCTUBSJ
 8rmz3b7I+Dhs8x+S93k6udQSBsRw5yyVBAvnUc4sYD4Mwrq2pP5ea9BXum6oxu1d93L8ulc4ep8
 Rdn9fqrsoac8DX+2AhfRSZSSCXF4OjCv95tci2yTWOv+HX2QL2JrcvC74h+IFQZmoBAoStXz/zM
 WQFSAfePUwMqWRffsceSKkkEk51LIpsoqo4/EI8widmPLOXLBK/SmQSfh2V/qwEfCnZ4boKlgbR
 fNr3NBrSeYmeNwdUBQ==
X-Received: by 2002:a2e:880d:0:b0:393:b138:34ac with SMTP id
 38308e7fff4ca-3943865ecacmr6164281fa.10.1778581419764; Tue, 12 May 2026
 03:23:39 -0700 (PDT)
MIME-Version: 1.0
From: Zixun LI <admin@hifiphile.com>
Date: Tue, 12 May 2026 12:23:28 +0200
X-Gm-Features: AVHnY4JccfObR7qNmRLtCfM1J7YVjPSbPXgrUkbAPFDZOjcV6jhm5nkvuIb_coc
Message-ID: <CA+GyqeZ8=P_i98Y4wT0Hfi9cmfvKsHn-upQ2h51zGB54-_JZvQ@mail.gmail.com>
Subject: Commit 59310d1ec (usb: gadget: introduce 'enabled' flag in struct
 usb_ep) broke atmel_usba_udc
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, stephan.gerhold@linaro.org
X-Mailman-Approved-At: Tue, 12 May 2026 14:37:47 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,
With 59310d1ec an "enabled" flag has been introduced to guard ep->ops
against
disable before enable or vice versa.
In atmel_usba_udc/usba_ep_disable() returns an error if the endpoint is
already disabled.
When the gadget is re-attached, for example a dhcp command triggers
usb_gadget_ops.pullup event, the bus is reset and
atmel_usba_udc/reset_all_endpoints() is called. Since ep->enabled flag is
still
true, following usb_ep_disable()/usb_ep_enable() calls will fail.

What's the correct fix, change atmel_usba_udc/reset_all_endpoints() ?

Regards,
Zixun
