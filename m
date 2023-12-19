Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12414C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 08:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB7187053;
	Tue, 19 Dec 2023 09:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="JaA5U2FC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="319/7vx0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eMoB1p+N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kvXO51A4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A785D871B4; Tue, 19 Dec 2023 09:35:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CFF586FD5
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mbrugger@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED35F1F7B6;
 Tue, 19 Dec 2023 08:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702974930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nWy+M3GCCfDJ3wBww3fFYiLhHwRqvMle/nUpZ++S+w=;
 b=JaA5U2FCTz5GSUMoYkCMOiShrFRAdugyxkPR/lSRXjrSMehJZM2sjbYpVDGGK4N8b31lAr
 8a6nfV70NQj/WyVxT67p602k/PAxE1OxKxpNAfi2JTtIc8ipTxOvD0HhfMHT60uY8NqN7w
 LxOshJGlzZKifhZfs2c8TbKKXZ4u/DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702974930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nWy+M3GCCfDJ3wBww3fFYiLhHwRqvMle/nUpZ++S+w=;
 b=319/7vx0xobKC/MNJPxF1Tbx/oRr/I4Pw7IZV/sGp7hF3RuYm+V9zblBMfBCDA9nZNLeIA
 Vyxx3eeR302VgiAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702974929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nWy+M3GCCfDJ3wBww3fFYiLhHwRqvMle/nUpZ++S+w=;
 b=eMoB1p+NcVnvhi4xOKwmN8wSZClVDN8Eo+B1uSAb/lf2XHxvfSHNvK1gaNhUIzUIohVHxg
 oh3FfZVD1a/rYl1OBpP7UwRpj590RIk+J4e8yA9Y/UP9yuK+vKdTbTLKZmau7QcXjaVBvr
 Gjj5n/I3hX9IjUdKXML962geB3VXvUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702974929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nWy+M3GCCfDJ3wBww3fFYiLhHwRqvMle/nUpZ++S+w=;
 b=kvXO51A4DkZPej0MODDSm6oL2PwYZ6avxASA6a5YQUJ4OHAEvUUhgiwJWME5/pD9GFjvS3
 hdUJapS2sXXbcPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E15CB136A5;
 Tue, 19 Dec 2023 08:35:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CbGgNtFVgWWhBQAAD6G6ig
 (envelope-from <mbrugger@suse.de>); Tue, 19 Dec 2023 08:35:29 +0000
MIME-Version: 1.0
Date: Tue, 19 Dec 2023 08:35:29 +0000
From: mbrugger <mbrugger@suse.de>
To: Thomas Schaefer <Thomas.Schaefer@kontron.com>
Cc: u-boot@lists.denx.de, macpaul.lin@mediatek.com, fparent@baylibre.com,
 mbrugger@suse.com
Subject: Re: Using uart1 on mediatek mt8195 derived board
In-Reply-To: <AM0PR10MB2082C282ACACF92E42484727F78AA@AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM>
References: <AM0PR10MB2082C282ACACF92E42484727F78AA@AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Roundcube Webmail
Message-ID: <800e2ae314b725348f0d25cb1676a04a@suse.de>
X-Sender: mbrugger@suse.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.30 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 XM_UA_NO_VERSION(0.01)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eMoB1p+N;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kvXO51A4
X-Rspamd-Queue-Id: ED35F1F7B6
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

El 2023-12-08 17:06, Thomas Schaefer va escriure:
> Hi Macpaul, Fabien,
> 
> I'm referring to patch series
> https://patchwork.ozlabs.org/project/uboot/patch/20230804110448.24589-1-macpaul.lin@mediatek.com/
> where support for the mediatek mt8195 SOC is introduced into u-boot.
> We are developing a board based on the mt8195 as well but we want to
> use UART1 instead of UART0 for debug output messages.
> 
> Our board is booting and we see boot messages on a debug pin header
> connected to UART0 when using the settings from the demo board, but
> when trying to switch to UART1, no more messages appear on the
> console. What we have tried is the following:
> 
> - Adaptation of the dts and dtsi files with uart1 settings taken from
> linux device tree:
> 
> diff --git a/arch/arm/dts/mt8195.dtsi b/arch/arm/dts/mt8195.dtsi
> index a7e4db5aa7..53eb437fad 100644
> --- a/arch/arm/dts/mt8195.dtsi
> +++ b/arch/arm/dts/mt8195.dtsi
> @@ -245,6 +245,17 @@
>                         status = "disabled";
>                 };
> 
> +               uart1: serial@11001200 {
> +                       compatible = "mediatek,mt8195-uart",
> +                                    "mediatek,hsuart";
> +                       reg = <0 0x11001200 0 0x1000>;
> +                       interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
> +                       clock-frequency = <26000000>;
> +                       clocks = <&clk26m>, <&clk26m>;
> +                       clock-names = "baud", "bus";
> +                       status = "disabled";
> +               };
> +
>                 pericfg_ao: syscon@11003000 {
>                         compatible = "mediatek,mt8195-pericfg_ao", 
> "syscon";
>                         reg = <0 0x11003000 0 0x1000>;
> 
> diff --git a/arch/arm/dts/mt8195-kontron-sbc-i1200.dts
> b/arch/arm/dts/mt8195-kontron-sbc-i1200.dts
> index c6ea7e8f3d..4700a6d303 100644
> --- a/arch/arm/dts/mt8195-kontron-sbc-i1200.dts
> +++ b/arch/arm/dts/mt8195-kontron-sbc-i1200.dts
> @@ -58,7 +58,7 @@
>         };
> 
>         chosen {
> -               stdout-path = &uart0;
> +               stdout-path = &uart1;
>         };
> 
>         reg_1p8v: regulator-1p8v {
> @@ -121,7 +121,7 @@
>         status = "okay";
>  };
> 
> -&uart0 {
> +&uart1 {
>         status = "okay";
>  };
> 
> We also tried to change the DEBUG_UART settings in the defconfig to
> match with UART1, but without success.
> 
> Are there any special means to make UART1 interface run?

Did you had a look in the DTS from the kernel:
https://elixir.bootlin.com/linux/v6.7-rc6/source/arch/arm64/boot/dts/mediatek/mt8195.dtsi#L1040

My bet would be that infracfg_ao CLK_INFRA_AO_UART1 is not configured 
correctly.

Best regards,
Matthias.

> 
> Best regards,
> Thomas
> 
> Thomas Schäfer
> SW Design Engineer
> 
> T:
> +49 681 95916 203
> 
> 
> thomas.schaefer@kontron.com
> www.kontron.com
> 
> 
> 
> 
> Kontron Europe GmbH
> Heinrich-Barth-Straße 1-1a | 66115 Saarbrücken | Germany
> 
> 
> 
> Die gesetzlichen Pflichtangaben finden Sie hier
> Please find our mandatory legal statement here
> Unsere Datenschutzerklärung finden Sie hier
> Please find our mandatory privacy statement here
