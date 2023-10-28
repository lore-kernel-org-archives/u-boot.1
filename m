Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FD8C4332F
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 20:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C5F186CB1;
	Sat, 28 Oct 2023 22:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="fwJHw2yh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D6586E42; Sat, 28 Oct 2023 22:31:16 +0200 (CEST)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ba])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF78B86B7A
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 22:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
Date: Sat, 28 Oct 2023 22:31:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1698525072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/UED8rtEj0bTfbI1gwnHxQM48IX87A9aSEYe/r8wWAs=;
 b=fwJHw2yh0NcE+yRD9FGKesqVWkZQMNzlAbjjYjCORrM77lKacisjOM3oYnTxqwrZjyyWAu
 cuPdaCemxsN3cHBjbOMlw6x6iAOTWkVw5KMFeTQ2vVuD5M3df8BFbwvMJcb5tXkDByNvYJ
 Erc44cZBRO0tWJcSNXYpfxyCp9nynsU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>
Subject: Re: [PATCH] mmc: sdhci: Rework SDHCI_QUIRK_BROKEN_R1B
Message-ID: <ZT1viTCUl-LKj8Dm@grimlerstat.localdomain>
References: <20231027205702.1549693-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027205702.1549693-1-sean.anderson@seco.com>
X-Migadu-Flow: FLOW_OUT
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

Hi Sean,

Tested on odroid-u2 (exynos4412-odroid) on top of 2024.01-rc1, still
works fine, so feel free to add:

Tested-by: Henrik Grimler <henrik@grimler.se>

Best regards,
Henrik Grimler

On Fri, Oct 27, 2023 at 04:57:03PM -0400, Sean Anderson wrote:
> As noted in commit 3a6383207be ("mmc: sdhci: add the quirk for broken
> r1b response"), some MMC controllers don't always set the transfer
> complete bit with R1b responses.
> 
> According to the SD Host Controller Simplified Specification v4.20,
> 
> > In the case of a command pairing with response-with-busy[, Transfer
> > Complete] is set when busy is de-asserted. Refer to DAT Line Active
> > and Command Inhibit (DAT) in the Present State register.
> 
> By polling the DAT Line Active bit in the present state register, we can
> detect when we are no longer busy, without waiting for a long timeout.
> This results in much faster reads/writes on buggy controllers.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> I've CC'd a few people who've added this quirk to controllers recently.
> Please let me know if your hardware still works. It's possible that my
> hardware is buggy in a different way.
> 
>  drivers/mmc/sdhci.c | 19 ++++++++++++-------
>  include/sdhci.h     |  1 +
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index fc9c6c37996..0178ed8a11e 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -306,14 +306,19 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
>  		if (stat & SDHCI_INT_ERROR)
>  			break;
>  
> -		if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
> -			if (host->quirks & SDHCI_QUIRK_BROKEN_R1B) {
> +		if (host->quirks & SDHCI_QUIRK_BROKEN_R1B &&
> +		    cmd->resp_type & MMC_RSP_BUSY && !data) {
> +			unsigned int state =
> +				sdhci_readl(host, SDHCI_PRESENT_STATE);
> +
> +			if (!(state & SDHCI_DAT_ACTIVE))
>  				return 0;
> -			} else {
> -				printf("%s: Timeout for status update!\n",
> -				       __func__);
> -				return -ETIMEDOUT;
> -			}
> +		}
> +
> +		if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
> +			printf("%s: Timeout for status update: %08x %08x\n",
> +			       __func__, stat, mask);
> +			return -ETIMEDOUT;
>  		}
>  	} while ((stat & mask) != mask);
>  
> diff --git a/include/sdhci.h b/include/sdhci.h
> index 70fefca2a97..a1b74e3bd79 100644
> --- a/include/sdhci.h
> +++ b/include/sdhci.h
> @@ -57,6 +57,7 @@
>  #define SDHCI_PRESENT_STATE	0x24
>  #define  SDHCI_CMD_INHIBIT	BIT(0)
>  #define  SDHCI_DATA_INHIBIT	BIT(1)
> +#define  SDHCI_DAT_ACTIVE	BIT(2)
>  #define  SDHCI_DOING_WRITE	BIT(8)
>  #define  SDHCI_DOING_READ	BIT(9)
>  #define  SDHCI_SPACE_AVAILABLE	BIT(10)
> -- 
> 2.35.1.1320.gc452695387.dirty
> 
