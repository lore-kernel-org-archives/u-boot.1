Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B870CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 11:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31C246060C;
	Tue, 13 Oct 2026 11:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d1-6zN10Bl9q; Tue, 13 Oct 2026 11:14:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88BE260644
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791890046;
	b=hn0iRh3MpcIzIY1isnHP8bOlSDkANesxnmpEiTHHpVDhd3CXOcWPUtYbIeACJ0tyYLBZ
	 +9kGJPltYZfQUfe6q1vb6ksu+N1qxE/O6GMyx55W8H0OaOcN4yJHs+76u/6/KvLKqXr8I
	 sGmKrAqJPDsa0pyCZ6TnSYBeGQ7MIl/eiuViUfRK67HmhWHnusTIre8P106T3d4ztenMP
	 gEwk7qahJ/K8Cu7/ZkjeR9qcg09Su31Snkc1swAX+EB+oC45awSMdhPFdr+aP8kyVljMX
	 +e4tAKBQR3pwqWKaAfIabxcWZe+OX4F88vCbNuoouvoUUI/vYu3Upv4yuN7r+67q7pA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791890046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:
	 X-Migadu-Flow:Mime-Version:Content-Transfer-Encoding:Content-Type:
	 Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HUmgv3R/ZoReK/Sbw4Y//jgyFcEYvKwjf1wImvRMcYM=;
	b=anpaNn/RXwN5XknQK6n763mav46RJVXnZwfOCr+SBGpcGPDIaLD1bIpFzF3LqEwbOi88
	 lKX0zq6O9HH5X9UD8HIfUDiQJ04UG+Mf35lwzR1zuGzKMxU2lieRwwM5ebFtPgybe82j4
	 jNzprCFOZfkXvBlSaMrrMfQvbwK3EkD6Qm0RUUiq2EP37AUjUgqsXAg2vQ0kMrCjeXADG
	 FND8Ns/qDQIfPxlAoVppulmqNffg5q4yk3II4gOArXw41dB/4k/ndEtHY7+KzcPVGIk62
	 NM6nUJhKe34TluVxPJ5Wr85Oc6uYbk7JRZc7v6G5Qb858b6/KWNYG43VDpKKoep+Rmg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791890046;
	bh=HUmgv3R/ZoReK/Sbw4Y//jgyFcEYvKwjf1wImvRMcYM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i/zxEgU9MR1ODnD3q3mk54zzxk5cxoxmJqNI90JJm/MRmAwIdVjnDOUjw7MRsAYqZ
	 5nTBY7MJ1GOBR77sF2WCp12rOkflSfZXYd+v6RbV4fUAZy38pJGjaxj3phP95QmndW
	 EoT0dDTeU+CA8GwvMbNwE+IWVfL69mZDITfacrCwBwm/IgBmNvF0hQSNJBdf3KR73K
	 Jmo5OXj/TXECQz4iN4OV0PXO5ZG/Su29wfRlmoAcCYb4BJq7Wb+/yZlpH4S1kqq0qo
	 ikNyvUSC6Bv6Lz+7dRin5t8xLbZ1llt/L+Isyh/gKAnAE3unMDuOb/Q1nYw1Aozvld
	 351oztuz6dAeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88BE260644;
	Tue, 13 Oct 2026 11:14:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C838DE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D44F40277
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1823udcZEFyd for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 11:14:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0FF27400C5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:41d0:1004:224b::4f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791890043;
 b=EdsCnQjjSr+M7v4DgeYCdXnk/fmeFjWgz1jrFK7Z1wMhNIbRBTP2m9gt3HMkl5hTvvIo
 6toI6d1TIdU5k9xTIonSNqQxpuI1pW9NkqpJokZaxWTvTuUCzpd9euS6Zh1vp6J3kqne+
 F8mAYt9CkARdNzwqumPNgkY5iZXXg/ySUQNFjiP2mLA3Z7jjlBOGwZiW1eWT8Sn4H+miZ
 KxfTLsU2ight3xndIswt1w/zhtfGAU7iAZxFlQHgmMHHtckQnruCOIl5WhzFgCdHz48Ed
 mnA/nU0RfcZyb76LU0Q1pi2lBu4/EmCTOTnF6dwVCR/5n5ETrbcw52zgA0l5m+sfTyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791890043;
 h=X-Greylist:Received-SPF:X-Envelope-To:DKIM-Signature:X-Envelope-To:
 Received:X-Mizu-Trace-ID:X-Migadu-Flow:Mime-Version:
 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
 From:To:X-Mailer:References:In-Reply-To;
 bh=HUmgv3R/ZoReK/Sbw4Y//jgyFcEYvKwjf1wImvRMcYM=;
 b=DLgOwx/i9kTnL0n9C779XPAE6Bo2MwvDJUPiCYifFE6GNVw1WNtUyWaKZzC9jQIQinhb
 jTyxxGAfgI8JMIq7Q1WLMWsllizLlcTHI5+vm2P5oIlkIduUdTO5R6aTJawaXJlI7PEF8
 R0K+C1W+ZhWPVUnQo0BVpBK18VB9DjQMAx0bFMmWRyAm/FANFe4L8axsZDB1sJDR/kw/5
 fzyun+LLu1Bz6VR3et5ncvGTGd2zZ0crELNIZt1XljwItrQLjdQr9WyuSoR63zKH7jD+g
 t9ia37U8c5hXHKN/+yPhStwg9hS38R/dYgmB4U3reB4GkHJ6was2dHkjB9SIxFqDWNw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=postmarketos.org;
 dkim=pass header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=oZVCULRB; 
 arc=none smtp.remote-ip="2001:41d0:1004:224b::4f"
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 13 Oct 2026 11:14:03 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=oZVCULRB
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::4f; helo=mta0.migadu.com;
 envelope-from=funderscore@postmarketos.org; receiver=<UNKNOWN> 
