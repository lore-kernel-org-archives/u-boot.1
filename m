Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9481C61DD3
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 01:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AC6F80F3B;
	Sat, 29 Aug 2026 01:50:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GfIxfQc27_Ne; Sat, 29 Aug 2026 01:50:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787968232;
	bh=4wNicaaBGmjCyt3uc1g98iYZpovTD2IJdSDugxqV+9Q=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xE9GIMoZmsrL64f8pAbN9kpoWUgfhB2UvnsMbQ6GjSIvQiQiataBTka6X1gxz43hM
	 bQx6JWbPS8/nxEK7tTOowKB0lAAF1+MM2JGQYcpkOq33WEcweGoWUg/LwrwE8N6hNj
	 gAkGSe0x25JgWfJt0F8Wq+sT2r3irQDAL8jN+N17ma3Y+QccXKWMqUKUiq6uQhsIRC
	 bRjhzf1AVnAIVsMyEVkFpGxLenjTbO43Z0aOUXToX9Il4q4KD0mAQJ/REtN6w12qXo
	 f9xwtmYbTxU45F4VB5tzdK5GcUowDRXwZ+h/khkNXruSwi/EzySJocyJelOnjM2WVP
	 9Ne3wCzghm9Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AF6F80F2C;
	Sat, 29 Aug 2026 01:50:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DE222FD
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 300FF40068
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KIkTObPPYd5i for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 01:50:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::b;
 helo=mail-oa2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qYnlIHIT
