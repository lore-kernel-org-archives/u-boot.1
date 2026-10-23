Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7BA606A31F
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oAOQnzkm;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JPShpNOw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15E04606F1;
	Fri, 23 Oct 2026 13:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MyJKeWQr0pqE; Fri, 23 Oct 2026 13:39:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96B7160633
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792762765;
	b=nOa2W4yiRQGvhlF9FA5ilISTocaEn9JzCn9AYBGKUrrFsysXumf/sgCxeXvkInfesNco
	 6H78nMWAgD/LlIDUfkuWebp5N8bkV+HChUTR7aCLGrcZWFW5gzfH/gkHL4lG1GI2ktGd4
	 MH4yRDOhq/gfj3pj75/bTOVvbNPFVSHt+o+AFl2HRLid8xEpk2yKpwAnELqvW3sU1XhB4
	 UGIGLxij/rDLLHWyTD+Jdl9lj+8lCudmQn7giFG9V1dn427PB8ntN9vManFi8H3RVq9q6
	 3dKWu806/vKW2h7ZQ2CUPRT6vK590lpD68Dt0XEZ3Y4s4bPGRfWxwi6GqXCttESH+Vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792762765;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1VkO+SesFDSfjiOHL18lEEdya7yFd7mYyitd0yVRf7c=;
	b=Rh1ern/Jd2tOopC4KTCjnNQ7juA6OrXSQ8Ayb8HfJQ4QGmWK/jlPP4T4xihGzVX2LHG7
	 Xo4GzU8CYjdKJy5uxuTpmhLlrn9Pa16OIzrg5TyCDHndM8K4DiRFdalKD2YQnRL+PR0eI
	 aohjmNUajg/zJGeUC/fld7UPs7k+8YJrwVDZjVzt+cWB7llrmJyrB9GdiaUsaV7X53yl1
	 bHTFBRDEIrW8dpn+mi8LYu/oggLeFlDm0y4KXhHk1d+7qf2fTg8bUPTcPcPxAyhk4lTIR
	 N3e1EMHTemLGgj7WVt9H3vC99w6nzmawuJ1od6yZLRxkrytSVdEbIpWxyLoXS16LUQw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792762765;
	bh=1VkO+SesFDSfjiOHL18lEEdya7yFd7mYyitd0yVRf7c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oAOQnzkml5VdWWzlPcZitXEGDAXLJC+9OC+KaOOd3u6ZAqqvCV7ArxkY/qcEAIlT8
	 4gWEXpL3QoVOZxlJuZUCWSveTVYbc1jGdpUtjXlzOnu3JZma4OaAdiGty5Ao9LxhFQ
	 MkHJ7BEWZ+piF9ORGPQAePqocQHHm+csFrbDOOujsCzaBiYvmRLmLZ6N2UwUkoGDaG
	 kmtAAqz+5tfIQDtR49/+8vo4yWICfYlBmyopVtKGxNcetEtWeD3RtP3PMCfym5JGbl
	 UNcVst13RNSL1fkPXPkShzMejmS62u8r+XEFHOgKe1U8k67FCz1m+l1EiJc4ktubN9
	 9oSarJPvQ0SCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96B7160633;
	Fri, 23 Oct 2026 13:39:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F1DC23A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50BA3407A4
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:39:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xa3TUvMgeiXW for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:39:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7351840782
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792762763;
 b=T69qGpNah3Y3ybiyB8wUo6PkIiwU5GXgJwSL6TJ426LT0eOzn+i0SKrRtKzPk8KMN39F
 v/9TwknYMR8ltNd98ngaOY9OcDtVdBLv/nKK04DdPVmv/D++Kt+m97SG6JeMDllMq0Ss4
 LwsTHuuGWTGj/ktKaFI1TTUYcFysD4uPYpB/cE51G1XQNUuhJ1HPeGJhSv4sF+bu5Whu0
 fS2EAvCIVVX0cwXnXisyjVMc/LxdkK+/EqZPieWahmg5fg3O2AEp8xggxLAwQIvB+jcOi
 pmaq3EeEVWigmVl/PCktMDXnDNpmL+QK6QbbWLVYifWDxHksiLZLkVrA2C0tkuyPO1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792762763;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=1VkO+SesFDSfjiOHL18lEEdya7yFd7mYyitd0yVRf7c=;
 b=gVrkfTPQKmlWrS+lbXwgvQ5nhe9QgLfGAPpErAAnD1p2tBaJeon5QYDYp+AXBf3ppT6H
 QwoQaSaOG/Kesl34NeH8KfCWgIW0kwb0AeiKfsDtrx183UC6IOqsC76/jaMIa5xgVgvXm
 jp/JuwT/TeceUDDjvLN6iCiGrLMMfcnPT2t3AqMenV7rhnE3e6FtCmg+wB3lLNtBbWU3o
 C1DITolSpwhFSwiWiUMW0eitgHnRZfHgFqxlFe9UmXYjLsOQInHBTPnhGS//fMBsQM4aH
 wsJwj5aB5Q2XlQ+D+mpt0JLyJcdWYaOqvoHMlqXM71EW+DA4V1f6F4UmyBBRPcyF5Cg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JPShpNOw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JPShpNOw
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7351840782
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:39:21 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6fe4372c5f3so628283eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792762760; x=1793367560;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1VkO+SesFDSfjiOHL18lEEdya7yFd7mYyitd0yVRf7c=;
 b=JPShpNOwf6gc6DcNLd9aZqA4bg0CMU/ZOQl0SwaE5vzug3+EG4E+GC90z6yUzN4ZF0
 xs0YtUL/GsQGd9vMynC/IJxIas5IDA7hitHol+tG7RTrk/w+3FccgjL3hfgTHEamoSJX
 K8L3GFosnaWQYrXOuz0/o61hfaHtDYClAq3DffF1ePB5cvOe6W6RuD12pSAk27Nw7HGE
 BpxkY/H5ndEGtrb2h8cFwYUgTHK3/Rc38KX/2zPDH7PzDCdIDGcl9Iumq8+daSzdlyVi
 0ogXNfAX3jPwpWmDYTb8s6kDwkQM2hegjobLGSejy3FYstSuJODN1pRJlkQgWd9IuG9W
 WLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792762760; x=1793367560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1VkO+SesFDSfjiOHL18lEEdya7yFd7mYyitd0yVRf7c=;
 b=hQnNut/Z0RIncW6EFAjm/k79V+zlf9wnWEKmvHVD6jWPNXUCDAX/Pjv5tSM88w9ip6
 10AR+LMEGV65AFwhPC6703UwASpqnP6tfbKZ32ojkJFZfsEQ90ZJDQSTTAYFZMvx6vka
 Fi94TYwt9Q2MafzrqRgByhY4A/1IMcG9vsFn0XvDkLZ8APqIWfJZLe27hMwUgkldkq8E
 gZhUEBxV2MBFtCACmuFIxrM6q7QM9HmrTzCxj/dcnReefkBSBTHhZAsMY2e5iCsIk5F6
 GQUaasgCN+vfLQnsaWTx31hU7+vQMinZKqYHUSr31b8NNijIXRevFBBuuNabH8j8WMqu
 SwuA==
