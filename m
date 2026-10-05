Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B847BCA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 13:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CDF94071B;
	Mon,  5 Oct 2026 13:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KYYNHxk3ZZ34; Mon,  5 Oct 2026 13:31:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0F0B1406BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791207088;
	b=hyYz4PE9d2fKo5hFO5HLf1PnDySiX/DKBeQDd3P3E8922wL0tFsFbH6oFnfhUcySqr7v
	 VxEuMn+N+U7eeCOqGqbBJcFoZyDsohNOm4cf4SwqbIiA/+ZPbGw1AlqzmtXRWAolWmwdF
	 UMAYB2mcKFF5GaVBMbKB1Yoj1uRIUkLWCCdcJmKUEsiZmU5q3pgp5onoCtZaMbku46B9q
	 TncrjRPSZP4aTCResu1udLvoUICTo1STCX/KTrjdTLR8aXkoznWuIzcAr9txOK7LiboQj
	 6JvgMvyl1yS5WP7Qqc3tJkoH3RMawSf0c/V/AR9iyulgO70vprpLbVSOPxBixpcK27w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791207088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RvMPZ6tdeLGtUpTsKg8BpQkHXh0xlkmlDBBjDmTmK6s=;
	b=bnVNubhxsuLi0SDqUX7BUPX4+ZY9dz2K3qx4iVHQToBN9DM/w0sY+J0lOdBRDzsuhU0S
	 ox1PwYbZIDmeN612pJV6N35mrc6mJuevfzVtx4fj1NxGBAsikU0uXDfvwfWuecApqS7ov
	 sbX8IiSs53xWKrsm43uNrv0FWyNLpcdqipexozjHC8cX8p1teRyLesIqWpqjyHp06qWuF
	 ZSya2Z4fkk2I5x7av7RzYzmyBu86kyQLB4zFOheHPThkU2+JbSCe0U4ZdSy02JQW0shE3
	 PhOxYHDle6nBBIOCEQIFzYPel/rwoJRy8taptHneWST2pTf98G+ngZSLYmkn++n+FRA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791207088;
	bh=RvMPZ6tdeLGtUpTsKg8BpQkHXh0xlkmlDBBjDmTmK6s=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0Sae8bKE2/NN78P57bNH60pkFPDAe4tO2eLwPGvCanjDeOy6iMpX81AWig+tx4aE5
	 RevaKCko43Sbh8vjRVaam5d8irYWHlJ8foh54Y03RZIMQ5X9ecrl2kGzCnyIbD/X3/
	 DxyeidsCGYzNlKgqYcfig7gHEuYNdhv/i8pA3avtaqVyBIB7j1VwIjilp0JgfNjzND
	 QTXH/L/+Fo0AKzuU3Ova9F2XflJag90YbLubpHXUOewY42jPD/P8wPjt7t2s60JapT
	 A2lP47CKdLFFanTz/pW2mdscovrTGqevl8JTiNW14CrYel8mrmM5krmuOqOKMWMz97
	 iodHoGmX1eZrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F0B1406BC;
	Mon,  5 Oct 2026 13:31:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 575141A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 10:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48C6A400F8
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 10:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IrWWzVdAkqhz for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 10:13:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7A9D34007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791195207;
 b=dA/6Qh0d21S+4wwOdtnQNmfmBUIubxJEdOuAHC/k3nsReRNbjS+ZRyner6ijskXx6JUJ
 /Tib36OxAIaJetEnDpPFYhJxoO0ZTOCqbHXH4fX2Dg1LrRL5u6tZMmMLsOkYgWXLpBlh4
 MxKQ7mdSnSqgq5SHSpOi/CX73D5onKVN3YQ6m63GBGM4O4+UclEScVPdD7DyKn/eGi3Bi
 suopsLtj9LcVpIhGH+/K38ULUTnd/oHOgUOun7EIL8gramdfANtvxU1Nww8hkPTgbpXVJ
 ag7QSCO4/xCkOJOpEbQu1X2YE929SnomQO7c4RyjyjNYAMdE61htBA2kUzesL0fMVkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791195207;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=RvMPZ6tdeLGtUpTsKg8BpQkHXh0xlkmlDBBjDmTmK6s=;
 b=jXis1tcRTdJ4Hw58SpEmVIzJ/rssJBYee86T1C4+53x2RD4DbNO0ZUm/mMrl/0sinHH7
 RXemmzIEDuywzHMZA0ocPNiiNvh437NbX+fbOOlWJXs02NaHdJBbizfx4LL15TULSYS5F
 XfG1bLJc8/+yqImJS6uEHPH+9U5QmcfLwJFyKusTBk40K8C7oQEjEUSzbrOutjzu5LZS3
 zGX7PkXIIrAJYNp3jDzzzKaBwlxmJVBg/zlRocOSlMmBjBMU9rzI2HZQAQPGhhU3LvDTO
 PA4kjlD5wEh+yo2J4xRTmHrW/b+6R8IR72cygIrZtBBuVVK7gGBGYLJ8dVrCwYh9GDA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UXxALVkd; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UXxALVkd
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A9D34007E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 10:13:24 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso8966695e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791195202; x=1791800002;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RvMPZ6tdeLGtUpTsKg8BpQkHXh0xlkmlDBBjDmTmK6s=;
 b=UXxALVkdNRMnSpGOsg87vNALrzsWgi6d1Kn6c8m6ruzzmLJkBWVXKzyl6bHZ/GRkja
 2fm+dWob1J1ScT/5djvpkEAsnqhONCg65JRRDxcR7bxQcnwwi68xJjM6l+2e8OTxpsY1
 eXumj2d5wVn57E0a0uuIDJnQykA2RRRrxOWDrkjfW7/LY80eXo0zFN5M+1oPfc1rxnL3
 U2P5vDB25U7pNoxctObcgKcC/UPxwyd1T0Yx7pcEJV3/Z219moE5nUpGBLBPSCcUqwMC
 +Qmf8rNpxjUX/CEQoXFMhh2uUO/i7ScRaUvZBucRx3affLh+4eBUPBZmKS6otHWIlTY0
 BA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195202; x=1791800002;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RvMPZ6tdeLGtUpTsKg8BpQkHXh0xlkmlDBBjDmTmK6s=;
 b=W1G+8zbR/F9lhmkGFhwPYT0d/uvewer6wWv1Yax3r4gglalssR7x6VdqsFcgi077q+
 RUGTfZkdeZQM8DHjocuVozGXZL8DxFeSb1TnV9DH18u5ELJ112Ulxa5SgX3soJBoK/iU
 o9pnLCFD1VR7SIaOdylQcqqI1eDXfEqaYtL1ESZ76pfgjXfwXg0lrxiODH+BDa7L94/w
 8Ksk/PeNruDYMPmczBVT1WNizhZGMWo/9vNSanw+PvbsPChm3qmy/sr2u9AJ8kBcW2wI
 12ilj2mMOvxRvxn2BJhxR3JKdFz484SW82ymsmlPe8mw5ojslhIb0Y8n4RbytTXNLaz+
 d6uQ==
