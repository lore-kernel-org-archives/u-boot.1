Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C455FC531CA
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 12:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F4FC8102F;
	Thu, 23 Jul 2026 12:11:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id imlENT7s0eKh; Thu, 23 Jul 2026 12:11:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0F0A80FB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784808682;
	bh=2idv8Mk+IB2OSAmpLmbPCtdjTepclgw41BMNg50r1+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mOf3GbNLw2lOEl8xnfxVBW4MrhTQtjNZoW4j4t5nE+Ji00rAkpit/sj1hhZCm28pw
	 HzaeS/0DrvSy016zTQbtW+M5SBpg3cEa53zfE8lMMxJ+zrKv14HwvVmnoQoD/Ej44+
	 d5CxI1+iWf9u05JuDBNBzrqZJtJZbWBcPfqXhJF6HXOAJI0KY88ovYX7SqtkdAk7ts
	 +QGSUgGu/xX9ed4rK2kaBWXY/3/g6pPbI2sMly4ghpD8siqmTbvWaP+0UAzaeONcLG
	 b1r7/48yXcLnzeBXUmL90rnOWJN10dqNjwZMLHEYqYImnD2KXDKa3l5rwVLvBcl5TY
	 /ANMOmFejRrcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0F0A80FB4;
	Thu, 23 Jul 2026 12:11:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C99F039E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB66340523
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:11:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CpCL2VEn6M2r for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 12:11:18 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2602B40500
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2602B40500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2602B40500
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:11:17 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63E3B83E76; Thu, 23 Jul 2026 14:11:16 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9282580117
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:11:13 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34EE241463;
 Thu, 23 Jul 2026 12:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC171F000E9;
 Thu, 23 Jul 2026 12:11:10 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ian Mullins <imullins@redhat.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ian Mullins
 <imullins@redhat.com>, Enric Balletbo i Serra <eballetbo@kernel.org>,
 Enric Balletbo Serra <eballetb@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Vincent =?utf-8?Q?Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Simon Glass <sjg@chromium.org>, Peter Robinson
 <pbrobinson@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, Shantur
 Rathore <i@shantur.com>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Masahisa Kojima
 <kojima.masahisa@socionext.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH 0/2] efi: Implement EFI Security Architecture protocols
In-Reply-To: <20260710-efi_security_protocol-v1-0-a06cef90057b@redhat.com>
References: <20260710-efi_security_protocol-v1-0-a06cef90057b@redhat.com>
Date: Thu, 23 Jul 2026 14:11:07 +0200
Message-ID: <87jyql9a90.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784808671;
 bh=2idv8Mk+IB2OSAmpLmbPCtdjTepclgw41BMNg50r1+Q=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=gsTTUO7vybcB8p4+dQqkvtC3ArExR3p/2nJfNRtLtw/NCvheD66Vig6f+EXXLUUOX
 9GzxEHmeB2gHIMA7VUVWOHgZoSUYBGoDyg6UM1NckGSwwBlBl6gWeHXxDvxCCtPVEQ
 UFaoQLiKmG7AzK17AWOdyjQG07xPcYOz1ja15VUFxRI0zCRWqYxlqdx45TP82LZyC/
 gKFvM8RXbj6ObKUC+Hz6IbkzzDAGIi5ZAgMujJJXf9+UFXMttNGVVEgT0eTudCEa/q
 cM+8vRlI3MP27lFtZPsOErObsGWF//NnyqIIB2OmDfIUBjk3Fe+c0jPexBP38wUurx
 4yb2g3Pn4CmCA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gsTTUO7v
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="gsTTUO7v"; 
 dkim-atps=neutral
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

Hi Ian,

Thank you for the series.

On Fri, Jul 10, 2026 at 14:23, Ian Mullins <imullins@redhat.com> wrote:

> This series implements the EFI_SECURITY_ARCH_PROTOCOL and
> EFI_SECURITY2_ARCH_PROTOCOL. The primary motivation is to support EFI
> applications like systemd-stub in Unified Kernel Images (UKI) so they
> can temporarily override authentication for embedded payloads.
>
> Note: This work was originally authored by Enric Balletbo i Serra. 
> I am submitting it upstream on his behalf with additional testing.
>
> ---
> Testing Performed
>
> I have validated these patches across various secure boot scenarios on 
> both physical hardware and emulators to ensure the new overrides work 
> without regressing standard secure boot enforcement.
>
> Hardware: Renesas R-Car S4 (EBBR UKI boot)
> - [PASS] Unsigned image, Secure Boot disabled, without patch
>   (Boots)
> - [PASS] Unsigned image, Secure Boot compiled (not enforcing),
>   without patch (Boots)
> - [PASS] Signed image, Secure Boot enforcing, without patch
>   (Fails to boot as expected)
> - [PASS] Signed image, Secure Boot enforcing, with patch
>   (Boots successfully)
> - [PASS] Signed image (wrong keys), Secure Boot enforcing, with patch
>   (Fails to boot as expected)
>
> Emulator: QEMU (qemu UKI boot)
> - [PASS] Unsigned image, Secure Boot disabled, without patch
>   (Boots)
> - [PASS] Unsigned image, Secure Boot enabled, without patch
>   (Boots)
> - [PASS] Signed image, Secure Boot enabled, without patch
>   (Fails to boot as expected)
> - [PASS] Signed image, Secure Boot enabled, with patch
>   (Boots successfully)
>
> Signed-off-by: Ian Mullins <imullins@redhat.com>

I've run the newly provided sandbox tests with:
$ ./test/py/test.py --bd sandbox --build -k test_efi_secboot

And I see all test pass (22)

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org> # sandbox

>
> ---
