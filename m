Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72A5CD4F2F
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 13:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A3B83E3A;
	Thu, 13 Nov 2025 14:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="F/eZmatg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F0A83DA9; Thu, 13 Nov 2025 10:44:43 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99EBE83C62
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 10:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 361561A1A74;
 Thu, 13 Nov 2025 09:44:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0C3D76068C;
 Thu, 13 Nov 2025 09:44:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E4CED102F21A5; Thu, 13 Nov 2025 10:44:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1763027079; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=urz5ZzP+tJ4E3PFh7eu6mohhLOuIOOeiZjHA/Tw0sxc=;
 b=F/eZmatgdDdhUIq5kEeovrIx0Hd/ZDecBEeOXourU93ybAyqywHXUseRQd5+smKAGFMLP7
 0Hp3yLCP68e1kony3pMf/m+oynfrDN+7c1YL9fNMpld8PEaLfIXFdocFB8d3X3G/OilCbD
 llCZL5FlbDwzdPJfib8JWscj1K0hzTUWAOTZERU/x+PAjopQIfVtTpFZtYEngMYZlSS61L
 tAYytkQlF1pkMh1n+pAnNdynEAg/dS50wAlx7mnTpsHU6tS8u/bgkV0bFBAIWnh7ryXjYr
 Jl+p7q/XgX80GbB/FqyumCepJaNN8q44Fh3/ipiq5Q7rYWEXnQZYsFbFVsMrSQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: "Raghavendra, Vignesh" <vigneshr@ti.com>,  Jagan Teki
 <jagan@amarulasolutions.com>,  Tom Rini <trini@konsulko.com>,  Steam Lin
 <stlin2@winbond.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] mtd: spi-nor: winbond: Make sure w25q{01,02}jv behave
 correctly
In-Reply-To: <CAOf5uwk5gHPkhF1emwpUyp8aDYXhsO-6JQ_x1gicEK4kkajiiw@mail.gmail.com>
 (Michael Nazzareno Trimarchi's message of "Wed, 10 Sep 2025 07:28:22
 +0200")
References: <20250702092313.970234-1-miquel.raynal@bootlin.com>
 <87a534exwc.fsf@bootlin.com>
 <CAMty3ZDG=MtRbzNPaRs=dz9AUkcTA5cHX+0=wgqyEbMqPhyxrQ@mail.gmail.com>
 <0efa621a-6cc5-4c1b-a5c9-9ab86f84692f@ti.com>
 <CAOf5uwk5gHPkhF1emwpUyp8aDYXhsO-6JQ_x1gicEK4kkajiiw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 13 Nov 2025 10:44:36 +0100
Message-ID: <87bjl6gtbv.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Fuzzy: 9299dda3c33891dfa44c1ad75bc5b09508782e39bae4a2e1fd99eb354a45618e54d43865ca2b915174e8b1f71dda412dc3a9d349748cf0db987cb526a54f69b8
X-Mailman-Approved-At: Thu, 13 Nov 2025 14:16:58 +0100
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

Hi Michael,

On 10/09/2025 at 07:28:22 +02, Michael Nazzareno Trimarchi <michael@amarula=
solutions.com> wrote:

> Hi all
>
> On Tue, Sep 9, 2025 at 7:08=E2=80=AFPM Raghavendra, Vignesh <vigneshr@ti.=
com> wrote:
>>
>>
>>
>> On 9/9/2025 5:37 PM, Jagan Teki wrote:
>> > On Tue, Sep 9, 2025 at 3:43=E2=80=AFPM Miquel Raynal <miquel.raynal@bo=
otlin.com> wrote:
>> >>
>> >> Hello,
>> >>
>> >> On 02/07/2025 at 11:23:13 +02, Miquel Raynal <miquel.raynal@bootlin.c=
om> wrote:
>> >>
>> >>> These chips are internally made of two/four dies with linear address=
ing
>> >>> capabilities to make it transparent to the user that two/four dies w=
ere
>> >>> used. There is one drawback however, the read status operation is ra=
cy
>> >>> as the status bit only gives the active die status and not the statu=
s of
>> >>> the other die. For commands affecting the two dies, it means if anot=
her
>> >>> command is sent too fast after the first die has returned a valid
>> >>> status (deviation can be up to 200us), the chip will get corrupted/i=
n an
>> >>> unstable state.
>> >>>
>> >>> The solution adopted here is to iterate manually over all internal
>> >>> dies (which takes about 30us per die) until all are ready. This appr=
oach
>> >>> will always be faster than a blind delay which represents the maximum
>> >>> deviation, while also being totally safe.
>> >>>
>> >>> A flash-specific hook for the status register read had to be
>> >>> implemented. Testing with the flash_speed benchmark in Linux shown no
>> >>> difference with the existing performances (using the regular status =
read
>> >>> core function).
>> >>>
>> >>> As the presence of multiple dies is not filled in these chips SFDP
>> >>> tables (the table containing the crucial information is optional), we
>> >>> need to manually wire the hook.
>> >>>
>> >>> This change is adapted from Linux.
>> >>>
>> >>> Link: https://lore.kernel.org/all/20250110-winbond-6-12-rc1-nor-vola=
tile-bit-v3-1-735363f8cc7d@bootlin.com/
>> >>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> >>
>> >> Same question for this one, no feedback for the past 2 months, I'm not
>> >> sure who's supposed to take these, Jagan and Vignesh you are marked M:
>> >> in maintainers, any chances this can get it?
>> >
>> > Unfortunately, I was off quite some-time. Need little bit of time.
>> > Vighnesh is off for years.
>>
>> Thats not true. I dont have access to U-Boot SPI trees. So patches have
>> been flowing through individual "platfor/SoC" maintainers trees
>> unfortunately. Tom picks the patches from TI contributors once
>> me/Nishanth Acks where as AMD/Xlinix bits have been picked up by Michal
>> Simek and so on...
>>
>> Happy to help out if you help to manage a merge window every now and
>> then or just review things. Most of the SPI NOR/NAND follow from linux
>> where its reviewed by set of maintainers and tested (example this one is
>> tested on TI board).
>
> I will go through the patches over the weekend and review them. I will
> prepare a branch
> spi-nor-next and try to ask to test from there
>
> Michael
>
>>
>> > In the meantime, Michael will help in
>> > review but need help on testing.
>> >
>> > Thanks,
>> > Jagan.
>>

I still do not see these patches in any upstream tree. Am I missing
something? If I may, these patches have been reviewed during the Linux
contribution process already, and submission happened in July, almost 5
months ago.

Thanks,
Miqu=C3=A8l
