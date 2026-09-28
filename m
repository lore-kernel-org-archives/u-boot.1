Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8061FCA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:10:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1542680BB8;
	Mon, 28 Sep 2026 22:10:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EknnLgdFcgs6; Mon, 28 Sep 2026 22:10:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 223BA80ACC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790633440;
	b=eHIHkPirbSBGASiysmEWkXkRcdn/L2x1J/FWbEIILfl24R1TgPBk4dRmeuJW5bMbQqvz
	 SAlWrsVaWR5M1pri7FrI19ZTL1/WOXA/Q+stlgvp7xmK30QKbODk5WnkoXwj8k1Ee35KD
	 nqP+Tfj36lzfe6m2SKoVeSP4PSD9mLcgVZeLHDyI8EfgVBLmLbUv31EUMAnmnbXKT4E2w
	 kUm7usWrQdLKEM68rnXACbQD+wEId2ZtFKNtpzSUNP13KKxlUWYz1ACcP012beMqEeZcx
	 X7kebY+H22qHX0ehP4cNQ/aLcQgQ05P9CwczzPRKJMX3Ib8GKS6j+J2plmSZsCsuklA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790633440;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zGEEhhy26a4/5AZOuHC6B1BO1vOwKOO99AOf4Fg7H4g=;
	b=sDcdgZkELKpj/RgCgbkXXVWBgcEy+GpxklEqShHXA1gyHqqGmDQ0cyGbv02S1sE04QcK
	 QMI5Z8DCInLUIlsw2+nCIF+hJxMLjz/nB5YAkvAvt47FQ7QLlMBEE34FasQjsCCVp4DKS
	 ch81NpbYk93Vnsov8XxBej0Dj44ZEL3dwzj0Ykh9D2EChuw4/dc96qZnpAiHhkg4ZWOx0
	 Dp9ucJ/jtQRkPHUVXC7xuTgce+SViI9wRynl70pm1L2BJ6GZzBC/OsoB8nS+s6aj0bd0Z
	 uLBdl7MZJbFlUbx3SiPIpIvTDTrlXci5e7YK1sn9Gh+G8G8KJntARhb4X1Bizt40DbQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790633440;
	bh=zGEEhhy26a4/5AZOuHC6B1BO1vOwKOO99AOf4Fg7H4g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cwbhiLRao7z1wC81ncqWe9grDEBIffT4TQ0UlVyLuHDbfJfkOFpCVWI/2naQLRqMG
	 93l5tdqB/xtTm2sgt1UmNnDVMVtVQA38wxSxlfyGDNKLJC2IElqMV0Oeh1gn8SnhKW
	 Lv0HDWLylXWuvXI1eo7phRkNEiXDv4E5rugqqO56AWO1to2os4OxuNmIpd8WhpEGzI
	 zz3Nd6tcmEKx4QOiAxy7Nb9V9J53xZuYHl3BXJbZ1zBNn8HyLp8RcdFIS2WiAimbyJ
	 JI2hFYu/QJQ5NaEZRQmhzgBFcoz09KNT1LBWTFUKgAFXA1BHkp5yLjRELZIjcYfJRC
	 gkGpfCJZw01jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 223BA80ACC;
	Mon, 28 Sep 2026 22:10:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D191417
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E6F1404E8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NjzxoRyz5-ss for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:10:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0D62B404E7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790633437;
 b=Hncz7RDAGvRW61P7o4GRjhDLxYxwO3NaSQRisZoKPRZ+K/gO1vnyDzxvS/VBasAWxf7f
 Dfd+9hThXCJSzZhSjdLfMqaxYr1cHKYl1+zUqvivby4Wwwqcv9Y1L6fisL5Hq/rmq1pRk
 UT8ZstjZkq9Odh83sxcrjypKChU+ih9k8fDQgqBWYvzcTyAVljsda6QmdHbowL7vBMRR7
 DbDrPO6Da9Tn4P10oYe6SKbrAdwfldz73SBdEaEDH8tQ1gVQny4pfTRfaIzPU3WCvKUHd
 dKuxPykJsku8PBwyf91VhcObWR1J1l0SlmJTOgl/PRjyGRqLVTzyeITGh0hXynMzWdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790633437;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=zGEEhhy26a4/5AZOuHC6B1BO1vOwKOO99AOf4Fg7H4g=;
 b=VEc0CKAIJFnV/nCDoOfEHSh3zRzGP16cMbeX1o/M/f5bnoJgLxoTb2J99qeinhx3vgxR
 ARDsSmHB4ab0Y0V1lthLsPjp1dyVefruDGDDGiajvRD1jMU1Fi9BGenNcr+siuesKLl8g
 GrLU9Puocn12ZWrgWiDK74XPTXDeEa/7iLut/x/o80cRyHAEf5oNY8Hr6yC0e/X7t1i5o
 q+aM98NEPrh809FqZE0AH7xcJohV7+IJMW2HeJeyiORgmjEH9yQ7UCnppS1U+YwOfwlQI
 u08qvfXbfbPJrrQKeVDkIpBOgMrTevBr9/ILCNyNkEu0Txqa5sqpe/r51XM5SdreazQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=DutGJnG3; 
 arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=DutGJnG3
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D62B404E7
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790633409; x=1791238209; i=xypron.glpk@gmx.de;
 bh=zGEEhhy26a4/5AZOuHC6B1BO1vOwKOO99AOf4Fg7H4g=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DutGJnG3OZ4/sDHOFXwRGWOvzAfPlRUT8Yuw1F3yWKvbZM1Rf122fQ0RCPTd/mCK
 RGNt3mb9um4HdbDmkRIlJ2ogqN5Qb+Brfz6kpTbPq5efD0wsaosr1FKwcFkroBI6e
 pAHmjgePR98OYPA+WjEdZgAQygnSttq5shL85UoXFUliT3Pesu+vlcFiStabIX7gk
 Rlet2O7/WhBXI8YIj94ATqF7DRRoSxnXbgMFri/7fS/viDpTF7FfidKqf6T2dKIB9
 pG8mE0rizV7L47L86EV3z3h26mtGzzk5t0CvzXtQpkUdcr66AVO19pLrLe8aIRXSd
 3WkRJGvfu1Fd7wM/3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1HZo-1x8Zj90j1O-0049li; Tue, 29
 Sep 2026 00:10:09 +0200
