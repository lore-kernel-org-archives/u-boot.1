Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96207C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 04:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA3E88426;
	Wed, 17 Apr 2024 06:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZZHE7Bev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239A488431; Wed, 17 Apr 2024 06:59:41 +0200 (CEST)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D0DB88422
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 06:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7e3e0b2f653so1512232241.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713329978; x=1713934778; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68ryBmkCR1wWrZ5y4nwFUGHicXmQ/swXWt3fizjPr5Q=;
 b=ZZHE7BevtPBs7cbEW7M5nBapK/sJ1sXpcLb1f47VnvKNrzRp5SdhYueHMjnGWYuLlY
 xzaoh68wQVyEA1Xa32tEAINALJ08WoYgyjfBujex+AaI1RZqhVSTbr1nskuRV8rAUf45
 IFDneDchKw0JktIdlr8vGbIRkjUUeQV33VwdQ8jeHXeKtiOXlZbmLv95oi/QOx7V37Bl
 HU9ApinyPYxg12Km9g0qKr2B9SdrEDgqwX6EwWoYaIRCZAMC/IuBQCs4Z0ZHTp23fS7o
 6Wm+APaDy+LaCsrmhAsKJqJbUUaLELPdMl53O1+7++rCqQe2wQ6FbGYvm/tZHCOCIeOt
 3M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713329978; x=1713934778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=68ryBmkCR1wWrZ5y4nwFUGHicXmQ/swXWt3fizjPr5Q=;
 b=XKfsZ9BiUHq6IIBtyobDmZ/b70IgfQzqUR85WNX2wsX53jxU+Qp9PsuQ7ZvRK3hSf8
 iLvctsfFsYn3zVX8qKqxSW5nzj9yvY+3+biJBclYuVB8Lds/L7tCyqzfOSDCTOMNyMkD
 g7/df+oPskCjG0QBI25F2DXFGrQA/BTNbVhFYdlCtG0bFnzgzBNnzXe2yPCwnjtV2jKE
 0ONtbLRb5gIldrOLArMdHsNNcK62/KEIzGXjr9plda6QxqGvKToC4XQgA7icrCm0HHyi
 0ToI6uzdqzTmarSFMzPSSoIKh6ZGS6UtNNqHsr+juvqMNag8rlp7RIcRVn7DSS83xZgo
 HOnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLx9436XA81PA+B76b2WboMelE8QJtHugWwjKrbfWwT6WPndWp4gsMhcQsGSTAxJCm74TyxSaZOg7BxW3VbODiiz4D8g==
X-Gm-Message-State: AOJu0Yz6xUGNxkLfkQHWAI7eesKaksNvKjfzBcPO7v7ufRpMq7wJ4x2A
 R/JPygz4LNb1soGgCj7d2ZPyRfJLT6u7NmVIlz7HAryXZ8kcFzD67eVsnGK5UHJ7k9NgdNXzkq1
 WN3wyowzUZdYoXt0nYrqEff16EaI=
X-Google-Smtp-Source: AGHT+IFgz2FHTSXwbc/JzdRTCYzv1qQD2ugB1qGDKoVlAAP1T13BalwVM7frJKznnon7CtU9e3l+SIz1/zXyWZn1dfk=
X-Received: by 2002:a05:6122:d0b:b0:4d4:be1:8196 with SMTP id
 az11-20020a0561220d0b00b004d40be18196mr12768576vkb.11.1713329977807; Tue, 16
 Apr 2024 21:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <1709694011-683-1-git-send-email-ganboing@gmail.com>
 <ZQ2PR01MB13079F11D2A7B2A20968F4FDE62BA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTMPrQVZhWvNFxi8-RA0ZC4UAF1sHBbHiipUc01aWx6oqg@mail.gmail.com>
 <0eda64cb-4ca8-f8bc-7515-6d2a2d3d4638@gmail.com>
In-Reply-To: <0eda64cb-4ca8-f8bc-7515-6d2a2d3d4638@gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 16 Apr 2024 21:59:26 -0700
Message-ID: <CANV2PTP3o1Q2JPCZO8Ewfye+oz9f3TVNTYhYZ3EAKtdYAhvkHg@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: jh7110: Enable PLL node in SPL
To: Bo Gan <ganboing@gmail.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 "rick@andestech.com" <rick@andestech.com>, 
 "ycliang@andestech.com" <ycliang@andestech.com>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 "duwe@suse.de" <duwe@suse.de>, "namcao@linutronix.de" <namcao@linutronix.de>, 
 Xingyu Wu <xingyu.wu@starfivetech.com>, Mason Huo <mason.huo@starfivetech.com>,
 "chanho61.park@samsung.com" <chanho61.park@samsung.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Tue, Apr 9, 2024 at 11:44=E2=80=AFPM Bo Gan <ganboing@gmail.com> wrote:
>
> On 4/9/24 6:55 PM, E Shattow wrote:
> > Original speed class SD cards fail with this change "unable to change m=
ode".
> >
>
> The BUS_ROOT clock will have to be switched to PLL2 anyway in U-Boot prop=
er or
> in Linux, because it's the parent or grandparent clock for *lots* of devi=
ces,
> including PCIe, i2c, spi, qspi... If there's an issue with this change, t=
hen
> I suspect there's something wrong with the dw_mmc driver.
>
> Bo

I've bisected and can confirm this change is what breaks original
speed SD function on Milk-V Mars CM Lite (DFRobot mini router
carrier). Class 10 speed SD media does not seem to be affected.
Reverting the change allows the original speed SD media access to
function again. SD access is functional in Linux with and without the
change.

How to troubleshoot this?

Thanks,

E
