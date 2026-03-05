Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C621EEF319
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 08:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1EC383F7F;
	Thu,  5 Mar 2026 09:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D0783F93; Thu,  5 Mar 2026 09:32:45 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E227F83F2E
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 09:32:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sha@pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1vy48P-0003C9-OG; Thu, 05 Mar 2026 09:32:41 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <sha@pengutronix.de>) id 1vy48N-003qqp-34;
 Thu, 05 Mar 2026 09:32:41 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
 (envelope-from <sha@pengutronix.de>) id 1vy48P-00000002Enn-0qpP;
 Thu, 05 Mar 2026 09:32:41 +0100
Date: Thu, 5 Mar 2026 09:32:41 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
Message-ID: <aak_qRpFr9PsgyFR@pengutronix.de>
References: <20260302220937.3682128-1-trini@konsulko.com>
 <aaff4oDKlkINa8H7@pengutronix.de>
 <ff92c314-b0fb-48ae-acf1-195ecb3163e7@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff92c314-b0fb-48ae-acf1-195ecb3163e7@cherry.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
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

On Wed, Mar 04, 2026 at 05:33:36PM +0100, Quentin Schulz wrote:
> Hi Sascha,
> 
> On 3/4/26 8:31 AM, Sascha Hauer wrote:
> > Hi Tom,
> > 
> > On Mon, Mar 02, 2026 at 04:09:37PM -0600, Tom Rini wrote:
> > > There is a flaw in how U-Boot verifies and generates signatures for FIT
> > > images. To prevent mix and match style attacks, it is recommended to
> > > use signed configurations. How this is supposed to work is documented in
> > > doc/usage/fit/signature.rst.
> > > 
> > > Crucially, the `hashed-nodes` property of the `signature` node contains
> > > which nodes of the FIT device tree were hashed as part of the signature
> > > and should be verified. However, this property itself is not part of the
> > > hash and can therefore be modified by an attacker. Furthermore, the
> > > signature only contains the name of each node and not the path in the
> > > device tree to the node.
> > > 
> > > This patch reworks the code to address this specific oversight.
> > 
> > As this breaks compatibility between old U-Boot and new FIT images and
> > the other way round it would be good to introduce a version field to FIT
> > images. With that at least newer U-Boot versions could print a more
> 
> How do we decide when to bump this version?

Bump it on incompatible changes.

> 
> > meaningful error message than just "image verification failed" which
> > gives no clue what had actually happened.
> > 
> 
> Here, only signed FIT images with required = conf actually won't work as far
> as I understood, the rest will work as usual. So we would need to keep track
> of which version(s) of the FIT are supported by which part(s) of the code,
> or error out saying it is not supported as soon as it is parsed but it
> actually is supported, making incompatibility wider for no reason?
> 
> Not saying it's a bad idea, just that it's not as simple as putting a
> version field in there. Also, I'm assuming this would need to be part of the
> FIT spec. And I'm wondering if this isn't rather a shortcoming of U-Boot
> implementation for FIT signature verification rather than an issue with the
> spec, so why should the spec bump the version if an implementer got it
> wrong?

In this case it looked like the spec itself had shortcomings. Anyway,
with Simons suggestion of not using the hashed-nodes property things
look differently now.

My suggestion wasn't meant to imply that you should broadly reject non
matching versions, there's no reason to reject any unsigned FIT images
when only the signature has changed. A version field would just give you
the possibility to detect incompatibilities before running into errors.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
