Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3BFC47DDF
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD769878CB;
	Thu, 25 Jan 2024 15:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="H+oNTAE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B688E879B5; Thu, 25 Jan 2024 15:50:01 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D5D87015
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706194196; x=1706798996; i=xypron.glpk@gmx.de;
 bh=4npTMfKvuN+gKsZ3FmsKfw8UEfI7Y2gBGA5srGAeD8c=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=H+oNTAE9PdGVjJpg71j0oNmXTeJnth9VFGFtDCEda9ejLqlp1ZUqjYkRG+w5njj6
 WUE7vJENwBd908UxbVQab+F+x94++f8K+wXDa/1ikuOoORix79ekekfUnUupEzLq6
 IaDygd5F39hYF3qCo0Hu4pzzqZjwbD7tdDslbWcVuJV2voGNFjbtc0eMH9t5im3yh
 lssb7QivdtPs/C3oXCmLoYY1hSy0ye0oN8qGmk6YwKTppXNmuI1qB824TmY6GtqaS
 jkEBnNcHFVe1RQA6lsshdN/zJMyfSAA9yiVnra8V1L2aGUDhELhl3zWaPqIby6zyD
 ntvku48/tapX21izzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1qumIN0QTP-00bO4b; Thu, 25
 Jan 2024 15:49:56 +0100
Message-ID: <94019c2e-44bb-49d5-b1ce-beebb0085871@gmx.de>
Date: Thu, 25 Jan 2024 15:49:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cmd: rng: Add rng list command
To: Weizhao Ouyang <o451686892@gmail.com>
References: <20240125140502.22400-1-o451686892@gmail.com>
 <20240125140502.22400-4-o451686892@gmail.com>
Content-Language: en-US
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240125140502.22400-4-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QYavP+2sqNiYG6++pAXppEtj0SVI8dKq7ajGXIlQv+QebhpVFGA
 3PiEmZ9VVqLQcHvgCptQIOgOyBY678u6Tp65XL4g3GoLXXrxVWmpkfcTawCq9FKJ6HuPea5
 K44L995M2zQYprOPXG1lgT1H+z40fVsxX3rYDL5IL9yDe38fpbMoBETlLj5xTFBhn/o0GW6
 InJZ0Jfp1YpqXXOoaDEKg==
UI-OutboundReport: notjunk:1;M01:P0:AlSgv4v3xUo=;CxxNeEura3631hP6kb8h+JDpQdf
 qeOm80mCD5SLBFr5e7gAN469+thKAtUCwWZ+NNCBHstMQyCAzT1/XQPykYGAhG+RPOzcDM2wu
 8i85lmCXA8dJEgIpJ8ZFoZHAVYfF3wTdZsVRvz36qJqTpM+gCCEvYA+dssHZSa2f3h9GqiUnD
 hcE7NiwkAjCKMSETRKRsdqHHCClKQuD/F05gyFsdBE30cH1o5kkJZecrcDY6mJTDqulE8bVvZ
 G/1x2O+d7ASoUhjc21e0akrAOG+YXBiGN8YL+GWpt9NcAlgnr7345W//wZsPjcgTIkh/kQzFh
 qbu3S9io+3iEdv3ypkhyynQ08NJNP8SlRNF80OCKeYjGBGOyNwX+BA+JlWD2wrqDuvEL/VTW4
 VBv3P02uqWYueU5JtnRJfnVhwToEuN1c7pWFh9ZB6eSSj0tio7hUOMgCGzC+HXurvTAtJFa5l
 R6axl3QUqg5U0xy+I7ziQQAlJyE7d+BEGag7i4pX6YFMEsFaXhsKRIOm3d/dhAs7nl5ynhpbN
 93k/l6fNRP5LCfaCU9Uy3hovKnLB867gllplF+oBEsEJC2uyjzgFlnoLCEzbIxFQmEzCP+6ug
 NR3RH7OyS0yoTunQ0+quYixhpXxI8+C+ITczFVrOVNXEu+Ilzc427Cb9opVFGMNQZvSPW3obh
 6j/rp4y3uRqN0iPaGfzdW52pdw69l8uDu1SCNPEQ84GSjffENmbtmHyY+JwGua+eH1Bbq9XpK
 lvSkMkh9h8FmsiXYtLZGyD7GExKbJ5s8CEXHVpx+x0/CkYS4sMNlVGAiAUDvIqb0+RnYLVfZo
 rfBY9Jk+jZbDLEYtCI6TZoiT+h9yhP677E97BHLy3ZnKpj8zoBzzoo0aOqK1wmyF0rwAtG31F
 npqCxICpeYe51ovS3SPcSi0sqWcaQE1paOFUlgcj5egEbuYh3c8WJl47w83LhsiFejYKsjNHq
 fi5symAP5j4+p9sRPx/148ilbJ0=
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

On 25.01.24 15:05, Weizhao Ouyang wrote:
> Add rng list command to list all probed RNG device.

Thank you for your contribution.

Would the following be more accurate?

The 'rng list' command probes all RNG devices and list those devices
that are successfully probed.

>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>   cmd/rng.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/cmd/rng.c b/cmd/rng.c
> index 52f722c7af..4818133f94 100644
> --- a/cmd/rng.c
> +++ b/cmd/rng.c
> @@ -18,6 +18,19 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[])
>   	int devnum;
>   	struct udevice *dev;
>   	int ret =3D CMD_RET_SUCCESS;
> +	int idx;

Please, put the definition into the code block where it is used.

> +
> +	if (argc =3D=3D 2 && !strcmp(argv[1], "list")) {

int idx =3D 0;

> +		uclass_foreach_dev_probe(UCLASS_RNG, dev) {
> +			printf("RNG #%d - %s\n", dev->seq_, dev->name);

++idx;

> +		}
> +
> +		if (!idx) {
> +			printf("*** no RNG devices available ***\n");

If idx is not initialized, depending on the random value of idx on the
stack you get a printout or not, e.g.

=3D> rng list
RNG #0 - riscv_zkr
RNG #1 - virtio-rng#8
*** no RNG devices available ***

Do we need the message to be so noisy? How about

log_err("No RNG device\n");


> +			return CMD_RET_FAILURE;
> +		}

We prefer having an empty line before return statements.

Best regards

Heinrich

> +		return CMD_RET_SUCCESS;
> +	}
>
>   	switch (argc) {
>   	case 1:
> @@ -57,6 +70,8 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int=
 argc, char *const argv[])
>   }
>
>   U_BOOT_LONGHELP(rng,
> +	"[list]\n"
> +	"  - list all the probe rng device\n"
>   	"[dev [n]]\n"
>   	"  - print n random bytes(max 64) read from dev\n");
>

