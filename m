Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205CBC83F01
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 07:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C73286963;
	Sat, 26 Aug 2023 09:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="oW239jVk";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="RIRF/UVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41F7786968; Sat, 26 Aug 2023 09:44:49 +0200 (CEST)
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D1D8642C
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 09:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from ziongate (localhost [127.0.0.1])
 by ziongate (OpenSMTPD) with ESMTP id 97f2848e;
 Sat, 26 Aug 2023 07:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=hQ+tLhys0N+bSmyjQdr3HS4X2ZA=; b=oW239jVkU3LV/l5PCMw5/adSx4nU
 uwNiZp3drsM2XobORJnnlvjKSLYgnoKMhX2t47lJXRKzuba/tWI79RezX2BppVEF
 PETZz4FkXY32JuuIAPaoD78uFRKD6nHis+20n4ssSramlHKD3sWeGVi732gcgUUh
 omPXPhMyrf7XqxI=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=
 default; b=g+4bmwOkTxRVREYy67dpkC0g0kbbR6/IpAqCCVxcc5PJetKIEeXZO
 vZipUolziuKudTl9kW9BgXd+VY9A7ASsOTVSI61NUUT2Eg/1n4LeVkh4TmtHzn0j
 YchwGAih5L7jSTO572lCkYfc0OtTLRLZmJ7KXwL1yFJOG1T5JXYWMg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=20190913; t=1693035885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRihDlJvFXdFvQvF6G7igLiTV2aSO8ejm9Rzs3RNzU4=;
 b=RIRF/UVGb+PICDnyWN6fSiSWh/TJGQP6HytZdCk2Lko1g5x0cQvNOUXAOV0mwETfNZ7prM
 eN86WuxveLkyca27xdgyQU+oYyHmVqUfu4ULVamYKauv/CcR91GQQw4QNTOvfegM/6mXO0
 w0hjrbN97f6gLu+BP96utlF7r6wZfU0=
Received: from [192.168.0.2] (host-87-4-233-120.retail.telecomitalia.it
 [87.4.233.120]) by ziongate (OpenSMTPD) with ESMTPSA id 8016c498
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 26 Aug 2023 07:44:45 +0000 (UTC)
Message-ID: <7413294c-068f-f0ea-8247-8b8ea414a6c5@kernel-space.org>
Date: Sat, 26 Aug 2023 09:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 1/2] tools: relocate-rela: Add M68K support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Angelo Durgehello <angelo.dureghello@timesys.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huan Wang <alison.wang@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Ovidiu Panait <ovpanait@gmail.com>, Simon Glass <sjg@chromium.org>,
 Zong Li <zong.li@sifive.com>
References: <20230730222051.227660-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20230730222051.227660-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Marek,

thanks a lot for the job i should have done.

Tested on real hw:

m5282evb   worked out of the box
mcf54415   not working,
had a lot of unsupported relocation type for R_68K_JMP_SLOT
mcf5307    need to fix the hw, will do in short

i had to add this fix:

diff --git a/tools/relocate-rela.c b/tools/relocate-rela.c
index 2d008c7f60..9722a6291a 100644
--- a/tools/relocate-rela.c
+++ b/tools/relocate-rela.c
@@ -40,6 +40,10 @@
  #define R_68K_GLOB_DAT         20
  #endif

+#ifndef R_68K_JMP_SLOT
+#define R_68K_JMP_SLOT          21
+#endif
+
  #ifndef R_68K_RELATIVE
  #define R_68K_RELATIVE         22
  #endif
@@ -531,6 +535,9 @@ static bool supported_rela32(Elf32_Rela *rela, 
uint32_t *type)
                 case R_68K_RELATIVE:
                         debug("R_68K_RELATIVE\n");
                         return true;
