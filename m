Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9C2C5DF8C
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 00:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F2FE60B0A;
	Sat, 22 Aug 2026 00:51:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r9yryNF7kqVB; Sat, 22 Aug 2026 00:51:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787359896;
	bh=chYeRd7KQSXEtFeM+q51+wiYkgqHCcbfPScbRSjVGXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DVm0rCdyVWIqH5jOhweNx3cAoMWiGoEN9CMiNDp1Zj1lt6SfbtDKsCFbETdrg1fA5
	 tNMjIjMJSkWZj2ydkZgC1SJEh9vPeurMvb86tQH1uDH/gdenBlManUJJGF3q3plZgv
	 SmmyxSB5SSknoNHrCLOOXv0Fu4wIEo6+7RnXNNYWtrbe3K5xE0SP1ckXJA7nv8IyHb
	 6nnHu1M8TNLDHxqgnlbicJxp7yuVvfIYVVcrnoE6gmX3py0IfxYCxMPxr24DLRksfA
	 P4DF1MBynvPCWdMW5mWneDVtg8TmFLf5aavdAj2mv5Bb6qteBzLzVQ62rK2W0VWQ4x
	 kQupDrADfJwEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22A3B60AB2;
	Sat, 22 Aug 2026 00:51:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 71981336
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 00:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E668409DB
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 00:48:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y8JZlQUUORLr for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 00:48:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=UPoDHDaf
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 65BAB409D9
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 00:47:57 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5b0231a3e86so1538156e87.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 17:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787359675; cv=none;
 d=google.com; s=arc-20260327;
 b=c1ADS241GdG1jhQVt5F/dPCsEeQjhki4FpOROgYiRFaaB9FyptwV2SVm8t99mSlamU
 b4q8slOggJlznWSBJqJw5qNrkEO9lMyPW4fMYdbgk7vWBq+3YVdb7NL1TYvxqnlEA+3C
 8EdhEmHaHvMHhtEzqA9B5rtf188tIR7eOP/TOkGdRT5bf004VuPSnBhgkfwNRJ0H5nDM
 X9R+mp3VXbdpP6R1JBELeDcIlg+gW76FKaEaXK+iMzm+L0scEGOPYeiSHE7VpBBb5Hsb
 PnWGLKeq23jA0CgizcnsNFYCpdrBG5Kx4ubWmFSGj4kIyqABLLRs6pGbzM6ww77F1rup
 n9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=chYeRd7KQSXEtFeM+q51+wiYkgqHCcbfPScbRSjVGXg=;
 fh=rcG6JyeqvbmCj47IOpsi8nXcrfuk1VV+lLPiz5L+/bo=;
 b=OemZINITQp4sPvoNBU0QjUAa3oUKk2c3y5IIJPaP4XMXhVfvltLi7Oj4o01i06b7GF
 izBfPK0Iauf7cjNHI9hXMRI4xr73WYv+Eb8Nw2k+aQniAGSZ95VH5TkEF2DGi3NDZ/m7
 nxt3eGP7ZCNWT2P2fI5O/vyMdQQjZbq2dcUPl2LQZgSx54uu3abTPLoDubR7r4R6QX15
 vbRrHJrnPOvT61n4kYGEpog0m/Xp4jHSkURYaInkwXyd6To7PN7VWEbfGV1UWxQqVNET
 wU+dsDTM8CkiTekNZdziNp57TQ3rw6A2JMq1tAzkeSAJdJ1JnHzt0GXk5rRIyztBN62i
 /jkg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787359675; x=1787964475;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=chYeRd7KQSXEtFeM+q51+wiYkgqHCcbfPScbRSjVGXg=;
 b=UPoDHDafZdP/8yhlj1VV22J/KiOeJa7SSQJBbBAm6q1bQfDBkeZlNqEk3/+F4B1lfW
 8e+xy+dNk7xZN44UtZIC8mBCkHcF/CzFY1y7WLea5AbBsKWYBjwCQk9ocoknmwtIbIfN
 R+M6U0YZIrmEeALm8xuaxq7HRb9JtRtJvh8Lk5J9L1xc3QREoWPFYLR3D67+rkJfSB5p
 jubMHvFpujsFLR62u5cJoG+bo7lgs3L1SNX1DM96UjcLRBs1zqSq8u890XzM30yvzZzu
 C4PnxAaDG64z4SetRnTgyit9OEoznhzOKdMgHGrVZ60EBS/dm8fVBSU7qUkX6jdVI8x1
 CJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787359675; x=1787964475;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=chYeRd7KQSXEtFeM+q51+wiYkgqHCcbfPScbRSjVGXg=;
 b=os4HwTEB8FfIYyz+4YZ48amevi/mJH9RRoMU7gExTK0nIC719x96lDshZtKoGREyLH
 Zr+GZ5z11eTJlWvnLd1YYqG2rPhLsUsP+DJhktf59+Pk+mASm4NnyaBW41KA9Bl+dQuR
 X507k1AN0ObFg9ntIRQdNeYObcntew27x+mwVzMcfCpQ/GSDtxBGlLi03Pto3HLYas7F
 Qdxxsgg0fXdIYbB2YSBdaV9zW7XdlfknRb4BhnI40qUhbsFvRs5sET6hewwJSHH/54KD
 Amhg++CRAldJIrq8jfaoyJ8VizKIohS833jw5PDPGp1I44fQsuRdlOD/KN9S2Kw5L98f
 jL6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeQuTcK2fAA5usS/s4wbZD8F4SOxUbGOFPrzrnK3FNFtKoNSlRZb5ruR1vz+yki5U52fU95YY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lxsPZ1dbaQc0oyxm9539M4VGJIEP5KBw2ARQutOYJZdtfsBB0V
 lT2XNWttBSSPe6zP7Xm4i0VZcWhRiXEXSb69QPJ188cc2fKTb0xUsNZgls9Z5xY29fk34/Rk3OP
 5OFOF+ih/j2tVDWVt319cd9tOwiek4iZVEHwJM3Qbgg==
X-Gm-Gg: AR+sD11rnaxyBRTXDcH8ri/cfeDPt1thei7ZeNiDKi6Xlbmx7S9ZMGvYPnVGf1y5bH2
 vmdz+QDr4OxDHhEjVSrUvZY0liG16YeTx7RXbNuJy4R1lmIdXtBLGjFXYc4vUz0vP0RgcGXHi4x
 Cf8b1BI2eHguA2NhBP2fCZeCPvLYxW1Vce4cgoAklsP4TKgTOoxVRNteg+lrqchpny1AWqyM1pn
 8K2qh54lJBa2wwaX4W1U5xf2WXN34j76kwpSSMPpeJrUEmQYBMK63tgJ/EftmUD0/+lYK9JUcYT
 p5nPhbUAtRDnpkYSuripSRFjfpfjdKhCvVXxB2Rk6zPuigkCmRGtGtm3lIaEz0jg9/y8hALzpp2
 tmxjzYzpHfzrkGkTX1DmSQn7dFm4hpPX95pjfEoK4dwnziKI5ztR+eq6UWAR/z7JR0ppNOXTMZU
 RXxyxBD/gKH5Tf
X-Received: by 2002:a05:6512:31cc:b0:5b0:1516:8799 with SMTP id
 2adb3069b0e04-5b48b89e472mr660072e87.17.1787359675468; Fri, 21 Aug 2026
 17:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
 <20260821164257-GKA579897@kernel.org>
In-Reply-To: <20260821164257-GKA579897@kernel.org>
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 22 Aug 2026 08:47:44 +0800
X-Gm-Features: AcwNN1WIjYVP7OVPOotYCEygKlFYRw_KL3uDWxnFKW7LM-R8CoKD4n-DFiNuYBQ
Message-ID: <CAH22mJzoRX6n=YgSRMukLOF6-ybPgHS2jmraoQLjB1LvG7jQVQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/19] spacemit mmc driver
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Yixun Lan <dlan@kenrel.org>,
 Alex Elder <elder@riscstar.com>, 
 Yixun Lan <dlan@gentoo.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
 Vincent Legoll <legoll@online.fr>, Troy Mitchell <troy.mitchell@linux.dev>, 
 Margherita Milani <margherita.milani@amarulasolutions.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Andre Heider <a.heider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 22 Aug 2026 00:51:34 +0000
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

On Sat, Aug 22, 2026 at 12:43=E2=80=AFAM Yixun Lan <dlan@kernel.org> wrote:
>
> Hi Eric
>
> On 11:54 Wed 19 Aug     , Eric Chung wrote:
> > This series adds MMC support for the SpacemiT K1: an SDHCI platform
> > driver, the SD card device-tree overlay, defconfig options, and SPL
> > boot-device selection from the SoC strap/config registers. The SDHCI
> > driver is usable in both SPL and U-Boot proper.
> >
> > A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
> > write images to eMMC.
> >
> > ---
> > Changes in v9:
> > - spl: Enhance detection on booting from SD.
> > - dts: Synched upstream DTS files for K1.
> > - doc: Create SD card image from scratch.
> > - mmc: Avoid to use CMD18 on SD card in SPL.
> ..
> > - pinctrl: Drop "fix drive strength configuration".
> Could you please explain why this patch is dropped?
>
> It looks valid to me, also it fix a problem that setting drive strength
> actually clear out other pin conf bits which lead to serious bug

Ah. I should drop "fix pull-up/pull-down configuration" instead. I
picked the wrong patch.

>
> -               clrsetbits_le32(addr, PAD_DRIVE, ds);
> +               clrsetbits_le32(addr, PAD_DRIVE, FIELD_PREP(PAD_DRIVE, ds=
));
>
> --
> Yixun Lan (dlan)
