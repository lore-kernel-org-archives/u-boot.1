Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EC2C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 12:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27C487BC3;
	Mon, 12 Feb 2024 13:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZDR0vs4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 749DC87EB6; Mon, 12 Feb 2024 13:12:07 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F945879F2
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 13:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707739921; x=1708344721; i=xypron.glpk@gmx.de;
 bh=R/YdeUxC2meAQAwiXDRl3AoRkbEZqL5+1KW7TFCu768=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ZDR0vs4nc+cxK92fvkrtQuRrd34c4PDy9HCV88byrzVpeQ8LQdpKVsMS0Nt/EM11
 I8DtTQIB8Tmg5QlaygDJE+Z4BTN+IfOzbN3mislznCRTz0QxI+UCE1aAobO08f1ly
 S4WKfmzhkSGAcvyJL2KiYfyUgBhEz50QPiq8KGTDr1RS27ZcCL0ugscSAz428zkSB
 y4UtrY0XcjFIyVLOoDSowJA4y335BdG+C1PbIsr31lWHogXPdTzgMA8CUep/nU5kx
 mNkkRUyFjG0x/ONt95PYxOSzjXC8Xxnj+WjXoXpeXUA9EKnqrZ9EpqOkNhX4eXBFy
 Fo//6mDyh9HPN9obVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUnz-1qlOW01G2b-00xsmy; Mon, 12
 Feb 2024 13:12:01 +0100
Message-ID: <28b92db2-0838-4d27-a63d-8324dc6f6c8a@gmx.de>
Date: Mon, 12 Feb 2024 13:12:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] video: console: Parse UTF-8 character sequences
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
 <20240210-vidconsole-utf8-uefi-v2-2-88c03db60de2@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240210-vidconsole-utf8-uefi-v2-2-88c03db60de2@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZgZPM5QAHUUkurBBi3vXth+nSj8km3SWbrx/UPtLhE43jSaUURc
 rguu7JENpDtUG6U4TJMwLS7Uz2b2Mh/m/EdC+HatDjO1GcAEb1y+jYU/ptk42MaJneHcAJP
 efOGDq/+aIgGjZNig553N+PDJ2Nx57XuHGnrtGSuqoQeqL67q0Mthy1jtsfZvTBAAuY6pdF
 PGatERw0OPEG+Ka5EX/1g==
UI-OutboundReport: notjunk:1;M01:P0:f71i3Tbweys=;0pTHyLjzxyB9qwsaxV/x7r55pGV
 KAjad8ryIn/J21zbwaRX2y5wNR3g8bMNy0D4xlpMSQf8UbP3od2STWMuJKy/pubuy2Xt0N1Pg
 P2VFNu4mxurfNmaAukDd9BU9zBfgO6EI2CvkluzkP845+Bstx+esYs3UKURQ/u78GDIdrq+z+
 0/uZMxy18LcfOgBMRE7cK+TC55scMo3pIdfBs68vAHsKj52YxKjAuZXRZZpVlXeBprDxp9Q3C
 QxWId/evHCHZktlPl3EvouK6eoqfLg0cBFs3GW0toykLatu3iqqQoSK3hYMOv1nKcHyDPsUF8
 x5UTKZQOg+KAjKRTqDagEMYYfM+TvuK1HE1dZxHQRK3tVlr56bl6MWzRfZcjH4Icn6r1cfUg4
 1YZfwBrievFYq5hN7QDaliYJ1JSvBYzAhxI067h4rv675Y4lSultbNPtaf1KKCzgENDtO4x4x
 xa8Qyp5jXmyTq4aR+1fW2Odcl4+GqGFON9ZBEsCbWjtrDqn3lyW1h169C9A+RjS6zFfklhDMg
 AZcS+nD6hWein+dct+sDPbD8wb+gyyyt44gBBPAKnIM2ErJDCXGKtxEM1Q7UY3rasLGLbcVqH
 RPqkimW8JZYsnqdI9kH9tdmKUUVlIAx1m/motA1565/U9R3AFF57nU14LF7SJzAx78+DiYwey
 OSJggmuP8SELiu6lqYzgJt2iAOA5jMBFjSwPO3fBA51p4/l3XoBteTto0jvN8k9scCNdHVt2Z
 IXJcusgriZ6cHsr+yNW2Ix1VEpPuJ8Bcp05CNAYeb0qVvYP69XcLGhiJaD6FDHnK+YD5svFJ5
 RwQkK0uY2Ai5guRG7Z3UwPBbprbKdwr5LMeCk2kA4cVrI=
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

