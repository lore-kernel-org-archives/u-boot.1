Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002E2C55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF2F3810AA;
	Thu, 30 Jul 2026 14:18:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OI7XF8Dn3AUq; Thu, 30 Jul 2026 14:18:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 422CA8100F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785421112;
	bh=bpa88baI3apR56Rriwe1wq2h2Tse1ZXwYjIMb/9Id18=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pATJG0mWuETE55lOfM53gEeJdWB6m9LNH95WkEtErJ4TwOIC4ALDIUfsc8LGrSW1K
	 5O3h5htNWsVUqY3V2qQQnB/EfRzIniZnlf88Cbid7sD1Sf3n2NbR8PPGFZT2lsBuWf
	 Ky7UqaGpQgKmN2SVCSBoeoSuIpQM14naEjAwDkTmpQ7xJgXX7u1mwdgxyBHB9Ekz5p
	 H0egZ/1HWA/vAF9qnZptbzciOT/1xHO5VAt69SwYgQ5cHxwU8k13Ixp9WAQFBVyFGy
	 0OaUal2tRQHsdMlnbr5ZjQv9imk6RMhUnVb8WyGavSZzXs9h1lzX1olCc47fTzFeUq
	 d0iAP/RGCs7mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 422CA8100F;
	Thu, 30 Jul 2026 14:18:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AB7869
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CB1540B3E
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ut4qJY3fltSU for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:18:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2356A40B35
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2356A40B35
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2356A40B35
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:27 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so267197766b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 07:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785421105; x=1786025905;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bpa88baI3apR56Rriwe1wq2h2Tse1ZXwYjIMb/9Id18=;
 b=JighiipabYIq9YCG6LQMEn9GQuDwy6+R2Y4l2RMmFi7RKlZoJ2ktQm9MIom/VVo/0m
 iUjux0XFCliiq5vcrtf0GJp+LEb4UhxkQTtt1799a3kNkJjh/ESGM0JvdX9sy46tu6+g
 3wmw3O0tFIDlBGssy+7LUPIndnevuS5bq4F7WqNguzbmPcAUSlxkv6fzydLo9dcPxWAj
 7l97EL3wPrEMXzZKItgaFSI0I4Z7OqYW1t8lnoF5QtTqXxluz2put/jQNZX0BLjEij94
 vvb63445AJf5lO+bLSDtCnZLZUeUp8wWrVvenDr6IESG/up3vU7M06+v31fgy1Fs1rHZ
 LE1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdWyF8ChpPF67BznYG4CxHfw0QzAkz8upYUp1H1JhAAPtXFUfAbGvWIR+uTZrQpAcn4Um8T/g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yza8hNWjAKrlLs3DYSh0rrCYHCtjL/Yl7d8JCIwcmPej3ODWuCJ
 X9615TKXUdvzRl6qIGjbWuz+jSksjlJfPI5QYm7qblErTfb0S3npqp0DyCghAJSEFfc=
X-Gm-Gg: AR+sD1120yu2OnEhlv9GlNmnnTgOWyQc16oFsVEoyVBpOaKGjqeyYrbOYpha0pSNxSA
 4hv1OAVIYUwybx4YtPhwCQEuklrRppHRh2n11I+oz+PQdIWuW73Px99gB4nh0pIM5f5vWiiZmB4
 Qujjlsd2NsJmDF7csblMoeFFGLtMcw544emB+D9EeCPAQda1ykUAHu4AUqhJfsgA0So2aurV9cm
 d+DUKHzN1yDhRpA0+gfsfogJtdw5Rq+PMl8nrTnypoRnCwYZBw8i70ubMzOkJ6pGPykpX+M8y0o
 PX6rK0RusqR3nYtwKyCuvR7Rh99l08K/+xaWrkmXku45hj8LrNM69Eirhi0mHITodT0g84lTJXC
 2/jS9zzGPCIHiTtAjSUs77FV7FuaRR1i0ZEAJCFTJ4rpfWDfaqI8n1VLxq7y5jd84gx6rsrnyG1
 CaRaiEi1DoHV+a8gRZAX+z7E4cGryYBAhNm98qnx+C3fDohzzdo5OuNChA7OM6joM3LDWl45jho
 13syFSgQ42mzep9wKsU+fiYiDa0K1xaRv6d0iuRgDbKnVN3t9VjtSrbOZYfn4kWn76VfTbRZqj3
 oOe+cQ==
X-Received: by 2002:a17:906:a353:10b0:c16:3a5:ee6b with SMTP id
 a640c23a62f3a-c1fa55830fcmr111049166b.4.1785421105390; 
 Thu, 30 Jul 2026 07:18:25 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa851b369sm78608266b.9.2026.07.30.07.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:18:22 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v3 0/6] Add Genio 510 and Genio 700 SPL boot support
