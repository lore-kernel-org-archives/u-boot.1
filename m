Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE46C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 15:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C62A8056A;
	Thu, 24 Apr 2025 17:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53AC8809D4; Thu, 24 Apr 2025 17:29:23 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B1580050
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 17:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.25.173])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 18091B4C1B8D;
 Thu, 24 Apr 2025 17:29:17 +0200 (CEST)
Message-ID: <0a65fce7-882c-4234-9fb6-d2c92eb68dc4@freeshell.de>
Date: Thu, 24 Apr 2025 08:29:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] board: starfive: spl: support DeepComputing
 FML13V01
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>, u-boot@lists.denx.de
References: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
 <20250424121315.144549-5-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250424121315.144549-5-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
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

In a different series I refactor this logic to match the sorting of
configs/starfive_visionfive2_defconfig:CONFIG_OF_LIST but now is more
important to get this variant added to VF2 board target
in U-Boot as done here.

On 4/24/25 05:13, Heinrich Schuchardt wrote:
> On the DeepComputing Framework motherboard (FML13V01) choose the matching
> FIT configuration.
> 
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
> 	no change
> v3:
> 	no change
> v2:
> 	rebased
> ---
>  board/starfive/visionfive2/spl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
> index 3e4d3e21988..9a3081ef06f 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -125,7 +125,10 @@ int board_fit_config_name_match(const char *name)
>  	if (strncmp(name, "starfive/", 9))
>  		return -EINVAL;
>  	name += 9;
> -	if (!strncmp(product_id, "VF7110", 6)) {
> +	if (!strncmp(product_id, "FML13V01", 8) &&
> +	    !strcmp(name, "jh7110-deepcomputing-fml13v01")) {
> +		return 0;
> +	} else if (!strncmp(product_id, "VF7110", 6)) {
>  		version = get_pcb_revision_from_eeprom();
>  		if ((version == 'b' || version == 'B') &&
>  		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))

Reviewed-by: E Shattow <e@freeshell.de>
