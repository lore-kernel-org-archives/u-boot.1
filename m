Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE89CE7AFE
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 10:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528DF88B58;
	Fri,  6 Sep 2024 12:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ijePNfzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A2E988C5C; Fri,  6 Sep 2024 12:44:25 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D7E88770
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 12:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1725619460; x=1726224260; i=xypron.glpk@gmx.de;
 bh=PBgGAzktgOjavvu/uS3kLO/5u077O3LCBmonrsS+Dl4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ijePNfzZSOxYsXFGpTgTZxebETUem5UjxFl2p+VIdATWmj6MxRRw1j4tiYm7auiy
 HSC4eihBmHPPfFKSNJFvSNLNJcEaTbe6Tbq8/lDO9wWnvYRW/HhXadnujjWu71gDm
 8StI0ZLB05uquOsC+pNWsY4bjtaL54Ua3jdhIPc56mZfEqGMsjgXCzjth1tVDbap5
 nu/6CelXqgyxm7CBnLUeYDle9TnqKB2b8uES9RtCLa0tlzmbKAmS/M7jYUMe2LRPc
 0ksKZqjnZSJLruUqBVl2hCW+I9gniRAcywO8C/TvfaMcO3n4tZguHVvGnRefnZy37
 WCpE3K4rWZKI13J79Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.162.74]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1s1b8o18O2-00roqE; Fri, 06
 Sep 2024 12:44:20 +0200
Message-ID: <adbefd8b-9d14-42f0-9a20-83416bf671c9@gmx.de>
Date: Fri, 6 Sep 2024 12:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/28] efi_loader: Install ACPI tables
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
 <20240906072231.2531491-15-patrick.rudolph@9elements.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240906072231.2531491-15-patrick.rudolph@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lrbvaqEjhQuEX1LkUnyOyRD3gtt6xWQJysdH8DZNMsYKlNWus5e
 iHfVl/iXVf64b6sBWCjpnGFzXdnB4EOf80JvbIUxW/bXn+EE1VpfPg32Eabk5j0LjAMd6gb
 VAbCJ1BDcr6RXk4vUTe17sh4hesrlXqUDNQvdF+PHk7cQYhnkAc/xz8w1Vg+kidtxJtmhEM
 e2k61omvoeVXxq2lMCl/A==
UI-OutboundReport: notjunk:1;M01:P0:ceuWP9gQxp8=;Cj1mkFI56l5/V70ETwptoIqQ68g
 oyFoDCnf0K+CTZZmb2R421k70El6ZoUxEQBQYAUXuYnjUnDHQJSAUKqt2TYMMqwlikC3S/9cQ
 A6kWi2lnTzmVxePuIkruX4bFdz6+lETAOvSOrZKwEuYXHWzvFLEOri8arJfGxPnGYJIuTkOpJ
 UK/DNGxEd9vt+7TXvZTSU1VjBB08HPEFWAniEUfDsKo6d9udkVW4HdFU+ujfD9yymSw1iSv8x
 1eQfH0BFGy6C4tLKJfGjSJ+rFUb/ij/ckVYpf8q6+spgrky0M7V2z8ENSsy/cQsr7Np2T8zHM
 mqXF+ZRJ2PAmeWuD4p19pvodW2sSvYWBxv8SNeOS5japLcumGtZMWhnpV3b1Tk16q12kZYJIw
 v8hzS4jUrgd3IszWc0RipYmYJBkUCxcBgsnxdbD3yvzEQA8tQAfLjGOVE9SRcLh1XI6fPbfGM
 tE1XHLUXsnNGODNN5KmSR5v0W3DVsFUA9ktuBxXfTZgA1E+R47fWVjo1VUt0M87Yj9jczIjr2
 JDo7UAWcJHqnyi5bVYz1bJtqQpXR5PQ/Aq04QABqZWb92teJ7bPLWWgmCXqpovhcKQXb/SzEl
 4eBcyPl3GVGv4JGLfCSeqsyWAvbDWS3veokWYSctKNCk2NywwH5seLXULOK99Po7FEAUopQP7
 lR9RANqgfGdKIZT5lyfjDuZbJ7cuKC0J9c8Pz234wkB8Fk4t3KunE80Hg8OLOPrspcoZShYSx
 6iLJbg5S0+TPmV/hMqDRWP106NoCrydXR12Z7H8qYT9NQPFbp+WpSe3x9MFDqzcmV5AtPiBf0
 tNdFNOr5YJctnqYhygs7swTQ==
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

