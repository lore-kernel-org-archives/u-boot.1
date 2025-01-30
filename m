Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44703C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 10:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72D282012;
	Thu, 30 Jan 2025 11:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MBL8HrfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C33578205B; Thu, 30 Jan 2025 11:02:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8783380C85
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738231298; x=1738836098; i=xypron.glpk@gmx.de;
 bh=p9aYIuSgJ6oY5V7Dn9lBUKDsQLl8PA17ewCNIUYYlxM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MBL8HrfXuButWn6FvMMG+uSV/VR3aUbUIHkmxixEyFqC0XP4XkITGBH30LF0yhe0
 q3AdxyBllidu1FTUte37Zx/WU8Om6DvEG+LkB0Z54KxUGcB8u/YQ+CrBElILrjRaZ
 kXaoX/WBnio+fsAvx6nuCGCBb34TAtPs7Yv4VyFBIvCWUY45s9MZDdli9/L6wVmfG
 iEVn49BEfYrI1BjxfKjJcHpKvcr5OYvNHXAxxSETQn33JWQX6cV85C13zs2eBghd3
 z72tFfdd9F+KyYPQZPr8jPm8K+iTeoWBTPBQoRzDQ3B0cyCQTriPTSS9goeJnC0tW
 6Pqyz6WkzBpn1f03dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1tagDC3kYk-00GBtq; Thu, 30
 Jan 2025 11:01:37 +0100
Message-ID: <bc481af0-64f1-47f4-af19-1aba64c2ae6c@gmx.de>
Date: Thu, 30 Jan 2025 11:01:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] meminfo: add memory details for armv8
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?=
 <ptosi@google.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Christian Marangi
 <ansuelsmth@gmail.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-2-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250130072100.27297-2-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W2q3eJbRewMsQArmZO7YDuFO5qholjEIlcwByvTmIAjzvGzZMxC
 3biNt7Xk/3sZxX/YFHsWPgIaTfH6wP0DiK1xhvvYO5jt7xa09bPfNNbxKECs0pFSVfT93fr
 t63ivzJ/rFz/LRbPT96WLBsI1S2z2Sz5jAYCRxm6d9kmSnkaI0Yz421TP/sF882CnaeeUnY
 cyFo3YetQiAY+KBONRL0g==
UI-OutboundReport: notjunk:1;M01:P0:Ik0SsQi6CHg=;NbYh29We1Ook0fmdNAsRM4Yw6X3
 /UrmLJEnRziu7xp6nKWl+3xSNs97kBwJbXoHvF3eiIN808kCZLI6R/ay+FJfDXgBI8nf12aZi
 3xmWgiOHt82jjaGovwVcPemJnGWamq2Q3VHKxPxeHX5D4GU8ZJQLRLzMkHao+FuX3xTHW88kQ
 qS9qQSXEz9vJvSqTjPtRgf58zqMY+i93IDfg5TvtBuVZX55BwJxQ+aanny8B4bhwKSpn4L0Fn
 6N/YcRiHFoEZxZFlWjY+QZRJzeliTKLPxOiQCTyU5l09EtbjeEGs5cdbFnnfUza+ccvnIPv6s
 oro2iXSGLNHWcKodcjw5crQPU2YY8rb5cU35cCl39XkntNgw22GZb/Z1u2pDFBpiGj8KJ8ciQ
 P+Wm18Uhrh+fN1dhrcX/1ARfMtkmAd93WYYiDOjMLG7FciDdh4lHW8F6sfMbdM9KXYVIq6AiD
 yymPU6oWvogfKq+sn932ccUpMyErLkoUi1bR1S8OiHx6nlU2msxPBa2ktea1rt4wufCjiwhRp
 vP4q+Gej486pQuFWVy6jVr17gEpjH0rP8LRbJ8/WXAxl/DhGW6+TRDt3Z9BcL/02JJKSmU/G5
 NdO1v2jAV4vL6SkR1/SDiSuYMiUje4o37CLLy19TTCwyIuJ2s/MRZlCdJtHyvM/i8F3QKYuRh
 0C2qvi2pzLsk2Yps7qpS/qvcbPpl/GhniooMhUXWvoTQZM2KoTlyx9f7yoLCMtzWx1o8CTi86
 wWTqWSKhu1A7aH3ZzFhGtLxkLzIXHIvxxqSSzWADGlK+FXrQi1W/HwGoc8M5bQ/m36n9rul5Z
 AvhfvU+ptuG6haYmBhdjLiXcOFgRuXxH8yk8Q0X+YvrbQQECRD2AAoYKRzye/76N6gvezNP/U
 cV+257dCsu1FfTKnuk2HZaI6JakqmwKCP06PXTLRuRDJsHEKFeUcdIESPuO2ICjl5kF8X29JU
 H0EkSxzW18wwlmry8L7hcga+tZCB73FFypRCyHAifFVecl9O5HesCXF6fQi/6IEXLC0L4bM/3
 h1bSrCEq0/ZRMHQM6ar4nbUCnnXpzvufjAdMTjcw9p0odenv7onsPetbWiozm0+6Rs9M4q/jD
 L1LZTfzZnwd2ZD4V1jGnCME7A3BZkiLO/XHmxNB95hUZ7oRCp1lSbWBG45sUwHrnDPy8b/Bcv
 0nmNks1qKE6KZdhgUVOfmAI3on50yI+3CaXvULWzmZQ==
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

