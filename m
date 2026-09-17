Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF825C982D2
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 696578109C;
	Thu, 17 Sep 2026 17:19:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WjrRy63kjFr1; Thu, 17 Sep 2026 17:19:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 79B42810EA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665560;
	b=sHEHKe+sR63Ca6ESnQcxQ5Fsagu2T27V04QtXz27QVUxXqbAs/ez50kKd2h37JAMTZk/
	 vZscyMKei9BEDC8umtOr2djDs8e1ahHcjpvyOB5QCLun25yHstpkc/8LYgqGnk4VzIESb
	 VAjZ2ZC5zI+ioR3KjAY3a071Fpn/udXr7THuc+V8MROmwQi8hqjti+0rPdBB9KBdkeS2m
	 WCaRD/GQv3DM64tX8ag3ygKOlprhHSB4E4USVS2dNRc451ElS7DSkpolVz4Y6NzhXuKAn
	 Nba3mpMyYZCK+r5o0rJXUFvH0asVTE6n5rd0FRdDinIcFATs7T98CHxj/vb2kv/UHgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IsHRxTvPpncWnXLvOyxvru1s6A4wwmUNcC9QSufhhsQ=;
	b=jwS+PXn7lsc+0kGxpDjGgPDphkYz1fehbCTAOgjpXCOtyXWAPZc/SNWK89HAOM0L2+R3
	 X5u4gFCd+O2EcAJNGvQBJqD6bUlZo/Yz3UbTxwjc/EaHPfwplpC/HGtCPnKH1UW68jEFP
	 jQ3vDpI9+OmYqgrct062gWiTgCHX80at6hCXL3truY36b1KJ2Lq1bcIIg825FkyyS5yTG
	 JRV966PBCRecVsAYp3v7WRJr2STNlzL/lbIDrYzflRI2WF1Rs0M8QBMWtuRcGEAEdj85Z
	 3kf14ibwzO2nNJWgYVVQmDkFc/GUPF+t+Awa/fM3nalOL0BmeUe29ZqIMgGxFq3d/HA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665560;
	bh=IsHRxTvPpncWnXLvOyxvru1s6A4wwmUNcC9QSufhhsQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rNiF4WXCqsMMUlrowVjcw9t1Zh9BNrDJ3rY9EEYYgo9DK9G9FAoq8RCj21rE8cHqc
	 keuQi1gdsJNptwoCJ5fivrijHNY1BNISEVSJJ0RPTGPo6TUAgWrD/3AY4hVHljLFEB
	 yg7G6t2o42QcLE4HpqLpgR1reJK+q8FTQ6X/Ds04BvRF3jeUrMy7W2CMjwT3RkU7ag
	 X2HFR8vmjes6EpMapMz+mA26HGjVQoG2rThmkP9WJrDmBt16FFDnkKJRk8ns5+k39U
	 +ZxSlvf08NdZ4X/nL5sHgH/q5EBWRRFNHjHO3KIWwSOXyWS1yNFquZyVtjJskFE5D+
	 B2XuYEA+IhQXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79B42810EA;
	Thu, 17 Sep 2026 17:19:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F3A8737A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D988440446
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lxl5tdP1iSjS for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org ACAD640378
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665519;
 b=jgpdpxAfGRZ+q+/PEbe0mMP9Z3NlCfJtpTwH41jG1gKCX4ZlSZQlhShke95E3EbgWkWm
 MfzBgAwFQcfJzZ95f3KmvVlhp5SLi3bLYZcLnpvJJPGWAbGEyGHn+BzXaj42o9u1SlhxO
 SfEHLhwsBRerrl9KuVYlb/XjBCdNI8P6oADo/hBEdGTV/XnsXLxlEfwxQe0NsKbPYSuP7
 LiNugyXOebgyksFH5nRb1iC4MpyqA53A8eVHFFro6xU7DaEgFG7yvh0IOYnviA6TbaUXx
 l5FbAgTI47C4LkJb4J51nNJ6yzcwjRI1GC/pVMBPlq9AjCOrUfC6GJhr53TjmvaHNrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665519;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=IsHRxTvPpncWnXLvOyxvru1s6A4wwmUNcC9QSufhhsQ=;
 b=nCa3qlvA0dnKE7XXzeR1b1TwomtBT6fqa6XONxW9MkftfYFhFy1ba4NffI/j4PNmOKe6
 WqdiMzUg40phmu33ZytbO8ZwwMTJPVJPe60uMKDDtN1KBz71BnGiE9FFLdBv678DbH+0S
 nDHRLdF4LCAXmZt9OqSv455tgTdOYiRnjq8QstgJXUo5aL8WyX37QoysazJ4LVHGQ8AEU
 VO+ctTghKODjLRqMz+es6xbGa5aWEb6BL94Ec6XH2nKnvDLTgHXLMqUh/7tvmOQAClbYY
 /MyfPLfoqzeTTFFkWpXXdDMpIuWx9B9gDh5imAR7VtU8GuZD3YDockSx4hfmj53hgBg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="ZGHK/FB6"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=ZGHK/FB6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id ACAD640378
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8088143D;
 Thu, 17 Sep 2026 10:18:33 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 857E73F7B4;
 Thu, 17 Sep 2026 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665517; bh=JJHoRDIQztYFG1mcKl8H+zd4e1ofltV3UO197FUQIGk=;
 h=From:To:Cc:Subject:Date:From;
 b=ZGHK/FB64EtuLnw91IYtsdyol+WxI5cqgR1ZoRXkYmSSqcrVzDWYhr28OmLIcvIIy
 gtMobTrm/6Cw+W+5oa97d0mrsKpP8MxVIU8gKIAUNBsYfneh+ry5K/QE6pPW3ItmRh
 6hDy5WhSQCA1Ng+bzj6bOU4+i4qUsFsl8GeRhT0g=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Adam Johnston <Adam.Johnston@arm.com>,
 Srinivas Kalaga <Srinivas.Kalaga2@arm.com>,
 Alex Chapman <alex.chapman@arm.com>, David Hu <david.hu2@arm.com>