X-Gm-Message-State: AFuF++mdGGR8LqgywvAqEwstH8pVOgbBzjI/OCCFm+updoh4gBfrpLfC
 W34r72xYoHpTn787ACjP6fXTgXyTVXlAW1JmMJxhzSVLy3knb6cujH0qZ3E63gFBdT4=
X-Gm-Gg: AYBFou1ixjozQeQI/FT2rUuwBkI53i048rJLWgI7joKcUL5Z3m+ZZMo1zVpoWVyk7rB
 iM+Byn4zvC2nD8P3SUIWx/KKOeJipFUHIBTuGqK1ydnWdzV1bQE4Ork1wiILmg2Fx7QJzl7IjJf
 81BqsV76Fuf1koyFHJYHR8MZV223DIGJPDTvkuwZVr1D0XUd1lIUTHb93lGxc7RPwWJnGhYAT1J
 h3LI5RtS8Itbcm11ex0blaQVkCqTRFR/dlrT6FZVjxeJblfLa0/KNhLFcT3EMsrsGHmk/vsSyf0
 r4RcMJSX2O1eCL24g1bGkxavaJQfTpvG+CZW2r4zc/gXHeeRuYDh92NFtjL1a4f9sET2q0aTbTl
 XE1o+x4MrF6ZPaDqSnBURUAhcf4ixji2gbYx4xwgwnTT86N0cpGTbA4VMe27yVeMpvpE5dVzva2
 6p9NrweTnYglFs/3I1WLQPp8NjarhJpYdy+Qa3r08TRrsoq7GxpsTINIGVB8hDLO6tO2p4NsqG8
 lu619BzmgIJhwE5bfhlPi9uQHY6rW2DwAzawOHmoBCJjXVwgsBlhSz6QDt7eg3gBdBO4+0HtVtq
 QZ1r7CFvqjDUkQ==
