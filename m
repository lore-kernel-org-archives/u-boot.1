Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C3EC79F8C
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 13:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 968A940607;
	Sun,  6 Sep 2026 13:44:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mons6Cru0D6C; Sun,  6 Sep 2026 13:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4CADE405DE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788702244;
	b=OUtUXR0fq0PqWo8sm0RH78qGcHN+Kgrtp+GgiR4pt/jKpsJzA4GwkTWIPC1vZh6WkGk2
	 /Jsjkq9NOjtymc6iQDowXHOAGVDgVUijXKZoKVjLDXbRqXvMs9wR3tlUdX4OPOLv78hZP
	 xt+Ri3S4SHERI23YY5/2PiM7BYTZn7Y7YN+Ri9NS0DOPOvMbVGLu3Jiu8Z63Q9wjuHKHl
	 6nBpJfjmKXHZJ9aiB5GZgwLNnqbusXPNiFl08MOySt/UfjMtVNI+8DpRKXE8uBuJKxDDV
	 0TL4haQ9ZDBg29LofNDozQsv67BLq3SnyrMDJBr+TCeR2vjVOK1CoT3i5T96KlCbF/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788702244;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SGj/sXlaLZ7VGdHvXM5ufEvP+SKjoBXPUm5RKIhoXi8=;
	b=GrRAang4L6E4GKtDlVRjcq94GAM0x5TycJVXbzcfyyMiLncoN70B54yUs6Ona4DiEaPU
	 70CsNi6kP02dtJ8kBgYk41fAedEjPX5GG6mbBzRZdAE7lbMdvkjjzZQ852v9WBYD/IGUL
	 e4F0Amf9WxLhLEQAt+9Y69lumlPeotDmUrFUEQA3dLV0ZmevvcB/gF7J3ipU71zkJe/5Y
	 qgO5jBCADip/JZm606bTPatOUrrQ+CC7+BxfR4tJ0MYRBpYVup2US4f4wzZDyuQVwdsA0
	 MxEY0w2hDTTUSb8QEKLlfCB/QQjbbUub4jySJUNCz/R5flNTXRQVNTE6h2shSSpJY7Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788702244;
	bh=SGj/sXlaLZ7VGdHvXM5ufEvP+SKjoBXPUm5RKIhoXi8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pe5XW5Enbzr+66UmzJ1O9nh4I4TdsaL7BxM6xpv5a1dpxOfDMbW6TnEd2amrWSzzc
	 ml5lSKPbuZKpDLZBbSCpTmKa7a71/oAAWqcg2f1P4tM1aJ62k2rLPbNwPHRp4cy/9I
	 /2DDnAV1eN4RZTzuxG8pFJcjZ2trMhvaNtzBYuinP4Z6xJ/a7oknO5n8V1TeOHN6MJ
	 uJJ1uKS+mLJ1Z5tg5/vv30NK9Q4ChNJQ5g7w0ADnitCUNpmOqbKQERm63g/sE6w1QO
	 NnXrODfaa8QLl4cl2m5/YPVam/CoYlQojGS4LGpvEnqqlUUsAaBJ9/SjDHt/5uQfV8
	 LWSf+1GIHZDQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CADE405DE;
	Sun,  6 Sep 2026 13:44:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CCAF6118
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 13:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDE7B80D39
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 13:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Luo-rch7I7OH for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 13:44:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1C4BC80D2B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788702241;
 b=HNFlotFBSmDFqaW1pzo55RdqLEa3IdHkpvSW/wcarTVaJ03eKMwoka4kRmp/FNszt6Ho
 lvEJBgU+WuDjOBqqEXSXLGvpvJF9ErA9j5WNkejUyLIEAekBhazbwqhf3uZiOQV2OhJ8z
 MQLjSUJ0hhI6+o6rzwBkSYANtHnuZPjipeK/Mz6KGdnEOueQsXa/MzH+Rll4Vyyrue8uU
 rMN8yG7IeFCHg4j53GsHwdRjHK4x+XYEEblLe2Tp4tQ8N4qRZ+7GoALdVq6LHj1qPRT/a
 GAWDVTcrUO3frCe2V2IdRDv6PtXJArB2qL5r1ivsGGrvZMtP8yRlR+nMhdToK9BzbBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788702241;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=SGj/sXlaLZ7VGdHvXM5ufEvP+SKjoBXPUm5RKIhoXi8=;
 b=ryquoRk1v6NztZVRGj3D4Vw4RiBD2vZHSmRkYclkbslpx5a67bcvlRwackfvxwlLMpRl
 yO2ov1R8Zlf00Z0+7EFBPvetAunVjk4bWQfcqMIhW7UrIW7TnTre7eaw/TxHtvGiDAfxr
 +AN5eRgsuzgnbQQrdCyE52zM+FbjbNnD5pVlWIUS/ldeqAMI6/6teaFJ+lB7Hz6B6gdS+
 QWDsx+WX2MlEmg31/Q1Lgdo4Rhfa1zTMo5t9lRVXKWgKw6iL/CbqpHznjs4WcnXP0oOy9
 N+/9QjD3L+Kz1rkTdT4R3qVitlsvMVpLHa0A1qbqW+2hDUnGhatBi8nn4Nd7FpQ48Uw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=public-files.de; 
 dkim=pass header.d=public-files.de header.i=frank-w@public-files.de
 header.a=rsa-sha256 header.s=s31663417 header.b=LDxeCFIg; 
 arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=frank-w@public-files.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=public-files.de header.i=frank-w@public-files.de
 header.a=rsa-sha256 header.s=s31663417 header.b=LDxeCFIg
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C4BC80D2B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1788702234; x=1789307034; i=frank-w@public-files.de;
 bh=SGj/sXlaLZ7VGdHvXM5ufEvP+SKjoBXPUm5RKIhoXi8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LDxeCFIgo7JEV9UfxDoxl446exDsJ5iOieiET7ERfPpY2OM37j1XyKepfNuFfaEP
 0jDF5UdL3C+wLV4wpYrMTVy2twrhdRhpjgE4psW+S1D9Q1VmLiQJuTTOo1u+nggUx
 FhCDCv/NKye0cK24M32MCR8tMQE2LxLo75K5YtQQNrU8uqcTiqI4LO5CJXFbugXxD
 rbH7QMVjw7LNI5txhf261rUrI6i97vI3RSsvarwgbjCGxhV30Uow33EmeT1sLvmst
 Mr7yVVSY1faPm4PrJkHsrhceaM+frFyOvZlqTpXLtotsBmRJz61giJmr/fKWJ1H7q
 4eoCRwh99/A41MhgxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNtP-1wZKWy46iD-00kOVl; Sun, 06
 Sep 2026 15:43:54 +0200