X-Forwarded-Encrypted: i=1;
 AKwUvByC+NGMwxaL5jw5EiLTWTqdltHs3Iw16VHT92SfPhYiyfK5gsC6Yd6mXH3hbimDVCAs/Tx3X1Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIs1cezl87oBs7y9zguNkNxlUYnnLyI6gb3QtyvhxCZCdJZX3VK
 8AyKSDuSMSoMNXErG7LAxnXVBj1CdT0UjGKYaZfBu+/02VF502ytsZdAG39IGQeqquU=
X-Gm-Gg: AYBFou0XNATeHT5xwWhxTVyq94AGmUXOYSTIgpO22MYDn7GY93ZLybaLp0jjLLe6Z+E
 wvKpJpnHv+oyptV6AF1+1FrGSYHClI0sDWweD+X4xxHSk7rapL98WYtjI82zwshf682nMNT9Lou
 GMsQESUlaOdL9EoCjImBSi149ZkLf0iQj5Hx0MtC23HSTSFL7wUBE/dwIQBuRfnLVY08SfV7qCh
 +VFhtU8SGG2GxGm3WsVzjnslM0zI6P6m9Bbc54gezJU8Jvt0v2VxvkbcA4+rqZtvEQllwpqV8V2
 noqXfbI3t1R9+PB5qqeV28+hb6/F+X6ZdrNb+glwSTh/e1EDSKMhwUJRRecyj4JT0IRnEP0Pvuc
 ILUUJYZy08MokV2iFAvjCrRW37+bObY11aSg7VytUpToQ1Qq2zyV3qjSUTUPK/EhpnDMc4gpl/i
 So/BZbARHofkXLaMNG4i1tFctjybI+L2EgJC3q47BzbjVDTmFcab7LsUFZlfxX2ihDEpW9VgOyW
 by3fC7lu2Sbi0BN+9k9foX3InAwp9/7xBW9m7/I86JDIuxIpAj8yq+P3w==
