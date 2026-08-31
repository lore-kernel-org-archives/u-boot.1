Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC253C624A4
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 14:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 605E240580;
	Mon, 31 Aug 2026 14:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sIHn5EVC5_PO; Mon, 31 Aug 2026 14:31:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788186668;
	bh=FNmDi7zPnoSucNOIeVwy6x4MRpr4yc0VkGmHzGtSaBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vt24heT2cm7CFUT8hA79+OD218fyZSo2Ln/2sK6WwhYL9cPIvfEv1z1IMAnXYKTOQ
	 gPNI9TXkIn6gPMOBoqLe7lwVFt68ZWw2svhDZxZBPkIlYAWaFKshGC8CiEMTsfoCsI
	 Q1gy7JmupaH4RQqK4nKoLOU02s4FeOMlEwuef8iTfeGSGuIRumtH2j65N+eF9OOa0s
	 N5/Zm7RskhLStRIw/TtUqpeb44wmKg3nisTNf/SJY9lhkUbs7txgyOEoye1PSLD64o
	 JoFBV2knmeRuog8u5wMNCalMEhB9yrvPICzvON0C2qjG6mFYbNLs9OiBaC/PodiVxY
	 4Deu5wDKgUN1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BF3E40581;
	Mon, 31 Aug 2026 14:31:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D6A3323E
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C85FD8086C
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:31:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id To8501EtuceH for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 14:31:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=rW8LTuUl; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=o+C/e6qt
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A735F80820
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:31:04 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hYWd25vd5zKmK5;
 Mon, 31 Aug 2026 16:31:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788186662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNmDi7zPnoSucNOIeVwy6x4MRpr4yc0VkGmHzGtSaBI=;
 b=rW8LTuUlSIhyizd6pRYClqrBZ8AIzcCDX3ITcq5lS2YiQazP/498UbA7aczeaV9LZX63Ez
 tV/Xr3CNHMqXtyNgS6gBX89frjZPDJHVe625LDVpIfP2CKYVjQT4hjkcZyB7GhYRLYE0wd
 rLMHBO/37WV5RnDw2ffe/PgWzwBGv0oKAraKnzfVUmS3L2dXOLkWpcds6VNVJpeqTZYMFE
 VIFGIxjnG/HMHeIxbBWkFXiokNHWHwuuq3kuqkoi+EDz6hyZeDxLy+/MaLONAhXVEUjCHh
 MVkgc4kp3c7t/fNvQIZ7Al9OPPNfwMavNxHhRZoCuT9laugJYWYrOHnnuZIqhA==
Message-ID: <a22674a2-eff8-4f4d-981d-8acff390a528@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788186660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNmDi7zPnoSucNOIeVwy6x4MRpr4yc0VkGmHzGtSaBI=;
 b=o+C/e6qt7MYnH5TYyxP1G8KiphtSkB4zz9umNN6BNUWiIlQlz895l6zIo6Gh+QVV/b1HVC
 aFuYQaZc55mIgwqRyrr7tUral4gqF+UiOrOCf3H+Q90uepi/M7WMa/3Gopq7C/yK9aaZ2u
 yjogxpHJk+/1uERTQoJ3fQz8h+/E2F1dnTJUvaeJw9c7ukDLDKDdPJOjMdLUzilQ1EnTvq
 AEQCnVhScYQkqGrAxRn889va7s+pgdu93XklO5r6EFY1q47dDVA3U31YvulNhJgu3CQ691
 sSnsXeY6XPuDtxxCv30Dse80OXrd/FEHmnYg6fWcPTgh1Bq3agMFpt05gI8pmQ==