Subject: [PATCH v6 00/24] Introduce Firmware Update Support for Arm PSA
Date: Thu, 17 Sep 2026 18:17:46 +0100
Message-ID: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
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

This patch series adds Firmware Update (FWU) support for Arm PSA
Certified platforms [1], enabling U-Boot to serve as
the FWU Client, with the Secure World acting as the Update Agent that
manages the firmware store and its metadata.

This implementation adheres to the Platform Security Firmware Update
specification [3] for the A-profile Arm Architecture and leverages the
Trusted Services framework [4] to interact with the Secure World update
agent. By delegating update management to the Secure World, U-Boot
handles only the client-side coordination, invoking a well-defined set
of ABIs over the FF-A interface [5] to deliver update capsules.

Key features include:

- Generic, platform-agnostic design.
- FF-A-based ABI: All interactions between U-Boot and the update agent
    occur over the FF-A interface, ensuring compatibility across
    PSA-compliant systems.
- Multi-payload capsules: Support for capsules containing multiple
    payloads, start/end markers, signed firmware images.
- ESRT support: Capsule payloads may be signed for authenticity, and
    U-Boot can populate the EFI System Resource Table (ESRT) for
     OS-level firmware management.
- On-disk and standard capsule handling.

For implementation details, please refer to the documentation [6].
Testing logs for standard and on-disk capsule update flows on
Corstone-1000 FVP are included below.

Changes in v6:

* As suggested by Sughosh:
  - Addressed review feedback by separating Arm PSA FWU from the existing
    normal-world FWU multi-bank implementation.
  - Moved PSA FWU code and Kconfig/Makefile integration from lib/fwu_updates to
    lib/efi_loader.
  - Dropped v5 changes to lib/fwu_updates/{Kconfig,Makefile,fwu.c}. PSA FWU no
    longer extends the generic FWU update path.
  - Made CONFIG_FWU_ARM_PSA mutually exclusive with CONFIG_FWU_MULTI_BANK_UPDATE.
  - Reworked PSA FWU trial-state and image-acceptance handling to use the cached
    PSA FWU directory from Secure world instead of generic FWU metadata.
  - Reworked Corstone-1000 active-index handling to read and validate FWU
    metadata directly for kernel setup.
* Rebased on master.

Regards,
Harsimran Singh Tungal

