Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102A1C27C5E
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3654588676;
	Tue, 11 Jun 2024 15:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sxlLxVuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20C1B88655; Tue, 11 Jun 2024 15:02:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BBA888655
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718110958; x=1718715758; i=xypron.glpk@gmx.de;
 bh=sQjA5knBG0ptMcBDeQ2KDWZ0E7/w1dnumRvej4LNQ0g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sxlLxVuBkC2+FPLOSz6Y0u+1ifchZBIawFGrw8rI1db7TDWUFiF2ILJJmUarIw75
 YKkaDNYdNcKwmd7JSdS4ICrdQD2xRDbX6hV4u5hcOkCROv8WLvJd/aLjPV91r56vO
 rlUP+r5TmloSXDtrvsIOhM/YdYpaW/29viQJoc4WyyRE3bw3Uzz4NvNAyWjmDvhsx
 ZSBFnTrCPJdWyfUrETpPXrQh9Jj1Pzj0vGomFAfc0LjPFTpQV6olf2FGHhiTHk7ns
 Z+cyeHR+SKDVvDoVdt89gy9TftFIOwLpfb9A0oRZsjqukrrR0ep6HwUFfJnPCKcpn
 3TwFQJ5q6NODcHVYTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.176.212]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1siguo2Use-00icWA; Tue, 11
 Jun 2024 15:02:38 +0200
Message-ID: <4887f128-786d-4d07-8dec-79ef75e39509@gmx.de>
Date: Tue, 11 Jun 2024 15:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] image: Take entry point as an output of setup_booti
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-3-1407e0b69678@flygoat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240522-loongarch-v1-3-1407e0b69678@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1VrQZNS9TupsZFlqU+IbA9LlTi/pMEjZ1LHJGAVcRMg85pLi8zQ
 LQxJEqgraMlWQSMr4K9l3sZ3j2/yz6y+IBakuUspqx29JPSoz98vbfSyCJwjiE5iGO2+CWL
 Z7K93/kMI0mWxWiE/9t7s8UEeOeaOuBZYpD814pGezcrJS/wMx+qZWblUb+Y6BVNs/E3M4L
 iYXPSXJlXLTY1VtCdxmwQ==
UI-OutboundReport: notjunk:1;M01:P0:NttKgZvjcgU=;di6SdtIq4rgqk0Gqi9V4Fp93FdJ
 kCjw9esGxXOIiScWv3ZFSe5sTSKwPT4T+n/CVXTAwrMBamK9/KaTpmJhKDLzSdfspiVCDU6Re
 BAZ9xuQnL2S40WSnIMubpkwDmXCWeBjt7qwJZDsx96wfsdUJyYC4HwO5+L5+phsmQ0T6Le8B7
 NLDUzxCUxLE/uSYP0ocAaKh7Ea6F5KaLYcQTtMmXETrOPgwhBtgoomyN06enpb74eC7DggtC8
 QzuowpFCGl4fVYT9npcZn+BN2P3eaYBToUoRA6HL9VoGdyJF5xkAczW10on/owUY07YlUacTA
 J0nIuAjb9hLVWQjVGM1Di5I0QiwaR+cnYsdOQUrhMf+x6R9KlEhoSUCmxpaFlEXsOpZwwCz1B
 12DJEYMBKKUJEkkr55P0ES7lP3dZGoT647av2ymdCn+WNLbd76/JwVJs6Gy8iMNy+YEWD58kM
 iRRf/datN4RjUkQM3b2tAY+VBJvkSor6cWbm/lgEOhkLsW1V6V3zVD8il4rHSnZSyoGoJnhRm
 bCY1DSsWtdTTv8G8JGOXYl2hQTQBegUYpvuFYRLAXBrI0tM8qvoMLVLtYLYWsdXLVjBBzE5rG
 5SYMPN+J24nyKiVK0f7b8qiEel+huEZeZoltHWPGivSoseHTWk30KhN3UJfXLC+0JCAM0KMTu
 +sjhQOcFp39PdRI5EsSjVujIApzQExGgE3m/RgJ/GDYsba1elT8CNFlBvPC40oa09TZqR6xlc
 YYvwru1oqiMzd2AOjWNfPa3FISym6LSJJi91D55tPwXT1PFvs+HStzDBnC99ftMA+OKRHrxKg
 EwSdc1LudNmCG2ni2UeXa6qdQNkcHMWzw2r537DJcm8wE=
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

On 22.05.24 17:34, Jiaxun Yang wrote:
> For LoongArch the start of the image is not the entry
> point to the image.

Looking at arch/loongarch/kernel/head.S there seem to be two cases:

* The kernel has an EFI stub (CONFIG_EFI_STUB=3Dy).
   The legacy physical entry point is available at offset 0x08 of the
header.
* The kernel has no EFI stub.
   The kernel entry point matches the start of the image.

Where do you differentiate between the cases?

Best regards

Heinrich