On 9/6/24 09:22, Patrick Rudolph wrote:
> Install ACPI tables inside the efi_loader similar to SMBIOS tables.
> When ACPI is enabled and wasn't installed in other places, install
> the ACPI table in EFI. Since EFI is necessary to pass the ACPI
> table location when FDT isn't used, there's no need to install it
> separately.
>
> When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
> bloblist.

The UEFI specification clearly describes how to hand over ACPI tables. I
can't see why bloblists should be of any relevance in the UEFI context.

>
> TEST: Booted QEMU SBSA using EFI and ACPI only.

With this description it is unclear if you used QFW to install ACPI
tables which would not test the code below.

>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>

Please, cc maintainers as reported by scripts/get_maintainers in future.

> ---
>   lib/efi_loader/efi_acpi.c        | 57 ++++++++++++++++++++++++++++++--
>   test/py/tests/test_event_dump.py |  1 +
>   2 files changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index 67bd7f8ca2..9262f21ea6 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -6,15 +6,23 @@
>    */
>
>   #include <efi_loader.h>
> -#include <log.h>
> -#include <mapmem.h>
>   #include <acpi/acpi_table.h>
>   #include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <bloblist.h>
> +#include <linux/sizes.h>
> +#include <linux/log2.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <mapmem.h>
>
>   DECLARE_GLOBAL_DATA_PTR;
>
>   static const efi_guid_t acpi_guid =3D EFI_ACPI_TABLE_GUID;
>
> +enum {
> +	TABLE_SIZE	=3D SZ_64K,
> +};
>   /*
>    * Install the ACPI table as a configuration table.
>    *
> @@ -47,3 +55,48 @@ efi_status_t efi_acpi_register(void)
>   	return efi_install_configuration_table(&acpi_guid,
>   					       (void *)(ulong)addr);
>   }
> +

Please, provide a function description.

> +static int install_acpi_table(void)
> +{
> +	u64 rom_addr, rom_table_end;

There is no ROM involved here. Please, use meaningful variable names.

> +	void *addr;
> +
> +	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE) ||
> +	    IS_ENABLED(CONFIG_X86) ||
> +	    IS_ENABLED(CONFIG_QFW_ACPI))

Why would you want to call write_acpi_tables() twice on the sandbox? See

board/sandbox/sandbox.c:180:
             end =3D write_acpi_tables(addr);

We should remove the redundant code from board/sandbox/sandbox.c with
this patch.

> +		return 0;
> +
> +	/* Align the table to a 4KB boundary to keep EFI happy */
> +	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> +		addr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
> +				    ilog2(SZ_4K));
> +	else
> +		addr =3D memalign(SZ_4K, TABLE_SIZE);

The UEFI specification wants ACPI tables to reside in
EfiACPIReclaimMemory. Neither bloblist_add() nor memalign() should be
used here.

> +
> +	if (!addr)
> +		return log_msg_ret("mem", -ENOBUFS);
> +
> +	rom_addr =3D virt_to_phys(addr);
> +
> +	gd->arch.table_start_high =3D rom_addr;
> +
> +	rom_table_end =3D write_acpi_tables(rom_addr);
> +	if (!rom_table_end) {
> +		log_err("Can't create ACPI configuration table\n");
> +		return -EINTR;
> +	}
> +
> +	debug("- wrote 'acpi' to %llx, end %llx\n", rom_addr, rom_table_end);

Please, use log_debug().

> +	if (rom_table_end - rom_addr > TABLE_SIZE) {
> +		log_err("Out of space for configuration tables: need %llx, have %x\n"=
,

This check is too late. We must ensure that write_acpi_table() does not
overwrite unallocated memory.

> +			rom_table_end - rom_addr, TABLE_SIZE);
> +		return log_msg_ret("acpi", -ENOSPC);
> +	}
> +	gd->arch.table_end_high =3D rom_table_end;
> +
> +	debug("- done writing tables\n");

ditto

Best regards

Heinrich

> +
> +	return 0;
> +}
> +
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_acpi_table);
> diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event=
_dump.py
> index e282c67335..88bbf34f71 100644
> --- a/test/py/tests/test_event_dump.py
> +++ b/test/py/tests/test_event_dump.py
> @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
>   --------------------  ------------------------------  ----------------=
--------------
>   EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_reque=
st.c:.*
>   EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simpl=
e_os.c:.*
> +EVT_LAST_STAGE_INIT   install_acpi_table              .*lib/efi_loader/=
efi_acpi.c:.*
>   EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader=
/efi_smbios.c:.*
>   EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/c=
pu/start.c:.*
>   EVT_TEST              h_adder_simple                  .*test/common/ev=
ent.c:'''