On 10.02.24 13:46, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
>
> efi_console / UEFI applications (grub2, sd-boot, ...) pass UTF-8
> character sequences to vidconsole which results in wrong glyphs for code
> points outside of ASCII. The truetype console expects Unicode code
> points and bitmap font based consoles expect code page 437 code points.
> To support both convert UTF-8 to UTF-32 and pass Unicode code points in
> vidconsole_ops.putc_xy(). These can be used directly in console_truetype
> and after conversion to code page 437 in console_{normal,rotate}.
>
> This fixes rendering of international, symbol and box drawing characters
> used by UEFI applications.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   drivers/video/console_normal.c      |  6 ++++--
>   drivers/video/console_rotate.c      | 16 ++++++++++------
>   drivers/video/console_truetype.c    |  8 ++++----
>   drivers/video/vidconsole-uclass.c   | 18 +++++++++++++-----
>   drivers/video/vidconsole_internal.h | 15 +++++++++++++++
>   include/video_console.h             | 10 ++++++----
>   6 files changed, 52 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/video/console_normal.c b/drivers/video/console_norm=
al.c
> index a0231293f3..34ef5a5229 100644
> --- a/drivers/video/console_normal.c
> +++ b/drivers/video/console_normal.c
> @@ -7,6 +7,7 @@
>    */
>
>   #include <common.h>
> +#include <charset.h>
>   #include <dm.h>
>   #include <video.h>
>   #include <video_console.h>
> @@ -63,7 +64,7 @@ static int console_move_rows(struct udevice *dev, uint=
 rowdst,
>   	return 0;
>   }
>
> -static int console_putc_xy(struct udevice *dev, uint x_frac, uint y, ch=
ar ch)
> +static int console_putc_xy(struct udevice *dev, uint x_frac, uint y, in=
t cp)
>   {
>   	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>   	struct udevice *vid =3D dev->parent;
> @@ -73,8 +74,9 @@ static int console_putc_xy(struct udevice *dev, uint x=
_frac, uint y, char ch)
>   	int pbytes =3D VNBYTES(vid_priv->bpix);
>   	int x, linenum, ret;
>   	void *start, *line;
> +	u8 ch =3D console_utf_to_cp437(cp);
>   	uchar *pfont =3D fontdata->video_fontdata +
> -			(u8)ch * fontdata->char_pixel_bytes;
> +			ch * fontdata->char_pixel_bytes;
>
>   	if (x_frac + VID_TO_POS(vc_priv->x_charsize) > vc_priv->xsize_frac)
>   		return -EAGAIN;
> diff --git a/drivers/video/console_rotate.c b/drivers/video/console_rota=
te.c
> index 65358a1c6e..e4303dfb36 100644
> --- a/drivers/video/console_rotate.c
> +++ b/drivers/video/console_rotate.c
> @@ -7,6 +7,7 @@
>    */
>
>   #include <common.h>
> +#include <charset.h>
>   #include <dm.h>
>   #include <video.h>
>   #include <video_console.h>
> @@ -67,7 +68,7 @@ static int console_move_rows_1(struct udevice *dev, ui=
nt rowdst, uint rowsrc,
>   	return 0;
>   }
>
> -static int console_putc_xy_1(struct udevice *dev, uint x_frac, uint y, =
char ch)
> +static int console_putc_xy_1(struct udevice *dev, uint x_frac, uint y, =
int cp)
>   {
>   	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>   	struct udevice *vid =3D dev->parent;
> @@ -77,8 +78,9 @@ static int console_putc_xy_1(struct udevice *dev, uint=
 x_frac, uint y, char ch)
>   	int pbytes =3D VNBYTES(vid_priv->bpix);
>   	int x, linenum, ret;
>   	void *start, *line;
> +	u8 ch =3D console_utf_to_cp437(cp);
>   	uchar *pfont =3D fontdata->video_fontdata +
> -			(u8)ch * fontdata->char_pixel_bytes;
> +			ch * fontdata->char_pixel_bytes;
>
>   	if (x_frac + VID_TO_POS(vc_priv->x_charsize) > vc_priv->xsize_frac)
>   		return -EAGAIN;
> @@ -145,7 +147,7 @@ static int console_move_rows_2(struct udevice *dev, =
uint rowdst, uint rowsrc,
>   	return 0;
>   }
>
> -static int console_putc_xy_2(struct udevice *dev, uint x_frac, uint y, =
char ch)
> +static int console_putc_xy_2(struct udevice *dev, uint x_frac, uint y, =
int cp)
>   {
>   	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>   	struct udevice *vid =3D dev->parent;
> @@ -155,8 +157,9 @@ static int console_putc_xy_2(struct udevice *dev, ui=
nt x_frac, uint y, char ch)
>   	int pbytes =3D VNBYTES(vid_priv->bpix);
>   	int linenum, x, ret;
>   	void *start, *line;
> +	u8 ch =3D console_utf_to_cp437(cp);
>   	uchar *pfont =3D fontdata->video_fontdata +
> -			(u8)ch * fontdata->char_pixel_bytes;
> +			ch * fontdata->char_pixel_bytes;
>
>   	if (x_frac + VID_TO_POS(vc_priv->x_charsize) > vc_priv->xsize_frac)
>   		return -EAGAIN;
> @@ -227,7 +230,7 @@ static int console_move_rows_3(struct udevice *dev, =
uint rowdst, uint rowsrc,
>   	return 0;
>   }
>
> -static int console_putc_xy_3(struct udevice *dev, uint x_frac, uint y, =
char ch)
> +static int console_putc_xy_3(struct udevice *dev, uint x_frac, uint y, =
int cp)
>   {
>   	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>   	struct udevice *vid =3D dev->parent;
> @@ -237,8 +240,9 @@ static int console_putc_xy_3(struct udevice *dev, ui=
nt x_frac, uint y, char ch)
>   	int pbytes =3D VNBYTES(vid_priv->bpix);
>   	int linenum, x, ret;
>   	void *start, *line;
> +	u8 ch =3D console_utf_to_cp437(cp);
>   	uchar *pfont =3D fontdata->video_fontdata +
> -			(u8)ch * fontdata->char_pixel_bytes;
> +			ch * fontdata->char_pixel_bytes;
>
>   	if (x_frac + VID_TO_POS(vc_priv->x_charsize) > vc_priv->xsize_frac)
>   		return -EAGAIN;
> diff --git a/drivers/video/console_truetype.c b/drivers/video/console_tr=
uetype.c
> index 14fb81e956..bc3ec1c31f 100644
> --- a/drivers/video/console_truetype.c
> +++ b/drivers/video/console_truetype.c
> @@ -262,7 +262,7 @@ static int console_truetype_move_rows(struct udevice=
 *dev, uint rowdst,
>   }
>
>   static int console_truetype_putc_xy(struct udevice *dev, uint x, uint =
y,
> -				    char ch)
> +				    int cp)
>   {
>   	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>   	struct udevice *vid =3D dev->parent;
> @@ -281,7 +281,7 @@ static int console_truetype_putc_xy(struct udevice *=
dev, uint x, uint y,
>   	int row, ret;
>
>   	/* First get some basic metrics about this character */
> -	stbtt_GetCodepointHMetrics(font, ch, &advance, &lsb);
> +	stbtt_GetCodepointHMetrics(font, cp, &advance, &lsb);
>
>   	/*
>   	 * First out our current X position in fractional pixels. If we wrote
> @@ -290,7 +290,7 @@ static int console_truetype_putc_xy(struct udevice *=
dev, uint x, uint y,
>   	xpos =3D frac(VID_TO_PIXEL((double)x));
>   	if (vc_priv->last_ch) {
>   		xpos +=3D met->scale * stbtt_GetCodepointKernAdvance(font,
> -							vc_priv->last_ch, ch);
> +							vc_priv->last_ch, cp);
>   	}
>
>   	/*
> @@ -320,7 +320,7 @@ static int console_truetype_putc_xy(struct udevice *=
dev, uint x, uint y,
>   	 * return NULL;
>   	 */
>   	data =3D stbtt_GetCodepointBitmapSubpixel(font, met->scale, met->scal=
e,
> -						x_shift, 0, ch, &width, &height,
> +						x_shift, 0, cp, &width, &height,
>   						&xoff, &yoff);
>   	if (!data)
>   		return width_frac;
> diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsol=
e-uclass.c
> index 22d55df71f..5f89f6a521 100644
> --- a/drivers/video/vidconsole-uclass.c
> +++ b/drivers/video/vidconsole-uclass.c
> @@ -11,6 +11,7 @@
>
>   #include <common.h>
>   #include <abuf.h>
> +#include <charset.h>
>   #include <command.h>
>   #include <console.h>
>   #include <log.h>
> @@ -20,7 +21,7 @@
>   #include <video_font.h>		/* Bitmap font for code page 437 */
>   #include <linux/ctype.h>
>
> -int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, char ch)
> +int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, int ch)
>   {
>   	struct vidconsole_ops *ops =3D vidconsole_get_ops(dev);
>
> @@ -426,8 +427,8 @@ error:
>   	priv->escape =3D 0;
>   }
>
> -/* Put that actual character on the screen (using the CP437 code page).=
 */
> -static int vidconsole_output_glyph(struct udevice *dev, char ch)
> +/* Put that actual character on the screen (using the UTF-32 code point=
s). */
> +static int vidconsole_output_glyph(struct udevice *dev, int ch)
>   {
>   	struct vidconsole_priv *priv =3D dev_get_uclass_priv(dev);
>   	int ret;
> @@ -455,7 +456,7 @@ static int vidconsole_output_glyph(struct udevice *d=
ev, char ch)
>   int vidconsole_put_char(struct udevice *dev, char ch)
>   {
>   	struct vidconsole_priv *priv =3D dev_get_uclass_priv(dev);
> -	int ret;
> +	int cp, ret;
>
>   	if (priv->escape) {
>   		vidconsole_escape_char(dev, ch);
> @@ -489,7 +490,14 @@ int vidconsole_put_char(struct udevice *dev, char c=
h)
>   		priv->last_ch =3D 0;
>   		break;
>   	default:
> -		ret =3D vidconsole_output_glyph(dev, ch);
> +		if (CONFIG_IS_ENABLED(CHARSET)) {
> +			cp =3D utf8_to_utf32_stream(ch, priv->utf8_buf);
> +			if (cp =3D=3D 0)
> +				return 0;
> +		} else {
> +			cp =3D ch;
> +		}
> +		ret =3D vidconsole_output_glyph(dev, cp);
>   		if (ret < 0)
>   			return ret;
>   		break;
> diff --git a/drivers/video/vidconsole_internal.h b/drivers/video/vidcons=
ole_internal.h
> index 0ec581b266..5dae7f85ad 100644
> --- a/drivers/video/vidconsole_internal.h
> +++ b/drivers/video/vidconsole_internal.h
> @@ -6,6 +6,9 @@
>    * (C) Copyright 2023 Dzmitry Sankouski <dsankouski@gmail.com>
>    */
>
> +#include <charset.h>
> +#include <config.h>
> +
>   #define FLIPPED_DIRECTION 1
>   #define NORMAL_DIRECTION 0
>
> @@ -142,3 +145,15 @@ int console_simple_get_font(struct udevice *dev, in=
t seq, struct vidfont_info *i
>    * See details in video_console.h select_font function
>    **/
>   int console_simple_select_font(struct udevice *dev, const char *name, =
uint size);
> +
> +/**
> + *
> + */
> +static inline u8 console_utf_to_cp437(int codepoint)
> +{
> +	if (CONFIG_IS_ENABLED(CHARSET)) {
> +		utf_to_cp(&codepoint, codepage_437);
> +		return (u8)codepoint;

The (u8) conversion is superfluous in C.

> +	}
> +	return (u8)codepoint;
> +}
> diff --git a/include/video_console.h b/include/video_console.h
> index bde67fa9a5..20cf2d0101 100644
> --- a/include/video_console.h
> +++ b/include/video_console.h
> @@ -43,6 +43,7 @@ enum {
>    * @col_saved:		Saved X position, in fractional units (VID_TO_POS(x))
>    * @row_saved:		Saved Y position in pixels (0=3Dtop)
>    * @escape_buf:		Buffer to accumulate escape sequence
> + * @utf8_buf:		Buffer to accumulate UTF-8 byte sequence
>    */
>   struct vidconsole_priv {
>   	struct stdio_dev sdev;
> @@ -66,6 +67,7 @@ struct vidconsole_priv {
>   	int row_saved;
>   	int col_saved;
>   	char escape_buf[32];
> +	char utf8_buf[8];

In patch 1 you described that 5 bytes are enough.

Best regards

Heinrich

>   };
>
>   /**
> @@ -124,12 +126,12 @@ struct vidconsole_ops {
>   	 * @x_frac:	Fractional pixel X position (0=3Dleft-most pixel) which
>   	 *		is the X position multipled by VID_FRAC_DIV.
>   	 * @y:		Pixel Y position (0=3Dtop-most pixel)
> -	 * @ch:		Character to write
> +	 * @cp:		UTF-32 code point to write
>   	 * @return number of fractional pixels that the cursor should move,
>   	 * if all is OK, -EAGAIN if we ran out of space on this line, other -=
ve
>   	 * on error
>   	 */
> -	int (*putc_xy)(struct udevice *dev, uint x_frac, uint y, char ch);
> +	int (*putc_xy)(struct udevice *dev, uint x_frac, uint y, int cp);
>
>   	/**
>   	 * move_rows() - Move text rows from one place to another
> @@ -403,12 +405,12 @@ void vidconsole_pop_colour(struct udevice *dev, st=
ruct vidconsole_colour *old);
>    * @x_frac:	Fractional pixel X position (0=3Dleft-most pixel) which
>    *		is the X position multipled by VID_FRAC_DIV.
>    * @y:		Pixel Y position (0=3Dtop-most pixel)
> - * @ch:		Character to write
> + * @cp:		UTF-32 code point to write
>    * Return: number of fractional pixels that the cursor should move,
>    * if all is OK, -EAGAIN if we ran out of space on this line, other -v=
e
>    * on error
>    */
> -int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, char ch);
> +int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, int cp);
>
>   /**
>    * vidconsole_move_rows() - Move text rows from one place to another
>

