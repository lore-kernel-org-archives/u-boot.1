Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8EDE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 14:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B3B89615;
	Fri,  6 Dec 2024 15:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="W0SCLFVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C14758960D; Fri,  6 Dec 2024 15:38:08 +0100 (CET)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 998E189627
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 15:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78B911BF203;
 Fri,  6 Dec 2024 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1733495886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOOKypnVomaBNW7RZqIpSOZfmZj23WKekFUa/J/aGpY=;
 b=W0SCLFVrh09lNboDztbE+O6+REBdNAxt2HIDv88Ebdu8Uw3qTkh5cvBxLZSZgOH0+CfER7
 oYWyq7p1Y8QweOprfFIZLvb+lfGv9f3vTuU4J6YKVYj+KSYsge+LPzKNmChmgNWIDttJnO
 sRL8qLkdC1lRcs/cNi0J9bZe+rkWAvQabFkaKVIlB88CvC9OEK7DFcKcp/TaB3o/8g3DpL
 Vwsv1jrCFUmVvAmfNxn4IWVvYl+4N5SOIj+z7tL5JtG4Ko2mueo7uTI/5EVaEmsMUnhyeE
 t8/kjNUVOTstDAo7E2RNIn1DF76tR1TWN2gYsIgqklKiNU4gSA1A2sZs9SEjMQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: Fabio Estevam <festevam@gmail.com>,  Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,  Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,  Anatolij Gustschin
 <agust@denx.de>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 05/13] power-domain: Add refcounting
In-Reply-To: <CAFLszTjaqOYJnoJ+DZh+BrREKsyenAT-mwkp=+9k4wyc6zHYUw@mail.gmail.com>
 (Simon Glass's message of "Thu, 5 Dec 2024 10:56:44 -0700")
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
 <20241205-ge-mainline-display-support-v2-5-4683bb4388dc@bootlin.com>
 <CAFLszTjaqOYJnoJ+DZh+BrREKsyenAT-mwkp=+9k4wyc6zHYUw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 06 Dec 2024 15:38:05 +0100
Message-ID: <871pykop0y.fsf@bootlin.com>
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

Hello Simon,

On 05/12/2024 at 10:56:44 -07, Simon Glass <sjg@chromium.org> wrote:

> Hi Miquel,
>
> On Thu, 5 Dec 2024 at 06:54, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>>
>> It is very surprising that such an uclass, specifically designed to
>> handle resources that may be shared by different devices, is not keeping
>> the count of the number of times a power domain has been
>> enabled/disabled to avoid shutting it down unexpectedly or disabling it
>> several times.
>>
>> Doing this causes troubles on eg. i.MX8MP because disabling power
>> domains can be done in a recursive loops were the same power domain
>> disabled up to 4 times in a row. PGCs seem to have tight FSM internal
>> timings to respect and it is easy to produce a race condition that puts
>> the power domains in an unstable state, leading to ADB400 errors and
>> later crashes in Linux.
>>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>  drivers/power/domain/power-domain-uclass.c | 37 +++++++++++++++++++++++=
+++++--
>>  include/power-domain.h                     |  4 ++--
>>  2 files changed, 37 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/=
domain/power-domain-uclass.c
>> index 938bd8cbc9ffd1ba2109d702f886b6a99288d063..55a3d95d83c5aaac31acbd87=
7199c87f8f6fb880 100644
>> --- a/drivers/power/domain/power-domain-uclass.c
>> +++ b/drivers/power/domain/power-domain-uclass.c
>> @@ -12,6 +12,10 @@
>>  #include <power-domain-uclass.h>
>>  #include <dm/device-internal.h>
>>
>> +struct power_domain_priv {
>> +       int on_count;
>> +};
>> +
>>  static inline struct power_domain_ops *power_domain_dev_ops(struct udev=
ice *dev)
>>  {
>>         return (struct power_domain_ops *)dev->driver->ops;
>> @@ -110,19 +114,47 @@ int power_domain_free(struct power_domain *power_d=
omain)
>>  int power_domain_on(struct power_domain *power_domain)
>>  {
>>         struct power_domain_ops *ops =3D power_domain_dev_ops(power_doma=
in->dev);
>> +       struct power_domain_priv *priv =3D dev_get_uclass_priv(power_dom=
ain->dev);
>> +       int ret;
>>
>>         debug("%s(power_domain=3D%p)\n", __func__, power_domain);
>>
>> -       return ops->on ? ops->on(power_domain) : 0;
>> +       if (priv->on_count++ > 0)
>> +               return 0;
>
> -EALREADY - see drivers/power/regulator/regulator-uclass.c

Actually I don't see the point in returning this? What is the purpose?
Users should not care nor know about this, it is all internal to the
uclass, we do _not_ want users to mess with this.

If someone ever needs it, they can add a layer of "hiding" for all users
but them, but as said just above, I really think it is a bad idea to
propagate this outside of the uclass.

(same in the _off path).

Thanks,
Miqu=C3=A8l
