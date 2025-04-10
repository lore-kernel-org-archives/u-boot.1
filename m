Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95D3C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D7A83A64;
	Thu, 10 Apr 2025 10:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZKKc9E6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BE0C839DD; Thu, 10 Apr 2025 10:46:59 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B736283A64
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 796E16843D;
 Thu, 10 Apr 2025 08:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D8EC4CEDD;
 Thu, 10 Apr 2025 08:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744274815;
 bh=f9U4Pjp11bXJAk6m3ojdARIUsGb7At/1l46Xiniu1jw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ZKKc9E6sGm7i8YWl4a0xuBi5RJ3jxxausZuKmayFb/zxaJLNItJG/VapusTJK/Fel
 KHVfvQm3eCksCPgy3SEyaMqoWPMtAsg/NZQOMBDddPZ7IVNU7b1VutCUY42I/cfFt7
 ++fOcbDWGCvGThZE9LEaMl6t566D/8e/zv4BArTFYkqSdsORcQil+IRbynUChmhCTN
 VVYp12XLYiM8cOMU3QdKMkmac43qYJnxqbElVZbMXYgc3xf2zFJfnC+z7kj3L3tCdE
 c6Puex99VBVsUBu2bF8ScfdOMpSbX6AfJ2sp4Ft1TIwUbZX5Ba1L2oscHWfwEBlFeg
 CPbC1XODu7OzQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michael Walle <mwalle@kernel.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250312073655.2281377-1-mwalle@kernel.org>
References: <20250312073655.2281377-1-mwalle@kernel.org>
Subject: Re: [PATCH 1/3] fastboot: lift restrictions on !NET_LWIP for USB
Message-Id: <174427481042.285795.9065978685234555349.b4-ty@kernel.org>
Date: Thu, 10 Apr 2025 10:46:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79
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

On Wed, 12 Mar 2025 08:36:55 +0100, Michael Walle wrote:
> Fastboot works either over TCP, UDP or USB. The latter doesn't have
> anything to do with networking, thus should work just fine with
> regardless which network stack is selected. In practice, header symbols
> are used inside common code paths. Add some ifdeffery to guard against
> that.
> 
> This will make fastboot over USB work with the new LWIP stack.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/3] fastboot: lift restrictions on !NET_LWIP for USB
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/d3c9f810f2b317ba376b4d9556e63a043b210355

--
Mattijs
