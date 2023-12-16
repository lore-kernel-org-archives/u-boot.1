Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA28AC46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 19:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4939D87BDB;
	Sat, 16 Dec 2023 20:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JHKh2rPK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D4387BF2; Sat, 16 Dec 2023 20:27:12 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBB3B87A7F
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 20:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [172.25.0.170] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 44566413C5; 
 Sat, 16 Dec 2023 19:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702754828;
 bh=xIcqcIeG4fmmaKuB3Iv+tY89zLStJQkuEvWqYbBbM+U=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=JHKh2rPKlVVr97qb18oR5CLSX8XkciMXc0qv5XRs0ZYkxhYkC51gcdmfUBE2K+Mxi
 MJ7JG256kBtpDOwUOmTfBAgf1JH7vsVIdZTcsGvGOEgVPanPiPPQU09eI3k/y8Kyug
 Woi8zk9ZXyjKzSH9pG979pU501HwoasKOaQSU073DDA0mIQzvjidklOf+D8G7jk2HU
 6u0e6U7XJJJS+C4K+Lz8/oUYMuhob65lEs0rKpeu06vieWYoFE4NmuoH0q0Nx9FNqf
 IxUAno+oZmC0Jc3fJeGLuOhYLRfQISJecH2dCXyeA6rflhz1IaiVM5tilnD8yH+wjO
 wL0GQX8gHf3WQ==
Message-ID: <3dd6f971-0c2b-402f-b6ca-0821f8cccfa3@canonical.com>
Date: Sat, 16 Dec 2023 20:27:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] configs: qemu: add config fragment for ACPI
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
 <20231215133245.7923-9-heinrich.schuchardt@canonical.com>
 <CAPnjgZ2C45f_WhDQz5TKk_THVh5HZ8t6PzozKZ1ROF4r16Cw8Q@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ2C45f_WhDQz5TKk_THVh5HZ8t6PzozKZ1ROF4r16Cw8Q@mail.gmail.com>
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

On 12/16/23 19:46, Simon Glass wrote:
> On Fri, 15 Dec 2023 at 06:33, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Provide a configuration fragment to enable ACPI on QEMU.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>> v2:
>>          no change
>> ---
>>   MAINTAINERS                         |  1 +
>>   board/emulation/configs/acpi.config |  3 +++
>>   doc/board/emulation/acpi.rst        | 23 +++++++++++++++++++++++
>>   doc/board/emulation/index.rst       |  1 +
>>   4 files changed, 28 insertions(+)
>>   create mode 100644 board/emulation/configs/acpi.config
>>   create mode 100644 doc/board/emulation/acpi.rst
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Are you planning to enable binman to build configurations with config 
fragments? This would be needed for testing in CI.

Best regards

Heinrich
