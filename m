Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84BFD43349
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 11:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C1C68920C;
	Thu,  7 Nov 2024 12:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TEomRV/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E0288FF6; Thu,  7 Nov 2024 12:42:02 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 265BA89245
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 12:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb3c3d5513so8050111fa.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 03:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730979719; x=1731584519; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fzuasx2z+MyoqXU9x/T5xa5am9ncu133GRa/1xZKG3g=;
 b=TEomRV/oOxI3kiVqt1Ql2yXkwYku6ccM+4yLMISNqhNwuFcEwHm7PpWTNNQV4VK/29
 gAvDx3c2J9Rc3rugIjB6uK2Tr/k8OLXABh3HofOSa4xUdPZuI2SjxXu3qHnzu5h7vxDH
 ekn/pS6gkpId3BX5ZBXmFRYGrPskmzVeYLNwZL1fXUF2e0gmxsVPEmX9t/vCfPOwkCAI
 kUxHjBTxzXZJ5RZ0LEQuG3LXQteuMAsDgSnDALUy0UKgOtz035vsAoQGgeMYNBgp5SsV
 YqQWpC4HoT1JlmVa1JSommsAZKHFsr6V1Ue3fLzAcgIutwzInqWmgCWsGYgMPliEvIv/
 nmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730979719; x=1731584519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fzuasx2z+MyoqXU9x/T5xa5am9ncu133GRa/1xZKG3g=;
 b=D8jNdinsIVsFA4Bcy/sC0JuL+fBnzPSH4LlsWcSfwDnd0sfygWJclhetHEj2H6buh/
 Z6Qzjuhv5RNZxY99ucqy31II4fyL75lo+LoiwbqGKLgki12YTwj9PlMsjXpJZjzIih7O
 WVFq/RsHCqO/eWzHIBrR1fA8MtpiPa1kZVJr/Qm4WE8khcbrqu45rPdD4vSN1Gcf1XeA
 YNe2DtSJp2nEeXrpPrgSDaQsKsBknxX/umtWNNfQCtA8PkN9bIOoheySHff3YiRWH/90
 94C+pTRPjHaMuMVuGIQTacoFOroacw9VzmrTx8XmHSi3G7aoK1al8QbAjVI+ufkk/1p9
 MIGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUU45QN/7m/BfsF8at7QyarvSmoDo7M1D3JQVx1Tzm2Ehep4OayVu0BWdbJQfOTjn5yOG5XTc=@lists.denx.de
X-Gm-Message-State: AOJu0YwflZ8Dna/e3lDE3G6Xzho6PlJBY6fJZhumudNJDggWzjkBVjWP
 5k1imW+V23lLA+BkpPpY7TPp5cbPlTyd7x4KZ+feaN3XF2ZY4SBsTU2pm2NhbkmTVZm9hhuGwfB
 cUiyziV9qqGiWXdZiw5b7VHcpFb6EphbF
X-Google-Smtp-Source: AGHT+IGXfvdyyfAx9HkGCGFkUnTR84ZDIbIB/MkQBOpvWRMVD7mJC4I8k7/G1axbPAfwv7etruweab43Z92kFbTMmNg=
X-Received: by 2002:a2e:a803:0:b0:2fb:6027:7bfd with SMTP id
 38308e7fff4ca-2ff1aadc9a4mr6268991fa.27.1730979719094; Thu, 07 Nov 2024
 03:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
 <20241030064314.28604-2-venkatesh.abbarapu@amd.com>
 <1ab82f5b-6e89-4c1d-990e-3936c8ffa489@denx.de>
 <SA1PR12MB869760E4493442CBBFFE6D41985C2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <fd5c36fb-8e27-4146-bec1-52c87045dd71@denx.de>
In-Reply-To: <fd5c36fb-8e27-4146-bec1-52c87045dd71@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 7 Nov 2024 08:41:47 -0300
Message-ID: <CAOMZO5B8AANkDA9ktRqrm4fdqXb6izs3wjZcQE8E=0NvtwAB_w@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] usb: onboard-hub: Add reset-gpio support
To: Marek Vasut <marex@denx.de>
Cc: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Simek,
 Michal" <michal.simek@amd.com>, 
 "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
 "git (AMD-Xilinx)" <git@amd.com>
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

On Thu, Nov 7, 2024 at 8:35=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:

> I can very much predict there will show up a hub which expects the reset
> to be active HIGH and this will have to be removed, so better remove it n=
ow.

Agreed.

The onboard_usb_dev.c driver in Linux does not assume that the USB hub
reset is always active low.

It honors the GPIO flag passed via DT:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/usb/misc/onboard_usb_dev.c?h=3Dv6.12-rc6#n380

We should do the same in U-Boot.
