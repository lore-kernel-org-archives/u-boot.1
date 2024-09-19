Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DFBCAC5BF
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 12:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E91489154;
	Thu, 19 Sep 2024 14:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oj0UZMDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 359F489154; Thu, 19 Sep 2024 14:39:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F95890E9
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 14:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726749593; x=1727354393; i=xypron.glpk@gmx.de;
 bh=nzyYaYbTbKuZLol0/IE4dWlXQMg/dT1h3OeNVDtsNFw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oj0UZMDUGJfKHQa1D5Zcc5VObZPaVtzTDlps6czZ1TY5Lou6m0pnK+bC6tMdPkvU
 uPnf7icDI2mnw0yVbmyfvU2FSkAhXgQLkJT9jPLAiyrkdpE6vygOjhOIWG4MOgKWI
 hdzA/2IE+3/sWbt4tnVv8G6UOOUUTKlhpQ3qSaRQJ9b1n8O/uDz8KL1J1mn8+Ojzn
 zRRtSsL0EW0uFpToAa99b6nRG37IwvcFGsbFZCw+WwMyQSeQSTsi3Ijr8iXfCjepa
 mlZZkH5VnVJRXK+EXlA6r5GaKkGq8876ItqZsJu6wIOBuaz7oy6U0mC+nkDY/cg62
 0X3uA6zHXfg48FKOeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1ryjsv3TE9-015Vfc; Thu, 19
 Sep 2024 14:39:52 +0200
Message-ID: <ce2fa4a5-bb75-4dae-b035-405af0870991@gmx.de>
Date: Thu, 19 Sep 2024 14:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/30] efi_loader: Allocate and write ACPI tables
To: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-15-patrick.rudolph@9elements.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240911062511.494855-15-patrick.rudolph@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wp7koPyp2IK5AWGpqPMhwhBGqYu2wRtMGqjlSl0OdO+e4z7UGbx
 B7ihLQk8Jb1z9lnhaR1Xac+ebA0oGi/s2sZx/a8yde8OjTYm0BvEeCcDeRveK7JndzVQE6H
 L1+4bTHM7FOC4RNKBfxtyoMzFht9j4yd+M2f2JcXeBbsmqja1uPEk+xqpAa68NikSDI3ovO
 yc4vMOGKPaMu/ozbd25Rw==
UI-OutboundReport: notjunk:1;M01:P0:ocoY1N+1Q+M=;9Y3x7QAPa1TnjE58J0Chkc7KFTZ
 p9DQa4Ymub/rY2KdLf8AiYdtVSuNsBAV1+b2H71uQbit+iGPdIL/lTGUZciArRK+rJFL8epC6
 pHlx/OUjOblUEK8VycEloLcG4ad7ZGGqgGFQVdkb+evgfjLHO0VSV1v4Xly2JVZOn0+nuf66Z
 Ybc663OvgFxUUWepyWCfVGgNuTxrvJYHfeMWbNX8Lxrzo0lr+x2kaYdYZeIA8Fik3tuBQC/0S
 s4i8c/ioiLUjvtYiT+g78TNfosgG9YJWHZBxGJd0669eowUU9eYwiz/MsGwVceaW0bMYzKesS
 D4CCcOBoWODtdGvtqUb5so09hMvt0DsM80uZQIw+PqgskgREFgDU00az0TiSdj6AmwFP09Bkn
 8nwkb6GjiP9wUDYssrxQRbKkHkyOs3K43QkmJM1G0IaAK7mCQsqVcfc70zqa7MLnEw1uxuXd3
 9UUjbAdd5Hr4vh1DPAuux69LrAabab8JGPDG3yLz8kIVH99uEIe7+TmXx/md0Qiz2W8FmD+hX
 Il7PkuYAQRsGVk0+ePNp+BxcWG6VS/mYuYk0B7+6JmHE17q2n+jotUcpQcKO4ge4d1OpdMESO
 r3OK+0Mghh4V9m1w+2FdZctfNTM6HRZfYLEhCBPivTXtcplZ9rtxon1m58/IeIjcvm143mko0
 vGE0F0JZNUoUONrp+cJbSMTNgfe7Iz8XVsWARL0WUtJbmYhOR05givwin5iQTpMiq29p0w0rx
 0WVxCu7VPgYh+CHb7dyUGry5sj8pWIeTNtqX8Q0VQGrkMAwOdOXP97RTFYSyhc1c6z02Tm5pb
 /SuLX3wu7XOv3VyxsMRHXC2w==
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

