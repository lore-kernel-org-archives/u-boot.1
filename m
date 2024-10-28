Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EE0D339AF
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 18:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71024890A9;
	Mon, 28 Oct 2024 19:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZMaB0Wet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E728E890DF; Mon, 28 Oct 2024 19:01:08 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E957289099
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 19:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730138465; x=1730743265; i=xypron.glpk@gmx.de;
 bh=hIdwpXNJ2XsS0w42IjtjQI3YZPP9YOFuM4/UiYfiEcw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZMaB0WetdHB1aV+1zyUIQL6IXTgTg/+I9PmGjiRpCoSSimTU36LzVc+nulNkNndZ
 IbqaRWeXHg5q6+rDUsN5RDi0zUulcYI6HeGdNDnrTbLy968siI8EdK75U/Dk5xinj
 B3Q9i4fvHl+wZxoA2Fuw3pVcZDrlK/Sg2dMzAYJufPVS3VbXChoYX2TucTfrgeb/+
 k9YtC8VKF26vVB9B+yUHay7fmSKW70N0MXa8Nd9H0cToX16DM+IpUgxUx53O9Wga6
 JFSHi6Qvc2COFtttS2iPSgV4Vqd5SpALR2qgdOUIpqsTJtEHEzN9rh4ILwxKvOOFE
 W/o2i2TcqhBMSTFoyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3He-1t7i2L0Mem-00A87H; Mon, 28
 Oct 2024 19:01:05 +0100
Message-ID: <a13dbc73-c05b-47dd-828d-4ed50dd5264b@gmx.de>
Date: Mon, 28 Oct 2024 19:01:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/8] sandbox: Add a -N flag to control on-host behaviour
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-5-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241022120032.196311-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OXtWa3FxJcXshfj7pk2fKYZxTawUNLgg5lI1ITeHCtaLlj11pRA
 QWqiuvE4xWoLHvuNNCvZ/+6zz7wMOyq5+8hIZMDvnhDxkJkPF9hbzxH24OqYXVqA+VwDUoL
 6fuMTviZwOndoZgVwwKbHI5GX0yzKC4yC+kAzb8jFoaOGdOyF8Lnj4EwqdOZHy5kXldjons
 koDrUoKRQjrwYgRKUIrXQ==
UI-OutboundReport: notjunk:1;M01:P0:E+FX1E4n558=;DEvdImnqFpm+uU8zOIgEKKOdT7L
 L/FpgX+iGKSIRwe0Govo4l2bQzqezDBFe3AVvOsktv4cBgjSAyOSC6SdDbvVGpFY0DcKeiDFA
 0hbFiqc42aPJSZseHGWob46NwDxoxD9mzVjkhAkr2q8FSocAghTfonJmTln8pmTaw6Dch7Cui
 4H+fJkw9nMDNRbNWp41vLgDEq5IUEJAxw56avL/EPtipmb0IvFrOeWATHr/jPdf16AZ2r1ol8
 lldX57TtzuI+dqfhI8/uRmoxYuYnK44gOKE6SdMuH76wJIv3/Eph2YceoGP5q7IBwYjw46++G
 DaVunc8zXmH9j68nSR4Cgd4VI/kkJu1ZmYlSyb+JW9dlhu0w7TDCPLPAtpRpgQyube7lihqAL
 louJJKckkIE+AqTetPLuhTQ56sOzO1OWDbPm23x7g0fkIT1DoioRuTkdVvDe1zUB9T1C18RLL
 ZmcnvO4YsMBafEmWVSuz0LKWfzZbtR8ToKQAiVMQn0OcU0n3Oggs9RJYX9kldh6ixCqh7YuxB
 k2wnzyx6F4YQVF+pbj2HW13mbXGlClF4kup0GWh8rDZcN4eL7MJIwB7erfPnur/J9iqoxAvP0
 UFcq+2oIX+WThuSz3FmbLjT46E/yHqmlwSDJf13F2dyuvOpPv5qDMWYbeAlRj5+ornJsG6pS/
 uWZffzjCYgR+4ocalqa8bVLq+bA6HKIBMWuYvhiUcu/KGWiAqK7+5S6kCOSbGPXzc4RgohxGv
 lZx1gQXs2uAcx6q/Gr/SNwsrB7aeAA+qP5KVwLgLCkl60pWeKBNt/M/AoMf53u6rtKM+D4tzH
 GIO7owcomTD4hYdjvD57YzgQ==
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

On 10/22/24 14:00, Simon Glass wrote:
> Sandbox is its own architecture, but sometimes we want to mimic the host
> architecture, e.g. when running an EFI app not built by U-Boot.
>
> Add a -N/--native flag which tells sandbox to reflect the architecture
> of the host.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v8:
> - Add new patch to control on-host behaviour
>
>   arch/sandbox/cpu/start.c         | 10 ++++++++++
>   arch/sandbox/include/asm/state.h |  1 +
>   2 files changed, 11 insertions(+)
>
> diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
> index 81752edc9f8..2940768cd1c 100644
> --- a/arch/sandbox/cpu/start.c
> +++ b/arch/sandbox/cpu/start.c
> @@ -449,6 +449,16 @@ static void setup_ram_buf(struct sandbox_state *sta=
te)
>   	gd->ram_size =3D state->ram_size;
>   }
>
> +static int sandbox_cmdline_cb_native(struct sandbox_state *state,
> +				     const char *arg)
> +{
> +	state->native =3D true;
> +
> +	return 0;
> +}
> +SANDBOX_CMDLINE_OPT_SHORT(native, 'N', 0,
> +			  "Use native mode (host-based EFI boot filename)");

We should not need an option for default behavior.

Please, turn the logic around to avoid users seeing unexpected results:

 > +SANDBOX_CMDLINE_OPT_SHORT(non-compliant, 'N', 0,
 > +			  "Non-compliant sandbox, for testing only");

Best regards

Heinrich

> +
>   void state_show(struct sandbox_state *state)
>   {
>   	char **p;
> diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm=
/state.h
> index e7dc01759e8..dc21a623106 100644
> --- a/arch/sandbox/include/asm/state.h
> +++ b/arch/sandbox/include/asm/state.h
> @@ -101,6 +101,7 @@ struct sandbox_state {
>   	bool disable_eth;		/* Disable Ethernet devices */
>   	bool disable_sf_bootdevs;	/* Don't bind SPI flash bootdevs */
>   	bool upl;			/* Enable Universal Payload (UPL) */
> +	bool native;			/* Adjust to reflect host arch */
>
>   	/* Pointer to information for each SPI bus/cs */
>   	struct sandbox_spi_info spi[CONFIG_SANDBOX_SPI_MAX_BUS]

