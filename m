Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF6606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XAHWgCyY;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ofk9Z68T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B492580E49;
	Mon, 16 Nov 2026 07:59:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3yfsdAYN_SHx; Mon, 16 Nov 2026 07:59:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 375A480E3F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794815959;
	b=hgugK4vDDTKjORyOoEMI0evOw6cAvBujIyq4+2wSQRTHm5tATlehg6ouqLoiGuytDCu6
	 d0+N8K0oCkB1ZBQAgWYk16O4FBhR1mEUCYpXjrkPbtTUpQZ6gm/52d9t9lFV9ORGkfWvH
	 Y98AeoQZ5Q7PlsUTUH51thy3dhVZXDlR5gGkArn4rSjaZZPCsHhOYro+0YW4p8GDzuVFf
	 HrEEBnVCvr2OUAUT0lfLtO6TccjA95ZPzv8SQt3hjxn8xGhotBoGY43CX/V47k6lVOlLr
	 82GvwA7S7IMGn6xLPGJLYifYp6RJZOu1bOM0r1kRuvYpYMgy/E2f76s+zkArAcbSkbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794815959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:X-Mailer:References:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=T+4Ni75zSnRnvrKAnH3Qjpx87n7PCEQw46Se8d1z1r8=;
	b=d3KFbsQ5RdKEFFO8PIpY84FufkVvd8wdlTO7v7aIcmWum8UR6Xr9LDH+pShL0RAzTr2F
	 yEWLPHgGaRl0PHq16sPcKPIinGnIeHDH5fJW31dAJOdUIQZWadl5woXWlB0Hcln0XbnRX
	 elc4uiLUtdvVoZcOKBQEEna6EQN5WRNZ73jlvi3FDNEbJqi/h6bLd6IpVyku11YAkwKrL
	 2g0HWfJZImB8RE2f1IgnlAwYySjLtBoTXSiSZuds0cyw8oiUHkwlI2yDYOwfpIwjleP8E
	 ir8SaadKtUXssSTS6+27QUfqt4515BryXDcepl6XJdd4VWbALgseFym+YOuSMdgKHxw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ofk9Z68T;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794815959;
	bh=T+4Ni75zSnRnvrKAnH3Qjpx87n7PCEQw46Se8d1z1r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XAHWgCyYmWFdlzOIFMEFmnEAJAZt+zwl2QN28/5PhP27brw/5C3rcdcfDIKjvJpKP
	 qhyrIYgne/MDnBzh2XwiADDiKHMf/uW/Bo56YqPpTWmaaewgEUSrFxgDxEOhEMf9UJ
	 23+f170c+09dC41GhFN0tKUrkam6v0Qd3p05HbwmnnKpTB49rDvnRorERO3dJ8Sw9C
	 lAplTKTwAqFg9o768oYk6pBzkH5lvIiqKUQpngodQBh5vyHAFDlKbSsDV9dtTe2Zsv
	 5wNFKNzyltOJwjKYnAFNBHtF/rLfQHsn4gFfsGhkEu+gtFsPru+hilx0woliecVcx5
	 YZtJU0MnKhFZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 375A480E3F;
	Mon, 16 Nov 2026 07:59:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A30841A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:59:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CC0780E3F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MG8qwoShBDkY for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 07:59:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A66EC80E3E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ofk9Z68T
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A66EC80E3E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:59:15 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso16841515e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 23:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794815953; x=1795420753;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T+4Ni75zSnRnvrKAnH3Qjpx87n7PCEQw46Se8d1z1r8=;
 b=ofk9Z68T5lbQE2SGn4fo0YQF5u1RlonvBDWA+3cOdtMyHXC4L0bLhu1IIdBjUlVZ1I
 I6rfS2cZbBs833kD1mBam8Ki0IzwSJPgGTZ4tT30AZgt8HeJ43E78L/h8L5pxZXpA0Kq
 PGoudtD6Kr6cLNT+wbRfwP5SJdBl7H5HC5SV0M9NgaO8bvVoTQw1+HiEA5XJHRwzkRPX
 UzNa+Ky+lpp1lbDpt7KbSeHiLfAV1g2QIyJNuE7nf5VaMIPXT0gWuDXzOnjjbLwiVLA+
 wBZUF+dgkqYwHvxni+6dTppqWDOVsFkl78SKt8fOHRe18IOMsJGxnSebs35dhKkLE92W
 XxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794815953; x=1795420753;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T+4Ni75zSnRnvrKAnH3Qjpx87n7PCEQw46Se8d1z1r8=;
 b=xXcUoT0Fg9BnA/LAyjmuXvHYWMdsc/AK46bLnOTCoNjLSSHDQGgWJjmDhGunlarEIz
 WwamLXOJBP2S0VfbVTUGVbp6FdUYKn4RftYiSJ/6p0ZJQ5xR6Yqm5NMPxbj2klg43p0U
 wpvIq31FJMY+UA4+U++7NExm5f1HW+7K+HpgGvkxx2rrnHWS1jqsetGZIld7HwixZuuO
 rewa8S7YutELaVW4yHO4vCgG6mLNGteAI3352NuaspRclJOW0ZNbqajn6IsbH7O1twiB
 jk4KihQs2x2eQq4cGLW5XbHCYi+p6tgafb7Kn5g8Yv7qW6Cro/TAmsDNfigVOldZ1S7P
 OzDg==
