Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C546CC87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 08:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCDEF83253;
	Wed, 13 Aug 2025 10:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AF6583290; Wed, 13 Aug 2025 10:50:54 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4402483236
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 10:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wangruikang@iscas.ac.cn
Received: from [192.168.0.107] (unknown [114.241.87.235])
 by APP-01 (Coremail) with SMTP id qwCowAAHMKTkUZxoYrdNCw--.46237S2;
 Wed, 13 Aug 2025 16:50:44 +0800 (CST)
Message-ID: <aeeacdc2-9b61-4129-be49-823680278df4@iscas.ac.cn>
Date: Wed, 13 Aug 2025 16:50:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: riscv: v2025.10-rc2 fails on QEMU with "Failed to reserve memory
 for fdt"
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de
References: <8397369a-9b0b-4798-9c30-3a81165657d6@iscas.ac.cn>
 <CADg8p94SHLtb3OcNN4KxppLgLzQc_J5SZMfuvz7n3sM051wztw@mail.gmail.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <CADg8p94SHLtb3OcNN4KxppLgLzQc_J5SZMfuvz7n3sM051wztw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: qwCowAAHMKTkUZxoYrdNCw--.46237S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy3uF17CrykurykAF13Arb_yoW8JFWrpa
 yxJw1SgF1kAr48Gwn2qw4vvFySqr4rKry5uryvgrW8Zr98XF1Iya1Yqw47Cay5CrZ7tr1j
 vFs2va4UZa4Du3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyjb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
 s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
 1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
 JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
 1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
 cSsGvfC2KfnxnUUI43ZEXa7IU8v_M3UUUUU==
X-Originating-IP: [114.241.87.235]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Mailman-Approved-At: Wed, 13 Aug 2025 10:55:17 +0200
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

Hi Sughosh,

On 8/13/25 15:58, Sughosh Ganu wrote:
> On Tue, 12 Aug 2025 at 20:47, Vivian Wang <wangruikang@iscas.ac.cn> wrote:
>> [...]
>>
>> Retrieving file: /Image
>> Moving Image from 0x84000000 to 0x80200000, end=0x81e88000
>> ## Flattened Device Tree blob at bee8f640
>>   Booting using the fdt blob at 0xbee8f640
>> Working FDT set to bee8f640
>> Failed to reserve memory for fdt at 0xbee8f640
>> FDT creation failed! hanging...### ERROR ### Please RESET the board ###
> Looks like the FDT is part of the region reserved for U-boot image
> post relocation. That region is marked as no-overwrite, meaning any
> other allocation attempt to the region will fail. Please check the
> relevant log below. The relevant code is in
> boot/image-fdt.c:boot_relocate_fdt(). The code gets exercised because
> fdt_high and initrd_high are being set to all ones. This was working
> in 2025.07 simply because the function call's return value was not
> being checked.

Thanks for the troubleshooting. I confirm that just removing that line
fixes the problem.

TBH I don't understand what the right thing to do here is, especially
whether copying the FDT a second time is the right thing to do here, so
anyone else taking a look is still appreciated. I *think* it should be safe?

Vivian "dramforever" Wang

