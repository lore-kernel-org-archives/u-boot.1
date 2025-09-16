Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B85ECAC597
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 00:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D395281E13;
	Tue, 16 Sep 2025 02:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96B7B82C84; Tue, 16 Sep 2025 02:25:29 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6173680B9B
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 02:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.145])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A38E0B220448;
 Tue, 16 Sep 2025 02:25:24 +0200 (CEST)
Message-ID: <3caf66ce-f9f4-4072-9a31-3d67f392c37f@freeshell.de>
Date: Mon, 15 Sep 2025 17:25:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: qemu: Remove fdt_high default
To: Tom Rini <trini@konsulko.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20250915-qemu-riscv-remove-fdt-high-v1-1-661178447396@iscas.ac.cn>
 <20250915143227.GJ124814@bill-the-cat>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250915143227.GJ124814@bill-the-cat>
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

Hi Tom,  Add CC: Heinrich

On 9/15/25 07:32, Tom Rini wrote:
> On Mon, Sep 15, 2025 at 07:45:49AM +0800, Vivian Wang wrote:
> 
>> Setting fdt_high to all ones is discouraged and does not appear to be
>> useful for RISC-V QEMU. Moreover, it causes a boot failure when the FDT
>> generated internally by QEMU is used while booting. Remove it to allow
>> U-Boot to pick a suitable address and relocate the FDT.
>>
>> Closes: https://lore.kernel.org/u-boot/8397369a-9b0b-4798-9c30-3a81165657d6@iscas.ac.cn
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> 

> I'm very glad to see this finally and would like to see the rest of the
> RISC-V platforms follow and do the same now.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 

When you say you would like the rest of the RISC-V platforms (to) follow
and do the same;  What do you mean?  Heinrich and I were trying to
figure this out off of something you said on IRC awhile back. I was
taking a guess it was the qemu config (and this patch makes sense to me
so I think that's part of it), but what else? Is that a reference to
sifive-unleashed config fragment, are there others?

If you give us a detailed hint what we should be looking at it would go
a long way and we can test / figure out the rest. Is initrd_high
all-ones on your radar too?

Thanks,

-E Shattow
