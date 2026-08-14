Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54A2C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53A02812B6;
	Fri, 14 Aug 2026 22:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u6vjm7Bp6gq4; Fri, 14 Aug 2026 22:44:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B11A4812B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747464;
	bh=OakyUJSFsugIZbj37Kn5uqmB1vNHoD4RuP9GWKS/TRE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SQfuzIWkubc0h8akx+DVoBTGyTRRzzELSQMtmD0QSyMGy9uBCwwwirVFvZG7p7A6K
	 TepA8PwxSI2ATywU1cJZESHeBrq6e917vkuckyGfSucLR+x9qYtr6QOiSAiom1DRMw
	 kr5K236o9czgyYBpLes60W1XDHkWYbM48dKTqk1tVX2EAe3gEpiTMxHTAR2R+iUmeJ
	 cDRU8wTfWwodXrUGhmWANwS1RZcXUfqpAonkTEesTnEyUvfWqZN+VTar4HL82lcaRW
	 D5kABGHTR/qJWfcXs4Kh2JD8wR7V8MHaYe9/i9cg/nhqG+rcT2c5h3Pc5cKlxUqOKT
	 U3BierHUUa6AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B11A4812B4;
	Fri, 14 Aug 2026 22:44:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 85071139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7722660DC6
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mhRCHIMPBKoV for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6F72860A86
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F72860A86
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F72860A86
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:20 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hMHN23ZyczMl1M;
 Sat, 15 Aug 2026 00:44:18 +0200 (CEST)
Message-ID: <7243d0c9-1466-4236-9d41-5d78fa1cae4f@mailbox.org>
Date: Sat, 15 Aug 2026 00:25:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/8] ARM: renesas: RZ/N1 QSPI controller features
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Udit Kumar <u-kumar1@ti.com>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-4-56b6acef0439@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-v2-4-56b6acef0439@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oct9wykhui8p6asad919r3d4j6fx7fwd
X-MBO-RS-ID: 4629486b1a25535197e
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/14/26 8:38 PM, Ralph Siemsen wrote:
> The Renesas RZ/N1 has a QSPI controller which offers memory-mapped
> "Direct Access" mode, so enable SPI_DIRMAP for this platform.
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>   arch/arm/mach-renesas/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
> index f86acc31039..4d16d541443 100644
> --- a/arch/arm/mach-renesas/Kconfig
> +++ b/arch/arm/mach-renesas/Kconfig
> @@ -70,9 +70,13 @@ config RZN1
>   	select DM
>   	select DM_ETH
>   	select DM_SERIAL
> +	select DM_SPI
>   	select PINCTRL
>   	select PINCONF
>   	select REGMAP
> +	select SPI

Shouldn't this be in board config ? Not all RZN1 boards likely require SPI ?

> +	select SPI_MEM
> +	select SPI_DIRMAP
Shouldn't this be selected by the SPI NOR driver instead ?
