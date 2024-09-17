Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A1DC35FFF
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B0C688DE9;
	Tue, 17 Sep 2024 14:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="epfV3VRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B42D88E06; Tue, 17 Sep 2024 14:27:13 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 541C288DAC
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f74e468baeso48973811fa.2
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726576031; x=1727180831; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0l3T4AKmQpSgHoS3by1bTGt3WO/+7YOQLBFvdihbboc=;
 b=epfV3VRPZU3lFh0/GOK8FOfE7aM1l9cgKMcvMSBaSJVAJQ66noCgu9gBq7B84IkfCz
 r5iV4b7z3CYAKo8FMFnYjmoYqW71ND7lv/cjJvUcrD5LkTNFyQgEMvgR8+H7WJ1a9N33
 Hhn/aGCQ7adcJk8VdqG9PfxkAA6UYPRLiyZW+LnsoSaPVlf2NjYRrxvzmwXqNsv9RRDw
 wVo2Jqt4ksxpvO8cPKei7A9wnxkRsIPpY6rUBQXo24FSsd6ye58NJXeb7m6j8G6T5CnG
 dTwzmLwNrY6YFQMBNlGxCs8ZXDLJ25XHkOxk1W9zIICMJza9W4UiDL/cj44xrHIoDUML
 b0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726576031; x=1727180831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0l3T4AKmQpSgHoS3by1bTGt3WO/+7YOQLBFvdihbboc=;
 b=oADCB41CekZvpnKCGpI5+8IyWJWBRdnTTU5ZgAKrRueCp5nQ4zdYuqjCjtt2COMtnf
 Gbp9QxIGUCT2V2dW+VpHhAphEV8WQ8IpvQSazYQqb+p0ozGn5HdAXW5PiPdJmhjilE+b
 FS+cFRGasAS8a9U4lldW9DiW43Ajq3qwNUOSOORxZ7ZSzjzXb0kATrkYJXaEwCAHkWiG
 DaP1bBGsQuLMWSLSKzQOPHIYwjdinfJPIFwSX2o5zbM28ND/rf/q/EP7qYHOyh2FVktT
 XtVCf2hxCs6y9dLfP1BQZnhQs0sw5Ffu8+AyyafFtF7pF1jKhjiuTu00qq1eO1domtrA
 qO6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAsqCzdF+nlTXS2XpswyTsbLk3VCEZf+Ub4d8Y0zC+Fy6PYZGUeXMr3MYbKl7F2TZ/fqlXL+Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxJMc86Xp/edtUSgwsQzH2CLlMtGJxverBU5ZdaJoDrOyXmozVI
 g6T6FUs07OPmmOtkX0n4X+A9OuNSH31kruC+syG8XpLMuGYFXcaoZTE/mydAR1pa+aHTJ/Ct5mL
 ERM5QklcxpxRoRrpoqJtvZEmknpGCqw==
X-Google-Smtp-Source: AGHT+IH07eOnWq9eK2DIbbWhx41Ar3G/ncJlC4ERN5cJMkPTLNDyNMazqc/3F6R6VEwrp2y4XJPMtmO5Lyv6KnNs2uI=
X-Received: by 2002:a05:651c:2208:b0:2f6:5921:f35b with SMTP id
 38308e7fff4ca-2f791a0d2d0mr82748101fa.27.1726576030517; Tue, 17 Sep 2024
 05:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-7-4fe8effc937e@nxp.com>
 <CAOMZO5BOwB8JYLSNhQyG-7suNnMvMiaSDib8YBRsV+ZmDwBW4g@mail.gmail.com>
In-Reply-To: <CAOMZO5BOwB8JYLSNhQyG-7suNnMvMiaSDib8YBRsV+ZmDwBW4g@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Sep 2024 09:26:59 -0300
Message-ID: <CAOMZO5AVBvmyv=tzXD=-VaVGmS9Q1t_iyF-4-0+SM+9Bx3JXpA@mail.gmail.com>
Subject: Re: [PATCH 07/21] imx9: soc: Add function to get target voltage mode
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 17, 2024 at 9:24=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:

> Should the IMX9_LOW_DRIVE_MODE symbol be deleted then?

Ah, I see it gets removed in patch 19.
