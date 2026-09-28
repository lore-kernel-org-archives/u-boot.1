Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE39CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81586808D2;
	Mon, 28 Sep 2026 15:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w_whu1O6dBWn; Mon, 28 Sep 2026 15:13:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BB31680DE4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608413;
	b=Lkc05+NlfjfNw0hyABfjC6l2XmErTukDLsDuUAt4ZACapM8c9usdeV4tWL5uPF1cFpUZ
	 H3B/wSUw/pyNhZyUIvMoBk0Sb3lI6hMo/rqn2bmBOGdSse9vXDpMf3okkT34hp1Rgw4gt
	 bNe/BjA3OjKiLHXjzA2o4zngk8A3KIXU1EN23aV2ohkXwd+2A7/QBe1A4eIgrfUMZoOiD
	 VS6CDpA2KE9xCZwJ89bg8WMakRw8p9i78XyMTnKg9+SjIY9XEx9bpza83PlPtQqgsibHQ
	 nKiOgp3yF2nQnE7xOmCqyJqnFT0kkXtDpafkNRCxWVgIBxq4bJwvJsWd3P70R9fkWog==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rleEWxCeX1cDDlgwnx/ylsZpA/dPZ912sPtrOB0aRmM=;
	b=CWqCt/svOWSIY8jFDRRN79A3H+rAJ2lalV5GQWEMm+6WHtTu8TUeabKDlxOcNbbjUvAN
	 e3hecFyUqZ2eKMLmQ72vd25HmVyDPIvCoVxxLu8NMPPxlfCfz+l6vq9Kcu/lj4mOtIcbV
	 ccZVzffF8DMxFzqHZv0rGGG3E6UcYX/qzNqZcaXjlXyIUJ7iYiZKOH/WzwrMrQYo8JAmG
	 AH8r1y5SqQE4jBiVWrsHpHDvI+1dw9SxICR/kmVU21sZVfgU8o5pGR9O68QL744HOrWz4
	 akok7CXEgjMoYHGK+IF+3XwnU3obWc+9n2EtFZoz28FYMTbWL2blsLfjiGC1kKLgHqg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608413;
	bh=rleEWxCeX1cDDlgwnx/ylsZpA/dPZ912sPtrOB0aRmM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xTOuGb+HX3/rNdBZHatr4+tLUghH0Zskqo6hbA3nZKEqhUyqYAuy3dfB3xNKM1/v5
	 ViyOGPUVK6VZgDoVchmHQjHBKTi41lPz2R1m9v8ubGsaLe41QwGxyZ2rmz2EtDA347
	 mgcojevDXJNTKI+oOtcznS8ufgU+6a9n3zGc26JHbxJHnINwCqnZycJCu8EUDOfDqS
	 Vz6TYY2l05VqAFEJ4+EVhNmO//IJGiEiiF+InO+aoXWWC+VNl21LDFNbb5/Evl3QZe
	 FC3ICJ1rqnkaBY8q22TLS/bYdPKGyT8pzBxcj6pCwk3smDGIQ0LUTaTbHwDacMYnMq
	 AmwiP8ex7GCcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB31680DE4;
	Mon, 28 Sep 2026 15:13:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90F783D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E7B0606C2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KxE-PrN_c7Pa for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:13:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D2541606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608410;
 b=hikU1lsIAJGfIi751KKm9ZktdsSiFBpx2iG0qg7q2YXVovhFVEFgc3Zzdtu06dQz2Rlr
 Y3+WsDpN0hP9cHa6X18dRxTluKgHPzkle5YetardiDZMkYV9mqBbDv5GlwC0FyBE0ZeR9
 awaWdnsJcJrRYE6il43tBIZI3NeblZVNg6IUNzrBroelE9JKQcbvh8oUFxXv4F/82937S
 eDrV2CTlF/kWiQWAnMO2kiv6NL0R+O+l3UcZ9ngwUT1cXOZABGTig+BlWNbRSD6Bv54a/
 t8mh1Nj4BkwCbbuP/JUJar+5lcJ3G1ujUeSfyE6CGUCIOX5o7HIeFrc2i+uOsZjEGrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608410;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=rleEWxCeX1cDDlgwnx/ylsZpA/dPZ912sPtrOB0aRmM=;
 b=TL/qqtooEh9ULYByFeecao1NbXr4MCizV/swHXbAl7aYJNJMk6CX16GlHi1hsIroGw+S
 9eHnyK4mYBhE5VDsUPKwKpSkFzSPgfxOiCKMeX7eKTEDX0m6yg1u+8YKSc9K9NLjMXX2s
 3/zGzJCJRdcpJAFIGvV65TwrZav/mjFurA5aYfSTgz70iKJPyk98yrYpPj9bU7z7RVfgU
 eCj/MqyBgDilhbEw86NkuE0zbnceGBY4vtUKUeGjtdmAtyJwHTTLJN/DAclaGF+5VsN9S
 nuOXFL8PrRWUGQ33cnk3wr7etoocxFD1opvLvcDg7PacP3DTtoAqm2ILV1C2KTeuGNw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=VL5xsjFQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:3b::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=VL5xsjFQ
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com
 [IPv6:2607:f8b0:4864:3b::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2541606B0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:13:30 +0000 (UTC)
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4d2fe2056so1133826a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608410; cv=none;
 d=google.com; s=arc-20260327;
 b=Vwb3rjsNjRws4suQ+h7jPldJbq+ga54eotuBIwDBIzyEGsT64LDlCf2Jh9+Y6TbFw0
 HNZJYliKpk/fm/ytPtXTDmBwgUGfACWlaiYuKjwjVZp2t43dnjcFWrhLm03ixFgYxKW4
 259cQZALaBmGYkBTJRIm1rJimkHiIi370R+Tw2CCa+Oi/DdM/GPJ36lOpYI79jawVNZq
 G06LZrygL4RD3cucaI9vHLEYjfsPVrtkz5ksW0M51V4XzWYkmy34/mgguBJeYWn4GyCd
 AqaD3zqoyr/DrklB/9ezFP3KzMlG6GgjhrCte1wUZNt7KLQbYiLwxJVrRBwrJBq13aMZ
 dmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rleEWxCeX1cDDlgwnx/ylsZpA/dPZ912sPtrOB0aRmM=;
 fh=uzT2pV4KT5GRKL5CD21aemEO8VrSKHAwPj81xmFbn+s=;
 b=WNjJfVz+O9Y0bb9SoYwqtAHMCb2/Iqa2N4DLhK9jYm2xvZZHpwEFQ2PLLjYqcPpMVR
 pbWgjdt7zG0ptYVF5edVI1Og3FhhrBZFy6pELVP8HSNbFCZ5XoybSVNhr9jQehQ4hjrD
 +VDZc7qQ1CxJiOIQnyJK4sC78+DaRDZq6sQ920Ztp1t3bpx+HI3a/m3zqTw+qV8S50PP
 2mXg3f3Tt1COLnumoX4oLJzYweCM+v8yRp2wn3XlmTvjj3YiwD1e/S/O6pKgqxEkHiIT
 tlOYTOjQh6BGMRRJs8+9AKRzNNqFRbDfdUiCo7kodlV3z0agvhe0hey4kvK0ZJbnqP1z
 xtqA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608410; x=1791213210;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rleEWxCeX1cDDlgwnx/ylsZpA/dPZ912sPtrOB0aRmM=;
 b=VL5xsjFQS7sa2zBh3L3PDlhC5Z33o9YdMsb1Hr5mQ/xGniwRsV5532LZFcoAHJhSzf
 oGro/hyGCjYFtI814pUfPOJyLH9RUW4RE/mHiMxMVbyvqY/nckKXBSlL+DqgQ/2XLB1K
 7Bv+NUAAEUefqljUDQMygXajRpttLMXEyXGv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608410; x=1791213210;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rleEWxCeX1cDDlgwnx/ylsZpA/dPZ912sPtrOB0aRmM=;
 b=RQMxpDpldCyIlYESSKbmxVd3g1KzWPkmrdTueWv5mBH3tJiUrP2tOHhNGKREbZyUQw
 2ls/3yku8V+cgAdUZDnk2AVaHg4c6PZuOB/YTSBLt2Hg3ECy4BpJdBqONFUDEjUYik+9
 ted+EkD9mdPlpvz1elmK9M0McEui9rmq2nVXZyG8xOk3cIkFUZ61x+dhq2ZRBhK8B8pc
 PYLJwDYW9SfGW/Lvrhr3cexs7jMTgdGVAo2vpJsQ0sGXKJULHmIH8JxnmyvZdLsloZMg
 mT4TrRrOceBafScdI67b2gUs3gYakkwiStagj1J6E5dvjwtxe+4mQ0RyxJpOm3yO0knd
 me3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXbozhkIPDaF1rEhBHYJGR+3KYoR98FYzy0QcFZ0sDT/XN2xTzS2FAOIxKrCUhv5a6UIcdt28=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lInnpBzoMLpfyxIb+R58RcBTwJTqP/uilJ58W/j1aYrVMTH0bX
 ETDMwCwfakS7tsJwX5dOVHMlQCK4RdJ8Cebl1h6NNdiPtYofxCevYlFyXXaLCQjNAJMmV1s9AQC
 t+MJOWkHPlfAk+K6xgkR7+/bVZruwjbiVCSGQF7LJ
X-Gm-Gg: AYBFou1RLc7ltgQvZ0A/MFiBKVfocqyTNB4CAsLOzIYnMwDDGcj5zeuOaAaMTzmh2Xt
 q5GC5pWIpyKSqwD7UNWYQlCmLllTxFZeB+r4YJy4Y9IUxArndIT/1JpgkHW8LlIGveUipZ5KWDn
 SFm2aj8NfmWYONSN3+H/9yJNK8u6sk0uKzRjjLzy7nLah+SF93OzizNCf3E5S18z3BLgfJNyS2h
 bl5+3FiUGGRcERRD004GYtqdzi8uabu+56qPnQtKIeI9O/Xqp54UN/zOKkylkBcWk282ytLqMe0
 wHLqhl0+hACNl95hhwYGmw07UR6kAIaMJsgIKgSi/owboPw0WlDudQ==
X-Received: by 2002:a05:6a21:398b:b0:3de:46cc:b637 with SMTP id
 adf61e73a8af0-3de46ccb8acmr5001636637.64.1790608409828; Mon, 28 Sep 2026
 08:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787272661.git.daniel@makrotopia.org>
 <98c5d0524ec9b1064d218babd5a453548c7c317b.1787272661.git.daniel@makrotopia.org>
In-Reply-To: <98c5d0524ec9b1064d218babd5a453548c7c317b.1787272661.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:12:46 -0600
X-Gm-Features: AclHuK-6zUQoz6EQ_PyYBoP8cYYxVgw4E7cDLN89Ry31Inw6zFs1fg1CA4LfdH4
Message-ID: <CAFLszTj-0S9vAZuA6uaE6PpdeJHL4TNB9pejCKJNWLgBHSPrRQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] configs: sandbox: enable imagemap and its storage
 backends
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Sapp <rs@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Daniel,

