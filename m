Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49348E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A07E8021D;
	Fri, 20 Dec 2024 03:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dpXmwrxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57C3E80312; Fri, 20 Dec 2024 03:42:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48FB48021A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734662515; x=1735267315; i=xypron.glpk@gmx.de;
 bh=f/Ylad8vQilcQbjhR7AdlvVzaDJXdsSD5s/aTAT9ays=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dpXmwrxYk9FjqbYgGlKV6fUFKx27gZhY4ZeNcmftJQr46izoSLUvR0zS7J210pqt
 JuVTBq/pWS5BDaR78LRBPYxTzBwCMbO5GQau3wpyF4tufiMmGrj7fbT+Xhsumakyp
 kIQ4I3rMiASdp58m43yHzqBjPNy6OB+Y7LeM6O+uVxi/OI8cUDw/KZPpfhvh4mWL0
 NKMDKCA1YGN55AOvFR44uLvwHhUWIkJ3rIQHJlbnm1Hycxv+StaCW2MqyUbRq8CE8
 5nZ6Y1O6U4BQSIUKrI8cSUfobq70TZBpLpuL8FAxXOtxT0e/IfuHfibjqm6rY1cRk
 c8IGUxQy6QVucdOLag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Z5-1tl4FM2Ilv-00ygfJ; Fri, 20
 Dec 2024 03:41:55 +0100
Message-ID: <14e2e605-b6c3-4a64-b200-f628f0101c18@gmx.de>
Date: Fri, 20 Dec 2024 03:41:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] fdt_support: board_fdt_chosen_bootargs() should
 return const char*
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: u-boot@lists.denx.de, kernel@salutedevices.com, rockosov@gmail.com,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Devarsh Thakkar <devarsht@ti.com>
References: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
 <20241220-board_fdt_chosen_bootargs_improvements-v1-2-f6a7181787c5@salutedevices.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241220-board_fdt_chosen_bootargs_improvements-v1-2-f6a7181787c5@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pp6KJllxjWSCjpSHnVPM9LskenoOr3LH2XBBxPFH2Jahd5u2uQe
 eGDkf7kzT5Ostk2PYv2fPlYTWOOJR3UXRRcTEkNbdc5oCJK2EUosn2VQBseMdFQQfDLGiEh
 yd+NCGcAMf36yzz+hXsdzDhY+gitNYUyNi+gPbMuCISIqPMCYEDvb5WoSopvPq7Ynro4get
 JoiRbZFNNY3DuN4RFguoA==
UI-OutboundReport: notjunk:1;M01:P0:zLrwqIy7ARY=;FXPGfyXKwCVDtcHOND9kswuIbKe
 WGcJKm+/vwhhlEHaYTloS1CO2b5NwLjCN429Fwg8aK476GS3YLDu+XJoMMxJPSjyRuI2CbQOe
 oo/7d4L2Qes6RE7Ytk0COKaCM4Csj8X73n9xMfQTNg453T8Xq/b1+mPjqVetp2yffwd+Pb9NE
 x0/IS6AT8jef3M+eMDRT+TejqpMxDnPMuCGpTZaS8nUdh/VM2KadurJMJcGyJbYLXBkkT7Tmz
 lDkKC8Mv9ltNOYrvH+QtgHMOSml5hpXcgVRY9KaC64yWJF+qflVOqbZ0/Qn7ki/q57WrRl39b
 EAT2HScLX4oDJ1+fdmb1MDAX42f7G6vcD2o9JB7mnExjCYUAmYWC3spFy+0gfDJwqf6vhPrQ0
 GAtcO7O0qZYg+IA1r2N3vgnGL3DMv6gqHPXi5XRxCJFBUKXYk+5HdxNvOXXnXWfk5/SjAFPZa
 JqobtYF/tsRa7qmbd6cv1npLK3jxySO2UzeJOfOcEsxnvK4rTkWWiOBowwfxHMR7+M0MHM/IF
 jBb33CJzHGC9bNo5jPwGpKxL5mBnHRZGk/+dUnvqaXCIRnH95W8y1F1szw9WJVpPMtWexqeiD
 11fSjMvuLxCaTSEhOBv6Ch+vByPp0OOdU7HY9risQ2bd0AV1p7QEynMxBEKN5f8g9BljSnRwE
 BOl8vMupWdO6JBDXAyNd/gSVtIs4dyfU4mS1eH8m1B16bghuKFIItbAGsa4Zu5G0gNqOe6NBY
 e2MrsuLVMhyJOdMFW8JOTB0dIoW2FiBhciivrKivWLdNhIgWTDt0t+vq2llHMQxua4zMoDC7O
 tZP/x078ADIrvdicWxcmtwC6k3P5BBv7+ou4l9VnAbkfU0FtgtAajcu+oGqPE+YOKms2v0pCD
 d1fOwmGudrIdvo5Z3K1o9X1h7qXtHW4S01nrkwXDruZEARLGnCpN0soFgLKJo4Hw0SU2la6NO
 WwE3//Q9c3bq5HKeFyPRZUPw+u4Z/UZNciH1bcY9pZaSeoEqvpD6SJ3Iu1zJRVICX4COZUI4s
 6y4ysVKX9gQN6ep9jR/mr6ciWL+6/5b+9+HJTXRQMPzsNjxdJI5jlCKxHUHis7cKc82+yupP0
 VPREEnwPPdb6i8OBl64CQkP7fGLo7z
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

On 12/19/24 22:42, Dmitry Rokosov wrote:
> It should be structured this way to demonstrate to the caller that
> freeing the return value is unnecessary and that the caller cannot
> modify it.
> The function fdt_setprop() includes a parameter with a const char*
> prototype, so it is better to use the const qualifier.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   boot/fdt_support.c    | 4 ++--
>   include/fdt_support.h | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 2392027d40ba292a4cd714c7f23497e9879ac454..2c39b2dd14b7c447bc4c7c8f=
ad64e22cb00e88e0 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -321,7 +321,7 @@ int fdt_kaslrseed(void *fdt, bool overwrite)
>    * board_fdt_chosen_bootargs - boards may override this function to us=
e
>    *                             alternative kernel command line argumen=
ts
>    */
> -__weak char *board_fdt_chosen_bootargs(void)
> +__weak const char *board_fdt_chosen_bootargs(void)
>   {
>   	return env_get("bootargs");
>   }
> @@ -331,7 +331,7 @@ int fdt_chosen(void *fdt)
>   	struct abuf buf =3D {};
>   	int   nodeoffset;
>   	int   err;
> -	char  *str;		/* used to set string properties */
> +	const char *str;		/* used to set string properties */
>
>   	err =3D fdt_check_header(fdt);
>   	if (err < 0) {
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index ed4f5ba26c19b2d0afcc43c46bdee3c211c0441a..f481881ce640797e0f6204d5=
99f008d0e5dc2bf7 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -236,7 +236,7 @@ int board_rng_seed(struct abuf *buf);
>    *
>    * Return: pointer to kernel command line arguments in memory
>    */
> -char *board_fdt_chosen_bootargs(void);
> +const char *board_fdt_chosen_bootargs(void);
>
>   /*
>    * The keystone2 SOC requires all 32 bit aliased addresses to be conve=
rted
>