X-Received: by 2002:a05:600c:548c:b0:4a0:1eb1:133b with SMTP id
 5b1f17b1804b1-4a0275599aamr169485075e9.12.1791195202177; 
 Mon, 05 Oct 2026 03:13:22 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280bcf0fsm375271105e9.6.2026.10.05.03.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:13:21 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 05 Oct 2026 12:13:08 +0200
Subject: [PATCH v2] arm: mediatek: support firmware A/B selection in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-ccaione-upstream-mt8390-ab-v2-1-c6032b5d46a1@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42PQW7DIBBFr2LNulQwgF2y6j2qLBg8NFR1nAC2G
 kW+e4nTA3T5pKc3f+5QOCcucOjukHlNJc3nBvjSQTj58yeLNDYGlNhLh0aE4JvCYrmUmtlPYqp
 v2knhSfRakRmN1UMcoAUumWP62eMfxyeXhb441Efxz8h8XdrV+tSAfGER5mlK9dDRiNEOztDAa
 EKP0qAnUg5VdAGlduRQskR41E+p1Dnf9k9Wtcf+M3pVQgltkaX1UQdt38nfvhNlfm0z4Lht2y/
 7Qa9kJQEAAA==
X-Change-ID: 20260924-ccaione-upstream-mt8390-ab-631b4d4537f7
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Chris Chen <chris-qj.chen@mediatek.com>, 
 Torsten Rupp <torsten.rupp@8tronix.de>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Stephane Le Provost <stephane.leprovost@mediatek.com>, 
 Felix Freimann <felix.freimann@mediatek.com>, 
 Pedro Tsai <pedro.tsai@mediatek.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 05 Oct 2026 13:24:22 +0000
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

Genio firmware updates use MediaTek v1 metadata in misc to choose
between bootloaders and bootloaders_b. Support this ABI in SPL so
systems replacing BL2 can retain their firmware update and boot-success
handling.

Make selection opt-in, since trial boots need an updater and a
boot-success owner to maintain the retry state. Reject corrupt metadata
and failed state updates rather than silently restarting the retry
budget.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
This is intended for systems with an updater and a boot-success owner
that maintain the MediaTek v1 metadata. The option stays disabled in the
standard defconfigs. It covers the firmware FIT slots; the DDR loader and
SPL in boot0 remain shared.
---
Changes in v2:
- Rebase onto upstream/next with the SPL and dynamic MMC support merged.
- Move the selector and private header under arch/arm/mach-mediatek.
- Add GPL-2.0-or-later terms alongside the inherited BSD-3-Clause license.
- Remove the eMMC cache guard and its EXT_CSD register definition.
- Remove duplicate hardware-partition validation and add direct includes.
- Clarify signed-FIT setup and software block-cache readback.
- Remove the blanket download-agent restriction from the documentation.
- Drop the unrelated changes to the general FIT signing example.
- Link to v1: https://patch.msgid.link/20260924-ccaione-upstream-mt8390-ab-v1-1-352e05af3c35@baylibre.com
---
 arch/arm/mach-mediatek/Kconfig          |  17 ++++
 arch/arm/mach-mediatek/Makefile         |   1 +
 arch/arm/mach-mediatek/mtk_ab.c         | 143 ++++++++++++++++++++++++++++++++
 arch/arm/mach-mediatek/mtk_ab.h         |  48 +++++++++++
 arch/arm/mach-mediatek/spl_ab.c         |  32 +++++++
 doc/board/mediatek/mt8188-genio-evk.rst |  85 ++++++++++++++++++-
 6 files changed, 323 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index e572cfe8571..b81ab29011f 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -211,6 +211,23 @@ config MTK_BROM_HEADER_INFO
 	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
