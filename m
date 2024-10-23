Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AC1D2E02B
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 09:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09168925A;
	Wed, 23 Oct 2024 11:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PVKeIjal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CAA38925A; Wed, 23 Oct 2024 11:21:35 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 894598841E
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 11:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e2e23f2931so5203194a91.0
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1729675288; x=1730280088;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rj9Cmv/yYarb016F0wFM+E7xyaUmVmz+1Vh6d3IMl24=;
 b=PVKeIjalu47UJQdPL56ljmDzOPiA2cfg/VeYW54ux8GMPiolZuCLvHCvmyFuGBTlTr
 fDzLg5KxOgWIRtW6W9TkZcFuSDYfdgQ/CAhKtGQ9/zD2fcjkjCRqMw1k+IlhJ7haw240
 UEKfEGk9pVEXMIhCP7UO8QhWoMdoyy6jZhap4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729675288; x=1730280088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rj9Cmv/yYarb016F0wFM+E7xyaUmVmz+1Vh6d3IMl24=;
 b=Y0z4lc4T7wL77Yik9NE8Mnatkz3BPGrgxsaIvoCBuny9HEtCGwAwOP0glXIkysO4ve
 rOFGudOWDgNJ1sdkLjRaxGQyAFZeEmL64+3iuCzuDx/TZpKvKwXn1x9dV3Rg7JzpsmMh
 DF4N/7dlriZpHvrrFjQ5zNavT69byxTb7psl2JVi8Jcby4A5xGiVYC8Q4trr4F2lJvXH
 1ttkAy2nm6E9K37Sf0MdLACk08DV5Mk+lPGnzsS8ZDLBiBs9061ZktqzlSKuFjUffDQj
 IOjg1bvJ70BEG7a3EU+Sk8LoqJA5hMKRT7ZhgUvB0L70SDKR6Byctwdo+GooYct+yEJ6
 wemQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe3pJYSKglp6afwfRU27EZW3ufYApXZ/TFiGa9U44vwGq7kIB065KCUh0WBNTTaDGfzaO+fMo=@lists.denx.de
X-Gm-Message-State: AOJu0YwfzO6C+KuxWVkRfUk8J3pyZI82XliZalGCcGpnAI6m6ZeyrWGn
 9Jnt6obcljvQJ9MDuHd7u/elx7/y8/HLTMNa8MuLe4QD8pNX62aIgxjKJ3hZ1pyl04t6tiX83t6
 SYB8x6zrTbRk8nYlxgEFdlGIeUndoCWSQTrbiIw==
X-Google-Smtp-Source: AGHT+IGia+KgYes1xG+b5F13euMSxDwT3lliYBOf5EHydHBHNwdgd4v/z8uljQWoP1HmN6PSALoJ90EgeHuGgokpOG4=
X-Received: by 2002:a17:90b:4a0c:b0:2e2:ebbb:760c with SMTP id
 98e67ed59e1d1-2e76b5dd9f0mr1953792a91.11.1729675287933; Wed, 23 Oct 2024
 02:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241022210633.271534-1-marek.vasut+renesas@mailbox.org>
 <SA1PR12MB8697AF99B0A56734FF65AD47984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <699f9d96-a109-40ab-9cd8-ed0c5b4b589f@mailbox.org>
In-Reply-To: <699f9d96-a109-40ab-9cd8-ed0c5b4b589f@mailbox.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 23 Oct 2024 11:21:17 +0200
Message-ID: <CAOf5uwkO+eYQx41HM9ydc1fRxjkhrytrtp1SLLKbotVNfk+KXw@mail.gmail.com>
Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories support
 in QSPI driver"
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Michael Walle <mwalle@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>
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

Hi Marek

On Wed, Oct 23, 2024 at 10:41=E2=80=AFAM Marek Vasut <marek.vasut@mailbox.o=
rg> wrote:
>
> On 10/23/24 5:18 AM, Abbarapu, Venkatesh wrote:
> > Hi Marek,
> > There was some issue and fix is sent
> > https://lore.kernel.org/u-boot/20241018082644.22495-1-venkatesh.abbarap=
u@amd.com/T/#u
>
> Is this one fix or three fixes for three different issues ?
>
> This seems to fix READ errors, which is apparently another error
> introduced by this stuff. In my case, plain and simply 'sf probe ; sf
> update' combination with single non-stacked SPI NOR does not work. Was
> such a simple configuration ever tested ?
>
> > Not sure we need to revert whole parallel/stacked support?
> Please stop top-posting.

spi-nor was taken care buy Jagan but I dont' know if he is having
time. This series was not merged from our
side

Michael