X-Received: by 2002:a05:6820:4910:b0:6cd:3fcc:96d6 with SMTP id
 006d021491bc7-70b88b3806dmr1308700eaf.84.1792762760453; 
 Fri, 23 Oct 2026 06:39:20 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:d2b5:d533:1cac:8248])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9abf7982sm109294eaf.0.2026.10.23.06.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:39:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream@mediatek.com,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-main-2026-10-23 into main
Date: Fri, 23 Oct 2026 08:38:15 -0500
Message-ID: <20261023133916.1090964-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 62c9805d8d57cad407f0295879cc9a6182da464a:

  Merge patch series "fit: use constants for the cipher property names" (2026-10-20 11:13:13 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-main-2026-10-23

for you to fetch changes up to dbcfb788588ff3df2894bb3a6a075d1c22b6b465:

  configs: mt8189: enable the eDP display path (2026-10-22 18:14:26 -0500)

----------------------------------------------------------------
* New Genio 360 EVK (MT8366) board support
* New MT8366 pwrap compatible
* New Startek KD070FHFID078 MIPI-DSI panel driver
* MediaTek clocks: propagate rate requests to PLLs and select mux inputs
  by rate
* Move the MediaTek PHY drivers to their own subdirectory
* New MediaTek MIPI DSI PHY and MT8189 eDP PHY drivers
* New DisplayPort PHY configuration options (include/phy-dp.h)
* New get_unaligned_le24() helper
* New SMI larb driver and MediaTek display pipeline components
* New HDMI display support for MT8188 (Genio 510/700)
* New DSI display support for MT8365 (Genio 350), MT8366 (Genio 360) and
  MT8189 (Genio 520/720)
* New eDP display support for MT8189 (Genio 520/720)
* New MT8365 power domain support, with SMI and infra-nao bus protection
* Firmware A/B selection in SPL for MT8188 (Genio 510/700)
* Simplify MediaTek SPL boot-device selection
* Splash screen: convert and update the documentation, add a splashoffset
  variable and SCSI storage support

----------------------------------------------------------------
Carlo Caione (2):
      arm: mediatek: simplify SPL boot-device selection
      arm: mediatek: support firmware A/B selection in SPL

Chris Chen (1):
      arm: mediatek: add MT8366 application processor

David Lechner (32):
      power: pmic: mtk-pwrap: add mt8366 compatible
      video: panel-startek-kd070fhfid078: new driver
      clk: mediatek: don't truncate the requested PLL rate
      clk: mediatek: return the new rate from PLL set_rate
      clk: mediatek: pass the input rate to mtk_pll_calc_values()
      clk: mediatek: select mux inputs by rate
      video: mediatek: mtk_disp_mutex: describe the DSI pipeline with data
      video: mediatek: add MT8189 DSI display support
      video: panel-startek-kd070fhfid078: support a separate VDDP supply
      arm: dts: mediatek: drop the USB port 4 VBUS regulator on Genio 520/720
      arm: dts: mediatek: describe the Genio 360 EVK panel VDDP rail
      arm: dts: mediatek: mt8189: add the display blocks
      arm: dts: mediatek: add the DSI panel to the Genio 520 and 720 EVKs
      configs: mt8189: enable the DSI display
      doc: splash: convert README.splashprepare to reStructuredText
      doc: splash: document the features added since 2013
      splash: use u32 for the raw storage offset
      splash: add a splashoffset environment variable
      splash: add SCSI storage support
      board: mediatek: MAINTAINERS: match the Genio 520/720 files with globs
      linux: drm_dp_helper: add the definitions needed for eDP link training
      phy: add the DisplayPort PHY configuration options
      phy: mediatek: add an MT8189 eDP PHY driver
      video: mediatek: mtk_ddp: allow routing the OVL output to DVO
      video: mediatek: mtk_disp_mutex: add DVO support
      video: mediatek: add a DVO driver
      video: mediatek: build the overlay with the shared pipeline
      video: mediatek: add an eDP driver
      arm: dts: mediatek: mt8189: add the eDP display path
      arm: dts: mediatek: describe the eDP panel on the Genio 520 and 720 EVKs
      arm: dts: mediatek: add an eDP overlay for the Genio 520 and 720 EVKs
      configs: mt8189: enable the eDP display path

Julien Stephan (31):
      phy: sort vendor subdirectory lists alphabetically
      phy: mediatek: move MediaTek PHY drivers to their own subdirectory
      phy: phy-mtk-mipi-dsi: add new driver
      memory: sort the Makefile alphabetically
      memory: mediatek: add SMI larb driver
      video: mediatek: add display pipeline component helpers
      video: mediatek: add ethdr component
      video: mediatek: add merge component
      video: mediatek: add mutex component
      video: mediatek: add padding component
      video: mediatek: add mdp rdma component
      video: mediatek: add dpi1 component
      asm-generic: unaligned: add get_unaligned_le24()
      video: mediatek: add hdmi driver
      configs: mediatek: mt8188: enable hdmi pipeline
      power: domain: mediatek: support SMI and infra-nao bus protection
      power: domain: mtk: add MT8365 power domain
      configs: mt8365: enable the power domain driver
      memory: mediatek: mtk-smi: support smi_common and the larb ports
      video: mediatek: add ovl component
      video: mediatek: add disp rdma component
      video: mediatek: add color component
      video: mediatek: add ccorr component
      video: mediatek: add aal component
      video: mediatek: add gamma component
      video: mediatek: add dither component
      video: mediatek: add ddp component
      video: mediatek: mtk_disp_mutex: add the DSI pipeline
      video: mediatek: add dsi driver
      configs: mediatek: mt8365_evk: enable dsi pipeline
      configs: mediatek: mt8366_genio_360_evk: enable dsi pipeline

Macpaul Lin (3):
      arm: dts: add MT8366 application processor
      arm: dts: mediatek: add Genio 360 EVK
      board: mediatek: add Genio 360 EVK defconfig

 MAINTAINERS                                        |    5 +-
 arch/arm/dts/Makefile                              |   13 +
 arch/arm/dts/mt8189.dtsi                           |  196 +-
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi      |  510 +++++
 arch/arm/dts/mt8366-genio-360-evk.dts              |   14 +
 arch/arm/dts/mt8366.dtsi                           |  769 +++++++
 arch/arm/dts/mt8371-genio-common-edp.dtso          |   54 +
 arch/arm/dts/mt8371-genio-common.dtsi              |  269 ++-
 arch/arm/mach-mediatek/Kconfig                     |   29 +-
 arch/arm/mach-mediatek/Makefile                    |    2 +
 arch/arm/mach-mediatek/cpu.c                       |    3 +-
 arch/arm/mach-mediatek/mt7629/init.c               |    8 +-
 arch/arm/mach-mediatek/mt8366/Makefile             |    3 +
 arch/arm/mach-mediatek/mt8366/init.c               |   58 +
 arch/arm/mach-mediatek/mt8516/init.c               |    8 +-
 arch/arm/mach-mediatek/mtk_ab.c                    |  140 ++
 arch/arm/mach-mediatek/mtk_ab.h                    |   48 +
 arch/arm/mach-mediatek/spl.c                       |   19 +-
 arch/arm/mach-mediatek/spl_ab.c                    |   32 +
 board/mediatek/MAINTAINERS                         |   20 +-
 common/splash.c                                    |    8 +-
 common/splash_source.c                             |   30 +-
 configs/mt8188.config                              |    4 +
 configs/mt8189.config                              |    6 +
 configs/mt8365_evk_defconfig                       |    7 +
 configs/mt8366_genio_360_evk_defconfig             |   67 +
 doc/README.splashprepare                           |   34 -
 doc/board/mediatek/mt8188-genio-evk.rst            |   85 +-
 doc/develop/index.rst                              |    1 +
 doc/develop/splash.rst                             |  135 ++
 drivers/clk/mediatek/clk-mtk.c                     |  306 ++-
 drivers/memory/Kconfig                             |   12 +
 drivers/memory/Makefile                            |    3 +-
 drivers/memory/mtk-smi.c                           |  300 +++
 drivers/phy/Kconfig                                |   52 +-
 drivers/phy/Makefile                               |   17 +-
 drivers/phy/mediatek/Kconfig                       |   66 +
 drivers/phy/mediatek/Makefile                      |    8 +
 drivers/phy/mediatek/phy-mtk-dp.c                  |  276 +++
 drivers/phy/{ => mediatek}/phy-mtk-hdmi-mt8195.c   |    0
 drivers/phy/{ => mediatek}/phy-mtk-hdmi-mt8195.h   |    0
 drivers/phy/{ => mediatek}/phy-mtk-hdmi.c          |    0
 drivers/phy/{ => mediatek}/phy-mtk-hdmi.h          |    0
 drivers/phy/{ => mediatek}/phy-mtk-io.h            |    0
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c     |  175 ++
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c            |  145 ++
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h            |   45 +
 drivers/phy/{ => mediatek}/phy-mtk-tphy.c          |    0
 drivers/phy/{ => mediatek}/phy-mtk-ufs.c           |    0
 drivers/phy/{ => mediatek}/phy-mtk-xsphy.c         |    0
 drivers/power/domain/Makefile                      |    1 +
 drivers/power/domain/mt8188-power-domain.c         |  164 +-
 drivers/power/domain/mt8189-power-domain.c         |   74 +-
 drivers/power/domain/mt8365-power-domain.c         |  236 ++
 drivers/power/domain/mt8366-power-domain.c         |   40 +-
 drivers/power/domain/mtk-power-domain.c            |  169 +-
 drivers/power/domain/mtk-power-domain.h            |   66 +-
 drivers/power/pmic/mtk-pwrap.c                     |    1 +
 drivers/video/Kconfig                              |   11 +
 drivers/video/Makefile                             |    2 +
 drivers/video/mediatek/Kconfig                     |   81 +
 drivers/video/mediatek/Makefile                    |   32 +
 drivers/video/mediatek/mtk_ddp.c                   |  138 ++
 drivers/video/mediatek/mtk_ddp.h                   |   39 +
 drivers/video/mediatek/mtk_disp_aal.c              |   54 +
 drivers/video/mediatek/mtk_disp_aal.h              |   31 +
 drivers/video/mediatek/mtk_disp_ccorr.c            |   55 +
 drivers/video/mediatek/mtk_disp_ccorr.h            |   31 +
 drivers/video/mediatek/mtk_disp_color.c            |   50 +
 drivers/video/mediatek/mtk_disp_color.h            |   31 +
 drivers/video/mediatek/mtk_disp_comp.c             |  124 +
 drivers/video/mediatek/mtk_disp_comp.h             |   99 +
 drivers/video/mediatek/mtk_disp_dither.c           |   89 +
 drivers/video/mediatek/mtk_disp_dither.h           |   32 +
 drivers/video/mediatek/mtk_disp_gamma.c            |   51 +
 drivers/video/mediatek/mtk_disp_gamma.h            |   31 +
 drivers/video/mediatek/mtk_disp_merge.c            |  155 ++
 drivers/video/mediatek/mtk_disp_merge.h            |   49 +
 drivers/video/mediatek/mtk_disp_mutex.c            |  244 ++
 drivers/video/mediatek/mtk_disp_mutex.h            |   43 +
 drivers/video/mediatek/mtk_disp_ovl.c              |  258 +++
 drivers/video/mediatek/mtk_disp_ovl.h              |   45 +
 drivers/video/mediatek/mtk_disp_padding.c          |   49 +
 drivers/video/mediatek/mtk_disp_padding.h          |   20 +
 drivers/video/mediatek/mtk_disp_rdma.c             |  154 ++
 drivers/video/mediatek/mtk_disp_rdma.h             |   30 +
 drivers/video/mediatek/mtk_dpi.c                   |  372 +++
 drivers/video/mediatek/mtk_dpi.h                   |   34 +
 drivers/video/mediatek/mtk_dpi_regs.h              |  247 ++
 drivers/video/mediatek/mtk_dsi.c                   | 1200 ++++++++++
 drivers/video/mediatek/mtk_dvo.c                   |  417 ++++
 drivers/video/mediatek/mtk_dvo.h                   |   33 +
 drivers/video/mediatek/mtk_edp.c                   | 2385 ++++++++++++++++++++
 drivers/video/mediatek/mtk_ethdr.c                 |  106 +
 drivers/video/mediatek/mtk_ethdr.h                 |   39 +
 drivers/video/mediatek/mtk_hdmi.c                  | 1027 +++++++++
 drivers/video/mediatek/mtk_hdmi_regs_v2.h          |  263 +++
 drivers/video/mediatek/mtk_mdp_rdma.c              |  185 ++
 drivers/video/mediatek/mtk_mdp_rdma.h              |   36 +
 drivers/video/panel-startek-kd070fhfid078.c        |  377 ++++
 include/asm-generic/unaligned.h                    |   10 +
 include/dt-bindings/gce/mt8366-gce.h               |  858 +++++++
 .../memory/mediatek,mt8366-memory-port.h           |  266 +++
 include/linux/drm_dp_helper.h                      |   12 +
 include/mtk_smi.h                                  |   51 +
 include/phy-dp.h                                   |   98 +
 include/splash.h                                   |    1 +
 107 files changed, 14390 insertions(+), 388 deletions(-)
 create mode 100644 arch/arm/dts/mt8366-genio-360-evk-common.dtsi
 create mode 100644 arch/arm/dts/mt8366-genio-360-evk.dts
 create mode 100644 arch/arm/dts/mt8366.dtsi
 create mode 100644 arch/arm/dts/mt8371-genio-common-edp.dtso
 create mode 100644 arch/arm/mach-mediatek/mt8366/Makefile
 create mode 100644 arch/arm/mach-mediatek/mt8366/init.c
 create mode 100644 arch/arm/mach-mediatek/mtk_ab.c
 create mode 100644 arch/arm/mach-mediatek/mtk_ab.h
 create mode 100644 arch/arm/mach-mediatek/spl_ab.c
 create mode 100644 configs/mt8366_genio_360_evk_defconfig
 delete mode 100644 doc/README.splashprepare
 create mode 100644 doc/develop/splash.rst
 create mode 100644 drivers/memory/mtk-smi.c
 create mode 100644 drivers/phy/mediatek/Kconfig
 create mode 100644 drivers/phy/mediatek/Makefile
 create mode 100644 drivers/phy/mediatek/phy-mtk-dp.c
 rename drivers/phy/{ => mediatek}/phy-mtk-hdmi-mt8195.c (100%)
 rename drivers/phy/{ => mediatek}/phy-mtk-hdmi-mt8195.h (100%)
 rename drivers/phy/{ => mediatek}/phy-mtk-hdmi.c (100%)
 rename drivers/phy/{ => mediatek}/phy-mtk-hdmi.h (100%)
 rename drivers/phy/{ => mediatek}/phy-mtk-io.h (100%)
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-dsi.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-dsi.h
 rename drivers/phy/{ => mediatek}/phy-mtk-tphy.c (100%)
 rename drivers/phy/{ => mediatek}/phy-mtk-ufs.c (100%)
 rename drivers/phy/{ => mediatek}/phy-mtk-xsphy.c (100%)
 create mode 100644 drivers/power/domain/mt8365-power-domain.c
 create mode 100644 drivers/video/mediatek/Kconfig
 create mode 100644 drivers/video/mediatek/Makefile
 create mode 100644 drivers/video/mediatek/mtk_ddp.c
 create mode 100644 drivers/video/mediatek/mtk_ddp.h
 create mode 100644 drivers/video/mediatek/mtk_disp_aal.c
 create mode 100644 drivers/video/mediatek/mtk_disp_aal.h
 create mode 100644 drivers/video/mediatek/mtk_disp_ccorr.c
 create mode 100644 drivers/video/mediatek/mtk_disp_ccorr.h
 create mode 100644 drivers/video/mediatek/mtk_disp_color.c
 create mode 100644 drivers/video/mediatek/mtk_disp_color.h
 create mode 100644 drivers/video/mediatek/mtk_disp_comp.c
 create mode 100644 drivers/video/mediatek/mtk_disp_comp.h
 create mode 100644 drivers/video/mediatek/mtk_disp_dither.c
 create mode 100644 drivers/video/mediatek/mtk_disp_dither.h
 create mode 100644 drivers/video/mediatek/mtk_disp_gamma.c
 create mode 100644 drivers/video/mediatek/mtk_disp_gamma.h
 create mode 100644 drivers/video/mediatek/mtk_disp_merge.c
 create mode 100644 drivers/video/mediatek/mtk_disp_merge.h
 create mode 100644 drivers/video/mediatek/mtk_disp_mutex.c
 create mode 100644 drivers/video/mediatek/mtk_disp_mutex.h
 create mode 100644 drivers/video/mediatek/mtk_disp_ovl.c
 create mode 100644 drivers/video/mediatek/mtk_disp_ovl.h
 create mode 100644 drivers/video/mediatek/mtk_disp_padding.c
 create mode 100644 drivers/video/mediatek/mtk_disp_padding.h
 create mode 100644 drivers/video/mediatek/mtk_disp_rdma.c
 create mode 100644 drivers/video/mediatek/mtk_disp_rdma.h
 create mode 100644 drivers/video/mediatek/mtk_dpi.c
 create mode 100644 drivers/video/mediatek/mtk_dpi.h
 create mode 100644 drivers/video/mediatek/mtk_dpi_regs.h
 create mode 100644 drivers/video/mediatek/mtk_dsi.c
 create mode 100644 drivers/video/mediatek/mtk_dvo.c
 create mode 100644 drivers/video/mediatek/mtk_dvo.h
 create mode 100644 drivers/video/mediatek/mtk_edp.c
 create mode 100644 drivers/video/mediatek/mtk_ethdr.c
 create mode 100644 drivers/video/mediatek/mtk_ethdr.h
 create mode 100644 drivers/video/mediatek/mtk_hdmi.c
 create mode 100644 drivers/video/mediatek/mtk_hdmi_regs_v2.h
 create mode 100644 drivers/video/mediatek/mtk_mdp_rdma.c
 create mode 100644 drivers/video/mediatek/mtk_mdp_rdma.h
 create mode 100644 drivers/video/panel-startek-kd070fhfid078.c
 create mode 100644 include/dt-bindings/gce/mt8366-gce.h
 create mode 100644 include/dt-bindings/memory/mediatek,mt8366-memory-port.h
 create mode 100644 include/mtk_smi.h
 create mode 100644 include/phy-dp.h
