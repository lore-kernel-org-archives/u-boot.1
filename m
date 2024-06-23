Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDDAC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D249B88327;
	Sun, 23 Jun 2024 22:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Xb3VIyLD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D997288271; Sun, 23 Jun 2024 22:22:47 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C77148332E
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1719174165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WONWYtZX0CKQfhy5btVqOeqsZQVITflVRsDKQpeL5sI=;
 b=Xb3VIyLDJ06ILZLE9j5MIixoGJi9AL4CVxFXHTLFgjvJufMGPytBogLvz6rnonPfq6jlzW
 b6nUFtlC1gDrN3ZVyjCCNxIKDTT52lYDibRFfHrkmIiAlCsc4rMT4K+SVTi/nFXJIyXueb
 vtX+J+xGs0uWq1G/qxFgS4NGUH0s0OXqy7JaIuQNh0a6inhTmsSCMdkfestCrCkBNksL/c
 YXdOOv704q2SWS1NEwRM3N2XtnWYlO2v2fRhHy2C1IPBHiSxt4/Zg954xgRRWxFcH2+lzg
 Ah/JobJ2rsU0mxETnlSrTfueFwfKJown14OxOCPinYl+GLWXbAqCaLIjm7Lyxw==
Date: Sun, 23 Jun 2024 22:22:44 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, heiko@sntech.de,
 krzk@kernel.org
Subject: Re: [RFC] rockchip: add support for Radxa ROCK Pi E v3.0 which uses
 DDR4 SDRAM
In-Reply-To: <CALeDE9Mc3GUNnEu0EAZnpWFJhJe=k8LwvFGLFE0u2gjZLpkHTg@mail.gmail.com>
References: <20240623041542.50137-1-naoki@radxa.com>
 <6ee01ffc7cf4965e3c7404359d45098f@manjaro.org>
 <CALeDE9Mc3GUNnEu0EAZnpWFJhJe=k8LwvFGLFE0u2gjZLpkHTg@mail.gmail.com>
Message-ID: <783a6595ac7cc97035644cc004e8e632@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

+Cc: heiko@sntech.de
+Cc: krzk@kernel.org

Hello Peter and Fukaumi,

On 2024-06-23 15:08, Peter Robinson wrote:
> On Sun, 23 Jun 2024 at 13:21, Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-06-23 06:15, FUKAUMI Naoki wrote:
>> > rk3328-rock-pi-e-v3.dts is identical to rk3328-rock-pi-e.dts in
>> > upstream. only difference between v3.0 and prior ver. is, using
>> > rk3328-sdram-ddr4-666.dtsi instead of rk3328-sdram-ddr3-666.dtsi.
>> 
>> I think you'll need to get the device tree resolved on the Linux
>> kernel side first, and then imported into U-Boot following the
>> rules of the OF_UPSTREAM approach.
> 
> I think the question was more "given the only difference between the
> two is the memory is there a way we can do a single U-Boot build that
> supports both" and I think the answer to that is unfortunately no,
> even if the DT, config etc are all the same. I would be interested if
> you come up with a solution as I have a couple of devices like this.

Good point.  Maybe we could employ an approach similar to how the
bad CPU cores will be disabled by U-Boot on RK3582.  Though, is it
even possible to detect the board revision on the ROCK Pi E, e.g.
by reading the statuses of some GPIO lines that encode the board
revision?  I went quickly through the v3.0 schematic and haven't
spotted anything like that.

>> > here is console output from ROCK Pi E v3.0:
>> >
>> > ```
>> > U-Boot TPL 2024.07-rc4-dirty (Jun 23 2024 - 12:53:09)
>> > DDR4, 333MHz
>> > BW=32 Col=10 Bk=4 BG=2 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
>> > Trying to boot from BOOTROM
>> > Returning to boot ROM...
>> >
>> > U-Boot SPL 2024.07-rc4-dirty (Jun 23 2024 - 12:53:09 +0900)
>> > Trying to boot from MMC2
>> > ```
>> >
>> > there is an another way which can share same u-boot-rockchip.bin
>> > between v3 and prior, using ddr blob from Rockchip instead of TPL in
>> > U-Boot. is it acceptable?
>> >
>> > Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>> > ---
>> >  arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi |   43 +
>> >  arch/arm/dts/rk3328-rock-pi-e-v3.dts         |  445 ++++
>> >  arch/arm/dts/rk3328.dtsi                     | 1943 ++++++++++++++++++
>> >  configs/rock-pi-e-v3-rk3328_defconfig        |   97 +
>> >  4 files changed, 2528 insertions(+)
>> >  create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
>> >  create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3.dts
>> >  create mode 100644 arch/arm/dts/rk3328.dtsi
>> >  create mode 100644 configs/rock-pi-e-v3-rk3328_defconfig

[snip]
