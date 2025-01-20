Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F48C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 12:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5AA7800B6;
	Mon, 20 Jan 2025 13:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rWE5RceC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F9B805C5; Mon, 20 Jan 2025 13:31:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CBE180077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737376305; x=1737981105; i=xypron.glpk@gmx.de;
 bh=PGkP63tvGbs/9ENEOqgJGTQMXguUEdN21uwZzyEl1b4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rWE5RceCw6DUrkraDEFl0KQaI8xHQTEm1R8xiDNqEIasAdOdYAOACCJk5KSb+FVG
 0T5JKKTrpqjhFoI6eoSeG03u3Gl5ePdG6Uj/uahji09f58bImr4qfv6fumWDcoA8K
 xc6PTH1ngM902OlWIRXr2IJArFZSXJkuqPd/OiLTQrKg/Vza64LubpdMcZEkBU/11
 deBLM6+6wKO9CPPJSoC7CsTLOBi9TdYumVzYaRK5xdjO+7bkK824FU0b0SGFjfqWN
 3jexvyEBR8whtb8gOszvu6f+QKzNYP/aqD2ZHwmaka+e0/n1Ab5jUDBNwjSN/P9Vi
 iU3yfJSume4QvBnjkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1tPmli0zCB-010NTF; Mon, 20
 Jan 2025 13:31:45 +0100
Message-ID: <67f57223-2c0d-414b-9e8c-138fdc57d92a@gmx.de>
Date: Mon, 20 Jan 2025 13:31:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] fdt: add support for adding pmem nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-2-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250120105045.1281262-2-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V4l33T6t34Naap0o63AAMAIxCadIgt2Nn8RQFgkRPkcTQTw3PUH
 Qa66BpXRM9CyyYhQB9E84nUjVccFdYR6kXnfLP6+w9nvEecOGWsIaod6FYz2o+6oYru7zHC
 zwUO4KZJLYGZcZKTAv2bG293nkek81ZsSJTvpvg0QulbPrduDALSs/iJ+r2jXJVRoRYUoUt
 k5+RZkS05ph60FNgn+/jw==
UI-OutboundReport: notjunk:1;M01:P0:P5bvvsWnS34=;NLEHzf524qdVYPnTlUhCQ2dgUS4
 /onUHWDjXXaoo7kTZsAwgIScKqklqyBmZ1IKnQRsHUyWBuWUEn3ou3aYaeOWry6AX4ij0GnJ6
 Ik5yXNPEHcLOvGkUGp361Z9lw5JLHain1xFS9XaRG2eBIIYGTsiOmzdpxdjVn1tj74xgDVjTg
 BSNRz8qJP6TRCrf9sErRDIcmnLoT+obtw7/LUpbj6C2Z7IsHTDwSIcSNYoLkbXtWZP3AV7bYI
 vuvp7spJKRKoDSvaFWx3rzKoWdOEkDqY83yvNe2i1CKOVySZRCWnJbPEZirXrvUI/2hoGHSsz
 srqnFEedIA4QudY972S/lIBsyrw9S5NeUVljApelKOJIxi5BLFSdu55Tvx7JpJwCtoAc8MMG0
 xWFeZl4CjTpgDrC92P13W/CKLWKmnJdCqmNl1dT8aymF+3d0bM3alZKjTOxcjQinHrEv1Mmd8
 bN0IOyCJNWhIFyZBHk9yCBYxYVjf8E4eysUdUl5fkgSDZWGkG7UwS0b4XdokOKtHCTGjlXF9I
 0ougu2bg2jjER6aViH4URx5wtXQnBllulYlPrpVwKyX6xHABH8gZFkfUD8ZzZRuC4eezvGdAt
 pqML4Ga7Hd62iJm/4tiksvnNeZpT9Cqzkz8pUrYDyV+1ieNi7n7SMnwfcRn3Kny1Sb1i+bJgI
 q38xd2xf2Jo0Wk7QcBzHnmAFNAGVzGZhTlOdIeKY9bwEozX4OZAMAzVzW/ooeFtDjBuHP3fDw
 rKHeeinJsEAhjf4vL8BO6KsPgeF9ArPV+c2kV9g3j9skn1egWlRRbIRuUNdQfekZtu6hCZ+Nn
 DlbNAMRIlFysC6UYuHhvwk45yD3rkKJ8nSlm1AJN7TH0bfhs6/rDacXaJSosxFGBglq7PY1q7
 5C633QceBPUTOM498baF7XhsrYMtAjaHse9SUPMekGevBJiLCQDpFpRc5nB2ayH+REJ3VEhvy
 Gddvs6r8c6tA/7s2VxHvPJIjzOOvCvZABcxt+pUfVEko2+9tkGhXUpT/3zGbjkD/nFqduEJNi
 AckKs60qBOFI5nxn3o/LsJjlj/zxarcB8E/sCxDgo1Sr1KTYYYn4ay3qRtPnQBLMHvfgL75oh
 O3NAfi7aZFXnftzz4duj3gbInFgU2WaBxVftfA9qs/6b4fkqdSdwaQ6xplj1P7eiRps9Mb3wP
 JlVTTHezu+PhNMgCzab5WAVQpCgliEP+eUc88H6MbSA==
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

