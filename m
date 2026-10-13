Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2129ECA9EDE
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 03:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8206405D6;
	Tue, 13 Oct 2026 03:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id chsr-GrUTDwV; Tue, 13 Oct 2026 03:40:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD996404EB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862840;
	b=e8Fm+KfEDeaeUNTORExqaWVSFlCwrNA4Usd/TNCe+fIn5DOGFfeM41DQgtXS/rQ38VNa
	 Va5FGe3gcyiUgWcJ1XFOR9xl35tnFJqXuVt+nAmajves3tN3D5bwXB3RsbdlR7zaUBcoG
	 GqFb10JaBJQ8kGy3MuqiC/qhcxTgG7GWrVCT8bvKSjO3VwVNuPOTZ3jivkgVVjYUjkT7N
	 2NKwBNmvREPDXZdCOnm+ZD6jy6lTZItX38ezCsrGxI2KWbilYhKy/rTRgjfLtBD0bir0I
	 7krZkWzp1YgUXiyyNLHbCcgOLCnn9amCYXk0SzmMjwXcbZ34PhwTD4XowotBUQXZCug==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791862840;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=in27oB3d5UJvltUOKgDsrN+jlLzrR+XEkBFz9e4ByOo=;
	b=iEbK0/f6OZ4qOKN987zhfoscxXK6DbzyxSY5iQsIClwVcMvmhEWSWU7U71vImPlnAo0+
	 IT4Xz49/KNV/ZB29sd826+nIP798lwlsN6zUo1Ux4/m5OIldufmd15oxi9BiUdGBb8+ze
	 sALH4hpNGGXAY2/zvqoccmniQgvOP1SGnXUJhRfA26P0uw6BmvTPp341Wusx2R6o59FFJ
	 E6B++s/voHENuGmu57b5pxB8dgRdtb2c/3ice5k6+Ds2BtJFGsivvLykA1BgqTMhbyXCW
	 UW6qhM+oFdZJ/dU6iT89GHpkcN8xAZE0hmXl+Q9qIs1QAfC848buVARvTGOrCzXrBLg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Yymy1XdR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791862840;
	bh=in27oB3d5UJvltUOKgDsrN+jlLzrR+XEkBFz9e4ByOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EK8O42Qde7gBacU6cWtb1Q5rTbt85on3aC9OH2EPH2PXk6teYu6AbvpkIk2vBdmp5
	 vwSmwzq0dGcYFG5zKAPCiB8dm7T4X0CPYMdslotiK309Re6KD3uOeoAhjPGLQ/xil9
	 wEI2upnmmR31UZnyNHd2bH15/17m0UoSXQ8x++8Rmh5XOr9WXQ1SOwMOg+eE1j0/H+
	 0cXfn2M4EPgTBVn/TH3pVLCj1yAv4NrFCXKcSKf+lQbi9IHXj/TDYEkaFJ3LbG4J4n
	 u4OC6IANDhKdJpidM2J9VRT1I7r9EW+dyIY5GpOifm/80sX2l+xQyBeTjY1QKcI0wz
	 0xPEWo9aBEW1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD996404EB;
	Tue, 13 Oct 2026 03:40:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BCAE1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7DD55405AE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:40:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eaiHpWDPDNo7 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 03:40:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A573404EB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862838;
 b=NI/8VorpJPLr4CoOpvenDaqF3cegSLgYpNe8Vw51cQy+/pUgVKdkgI95wznBkJarX16t
 hc4RRVUHMkR8VB/+y1ve4csSTtHYiuUBhO2wGd1I6lSCjsx8q5/bcrYbyhGNJ+5Gk2B3m
 SbbhL/fk5wNGQhvmbam3+/YvCVJAkAlyR/kVLBcjA9AC1QENcaFTnQt5qsuaArCTvkAGn
 NpKvhU1Ycz94AHpxZ1r69FQZn6Qz7lCUnp7C815Uk3nGa2rFozV/EiTzepkOsWCHyHrBQ
 qXt5lC8cvCDsxKmD9mYggcgu745G8DYrZk0EdwLPa8QKforq+Unm3IA6GOMNXhvQLZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791862838;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=in27oB3d5UJvltUOKgDsrN+jlLzrR+XEkBFz9e4ByOo=;
 b=DgfFK5TA41MX2eIBo0kh5+M0L2K5VW7fOsyDNMpuU+at6pAgn9dVUkY3z+HqW29PVjVJ
 5FNRPsnwx+ni91yHMnhyjIVXdfZYQaoaHqIbrOjcVVaHB06rsbQEOITHl8JwAA8BPvi3S
 zyK8TOiCU7xHfBCxY1by12DjTkXADQSME8A2BUmB5B4LEouPWTh0Zh3xZKn+2c2D2Vu+K
 bt7Rp3xLj3pCa6nw/s05erAYVt6/DVKkRhltAfSmdPRPKd/Y/jU4VYH1HNisfjo+Ur9bz
 trxukSFnBFniiVUGMdTeJRPi/gYHDzR9ZqX4Rmn58WG6Dl5fdUiGHahpEyI0INkHLsQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Yymy1XdR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Yymy1XdR
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A573404EB
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:40:37 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so3591873a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862836; cv=none;
 d=google.com; s=arc-20260327;
 b=XwhAiTlepWgR4HkHAc6FX9pKrgavjx5XmkIgp0qcwP55AzZkE9OsxR9NEII/37HG2L
 kw07bgAF8ySroewxHDWBby6QiNz7urUzCEeAIOHnmGC2yyYcJ6nNL2GoFlFs+uqvcQ8S
 evxPh8ntdM1RpLpQ0bhSqDhqVcznHx6nU+nzdBGZ5yxzW5Jbh+PvvRA7p7bNOsaX1vo0
 iwdRQTIun1RQw467dP9+a0GheUo7Ht6RTJTNP4QhNzUGnavVck7AxEWq/FVX7GXYIfE3
 jSAArWcNW/hjEOsgNmKezlzhYSR+tDUqdNE3wXol9uscWs2abpCUvmsmDHGxEGjywLqv
 p37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=in27oB3d5UJvltUOKgDsrN+jlLzrR+XEkBFz9e4ByOo=;
 fh=HDV0X3+TLUhxiHPlpo9yZmUM2Mli5qxXxr/NwF8FI6c=;
 b=hevTrgGqzJlF1Y1dWSvSLoZ8t7IsQdOR2O1VEfoG0Jwey8joB26wtsW/M6DrIprYPU
 dxcR/lToFhbCdHC5LAeIjMXvDLcinAgTHJR4T6KomK5TGr4ANY3EkqvrQG+UnJteeZXp
 ZD/hLrgyDhoarqDTPiOpJZDsQEFuX+HmRpsa8gP7aFoufvKZ0Tk8ilIC3TAFV4yBUkE+
 ORT9puu7zfmsOa+BbP/p8C8PAaIvmHTyp9A950phxMH8RlGnffQ6NQMs2C9eFHf3sl3b
 ine9+Bcs6n5emnqK1Ybtl06zr0d2O9anDlY8i1H/ThhQsrnNFFbI85Y1C15WuV2PVM27
 K2GQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791862836; x=1792467636;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=in27oB3d5UJvltUOKgDsrN+jlLzrR+XEkBFz9e4ByOo=;
 b=Yymy1XdR/5biIE5ga9E8eX/TnV0MRxzYMWKv7f79k1l+K18wIgU9dU7J1HxrNcqLE1
 UQuPSbc+CnWhBXNvl2K9Py6IdWxdEpvBHzQV6PhMlJrtLx5TykFqP7tJc2xwfqX8DIL2
 9+ercTTDgLtHMLUQOxJUxmOs3b87ueXnXhU9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862836; x=1792467636;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=in27oB3d5UJvltUOKgDsrN+jlLzrR+XEkBFz9e4ByOo=;
 b=GGYcfVGQWG9T02EtUpkHaz8nZCeDq7TUWl9rD2RFpV1EusbHBlVy3FKDqQzsx8j4kw
 iFMMPoDoqOhy8Q+iMS0JDp+6fN0NI5Im9Qux4AeQpiyA5z8kg9GCOsTH2NLvqf2GUJkB
 y5Vhq42+lO8Lv65YQHFBruDPggBGPDZyAZyNPyNbBB63VHoIK95kM2x4sbMfcZ+a8BoQ
 bO9b9dDUcRSZUAjEqezdwUrg3MHlRUVpj1NzabuukR6yrR+oGi21dQ1KReBUA8gykFll
 8TcvGpXzoImtiDGmp9bCee06x8ueknOWwrymIVTIXkGhoC9J+TbaLBYqpEarzBhlxSaj
 W64A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPEkoKgrfMGS3PQV9Dge2lX/C8cInKdOuT3WAqPgN8uFad8J9kmwjOZid/zKt5aZ8RDo9tiTs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKEp7GykvgygmZ8U+wsaIf4yXWF9ae0YUnT3M/MBN+T575eCpl3
 KgHtugBa2PuQ/AcKrBf3M2MD/RmmPSFBrVOWkLVJXSzFnvBnGRXSVCC3EogWvBI6mX/Xub4Hqg3
 WgewwCc936m+QBQnqcvYHT71z8P2VXalPIea0bS+m
