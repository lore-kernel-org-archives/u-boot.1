Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34C8CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 490A460607;
	Mon, 28 Sep 2026 22:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FSpaJDS3jPDq; Mon, 28 Sep 2026 22:20:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2918260613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634055;
	b=MUuumCr0HeVwDQ9rI7gtozFYkFwIpKEF/u4YvoOtAfrsEb/7JH8hqosoEtRnxTBp3W76
	 cTjcsu3YrjYG/HKnMZbrmQlOuxgtACRKfWFMdjrNWzBqvNw4d+H1E6DmB7dcIoDbzzmUf
	 AobgDzWnbYJAz/KZJ9VecE6mzQDmuO5+yhXhwQYmsorkmZgJnj9fwT+lGCGeXHNlFdtY2
	 GaRzezPD4FP0BlZLF6u8ewXQKRVsdMKoMQd4ZZDTCtxKOHLTuHH4NeJQVfWcUVLQ4wuaF
	 TViTRlHqW3UMag+A7JlZgOAd/wrj7fm06d2ORugmUlZAjyn4gMLt05x2asnnuco/VFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634055;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lWFnqb9LnKCQ1L44htXrQGVYM74BQPfWLNsxYbe0t5A=;
	b=VJyQiyE9FEu28dRs653teJVnVhCpHLSCxFeaUcd+Uu3o748WDGOJebMq8fILSFUygn38
	 B6EqBokgFXOFBLYI/6ZVVdE/l4jM6V4oSWigMDGbxrJQmaBkIo8Q6F+9VTsFwvShPOYJP
	 VGFKqbeGzsvLIjN9Mw7MLfnmbg6VujcS9gmvWWbSnsxW9P8vDuFfMcTPT/lJViNY6diVV
	 hUabSDP3CxSB6AWIaXHdpzW0D90FifrQAf7lK6UmK5vhCgFse9x3I6eWTEDwqRLf0AH7s
	 /3RIX5U4aXH1pHkUjOP74Q8zEQ0hP3u4+xGRBioPChGhLNj0r2wiLLE+kXEL1+kNZIg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="f9/3zIUe";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634055;
	bh=lWFnqb9LnKCQ1L44htXrQGVYM74BQPfWLNsxYbe0t5A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q1bJ3FxX1TaYCWjcjg8E8S2id9cUotN50Mf3oeNSNErqzkGtlTU0FlCkp5+qc4dkg
	 vAWFwThaVPj4/rVmpghbeldIZnQ3uGS2W/e1+s/xDdYVyt0DRdUj4bHaKcLpxQcrTT
	 DzBDCLoEZL0NLE1jI5gdsQrM/7sMqY+5YAqUWv7faiQsz37kLNNIsGqdM+t9oar9bW
	 RhBfNveekaGUdwlG/rF2ZA8J43Tj5FnzNzRDlrlUUf2Vt2uohI46uUqM0CPM3J4p76
	 w+JR94ijHRszlmdBprghYoa4vwmQtUnwEclSMifGw7tRwJ7wnKep5DGS/vxraXsFDx
	 5zcya80Rgtilg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2918260613;
	Mon, 28 Sep 2026 22:20:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CEF3335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D1A860613
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IBj_mBTH1gh2 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AF94A60607
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790634052;
 b=Qbfp1Wuidc9mJi0VZF1pOMlnt51No560z/TXiVLBcp3jdCxQZ9xXYOZhtVyEbQR0FkvT
 3CMIL9BfU91AJsW2MBivvdDRn/xn4c3Q0Qo7DOCbqWm3dZN+WFQbx+YCg2++DEc2k/0lB
 5HGvLiE/ufUyK0t8IGh//0YuG0xhpfmsgP8xmH2JBOf7p7EeKVPFlXBGRvWRKiWFn4TtF
 HS8Ilq64NRQxfG/6aMeW35u2pBRe25UmCTBTcMqiLTkU05Lh1CyVPGqm6ckXtcRTbACMI
 D0gMMHdS/48ingkaRBeENXEv3tPKZOHt30xqyyQ3gF+FF6MkgpEhWzZi7Zq78WvDo7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634052;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=lWFnqb9LnKCQ1L44htXrQGVYM74BQPfWLNsxYbe0t5A=;
 b=pnL2R4cjTse1gG9Olb6xXMyPUlcbTN+igzgJuNbAV7evHJ6iLxE9G6IBKQhkK0s116CK
 +tBgwNxvkT+SXc5VKM5FZQK+LkMdVDSyou4jTJrE3vqCgYf/q2W7St8j1DVrKnz+oNAJn
 eoZsf/ddIDU8AG1QsKY0I5rAnVjdoSSNXIB0qWiYRd7NKd8Cosn95OFvawaYoZLfMNkpp
 8Skeway+vJD2xBAl8cXsvDfpA7kAxyTrLpwRFY04gitG8ZXnoB7GL29VLDVQ/7vB8HpgL
 EA5tQw7OHwboX2SzHylEL+hkTUODMOHPUe53+qF3XCcb9pwYuo7KIZ1RzD+e2FwRb2g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b="f9/3zIUe"; 
 arc=none smtp.remote-ip=212.227.17.22
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.22;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=f9/3zIUe
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF94A60607
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790634047; x=1791238847; i=xypron.glpk@gmx.de;
 bh=lWFnqb9LnKCQ1L44htXrQGVYM74BQPfWLNsxYbe0t5A=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=f9/3zIUekis0+KkyKNAICoR4pgRoIlVMJEUtnGfEfpXaS4TmaFpYjMaaaaDgysDA
 TDzdUWbJS4EAq58H6ffNa10ZmNMV3mY83rMTJyGp+n7xQhVQ5G/DyzjaXQ19i9G1q
 wUFsEv8JwquX1le0I52f0FIiXE7/NoTKSD0y4lLkSGf/yD+jD30d4SHadb1VDNveS
 2X2gnQxxuxEJ6u4A2JvC2XKxaq5+j0laPWDWnPdtzmYpHpHZ3qQgQxW1//rk8S4F6
 LZlu8FcFhchAWvY3g3LGNeo31l6NHLYvtHjtCiuDLvQBkIES9cNwyxi6Dyy8XmOwN
 jh5hVy495PMZ/FjEjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1wutQJ2d53-012wR8; Tue, 29
 Sep 2026 00:20:46 +0200