X-Gm-Message-State: APuU4Z8YHaHRVvo3YdG4uz9/qZx8XRuPCj7ib9LaIjMZ+5NtH6StFweq
 +DnPxRMdpgVRoWdA6yc4kWU8bWVZUkbztcgxVuDdHJxqTi+iLtnCPSQcdfrHI20yqUg=
X-Gm-Gg: AYBFou1DEYdPbg7hLYXtBJXHF33c16BuXVyxbVq/6JN0gKhiUQ+QTONQMCoFV9iMrFT
 Q/641abRD00YHB9LqURN+rGDXk+lhmYRLnDpRpYjku4HXBffl6xEf2Tu5XyQp3lkVaHaHoxecjN
 ZQUV7zGXBM12tptx+44Hg7JbVuLwSpDjxu5eFGudeulBeNrlb4PQQw6FQmAJtjPvhUgp3wMLMD4
 jfJPCrWFLOru8LwF7tePtOmpBRmoUaor0z9xDX0MxKYwnwYkkPkze/LP9gOR6dYDBicP+cxcyAZ
 6wSvLYgFfVZP+eXgww3L1yYD5wnMcb5FhH47wBE52gO9IDx+919RvURqHBi01EINKnaQ0XzMZv5
 T240RzkA3Jdbb52wVf24XBl4M5mlfAU32cQhiwQ+eGGVS/Au8ogJ/KcH8ngK2LwSpt9VvB5TXBy
 Y+7zkXSHmCZq0i5l+F8nU0v40T6cWsv1rd0tSB4ZiI64gHqENuHiET6Usa9rIaTA2mVyOBIHNGQ
 RpIpjpstAiAyLSiN3ZX8xdah83QsU8QFc2AlH4Yiafrpdh6upK0uda7kdHqYlZHwFMSYVIr3u2k
 +qEduAKCCAeu5jjj84znS27cZsQDG9dUxA08ymPElXg4A37i6CLQpGXcaTfLrMGFyRUen6mRHS6
 FHfoC5GyCNqQs5hx23Pwtus9VqkQlJrhmGW2P/1ObE55j/fNQUzgEtua4qTdZi2K8ADSwh0TrSF
 TiY3OTJxxObJQ5yqxRC15+ndO7uHZUcaIeLUQcd77U/EnzIausXBPzMe+HYzMXyAAHAlPUCn6NQ
 WH+BT/qp4A6A5qA3hmZYvgqRFXCbG1B4Y0Ti3Zf8xD/MhSLXRiF4ZtySGzgal6o9SPB60lceNzQ
 Woqkk9Err7PF+P6d6lun6eItBPIi89BftZSc1orzN+G1JN+7y/H6m4R3oLpDkFM+Rw8y0qcSN1l
 E4i0V1xvhWfOz42TC7Fcg5UUMDgegXFrSTA==
