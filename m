Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4905EC87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 07:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25FA18334A;
	Thu, 31 Jul 2025 09:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ijZRFHwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35CAF83390; Thu, 31 Jul 2025 09:04:36 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E3DC8318E
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V74T2n2944944;
 Thu, 31 Jul 2025 02:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753945469;
 bh=UUZ9VnhkMRwluG0xguKbS5rT15cRkHBPnqq8DzDYD+k=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ijZRFHwooTicXxn9CC2MVQvRAPrnRw4R/yh+rqjj5wF9OMdvZYxd6DrhQ030hZ3jG
 RnNGEHsNMD+SPL1RCLoqz2+3x8zUluHQE58VYl5M022aJGRRjh4mRpo15+VCyb6jHC
 6OPfirstsbrnoiBYeGZd/W25wHF/0mln3Wyijfcs=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V74Tni3134934
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 02:04:29 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 02:04:28 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.1748.24; Thu, 31 Jul
 2025 02:04:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 02:04:28 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V74QSH2501398;
 Thu, 31 Jul 2025 02:04:26 -0500
Message-ID: <9f557449-f648-4e39-9567-7d97e4ebeb8a@ti.com>
Date: Thu, 31 Jul 2025 12:34:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] binman: bintool: use apt-get instead of apt
To: Jerome Forissier <jerome.forissier@linaro.org>, U-Boot mailing list
 <u-boot@lists.denx.de>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Leonard Anderweit
 <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20250724091342.59902-1-jerome.forissier@linaro.org>
 <20250724091342.59902-2-jerome.forissier@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250724091342.59902-2-jerome.forissier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jerome

On 24/07/25 14:42, Jerome Forissier wrote:
> The 'apt' command is not meant to be used in scripts or tools. Please
> see the man page [1] for details. Therefore, use 'apt-get' instead.
> This avoids the following warning:
> 
> WARNING: apt does not have a stable CLI interface. Use with caution in scripts.
> 
> [1] https://manpages.debian.org/bookworm/apt/apt.8.en.html#SCRIPT_USAGE_AND_DIFFERENCES_FROM_OTHER_APT_TOOLS
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
> 
> (no changes since v1)
> 
>  tools/binman/bintool.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
> index 81872db377f..f46bb52a7b3 100644
> --- a/tools/binman/bintool.py
> +++ b/tools/binman/bintool.py
> @@ -421,7 +421,7 @@ class Bintool:
>          Returns:
>              True, assuming it completes without error
>          """
> -        args = ['sudo', 'apt', 'install', '-y', package]
> +        args = ['sudo', 'apt-get', 'install', '-y', package]
>          print('- %s' % ' '.join(args))
>          tools.run(*args)
>          return True

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