On 2026-08-23T19:12:43, Daniel Golle <daniel@makrotopia.org> wrote:
> configs: sandbox: enable imagemap and its storage backends
>
> Enable CONFIG_IMAGEMAP and, so the end-to-end unit tests can exercise
> the real block paths, the storage that feeds them: CONFIG_MTD_BLOCK
> and CONFIG_SPI_FLASH_MTD (a bare non-NAND MTD reached via mtd_blk) and
> CONFIG_CMD_UBI / CONFIG_UBI_BLOCK (a UBI volume reached via ubi_blk).
>
> Give the sandbox SPI-NOR two device-tree partitions for the mtd_blk
> test and add a clean sandbox NAND chip (nand@2, no injected errors) so
> UBI can format on it for the ubiblock test.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> arch/sandbox/dts/test.dts | 29 +++++++++++++++++++++++++++++
>  configs/sandbox_defconfig |  6 ++++++
>  2 files changed, 35 insertions(+)

> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 5c97418783f..9e7d734a0b8 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -400,3 +401,8 @@ CONFIG_UTHREAD=y
>  CONFIG_UNIT_TEST=y
>  CONFIG_UT_TIME=y
>  CONFIG_UT_DM=y
> +CONFIG_MTD_BLOCK=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_CMD_UBI=y
> +CONFIG_MTD_UBI=y
> +CONFIG_UBI_BLOCK=y

