Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9700606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FXRCHFA7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y19RqESS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05683608B7;
	Thu, 22 Oct 2026 11:48:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CvvLG--0HFoD; Thu, 22 Oct 2026 11:48:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A5BB60888
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792669710;
	b=CgUudQvRVvTxKV7DmqtNP8yhc3gAGiHlR5d+ZToIs3COzx7Zf59VgFocsfmj46u+7qFP
	 clvEsTvWzfFERpGzHc2LyPlCZC0VEYmQGpqb9gUzKfYTz7ESP1jYoF4xb7x+Os7JI0xXI
	 tXvaXdof+HybCkwnPVhCj2U7lfmdLBayf7rKGut0mh8EUN2q/vmG/OoAAdoCtRNDU0P6z
	 xH9DPsr+CR5DkObSgHquPxtGT5inoo0takjCEACOh2W+NIfPnoSRYPwmi8ysAp2Laqgkj
	 D+o4UvSYa3U1wqG0skHDRegY5oVldTiCIVtlP5q7WF2ycmjuUouYdDeS2lCNtvXGmoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792669710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=43iDUP/ehakshscvbSp1p/v34LsbUY5b31X9OZIxFJs=;
	b=ITxxIF4Rwcps9l96kgr9ssYYJ7fgb62YCQf8dZw1r9xwrbPky2KmbTBJyGAjACp+bzZC
	 S+YW+sFqT05FHXh7oQPCTAu0zwG1NvUy5Z9MSP9S1P8nTFj81bqeGbsUUNOJzgGjz6ZVa
	 VBwq1UFNB3/vllH8IsSt2qUyEwNahvnNsmj8WLWTez39H+zpX0g9ziv4vq+O0q14V4era
	 T20ymiVB5b/7I+ejAymuEBvujixPg9ilBnCEYFgvw4Z9ApRPlQSZ+MdkAKq5kGE934/C5
	 fWZ5WZcOpN/A1qtHh/afClOSpvanIXW9pvs9eGQtspiOWJBLzeJgcRZFSyBLrmgNAnw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792669710;
	bh=43iDUP/ehakshscvbSp1p/v34LsbUY5b31X9OZIxFJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FXRCHFA7eu0tqVV7NpC7acFfxGZhwTvoyKM5mfet/4dCu7wLie2f58FwA7lqVut5J
	 0QGUMnicAbz2X+/iNfFD5oFtTSKt1CoANr3Kj4QyUDrtqcZy8m9VfI1a1eNNztMIRz
	 WVmypJyMbuYX4LaEJWAoiBNeUy3TUDtbSzFsIZcitSfJMj8d5bqA/DCNKBpqHD/Syp
	 DTwMSHXyk9X6MCJcVn2G/WeIP2PNHaJumzIPNt/UphaE/nDkob5Z5NqGaVxSnO2Bbj
	 nTokibJdlwDVGRC1AfKdDcDlyWRPSlOvJJH6ksl9YpmHgSFcFV5aFI6gJPfN95cyKS
	 B1RH1F+JG1IJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A5BB60888;
	Thu, 22 Oct 2026 11:48:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 66756371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C73440889
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:48:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UY1wlfRwCkt0 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 11:48:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F24EF40879
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792669708;
 b=jecKsQaDvb4vdl8USKv+wN8mjMDtIDuYC0ZbOlBWKNaidjcjBeD+8Pcor6FiLWAXMoVS
 BJPYaLyQoa1YMXHdmQWlW/NXvwJVahJsIRhyqJ9FkMry7q6eflbiv25gD2JDPeDxMWjDo
 OI5af1c1Ol5IE20iNt1UzTOKjM6BZVpxMKDGWEPTbkxjdyZgucNMpec5yl9tNn+AdaRrJ
 wD0jHbZVE4XICukigfPX+mH1psfjfOuEoP2Rbv0CKJcc5aUlnjEbFOadc/4aKiRvJZW3e
 I6bRkmquUGyrMqFffmfA22S6X2OGhm+LC85MHuLYda0TKrDFbkkwhZ6jMs+GAC9abXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792669708;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=43iDUP/ehakshscvbSp1p/v34LsbUY5b31X9OZIxFJs=;
 b=PSKTABbHkpnaLKdVLanIIn1BEchtp2JcYw5XR86l0BOTzUlpWu/kuOdMnLzjOXWiI/0m
 iS5aStBYPqx70QBNB/c2M990DxUSZZdYlsk65j/YESjtNl5Zro4Bbt9GgjyhFj1VUlTYg
 D4m6Gglcm8U+dncd6EjgT2a6ETFVTi2P3KKVXlxordUt/RbStKSA4BjgsTD/HG59HhE60
 ri0An59AB0BE3pybLGQqIUMCk1EGPyBhQ+Rky3mxyn9P2t1p2Y1hZzScv2JZRqPGjB+ud
 X1dSFFumc1CpfGLqO5CTx04JkEmSS9HnqE0FWSScDrquQPQnYuSgPS5UJ2muSVNuQ7w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=Y19RqESS; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=Y19RqESS
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id F24EF40879
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:48:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE4D32C41;
 Thu, 22 Oct 2026 04:48:21 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 0CFEC3F673; Thu, 22 Oct 2026 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792669705; bh=2hjsRydWMrhkpsEuOymXhsr9C/uiWcGNyEBrVRvx+Mo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Y19RqESSjzTWi2ssRfZ/mDHTSRHyyPk+kUmkuhQPrbsfh/pZIic6zOxvph1F4wnhn
 eBSWlYtSKjgtnroC8fDPO2jT5ljAV+D7h/omGRw4jFB+18UJ++XqDO3yeVc1lgA3eN
 YZhHPzMDl0FPj7sMVgqYE20geZshvmBvBH+n6sg4=
