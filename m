Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068DBC5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 04:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC9BD40670;
	Wed, 19 Aug 2026 04:53:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cwlgScq-TvXB; Wed, 19 Aug 2026 04:53:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787115226;
	bh=FgPMMM/RyK48lMbLKs8RGYaZLTSNOiIj/gkiyfSCmoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JoCiy6JqpZ2p9bVjZKOZfHOGskzCfUNULldHPgq+wrQ3IoZKlhb2n965QMX0ZAcpw
	 iggH3hRD2YPa9SiuaEG3JyUNo53NZn24vEaEg3xstFjBsAsK+81Hg6srhLOlH4+Xs3
	 BmQEFwj/hadPnVC+q8z3cc9S0hsEQUlhh5sJiXUftqFT6IcaHwXS5eTAfQo5lazp/g
	 Kkrpq/AIVYsXCYGsFdQCDlvxf28g/ZejW6H1w0BS+K/AoBuKUkk3xr9AenCYd3Ug6m
	 1NjhFWLWevAB0D4gGgjfR162nC03dpaX/j/v7xzE4lbJrsUl8usGME9oX96kduznhT
	 /TlvLslAbvEMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A91D40674;
	Wed, 19 Aug 2026 04:53:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C057F39E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 04:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B28A980DE8
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 04:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0_sXtQZX-eXA for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 04:53:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=VG855OfC
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2E2F80BB9
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 04:53:43 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hPvNN49L2zMlBx;
 Wed, 19 Aug 2026 06:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787115220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgPMMM/RyK48lMbLKs8RGYaZLTSNOiIj/gkiyfSCmoY=;
 b=VG855OfCoMmXMF3VMZpXPsbhPViERXkhneqRpFXsnIUpuFNSdybyO1O0utjr2BOSM4SoBf
 pe2lgGzxSqUJWYLUDpdwZ4LAkn4cKedCQasyHgzGOxh4YBjwJLDqVQJ7SCwWwnIy899uYX
 otnHHnUa3s4zrE2gg3fTgzNiOX6LAEKAcYPFaef1R+a0UL0naqRpvKENdmN9c3gre0YlzP
 aVDpX3lYbYP0AIPSVKeJ8f9FgQjKAOk/A4wCJ/eK1G1XE9LMRpyAebRRrF3nGYaSQ8c8O1
 m9ER2u/8kLK4uO/Cc3Y3LUs2kgKqaqHoO+79m1WgD10CWKsprxQW5A96Q6BYcg==
Message-ID: <1a8642c2-58c8-45fb-a0b6-2ae91076e790@mailbox.org>
Date: Tue, 18 Aug 2026 17:39:11 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: ehci-vf: take the controller index from the device
 tree
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org
References: <20260818151236.2891878-1-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260818151236.2891878-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 767337d224fe41c0843
X-MBO-RS-META: c1hmrwh5rhqg3yxyyjazh5j36bbjikqi
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/18/26 5:12 PM, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> "usb start" dies with a data abort on a Colibri VF50 and on a Colibri
> VF61, and the watchdog resets the board:
> 
>    Colibri VFxx # usb start
>    starting USB...
>    Bus usb@40034000: Port not available.
>    data abort
>    ...
>    r4 : 00000003
>    Resetting CPU ...
> 
> vf_usb_of_to_plat() takes the controller index from dev_seq(), but the
> sequence numbers of the two controllers are 2 and 3:
> 
>    Class     Seq  Probed  Driver    Name
>    usb         2  [   ]   ehci_vf   usb@40034000
>    usb         3  [   ]   ehci_vf   usb@400b4000
> 
> uclass_find_next_free_seq() starts numbering above the highest alias of
> the uclass, and fdtdec_get_alias_highest_id() matches an alias by its
> name prefix plus trailing digits, so the usbphy0 and usbphy1 aliases of
> the vf device tree count as "usb" aliases and reserve 0 and 1. The two
> controllers have no aliases of their own and end up with 2 and 3, past
> the two entries of phy_bases[] and nc_reg_bases[]. usb_oc_config() then
> loads a base address from beyond the table and writes to it, which is
> the abort above. The bounds check that would have caught this only
> exists in the non-DM ehci_hcd_init().
> 
> Follow the fsl,usbphy phandle, as ehci-mx6 does, and map the PHY node
> to the index of the driver's own table instead of trusting the sequence
> number, since the alias numbering is what goes wrong here.
> 
> Tested on a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from
> NAND: "usb start" now brings up the host controller and enumerates the
> root hub instead of resetting the board.
> 
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> ---
>   drivers/usb/host/ehci-vf.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
> index 96d1363a76e..32fe05920d0 100644
> --- a/drivers/usb/host/ehci-vf.c
> +++ b/drivers/usb/host/ehci-vf.c
> @@ -221,8 +221,23 @@ static int vf_usb_of_to_plat(struct udevice *dev)
>   	const void *dt_blob = gd->fdt_blob;
>   	int node = dev_of_offset(dev);
>   	const char *mode;
> +	fdt_addr_t phy_addr;
> +	ofnode phy_node;
> +	int i;
>   
> -	priv->portnr = dev_seq(dev);
> +	phy_node = ofnode_parse_phandle(dev_ofnode(dev), "fsl,usbphy", 0);
> +	if (!ofnode_valid(phy_node))
> +		return -EINVAL;
> +
> +	phy_addr = ofnode_get_addr(phy_node);
> +	for (i = 0; i < ARRAY_SIZE(phy_bases); i++) {
> +		if (phy_addr == phy_bases[i])
> +			break;
> +	}
> +	if (i == ARRAY_SIZE(phy_bases))
> +		return -EINVAL;
> +
> +	priv->portnr = i;
Would it be possible to eliminate the priv->portnr and index based PHY 
handling in favor of parsing the PHY addresses from DT fully, possibly 
in a follow up patch ?

This fix looks good.
