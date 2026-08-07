Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E23C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 15:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA98B81337;
	Fri,  7 Aug 2026 15:02:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tJjbngK_Obk8; Fri,  7 Aug 2026 15:02:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D21BC81325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786114946;
	bh=6VmMCdgZ8NjRxc0YdFbwoaLF2EgMvbPFp1e6cVWsSPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Hn55YQa0CqzjSl8S/8bQnXCXwH+FCLCj0ykODokxQn3iS6Qd3aVPNKw6QMxZAXst5
	 3Bb1uBBR/TGh+bWhIgRJbIYBls3kXLFt1sSnd4qxkwb4XQV8Ud69sjnhOfahzXEX6+
	 5wcgwhsWZFr7+/yugs7+hTh61FXE8XO9FIM78CDKQgDCUIVKE5wsE2VALC2yeiB7bl
	 lotmAqlDp9rgMqi8YFlRWnPvXWfUmyt9KNEe56w/qeW5f7ZxO3YXpivooOUMW5Wfty
	 /15pZzAylUEQm61xC9u++++urfTLVO+wUGFeq/dfblmvsYb0xCCExdMr3kIGEzfc8s
	 6XN4grGX8GwGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D21BC81325;
	Fri,  7 Aug 2026 15:02:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83125259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 695F440A6C
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:02:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nu-xhiqocllt for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 15:02:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=wens@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 96E2340A39
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96E2340A39
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 96E2340A39
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:02:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97C704370D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647761F00ACF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:02:23 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-39c74c469e8so24808651fa.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 08:02:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqqKAZGPtfWwoMP1hOC1WTnMJ+vJMwv7UJxeRGZXG9qSzCCT5axUMd9gVJkhmu0FQpO8r54MB0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yywn8Yrk1npFAiykcLZ6/InkzMcxvy2AEdnzGEjlKOJgzVNVJ90
 29d2gEpDYN8S5JoOo8PXIgUke+RxF5JeItdO3Pi9f+8py0wYFJJJDQnUTUFyeTDwPeKCfSuaZ7h
 r69LvyrgKgbDkSjaLzF4au6E+9uT/Xm8=
X-Received: by 2002:a05:651c:b09:b0:39d:b5b9:f0f4 with SMTP id
 38308e7fff4ca-39fe569a9c6mr1583231fa.10.1786114941771; Fri, 07 Aug 2026
 08:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
 <20260804-mtk-pmic-mt6366-v1-5-f3b36b8a1a47@baylibre.com>
