Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E667BD1F9C5
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 20:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2293E87FED;
	Tue, 15 Oct 2024 22:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729023728;
	bh=lVx4I9FeAsJoXU0o3Wqmsgujkd2+EArhzLBJZY7WS9o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bnCsB+UmbWq+5pKPgrKiiAjt30xhMUbYh9zpxrMKIFtrzsRE+mp3kgsymumsj0pGQ
	 zbn2qLcvV7RyFV+YSbOVBijhA7DHXuK6iZ/WtTWJ+4TpLoNM9MAmq3gkex0CmXGS8l
	 9xGsolmBpGjpOQ8w1xiyaBXmQH1zHMV8JaSXUpJpCekmTGLxIu45p2L+0RdfNqUyn3
	 jqCGn8YQlg7uJRdyjGysYDiQ1TZaIKFZy5amjMYlJUW+nBSKu277BW26uD6xdeC9rv
	 /BVZl7mePaDHNI3jb5LhK56vVKH6md9AqnXSTiNtfs8WdjIZpYJ235rvKtYpTCizZX
	 PRy/sdrIOztOQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C168487F19;
 Tue, 15 Oct 2024 22:22:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729023727;
 bh=lVx4I9FeAsJoXU0o3Wqmsgujkd2+EArhzLBJZY7WS9o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lJyUo/nThCp3HYXJBtOPUiCLqIjego/TUj8qwNsVOfHFkbj5qmnmxKBBhYJLAP25Y
 zWW6EVQYTBiWLg1ByNa9sa9HmgYIef15rvL08sGzVNm22Nx4EPsWpX5uxzL3rmxC7z
 Bqj/8NQ5oP4OnVBMfKiH5tbHbZQEbxRfo6/Fmwk/99UWfBAZDch2wFMY1sQk+HAeEM
 GYvH0kVI8qRvk0PxiW4NaKPWfeU9G6lWchzgy9PtD/g9P8dMC1cbCp+mrb1D6z65/1
 xmeRNNW9QsKHm0rCD1Zm2o1rzJX0qo1CXnD54t275YoJKqJh2emY8JRkC/5Awz2FmJ
 A/szOdM0F0m6w==
Message-ID: <d87b9fc8-5bdb-4e16-a219-51d05230bc80@denx.de>
Date: Tue, 15 Oct 2024 22:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dts: Add ability to build fallback DTBOs from
 arch/$(ARCH)/dts
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241007120002.25690-1-marex@denx.de>
 <CAOMZO5BX3EvcGAJjKNt-vX9+9se9nzmf19_-4f4gfS59C9Q8Sg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5BX3EvcGAJjKNt-vX9+9se9nzmf19_-4f4gfS59C9Q8Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/8/24 4:16 PM, Fabio Estevam wrote:
> Hi Marek,

Hello again,

> On Mon, Oct 7, 2024 at 9:00 AM Marek Vasut <marex@denx.de> wrote:
>>
>> Currently the enablement of OF_UPSTREAM results on the build system
>> searching for DTs only in dts/upstream/ . There are platforms which
>> use U-Boot specific DTBOs applied on top of U-Boot control DT during
>> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.
>>
>> Add dedicated 'dtbos' target which builds only .dtbos and not .dtbs and
>> in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled, build
>> this target for arch/$(ARCH)/dtb to generate local U-Boot specific DTBOs.
>>
>> Adjust top level Makefile so binman would search for .dtb and .dtbo in
>> both OF_UPSTREAM specific paths and arch/$(ARCH)/dtb for the .dtbo case
>> in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled.
>>
>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> This one no longer applies against the current u-boot/master.
This should now apply on u-boot/master .
