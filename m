Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98467D25044
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 08:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1B1E83C6C;
	Mon, 12 Jan 2026 09:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="n/M5cVjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFADB83C91; Mon, 12 Jan 2026 09:10:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 879D883C14
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 09:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1768205415; x=1768810215; i=xypron.glpk@gmx.de;
 bh=1E7KLrFhllVLkRJyR+mB7exZIURzovJ52zuYiS43Rfs=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=n/M5cVjpPwhf/LXqz64akI5PF6bKeL06FWKIeWXGkczaKFMJRVdU4XQDFGA2Rtaf
 fx1PnLr4GKBaHvbU2MR7cPlEo+98SZ5SRm3tTtsv2xxYzZAA8KqmTGBmn74BqfvLV
 DONtCNPPBndYh32sMw4aqV51yiZdFXaykNTm3IIrPCz3Y86py2dvy7u8ytDJuFUli
 meE9HmFkVrkSq2hehq+JZvpCZXumX0exr82Wlaw1WxPXQlnXisMneEpxYaLOvn75u
 uKSitlI5BmquMfhFjZAySbUN9cx7yB3hUMD60j1fYq9WxfLeUFjvBtKmqYeGvZQRJ
 REMa9zyv6c15Gksxlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryTF-1w91ZT2ePN-00ilnl; Mon, 12
 Jan 2026 09:10:14 +0100
Date: Mon, 12 Jan 2026 09:10:10 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 adrianox@gmail.com, paul.liu@linaro.org, sjg@chromium.org,
 wolfgang.wallner@at.abb.com, javier.tia@linaro.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_v1_0/3=5D_efi=5Floader=3A_Int?=
 =?US-ASCII?Q?roduce_platform_hook_for_FDT_selection?=
User-Agent: Thunderbird for Android
In-Reply-To: <597c246c-113c-4b88-93bb-22ec5b525b55@oss.qualcomm.com>
References: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
 <597c246c-113c-4b88-93bb-22ec5b525b55@oss.qualcomm.com>
Message-ID: <7E6BBD8A-5ADE-4AD3-A9C1-061ED7A4BA77@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VKanMELRITP4pN4pSP47Gq9uQFn2EhEmALOPWR+LWKDvrCwlTc6
 33ECsnPENRhXiJ5ZMzX+1ns33eawUT/XSkztY7ezkz7ADutCOkkBhBCT034Rezojo2T3rbG
 Rj6goSikWdS3+DvjaVsEzwZDmpZF1UVVpvYz6s+5pQNoAK7vc4AZ+8PSBZ2D4/dey13MnmD
 PfKrXZNBst/kSTDtxU/1Q==
UI-OutboundReport: notjunk:1;M01:P0:1bfxCBerqJo=;8FRZa/jYS1dcnDvApb7ngTxI5tD
 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
 e4TFqrUs=
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

Am 10=2E Januar 2026 09:30:03 MEZ schrieb Aswin Murugan <aswin=2Emurugan@os=
s=2Equalcomm=2Ecom>:
>Thanks everyone for all the valuable feedback=2E I appreciate the detaile=
d reviews and want to address the concerns raised=2E
>
>I should have been clearer upfront about what makes Qualcomm platforms di=
fferent here=2E Qualcomm has its own combined-dtb format that's been used a=
cross Linux products=2E The format is documented in [1] and the combined dt=
b file is placed in a separate dtb partition
>
>The combined-dtb file contains multiple DTBs concatenated together as a s=
ingle dtb file, each with Qualcomm-specific properties:
>- qcom,msm-id (platform ID and SoC revision)
>- qcom,board-id (board variant and subtype)
>- qcom,pmic-id (PMIC models - up to 4)
>
>At runtime, we read hardware info from SMEM (shared memory interface with=
 the firmware) and match it against these properties to pick the right DTB=