+config SPL_MTK_FIRMWARE_AB
+	bool "MediaTek firmware A/B boot in SPL"
+	depends on TARGET_MT8188 && SPL_MMC && SPL_LOAD_FIT && SPL_BLK
+	depends on !SPL_RAW_IMAGE_SUPPORT && !SPL_LEGACY_IMAGE_FORMAT
+	depends on SPL_EFI_PARTITION
+	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
+	depends on !SPL_OS_BOOT && !SPL_FS_FAT && !SPL_FS_EXT4
+	depends on !SPL_FS_SQUASHFS && !SPL_RAM_SUPPORT && !SUPPORT_EMMC_BOOT
+	select SPL_CRC32
+	select SPL_MMC_WRITE
+	help
+	  Select firmware FITs from the bootloaders and bootloaders_b GPT
+	  partitions using MediaTek A/B metadata in misc. Track trial boots
+	  and switch slots when retries are exhausted.
+
+	  An updater and a boot-success owner must maintain the metadata.
+
 config MTK_GENIO_BOOT_IMAGES
 	bool "Build MediaTek firmware images"
 	depends on TARGET_MT8188 && SPL
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 35f748a70d6..20073c12d1f 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARM64) += armv8-mem-map.o
 obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
+obj-$(CONFIG_$(PHASE_)MTK_FIRMWARE_AB) += spl_ab.o mtk_ab.o
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
 obj-$(CONFIG_TARGET_MT7623) += mt7623/