Message-ID: <ab44823b-6067-4985-948a-e25310f4814a@public-files.de>
Date: Sun, 6 Sep 2026 15:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: mediatek: add BPi-R3 Mini eMMC board support
To: "Lucien.Jheng" <lucienzx159@gmail.com>, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 dlechner@baylibre.com, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, jbx6244@gmail.com, msp@baylibre.com,
 u-boot@lists.u-boot-project.org
Cc: daniel@makrotopia.org, skylake.huang@mediatek.com
References: <20260906120756.8290-1-lucienzx159@gmail.com>
 <4c03ad9a-1314-4cae-b2ff-bbf84a6f4b4e@public-files.de>
 <8461e750-ddac-4079-8d2d-52e285b7eb38@gmail.com>
Content-Language: en-US
From: Frank Wunderlich <frank-w@public-files.de>
In-Reply-To: <8461e750-ddac-4079-8d2d-52e285b7eb38@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lhwhX4lJeNyaHh3RD7f9YEgxXnAUBe8cOxBTjWHbSa190Zaq37C
 ObfZirgdX7ZEI1uQE2ak12ECMa/o/OcNBcboDq8DSArT+aQu6fzUv7l48JNfqCYnf51vefq
 LJfVNoXfIEIgI4Asu3NtVw91Mhr1SJv+3sbMfJ08Z+KK4z3n6CDnnD3YAorLH7JRd8p+Akc
 3wl3+zLPuIKgsXylIwErA==
UI-OutboundReport: notjunk:1;M01:P0:m5/xz1nZ4sQ=;EjG/jZdqV/mgQ+NfWq0YSHROcRM
 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
 tRUu03Iek5PgRZKO8fP6+vxm9caUsouscaHIK8=
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

Am 06.09.26 um 15:10 schrieb Lucien.Jheng:
> Hi Frank
>
> My apologies for not citing your Git repository as the source for the=20
> DTS file.
>
> I'll make sure to attribute you using the 'Co-developed-by' tag. Sorry=
=20
> about the oversight!
>
> I will double-check your commit and what you mentioned about=20
> 'compatible' earlier, and try to make the next commit.=20

Thanks, I hope my comment didn't come across as too harsh. :)

I just copied the mt7986-rfb (and added the phys+regulators), so please=20
crediting the original rfb author (Weijie Gao) too.

