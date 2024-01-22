Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC22C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 12:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D73879B2;
	Mon, 22 Jan 2024 13:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pwc39a1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D58D879CB; Mon, 22 Jan 2024 13:43:43 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9248987812
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 13:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BAE5ECE2975;
 Mon, 22 Jan 2024 12:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7D1C433C7;
 Mon, 22 Jan 2024 12:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705927417;
 bh=ZKRlQl+8PaImgsyKwewdXqP8qjLYmZaf/jkKC1WiD7g=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=Pwc39a1myLGsfaj5n3wdE4NpCg4IPdcQPnajI52mPyqXY+w3sS+pHOhp5c64r7wL/
 Uv9Fs+aK/Y246ScMAW/UXhQjROWp+w55q2gbTyO8QH2uCut3UxNq8Dj9IQgJOkXdNX
 /KMSiS/Z1o7zdgk/xi5ppyFM38qm5X0E4sSgaOQkTPVYUuom2SUxrH0bdxu5/wWB5F
 5VMzH0BPT9pCfsXXLYUh8u0LZz3wZUq1RIKSCFRHf/YwhnD0tnB0s3/WtFtJ1TG/mH
 h0J20WDcDdX+BRof5aM4yoqW2CVbyY+yhOEVMBjcyttEfxisAADlW2oEvKWqsdVlh1
 v4Xb/cyu63EYQ==
Message-ID: <e38ee3cb-8ae6-4890-a6b0-804c40508182@kernel.org>
Date: Mon, 22 Jan 2024 14:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/16] arm: mach-k3: j784s4: Add clk and power support
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
 <20240119175043.3904751-8-a-nandan@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240119175043.3904751-8-a-nandan@ti.com>
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
> Add clk and device data which can be used by respective drivers
> to configure clocks and PSC.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Bryan Brattlof <bb@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
