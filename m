Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0E4E7B5FB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A995D87515;
	Wed,  4 Oct 2023 14:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E6myhdpp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A577E82BBF; Wed,  4 Oct 2023 13:35:18 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25F42874FE
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 13:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id AB59BB81D7E;
 Wed,  4 Oct 2023 11:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4756C433C8;
 Wed,  4 Oct 2023 11:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696419313;
 bh=EKub7DB0kxiceubZBtND+wquahZHKwwMH5j2bwwGvZo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E6myhdpplLeJMfThiZcQnD5TncbV3oJuuWCinlPuQn3k62ICZ8+K1qAe7EQ3P+ESt
 x6o33yAOVmljx52m51Uqj3J5Ef+/6Zjv1Uumgy4uOj+QhZoDzNzLvfbSQuB0Ma7uf2
 GWh+mHpReWV2wzYF2F2ON1l7PZG9NxLcHKuGCkTHgycbXS8cVWCSH1CH9uV9TWRntm
 gKrqsO0Wx8WY6IV1emB+TGJeTnLYlhulj+hojFts5ksLDZ3dJc6vcJ24Kh5TPrBpzY
 Yp2+jP9LJYd3sUDcB4fYX5EkjIFbCYHpVD7jPKnS59GLT78lyezPF2/oKNTNKgZk/x
 s/fFrsndcc4GQ==
From: Michael Walle <mwalle@kernel.org>
To: miquel.raynal@bootlin.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, ptyadav@amazon.de, rafal@milecki.pl,
 richard@nod.at, robh+dt@kernel.org, robh@kernel.org, sjg@chromium.org,
 trini@konsulko.com, u-boot@lists.denx.de, vigneshr@ti.com,
 Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman
 compatible
Date: Wed,  4 Oct 2023 13:34:58 +0200
Message-Id: <20231004113458.531124-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004093620.2b1d6917@xps-13>
References: <20231004093620.2b1d6917@xps-13>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Oct 2023 14:04:49 +0200
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

Hi,

>> Add a compatible string for binman, so we can extend fixed-partitions
>> in various ways.
> 
> I've been thinking at the proper way to describe the binman partitions.
> I am wondering if we should really extend the fixed-partitions
> schema. This description is really basic and kind of supposed to remain
> like that. Instead, I wonder if we should not just keep the binman
> compatible alone, like many others already. This way it would be very clear
> what is expected and allowed in both cases. I am thinking about
> something like that:
> 
> 	Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml 
> 
> this file is also referenced there (but this patch does the same, which
> is what I'd expect):
> 
> 	Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> 
> I'll let the binding maintainers judge whether they think it's
> relevant, it's not a strong opposition.

What is the overall goal here? To replace the current binman node which is
usually contained in the -u-boot.dtsi files? If one is using binman to
create an image, is it expected that one needs to adapt the DT in linux?
Or will it still be a seperate -u-boot.dtsi? Because in the latter case
I see that there will be conflicts because you have to overwrite the
flash node. Or will it be a seperate node with all the information
duplicated?

Maybe (a more complete) example would be helpful.

-michael
