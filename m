Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D42C48286
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 17:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E4387C7A;
	Thu,  1 Feb 2024 18:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="M4eaX37D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E3187CFE; Thu,  1 Feb 2024 18:56:49 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1565F87CDB
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 18:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1706810206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2LAXXIl5NMRe3Jc8PDHrF6UU7utFHQIYA5FctcI10I=;
 b=M4eaX37Dob5+/vTaL4exXizRBZYy10iR1G/cyuX0lSnSwA8jAcVXmxFUODDdETKfbQWcWD
 bb/6b3eSKAk/XnrtIMoU0XI18+HIkImIy3NVnJFup1QDhFHjhUcaIWMU4+YKPSn2kqY2WK
 LWye/urogI7z/5NBNMp4VkjwU6O7dyJn3Nc7OLDQ26lVpVKuwvXtsPz4nr7pfjG3woMijT
 HambRjh+KWgVQW5y3EUwKl9qX/SLIJ9dULwA1ae5LuzluWU9cAnyZQWlYu7qQDF9Yrn/LW
 qpzHqGXI70qi8EqOm+sdzUpwhfs0xRpwlrrkxGJ52Vo0J5PoiUqjrRvk2C4qlg==
Date: Thu, 01 Feb 2024 18:56:43 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz
 <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, Jagan
 Teki <jagan@amarulasolutions.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>, Andy
 Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, heiko@sntech.de, u-boot@lists.denx.de
Subject: Re: [PATCH 06/18] rockchip: pine64: pinebook: migrate to
 rockchip_early_misc_init_r
In-Reply-To: <4489aa5b-9bd1-415f-9bcd-32b8250e0024@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-6-1eec1c34953c@theobroma-systems.com>
 <86f059d7-c2db-4b23-bc50-0317c70efdae@rock-chips.com>
 <ef680bb049878ca5b97a2a257c918db2@manjaro.org>
 <4489aa5b-9bd1-415f-9bcd-32b8250e0024@theobroma-systems.com>
Message-ID: <e86f694a72ff352faec01f371cd02170@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Quentin,

On 2024-02-01 18:46, Quentin Schulz wrote:
> On 2/1/24 05:02, Dragan Simic wrote:
>> On 2024-02-01 03:48, Kever Yang wrote:
>>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>> 
>>>> Compared to the original misc_init_r from Rockchip mach code,
>>>> setup_iodomain() is added and rockchip_setup_macaddr() is not 
>>>> called.
>>>> 
>>>> It is assumed adding rockchip_setup_macaddr() back is fine.
>>>> Let's use rockchip_early_misc_init_r instead of reimplementing the
>>>> whole
>>>> misc_init_r from Rockchip (the side effect being that
>>>> rockchip_setup_macaddr() is back).
>> 
>> We might actually introduce some issues with this change.  I'll get
>> back later with a more detailed explanation, together with a proposed
>> fix, after I check it all in detail.
>> 
>> This applies to some other patches in this series as well.
>> 
> I assume this is specifically about the migration to 
> rockchip_early_misc_init_r?
> 
> What's the issue? And for which devices?
> 
> I don't really need this patch, it's just to avoid code duplication in
> a later patch but I'd rather not have this block this patch series. We
> can always revisit this in a separate patch series which can take as
> long as we want.

I should be able to provide all the details later today or tomorrow,
together with the proposed fix.  Perhaps such a timeline should be
acceptable, by not introducing some significant delays.
