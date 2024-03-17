Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB56C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 09:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B8E87916;
	Sun, 17 Mar 2024 10:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DOTyESnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3CF58796B; Sun, 17 Mar 2024 10:08:29 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E7A878A1
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 10:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710666502; x=1711271302; i=xypron.glpk@gmx.de;
 bh=LC+s2/I+HvqYQ7ZdMeYhdp1IMD9LmwlU2KXsiX474fA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=DOTyESnINvVap61RFzOMB3PaLA2PBwODAnSxBe7mhLD4ldM36y6XHlW59CmhJC39
 e24x2lPqnOAbyUkdv0Hj5fvC0B69QuscA3RYJ8hQQf7xj+bTVydOncHAd5PDz1M26
 V8lEVHIqrWx2QlbSokKbGrl+Ri+TTfqjyjsOI4+tRFzdP8jwez+XtLOJxqbAs87bV
 08EdJCmfTaXaMHaFB2FIpbWUgftsjDE02oWwVqNTvPR8ijV5DvykSKt99C1cGzv9E
 oWlg589txr5u06+WhhaRm5E9ZQE+8eE+eNAr7atnSELNUNk5yKwxr+VOqlSNArHBe
 CtaPTnB/FjTvvMyihw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpJg-1rBtWG01xq-00ZzHr; Sun, 17
 Mar 2024 10:08:22 +0100
Message-ID: <680c7c9d-5f34-4646-b624-490f934f4a1f@gmx.de>
Date: Sun, 17 Mar 2024 10:08:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] boot: fdt: Change type of env_get_bootm_low() to
 phys_addr_t
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2GbFJj/FfOd+svL9SbmFQya8/xvyDdwgseY7hfOHaAKV4Bx4DYY
 Lfy+si+WXlxj5SfInGVYsBPc4TYU5x/3R/fH2eLJDVB3HIPdt99m8ZsY/mBGyP0Q0zw3Gmd
 FG9XXc0NNZFkMqeml9aRBUFIMotod0rLXb2VPDhr8yx+hVy+897RwvPKhsO11S7/i2L+SRz
 kWvvgiacNRm3K5Hti0Ofw==
UI-OutboundReport: notjunk:1;M01:P0:i4ggJ0CJ2YY=;dapihJCU1htbIhJx5Xzsy28s7KQ
 t9Y3e4ZpjeqZDSppErhp5RvxeMUIzbM+uLjiMufZc828YnmZK3prAzH0C0y474AaKwuAOtWN9
 N1mfyuviSRtrUrEx5hX5C0HvLbtTpVH9Xl+DICgUjezKImN5VTeU96MQfSXGuP/xQTFlIbeVn
 g4EfHmqdnqJyKPoxiBsXXbcTFD3MKjUTlG5vayfftgs/TTg4qT/dhqzEmKl4C7HHBe8cWo7FW
 +C5z6BXVou1nc19C9hJliaLgE1Z2ui+2Ntpu6/upeKZEXPhBRxgCywzaaTZ69IzaNgcJ7PFhM
 DCjzfJAadhLPBLoycvUh1+jLhsRXE9nBubvg9lLvWebL+1pqa9djEt071wqzaqLoDoDNAevk4
 o7e5TuxwRC1aQ70cFsH47PBEbzhR8/eY/gQdKtE0uH/wjgq68BfnqOjDfiWlmxpLmPLwVfsaJ
 fGCQZpBFL5Idgq10WuYV8NSsomgHQvwbkCK/Ahi7PG2wuwvpsmODWcPIfEfYKiqa1n03mIp1P
 40sgWASqMRCoB9VRriRVWJz4Mn3WXEgK4hlbM3XNLZHYdG8SXbeO4zmOc/dBvp9hQJznNngoY
 zypRhsgtWahd+w05uUzBKccY7QbAs49F7tOSv14RaqNvrSOB41/OKdDF5cSh+u6ywgDIR4V+D
 s53LNXqg7UkHP7OTodMquo8ed1JCVSQhsoVy5d7/wGjy2ceeZj5hLf2gyG5yP8nQOmqoRc7Ou
 WONBd5L7P+Olz+XOux9jsOvz4VFifCiL8yvZ3nBPCLRd6/DYDGDFL0B5z/no/s/MmtDwUnwWV
 2HyLW81TYyE0AnwQ4UhPu5W0ESGnN5ec79kHPovdSpLYc=
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

On 3/17/24 07:16, Marek Vasut wrote:
> Change type of ulong env_get_bootm_low() to phys_addr_t env_get_bootm_lo=
w().
> The PPC/LS systems already treat env_get_bootm_low() result as phys_addr=
_t,
> while the function itself still returns ulong. This is potentially dange=
rous
> on 64bit systems, where ulong might not be large enough to hold the cont=
ent

Isn't long always 64bit when building with gcc or llvm?

