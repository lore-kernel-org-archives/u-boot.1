Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF05C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 04:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 243C687B4D;
	Wed,  5 Jun 2024 06:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="W4pmrlfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A7B88223; Wed,  5 Jun 2024 06:10:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E8B87AD2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 06:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717560588; x=1718165388; i=xypron.glpk@gmx.de;
 bh=snwQItvIW/8KP0M+2xP6XFgV5K83AfRZFewshGbNhIs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=W4pmrlfEmPia3bujuygDkqDgcVBjWvLPLlMyjbZVMx0klp5ti+JHnqYidWBoZ71F
 ZQZEtdZkMoj9sDoCYHsaBmz4adwYD8z9nPH0BCrbqYpTgaURwecdU1X1OrPb1GkzH
 jkkPGE+HPK9gxEF2MpYxRV+SbaOJ7a1nviqwixTiQpIBX3+f+FqI8lJ1kr1VZLAAp
 kHNDbEqpPPi3sPTgO3h2ggQQ/OFUpWGNGVMMARfHC1mgvKhRaB8UlsNHwteQ70cbI
 486OBOWZ2jIl+go2bJabNdCHos90W8Ht55vOOeqKJcSE/pqglUz5jJit4T6tJwtIJ
 5VK+Zs4G2I3wXxfcWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.178.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QsO-1sdDNS1eUA-012UPl; Wed, 05
 Jun 2024 06:09:48 +0200
Message-ID: <21ec4fcf-0a17-46c6-ae18-6787366e99fa@gmx.de>
Date: Wed, 5 Jun 2024 06:09:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-3-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240605032521.1142768-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SbIvy9tsRtRNaSGTL5k+rCeMfD03eD2Vu4+TX2Po9byAjSnMRPH
 t1zNgUkUa/MHKf+P/aSW7GNG/TrQZhkCW7MJGjFFmAdFwi45PfVwQG86oSEYIDvn9rgq2fz
 kwtatoSWRrTf+Pl6IcNAedxW9nt+dl4UwyPK7h72H5uPfl0StVUVsl/qsWj8YCjdBsnQtHy
 DPEWesHjzyqXeOVsb7v5w==
UI-OutboundReport: notjunk:1;M01:P0:p+wu60TLneU=;RiPaeBd09yvxymJ7d/MeDSO9N/9
 CubMmL+PzhMOiWeEloWpUBrXbCmJHqzN1v4L7l0347YFoXJ1EPCV9smmL4fsGVh5Wg9pMwhHa
 +SxBio8CnSMsdkWppl7hf6aq6giguJDWew+HXknJ5VvLOYUeHB7/FPb4SKxwFsIoW0DQxk4kz
 WrfbizR+m8+kOzyxpzvxs+l1Uxztpj9TQyTP49IRhZh/uNEPmQ8gF5PWBavWu8AJ0GDuBg2xU
 7OmuxzUFW+OSIMqdfVXlA3cbUlOIEkv7J+Hon3lREWpRa5HiKZ2IGruTUFo08dVSM2NfQZug2
 RYbrjK2TFhXyhsqYAi5OzfQbojaG5ggvqJ6S9TYjbPFbyKCRggxy6F/uQ/jDGUHxion97sqzE
 4Rd76EKJx9Ej2IMompkBdYWJOTNhtqnEFOL1vhRXNUCJzU1ZIiFvYpn586N68MYJ2y0E6ruZ9
 nqkdPHsN/jivqcmGbUktB7cCOwUNYO5ts+2TZLwMjbwDKv24tlwbUT549A6QXhXGjhWDZbvif
 q03BQc7QopkYcIq2bWFnMAig6phx55CD8N9cE9Y1Rpo+E2QImxkZ5cFWoy8JWUKI43sHt3O0z
 1tWzPORCQt7uZUOzQh8mmqGjzwrJZ9nV68C7JNb8TxQ7DP/e+3NaM+Yutc6nn1tVRc5M838g5
 L3zSQlYEChNlJdpSH9oyhsA4kGkDtENnqIPMBFl+smeLNukFbpveXILIGhPXvOGF3NQYvn1Jl
 YkYB+xHdKOpj0eAFfGqUAeNUXlWzk0Y3Q3RLGgYZhJmWdvfMT+N1sTu1UrUpS5OL5t8wvmvZF
 b21t221jjJ0BBR3RiIMYtOh5P6/K84OwtlhXUqYZkr9c4=
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

On 6/5/24 05:25, Simon Glass wrote:
> It does not make sense to enable all SHA algorithms unless they are
> needed. It bloats the code and in this case, causes chromebook_link to
> fail to build.

Why would chromebook_link fail to build?
Is TPM used by U-Boot on that board at all?

>
> Add a condition to TPM to correct this. Note that the original commit
> combines refactoring and new features, which makes it hard to see what
> is going on.
>
> Fixes: 97707f12fda tpm: Support boot measurements
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   lib/Kconfig | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 189e6eb31aa..70b32362ada 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -438,10 +438,10 @@ config TPM
>   	bool "Trusted Platform Module (TPM) Support"
>   	depends on DM
>   	imply DM_RNG
> -	select SHA1
> -	select SHA256
> -	select SHA384
> -	select SHA512
> +	select SHA1 if EFI_TCG2_PROTOCOL
> +	select SHA256 if EFI_TCG2_PROTOCOL
> +	select SHA384 if EFI_TCG2_PROTOCOL
> +	select SHA512 if EFI_TCG2_PROTOCOL

You need to consider CONFIG_MEASURED_BOOT which allows measured boot in
the non-UEFI case.

Please, take into account

lib/tpm-v1.c:20:
#error "TPM_AUTH_SESSIONS require SHA1 to be configured, too"

This #error should be replaced by a Kconfig constraint.

I would prefer the select statements to be in lib/efi_loader/Kconfig
under EFI_TCG2_PROTOCOL.

@Ilias, Eddie:

Why do we require SHA1 which is considered insecure?

Shouldn't we change tpm2_supported_algorithms[] to include only
algorithms selected in the configuration? This would allow replacing all
the select statements in Simon's patch by imply.

Best regards

Heinrich

>   	help
>   	  This enables support for TPMs which can be used to provide security
>   	  features for your board. The TPM can be connected via LPC or I2C