Received: from mail-oa2-x0b.google.com (mail-oa2-x0b.google.com
 [IPv6:2607:f8b0:4864:30::b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4E9540056
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:29 +0000 (UTC)
Received: by mail-oa2-x0b.google.com with SMTP id
 586e51a60fabf-467e2b5b74eso724857fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787968228; x=1788573028;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4wNicaaBGmjCyt3uc1g98iYZpovTD2IJdSDugxqV+9Q=;
 b=qYnlIHITF7LRdYw4W0VH+3pwFpVB1FOB5lq6tTWjzM/zBPYHyZQCCIM1dRqxbFuJYp
 OGvLEsPqJh7Us0XuYn30KQx5NCSZ25Vx6lNL0D/L/OkdthFGl+/56LEgsw5aXlMiDXDb
 UbicdxFtITpLGywHtAllKqOrc6vjNQ9L1h3pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787968228; x=1788573028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4wNicaaBGmjCyt3uc1g98iYZpovTD2IJdSDugxqV+9Q=;
 b=hUUyf6Q/YloHDkHWO6B0neMyNzI8VSaDeH8RmGEX4p+DPkLXFxCT1D1tMKe2xitj5/
 BWOO9ft9EmAAt8Wzu/1KWEyP9kHeL6F9KRowAiVY9YzUv0rCORsMWevkhhJAJWDHrBFa
 qSOFI+zW7EUZST7u/nLlqFPuOAp3/6RN2bp7a9vDFrG5LzHMyQqNu6OcMu8L5IEEI5j0
 hRpHuNhhyl/zSrog5ETPd6CEiCA1RJKAnguoMa3WASV1zLrlojwwT79Lo1Ux989WhIT6
 ann2zjUEsID5Nf1TUeZAxCCCwo5LBFzUFssVbVN7lHu16w/5UyVWnh/pmg++vO5UrrqD
 0NSg==
X-Gm-Message-State: AFuF++kFQw+aFZUxGO0Ay+fIKRMMVz6K0RjPuzUv2a0cdzFbE+wUQOUp
 PBYFYbyFWi9i74QU28+9QGCgIxgDz0eucct3sa9z01Snibc657QHtRS186zlXc6YBGSa1jf+SKn
 gSppkmfHgf/F6dHM=
X-Gm-Gg: AR+sD12CtzmjaxpEfFxtnW5RvUp2NK2slF9GkaulfP6Ve1sIV3joljBSIFjeb40S209
 aNcIxzykL8E8yEQABkAPegxKDfJALpf4A1p1gG2jToqDnsQz9bhwOL5jw2LudslxNr/bYjZAd/e
 ibxDKxxDyRpGNoJrx13coMYuzz7cMoZdZ3eIs7Ya+A++7TZPZw3Y6oIyEZpSofLEe11zP7lci00
 B/v8kAkDjPFo1hi/cOdsBTukFTLEa2WoKajgI8b2e2zCfSe54wJYscrk1gCCJUS6M2sm71vuCHJ
 v2IdKOIAH1wnFRo+Q1CONe/w2GDi3YKia2KsCnBmPc3JHJNf7hm40gsRifhLQkFxjdREUt598uJ
 1rBa+2L1l7Mq4RqTdzoJdhKYFXeP5CP0/0ei4uamPoku5btrcPgSkgTGMJe90ricmPLATUuuDlU
 /91co/+2tdSIOKhRduU/3lJ6tmWRHrUB+kApqCvAxN5TmJt0kzzV3EoRhsHy+7zHAtMKU3yECSQ
 3f+U0UNaTH46Om19sQldhYI3c/hZsEth6P51hNoXQzzF1YKEG2O2dTy6hckxiKS5aUb3fHIHPmL
 3wlnhU2UaIJxzcDeiLXeLBx+KZI+xwnfZw==
X-Received: by 2002:a05:6870:16e1:b0:447:29d9:cf22 with SMTP id
 586e51a60fabf-4683712b62fmr12777798fac.9.1787968228218; 
 Fri, 28 Aug 2026 18:50:28 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a353d45asm3070190fac.7.2026.08.28.18.50.27
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 18:50:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/7] Cleanup MAINTAINERS entries
Date: Fri, 28 Aug 2026 19:50:18 -0600
Message-ID: <20260829015026.473134-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: cover.1787555916.git.michal.simek@amd.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

This is a v2 of the series Michal posted here[1]. I've also taken a
patch I had posted before to run the scripts/check_maintainers_files.sh
tool in CI and put it at the end, as the tool runs cleanly then.

As the diffstat and v1 show, we end up touching almost 140 files. To
avoid having a huge series, and also to avoid unmanagable CC lists, I've
broken this up in to 5 patches. In the case of updating all of the Tegra
entries, a little more work was required to ensure consitent coverage,
so it's a separate patch. Also, as there was a question of ensuring that
new -u-boot.dtsi files would be caught in one case, that is also a
separate patch. The final 3 patches try and group together the cases of:
- We know what file or directory should have been used, correct the
  entry, it was never in-tree to start with
- The above, but MAINTAINERS was missed in a rename, so fix it now.
- The files have been removed.

With all of these applied, we have a bit more coverage than we used to
thanks to the corrections and now the tool reports everything is clean,
so we can have CI ensure it stays that way moving forward.

Michal Simek (1):
  scripts: Check F: entries in all MAINTAINERS files

Tom Rini (6):
  MAINTAINERS: tegra: Update and correct entries
  MAINTAINERS: rockchip: Use N for rk3576-nanopi-r76s
  MAINTAINERS: Fix "typo" and similar incorrect entries
  MAINTAINERS: Correct entries missed during renames
  MAINTAINERS: Removed files
  CI: Run scripts/check_maintainers_files.sh in the existing MAINTAINERS
    job

 .azure-pipelines.yml                          |  3 +-
 .gitlab-ci.yml                                |  4 +-
 MAINTAINERS                                   |  6 +-
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |  2 +-
 board/CZ.NIC/turris_omnia/MAINTAINERS         |  2 +-
 board/LaCie/net2big_v2/MAINTAINERS            |  4 -
 board/LaCie/netspace_v2/MAINTAINERS           |  6 --
 board/Marvell/octeontx/MAINTAINERS            |  3 +-
 board/Marvell/octeontx2/MAINTAINERS           |  3 +-
 board/Synology/ds116/MAINTAINERS              |  1 -
 board/acer/picasso/MAINTAINERS                |  1 -
 board/advantech/imx8mp_rsb3720a1/MAINTAINERS  |  2 +-
 board/advantech/imx8qm_dmsse20_a1/MAINTAINERS |  2 +-
 board/alliedtelesis/SBx81LIFKW/MAINTAINERS    |  2 +-
 board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS  |  2 +-
 board/altera/stratix10-socdk/MAINTAINERS      |  1 -
 board/amd/versal2/MAINTAINERS                 |  2 +-
 board/amlogic/p212/MAINTAINERS                |  2 +-
 board/amlogic/q200/MAINTAINERS                |  2 +-
 board/amlogic/s400/MAINTAINERS                |  2 +-
 board/andestech/voyager/MAINTAINERS           |  2 +-
 board/asus/grouper/MAINTAINERS                |  1 -
 board/asus/transformer-t114/MAINTAINERS       |  1 -
 board/asus/transformer-t20/MAINTAINERS        |  1 -
 board/asus/transformer-t30/MAINTAINERS        |  1 -
 board/atmel/at91sam9260ek/MAINTAINERS         |  1 -
 board/atmel/sama5d29_curiosity/MAINTAINERS    |  2 +-
 board/atmel/sama7d65_curiosity/MAINTAINERS    |  2 +-
 board/atmel/sama7g54_curiosity/MAINTAINERS    |  2 +-
 board/atmel/sama7g5ek/MAINTAINERS             |  2 +-
 board/avionic-design/medcom-wide/MAINTAINERS  |  2 +-
 board/avionic-design/plutux/MAINTAINERS       |  2 +-
 board/avionic-design/tec-ng/MAINTAINERS       |  2 +-
 board/avionic-design/tec/MAINTAINERS          |  2 +-
 board/beacon/beacon-rzg2m/MAINTAINERS         |  3 -
 board/bosch/acc/MAINTAINERS                   |  2 +-
 board/cei/cei-tk1-som/MAINTAINERS             |  2 +-
 board/compal/paz00/MAINTAINERS                |  2 +-
 board/compulab/trimslice/MAINTAINERS          |  2 +-
 board/comtrend/vr3032u/MAINTAINERS            |  2 +-
 board/comtrend/wap5813n/MAINTAINERS           |  2 +-
 board/coolpi/genbook_cm5_rk3588/MAINTAINERS   |  2 +-
 board/davinci/da8xxevm/MAINTAINERS            |  2 +-
 board/embest/mx6boards/MAINTAINERS            |  1 -
 board/engicam/imx6ul/MAINTAINERS              |  5 +-
 board/friendlyarm/nanopi2/MAINTAINERS         |  2 +-
 .../gardena/smart-gateway-at91sam/MAINTAINERS |  2 +-
 .../gardena/smart-gateway-mt7688/MAINTAINERS  |  1 -
 board/gateworks/gw_ventana/MAINTAINERS        |  6 --
 board/ge/bx50v3/MAINTAINERS                   |  3 -
 board/htc/endeavoru/MAINTAINERS               |  2 +-
 board/imgtec/xilfpga/MAINTAINERS              |  2 +-
 board/intel/agilex-socdk/MAINTAINERS          |  1 -
 board/intel/agilex7m-socdk/MAINTAINERS        |  3 +-
 board/intel/n5x-socdk/MAINTAINERS             |  1 -
 board/keymile/km83xx/MAINTAINERS              |  6 +-
 board/khadas/khadas-edge2-rk3588s/MAINTAINERS |  1 -
 board/kontron/sl-mx6ul/MAINTAINERS            |  7 +-
 board/lenovo/ideapad-yoga-11/MAINTAINERS      |  2 +-
 board/lg/x3-t30/MAINTAINERS                   |  2 +-
 board/libre-computer/aml-a311d-cc/MAINTAINERS |  2 +-
 board/libre-computer/aml-s805x-ac/MAINTAINERS |  2 +-
 .../libre-computer/aml-s905d3-cc/MAINTAINERS  |  2 +-
 board/mediatek/mt7981/MAINTAINERS             |  2 -
 board/mediatek/mt7986/MAINTAINERS             |  4 -
 board/microsoft/surface-rt/MAINTAINERS        |  2 +-
 board/myir/mys_6ulx/MAINTAINERS               |  3 +-
 board/nvidia/beaver/MAINTAINERS               |  1 -
 board/nvidia/cardhu/MAINTAINERS               |  1 -
 board/nvidia/dalmore/MAINTAINERS              |  1 -
 board/nvidia/harmony/MAINTAINERS              |  1 -
 board/nvidia/jetson-tk1/MAINTAINERS           |  1 -
 board/nvidia/nyan-big/MAINTAINERS             |  1 -
 board/nvidia/p2371-0000/MAINTAINERS           |  1 -
 board/nvidia/p2371-2180/MAINTAINERS           |  1 -
 board/nvidia/p2571/MAINTAINERS                |  1 -
 board/nvidia/p2771-0000/MAINTAINERS           |  1 -
 board/nvidia/p3450-0000/MAINTAINERS           |  1 -
 board/nvidia/seaboard/MAINTAINERS             |  1 -
 board/nvidia/tegratab/MAINTAINERS             |  1 -
 board/nvidia/venice2/MAINTAINERS              |  1 -
 board/nvidia/ventana/MAINTAINERS              |  1 -
 board/nxp/imx93_evk/MAINTAINERS               |  1 -
 board/nxp/ls1012afrdm/MAINTAINERS             | 12 +--
 board/nxp/ls1012aqds/MAINTAINERS              |  1 -
 board/nxp/ls1012ardb/MAINTAINERS              |  3 -
 board/nxp/ls1043aqds/MAINTAINERS              |  7 --
 board/nxp/ls1043ardb/MAINTAINERS              |  6 --
 board/nxp/ls1046aqds/MAINTAINERS              |  7 --
 board/nxp/ls1046ardb/MAINTAINERS              |  7 --
 board/nxp/ls1088a/MAINTAINERS                 |  9 ---
 board/nxp/ls2080aqds/MAINTAINERS              |  4 -
 board/nxp/ls2080ardb/MAINTAINERS              |  6 --
 board/nxp/lx2160a/MAINTAINERS                 |  2 -
 board/nxp/mpc837xerdb/MAINTAINERS             |  1 -
 board/nxp/mx6slevk/MAINTAINERS                |  2 -
 board/nxp/p2041rdb/MAINTAINERS                |  3 -
 board/nxp/t104xrdb/MAINTAINERS                | 13 ---
 board/nxp/t208xqds/MAINTAINERS                |  5 --
 board/nxp/t208xrdb/MAINTAINERS                |  1 -
 board/ouya/ouya/MAINTAINERS                   |  2 +-
 board/phytec/phycore_am62ax/MAINTAINERS       |  2 +-
 board/phytec/phycore_am68x/MAINTAINERS        |  1 -
 board/phytec/phycore_imx8mm/MAINTAINERS       |  2 +-
 .../polyhex/imx8mp_debix_model_a/MAINTAINERS  |  1 -
 board/qualcomm/dragonboard410c/MAINTAINERS    |  2 +-
 board/qualcomm/dragonboard820c/MAINTAINERS    |  2 +-
 board/qualcomm/dragonboard845c/MAINTAINERS    |  2 -
 board/qualcomm/qcs404-evb/MAINTAINERS         |  2 -
 board/renesas/blanche/MAINTAINERS             |  1 -
 board/renesas/eagle/MAINTAINERS               |  2 +-
 board/renesas/grpeach/MAINTAINERS             |  2 +-
 board/renesas/v3msk/MAINTAINERS               |  2 +-
 board/samsung/starqltechn/MAINTAINERS         |  4 +-
 board/seeed/linkit-smart-7688/MAINTAINERS     |  1 -
 board/siemens/iot2050/MAINTAINERS             |  2 +-
 board/sifive/unmatched/MAINTAINERS            |  2 +-
 board/sunxi/MAINTAINERS                       |  2 -
 board/ti/am62ax/MAINTAINERS                   |  2 +-
 board/ti/am62dx/MAINTAINERS                   |  2 +-
 board/ti/am62px/MAINTAINERS                   |  2 +-
 board/ti/j7200/MAINTAINERS                    |  2 +-
 board/toradex/apalis-tk1/MAINTAINERS          |  2 +-
 board/toradex/apalis_t30/MAINTAINERS          |  4 +-
 board/toradex/colibri-imx6ull/MAINTAINERS     |  1 -
 board/toradex/colibri-imx8x/MAINTAINERS       |  4 +-
 board/toradex/colibri_imx7/MAINTAINERS        | 12 +--
 board/toradex/colibri_t20/MAINTAINERS         |  4 +-
 board/toradex/colibri_t30/MAINTAINERS         |  4 +-
 board/toradex/colibri_vf/MAINTAINERS          |  2 +-
 board/toradex/smarc-imx8mp/MAINTAINERS        |  2 +-
 board/traverse/ten64/MAINTAINERS              |  1 -
 board/wandboard/MAINTAINERS                   |  2 +-
 board/wexler/qc750/MAINTAINERS                |  2 +-
 board/xiaomi/mocha/MAINTAINERS                |  2 +-
 board/xilinx/zynqmp/MAINTAINERS               |  1 -
 board/xilinx/zynqmp_r5/MAINTAINERS            |  2 +-
 .../orangepi-5-ultra-rk3588/MAINTAINERS       |  2 +-
 board/zyxel/nsa325/MAINTAINERS                |  3 -
 scripts/check_maintainers_files.sh            | 80 ++++++++++++-------
 140 files changed, 151 insertions(+), 284 deletions(-)

[1]: https://lore.kernel.org/r/cover.1787555916.git.michal.simek@amd.com/

-- 
Tom
