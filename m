Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E98C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 11:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1ECF81E13;
	Wed, 30 Jul 2025 13:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ys1CY6lV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F337582BA1; Wed, 30 Jul 2025 13:14:02 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC41F81E06
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 13:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-55b81b58eb7so589070e87.2
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 04:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753874040; x=1754478840; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cX+Hq9u4J8NA0fIy43np69sBRMc4bHVX3uMyDAp3/dE=;
 b=Ys1CY6lV79U9h0G3a5pgSi4yx4tbhugfsfV77BRja/sWoxYmlMtZSYtZHEa7sw5fBO
 dx8rN+fWtydk3AvuEkod5FsqXTORqKDvGWvHip6XBPCtMIofTb4HvnSHeO70gqAat1vl
 7OFwC44ol8Ict/1BDs00ojgRYHmrQzfohU2UpCLbduyBgmMFtLIZRS/bOTHghGrMSGEP
 GzuR4u8TSYAaSAgKr+F214YJk/AXhdPpE8OpHmI6Y8oZE65XhKhCkRHcP954Sf/JSVaO
 k5HoJmYS+ygCcPqZResLCzagZlYsL8Ns6FVlTOd/cj8sLHu9Ozxr09Rl02HWPs3HBpSY
 DHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753874040; x=1754478840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cX+Hq9u4J8NA0fIy43np69sBRMc4bHVX3uMyDAp3/dE=;
 b=T6F01aRR9au5ti/imGlE1mFGT/v24AlYcRwNg7ojXhrIITZFW8/2k9RO6Mwf5HNoug
 8HcsvLybHgXweJPcpmIP6dxU/A4B6tVGm4nKyOpD4qY0efI38v7m8ey2+oryNV871sBm
 /WGoLtZBtOfX2wtMT2ofB/kV3JDU4FCHnLl51Cf4PEi+5wJsZZattmHffXvUBPvAmFl1
 VTH5HYPshtD/aSDLSD2KqZYg+CeUbCPe4wvRaP1wPQSshdwkviujycLGLsA6wT/aLwKl
 yoK3kOgR7fKMdd0Mud5D8MmcA71U24QgolQjeiv+hKEc8iwidAYBbDIhhfG/QvA5Zjav
 ibLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXobAFqMlACJZRjg55+YalrX5N4wodxUEt3fg8FgDLow7i3hpSUaHur1jn9wHna2h1Ao7/oPxU=@lists.denx.de
X-Gm-Message-State: AOJu0YzNF1IKJzwGhu25qTtwmhRgkguaNv+9nfmUOma3CMN7J2IcVkae
 lJjZtqBJDuYTWlcqfsUUbiKs8E7zr3KBNokEkogiJ4NcGTuFDSCY4f2KXlYzw7sFIpnNBd/PUXV
 BMWYMLqRUqDDNeiP7vSSctpRP9m+0N10=
X-Gm-Gg: ASbGncvTrC64sNRQD1flJkSLB3sYGkkPQTcuV8gm9ljxq/NfsuG04qWzr+nvCCvxh31
 WiZm8b8LO8iL8jYLpR2CApICiocfR8ZNJOxh/PALVvGuEHMOHf/0jDlnJziG6IR+yNpwYIebQRJ
 AkqqkB5jwhhy8E0eY4af0BayB+jJAod4WANRjvX3djufZORqzTCWLMKI+uDNL7wBSZL/V817JiV
 b/MZqjtw5ngsV2nQx1347KZe/HbWQSR9qqNHso=
X-Google-Smtp-Source: AGHT+IHfplZQs//127P36LG1ClKiZTKUsCNth/HpNRt0sL7F2tGl4y+YVYgFBVRDA79drbEzUZJYNXY7Us65u3r0eTc=
X-Received: by 2002:ac2:4c4b:0:b0:553:2fec:b139 with SMTP id
 2adb3069b0e04-55b7c02c650mr923443e87.24.1753874039749; Wed, 30 Jul 2025
 04:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
 <20250728-ddr-imx-v1-8-73da75bb33d3@nxp.com>
In-Reply-To: <20250728-ddr-imx-v1-8-73da75bb33d3@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Jul 2025 08:13:48 -0300
X-Gm-Features: Ac12FXwzkSBSaNHo8vwNZLjygud-grsrBWGS90zA1jPrsC5dFDi7y3rqfhPAqi8
Message-ID: <CAOMZO5D=p-BHD6KTLVWo_A-Gp+rn0k19Z-WFmtbS9o-x6stxzg@mail.gmail.com>
Subject: Re: [PATCH 8/9] ddr: imx9: Implement Synopsys LPDDR PHY QuickBoot flow
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Jul 27, 2025 at 11:14=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Viorel Suman <viorel.suman@nxp.com>
>
> Implement Synopsys LPDDR PHY QuickBoot flow.

