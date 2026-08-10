Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5088BC5AC82
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 09:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01A1D40518;
	Mon, 10 Aug 2026 09:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ri_aab3mRVHN; Mon, 10 Aug 2026 09:16:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19EA240576
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786353392;
	bh=YJgSzdwgUKx2Q/+TgjYgyFWCZJKhtq0W23PlS4NSfOw=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=FJjr7R5PvvradReMGPBwMzW6LoOWJ60zLXoBem8s5rCFJJff8/3X0uQhyhcWkG3uC
	 8KgVcFeZOo0XTvICDfpWaO5Izn9eySUGthGrj18/W6CRIKk+MAq1DOfKzlWmMw5i7+
	 ggS5CzWBifpwDlMTTvVwEo/OTjoo44k6z0sFqx2B/1LcbqHo+9gE+q3+kaQSFCa6JA
	 n7OHRfAG58SyxVLFEzjTV/xbS3q32Oz+OOl1nAX3RVGm+lBucLojVQfrTDmwRcvETC
	 XvGMJLrqihWUBoyREYVQWQWlxw2utGbNjI5y6BPbObSRqs70T2AyNYiNWlDa9vUjAG
	 euB834MjmRHsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19EA240576;
	Mon, 10 Aug 2026 09:16:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 50ADC259
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42DB06064C
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nHLCHeSPDNnK for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 09:16:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::8fab; helo=smtp-8fab.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A01A260628
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A01A260628
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::8fab])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A01A260628
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:16:27 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hJTdh22SvzmX8;
 Mon, 10 Aug 2026 11:16:24 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hJTdf73F0zb16; Mon, 10 Aug 2026 11:16:22 +0200 (CEST)
Message-ID: <e6761f23-097d-4cca-ba8e-9b2838b6083b@0leil.net>
Date: Mon, 10 Aug 2026 11:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3576-rock-4d: Enable XMC SPI chip
To: Martin Herren <sputnik@on-the-web.ch>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>
References: <20260809-rk3576_radxa-rock-4_spi-v1-1-e3f2933f411d@on-the-web.ch>
Content-Language: en-US
In-Reply-To: <20260809-rk3576_radxa-rock-4_spi-v1-1-e3f2933f411d@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786353384;
 bh=YJgSzdwgUKx2Q/+TgjYgyFWCZJKhtq0W23PlS4NSfOw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hHMclOhxxTJDyJU8SdtUU0K3UeJ3NEDI2bBKcuV/UQ40MIKmT1377BkL3gw0UjwOi
 dbjRpV3i7G/cGn4TvLqOLA8XF6j+94vl90vPKnnAzdmVRXg+UxVWAT/KN5baFeNdLs
 2AkFSe6sRB8zLEADBHFqvNkfOa+ask9mHr1MYrU0o7Ux6gArTLge9ifnvHD1iqhx11
 yHfusGXMIRpCuDhhjSvX50lGUS0jLTQlA4uZ2AMMtnmDi5JH/Z86KY0Q0RsCgn4M4a
 R5SC4Qik5TokrakGVZOyt6ZGD9ZaHgBfUEbDQUtUGLv21pECpdmVAFF5scCxHhtmax
 7uX6TAaowWFkQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=hHMclOhx
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Martin,

On 8/9/26 12:07 AM, Martin Herren wrote:
> The Radxa Rock 4D exists also with a different SPI flash chip than the
> one specified in the schematic[1]: XMC XM25QU128C.
> At least board revision V1.12 can be impacted.
> 
> Enable CONFIG_SPI_FLASH_XMC Kconfig options.
> 
> Without this SPL fails to probe the SPI and thus fails to load u-boot

the SPI flash

> proper from SPI.
> 
> Vendor u-boot also enables CONFIG_SPI_FLASH_GIGADEVICE and
> CONFIG_SPI_FLASH_WINBOND so other hardware configuration might exist.
> They are not enabled by this patch.
> 

This patch here matches what's been done in Radxa downstream U-Boot in 
commit 2742c75cc288 ("configs: rk3576 series: enable 
CONFIG_SPI_FLASH_XMC") so fine with me. However, it doesn't apply. I'm 
assuming the issue is the CONFIG_SPI_FLASH_MACRONIX=y line being split 
in two in the git context just above the new CONFIG_SPI_FLASH_XMC=y 
line. Can you please send a v2 with a patch that can be applied?

Try to properly capitalize U-Boot while at it :)

Cheers,
Quentin

> [1] https://dl.radxa.com/rock4/4d/docs/hw/Radxa_ROCK_4D_SCH_V1.12.pdf
> 
> Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
> ---
>   configs/rock-4d-rk3576_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
> index 7228a9d879a..93faf09962c 100644
> --- a/configs/rock-4d-rk3576_defconfig
> +++ b/configs/rock-4d-rk3576_defconfig
> @@ -49,6 +49,7 @@ CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_
> FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_XMC=y
>   CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_PHY_REALTEK=y
> 
> ---
> base-commit: d0615e4a67c8958fad4a8c39262074958f04c179
> change-id: 20260808-rk3576_radxa-rock-4_spi-9c241f4e29e5
> 
> Best regards,
> --
> Martin Herren <sputnik@on-the-web.ch>
> 