[1]: PSA: https://www.psacertified.org
[2]: Corstone-1000: https://developer.arm.com/Processors/Corstone-1000
[3]: DEN0118 v1.0 A specification: https://developer.arm.com/documentation/den0118/latest 
[4]: Trusted Services documentation: https://trusted-services.readthedocs.io/en/stable
[5]: FF-A interface: doc/arch/arm64.ffa.rst
[6]: Documentation of the FWU for Arm PSA support: doc/develop/uefi/fwu_arm_psa.rst
[7]: Arm PSA FWU logs when used for on-disk capsule update in Corstone-1000

Testing:
The implementation has been tested on Corstone-1000 FVP with both
standard capsule update and on-disk capsule update flows.

Tested on Corstone-1000 FVP:
  - Standard capsule update: passed
  - On-disk capsule update: passed
  - ESRT entries verified from Linux after update

Testing logs for standard capsule update:

A trimmed standard capsule update log is included below.

```
CapsuleApp: capsule block/size              0xDCF56040/0x867B5A
FWU: Updating 4 payload(s)
resetting ...
NOTICE:  BL2: v2.14.2(debug):lts-v2.14.2-dirty
...
U-Boot 2026.07 (Sep 08 2026 - 15:59:00 +0000) corstone1000 aarch64 
...
FWU: System booting in Trial State
...
Poky (Yocto Project Reference Distro) 5.2 corstone1000-fvp /dev/ttyAMA0
...
root@corstone1000-fvp:~# reboot
...
U-Boot 2026.07 (Sep 08 2026 - 15:59:00 +0000) corstone1000 aarch64 
...
FWU: System booting in Regular State
...
Poky (Yocto Project Reference Distro) 5.2 corstone1000-fvp /dev/ttyAMA0

corstone1000-fvp login:

root@corstone1000-fvp:~# cat /sys/firmware/efi/esrt/entries/entry*/*
0x0
f1d883f9-dfeb-5363-98d8-686ee3b69f4f
1
6
0
6
0
0x0
7fad470e-5ec5-5c03-a2c1-4756b495de61
1
6
0
6
0
0x0
f1933675-5a8c-5b6d-9ef4-846739e89bc8
1
6
0
6
0
0x0
f771aff9-c7e9-5f99-9eda-2369dd694f61
1
6
0
6
0

root@corstone1000-fvp:~# 
```
 
Testing logs for On-Disk capsule update:

A trimmed on-disk capsule update log is included below for one payload

```
CapsuleApp: capsule block/size              0xDCF61040/0x867B5A
Found EFI system partition on Boot0001: OnDiskFWU
FS2:;HD0b:;BLK4: 
Succeed to write corstone1000-fvp-v6.uefi.capsule
resetting ...
NOTICE:  BL2: v2.14.2(debug):lts-v2.14.2-dirty
...
U-Boot 2026.07 (Sep 08 2026 - 15:59:00 +0000) corstone1000 aarch64 
...
FWU: System booting in Regular State
FWU: ABI version 1.0 detected
FWU: Updating 1 payload(s)
Applying capsule corstone1000-fvp-v6.uefi.capsule succeeded.
Reboot after firmware update.
NOTICE:  BL2: v2.14.2(debug):lts-v2.14.2-dirty
...
U-Boot 2026.07 (Sep 08 2026 - 15:59:00 +0000) corstone1000 aarch64 
...
FWU: System booting in Trial State
...
Poky (Yocto Project Reference Distro) 5.2 corstone1000-fvp /dev/ttyAMA0
...
root@corstone1000-fvp:~# reboot
...
U-Boot 2026.07 (Sep 08 2026 - 15:59:00 +0000) corstone1000 aarch64 
...
FWU: System booting in Regular State
...
Poky (Yocto Project Reference Distro) 5.2 corstone1000-fvp /dev/ttyAMA0

corstone1000-fvp login:

root@corstone1000-fvp:~# cat /sys/firmware/efi/esrt/entries/entry*/*
0x0
f1d883f9-dfeb-5363-98d8-686ee3b69f4f
0
6
0
6
0
0x0
7fad470e-5ec5-5c03-a2c1-4756b495de61
0
0
0
0
0
0x0
f1933675-5a8c-5b6d-9ef4-846739e89bc8
0
0
0
0
0
0x0
f771aff9-c7e9-5f99-9eda-2369dd694f61
0
0
0
0
0
root@corstone1000-fvp:~# 
```
Link to v5: https://lore.kernel.org/all/20250926141351.1755829-1-abdellatif.elkhlifi@arm.com/

Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Davidson kumaresan <davidson.kumaresan@arm.com>
Cc: Adam Johnston <Adam.Johnston@arm.com>
Cc: Srinivas Kalaga <Srinivas.Kalaga2@arm.com>
Cc: Alex Chapman <alex.chapman@arm.com>
Cc: David Hu <david.hu2@arm.com>