On 20.01.25 11:50, Sughosh Ganu wrote:
> From: Masahisa Kojima <kojima.masahisa@socionext.com>
>
> One of the problems OS installers face, when running in EFI, is that
> the mounted ISO after calling ExitBootServices goes away. For some
> distros this is a problem since they rely on finding some core packages
> before continuing the installation. Distros have works around this --
> e.g Fedora has a special kernel command line parameter called
> inst.stage2 [0].
>
> ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> don't have anything in place for DTs. Linux and device trees have suppor=
t
> for persistent memory devices. So add a function that can inject a pmem
> node in a DT, so we can use it when launhing OS installers with EFI.

We also have ACPI support in U-Boot. In a future patch series I guess we
could add the generation of said ACPI tables.

>
> [0]
> https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html=
/installation_guide/chap-anaconda-boot-options#sect-boot-options-installer
>
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2:
> * Fix a checkpatch error by putting a blank line after a function
>
>   boot/fdt_support.c    | 40 +++++++++++++++++++++++++++++++++++++++-
>   include/fdt_support.h | 13 +++++++++++++
>   2 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 49efeec3681..613685b80eb 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -18,6 +18,7 @@
>   #include <dm/ofnode.h>
>   #include <linux/ctype.h>
>   #include <linux/types.h>
> +#include <linux/sizes.h>
>   #include <asm/global_data.h>
>   #include <asm/unaligned.h>
>   #include <linux/libfdt.h>
> @@ -464,7 +465,6 @@ void do_fixup_by_compat_u32(void *fdt, const char *c=
ompat,
>   	do_fixup_by_compat(fdt, compat, prop, &tmp, 4, create);
>   }
>
> -#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY>   /*
>    * fdt_pack_reg - pack address and size array into the "reg"-suitable =
stream
>    */
> @@ -493,6 +493,7 @@ static int fdt_pack_reg(const void *fdt, void *buf, =
u64 *address, u64 *size,
>   	return p - (char *)buf;
>   }
>
> +#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY

Do we need this #ifdef at all? We tend to leave it to the linker to
eliminate functions.

>   #if CONFIG_NR_DRAM_BANKS > 4
>   #define MEMORY_BANKS_MAX CONFIG_NR_DRAM_BANKS
>   #else
> @@ -2222,3 +2223,40 @@ int fdt_valid(struct fdt_header **blobp)
>   	}
>   	return 1;
>   }
> +
> +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size)
> +{
> +	u64 pmem_start[2] =3D { 0 };
> +	u64 pmem_size[2] =3D { 0 };
> +	char pmem_node[32] =3D {0};
> +	int nodeoffset, len;
> +	int err;
> +	u8 tmp[4 * 16]; /* Up to 64-bit address + 64-bit size */
> +
> +	if (!IS_ALIGNED(addr, SZ_2M) || !IS_ALIGNED(addr + size, SZ_2M)) {
> +		printf("Start and end address needs at 2MB alignment\n");

Nits:

%s/needs at 2MB alignment/must be 2 MiB aligned/

> +		return -1;
> +	}
> +	snprintf(pmem_node, sizeof(pmem_node), "pmem@%lx", addr);
> +	nodeoffset =3D fdt_find_or_add_subnode(blob, 0, pmem_node);
> +	if (nodeoffset < 0)
> +		return nodeoffset;
> +
> +	err =3D fdt_setprop_string(blob, nodeoffset, "compatible", "pmem-regio=
n");
> +	if (err)
> +		return err;
> +	err =3D fdt_setprop_empty(blob, nodeoffset, "volatile");
> +	if (err)
> +		return err;
> +	pmem_start[0] =3D addr;
> +	pmem_size[0] =3D size;
> +	len =3D fdt_pack_reg(blob, tmp, pmem_start, pmem_size, 1);
> +	err =3D fdt_setprop(blob, nodeoffset, "reg", tmp, len);
> +	if (err < 0) {
> +		printf("WARNING: could not set pmem %s %s.\n", "reg",
> +		       fdt_strerror(err));
> +		return err;
> +	}
> +
> +	return 0;
> +}
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index f0ad2e6b365..aea24df828f 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -507,4 +507,17 @@ void fdt_fixup_pstore(void *blob);
>    */
>   int fdt_kaslrseed(void *blob, bool overwrite);
>
> +/**
> + * fdt_fixup_pmem_region() - add a pmem node on the device tree
> + *
> + * This functions injects a pmem node to the device tree. Usually
> + * used with EFI installers to preserve installer images

If I understand the code correctly, the function adds or updates a pmem
device-tree node for the given start address.

Otherwise looks good to me.

Best regards

Heinrich

> + *
> + * @blob:	device tree provided by caller
> + * @addr:	start address of the pmem node
> + * @size:	size of the memory of the pmem node
> + * Return:	0 on success or < 0 on failure
> + */
> +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size);
> +
>   #endif /* ifndef __FDT_SUPPORT_H */

