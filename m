Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B0DEF5868
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 07:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E9C80FA1;
	Sun, 15 Feb 2026 08:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VU5wE4QH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A37683A41; Sun, 15 Feb 2026 08:28:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6BAD80B98
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 08:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771140502; x=1771745302; i=xypron.glpk@gmx.de;
 bh=LrgZxF9PeF8OG0js0zN9MBkbbXcfHP/+WwHvPxsxp2Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VU5wE4QHoQbF8vHk8uKvbmv4o4dsVfN0NmsJNHhVxX76i0v9V90vT9mi5kTgddFR
 87RZ0EvNbKhj9oLoQzogx9jXcAMJ6umiYNZ+pj3FE/owred7u8A8JAG3olO1ije+7
 QlYqKNPsvLGTQNywpQwvL9fMASZZgAR3rkeM/e/20kpwjJXRk9MyDB1NghRfvXQVr
 pmaGzKhaQvAIzLqVZypT07dvwHTpaU8mgCyn1KhLtZyclQZYBLO5dKlzR5eJC07So
 6KrsIgzeU9p4/DVS4Ab3wnyTLlyRMiBvosIEbllsr5Qi3ksQd0KI9KNPeaGcwEH1v
 Z/Z/vpjmzWkPXnoDtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ob6-1vfzPv41ry-010JWU; Sun, 15
 Feb 2026 08:28:22 +0100
Message-ID: <ad8b541f-8809-437e-8de6-03646e998bb0@gmx.de>
Date: Sun, 15 Feb 2026 08:28:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: add missing EFI_CALL around tcg2 read_blocks
 calls
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
References: <20260211124314.3406952-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260211124314.3406952-1-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t+m4FkxinlV85x4vSkkn+q96rboYE1K6EGhDfbuobVUk92CkLrU
 t23rQkawtZwmDzofXPujQPLmUABWrv6tByhUGXUrMSFTBJxFuwmPjfUebammyKUirnGfJBv
 13vSCwOHhJytDkwmjAdIyNFvXipN2LUcxWorQioqlfJs/pv+cO42aLG1o1NwlCyIJeEsaC1
 3FnYDisFX0GrQ/e76WyxQ==
