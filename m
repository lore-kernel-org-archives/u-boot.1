Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D008BC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 12:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02468388E;
	Thu, 24 Jul 2025 14:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E958B83890; Thu, 24 Jul 2025 14:34:11 +0200 (CEST)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E0483885
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1uev9E-00017Y-LD; Thu, 24 Jul 2025 14:34:08 +0200
Message-ID: <64cccc0b-e57c-4d78-8f7c-1ae5fb92b6b4@pengutronix.de>
Date: Thu, 24 Jul 2025 14:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [RFC] Plan to Migrate U-Boot from OpenSSL Engines to Providers
To: Enric Balletbo i Serra <eballetbo@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eddie Kovsky <ekovsky@redhat.com>, Loic Poulain
 <loic.poulain@linaro.org>, Tobias Olausson <tobias@eub.se>
References: <CALE0LRuihERtJ-ghH9OXnFz8Y+JV28g5=nSmnw_LdboWV60=aQ@mail.gmail.com>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <CALE0LRuihERtJ-ghH9OXnFz8Y+JV28g5=nSmnw_LdboWV60=aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

Hello,

On 7/22/25 17:48, Enric Balletbo i Serra wrote:
> * Introduce a new config option OPENSSL_NO_DEPRECATED.
> This option will allow building U-Boot without any ENGINE support.
> When enabled, hardware-backed signing (PKCS#11, etc.) will not be
> available, but U-Boot will be buildable on distributions that have
> removed ENGINE support from OpenSSL.

Gating the deprecated openssl engine support behind a config option is a
good first step.

> * Add support for OpenSSL Providers

[snip]

> Arguments for this change:

Fully in agreement.

> Impact:
>
> Users who require hardware-backed signing will need to ensure their
> provider (e.g., PKCS#11 provider) is available and configured.
>
> The transition will be gradual: ENGINE support can be kept as an
> option for a while, but the default and recommended path will be
> providers.

That would be my preference as well.

> Questions for the community:
>
> * Do we need to maintain ENGINE compatibility for a transition period,
> or can we remove ENGINE support entirely and move fully to providers?

I am afraid this might complicate things a lot downstream. For Debian,
the pkcs11-provider package is still in testing. Even once it hits
stable, it will take a while for it to be available generally. IMO we
will have to keep ENGINE support around for quite a while still.

> * Are there users or workflows that still depend on ENGINE-based
> hardware signing that cannot be migrated to providers?

A lot of stuff still use ENGINEs, but having mkimage support PROVIDERs
as well is a first step in migrating them. With mkimage supporting both,
users can gradually migrate.

> Next Steps:
>
> * Add the OPENSSL_NO_DEPRECATED config and update documentation.
> * Begin refactoring the signing code to use providers by default.

I think it might be better to explicitly point out OpenSSL engines in
the option name. Maybe CONFIG_OPENSSL_ENGINE?

> Note that we feel comfortable with adding the OPENSSL_NO_DEPRECATED
> config option and can proceed with that change. However, we are not
> very familiar with the details of migrating from OpenSSL Engines to
> Providers. Any help, guidance, or code contributions from community
> members experienced with the OpenSSL provider API would be greatly
> appreciated.

I added PKCS#11 support via providers to qpid-proton last year. Because
this was new to me, I added support via ENGINEs first, then switched to
PROVIDER and then squashed the end result.

You may find my patch doing the switch from ENGINE to PROVIDER useful:
https://github.com/a3f/qpid-proton/commit/a14fa72c67f47f152d2

And here's the final change:
https://github.com/apache/qpid-proton/commit/96cbea1052a2196d

Feel free to shoot me a mail if you have questions about them.

> Please let us know your thoughts, concerns, or if you are interested
> in helping or you are already working with this migration.

I am happy to assist with reviewing the patches if you Cc me on them.

Cheers and thanks for picking up the work!

Ahmad

>
> Best regards,
>
>   Eddie and Enric
>

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