Date: Mon, 31 Aug 2026 16:30:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] Add RITY devicetree preparation support
To: Carlo Caione <ccaione@baylibre.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?= <Ramax.Lo@mediatek.com>
References: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
 <CALeDE9O3Taz2Q-NgEM4Prjn_Q=z6mXduMR7y_iSvwgBR6yKGXw@mail.gmail.com>
 <DL2BE0LQPFRK.1IXQLUXGFDKAW@baylibre.com>
 <3aa3d789-3cfc-4913-9003-9a9d8dc81647@mailbox.org>
 <CALeDE9MPBAt4P3Dw9oE-eEF_UjSWUprFG_ipic8SwjwTAb0Ubw@mail.gmail.com>
 <DL2YUFG39FD4.1MPXRK4G8ZGQR@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DL2YUFG39FD4.1MPXRK4G8ZGQR@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zwcfritjsscdra11m6u13docsts8pxxf
X-MBO-RS-ID: f7746caf5fcb2bcb9e6
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/31/26 9:54 AM, Carlo Caione wrote:
> On Sun Aug 30, 2026 at 10:54 PM CEST, Peter Robinson wrote:
>> On Sun, 30 Aug 2026 at 21:47, Marek Vasut <marek.vasut@mailbox.org> wrote:
> 
> [...]
>>>>>> RITY images select a base devicetree and an ordered list of overlays
>>>>>
>>>>> What's an RITY image?
>>>>
>>>> Fair enough. Since this is all MediaTek-specific code, I took the term
>>>> for granted, sorry about that. Anyway, RITY is MediaTek’s Genio IoT
>>>> Yocto SDK. By a "RITY image", I mean a boot image produced by that SDK.
>>>
>>> Can this instead use fitImage core code which can already apply DTOs on
>>> top of base DT ?
>>
>> Or boot using UEFI and be generic, deal with the DT overlays with
>> standard U-Boot mechanisms.
> 
> Hi Marek, hi Peter,
> 
> In principle, yes, we could use FIT core, or the EFI bootmeth together
> with the extension-board framework, to implement parts of this. The
> problem is that neither currently covers the complete interface we need
> (and we are using).

Can you extend the existing code instead of adding yet another 
incomplete parallel implementation of it ?

> The RITY boot contract supports (among other things):
> 
> - selecting the base DTB and an ordered overlay list at runtime through
>    the environment

This is scriptable , see loaddtos/loaddtoscustom in 
https://github.com/dh-electronics/meta-dhsom-imx-bsp/blob/main/recipes-bsp/u-boot/files/dh-imx-dhsom/boot.cmd 
.

> - loading those files from either block-backed filesystems or UBI/UBIFS

You can load fitImage from wherever you want.

> - accepting both raw DT files and individually signed FIT-wrapped DT
>    files

See above.

> - preparing the same resulting DT for both the normal EFI boot path and
>    the legacy boot path

See 'fdt apply' in the script above.

> - allowing Genio tooling, in particular genio-flash --load-dtbo, to
>    modify the overlay selection without rebuilding the image (important)

See mkimage -F parameter.

> Now, the core problem is that using FIT core for the complete operation
> would require changing the image producer and on-media format so that
> the selected DTB and overlays are represented by a FIT configuration.
> The EFI payload would still be discovered independently.

You could pull both images and configurations out of fitImage , look at 
imxtract .

> Also the EFI extension-board support is useful for automatically
> detected hardware, but it does not currently consume the
> user-configurable ordered overlay list, cover the UBI/UBIFS and legacy
> boot cases, or handle the individually signed DT files.
> 
> One of our objectives is to allow existing RITY users to replace the
> vendor U-Boot with upstream U-Boot without also changing their images,
> tooling and environment interface.

I think this is the main reason, because all the rest can be solved with 
already in-tree content.

> Changing the RITY interface and
> image layout would prevent that kind of drop-in transition, and it is
> something we would prefer to avoid (at least at this stage). This is why
> we are proposing the functionality as a platform-specific
> well-compartmentalized command.

Non-generic goop like that makes maintenance harder. Can you instead 
introduce some adaptation layer/tool which would convert images back and 
forth ?

> If preserving that existing contract is not considered sufficient
> justification for platform-specific code, please let me know. In that
> case we will need to reconsider the approach and find another way
> forward (still unclear which :)
It would be much better to reuse existing generic well tested code than 
introduce ad-hoc new special-case for specific SoC.
