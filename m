Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341BBC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 16:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98A6088842;
	Tue, 13 Aug 2024 18:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UPK2OgQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD44D8890D; Tue, 13 Aug 2024 18:23:34 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625C4880A5
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 18:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-530eed61afdso701094e87.3
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723566212; x=1724171012; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LovGFXnP9rICY6PfjCV6pGWqREgodI6GZ2I8afdHn/0=;
 b=UPK2OgQdpp58YUP/S4cc0DpbDHGcZ+4BHS+UmLlap13STSyXjZkCAX6UldljpUIKtO
 gbf4G2JrvYYk/BxfLq0cFsiOOC5y+PFKHcTxnvHVsnZckSIpjo7PjBXlyVcgjr+2eWAC
 mDZNsC9iL3JbnGf6JLCJzF7+wANz56d/fx0u1Jb6oRTb8DO+E+FBtOWNfLUloumTh8ZJ
 XT9E1Ibzzo2vBaxT9+9BpOd6KFz+nZhj5+wwIMozbnsKJl4Mf/WwCRCsQrOT1dklWirq
 yCOzSIJeYlv3qAlvfUT4fTsi8ixZhKzdkU3xwlolPQ0T3JIFbtwmaAS0eCZR2AwXYnXm
 cTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723566212; x=1724171012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LovGFXnP9rICY6PfjCV6pGWqREgodI6GZ2I8afdHn/0=;
 b=gTPSIkKUoPXGJwRiJ/NKGeddoiirwT2MPmhrpN90Lu/58RpWMAcMtqCdnVtn58ovmU
 ooHzY0mSDV3sT4fh0owGvP3F7ue02C6/rhJuBlHiuDA1K78Qq95Md9GBBlyUpK2H+Inm
 caEvsveIwNLuaN9saKtaAL7Z0WEo/4J9oJQqGQBJ3lUGQ0ik8scHBwSrnmi5ofB837lZ
 Hm7CE08ufAs6jys4mNhlXIU0QsXcI2QyHev1OEAffUSPNX4H6UFUhx+Qu0A4SeUdhdnm
 ElTerdnZMYbfYAF5a7//vFkeTniumhsx5hEDgV6T6X5Ir7wSJtNphX2V02F7rat2UXS8
 MW7A==
X-Gm-Message-State: AOJu0YzUkB586x8stdT/QC7yhjBjY4iX7GVTrbFmF/HgAWhbyTe5KTkq
 vNDWykfdHXhWoDwOFIzgMS3B148nqct59pS80uGtv8UQYBG8rRTrjgVPJrKpH6ssDOVurMqR1PN
 gVfxb3mSkAl9jVQOOK4IVxuazhgkdWw==
X-Google-Smtp-Source: AGHT+IELpYvD+/3UPkhB5vROiNYgANRdtAzqQs6m664tKAqHjHIV5TzG2hPtPOgu/ipgbX/pLkQA7Ht4wSrgUMZiBGk=
X-Received: by 2002:a05:6512:3b99:b0:52f:287:a083 with SMTP id
 2adb3069b0e04-53215be2ab8mr1334945e87.0.1723566211121; Tue, 13 Aug 2024
 09:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240805124326.544310-1-bisson.gary@gmail.com>
 <20240805124326.544310-2-bisson.gary@gmail.com>
In-Reply-To: <20240805124326.544310-2-bisson.gary@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Aug 2024 13:23:19 -0300
Message-ID: <CAOMZO5Cd+4i2KvBzwD=83=jVVr7PMLS_mob3Ng8cFVbrQEOgKw@mail.gmail.com>
Subject: Re: [PATCH 1/5] tools: imx8image: fix soc variable for ULP
To: Gary Bisson <bisson.gary@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 uboot-imx@nxp.com
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

On Mon, Aug 5, 2024 at 9:43=E2=80=AFAM Gary Bisson <bisson.gary@gmail.com> =
wrote:
>
> Fixes: 6ec65c8558f (tools: image: support i.MX93)
>
> Currently the ULP token sets the soc as IMX9, making it impossible to
> differentiate the two families of processors.
> However, since the 8ULP requires specific binaries like upower which do
> not exist in 93, they need to be separated.
>
> Signed-off-by: Gary Bisson <bisson.gary@gmail.com>

Applied the series, thanks.