UI-OutboundReport: notjunk:1;M01:P0:F8MB68sCGlU=;X/yJSEYz3GpEgI7aUD3By+ytULo
 a0dno0LiaXNvCciQ4ky8UU+R/kc+MWTjSzK3po8rXfjZ/it7jf/kSTzbt0lc6fk4J/mGQi66B
 EH/3PuUhfyztWwV00WMZAD4adTbet8Fw/ElF65qq7j4NjTocwRPOCs8ch0AhMjwPmJMLwGeL+
 Bft6hBvK+cookSoFhYEu7c2SvSAz8/X1CQT51yd8KJJU5BtRzJPCDincattDV/VBJnVGEXJGY
 Rt5p4UXDGQIYD3kgHZLCox0FnQ8MYifWL2ITyFMMKwPBH7BWXCDnl+fs3e/icWq1as5C+wq0f
 FeTLAHPajVrvpJ9dfoBAnaJqMi5uDTSIAWNd4OEXKVQS/nluSysWKddubKlihgewhCuYRFq35
 M6utWWe0ZX9wr8mJEC4OMgF8iMCaYxZDOJ1sSTbnRVhJNwI9byhU35pGuLKusFt7ysSQ5RbGJ
 N+7EvxzAVFPahsdSnlWAkTX2Q4CiNUWkirYGrzhW3mAcOYk7VoN8A3LiLOT3BwN3JZmZD0I4J
 QFB4+V/d/P3VY27edz+PYcirtDtUQ9M+ZXwAFXRutU/V6XCyThL5eQgpxMfyDcrnCmBGC6tIl
 PqvOklEHjjtFBX8rmwwftNVxX2/eTXrXradAETPcqjFajKBliI4nvDFyGspZDQI6rV9NWMrNS
 bVWNc2pdxXPx6hIccu1XJ6qEWmtltsQG2I5fNirDVu44C+MyZmNBYVivP6HeSNu7hL0Ril6GI
 bSO2Zyi6UaHBM8Wty7lcO9NgnvQl9XJURKJm783RgLSA0pCPRDTEaEpIZjqpxVOUHJ4OGxV3g
 lEi83kuPGWGlkXQIRVoDHvEmjwQAgSTHyXgffXgAjQ8kOe0hcAXcBN+ph21BN6tlBks5OzErt
 2TW0Jcob7EkxzqDAR/YLbA3VfGZqFVE/qN0jSTcgIPQM57TKh5j0RdUDScIZAwnRFu7cFEAg4
 uVKsxaT14iILGclRpX0v7PXTZMObytSAVDNd/vaR/2fBJ9bFEHK01OK/thUW2S3SvhCKloW74
 DrUFEZ/IazZgmx/yqj9AP29AqkmCOE8r3I5WiUtkQXC2qyZqZBViLWgBizbNN1XOb5J2d4nWO
 dwaU9KzkGyp0VVPEhfdUpnRa8SUCnrs4QK3RoPSItA6/rhG/FL87+bUKIZozRM659CmFhH+1F
 Ol/CoUV//bAh94iSj1lPzdZg4OFbyMQBTTvb2BigI3JpVd4ACmKVCBeU71/9vNxl7vy7WP3VK
 skX3HRZYWG0kxEikD5qNYOOFsaXy4VsPAt8zdrj+R8jdRdcwIzQ4fLsT3uOixh42smh6ywAcb
 zHu/aJ9g1WN2w0QC1jmdO1xrOgf6j0GwznBT+ehQ5REyEfyyl18n5AazDFPCGBcGaWx8QmZ8k
 Dxwx2zEu3fKW4EDanzFHkZeCsNY5CnW28F19MvgC3j/HgwrM2DYybecr5EPEebKfhHeIajxm7
 wlZhsvKUm8IlYFgkyqZ7KFQSsyOc5EXtPptMBXSzY3w9DRyexxmHzFon1BAZVB6Y/YhxF16xK
 2nbGAcOeEQEyEkv98IXMW9puLPRPKbAy4hK4zBuqr0spynKpWh77GxDQMQq4DoXI8aKK7xXew
 KDccUCrVIFSWKlAeVDNx3XXeTa93r1g4ULe5gRX9IcKU42xHmLyfhe1GFvnIbvxZCj6FGQe+x
 HtRlOJ7QcCZu9c4f5JNdy07nfcqnhJh/PrDRlCyXmne1Wb1dEtwla2806HsvsETJcB37CzSpb
 1ThPJHPb3tQAah7MfLDHroOvK8T0621KBECwNy2uLPxXIWCjeDkchrWVwUsVha5EmK0eKyaxu
 wRPjhh3dE1wepf8buMBDCNIA0j44crrv/ZFvRg94E2/IkBaom26ljCe81bHECBbYVjsPHu56i
 ADFdHP0m84zSjW4q8UzmAKL+aTgzjQCxNo+0D9nTFjrhgX0DWFUK35T2yFAH+sN2+a31Lgr7y
 3XO/kwmix6PiLiovpWk8aiT9AscX0hiWWRwVTDdIiMYga7O5Y1SFn4kZ+6mlyF0nyK9pduKH3
 YOFrqnLcBO8CBqTV8lKX0sspqpBjKC4ns/kXdpP/+qmi/TK/fF77vt60cBZ0cuTZcIiyFqFoZ
 BOflOecvOlPOvRYFAdocukWUsdPrNvtjKfrKTfcRlqt3/VBeGhB2UIy0xwWKkslXven+1jvK7
 Vrl71Pk/FHehq5Dk+RPPapz3WHDO3ePIUME17WA7adkdqtWlUSrAaiEKAnrIQbBMTk5elyX+2
 uqeVq8WG5IOP7dxOQlqx7dpywYhGWx8DVTl+ymhAAmLnzrT0ArvdNj1DkOcoZKLjSF7fo252j
 +mht7VxBCTGGmmBOQ7FzfuNZPQZnHdpXJOCyVzgSLc32ptO/xGQKO7M2EenwrU1CgLU3TYHFn
 Dd4pp/Q3ML8NaOKTx4r7Y8XhWd9ldAUkqvSrXKN7NdQlT6Bk9ixiNEd+lu+P4CnU+RBDGIqfC
 hAJ1+zMaUCf5tdMVFY6tlaevPi73eyBkYJJjVy2JG8DVAnPcg6LFpthDllryR7++ar3gFeSkO
 R9XEM6N5naQlMimcSpfXDNH10Ia6zh3fzpfHx3Pv1ArI3qhz+5jAUg7i1A68PEg26utL/OLsa
 5QpHI3uvxppbg2t1mbcasl+enl/OCDFAFO8jOuDUdrAd8AlII0r736HrnBqgVOqeYGY1+2l/y
 Icrf0I1+g/+3nts8F1pfXw2KYQ5OMDllTbpfY486x+t7iKOF7IfqDUaSRwZo7/J1mYKBiNQTS
 iEUMn2a+vmiYpQ9Fxz5en+4WqYDnMsdrHstUEjQHFh2JdjFaIkKRDFk2ZfGdcpFoBB66CXdi5
 BsYHVcZScl7f4p3vq+WrAjAwS+WhHV169d3vvwpVu3EDIo3VJ3w24vPnLkq/TTF5SWau525Zu
 6CIzgkMFIBoxvV4Lk2sP55+8IxIODnmb4Oiu7p2KF7OJfR8g06Dl3QTAwjkfv8m/2vLVbM682
 jFH+/23gZ34HvA6nv23KZQ/GXmH19cTN2QF0tCxUo6BPWVc+FcQqaoUrE22GVRLfzGoONJQC4
 ZMP7e3S8eq9eLjGJdP9Vq9a8s+ZmoxaUeNFfqRQ0XK/00RidoyKgDqNwFc9Q9BPLhuQkPfziA
 edkY5jtyE+oj20ALxn+cUtH1bX96xa6CYggEiN7RMP8mUcPLLgFpV6QO24mOGXHMnWF/3mOy5
 5bwwHlUIzyaKi/2mb7TEJtCahuvyR3LOAy1xdhjqftfRwNaivuPfpiPsfal3pwf89xKLfsisM
 iob4vRskIA0Tc0MQDNLlFh7+sf+N8uHKLz7/kdbsuNSVDomqpYzmnuPRiddWzoWDBP9ffL2rY
 ds1EkUFu127iulai1ojO95pbIfvRAm9JOzo8t1RQ16bYBAYv8jpdPjrgQtBuPuWkKi46Wpey3
 c40sGO3U2tETea3Xb1U+fUNWndwHW6IDGgS6cJSlCy24HAXw+wvjjh6MblJlPdR4sKdYlhGYZ
 dvSqOEFMz1+lLKOzqdRb8aFTmh5OWelvfbkqe1GvHmBYVHQ6mCVPLK/MKQIZAMTwv13gAcDs+
 MNHVVUPP1U/DMDdZVuVE1l25v41fSALW7dIARAlcUzieuI/yn8dJskykb0rmX8cB44KBn3Kei
 RUkwgpK25Su4FLZ0a5F6+5Kb9TwslQ+9pJE1KD7nLoSeDuqt5hQH1yMB55oYNFlu9rNLrJ0ks
 LYT8bkQ0FnUTYPwBLjHwtv2A62z2BocDV9RGOQedAoegXdLCPk4viWmgxNxD/u9BVNCDjgix5
 D2ZEq+6ZH8sdN4HG3xGjM3r8pIUOVkgKFmup7kql+/1XBmxChGlQubQQu7r5ESmWs2jjnixIl
 UJz/y0EmTceXqO3vFz64oSvuIaPwanU1SeJcpJLkVObzDVjGXRWyzzEXYOusSCyXH5wYAlv5U
 d2XNAxMx09j/EAuZC7H8M504b+iFSJQ8HGvdclu/0zlfKz8AZzl8eusRYX7wgpXJdEhgwSf+B
 LxsKw9CyQBvp5+cukTwf5W82dTkcxRKR98k8c6OTIsYjhHg/5v0fPjymE331J373leK864Lbg
 5hRCWwmjF/xsxH8MC88TzE+LrMkuILWucGifknMFGXegHX2UKuNU/m2sWMmX5gDBRvi2705vS
 ODAXrjKwsKqkQaNrnr7W5crUtNqB8LmukYLMLGfANfGp000/rEqL32wP8UiYZQwHISKo4FtrG
 Pjm34E80r3tnmJu+xAdjY24EQ2JvcLEmtH+07a557qh8bb575rsVJOHKefIucOVkyS4LOKj4z
 lTkTMSRdXAPp6vOeQghUSsZqnyaEHT3tAMkI0rl3jy4VymISK+ky+JusAIS068aH6OE0p6IQs
 4z3dCuWRPIKnurpax5WjemtXZzFvgecgAap2TlulowciyN3EaVA5OPlZNjnjRwO5t6edvIiPH
 bAXlG1ch9PGV3+pOot3sSzl38SDSbRdnx4+0hrnwS/5A4fhD+oJknI7Uh5xMhuqmIumXJBbcX
 Ce4k7awoJBwHekpemStzlXUNTO1rttvwXvuq0+feFXTpphd3bQ2Y/oAFzaExEEK7oCc5Y5q3i
 Iar/EwtmjdPpUnWXJlpNYNiV5YKx7tdaRVXK/cHbrwLb/KpumGlUzJLCGvjqYdPFsBCndjf+7
 vUJYZb5FXbdfdNhuW+JWRrVC928S1Uc9hQm/Aa3dKM/T0FwoW0Km2fMcc6mRV1hNUTS2GqzXs
 dbB36uVhiUVuZkiGCAv6HpNEMLlqMjtQfG7VdPslVpyUcw4MtrZ/QLr5M2QssgJ/RAHLBKctj
 vphplrKTVz/VuY1ZLiQ3SyWlHVRkNfphVRjSG3PnflFa7eCNirgafquFV9cZR2+6Aq9aoSXzW
 5gbAN5cehpOVa5PMI/VPxQ3NXvLu92gc/Tc9ePHdlC3AuN0BwgxRJMULALyZWmAR+1Ke+aUOu
 7NOBEc0Pafxd53lX9kv//Sb57khoXigtCchC9nb9HFcZjrgC2mp/N7fjxcDJpvHKPT9uk9+cQ
 tFrcKm3hFRN2JSD19J0x6DtW+Zs14pqt/GCi3iXUBGSuqu+8D+ewfjOGUmUKvy3sLH/K/bTY8
 1Ol/IS6G1K3ZVkkk+vN18RdbWpXGVx5VJar++qrdkVbwOkyzDsr9Yn/gShsmjxfxoRppsLRre
 +AbJqai7Z5ngtXYf9DHboJIKSphT5SCQKVhIg2Flb2Cuqz3dVQQ6xS9ZlWHyJTZEeuWl1jrQS
 l0SpuOEX3c5FXlzogmle1Wov13Qiqcx5V0jDb10HoVyo3TxJrKShJRRl0NHrEjWQ9xI0boNCL
 eOIkqpHwo+JaSJ2E4ikR
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