X-Gm-Gg: AYBFou0oXRifMSOEjT9AFgSoANpebEsYJb9ocU6bow80y5P2lBNZqlzOGmK73HKO57x
 mA4Olba2h6nJ+7oO6unx0oQZ0WPW6qh4TKtPXmqgkt+V1J9ADqoNlWLHe7BG661GvK/92Y/mQYS
 TxB4T+t22mZtci2m734llkGo60DuNx3oOo0agaZcv0onHrKjDLrfd4bGZU4pz20guau4vyTMoaK
 fTSuVle/6ntzwfj+g512YhlSLHgvKTXaobGGGLBia3yEcmR+gvqM007KPWPJqAH79TdgqjpiTW5
 cFLn5vQQZYJAd0RkxCglvPOYCrmhAvMAuG1RRgoe8qTTsXAn2f5b3NKO+A==
X-Received: by 2002:a05:6402:1f44:b0:6a9:93c7:ca57 with SMTP id
 4fb4d7f45d1cf-6b17c29942emr9911164a12.22.1791862835606; Mon, 12 Oct 2026
 20:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-4-hs@nabladev.com>
 <CAFLszThGYtvGYmYi1iOjRiqBANzbNSOt00n1HHzOWX8GXw3P0A@mail.gmail.com>
 <e66df57a82424e6d9b1fe8e2e5b7041f@infineon.com>
 <d19b3b84-86fe-4f46-a9f3-95bb18b20d13@nabladev.com>
