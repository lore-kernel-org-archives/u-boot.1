Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F01C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76577877B9;
	Mon, 27 Nov 2023 14:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701092368;
	bh=FdEW8QYUUufZUFBdEBCgpILBgPmNLy9fZMcduys+Uok=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=h4/mhhBySdr+G9d1HCqBTN4KF8RIfKjJ6nC/mgRZInoQ6rJ187oCz82JEFfmP04mQ
	 9t8IT982guJG5ZdwDi6zXS3FaSiJYdR5w7iH0X0HYB0stLTOCYdb2aQYTmCaap9rXx
	 3vXqDnM/1z30w4Y/cUKKWA9KZXKDlwM0NVHmec7cMvkMXboE3tMs6jTiE8suEfZ+e4
	 coby4nzXYufqWUgKwGc4qdKnrONCEF9O/bZKxQdNhm/8G66X7AK0cNUTGwh/v2HhMx
	 o4+CoQ4eAkmNoKe2WRy9yzpbGdMiyNgqug+ut975n7Vsn8jez7WcyCE/1DLjiJTSim
	 RrK6+GH/mrVIg==
Received: from [192.168.1.107] (89-186-112-232.pool.digikabel.hu
 [89.186.112.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 993CA8775C;
 Mon, 27 Nov 2023 14:39:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701092367;
 bh=FdEW8QYUUufZUFBdEBCgpILBgPmNLy9fZMcduys+Uok=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ngXUAIy3UT6k2b7qPECOu10+sBs3gYd/Kpu/j3GMUd4Cpbu4oW21xUkGtzY+zEYAl
 +8eco+kiOEyXHaGplEYGR2r3XcrefVtwDdZDr9x5q8z+Cp/iM6neyu8ofdShX1THPc
 giguj0LTv0DBRRrfDn3zehw2Bh8q4o1l56LNjM+A4sifgZbIy34P9M9sxKKgM+Dd9O
 WUTcm1994g8+l949cPpYCk9beOWXBu+aU2QLP+ot5uhotRyr5KmtordPoHP+Wm8w/A
 dLXyzmLWsCW/V7lwEUXjZdc785sIOjTRDvQqTQVL7yIcLbKi+WjzO3J2zoSwXKcrw8
 qIese95ouDWLQ==
Subject: Re: [PATCH] mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
To: Roger Quadros <rogerq@kernel.org>, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com
Cc: enrico.leto@siemens.com, trini@konsulko.com, praneeth@ti.com, nm@ti.com,
 vigneshr@ti.com, u-boot@lists.denx.de
References: <20231125111605.47536-1-rogerq@kernel.org>
From: Heiko Schocher <hs@denx.de>
Message-ID: <41ac9722-9fc4-7a13-caaa-89625a49383d@denx.de>
Date: Mon, 27 Nov 2023 14:39:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231125111605.47536-1-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Roger,

On 25.11.23 12:16, Roger Quadros wrote:
> AM335x uses a special driver "am335x_spl_bch.c" as SPL
> NAND loader. This driver expects 1 sector at a time ECC
> and doesn't work well with multi-sector ECC that was implemented in
> commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based correction")
> 
> Switch back to 1 sector at a time read/ECC.
> 
> Fixes: 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based correction")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/mtd/nand/raw/omap_gpmc.c | 95 ++++++++++----------------------
>  1 file changed, 29 insertions(+), 66 deletions(-)
[...]
> 
> base-commit: 9e53e45292ee2f1d9d2ccc59914b161bef9b10d7

Based on this commit and with the (rebased) patchset from Enrico:

https://lists.denx.de/pipermail/u-boot/2023-November/536793.html

I can confirm, that the draco thuban board now boots again from
NAND.

Tested-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