On 2/11/26 13:43, Vincent Stehl=C3=A9 wrote:
> The read_blocks() function from the Block IO protocol is a UEFI function=
;
> make sure to call it from within U-Boot using the EFI_CALL() macro.
>=20
> To demonstrate the issue on an AArch64 machine, define the DEBUG macro i=
n
> include/efi_loader.h and build u-boot with sandbox_defconfig, then downl=
oad
> and uncompress the ACS-DT image [1], and finally execute the following
> command:
>=20
>    $ ./u-boot -T -c " \
>        host bind 0 systemready-dt_acs_live_image.wic; \
>        setenv loadaddr 0x10000; \
>        load host 0 \${loadaddr} EFI/BOOT/Shell.efi; \
>        bootefi \${loadaddr} \${fdtcontroladdr}"
>=20
> The following assertion should fail:
>=20
>    lib/efi_loader/efi_net.c:858: efi_network_timer_notify: Assertion `__=
efi_entry_check()' failed.
>=20
> This happens due to the following EFIAPI functions call chain:
>=20
>    efi_start_image()
>      efi_disk_read_blocks()
>        (due to the missing EFI_CALL, entry_count =3D=3D 2)
>        efi_network_timer_notify()
>=20
> Link: https://github.com/ARM-software/arm-systemready/releases/download/=
v25.12_DT_3.1.1/systemready-dt_acs_live_image.wic.xz [1]
> Fixes: ce3dbc5d080d ("efi_loader: add UEFI GPT measurement")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_tcg2.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index bdf78897d47..1860dc50238 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -1213,8 +1213,10 @@ tcg2_measure_gpt_data(struct udevice *dev,
>   		goto out2;
>   	}
>  =20
> -	ret =3D block_io->read_blocks(block_io, block_io->media->media_id, 1,
> -				    block_io->media->block_size, gpt_h);
> +	ret =3D EFI_CALL(block_io->read_blocks(block_io,
> +					     block_io->media->media_id, 1,
> +					     block_io->media->block_size,
> +					     gpt_h));
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out2;
>  =20
> @@ -1227,9 +1229,10 @@ tcg2_measure_gpt_data(struct udevice *dev,
>   		goto out2;
>   	}
>  =20
> -	ret =3D block_io->read_blocks(block_io, block_io->media->media_id,
> -				    gpt_h->partition_entry_lba,
> -				    total_gpt_entry_size, entry);
> +	ret =3D EFI_CALL(block_io->read_blocks(block_io,
> +					     block_io->media->media_id,
> +					     gpt_h->partition_entry_lba,
> +					     total_gpt_entry_size, entry));
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out2;
>  =20

