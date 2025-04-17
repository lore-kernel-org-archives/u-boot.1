Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9852EC369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 15:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E64AD82E58;
	Thu, 17 Apr 2025 17:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nqwcHm/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E402183077; Thu, 17 Apr 2025 17:20:28 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9093A82F87
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 17:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1AAEC43A14;
 Thu, 17 Apr 2025 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1744903226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H4Waa3bXndl7mWkZhzbrQW+4K8bTWwjbHi/q5+1Bgtk=;
 b=nqwcHm/iJCqTg7kHm9pWbqMNx52EpGkmJcVUphbI+J7MP5NAcLdif+MLPs9nNttlus5IlQ
 cXr1wZNz6E3h/lvX1DkxrxnD9UOr3vGgksMFaYzbUQ7IBYbXqgcpssjIt2JRbofCzqGyBA
 Jd7RtbOSKelw6fogyTECw1FLoA7uMJhSvD8ozTMI0ydP+K9bbNJftRZMfa8xSXc7dOPuEb
 L/P8elgGzAhWdrA/jjzxtsg6Jp/k1R/LHaBtFLPWTUFnY7nzWeHpgvfU9xSjKG6gnEyRrg
 fQzy6Wx788Az9CLvbq/otGIVyG7XwHOcYI6dl4DefnCF4lYNTKl/RoHO2ycrZg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Heiko Schocher <hs@denx.de>
Cc: Fabio Estevam <festevam@denx.de>,  "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: imx8mp: pci enumeration fails with current HEAD
In-Reply-To: <475e2654-715a-0139-7cc5-734a3457db9b@denx.de> (Heiko Schocher's
 message of "Thu, 17 Apr 2025 16:46:13 +0200")
References: <c533393a-ca65-49a4-55a5-77bcb3cf589d@denx.de>
 <475e2654-715a-0139-7cc5-734a3457db9b@denx.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 17 Apr 2025 17:20:25 +0200
Message-ID: <874iymq0g6.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeliedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohephhhsseguvghngidruggvpdhrtghpthhtohepfhgvshhtvghvrghmseguvghngidruggvpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 17 Apr 2025 17:35:41 +0200
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

On 17/04/2025 at 16:46:13 +02, Heiko Schocher <hs@denx.de> wrote:

> Hello Miquel,
>
> On 17.04.25 16:37, Heiko Schocher wrote:
>> Hi Miquel,
>> I have here an imx8mp based board for which I just prepare mainlining.
>> pci enumeration works fine with U-Boot 2025.04
>> u-boot=3D> pci enum
>> PCIE-0: Link up (Gen1-x1, Bus0)
>> u-boot=3D>
>> and tftp through the ethernet interface works fine.
>> Using current HEAD
>> * 5b4ae0f3f04 - (origin/master, origin/HEAD) mailmap: update my name
>> and email (vor 2 Tagen) <Casey Connolly>
>> It breaks with:
>> u-boot=3D> pci enum
>> nxp_imx8_pcie_phy pcie-phy@32f00000: PHY: Failed to power on pcie-phy@32=
f00000: -110.
>> pcie_dw_imx pcie@33800000: failed to power on PHY
>> u-boot=3D>
>> git bisect dropped your patch:
>> 197376fbf300e92afa0a1583815d9c9eb52d613a is the first bad commit
>> commit 197376fbf300e92afa0a1583815d9c9eb52d613a
>> Author: Miquel Raynal <miquel.raynal@bootlin.com>
>> Date:=C2=A0=C2=A0 Thu Apr 3 09:39:05 2025 +0200
>>  =C2=A0=C2=A0=C2=A0 power-domain: Add refcounting
>>  =C2=A0=C2=A0=C2=A0 It is very surprising that such an uclass, specifica=
lly designed
>> to
>>  =C2=A0=C2=A0=C2=A0 handle resources that may be shared by different dev=
ices, is not keeping
>>  =C2=A0=C2=A0=C2=A0 the count of the number of times a power domain has =
been
>>  =C2=A0=C2=A0=C2=A0 enabled/disabled to avoid shutting it down unexpecte=
dly or disabling it
>>  =C2=A0=C2=A0=C2=A0 several times.
>>  =C2=A0=C2=A0=C2=A0 Doing this causes troubles on eg. i.MX8MP because di=
sabling power
>>  =C2=A0=C2=A0=C2=A0 domains can be done in recursive loops were the same=
 power domain