> Thank.
>
>>> --- /dev/null
>>> +++ b/configs/mt7986a_bpir3_mini_emmc_defconfig
>>> @@ -0,0 +1,139 @@
>>> +CONFIG_ARM=3Dy
>>> +CONFIG_ARM_SMCCC=3Dy
>>> +CONFIG_SYS_HAS_NONCACHED_MEMORY=3Dy
>>> +CONFIG_POSITION_INDEPENDENT=3Dy
>>> +CONFIG_ARCH_MEDIATEK=3Dy
>>> +CONFIG_TEXT_BASE=3D0x41e00000
>>> +CONFIG_SYS_MALLOC_F_LEN=3D0x4000
>>> +CONFIG_NR_DRAM_BANKS=3D1
>>> +CONFIG_ENV_SIZE=3D0x80000
>>> +CONFIG_ENV_OFFSET=3D0x300000
>>> +CONFIG_DEFAULT_DEVICE_TREE=3D"mt7986a-bpi-r3-mini-emmc"
>>> +CONFIG_TARGET_MT7986=3Dy
>>> +CONFIG_DEBUG_UART_BASE=3D0x11002000
>>> +CONFIG_DEBUG_UART_CLOCK=3D40000000
>>> +CONFIG_SYS_LOAD_ADDR=3D0x46000000
>>> +CONFIG_DEBUG_UART=3Dy
>>> +CONFIG_DEFAULT_FDT_FILE=3D"mt7986a-bpi-r3-mini-emmc"
>>> +CONFIG_LOGLEVEL=3D7
>>> +CONFIG_LOG=3Dy
>>> +CONFIG_SYS_PROMPT=3D"BPI-R3M> "
>>> +CONFIG_SYS_CBSIZE=3D512
>>> +CONFIG_SYS_PBSIZE=3D1049
>>> +# CONFIG_BOOTM_NETBSD is not set
>>> +# CONFIG_BOOTM_PLAN9 is not set
>>> +# CONFIG_BOOTM_RTEMS is not set
>>> +# CONFIG_BOOTM_VXWORKS is not set
>>> +# CONFIG_CMD_ELF is not set
>>> +# CONFIG_CMD_UNLZ4 is not set
>>> +# CONFIG_CMD_UNZIP is not set
>>> +CONFIG_CMD_GPIO=3Dy
>>> +CONFIG_CMD_GPT=3Dy
>>> +CONFIG_CMD_GPT_RENAME=3Dy
>>> +CONFIG_CMD_LSBLK=3Dy
>>> +CONFIG_CMD_MMC=3Dy
>>> +CONFIG_CMD_PART=3Dy
>>> +CONFIG_CMD_READ=3Dy
>>> +CONFIG_CMD_PING=3Dy
>>> +CONFIG_CMD_SMC=3Dy
>>> +CONFIG_CMD_FAT=3Dy
>>> +CONFIG_CMD_EXT4=3Dy
>>> +CONFIG_CMD_FS_GENERIC=3Dy
>>> +CONFIG_PARTITION_TYPE_GUID=3Dy
>>> +CONFIG_ENV_OVERWRITE=3Dy
>>> +CONFIG_ENV_IS_IN_MMC=3Dy
>>> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
>>> +CONFIG_NET_RANDOM_ETHADDR=3Dy
>>> +CONFIG_REGMAP=3Dy
>>> +CONFIG_SYSCON=3Dy
>>> +CONFIG_CLK=3Dy
>>> +CONFIG_MMC_HS200_SUPPORT=3Dy
>>> +CONFIG_MMC_MTK=3Dy
>>> +CONFIG_PHY_FIXED=3Dy
>>> +CONFIG_DM_MDIO=3Dy
>>> +CONFIG_MEDIATEK_ETH=3Dy
>>> +CONFIG_PINCTRL=3Dy
>>> +CONFIG_PINCONF=3Dy
>>> +CONFIG_PINCTRL_MT7986=3Dy
>>> +CONFIG_POWER_DOMAIN=3Dy
>>> +CONFIG_MTK_POWER_DOMAIN=3Dy
>>> +CONFIG_DM_REGULATOR=3Dy
>>> +CONFIG_DM_REGULATOR_FIXED=3Dy
>>> +CONFIG_DM_SERIAL=3Dy
>>> +CONFIG_MTK_SERIAL=3Dy
>>> +CONFIG_FAT_WRITE=3Dy
>>> +CONFIG_HEXDUMP=3Dy
>>> +# CONFIG_EFI_LOADER is not set
>>> +CONFIG_LMB_MAX_REGIONS=3D64
>>> +
>>> +CONFIG_AUTOBOOT=3Dy
>>> +#CONFIG_BOOTDELAY=3D2
>>> +
>>> +CONFIG_FIT=3Dy
>>> +CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=3Dy
>>> +CONFIG_ENV_DEFAULT_ENV_TEXT_FILE=3D"uEnv_r3.txt"

this will not work upstream as this file only exists in my repo and i'm=20
sure upstream will reject this.

you should mention the vars needed for phy function and firmware load=20
(e.g. pointing to your driver

commit with small comment).

same for bootmenu, autoboot and bootdelay.

