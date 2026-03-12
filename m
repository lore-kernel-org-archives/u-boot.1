Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833E3FED2F0
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D67D883F00;
	Thu, 12 Mar 2026 10:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CoQ5rl+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1322A840A2; Thu, 12 Mar 2026 09:59:59 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC8D683DA6
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 09:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BE1FF60131;
 Thu, 12 Mar 2026 08:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4206C4CEF7;
 Thu, 12 Mar 2026 08:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773305995;
 bh=1IRcaa56YquvTNDf824kNyV7IwxhcXIOhnngfAXfrLg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=CoQ5rl+RmTOPAOTAvwfiYhZULEZryoTfvf9y+4wwuguQrNZ9ONdeIizTgo090baST
 7jIL0aHXTYkKGyhgtcIUdKyqHB7F45t2IccLnatiJau10RgtjzyXRms7R7PTNmfvMW
 AD83ADUYQX7VGQWB9Mmc1qd+WUEaykifOIk5BsOjrd5nqqIulJH1DPE1cGJRnfNT4d
 MEIzZCorXb18ZUUyjwVaqo4PonREz4DXoQMt2ZiKQKGzutp6r16hj8KxImfosKaOkQ
 a6FOXPVItckgsw3iffuapZfMg1I+Erd82bcmtOJ6NRaCFV9CKTsP05NFC0OeiDOrza
 RmxrCt2tbkezA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: trini@konsulko.com, lukma@denx.de, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20260305103815.999886-1-s-vadapalli@ti.com>
References: <20260305103815.999886-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] common: spl: spl_dfu.c: Fix warning associated with
 PCI subclass_code
Message-Id: <177330599273.513094.6587196751735168553.b4-ty@kernel.org>
Date: Thu, 12 Mar 2026 09:59:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 05 Mar 2026 16:08:14 +0530, Siddharth Vadapalli wrote:
> The subclass_code member of the pci_ep_header structure is a 1-byte
> field. The macro PCI_CLASS_MEMORY_RAM is a concetation of baseclass_code
> and subclass_code as follows:
> 	PCI_BASE_CLASS_MEMORY: 0x05
> 	Subclass Code for RAM: 0x00
> 	PCI_CLASS_MEMORY_RAM:  0x0500
> Hence, instead of extracting it via an implicity type conversion from int
> to u8 which throws a warning, explicitly mask the bits to extract the
> subclass_code.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] common: spl: spl_dfu.c: Fix warning associated with PCI subclass_code
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/433a17aca15481cde866a9bc636b61584360fbb3

--
Mattijs