X-Received: by 2002:a05:6000:2dc9:b0:491:8462:20b6 with SMTP id
 ffacd0b85a97d-49c73ed0fbemr24280366f8f.38.1794815953185; 
 Sun, 15 Nov 2026 23:59:13 -0800 (PST)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d22394esm21424708f8f.3.2026.11.15.23.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Nov 2026 23:59:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 09:59:10 +0200
Message-Id: <DMWH5L5PBF9S.2Z428I5YBXQVU@linaro.org>
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "David Lechner" <dlechner@baylibre.com>, "Tom Rini"
 <trini@konsulko.com>, "Alper Nebi Yasak" <alpernebiyasak@gmail.com>, "Ryder
 Lee" <ryder.lee@mediatek.com>, "Weijie Gao" <weijie.gao@mediatek.com>,
 "Chunfeng Yun" <chunfeng.yun@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "Julien Stephan"
 <jstephan@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, "Macpaul Lin"
 <Macpaul.Lin@mediatek.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>
Cc: <u-boot@lists.u-boot-project.org>, "Michal Simek"
 <michal.simek@amd.com>, "Casey Connolly" <casey.connolly@linaro.org>,
 "Carlo Caione" <ccaione@baylibre.com>
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
X-Mailer: aerc 0.22.0
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
In-Reply-To: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

Unfortunately, I don't have the bandwidth to go throuigh this in detail, bu=
t +1 for
the overall approach.

