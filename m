Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CB8C3DA7F
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 23:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 735D888747;
	Wed, 31 Jul 2024 01:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722380750;
	bh=Y7kTvAzxRNzR817Oi9qX7+ieYm+UhAkmCNRpO3XHQD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fLPkbK1JLjM/aNF9NUTXrXZ86EykLYdK6iRv+TislPwPKftyXwdgzY22kV+ZByTBC
	 NJ5Zg4+DcifoWm8eM6es/Y6YZq3TUcrSXHIcnece8XCoEckS4i8qZw78yKsHyYIHXS
	 4OwF3kqJXnhfTjKET0G5m4fSjmu43OJU9TRYuy+AUtrs1nEADbYWrD7UpOEfYYS2C4
	 1e3cVSHDxlvV6SltnpGqDwWTDAgOG5Gy0vbgea8cxAVxXeDVeATZmxFe2JmNO444My
	 CJyLe8GIxKn5aeUBuvKGAfSm6MhKNLkxH9ryk39NOJ+1bkOyWXfhb78mw01gnUFqDn
	 8+z5mzcos7VAw==
Received: from crub (p54833c06.dip0.t-ipconnect.de [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3937387FFB;
 Wed, 31 Jul 2024 01:05:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722380748;
 bh=Y7kTvAzxRNzR817Oi9qX7+ieYm+UhAkmCNRpO3XHQD8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lYmDK6Uq84V7MfotyUld7kS0VDySMNYEsoxg3LuylN5CmHbzQpcZtOq5s3l7yy1kh
 RWELMjpJFDFvf6ecqK4/j5DitKEyFSh5FLo7dO9PLi0p4g2E4X7sxm/qc1lfmOnmcU
 Z5vWLcFHUNngZ9iq5hw7bxcrsIfkUuc04gWsLtL7EtX4og7wVE+RU6zArE+MDO+3NW
 epWsiPM9U+LPqbNlraUzOQHjHcgwhbqw++YuWVfkCuWaj4sHEZqT4GnJX1WAaPhism
 l4GFVj3TeNPgi7z/go6SgW8g1AzDscD/eTOQVEW3111pREhgAZZFZUeU/twPCppGqd
 fxEckxFXOTubA==
Date: Wed, 31 Jul 2024 01:05:25 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Angelo
 Dureghello <angelo@kernel-space.org>, Anton Bambura
 <jenneron@protonmail.com>, Bin Meng <bmeng@tinylab.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Chanho Park <chanho61.park@samsung.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Nikhil M Jain <n-jain1@ti.com>, Ondrej
 Jirman <megi@xff.cz>, Peter Robinson <pbrobinson@gmail.com>, Randolph
 <randolph@andestech.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v3 0/5] video: Improve syncing performance with cyclic
Message-ID: <20240731010407.0ff6a929@crub>
In-Reply-To: <20240704074859.2956745-1-sjg@chromium.org>
References: <20240704074859.2956745-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi Simon,

On Thu,  4 Jul 2024 08:48:54 +0100
Simon Glass sjg@chromium.org wrote:

> Now that U-Boot has a background-processing feature, it is possible to
> reduce the amount of 'foreground' syncing of the display. At present
> this happens quite often.

This series breaks turris_1x_sdcard SPL build:

 https://source.denx.de/u-boot/custodians/u-boot-video/-/jobs/878470#L646

Should we enable CONFIG_SPL_CYCLIC for this board to fix this?

--
Anatolij
