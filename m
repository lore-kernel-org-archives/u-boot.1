Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B47C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 17:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 792D783249;
	Wed, 16 Jul 2025 19:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7DB983242; Wed, 16 Jul 2025 18:23:26 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E14B830B5
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 18:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [143.105.119.108])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 993D8B4D16BD;
 Wed, 16 Jul 2025 18:23:16 +0200 (CEST)
Message-ID: <c841ac9b-809c-41d3-92e9-f143cfde6d5b@freeshell.de>
Date: Wed, 16 Jul 2025 09:23:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Update riscv's SYS_BOOTM_LEN to the most commonly
 used value.
To: Martin Herren <sputnik@on-the-web.ch>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 Andreas Schwab <schwab@suse.de>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Bin Meng <bmeng.cn@gmail.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Green Wan <green.wan@sifive.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rick Chen <rick@andestech.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yao Zi <ziyao@disroot.org>, Yixun Lan <dlan@gentoo.org>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>
References: <20250714133345.128853-1-sputnik@on-the-web.ch>
 <9529db2f-ff07-448e-99b4-65dde605b0ec@amd.com>
 <b3f95ac9-a847-450b-9d5a-64af5e84a47e@freeshell.de>
 <vYg4IlDYamca-5F-VHVhUe0syuQhVE3qrEpgug3uvTZas8gzrXpE4YX-H63dA9ISHVebukojmJUigxf9EaSWx-lmzGGSdeV_SLSMXuNa62Q=@on-the-web.ch>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <vYg4IlDYamca-5F-VHVhUe0syuQhVE3qrEpgug3uvTZas8gzrXpE4YX-H63dA9ISHVebukojmJUigxf9EaSWx-lmzGGSdeV_SLSMXuNa62Q=@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 16 Jul 2025 19:00:28 +0200
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



On 7/16/25 03:11, Martin Herren wrote:
> Hej all,
> 
> On Wednesday, July 16th, 2025 at 3:35 AM, E Shattow <e@freeshell.de> wrote:
>>
> 
>>
> 
>> Is there some reason for the value from documentation about the
>> architecture? Or is it arbitrary?
>>
> 
>> I don't really see the sense in a default value which is simply popular
>> but not founded in an architectural reasoning.
>>
> 
>> The values do not change often (ever?) so I miss why there is any
>> default at all.
>>
> 
>> -E
> 
> No, there is no documentation justifying this value. My reasoning was the reverse, there is no justification either that this default value should be almost an order of magnitude lower than ARM64 as typically generated RISCV code size is similar and thus the typical kernel size as well.
> 
> This is reflected in the most commonly used value in the existing riscv defconfigs as well as other boards not yet mainlined into u-boot.
> 
> With a lower value, typical kernels generated from Yocto or others are too big to be able to be booted.
> 
> In my idea the default value, when provided, should reflect the most common use case which can then be overridden if wanted.
> 
> I understand it was a very bold move on my side as a first submission to challenge a default value and touch over 30 boards, so i won't be offended if this is not accepted. The learning experience on just submitting a patch here and learning about patman and co is already a success for me.
> 
> Still I consider the proposed new default as sane and maybe more future oriented for new boards to come.
> 
> Cheers,
> 
> Martin

My concern is to not-find what I am looking for where I am looking for
it and then hunt around to determine where this value comes from. A
default ceases to be a default when there are more than a few
exceptions, as it then becomes an obfuscation.

I do tend to complain when the code base becomes clever for the sake of
being clever, and defer to actual programmers however... all else being
the same (it compiles the same?) go with what you think is most
maintainable and readable.

-E
