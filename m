Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5606CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 12:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B495832AD;
	Tue, 30 Sep 2025 14:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JQnc4zZP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nfgDQkM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA99833E9; Tue, 30 Sep 2025 14:41:26 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE87D83045
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 14:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cbd372RbFz9tYd;
 Tue, 30 Sep 2025 14:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759236083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LI//Vt2L+FiaAJiclKT0geGQflwiwnnudR7r8DPavqY=;
 b=JQnc4zZPcnbLRTzEkv+ghESyRnLtSJgoXI57o4B59C6Myjc7l+cTiCdkEEOcBSYSCGCX6I
 Nqc153nQIpHp+5Q9yAl5m1VBMqynkz0WyFIupetZ9pQOhi4uGBSW38tl/i0jL14L2BSYLY
 4SWyM2iH4fFcC7qBwR9fjcMf17mYkponduEXfd0XeXj9yycEwNX8pA/XeHoaflvN5zg5pY
 0Dpr9XUMswx7zqzv6qApI5gWxC8lA079uFpoe6qUaZ6Thr2XUTQE57vPybwMwGXVJQO8Ph
 D+8osZtKoTEMOhsZoKJJ/q1KTnmVHppcw5dhbDZMDhHUbAmhva6rOJDtcXQgJw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=nfgDQkM4;
 spf=pass (outgoing_mbo_mout: domain of stefan.roese@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=stefan.roese@mailbox.org
Message-ID: <efe2806c-820d-4fc3-aa54-7650aa6a3180@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759236081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LI//Vt2L+FiaAJiclKT0geGQflwiwnnudR7r8DPavqY=;
 b=nfgDQkM4fVamxu3zG7jkLnLfGilRWTgQyEBVOqezldwDmK71VmASBG4gIXS8jJTY5acAwV
 PmYwT3tGcMxgk4SDkYNumwJLnBPTDs8v2IZXaldp2C22Und7YJQoBKv8okQekF0wkbHqrl
 PWzRq+hfqdTBX5EAvyF+oTmE+r/vXIOlVQ9gDRnNck2qCmMIX+9a2JquloPoZS16O00gU3
 Lj5Jxihq+2yr6CLzuk+2uDnHnMCgmTvDB5b1K/94p4lV2yTE0x7Q9Iz9K5c/k2fLbiDAqA
 OboqX2W0lH9byaAfc4Ak0Fc63Q1g+eBspxGJaQ0RrRlRnRPR5ykfS16CticTEA==
Date: Tue, 30 Sep 2025 14:41:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] pci: mvebu: Unable to assign mbus windows for 2nd pcie
 controller
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>
References: <20250929215006.6654-1-mibodhi@gmail.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250929215006.6654-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: sk55yzaq31bpywq9idr6rwh38pk3nb3t
X-MBO-RS-ID: 6f468fd958a6bdfa776
X-Rspamd-Queue-Id: 4cbd372RbFz9tYd
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

On 9/29/25 23:49, Tony Dinh wrote:
> Correct the memory and IO mbus windows size increments in mvebu_pcie_bind.
> 
> Currently, pcie1 controller resource_size(&mem) and resource_size(&io)
> checks result in a failure. This is because mem.end and io.end must be
> incremented at the end of pcie0 windows assignment.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
> 
>   drivers/pci/pci_mvebu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci_mvebu.c b/drivers/pci/pci_mvebu.c
> index 77815513b76..3985bd59607 100644
> --- a/drivers/pci/pci_mvebu.c
> +++ b/drivers/pci/pci_mvebu.c
> @@ -763,6 +763,7 @@ static int mvebu_pcie_bind(struct udevice *parent)
>   			pcie->mem.start = mem.start;
>   			pcie->mem.end = mem.start + SZ_128M - 1;
>   			mem.start += SZ_128M;
> +			mem.end = mem.start + SZ_128M - 1;

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

>   		} else {
>   			printf("%s: unable to assign mbus window for mem\n", pcie->name);
>   			pcie->mem.start = 0;
> @@ -773,6 +774,7 @@ static int mvebu_pcie_bind(struct udevice *parent)
>   			pcie->io.start = io.start;
>   			pcie->io.end = io.start + SZ_64K - 1;
>   			io.start += SZ_64K;
> +			io.end = io.start + SZ_64K - 1;
>   		} else {
>   			printf("%s: unable to assign mbus window for io\n", pcie->name);
>   			pcie->io.start = 0;