In-Reply-To: <d19b3b84-86fe-4f46-a9f3-95bb18b20d13@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 04:40:23 +0100
X-Gm-Features: AclHuK-nLMm6cDlzCc7b_qAEu0FYDo11eQXFCDaKDL1FM1z_GmmhB31QdYPI-ps
Message-ID: <CAFLszTjDUUaJMO9L-6oK5LnGxQv2=rGuf7nvh4ya6sieW=rfPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
To: Heiko Schocher <hs@nabladev.com>
Cc: Takahiro.Kuwano@infineon.com, u-boot@lists.u-boot-project.org, 
 marek.vasut+renesas@mailbox.org, vigneshr@ti.com, jbx6244@gmail.com, 
 stefan.bigler@securiton.ch, quentin.schulz@cherry.de, trini@konsulko.com, 
 vjardin@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

HI Heiko,

On Fri, 9 Oct 2026 at 10:29, Heiko Schocher <hs@nabladev.com> wrote:
>
> Hello Takahiro.Kuwano,
>
> just answer here, before I looked into the comments from Simon...
>
> On 09.10.26 10:29, Takahiro.Kuwano@infineon.com wrote:
> > Hi Heiko and Simon,
> >
> >> Hi Heiko,
> >>
> >> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
> >>> mtd: add driver for the Microchip 23LCV1024 SPI SRAM
> >>>
> >>> The 23LCV1024 is a 1 Mbit serial SRAM with battery backup, sitting on
> >>> an SPI bus and used as non volatile scratch storage. Register it as a=
n
> >>> MTD device of type MTD_RAM, so the mtd command reaches it.
> >>>
> >>> The device powers up in byte operation, where every command carries
> >>> exactly one data byte. Select sequential operation once during probe,
> >>
> >> Just to check, is this right? My understanding is that the
> >> 23LC1024/23LCV1024 data sheet gives sequential mode (01) as the MODE
> >> register default; byte mode is the default only on the older 23K256.
> >> The Linux mchp23k256 driver never writes the MODE register. Setting it
> >> explicitly is still a fine defensive step, since something else could
> >> have changed the mode and the part keeps it while on battery. Please
> >> can you reword the commit message and the comment in spi_ram_probe()
> >> to match?
> >>
> >>> so that a read or a write of any length is served by a single command
> >>> and the bus is claimed once per transfer.
> >>>
> >>> Writing needs no erase. The driver therefore implements no erase
> >>> operation and says MTD_NO_ERASE in the MTD flags.
> >>>
> >>> Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
> >>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> >>>
> >>> MAINTAINERS               |   5 ++
> >>>   configs/sandbox_defconfig |   1 +
> >>>   drivers/mtd/Kconfig       |  14 +++
> >>>   drivers/mtd/Makefile      |   1 +
> >>>   drivers/mtd/spi_ram.c     | 222 +++++++++++++++++++++++++++++++++++=
+++++++++++
> >>>   5 files changed, 243 insertions(+)
> >>
> >>> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> >>> @@ -194,6 +194,20 @@ config ALTERA_QSPI
> >>> +config SPI_RAM
> >>> +     bool "Microchip 23LCV1024 SPI SRAM"
> >>> +     depends on DM_SPI && DM_MTD
> >>
> >> SPI_RAM, spi_ram.c and the spi_ram driver name are very generic for a
> >> driver that handles one Microchip part. Linux already supports this
> >> chip in drivers/mtd/devices/mchp23k256.c (CONFIG_MTD_MCHP23K256), and
> >> the binding in dts/upstream/Bindings/mtd/microchip,mchp23k256.yaml
> >> lists both microchip,mchp23k256 and microchip,mchp23lcv1024. How about
> >> using the Linux names, here and in MAINTAINERS?
> >>
> >
> > I would rather have a generic SPI-RAM driver that also supports MRAM [1=
]
> > and FRAM devices using the common opcode set without erase.
> >
> > Currently, some FRAM chips are handled by SPI-NOR, but new devices shou=
ld
> > be added to the SPI-RAM driver if it exists.
> >
> > What are your thoughts on this?
>
> Seems like a valid argument to me. Simon? What do you think?