>>>
>>> +CONFIG_HUSH_PARSER=3Dy
>>> +
>>> +CONFIG_MTD=3Dy
>>> +CONFIG_DM_MTD=3Dy
>>> +CONFIG_MTD_UBI=3Dy
>>> +CONFIG_CMD_UBI=3Dy
>>> +CONFIG_CMD_UBIFS=3Dy
>>> +CONFIG_SPI=3Dy
>>> +CONFIG_DM_SPI=3Dy
>>> +CONFIG_MTD_SPI_NAND=3Dy
>>> +CONFIG_MTK_SPIM=3Dy
>>> +#CONFIG_MTK_SPI_NAND=3Dy
>>> +#CONFIG_MTK_SPI_NAND_MTD=3Dy
>>> +#CONFIG_MTK_SNOR=3Dy
>>> +#CONFIG_MTK_SNFI_SPI=3Dy
>>> +CONFIG_SPI_FLASH=3Dy
>>> +CONFIG_SPI_FLASH_MTD=3Dy
>>> +CONFIG_SPI_FLASH_WINBOND=3Dy
>>> +CONFIG_CMD_MTD=3Dy
>>> +CONFIG_DM_SPI_FLASH=3Dy
>>> +CONFIG_CMD_SF=3Dy
>>> +#CONFIG_MTD_RAW_NAND=3Dy
>>> +#CONFIG_CMD_NAND=3Dy
>>> +#CONFIG_CMD_NAND_TRIMFFS=3Dy
>>> +CONFIG_ENABLE_NAND_NMBM=3Dy
>>> +CONFIG_MTDIDS_DEFAULT=3D"nmbm0=3Dnmbm0"
>>> +CONFIG_MTDPARTS_DEFAULT=3D"nmbm0:1024k(bl2),512k(u-boot-env),2048k(fa=
ctory),2048k(fip),65536k(ubi)"=20
>>>
>>> +CONFIG_PHY=3Dy
>>> +CONFIG_PHY_MTK_TPHY=3Dy
>>> +CONFIG_DM_USB=3Dy
>>> +CONFIG_USB=3Dy
>>> +CONFIG_USB_XHCI_HCD=3Dy
>>> +CONFIG_USB_XHCI_MTK=3Dy
>>> +CONFIG_CMD_USB=3Dy
>>> +CONFIG_USB_STORAGE=3Dy
>>> +CONFIG_CMD_ASKENV=3Dy
>>> +CONFIG_CMD_STRINGS=3Dy
>>> +CONFIG_OF_LIBFDT_OVERLAY=3Dy
>>> +CONFIG_CMD_BOOTMENU=3Dy
>>> +CONFIG_SUPPORT_EMMC_BOOT=3Dy
>>> +
>>> +CONFIG_FS_LOADER=3Dy
>>> +CONFIG_PHY_AIROHA=3Dy
>>> +CONFIG_PHY_AIROHA_EN8811=3Dy
>>> +CONFIG_DM_ETH_PHY=3Dy
>>> +CONFIG_PHY_AIROHA_FW_BUILTIN=3Dy
>>> +CONFIG_PHY_ETHERNET_ID=3Dy
>>> +
>>> +CONFIG_PCI=3Dy
>>> +CONFIG_PCIE_MEDIATEK_GEN3=3Dy
>>> +CONFIG_CMD_PCI=3Dy
>>> +CONFIG_NVME_PCI=3Dy
>>> +CONFIG_NVME=3Dy
>>> +CONFIG_CMD_CACHE=3Dy
>>> +
>>> +CONFIG_CMD_PSTORE=3Dy
>>> +CONFIG_CMD_PSTORE_MEM_ADDR=3D0x42ff0000
>>> +CONFIG_CMD_PSTORE_RECORD_SIZE=3D0x1000
>>> +#CONFIG_CMD_PSTORE_CONSOLE_SIZE=3D0x1000
>>> +#CONFIG_CMD_PSTORE_FTRACE_SIZE=3D0x0
>>> +#CONFIG_CMD_PSTORE_PMSG_SIZE=3D0x1000
>>> +
>>> +CONFIG_DM_RNG=3Dy
>>> +CONFIG_RNG_MTK_V2=3Dy
>>> +CONFIG_CMD_RNG=3Dy
>>>
I also guess the defconfig must be filtered and reordered (did my=20
changes at the end and grouped by function) by importing and using the=20
.config to follow internal order (afaik there was any command to make to=
=20
do this).

afaik

|makemyboard_defconfig ||makesavedefconfig ||cp ||defconfig path/to/||mybo=
ard_defconfig|

and some parts like hushparser, cmd-cache and maybe the downstream mtd=20
layout (nmbm) should not be part of defconfig.

had not tested nand on r3mini (kept it original to have a fallback in=20
case i break emmc).

regards Frank

