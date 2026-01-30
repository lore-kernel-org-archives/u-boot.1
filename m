Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19937D49C6B
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 08:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8387F8420D;
	Fri, 30 Jan 2026 09:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c/1oIfIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53A1E8423D; Fri, 30 Jan 2026 09:00:50 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E131784206
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 09:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BC9C760126;
 Fri, 30 Jan 2026 08:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE0FC4CEF7;
 Fri, 30 Jan 2026 08:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769760045;
 bh=8N+8nKpR/gFVvWqjct/xpQJkkTU2y32VeVQquxwvHMY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=c/1oIfIVE3mWPuj9RcOTqGgx+mm1soyyhUBxaGpts7rCxYtxWrh/8jwzaUN4V6Bgf
 ejwdsNSW33OTncVIIdDoQDU2P7X8PpmBuqwHVbv1BdWopfRoaGfrG/Tw0r4ONaXS9D
 TKSUREUr1GCjL8b3wMo4Z9UttM/xDgpHPaehEd86sHOfbAY7owOBwQo9P6gzFb+k/t
 ndSdeBg++oaunD+22ivI/tq68cDOlrwkvgseMH9mXseTyUeBfPCxQ9FdCOlgiZsAHK
 2yBq96lqmG4qi42ufXPAdFP0Io6qXmiHI8609zSXr+M329n2txGxYM+QTp0pyAZN55
 uBkxdPJ1XJMWQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Chris Morgan <macroalpha82@gmail.com>
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com, 
 felipe.balbi@linux.intel.com, lukma@denx.de, trini@konsulko.com, 
 marex@denx.de, macromorgan@hotmail.com
In-Reply-To: <20260115230135.183158-1-macroalpha82@gmail.com>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
Subject: Re: [PATCH V2 0/4] USB Fixes for Gadget Mode on DWC3
Message-Id: <176976004263.485564.15580714476503359162.b4-ty@kernel.org>
Date: Fri, 30 Jan 2026 09:00:42 +0100
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

On Thu, 15 Jan 2026 17:01:31 -0600, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> In order to get gadget mode functional (for fastboot and ums) I need to
> pull two patches in from mainline Linux. After applying these two
> patches to U-Boot I am able to use ums and fastboot on my Anbernic
> RG353P device for testing purposes.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/4] usb: dwc3: core: Add ip and version_type support from Linux
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/add7152eb071619efa150e4b7503f9f333133dbb
[2/4] usb: dwc3: Increase DWC3 controller halt timeout
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/7590f29e2cd72fb8ed50efde3cdb786d74dc1f10
[3/4] usb: dwc3: gadget: Don't send unintended link state change
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/de69f14a0991f3b9afe78dc0721a9184d297e303
[4/4] usb: dwc3: core: improve reset sequence
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/aef270254f0feaad54837d3fbbc04ad0c060d3fa

--
Mattijs
