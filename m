Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EAFC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 13:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B9B48796A;
	Thu, 18 Jan 2024 14:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1343F87B53; Thu, 18 Jan 2024 14:58:00 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8F3B786DC3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 14:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D48891042;
 Thu, 18 Jan 2024 05:58:42 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F01F3F73F;
 Thu, 18 Jan 2024 05:57:55 -0800 (PST)
Date: Thu, 18 Jan 2024 13:57:53 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Cc: <j@jannau.net>, Anatolij Gustschin <agust@denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC 2/6] video: console: Parse UTF-8 character sequences
Message-ID: <20240118135753.35a6c819@donnerap.manchester.arm.com>
In-Reply-To: <20240117-vidconsole-utf8-uefi-v1-2-539f7ce74fb9@jannau.net>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
 <20240117-vidconsole-utf8-uefi-v1-2-539f7ce74fb9@jannau.net>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 17 Jan 2024 23:24:28 +0100
Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org> wrote:

Hi,

> From: Janne Grunau <j@jannau.net>
>=20
> efi_console / UEFI applications (grub2, sd-boot, ...) pass UTF-8
> character sequences to vidconsole which results in wrong glyphs for code
> points outside of ASCII. The truetype console expects Unicode code
> points and bitmap font based consoles expect code page 437 code points.
> To support both convert UTF-8 to UTF-32 and pass Unicode code points in
> vidconsole_ops.putc_xy(). These can be used directly in console_truetype
> and after conversion to code page 437 in console_{normal,rotate}.
>=20
> This fixes rendering of international, symbol and box drawing characters
> used by UEFI applications.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/video/console_normal.c      |  6 ++++--
>  drivers/video/console_rotate.c      | 16 ++++++++++------
>  drivers/video/console_truetype.c    |  8 ++++----
>  drivers/video/vidconsole-uclass.c   | 18 +++++++++++++-----
>  drivers/video/vidconsole_internal.h | 15 +++++++++++++++
>  include/video_console.h             | 10 ++++++----
>  6 files changed, 52 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/video/console_normal.c b/drivers/video/console_norma=
l.c
> index a0231293f3..34ef5a5229 100644
> --- a/drivers/video/console_normal.c
> +++ b/drivers/video/console_normal.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <common.h>
> +#include <charset.h>
>  #include <dm.h>
>  #include <video.h>
>  #include <video_console.h>
> @@ -63,7 +64,7 @@ static int console_move_rows(struct udevice *dev, uint =
rowdst,
>  	return 0;
>  }
> =20
> -static int console_putc_xy(struct udevice *dev, uint x_frac, uint y, cha=
r ch)
> +static int console_putc_xy(struct udevice *dev, uint x_frac, uint y, int=
 cp)
