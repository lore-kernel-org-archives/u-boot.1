Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D47C54798
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 10:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281C3880B2;
	Thu, 29 Feb 2024 11:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QwHmqHbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFB1187F73; Thu, 29 Feb 2024 11:13:54 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB05F87B41
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 11:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 43D15CE1EF8;
 Thu, 29 Feb 2024 10:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE08C433C7;
 Thu, 29 Feb 2024 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709201629;
 bh=rLfRNXFWlOnhIyjVxxML1HWgozrMtXO8KcTdRmsDew4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QwHmqHbiivcm0mgzJ3v/xDYZy3quZMWNGX7RynVvSMWOliLjuLHVqqsgE1p2F4FCK
 X0Yrw07X26+Y7zqIPcqN8ozrqgo68kClc9ovL5crQi4rGeQl9HR/+RB1bvxCSwxBcL
 RJJbFlir8h4QHj0Z9kDIgmBESoalQR1VqVRyGwv0ovZCvFnA4jgKKbE1hnTWY29/QX
 HeK6iisxYjCv7cLZ0Zy2yeuG/awkjg56Gpbyx5wxoGx3SSINGR1ApAD6iapfb/xN29
 52Ggu5XP4X4deh9OlBIY7l8utXWtjJjLzRYYX8W5itrIF1QxPyYIkQw3bpqIKSphKJ
 WTCGoM8CtmBPA==
Message-ID: <34e1f240-1a5a-4982-aca5-43a508c469f5@kernel.org>
Date: Thu, 29 Feb 2024 12:13:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240228120645.958316-1-danishanwar@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240228120645.958316-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 28/02/2024 14:06, MD Danish Anwar wrote:
> Add APIs to set a firmware_name to a rproc and boot the rproc with the
> same firmware.
> 
> Clients can call rproc_set_firmware() API to set firmware_name for a rproc
> whereas rproc_boot() will load the firmware set by rproc_set_firmware() to
> a buffer by calling request_firmware_into_buf(). rproc_boot() will then
> load the firmware file to the remote processor and start the remote
> processor.
> 
> Also include "fs-loader.h" and make remoteproc driver select FS_LOADER in
> Kconfig so that we can call request_firmware_into_buf() from remoteproc
> driver.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
