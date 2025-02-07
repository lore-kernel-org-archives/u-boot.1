Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD53C0219C
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 17:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D765E801BE;
	Fri,  7 Feb 2025 18:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ogg9LiJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4992E80141; Fri,  7 Feb 2025 18:07:58 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D707A801DE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 517H7rfi3040253
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Feb 2025 11:07:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738948073;
 bh=swVzp+Q1HF3tOL67oanrOIfJ2USXsfyka+UfWhnxz4o=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Ogg9LiJMeH6QdEeCS3y04MwCqTGZ9wI2DB7ftunVUDp5Vx2cFpXcTdnXOpAaBV/Xi
 ljtplXepKxgbXwpEaVfPMJxBlPtlGAkWq6CoZRnY9aPR6zx1EWbHH1yYzV48eMYHmW
 uU+u5qs5ngWtLypPxxDZko5UC8iGftv3wJj1DTr4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 517H7rCH012554
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Feb 2025 11:07:53 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Feb 2025 11:07:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Feb 2025 11:07:53 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 517H7qOi111941;
 Fri, 7 Feb 2025 11:07:52 -0600
Message-ID: <b97fa179-8293-480e-8757-f8cc15c39828@ti.com>
Date: Fri, 7 Feb 2025 11:07:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] board: phytec: common: k3: Introduce Configs to Sign
 Images
To: Daniel Schultz <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <trini@konsulko.com>, <ggiordano@phytec.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <d-gole@ti.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>
References: <20250207065122.2495923-1-d.schultz@phytec.de>
 <20250207065122.2495923-2-d.schultz@phytec.de>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250207065122.2495923-2-d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 2/7/25 12:51 AM, Daniel Schultz wrote:
> Private keys to sign bootloader images shouldn't be commit or part
> of this repository. Add config entries to use keys located outside
> of U-Boot to sign images.
> 

The custMpk.pem was always a placeholder, we fill it with the TI Dummy
key as an example. The idea was you replace it with your key using
something like a symlink. So custMpk.pem is replaced with a pointing
to your real key when building on the production HSM. Why do you
need to have a Kconfig to point to your real key?

If you really want a full path to be settable from Kconfig for some
reason that I am not seeing, then others will want to too. So you
should make this option generic for all K3, nothing specific to this
one board family.

Andrew

> Signed-off-by: Maik Otto <m.otto@phytec.de>
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>   board/phytec/common/k3/Kconfig | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/board/phytec/common/k3/Kconfig b/board/phytec/common/k3/Kconfig
> index 282f4b79742..19fe927b22e 100644
> --- a/board/phytec/common/k3/Kconfig
> +++ b/board/phytec/common/k3/Kconfig
> @@ -3,3 +3,37 @@ config PHYTEC_K3_DDR_PATCH
>   	help
>   	   Allow to override default DDR timings prior to
>   	   DDRSS driver probing.
> +
> +config PHYTEC_K3_KEY_BLOB_COPY
> +	bool "Copy the MPK key and the degenerate TI key to the build path"
> +	default y
> +	help
> +	   Select how to manage the MPK and degenerate TI keys.
> +	   If PHYTEC_K3_KEY_BLOB_COPY is enabled, the keys will be copied into
> +	   the U-Boot directory for compatibility with the TI dummy keys
> +	   stored there.
> +	   If PHYTEC_K3_KEY_BLOB_COPY is disabled, the build will use the
> +	   original key directly. It is recommended to use the original key to
> +	   avoid unnecessary duplication.
> +
> +config PHYTEC_K3_MPK_KEY
> +	string "Path to customer specific MPK key"
> +	default "custMpk.pem" if PHYTEC_K3_KEY_BLOB_COPY
> +	default "arch/arm/mach-k3/keys/custMpk.pem" if !PHYTEC_K3_KEY_BLOB_COPY
> +	help
> +	   Specifies the path to the MPK signing key:
> +	   If PHYTEC_K3_KEY_BLOB_COPY is enabled, provide the path to the blob
> +	   copy of the original key.
> +	   If PHYTEC_K3_KEY_BLOB_COPY is disabled, provide the path to the
> +	   original key.
> +
> +config PHYTEC_K3_DEGENERATE_KEY
> +	string "Path to the degenerate TI key"
> +	default "ti-degenerate-key.pem" if PHYTEC_K3_KEY_BLOB_COPY
> +	default "arch/arm/mach-k3/keys/ti-degenerate-key.pem" if !PHYTEC_K3_KEY_BLOB_COPY
> +	help
> +	   Specifies the  path to the degenerate key:
> +	   If PHYTEC_K3_KEY_BLOB_COPY is enabled, provide the path to the blob
> +	   copy of the original key.
> +	   If PHYTEC_K3_KEY_BLOB_COPY is disabled, provide the path to the
> +	   original key.
