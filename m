Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2344CA0FFA
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2720C869C4;
	Tue,  5 Sep 2023 20:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Bu7zTwtv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1288B869A4; Tue,  5 Sep 2023 20:15:26 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF67865F4
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 385IFKsm095371;
 Tue, 5 Sep 2023 13:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693937720;
 bh=CYp4LqPGCGxCxSBuCJR9ePkcI4QzfIWDpTp2A0V/EnQ=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=Bu7zTwtvREX/pjAttn2Ghr1WXzFW5QGQ7YJtfx8rB1/aWOe4//1MyG6T8dKj5FdFU
 hIygy5S0fE+3QflQ4JO55+3QNH5vReO0uABs2mHLlGy6M34jCGN4KPCcnHe+jv6StJ
 5JtPfeUfDtk5k+adX3XTDA/MSPtztdQs0iPtdYes=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 385IFKck006783
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 13:15:20 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 13:15:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 13:15:18 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 385IFIEC031043;
 Tue, 5 Sep 2023 13:15:18 -0500
Message-ID: <7ef8bf43-f84d-a76c-afa0-f87a55d57c84@ti.com>
Date: Tue, 5 Sep 2023 13:15:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Makefile: Force regeneration of env.txt
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
References: <20230905180959.392276-1-afd@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20230905180959.392276-1-afd@ti.com>
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

On 9/5/23 1:09 PM, Andrew Davis wrote:
> If the source .env file changes to one that is also older than
> the generated env.txt file then it is not regenerated. This means
> when switching board configs we do not regenerate the env. This
> can be tested easily with:
> 
> $ make j721e_evm_a72_defconfig
> $ make # this may fail to complete but that is okay for this test
> $ make am64x_evm_a53_defconfig
> $ make
> $ vim include/generated/env.txt
> 
> Note this is still the J721e env not the AM64 config as expected.
> 
> There is probably a better way to detect if the dependency name changed,
> but that may involve extra files and hashing contents, so let's just
> force it for now.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

This is basically a revert of:
36fc832927eb ("Makefile: Fix incorrect FORCE deps on env rules")

But without changing the `include/generated/env.in` rule. The more
I think about it, that should also be changed to forced as right
now any changes to include/config.h or other kconfig options are
not reflected in the env.in file after updates.

That rule should depend on the generated config file so that any
change in kconfig variables will cause it to regenerate, that
might be what we need for this target instead of FORCE.

Andrew

>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 9be24c4ec61..d195590d4b0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1830,7 +1830,7 @@ quiet_cmd_envc = ENVC    $@
>   		touch $@ ; \
>   	fi
>   
> -include/generated/env.txt: $(wildcard $(ENV_FILE))
> +include/generated/env.txt: $(wildcard $(ENV_FILE)) FORCE
>   	$(call cmd,envc)
>   
>   # Write out the resulting environment, converted to a C string
