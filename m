Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C8BC072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 02:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D617286D9A;
	Thu, 16 Nov 2023 03:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WcM8lnB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ADB386D9A; Thu, 16 Nov 2023 03:19:12 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D858871DF
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 03:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700101135; x=1700705935; i=xypron.glpk@gmx.de;
 bh=cBc2sdL5k3iZlLLzHxb7ClHfzAyeEG22Ry10lb4iwdw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=WcM8lnB8euTlbP8Om9FRjbjqCtzjeWOjQBkxMP0rsc51y7WAJvloY/ScrtZnW7UO
 3V1nBlLkTlwGZ57tB6kw4eNsOPig/nHewRQHCbdrRnixuPxJs1AX6D+9iSJBcYvII
 JUdYtrvCNstY65jnEWEmo84YdIXtpinVU8wyLSHxDrNCbbXDe0APrvRhdwMQ4bUVH
 5Bce7veA5IOsZY8SK9JPbD4Jx0Ih/qPoNIae9law3KL8WnozenrEO8Qy0dWrnhfW/
 /HdKwAAZZfyHL+WJdvettr2nGH2Z6CpjzI6m1ZXVBJurlVhRnKwNq0GsFrC0mUSou
 x+sI9Ij2vpmJDqHqcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWici-1qsK2x1Qfg-00X5m2; Thu, 16
 Nov 2023 03:18:55 +0100
Message-ID: <ee2def9d-c931-466a-bf78-507887de41c9@gmx.de>
Date: Thu, 16 Nov 2023 03:18:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootstd: Avoid freeing a non-allocated buffer
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Shantur Rathore <i@shantur.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MPP4kwxShVPzhrYnsbkgJJnoJLQWiKeViwfO9QA6A+V79AfQ2QP
 yb+jQRCbWNiBZGkSzi4rNbYRT9PkRsxKHxsEgb+r8Vmu54SNUKmD21gmc6HZ1TO36nkb8qr
 C+dP8FRnJqUuVuyDMOmm2A6jzGh2SDkkk3jBceYItcoueC6tSzgJ9CSh83YKqm4Y01zieY6
 OW0H9yah7TG0yEdGv6KrQ==
UI-OutboundReport: notjunk:1;M01:P0:xT1XAX2g68I=;K/IIIJMP3OaDk7lzB/WdG97lak2
 PWN8qakebjT/MDFQ/XiYaaY47+6WJNZYnB0dZ+AlP/PzikRICWtmN3qcFzQm19vE9z/djXO4F
 +JEq5yxc1NSTpbV7EIV38g2knmYl3VjONoU8A4mksNWXWryuoRRSeYW8PKZ4XdifVm6CeAXRB
 KGRTGRcnqPJSc90bgoja42Wl/LW17vRUjHceshdJCrwnqNmnMWQ1zprJZuMMVWqx3+ZK8IPav
 udZPb1hfZhU6Zr+WISwVikGQwscSLE/cybv0wWUWztVMwBu9VRka/o0A1AjO0v3rDuR11r2dM
 i1JE49hkA3pAc1iFfFcGINYRHJMvaIoeFIFg3bMj5Hb+u8AwJ2tqW3eGv14gK/c35ChDJvsMq
 jKPnUZrQtyiLJe3bif6rbkzJgcIivuM5dDqKMxIaRbTvC77nYZDKF5xiK5FVOZ/92eviLwJmz
 5+JaFLPeBLH0idVWEKP9LmYVLyPtuOdbY+oG55Pnz+9AoHj4+ZJaQSuGXlm2pOihraLl5dwJQ
 RUBNZP4rAVHnIhSwzJdqlWhqpW30Pz/Z8OTnQutIDxRk7Q33AJLg3CPFAT2U9wQjdPlxW+kXF
 HxXsr9HUlIUGDefrQHg3liiRq3+Tr+6TkM9Avu98AewWTOveFuA7YuKTPLrEYwSokPEbXlm4Y
 jZCIQTSe4mCxguVPxKZ8ixulz79lsmlNED5Skb4TJKwp+p2Oq/AjM9bJT+B8098jRvJ80pkuD
 xH7opz4O0haj0HD8N6iVw/k5zYjBhTOxzUJo7T0KtrBhAzTKTst9ncg1/h+JD2R9Wl7jLIL66
 SCIZyDSAwKea4bSIXEfu6/1j0k7pp5SX3WxGbigBIpmJe+KCxQt8w+vgzmhplUUYTxW/DUIiM
 DMOL1xIrWHYGp9xzsbryaGY/hP1zkmXTetGIP45VuH31GHE77i46BPscNQ1TVXMAe6pfvTLXR
 TxWM+Q==
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