Date: Tue, 29 Sep 2026 00:20:41 +0200
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
In-Reply-To: <CF9CE178-91B3-4F7E-AC97-DE37B8D63CDF@gmx.de>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <CF9CE178-91B3-4F7E-AC97-DE37B8D63CDF@gmx.de>
Message-ID: <9A8EEB25-DEA9-4CBA-B932-1E1D1D477246@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QnZNEjqrUNC0nnFC0EfXy5zmTPESrKmPfKoFvROtStG7QqDnACR
 Wxaku3btAfF+/5dfNFO1hUy2HDA35J3IgHDaypKRsEoIAlSbMfrmVSzJjr9lDa5wDIWyIg6
 bp/tpjQT1yxqmb6NVA0EllNs9qupQyBKqo/vScv/jUx+iFVBKgey0orgWKOt9KYv41eFDLw
 55Ng7l+PfSPW6VgZKvw6A==
UI-OutboundReport: notjunk:1;M01:P0:m7q8wWAzrD8=;Zw35G+O17S+ErTOhSnDyzkQVphw
 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
 VcFDawTrn6Zph6Yc0Vvk1GhtNQ==
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

Am 29=2E September 2026 00:10:05 MESZ schrieb Heinrich Schuchardt <xypron=
=2Eglpk@gmx=2Ede>:
>Am 3=2E September 2026 15:09:47 MESZ schrieb Carlo Caione <ccaione@baylib=
re=2Ecom>:
>>EBBR-style firmware owns the devicetree: the OS is booted via UEFI and
>>receives the devicetree from the firmware through the EFI configuration
>>table instead of shipping its own=2E U-Boot has the handoff mechanism
>>(efi_install_fdt()), but no generic way to describe and load the
>>firmware-owned source=2E As a result, platforms carry downstream command=
s
>>to provide it=2E
>>
>>This series adds a firmware-FDT uclass with storage-specific source
>>drivers and common FIT selection, verification, overlay assembly and
>>caching:
>>
>>- one FIT ("fdt=2Eitb" by default) carries the base devicetree and its
>>  overlays=2E FIT configurations describe valid combinations, so a signe=
d
>>  configuration authenticates the base, overlay set and ordering;
>>
>>- the first backend, selected by a standalone
>>  'u-boot,firmware-fdt-block' control-DT node, reads the FIT from a
>>  filesystem on a GPT partition=2E The compatible suffix leaves room for
>>  drivers which obtain the same FIT from other firmware storage;
>>
>
>Why should a "firmware-owned" device-tree live on an OS owned block devic=
e?
>
>This lack of separation of duties is bound to lead to total failure once =
I reinstall my OS which typically starts with repartitioning the block devi=
ce=2E
>
>Please, put anything that is firmware owned on a storage device that is f=
irmware owned and not OS owned=2E
>
>>- 'fw_fdt_part' can override the partition for A/B firmware selection,
>>  while 'fw_fdt_config' can select the configuration for the current boo=
t
>>  policy=2E Otherwise compatible best-match against the control devicetr=
ee
>>  is used, falling back to the FIT default;
>>
>>- the source device caches the assembled result by those two selectors,
>>  avoiding repeated reads and verification while the EFI bootmeth scans
>>  bootflow candidates;
>>
>>- once a source is configured, any failure to assemble the devicetree is
>>  fatal rather than silently falling back to an unverified source=2E Eve=
ry
>>  image is verified up front so a corrupt overlay cannot be silently
>>  skipped=2E
>>
>>The loader does not depend on standard boot=2E EFI is its first consumer=
,
>
>The topic of constructing a firmware device-tree seems to be completely i=
ndependent of the way the boot binary is invoked=2E
>
>The easiest way to make such a device-tree available for other boot metho=
ds would be providing an environment variable that can be used instead of $=
fdtcontroladdr=2E
>
>The construction should only occur once and not repeatedly for each of th=
e EFI binaries that is executed=2E

