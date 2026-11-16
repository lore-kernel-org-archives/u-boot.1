Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D616C606A33D
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u0USVFBD;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=EFb04vBR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EB6180E78;
	Mon, 16 Nov 2026 13:49:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CQLZ-XkRQuDO; Mon, 16 Nov 2026 13:49:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52BA780DD8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794836971;
	b=QjTi3nfQm9srwOtQLl3SxELTUEtPUvX9Yb9+LvRtvobH0/1TXvllIB8FGLBf0tHIzqR+
	 Ov9Pk/v7kTuL2NL5FBX0KDTUW4QRFZGTr6ypGKRKmZR744RnBnJRUykvNcb4rItQzo1vp
	 NGcTtz7iqBzj7ONc6ce9PxX4lY0bdLpRN4urDY+g+H3Zuk1qADAUtBDKX9VhSNtRHqTVm
	 7mffauG1d9eSagDXMBag/vO8JB5eNwxAdlJoUIjMugqiTR6UuRgAZT/ZfEheyY7k0ubZM
	 /Us75AMaiQLCTvgHUrsaDd2W6V11qBA5HY8aWBHjxeR9DtBaL2ZpdWYdSSut3Vd9BUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794836971;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AZMvaPh3APsJUxyhjHUNuMioytERo3sUwN8J/RqGOk0=;
	b=lpweR0gs8twl8GJx8Luje9+CYPSuFa+5MLUSkjgqOJDJsZqBfwhCzI9J8WZEVmf8UPsi
	 Pl3VTYlKrB3/6LZyCecbnd5PPlGIK/vpFcUTinS21/GV5q017iF8C2+dwFRisS0TsXoHd
	 4STQRmXXzK74lDp/IitgTvcKykM43eme2zvWAe3o8gIiBvfc/FLqC25OrkPl4rCn8z8ro
	 46UuxJ4qG+IvLxXN6TH7Eqk0dTh2A+OXkugz7+QrSpxw5u1VYdnpoYvdGf8M4B+N00U0m
	 rxrCVaQr8eY1l0fnHy34TBbwMXpPn7qACYctaJxn/LK7F6fnHuCYQMVHtECsHy89gzQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=EFb04vBR;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794836971;
	bh=AZMvaPh3APsJUxyhjHUNuMioytERo3sUwN8J/RqGOk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u0USVFBDYT26JBTwJ4HYRhZgGtmW51kqIQRhyKvmCX3YhpXSRgZZYU0em5fmAla46
	 AfH43Au2ov0TOAytrFQiKg+UwF0SNpBDapgfmeiWbHIXE92rSYfVpi+RkbUJzoBaKI
	 XaKtv/aLQ7b5aqH5Wmmc213sE4NokyYyDG1dOhzr2Z7SfNm0gExOL98xOG2z7l1q2i
	 GG/2MaanfvOetCVRkn34yIdUCTcwOOpcWLBbqjEZgrMaA74Ew4+ISvopx8fI/b3WE2
	 iSTNR0pg0wBJG99LmC2+TleMrGdcMPYpgcAlDDYMNC/asbwV40skmjy3W89JJzFEw/
	 /kjv0wR5ukLXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52BA780DD8;
	Mon, 16 Nov 2026 13:49:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 573C8109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DB7D80DD8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYxPZaaf3gjP for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 13:49:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5A5ED80DB1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.125.25.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.15;
 helo=smtp-190f.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=EFb04vBR
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [185.125.25.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A5ED80DB1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:49:25 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jSq3R2NGcz2L1l;
 Mon, 16 Nov 2026 14:49:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794836963;
 bh=AZMvaPh3APsJUxyhjHUNuMioytERo3sUwN8J/RqGOk0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EFb04vBR3KNwduxfAsophCkUtsjQMraCW7GqNYzRMJpiHxBKorkHGxthVahgCoY4C
 yAZBP/zdcsn+Nkc6QFu8q8XkAUSk1nz6KKsG2eR+IduIEFPqT91TUB8W6dkQzDHtoa
 RPA7iIW6p+lT8tB6p5mS/9giUzkxkzNaLbsDK8WiHOqxkag8AkQuyZpd0PrC280M3P
 LNWygNnKLK9qefwnOFU5O8RzkjoQtp0nKZueJK/s0OkvcLM7cKM7gjEOkGa5xSrbkJ
 HZVEn9qQcBRtYZyWttbhhGEwfWVs7rLLsFi61Uupp2DH5T/z92XdNXk9QTR6IJ+dss
 UVCQMGHG6rsaw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jSq3Q1XbXzV8Q; Mon, 16 Nov 2026 14:49:22 +0100 (CET)
Message-ID: <49c209b8-edb9-40a1-b6af-0c1f7d243306@0leil.net>
Date: Mon, 16 Nov 2026 14:49:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: Add Kobol Helios64
To: iav@iav.lv, Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261116-b4-helios64-v2-1-3631141e429e@iav.lv>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261116-b4-helios64-v2-1-3631141e429e@iav.lv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On 11/16/26 1:19 AM, Igor Velkov via B4 Relay wrote:
> From: Igor Velkov <iav@iav.lv>
> 
> Add support for the Kobol Helios64, an RK3399 NAS board with 4 GiB of
> LPDDR4, eMMC, SD card, SPI NOR flash, a 1 GbE RTL8211F PHY, a 2.5 GbE
> RTL8156 on USB and a JMB585 SATA controller on PCIe.
> 
> The board uses the upstream device tree. The -u-boot.dtsi adds the
> LPDDR4 timings for the open-source TPL and the vdd_log PWM regulator
> and the vdd_center RK808 buck, and sets both rails to 950 mV. RockPro64
> sets vdd_center the same way, see commit f210cbc1f3d4 ("arm: dts:
> rk3399-rockpro64: slightly increase center voltage").
> 
> The upstream device tree gains both rails in Linux 7.5. Until
> dts/upstream catches up, the -u-boot.dtsi describes them; after that
> only the 950 mV settings remain here.
> 
> Without the vdd_log and vdd_center nodes, Linux 7.3 reset or hung about
> 2.3 s into the boot in 2 of 2 cold boots. With both rails at 950 mV,
> 20 cold boots of Linux 7.3 showed no memory errors.
> 
> Linux can leave the SD card at 1.8 V across a watchdog reset or a panic,
> and the RK808 LDO that supplies the card I/O (vcc_sdio_s0) keeps that
> voltage. Enable the IO-domain driver in SPL, so that SPL sets the SDMMC
> IO domain from the voltage of that regulator and can read the card.
> 
> U-Boot proper sits at 0xE0000 in SPI flash, the RK3399 default, rather
> than at 0x80000 as in Kobol's vendor U-Boot. Kobol's instructions start
> from microSD, and Armbian, the image Kobol recommended, always wrote the
> whole loader to SPI at once. In normal use nobody flashes the U-Boot
> stages to SPI separately, so old TPL/SPL never meet a new proper and
> nothing depends on 0x80000. Whoever updates the stages one by one by
> hand does it on purpose and knows where each goes. There is no reason
> for a board-specific offset.
> 
> Features tested on a Helios64:
> - eMMC boot (TF-A v2.13.0 BL31, open-source TPL), also after watchdog
>    resets and power cycles
> - SD card boot, also after a watchdog reset or a panic left the card
>    at 1.8 V
> - SPI flash boot
> - GMAC Ethernet (DHCP, TFTP)
> - USB 3 host
> 
> Not working yet: PCIe, and the RTL8156, which U-Boot has no driver for.
> 
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> vdd_log and vdd_center are applied for Linux 7.5:
> https://lore.kernel.org/r/20261021-helios64-vdd-log-center-v1-1-4cafd110e0e5@iav.lv
> I said I would wait for devicetree-rebasing, but the rest of this patch
> does not depend on it. Until the sync the nodes stay in -u-boot.dtsi;
> after it a follow-up reduces them to the 950 mV settings. Is that fine,
> or should this wait for the sync?

This patch will be for the next (2027.04) branch anyway. If I did my 
maths correctly:
- 2027.04-rc1 should be published on Monday, January 25th.
- v7.5-rc1 should be published on Sunday, January 24th. Add a few more 
days/a week for devicetree-rebasing to sync.

So, we could also just wait for end of January and not have to need 
additional follow-up patches? Even a few days after our -rc1 is released 
is fine.

https://docs.u-boot-project.org/en/latest/develop/process.html#management-summary

states:

"""
A patch that is generally in good shape and that was submitted while the 
Merge Window was open is eligible to go into the upcoming release, even 
if changes and resubmits are needed.
"""

So this strategy is allowed by the project (note that **I** will 
*generally* not add new features or new board support after -rc1, but 
when it's discussed up front like here and justified, then that's fine).

Cheers,
Quentin
