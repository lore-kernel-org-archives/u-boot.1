Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80D8CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 08:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1611B8488B;
	Tue,  2 Jun 2026 10:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XbFmxA43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69188848A9; Tue,  2 Jun 2026 08:36:24 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D8B184884
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 08:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=p7rhYQcpnHXE6XGQS1+oCGabX87SqjgfjwrhkoYj1a8=; b=XbFmxA439WDW/aOdAyNMUp7VDB
 9usfMv0ZcKTEd48iIvbVaVx9HsDDl6mlLYgzU2A9fisBnZWYVlSNbaOFY1QjhYbhlJxQOHwIQCCBu
 lcS00+ARMLjyv32yLwkC0qoJk98uQZNuHPnPjum9ZChNba7v9SQlMN7FpxSqZZN252UA8zQ6K7JXq
 FTO8Qbo0Fvdd4VeS5YequRL88oRRxn1Fl8aDOwXWUkouVO3ar6fauQzHw0WZA6nrM8B1RqnzIRxiF
 eQTxnulvnJ9GlGpacIbwLCnPsEyd4dqfoDMi5fGuZyhKSwknWe1L67w1kXMoGs0hiyr/E7rtqsYpF
 KLMe5Y2Q==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wUIjd-000NKv-2U; Tue, 02 Jun 2026 08:36:21 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wUIjc-0006vW-2Z; Tue, 02 Jun 2026 08:36:21 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] fdt: fix condition for devicetree from bloblist
Date: Tue, 02 Jun 2026 08:36:20 +0200
Message-ID: <13995287.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260601161513.GK627328@bill-the-cat>
References: <20260601082632.238595-1-alexander.stein@ew.tq-group.com>
 <20260601161513.GK627328@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Mailman-Approved-At: Tue, 02 Jun 2026 10:00:24 +0200
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

Hi Tom,

Am Montag, 1. Juni 2026, 18:15:13 CEST schrieb Tom Rini:
> On Mon, Jun 01, 2026 at 10:26:30AM +0200, Alexander Stein wrote:
>=20
> > On boards without TPL, but SPL enabled, xpl_prev_phase() will return ne=
ver
> > return PHASE_TPL. This the condition is always true. This is a problem
> > for system which use an SDRAM bloblist location and initialize the SDRAM
> > in SPL. Adjust the condition to take this config into account.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > There is also another possibility for the check. I'm not sure which one
> > is better or preferred.
> >=20
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1829,7 +1829,7 @@ int fdtdec_setup(void)
> >          * not whether this phase creates one.
> >          */
> >         if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > -           (xpl_prev_phase() !=3D PHASE_TPL ||
> > +           (xpl_prev_phase() !=3D PHASE_TPL &&
> >              IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> >                 ret =3D bloblist_maybe_init();
> >                 if (!ret) {
> >=20
> >  lib/fdtdec.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index c67b6e8c133..3f31f9c2aeb 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1829,8 +1829,8 @@ int fdtdec_setup(void)
> >  	 * not whether this phase creates one.
> >  	 */
> >  	if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > -	    (xpl_prev_phase() !=3D PHASE_TPL ||
> > -	     IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > +	    !xpl_is_first_phase() &&
> > +	    (IS_ENABLED(CONFIG_TPL_BLOBLIST) || IS_ENABLED(CONFIG_SPL_BLOBLIS=
T))) {
> >  		ret =3D bloblist_maybe_init();
> >  		if (!ret) {
> >  			gd->fdt_blob =3D bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
>=20
> Can you please test the series at
> https://patchwork.ozlabs.org/project/uboot/cover/20260519162225.770071-1-=
trini@konsulko.com/
> and see if your problem is fixed there too? Thanks.

Indeed. This fixes my problem as well.

Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