Thinking of other boot stages like EDK II the device-tree may already have=
 to be created in U-Boot SPL=2E

Multiple RISC-V systems boot via

U-Boot SPL -> OpenSBI-> EDK II

Best regards

Heinrich

>>but the source drivers, FIT handling and staging interface are generic=
=2E
>>Both the EFI bootmeth and EFI boot manager use the same staging helper=
=2E
>>
>>Patch 1 makes an FDT passed to efi_bootmgr_run() outrank a Boot#### FDT,
>>as an independent behaviour fix=2E Patch 2 adds the uclass, block backen=
d,
>>documentation and staging interface=2E Patches 3 and 4 integrate the EFI
>>bootmeth and boot manager=2E Patch 5 adds sandbox coverage=2E
>>
>>Signed-off-by: Carlo Caione <ccaione@baylibre=2Ecom>
>>---
>>Changes in v3:
>>- Model firmware-FDT sources as a uclass with storage backend drivers;
>>  split out the block backend and reject multiple enabled sources=2E
>>- Cache the verified, assembled devicetree by the partition and
>>  configuration runtime selectors=2E
>>- Rename efi_stage_firmware_fdt() to the generic firmware_fdt_stage()=2E
>>- Add separate configurable size limits for the input FIT and assembled
>>  devicetree=2E
>>- Validate the assembled devicetree before publishing it and avoid
>>  duplicating the internal FIT filename=2E
>>- Keep EFI and firmware-FDT sizes separate in the boot manager and retai=
n
>>  the FIT filename for failure diagnostics=2E
>>- Extend sandbox coverage for caching and selector invalidation, a missi=
ng
>>  FIT and multiple configured sources=2E
>>- Use the current SystemReady DeviceTree name=2E
>>- Clarify fw_fdt_part as the A/B partition override and fw_fdt_config as
>>  the per-boot-target configuration override accepted in the v2 review=
=2E
>>- Add Reviewed-by tags from Ilias Apalodimas and Simon Glass to patch 1=
=2E
>>- Link to v2: https://patch=2Emsgid=2Elink/20260728-ccaione-upstream-ebb=
r-v2-0-4efb529140d6@baylibre=2Ecom
>>
>>Changes in v2:
>>- Make the loader independent of bootstd and describe EFI as its first
>>  consumer=2E
>>- Describe the source with a standalone compatible node which points to
>>  the backing media through a phandle=2E
>>- Rename 'boot_dtb' to 'fw_fdt_part' and document both environment
>>  variables in doc/usage/environment=2Erst=2E
>>- Factor EFI staging and fail-closed policy into one helper used by all
>>  three call sites=2E
>>- Track the assembled FDT's ownership explicitly and own the FIT filenam=
e=2E
>>- Select FIT_BEST_MATCH and add explicit compatible-selection coverage=
=2E
>>- Split the passed-FDT precedence change into its own first patch=2E
>>- Build the entire sandbox source topology at runtime, store mmc11=2Eimg=
 in