In-Reply-To: <20260804-mtk-pmic-mt6366-v1-5-f3b36b8a1a47@baylibre.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 7 Aug 2026 23:02:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v67yRrSLi-voJWUpWW-niXqBb63mTTWCYPUnGim5ALW_NA@mail.gmail.com>
X-Gm-Features: AUfX_mz12s80owBdDOVMuqP_tSk58SWcrcwRQcnwO2m_vFwTFtbpngWjXIqKoDk
Message-ID: <CAGb2v67yRrSLi-voJWUpWW-niXqBb63mTTWCYPUnGim5ALW_NA@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm: dts: add mt6366 PMIC include
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786114943;
 bh=6VmMCdgZ8NjRxc0YdFbwoaLF2EgMvbPFp1e6cVWsSPg=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=U1GpauiK/lOXFX3Vioj0b2RZE6q8WF0E+LNILL+qGeYkJYWpDSoHIL6yjnm6N0qGu
 IBfJVrZ6XiN+3QomHrgZtdVfQQ54VQq18p2Pp9Or0XO64TBni41F5RXDSv8Jx+D8Kb
 keU/sh946Nlgh5bCEYVL6WcSp5xRElFhEhaol321VBWDb3UD/+UiPOiPUHbUUH4K+N
 wWFni9FtyrAw5HMon95TRvP7/kqMdKIBElQstr4W7u8FcyrerApsXH8IHZd5dmrHIY
 9urkSZx2gU9+vnk2QDUXTk+4Or0yoGKZufA9YvYCNpUEBfrpDFvfcjxmWZd1/7rE+H
 ptRuXBdyyrKaA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=U1GpauiK
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
Reply-To: wens@kernel.org
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, Aug 5, 2026 at 6:33=E2=80=AFAM David Lechner <dlechner@baylibre.com=
> wrote:
>
> Add a mt6366.dtsi file for the MediaTek MT6366 PMIC. For now, this just
> includes the regulators since that is all that U-Boot uses. This should
> eventually be replaced by an upstream devicetree file.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  arch/arm/dts/mt6366.dtsi | 273 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 273 insertions(+)
>
> diff --git a/arch/arm/dts/mt6366.dtsi b/arch/arm/dts/mt6366.dtsi
> new file mode 100644
> index 00000000000..9b3a23d51b6
> --- /dev/null
> +++ b/arch/arm/dts/mt6366.dtsi
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (c) 2026 MediaTek Inc.
> + */
> +
> +&pwrap {
> +       pmic: pmic {
> +               compatible =3D "mediatek,mt6366", "mediatek,mt6358";
> +
> +               regulators {
> +                       compatible =3D "mediatek,mt6366-regulator", "medi=
atek,mt6358-regulator";
> +
> +                       mt6366_vdram1_reg: vdram1 {
> +                               regulator-name =3D "vdram1";
> +                               regulator-min-microvolt =3D <500000>;
> +                               regulator-max-microvolt =3D <2087500>;

Please don't add default full-range voltages and default names. They
make no sense. Both can be derived from the node and the PMIC's compatible
string.


ChenYu

> +                               regulator-enable-ramp-delay =3D <0>;
> +                       };
> +
> +                       mt6366_vcore_reg: vcore {
> +                               regulator-name =3D "vcore";
> +                               regulator-min-microvolt =3D <500000>;
> +                               regulator-max-microvolt =3D <1293750>;
> +                               regulator-enable-ramp-delay =3D <200>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vpa_reg: vpa {
> +                               regulator-name =3D "vpa";
> +                               regulator-min-microvolt =3D <500000>;
> +                               regulator-max-microvolt =3D <3650000>;
> +                               regulator-enable-ramp-delay =3D <250>;
> +                       };
> +
> +                       mt6366_vproc11_reg: vproc11 {
> +                               regulator-name =3D "vproc11";
> +                               regulator-min-microvolt =3D <500000>;
> +                               regulator-max-microvolt =3D <1293750>;
> +                               regulator-enable-ramp-delay =3D <200>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vproc12_reg: vproc12 {
> +                               regulator-name =3D "vproc12";
> +                               regulator-min-microvolt =3D <500000>;
> +                               regulator-max-microvolt =3D <1293750>;
> +                               regulator-enable-ramp-delay =3D <200>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vgpu_reg: vgpu {
> +                               regulator-name =3D "vgpu";
> +                               regulator-min-microvolt =3D <500000>;
> +                               regulator-max-microvolt =3D <1293750>;
> +                               regulator-enable-ramp-delay =3D <200>;
> +                       };
> +
> +                       mt6366_vs2_reg: vs2 {
> +                               regulator-name =3D "vs2";
> +                               regulator-min-microvolt =3D <500000>;
> +                               regulator-max-microvolt =3D <2087500>;
> +                               regulator-enable-ramp-delay =3D <0>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vmodem_reg: vmodem {
> +                               regulator-name =3D "vmodem";
> +                               regulator-min-microvolt =3D <500000>;
> +                               regulator-max-microvolt =3D <1293750>;
> +                               regulator-enable-ramp-delay =3D <900>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vs1_reg: vs1 {
> +                               regulator-name =3D "vs1";
> +                               regulator-min-microvolt =3D <1000000>;
> +                               regulator-max-microvolt =3D <2587500>;
> +                               regulator-enable-ramp-delay =3D <0>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vdram2_reg: vdram2 {
> +                               regulator-name =3D "vdram2";
> +                               regulator-min-microvolt =3D <600000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-enable-ramp-delay =3D <3300>;
> +                       };
> +
> +                       mt6366_vsim1_reg: vsim1 {
> +                               regulator-name =3D "vsim1";
> +                               regulator-min-microvolt =3D <1700000>;
> +                               regulator-max-microvolt =3D <3100000>;
> +                               regulator-enable-ramp-delay =3D <540>;
> +                       };
> +
> +                       mt6366_vibr_reg: vibr {
> +                               regulator-name =3D "vibr";
> +                               regulator-min-microvolt =3D <1200000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-enable-ramp-delay =3D <60>;
> +                       };
> +
> +                       mt6366_vrf12_reg: vrf12 {
> +                               regulator-name =3D "vrf12";
> +                               regulator-min-microvolt =3D <1200000>;
> +                               regulator-max-microvolt =3D <1200000>;
> +                               regulator-enable-ramp-delay =3D <120>;
> +                       };
> +
> +                       mt6366_vio18_reg: vio18 {
> +                               regulator-name =3D "vio18";
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-enable-ramp-delay =3D <2700>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vusb_reg: vusb {
> +                               regulator-name =3D "vusb";
> +                               regulator-min-microvolt =3D <3000000>;
> +                               regulator-max-microvolt =3D <3100000>;
> +                               regulator-enable-ramp-delay =3D <270>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vcn18_reg: vcn18 {
> +                               regulator-name =3D "vcn18";
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-enable-ramp-delay =3D <270>;
> +                       };
> +
> +                       mt6366_vfe28_reg: vfe28 {
> +                               regulator-name =3D "vfe28";
> +                               regulator-min-microvolt =3D <2800000>;
> +                               regulator-max-microvolt =3D <2800000>;
> +                               regulator-enable-ramp-delay =3D <270>;
> +                       };
> +
> +                       mt6366_vsram_proc11_reg: vsram-proc11 {
> +                               regulator-name =3D "vsram_proc11";
> +                               regulator-min-microvolt =3D <500000>;
> +                               regulator-max-microvolt =3D <1293750>;
> +                               regulator-enable-ramp-delay =3D <240>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vcn28_reg: vcn28 {
> +                               regulator-name =3D "vcn28";
> +                               regulator-min-microvolt =3D <2800000>;
> +                               regulator-max-microvolt =3D <2800000>;
> +                               regulator-enable-ramp-delay =3D <270>;
> +                       };
> +
> +                       mt6366_vsram_others_reg: vsram-others {
> +                               regulator-name =3D "vsram_others";
> +                               regulator-min-microvolt =3D <500000>;
> +                               regulator-max-microvolt =3D <1293750>;
> +                               regulator-enable-ramp-delay =3D <240>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vsram_gpu_reg: vsram-gpu {
> +                               regulator-name =3D "vsram_gpu";
> +                               regulator-min-microvolt =3D <500000>;
> +                               regulator-max-microvolt =3D <1293750>;
> +                               regulator-enable-ramp-delay =3D <240>;
> +                       };
> +
> +                       mt6366_vxo22_reg: vxo22 {
> +                               regulator-name =3D "vxo22";
> +                               regulator-min-microvolt =3D <2200000>;
> +                               regulator-max-microvolt =3D <2200000>;
> +                               regulator-enable-ramp-delay =3D <120>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vefuse_reg: vefuse {
> +                               regulator-name =3D "vefuse";
> +                               regulator-min-microvolt =3D <1700000>;
> +                               regulator-max-microvolt =3D <1900000>;
> +                               regulator-enable-ramp-delay =3D <270>;
> +                       };
> +
> +                       mt6366_vaux18_reg: vaux18 {
> +                               regulator-name =3D "vaux18";
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-enable-ramp-delay =3D <270>;
> +                       };
> +
> +                       mt6366_vmch_reg: vmch {
> +                               regulator-name =3D "vmch";
> +                               regulator-min-microvolt =3D <2900000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-enable-ramp-delay =3D <60>;
> +                       };
> +
> +                       mt6366_vbif28_reg: vbif28 {
> +                               regulator-name =3D "vbif28";
> +                               regulator-min-microvolt =3D <2800000>;
> +                               regulator-max-microvolt =3D <2800000>;
> +                               regulator-enable-ramp-delay =3D <270>;
> +                       };
> +
> +                       mt6366_vsram_proc12_reg: vsram-proc12 {
> +                               regulator-name =3D "vsram_proc12";
> +                               regulator-min-microvolt =3D <500000>;
> +                               regulator-max-microvolt =3D <1293750>;
> +                               regulator-enable-ramp-delay =3D <240>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vemc_reg: vemc {
> +                               regulator-name =3D "vemc";
> +                               regulator-min-microvolt =3D <2900000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-enable-ramp-delay =3D <60>;
> +                       };
> +
> +                       mt6366_vio28_reg: vio28 {
> +                               regulator-name =3D "vio28";
> +                               regulator-min-microvolt =3D <2800000>;
> +                               regulator-max-microvolt =3D <2800000>;
> +                               regulator-enable-ramp-delay =3D <270>;
> +                       };
> +
> +                       mt6366_va12_reg: va12 {
> +                               regulator-name =3D "va12";
> +                               regulator-min-microvolt =3D <1200000>;
> +                               regulator-max-microvolt =3D <1200000>;
> +                               regulator-enable-ramp-delay =3D <270>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vrf18_reg: vrf18 {
> +                               regulator-name =3D "vrf18";
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-enable-ramp-delay =3D <120>;
> +                       };
> +
> +                       mt6366_vcn33_bt_reg: vcn33 {
> +                               regulator-name =3D "vcn33";
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3500000>;
> +                               regulator-enable-ramp-delay =3D <270>;
> +                       };
> +
> +                       mt6366_vmc_reg: vmc {
> +                               regulator-name =3D "vmc";
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-enable-ramp-delay =3D <60>;
> +                       };
> +
> +                       mt6366_vaud28_reg: vaud28 {
> +                               regulator-name =3D "vaud28";
> +                               regulator-min-microvolt =3D <2800000>;
> +                               regulator-max-microvolt =3D <2800000>;
> +                               regulator-enable-ramp-delay =3D <270>;
> +                               regulator-always-on;
> +                       };
> +
> +                       mt6366_vsim2_reg: vsim2 {
> +                               regulator-name =3D "vsim2";
> +                               regulator-min-microvolt =3D <1700000>;
> +                               regulator-max-microvolt =3D <3100000>;
> +                               regulator-enable-ramp-delay =3D <540>;
> +                       };
> +               };
> +       };
> +};
>
> --
> 2.43.0
>
