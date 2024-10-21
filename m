Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F49DD0E6C8
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A688892B9;
	Mon, 21 Oct 2024 10:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729499361;
	bh=b9Em9Sl6fyuAeRy3oVlz8Z9CXojNiqzf6bKV5S3slXk=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=nbAIdO1BWwbOyBnA6anRgUhHtwFnAHiMWQcUzsJFwkxSgBgAWLqmj1c/WAn5rNbgi
	 SoI2O6VmcuJEIEfaWbPAwoVzoACTuJ6j6FlGn3AM4QIZpdJE9+xqkJ/FBc9vo9wPlC
	 qidz6boWsBsw236VOHywL6rtr9I2YQoI6kOZLnim4fFk/Ux+A9TENfc4pOxhlPxbaZ
	 4VigUmGlKuVFBE64sdS3tIq/S15fGY9gmlYL5fAF9SlTusJsIIs7rvxOoWPqi2vOow
	 FJTHN6zF3q5LFcvK5lF887NUwIQ3FuAsIAF7r9NdIABxBozFUs6xJjzpyDH+sLc2AI
	 m+mw6uzKeg9uQ==
Received: from [192.168.1.107] (82-131-200-27.pool.digikabel.hu
 [82.131.200.27])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 756F4892E1;
 Mon, 21 Oct 2024 10:29:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729499359;
 bh=b9Em9Sl6fyuAeRy3oVlz8Z9CXojNiqzf6bKV5S3slXk=;
 h=Date:To:Cc:Reply-To:From:Subject:From;
 b=U8PXjOgzKQND8Wsyms8loOQxB3Zo8vbzVZMkCSUaBqyy/Puda6A6GZ+dumgieGNa+
 Ut8YIoDOX4oNLpUjsp7+jh3CE6S/jchCcj8OPGatnzKitotkCYeuEL8kyrdhsmQmzf
 p2p3RBw0nlUYPtmZhsMhMIBadTYLT9iGXrqJQGNswcErqb3vYTNt28XrV+pT6/o7+8
 2q/Thme6yYNKOLDJ5FzV2Tq+wR7ABXeQcr46Z/Vw4Mj61FJjInfF6kO5oTtsCaacig
 R6mVutVVgDiixgp0KuHAxTez6CfNA/MikIVdxgf5RHwvQ1HV95/QB9rEYXRTK2dGhx
 p79bs3290Bz4Q==
Message-ID: <7082f093-4e4c-7329-d10a-761753c8e16e@denx.de>
Date: Mon, 21 Oct 2024 10:27:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, bigunclemax@gmail.com,
 Alex Shumsky <alexthreed@gmail.com>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-i2c
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hello Tom,

please pull:

The following changes since commit fa0ed06a749c8e3c65d8b12a7d2d33a055a08aad:

   Merge tag 'efi-2025-01-rc1-2' of https://source.denx.de/u-boot/custodians/u-boot-efi (2024-10-20 
08:27:15 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git i2c-tag-v2025.01-rc1

for you to fetch changes up to f315a4813186ca098a6c698754a06b8297d400f6:

   i2c: i2c-gpio: add support for i2c-gpio,sda-output-only (2024-10-21 06:32:40 +0200)

----------------------------------------------------------------
i2c updates for v2025.01-rc1

- Add support for the following Maxim chips using the existing PCA954x
   driver from Maxim:
   - MAX7356
   - MAX7357
   - MAX7358
   - MAX7367
   - MAX7368
   - MAX7369

- introduce "i2c-gpio,sda-output-only" functionality
   from Alex

----------------------------------------------------------------
Alex Shumsky (1):
       i2c: i2c-gpio: add support for i2c-gpio,sda-output-only

Maksim Kiselev (1):
       i2c: muxes: pca954x: Add MAX735x/MAX736x support

  doc/device-tree-bindings/i2c/i2c-gpio.txt |  2 ++
  drivers/i2c/i2c-gpio.c                    | 10 ++++++++--
  drivers/i2c/muxes/Kconfig                 |  5 +++++
  drivers/i2c/muxes/pca954x.c               | 37 +++++++++++++++++++++++++++++++++++++
  4 files changed, 52 insertions(+), 2 deletions(-)


Azure build is fine:

https://dev.azure.com/hs0298/hs/_build/results?buildId=126&view=results

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
