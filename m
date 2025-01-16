Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE32C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 17:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B8B78022B;
	Thu, 16 Jan 2025 18:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VJGQp4YR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 616B380312; Thu, 16 Jan 2025 18:09:44 +0100 (CET)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C72780214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 18:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C43011BF205;
 Thu, 16 Jan 2025 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1737047381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LinRY8msd/3lU7ttloCpJbxCPUvrDV5Szc4+aqh5m1s=;
 b=VJGQp4YROAh4JoEJqxIsP2zRzidLI5ULEfgE8zvip6zZ+2JtvIIeT5VvQUz5ndcTatrafX
 RnONY6ly6MLe+FgrbtKG+E351sAfF5EWw95u5r20sFQ/+vjfg01Y4yUoII7tmRs1FkJTSC
 jCFM/uZ5DxKdBS3LeUtuwNW4o8Ct+c0LuwNsJSZyOUJIIMv+lJXbf2IssL+KJBuKMrjFjN
 dEhmDPyvAhKMRRyqYxMnfhK1l6rJD7jfI1kJ4mKyoYdiDUXLL2bnQAFYw8edAwQQaQriUt
 Lo3rJZVikNM+XqWQyc1oPDwu29igYDyU0zykPxLoFvJXmG9xXMz80cpMHlF0Kg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Simon Glass <sjg@chromium.org>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Lukasz Majewski <lukma@denx.de>,  Sean
 Anderson <seanga2@gmail.com>,  Anatolij Gustschin <agust@denx.de>,  Peng
 Fan <peng.fan@nxp.com>,  Mario Six <mario.six@gdsys.cc>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 13/13] imx8mp_evk: Enable display support
In-Reply-To: <CAOMZO5DRfTh_iOFiJi9J1FrDq6-VV0dWkCJD1Oq1cwBeVQ4pjA@mail.gmail.com>
 (Fabio Estevam's message of "Thu, 16 Jan 2025 13:13:53 -0300")
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-13-d2c0acea6feb@bootlin.com>
 <CAOMZO5B2K64cc1v3yn26fXqHtEcsMf+eSj_Smm_vAr5shzfboQ@mail.gmail.com>
 <87zfjxsmpk.fsf@bootlin.com>
 <CAOMZO5DRfTh_iOFiJi9J1FrDq6-VV0dWkCJD1Oq1cwBeVQ4pjA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 16 Jan 2025 18:09:40 +0100
Message-ID: <87jzauk7mz.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

On 16/01/2025 at 13:13:53 -03, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Miquel,
>
> On Sat, Jan 11, 2025 at 6:51=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
>
>> I only worked on a custom design based on a i.MX8MP. We do have an EVK,
>> but it has no display. I was asked to add a user, but in practice I
>> cannot test that. I can enable the ldb in the EVK DTS or drop that
>> patch.
>
> I wanted to have an in-tree user for the i.MX8MP LDB, but if you
> cannot test, I suggest dropping the imx8mp-evk patch from v4.
>
> Hopefully, someone can enable LDB support for some other imx8mp-based boa=
rd.

Ok.

> Besides that, there are some comments from Simon on the patch 05/13
> that need to be addressed in v4.
>
> I hope v4 can be merged.

Yes, I need to get into this again because he asked something similar in
response to one of my previous versions, and I disagreed. I will
reconsider his requests. Hopefully we'll settle at some point.

Thanks,
Miqu=C3=A8l
