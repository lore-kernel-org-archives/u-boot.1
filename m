Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29204C5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 08:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8183060867;
	Fri, 31 Jul 2026 08:32:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8MIMfzxyHNZh; Fri, 31 Jul 2026 08:32:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76CB06081D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785486733;
	bh=SnLDkXNSUWm/VQeU358Q/mJyuj99diavfCLrDEmjD5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ofhRRIug83kbNeccU+SumG8lLR+mXqNNCDtMiOW/ThIhWiUvo9hyI2n8rluhhifPx
	 BPNmFOC+4wgZ2h7rD3lDpg+LCdZIdzVHLesqzzMZoVLSoX9IWCf1UNU2/ZCWhhPZWY
	 pCb0uSiE0Cqg37T+mSnKZCoU+32RFt5mck01oTK2J7eBjgTqqpn4PJ5a/IFqHuKvur
	 2dU1d2hjFWFodq8+dud8rch73dtKBR+wxde3uworu0/1ILUoCKBNtHRzaj63di5/oS
	 RjnpDwXEzGJHAx2EP83aASSwUdxaGfIUhiV4KJiEkZLumgWSxKlfIzXiOaF2g916Nb
	 ZW/spr84ROOgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76CB06081D;
	Fri, 31 Jul 2026 08:32:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CBED26C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B1F640F43
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2DVqgeHDPq6F for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 08:32:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E650640E0A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E650640E0A
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E650640E0A
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:32:09 +0000 (UTC)
X-Forward-Email-ID: 6a6c5d87323e9d4ba991ff83
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b18b9a88-11f5-4d77-a29a-e341695240ff@kwiboo.se>
Date: Fri, 31 Jul 2026 10:32:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] rockchip: doc: add boot medium layout text
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org,
 trini@konsulko.com, u-boot@lists.u-boot-project.org,
 eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
 <4d7b7705-62d6-4b61-840c-ef1dd28f9435@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4d7b7705-62d6-4b61-840c-ef1dd28f9435@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1785486728;
 bh=SnLDkXNSUWm/VQeU358Q/mJyuj99diavfCLrDEmjD5w=;
 b=tg7wtnqbjpND0uzLKd/fW99tZHX6tlX7IQCHJGNpwibDdA2+kcbsKlGqAt5LXN6HXEFw408RQ
 /RDrJ5xHJCMdMIhmPItFNh9S7VWpwjdNxfuOFfaFIGUMchSnY6Un898V43uEF2iMpVcULIcHaQR
 EE+GO8khuV+vtm5Tis0BVNJCDJPl3yvgEdZOYsCR/RN2vLAVAlOCMyaBSjblBTx7EK53rpyawAK
 9YZR/TN6Tpa9QBu68MmPN0o0V1P0E/iCEhmLB/Tq2hvL2cAmVKtNvPnhvMm1e3xoEdRDqoyyAJU
 I/gSdKOyKx/iZ3Z8wQTkK7h/Mp2g4sgTJWSqWbC99PEg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=tg7wtnqb
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 7/30/2026 3:34 PM, Johan Jonker wrote:
> Add text that explains the boot medium layout options.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V3:
> wrap
> remove 'the'
> use eMMC
> add unit and block size
> ---
>  doc/board/rockchip/rockchip.rst | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> --
> 2.39.5
> 
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index c089419b65e5..6b9007103257 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -353,6 +353,32 @@ To build rk3588 boards:
>          make evb-rk3588_defconfig
>          make CROSS_COMPILE=aarch64-linux-gnu-
> 
> +Boot media layout
> +-----------------
> +
> +The boot ROM only checks a boot medium for a limited number of pages or blocks

I do not like that we keep using inconsistent naming for 'BootROM'.

> +for data. It is not possible to place these blocks randomly.
> +
> +* eMMC/SD card:
> +
> +  Rockchip uses a unified GPT partition layout for it's open source products.
> +  With this GPT partition layout U-Boot can be compatible with other components,
> +  like miniloader, trusted-os, arm-trusted-firmware.
> +
> +  There are some documents about partitions in the link below.
> +  https://web.archive.org/web/20260501050119/https://opensource.rock-chips.com/wiki_Partitions

Please drop this entire 'unified GPT partition layout' section, it is
not something we should encourage user to use. It is legacy and nothing
in mainline U-Boot that depends on this layout.

It has mostly been used to simplify flashing and locating vendor boot
firmware.

For mainline a more appropriate layout would be to reserve initial 0-16
MiB of boot media for partition table and firmware, and use remaining
freely.

> +
> +  Write u-boot-rockchip.bin to block offset 64 (block size: 512 byte).
> +
> +* SPI:
> +
> +  Write u-boot-rockchip-spi.bin to flash offset 0 (unit: bytes).
> +
> +* NAND:
> +
> +  The closed source usbplug binaries and RKMTD use the NAND erase blocks [2-6]
> +  for TPL/SPL.
> +

We should likely also mention UFS if we are listing all other supported
boot media.

Regards,
Jonas

>  BootROM mode
>  ------------
> 