>>  persistent_data_dir and add staging, configuration-chaining and corrup=
t
>>  base/overlay fail-closed coverage=2E
>>- Link to v1: https://patch=2Emsgid=2Elink/20260706-ccaione-upstream-ebb=
r-v1-0-e742cdd6abe5@baylibre=2Ecom
>>
>>---
>>Carlo Caione (5):
>>      efi_loader: bootmgr: preserve a passed devicetree
>>      boot: add a firmware-owned devicetree source
>>      bootmeth: efi: use the firmware-owned devicetree
>>      efi_loader: bootmgr: install the firmware-owned devicetree
>>      test: boot: add firmware-FDT source tests
>>
>> MAINTAINERS                               |   3 +
>> boot/Kconfig                              |  49 +++
>> boot/Makefile                             |   2 +
>> boot/bootmeth_efi=2Ec                       |  45 ++-
>> boot/firmware_fdt=2Ec                       | 303 ++++++++++++++++++
>> boot/firmware_fdt_block=2Ec                 | 143 +++++++++
>> boot/image-fdt=2Ec                          |   3 +-
>> boot/image-fit=2Ec                          |   9 +-
>> configs/sandbox_defconfig                 |   1 +
>> doc/develop/uefi/firmware_fdt=2Erst         | 118 +++++++
>> doc/develop/uefi/index=2Erst                |   1 +
>> doc/device-tree-bindings/firmware-fdt=2Etxt | 160 ++++++++++
>> doc/usage/environment=2Erst                 |  13 +
>> include/dm/uclass-id=2Eh                    |   1 +
>> include/firmware_fdt=2Eh                    | 106 +++++++
>> include/image=2Eh                           |   5 +-
>> lib/efi_loader/efi_bootmgr=2Ec              |  45 ++-
>> test/boot/Makefile                        |   1 +
>> test/boot/firmware_fdt=2Ec                  | 498 +++++++++++++++++++++=
+++++++++
>> test/py/tests/test_ut=2Epy                  | 183 +++++++++++
>> 20 files changed, 1670 insertions(+), 19 deletions(-)
>>---
>>base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
>>change-id: 20260706-ccaione-upstream-ebbr-206c30be3a3a
>>
>>Best regards,
>>-- =20
>>Carlo Caione <ccaione@baylibre=2Ecom>
>>
>

