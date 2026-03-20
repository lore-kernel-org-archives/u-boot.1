Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450B61099B56
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 23:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77400840A2;
	Sat, 21 Mar 2026 00:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LnyrPG84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C54883FA4; Fri, 20 Mar 2026 18:38:44 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A0C83D71
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 18:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65c4152313fso3216828a12.1
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 10:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028322; cv=none;
 d=google.com; s=arc-20240605;
 b=bNlhcgKtPyhzY4LurYFkfAmIQ1QmwWB6HZ4HydqEe5jJg9qy3NQP12j1mddru+6U0W
 RuZvJ1yRzKsga/4ZQSVp+x0KfTvsPgWjPFrqEAerhCxRAa5E4vYtPybpyIQsYntnwdgK
 O+7chhUDLXbCtO7sQ+Br1YxG/lz7JDihwJIabDcn0yvmCJ9Gnp5UA9/3xWOusd3Ot/pN
 yNk9eoSeDh1JZ9iTSZ4xqji5Cuo8GbQSCILVYCM35eLk3NXaxB4UuZEtaDsAYkSVhFey
 Poo1+gLGHUImiodfQWmb8lCT+JG1Ocdu4iiCxQVMGt1Kah6Z7Hp1D9ZagKS6I7TSdXKQ
 kGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AcxE9zTCfATi7GI3T4HAsSD0gteZDy+SVQ+uh3BZvhk=;
 fh=3On2fTPT3ssfWmuCeooOsZm/slUd8/o/8MwZq3kDWRQ=;
 b=fEeUmYzmPO5ur/XbM0NSKOqLe2PQuUZtDiFimzu8Thvek+lOsriMG3BNQUG6tu62j6
 e2KTqs4lRB+5BqZWaNesYbc+3M9856YJp50OYWOLAUCTSRBXE1OHaKa615u6mySTxTBw
 PqjBEcE3daUa7ze+N8H/dL3szxoMp/qdpRD4jziJVKoYj+h6t/hKVkkvOBUbC8U3diAv
 ohFJVossC45t1b8RTljodxr1Z/ceFZu3J9DqQhqgFf0QjvG6URQdzX8/w/ayYZLCV257
 0QWKSP2PNK+bdO1kULfYiCdl8PlHW9/h4qDCwEpP6YLwHO0eTeDRKR+AsF4DlURsxjib
 2XFw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774028322; x=1774633122; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AcxE9zTCfATi7GI3T4HAsSD0gteZDy+SVQ+uh3BZvhk=;
 b=LnyrPG843p8CrdLqHAgVFtFDeWnuMvhDJW71uuXr9YNQFZL9EERJEDVkIkA6n+HNzG
 8Dz2aJEgs4jExZ7zFlckSN0hH97Cy8fqYb4SpR1nd5y5cXsriFPfW+Q6Mx2eAPiRE0C+
 GUO4O8/fjvQkHpqgiQj3PpkEeGfZeq1oV+VNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774028322; x=1774633122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcxE9zTCfATi7GI3T4HAsSD0gteZDy+SVQ+uh3BZvhk=;
 b=CerKtiO8Lw9Qgmc8EigkVMjJ1KQ/y1gJa/dhinuLTHwxh3YPiFbqcqrJk5n08ynhLe
 xkmKYitVqfoHK5dsQRrWQKMnE6P2IaxaXj/FrfwgvMLFLk+gQv1P4kptFoXyqJXprj6J
 lr2aKIyFp9qlhQr6Sz69fF0GR/cl2qdUx3M2Dvh/vHl+LwYW87mv2xsf369zUoK7uD8A
 giyvBAOPqmquwuqiE2AiaZ+8bGAhPOkhm+4xqPykFW34+4S47byLju42wWEGNmQO2Z96
 RkL7lJCJJTYn2VXCaQbJtQlJ+6wS7tWhxYLRodY3O1y1SNa0ME3zkw0Y631dNPUpdCpE
 Zh7Q==
X-Gm-Message-State: AOJu0YxcUiZVZ8vwCZa7YKPdJenICaVeQAaWnUDWKnEnZ7ZPJaE18Bl/
 DyjSrebCzsxnIYMDu4wrSohVz+aExdVabBoY8UOCtQ7D9rbIXSyvb1QAD96QPbtGEp1YFcRW+wN
 73F7XxIFe+nLFrm2b1tjO5orcmt3Folwmwkmqm0ui
X-Gm-Gg: ATEYQzx8gNo6PZcm/uVBsky4aldxkNOVZP/9yS+C2+AQ7fOBczNkZXz4Yzm8iI2JL4D
 /NkKSjocUtcpWgWa5r8O3kQkE8hDJ7DHjT2o13LBDdqSaqwNpmm7tBsz40johFA5zYCfscayGeq
 p5n3lno5k/a6l5pOBPmhdjo8aeOJAL+HU3vHdGkr/oKCfk4O3z+aKAaiiEZD94lK5Ei9GNSGgRe
 b6Sv5Lmg7V+GpZnPAaWQC8WSheHcdYiscIZ0p6kT8JuR8T7gCXQ5+dyHdfrQr8c0qUKT35tMGpa
 C/d1YS9Y
X-Received: by 2002:a17:907:3d90:b0:b98:48b1:b129 with SMTP id
 a640c23a62f3a-b9848b1baedmr34721866b.47.1774028321604; Fri, 20 Mar 2026
 10:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260319213551.267031-1-sjg@chromium.org>
 <20260320141622.GA502704@bill-the-cat>
In-Reply-To: <20260320141622.GA502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Mar 2026 11:38:29 -0600
X-Gm-Features: AaiRm51g0Y-Z5AfW0KWwZxU1ul0uF2YGd0RZEneigxVgzSoay2Ou9hX0aXtCfB4
Message-ID: <CAFLszTiwTyvbxYpNgTy-FKN4be80wTL58ag-gZ3Pvrp=mRU-Tg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/15] RFC: dm: Add uclass adjunct support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Brian Sune <briansune@gmail.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 George McCollister <george.mccollister@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Jim Liu <JJLIU0@nuvoton.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Stanley Chu <yschu@nuvoton.com>, Stefan Bosch <stefan_b@posteo.net>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 21 Mar 2026 00:54:25 +0100
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

Hi Tom,

On Fri, 20 Mar 2026 at 08:16, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 19, 2026 at 03:35:30PM -0600, Simon Glass wrote:
>
> [snip]
> > Note that a couple of linker-list fixes are included so that sandbox
> > will start up correctly. It still does not pass all tests though, due to
> > various bugs surfaced by this series. If we go ahead, we will need at
> > least one precursor series to resolve these pre-existing problems.
>
> I assume that the first two, linker-list, patches pass CI on their own.
> Since we hit those issues as part of lwIP development, can you please
> just post them on their own so they can be merged soon? Thanks.

Yes they are independent. I can post them separately.

Regards,
Simon
