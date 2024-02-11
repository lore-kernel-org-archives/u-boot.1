Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2FDC4829B
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 08:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 039D2879AF;
	Sun, 11 Feb 2024 09:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="IfKsBKNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99E887B2D; Sun, 11 Feb 2024 09:21:48 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA6C8798F
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 09:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707639705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6BmEDyMIdTeIx5H2nsrrPU/2KaJQBT6rRJ++vkka2Y=;
 b=IfKsBKNh/TwE39ZqMwUsVknnDkRs9vbXCBmzaFKgUTBrEhnwkAQSyMAoLxCBiM0Vtfb3D2
 uHe1+u4o+Py9ctpHUa5QqlljlEyYI8eb+GVmxiZcdQbKifEQAEQ5vThO6c4dWvGuqChBBA
 MvbcOwIsze8QUGx0WxSoLUE11NWqdecVePJHpY/xyOKHCIKmITArw0KWnZ1/I0QM4/Q2iO
 g+aGyaXbZwx+qtnNDxsqhbtSP7/b5QqhjyV0o0jv4CvinT6bN4cEf33Ozq+xWI3vYqpk1S
 FUIhuQfvtxGDjaJB0gFZv24uVdPWdHXMsImjJtDt/ES3bdVjSnaTLPF7YtoDbw==
Date: Sun, 11 Feb 2024 09:21:43 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, massimo.pegorer+oss@gmail.com
Subject: Re: [PATCH] doc: rockchip: Clarify the rkspi image format further
In-Reply-To: <20240210234115.GA3040305@bill-the-cat>
References: <cd0b002cacfd40ac294b1583c1769718e94e869f.1707588872.git.dsimic@manjaro.org>
 <20240210234115.GA3040305@bill-the-cat>
Message-ID: <92dae8a119411203c79192276294fbaf@manjaro.org>
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

Hello Tom,

On 2024-02-11 00:41, Tom Rini wrote:
> On Sat, Feb 10, 2024 at 07:18:10PM +0100, Dragan Simic wrote:
>> As discussed on the U-Boot mailing list, [1][2] only some Rockchip 
>> SoCs
>> suffer from a bug in their BROMs that requires a specific format for 
>> their
>> SPI images, which was the reason for the rkspi format to be 
>> introduced.
>> 
>> Improve the description of the rkspi format a bit to mention this, for
>> future reference and to make understanding it easier.
>> 
>> [1] 
>> https://lore.kernel.org/u-boot/c32129ba-db25-4b9d-9a4a-032d88dfb9cd@kwiboo.se/
>> [2] 
>> https://lore.kernel.org/u-boot/CACdvmAjfCWicRd=LKKyob7fZo79AFkUQKy0e1HBb0zyJuoO70g@mail.gmail.com/
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  doc/README.rockchip | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Can we please convert this content to rst under doc/board/rockchip/ 
> then
> enhance it?

Sure, I'll do that, but it will take some time.
