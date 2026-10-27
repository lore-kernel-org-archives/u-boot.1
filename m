Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10012606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hnh4Cyfq;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=A75DZtEp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61A4040707;
	Tue, 27 Oct 2026 17:54:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yiXlgwLP3-e7; Tue, 27 Oct 2026 17:54:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1072C40651
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793123698;
	b=g5vBCgl6xuVe/+jyYJlsxpL1tYeORrk0OkFRlJKFE+6XyjWfmJ5BPOsBlQS07p0Qx66T
	 ZKWLkY9BAmDRmdppNFy+G5QPuUXXlXzEsTEkcpySGnVgAqva1gZNglbS0ojortf5lmSrF
	 uTYeaiQ4wzX69oJBcx0ckDZayQHtOSS0gGbW2hcdkCB2STHtICNi7J5h5uyjCYKuy2w1D
	 Y3kZ4zdMrst4bVTsPMrCVQ1PqXq4xKVtdDxResBKLOkTiOut4/UlgDTSoDGOIOWg8cX7j
	 ncbONw1iTIwNPZ0e1EKpkAVpnn13ncr28Es7g8CRyz4t46xMI5u9bWcvk15ff2OOkoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793123698;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cd9RZbmwAjPgcC/4q/EEufgN3HtCaiSlN59WBOkfkyQ=;
	b=VTrKDDdp66c9CYuK9qGdH4ZLYufhgmdVP3f22e6qfdwtFQdY/N7GCUafjnEx/LpR3aqs
	 rEjjprVOAmiUoWu84iYi88ZfSLv1maMutYIpT7p99/QAtkFvPB4J/dT2JuBMQ2iEYnt93
	 wkoWs3V2Cjiq4TuKBtv7bSaH6ZdIAvaV0JohIzMSMO7aK7SClB6bBnOFBLEZ+0X6MvYc6
	 Itwpnc+1ax8NHoJ9HAt0zPVcIl1WOBGfGeYEFpuQUw1R8Lj5wiqq7GuELWsf5n8VisV4h
	 da3AeenEeabtKoHI0xxMFjck4xD3wyzF4zFKunVEDBHZBwhM9+0IMQNpwivmC9Kq+XQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793123698;
	bh=cd9RZbmwAjPgcC/4q/EEufgN3HtCaiSlN59WBOkfkyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hnh4Cyfq6DWst/POkKtozxOjr6WhgIW82KF73Hdi5Z+xoO22OI6yrJ783/dByIwj1
	 4QkJT1iyXOqgImJ/x9q2+KL99S8V1pwFaVnzXsXxY/UrAgYZQVbW4BfkRhar6F8tIs
	 HwAvgyPzWVQOdAKGp21v3miWKvUMPqKoVqrK2Xoe/vNTnvj98VkCQjBA7VsdODPh6f
	 1BAd2Abe1FE6FTrhGqvW+QA67NrFgU72U6OigIY4ikpJJJIJjGREyBq/+H1/xbrS0j
	 2rkVQrBuOL4xt1ms/CgHq2mGxAEefjIWOxJdaE360i2APVbtFU5zTAeRhk4BlyFdq3
	 m0q6ywima9gsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1072C40651;
	Tue, 27 Oct 2026 17:54:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B29824D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A114D401B9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:54:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tEmi0QDxP0h5 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 17:54:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 83D424016B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793123695;
 b=PrdBkecvP/gYgBUd4AP9Bsmmv+TermOysR8rj1UPmUcUNXlx8AjTrtUbCm+aQCs0Tux1
 M8PQ/djZL07PTiXUnznha1rGVozkRoHu4tABgQjotGboAs4FpMlDI8priSApi9i5cRL5V
 LslhpEYp4cjeksJ0ns3X88aZhDpDldVsaT7dsXp2nc+rgYS0Chc7qkRDZTWCW9gGWGHJg
 FIXpocFKNT9exV+vpyWs1Y1jkyRliBds8dBTx/81w2S28+IlRx0Px4gFRYeHphgnB0XBY
 9WIjchvtsrh4bhb5ln/kQy3uv3DqgdeynPzIIiTzRUvF4MEAyV/9VrNGC3haDIuzrtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793123695;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=cd9RZbmwAjPgcC/4q/EEufgN3HtCaiSlN59WBOkfkyQ=;
 b=UsbvS/8Pb0i1xqFx2Jye5yGAwkipp6pb2AeBNrHqdwPeFQxEQmkbuo+JmEH43vHlqX9h
 +uWW+j6q4nf0+x/YPXYMZAFHfTGI3OLe4M8goK7+ybhYpp7pTbfUq7UCiTU2GV79Z6N22
 SVCfDq3NHukP1w0J/rH6fsX2ydT3GKKVfo8s0nm9m02FlA/KynSCysz5CpkfcD8fWmN0r
 ikkLaTxhQKsPOeov+S7D2hasTHzFHV3O54hkp3PYoZ+v0TvJg+89LHh5GAZwVztrdssrJ
 5EtZGYXQxAbYJ0nEkJ278ZpUE4McaWouctVd+wFCY0uFIt4gnhYA1Sa2Nnjz6mCmKkg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=A75DZtEp; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=A75DZtEp
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83D424016B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793123665;
 bh=cd9RZbmwAjPgcC/4q/EEufgN3HtCaiSlN59WBOkfkyQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=A75DZtEpyUYssqJyoZgLwZHt6MkIVA0J9nHSoTo2527uD19ndVESxSun6lT+UaNnk
 uLPkEoek03jvGeojprZlvd30PIrnD2cZy+W7C7yGhyjsYqkGR6TWYT9GOJ+eeCsmRw
 I5CaHXubTMqGFgbvX6mcbj70co8gGDt05DnXTR5GDUhRA+azPoMfNr6GgStFOybCNa
 xWvSH1hh8uuuhiIVgrNauKJeO7vRAaYy1JHQM6R+WNa5WyunlBViRK0sjuWjgOgkw/
 +dXK5YrxbtTgKFNT2IvkVewPceXAuxIViYWuRvQRID6F6SNZogNj3nXGzMU10L5aGc
 97URCtZxlpDQg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 630B3B22052E;
 Tue, 27 Oct 2026 18:54:23 +0100 (CET)