+               case R_68K_JMP_SLOT:
+                        debug("R_68K_JMP_SLOT\n");
+                        return true;
                 }
         } else {
                 switch (*type) {
@@ -631,8 +638,9 @@ static int rela_elf32(char **argv, FILE *f)
                                 return 4;
                         }
                 } else if ((machine == EM_M68K &&
-                           (type == R_68K_32 || type == R_68K_GLOB_DAT)) ||
-                          (machine == EM_MICROBLAZE &&
+                           (type == R_68K_32 || type == R_68K_GLOB_DAT ||
+                            type == R_68K_JMP_SLOT)) ||
+                           (machine == EM_MICROBLAZE &&
                             (type == R_MICROBLAZE_32 ||
                              type == R_MICROBLAZE_GLOB_DAT))) {
                         /* global symbols read it and add reloc offset */



On 31/07/23 12:20 AM, Marek Vasut wrote:
> Add M68K ELF32 support into this tool, so it can patch static rela
> into M68K u-boot-nodtb.bin . This is the first step toward M68K
> relocation support, and in turn, removal of NEEDS_MANUAL_RELOC
> from the codebase altogether.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> Cc: Angelo Durgehello <angelo.dureghello@timesys.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Huan Wang <alison.wang@nxp.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Ovidiu Panait <ovpanait@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Zong Li <zong.li@sifive.com>
> ---
>   tools/relocate-rela.c | 108 ++++++++++++++++++++++++++++++------------
>   1 file changed, 77 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/relocate-rela.c b/tools/relocate-rela.c
> index e28e7fcc6f5..2d008c7f602 100644
> --- a/tools/relocate-rela.c
> +++ b/tools/relocate-rela.c
> @@ -24,6 +24,26 @@
>   #define R_AARCH64_RELATIVE	1027
>   #endif
>   
> +#ifndef EM_M68K
> +#define EM_M68K			4
> +#endif
> +
> +#ifndef R_68K_NONE
> +#define R_68K_NONE		0
> +#endif
> +
> +#ifndef R_68K_32
> +#define R_68K_32		1
> +#endif
> +
> +#ifndef R_68K_GLOB_DAT
> +#define R_68K_GLOB_DAT		20
> +#endif
> +
> +#ifndef R_68K_RELATIVE
> +#define R_68K_RELATIVE		22
> +#endif
> +
>   #ifndef EM_MICROBLAZE
>   #define EM_MICROBLAZE		189
>   #endif
> @@ -46,6 +66,7 @@
>   
>   static int ei_class;
>   static int ei_data;
> +static int machine;
>   
>   static uint64_t rela_start, rela_end, text_base, dyn_start;
>   
> @@ -111,7 +132,7 @@ static int decode_elf64(FILE *felf, char **argv)
>   	uint64_t sh_addr, sh_offset, sh_size;
>   	Elf64_Half sh_index, sh_num;
>   	Elf64_Shdr *sh_table; /* Elf symbol table */
> -	int ret, i, machine;
> +	int ret, i;
>   	char *sh_str;
>   
>   	debug("64bit version\n");
> @@ -245,7 +266,7 @@ static int decode_elf32(FILE *felf, char **argv)
>   	uint32_t sh_addr, sh_offset, sh_size;
>   	Elf32_Half sh_index, sh_num;
>   	Elf32_Shdr *sh_table; /* Elf symbol table */
> -	int ret, i, machine;
> +	int ret, i;
>   	char *sh_str;
>   
>   	debug("32bit version\n");
> @@ -262,12 +283,20 @@ static int decode_elf32(FILE *felf, char **argv)
>   	machine = elf16_to_cpu(header.e_machine);
>   	debug("Machine %d\n", machine);
>   
> -	if (machine != EM_MICROBLAZE) {
> +	if (machine != EM_MICROBLAZE && machine != EM_M68K) {
>   		fprintf(stderr, "%s: Not supported machine type\n", argv[0]);
>   		return 30;
>   	}
>   
>   	text_base = elf32_to_cpu(header.e_entry);
> +	/*
> +	 * M68K ELF entry point is MONITOR_BASE, not TEXT_BASE.
> +	 * TEXT_BASE is always MONITOR_BASE &~ 0x7ff, so clear
> +	 * those bits here.
> +	 */
> +	if (machine == EM_M68K)
> +		text_base &= ~0x7ff;
> +
>   	section_header_base = elf32_to_cpu(header.e_shoff);
>   	section_header_size = elf16_to_cpu(header.e_shentsize) *
>   			      elf16_to_cpu(header.e_shnum);
> @@ -488,25 +517,41 @@ static bool supported_rela32(Elf32_Rela *rela, uint32_t *type)
>   
>   	debug("Type:\t");
>   
> -	switch (*type) {
> -	case R_MICROBLAZE_32:
> -		debug("R_MICROBLAZE_32\n");
> -		return true;
> -	case R_MICROBLAZE_GLOB_DAT:
> -		debug("R_MICROBLAZE_GLOB_DAT\n");
> -		return true;
> -	case R_MICROBLAZE_NONE:
> -		debug("R_MICROBLAZE_NONE - ignoring - do nothing\n");
> -		return false;
> -	case R_MICROBLAZE_REL:
> -		debug("R_MICROBLAZE_REL\n");
> -		return true;
> -	default:
> -		fprintf(stderr, "warning: unsupported relocation type %"
> -			PRIu32 " at %" PRIx32 "\n", *type, rela->r_offset);
> -
> -		return false;
> +	if (machine == EM_M68K) {
> +		switch (*type) {
> +		case R_68K_32:
> +			debug("R_68K_32\n");
> +			return true;
> +		case R_68K_GLOB_DAT:
> +			debug("R_68K_GLOB_DAT\n");
> +			return true;
> +		case R_68K_NONE:
> +			debug("R_68K_NONE - ignoring - do nothing\n");
> +			return false;
> +		case R_68K_RELATIVE:
> +			debug("R_68K_RELATIVE\n");
> +			return true;
> +		}
> +	} else {
> +		switch (*type) {
> +		case R_MICROBLAZE_32:
> +			debug("R_MICROBLAZE_32\n");
> +			return true;
> +		case R_MICROBLAZE_GLOB_DAT:
> +			debug("R_MICROBLAZE_GLOB_DAT\n");
> +			return true;
> +		case R_MICROBLAZE_NONE:
> +			debug("R_MICROBLAZE_NONE - ignoring - do nothing\n");
> +			return false;
> +		case R_MICROBLAZE_REL:
> +			debug("R_MICROBLAZE_REL\n");
> +			return true;
> +		}
>   	}
> +	fprintf(stderr, "warning: unsupported relocation type %"
> +		PRIu32 " at %" PRIx32 "\n", *type, rela->r_offset);
> +
> +	return false;
>   }
>   
>   static int rela_elf32(char **argv, FILE *f)
> @@ -569,8 +614,8 @@ static int rela_elf32(char **argv, FILE *f)
>   
>   		debug("Addr:\t0x%" PRIx32 "\n", addr);
>   
> -		switch (type) {
> -		case R_MICROBLAZE_REL:
> +		if ((machine == EM_M68K && type == R_68K_RELATIVE) ||
> +		    (machine == EM_MICROBLAZE && type == R_MICROBLAZE_REL)) {
>   			if (fseek(f, addr, SEEK_SET) < 0) {
>   				fprintf(stderr, "%s: %s: seek to %"
>   					PRIx32 " failed: %s\n",
> @@ -585,9 +630,11 @@ static int rela_elf32(char **argv, FILE *f)
>   					argv[0], argv[1], addr);
>   				return 4;
>   			}
> -			break;
> -		case R_MICROBLAZE_32:
> -		case R_MICROBLAZE_GLOB_DAT:
> +		} else if ((machine == EM_M68K &&
> +		            (type == R_68K_32 || type == R_68K_GLOB_DAT)) ||
> +			   (machine == EM_MICROBLAZE &&
> +			    (type == R_MICROBLAZE_32 ||
> +			     type == R_MICROBLAZE_GLOB_DAT))) {
>   			/* global symbols read it and add reloc offset */
>   			index = swrela.r_info >> 8;
>   			pos_dyn = dyn_start + sizeof(Elf32_Sym) * index;
> @@ -632,12 +679,11 @@ static int rela_elf32(char **argv, FILE *f)
>   					argv[0], argv[1], addr);
>   				return 4;
>   			}
> -
> -			break;
> -		case R_MICROBLAZE_NONE:
> +		} else if (machine == EM_M68K && type == R_68K_NONE) {
> +			debug("R_68K_NONE - skip\n");
> +		} else if (machine == EM_MICROBLAZE && type == R_MICROBLAZE_NONE) {
>   			debug("R_MICROBLAZE_NONE - skip\n");
> -			break;
> -		default:
> +		} else {
>   			fprintf(stderr, "warning: unsupported relocation type %"
>   				PRIu32 " at %" PRIx32 "\n",
>   				type, rela.r_offset);

Regards,
angelo