On 1/30/25 07:20, Ilias Apalodimas wrote:
> Upcoming patches are mapping memory with RO, RW^X etc permsissions.
> Fix the meminfo command to display them properly
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   arch/arm/cpu/armv8/cache_v8.c    | 18 +++++++++++++++++-
>   arch/arm/include/asm/armv8/mmu.h |  2 ++
>   cmd/meminfo.c                    |  5 +++++
>   3 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8=
.c
> index 5d6953ffedd1..a4ca56c8ed42 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -421,7 +421,7 @@ static int count_ranges(void)
>   	return count;
>   }
>
> -#define ALL_ATTRS (3 << 8 | PMD_ATTRINDX_MASK)
> +#define ALL_ATTRS (3 << 8 | PMD_ATTRMASK)
>   #define PTE_IS_TABLE(pte, level) (pte_type(&(pte)) =3D=3D PTE_TYPE_TAB=
LE && (level) < 3)
>
>   enum walker_state {
> @@ -568,6 +568,17 @@ static void pretty_print_table_attrs(u64 pte)
>   static void pretty_print_block_attrs(u64 pte)
>   {
>   	u64 attrs =3D pte & PMD_ATTRINDX_MASK;
> +	u64 perm_attrs =3D pte & PMD_ATTRMASK;

The variable perm_attrs is not needed. You could use pte directly.

> +
> +	if ((perm_attrs & PTE_BLOCK_PXN) && (perm_attrs & PTE_BLOCK_UXN) &&
> +	    perm_attrs & PTE_BLOCK_RO)
> +		printf("%-5s", " | RO");
> +	else if ((perm_attrs & PTE_BLOCK_PXN) && (perm_attrs & PTE_BLOCK_UXN))
> +		printf("%-5s", " | RW");
> +	else if (perm_attrs & PTE_BLOCK_RO)
> +		printf("%-5s", " | RX");
> +	else
> +		printf("%-5s", " | RWX");

The string has 6 characters. "%-5s" does not match!
As the string length is known using a length identifier is superfluous.

It would be helpful to add descriptions to the flags in
arch/arm/include/asm/armv8/mmu.h.

https://documentation-service.arm.com/static/5efa1d23dbdee951c1ccdec5
describes:

"The Unprivileged Execute Never (UXN) and Privileged Execute Never (PXN)
attributes can be set separately. This is used to prevent, for example,
application code running with kernel privilege, or attempts to execute
kernel code while in an unprivileged state."

Shouldn't we show the values of UXN and PXN separately?

E.g:

printf("%s%s%s\",
	pte & PTE_BLOCK_RO  ? " | RO " : "",
	pte & PTE_BLOCK_PXN ? " | PXN" : "",
	pte & PTE_BLOCK_UXN ? " | UXN" : "");

Best regards

Heinrich

>
>   	switch (attrs) {
>   	case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE):
> @@ -1112,3 +1123,8 @@ void __weak enable_caches(void)
>   	icache_enable();
>   	dcache_enable();
>   }
> +
> +void arch_dump_mem_attrs(void)
> +{
> +	dump_pagetable(gd->arch.tlb_addr, get_tcr(NULL, NULL));
> +}
> diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/arm=
v8/mmu.h
> index 0ab681c893d3..6af8cd111a44 100644
> --- a/arch/arm/include/asm/armv8/mmu.h
> +++ b/arch/arm/include/asm/armv8/mmu.h
> @@ -66,6 +66,7 @@
>   #define PTE_BLOCK_NG		(1 << 11)
>   #define PTE_BLOCK_PXN		(UL(1) << 53)
>   #define PTE_BLOCK_UXN		(UL(1) << 54)
> +#define PTE_BLOCK_RO            (UL(1) << 7)
>
>   /*
>    * AttrIndx[2:0]
> @@ -75,6 +76,7 @@
>   #define PMD_ATTRMASK		(PTE_BLOCK_PXN		| \
>   				 PTE_BLOCK_UXN		| \
>   				 PMD_ATTRINDX_MASK	| \
> +				 PTE_BLOCK_RO		| \
>   				 PTE_TYPE_VALID)
>
>   /*
> diff --git a/cmd/meminfo.c b/cmd/meminfo.c
> index 5e83d61c2dd3..3915e2bbb268 100644
> --- a/cmd/meminfo.c
> +++ b/cmd/meminfo.c
> @@ -15,6 +15,10 @@
>
>   DECLARE_GLOBAL_DATA_PTR;
>
> +void __weak arch_dump_mem_attrs(void)
> +{
> +}
> +
>   static void print_region(const char *name, ulong base, ulong size, ulo=
ng *uptop)
>   {
>   	ulong end =3D base + size;
> @@ -54,6 +58,7 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag,=
 int argc,
>
>   	puts("DRAM:  ");
>   	print_size(gd->ram_size, "\n");
> +	arch_dump_mem_attrs();
>
>   	if (!IS_ENABLED(CONFIG_CMD_MEMINFO_MAP))
>   		return 0;

