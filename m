Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38EEC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 16:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB55B883DE;
	Mon, 22 Jul 2024 18:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BEFOpnYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E9E088387; Mon, 22 Jul 2024 18:43:17 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A06D88348
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 18:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46MGhB6M019976;
 Mon, 22 Jul 2024 11:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721666591;
 bh=L+6ctzE7ECiYwYDDc0kNNFSjIt5Vfm0G7TB5XYXZZYk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BEFOpnYwWAvO9Xbn47cAEQu+l0uJrKpHMZOa+ZRSdMua3ylRQ+lHfu7MalmXSMEmf
 Z+SZknWJrtupUAs6mzbLWA03JfaMUvFqu4lmbZ9d6/qqTYsgUF0cQ+IXI10KDAyaFi
 FFQwAGi0SFJkhgxcugoWI2l7WO5UyJlrfthbQWqk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46MGhBT5019157
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 22 Jul 2024 11:43:11 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jul 2024 11:43:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jul 2024 11:43:11 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46MGhBtL006144;
 Mon, 22 Jul 2024 11:43:11 -0500
Date: Mon, 22 Jul 2024 11:43:11 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Sebin Francis
 <sebin.francis@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>
Subject: Re: [PATCH V6 2/6] doc: ti: k3: Add TIFS Stub documentation
Message-ID: <20240722164311.jszai6ahxexvw5hz@skydiver>
References: <20240719070312.3771755-1-d-gole@ti.com>
 <20240719070312.3771755-3-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240719070312.3771755-3-d-gole@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 12:33-20240719, Dhruva Gole wrote:
> +
> +.. k3_rst_include_end_boot_firmwares
> +.. k3_rst_include_start_lpm_firmware
	s/lpm/tifsstub ?
> +
> +* **TIFS Stub** - A small piece of code that helps restore the remaining
> +  context and resume the TIFS firmware when resuming from Low Power Modes
> +  like Suspend-to-RAM/ Deep Sleep. It is loaded into the ATCM (Tightly
> +  Coupled Memory 'A' of the DM R5) during DM startup. The reason it isn't
> +  merged with DM is because in HS devices we need to sign the tifs-stub with
> +  customer key. The DM cannot have a component signed using a customer key
> +  because a HS device customer owns the customer key and only customer
> +  has the access for the customer key. Since TIFS Stub signing has to happen
> +  from the customer side but the DM is released by TI or built by customer
> +  optionally using publicly available sources, we need to allow binman to
> +  sign the TIFS Stub and only then package it alongside other firmwares.

How about:

The TIFS stub is a small piece of binary designed to help restore the
required security context and resume the TIFS firmware when the system
resumes from low-power modes such as suspend-to-RAM/Deep Sleep. This
stub uses the same encryption and customer key signing model as TIFS
and is loaded into the ATCM (Tightly Coupled Memory 'A' of the DM R5)
during DM startup. Due to the independent certificate signing process,
the stub is maintained separately from DM.


> +
> +.. k3_rst_include_end_lpm_firmware
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
