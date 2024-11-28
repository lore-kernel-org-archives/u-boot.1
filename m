Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBC4D70DE7
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 17:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078EB89398;
	Thu, 28 Nov 2024 18:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tN1A6lft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF6FB8939D; Thu, 28 Nov 2024 18:26:33 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0FC38937E
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 18:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732814784; x=1733419584; i=xypron.glpk@gmx.de;
 bh=y2D2yxNgbu0mx+CwjVhC11RNPa9ySp6L3RAiggLXaA4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tN1A6lftswdxSFuLbFzhfnH8c6psizKEA3NivDWHJ+NnS5cyy/HXIbHM0ouY4R02
 vx3QbfPdGxhwlENm7h9uLgCBC1Jr5c9mkMRmUEz09srpAxyfC0SabOUNX9VJTpyjF
 Z7xPFumxq2GHF9wRQ4n0ZTItObEtnJ0N5pSkiT/uBuUfx+0728uv1fRL9kCHyoRTS
 5feGjbzE7VbhvnBcys1AKVec08NY7JbgdNpeEOBXEcD7o95p37h/w3madzPPByNaP
 EWStqlqE9A5wzKpgLmZRcd72iZVbH1DuZpnkgCoUOzDQpOcrqNpk7nqVG9KeHxBGW
 m182JzeKYU/2J/48rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSt8Q-1t7Ot73dnC-00I2ot; Thu, 28
 Nov 2024 18:26:23 +0100
Message-ID: <e04cd688-a39b-488f-a599-b8b1311ca366@gmx.de>
Date: Thu, 28 Nov 2024 18:26:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/28] efi_loader: Simplify efi_dp_from_mem()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-29-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128154727.771871-29-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:54a71d0E8wBxmLoHKu9uWSABt/AQ004RoVntPhaqwgFOKpJuE7o
 DLnYzNoDv4Y6t+SM+jgjH4/iv2b9kPNIwl6pZAaPiVTtYIIp/pPZXq5THkQRQ+BS1WRk2TI
 7c3vnA9vClNpysqbuivLejjbY6coSQcUhMADmhTECxOrOXM1VRwnulQqh69gjYTTSSw6wyO
 JfcuuUoGbrPkNImakn2Tw==
UI-OutboundReport: notjunk:1;M01:P0:VEku8XA8B5s=;HoAWxUt866Wjw1/22usu/txfFKr
 UD+cg9qe6yhx6TRTc+2BkUDwv62XIygXIt7YUrEOjaO/FQRbJTsWI2MjMjPxloL70Rs7Jb3d7
 BbW6gG+DlCv+GMgrKckV1lUvNkKojdfH1z17Zcp5ZXixsc5T2cnNFdpkt1xg4Kt79Kqtp0ecd
 1DrP9c/2X/kUkWVEhyBXAocg660y4GgEzTIjlkOSFf+f8d02omD6s1HOHfDWHgKyRhaHmYl9o
 PHiPF7tAurgfF2wJk/Px082B+5Bvef2LA/cRPEcDmomFRzlfOuT1N//45uPdB1GinEFFihVTZ
 BNF8ZeEyV8S69MmuWkfeGj171H762+GoKPzAKzllh4zQq/vyz8lOeK+jAwCdiXHICJBi2oIue
 5b70Q0rKv8QzgGnrN5Q/BmHmx7Y9n8Ncy4Zjw+IgAOvCnsvY6kXdbCuNk0APqO66ezkSDCp1N
 dSL6OIqRE1DctbRq4rJET/LH6A2Zg497acQl4SXwPhwTOpTUnWG6pQTOYlbKRjrTrO63Jo5zI
 S/wz+ROpmBKHiGz0id2mYVXpKw+LBSPtd4zBMdn1TOKqZFN3m00qo9QNk4qDmDdnLHL08STtb
 bTW+3qqJVyutI9Igl7l0rpaJmdgHyrJ6nvjetCnJ84YYwMPsqPRiSkxZAoOIzOrNB4MMTnY6+
 OR4oml4AP5UxZO83MetzUvCGoDUcrtqwP6wKSFVBw24CaVSIbvAGSJkxLzEUPHPLIW9X/AH2K
 36fRIzTk8GdAOF57KuYWbJcnlaw/O8zYbfLsx2/LCv7SRNx5vUS1OzNvPP756YVBJdO5sSE2R
 B21UumImh4ttD08hZx9yeB8+OahoHMO48VepnPhKsrCV0IZBOpjsCUXycnRnhnvQTjlr3qz1S
 Vh1xb3nPugASZYswkFJnCgknWVatbxrHMULq7x2fGHVX9vLQmQKniYkuVboZC0Xjj3aJlgQ0R
 FJCjStXo1qqJJA3Enbl5dZyFB8vKGWuHhXkjt51UvJS8vpjwBzaV4TUw8cPtKFHsVcEzt2nL7
 +R5m3jSQiNXhqV6FOey1bKnvC4A74B2gzXdxW9iFtlKMdvBMNKT+KPgHdUd1Imin+nRZRHf8f
 JSKH2PJ8CQ1uFxJfhBjy1FWgbgiB0U
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

On 28.11.24 16:47, Simon Glass wrote:
> This function should take a pointer, not an address. Update it along
> with all users.

This function never was meant to take a sandbox virtual address. It
always expected an EFI_PHYSICAL_ADDRESS which must be convertible to
void * as UEFI uses an identity mapping.

A reasonable commit message would be:

