Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E68C88E73
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 19:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E6DB40508;
	Mon, 14 Sep 2026 19:59:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LmwssFCyO6mK; Mon, 14 Sep 2026 19:59:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E8A7640509
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789415941;
	b=sb6fK9G79AbwzasLLAFHSrLezMg/Fa4F0fQnUUCBLvPOqzQrJ6gmNg/dmYjBj7mObpCh
	 AktVggSaac1z1T4cuctpZ4/E88aDMmHtFelH37iOPh2MqaQ6Sn+ZBJhRAY34eLP2O35zM
	 8jhrCO3GnrvM9sZ5uMqogHqhQeabrLywlzp4UB27q1th4QLdvAbWkro6lobxxRmlR0jEr
	 W2TnJMRC1c9RwqySjzzv/O7YywixGEapGYKceoYFTvjhZ8Sw1U7eIogvhSsZs1hohki7z
	 RqwnR0qsGPjfiJqseyrPmFJYvQAhk+zperVKCVDDb2D/RRR3ogwQAilJb+nobKdSzOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789415941;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1rFEfLLtA/XKmR35Jbk1JQGvPZVJOI0G+K2m0GsKEFM=;
	b=ir/H3P4jdL7TqKDIoYFwIpZyqC2GRbAYZZ5Vs/5k58Igncn+3yvX2fTdHJ0sS+FUx6SV
	 bHZ3LxdKQSNoaK0qZ2uKtWL6AGX4ghlr++jZApquIhRTNVo5+f7Ay4dW6ZXUtVJIlRpGF
	 5+a3ICuWxyPIMh8Dm4r9M3exmvkA1tTAfoJ55qtY77i+JUvoSGAiBn/dsNjCneP6cZGDL
	 yAnV7US33QS2Mwu/eEP3+vFXF/tsQ89Tj+BCsYJTx8/C8J7ACSn95FCreRyvQSeRzJFHl
	 Qg43YvZHWZ+k6nx1hRZoKSDbiwgtXU3V3zBC1Xp//W3OByG5Se9kCF4DJPzXXRFcYkg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789415941;
	bh=1rFEfLLtA/XKmR35Jbk1JQGvPZVJOI0G+K2m0GsKEFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BDL+ZzbMYf8XyOV48X2cScH7ImRP1zdQbENJ3SewXCD8Jl+sjsmKj2V5VFcSEBvXV
	 TL+T6ZPabt2bdPt4TAy9PqrbUo1vzmagJcuAgfA9F0iskJhdGj83VFBKm5EbLYIXQ6
	 FMtuaSBALareB+mpHMuT5ykglUVOneqgHmCbwcHD3L24/POSp9459RpotSBcx2YIVK
	 0hu66O3Yb4Vgl2zrAgg/lDc46BQm2F7Sy4wku3a4FA/kbItYMOTi3oxLddwkXUXji9
	 yBKMCRGCdLtUGP2ftQXEdvg8yhG0Maod64QVltWhTDTzUtj+VlweMP1uexbvfRsZR9
	 mY4BIjJJ53P3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8A7640509;
	Mon, 14 Sep 2026 19:59:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E76E224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 19:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 14434605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 19:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dg1EtizZe3MS for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 19:58:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4FDA2605E9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789415939;
 b=cJneRYJNGbT+ZiFPuXbG7Q/blagIKCkgPFM7l/zdZtTrj5zYwc8hcaJrRciyk8si/1Fa
 0Y00wM3OE/UxAXcQKe/qeE9GxKk0FpEdke/IxpDp26CFVFuowbv0cMhGei94wsBPNNMvP
 JnsJQ8/1ILcV1aLGs5Qa10hhQ6OuOQJ9jdQqHrhxRl4rno0jY061o5oBtqLXOiaadxd7F
 ZDDaVMqDqUbW1xsXGJh9aHMGU6ET17fsSTRi9seK2A9WC7Z7vGSXRZBpUccA1pX+g0ha+
 qaNt3uiphgd9VOJSBeNGXOF+3E6hdqhIFtQBYhq8Wyb5Gr9ee/3sOoj3o4+Ut2r1H+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789415939;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=1rFEfLLtA/XKmR35Jbk1JQGvPZVJOI0G+K2m0GsKEFM=;
 b=OHfF9hD65fxTtyCtWaJLAibF8+bsPuEU9ERVjYfOwBCfNiXj0Fw+TZjZEULfAnPiwahy
 gdoKyFfdDjn9Cf0ePQ9/vsVme+lHqS3QlYJFeidK4Tb//9oaiPdULHG9ojUWuwlpkhPEN
 cmbCAM3wJnWVQnO9k/UfOQRkjmdOym7Na+8LtiLqX9S2fHvtSRdS5+mjOIYQ5CNdE/+Bt
 39V6pqaN1+CcVvgpUWdOfOgIZizCcXVywHVuT3CPM3WoS4URvh8EllVhxm46QjoN30p+q
 /jI0yMcG1OcKNx+lO3PW3oO2SNV3SPgy5Q+gwjJyXVjJOP8aEktqVBwqB9ZlHeUMqgQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Dl7tOVuO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Dl7tOVuO
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FDA2605E9
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 19:58:58 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4a46a53abc9so3149386b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789415938; x=1790020738;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1rFEfLLtA/XKmR35Jbk1JQGvPZVJOI0G+K2m0GsKEFM=;
 b=Dl7tOVuOOB65aovi/e79IWtfQ4RhSqg8ICpN9Dp+6bMqtjegxS9BSb/gwfCUIKzr20
 lTKsJy8OE/et/sWMD9lgDl5sG+1bUSalYjLHAUGY9dOBUDOci2tdcngKU9GHmhI0zttW
 wstmBRgYuH8Ko0WCJwzxr9zu/zLZpuJ8yLA8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789415938; x=1790020738;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1rFEfLLtA/XKmR35Jbk1JQGvPZVJOI0G+K2m0GsKEFM=;
 b=RAri+lB/hhV7zfqr5c2gWGscKtVK0ouZpZm/MqQLppB6QksgNAQ1mnPLUYcEVWh6Oj
 kaL4a2B5MrThhI64c897F7iP6tCaVJsxuCocJlTkYUoWi5gRtlypfRwnzftiINl0cpnH
 7sten3opleVkWAuxMzuyNrQ0JKt75ZngJU40pn67QpbSPn4Vf87SmOThPZI/o2I/hzrf
 Uc7a5TnxD5jzLDQenIGilaiej9hv8nXy1vKes/jGDw3r43yTvsMXZB6edY8gV1FjMLDk
 mZZwZQm8+pZ+0HabGhkdLUdwpPqBO0n4NYOPEFrOzZhIzVSZ7E1bDlAvQXTPAQLe326k
 R/rQ==
