Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4EEC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 11:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C68E87864;
	Tue,  9 Jan 2024 12:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704800736;
	bh=PwYoIzDtGHs1oEOzx+meqpmA5YzSIjNjfCZ8viPGBgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hFOiP5L0PBFtojGRmlFMwIKrpO2pWyrIMWzHzs9MrhQFH+0B5WJOtLmaXw0kAHORI
	 DDQDHbRAqZ1OJSI7BpJUrVQbes8FmCM3R2lQdlZsBnL1rYO91kvEm9jhh6SWkJTsRK
	 KU6jE2ujNGewRfi22qCfMQ2OQVFs4Mgag6ovi/yvr0KMKMSSiqb0Wzy0WbLVCAQBCW
	 6TbrVXt7q/2N71qhu7YfnuQRqoEwwBvKV3EOZCHGErB76rCkGhH8uz5H8sNJl+S1Zg
	 I0QnK86UmvvxCeqCWD0REeobuAUiu0TH9eydcnnVDJX+Q9kc85lxXGyAYUMrMgsROr
	 R5XkHrT/+cxJQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB47A8783F; Tue,  9 Jan 2024 12:45:34 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56F08773F
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 12:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4T8TdQ51ftz9sTS;
 Tue,  9 Jan 2024 12:45:30 +0100 (CET)
Message-ID: <34ed0778-78a0-4a29-b329-638e9e24967a@denx.de>
Date: Tue, 9 Jan 2024 12:45:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] arm: mvebu: clearfog gtr: add config option to select
 serdes0 interface
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>
Cc: u-boot@lists.denx.de
References: <20240106-clearfog-gtr-serdes-v1-0-66cbc350c58d@solid-run.com>
 <20240106-clearfog-gtr-serdes-v1-1-66cbc350c58d@solid-run.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240106-clearfog-gtr-serdes-v1-1-66cbc350c58d@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T8TdQ51ftz9sTS
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

On 1/6/24 18:29, Josua Mayer wrote:
> Clearfog GTR has an assembly option for a SATA connector, CON18.
> It shares the serdes with mini-pcie connector CON3.
> 
> Add new kconfig option to select betweenata and pci, defaulting to pci
> as it was previously configured in board-file.
> 
> Clearfog GTR connects eth2 / serdes 1 to a 2.5Gbps capable ethernet
> switch port. Linux already configures a fixed-link at speed 2500 from
> device-tree.
> Upgrade serdes 1 rate to 3.125Gbps to support a 2.5Gbps network link on
> Clearfog GTR.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>   board/solidrun/clearfog/Kconfig    | 19 +++++++++++++++++++
>   board/solidrun/clearfog/clearfog.c | 11 ++++++++---
>   2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/board/solidrun/clearfog/Kconfig b/board/solidrun/clearfog/Kconfig
> index 60d3921307..765d8a6355 100644
> --- a/board/solidrun/clearfog/Kconfig
> +++ b/board/solidrun/clearfog/Kconfig
> @@ -39,6 +39,25 @@ config CLEARFOG_SFP_25GB
>   	  SGMII connection (requires a supporting SFP). By default, transfer speed
>   	  of 1.25 Gbps is used, suitable for a more common 1 Gbps SFP module.
>   
> +choice CLEARFOG_GTR_SERDES0
> +	prompt "Select Clearfog GTR SerDes 0 Function"
> +	help
> +	  Select function for SerDes 0 which is shared between CON3 and CON18
> +	  for either pci-e or sata.
> +
> +config CLEARFOG_GTR_SERDES0_PCIE
> +	bool "PCI-E on CON3"
> +	default y

After applying this patch I get this warning:

board/solidrun/clearfog/Kconfig:50:warning: defaults for choice values 
not supported

Could you please take a look?

Thanks,
Stefan

> +	help
> +	  Configure SerDes 0 for PCI-E to enable CON3 mini-PCI-E connector.
> +
> +config CLEARFOG_GTR_SERDES0_SATA
> +	bool "SATA on CON18"
> +	help
> +	  Configure SerDes 0 for SATA to enable CON18 SATA connector.
> +
> +endchoice
> +
>   config ENV_SIZE
>   	hex "Environment Size"
>   	default 0x10000
> diff --git a/board/solidrun/clearfog/clearfog.c b/board/solidrun/clearfog/clearfog.c
> index 6fa2fe5fe3..51c5be518a 100644
> --- a/board/solidrun/clearfog/clearfog.c
> +++ b/board/solidrun/clearfog/clearfog.c
> @@ -90,9 +90,14 @@ int hws_board_topology_load(struct serdes_map **serdes_map_array, u8 *count)
>   
>   	/* Apply runtime detection changes */
>   	if (sr_product_is(&cf_tlv_data, "Clearfog GTR")) {
> -		board_serdes_map[0].serdes_type = PEX0;
> -		board_serdes_map[0].serdes_speed = SERDES_SPEED_5_GBPS;
> -		board_serdes_map[0].serdes_mode = PEX_ROOT_COMPLEX_X1;
> +		if (IS_ENABLED(CONFIG_CLEARFOG_GTR_SERDES0_SATA)) {
> +			/* serdes 0 is sata (like clearfog pro) */
> +		} else if (IS_ENABLED(CONFIG_CLEARFOG_GTR_SERDES0_PCIE)) {
> +			/* serdes 0 is pci */
> +			board_serdes_map[0].serdes_type = PEX0;
> +			board_serdes_map[0].serdes_speed = SERDES_SPEED_5_GBPS;
> +			board_serdes_map[0].serdes_mode = PEX_ROOT_COMPLEX_X1;
> +		}
>   	} else if (sr_product_is(&cf_tlv_data, "Clearfog Pro")) {
>   		/* handle recognized product as noop, no adjustment required */
>   	} else if (sr_product_is(&cf_tlv_data, "Clearfog Base")) {
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
