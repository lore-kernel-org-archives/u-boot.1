Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8044C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 12:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B199387C01;
	Wed, 31 Jan 2024 13:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="atg4mP7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CD2B87C02; Wed, 31 Jan 2024 13:36:53 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0330A87B71
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 13:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706704606; x=1707309406; i=xypron.glpk@gmx.de;
 bh=6yTNCG+Eh8cKXHSZTPBX1e67+V4b79vwrg7kXr3IDd4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=atg4mP7WptXwGyATrsMs7jkBMO4O9t+qwIi7sCXBZIG8hDvKq5y0ycik2k3f2W0E
 0+pBmeawRQfL40Rm+ewGwBRoiojQWRy7gpLbA/fbMCq2e94E7LnGrjKHfLLZZlsD/
 2U6UM1PNir+21HCJTaB/B5uJl54cxdpHcbX7CGHb6WxaN+FyXlm+U9Jq8Z0k1YovS
 iZV6I/T+oby6KXysc6sv34lLDP+7uJh870BsxB9bnJH4LFo7GDQ5C+EIs5SxM0DSl
 ZP9Gxm4R8aX10uw7fbj08p/pgDkikpld5ebyfRsIoBOpmTm2IqHdUcR3N9wR/IpIK
 ZEaoLS/auHyLjPGobw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzOm-1rhIMD3iJg-00PLs6; Wed, 31
 Jan 2024 13:36:45 +0100
Message-ID: <9f196161-e94a-4416-984b-afb7f310508d@gmx.de>
Date: Wed, 31 Jan 2024 13:36:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cmd: rng: Add rng list command
Content-Language: en-US
To: Weizhao Ouyang <o451686892@gmail.com>
References: <20240131111217.30124-1-o451686892@gmail.com>
 <20240131111217.30124-4-o451686892@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240131111217.30124-4-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XX09bV+i9deKVfn9O6ASTHcCCI6UyNGd6i0HBpZz3XaRoGRGRfC
 9joKQgexMsRnldEVTfpHSpOWMXlOqohYVVHtQrVb4DarAsfqOPnP3vKVf+XBsXXJfZprwaP
 uCdgMvZoPZ5lfsq+zvwdmo6OhldQ/M/SvqaHVSvuVIq0+dcUA1CEsTMYww4hRTt3dhOCmvA
 QVg3vTC8apPgwoJ5ATA5A==
UI-OutboundReport: notjunk:1;M01:P0:zim8QnPf+xM=;AQoMmTIzUeUpPjPK14Lp01iFK5A
 bgUzYyjS2CSNi2BBs7o/HYjOlJR1VorWWjP1eDOs9FhWTsnCRBTgxXj/w5kbGs+BpFbVq30z5
 WVygpTbkbISBeFoDqKZrYbfkplW3U+RaV1ezyNj1FwayXNtgVy366kI532Hw+b7sJbvP9TJfI
 UNwAdSk/4jMPLYudp6HROHcxwpfiQLQnA9ac77nEm053Q8SqD+0SKUFr1ZbrQatBIPhiOC8Jt
 C+0AdEf1M4rwX3dPOH2HE8CcOmQ9lQ5pRX4/uAtkaTTLs9cL26EN4iB0apqhXCrwbivgoFfih
 IX8/h0nUBvklKLIm3QL76bIZtJEDcIyrQSW3foFf8sCVSBse8h6VUucZvjBfKO0OsgyuF0d+l
 ty4QKk4uQCikSmp8lrCh3xql/v0NBACJPCP65CrGoh664LS7siUqnm2yKZyqyXsVtiZyraHVt
 rLUSHacohCuXz7w0Bb9c2YAM4A+XeHl4VBfGPMy2cRkmTvTI6PZq+x/KCx04WLGBXsai9Bf3M
 Or1dEJ3s/sGWmrcQ1BcCsAVtcor9g+66NI04EChd91cIVozpUlxUH7i/vHxmxACC2EVpqytOG
 fJ6+M7drEXuJO7XqbEMBP1SBstwK8ndYDfXDm/F07vFOWPCzso+quMKIsngLD7y8Un3zCCGpj
 v3G027q1NbdZYUKgYVECEHK5lF3qtHmsjTiutuHV0q11LB0IPAE/WaYk2XaHviw5Wbesb2MFr
 hLhr5TPhmLYWhatqDkq4yTbSmVuloQ0fr5OHFMIy886nfOcr6O7NjSCCKTkb27on8SToElpu5
 HUvMToNToY4Z8UIBYQYHYqpnUt4UpezZOiYpq/c0Sesm0=
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

On 31.01.24 12:12, Weizhao Ouyang wrote:
> The 'rng list' command probes all RNG devices and list those devices
> that are successfully probed. Also update the help info.
>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
> v2: update commit message and rng help info

Thanks for updating.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   cmd/rng.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/cmd/rng.c b/cmd/rng.c
> index 52f722c7af..b073a6c849 100644
> --- a/cmd/rng.c
> +++ b/cmd/rng.c
> @@ -19,6 +19,22 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[])
>   	struct udevice *dev;
>   	int ret =3D CMD_RET_SUCCESS;
>
> +	if (argc =3D=3D 2 && !strcmp(argv[1], "list")) {
> +		int idx =3D 0;
> +
> +		uclass_foreach_dev_probe(UCLASS_RNG, dev) {
> +			idx++;
> +			printf("RNG #%d - %s\n", dev->seq_, dev->name);
> +		}
> +
> +		if (!idx) {
> +			log_err("No RNG device\n");
> +			return CMD_RET_FAILURE;
> +		}
> +
> +		return CMD_RET_SUCCESS;
> +	}
> +
>   	switch (argc) {
>   	case 1:
>   		devnum =3D 0;
> @@ -56,12 +72,9 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[])
>   	return ret;
>   }
>
> -U_BOOT_LONGHELP(rng,
> -	"[dev [n]]\n"
> -	"  - print n random bytes(max 64) read from dev\n");
> -
>   U_BOOT_CMD(
>   	rng, 3, 0, do_rng,
>   	"print bytes from the hardware random number generator",
> -	rng_help_text
> +	"list         - list all the probed rng devices\n"
> +	"rng [dev] [n]    - print n random bytes(max 64) read from dev\n"
>   );

