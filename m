Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332F9C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 03:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2079086FC9;
	Sat,  2 Dec 2023 04:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.es
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmx.es header.i=j.viguera@gmx.es header.b="UQI8xeWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31E9A87664; Fri,  1 Dec 2023 15:34:55 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3955D875A7
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 15:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.es
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.viguera@gmx.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.es; s=s31663417;
 t=1701441286; x=1702046086; i=j.viguera@gmx.es;
 bh=AdY15veniyjuwLJis4t8f/mWtA5O/luL3VN+HfTv0b0=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
 In-Reply-To;
 b=UQI8xeWbqD9J60GpNGxx3dkrhmsQ+4QZQ/1B5VnV3eMFRA/qN/EIhtOlMfCeWFI1
 HnkM1iMhBTZ6Miqo+vUtCm+wN+tAj+H4O7TqSZWR0aR9zpoevXCMA05B4sMZ0BqI3
 kj9h8nG8dNoB/qtIDxDhlY3l15y+pLw2ky8szQQvAM803iWgze0CwiyAObnxP2Itn
 Ybaw+/xR+x1Hhs9PL+J+QpCSKq+8WzZblzlRE16/Ya4xkyV1WgB023olmJIEA/5WH
 DB/5jNfrkRIfPclxLLCg3krpKHYYzHmC4dNewNByiyLNrig2roLb+64KpRUugt9AV
 iFngyiD2+bZG/LRLew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.10] ([95.127.30.95]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mirng-1rne9S1Q4y-00ev7g; Fri, 01
 Dec 2023 15:34:46 +0100
Message-ID: <3c90b54d-8e22-4db7-8534-bba5e5451e87@gmx.es>
Date: Fri, 1 Dec 2023 15:34:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] env: mmc: fix environment on hw boot partition 2
From: Javier Viguera <j.viguera@gmx.es>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, Javier Viguera <javier.viguera@digi.com>
References: <20231201110929.1758518-1-javier.viguera@digi.com>
Content-Language: en-US
In-Reply-To: <20231201110929.1758518-1-javier.viguera@digi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zn8wfUqH7vmz5NzmIw3Ajr3nAVN1ILJKUg8QE5v2j7goWFZ2s4H
 HyOTFSAnJXtHtbapsu9KEV6WJw9j2pepVctm5IO1dwkFCeioI4PmzgNWZmS2StVQN+9+61V
 Q9F4AROavEwe9ueO731FwpCdlEPDTD3twKiRsbuUk1WBbAJViTXoA9ZgSXFwvFSThNI9QhQ
 gDmYHewD5ygYqJ6XRBIxg==
UI-OutboundReport: notjunk:1;M01:P0:gVtZ01sYzs8=;fXWwFHyf1z+6FFkuTjCA1uVg2of
 QFGOQmqsQSjdrseDzvLA8JtsbBLIpvg2q0o4P46uGya0VZCb62YNS5Nkbm5FBg8cneZ6SvxpS
 b7ZIXrVM7GWJB/gEAgpI1pOxavOSj11CNov3MyEB7Vyx2yCNX1kaJOALsMTaLKuVxMvctW8eT
 0qU+OSd79Vk1RxGnyueXfLIyPgTX06R9cdLYQp1FTgyMJ8/WdoSkVo1L+kR6BD32zkSTru84Q
 usXmRbpQGHPRvPTRlM2naQPyNYsAuDbnfRldak5cnVQBwCEtooNoX4g1Yz4SLPVIpCVFyTWOr
 Q+edmka9xliNJviZQpQpg8Uq8VsEKzxDWdP2h6vLIzCmraVoZFxHbYQ7cJQnkXnVttXebJb3j
 ahHLNeCF3pALXMPc8Cmj7jkrmGO5JSdZLJb0TqWcVZgffxnbVyu8s9pVUkA272V2zr9DX15Dy
 hzi9cyn+H+nt2AOjKkk9aQW3eqNuKp6VyU5lppL099xPzBuUz5alLDCwYmAeh9qJV3n9emEao
 s5wnMpI4kkW6Nzrz6IPUjnyz3NcVnlSPs7pEPBKQ6C1lZ1cZIR3NOUywMRg5+qOJWhcywOAwI
 NIGAHnxodKvJ9A0lrrx2vN4TRMScOGjgvceFyMG3y3dIRrYSCIUtIAQ6kmC9tmFxvpjA73AUA
 immNXS/aFjeCIuktovrMVfINNZ2NSdZsGMcxjj2s2GW5Ksb86NiapXyjE5OjcWDwV90mwiQBO
 9K2buPbC/w3YWdV2dNFF8On50oSd0ppG3hnv+EspOlmJOHDTQvQzZ2NYafZiiwx8aus5047RQ
 QPgQMFF7md6zClHDbMwcXYTzM7tBgmhQzQBNVPJmQq9GTz9j5ZHa6q+k8ONU0WQaXrBT+ypRD
 jYfaKGRDFKzq9mbnefrYrArNbnew1ysYxPJnj3aNpkWtLrz+OpMCTmwRvI14a1Oeey4KK4yLk
 TaFa8QQSZ+7B31OTrrWEmpfQlpU=
X-Mailman-Approved-At: Sat, 02 Dec 2023 04:03:55 +0100
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

Hi all,

Please disregard this patch. I'm not sure if CONFIG_VAL is the correct
macro when there are no SPL_,TPL_ versions for SYS_MMC_ENV_PART option.

So back on square one.

How do we solve this to support SYS_MMC_ENV_PART =3D 2?

We have a configuration where we want the environment on "mmcblk0boot1"
(which is the **second** boot partition) and the IS_ENABLED evaluates to
**0** which prevents the "hwpart =3D mmc_get_env_part(mmc);" to even run.

Thanks for your help.

=2D-
Javier Viguera


On 1/12/23 12:09, Javier Viguera wrote:
> SYS_MMC_ENV_PART is an integer option. If it is set to 2 to use the
> second hardware boot partition, the IS_ENABLED check fails as it expects
> a boolean, and then it does not get the correct hwpart.
>
> Signed-off-by: Javier Viguera <javier.viguera@digi.com>
> ---
>   env/mmc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/env/mmc.c b/env/mmc.c
> index cb14bbb58f13..df82969d4231 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -111,7 +111,7 @@ static inline s64 mmc_offset(struct mmc *mmc, int co=
py)
>   	int hwpart =3D 0;
>   	int err;
>
> -	if (IS_ENABLED(CONFIG_SYS_MMC_ENV_PART))
> +	if (CONFIG_VAL(SYS_MMC_ENV_PART))
>   		hwpart =3D mmc_get_env_part(mmc);
>
>   #if defined(CONFIG_ENV_MMC_PARTITION)
>