diff --git a/arch/arm/mach-mediatek/mtk_ab.c b/arch/arm/mach-mediatek/mtk_ab.c
new file mode 100644
index 00000000000..b28013bbcb6
--- /dev/null
+++ b/arch/arm/mach-mediatek/mtk_ab.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-or-later AND BSD-3-Clause
+/*
+ * Copyright (c) 2023, Mediatek Inc. All rights reserved.
+ * Copyright (c) 2026 BayLibre SAS
+ *
+ * Disk format and valid-record transitions follow MediaTek's TF-A mtk_ab.c.
+ */
+
+#include <blk.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <part.h>
+#include <stdio.h>
+#include <asm/byteorder.h>
+#include <linux/build_bug.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/string.h>
+#include <u-boot/crc.h>
+
+#include "mtk_ab.h"
+
+#define MTK_AB_MISC_INDEX	2
+
+static_assert(sizeof(struct mtk_ab_control) == 28);
+static_assert(offsetof(struct mtk_ab_control, padding) == 11);
+static_assert(offsetof(struct mtk_ab_control, reserved) == 12);
+static_assert(offsetof(struct mtk_ab_control, crc32) == 24);
+
+static u32 mtk_ab_crc(const struct mtk_ab_control *ctrl)
+{
+	return crc32(0, (const void *)ctrl, offsetof(struct mtk_ab_control, crc32));
+}
+
+static int mtk_ab_layout(struct blk_desc *desc, struct disk_partition *parts,
+			 int *numbers)
+{
+	static const char * const names[] = { "bootloaders", "bootloaders_b", "misc" };
+	int i;
+
+	part_init(desc);
+	if (desc->part_type != PART_TYPE_EFI)
+		return -EPROTONOSUPPORT;
+
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		numbers[i] = part_get_info_by_name(desc, names[i], &parts[i]);
+		if (numbers[i] < 0)
+			return numbers[i];
+	}
+
+	/* The metadata read-modify-write needs one block in misc. */
+	if (!parts[MTK_AB_MISC_INDEX].start || !parts[MTK_AB_MISC_INDEX].size ||
+	    parts[MTK_AB_MISC_INDEX].start >= desc->lba)
+		return -EINVAL;
+
+	return 0;
+}
+
+int mtk_ab_select(struct blk_desc *desc, unsigned int *slot)
+{
+	struct disk_partition parts[3];
+	struct mtk_ab_control *ctrl;
+	unsigned int selected;
+	int numbers[3], ret;
+	void *block, *verify;
+	bool changed = false;
+
+	if (!desc || !slot || !desc->lba || desc->hwpart || desc->blksz < 512 ||
+	    desc->blksz > 4096 || !is_power_of_2(desc->blksz) ||
+	    desc->blksz % ARCH_DMA_MINALIGN)
+		return -EINVAL;
+
+	/* Locate all required partitions before updating the metadata. */
+	ret = mtk_ab_layout(desc, parts, numbers);
+	if (ret)
+		return ret;
+
+	block = malloc_cache_aligned(2 * desc->blksz);
+	if (!block)
+		return -ENOMEM;
+	verify = block + desc->blksz;
+	ctrl = block;
+
+	ret = -EIO;
+	blkcache_invalidate(desc->uclass_id, desc->devnum);
+	if (blk_dread(desc, parts[MTK_AB_MISC_INDEX].start, 1, block) != 1)
+		goto out;
+
+	if (!memchr_inv(ctrl, 0, sizeof(*ctrl)) ||
+	    !memchr_inv(ctrl, 0xff, sizeof(*ctrl))) {
+		puts("MediaTek A/B: initializing blank metadata\n");
+		memset(ctrl, 0, sizeof(*ctrl));
+		ctrl->magic = cpu_to_le32(MTK_AB_MAGIC);
+		ctrl->version = MTK_AB_VERSION;
+		ctrl->tries[0] = 1;
+		ctrl->tries[1] = 1;
+		selected = 0;
+		changed = true;
+	} else {
+		ret = -EINVAL;
+		selected = le32_to_cpu(ctrl->slot);
+		if (le32_to_cpu(ctrl->magic) != MTK_AB_MAGIC ||
+		    ctrl->version != MTK_AB_VERSION || selected > 1 ||
+		    ctrl->tries[0] > MTK_AB_MAX_TRIES ||
+		    ctrl->tries[1] > MTK_AB_MAX_TRIES)
+			goto out;
+		ret = -EBADMSG;
+		if (le32_to_cpu(ctrl->crc32) != mtk_ab_crc(ctrl))
+			goto out;
+
+		if (ctrl->tries[selected] == MTK_AB_MAX_TRIES) {
+			selected ^= 1;
+			ret = -ENOENT;
+			if (ctrl->tries[selected] == MTK_AB_MAX_TRIES)
+				goto out;
+			ctrl->slot = cpu_to_le32(selected);
+			changed = true;
+		}
+		if (ctrl->tries[selected]) {
+			ctrl->tries[selected]++;
+			changed = true;
+		}
+	}
+
+	if (changed) {
+		ctrl->crc32 = cpu_to_le32(mtk_ab_crc(ctrl));
+		ret = -EIO;
+		if (blk_dwrite(desc, parts[MTK_AB_MISC_INDEX].start, 1, block) != 1)
+			goto out;
+		/* Do not verify a write against U-Boot's cached copy. */
+		blkcache_invalidate(desc->uclass_id, desc->devnum);
+		if (blk_dread(desc, parts[MTK_AB_MISC_INDEX].start, 1, verify) != 1 ||
+		    memcmp(block, verify, desc->blksz))
+			goto out;
+	}
+
+	*slot = selected;
+	ret = numbers[selected];
+out:
+	free(block);
+	return ret;
+}
diff --git a/arch/arm/mach-mediatek/mtk_ab.h b/arch/arm/mach-mediatek/mtk_ab.h
new file mode 100644
index 00000000000..f5e9749e80c
--- /dev/null
+++ b/arch/arm/mach-mediatek/mtk_ab.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later AND BSD-3-Clause */
+/*
+ * Copyright (c) 2023, Mediatek Inc. All rights reserved.
+ * Copyright (c) 2026 BayLibre SAS
+ */
+
+#ifndef __MTK_AB_H
+#define __MTK_AB_H
+
+#include <linux/types.h>
+
+struct blk_desc;
+
+#define MTK_AB_MAGIC	0x544f494d
+#define MTK_AB_VERSION	1
+#define MTK_AB_MAX_TRIES	9
+
+/* MediaTek v1 disk ABI, including the original AArch64 structure padding. */
+struct mtk_ab_control {
+	__le32 slot;
+	__le32 magic;
+	u8 version;
+	u8 tries[2];
+	u8 padding;
+	u8 reserved[12];
+	__le32 crc32;
+};
+
+/**
+ * mtk_ab_select() - Select and account for a MediaTek firmware slot
+ * @desc: Block device containing the GPT user area
+ * @slot: Returns the selected slot (0 for A, 1 for B), only on success
+ *
+ * Resolve bootloaders, bootloaders_b and misc by name, validate the v1 record
+ * at the start of misc, and persist any required retry update before returning.
+ * The caller must provide a valid, non-overlapping GPT layout.
+ * A zero counter denotes success; counters 1..8 consume a trial and 9 is
+ * exhausted. Only an all-zero or all-0xff record is initialized automatically.
+ * Writes preserve the rest of the block and are verified by reading back
+ * with U-Boot's block cache invalidated. This single-copy format does not
+ * provide power-fail atomicity.
+ *
+ * Return: Positive GPT partition number to boot, or a negative error. The
+ * caller must stop booting on error; a failed write may have changed storage.
+ */
+int mtk_ab_select(struct blk_desc *desc, unsigned int *slot);
+
+#endif
diff --git a/arch/arm/mach-mediatek/spl_ab.c b/arch/arm/mach-mediatek/spl_ab.c
new file mode 100644
index 00000000000..adf9726131c
--- /dev/null
+++ b/arch/arm/mach-mediatek/spl_ab.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2026 BayLibre SAS */
+
+#include <mmc.h>
+#include <spl.h>
+#include <stdio.h>
+#include <linux/errno.h>
+
+#include "mtk_ab.h"
+
+int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
+{
+	struct blk_desc *desc = mmc_get_blk_desc(mmc);
+	unsigned int slot;
+	int ret;
+
+	if (IS_SD(mmc)) {
+		ret = -ENODEV;
+		goto error;
+	}
+
+	ret = mtk_ab_select(desc, &slot);
+	if (ret < 0)
+		goto error;
+
+	printf("MediaTek A/B: slot %c, partition %d\n", 'A' + slot, ret);
+	return ret;
+
+error:
+	printf("MediaTek A/B: selection failed (%d)\n", ret);
+	return ret;
+}
diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
index e36e8faeb48..ea1966c21ff 100644
--- a/doc/board/mediatek/mt8188-genio-evk.rst
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -36,7 +36,8 @@ followed by U-Boot SPL. The DDR loader initializes DRAM, copies the fixed
 ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE`` to ``CONFIG_SPL_TEXT_BASE`` and enters
 SPL at EL3 with exceptions masked.
 
