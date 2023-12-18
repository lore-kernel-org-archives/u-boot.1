Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4151C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 22:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B3F87505;
	Mon, 18 Dec 2023 23:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="OfZrNSbf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A3E0874ED; Mon, 18 Dec 2023 23:32:20 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA08387227
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 23:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1702938730; x=1703543530; i=wahrenst@gmx.net;
 bh=VvuF3dnURkRcnROmakZ/ym6n/8+oLJ6wwFBLmBqU5iI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=OfZrNSbf6pTNw5CD8BaxJQCc/Uk1x02idTx4WTfifCzAm4KMYaSSV5xAUSE1czxb
 uMCqQChBxEE33VrIE+QSYRkIs8e3OyanfvyJSKrK9MJwf6S5awIRPQJMaQZtkNr9K
 7HDEvihxOJf/1Q38M2gHeMWhoRJEFRN/fEO+RX8/6ArSKkmXZwZOGEicSkENFDVbL
 1qhqOGU3eRcI9e0suy4iKs7ZMfTMzWzDbE3OvAJ/X9B3YrN1CtIDGP+9kljsPFuNc
 d2f4v6MPXFi0hl1kSWpYqckAHacStVMEfdglgJIxWn8djgj8AfVQBf1uSkgX/3dww
 KwGyxtqDfWQlNUpwkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.130] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs4f-1qtY3n15Zh-00msIR; Mon, 18
 Dec 2023 23:32:10 +0100
Message-ID: <7764be07-c3cc-47e0-a284-4ba9420a843f@gmx.net>
Date: Mon, 18 Dec 2023 23:32:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] bcm2835: brcm,bcm2708-fb device is using r5g6b5
 format
Content-Language: en-US
To: "Ivan T. Ivanov" <iivanov@suse.de>, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 florian.fainelli@broadcom.com, u-boot@lists.denx.de
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-5-iivanov@suse.de>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231218210341.30073-5-iivanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ZkoU2CUN4kT51nF9hOVCQbfgf20tovrXmG0J23vLmIrWJB2ro/
 9rSdZPt6mNRrtvQpyGGR7hxwTj6zRsxiuNR3XNYRAM1aTS4LXbbR4G5gZSGEyG8z0pXfkyu
 mpHTlflWyL0RnK0RoL/sm3MqiyAz6f0FdfOyC+o4PlkOIlPFR6/xhyatA/3FAzH4B7hpZ5q
 lh8q5N+TUOzJ5sbsURpCA==
UI-OutboundReport: notjunk:1;M01:P0:jXiWrw5Y64s=;aUmK2U4nAUrhzRfn1bywHnB2H/4
 Vlhirh679KO2/VIYCZdLaj6yc1x+lppQhHal318qXvs+VHIV1aD4ph3Fh+Agf8vK8/PI3Jm4i
 FiC/wxi8YnrsUiEwTrszh6V6+acGzToVWT5DWNMYt06FsqjuXZmsc0l2t0q3YUQ/aRwyPNC0O
 R2JjMpd31/6SQUiq9V3xn2EdSCfRZkiUbgR4eeQ7xZEWN2WBJIYduj16SAl8g7ZceJk8dHCrt
 /29ubc/1bcYQHTlrxwKnYY35TBgj6DG4OtkYXXgKseTFlm11RMDEdjHWC312VaQBdnEdg5bQa
 3D7+tPu/DzwEICS7cFC0Ak53WfpwlTlmQaNvVzfsPzJh9MDI4d9sM9OpPH97ozjswbUMad2gg
 06qfEAFZx2R99RuZgLBTsOvDS+wrSF+kFZCTYSbl1zp7Qe+rMX/mEyFeyUYQoOI0MzrE7f4LQ
 8kliqa/ajTnl02P+w2IroBk+qVIbbPkEKxbjZk7ioHenagUXHl6dn27giFsDhNmfzklww0CBs
 MG++DHT3RGtOk8bwMEaClAKyryBNV9FNL+o5k1+bl6584OHcsDjwZJx74LcoxM5ebxCRrtleb
 N8Y9/qHKQob4MiX9nrFg4IuLol1SpjUVJbd2AyzMFrEFKjX/Kms3YgWcgcOZpeJ25rWjZiVF2
 9DSSJiwGVKfNNvdGT++aJwWLFOFQmNZZvjQJcowU0fUfAG3lH3TO/m/x/IernaA1woJ3umEgf
 DIMk6EeQWPiNmDicHgeTbyNsZyP7v8eJh0lGiJuLZNugRvKtBe5TPgP3N44BShGCOPBUnWZPd
 +GoCrfJqE+oKpUJ8sxkHT+7PetSmI+ygg4839rk76S7UiAIx1xNfgyKFe0FLHlpbKDMa+ex7u
 YyvWn4opwqx2i/iNB2tV+xYYRQcT9bn10LSXRIwJZ+tnEt90ZgHcHwrR3PYIrLDYUlRE+cHCz
 8BD7+A==
X-Mailman-Approved-At: Mon, 18 Dec 2023 23:33:51 +0100
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

Hi Ivan,

Am 18.12.23 um 22:03 schrieb Ivan T. Ivanov:
> brcm,bcm2708-fb device provided by firmware on RPi5 uses
> 16 bits per pixel. Update driver to properly handle this.
>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> ---
>   drivers/video/bcm2835.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/video/bcm2835.c b/drivers/video/bcm2835.c
> index 14942526f1..245c958b6e 100644
> --- a/drivers/video/bcm2835.c
> +++ b/drivers/video/bcm2835.c
> @@ -43,7 +43,7 @@ static int bcm2835_video_probe(struct udevice *dev)
>
>   	uc_priv->xsize =3D w;
>   	uc_priv->ysize =3D h;
> -	uc_priv->bpix =3D VIDEO_BPP32;
> +	uc_priv->bpix =3D dev_get_driver_data(dev);
>   	plat->base =3D fb_base;
>   	plat->size =3D fb_size;
>
> @@ -51,11 +51,11 @@ static int bcm2835_video_probe(struct udevice *dev)
>   }
>
>   static const struct udevice_id bcm2835_video_ids[] =3D {
> -	{ .compatible =3D "brcm,bcm2835-hdmi" },
> -	{ .compatible =3D "brcm,bcm2711-hdmi0" },
> -	{ .compatible =3D "brcm,bcm2708-fb" },
> +	{ .compatible =3D "brcm,bcm2835-hdmi",  .data =3D VIDEO_BPP32},
> +	{ .compatible =3D "brcm,bcm2711-hdmi0", .data =3D VIDEO_BPP32},
> +	{ .compatible =3D "brcm,bcm2708-fb",    .data =3D VIDEO_BPP16 },
this change looks wrong to me. Before we used VIDEO_BPP32 for
brcm,bcm2708-fb. I think it's hard to explain why we should downgrade
the other boards. I would expect some brcm,bcm2712 compatible at least
this needs an explanation in the commit message.
>   #if !IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB)
> -	{ .compatible =3D "simple-framebuffer" },
> +	{ .compatible =3D "simple-framebuffer", .data =3D VIDEO_BPP32},
>   #endif
>   	{ }
>   };

