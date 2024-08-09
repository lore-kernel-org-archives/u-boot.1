Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58978C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 12:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C366B86E85;
	Fri,  9 Aug 2024 14:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FKUxtmmj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C13885AE; Fri,  9 Aug 2024 14:45:18 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB2E08690D
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 14:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7929F616B9;
 Fri,  9 Aug 2024 12:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C063C4AF0B;
 Fri,  9 Aug 2024 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723207515;
 bh=GkB/8xN9Tkv/3CM8o+yX7BA4+xlyPJR3+JTrYgfpQi4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FKUxtmmj4e2IvBQDCeyLeyAv3USDE0nkmazyv/tllbAyPyy+rY61oHQrv5KVMa0cb
 3dbnWEMV3EQTm/5Qm2Qgb7XxNVDbmGA2P3ElbLz+y4R8AUZXfITKBtVNZw4J3FKv1O
 22ghmH+d4vpFdQ73jjrfSFpn2EIXkHKpC6aC89ro8Ub8J1rgkA3tnJms1ltwTWUVgL
 HgW2fo2yvI0D/v+ddO/k3X6VMFTPsR+xzfPVnuBiBPDbvaYDlRQU+/XSCImO5LQbkt
 FMJl784CRzQlXy3GYZhIU+9vn+RNypDqpWa8mY0cN+2GjA6654VW8b1sVejaC6IGKW
 ntyHJeuhkCAdw==
Message-ID: <9b8f3555-9d5d-466a-9578-8374697ef4f8@kernel.org>
Date: Fri, 9 Aug 2024 15:45:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] remoteproc: uclass: Modify uc_pdata->name to use
 combination of device name and device's parent name
To: MD Danish Anwar <danishanwar@ti.com>, Nishanth Menon <nm@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
 Andrew Davis <afd@ti.com>
References: <20240807090829.530865-1-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240807090829.530865-1-danishanwar@ti.com>
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



On 07/08/2024 12:08, MD Danish Anwar wrote:
> uc_pdata->name is populated from device tree property "remoteproc-name".
> For those devcices that don't set "remoteproc-name", uc_pdata->name
> falls back to dev->name.
> 
> If two devices have same name, this will result into uc_pdata->name not
> being unique and rproc_init() will fail.
> 
> Fix this by using combination of dev->name and dev->parent->name instead
> of using just the dev->name to populate uc_pdata->name.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