-SPL reads a FIT image from partition 1 of the eMMC user area. The FIT contains
+By default, SPL reads a FIT image from partition 1 of the eMMC user area.
+Optional firmware A/B selection is described below. The FIT contains
 Arm Trusted Firmware-A (BL31), OP-TEE (BL32), U-Boot proper (BL33) and the
 U-Boot control devicetree. It is an ordinary, directly parseable FIT whose
 first word is the FDT magic; the complete FIT container must not be compressed.
@@ -252,12 +253,12 @@ Image                Destination
 ===================  ================================================
 
 The standard Genio 510 and Genio 700 partition layouts name GPT partition 1
-``bootloaders``. SPL selects the partition by number through
+``bootloaders``. By default, SPL selects the partition by number through
 ``CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION``; it does not locate it by name.
 
 Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
 the platform recovery path and any backup bootloader partition while testing.
-Selection of a backup partition is not implemented by this SPL configuration.
+Selection of a backup partition requires the optional firmware A/B support.
 
 Using Genio Tools
 ~~~~~~~~~~~~~~~~~
@@ -279,3 +280,81 @@ Genio Tools uses the default bootstrap from the image directory. Keep
 ``bootloaders_b`` unchanged until the new images have been tested. Add
 ``--dry-run`` to check the selected files and partitions without accessing the
 board.