Message-ID: <175a7f33-a567-4c6f-b509-3b796e09f879@arm.com>
Date: Thu, 22 Oct 2026 12:48:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] sunxi: Add Orange Pi 3 LTS support
To: filipescu.cristian@gmail.com, u-boot@lists.u-boot-project.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>
References: <20261022-sunxi-orangepi-3-lts-v2-0-46b9df5f9e43@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261022-sunxi-orangepi-3-lts-v2-0-46b9df5f9e43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cristian,

please try to avoid unsolicited new version posts, in particular shortly 
after the previous version.
It's not like maintainers and reviewers twiddling their thumbs waiting 
for new patches, so please give everybody enough time to have a look. 
I'd say a few days at least.
If you find issues in your own patches, please reply on the list, 
pointing this out. And then still wait for proper reviews before reposting.

On 10/22/26 07:55, Cristian Filipescu via B4 Relay wrote:
> Add a device tree and a separate defconfig for the Orange Pi 3 LTS. The
> LTS has an H6, 2 GiB LPDDR3, 8 GiB eMMC and a Motorcomm YT8531C Ethernet
> PHY, with power and reset wiring different from the original Orange Pi 3.
> 
> The device tree is based on Jernej Skrabec's Linux submission:
> https://lore.kernel.org/linux-sunxi/20250413134318.66681-3-jernej.skrabec@gmail.com/

Which had comments, so have those been addressed?
> It lives under arch/arm/dts until the board description is merged into

Please don't do this. If there is a mainline DTS pending, move that into 
dts/upstream anyway, that way we don't have two versions of patches to 
deal with. We don't take non-mainline DTs anyway, so the support has to 
wait until the .dts ended up in a tagged mainline Linux release, then we 
can cherry-pick that DT patch. Compare U-Boot commit 4112b26537cf04 for 
an example.
For the sake of getting the (defconfig) patch out, and allow people to 
play with that, it's fine to post, but in a setup that matches the final 
submission.

> Linux and reaches dts/upstream. The current dts/upstream H6 SoC and OPP
> includes are reused. The original authorship and sign-off are retained.
> 
> Clock naming, regulator supply chaining and BLDO3 always-on corrections
> from the earlier review are included. Ethernet uses the Motorcomm driver
> with rgmii-id, zero MAC delays and explicit 1950 ps RX/TX PHY delays, as
> proposed during the Linux review. This configuration has been tested on
> the board with DHCP and ICMP.

That level of detail here and below smells like an LLM having been 
unleashed. I don't think it's necessary wasting people's time with 
details that are also shown in the diff.
If there is something surprising, it's worth mentioning here, but in 
general I would expect a simple defconfig and .dts post to not cause 
much problems.

Cheers,
Andre

