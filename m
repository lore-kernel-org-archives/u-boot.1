Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D113DC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 13:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57ECF801B0;
	Thu, 23 Jan 2025 14:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="BzjKlGza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F8480214; Thu, 23 Jan 2025 14:52:47 +0100 (CET)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F32980137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 14:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737640363; x=1737899563;
 bh=L4ybhrSw8PuUHGfBR+hJRLTyhz3/9PH3kI3AkSZ8hJA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=BzjKlGza3gd1MYfPWPR5h4eHWsXHaaw4YIoZcvw2UV10BHrp3jWG27RoqIcOiCaHd
 e9mURbGMbnBtAU3fQhT/uA6TQh1v6c5BVFxuXev8FiYQ0qhFH2IyfUAfpp/hJ6moz3
 1lpcF4jwRBt7eP4ube8/U3p+2QG7RlgaANFUDNtnZKeHRQupRisjHjxXUq+KK9xk4v
 vpzt/d700XTbAe+A8FrrMb4sDLAB5fweh9bZ8ou8AXTuPeT7K8dWERYdoJGVqfch3V
 t/YrPVNFiDOKrB78OmYQQhajL9w/w7H53h53Z5TxIb/tDovXNAs2UnpjNAVpfi/4FY
 nPWvfN5xKQn/A==
Date: Thu, 23 Jan 2025 13:52:41 +0000
To: Julien Masson <jmasson@baylibre.com>
From: Sam Day <me@samcday.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Nicolas Belin <nbelin@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Aaron Kling <webgeek1234@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] boot: android: Check kcmdline's for NULL in
 android_image_get_kernel()
Message-ID: <7W0TcVNTD1mHGCFJRS-ktmrUBgG7QLGFKfIhKom4HF7fGW7GFEa3fQRxwo0hrMYhCuxpIOBe4Ae9WN1bqn-BLbg9XekLv3CyzBTSd3E3wcU=@samcday.com>
In-Reply-To: <877c6ld5g7.fsf@baylibre.com>
References: <877c6ld5g7.fsf@baylibre.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 9ef3c09d7ad54779f25d750d1baa862a1366f77c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Thursday, 23 January 2025 at 14:29, Julien Masson <jmasson@baylibre.com>=
 wrote:

>=20
> On Thu 23 Jan 2025 at 14:28, Mattijs Korpershoek mkorpershoek@baylibre.co=
m wrote:
>=20
> > From: Aaron Kling webgeek1234@gmail.com
> >=20
> > kcmdline and kcmdline_extra strings can be NULL. In that case, we still
> > read the content from 0x00000 and pass that to the kernel, which is
> > completely wrong.
> >=20
> > Fix android_image_get_kernel() to check for NULL before checking if
> > they are empty strings.
> >=20
> > Fixes: 53a0ddb6d3be ("boot: android: fix extra command line support")
> > Signed-off-by: Aaron Kling webgeek1234@gmail.com
> > Signed-off-by: Mattijs Korpershoek mkorpershoek@baylibre.com
> > ---
> > Thanks to Aaron for reporting this on the aosp-devs discord and for
> > fixing this.
> > ---
> > boot/image-android.c | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/boot/image-android.c b/boot/image-android.c
> > index 60a422dfb74a6c683b3cf9d2b19b3ad1dbd0d151..fa4e14ca4698e1dea105388=
dd2ea590024cafa58 100644
> > --- a/boot/image-android.c
> > +++ b/boot/image-android.c
> > @@ -337,12 +337,12 @@ int android_image_get_kernel(const void *hdr,
> > if (bootargs)
> > len +=3D strlen(bootargs);
> >=20
> > - if (*img_data.kcmdline) {
> > + if (img_data.kcmdline && img_data.kcmdline) {
> > printf("Kernel command line: %s\n", img_data.kcmdline);
> > len +=3D strlen(img_data.kcmdline) + (len ? 1 : 0); / +1 for extra spac=
e */
> > }
> >=20
> > - if (*img_data.kcmdline_extra) {
> > + if (img_data.kcmdline_extra && img_data.kcmdline_extra) {
> > printf("Kernel extra command line: %s\n", img_data.kcmdline_extra);
> > len +=3D strlen(img_data.kcmdline_extra) + (len ? 1 : 0); / +1 for extr=
a space */
> > }
> > @@ -357,13 +357,13 @@ int android_image_get_kernel(const void *hdr,
> > if (bootargs)
> > strcpy(newbootargs, bootargs);
> >=20
> > - if (*img_data.kcmdline) {
> > + if (img_data.kcmdline && *img_data.kcmdline) {
> > if (newbootargs) / If there is something in newbootargs, a space is nee=
ded */
> > strcat(newbootargs, " ");
> > strcat(newbootargs, img_data.kcmdline);
> > }
> >=20
> > - if (*img_data.kcmdline_extra) {
> > + if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
> > if (newbootargs) / If there is something in newbootargs, a space is nee=
ded */
> > strcat(newbootargs, " ");
> > strcat(newbootargs, img_data.kcmdline_extra);
> >=20
> > ---
> > base-commit: bc157bb6667ed97e33be8ce8436c28baa275b295
> > change-id: 20250113-kcmdline-extra-fix-509331e4d7f3
> >=20
> > Best regards,
> > --
> > Mattijs Korpershoek mkorpershoek@baylibre.com
>=20
>=20
> Reviewed-by: Julien Masson jmasson@baylibre.com

Tested-by: Sam Day <me@samcday.com>

