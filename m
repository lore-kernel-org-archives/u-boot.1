Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A0C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F14A4409C6;
	Tue, 28 Jul 2026 11:18:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GZqHgFIqg2Rh; Tue, 28 Jul 2026 11:18:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3612409BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785237527;
	bh=whufBriut5SLLcmBls0LMxerDRephhktxgaFsldGATM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MnskyJU/HlhuHslJlIe966wQoqM+Qnn7VcfZLQYjkVPmT2yGoAdcAM1hpfNgB3SBA
	 1OrWdChIUe1przoAhtkyOIWZExUc7yD1d5e9cXfTzUNn4BLsHl2+O3IepElWPgFLnW
	 YDsbFufzOgCEeTH23mWUarfUhbuCDNB9KhZHaro3cw9AuXP3hprcyGJfHJm1HxiRUK
	 rsOBf4N0nfBkczi3Fvu6xw5RnPtlE5PDH1K7IFRW+EgVV8IQjH9DZ3dTU2k/0o3tjL
	 a4KA8cum4PXgNz2pBlRkF7Cwk9bgzJeeONDXRgMC29JqIwo0upUn81xN8Evjl6e7GR
	 QxsC4XDNKX/6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3612409BF;
	Tue, 28 Jul 2026 11:18:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F55742A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 615F481292
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:18:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id it1a9rdwZX6k for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:18:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 69AAA81290
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69AAA81290
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69AAA81290
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:18:44 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-699fbcd23ccso5624241a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237522; cv=none;
 d=google.com; s=arc-20260327;
 b=Cec4CX3D66wwUjBiN5THZPB75FQU7YxuU6Qap/pbgkwSzk6AqjY5FbpLEf9v233acf
 Cyy+cN7jHorew4LOT8nIByOQMi+pMxkIkamhEdCL4S7reYmjwyrhtAGJfr+V/aZYfJhK
 garg8DDaNyGnVXarH/mGdNJLM5NvTsNFClVmOvuF01bqn30yKmPVU5VLNWEegSreqc/H
 /Rd8b1KrJdjbUm141qAq7fJoSKonXM2F7Y4BNNpIISvyYEAdQYCMBjdvh6go71DdGcpV
 OAlFmLsuW7bn0vS1mcOJYavArK9+IqenC1Rfhtx566MV/VlTtQMeysptFKQXBwtdrpHh
 xZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=whufBriut5SLLcmBls0LMxerDRephhktxgaFsldGATM=;
 fh=wekN399OGv1FHkcn15hW2aKiJjC4Gnr7zohZCcjgImk=;
 b=RUL6DMNa22VE8mq4LXHgTqTgdfggw726mn9/28HdyhATtOaEpwWlBtuIu4NzQoPABw
 QTTFc3JYSQ0cUma0DRxOgLdzH/6SE0NoGyT3LH9JO4XWdjVNsJFoHQB1I0V4Q4A5h8X/
 ZAMe15VczRYXLHyhoB5aVFe7xBM8h9kg0TalpnLDZrGIs3Fs5tOgZOrBwB8XP0JKt+Kl
 OFkrVBwVlhrJ+nTDNIbhlB2TLvBekAvjjcoYGAouqjToqNxnRbVstzLjl2bXtZfgJP7G
 /FS01h7Pz25xBjrvH4f5GHDht+ApaSchLRPuFI0D69KGk8NFqcIwZeF67v5HNxYFTth3
 66rw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237522; x=1785842322;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=whufBriut5SLLcmBls0LMxerDRephhktxgaFsldGATM=;
 b=iQ9bIiOLuOXvcJ2cEB9Ch+4BeaokGvQ/ElJecaE3gYa0gK5nSzDbgd2THNdQ2fz6/S
 2S1APpT9r9z1h6MW1BJQDG6H6GOYfVvF2NkbLMqySbSIhaVUfLVuRzyDQZvdd8zvJxc3
 0NGha3kRi/2pNzrPHqq8aZObDv9HReXssmvZkC17KTshkS+Re95dZfK6R1pHjgxiaJom
 +NRJn70P2Jtl9Rh92vjp5RUaDdpcZo+hEPpBiynIO8V4A6X8Rppfc4CoWIFsOcLL2ME5
 lmqF6qsCOESnF/2eYmL9mQt1R0BU8PPHp5kKpqQB1URTX6Yc5sY7wrQDUhXpDjKZpEJQ
 RxGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSOwgFOdd32IyoVEkrrHfvETmrqOQDmObwRLL+r9vgUvcjPFZ9gUM411KZ5Su/HqG76n1MDnQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyZCTS0VlNWW7TQOicsXtI6maPTZoGI6hzwpcCF2ODsgiHesEkL
 zj7Cy4KRmQt4LV94UEkMBBN3Y0IuprHqedLnDs/2Bp6WacpQ3SYRXceamA1KbMxu1nJXXZQ+7vg
 v3PRbbBEUfewwpNIhIZDj+lp4fHXJ/TgzH3qbj8pB
