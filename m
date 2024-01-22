Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048EBC4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 12:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD67879FB;
	Mon, 22 Jan 2024 13:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sVpYZpQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07468879BE; Mon, 22 Jan 2024 13:41:39 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9274887A01
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 13:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 265BCB80B96;
 Mon, 22 Jan 2024 12:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E9FC433C7;
 Mon, 22 Jan 2024 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705927294;
 bh=vMHtmUIBGROpYsWqWE7qSZCQh0lSXNKKzZcFSRdtngk=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=sVpYZpQWNrH1xvy19uiGI0Oc7HCkBBIBVWd9PviLRDhBLnzJlZm0upNAn04EkC9pK
 MoPz3KbFuyHIqIrkeJHyEh/gZe0WISTggwy8G3Qs74sQnwgZmhyT7wYr7dHpkZTQPz
 R8QILRzcrFkyf0y0xFAR8btMN+CbyAvn7uzRxU7kTaCIFFN8ZGmQ6Nt6LwH5KKOCjK
 5kqtn/x/IcBbtT3iVioISEr800ttQMfoBr0I0Zho79S04RODll569G/MpHxyU7u9f0
 Qm/+e4Q9ef00S0UfZojYgarzz9ntqy/PSvGQX2gaL6U1SA3XtlS3VuXBCJ7Odn2UFo
 JazzdjTL61ieg==
Message-ID: <bf810d9f-5959-4a41-b732-1490589151b8@kernel.org>
Date: Mon, 22 Jan 2024 14:41:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/16] arm: mach-k3: Sort SoC JTAG_ID entries
Content-Language: en-US
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-6-a-nandan@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240119175043.3904751-6-a-nandan@ti.com>
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



On 19/01/2024 19:50, Apurva Nandan wrote:
> Sort JTAG_IDs for K3 SoCs in hardware.h in alphabetical order.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
