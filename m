Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BCCC83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 10:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC2FB832C8;
	Tue, 22 Jul 2025 12:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QpywCgng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1067B83346; Tue, 22 Jul 2025 12:09:43 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2F6982C65
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EE334336F;
 Tue, 22 Jul 2025 10:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1753178979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNFHPacyPFXb/Oc8AU5d3QxKLgr4pXqeub209XlWKzU=;
 b=QpywCgng/AvZ9YWYh85k0rLylpJuxs7qlxVXjcd2jC4i3ThFN4bLtHQtqEYY0bVnPL9m3A
 oNzz3XoNu1Lu9QQrUFnWgzx+t5AADpQiR38qtlIsbC0pltWT4SHcfxC/7qseyMSykUCw+j
 5ScU5+yxANHMyE/JLpdx+XZLZ/lMdfAxeSgSu8qELhYasXM/UuuU1Tlm6kG8vBcOEt+xUP
 YnMP/T2AMJvd37HBO7BjhZ8ok2baEDKUHi8JH1ecTyn7oeNEUo2cVKx/n3q0FuYlWWz+jm
 wJyx2rVMBicCOgKgkVQBTgNRM7+v4i5pFntV3npxhvaUszYmyRm/lCzqyMcciQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: u-boot@lists.denx.de,  Jaehoon Chung <jh80.chung@samsung.com>,  Patrick
 Wildt <patrick@blueri.se>,  Tom Rini <trini@konsulko.com>,  Frieder
 Schrempf <frieder.schrempf@kontron.de>,  Fabio Estevam
 <festevam@gmail.com>,  Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] imx: power-domain: Fix crash due to uninitialized 'id'
 field
In-Reply-To: <20250722083119.64084-1-frieder@fris.de> (Frieder Schrempf's
 message of "Tue, 22 Jul 2025 10:31:18 +0200")
References: <20250722083119.64084-1-frieder@fris.de>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 22 Jul 2025 12:09:38 +0200
Message-ID: <878qkgcza5.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehfrhhivgguvghrsehfrhhishdruggvpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepjhhhkedtrdgthhhunhhgsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepphgrthhrihgtkhessghluhgvrhhirdhsvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehfrhhivgguvghrrdhstghhr
 hgvmhhpfheskhhonhhtrhhonhdruggvpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhrghrvhgvhiesghgrthgvfihorhhkshdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Tue, 22 Jul 2025 12:14:18 +0200
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

Hi Frieder,

On 22/07/2025 at 10:31:18 +02, Frieder Schrempf <frieder@fris.de> wrote:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> In case of the i.MX8M power-domains (i.MX8MQ, MM, MN) there is only
> one power-domain for each device. Therefore the 'id' field in struct
> power_domain should always be zero.
>
> Currently if a power-domain is accessed after the initial bind, the
> 'id' field is left uninitialized. This didn't cause any problems
> until the following commits were introduced:
>
> 9086b64ca071 ("power-domain: Add support for refcounting (again)")
> a785ef24487b ("imx: power-domain: Enable refcounting on imx8mp")
>
> Now the 'id' field gets accessed in the power_domain_off() sequence
> and the invalid value causes "Synchronous Abort" failures.
>
> This was observed on a i.MX8MM board when running "usb start" and
> then "usb stop".
>
> Fix this issue by setting power_domain->id to '0' in
> imx8m_power_domain_of_xlate().
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Fixes: d08a194871fd ("imx: add support for i.MX8MQ power domain controlle=
r")
> Fixes: 9086b64ca071 ("power-domain: Add support for refcounting (again)")
> ---
>  drivers/power/domain/imx8m-power-domain.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/do=
main/imx8m-power-domain.c
> index b44aae78e6d..a7e64971a2a 100644
> --- a/drivers/power/domain/imx8m-power-domain.c
> +++ b/drivers/power/domain/imx8m-power-domain.c
> @@ -468,6 +468,8 @@ out_clk_disable:
>  static int imx8m_power_domain_of_xlate(struct power_domain *power_domain,
>  				      struct ofnode_phandle_args *args)
>  {
> +	power_domain->id =3D 0;
> +
>  	return 0;
>  }

Looks like a correct fix. I wonder how many drivers do not properly set
an id though. Thanks a lot!

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
