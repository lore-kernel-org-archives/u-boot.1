Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CFECCD1BF
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 21:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 007AD835B3;
	Thu, 23 Oct 2025 23:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="D/DzTpRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988EE80422; Thu, 23 Oct 2025 18:36:20 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DBC28003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 18:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7EB6725F2E;
 Thu, 23 Oct 2025 18:36:17 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p6xHYCxa8VzJ; Thu, 23 Oct 2025 18:36:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1761237376; bh=BcAoCWdEdezlUZZcvaCdw/3D5v3liR0kb5KlYndWEBA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=D/DzTpRCYkmpEdcTZF+kQ0CHNBQAv3Fu0mFlgQcMsCFohngTcAMjfK4Wk1JbvvBLW
 GQnTK+W2ENC5EQ7HLfBDs0pYrAwRSHMGzyeJJUG7d0Dmkpkwpm+heJcDsiJnsYpVxL
 P8XfLTyNVRR5igb2tQ4nKwmLxHXbxSjZec6JF2qI+r9w37Fh7/5HhR6s2VMQIoc4wn
 yhONS/qzNmITxox7wVyNMg/MJD36HA6/CcQWNSJlIPWuY935ZF40IQcike7UuRLMt9
 zsf5MYJ1wEuwfrnugV9Vz0kOWXVjioMudxJIkrwn44eedtoElYfuq107fHkM6bVQbb
 4V3QIq/Q7oKWw==
MIME-Version: 1.0
Date: Thu, 23 Oct 2025 16:36:16 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Bhimeswararao Matsa
 <bhimeswararao.matsa@gmail.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Ronald
 Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH 3/9] mmc: dw_mmc: properly address command completion in
 dwmci_control_clken()
In-Reply-To: <20251022075649.GB30163@nxa18884-linux.ap.freescale.net>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
 <20251017-mmc-dw-exynos7870-v1-3-a2c5139d9afe@disroot.org>
 <20251022075649.GB30163@nxa18884-linux.ap.freescale.net>
Message-ID: <d52418aee9ccb18fbf6fbe93024e3c1d@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 23 Oct 2025 23:41:50 +0200
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

On 2025-10-22 07:56, Peng Fan wrote:
> Hi Kaustabh,
> On Fri, Oct 17, 2025 at 08:54:08PM +0530, Kaustabh Chakraborty wrote:
>>The current implementation polls for the DWMCI_CMD register, for the
>>DWMCI_CMD_START bit to turn off, which indicates that the command has
>>been completed. The problem with this approach is that it doesn't
>>address the DWMCI_INTMSK_CDONE bit in the interrupt register,
>>DWMCI_RINTSTS. As a result, subsequent commands result in timeout errors.
> 
> This patch looks good to me, but I need a few more details to understand:
> 
> Do you mean that DWMCI_INTMSK_CDONE must be cleared before sending
> out next cmd?
> 
> Per my guess, DWMCI_CMD_START will be cleared when CMD done from
> controller perspective, but the card may not return back response.
> DWMCI_INTMSK_CDONE means response done. But if there is some commands
> does not have response, will DWMCI_INTMSK_CDONE still be set?
> 
> Please help clarify.

This was observed experimentally actually. In Linux this seems to trigger
an interrupt, and the respective subroutine does clear the interrupt.

> 
> Thanks,
> Peng
> 
