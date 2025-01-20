Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE06EC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 10:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F9A80077;
	Mon, 20 Jan 2025 11:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WoYteiRa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD2E801CF; Mon, 20 Jan 2025 11:34:31 +0100 (CET)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2CBF80017
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 11:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DDF020008;
 Mon, 20 Jan 2025 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1737369268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LmiI/XaKxikuMSU35UpPUSvxr3hvvk/AA4QAHHGZthE=;
 b=WoYteiRa2uQDNc8IAgBflxZgbZDnpBtvDTt7xTMKYpAGAupDirVOvXVj0jkMBaRAC/vv3Y
 yDy6nz9DWYtupSHSBH3BpWCoSgx/oNOpYqdrwWSVQS97Ll4RkRKi3w6how3S4TzrM4Vapd
 DkWtrsQYdLT1/vGgdP4HKxaJ4DG9huQU09+yPylYCNU5wHs/16/hfZ6Z3ASQVbIgEU+lg/
 4qp+AfUEMikp2vqxruLNr62IHpvv2A/C01ibC+gF1pNOk6aVFl0ZyvnIxdkwiJfmgBFxPU
 MtdWY+W9iZ79IDIXcuXuEet/D9/2WLmLTXDa6D627fhjkAKLPqalh+bJ2P5LuA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,  Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>,  Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,  Fabio Estevm <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>,  Mario Six <mario.six@gdsys.cc>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 05/13] power-domain: Add refcounting
In-Reply-To: <CAFLszTinomkmj=gaKbX5WBPMsbr_3nxt45sQjXqKJ5q1rxcKwQ@mail.gmail.com>
 (Simon Glass's message of "Wed, 15 Jan 2025 06:19:29 -0700")
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-5-d2c0acea6feb@bootlin.com>
 <CAFLszTinomkmj=gaKbX5WBPMsbr_3nxt45sQjXqKJ5q1rxcKwQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 20 Jan 2025 11:34:27 +0100
Message-ID: <87a5blu630.fsf@bootlin.com>
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

>>  int power_domain_on(struct power_domain *power_domain)
>>  {

...

>> +       if (priv->on_count++ > 0)
>> +               return 0;
>
> -EALREADY

...

>>  int power_domain_off(struct power_domain *power_domain)
>>  {

...

>> +       if (priv->on_count-- > 1)
>> +               return 0;
>
> -EBUSY
>
> See how the regulator uclass does it.

I really does not understand why we would like to do that.

It is perfectly normal operation to call power_domain_on/off() on the
same power domain several times in a row and there is no reason to
return an error code. It is quite the opposite, the main reason for
power domains is to act like shared regulators. Se while a regulator has
one user and doing the same action on it several times does not make
much sense and can be reported, that is not how power domains have been
thought about in the first place.

Hence, I do not agree with returning error codes in these situations,
they are misleading and they would have to be ignored anyway.

Thanks,
Miqu=C3=A8l