Tom does this anyway from time to time, but you could run make
savedefconfig to get these in the right order - also CONFIG_MTD_UBI is
implied by CONFIG_UBI_BLOCK

> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> @@ -1633,6 +1633,22 @@
>                       compatible = "spansion,m25p16", "jedec,spi-nor";
>                       spi-max-frequency = <40000000>;
>                       sandbox,filename = "spi.bin";
> +
> +                     partitions {
> +                             compatible = "fixed-partitions";
> +                             #address-cells = <1>;
> +                             #size-cells = <1>;
> +
> +                             partition@0 {
> +                                     label = "nor-fit";
> +                                     reg = <0x0 0x100000>;
> +                             };
> +
> +                             partition@100000 {
> +                                     label = "nor-spare";
> +                                     reg = <0x100000 0x100000>;
> +                             };
> +                     };

Adding fixed-partitions to spi.bin@0 combined with patch 1 (auto-bind
mtd_blk on non-NAND masters) means every sandbox test now grows two
extra block-device partitions on this flash. Please check the SPI
bootdev tests (bootdev_test_next_prio in test/boot/bootdev.c expects
only spi.bin@0.bootdev / spi.bin@1.bootdev) and dm_test_spi_flash in
test/dm/sf.c still pass; if not, the partition table would be better
hung off spi.bin@1 (which no existing test walks), or off a dedicated
third flash chip.

> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> @@ -2242,6 +2258,19 @@
> +             /* Clean chip (no injected errors) for UBI/ubiblock tests */
> +             nand@2 {
> +                     reg = <2>;
> +                     nand-ecc-mode = "soft";
> +                     sandbox,id = [00 e3];
> +                     sandbox,erasesize = <(8 * 1024)>;
> +                     sandbox,oobsize = <16>;
> +                     sandbox,pagesize = <512>;
> +                     sandbox,pages = <0x2000>;
> +                     sandbox,err-count = <0>;
> +                     sandbox,err-step-size = <512>;
> +             };

Just to check - sandbox,err-count = <0> is the default, so this and
sandbox,err-step-size can be omitted. The comment can go too; the
property values already say it.

Regards,
Simon