Seems reasonable to me, but I have not dug into how these chips actually wo=
rk.

Regards,
Simon

>
> Thanks!
>
> bye,
> Heiko
> >
> > Thanks,
> > Takahiro
> >
> >>> diff --git a/drivers/mtd/spi_ram.c b/drivers/mtd/spi_ram.c
> >>> @@ -0,0 +1,222 @@
> >>> +static int spi_ram_xfer(struct spi_slave *spi, const u8 *cmd, size_t=
 cmd_len,
> >>> +                     const void *data_out, void *data_in, size_t dat=
a_len)
> >>> +{
> >>> +     unsigned long flags =3D SPI_XFER_BEGIN;
> >>> +     int ret;
> >>> +
> >>> +     if (!data_len)
> >>> +             flags |=3D SPI_XFER_END;
> >>
> >> This duplicates spi_write_then_read() in drivers/spi/spi-uclass.c,
> >> which has the same flag handling and debug messages. You could drop
> >> this function and use that one instead?
> >>
> >>> diff --git a/drivers/mtd/spi_ram.c b/drivers/mtd/spi_ram.c
> >>> @@ -0,0 +1,222 @@
> >>> +     ret =3D spi_claim_bus(spi);
> >>> +     if (ret) {
> >>> +             dev_dbg(dev, "failed to claim SPI bus: %d\n", ret);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     ret =3D spi_ram_xfer(spi, cmd, sizeof(cmd), data_out, data_in, =
len);
> >>
> >> A read or write of the whole 128KB goes out as a single spi_xfer().
> >> This fails on controllers that only implement spi-mem ops or that
> >> limit the transfer size, where the SPI NAND driver you are modelling
> >> this on would work. Using spi_mem_exec_op() with
> >> spi_mem_adjust_op_size() in a loop would cover both cases. I'm not
> >> sure how much that matters for your boards, so I'm just mentioning it.
> >>
> >> In any case:
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>
> >> Regards,
> >> Simon
> >
> > [1] https://lore.kernel.org/u-boot/20261008-everspin_mr24h40_mram_suppo=
rt-v1-0-d8f14da1a997@gmail.com/
> >
>
> --
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic
