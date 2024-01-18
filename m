Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6463FC47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 18:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC7F087BB5;
	Thu, 18 Jan 2024 19:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="otpDZswW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 787D287BC3; Thu, 18 Jan 2024 19:12:12 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB6A87B93
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 19:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705601525; x=1706206325; i=xypron.glpk@gmx.de;
 bh=kXWJtBX0hsmxjKrCeOMaTFIUebc16ZPJWdGzRL7SfoY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=otpDZswWAUrXT2OLVnQZ+igmqqWA2P0eP0gK1XtWJGQFnUCx3psobfPM1qM19uv3
 yjTyvg885ae14WYeaTW6awAahrsYP+uM+Qc10j44tKgcEK7wz/wUMEyHVfrL58WZW
 PnHMwJXxSupzVwcSRtxn/EojnYnqPEXC8P4CXkvSa75jygjIotRp607vvfpN5Evj9
 HTNpOP5uyqfd5wjzn49IpE7rJJufABUeoNwh/zyv3bO6geLosgaMLAnKSjvs3/5x/
 9kimkg+GfuvfD+viaL/JvjnevQork88KpmdQ/fcWfnEvpoynXaBiJSpIBgBsnhkXj
 QwNpTuEZZUgF8VNEeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.55] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXyJ-1rcoW34AEJ-00YwKd; Thu, 18
 Jan 2024 19:12:05 +0100
Message-ID: <53bd4a08-5a31-41c0-936e-baf1de74f7d4@gmx.de>
Date: Thu, 18 Jan 2024 19:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/6] video: console: Parse UTF-8 character sequences
Content-Language: en-US
To: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Cc: j@jannau.net, Anatolij Gustschin <agust@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
 <20240117-vidconsole-utf8-uefi-v1-2-539f7ce74fb9@jannau.net>
 <20240118135753.35a6c819@donnerap.manchester.arm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240118135753.35a6c819@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OMYQ4/IE9Z9DNx/HC7ieqNOMmCkneNdQiTReDporqoOe3h3aQWS
 FMnOHpSmweZtJC3kH1VeQ1zqYGPkZqetbKVI5Ar609UZP5ZjK6OoTe2mzoGiZzBSVZVb02Z
 G0koSBTM3JXJfJ1p+2Xqii7O6g9Hdo8B7zF/WZxzTfdhf496FA3atPjcGfk3u7QhMGBcP2h
 xxyN7SmRet3V0VUt3v4jA==
UI-OutboundReport: notjunk:1;M01:P0:JEJddpOOTFw=;T+nUJfl97MXSTyn1TD+6yxDHaS1
 ehfANRM3Io7NRqYutu2Cms6AxorKaCSUg7NknxwAieo3s0CiJqkZgVNnYx8uz1ZjzbDL1Xa4s
 +TSsWNQZHBWMPm8qqB8nB1UkCswVyH6Td5BUTl/wCc0bOjnxKFy5ucJt0wi7VvAMf03VAKu1a
 boCg4+P2En4S23FzOZPKxHgdMfT0abmPJG7VMHXcJQiB9YWlU/yRKt46LWoW20oA/OkQ3N8fY
 DPHlbMGGijve1UZ4VCxfp02hgfcD5aNz88vyGv+7r0MyGom+uIPZRlCB/Q6WsJvteBITV3cWl
 Htn5Hi9JWITgc6NmM+x8W3KU3V7bNkrx0vt+38BSfTa6n5+zyBR1OvZK/3NWPBMykp8jrkRrS
 /DqGRB9nhsjt6z4DNdbxGktDy9jhXAQ22dWxF6E5LeYZGAfYHUH9YB9BYeW6QvPu/7J1xrv3/
 QDyTyNHykPl2n023J/JUYhR+XnQ3xhZd8/wirCbBWfxsWUpYTMaIAls4j1vb/iYJh4KNOT1gD
 Gic50UatSpq2DbZ//3Itk9vJdb4R6KRge2XYDNusJep40CXAVwZsgejN61xFHKPvoEM6xMZ4O
 ne5Vjn8kVfFmI+8G4y6lLMThfyWjmkQhnrYzHeRLiNtiXi/Ly6qvl0OOiBeH19Vtx0xMqF/LS
 014sCgO18BObEkvrHDeiJbvAK44NMsm/IOd/aQvreUZHEmBkZaspWmx2Kvj6LxA3Yt6gl09Ou
 uZsr6YV15sSNdXB5hPPgZ0jI9hUIJ1U9OA1oxlbxcKAKQQryL9MBzQspq6LieGhQDQivhW+yz
 nT2JXGCLeoHzgfm/EDYk5hc33wPfsFfrll36kln1pa20RkZVbaj8Tc2nuISXD3inYLxo7IPAH
 2UyNKWG5XHgs5BX4PNxW5FWQuibBOEdVpmTjztiu8bWgD+7tfsVYpI08vf0TBXhHB3687rBNb
 TPFW7gI9qN6snJaiSIBdQz3iKOQ=
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

