Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE076E7B608
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0924E87522;
	Wed,  4 Oct 2023 14:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l27YaV92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5954687505; Wed,  4 Oct 2023 14:39:35 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2960287531
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id AD97BB81DE1;
 Wed,  4 Oct 2023 12:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA20C433C7;
 Wed,  4 Oct 2023 12:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696423168;
 bh=rJOV6o8fwPrbjDUGSFsJ7jmJEUlBTEPwToORv23IIzo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=l27YaV92nKg6u+qzOXsaw6nv8RJPaQCnrwWma01mRBWJkp7Z96SK4gd8eauEDPTKY
 ROuunl0ptE2EAd8kfaorkul8KExcs+PCGDu7jurAj3JWGQfRrBgeKav2cGkIL6IPdt
 jzGhcaGkV+jESqamovq1JvnN9JDb8yQG9Qrud3yfd2oMLkRfhfhdbKpwDkB6vsp0NK
 fNLklAmN4lSb96RVh/xTb4kLiLp3OQsZ32EiBFusDf7q9bibcAgFxEMBzDESF0ApDD
 X3UuPlQhHTZ+rQ2Mu1FXgkmdV3iC2cUGCBD7NlOZxKOFwozE0TL05ADf3k9FTZW4Uk
 gDhY6071HfiKQ==
Message-ID: <263918be-381e-44b6-899e-321ecaabb2bc@kernel.org>
Date: Wed, 4 Oct 2023 15:39:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] board: ti: am65x: Move to using Extension
 framework
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>
Cc: vigneshr@ti.com, trini@konsulko.com, srk@ti.com, robertcnelson@gmail.com, 
 u-boot@lists.denx.de, "Francis, Neha" <n-francis@ti.com>,
 kory.maincent@bootlin.com
References: <20230710145026.128481-1-rogerq@kernel.org>
 <20230710145026.128481-3-rogerq@kernel.org>
 <CAPnjgZ1odo6F7RTumJ6A=+kgZ-pm0JnRvxNYB00HX7YpAyrFXg@mail.gmail.com>
 <574c8eb0-4c19-72ef-5920-e506e4be6203@kernel.org>
 <20230713184438.y3ac7c425fwu575b@radiantly>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230713184438.y3ac7c425fwu575b@radiantly>
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

Hi,

On 13/07/2023 21:44, Nishanth Menon wrote:
> On 15:29-20230711, Roger Quadros wrote:
>> Hi Simon,
>>
>> On 10/07/2023 22:45, Simon Glass wrote:
>>> Hi Roger,
>>>
>>> On Mon, 10 Jul 2023 at 08:51, Roger Quadros <rogerq@kernel.org> wrote:
>>>>
>>>> Support the Expansion cards via Extension framework.
>>>> This should make 'expansion' command work to scan
>>>> for expansion cards and apply DT overlays.
>>>>
>>>> Card detection code is moved to a library so
>>>> other boards can benefit from it.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>> ---
>>>>  board/ti/am65x/evm.c               | 264 ++++++++---------------------
>>>>  board/ti/common/Kconfig            |   8 +
>>>>  board/ti/common/Makefile           |   1 +
>>>>  board/ti/common/ti_card_detect.c   | 155 +++++++++++++++++
>>>>  board/ti/common/ti_card_detect.h   |  43 +++++
>>>>  configs/am65x_evm_a53_defconfig    |   2 +
>>>>  configs/am65x_hs_evm_a53_defconfig |   2 +
>>>>  7 files changed, 280 insertions(+), 195 deletions(-)
>>>>  create mode 100644 board/ti/common/ti_card_detect.c
>>>>  create mode 100644 board/ti/common/ti_card_detect.h
>>>
>>> Before this goes too far I think this should move to using a linker
>>> list to declare the driver (or a driver-model driver if you prefer,
>>> but that might be overkill).

So I've been working on this on the side and got linker list way working
with custom script booting but as soon as I move to standard boot flow
it no longer works. This is because there is no code in place to
apply the overlay and pass it to next stage e.g. EFI.

I see the following note at
https://elixir.bootlin.com/u-boot/latest/source/boot/bootmeth_efi.c#L304

"
                /*
                 * TODO: Apply extension overlay
                 *
                 * Here we need to load and apply the extension overlay. This is
                 * not implemented. See do_extension_apply(). The extension
                 * stuff needs an implementation in boot/extension.c so it is
                 * separate from the command code. Really the extension stuff
                 * should use the device tree and a uclass / driver interface
                 * rather than implementing its own list
                 */
"

Another note at
https://elixir.bootlin.com/u-boot/latest/source/cmd/extension_board.c#L198

"/* extensions should have a uclass - for now we use UCLASS_SIMPLE_BUS uclass */"

So are we better off implementing a class driver for extension stuff?

Once that is in place how should extension apply work?
Current implementation relies on a extension_overlay_cmd environment
to be specified.
e.g. for EFI boot case, the overlay files should be obtained in the same
way we get the base device tree i.e. bootmeth_common_read_file()?

-- 
cheers,
-roger