Message-ID: <4817a138-b88d-4d1d-8a93-d014139901d8@freeshell.de>
Date: Tue, 27 Oct 2026 10:54:16 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs: k1: enable GigaDevice SPI NOR flash support
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>
Cc: Tom Rini <trini@konsulko.com>, Guodong Xu <docular.xu@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261027154347.1392094-1-alan.tseng.cs@gmail.com>
 <20261027154347.1392094-2-alan.tseng.cs@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261027154347.1392094-2-alan.tseng.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 08:43, Hung-Chun Tseng wrote:
> The Milk-V Jupiter boots from a GigaDevice GD25Q64 SPI NOR flash, but
> spacemit_k1_defconfig only enables the Winbond ID table, so neither the
> SPL nor U-Boot proper can detect it:
> 
>   jedec_spi_nor flash@0: unrecognized JEDEC id bytes: c8, 40, 17
> 
> Enable SPI_FLASH_GIGADEVICE. With it, "sf probe" on a Jupiter reports:
> 
>   SF: Detected gd25q64 with page size 256 Bytes, erase size 4 KiB, total 8 MiB
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
>  configs/spacemit_k1_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
> index 8ee9baa13..b8f777e89 100644
> --- a/configs/spacemit_k1_defconfig
> +++ b/configs/spacemit_k1_defconfig
> @@ -88,6 +88,7 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
>  CONFIG_MMC_HS400_SUPPORT=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_SPACEMIT=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
>  CONFIG_SPI_FLASH_WINBOND=y
>  CONFIG_NVME_PCI=y
>  CONFIG_PCIE_DW_SPACEMIT=y

LGTM

Reviewed-by: E Shattow <e@freeshell.de>