On 1/18/24 14:57, Andre Przywara wrote:
> On Wed, 17 Jan 2024 23:24:28 +0100
> Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org> wrote:
>
> Hi,
>
>> From: Janne Grunau <j@jannau.net>
>>
>> efi_console / UEFI applications (grub2, sd-boot, ...) pass UTF-8
>> character sequences to vidconsole which results in wrong glyphs for cod=
e
>> points outside of ASCII. The truetype console expects Unicode code
>> points and bitmap font based consoles expect code page 437 code points.
>> To support both convert UTF-8 to UTF-32 and pass Unicode code points in
>> vidconsole_ops.putc_xy(). These can be used directly in console_truetyp=
e
>> and after conversion to code page 437 in console_{normal,rotate}.
>>
>> This fixes rendering of international, symbol and box drawing character=
s
>> used by UEFI applications.
>>
>> Signed-off-by: Janne Grunau <j@jannau.net>
>> ---
>>   drivers/video/console_normal.c      |  6 ++++--
>>   drivers/video/console_rotate.c      | 16 ++++++++++------
>>   drivers/video/console_truetype.c    |  8 ++++----
>>   drivers/video/vidconsole-uclass.c   | 18 +++++++++++++-----
>>   drivers/video/vidconsole_internal.h | 15 +++++++++++++++
>>   include/video_console.h             | 10 ++++++----
>>   6 files changed, 52 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/video/console_normal.c b/drivers/video/console_nor=
mal.c
>> index a0231293f3..34ef5a5229 100644
>> --- a/drivers/video/console_normal.c
>> +++ b/drivers/video/console_normal.c
>> @@ -7,6 +7,7 @@
>>    */
>>
>>   #include <common.h>
>> +#include <charset.h>
>>   #include <dm.h>
>>   #include <video.h>
>>   #include <video_console.h>
>> @@ -63,7 +64,7 @@ static int console_move_rows(struct udevice *dev, uin=
t rowdst,
>>   	return 0;
>>   }
>>
>> -static int console_putc_xy(struct udevice *dev, uint x_frac, uint y, c=
har ch)
>> +static int console_putc_xy(struct udevice *dev, uint x_frac, uint y, i=
nt cp)
>>   {
>>   	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>>   	struct udevice *vid =3D dev->parent;
>> @@ -73,8 +74,9 @@ static int console_putc_xy(struct udevice *dev, uint =
x_frac, uint y, char ch)
>>   	int pbytes =3D VNBYTES(vid_priv->bpix);
>>   	int x, linenum, ret;
>>   	void *start, *line;
>> +	u8 ch =3D console_utf_to_cp437(cp);
>>   	uchar *pfont =3D fontdata->video_fontdata +
>> -			(u8)ch * fontdata->char_pixel_bytes;
>> +			ch * fontdata->char_pixel_bytes;
>>
>>   	if (x_frac + VID_TO_POS(vc_priv->x_charsize) > vc_priv->xsize_frac)
>>   		return -EAGAIN;
>> diff --git a/drivers/video/console_rotate.c b/drivers/video/console_rot=
ate.c
>> index 65358a1c6e..e4303dfb36 100644
>> --- a/drivers/video/console_rotate.c
>> +++ b/drivers/video/console_rotate.c
>> @@ -7,6 +7,7 @@
>>    */
>>
>>   #include <common.h>
>> +#include <charset.h>
>>   #include <dm.h>
>>   #include <video.h>
>>   #include <video_console.h>
>> @@ -67,7 +68,7 @@ static int console_move_rows_1(struct udevice *dev, u=
int rowdst, uint rowsrc,
>>   	return 0;
>>   }
>>
>> -static int console_putc_xy_1(struct udevice *dev, uint x_frac, uint y,=
 char ch)
>> +static int console_putc_xy_1(struct udevice *dev, uint x_frac, uint y,=
 int cp)
>>   {
>>   	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>>   	struct udevice *vid =3D dev->parent;
>> @@ -77,8 +78,9 @@ static int console_putc_xy_1(struct udevice *dev, uin=
t x_frac, uint y, char ch)
>>   	int pbytes =3D VNBYTES(vid_priv->bpix);
>>   	int x, linenum, ret;
>>   	void *start, *line;
>> +	u8 ch =3D console_utf_to_cp437(cp);
>>   	uchar *pfont =3D fontdata->video_fontdata +
>> -			(u8)ch * fontdata->char_pixel_bytes;
>> +			ch * fontdata->char_pixel_bytes;
>>
>>   	if (x_frac + VID_TO_POS(vc_priv->x_charsize) > vc_priv->xsize_frac)
>>   		return -EAGAIN;
>> @@ -145,7 +147,7 @@ static int console_move_rows_2(struct udevice *dev,=
 uint rowdst, uint rowsrc,
>>   	return 0;
>>   }
>>
>> -static int console_putc_xy_2(struct udevice *dev, uint x_frac, uint y,=
 char ch)
>> +static int console_putc_xy_2(struct udevice *dev, uint x_frac, uint y,=
 int cp)
>>   {
>>   	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>>   	struct udevice *vid =3D dev->parent;
>> @@ -155,8 +157,9 @@ static int console_putc_xy_2(struct udevice *dev, u=
int x_frac, uint y, char ch)
>>   	int pbytes =3D VNBYTES(vid_priv->bpix);
>>   	int linenum, x, ret;
>>   	void *start, *line;
>> +	u8 ch =3D console_utf_to_cp437(cp);
>>   	uchar *pfont =3D fontdata->video_fontdata +
>> -			(u8)ch * fontdata->char_pixel_bytes;
>> +			ch * fontdata->char_pixel_bytes;
>>
>>   	if (x_frac + VID_TO_POS(vc_priv->x_charsize) > vc_priv->xsize_frac)
>>   		return -EAGAIN;
>> @@ -227,7 +230,7 @@ static int console_move_rows_3(struct udevice *dev,=
 uint rowdst, uint rowsrc,
>>   	return 0;
>>   }
>>
>> -static int console_putc_xy_3(struct udevice *dev, uint x_frac, uint y,=
 char ch)
>> +static int console_putc_xy_3(struct udevice *dev, uint x_frac, uint y,=
 int cp)
>>   {
>>   	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>>   	struct udevice *vid =3D dev->parent;
>> @@ -237,8 +240,9 @@ static int console_putc_xy_3(struct udevice *dev, u=
int x_frac, uint y, char ch)
>>   	int pbytes =3D VNBYTES(vid_priv->bpix);
>>   	int linenum, x, ret;
>>   	void *start, *line;
>> +	u8 ch =3D console_utf_to_cp437(cp);
>>   	uchar *pfont =3D fontdata->video_fontdata +
>> -			(u8)ch * fontdata->char_pixel_bytes;
>> +			ch * fontdata->char_pixel_bytes;
>>
>>   	if (x_frac + VID_TO_POS(vc_priv->x_charsize) > vc_priv->xsize_frac)
>>   		return -EAGAIN;
>> diff --git a/drivers/video/console_truetype.c b/drivers/video/console_t=
ruetype.c
>> index 14fb81e956..bc3ec1c31f 100644
>> --- a/drivers/video/console_truetype.c
>> +++ b/drivers/video/console_truetype.c
>> @@ -262,7 +262,7 @@ static int console_truetype_move_rows(struct udevic=
e *dev, uint rowdst,
>>   }
>>
>>   static int console_truetype_putc_xy(struct udevice *dev, uint x, uint=
 y,
>> -				    char ch)
>> +				    int cp)
>>   {
>>   	struct vidconsole_priv *vc_priv =3D dev_get_uclass_priv(dev);
>>   	struct udevice *vid =3D dev->parent;
>> @@ -281,7 +281,7 @@ static int console_truetype_putc_xy(struct udevice =
*dev, uint x, uint y,
>>   	int row, ret;
>>
>>   	/* First get some basic metrics about this character */
>> -	stbtt_GetCodepointHMetrics(font, ch, &advance, &lsb);
>> +	stbtt_GetCodepointHMetrics(font, cp, &advance, &lsb);
>>
>>   	/*
>>   	 * First out our current X position in fractional pixels. If we wrot=
e
>> @@ -290,7 +290,7 @@ static int console_truetype_putc_xy(struct udevice =
*dev, uint x, uint y,
>>   	xpos =3D frac(VID_TO_PIXEL((double)x));
>>   	if (vc_priv->last_ch) {
>>   		xpos +=3D met->scale * stbtt_GetCodepointKernAdvance(font,
>> -							vc_priv->last_ch, ch);
>> +							vc_priv->last_ch, cp);
>>   	}
>>
>>   	/*
>> @@ -320,7 +320,7 @@ static int console_truetype_putc_xy(struct udevice =
*dev, uint x, uint y,
>>   	 * return NULL;
>>   	 */
>>   	data =3D stbtt_GetCodepointBitmapSubpixel(font, met->scale, met->sca=
le,
>> -						x_shift, 0, ch, &width, &height,
>> +						x_shift, 0, cp, &width, &height,
>>   						&xoff, &yoff);
>>   	if (!data)
>>   		return width_frac;
>> diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconso=
le-uclass.c
>> index 22d55df71f..ce1668b97b 100644
>> --- a/drivers/video/vidconsole-uclass.c
>> +++ b/drivers/video/vidconsole-uclass.c
>> @@ -11,6 +11,7 @@
>>
>>   #include <common.h>
>>   #include <abuf.h>
>> +#include <charset.h>
>>   #include <command.h>
>>   #include <console.h>
>>   #include <log.h>
>> @@ -20,7 +21,7 @@
>>   #include <video_font.h>		/* Bitmap font for code page 437 */
>>   #include <linux/ctype.h>
>>
>> -int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, char ch)
>> +int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, int ch)
>>   {
>>   	struct vidconsole_ops *ops =3D vidconsole_get_ops(dev);
>>
>> @@ -426,8 +427,8 @@ error:
>>   	priv->escape =3D 0;
>>   }
>>
>> -/* Put that actual character on the screen (using the CP437 code page)=
. */
>> -static int vidconsole_output_glyph(struct udevice *dev, char ch)
>> +/* Put that actual character on the screen (using the UTF-32 code poin=
ts). */
>> +static int vidconsole_output_glyph(struct udevice *dev, int ch)
>>   {
>>   	struct vidconsole_priv *priv =3D dev_get_uclass_priv(dev);
>>   	int ret;
>> @@ -455,7 +456,7 @@ static int vidconsole_output_glyph(struct udevice *=
dev, char ch)
>>   int vidconsole_put_char(struct udevice *dev, char ch)
>
> This looks like a weird interface, to stuff in 8-bit bytes really,
> rather than the promised characters, and have some kind of internal stat=
e
> here. I am wondering if we should make this function static? There is on=
ly
> one real user (in board/atmel/common/video_display.c), that looks like i=
t
> could use vidconsole_put_string(). Plus the tests, but we could fix them
> as well.
> Or we make this function also take a UTF-32?
>
> Shouldn't hold back this series, but just stumbled upon it, and
> was curious what other people think.
>
>>   {
>>   	struct vidconsole_priv *priv =3D dev_get_uclass_priv(dev);
>> -	int ret;
>> +	int cp, ret;
>>
>>   	if (priv->escape) {
>>   		vidconsole_escape_char(dev, ch);
>> @@ -489,7 +490,14 @@ int vidconsole_put_char(struct udevice *dev, char =
ch)
>>   		priv->last_ch =3D 0;
>>   		break;
>>   	default:
>> -		ret =3D vidconsole_output_glyph(dev, ch);
>> +		if (CONFIG_EFI_LOADER) {
>
> This would need to be:
> 	if (IS_ENABLED(CONFIG_EFI_LOADER)) {

Please, use CONFIG_IS_ENABLED(CHARSET). CONFIG_IS_ENABLED will correctly
determine the avaialability of the symbol in SPL if we should ever have
a video console there. Unicode is not only relevant for UEFI but also
for correctly displaying non-ASCII file names. In general we should
assume that code sequences used in the console are UTF-8 to support
internationalization.

> Otherwise disabling EFI_LOADER breaks compilation, since
> CONFIG_EFI_LOADER will not be defined at all:
>
> drivers/video/vidconsole-uclass.c: In function =E2=80=98vidconsole_put_c=
har=E2=80=99:
> drivers/video/vidconsole-uclass.c:493:7: error: =E2=80=98CONFIG_EFI_LOAD=
ER=E2=80=99 undeclared (first use in this function); did you mean =E2=80=
=98CONFIG_ENV_ADDR=E2=80=99?
>
> But more general, is this really a compile time check? Without EFI
> applications, do we only expect 7-bit ASCII, or CP437 explicitly? It's
> only U-Boot generated output then, right?

A board on the Chinese market should be able to write a Chinese text to
the console. This is not UEFI specific.

Best regards

Heinrich

>
>> +			cp =3D utf8_to_utf32_stream(ch, priv->utf8_buf);
>> +			if (cp =3D=3D 0)
>> +				return 0;
>> +		} else {
>> +			cp =3D ch;
>> +		}
>> +		ret =3D vidconsole_output_glyph(dev, cp);
>>   		if (ret < 0)
>>   			return ret;
>>   		break;
>> diff --git a/drivers/video/vidconsole_internal.h b/drivers/video/vidcon=
sole_internal.h
>> index 0ec581b266..3d19410a52 100644
>> --- a/drivers/video/vidconsole_internal.h
>> +++ b/drivers/video/vidconsole_internal.h
>> @@ -6,6 +6,9 @@
>>    * (C) Copyright 2023 Dzmitry Sankouski <dsankouski@gmail.com>
>>    */
>>
>> +#include <charset.h>
>> +#include <config.h>
>> +
>>   #define FLIPPED_DIRECTION 1
>>   #define NORMAL_DIRECTION 0
>>
>> @@ -142,3 +145,15 @@ int console_simple_get_font(struct udevice *dev, i=
nt seq, struct vidfont_info *i
>>    * See details in video_console.h select_font function
>>    **/
>>   int console_simple_select_font(struct udevice *dev, const char *name,=
 uint size);
>> +
>> +/**
>> + *
>> + */
>> +static inline u8 console_utf_to_cp437(int codepoint)
>> +{
>> +	if (CONFIG_EFI_LOADER) {
>
> Same IS_ENABLED() usage required here.
>
> Cheers,
> Andre.
>
>> +		utf_to_cp(&codepoint, codepage_437);
>> +		return (u8)codepoint;
>> +	}
>> +	return (u8)codepoint;
>> +}
>> diff --git a/include/video_console.h b/include/video_console.h
>> index bde67fa9a5..20cf2d0101 100644
>> --- a/include/video_console.h
>> +++ b/include/video_console.h
>> @@ -43,6 +43,7 @@ enum {
>>    * @col_saved:		Saved X position, in fractional units (VID_TO_POS(x))
>>    * @row_saved:		Saved Y position in pixels (0=3Dtop)
>>    * @escape_buf:		Buffer to accumulate escape sequence
>> + * @utf8_buf:		Buffer to accumulate UTF-8 byte sequence
>>    */
>>   struct vidconsole_priv {
>>   	struct stdio_dev sdev;
>> @@ -66,6 +67,7 @@ struct vidconsole_priv {
>>   	int row_saved;
>>   	int col_saved;
>>   	char escape_buf[32];
>> +	char utf8_buf[8];
>>   };
>>
>>   /**
>> @@ -124,12 +126,12 @@ struct vidconsole_ops {
>>   	 * @x_frac:	Fractional pixel X position (0=3Dleft-most pixel) which
>>   	 *		is the X position multipled by VID_FRAC_DIV.
>>   	 * @y:		Pixel Y position (0=3Dtop-most pixel)
>> -	 * @ch:		Character to write
>> +	 * @cp:	EF	UTF-32 code point to write
>>   	 * @return number of fractional pixels that the cursor should move,
>>   	 * if all is OK, -EAGAIN if we ran out of space on this line, other =
-ve
>>   	 * on error
>>   	 */
>> -	int (*putc_xy)(struct udevice *dev, uint x_frac, uint y, char ch);
>> +	int (*putc_xy)(struct udevice *dev, uint x_frac, uint y, int cp);
>>
>>   	/**
>>   	 * move_rows() - Move text rows from one place to another
>> @@ -403,12 +405,12 @@ void vidconsole_pop_colour(struct udevice *dev, s=
truct vidconsole_colour *old);
>>    * @x_frac:	Fractional pixel X position (0=3Dleft-most pixel) which
>>    *		is the X position multipled by VID_FRAC_DIV.
>>    * @y:		Pixel Y position (0=3Dtop-most pixel)
>> - * @ch:		Character to write
>> + * @cp:		UTF-32 code point to write
>>    * Return: number of fractional pixels that the cursor should move,
>>    * if all is OK, -EAGAIN if we ran out of space on this line, other -=
ve
>>    * on error
>>    */
>> -int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, char ch);
>> +int vidconsole_putc_xy(struct udevice *dev, uint x, uint y, int cp);
>>
>>   /**
>>    * vidconsole_move_rows() - Move text rows from one place to another
>>
>