>  {
>  	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>  	struct udevice *vid =3D dev->parent;
> @@ -73,8 +74,9 @@ static int console_putc_xy(struct udevice *dev, uint x_=
frac, uint y, char ch)
>  	int pbytes =3D VNBYTES(vid_priv->bpix);
>  	int x, linenum, ret;
>  	void *start, *line;
> +	u8 ch =3D console_utf_to_cp437(cp);
>  	uchar *pfont =3D fontdata->video_fontdata +
> -			(u8)ch * fontdata->char_pixel_bytes;
> +			ch * fontdata->char_pixel_bytes;
> =20
>  	if (x_frac + VID_TO_POS(vc_priv->x_charsize) > vc_priv->xsize_frac)
>  		return -EAGAIN;
> diff --git a/drivers/video/console_rotate.c b/drivers/video/console_rotat=
e.c
> index 65358a1c6e..e4303dfb36 100644
> --- a/drivers/video/console_rotate.c
> +++ b/drivers/video/console_rotate.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <common.h>
> +#include <charset.h>
>  #include <dm.h>
>  #include <video.h>
>  #include <video_console.h>
> @@ -67,7 +68,7 @@ static int console_move_rows_1(struct udevice *dev, uin=
t rowdst, uint rowsrc,
>  	return 0;
>  }
> =20
> -static int console_putc_xy_1(struct udevice *dev, uint x_frac, uint y, c=
har ch)
> +static int console_putc_xy_1(struct udevice *dev, uint x_frac, uint y, i=
nt cp)
>  {
>  	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>  	struct udevice *vid =3D dev->parent;
> @@ -77,8 +78,9 @@ static int console_putc_xy_1(struct udevice *dev, uint =
x_frac, uint y, char ch)
>  	int pbytes =3D VNBYTES(vid_priv->bpix);
>  	int x, linenum, ret;
>  	void *start, *line;
> +	u8 ch =3D console_utf_to_cp437(cp);
>  	uchar *pfont =3D fontdata->video_fontdata +
> -			(u8)ch * fontdata->char_pixel_bytes;
> +			ch * fontdata->char_pixel_bytes;
> =20
>  	if (x_frac + VID_TO_POS(vc_priv->x_charsize) > vc_priv->xsize_frac)
>  		return -EAGAIN;
> @@ -145,7 +147,7 @@ static int console_move_rows_2(struct udevice *dev, u=
int rowdst, uint rowsrc,
>  	return 0;
>  }
> =20
> -static int console_putc_xy_2(struct udevice *dev, uint x_frac, uint y, c=
har ch)
> +static int console_putc_xy_2(struct udevice *dev, uint x_frac, uint y, i=
nt cp)
>  {
>  	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>  	struct udevice *vid =3D dev->parent;
> @@ -155,8 +157,9 @@ static int console_putc_xy_2(struct udevice *dev, uin=
t x_frac, uint y, char ch)
>  	int pbytes =3D VNBYTES(vid_priv->bpix);
>  	int linenum, x, ret;
>  	void *start, *line;
> +	u8 ch =3D console_utf_to_cp437(cp);
>  	uchar *pfont =3D fontdata->video_fontdata +
> -			(u8)ch * fontdata->char_pixel_bytes;
> +			ch * fontdata->char_pixel_bytes;
> =20
>  	if (x_frac + VID_TO_POS(vc_priv->x_charsize) > vc_priv->xsize_frac)
>  		return -EAGAIN;
> @@ -227,7 +230,7 @@ static int console_move_rows_3(struct udevice *dev, u=
int rowdst, uint rowsrc,
>  	return 0;
>  }
> =20
> -static int console_putc_xy_3(struct udevice *dev, uint x_frac, uint y, c=
har ch)
> +static int console_putc_xy_3(struct udevice *dev, uint x_frac, uint y, i=
nt cp)
>  {
>  	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>  	struct udevice *vid =3D dev->parent;
> @@ -237,8 +240,9 @@ static int console_putc_xy_3(struct udevice *dev, uin=
t x_frac, uint y, char ch)
>  	int pbytes =3D VNBYTES(vid_priv->bpix);
>  	int linenum, x, ret;
>  	void *start, *line;
> +	u8 ch =3D console_utf_to_cp437(cp);
>  	uchar *pfont =3D fontdata->video_fontdata +
> -			(u8)ch * fontdata->char_pixel_bytes;
> +			ch * fontdata->char_pixel_bytes;
> =20
>  	if (x_frac + VID_TO_POS(vc_priv->x_charsize) > vc_priv->xsize_frac)
>  		return -EAGAIN;
> diff --git a/drivers/video/console_truetype.c b/drivers/video/console_tru=
etype.c
> index 14fb81e956..bc3ec1c31f 100644
> --- a/drivers/video/console_truetype.c
> +++ b/drivers/video/console_truetype.c
> @@ -262,7 +262,7 @@ static int console_truetype_move_rows(struct udevice =
*dev, uint rowdst,
>  }
> =20
>  static int console_truetype_putc_xy(struct udevice *dev, uint x, uint y,
> -				    char ch)
> +				    int cp)
>  {
>  	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>  	struct udevice *vid =3D dev->parent;
> @@ -281,7 +281,7 @@ static int console_truetype_putc_xy(struct udevice *d=
ev, uint x, uint y,
>  	int row, ret;
> =20
>  	/* First get some basic metrics about this character */
> -	stbtt_GetCodepointHMetrics(font, ch, &advance, &lsb);
> +	stbtt_GetCodepointHMetrics(font, cp, &advance, &lsb);
> =20
>  	/*
>  	 * First out our current X position in fractional pixels. If we wrote
> @@ -290,7 +290,7 @@ static int console_truetype_putc_xy(struct udevice *d=
ev, uint x, uint y,
>  	xpos =3D frac(VID_TO_PIXEL((double)x));
>  	if (vc_priv->last_ch) {
>  		xpos +=3D met->scale * stbtt_GetCodepointKernAdvance(font,
> -							vc_priv->last_ch, ch);
> +							vc_priv->last_ch, cp);
>  	}
> =20
>  	/*
> @@ -320,7 +320,7 @@ static int console_truetype_putc_xy(struct udevice *d=
ev, uint x, uint y,
>  	 * return NULL;
>  	 */
>  	data =3D stbtt_GetCodepointBitmapSubpixel(font, met->scale, met->scale,
> -						x_shift, 0, ch, &width, &height,
> +						x_shift, 0, cp, &width, &height,
>  						&xoff, &yoff);
>  	if (!data)
>  		return width_frac;
> diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole=
-uclass.c
> index 22d55df71f..ce1668b97b 100644
> --- a/drivers/video/vidconsole-uclass.c
> +++ b/drivers/video/vidconsole-uclass.c
> @@ -11,6 +11,7 @@
> =20
>  #include <common.h>
>  #include <abuf.h>
> +#include <charset.h>
>  #include <command.h>
>  #include <console.h>
>  #include <log.h>
> @@ -20,7 +21,7 @@
>  #include <video_font.h>		/* Bitmap font for code page 437 */
>  #include <linux/ctype.h>
> =20
> -int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, char ch)
> +int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, int ch)
>  {
>  	struct vidconsole_ops *ops =3D vidconsole_get_ops(dev);
> =20
> @@ -426,8 +427,8 @@ error:
>  	priv->escape =3D 0;
>  }
> =20
> -/* Put that actual character on the screen (using the CP437 code page). =
*/
> -static int vidconsole_output_glyph(struct udevice *dev, char ch)
> +/* Put that actual character on the screen (using the UTF-32 code points=
). */
> +static int vidconsole_output_glyph(struct udevice *dev, int ch)
>  {
>  	struct vidconsole_priv *priv =3D dev_get_uclass_priv(dev);
>  	int ret;
> @@ -455,7 +456,7 @@ static int vidconsole_output_glyph(struct udevice *de=
v, char ch)
>  int vidconsole_put_char(struct udevice *dev, char ch)

This looks like a weird interface, to stuff in 8-bit bytes really,
rather than the promised characters, and have some kind of internal state
here. I am wondering if we should make this function static? There is only
one real user (in board/atmel/common/video_display.c), that looks like it
could use vidconsole_put_string(). Plus the tests, but we could fix them
as well.
Or we make this function also take a UTF-32?

Shouldn't hold back this series, but just stumbled upon it, and
was curious what other people think.

>  {
>  	struct vidconsole_priv *priv =3D dev_get_uclass_priv(dev);
> -	int ret;
> +	int cp, ret;
> =20
>  	if (priv->escape) {
>  		vidconsole_escape_char(dev, ch);
> @@ -489,7 +490,14 @@ int vidconsole_put_char(struct udevice *dev, char ch)
>  		priv->last_ch =3D 0;
>  		break;
>  	default:
> -		ret =3D vidconsole_output_glyph(dev, ch);
> +		if (CONFIG_EFI_LOADER) {

This would need to be:
	if (IS_ENABLED(CONFIG_EFI_LOADER)) {
Otherwise disabling EFI_LOADER breaks compilation, since
CONFIG_EFI_LOADER will not be defined at all:

drivers/video/vidconsole-uclass.c: In function =E2=80=98vidconsole_put_char=
=E2=80=99:
drivers/video/vidconsole-uclass.c:493:7: error: =E2=80=98CONFIG_EFI_LOADER=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98CO=
NFIG_ENV_ADDR=E2=80=99?

But more general, is this really a compile time check? Without EFI
applications, do we only expect 7-bit ASCII, or CP437 explicitly? It's
only U-Boot generated output then, right?

> +			cp =3D utf8_to_utf32_stream(ch, priv->utf8_buf);
> +			if (cp =3D=3D 0)
> +				return 0;
> +		} else {
> +			cp =3D ch;
> +		}
> +		ret =3D vidconsole_output_glyph(dev, cp);
>  		if (ret < 0)
>  			return ret;
>  		break;
> diff --git a/drivers/video/vidconsole_internal.h b/drivers/video/vidconso=
le_internal.h
> index 0ec581b266..3d19410a52 100644
> --- a/drivers/video/vidconsole_internal.h
> +++ b/drivers/video/vidconsole_internal.h
> @@ -6,6 +6,9 @@
>   * (C) Copyright 2023 Dzmitry Sankouski <dsankouski@gmail.com>
>   */
> =20
> +#include <charset.h>
> +#include <config.h>
> +
>  #define FLIPPED_DIRECTION 1
>  #define NORMAL_DIRECTION 0
> =20
> @@ -142,3 +145,15 @@ int console_simple_get_font(struct udevice *dev, int=
 seq, struct vidfont_info *i
>   * See details in video_console.h select_font function
>   **/
>  int console_simple_select_font(struct udevice *dev, const char *name, ui=
nt size);
> +
> +/**
> + *
> + */
> +static inline u8 console_utf_to_cp437(int codepoint)
> +{
> +	if (CONFIG_EFI_LOADER) {

Same IS_ENABLED() usage required here.

Cheers,
Andre.

> +		utf_to_cp(&codepoint, codepage_437);
> +		return (u8)codepoint;
> +	}
> +	return (u8)codepoint;
> +}
> diff --git a/include/video_console.h b/include/video_console.h
> index bde67fa9a5..20cf2d0101 100644
> --- a/include/video_console.h
> +++ b/include/video_console.h
> @@ -43,6 +43,7 @@ enum {
>   * @col_saved:		Saved X position, in fractional units (VID_TO_POS(x))
>   * @row_saved:		Saved Y position in pixels (0=3Dtop)
>   * @escape_buf:		Buffer to accumulate escape sequence
> + * @utf8_buf:		Buffer to accumulate UTF-8 byte sequence
>   */
>  struct vidconsole_priv {
>  	struct stdio_dev sdev;
> @@ -66,6 +67,7 @@ struct vidconsole_priv {
>  	int row_saved;
>  	int col_saved;
>  	char escape_buf[32];
> +	char utf8_buf[8];
>  };
> =20
>  /**
> @@ -124,12 +126,12 @@ struct vidconsole_ops {
>  	 * @x_frac:	Fractional pixel X position (0=3Dleft-most pixel) which
>  	 *		is the X position multipled by VID_FRAC_DIV.
>  	 * @y:		Pixel Y position (0=3Dtop-most pixel)
> -	 * @ch:		Character to write
> +	 * @cp:	EF	UTF-32 code point to write
>  	 * @return number of fractional pixels that the cursor should move,
>  	 * if all is OK, -EAGAIN if we ran out of space on this line, other -ve
>  	 * on error
>  	 */
> -	int (*putc_xy)(struct udevice *dev, uint x_frac, uint y, char ch);
> +	int (*putc_xy)(struct udevice *dev, uint x_frac, uint y, int cp);
> =20
>  	/**
>  	 * move_rows() - Move text rows from one place to another
> @@ -403,12 +405,12 @@ void vidconsole_pop_colour(struct udevice *dev, str=
uct vidconsole_colour *old);
>   * @x_frac:	Fractional pixel X position (0=3Dleft-most pixel) which
>   *		is the X position multipled by VID_FRAC_DIV.
>   * @y:		Pixel Y position (0=3Dtop-most pixel)
> - * @ch:		Character to write
> + * @cp:		UTF-32 code point to write
>   * Return: number of fractional pixels that the cursor should move,
>   * if all is OK, -EAGAIN if we ran out of space on this line, other -ve
>   * on error
>   */
> -int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, char ch);
> +int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, int cp);
> =20
>  /**
>   * vidconsole_move_rows() - Move text rows from one place to another
>=20