>>  =C2=A0=C2=A0=C2=A0 disabled up to 4 times in a row. PGCs seem to have t=
ight FSM internal
>>  =C2=A0=C2=A0=C2=A0 timings to respect and it is easy to produce a race =
condition that puts
>>  =C2=A0=C2=A0=C2=A0 the power domains in an unstable state, leading to A=
DB400 errors and
>>  =C2=A0=C2=A0=C2=A0 later crashes in Linux.
>>  =C2=A0=C2=A0=C2=A0 CI tests using power domains are slightly updated to=
 make sure
>> the count
>>  =C2=A0=C2=A0=C2=A0 of on/off calls is even and the results match what w=
e *now* expect.
>>  =C2=A0=C2=A0=C2=A0 As we do not want to break existing users while stil=
e getting
>>  =C2=A0=C2=A0=C2=A0 interesting error codes, the implementation is split=
 between:
>>  =C2=A0=C2=A0=C2=A0 - a low-level helper reporting error codes if the re=
quested transition
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 could not be operated,
>>  =C2=A0=C2=A0=C2=A0 - a higher-level helper ignoring the "non error" cod=
es, like EALREADY and
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EBUSY.
>>  =C2=A0=C2=A0=C2=A0 Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.=
com>
>> reverting this patch, and it works again fine for me!
>> Do you have a imx8mp based hardware with pci?
>> Can you (or anyone else with an imx8mp based hardware with pci)
>> approve
>> this on a similiar HW?
>> I try to dig into it, but may you have a fast idea!
>> Okay, thought about it ... it tries to power on "blk-ctrl@32f10000"
>> driver:/drivers/power/domain/imx8mp-hsiomix.c
>> imx8mp.dtsi:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hsio_=
blk_ctrl: blk-ctrl@32f10000 {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "fsl,imx8mp-hsio-=
blk-ctrl", "syscon";
>> which has several different power domains ... and your patch prevents
>> to
>> enable more than one of them ... adding some debugs shows:
>> u-boot=3D> pci enum
>> [...]
>> power_domain_on_lowlevel(power_domain=3D00000000fe5942f8) blk-ctrl@32f10=
000 priv->on_count: 0
>> power_domain_on_lowlevel(power_domain=3D00000000fe5942f8) blk-ctrl@32f10=
000 power_domain->id: 4
>> Here pwoer domain id
>> #define IMX8MP_HSIOBLK_PD_PCIE_PHY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 4
>> gets enabled and on_count increases...
>> imx8mp_hsiomix_set: ------------ power_domain->id: 4
>> IMX8MP_HSIOBLK_PD_PCIE: 3 4
>> power_domain_on_lowlevel(power_domain=3D00000000fe5d2408) power-domain@1=
7 priv->on_count: 0
>> power_domain_on_lowlevel(power_domain=3D00000000fe5d2408) power-domain@1=
7 power_domain->id: 0
>> power_domain_on_lowlevel: ret: 0
>> power_domain_on_lowlevel(power_domain=3D00000000fe5d2480) power-domain@1=
 priv->on_count: 0
>> power_domain_on_lowlevel(power_domain=3D00000000fe5d2480) power-domain@1=
 power_domain->id: 0
>> power_domain_on_lowlevel: ret: 0
>> imx8mp_hsiomix_set: ------------ power_domain->id: 4 IMX8MP_HSIOBLK_PD_P=
CIE: 3 4 END OKAY
>> power_domain_on_lowlevel: ret: 0
>> power_domain_get_by_index(dev=3D00000000fe5b2410, power_domain=3D0000000=
0fe594458)
>> power_domain_on_lowlevel(power_domain=3D00000000fe594458) blk-ctrl@32f10=
000 priv->on_count: 1
>> power_domain_on_lowlevel(power_domain=3D00000000fe594458) blk-ctrl@32f10=
000 power_domain->id: 3
>
> okay, the "power_domain=3D00000000fe594458" for the IMX8MP_HSIOBLK_PD_PCI=
E case
> is different as the one for the IMX8MP_HSIOBLK_PD_PCIE_PHY case ... so pr=
iv pointer
> should also be different...

That's part of the problem. The API is unusual, you probably allocate a
structure (either on the stack or dynamically) and pass its pointer to
be filled by the uclass.

In general the approach is that you ask the uclass to give you a pointer
towards a unique version of a structure that defines an opaque object
you want to manipulate.

So I do not think the printing is relevant, what is more relevant is the
node the udev targets. In both cases it is blk-ctrl@32f10000, so the
second time on_count is already set.

> so that should be fine ... I do not see any debug output
> where this "power_domain=3D00000000fe594458" gets enabled (or disabled be=
fore) ... I
> have to debug deeper into it... sorry. But may you have an idea...

Let me know if you think my theory does not stand.

Thanks,
Miqu=C3=A8l
