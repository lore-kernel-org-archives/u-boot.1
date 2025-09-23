Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68D0CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 13:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 510F283443;
	Tue, 23 Sep 2025 15:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="fegvz1z/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DF8A83448; Tue, 23 Sep 2025 15:06:05 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF22833E9
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 15:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
 :Date:subject:date:message-id:reply-to;
 bh=952SFeXF/8HThbaoH7EEBBxteIGPDYTMgieKpoEPu1w=; b=fegvz1z/4yiiQdZd3RaKe+o34B
 vXg95V0eG9zCP7uX0G7pLbaR796lHdLpcA2BwhXx0zh+FEnVraQltD2CmxfUprsxB/0lXfTm+nuys
 QxYK+8d/RHdmw9M+YRcY+CaOdUdstQBlgIjn/Cauaca0loNIBI8gmC7EkrX2GCHYhbvk=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:58376
 helo=pettiford) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1v12iA-0001eR-Gh; Tue, 23 Sep 2025 09:05:39 -0400
Date: Tue, 23 Sep 2025 09:05:37 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, Paul
 Barker <paul@pbarker.dev>, Sam Protsenko <semen.protsenko@linaro.org>, Peng
 Fan <peng.fan@nxp.com>, u-boot@lists.denx.de, anton.reding@landisgyr.com
Message-Id: <20250923090537.baeeb1d2a347fbb5e746556c@hugovil.com>
In-Reply-To: <20250922162901.22908-1-othacehe@gnu.org>
References: <20250922162901.22908-1-othacehe@gnu.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH v2] board: rzg2l: Check the DTB pointer passed by the TF-A.
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

Hi Mathieu,
thanks for the patch, I have been wondering why the latest U-Boot
didn't work for the renesas EVK.

Note: remove the trailing dot from all your commit messages.

On Mon, 22 Sep 2025 18:29:00 +0200
Mathieu Othacehe <othacehe@gnu.org> wrote:

> On the RZG2L platform, the advised
> TF-A (https://github.com/renesas-rz/rzg_trusted-firmware-a/tree/v2.5/rzg2l)
> does not pass any DTB blob to U-Boot.
> 
> On the other hand, the RZG2L part of U-Boot expects a DTB to be passed.  It
> means that if one flashes the latest TF-A as well as the mainline U-Boot,
> it will crash trying to dereference the NULL DTB pointer before outputing
> anything.
> 
> Check if the DTB pointer is NULL before trying to use it.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
> v1: https://lists.denx.de/pipermail/u-boot/2025-September/598712.html
> 
> Changelog:
> v2: Keep compatibility with TF-A passing DTB blobs.
> 
>  arch/arm/mach-renesas/cpu_info-rzg2l.c | 2 +-
>  board/renesas/rzg2l/rzg2l.c            | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-renesas/cpu_info-rzg2l.c b/arch/arm/mach-renesas/cpu_info-rzg2l.c
> index ab95ce76388..a9cb9f72dd3 100644
> --- a/arch/arm/mach-renesas/cpu_info-rzg2l.c
> +++ b/arch/arm/mach-renesas/cpu_info-rzg2l.c
> @@ -30,7 +30,7 @@ static const struct tfa_info *get_tfa_info(void)
>  {
>  	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
>  
> -	if (fdt_magic(atf_fdt_blob) == FDT_MAGIC) {
> +	if (atf_fdt_blob && fdt_magic(atf_fdt_blob) == FDT_MAGIC) {
>  		unsigned int i;
>  		for (i = 0; i < ARRAY_SIZE(tfa_info); i++) {
>  			if (!fdt_node_check_compatible(atf_fdt_blob, 0,

Would it be a good idea to:

a) "return &invalid_tfa_info" if atf_fdt_blob is valid but
fdt_node_check_compatible() fails to find a valid node?

b) "return tfa_info" if atf_fdt_blob is not
valid?

This is inspired by what you proposed in your patch
"board: rzg2l: Do not expect a DTB blob from the TF-A."

This would look like this (on top of this current patch):

--------------------------------------------------
@@ -37,9 +37,11 @@ static const struct tfa_info *get_tfa_info(void)
                                                       tfa_info[i].soc_name))
                                return &tfa_info[i];
                }
+
+               return &invalid_tfa_info;
        }
 
-       return &invalid_tfa_info;
+       return tfa_info;
 }
--------------------------------------------------

With this, I am able to successfully boot using the current TF-A.


> diff --git a/board/renesas/rzg2l/rzg2l.c b/board/renesas/rzg2l/rzg2l.c
> index 509c5dbb156..3c8f8d04cbd 100644
> --- a/board/renesas/rzg2l/rzg2l.c
> +++ b/board/renesas/rzg2l/rzg2l.c
> @@ -22,7 +22,7 @@ int board_fit_config_name_match(const char *name)
>  {
>  	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
>  
> -	if (fdt_magic(atf_fdt_blob) != FDT_MAGIC)
> +	if (!atf_fdt_blob || fdt_magic(atf_fdt_blob) != FDT_MAGIC)
>  		return -1;
>  
>  	if (is_rzg2l_board("renesas,r9a07g044l2"))
> @@ -36,7 +36,7 @@ static void apply_atf_overlay(void *fdt_blob)
>  {
>  	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
>  
> -	if (fdt_magic(atf_fdt_blob) == FDT_MAGIC)
> +	if (atf_fdt_blob && fdt_magic(atf_fdt_blob) == FDT_MAGIC)
>  		fdt_overlay_apply_node(fdt_blob, 0, atf_fdt_blob, 0);
>  }
>  
> -- 
> 2.49.0
> 


-- 
Hugo Villeneuve
