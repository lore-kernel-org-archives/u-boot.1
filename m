Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27920D1CA05
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A0988DE6;
	Mon,  4 Nov 2024 23:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VA33tPHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD42688E50; Mon,  4 Nov 2024 23:30:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2AEA88DA3
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730759441; x=1731364241; i=xypron.glpk@gmx.de;
 bh=8BQ+7tMNR4JlHz1bOfAK7lbsXH6n3kMX0qqVZgHgWpI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VA33tPHN702qIp6DkSPYvw7noawLjLV8H4KdLh0cz2WbhuCk1HMQaubY0FSgYUFk
 wZRLSAWtetqYifsG5zJsfytGVvFTwwwjYgjtfywiRpaZPcQHyNInanIdvCtySUtXB
 +cQWdC2CfzXNaujhugYM6F2y3Xcpvo84yq5AqB02DuGPfpmCVglB3pkHV8zWc6ZAx
 a/uQPLMFk/WvkO6eGEe8dF8IuucSpmK2FtLK130VU9GO8dn7d2oa07rnlItVbl+WB
 MHoHnlZq9lNfVfm8b9K2r7xHznuJcemCiAdK9m5mPwoIb7px5oOmaSBJx/1bJoURx
 G/khCoW/+E5TpTKklw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.108.63]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1tl0e62wBT-00psYb; Mon, 04
 Nov 2024 23:30:41 +0100
Message-ID: <b2cb7506-e3e9-470a-a5b1-64c889032f01@gmx.de>
Date: Mon, 4 Nov 2024 23:30:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Change efi_dp_from_mem() to use size
To: Moritz Fischer <moritzf@google.com>
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, pwildt@google.com,
 u-boot@lists.denx.de
References: <20241104014934.2542857-1-moritzf@google.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241104014934.2542857-1-moritzf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:15dj7ah0QK0Ky0INE5cFQnCkwlJbzB+7uf6vtb8W79Ny5b/EtOC
 gMpPatkm7jKb/mjjW2DFkwDAVBmF65rVn+3cEWk8Vy+AdTMoWwg5TBwUDMh+C7BN1SOlZ5A
 HexWbgVy7hKj0sNcQJDrxgt0KQxoHgoLcHTIfxflD/aB0wa65AP5ydLm+CubzHeekln4hyJ
 S70F5u9120Jf9KJ3W0yTw==
UI-OutboundReport: notjunk:1;M01:P0:HS90/T8wN24=;o+uWTYDF4HHmdsOtXgoq3aoIKyM
 T9wqDfndISls4OkCQKQy3MxQg88nDyO9/ga6vGEeqJwQljzfJ1tYEw+6CmNujJGZSpqhSZkd+
 tTl8CQbS7CcuNExJO4jF8U8SYxWvMxu4GoKtXp/UP58FMClrRT5O4BSEeiu+lA2+6LL37Lqwm
 /C5CTbuxO7M3PRx4awJ1FMXcHPzmr4endpc6T2z+j6wktsxmerb23OqAVzU3fZ4U+qI9h/pym
 A3jv5lDf2EILgJv46e9D6agUCHeXcnfodfJDsMScMxRJEupwEPRhGDGExaTbmEl1bkg42Nsh6
 kTu2gvhnnW9fhWwZpizQDea3lU3CWeTUaeYI3HiDeRNwo4ajc6XXw7e4GSR5XHme4KNtF00Z5
 DUAsqeumvcEghTsyF2WSXyWHHbISYRxy6l7rPWsi0mjKI3026zh2TJLCVFGJEX3TSN7SEIb9s
 JlRIe/IHEMQvU5GnYFU6gOJB9fpDMHYOLUg6w500DCLT1XMcyYQCW5T1n+ZurAHY5fY1cT0zC
 Va4Fz8NzraHSgPONnlIq0noI4refqozKTmQT2Aq+Ytu55qQkjDivDeUoqaof8y3zVLPJZ2yZG
 fIzrjMyqBpwwjClIFR0nxEd1ECJWnrus4HH+eej80kjEK9Iqca/rPAtexudRTOUAmRLa0ParX
 evJs8ljE8csTuAxsU7pzcp81CXowfMghv8ruPC0On0PoOOklmkxTiEBijXAjmce9VMzq1yZXT
 /5t2AsweC3xURLJIsBRiUA4SxgxQnYDjTO254YBoyAiSo1huNcCHKQ/c9auBYBA5zPHgQXj18
 qkBQyBEZk6kOfcQFb6DW9wFw==
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

On 11/4/24 02:49, Moritz Fischer wrote:
> All call sites are using size rather than end addresses,
> so instead - as previously done - calculating an end address
> everywhere, just modify the function to use size and internally
> calculate the end address
>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Patrick Wildt <pwildt@google.com>
> Signed-off-by: Moritz Fischer <moritzf@google.com>

This fixes an incorrect usage in lib/efi_loader/efi_bootmgr.c.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> Thinking about this some more it seems more sensible to fix this
> in the function rather than patching all the call sites;
> it seems we even missed another call site.
>
> - Moritz
>
> ---
>   include/efi_loader.h             | 2 +-
>   lib/efi_loader/efi_bootbin.c     | 1 -
>   lib/efi_loader/efi_device_path.c | 7 +++----
>   3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 291eca5c07..39809eac1b 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -858,7 +858,7 @@ struct efi_device_path *efi_dp_from_file(const struc=
t efi_device_path *dp,
>   struct efi_device_path *efi_dp_from_eth(void);
>   struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
>   					uint64_t start_address,
> -					uint64_t end_address);
> +					size_t size);
>   /* Determine the last device path node that is not the end node. */
>   const struct efi_device_path *efi_dp_last_node(
>   			const struct efi_device_path *dp);
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index bf38392fac..a87006b3c0 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -137,7 +137,6 @@ efi_status_t efi_run_image(void *source_buffer, efi_=
uintn_t source_size)
>   		 */
>   		file_path =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
>   					    (uintptr_t)source_buffer,
> -					    (uintptr_t)source_buffer +
>   					    source_size);
>   		/*
>   		 * Make sure that device for device_path exist
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index d7444588aa..ee387e1dfd 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -977,7 +977,7 @@ struct efi_device_path __maybe_unused *efi_dp_from_e=
th(void)
>   /* Construct a device-path for memory-mapped image */
>   struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>   					uint64_t start_address,
> -					uint64_t end_address)
> +					size_t size)
>   {
>   	struct efi_device_path_memory *mdp;
>   	void *buf, *start;
> @@ -992,7 +992,7 @@ struct efi_device_path *efi_dp_from_mem(uint32_t mem=
ory_type,
>   	mdp->dp.length =3D sizeof(*mdp);
>   	mdp->memory_type =3D memory_type;
>   	mdp->start_address =3D start_address;
> -	mdp->end_address =3D end_address;
> +	mdp->end_address =3D start_address + size;
>   	buf =3D &mdp[1];
>
>   	*((struct efi_device_path *)buf) =3D END;
> @@ -1073,8 +1073,7 @@ efi_status_t efi_dp_from_name(const char *dev, con=
st char *devnr,
>   		efi_get_image_parameters(&image_addr, &image_size);
>
>   		dp =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> -				     (uintptr_t)image_addr,
> -				     (uintptr_t)image_addr + image_size);
> +				     (uintptr_t)image_addr, image_size);
>   	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
>   		dp =3D efi_dp_from_eth();
>   	} else if (!strcmp(dev, "Uart")) {