What does "QuickBoot flow" mean? What are the motivations/advantages
of adding support for it?

Please expand the commit message to explain why you are doing this.

> +config IMX_SNPS_DDR_PHY_QB
> +       bool "i.MX Synopsys DDR PHY QuickBoot mode"
> +       depends on IMX_SNPS_DDR_PHY && !IMX_SNPS_DDR_PHY_QB_GEN
> +       help
> +         Select the DDR PHY QuickBoot mode on i.MX9 SOC.

Nothing selects IMX_SNPS_DDR_PHY_QB in this series, so this patch is
only adding dead code.

> +static int ddrphy_qb_restore(struct dram_timing_info *info, int fsp_id)
> +{
> +       int i;
> +       u32 to_addr;
> +       struct dram_fsp_msg *fsp_msg;
> +       struct dram_cfg_param *dram_cfg;
> +
> +       fsp_msg =3D &info->fsp_msg[fsp_id];
> +       for (i =3D 0; i < fsp_msg->fsp_cfg_num; i++) {
> +               dram_cfg =3D &fsp_msg->fsp_cfg[i];
> +               dwc_ddrphy_apb_wr(dram_cfg->reg, dram_cfg->val);
> +       }
> +
> +       /* enable the ddrphy apb */
> +       dwc_ddrphy_apb_wr(0xd0000, 0x00);
> +       dwc_ddrphy_apb_wr(0x54008, 0x01); /* SequenceCtrl =3D 0x1 (DevIni=
t Only)*/
> +       ddrphy_w(0x5400c, 0x19, 0x1);     /* Lp4Quickboot =3D 0x1 */
> +
> +       /* Adjust MR14_xy if pstate=3D0 and 2D training data collected du=
ring training phase */
> +       if (fsp_id =3D=3D 0 && (qb_state.flags & DDRPHY_QB_FLAG_2D)) {
> +               ddrphy_w(0x5401c, 0x39, qb_state.fsp[0] >> 8);   /* Train=
edVREFDQ_A0 -> MR14_A0 */
> +               ddrphy_w(0x54022, 0x45, qb_state.fsp[1] & 0xFF); /* Train=
edVREFDQ_A1 -> MR14_A1 */
> +               ddrphy_w(0x54036, 0x6c, qb_state.fsp[2] & 0xFF); /* Train=
edVREFDQ_B0 -> MR14_B0 */
> +               ddrphy_w(0x5403c, 0x78, qb_state.fsp[2] >> 8);   /* Train=
edVREFDQ_B1 -> MR14_B1 */
> +       }
> +
> +       /* save CSRs to address starting with 0x54800 */
> +       for (i =3D 0, to_addr =3D 0x54800; i < DDRPHY_QB_CSR_SIZE; i++, t=
o_addr++)
> +               dwc_ddrphy_apb_wr(to_addr, qb_state.csr[i]);
> +
> +       /* disable the ddrphy apb */
> +       dwc_ddrphy_apb_wr(0xd0000, 0x01);

Lots of magic numbers in this function.

> +
> +       return 0;

No need to return 0. Make the function 'void'.

> +int ddr_cfg_phy_qb(struct dram_timing_info *dram_timing, int fsp_id)
> +{
> +       int ret;
> +
> +       /* MemReset Toggle */
> +       dwc_ddrphy_apb_wr(0xd0000, 0x0);
> +       dwc_ddrphy_apb_wr(0x20060, 0x3);
> +       dwc_ddrphy_apb_wr(0x2008F, 0x1);
> +
> +       /* load the dram quick boot firmware image */
> +       dwc_ddrphy_apb_wr(0xd0000, 0x0);
> +       ddr_load_train_firmware(FW_1D_IMAGE);
> +       ddrphy_qb_restore(dram_timing, fsp_id);
> +
> +       /* excute the firmware */
> +       dwc_ddrphy_apb_wr(0xd0000, 0x0);
> +       dwc_ddrphy_apb_wr(0xc0080, 0x3);
> +       dwc_ddrphy_apb_wr(0xd0031, 0x1);
> +       dwc_ddrphy_apb_wr(0xd0000, 0x1);
> +       dwc_ddrphy_apb_wr(0xd0099, 0x9);
> +       dwc_ddrphy_apb_wr(0xd0099, 0x1);
> +       dwc_ddrphy_apb_wr(0xd0099, 0x0);
> +
> +       /* Wait for the quick boot firmware to complete */

Is there a special firmware for this quick boot firmware?

Please explain the details. It is not clear why or how someone should
enable this QuickBoot feature.
