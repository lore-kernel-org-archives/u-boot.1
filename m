Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3482CFD356
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 22:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F0483EF5;
	Mon, 24 Nov 2025 23:14:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oCkb60Qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B065B83F00; Mon, 24 Nov 2025 23:14:33 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF0A183EF5
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 23:14:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dFg9066qtz9vCC;
 Mon, 24 Nov 2025 23:14:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764022469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCN++haiSav0Uv4lUuMjb6OOj299aDM/Tfni46w/uKs=;
 b=oCkb60QiKSNaCVe30D/j86xPzJkyzB72RgNIVCsSZTG5NjVpojAf+AYNOtNToocaoXvNYj
 XD5EPqOjo06cOOiIkTMm9atM+hmaSsankbziXxW3MTBFYU4eFMS1xNz8NnhByfCsXXkQZC
 mWXtZF+UfnThUTMwkeu36WNDQwGGXXZneIIEcxyTMsgrzhNLACBiOritJzDrK/qhC4wced
 IXQ+3YcWZHur5vxs/8Q2jdbu5naSUd1b62JVMcF5qFiHk4qMfj2nqPkKv/KxkjgIC22qfp
 MPrTqg0POC2V7kFlTl0euI0X6EtFpi8MlSRKlGe/59H9E5Y0a41+O6mlmb4Hjg==
Message-ID: <7b21c476-ed12-48da-95f7-dd354e116a70@mailbox.org>
Date: Mon, 24 Nov 2025 20:23:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mkimage: Add support for bundling TEE in mkimage -f auto
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
References: <20251118232045.578034-1-marek.vasut@mailbox.org>
 <9e9ec219-3ae7-4ec8-8f85-5edb4bbbe53a@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <9e9ec219-3ae7-4ec8-8f85-5edb4bbbe53a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: r5sj6369xmy1x6srrayifo3c14abr9gr
X-MBO-RS-ID: aba6834988e0e6a9998
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

On 11/24/25 4:05 PM, Quentin Schulz wrote:

Hello Quentin,

>> Example invocation:
>> "
>> $ mkimage -E -A arm -C none -e 0xc0008000 -a 0xc0008000 -f auto \
>>            -d arch/arm/boot/zImage \
>>            -b arch/arm/boot/dts/st/stm32mp135f-dhcor-dhsbc.dtb \
>>            -z ../optee_os/out/arm-plat-stm32mp1/core/tee-raw.bin \
>>       -Z 0xde000000 \
>>            /path/to/output/fitImage
>> "

...

> Which formats are supported for the --tee-file parameter? OP-TEE OS 
> itself has multiple versions for the binary header (v1 and v2?) and we 
> can pass either a binary (tee.bin) or an ELF (tee.elf) in binman, c.f. 
> tools/binman/etype/tee_os.py

The raw binary only, see the example invocation above.

[...]

> OK so... On Rockchip we have TF-A and OP-TEE OS split in multiple 
> entries with different load addresses (see @atf-seq and @tee-seq in 
> arch/arm/dts/rockchip-u-boot.dtsi). I guess this means we wouldn't be 
> able to use this auto FIT?

Are those multiple "versions" of these binaries or are those really 
separate parts of a single binary ? The later seems a bit odd. Do you 
have an example of such configuration?

Note that you could include multiple TFA BL31/TEE binaries in fitImage, 
but to support that from command line would probably be overloading 
mkimage -f auto already.

...

The rest, I hope, is addressed in V2.
