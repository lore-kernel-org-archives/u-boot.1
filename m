Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC879CA0EF1
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 16:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50FA86E24;
	Tue, 12 Sep 2023 18:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1694537488;
	bh=8eSDeGfruATGMepWd3bn+5PiBpVf6H91ZexfNGfnP9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QVEII+ENB8S95qQ0zuBDGceyqRNjMHqnwBNYCwVJf1Ja2qq8e6o1T8lZoPLwgqi+c
	 WLb8d2kbhCg39BPYuYfU+IVittBcsPM4LX1Qu4CRmUQr1KNKD51CaKAopPijHNs9q0
	 +9peIRlHXGxoK44rCqQq3EE96n3MZMJmOAV3CcnVY5VwbTs9RFa3kLeWcfx21j5vWa
	 12gtPxSYSho5GGm3WY9C4/wSgmF+WU2bM/A/lUNFREZIrZTws97SzS5fpalYNcXLp6
	 csCQv9MSHILCtrsX8kaTz867/WvGZIJSVXhlMu15FXMsSsdt1awDOT+rV4s12OoLMB
	 QqE95OWfm+27A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E040B86E13;
 Tue, 12 Sep 2023 18:51:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1694537487;
 bh=8eSDeGfruATGMepWd3bn+5PiBpVf6H91ZexfNGfnP9Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=J6nEPNPwX9LR4hS3EWNIPcsM0Q5/A6z1g54frrpgWewg2SJQjySmtTacJBZPl4jt3
 B+IxjILCCncZrB28DgiP7QZgZBqoFjYDkU8opvnjIZqXE1VFB75m3k3irEKbfNu9d6
 B/Gi/6AUwmOOxcto6GjH855NESI+WSvJJg7a0usK6zrFF9ADLi4A8k+WvAKJfS0VFo
 wG3up7w4H9kp80RKLVFKbpXTxqTrSwZ2RV+RcwQO25lFF5A6TaQ2qUiyS9+fcwkM34
 k/vNE8UiLRCW2QTKk604YhdnfyBavvhB6hmEvy4Y0ltkmE5Lg3NfPaj7MIJVo9BZtl
 hQPHOYfJnu5nw==
Message-ID: <d1627638-e9ac-d24d-5b6b-3e5c8d1fc158@denx.de>
Date: Tue, 12 Sep 2023 18:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] usb: dwc3: core: add external vBus supply support for
 ulpi phy
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, git@xilinx.com
References: <20230912040147.30734-1-venkatesh.abbarapu@amd.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230912040147.30734-1-venkatesh.abbarapu@amd.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/12/23 06:01, Venkatesh Yadav Abbarapu wrote:
> [ Piyush: Ported from Linux kernel commit
> 	  b84ba26c922a ("usb: dwc3: core: add external vBus
> 				supply support for ulpi phy") ]
> 
> Some ULPI USB PHY does not support internal VBUS supply, to drive the CPEN
> pin, which requires the configuration of the ULPI DRVVBUSEXTERNAL bit of
> OTG_CTRL register.
> 
> Added 'snps,ulpi-ext-vbus-drv' a DT property to configure the USB2 PHY to
> drive VBUS with an external supply, by setting the USB2 PHY ULPIEXTVBUSDRV
> bit[:17] of the GUSB2PHYCFG register to drive VBUS with an external supply.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Please sync the DWC3 driver with Linux first.