X-Gm-Gg: AR+sD13EBud9IkTGQcLSTHVEeo9/7FI6gyt+JEkIUnQ9GuogQBQwFp0Pm7fHyAb5DaZ
 bA5XzlS6umV1L67Doq8VgiyB8eTIBNLX4m3bDrSgh8Baa2cS/cIQy0w4icxEDcK2tCiXc4llNyh
 9LR+67yTz4m122yWwhVEKidj4yzSZehIL+zXEnXJ0zBVNosqU4NMlqrkXN/7O+iupcpWCgEnN8v
 jTOSkYJHbMk6CO2hHPII9NZmBAZjMtokVZIyuqrB8gUoql1fdl9cuXe5TQYsIYUj9GePSg=
X-Received: by 2002:a05:6402:4499:b0:69c:4051:69e5 with SMTP id
 4fb4d7f45d1cf-6a034a51860mr974387a12.28.1785237522217; Tue, 28 Jul 2026
 04:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
 <20260721152110.283998-5-aristo.chen@canonical.com>
In-Reply-To: <20260721152110.283998-5-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:18:26 -0600
X-Gm-Features: AUfX_my_kGq6mZU5YPYlKNGnc2B19f-MwIQz-GRFHUOyvwK9XYSienD3tQ79izU
Message-ID: <CAFLszTj_iE3uf7azuc60uzFNEutQt35oD+R8WwF+C+UnNxFnYA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] arm: dts: k3: phycore: widen SPL overlay load
 address spacing
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Wadim Egorov <w.egorov@phytec.de>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Garrett Giordano <ggiordano@phytec.com>, 
 Suhaas Joshi <s-joshi@ti.com>, upstream@lists.phytec.de,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237522; x=1785842322;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=whufBriut5SLLcmBls0LMxerDRephhktxgaFsldGATM=;
 b=GWI8COFofkWAW4mvZ2epFLIYbMmQdCFdjNTdK9gnfRWykDCe/V4/9RBZFyjjhifs/t
 0BCaPxxBD+8I537QWV0TH2NTIHtuXacJRVIH4dtPBo7EIzH7gb/r7j4bZwpRCC/cmkOV
 X2i+VoZrGJm7LOp427TPNQ5i01dEq2a6B+oCY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=GWI8COFo
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

On 2026-07-21T15:21:05, Aristo Chen <aristo.chen@canonical.com> wrote:
> arm: dts: k3: phycore: widen SPL overlay load address spacing
>
> The phyCORE AM62x, AM62Ax and AM64x u-boot FIT images carry four
> devicetree overlays (som-no-rtc, som-no-spi, som-no-eth, som-qspi)
> that SPL loads simultaneously as loadables of the same configuration.
> Their load addresses are spaced only 4 KiB apart, but each packaged
> image is larger than that. Measured on a phycore_am62x build, every
> overlay is between 6035 and 6163 bytes including the prepended
> ti-secure certificate, and the raw dtbo that remains in memory after
> the certificate is stripped is still around 4.2 to 4.4 KiB.
>
> Loading the images back to back therefore overwrites the tail of the
> previously loaded overlay, so by the time the board code applies the
> overlays from the recorded /fit-images addresses the earlier ones are
> already corrupted.
>
> Space the overlay slots 16 KiB apart so each image has comfortable
> headroom. The addresses are only consumed through the /fit-images
> records that SPL writes while loading the images, so no other code
> needs to change. This also allows the upcoming mkimage load address
> overlap check to pass for these boards.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> Tested-by: Wadim Egorov <w.egorov@phytec.de>
>
> arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 6 +++---
>  arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 6 +++---
>  arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
