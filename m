Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A134ECD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 15:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF31838BB;
	Tue, 12 May 2026 17:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="JwMUP5QV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0g9vm3CZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JwMUP5QV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0g9vm3CZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCEBE83C2B; Tue, 12 May 2026 17:12:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95146836AC
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 19EEF6C1DB;
 Tue, 12 May 2026 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778598725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEFvl0YLsXFB/CfhLlFLB4OaER5Lg3kk0MoWnTSGofA=;
 b=JwMUP5QVuXYTsDMpaLzxzLypVGJZI2ZXojekbR8Zi8y+KbbXxeoN37sTwhTIXyL+VC/SAM
 QARnWy0SFZAsGTD2WU48CLDTEv2TwJEuhk5UdyK+KiJ9PXB9okFZiCiZYtBVF37zWAvHpr
 NjMcYeMBbkGV9cCFMdFj4vCh4IEvQmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778598725;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEFvl0YLsXFB/CfhLlFLB4OaER5Lg3kk0MoWnTSGofA=;
 b=0g9vm3CZpKTpy5KUTmMN5s8h8c1TiGo2YKCGGVqIATnQOHTRrHvpZaMXIVYRNcQrjPQYTz
 WVqi4LhrE66OP+DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JwMUP5QV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0g9vm3CZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778598725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEFvl0YLsXFB/CfhLlFLB4OaER5Lg3kk0MoWnTSGofA=;
 b=JwMUP5QVuXYTsDMpaLzxzLypVGJZI2ZXojekbR8Zi8y+KbbXxeoN37sTwhTIXyL+VC/SAM
 QARnWy0SFZAsGTD2WU48CLDTEv2TwJEuhk5UdyK+KiJ9PXB9okFZiCiZYtBVF37zWAvHpr
 NjMcYeMBbkGV9cCFMdFj4vCh4IEvQmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778598725;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEFvl0YLsXFB/CfhLlFLB4OaER5Lg3kk0MoWnTSGofA=;
 b=0g9vm3CZpKTpy5KUTmMN5s8h8c1TiGo2YKCGGVqIATnQOHTRrHvpZaMXIVYRNcQrjPQYTz
 WVqi4LhrE66OP+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 019B7593A9;
 Tue, 12 May 2026 15:12:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id REzsOURDA2oWQAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Tue, 12 May 2026 15:12:04 +0000
Date: Tue, 12 May 2026 18:12:04 +0300
From: "Ivan T . Ivanov" <iivanov@suse.de>
To: Jan =?utf-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>
Cc: u-boot@lists.denx.de, Thomas Fitzsimmons <fitzsim@fitzsim.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH] mmc: bcmstb: Fix non-removable check in bcm2712 init
Message-ID: <2czhyjwfqb7fnssvf2dwbaacez3r3x5w2tgvq3im47gz47o4fc@cjeetuhjau4l>
References: <20260512122435.1118557-1-sairon@sairon.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512122435.1118557-1-sairon@sairon.cz>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.com:email,denx.de:email,nxp.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 19EEF6C1DB
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

On 05-12 14:24, Jan Čermák wrote:
> Date: Tue, 12 May 2026 14:24:35 +0200
> From: Jan Čermák <sairon@sairon.cz>
> To: u-boot@lists.denx.de
> Cc: Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
>   Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
>   Matthias Brugger <mbrugger@suse.com>, "Ivan T . Ivanov"
>  <iivanov@suse.de>,  Jan Čermák <sairon@sairon.cz>
> Subject: [PATCH] mmc: bcmstb: Fix non-removable check in bcm2712 init
> Message-ID: <20260512122435.1118557-1-sairon@sairon.cz>
> 
> sdhci_brcmstb_init_2712() reads host->mmc->host_caps to decide whether
> to force card-detect for a non-removable eMMC, or to route the CD signal
> for a removable SD card. At the time this function runs from
> sdhci_bcmstb_probe(), however, host->mmc->host_caps is still zero, that
> field is only populated later by the MMC uclass, after the driver's
> probe returns. mmc_of_parse() has already filled plat->cfg.host_caps
> from the device tree by this point, so check that field instead.
> 
> Without the fix, every BCM2712 SDHCI instance takes the else branch and
> writes SDIO_CFG_SD_PIN_SEL = SDIO_CFG_SD_PIN_SEL_CARD (0x02), including
> the non-removable eMMC on boards such as CM5 on Home Assistant Yellow.
> The SDIO_CFG block lies outside the SDHCI core's reset scope, so this
> value persists across SDHCI_RESET_ALL into the next stage. On the
> BCM2712, having SD_PIN_SEL set to "SD" when the Linux kernel performs
> its first set_power(MMC_POWER_UP) write racily prevents the SDHCI
> POWER_ON bit from latching (see [1] for the whole backstory) - the
> voltage bits stick but POWER_ON drops - which wedges the first CMD0 the
> full 10 s software timeout. On Home Assistant Yellow this manifested as
> a ~20 s eMMC probe delay on roughly one in two Linux boots when U-Boot
> was the previous stage. Booting directly from the Pi firmware (no U-Boot
> in between) left SD_PIN_SEL at its default and did not exhibit the race.
> 
> Reading plat->cfg.host_caps lets init_2712 see the "non-removable"
> property and take the correct branch, leaving SD_PIN_SEL untouched for
> the eMMC.
> 
> [1] https://github.com/home-assistant/operating-system/pull/3700#issuecomment-4430229511
> 
> Fixes: 10127cdbab64 ("mmc: bcmstb: Add support for bcm2712 SD controller")
> Signed-off-by: Jan Čermák <sairon@sairon.cz>


Reviewed-by: Ivan T. Ivanov <iivanov@suse.de>

Thank you!

> ---
>  drivers/mmc/bcmstb_sdhci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/bcmstb_sdhci.c b/drivers/mmc/bcmstb_sdhci.c
> index 7bddbebb162..f27b84a6ee4 100644
> --- a/drivers/mmc/bcmstb_sdhci.c
> +++ b/drivers/mmc/bcmstb_sdhci.c
> @@ -56,7 +56,7 @@ struct sdhci_brcmstb_dev_priv {
>  
>  static int sdhci_brcmstb_init_2712(struct udevice *dev)
>  {
> -	struct sdhci_host *host = dev_get_priv(dev);
> +	struct sdhci_bcmstb_plat *plat = dev_get_plat(dev);
>  	void *cfg_regs;
>  	u32 reg;
>  
> @@ -65,8 +65,8 @@ static int sdhci_brcmstb_init_2712(struct udevice *dev)
>  	if (!cfg_regs)
>  		return -ENOENT;
>  
> -	if ((host->mmc->host_caps & MMC_CAP_NONREMOVABLE) ||
> -	    (host->mmc->host_caps & MMC_CAP_NEEDS_POLL)) {
> +	if ((plat->cfg.host_caps & MMC_CAP_NONREMOVABLE) ||
> +	    (plat->cfg.host_caps & MMC_CAP_NEEDS_POLL)) {
>  		/* Force presence */
>  		reg = readl(cfg_regs + SDIO_CFG_CTRL);
>  		reg &= ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