On 11/16/23 02:35, Simon Glass wrote:
> EFI applications can be very large and thus used to cause boot failures
> when malloc() space was exhausted.
>
> A recent changed fixed this by using the kernel_addr_r environment var
> as the address of the buffer. However, it still frees the buffer when
> the bootflow is discarded.
>
> Fix this by introducing a flag to indicate whether the buffer was
> allocated, or not.
>
> Note that kernel_addr_r is not the last word here. It might be better
> to use lmb to place images. But there is a lot of refactoring to do

We need a discussion about memory management. We currently have:

* malloc
* EFI - AllocatePages(), AllocatePool()
* lmb
* preassigned addresses like $kernel_addr_r, $fdt_addr_r

EFI manages memory on page level. It needs to provide a complete memory
map to the OS with flags for different types of memory. Currently it is
not aware of where files are loaded and might allocate those regions for
its own usage.

lmb does not track any allocations but tries to recreate a memory map on
the fly whenever a file is loaded.

It would be preferable to allocate memory for files and require to
explicitly unload a file before reusing the same memory area.

We should start a separate thread on this topic.

> before we can remove the environment variables. The distro scripts rely
> on them so it is safe for bootstd to do so too.
>
> Fixes: 6a8c2f9781c bootstd: Avoid allocating memory for the EFI file
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reported by: Simon Glass <sjg@chromium.org>
> Reported by: Shantur Rathore <i@shantur.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
>   boot/bootflow.c     | 3 ++-
>   boot/bootmeth_efi.c | 1 +
>   include/bootflow.h  | 5 ++++-
>   3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 6922e7e0c4e7..1ea2966ae9a5 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -467,7 +467,8 @@ void bootflow_free(struct bootflow *bflow)
>   	free(bflow->name);
>   	free(bflow->subdir);
>   	free(bflow->fname);
> -	free(bflow->buf);
> +	if (!(bflow->flags & BOOTFLOWF_STATIC_BUF))
> +		free(bflow->buf);
>   	free(bflow->os_name);
>   	free(bflow->fdt_fname);
>   	free(bflow->bootmeth_priv);
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index ae936c8daa18..9ba7734911e1 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -160,6 +160,7 @@ static int efiload_read_file(struct bootflow *bflow,=
 ulong addr)
>   	if (ret)
>   		return log_msg_ret("read", ret);
>   	bflow->buf =3D map_sysmem(addr, bflow->size);
> +	bflow->flags |=3D BOOTFLOWF_STATIC_BUF;
>
>   	set_efi_bootdev(desc, bflow);
>
> diff --git a/include/bootflow.h b/include/bootflow.h
> index 44d3741eacae..fede8f22a2b8 100644
> --- a/include/bootflow.h
> +++ b/include/bootflow.h
> @@ -43,9 +43,12 @@ enum bootflow_state_t {
>    *	and it is using the prior-stage FDT, which is the U-Boot control FD=
T.
>    *	This is only possible with the EFI bootmeth (distro-efi) and only w=
hen
>    *	CONFIG_OF_HAS_PRIOR_STAGE is enabled
> + * @BOOTFLOWF_STATIC_BUF: Indicates that @bflow->buf is statically set,=
 rather
> + *	than being allocated by malloc().
>    */
>   enum bootflow_flags_t {
>   	BOOTFLOWF_USE_PRIOR_FDT	=3D 1 << 0,
> +	BOOTFLOWF_STATIC_BUF	=3D 1 << 1,
>   };
>
>   /**
> @@ -72,7 +75,7 @@ enum bootflow_flags_t {
>    * @fname: Filename of bootflow file (allocated)
>    * @logo: Logo to display for this bootflow (BMP format)
>    * @logo_size: Size of the logo in bytes
> - * @buf: Bootflow file contents (allocated)
> + * @buf: Bootflow file contents (allocated unless @flags & BOOTFLOWF_ST=
ATIC_BUF)
>    * @size: Size of bootflow file in bytes
>    * @err: Error number received (0 if OK)
>    * @os_name: Name of the OS / distro being booted, or NULL if not know=
n