Date: Tue, 29 Sep 2026 00:10:05 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org
CC: Ahmad Fatoum <a.fatoum@barebox.org>, David Lechner <dlechner@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_0/5=5D_firmware-owned_devic?=
 =?US-ASCII?Q?etree_for_EBBR_/_SystemReady_DeviceTree?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
Message-ID: <CF9CE178-91B3-4F7E-AC97-DE37B8D63CDF@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ozcN+dr2gQE6uuwC2tSjfCT9jHSgmC8A2vZcbLP7EslxPZwlwCx
 I8zdwmKUQQUW2vv4ozfCkp9Xcmb5Itf3R5JJeRkK8ua7B01DX+q7aiFkEdP1eSGde5vsQiR
 kDeIw/OGFH5uySBNlmyJfhX7HCjNva3H/25eH1pjBW3L4dPnk1NvmClt43fNvbHCGhhnP3s
 0r9c9pZnJKdZigqtRtaOA==
UI-OutboundReport: notjunk:1;M01:P0:wFvQrTAd9Rc=;HZnxqP7dNGq+joNhvp9kl2q/+7v
 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
 4O9mwJZ0H6Kt71GPA1gFihRKeQ==
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

Am 3=2E September 2026 15:09:47 MESZ schrieb Carlo Caione <ccaione@baylibre=
=2Ecom>:
>EBBR-style firmware owns the devicetree: the OS is booted via UEFI and
>receives the devicetree from the firmware through the EFI configuration
>table instead of shipping its own=2E U-Boot has the handoff mechanism
>(efi_install_fdt()), but no generic way to describe and load the
>firmware-owned source=2E As a result, platforms carry downstream commands
>to provide it=2E
>
>This series adds a firmware-FDT uclass with storage-specific source
>drivers and common FIT selection, verification, overlay assembly and
>caching:
>
>- one FIT ("fdt=2Eitb" by default) carries the base devicetree and its
>  overlays=2E FIT configurations describe valid combinations, so a signed
>  configuration authenticates the base, overlay set and ordering;
>
>- the first backend, selected by a standalone
>  'u-boot,firmware-fdt-block' control-DT node, reads the FIT from a
>  filesystem on a GPT partition=2E The compatible suffix leaves room for
>  drivers which obtain the same FIT from other firmware storage;
>

Why should a "firmware-owned" device-tree live on an OS owned block device=
?

This lack of separation of duties is bound to lead to total failure once I=
 reinstall my OS which typically starts with repartitioning the block devic=
e=2E

Please, put anything that is firmware owned on a storage device that is fi=
rmware owned and not OS owned=2E

>- 'fw_fdt_part' can override the partition for A/B firmware selection,
>  while 'fw_fdt_config' can select the configuration for the current boot
>  policy=2E Otherwise compatible best-match against the control devicetre=
e
>  is used, falling back to the FIT default;
>
>- the source device caches the assembled result by those two selectors,
>  avoiding repeated reads and verification while the EFI bootmeth scans
>  bootflow candidates;
>
>- once a source is configured, any failure to assemble the devicetree is
>  fatal rather than silently falling back to an unverified source=2E Ever=
y
>  image is verified up front so a corrupt overlay cannot be silently
>  skipped=2E
>
>The loader does not depend on standard boot=2E EFI is its first consumer,

The topic of constructing a firmware device-tree seems to be completely in=
dependent of the way the boot binary is invoked=2E

The easiest way to make such a device-tree available for other boot method=
s would be providing an environment variable that can be used instead of $f=
dtcontroladdr=2E

