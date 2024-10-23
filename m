Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FE3D2E022
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 08:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0305F89092;
	Wed, 23 Oct 2024 10:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="w7XAKufP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Hx1vzQh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7657E890AE; Wed, 23 Oct 2024 10:41:49 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D17058908D
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 10:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XYMwK3WHlz9t3D;
 Wed, 23 Oct 2024 10:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729672897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nETczxx9naPwETSneqAB2+nSLhBVJJhureDjd5PqEQo=;
 b=w7XAKufPhnC+eXiJQOx5TlnZWA3AHsDLqflKHffmEjRVabOqur2Jqw0NtlUrKpqNhXg1/5
 Odau4nMOD13TXd4qHkCZOWbL8c5zt0HVzXHJinLwpKPspfm+Y7P32NYFUqyd99stg3vH7+
 7y7YJHK1RnpL+Q/3sGzkfq288sS7r1NEbIR1RcA009czjZYs51ggY4X+MCdWiDEMhHuPGP
 IRjJar3EfwW7NwZJxZRjsrg3BM61//fHsZChiDO2XXpiqEKzk20GKeOotbnxFoaPAQ8ruz
 xV9jTRv1EMr8nq8H+48tmJFYyF+FQ02QKUY0mVNyJuABVVb/G/sIOMxemiUSBQ==
Message-ID: <699f9d96-a109-40ab-9cd8-ed0c5b4b589f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729672895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nETczxx9naPwETSneqAB2+nSLhBVJJhureDjd5PqEQo=;
 b=Hx1vzQh3o0flhckvYFKT0d79+LlJUs+HlQa58hG16JnWxen/UuxBkK4qQd/DUKfEjO7sqL
 oO3gYpjczvXC1X6DqHRkdFSAFf+0R0YMMECvqibdcfCfAPKT4P2/lGh/LkrCr7ABkj7jeg
 1xMnBGeRNcfU5ZNTWKnLMljhy3YWqAPVjiRoRASmzj6AWe+RyaSt8grgLeag15N0LsHnGg
 3gRoL3eKC3FFGTsdY6dwSz8zno+zrSgsvk3QYleo4JCg3gRRvZXx1oa3ZvTZ2rNO5QaxE2
 WntskBPSXvMlKdxCOVdWa2nBQLc/l2t6X62uE/XwgVSJxwYpK2HU2I7ngfFOFA==
Date: Wed, 23 Oct 2024 10:41:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories support
 in QSPI driver"
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241022210633.271534-1-marek.vasut+renesas@mailbox.org>
 <SA1PR12MB8697AF99B0A56734FF65AD47984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <SA1PR12MB8697AF99B0A56734FF65AD47984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rakpnfp38gg36n7nwu7atxb64q4bk6c3
X-MBO-RS-ID: 1870e1da7dd7069787f
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

On 10/23/24 5:18 AM, Abbarapu, Venkatesh wrote:
> Hi Marek,
> There was some issue and fix is sent
> https://lore.kernel.org/u-boot/20241018082644.22495-1-venkatesh.abbarapu@amd.com/T/#u

Is this one fix or three fixes for three different issues ?

This seems to fix READ errors, which is apparently another error 
introduced by this stuff. In my case, plain and simply 'sf probe ; sf 
update' combination with single non-stacked SPI NOR does not work. Was 
such a simple configuration ever tested ?

> Not sure we need to revert whole parallel/stacked support?
Please stop top-posting.