> of "bootm_low" environment variable. Fix it by using phys_addr_t, simila=
r to
> what env_get_bootm_size() does, which returns phys_size_t .
>
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   boot/bootm.c       |  2 +-
>   boot/image-board.c | 11 ++++++-----
>   boot/image-fdt.c   |  9 +++++----
>   include/image.h    |  2 +-
>   4 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index d071537d692..2e818264f5f 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -242,7 +242,7 @@ static int boot_get_kernel(const char *addr_fit, str=
uct bootm_headers *images,
>   #ifdef CONFIG_LMB
>   static void boot_start_lmb(struct bootm_headers *images)
>   {
> -	ulong		mem_start;
> +	phys_addr_t	mem_start;
>   	phys_size_t	mem_size;
>
>   	mem_start =3D env_get_bootm_low();

Please, remove the conversion to phys_addr_t in the
lmb_init_and_reserve_range() invocation.


> diff --git a/boot/image-board.c b/boot/image-board.c
> index 75f6906cd56..447ced2678a 100644
> --- a/boot/image-board.c
> +++ b/boot/image-board.c
> @@ -107,12 +107,13 @@ static int on_loadaddr(const char *name, const cha=
r *value, enum env_op op,
>   }
>   U_BOOT_ENV_CALLBACK(loadaddr, on_loadaddr);
>
> -ulong env_get_bootm_low(void)
> +phys_addr_t env_get_bootm_low(void)
>   {
>   	char *s =3D env_get("bootm_low");
> +	phys_size_t tmp;
>
>   	if (s) {
> -		ulong tmp =3D hextoul(s, NULL);
> +		tmp =3D (phys_addr_t)simple_strtoull(s, NULL, 16);

In C the conversion is superfluous. Please, remove '(phys_addr_t)'.

Why do we need tmp?

     return simple_strtoull(s, NULL, 16);

>   		return tmp;
>   	}
>
> @@ -538,7 +539,7 @@ int boot_ramdisk_high(struct lmb *lmb, ulong rd_data=
, ulong rd_len,
>   		      ulong *initrd_start, ulong *initrd_end)
>   {
>   	char	*s;
> -	ulong	initrd_high;
> +	phys_addr_t initrd_high;
>   	int	initrd_copy_to_ram =3D 1;
>
>   	s =3D env_get("initrd_high");
> @@ -553,8 +554,8 @@ int boot_ramdisk_high(struct lmb *lmb, ulong rd_data=
, ulong rd_len,
>   		initrd_high =3D env_get_bootm_mapsize() + env_get_bootm_low();
>   	}
>
> -	debug("## initrd_high =3D 0x%08lx, copy_to_ram =3D %d\n",
> -	      initrd_high, initrd_copy_to_ram);
> +	debug("## initrd_high =3D 0x%p, copy_to_ram =3D %d\n",
> +	      (void *)(uintptr_t)initrd_high, initrd_copy_to_ram);

Void * may be narrower than phys_addr_t. Shouldn't we convert to
unsigned long long for printing.

Best regards

Heinrich

>
>   	if (rd_data) {
>   		if (!initrd_copy_to_ram) {	/* zero-copy ramdisk support */
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 5e4aa9de0d2..boot/image-fdt.c
> @@ -160,9 +160,10 @@c2571b22244 100644
> --- a/boot/image-fdt.c
> +++ b/ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong=
 *of_size)
>   {
>   	void	*fdt_blob =3D *of_flat_tree;
>   	void	*of_start =3D NULL;
> -	u64	start, size, usable;
> +	phys_addr_t start, size, usable;
>   	char	*fdt_high;
> -	ulong	mapsize, low;
> +	phys_addr_t low;
> +	phys_size_t mapsize;
>   	ulong	of_len =3D 0;
>   	int	bank;
>   	int	err;
> @@ -217,7 +218,7 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_fla=
t_tree, ulong *of_size)
>   			if (start + size < low)
>   				continue;
>
> -			usable =3D min(start + size, (u64)(low + mapsize));
> +			usable =3D min(start + size, low + mapsize);
>
>   			/*
>   			 * At least part of this DRAM bank is usable, try
> @@ -233,7 +234,7 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_fla=
t_tree, ulong *of_size)
>   			 * Reduce the mapping size in the next bank
>   			 * by the size of attempt in current bank.
>   			 */
> -			mapsize -=3D usable - max(start, (u64)low);
> +			mapsize -=3D usable - max(start, low);
>   			if (!mapsize)
>   				break;
>   		}
> diff --git a/include/image.h b/include/image.h
> index 21de70f0c9e..acffd17e0df 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -946,7 +946,7 @@ static inline void image_set_name(struct legacy_img_=
hdr *hdr, const char *name)
>   int image_check_hcrc(const struct legacy_img_hdr *hdr);
>   int image_check_dcrc(const struct legacy_img_hdr *hdr);
>   #ifndef USE_HOSTCC
> -ulong env_get_bootm_low(void);
> +phys_addr_t env_get_bootm_low(void);
>   phys_size_t env_get_bootm_size(void);
>   phys_size_t env_get_bootm_mapsize(void);
>   #endif