Date: Thu, 30 Jul 2026 16:18:06 +0200
Message-Id: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NyQrCMBSF4VcpWRtJ0iHVle8hLjLc2IgdSNpgK
 X13k4ogLro8cPj+BXlwFjw6ZwtyEKy3fRdHfsiQakR3B2x13IgRVhFOOVZKxAvgafCjA9Hidqz
 zE8F+eGJuqkIJyrSRGkVhcGDsa9Ovt8/2k3yAGhOZHo31Y+/mLR9o+n1L9W4pUEwwZWUlK220y
 M1FivlppYOj6luUYoH9cIztcyxyXAhCyrwoOaV/3Lqub0oVuN8qAQAA
X-Change-ID: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785421105; x=1786025905;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bpa88baI3apR56Rriwe1wq2h2Tse1ZXwYjIMb/9Id18=;
 b=RYS9KEx47HkUaaCom/atCPIbgJ3/a5iseb8aAbBrEtI7Y0ksid5pikQFBq0D31sLa/
 hU6jRNA6FKr3HrOG6/3xbqr36cHhlDbOmz5GqOc73KXSy8mdQZB9GPxgpB4fvgOvYlW6
 VHmCTMGkLTufcMEg9xueqRZAJ8bN0EZWSK+UZmIAAsA2A3cfBw/q2yjHgSJHk7ToHMiF
 12dYerfXo1f6HaPFIHqBBB6CXq/D8oC3+ecKCH9N/45U6mIY3YS/GKw7T0wjmYbuLDjX
 DP7Tsb7wvL4H+jzi8jkSXAQM4tYF29JIFN0HYlHvliF26ZNm7XAq845/KYYkrTo4tKI7
 wsIw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RYS9KEx4
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

The Genio 510 and Genio 700 boot chains use a platform DDR loader built
separately from U-Boot to initialize DRAM before entering U-Boot SPL. Add
the shared SPL devicetree and configuration needed to initialize the debug
UART, watchdog, pinctrl and eMMC, then load a conventional FIT from the
bootloaders GPT partition.

Add an opt-in binman description that generates the images consumed by
the MediaTek flashing flow:

  mtk-boot.bin
    MediaTek BootROM wrapper containing the platform DDR loader and SPL

  mtk-boot-payload.bin
    Raw DDR-loader and SPL payload for external MediaTek signing tools

  bootloaders.img
    FIT containing BL31, OP-TEE, U-Boot proper, and its control DT

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v3:
- Add Genio 510 support using the shared MT8188-family SPL configuration,
  pre-RAM devicetree annotations and binman layout.
- Make complete image packaging opt-in through CONFIG_MTK_BOOT_IMAGES.
- Keep the binman image description in a separate optional include.
- Leave SPL binman symbols disabled by default on MT8188.
- Add optional RSA-3072 signing for the bootloader FIT.
- Emit the raw BootROM payload required by external MediaTek signing tools.
- Document component-only, unsigned, and signed build procedures.
- Link to v2: https://patch.msgid.link/20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com

Changes in v2:
- Clarify that the platform DDR loader is built separately from U-Boot.
- Fix the SPL copy-window wording in patch 2.
- Keep the SPL annotations board-scoped and drop the unused pericfg_ao tag.
- Normalize the firmware-stage names in the board documentation.
- Simplify the documented build commands.
- Remove the redundant MediaTek documentation maintainer pattern.
- Add links to Genio Tools and prebuilt images.
- Link to v1: https://patch.msgid.link/20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com

---
Carlo Caione (6):
      arm: dts: mediatek: prepare Genio 510 and 700 devices for SPL
      configs: mt8188: enable eMMC FIT boot from SPL
      arm: mediatek: build Genio 510 and 700 boot images with binman
      arm: dts: mediatek: support signed Genio 510 and 700 bootloader FIT
      arm: dts: mediatek: emit the Genio 510 and 700 BootROM payload
      doc: board: mediatek: document Genio 510 and 700 SPL boot

 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |   9 +-
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |   9 +-
 arch/arm/dts/mt8390-genio-common-binman.dtsi  | 155 +++++++++++++++
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi  |  94 ++++++++++
 arch/arm/mach-mediatek/Kconfig                |   8 +
 board/mediatek/MAINTAINERS                    |   3 +
 common/spl/Kconfig                            |   1 +
 configs/mt8188.config                         |  27 +++
 doc/board/mediatek/index.rst                  |   1 +
 doc/board/mediatek/mt8188-genio-evk.rst       | 260 ++++++++++++++++++++++++++
 10 files changed, 565 insertions(+), 2 deletions(-)
---
base-commit: bf75f80082a194a95eb2aef039a746c5765ba8d1
change-id: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