X-Gm-Message-State: AFuF++nScq2UC8Ny3saRZwai9V8jiQ9F3TfdEaPmNcyeVPXFzBRcK18e
 O8llK5CN2ONQsIAdIr9HyVYPO2TXxly2Zx+PfYoyXxNddKpXkFVvJsnYtW/lf0MIyzg=
X-Gm-Gg: AYBFou26gQJsEoJr6B6OaX3afz+oKOR02+Qqm+VEVmgg0l/dJ9lduR118zo2bEypus7
 QGYNZpXnGN0R2ci+dSVMczh4cQrDXurxvnFraCX4//9psmSJMHtqOCtlZ94Nt6dGwxwWHUbHGbK
 fl4zCdkxxXi76owDdEqT47R+RHjAQah1k/Er5qsP20JPZYxEa6KnsRFX76YUHxWYRkS7JYUpRA0
 m3EI1y2d7sXBw2UDuzOS0PQ0M/O4O5j1KBE4ECE9niQRvD8LmJ/s9yLjgcadCQU8SBocTGjPLFf
 kQ6k7Nv8PLTUXfpffDOzRhmQHlJnHY7Qtus7nN2D3choGgbLunt3GeURUEr+28Qac0YcYdmK+Pm
 aUfal9Vufmf8nTB2MIaqxucH4tzz9vaCUJXoFrZllqDB0UPA2PUXjhh9Gzbz1jgZO+CWGkq8x1l
 /mBZyjDEKU7ngvFMWIlCXbh94RkRiMeJXm/X41E/pJuWRDD9N7ZX6EmVa67urXHRLGGnUD2Ntmx
 NUhPGm6jWvgu4p2JcxxIpHJe06JraG5/+OU210BP/OGUMe/PeC/NBiuRLz5NGoshh8kGYIYpjpA
 qHwQpVboPiTXYgpxA6T1
