Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CEEE7719A
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 09:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF84801CE;
	Sat, 11 Jan 2025 10:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MtnCY5Sn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFD4E8036B; Sat, 11 Jan 2025 10:51:07 +0100 (CET)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70910801BE
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 10:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF2CDC0002;
 Sat, 11 Jan 2025 09:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1736589065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Et84hj2a4tunZwA2KmgVna2geI4gzH26gZL0KcN5hTU=;
 b=MtnCY5SnVDIdZ/z9+taJx5n6FFJ2U/ufUrnTFF6n1yLJw7MHGYL0tdD61iYfyiFHetD9JC
 ecIgTv87A3GpxB3V6bqwbE0NNnUoh1hJ32df/NYLkZevfywTwfhnT7xOY5UxD9dSYcH+8G
 HknvFWutmWoPV4WZQJSQ1sDkItxSeCjvg+UcdXkqBbWipKXgZk6X8njbwzkQ3BxFN3KT1u
 GybOYYeU+D7DHejWeOrtu6Pw70KxseH8ixWmkL6uMwT3Y4Icy3o4z1kuX7aygEL5ku7Dgf
 iwsFoU/DxQNZtka8gJdX4Kp8qOMLAdvIW/v5m8ROBKRNEPzXmNSI8X9I8ViFyg==
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
In-Reply-To: <CAOMZO5B2K64cc1v3yn26fXqHtEcsMf+eSj_Smm_vAr5shzfboQ@mail.gmail.com>
 (Fabio Estevam's message of "Fri, 10 Jan 2025 15:53:35 -0300")
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-13-d2c0acea6feb@bootlin.com>
 <CAOMZO5B2K64cc1v3yn26fXqHtEcsMf+eSj_Smm_vAr5shzfboQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 11 Jan 2025 10:51:03 +0100
Message-ID: <87zfjxsmpk.fsf@bootlin.com>
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

Hello Fabio,

On 10/01/2025 at 15:53:35 -03, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Peng,
>
> On Fri, Jan 10, 2025 at 3:43=E2=80=AFPM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
>>
>> There is now support for the display pipeline using one LCD interface,
>> the LDB bridge and of course the related media power domain controls.
>>
>> This is untested as I do not have the EVK but should be enough to use
>> the display, using bmp, lcdputs and co. For console-like commands, it
>> might be also needed to enable the VIDEO_CONSOLE explicitly using:
>>
>>      setenv stdout serial,vidconsole0
>
> I have access to an imx8mp-evk but don't have an LVDS panel to test.
>
> Could you please test this series on an imx8mp-evk + LVDS setup?

I only worked on a custom design based on a i.MX8MP. We do have an EVK,
but it has no display. I was asked to add a user, but in practice I
cannot test that. I can enable the ldb in the EVK DTS or drop that
patch.

Thanks,
Miqu=C3=A8l
