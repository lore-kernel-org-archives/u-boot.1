Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9788606A334
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vKLHDcAa;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=ufBBiKf2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A07CE81774;
	Fri, 13 Nov 2026 20:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6TymPEF0FAG7; Fri, 13 Nov 2026 20:03:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0733817AF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794600222;
	b=j7CImXht23NxhKuu4m3/xsoeEpfSbgpJ3H/l/gDX6ZA3g5y/wN88tSEqbuGXOEIB9foz
	 P93vu8HaSS6djKv+YtN4hH/WZX81oOEeTAeYG4KrFN37W2g4fZCdzt5nYA+zaREajdlPz
	 wRJhlKrgyJaRDV/eHdtZmHfkzIOv0Woao6xhAdaXXI/flmbCeQzjZXA8IsZsN/uVtwSBU
	 kNzlGvgMe4/7vUINXA4+Tzaovojp5gt8MHMXL1j7SWQy8u3Jo+RB4ytD5eGKGS5MZ8PIB
	 1MnLuYyZMm5PvlzlWpBtS5m57uMCC/2yqLxarhRBxQQ0kBih5vUTlls/gkxC9JK4aYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794600222;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Ib062Fr1Pb/SugAnXDfmQFOXYEWX8imsXt0Hvoie+RY=;
	b=ifs7wdSjQfIJS+evRYgw170IvXvrmzF4kbBJbMBOeX0cHSpUHnVtfOcBZ/Zh1tb0dd39
	 nVhzdG9vak4EY/up18Ovso0aS9T6DsBIBee5psZ4LUWUONWyMxdwLTfY6Ss/RCnSUSrZP
	 x4ddfMrqE5GPXFdDJ4qig1dZpEBPN4viwTNPdfNVeTGRA+NbJRkQhelb0prqiz+jXA4hF
	 zcpy1e3ekEtKd6bN10uR+snGwpnN64tk6XlUwkAn30+URD/05l9v/2hzYIx7kiBEMpiBS
	 0KOHsCSFtJfSZNQqvSWoFhYuG+EkdR/QGElt5xqUq5A/9Z8P/QafqZMtALqeBPwcvWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794600222;
	bh=Ib062Fr1Pb/SugAnXDfmQFOXYEWX8imsXt0Hvoie+RY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vKLHDcAaqz3H24elk6C8GqpYPyIbc4ExVBGowinQuWDRu5d8V4k1Kcq1yAREYzXAO
	 sX0+LiJjLetDaibickbqhnoUdefROd7TbftpUvLDJN934lDdSGlsuk/VI54PaN0sKv
	 +vYHvNJR3VKBJ9rnYnqWfaq/vs61s3cFWl2ulIzd55KaeoBfPEDeGJjcmZ/zhdvyLx
	 RFh7qEGzccBxzPzDB5uupQllrWuKU7LdzUqQfesxWXXqJb66s7KTnzZmdW4MFICKkF
	 RBNN+al2FL3buj+VrZ2XAvmxGQQ9sKwBSNNq98ndPI9DzWUaIs4DYfurdrUi++OREU
	 ioth8k9tBpl6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0733817AF;
	Fri, 13 Nov 2026 20:03:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C11341A6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 20:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD67640E17
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 20:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IV8ReyAbMMe2 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 20:03:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EF24E40E00
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7708869e7=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=ufBBiKf2
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF24E40E00
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794600220; x=1826136220;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xCRAM5RsDzKF1pPeUvgTMi2e9A9tshmtwyq5kvagdZg=;
 b=ufBBiKf2pGeJxTpKSv9OIsnoXsK+XbTYUEHPkDTFBit3BbNxcWE/1rFh
 rNL39zWVyaPq4iSf83RNqjJ/W0T6atJotl9KyDK9KMYhYzRaXgOfnHP37
 3bJk1FO0/lqmuCKcPOehTVtGdpUwADIi0OUmazqtgfhpgW3jj9jM0Ag+E
 8pN2OuZuEdK+doujHZYQeV0oDLgrB021nbmzsGuMHAlyjuHvtNfb9BNfx
 f1SoQAx5gqkQ0itW05pXHl0BDNV/EVSvntkh/ptf88+V77CToqOXpk6sY
 8z8awWL3U71l5r6jKQ54IcIU6rg/io3cyqdlVepCcDPSVSqpamTvuncEL w==;
X-CSE-ConnectionGUID: gTlmUVHtSeSua5Z4LXSeoA==
X-CSE-MsgGUID: YQdWEyQlQNelDcaviR7FEw==
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="297901131"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Nov 2026 13:03:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 13 Nov 2026 13:03:37 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 13:03:35 -0700
Date: Fri, 13 Nov 2026 15:03:33 -0500
From: Charles Perry <charles.perry@microchip.com>
To: Tom Rini <trini@konsulko.com>
CC: Charles Perry <charles.perry@microchip.com>,
 <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>, Rahul Pathak
 <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Rick Chen <rick@andestech.com>, "Leo Yu-Chi
 Liang" <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>, "Conor
 Dooley" <conor@kernel.org>, Peng Fan <peng.fan@oss.nxp.com>, "Subrahmanya
 Lingappa" <subrahmanya.lingappa@oss.qualcomm.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/8] Add support for RPMI to U-Boot
Message-ID: <avdtFdcuCvG6YE7f@MON-LT-C78453.mchp-main.com>
References: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
 <20261113194911.GP554944@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261113194911.GP554944@bill-the-cat>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> 
> Once QEMU is updated, do you plan to update / add more tests, so that we
> can run those tests, and presumably have more comprehensive testing, in
> CI? Thanks.

That might not be possible because I need a special patch on top of
Subrahmanya's series to add the clock service and some phony clocks. This
clock service isn't going to be upstreamed to QEMU because it's somewhat
useless outside of testing.

For CI testing, the path forward would be the sandbox mode that I added.
The only drawback to this sandbox mode is that it will NOT test the transport
layers, only the services.

QEMU is nice because it does test both transport layers and the services
themselves with librpmi and OpenSBI (but I need the special clock patch,
and we also need to build OpenSBI).

I'm open to any suggestions that would improve testing and CI.

> 
> -- 
> Tom

-- 
Thanks,
Charles
