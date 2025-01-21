Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB1CC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 08:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DABF801F5;
	Tue, 21 Jan 2025 09:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Je1dyR7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51FEE80326; Tue, 21 Jan 2025 09:34:58 +0100 (CET)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE4EB800CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 09:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8FCA120005;
 Tue, 21 Jan 2025 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1737448495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPfTheKCilTWnv0lbziwa6KviRmDc7dtB1q/vZZ1x2s=;
 b=Je1dyR7fL7PBl8/jrPea+J/NhSg+Jk+nP0f7zVT+fPnRoMd3Y6VVNYPo/i0ktjHfX7GJJx
 n8gp4lRSbuWbbQSxbrH5/PtMTRipOQVlqgK6E07NefSS9hMU7sIumQT24+xcPqgZO/othe
 i5UQIK5EIKbwPz8iG5UzDZO9vLT94+/6T9KxebDolp+11kqXPf1ZftmHMZTCs110DbW4Ul
 qz7pmh/rO4K5ms3jMvnpnvUulv27T4HTT7lDcHG9zLjaoEAiYtN6hT+CCUGNtEvHpyjCnt
 203xg+JDyOa7VBSl8RY6r8XLu0EWy2pk5Hd9zuih38GpusY8Mlu9mBi+t15jWg==
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
In-Reply-To: <CAFLszThX2ULHHA1DOA-essfVJ_Fw=BgsR391iDT=bO+6j=UGwg@mail.gmail.com>
 (Simon Glass's message of "Mon, 20 Jan 2025 12:21:04 -0700")
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-5-d2c0acea6feb@bootlin.com>
 <CAFLszTinomkmj=gaKbX5WBPMsbr_3nxt45sQjXqKJ5q1rxcKwQ@mail.gmail.com>
 <87a5blu630.fsf@bootlin.com>
 <CAFLszThX2ULHHA1DOA-essfVJ_Fw=BgsR391iDT=bO+6j=UGwg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 21 Jan 2025 09:34:54 +0100
Message-ID: <87frlcr2dt.fsf@bootlin.com>
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

Hi Simon,

On 20/01/2025 at 12:21:04 -07, Simon Glass <sjg@chromium.org> wrote:

> Hi Miquel,
>
> On Mon, 20 Jan 2025 at 03:34, Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>>
>> Hello Simon,
>>
>> >>  int power_domain_on(struct power_domain *power_domain)
>> >>  {
>>
>> ...
>>
>> >> +       if (priv->on_count++ > 0)
>> >> +               return 0;
>> >
>> > -EALREADY
>>
>> ...
>>
>> >>  int power_domain_off(struct power_domain *power_domain)
>> >>  {
>>
>> ...
>>
>> >> +       if (priv->on_count-- > 1)
>> >> +               return 0;
>> >
>> > -EBUSY
>> >
>> > See how the regulator uclass does it.
>>
>> I really does not understand why we would like to do that.
>>
>> It is perfectly normal operation to call power_domain_on/off() on the
>> same power domain several times in a row and there is no reason to
>> return an error code. It is quite the opposite, the main reason for
>> power domains is to act like shared regulators. Se while a regulator has
>> one user and doing the same action on it several times does not make
>> much sense and can be reported, that is not how power domains have been
>> thought about in the first place.
>
> I am not aware of any difference between these two subsystems.

Actually you're right on this point, the regulator API works like the
pmdomain one. I had a look: it always returns 0, no matter the state of
the regulator after the operation (as long as there is no error of
course).

> If we
> want a power domain to actually turn off, how many times do we need to
> call power_domain_off()?

We do not? It is why I add refcounting, if a power domain has 2
consumers, each consumer says whether it needs the power domain to be on
or off and the core will handle, but in no case they should force it's
state.

> The function silently does nothing in many
> cases, so it is not deterministic.

It is fully deterministic, as long as consumers call power_on/off
evenly (and this is already what we request in U-Boot).

> In the case where we *actually*
> want to turn the power domain off, we are at a loss as to what code to
> write.
>
>> Hence, I do not agree with returning error codes in these situations,
>> they are misleading and they would have to be ignored anyway.
>>
>
> How about creating a power_domain_off_if_allowed() or
> power_domain_soft_off/on() or power_domain_req_off (for request)?

The power domain logic has a hardware reality in many SoCs but is also a
software concept that is shared with Linux. Changing the semantics in
U-Boot would be very misleading and if my understanding is correct, this
approach would be new.

If you really want a way to track the state of the power domain,
however, I can maybe add a helper returning its state, ie:

         bool power_domain_is_on(domain)

Would that work?

Thanks,
Miqu=C3=A8l
