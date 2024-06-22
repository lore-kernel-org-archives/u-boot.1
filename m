Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9374DC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 15:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E6987FC2;
	Sat, 22 Jun 2024 17:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Yvg+kKCW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57314880DB; Sat, 22 Jun 2024 17:44:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA9987A09
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 17:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719071031; x=1719675831; i=xypron.glpk@gmx.de;
 bh=65a3NdiIj7OkvRDM8HQV1oy9u0bhK/WE5NVUg93kwrM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Yvg+kKCWUyhIn8HikTJgfr5/oi1MjF3tf+09GyzCt/BAsAt6U9TecAo0/QxPfxnz
 S/bodYXpywrGuyUq4INkPJGzG307apR86gT+Js7Q0A0p3RA8jNap/hCsczzu4YrTk
 Gma7wKQzmABKiCSEvmAArAZYDKTezwviHLeIcvBNhL4vPVseht79gO89IHEdE50lN
 WQskRxznj/14cTk3f/QpyNillq6AT4X8xKc5D5Tbf86crdM17O3SzumUgFtopyKZf
 aRHjMoi4k0SVA9VfHB9+QeQsMUSD8R0lp+RLEN4L8x2M+0oBeEJSJwfzSTNksHzkT
 NwWRdlDc174yrX7dDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4b1y-1sJP0b1sXu-00FYen; Sat, 22
 Jun 2024 17:43:51 +0200
Message-ID: <fa78a7e6-4f3e-4a85-9c43-f0ec6b8e06d5@gmx.de>
Date: Sat, 22 Jun 2024 17:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] efi_loader: remove unneeded header files
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 sjg@chromium.org, trini@konsulko.com
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
 <20240622143601.187723-6-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240622143601.187723-6-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rv4EJwshdI/SdGrrrCC9uZVtmrxldcBvfsJU6q0YbfgIHfgzWWi
 1vdxDtnQNxBI5tVbtstwhZFbMFyr8QNOyuhfuEloqWdS90yGJK2yQLZRN+IdhbQxgzFBDtB
 WsbcQ4t1ZtdAi7MVmxruqt6Zx46JLfVMeiUd7+7c+zwDILCjW8Nwf2gOln867dEmDremkMe
 tKQSz/vD51AIi8OEaRaOg==
UI-OutboundReport: notjunk:1;M01:P0:DvLNuULgwCM=;jEV8rGMESuOxBNLh8nGIEBXbxzT
 r7dbHWaoDKFpGsE77rPC5tkC3JZZvSwq9mcNNuDAoC10ykH2hfx8xCDrQQmrC7IzWBBeir01J
 fwLABHmcayyQq9tRF4EF1jtBk/hW1UzjqlpJcycElgAu8nImST8/IuoxpbPU14PcSCTjEwgi/
 +d3oxznh8bqQmnrLsfB4tCfn6VXcGEF6C1ZGFYFdrCVMWK9Ok50MVwAbGL3t3+Lalt4ykpBan
 Q+Pwq3A+kYz7JnUqSDeAYeE5B5YlMyNkRjIGTyuAXactXAJj26ZeRi5s2SiGZBk27hnB9vE2G
 6AM7ZMkyu2M5sO+BmXQkWPw6m29G89EJ30PL0XIHoUji9ZK5PC7fipg35nhMGR6J/riFJYQAB
 wNNO60Urf0KTshVNGk95ySzZypVnHIfdwNhqKI7Ae0v18eNYzFo2EgQn6Z0hGmE7Z4v8FsVM0
 jNLslzXbnS/ilxHAqY8DuAg9cVJe+U3O7Eg084XgZLYHl7GtlJnsjD/d1zOtj3sJnDatS6YsE
 i+00Xe5ksK5ejATRXu0y5DvIRXSCIvwD2+qTFLABsxvK5WBu+zy2WkYUsQpa2y42tza+GsEQs
 PYBBrKPG5I6zGng5gzPUL22PGMhjxdkerDCEdcwaVuscE9zuuqfeVkpR50HHAzRqGnbXlcfXM
 gpIgIFulcsxvYN6gv3+BUIlwt4peYf/qdimDo2fGxdDmx+N/8iP/lrsTWzP09K+F+GFXjaE2p
 fzn7nzFi4cILyZjNUQb+2LPPAvKQ2oK42hBKtBV/kd5lbsPvqhhPPUbkFjLKzgJStKYFKwi2d
 ILl5MlqL3yuPGMw1D8YlKbwM2o78M4Ije7ZikJH3vV6uw=
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

On 22.06.24 16:35, Ilias Apalodimas wrote:
> efi_tcg2.h already includes tpm-v2.h. Remove it
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_tcg2.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 10c09caac35a..c654d2cbd704 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -16,7 +16,6 @@
>   #include <malloc.h>
>   #include <smbios.h>
>   #include <version_string.h>
> -#include <tpm-v2.h>
>   #include <tpm_api.h>
>   #include <u-boot/hash-checksum.h>
>   #include <u-boot/sha1.h>