>
> We refactor the code base to allow entry point to be
> supplied by setup_booti.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/arm/lib/image.c     | 3 ++-
>   arch/riscv/lib/image.c   | 4 +++-
>   arch/sandbox/lib/bootm.c | 2 +-
>   boot/bootm.c             | 5 +++--
>   cmd/booti.c              | 5 +++--
>   common/spl/spl.c         | 9 +++++----
>   include/image.h          | 3 ++-
>   7 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/lib/image.c b/arch/arm/lib/image.c
> index e394c1ad9093..024b6adc75e7 100644
> --- a/arch/arm/lib/image.c
> +++ b/arch/arm/lib/image.c
> @@ -30,7 +30,7 @@ struct Image_header {
>   };
>
>   int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> -		bool force_reloc)
> +		ulong *entry, bool force_reloc)
>   {
>   	struct Image_header *ih;
>   	uint64_t dst;
> @@ -73,6 +73,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ul=
ong *size,
>   		dst =3D gd->bd->bi_dram[0].start;
>
>   	*relocated_addr =3D ALIGN(dst, SZ_2M) + text_offset;
> +	*entry =3D *relocated_addr;
>
>   	unmap_sysmem(ih);
>
> diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
> index a82f48e9a505..2fd1f6c535ae 100644
> --- a/arch/riscv/lib/image.c
> +++ b/arch/riscv/lib/image.c
> @@ -33,7 +33,7 @@ struct linux_image_h {
>   };
>
>   int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> -		bool force_reloc)
> +		ulong entry, bool force_reloc)
>   {
>   	struct linux_image_h *lhdr;
>
> @@ -56,6 +56,8 @@ int booti_setup(ulong image, ulong *relocated_addr, ul=
ong *size,
>   		*relocated_addr =3D image;
>   	}
>
> +	*entry =3D *relocated_addr;
> +
>   	unmap_sysmem(lhdr);
>
>   	return 0;
> diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
> index 44ba8b52e139..4ef34c81d6d2 100644
> --- a/arch/sandbox/lib/bootm.c
> +++ b/arch/sandbox/lib/bootm.c
> @@ -83,7 +83,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
>
>   /* used for testing 'booti' command */
>   int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> -		bool force_reloc)
> +		ulong entry, bool force_reloc)
>   {
>   	log_err("Booting is not supported on the sandbox.\n");
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 032f5a4a1605..770300132891 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -693,9 +693,10 @@ static int bootm_load_os(struct bootm_headers *imag=
es, int boot_progress)
>   	    images->os.os =3D=3D IH_OS_LINUX) {
>   		ulong relocated_addr;
>   		ulong image_size;
> +		ulong entry;
>   		int ret;
>
> -		ret =3D booti_setup(load, &relocated_addr, &image_size, false);
> +		ret =3D booti_setup(load, &relocated_addr, &image_size, &entry, false=
);
>   		if (ret) {
>   			printf("Failed to prep arm64 kernel (err=3D%d)\n", ret);
>   			return BOOTM_ERR_RESET;
> @@ -709,7 +710,7 @@ static int bootm_load_os(struct bootm_headers *image=
s, int boot_progress)
>   			memmove((void *)relocated_addr, load_buf, image_size);
>   		}
>
> -		images->ep =3D relocated_addr;
> +		images->ep =3D entry;
>   		images->os.start =3D relocated_addr;
>   		images->os.end =3D relocated_addr + image_size;
>   	}
> diff --git a/cmd/booti.c b/cmd/booti.c
> index b9637b3ec3d8..9586a4c58ac1 100644
> --- a/cmd/booti.c
> +++ b/cmd/booti.c
> @@ -27,6 +27,7 @@ static int booti_start(struct bootm_info *bmi)
>   	ulong ld;
>   	ulong relocated_addr;
>   	ulong image_size;
> +	ulong entry;
>   	uint8_t *temp;
>   	ulong dest;
>   	ulong dest_end;
> @@ -73,7 +74,7 @@ static int booti_start(struct bootm_info *bmi)
>   	}
>   	unmap_sysmem((void *)ld);
>
> -	ret =3D booti_setup(ld, &relocated_addr, &image_size, false);
> +	ret =3D booti_setup(ld, &relocated_addr, &image_size, &entry, false);
>   	if (ret)
>   		return 1;
>
> @@ -84,7 +85,7 @@ static int booti_start(struct bootm_info *bmi)
>   		memmove((void *)relocated_addr, (void *)ld, image_size);
>   	}
>
> -	images->ep =3D relocated_addr;
> +	images->ep =3D entry;
>   	images->os.start =3D relocated_addr;
>   	images->os.end =3D relocated_addr + image_size;
>
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index e06bc75d36b2..52a4bee13728 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -113,7 +113,8 @@ int __weak bootz_setup(ulong image, ulong *start, ul=
ong *end)
>   	 return 1;
>   }
>
> -int __weak booti_setup(ulong image, ulong *relocated_addr, ulong *size,=
 bool force_reloc)
> +int __weak booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> +		       ulong *entry, bool force_reloc)
>   {
>   	 return 1;
>   }
> @@ -324,13 +325,13 @@ int spl_parse_image_header(struct spl_image_info *=
spl_image,
>
>   #if CONFIG_IS_ENABLED(OS_BOOT)
>   #if defined(CMD_BOOTI)
> -		ulong start, size;
> +		ulong start, size, entry;
>
> -		if (!booti_setup((ulong)header, &start, &size, 0)) {
> +		if (!booti_setup((ulong)header, &start, &size, &entry, 0)) {
>   			spl_image->name =3D "Linux";
>   			spl_image->os =3D IH_OS_LINUX;
>   			spl_image->load_addr =3D start;
> -			spl_image->entry_point =3D start;
> +			spl_image->entry_point =3D entry;
>   			spl_image->size =3D size;
>   			debug(SPL_TPL_PROMPT
>   			      "payload Image, load addr: 0x%lx size: %d\n",
> diff --git a/include/image.h b/include/image.h
> index acffd17e0dfd..a2bfc7bb19a3 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1061,11 +1061,12 @@ int bootz_setup(ulong image, ulong *start, ulong=
 *end);
>    * @image: Address of image
>    * @start: Returns start address of image
>    * @size : Returns size image
> + * @entry: Returns entry point of image
>    * @force_reloc: Ignore image->ep field, always place image to RAM sta=
rt
>    * Return: 0 if OK, 1 if the image was not recognised
>    */
>   int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> -		bool force_reloc);
> +		ulong *entry, bool force_reloc);
>
>   /*******************************************************************/
>   /* New uImage format specific code (prefixed with fit_) */
>

