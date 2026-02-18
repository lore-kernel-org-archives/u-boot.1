Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667C7E9A047
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 13:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A763F83AA9;
	Wed, 18 Feb 2026 14:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QydiW6AW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2660883B99; Wed, 18 Feb 2026 10:23:34 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08CAF83A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 10:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5B6D6C1D73B;
 Wed, 18 Feb 2026 09:23:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7C65860738;
 Wed, 18 Feb 2026 09:23:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B450610368B1A; Wed, 18 Feb 2026 10:23:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771406610; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=EgG+Lv4F/4sc2NE6fHEWVdLpAjMVkBDsRB0j10a5Zgg=;
 b=QydiW6AWlFH4a3dle+fvW2/vL6a7T965y4ed+kia4lyLNvhZRByNkRFmsAP4Ee6Zo5ZESA
 qcuPfwxt32K6ugY4S4T0lpweEmSL1clV3jSbLT126ij0Esi9ViUevaxEe6n6qu1SEzh8MI
 sl6sFd0lZ4QtL/mXrskuwZNbytT8KUTR/edJHb0UO+WO7UEn9z/2PoDaD4i2Ld3y+62tpU
 5EYQo/zik9dvR71eKh3dLFwtEopLqlx44EOmeewKjtFM6Tbri1e3UiQbjNjjXYii3k6dVn
 bfgqTBqdsz2B7hqkXjMUBmoxYxHQk98TvgL0rJveXh1OfocY7tSnz5iVcS7OcQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Michael Walle <mwalle@kernel.org>,  Conor Dooley <conor@kernel.org>,
 u-boot@lists.denx.de,  Tudor Ambarus <tudor.ambarus@linaro.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,  Hiroyuki Saito
 <Hiroyuki.Saito2@infineon.com>,  Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>,  Prasanth Babu Mantena <p-mantena@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,  Prasad Kummari
 <prasad.kummari@amd.com>
Subject: Re: [RFH] SPI and SPI-NOR patch help
In-Reply-To: <20260216153110.GV2747538@bill-the-cat> (Tom Rini's message of
 "Mon, 16 Feb 2026 09:31:10 -0600")
References: <20260213164607.GI2747538@bill-the-cat>
 <20260214-sternness-cling-4259916a8f73@spud>
 <DGG8OA1O1UEL.12RR559TX4XX6@kernel.org>
 <20260216153110.GV2747538@bill-the-cat>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 18 Feb 2026 10:23:28 +0100
Message-ID: <87bjhmv20f.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 18 Feb 2026 14:32:16 +0100
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

Hello Tom,

On 16/02/2026 at 09:31:10 -06, Tom Rini <trini@konsulko.com> wrote:

> On Mon, Feb 16, 2026 at 09:21:55AM +0100, Michael Walle wrote:
>> On Sat Feb 14, 2026 at 7:58 PM CET, Conor Dooley wrote:
>> > On Fri, Feb 13, 2026 at 10:46:07AM -0600, Tom Rini wrote:
>> >> Hey all,
>> >>=20
>> >> To be blunt, U-Boot needs help with reviewing and maintaining the SPI
>> >> and SPI-NOR subsystems. We haven't had someone with time to actively
>> >> work in this area for some time. I'm going through the outstanding
>> >> changes now, but it also seems a common problem is that with respect =
to
>> >> device IDs, most of the new ones also aren't in the upstream Linux
>> >> Kernel. Is there some better and generic solution we're missing so th=
at
>> >> we don't have large and often growing device ID tables? I'd rather not
>> >> make that problem worse, so I've rejected two of those types of updat=
es
>> >> today and I'm just setting aside a large number of others.
>> >
>> > Dunno if your timing was cursed on sending this, but Tudor submitted h=
is
>> > resignation from spi-nor maintainership in the kernel about 10 mins
>> > after.
>> > I think Michael Walle might be responsible for what you're talking abo=
ut
>> > here, with his 773bbe1044973 ("mtd: spi-nor: add generic flash driver"=
),
>> > but idk jack about spi-nor stuff.
>>=20
>> Yeah. Nowadays SPI-NOR flashes come with self describing tables,
>> which are already supported by u-boot, I think. The only change that
>> seems to be missing is the fallback to it if an id isn't found in
>> the flashdb. Only thing is, the SFDP doesn't describe all features,
>> most prominent example being locking. So if you need that, you'll
>> still need to have an entry per flash.
>>=20
>> In fact, in linux I'm planning to change to make it probe SFDP first
>> and then amend it with the flashdb information (if there is an
>> entry).
>
> Thanks for explaining. So in that U-Boot does have SFDP support, the
> first thing is platforms should likely be enabling that instead of just
> adding IDs, at least for basic support.

Yes. There will be the need for IDs anyways, for those "extra" "non
sfdp" features, but that should reduce the load. For example, shall we
consider block protection in U-Boot or not? This is a useful feature,
but at the same time, do we really need it in a Bootloader? This is open
to discussion.

> It still leaves us in a bad spot
> about having SPI and SPI-NOR stuff reviewed and maintained, but at least
> it's clearer in public now where it stands.

I guess spi-mem and SPI NAND is also in this kind of situation, even
with the Amarula crew doing what they can to improve the situation.

Thanks,
Miqu=C3=A8l