Thanks
/Ilias
On Thu Nov 12, 2026 at 11:14 PM EET, David Lechner wrote:
> Anyone who has worked on hardware that uses a devicetree for the
> hardware description should know the mantra "the devicetree describes
> the hardware, not the configuration".
>
> Binman is describing configuration and not the hardware itself,
> therefore it doesn't belong in the control devicetree that describes
> the hardware. So we propose encouraging the separation of these two
> descriptions into separate devicetree files. In most cases, binman
> info is not needed at runtime anyway, so combining it with the control
> devicetree is unnecessary, takes up space, and causes DTS validation
> to fail because binman is not part of any standard devicetree schema.
>
> Currently, only Xilinx is doing this kind of separation. This series
> makes it possible for more platforms to adopt this separation. The first
> patches fix binman so that the image gets the U-Boot control devicetree
> rather than the binman one when the two are separate binaries. And they
> make BINMAN_DTB work with OF_UPSTREAM, and document the recommendation.
> The remaining patches update the MediaTek Genio targets to make use of
> all of this.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Casey Connolly (1):
>       binman: support building binman dtb when OF_UPSTREAM is enabled
>
> David Lechner (9):
>       binman: allow a control devicetree separate from the image descript=
ion
>       Makefile: give binman the control devicetree with BINMAN_DTB
>       dts: always build the binman devicetree from BINMAN_DTB
>       lib: Kconfig: do not enable BINMAN_FDT by default with BINMAN_DTB
>       binman: recommend a separate devicetree for the image description
>       arm: dts: mediatek: drop the -u-boot suffix from the Genio binman f=
iles
>       arm: mediatek: describe the Genio images in a separate binman devic=
etree
>       board: mediatek: add a Genio boot images config fragment
>       doc: board: mediatek: use the Genio boot images config fragment
>
>  .gitignore                                         |  1 +
>  Makefile                                           | 16 +++---
>  arch/arm/dts/mt8188-genio-binman.dts               | 15 ++++++
>  arch/arm/dts/mt8189-genio-binman.dts               | 13 +++++
>  arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      | 10 ----
>  arch/arm/dts/mt8370-genio-da-u-boot.dtsi           |  6 ---
>  arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi      |  9 ----
>  arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      | 10 ----
>  arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi      |  9 ----
>  arch/arm/dts/mtk-genio-binman-u-boot.dtsi          | 12 -----
>  arch/arm/dts/mtk-genio-binman.dtsi                 | 26 ++++++++++
>  ...boot.dtsi =3D> mtk-genio-bootloaders-binman.dtsi} |  2 +
>  ...binman-u-boot.dtsi =3D> mtk-genio-da-binman.dtsi} |  2 +-
>  ...an-u-boot.dtsi =3D> mtk-genio-da-fit-binman.dtsi} |  2 +
>  ...-boot.dtsi =3D> mtk-genio-loader-spl-binman.dtsi} |  2 +
>  ...-u-boot.dtsi =3D> mtk-genio-mtk-boot-binman.dtsi} |  3 +-
>  arch/arm/mach-mediatek/Kconfig                     |  5 ++
>  board/mediatek/MAINTAINERS                         |  7 ++-
>  board/mediatek/genio-boot-images.config            |  5 ++
>  doc/board/mediatek/mt8188-genio-evk.rst            |  9 ++--
>  doc/board/mediatek/mt8189-genio-evk.rst            | 14 ++----
>  dts/Makefile                                       | 20 +++++++-
>  lib/Kconfig                                        |  9 +++-
>  tools/binman/binman.rst                            | 22 ++++++++-
>  tools/binman/cmdline.py                            |  3 ++
>  tools/binman/control.py                            | 14 ++++--
>  tools/binman/etype/fdtmap.py                       |  3 +-
>  tools/binman/ftest.py                              | 57 ++++++++++++++++=
++++--
>  tools/binman/state.py                              | 38 ++++++++++++---
>  tools/binman/test/fdt/u_boot_dtb_separate.dts      | 13 +++++
>  .../test/fdt/u_boot_dtb_separate_expanded.dts      | 13 +++++
>  .../binman/test/fdt/u_boot_dtb_separate_fdtmap.dts | 15 ++++++
>  32 files changed, 285 insertions(+), 100 deletions(-)
> ---
> base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
> base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-mediat=
ek.git mediatek-staging
> change-id: 20261106-mtk-genio-binman-dtb-c0be6919e9cd
> prerequisite-message-id: <20261104-ccaione-upstream-spl-fastboot-boot-v2-=
0-cf9781441ed5@baylibre.com>
> prerequisite-patch-id: 15e30b35b9a32d98cea92287c95973bb55655b8d
> prerequisite-patch-id: 74b01d9723a9eebb7a438ae6f3aa84fecbd86a2f
> prerequisite-patch-id: 84ffa226fd432b97e30508988d556056f19488d8
> prerequisite-patch-id: b6ef8f19bc0e45642fadc98a2a70a8a77e16cc31
> prerequisite-patch-id: 6d301cbbd2d389bb156e2f9565f02c7d1eb9fed1
> prerequisite-patch-id: 21aae4cff1307c55e73d737cd68552b6ea1b73f2
> prerequisite-patch-id: 110fc69a696fa4dd74fb7e14a50c97e3b7238a9a
> prerequisite-message-id: <20261022-ccaione-upstream-mt8390-da-v5-0-58982f=
e11312@baylibre.com>
> prerequisite-patch-id: 47bd1028b5d35a3cc00be6cfd2efa94a8fcbf521
> prerequisite-patch-id: aceec0866b3329401896512d235b7e01dc1746b1
> prerequisite-patch-id: 9f0be27b51978f99dd1d301f4e346e323f057407
> prerequisite-patch-id: 94bec74d37c3b2d2b22ffc303d8f2ac567db22c4
> prerequisite-change-id: 20261104-bloblist-tl-fixes-4e2617a399c6:v1
> prerequisite-patch-id: 316b1610fc2e3953677ec152eee8cd5035723f82
> prerequisite-patch-id: 55680c05d9c25c1a5fbd05e2b9f91a5bb1e4c350
> prerequisite-change-id: 20261103-spl-bloblist-pass-regs-3130cf768211:v2
> prerequisite-patch-id: 2aa06c6d07b125147e3a6bcdc620e19f9c5885df
> prerequisite-patch-id: eb93f71f16b3641ae6a369b1b3113656656f65e3
> prerequisite-patch-id: 575d26f405980ef8a1be726c9ca0df679eb77d84
> prerequisite-patch-id: 6b9e9c6e1f9cbc0ef3b716cd8615430680354877
> prerequisite-change-id: 20261013-mtk-genio-720-spl-1620416c6224:v2
> prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
> prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
> prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
> prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
> prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
> prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175
> prerequisite-change-id: 20261013-mtk-mt8189-tfa-fdt-94283317c6c0:v2
> prerequisite-patch-id: 316b1610fc2e3953677ec152eee8cd5035723f82
> prerequisite-patch-id: 55680c05d9c25c1a5fbd05e2b9f91a5bb1e4c350
> prerequisite-patch-id: 2aa06c6d07b125147e3a6bcdc620e19f9c5885df
> prerequisite-patch-id: eb93f71f16b3641ae6a369b1b3113656656f65e3
> prerequisite-patch-id: 575d26f405980ef8a1be726c9ca0df679eb77d84
> prerequisite-patch-id: 6b9e9c6e1f9cbc0ef3b716cd8615430680354877
> prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
> prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
> prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
> prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
> prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
> prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175
> prerequisite-patch-id: ef70f6dcf4e6aea68256028734614efc067c954d
> prerequisite-patch-id: 75640c82cbccc2f173feb4bc6c912c9a321a68c9
> prerequisite-patch-id: 569f315372b1b8f55a5a94f1385175252dc33b9f
> prerequisite-patch-id: b43d50f060dc034ad413c28153ea641e697e5655
> prerequisite-patch-id: f5f6fabf8e9a55c44413a76791d3713fe6415a33
> prerequisite-patch-id: f031399df28961dad8315ffa6ad1ee0ff77116ec
> prerequisite-patch-id: 316728f8f3107d7e9e0b45669d947498b77469a3
> prerequisite-patch-id: 6c889af47fd9df264bf4dc2758c18418c175dd3b
> prerequisite-message-id: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm=
.com>
> prerequisite-patch-id: 8adf07351c5a4eb61976ceeced2d0ab0eadf235d
> prerequisite-patch-id: 55ead548e0a7c82c4296cc9b9fa047f110c1e306
> prerequisite-patch-id: 34bbdb130ae694420b954f41a536b8eb8df77791
> prerequisite-patch-id: 5a62f8304a1790b31accf47af84815bffaa92b89
> prerequisite-patch-id: d2e87bf5a992d19bde372fb230f4589242f12d40
> prerequisite-patch-id: 0429aaac18b3a3d564662f2b93aa3af755c880db
> prerequisite-patch-id: a577a9e2266f5b16dd0bf1b8b4312952f736380d
> prerequisite-patch-id: 3223b00fa7e9c330054e19f256b4e601008160f2
> prerequisite-patch-id: f1cf16250799f803bde22d6dae704cc5338ec76c
> prerequisite-change-id: 20261013-mtk-genio-720-spl-ufs-4ac6af78de70:v1
> prerequisite-patch-id: 79df99b8a797eed3bedbfcbafb7cda7e019f0445
> prerequisite-patch-id: bc8ebcd6928771bcb436408a6c10ac4f00b2c265
> prerequisite-patch-id: 0f5ccd0db365686315ced7255063d0404cdf5250
> prerequisite-patch-id: a435fbd4cca84219d404138e2d8ee1a96d669366
> prerequisite-patch-id: 4407c23f51001d4996a8e790270825fd8281d7f5
> prerequisite-patch-id: 14bb13c537f635ee2589d626e0031e9a80c348d5
> prerequisite-patch-id: 0b59a9f24e103a77700ca1cc99052ba318017b9d
> prerequisite-patch-id: fc1dc7d141126db709479fb8477fe11536e6811c
> prerequisite-patch-id: 2b22eb0b87c0c9e5c35e0b2719eedb3228503dbf
> prerequisite-patch-id: 90108657775725ee881493b1af8e2ae51c8debc9
> prerequisite-patch-id: ba3b4599b6ce497f7bf5bcafd2c93c89a0c7f5d4
> prerequisite-patch-id: b47cebc4433bc3a0e5c3932a8cd64afea88d32a9
> prerequisite-patch-id: a8a6f8e478b4888ff1c6affbcf14f1bb801f6cb9
> prerequisite-patch-id: 537ec57f093f5cc68529116aabb6fec1296e9ed5
> prerequisite-patch-id: bcd4644665e032714d68c49ad9afb36b25b9f418
> prerequisite-patch-id: 1eda3254e8ba4f67886c788467d5cb3e706e51f7
> prerequisite-patch-id: 0396e7309b235e7a577aa54549f260d6561d6cc5
> prerequisite-patch-id: 3ff8b871bc763b373ac93eb095a0ac362f4fb4f9
> prerequisite-patch-id: f3288ee3e395bff11655165a34c9617be55cc52a
> prerequisite-patch-id: 893c19a121729050c2095888af67d5cee32c67d1
> prerequisite-patch-id: 8c900b341eac7dd1b2f69a434b2fa808ac79e914
> prerequisite-patch-id: 180113519aa422aef5b1d6384c8e65a943482cf5
> prerequisite-patch-id: a5493d2e60617de14414c25c63d9f77f3fbc7ca9
> prerequisite-patch-id: 3b798f71b18533fa36c3864daaf3b60099201097
> prerequisite-patch-id: 731b2a85b293eb24b8a9ad5cbd4b2052591ec9d7
> prerequisite-patch-id: f44798150ea9c5cf44a43ba0ee5561ed6d522063
> prerequisite-patch-id: 01bd0fde93d212bbce964da6cc85f5aace84bddf
> prerequisite-patch-id: c5662096f7f5cc7abfd5b178e145fe006737152d
> prerequisite-patch-id: 74e53343d8fb0f2e7baee9848b7d81320910ed4a
> prerequisite-patch-id: f018d9e03bd324a7853ab106eaaeb770f20bfb1a
> prerequisite-patch-id: 95e0ae837a7ba3ca39b2a4b8421ac105234d677a
> prerequisite-patch-id: 88e610436d6e9630fac7212c08251727fbe27fc3
> prerequisite-patch-id: 0949dcf268f48d1fb7ee912fc57188b73fd4ae58
> prerequisite-patch-id: 1474c68c12a790dc0abe513ffa5f71c5d72934eb
> prerequisite-patch-id: fdc92399e83ba67d6f157e7e9fec546624226db6
> prerequisite-patch-id: bb0f680620dd60fe1f55507198c1daba04d51ca0
> prerequisite-patch-id: b60ed43a099f02bf9743f90a7cf474ca844d71d2
> prerequisite-patch-id: f18d63e4e8c0ca8f08573f2395dd58b698e1da27
> prerequisite-patch-id: ce11ab44a0332ef9682d3f6cb34a5f8648a1c619
> prerequisite-patch-id: 3c5e447deebe943a6b8a98c2d017d1c0eab5da25
> prerequisite-patch-id: dc6c98cdbffe9b3f19b8a0fc303f9b2902defa07
> prerequisite-patch-id: 558d3536869699311008e4d6cce6a2a18a727eca
> prerequisite-patch-id: 805a0898b88d8e1291e8262044d1d6bed1d45be2
> prerequisite-patch-id: 8d7155ea7c0941b756129b6a490f9413b51b05ef
> prerequisite-patch-id: 974eaa9cb6adf9749f6225fe1e67dd9433318625
> prerequisite-patch-id: cdb2934ed5393e539f856e6f4de36140cd8ad697
> prerequisite-patch-id: ab91736213909c77894d8e47594f548592f96bb4
> prerequisite-patch-id: 15e30b35b9a32d98cea92287c95973bb55655b8d
> prerequisite-patch-id: 74b01d9723a9eebb7a438ae6f3aa84fecbd86a2f
> prerequisite-patch-id: 84ffa226fd432b97e30508988d556056f19488d8
> prerequisite-patch-id: b6ef8f19bc0e45642fadc98a2a70a8a77e16cc31
> prerequisite-patch-id: 6d301cbbd2d389bb156e2f9565f02c7d1eb9fed1
> prerequisite-patch-id: 21aae4cff1307c55e73d737cd68552b6ea1b73f2
> prerequisite-patch-id: 110fc69a696fa4dd74fb7e14a50c97e3b7238a9a
> prerequisite-patch-id: 2ec906b416c75e44362332459fcd498872a22124
> prerequisite-patch-id: aceec0866b3329401896512d235b7e01dc1746b1
> prerequisite-patch-id: 41d8b9c212ca0950fb1ccbea92d8f62a3c42676a
> prerequisite-patch-id: 94bec74d37c3b2d2b22ffc303d8f2ac567db22c4
> prerequisite-patch-id: 4391fbbb5b04123f46d3eb3ec7b183be7152d338
> prerequisite-patch-id: 08e009e1d4f6ef7fffaddeb82f9e35692bd593e4
> prerequisite-patch-id: 14b40c9224527e76382332cf547d070f1d3a40ed
> prerequisite-patch-id: eca0139a7cedf72a4e8a99324a846dea15392e4b
> prerequisite-patch-id: cde323ef8d773b7dad5a278faaca89bb71405ab1
> prerequisite-patch-id: 6abe9e3824531990933ada4bd58ff483637f3794
> prerequisite-patch-id: 4344564d375dc6002077d382335ce759523ffa29
> prerequisite-patch-id: 316b1610fc2e3953677ec152eee8cd5035723f82
> prerequisite-patch-id: 55680c05d9c25c1a5fbd05e2b9f91a5bb1e4c350
> prerequisite-patch-id: 2aa06c6d07b125147e3a6bcdc620e19f9c5885df
> prerequisite-patch-id: eb93f71f16b3641ae6a369b1b3113656656f65e3
> prerequisite-patch-id: 575d26f405980ef8a1be726c9ca0df679eb77d84
> prerequisite-patch-id: 6b9e9c6e1f9cbc0ef3b716cd8615430680354877
> prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
> prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
> prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
> prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
> prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
> prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175
> prerequisite-patch-id: ef70f6dcf4e6aea68256028734614efc067c954d
> prerequisite-patch-id: 75640c82cbccc2f173feb4bc6c912c9a321a68c9
> prerequisite-patch-id: 569f315372b1b8f55a5a94f1385175252dc33b9f
> prerequisite-patch-id: b43d50f060dc034ad413c28153ea641e697e5655
> prerequisite-patch-id: f5f6fabf8e9a55c44413a76791d3713fe6415a33
> prerequisite-patch-id: f031399df28961dad8315ffa6ad1ee0ff77116ec
> prerequisite-patch-id: 8064ba5bd7cf2db6d127f981b3731001c71d58f2
> prerequisite-patch-id: 6c889af47fd9df264bf4dc2758c18418c175dd3b
> prerequisite-patch-id: 6c44e76abdeb8319ce17dab256fb99ea6a5e77ea
> prerequisite-patch-id: 4680066fad4dcbccf016541a4847c7ace62e2e06
> prerequisite-patch-id: d7159d0635ba309d374f519b37fc39dfdd15d0eb
> prerequisite-patch-id: 070be0db29756ccd90ee239cb9ae5c3b6748cf93
> prerequisite-patch-id: 93318a4ddebf24432063549989b91d9ff998bdec
> prerequisite-patch-id: 55ead548e0a7c82c4296cc9b9fa047f110c1e306
> prerequisite-patch-id: 34bbdb130ae694420b954f41a536b8eb8df77791
> prerequisite-patch-id: 5a62f8304a1790b31accf47af84815bffaa92b89
> prerequisite-patch-id: d2e87bf5a992d19bde372fb230f4589242f12d40
> prerequisite-patch-id: 0429aaac18b3a3d564662f2b93aa3af755c880db
> prerequisite-patch-id: a577a9e2266f5b16dd0bf1b8b4312952f736380d
> prerequisite-patch-id: 3223b00fa7e9c330054e19f256b4e601008160f2
> prerequisite-patch-id: f1cf16250799f803bde22d6dae704cc5338ec76c
> prerequisite-patch-id: 781986f407c7f833f3a157bcaa9b6384f964fe11
> prerequisite-patch-id: bb9dcec311319f2dbac1c3795ec19fc44dc5bd20
> prerequisite-patch-id: d56476ab6a3a7b32a29eea6c811e110a127dfc65
> prerequisite-patch-id: 0d9bf4d3f321845f908bc96dcf0b844c14701218
> prerequisite-patch-id: 24910c0e34355ac74ac3e0701e24d09e18450b90
> prerequisite-patch-id: 640fa47c52c8d79ae409b7077e030cfe8d336287
> prerequisite-patch-id: de19c1094bc466beef1d7d648974f925f7cbfb91
> prerequisite-patch-id: d98337a0fb6f5db044fc303476f609e4d0a5bc0f
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>