On 11.09.24 08:24, Patrick Rudolph wrote:
> Allocate memory for ACPI tables inside the efi_loader and write out
> the tables similar to SMBIOS tables. When ACPI is enabled and wasn't
> installed in other places, install the ACPI table in EFI. Since EFI
> is necessary to pass the ACPI table location when FDT isn't used,
> there's no need to install it separately.
>
> When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
> bloblist. The tables are still passed to the OS using EFI.
>
> This allows non x86 platforms to boot using ACPI only in case the
> EFI loader is being used.
>
> TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>

Could you, please, describe how QEMU SBSA is passing the ACPI table to
U-Boot and where you convert this to a bloblist. I could not find this
in patches 1-13.

Please, provide a test that we can run on our CI.

Best regards

Heinrich

> ---
> Changelog v3:
> - Drop memalign and use efi_allocate_pages
> - Use log_debug instead of debug
> - Clarify commit message
> - Skip writing ACPI tables on sandbox
> - Rename function
> - Add function comment
> ---
>   lib/efi_loader/efi_acpi.c        | 80 +++++++++++++++++++++++++++++++-
>   test/py/tests/test_event_dump.py |  1 +
>   2 files changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index 67bd7f8ca2..9d38d0060c 100644
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
> @@ -47,3 +55,71 @@ efi_status_t efi_acpi_register(void)
>   	return efi_install_configuration_table(&acpi_guid,
>   					       (void *)(ulong)addr);
>   }
> +
> +/*
> + * Allocate memory for ACPI tables and write ACPI tables to the
> + * allocated buffer.
> + *
> + * Return:	status code
> + */
> +static int alloc_write_acpi_tables(void)
> +{
> +	u64 table_addr, table_end;
> +	u64 new_acpi_addr =3D 0;
> +	efi_uintn_t pages;
> +	efi_status_t ret;
> +	void *addr;
> +
> +	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
> +		return 0;
> +
> +	if (IS_ENABLED(CONFIG_X86) ||
> +	    IS_ENABLED(CONFIG_QFW_ACPI) ||
> +	    IS_ENABLED(CONFIG_SANDBOX)) {
> +		log_debug("Skipping writing ACPI tables as already done\n");
> +		return 0;
> +	}
> +
> +	/* Align the table to a 4KB boundary to keep EFI happy */
> +	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> +		addr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
> +				    ilog2(SZ_4K));
> +
> +		if (!addr)
> +			return log_msg_ret("mem", -ENOMEM);
> +	} else {
> +		pages =3D efi_size_in_pages(TABLE_SIZE);
> +
> +		ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> +					 EFI_ACPI_RECLAIM_MEMORY,
> +					 pages, &new_acpi_addr);
> +		if (ret !=3D EFI_SUCCESS)
> +			return log_msg_ret("mem", -ENOMEM);
> +
> +		addr =3D (void *)(uintptr_t)new_acpi_addr;
> +	}
> +
> +	table_addr =3D virt_to_phys(addr);
> +
> +	gd->arch.table_start_high =3D table_addr;
> +
> +	table_end =3D write_acpi_tables(table_addr);
> +	if (!table_end) {
> +		log_err("Can't create ACPI configuration table\n");
> +		return -EINTR;
> +	}
> +
> +	log_debug("- wrote 'acpi' to %llx, end %llx\n", table_addr, table_end)=
;
> +	if (table_end - table_addr > TABLE_SIZE) {
> +		log_err("Out of space for configuration tables: need %llx, have %x\n"=
,
> +			table_end - table_addr, TABLE_SIZE);
> +		return log_msg_ret("acpi", -ENOSPC);
> +	}
> +	gd->arch.table_end_high =3D table_end;
> +
> +	log_debug("- done writing tables\n");
> +
> +	return 0;
> +}
> +
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, alloc_write_acpi_tables);
> diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event=
_dump.py
> index e282c67335..459bfa26bb 100644
> --- a/test/py/tests/test_event_dump.py
> +++ b/test/py/tests/test_event_dump.py
> @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
>   --------------------  ------------------------------  ----------------=
--------------
>   EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_reque=
st.c:.*
>   EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simpl=
e_os.c:.*
> +EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/efi_loader/=
efi_acpi.c:.*
>   EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader=
/efi_smbios.c:.*
>   EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/c=
pu/start.c:.*
>   EVT_TEST              h_adder_simple                  .*test/common/ev=
ent.c:'''

