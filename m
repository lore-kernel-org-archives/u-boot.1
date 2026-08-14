Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE143C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 557C660A9A;
	Fri, 14 Aug 2026 18:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S-Ei3Y2JU4FJ; Fri, 14 Aug 2026 18:34:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB9D660A6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732495;
	bh=KxJwouRtFULG87OW+b2L3wBY/dMehC3CtUGmUNHBXeQ=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t+fcdCT0aG5sD6BsLzI6DsnsZ0v8iaNsFzSO2mjrGYuJQ5V7YFc2COvKYa3Nz51/q
	 w7BWJizdf+FsxURBMLeX0ZPnNrm7HOBzvHWWeMsB+oKu5kzGP4lWoSqJLAhJb2u51I
	 Us67QwnmI/ys1iCn/Uf9QOiFsFUvBYJbXxSgyY8NjoO3Uf/0Y0knyRvrkLeZaDfL2Z
	 nEpyO5vKeQorlC0gZC3lYNEpYSM/o9Q/fwuU5ZyRNsEoIrN0CKWnGkZyJrQUACP+sD
	 poIUWHNFPmgbefKrK/3o6/DgkMacBVfS+uOmUJsr1kONuuUwxgN1IlWeP/8+5AccjC
	 giOSXYjDzBY+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB9D660A6D;
	Fri, 14 Aug 2026 18:34:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A2B6C2B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EC4140CDC
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:34:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmRAkyk96jUT for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:34:52 +0000 (UTC)
X-Greylist: delayed 59849 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 14 Aug 2026 18:34:51 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9DA9F4070A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DA9F4070A
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=PgqfjTUU
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DA9F4070A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786732484; x=1786991684;
 bh=KxJwouRtFULG87OW+b2L3wBY/dMehC3CtUGmUNHBXeQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=PgqfjTUUcm4PbMdDKdUWv9tcJAPyAsfU0M7bHcRLlvEgJiZ6g/I3h/QWZ56mhXwvp
 QZmQVgPGUZZSCFQOWnJn/WZdxvN+JCiGzAhXft5OCYLuYk95MBSTHH89gPSorGxvW7
 5sfMT1vTgQYoniyZflZ87dGulwBYSypgjwU3V6xLdKcUVznaj0tia5hLcyOnswGuSO
 9mnwTXl99unYhA1stVYs7QvVzF3M2m+4bnTGVoKbnPymrni755qICa39MWDwkBdJ33
 bKzpurW5KEHPeTTbUNRjU/jgMDCz3JxXKV+dLVh5B0bwPdciVQXrS8JRq7PBt/hcnv
 CK9n6qyk0p/mg==
Date: Fri, 14 Aug 2026 18:34:42 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>
Subject: Re: [PATCH] lib: zstd: update to latest Linux zstd 1.5.7
Message-ID: <dd01c4b5-ed45-4fc7-8670-026aa38ee284@proton.me>
In-Reply-To: <69502f5a39ab3f07b7872cc6dcbf7e86f7e7d42f.1786670589.git.Munzzyy1@proton.me>
References: <69502f5a39ab3f07b7872cc6dcbf7e86f7e7d42f.1786670589.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: caec8865a7f8d3f57d5283b9c940e3d046d8addc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Alexey asked which boards actually carry this and what it costs them, so
here is the data.

Nothing selects ZSTD except fs/btrfs/Kconfig, and nothing selects FS_BTRFS
except CMD_BTRFS in cmd/Kconfig. So a board pays for zstd only if its
defconfig sets CONFIG_ZSTD, CONFIG_FS_BTRFS or CONFIG_CMD_BTRFS, either
directly or through an included .config fragment. Resolving those includes
transitively, that is 41 of 1550 defconfigs:

  am62px_evm_a53                      am62x_evm_a53
  am64x_evm_a53                       dh_imx6
  hc2910_2aghd05                      imx6_dhcom_drc02
  imx6_dhcom_pdk2                     imx6_dhcom_picoitx
  imx8mm-mx8menlo                     imx8mm_data_modul_edm_sbc
  imx8mp_data_modul_edm_sbc           imx8mp_dhcom_drc02
  imx8mp_dhcom_pdk2                   imx8mp_dhcom_pdk3
  imx8mp_dhcom_picoitx                kontron-osm-s-mx8mp
  kontron-osm-s-mx93                  kontron-sl-mx8mm
  m53menlo                            mvebu_espressobin-88f3720
  mvebu_espressobin_ultra-88f3720     sandbox
  sandbox64                           sandbox_flattree
  sandbox_noinst                      sandbox_spl
  sandbox_vpl                         stm32mp13_dhcor
  stm32mp15_dhcom_basic               stm32mp15_dhcom_drc02_basic
  stm32mp15_dhcom_pdk2_basic          stm32mp15_dhcom_picoitx_basic
  stm32mp15_dhcor_avenger96_basic     stm32mp15_dhcor_basic
  stm32mp15_dhcor_drc_compact_basic   stm32mp15_dhcor_testbench_basic
  th1520_lpi4a                        turris_1x_nor
  turris_1x_sdcard                    turris_mox
  turris_omnia

Text growth, measured base vs this patch:

  turris_mox                  +1920
  mvebu_espressobin-88f3720   +1920
  am62x_evm_a53               +2072
  kontron-sl-mx8mm            +2072
  imx8mp_dhcom_pdk2           +2072
  sandbox                     +2888

data and bss are unchanged on every one of them. ZSTD_LIB_MINIFY is default=
 y
under ZSTD and none of the affected defconfigs turn it off, so those are th=
e
numbers boards actually ship. The three i.MX8MP/AM62x figures come from the
linked ELF; those builds stop later at binman for want of vendor blobs I do
not have, with no compile errors.

On a board without zstd there is no change at all. I built qemu_arm64 at th=
e
parent commit and at this patch with SOURCE_DATE_EPOCH pinned: .text and
.text_rest are byte for byte identical.

It is also not in xPL. SPL_ZSTD is a separate symbol, no defconfig enables =
it
and nothing selects it, so this only lands in U-Boot proper.

I did not measure the RISC-V, PowerPC or 32-bit ARM boards in that list, as=
 I
have no toolchain for them here.