The construction should only occur once and not repeatedly for each of the=
 EFI binaries that is executed=2E

Best regards

Heinrich

>but the source drivers, FIT handling and staging interface are generic=2E
>Both the EFI bootmeth and EFI boot manager use the same staging helper=2E
>
>Patch 1 makes an FDT passed to efi_bootmgr_run() outrank a Boot#### FDT,
>as an independent behaviour fix=2E Patch 2 adds the uclass, block backend=
,
>documentation and staging interface=2E Patches 3 and 4 integrate the EFI
>bootmeth and boot manager=2E Patch 5 adds sandbox coverage=2E
>
>Signed-off-by: Carlo Caione <ccaione@baylibre=2Ecom>
>---
>Changes in v3:
>- Model firmware-FDT sources as a uclass with storage backend drivers;
>  split out the block backend and reject multiple enabled sources=2E
>- Cache the verified, assembled devicetree by the partition and
>  configuration runtime selectors=2E
>- Rename efi_stage_firmware_fdt() to the generic firmware_fdt_stage()=2E
>- Add separate configurable size limits for the input FIT and assembled
>  devicetree=2E
>- Validate the assembled devicetree before publishing it and avoid
>  duplicating the internal FIT filename=2E
>- Keep EFI and firmware-FDT sizes separate in the boot manager and retain
>  the FIT filename for failure diagnostics=2E
>- Extend sandbox coverage for caching and selector invalidation, a missin=
g
>  FIT and multiple configured sources=2E
>- Use the current SystemReady DeviceTree name=2E
>- Clarify fw_fdt_part as the A/B partition override and fw_fdt_config as
>  the per-boot-target configuration override accepted in the v2 review=2E
>- Add Reviewed-by tags from Ilias Apalodimas and Simon Glass to patch 1=
=2E
>- Link to v2: https://patch=2Emsgid=2Elink/20260728-ccaione-upstream-ebbr=
-v2-0-4efb529140d6@baylibre=2Ecom
>
>Changes in v2:
>- Make the loader independent of bootstd and describe EFI as its first
>  consumer=2E
>- Describe the source with a standalone compatible node which points to
>  the backing media through a phandle=2E
>- Rename 'boot_dtb' to 'fw_fdt_part' and document both environment
>  variables in doc/usage/environment=2Erst=2E
>- Factor EFI staging and fail-closed policy into one helper used by all
>  three call sites=2E
>- Track the assembled FDT's ownership explicitly and own the FIT filename=
=2E
>- Select FIT_BEST_MATCH and add explicit compatible-selection coverage=2E
>- Split the passed-FDT precedence change into its own first patch=2E
>- Build the entire sandbox source topology at runtime, store mmc11=2Eimg =
in
>  persistent_data_dir and add staging, configuration-chaining and corrupt
>  base/overlay fail-closed coverage=2E
>- Link to v1: https://patch=2Emsgid=2Elink/20260706-ccaione-upstream-ebbr=
-v1-0-e742cdd6abe5@baylibre=2Ecom
>
>---
>Carlo Caione (5):
>      efi_loader: bootmgr: preserve a passed devicetree
>      boot: add a firmware-owned devicetree source
>      bootmeth: efi: use the firmware-owned devicetree
>      efi_loader: bootmgr: install the firmware-owned devicetree
>      test: boot: add firmware-FDT source tests
>
> MAINTAINERS                               |   3 +
> boot/Kconfig                              |  49 +++
> boot/Makefile                             |   2 +
> boot/bootmeth_efi=2Ec                       |  45 ++-
> boot/firmware_fdt=2Ec                       | 303 ++++++++++++++++++
> boot/firmware_fdt_block=2Ec                 | 143 +++++++++
> boot/image-fdt=2Ec                          |   3 +-
> boot/image-fit=2Ec                          |   9 +-
> configs/sandbox_defconfig                 |   1 +
> doc/develop/uefi/firmware_fdt=2Erst         | 118 +++++++
> doc/develop/uefi/index=2Erst                |   1 +
> doc/device-tree-bindings/firmware-fdt=2Etxt | 160 ++++++++++
> doc/usage/environment=2Erst                 |  13 +
> include/dm/uclass-id=2Eh                    |   1 +
> include/firmware_fdt=2Eh                    | 106 +++++++
> include/image=2Eh                           |   5 +-
> lib/efi_loader/efi_bootmgr=2Ec              |  45 ++-
> test/boot/Makefile                        |   1 +
> test/boot/firmware_fdt=2Ec                  | 498 ++++++++++++++++++++++=
++++++++
> test/py/tests/test_ut=2Epy                  | 183 +++++++++++
> 20 files changed, 1670 insertions(+), 19 deletions(-)
>---
>base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
>change-id: 20260706-ccaione-upstream-ebbr-206c30be3a3a
>
>Best regards,
>-- =20
>Carlo Caione <ccaione@baylibre=2Ecom>
>