Received: from mta0.migadu.com (out-79.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::4f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FF27400C5
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:14:02 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=JvfgP+ltAITpV9k2vc83vvFTxclxGU0P1lhzYmqpr2M=; 
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791890040; v=1; x=1792494840;
 b=oZVCULRBs3As7yy+sOGJawhU1FQzwlJnHjifoAhmnx+ihCmt1rLP0YOjoXLriMc4qZvZbgIK
 fM3BdAO+bF/7FELX8KgwnulD7fA/jNZXDtfpBAItkGad8q+uTDhI9T++4BNKOfkMFS0GTOry/T6
 Q6IINULrfyUYq8GdEfVeT3Otjxl55QZcu00a1VHSh33wYJ/0Tau1D2jDvTX5D9WwNdq+z5gjVSg
 ma0LfRB3dZZYy0DndcI5tT5Wa8M3x7qqS7zjtx5coKj77WiJNMLLktlngieF2xCY/FK5CvRaOGQ
 Rt3OYStfG41fNeb986DPhRGUPlrR+pMT6Nl4pMvmXEjWg==
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 3cbba7a6aefa8e38;
 Tue, 13 Oct 2026 11:12:57 +0000
X-Mizu-Trace-ID: 3cbba7a6aefa8e38
X-Migadu-Flow: FLOW_OUT
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 11:12:53 +0000
Message-Id: <DM3NZDMWLXUO.3BY4A60QYUEW1@postmarketos.org>
Cc: "Rayagonda Kokatanur" <rayagonda.kokatanur@broadcom.com>, "Tom Rini"
 <trini@konsulko.com>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Casey Connolly" <casey.connolly@linaro.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Johan Jonker" <jbx6244@gmail.com>, "Tien Fong
 Chee" <tien.fong.chee@altera.com>, "Michael Srba" <Michael.Srba@seznam.cz>,
 "Sumit Garg" <sumit.garg@oss.qualcomm.com>, "Aswin Murugan"
 <aswin.murugan@oss.qualcomm.com>, "Simon Glass" <sjg@chromium.org>,
 "Hongyang Zhao" <hongyang.zhao@thundersoft.com>, "Balaji Selvanathan"
 <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v7 8/8] doc: qualcomm: Add snagboot mode documentation
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: <balaji.selvanathan@oss.qualcomm.com>, <u-boot-qcom@groups.io>,
 <u-boot@lists.u-boot-project.org>, <sumit.garg@kernel.org>
