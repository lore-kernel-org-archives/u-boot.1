Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41165C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 09:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E73D487E86;
	Mon, 18 Mar 2024 10:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0D0887DDA; Mon, 18 Mar 2024 10:39:25 +0100 (CET)
Received: from esa1.ltts.com (unknown [118.185.121.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02BE86F1E
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 10:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhargav.r@ltts.com
IronPort-SDR: tT9OexHFpVY8uJ9cYr83QtN8x8MusPrB6NcyJFh9+0NynlqtgOBN6YbuuvNyJ1At52b0e8cYNp
 meDR9+G9xY1w==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
 by esa1.ltts.com with ESMTP; 18 Mar 2024 15:09:20 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: bhargav.r@ltts.com
Cc: d-gole@ti.com, dan.carpenter@linaro.org, jh80.chung@samsung.com,
 m.nirmaladevi@ltts.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: Add support for TI TPS65224 PMIC
Date: Mon, 18 Mar 2024 15:09:05 +0530
Message-Id: <20240318093905.373963-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240318092959.373356-1-bhargav.r@ltts.com>
References: <20240318092959.373356-1-bhargav.r@ltts.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hello,

On Mon, 18 Mar 2024 14:59:54 +0530, Bhargav wrote:
> 
> TPS65224 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ADC, ESMs (Error Signal Monitor),
> and PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC
> can communicate through the I2C.
> 
> Data Sheet for TPS65224: https://www.ti.com/product/TPS65224-Q1
> 
> Reusing the TPS65941 PMIC driver to add support for TPS65224 PMIC 
> in U-boot. This includes driver for PMIC and regulator.
> 
> The driver was tested on Ti's custom AM62P EVM using U-boot's
> pmic list, regulator list, regulator status and regulator value commands.
> Since, support for Ti's AM62P is absent in u-boot next, the patches
> were applied on ti-u-boot ti-u-boot-2023.04-next and tested.
> 
> Changelog v2 -> v3:
> - use pr_err instead of printf
> - comments added in ldo conversion functions
> 

Please ignore this patch set.

I sent old patches again by mistake.
I will be re-sending the v3 patch with updated changes.

Regards,
Bhargav
