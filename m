Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF90CAC5A5
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 22:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F27283335;
	Wed, 24 Sep 2025 00:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95F2C833E9; Wed, 24 Sep 2025 00:21:20 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CDB0808AF
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 00:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.228])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id BCBA1B22008E;
 Wed, 24 Sep 2025 00:21:16 +0200 (CEST)
Message-ID: <5c574f7e-1765-4cc1-9580-a9cdc890c764@freeshell.de>
Date: Tue, 23 Sep 2025 15:21:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: Update mentions of README.fdt-control
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchart <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20250917011720.1148189-1-e@freeshell.de>
 <f1694902-6b69-48e9-aae6-1f0801c72a21@cherry.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <f1694902-6b69-48e9-aae6-1f0801c72a21@cherry.de>
Content-Type: text/plain; charset=UTF-8
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



On 9/23/25 05:14, Quentin Schulz wrote:
> Hi E,
> 
> On 9/17/25 3:17 AM, E Shattow wrote:
>> Update documents 'README.fdt-control' reference to replacement
>> 'control.rst':
>>    doc/arch/nios2.rst
>>    dts/Makefile
>>
>> Also convert some adjacent pathname mentions to rST links where
>> applicable
>>
>> Fixes: 3e9fddfc4f14 "doc: Move devicetree control doc to rST"
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>   doc/arch/nios2.rst                    | 2 +-
>>   doc/develop/devicetree/control.rst    | 3 ++-
>>   doc/develop/driver-model/design.rst   | 1 +
>>   doc/develop/driver-model/ethernet.rst | 2 +-
>>   doc/develop/spl.rst                   | 2 +-
>>   doc/usage/fdt_overlays.rst            | 1 +
>>   doc/usage/fit/overlay-fdt-boot.rst    | 2 +-
>>   dts/Makefile                          | 2 +-
>>   8 files changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/doc/arch/nios2.rst b/doc/arch/nios2.rst
>> index 34a75e7fb00..58f63c996b6 100644
>> --- a/doc/arch/nios2.rst
>> +++ b/doc/arch/nios2.rst
>> @@ -13,7 +13,7 @@ Please refer to the link for Linux port and toolchains:
>>   http://rocketboards.org/foswiki/view/Documentation/
>> NiosIILinuxUserManual
>>     The Nios II port of u-boot is controlled by device tree. Please check
>> -out doc/README.fdt-control.
>> +out :ref:`devicetree_control`.
> 
> If you're not pointing at a specific section in the document, maybe
> use :doc:[1] instead of :ref:, in which case you wouldn't need to add
> labels at the top of each file?
> 
> What do you think?
> 
> [1] https://www.sphinx-doc.org/en/master/usage/referencing.html#role-doc
> 
> Cheers,
> Quentin

Yes, will use doc instead of ref. Thanks!

-E