X-Mailer: aerc 0.21.0
References: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
 <20261013-snagboot-v7-8-fc296a32836a@oss.qualcomm.com>
In-Reply-To: <20261013-snagboot-v7-8-fc296a32836a@oss.qualcomm.com>
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

Hi Balaji,

(sorry, I didn't mean to send this off-list)

Some drive-by feedback following:

On Tue Oct 13, 2026 at 1:53 AM UTC, Balaji Selvanathan via groups.io wrote:
> Add documentation for snagboot mode support on Qualcomm platforms.
> This covers build steps to compile U-Boot for Snagboot mode for
> Lemans-EVK along with the architecture, execution flow, and Snagboot
> enablement requirements.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v7:
> - Rebased on top of latest file
>
> Changes in v5:
> - Added build steps for U-Boot in Snagboot mode
>
> Changes in v4:
> - Newly added in v4
> ---
>  doc/board/qualcomm/index.rst    |   1 +
>  doc/board/qualcomm/snagboot.rst | 224 ++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 225 insertions(+)
>
> diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
> index 56b8d894c2a..b8bc37bb384 100644
> --- a/doc/board/qualcomm/index.rst
> +++ b/doc/board/qualcomm/index.rst
> @@ -17,3 +17,4 @@ Qualcomm
>     rdp
>     signing
>     spl
> +   snagboot
> diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboo=
t.rst
> new file mode 100644
> index 00000000000..0cbde61253d
> --- /dev/null
> +++ b/doc/board/qualcomm/snagboot.rst
> @@ -0,0 +1,224 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Snagboot Mode for Qualcomm Platforms
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +
> +Snagboot is an open-source, scriptable flashing framework that provides
> +an alternative to the proprietary Firehose protocol for device
> +provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
> +Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
> +and execute bootloaders. However, instead of using the proprietary
> +Firehose programmer, Snagboot loads U-Boot into DDR and uses the
> +standard fastboot protocol for device flashing.
> +
> +The framework consists of three modular components:
> +
> +* **snagrecover**: Downloads XBL/QCLib to initialize DDR and load U-Boot=
 into RAM
> +* **snagflash**: Communicates with U-Boot over USB using fastboot to fla=
sh system images
> +* **snagfactory**: Orchestrates parallel factory flashing tasks
> +

It might be worth just linking to snagboot documentation. This overview
makes it seem like Snagboot was made specifically for Qualcomm which it
is not.

> +Why Snagboot?
> +-------------
> +
> +* EDL + Firehose remains the default and supported factory provisioning =
flow
> +* Customers are requesting support for Snagboot, an open, scriptable fla=
shing framework,
> +  as an alternative option
> +* Snagboot reuses Qualcomm recovery primitives and standard flashing pro=
tocols,
> +  minimizing platform disruption
> +* Provides an open-source alternative to proprietary flashing tools
> +

I would drop this whole section, it's not useful.

> +Architecture
> +------------
> +

This IMO is better suited in a different doc? I would personally try to
keep this solely for usage instructions.

Or at least put usage instructions first, since that'd be what most
users are interested in.

> +Snagboot Execution Flow on Qualcomm SoCs
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The snagboot execution flow consists of two main phases:
> +
> +**Phase 1 - snagrecover**:
> +
> +1. ROM code enters recovery mode (EDL)
> +2. Snagrecover uses Sahara protocol to download XBL/QCLib to internal me=
mory
> +3. XBL executes and initializes DDR
> +4. Snagrecover downloads U-Boot into DDR
> +5. Control transfers to U-Boot
> +
> +**Phase 2 - snagflash**:
> +
> +1. U-Boot runs in DDR and enters fastboot mode
> +2. Snagflash communicates with U-Boot over USB using fastboot protocol
> +3. System images are flashed to non-volatile memory (UFS, eMMC)
> +
> +Boot Environment Considerations
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In the snagboot execution flow, ROM code in recovery mode loads
> +snagrecover, which downloads XBL to internal memory. XBL executes
> +and initializes DDR, then snagrecover downloads U-Boot into DDR and
> +transfers control to it. At this point, XBL has left the MMU enabled
> +with its own page tables and has not initialized PSCI firmware or
> +populated the Command DB. U-Boot must handle this non-standard boot
> +environment to enter fastboot mode for device flashing.
> +
> +This is why several standard U-Boot features must be disabled in snagboo=
t mode.
> +
> +Comparison with Traditional EDL+Firehose
> +-----------------------------------------
> +
> +**Standard Device Provisioning Path Using EDL and Firehose**:
> +
> +* **Emergency Download Mode (EDL)**:
> +
> +  * EDL is a special boot mode built into Qualcomm SoCs Primary Bootload=
er (PBL) in ROM
> +  * Triggered via hardware strap, software command, or recovery from boo=
t failure
> +
> +* **Sahara Protocol (Stage 1)**:
> +
> +  * Host PC uses Sahara protocol to communicate with the SoC's PBL
> +  * Transfers Device programmer (Firehose) into RAM
> +
> +* **Firehose Protocol (Stage 2)**:
> +
> +  * Once the Firehose Programmer is running on the device, it establishe=
s a Firehose
> +    protocol session with the host
> +  * Host sends XML-based commands to flash firmware images to specific p=
artitions,
> +    erase or read flash memory and manage partition tables
> +  * Integrated into tools like QFIL and PCAT
> +
> +**Snagboot Alternative**:
> +
> +Instead of loading a proprietary Firehose programmer, Snagboot loads U-B=
oot into DDR
> +and uses the standard, open-source fastboot protocol for flashing operat=
ions.
> +

I as an end user don't find this whole comparaison section useful, I
suggest dropping it.

> +Supported Platforms
> +-------------------
> +
> +Currently supported platforms:
> +
> +* **Lemans-EVK **: Initial platform with snagboot support
> +
> +Additional platforms can be enabled by following the board enablement gu=
ide below.
> +
> +Board Enablement
> +----------------
> +
> +To enable snagboot mode on a new platform, follow these steps:
> +
> +Using the Config Fragment
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +A reusable config fragment is provided at ``configs/qcom-snagboot.config=
`` that contains
> +all common snagboot settings. Include it in your platform-specific defco=
nfig::
> +
> +    # Configuration for building U-Boot for snagboot/recovery mode
> +    # on <Your Platform> boards.
> +    #
> +    # For normal production boot, use <platform>_defconfig instead.
> +
> +    #include "qcom_defconfig"
> +    #include "qcom-snagboot.config"
> +
> +    # Platform-specific settings for <Your Platform>
> +
> +    # Address where U-Boot will be loaded
> +    CONFIG_TEXT_BASE=3D0x1c100000
> +    CONFIG_REMAKE_ELF=3Dy
> +    CONFIG_FASTBOOT_BUF_ADDR=3D0xdb300000
> +    CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/<your-board>"
> +
> +    # Timer frequency for your platform
> +    CONFIG_COUNTER_FREQUENCY=3D19200000
> +

From here to

> +Enabling ``CONFIG_QCOM_SNAGBOOT_MODE`` (via the fragment) automatically =
selects:
> +
> +* ``CONFIG_QCOM_BOOT0_SNAGBOOT_MODE``: Early boot initialization
> +* ``CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK``: Enable boot0 hooks
> +* ``CONFIG_SKIP_RELOCATE``: Skip relocation (U-Boot runs from load addre=
ss)
> +* ``CONFIG_ENV_IS_NOWHERE``: Ensure recovery works even with corrupted e=
nvironment
> +  storage, since a recovery mechanism should not load a potentially brok=
en or
> +  untrusted environment from the board
> +
> +It also enforces the following at the Kconfig level via ``depends on !X`=
`, so these
> +configs cannot be enabled together with snagboot mode:
> +
> +* ``CONFIG_PSCI_RESET``: Not available in Snagboot mode (XBL doesn't ini=
tialize PSCI firmware)
> +* ``CONFIG_IOMMU``: Not initialized by XBL in Snagboot mode
> +* ``CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR``: Previous bootloader cont=
ext is not preserved
> +  in snagboot mode
> +* ``CONFIG_ENV_IS_IN_SCSI``: Not available in Snagboot mode
> +
> +``CONFIG_QCOM_SNAGBOOT_MODE`` also requires ``CONFIG_COUNTER_FREQUENCY``=
 and
> +``CONFIG_TEXT_BASE`` to be set to a non-zero value.
> +

to here, I would drop, it's not very useful. I'd expect developers to be ab=
le to
look at the source code for these kinds of details.

> +You still need to set the following platform-specific values in your def=
config:
> +
> +* ``CONFIG_COUNTER_FREQUENCY``: Set to your platform's timer frequency (=
e.g., 19200000 for Lemans)
> +* ``CONFIG_TEXT_BASE``: Set to the address where XBL will load U-Boot (e=
.g., 0x1c100000 for Lemans)
> +* ``CONFIG_FASTBOOT_BUF_ADDR``: Set fastboot buffer address for your pla=
tform
> +
> +Example: Lemans-EVK
> +^^^^^^^^^^^^^^^^^^^
> +
> +See ``configs/qcom_lemans_snagboot_defconfig`` for a complete example of=
 a