X-Received: by 2002:a05:6808:2203:b0:4b3:80c6:4bd4 with SMTP id
 5614622812f47-4c7b42c9aa4mr2414116b6e.5.1789415937922; 
 Mon, 14 Sep 2026 12:58:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4dac87084sm8168415b6e.4.2026.09.14.12.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 12:58:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Alexey Romanov <avromanov@salutedevices.com>
In-Reply-To: <cover.1787673209.git.daniel@makrotopia.org>
References: <cover.1787673209.git.daniel@makrotopia.org>
Subject: Re: [PATCH v2 00/11] imagemap: on-demand FIT loading from storage
Message-Id: <178941593647.622999.2102604633194206607.b4-ty@konsulko.com>
Date: Mon, 14 Sep 2026 13:58:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 25 Aug 2026 16:57:57 +0100, Daniel Golle wrote:

> This series adds "imagemap", a small layer for reading FIT images directly
> from storage on demand instead of copying the whole image into RAM first.
> It keeps a translation table of the byte ranges already loaded, so a
> header probe, signature verification and the final load can reuse a single
> read, and it hooks transparently into fit_image_load() so all existing
> verification and decompression paths run unchanged for both RAM- and
> storage-backed images.
> 
> [...]

Applied to u-boot/next, thanks!

[01/11] mtd: bind an mtd_blk device for non-NAND MTD masters
        commit: e8a7453824b7ec20c722b0268de417058e49a9e0
[02/11] mtd: nand: sandbox: forbid sub-page writes
        commit: 7c821fea086014d3a78130a853e017a269d63e1e
[03/11] cmd: ubi: create a ubi_blk device when attaching UBI
        commit: dec405d1653a9e6b8bfc9a0f9aaf66ac3de7cb99
[04/11] mtd: nand: spi: drop the eager ubi_blk binding
        commit: 790c94a5c40a1b2c8cbcb87bc49c7fe0af5cbf2e
[05/11] mtd: ubi: block: build only with CONFIG_CMD_UBI
        commit: 15358294f11268e7998271df6e03127650178aa4
[06/11] mtd: ubi: block: only claim UBI block devices in the partition scan
        commit: d6bcfe912757ffc53403578700919a7a427ef94d
[07/11] boot: add imagemap on-demand loading from storage
        commit: 9b41c7dbee964fd6ea67c8ef23d30346c1f0f8a8
[08/11] boot: fit: support on-demand loading in fit_image_load()
        commit: 46d32e38ee4ef49567255aa9a89a7be44c0f0e04
[09/11] configs: sandbox: enable imagemap and its storage backends
        commit: feeef0a69f0f69252e8d06d906b80aaafe0c2cd2
[10/11] test: boot: add imagemap unit tests
        commit: 05c1fbbfa79ffe020b51b5d9ac9fd46ca3eb3e74
[11/11] doc: imagemap: document on-demand loading framework
        commit: 0f59e0702ae90dab8561e4ff2b32e89ef8390f28
-- 
Tom


