Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E53D6EBEC
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 08:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FF2489380;
	Fri, 29 Nov 2024 09:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732868549;
	bh=ktH1DlIv95GWU3LSfUxViQA/waVRcXS/b/uRWij9ekE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wxTh1N4P24jUFlvNwkEh7OZSGzes1bnGRE3cpR8B2XdDLSZ5bMPQ+3jxqdOCGF9ar
	 ExzhIxaw8V9CZ8ecywWHDWMH9Ow0d+c7G3xWx6zBbz1e6Pcyo19m0k+c9cLRaRh5nd
	 SOP67PCzD2OjtyCjnHl9paSzLEL/KmeHLKBScnNEk3SHmjJ/tGSwd8WRVp5vlIQsma
	 E1BlL0Gpfv0zampR9zzMd4slK4VNIL7B+Eo6XZ22JvB2tzmq5P9hMRDwCYxgZVRZOf
	 sRsw3iONTD/SKquAtcYmbmA9Bb/zRYZReaNzEq1ZgndgWCBFBcNzhb9jX+AWe27NWe
	 3Bi3hgfcCDxrA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B93289382; Fri, 29 Nov 2024 09:22:28 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFADB8937E
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 09:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Y05l32NVjz9sV4;
 Fri, 29 Nov 2024 09:22:23 +0100 (CET)
Message-ID: <8d3fe6b1-7465-4632-8af6-d058f87e6a78@denx.de>
Date: Fri, 29 Nov 2024 09:22:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] board: solidrun: clearfog: enable ddr odt0 on write for
 both chip-select
To: Josua Mayer <josua@solid-run.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241127-a388-sr-som-odt-v1-1-ad51f46a6e9a@solid-run.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241127-a388-sr-som-odt-v1-1-ad51f46a6e9a@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Y05l32NVjz9sV4
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

On 27.11.24 13:32, Josua Mayer wrote:
> Enabling ODT is required to suppress reflection of the data signal on
> DDR write operation. SolidRun Armada 388 SoM only connects M_ODT[0] even
> when both chip-select are used.
> 
> Enable ODT[0] for both chip-select during write only.
> 
> Original work by Baruch Siach [1] and Chris Packham [2].
> 
> [1] https://github.com/SolidRun/u-boot-armada38x/commit/aba763a611e69fbcc4e229659da9d84f16b39814
> [2] https://github.com/SolidRun/u-boot-armada38x/commit/dbaf09590df9add19e738d2de03c0f2d0d8f5433
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   board/solidrun/clearfog/clearfog.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/solidrun/clearfog/clearfog.c b/board/solidrun/clearfog/clearfog.c
> index 2dbd071abd9f29cee97fb813a67d0190a620bd32..67b60d2e7b43331383b6a01b13693b29b21129be 100644
> --- a/board/solidrun/clearfog/clearfog.c
> +++ b/board/solidrun/clearfog/clearfog.c
> @@ -161,7 +161,7 @@ static struct mv_ddr_topology_map board_topology_map = {
>   	{0},				/* timing parameters */
>   	{ {0} },			/* electrical configuration */
>   	{0,},				/* electrical parameters */
> -	0,				/* ODT configuration */
> +	0x30000,			/* ODT configuration */
>   	0x3,				/* clock enable mask */
>   };
>   
> 
> ---
> base-commit: 3881c6b90350b0b04085ad46ef64989b43967eef
> change-id: 20241127-a388-sr-som-odt-89f8dd6b6410
> 
> Best regards,

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