+
+Firmware A/B in SPL
+------------------
+
+``CONFIG_SPL_MTK_FIRMWARE_AB`` enables A/B selection for the firmware loaded
+by SPL from eMMC. It is disabled by default. Enable it only with an updater
+that activates firmware slots and a service that confirms successful boots.
+After selecting the board defconfig, enable it with::
+
+   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
+         --disable SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION \
+         --enable SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC \
+         --disable SPL_RAW_IMAGE_SUPPORT \
+         --disable SPL_LEGACY_IMAGE_FORMAT \
+         --enable SPL_MTK_FIRMWARE_AB
+   $ make olddefconfig
+
+Install a complete ``bootloaders.img`` FIT in each of the ``bootloaders``
+(slot A) and ``bootloaders_b`` (slot B) GPT partitions. The ``misc`` partition
+stores the selected slot and boot-attempt counters. When migrating from BL2,
+replace the FIP images in both slots with FIT images. To verify signed
+firmware, also follow `Signed bootloader FIT`_; A/B selection does not enable
+signature verification. Both slot images must then be signed with a key
+trusted by the installed SPL.
+
+The DDR loader and SPL in boot0 are shared by both firmware slots.
+
+With SPL installed in the standard RITY eMMC layout, the boot flow is::
+
+              BootROM
+                 |
+                 v
+   +---------------------------+     +---------------------------+
+   | boot0                     |     | boot1                     |
+   | DDR loader -> SPL         |     | U-Boot environment        |
+   | shared by slots A and B   |     | not a firmware slot       |
+   +-------------+-------------+     +---------------------------+
+                 |
+                 v
+   +-------------------------------------------------------------+
+   | eMMC user area (GPT partitions)                             |
+   |                                                             |
+   |   +-----------------------------------------------------+   |
+   |   | misc                                                |   |
+   |   | Selected firmware slot and boot-attempt counters    |   |
+   |   +-------------------------+---------------------------+   |
+   |                             |                               |
+   |                     select A or B                           |
+   |              +--------------+--------------+                |
+   |              v                             v                |
+   |   +-----------------------+   +-------------------------+   |
+   |   | bootloaders (slot A)  |   | bootloaders_b (slot B)  |   |
+   |   | FIT: BL31, BL32, BL33 |   | FIT: BL31, BL32, BL33   |   |
+   |   +-----------------------+   +-------------------------+   |
+   +-------------------------------------------------------------+
+
+Firmware updates and rollback
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Use an updater and boot-success service compatible with MediaTek firmware
+A/B metadata:
+
+1. Write and verify the new FIT in the inactive slot.
+2. Activate that slot for trial booting.
+3. After booting and completing the required health checks, mark the booted
+   slot successful.
+
+A newly activated trial slot has eight boot attempts. Without confirmation,
+even a working image eventually exhausts its attempts. SPL then selects the
+other slot on the following boot, provided that slot has attempts remaining
+or was previously marked successful. Blank metadata initially selects slot A.
+
+A failed FIT load or verification stops the current boot. Configure a watchdog
+or another reset mechanism if unattended retries are required. Keep a working
+download/recovery path for exhausted slots or damaged metadata, including
+damage caused by an interrupted metadata update. A slot already marked
+successful is no longer subject to trial retries; a later failure of that
+image requires recovery.

---
base-commit: bd2f5794b7e24c62042abb1921f9c2039b920e02
change-id: 20260924-ccaione-upstream-mt8390-ab-631b4d4537f7

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