=2E
>
>*Why Existing Approaches Don't Quite Fit*
>
>After reviewing the feedback from Heinrich, Ilias, Simon & Sumith, I real=
ize the core issue is that all the existing U-Boot mechanisms assume separa=
te DTB files on the ESP:
>
>VisionFive2 approach: Uses EEPROM detection in SPL and sets `$fdtfile` to=
 point to individual files like `dtb/starfive/jh7110-milkv-mars=2Edtb`, `dt=
b/starfive/jh7110-starfive-visionfive-2-v1=2E3b=2Edtb`
>
>eficonfig and distro boot: These mechanisms work great for selecting betw=
een multiple DTB files=2E
>
>The common thread is they all expect individual DTB files, while Qualcomm=
's deployment model uses a single combined-dtb=2Edtb file that requires par=
sing and extraction=2E This is the fundamental gap we're trying to bridge=
=2E
>
>=C2=A0I agree with Simon that using the weak function approach is not an =
ideal solution=2E we should be avoiding adding hooks in the EFI loader=2E I=
nstead, we need to handle this at the board level and work with the existin=
g `$fdtfile` mechanism=2E
>
>*Proposed Approach*
>
>Based on all the feedback, here's the revised plan:
>For v2:
>1=2E In board code: Parse combined-dtb=2Edtb, extract the matching DTB, w=
rite to ESP as `dtb/qcom-<board>=2Edtb`

"Write to ESP" would imply at build time?

Do combined dtbs exist in Linux? Why use them here?

How are dtbs handled in earlier code like TFA? Could that earlier code pas=
s the specific dtb for the board?

Best regards

Heinrich


>3=2E Set `$fdtfile` to point to the extracted file
>4=2E Let standard EFI mechanisms handle the rest
>5=2E Drop the weak function approach entirely
>
>Does this approach address the concerns raised, or suggest a different di=
rection? I'm particularly interested in feedback on runtime DTB extraction =
to ESP is acceptable, or if there's a better way to bridge between our comb=
ined-dtb format and U-Boot's expectations=2E
>
>[1] https://docs=2Equalcomm=2Ecom/doc/80-70023-27/topic/configure_and_sec=
ure_boot_with_systemd_boot_and_uki=2Ehtml#multi-dtb-support
>
>Thanks,
>Aswin
>
>On 1/6/2026 5:51 PM, Aswin Murugan wrote:
>> This RFC patch series introduces a weak function hook to allow platform=
s to
>> provide custom device tree selection logic while keeping common EFI
>> loader code generic=2E
>>=20
>> Background:
>> Currently, EFI loader supports loading a single DTB file=2E
>> Qualcomm platforms require special multi-DTB selection logic that:
>> - Reads hardware information from SMEM (Shared Memory)
>> - Selects the appropriate device tree from a combined DTB file based on=
:
>>    * Platform ID (SoC variant)
>>    * Board variant and subtype
>>    * PMIC configuration
>>    * SoC revision=2E
>>=20
>> Solution:
>> Introduce `efi_load_platform_fdt()` as a weak function:
>> - Weak implementation in lib/efi_loader/efi_fdt=2Ec (defaults to no-op)
>> - Called from efi_bootmgr_run() after efi_load_distro_fdt()
>> - Qualcomm override in arch/arm/mach-snapdragon/efi_fdt_qcom=2Ec
>>=20
>> Aswin Murugan (3):
>>    efi_loader: Add platform hook for FDT loading
>>    soc: qcom: smem: Added socinfo header file
>>    mach-snapdragon: Implement Qualcomm multi-DTB selection
>>=20
>>   arch/arm/mach-snapdragon/Makefile       |   1 +
>>   arch/arm/mach-snapdragon/efi_fdt_qcom=2Ec | 339 +++++++++++++++++++++=
+++
>>   include/soc/qcom/socinfo=2Eh              | 114 ++++++++
>>   lib/efi_loader/efi_fdt=2Ec                |  34 +++
>>   4 files changed, 488 insertions(+)
>>   create mode 100644 arch/arm/mach-snapdragon/efi_fdt_qcom=2Ec
>>   create mode 100644 include/soc/qcom/socinfo=2Eh
>>=20

