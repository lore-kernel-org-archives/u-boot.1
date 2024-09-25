Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E26AC369D4
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 11:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5E228897F;
	Wed, 25 Sep 2024 13:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="seNStJ/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9BBA8897F; Wed, 25 Sep 2024 13:50:51 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CFBB87E30
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 13:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727265044; x=1727869844; i=xypron.glpk@gmx.de;
 bh=0lwmNJovfQO4BP+PZeeLOrNk0Wet6EBAmiSZWK6PHzs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=seNStJ/D7PhdfXw5VBR/euYHpGUSs465ssEF2Fb/x1Oxcgbwootn1VcZcKcURgZV
 S/8PNkaTt6YjOoEzPkKlyrKy3x31nAnAe8uWZURhs3j50/2OGGysX0ugbhc+TleDE
 utx3nRjawAnkpIKW8BiMw0KblCuvF0ZiGegg5MuGDKbW8tvwiNYHCV88AgdFVX4Mu
 mhjleJkoSaSFsHql35UZo3rtVIC93lfpMQOksfOq4BZHqCuCFFofa9G3Z5+qz19Q0
 u2CYexU8CkWqlydUQ269JQ2za9OwfiSFX8acfpwL7P8+slkj8dYBwGsCcFr8WC7mK
 Vgj+fpRUZ15xq/XfTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1rre7I3xbr-00x29I; Wed, 25
 Sep 2024 13:50:44 +0200
Message-ID: <478ac7c2-88cd-4880-88da-2c786930ad2c@gmx.de>
Date: Wed, 25 Sep 2024 13:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sandbox_spl: Restrict use of UPL when not enabled
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240925104501.44457-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240925104501.44457-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CoGMZzhKoaNL9hYOIl5L8fhFOXTYOqu+itO8E8Iglpsq/ZGjLdv
 42aJicOPBS79AbagfgWrRHtt/sGo8OFtxT5VMPtwI462lAhdPcq8p1L0lgdhdJkc0Ldl/oo
 QhdjQBDVuP3oWvMp2Xn5PmPy2P/kqNuRFvEEXclMA4eZ3zz8f0ToQnFs7PY2zuUUmw4pRp7
 U5oSeci/dGHKR08diswIg==
UI-OutboundReport: notjunk:1;M01:P0:GIHw5Yex1FY=;u5QteCivBI0Lk3bBQIGoiemjiWD
 DvGWitaXUo2AByeYTagUPJ4TRnkJswGkGAzNZsh2BjTZvM4BRCFWO7tTGNpfv8tZJCYQ050BK
 lZXI6A8dAPvk5YB19FrHsOloClR+h++CmUko8OMboh9R+7wnlWGzhGiertivw38iS0u1Gjs2o
 BEXH7SgsBKr6sbLtMpTphjUL9c53Z8cFicbZsvW3E+yYCjQ6q0T22PupNQaMGAKy7RvUzIGSq
 apCMPTK3j1Nh5e1Z7uSd/VCrMppnrKz0If5YZ5amXhEFoaiGSABe/VNCzmNL10Zf5/e3w+2u1
 X0GCS+zgjRgC4HLWnuOY8MOoE0YO0oo99kqZS85EGAA5SYpXy+SvoZmzRsMHrLEHjLiUL+zyN
 TA2EKVPpref0WHuHKWs6IUy3EGUifjzV6KKm1YLTkdm0URyxIgrDSKkcwEEmPLWH+tWEu62J4
 luhM3uV5VC8sifHjQaxQyUCEeCtdtutfLYt1nYK/F7wOTd2JaewnjyrrbEEPpWmoOCn/SG+xv
 kl4BXYbOqw7whc0pIAgj5doeQCWC61D6LtEmZlBw0OGKpVSGd1p1ZKqxPjloUkhA4sJf4oQvV
 D+qAuDEPyNFLRbICRhQ/hglHEfjbot3HjK0aTBLzVpB0AM06HBl/PIQxfXEz3gtNjulfCLXA6
 aFaDIL/t6Q2d6eQ4ALfenQXEK6khPtOgIFIWxwlntTL2JaWR2QCa8CcYIL4BK26B4xTmx7lx0
 ZT/cXRcPC2HJZyub+CtapZCwycyu99uKIA7+B35GY01SuYMKqj2yzIQKeHlT/NZeWKJtKZ/ze
 /yq7p3YI9l3VoI+8v6TWHLfg==
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

On 25.09.24 12:44, Simon Glass wrote:
> With sandbox_spl we want to use the file-based boot in CI, so that this
> flow is tested. The recent UPL change enabled booting via that method,
> thus overriding the file-based boot.
>
> Correct this by using UPL only when the --upl flag is given.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 91fde8e1764 ("sandbox: Add an SPL loader for UPL")
> ---
>
>   arch/sandbox/cpu/spl.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
> index 1c33a520c64..76638362564 100644
> --- a/arch/sandbox/cpu/spl.c
> +++ b/arch/sandbox/cpu/spl.c
> @@ -55,9 +55,10 @@ void board_init_f(ulong flag)
>
>   void board_boot_order(u32 *spl_boot_list)
>   {
> +	struct sandbox_state *state =3D state_get_current();
> +
>   	spl_boot_list[0] =3D BOOT_DEVICE_VBE;
> -	spl_boot_list[1] =3D BOOT_DEVICE_UPL;
> -	spl_boot_list[2] =3D BOOT_DEVICE_BOARD;
> +	spl_boot_list[1] =3D state->upl ? BOOT_DEVICE_UPL : BOOT_DEVICE_BOARD;

Wouldn't the UPL method check if the loaded file is a universal payload,
and if not the BOARD method would be executed?

In upl_load_from_image() I am missing a check that the FIT image is
really a universal payload, e.g. look at the spec-revision field.

Considering
https://universalpayload.github.io/spec/chapter2-payload-image-format.html=
#example-fit
it seems a field uniquely identifying universal payloads (in contrast to
non-UPL FIT images) is missing in the specification.

Best regards

Heinrich


>   }
>
>   static int spl_board_load_file(struct spl_image_info *spl_image,

