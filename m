Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5B5C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 13:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA4087EFD;
	Fri,  8 Mar 2024 14:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AkyWZPTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 379EB88065; Fri,  8 Mar 2024 14:33:50 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBAF98744F
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 14:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 428DXSAK087257;
 Fri, 8 Mar 2024 07:33:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709904808;
 bh=zA69OIofG5k+iwjUgWljmfMuDsbIjqyRp4la1Pd/EzU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=AkyWZPTYNXUObzaG/EQEz/msSUYXiU/M22CY0+4dRtdZj68j0Y5XioOUycUNF5AKA
 2KF4QxF7d+oB4kqDIExjtdVLfH7qGI9joCHrdj5cLttpuUO8yszurfMBbgrFNf2lVR
 zIdZb0XswLz1z1VYUY/qyw1dK7c3aWq2wOJcYOjY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 428DXSh6030959
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Mar 2024 07:33:28 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Mar 2024 07:33:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Mar 2024 07:33:28 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 428DXR3N060369;
 Fri, 8 Mar 2024 07:33:27 -0600
Message-ID: <fd9815c9-d8f3-4a35-8253-3bb6174362d3@ti.com>
Date: Fri, 8 Mar 2024 07:33:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: Improve generated_defconfig file handling
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, Joao Marcos Costa <jmcosta944@gmail.com>, 
 John Clark <inindev@gmail.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Rong Tao <rongtao@cestc.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Nishanth Menon <nm@ti.com>, "Jason
 Kacines" <j-kacines@ti.com>, <u-boot@lists.denx.de>
References: <20240308033822.28727-1-semen.protsenko@linaro.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240308033822.28727-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 3/7/24 9:38 PM, Sam Protsenko wrote:
> Commit 2027e99e61aa ("Makefile: Run defconfig files through the C
> preprocessor") adds `generated_defconfig' file, but fails to clean that
> up. It might be useful to have that file around after `make' is done,
> but it's better to clean that up on `make clean'. Also we probably want
> to hide it in `git status' list. This patch makes the described changes,
> and also adds `-P' parameter to the CPP command that produces the
> `generated_defconfig' to avoid generating linemarkers.
> 

All look like sensible improvements to me,

Acked-by: Andrew Davis <afd@ti.com>

> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: 2027e99e61aa ("Makefile: Run defconfig files through the C preprocessor")
> ---
>   .gitignore               | 1 +
>   Makefile                 | 1 +
>   scripts/kconfig/Makefile | 2 +-
>   3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 330148119264..d9a64d742fd7 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -63,6 +63,7 @@ fit-dtb.blob*
>   /spl/
>   /tpl/
>   /defconfig
> +/generated_defconfig
>   
>   #
>   # Generated include files
> diff --git a/Makefile b/Makefile
> index a2bc9d590329..6fd0e92c7d5a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2205,6 +2205,7 @@ clean: $(clean-dirs)
>   		-o -name modules.builtin -o -name '.tmp_*.o.*' \
>   		-o -name 'dsdt_generated.aml' -o -name 'dsdt_generated.asl.tmp' \
>   		-o -name 'dsdt_generated.c' \
> +		-o -name 'generated_defconfig' \
>   		-o -name '*.efi' -o -name '*.gcno' -o -name '*.so' \) \
>   		-type f -print | xargs rm -f
>   
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 5ce5845e8247..079add4d5dab 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -93,7 +93,7 @@ endif
>   endif
>   
>   %_defconfig: $(obj)/conf
> -	$(Q)$(CPP) -nostdinc -I $(srctree) -undef -x assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
> +	$(Q)$(CPP) -nostdinc -P -I $(srctree) -undef -x assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
>   	$(Q)$< $(silent) --defconfig=generated_defconfig $(Kconfig)
>   
>   # Added for U-Boot (backward compatibility)