"We can reduce the number of locations where we convert from a pointer
to an integer by passing the address as a pointer instead of an u64."

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Drop patch 'Convert efi_get_memory_map() to return pointers'
> - Drop patch 'efi_loader: Make more use of ulong'
> - Significantly expand and redirect the series
>
>   include/efi_loader.h             |  5 ++---
>   lib/efi_loader/efi_bootbin.c     |  3 +--
>   lib/efi_loader/efi_bootmgr.c     |  2 +-
>   lib/efi_loader/efi_device_path.c | 20 ++++++++++----------
>   4 files changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 4e34e1caede..1269907fa3c 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -919,9 +919,8 @@ struct efi_device_path *efi_dp_part_node(struct blk_=
desc *desc, int part);
>   struct efi_device_path *efi_dp_from_file(const struct efi_device_path =
*dp,
>   					 const char *path);
>   struct efi_device_path *efi_dp_from_eth(void);
> -struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
> -					uint64_t start_address,
> -					size_t size);
> +struct efi_device_path *efi_dp_from_mem(enum efi_memory_type  mem_type,
> +					void *start_ptr, size_t size);
>   /* Determine the last device path node that is not the end node. */
>   const struct efi_device_path *efi_dp_last_node(
>   			const struct efi_device_path *dp);
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index a87006b3c0e..7e7a6bf31aa 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -136,8 +136,7 @@ efi_status_t efi_run_image(void *source_buffer, efi_=
uintn_t source_size)
>   		 * loaded directly into memory via JTAG, etc:
>   		 */
>   		file_path =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> -					    (uintptr_t)source_buffer,
> -					    source_size);
> +					    source_buffer, source_size);
>   		/*
>   		 * Make sure that device for device_path exist
>   		 * in load_image(). Otherwise, shell and grub will fail.
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 98799aead84..e3b8dfb6013 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -515,7 +515,7 @@ static efi_status_t try_load_from_uri_path(struct ef=
i_device_path_uri *uridp,
>   		 * will be freed in return_to_efibootmgr event callback.
>   		 */
>   		loaded_dp =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> -					    image_addr, image_size);
> +					    source_buffer, image_size);
>   		ret =3D efi_install_multiple_protocol_interfaces(
>   			&mem_handle, &efi_guid_device_path, loaded_dp, NULL);
>   		if (ret !=3D EFI_SUCCESS)
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index 9c8cd35b97b..025a17b19fa 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -11,6 +11,7 @@
>   #include <dm.h>
>   #include <dm/root.h>
>   #include <log.h>
> +#include <mapmem.h>
>   #include <net.h>
>   #include <usb.h>
>   #include <mmc.h>
> @@ -975,9 +976,8 @@ struct efi_device_path __maybe_unused *efi_dp_from_e=
th(void)
>   }
>
>   /* Construct a device-path for memory-mapped image */
> -struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
> -					uint64_t start_address,
> -					size_t size)

The parameter used to be an EFI_PHYSICAL_ADDRESS in the UEFI spec terms
which is an UINT64.

> +struct efi_device_path *efi_dp_from_mem(enum efi_memory_type  memory_ty=
pe,
> +					void *start_ptr, size_t size)

We only can use a pointer here because we do not expect addresses above
4 GiB on 32bit systems.

>   {
>   	struct efi_device_path_memory *mdp;
>   	void *buf, *start;
> @@ -990,9 +990,9 @@ struct efi_device_path *efi_dp_from_mem(enum efi_mem=
ory_type mem_type,
>   	mdp->dp.type =3D DEVICE_PATH_TYPE_HARDWARE_DEVICE;
>   	mdp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MEMORY;
>   	mdp->dp.length =3D sizeof(*mdp);
> -	mdp->memory_type =3D mem_type;
> -	mdp->start_address =3D start_address;
> -	mdp->end_address =3D start_address + size;
> +	mdp->memory_type =3D memory_type;
> +	mdp->start_address =3D map_to_sysmem(start_ptr);

An UEFI application loaded by the sandbox does not know anything about
the virtual address space (phys_addr_t) of the sandbox.

The device-tree node must contain addresses that an UEFI application can
use as void *.

map_to_sysmem() is wrong here. You could use

mdp->start_address =3D (uintptr_t)start_ptr;

Best regards

Heinrich

> +	mdp->end_address =3D mdp->start_address + size;
>   	buf =3D &mdp[1];
>
>   	*((struct efi_device_path *)buf) =3D END;
> @@ -1061,7 +1061,7 @@ efi_status_t efi_dp_from_name(const char *dev, con=
st char *devnr,
>   	struct efi_device_path *dp;
>   	struct disk_partition fs_partition;
>   	size_t image_size;
> -	void *image_addr;
> +	void *image_ptr;
>   	int part =3D 0;
>
>   	if (path && !file)
> @@ -1070,10 +1070,10 @@ efi_status_t efi_dp_from_name(const char *dev, c=
onst char *devnr,
>   	if (IS_ENABLED(CONFIG_EFI_BINARY_EXEC) &&
>   	    (!strcmp(dev, "Mem") || !strcmp(dev, "hostfs")))  {
>   		/* loadm command and semihosting */
> -		efi_get_image_parameters(&image_addr, &image_size);
> +		efi_get_image_parameters(&image_ptr, &image_size);
>
> -		dp =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> -				     (uintptr_t)image_addr, image_size);
> +		dp =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, image_ptr,
> +				     image_size);
>   	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
>   		dp =3D efi_dp_from_eth();
>   	} else if (!strcmp(dev, "Uart")) {