> +platform-specific snagboot defconfig.

I would drop this section.

> +
> +Building U-Boot for Snagboot
> +-----------------------------
> +
> +Build Steps
> +^^^^^^^^^^^
> +
> +First, setup ``CROSS_COMPILE`` for aarch64. Then, configure and build U-=
Boot for
> +the Lemans EVK platform::
> +
> +    $ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
> +    $ make O=3D.output qcom_lemans_snagboot_defconfig
> +    $ make -j8 O=3D.output
> +
> +Expected result: the build completes without errors and ``u-boot.elf`` i=
s
> +available in the ``.output`` directory.

Drop this sentence.

> +
> +Signing Prerequisites
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +* ``u-boot.elf`` (generated from build, located in ``.output/``)
> +* ``swiv_build_utility.py`` =E2=80=94 download from:
> +  https://github.com/qualcomm-linux/boot-firmware-ci/blob/main/tools/swi=
v_build_utility.py
> +* ``qtestsign`` =E2=80=94 clone from ``msm8916-mainline/qtestsign``::
> +
> +    git clone https://github.com/msm8916-mainline/qtestsign

It's not useful, just tell people commands to fetch these two latter

Additional tooling
^^^^^^^^^^^^^^^^^^

In order to generate a working image, we need ``qtestsign`` and
``swiv_build_utility.py``::

    git clone https://github.com/qualcomm-linux/boot-firmware-ci/
    export SWIV_BUILD=3D"$PWD/boot-firmware-ci/tools/swiv_build_utility.py"
    git clone https://github.com/msm8916-mainline/qtestsign
    < installation instructions for qtestsign >