Abdellatif El Khlifi (23):
  arm_ffa: Add FFA_MEM_SHARE support
  arm_ffa: Add FFA_MEM_RECLAIM support
  arm_ffa: sandbox: Replace the emulator error log with debug log
  arm_ffa: sandbox: Improve the readability of clearing the X registers
  arm_ffa: sandbox: Add FFA_MEM_SHARE emulation
  arm_ffa: sandbox: Add FFA_MEM_SHARE tests
  arm_ffa: sandbox: Add FFA_MEM_RECLAIM emulation
  arm_ffa: sandbox: Add FFA_MEM_RECLAIM tests
  fwu_arm_psa: Initialize the update agent
  fwu_arm_psa: Read the FWU directory through get_image_info()
  fwu_arm_psa: Add staging ABIs
  efi_loader: fwu_arm_psa: Add set_image() support
  efi_loader: fwu_arm_psa: Allow keeping the FMP payload header
  efi_loader: fwu_arm_psa: Skip accepting payload after set_image()
  efi_loader: fwu_arm_psa: Disable trial state handling
  fwu_arm_psa: Add FWU acceptance mechanism
  fwu_arm_psa: Add ESRT support
  fwu_arm_psa: Add ExitBootServices() notification handler
  fwu_arm_psa: corstone1000: Enable FWU support
  fwu_arm_psa: corstone1000: Read active index for kernel setup
  fwu_arm_psa: corstone1000: Notify SE Proxy SP on ExitBootServices()
  fwu_arm_psa: corstone1000: Set Boot0001 for on-disk FWU
  fwu_arm_psa: Document FWU support for Arm PSA

Emekcan Aras (1):
  efi_loader: capsule: Add runtime capsule flags checks

 MAINTAINERS                                   |    9 +
 .../include/asm/sandbox_arm_ffa_priv.h        |   21 +-
 board/armltd/corstone1000/corstone1000.c      |  406 ++++-
 board/armltd/corstone1000/corstone1000.env    |    8 +
 configs/corstone1000_defconfig                |   15 +-
 doc/arch/arm64.ffa.rst                        |    4 +
 doc/develop/uefi/fwu_arm_psa.rst              |  154 ++
 doc/develop/uefi/index.rst                    |    1 +
 drivers/firmware/arm-ffa/arm-ffa-uclass.c     |  285 ++-
 drivers/firmware/arm-ffa/arm-ffa.c            |    4 +-
 drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  108 +-
 drivers/firmware/arm-ffa/sandbox_ffa.c        |    4 +-
 include/arm_ffa.h                             |  128 +-
 include/arm_ffa_priv.h                        |  153 +-
 include/efi_api.h                             |    3 +
 include/efi_loader.h                          |    3 +
 include/fwu_arm_psa.h                         |  422 +++++
 lib/efi_loader/Kconfig                        |   53 +
 lib/efi_loader/Makefile                       |    1 +
 lib/efi_loader/efi_capsule.c                  |   45 +-
 lib/efi_loader/efi_firmware.c                 |   32 +-
 lib/efi_loader/fwu_arm_psa.c                  | 1616 +++++++++++++++++
 test/dm/ffa.c                                 |   73 +-
 23 files changed, 3458 insertions(+), 90 deletions(-)
 create mode 100644 doc/develop/uefi/fwu_arm_psa.rst
 create mode 100644 include/fwu_arm_psa.h
 create mode 100644 lib/efi_loader/fwu_arm_psa.c

-- 
2.43.0