> Validation (including the earlier board build):
> - Cross-build the revised orangepi_3_lts_defconfig with GCC 14.2.0 and
>    TF-A v2.13.0 (sun50i_h6, DEBUG=1). Cross-build the original
>    orangepi_3_defconfig too; its handoff hook remains an empty return.
> - Verify the LTS DT model, Ethernet configuration and final combined FIT.
> - Match the new defconfig to savedefconfig output.
> - Check both patches with checkpatch.pl --strict, excluding only the
>    FILE_PATH_CHANGES warning: board/sunxi/MAINTAINERS is updated, but
>    checkpatch recognises only a top-level MAINTAINERS change.
> 
> The GPIO LEDs are enabled in main U-Boot, with green PL7 on and red
> PL4 off. The early SPL LED is disabled. At the OS handoff immediately
> after "Starting kernel ...", the LTS-specific board_quiesce_devices()
> hook switches green off and red on. Linux's LED defaults retain those
> states; diagnostic userspace clears both before starting the shell.
> Cristian confirmed this sequence on the corrected 60d788d7056c build:
> green in main U-Boot, red at the kernel handoff, both off in the shell.
> 
> On-board testing of the pre-LED-change U-Boot 2026.10-gc8f95275fc8f:
> - Reaches the console and reports 2 GiB RAM.
> - Enumerates SD at 50 MHz/4-bit and eMMC at 52 MHz/8-bit.
> - Obtains a DHCP lease and pings two LAN hosts successfully. The control
>    device tree confirms phy-mode = "rgmii-id".
> - Enumerates EHCI, OHCI and XHCI root hubs. External USB peripherals have
>    not been tested.
> 
> The submitted v1 (11d60b7149e6) also loaded a mainline Linux Image, DTB
> and initramfs from SD and reached a RAM shell with four CPUs and 2 GiB
> RAM. Its test-kernel configuration caused a PMIC I2C failure; Linux
> peripheral validation remained pending in that first test.
> 
> The v2 build (f5a667df5ada) now boots Linux with CONFIG_MODULES=y into
> the RAM shell. Linux initializes the AXP806, enumerates SD and eMMC,
> registers eth0 and all USB host root hubs. The YT8531 PHY links at
> 1 Gbps/full duplex; DHCP, DNS and an IPv6 Internet ping passed on that
> build. Two direct 8 MiB reads from each of SD and eMMC compared
> identical under Linux. Two cold starts with LED, shell and Ethernet
> checks were confirmed on the final build. Both LEDs were confirmed off
> in the diagnostic shell. Sustained transfer, external USB peripherals
> and HDMI remain untested.
> The local test builds omit optional Crust firmware; suspend is not tested.
> 
> Signed-off-by: Cristian Filipescu <filipescu.cristian@gmail.com>
> ---
> Changes in v2:
> - Enable GPIO LEDs in main U-Boot; drop early SPL status activation.
> - Add board-specific U-Boot DT overrides: green on, red off.
> - Set shared Linux defaults to retain green off and red on.
> - Switch green off and red on in the LTS OS handoff hook at Starting kernel.
> - Retain the original two-patch DTS/defconfig series structure.
> - Link to v1: https://patch.msgid.link/20261021-sunxi-orangepi-3-lts-v1-0-19a3df928d8e@gmail.com
> 
> To: u-boot@lists.u-boot-project.org
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Cristian Filipescu <filipescu.cristian@gmail.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> ---
> Cristian Filipescu (1):
>        sunxi: Add Orange Pi 3 LTS defconfig
> 
> Jernej Skrabec (1):
>        arm: dts: sunxi: Add Orange Pi 3 LTS device tree
> 
>   arch/arm/dts/Makefile                             |   1 +
>   arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi |  11 +
>   arch/arm/dts/sun50i-h6-orangepi-3-lts.dts         | 362 ++++++++++++++++++++++
>   board/sunxi/MAINTAINERS                           |   7 +
>   board/sunxi/board.c                               |  19 ++
>   configs/orangepi_3_lts_defconfig                  |  19 ++
>   6 files changed, 419 insertions(+)
> ---
> base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
> change-id: 20261021-sunxi-orangepi-3-lts-2fa76de6f361
> 
> Best regards,
> --
> Cristian Filipescu <filipescu.cristian@gmail.com>