> +
> +Step 1: Generate SWIV ELF
> +""""""""""""""""""""""""""
> +
> +Add the SWIV segment required for TZ-based signing::
> +
> +    python3 swiv_build_utility.py \
> +     .output/u-boot-swiv.elf \
> +     .output/u-boot.elf \
> +     lemans
> +

-----8<-----
> +Output::
> +
> +    .output/u-boot-swiv.elf

Drop
-----8<-----

> +
> +Step 2: Sign Image Using Qtestsign
> +""""""""""""""""""""""""""""""""""
> +
> +Sign the SWIV-enabled ELF using qtestsign (test-key signing)::
> +
> +    <path_to_qtestsign>/qtestsign -v 6 -o .output/u-boot.mbn tz .output/=
u-boot-swiv.elf
> +
> +Output::

Drop this line

> +
> +    .output/u-boot.mbn -> Final Binary to be flashed

and this line. Instead I would say:

This generates the final ``.output/u-boot.mbn`` binary, that can then be
used for snagboot.

> +
> +References
> +----------
> +
> +* Snagboot project: https://github.com/bootlin/snagboot
> +* Snagboot documentation: https://github.com/bootlin/snagboot/tree/main/=
docs
> +* Qualcomm EDL mode: See your platform's technical documentation

May I also ask, if you got help from AI to write this?

Best regards,
Ferass
