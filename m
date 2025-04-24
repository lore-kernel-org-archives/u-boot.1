Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272D9C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 15:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E358056A;
	Thu, 24 Apr 2025 17:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 031AA806FC; Thu, 24 Apr 2025 17:25:20 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D122080050
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 17:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.25.173])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id EED14B2227FD;
 Thu, 24 Apr 2025 17:25:13 +0200 (CEST)
Message-ID: <f807345e-7982-404b-b84e-e26eb8043d30@freeshell.de>
Date: Thu, 24 Apr 2025 08:25:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] board: starfive: DeepComputing FML13V01 fdt
 selection
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>, u-boot@lists.denx.de
References: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
 <20250424121315.144549-4-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250424121315.144549-4-heinrich.schuchardt@canonical.com>
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

In a different series I suggest removal of this fdtfile setting code,
but now is more important to get this variant added to VF2 board target
in U-Boot as done here.

On 4/24/25 05:13, Heinrich Schuchardt wrote:
> We support all JH7110 boards with starfive_visionfive2_defconfig.
> The relevant device-tree is selected at runtime based on EEPROM data.
> 
> Support setting $fdtfile to the file name of the DeepComputing Framework
> motherboard (FML13V01) device-tree.
> 
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
> 	no change
> v3:
> 	rebased upon Mars CM removal patch
> v2:
> 	no change
> ---
>  board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
> index b8cd509bc89..5fe888d4072 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -17,6 +17,8 @@
>  DECLARE_GLOBAL_DATA_PTR;
>  #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
>  #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
> +#define FDTFILE_FML13V01 \
> +	"starfive/jh7110-deepcomputing-fml13v01.dtb"
>  #define FDTFILE_MILK_V_MARS \
>  	"starfive/jh7110-milkv-mars.dtb"
>  #define FDTFILE_VISIONFIVE2_1_2A \
> @@ -63,7 +65,9 @@ static void set_fdtfile(void)
>  		log_err("Can't read EEPROM\n");
>  		return;
>  	}
> -	if (!strncmp(product_id, "MARS", 4)) {
> +	if (!strncmp(product_id, "FML13V01", 8)) {
> +		fdtfile = FDTFILE_FML13V01;
> +	} else if (!strncmp(product_id, "MARS", 4)) {
>  		fdtfile = FDTFILE_MILK_V_MARS;
>  	} else if (!strncmp(product_id, "VF7110", 6)) {
>  		version = get_pcb_revision_from_eeprom();

Reviewed-by: E Shattow <e@freeshell.de>
