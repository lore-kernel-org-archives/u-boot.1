Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189DFC79FBB
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 20:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5DB040BA4;
	Thu, 10 Sep 2026 20:03:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ByRgoZl27WBU; Thu, 10 Sep 2026 20:03:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C39D840BA1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789070607;
	b=B5ihTb+leiVwrOp29yB620l4tgqSR96XcHxKb1K2S0PIDQ/uuO+e3EHpWhspNSEnmZCm
	 2QkaXVJeRgbhwEgr1Y/2uxUN8dbNP7uIkTlscR8N07LEwry19lHk7LhZh+/4DKI3Z3s54
	 hkjmxgOS9S4EQ9GIJxZUWe/7SZXAaDi7MXyjSmbt8PFACfXpWe4/pKutss27lU+oGbqhH
	 g7wAOqJgGeGSpL8QHz0DrucBTs8uD4PXZaVrcUm9O95KTalpiN0cw07ZzhZAHGpDpmS1V
	 kZvo5PbFjbQR89FqAhNBp7DQYU5rO16AAwbLUKY6JlAapkRvt941XcNcSXA24uH8jlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789070607;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/SLl/LVJopbcnHSbRwxdudekOSVOVxwcQ8JSQbicUV4=;
	b=CTHyh1ZGjefhPkqVL891+IJEPm3uF/nbq8B3BIHHBhoJwbZprS9ULp9XQsORPW/8tDj3
	 na/YMsjaJaZwh2fT4YhusCWkI+rKEfYtAk60Pw0cRYPBQF92nuLw5am97qOpxZnfecKp7
	 56FSTyf9HZcm4ilzU0r9XnTPCA4VfBo0Ta6WUve38jq8vaasRygIGRv00eoWkZGgJytEj
	 6XKIT5F5qgsrjK4NyvrcWCWDhVDCZD8IDuCkCcgTAcz81jRuEba4sZRcN5ri2LkTbcdLp
	 BBp0lsg/kQU3wc/72hHzqBy+QQ0Dz7zfTpxntj8Z5tSGj7CLjmYl8RMMOuApmHa04Yw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789070606;
	bh=/SLl/LVJopbcnHSbRwxdudekOSVOVxwcQ8JSQbicUV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=greXgG2/aWHZ0jTupBIxTc0X7gL/JlXYWHO4INRWIcPw9ijWMi4xb4duS8O8IX4JV
	 mHXQIEueCnD2B6L5XnIyGGDLe7BGcItgLLXkfjMad2HryNe+RV054jhp4ROFyQ0HGZ
	 p85bTkdqYSwlpzLnCVqmvDuSiWfk+L8x+M8hECS/jAi6QZkYzXhVRb1mSybBBpCeN6
	 WA02j1VmviIY0nwS6d+noHc/MoWAs3vlyP+5EZTPLjmjDKHoFzNvPHK8udT3bJ906M
	 L+y05RG3E/VFNjl6+Nbr5Zrh4krEaiqN42ocnwtAw8RfGPGZnX385AlalNrBFKn4An
	 UhAULiW6M2cNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C39D840BA1;
	Thu, 10 Sep 2026 20:03:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1BBC14D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3F1560BE0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GnRBPBtNCADz for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 20:03:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DE2EE60BD6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789070599;
 b=rSBq892Nx5/DVDCgJmTPkneWFvMotMqLYKr93jGFxOgH/ZRsKTg3NjDYz0E+ZS7EACdK
 gCjnW4v5lJQU0Xu3jXWivYoQW/+Vn2md6fH20BxBFNrlatJoKGybmmvZN2OwY+r3+SErT
 1iJRtSLGX/Jc2B6EtPUVVxs7+ksTI/S1JQnoPVV5ZcLo/+7Z2L06GWxAvN2IHmU2nmnoJ
 npk+J1fPytRpC74PyVVbvB7Yd0oGsU0xA75gOJJLIKf9XMKZjngw47xYIwhs8cUf6Qp6d
 FhdJWW2TDnzB/2nhA19yClp6Rs4zybhKqC6Itp8YhYB8E0ewGn8AZM9BZJhCnWxcQFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789070599;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=/SLl/LVJopbcnHSbRwxdudekOSVOVxwcQ8JSQbicUV4=;
 b=KhEfD8BYCzCCNGmmeibZYSlHG6ZXOdiSCvLafvNbqW8z/N9bdiaBgQdpRJ5AXs0WdRqx
 8YVQKaLZz402ICnU/UaFP0Phlgu2R9Z6AkNeiTWGWjTvCXzr39MBipOD2f+x4YR5z+i4S
 ZYP65ZiEziTXp+XUSii9YwPwBU31O0vcv6k3J5DwQCJ5BcIkWVTxtJ0faOhB7y6JinMNC
 GjZXcDr18/S0HYdMiye48aHqloVsqTwE6VdZP5d+q8z6PZQqI5zdsObu0O02hAXDsNkd0
 wYVlw6NHuRtUzbZXknDl5qHdgWFLY3VOhEv4+rKzQ8R/q7TrMIGaDycwXsinGHFlXJA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OqnLJfcy; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::6;
 helo=mail-oi2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OqnLJfcy
Received: from mail-oi2-x06.google.com (mail-oi2-x06.google.com
 [IPv6:2607:f8b0:4864:32::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE2EE60BD6
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:18 +0000 (UTC)
Received: by mail-oi2-x06.google.com with SMTP id
 5614622812f47-4b3759b7ff0so127566b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789070597; x=1789675397;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/SLl/LVJopbcnHSbRwxdudekOSVOVxwcQ8JSQbicUV4=;
 b=OqnLJfcyuwFrmHxFlvYieUCcIgL34OUgPLW4QlG8Cr9vjnABMNzdCisYJrK7sWHoBh
 uEs1ftKShAd3Ih8fN3Wm5vxqznW7pUFpUUp2M/vDRayoJllSFfeeaDiKp7sWDhMODKKM
 vEBKnsl0P5sU3eWcJGBgbOaW1ydXiWyYlYIGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789070597; x=1789675397;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/SLl/LVJopbcnHSbRwxdudekOSVOVxwcQ8JSQbicUV4=;
 b=XXDvixFQ38R+wr4GlnAINSYICFlx2NER06w50Sxe7dj3lStlFWtUukuuPStu820ajU
 VIwvAWlBU6Lvm++kF4MzR5GbptlYWjjrPasRgMLlUDPM26sJT3ie9TJ0FOUaRGkq8wVG
 GPk+w6F8sSYwm12D4GaJSwYmQKHwycedjdkLRnHP9iGBb3fgVO1+nVxgn596cIraTVjw
 mQBCDK97s55PM65jitKL2Jn8h70XiyGRcgpGfyeHszW9JWEiUsioFfZVQvLAPq2j3at0
 7leAZYfRCIrbVeeEkB7/u0GdKLHtnFnmTNdgw1zHUZ3qiFsZBd+hje+Yxumk3tBfC42h
 v6sA==
X-Gm-Message-State: AFuF++khwy74k1+PgFZcDXndVzU6YilMgCGWUn3KOOoJUXkfxe1hqjjx
 dVzo4iR5dGQ8lz1Nd99Rc5KXCBYa4NmdGCNWrz/GmMXt6IEDXcSjEi2tHbuRKC//b2i3H6gchnJ
 MWF6OQhtxeLl0rKk=
X-Gm-Gg: AYBFou1lvRLYxCnf1baoYO9OGVZ2fhKfYtQM4Oudt3RUPsnW47LkIjsVIH2hp07dxcS
 y0HayeFux6rZ1H7dnyEtyNlrTy85nKQtJjjnc2HW5YG+QzW7d7MadTWy7Ce7pd+iS7xmBSrzPD4
 RGAhj+Bz2CnCW+Z6TKZ1XSFdvZ42/Lt8KKAiHhqjgD7gbCvHTcihlHyP/FShAdnl5QuQdhEu9Iz
 anU4TwfTpp4W5wDHAZKr4yzh8kjquRp+R/QZCsal6wtIZxbXBAu12bdQBBS44EunVbSZNY3N7JE
 BtJsSium8/5rDgOa0wTPpGqJkg4FjcqPnUFXlOYKtCCuvBqGn4nPGK293qer9u2h2yh7HrD93Kk
 MHMQsjXCTUJAsvmgmUlqC+0yyZXcvPdaPOlRFluGHp8m7xYDOd2r5vCXkdek70l7CsAx9ezyl8/
 tf6NILyX6J/NQXtvQv45w+Ve/cXW6MAsFnQKlaZUkdeVhSkGCGXWT89boFxMN/h5hOAX/paq0TS
 VRddXsp5zcHuR5RsZYcgW68v6t9bX+6bbOFL53tihHVlbebbXGMlpvAnIrRBi+q7M9QMaw+LSAM
 YYSp/CUD1XRJaz0xMQ/YBP/s/75kfb+rsras6SBVjGZW
X-Received: by 2002:a05:6808:320a:b0:4b9:a829:f01e with SMTP id
 5614622812f47-4c31ca3c690mr483116b6e.42.1789070597275; 
 Thu, 10 Sep 2026 13:03:17 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c331bc937bsm208357b6e.11.2026.09.10.13.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:03:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 4/7] MAINTAINERS: Fix "typo" and similar incorrect entries
Date: Thu, 10 Sep 2026 14:03:06 -0600
Message-ID: <20260910200310.3503830-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910200310.3503830-1-trini@konsulko.com>
References: <20260910200310.3503830-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This goes and fixes MAINTAINERS file entries that reference files that
don't exist in mainline due things like:
- A typo / missing extension / similar
- Not updating the entry when the location was changed as part of review
  feedback

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v3:
- Drop boards/ti/ changes in favor of Bryan's series.

Cc: Michal Simek <michal.simek@amd.com>
---
 board/CZ.NIC/turris_omnia/MAINTAINERS             |  2 +-
 board/Marvell/octeontx/MAINTAINERS                |  3 +--
 board/Marvell/octeontx2/MAINTAINERS               |  3 +--
 board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  2 +-
 board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  2 +-
 board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  2 +-
 board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  2 +-
 board/amd/versal2/MAINTAINERS                     |  2 +-
 board/andestech/voyager/MAINTAINERS               |  2 +-
 board/atmel/sama5d29_curiosity/MAINTAINERS        |  2 +-
 board/atmel/sama7d65_curiosity/MAINTAINERS        |  2 +-
 board/atmel/sama7g54_curiosity/MAINTAINERS        |  2 +-
 board/atmel/sama7g5ek/MAINTAINERS                 |  2 +-
 board/bosch/acc/MAINTAINERS                       |  2 +-
 board/comtrend/vr3032u/MAINTAINERS                |  2 +-
 board/comtrend/wap5813n/MAINTAINERS               |  2 +-
 board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  2 +-
 board/davinci/da8xxevm/MAINTAINERS                |  2 +-
 board/friendlyarm/nanopi2/MAINTAINERS             |  2 +-
 board/gardena/smart-gateway-at91sam/MAINTAINERS   |  2 +-
 board/imgtec/xilfpga/MAINTAINERS                  |  2 +-
 board/intel/agilex7m-socdk/MAINTAINERS            |  2 +-
 board/libre-computer/aml-a311d-cc/MAINTAINERS     |  2 +-
 board/libre-computer/aml-s805x-ac/MAINTAINERS     |  2 +-
 board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  2 +-
 board/myir/mys_6ulx/MAINTAINERS                   |  3 ++-
 board/phytec/phycore_am62ax/MAINTAINERS           |  2 +-
 board/phytec/phycore_imx8mm/MAINTAINERS           |  2 +-
 board/siemens/iot2050/MAINTAINERS                 |  2 +-
 board/sifive/unmatched/MAINTAINERS                |  2 +-
 board/toradex/colibri-imx8x/MAINTAINERS           |  4 ++--
 board/toradex/colibri_imx7/MAINTAINERS            | 12 ++++++------
 board/toradex/colibri_vf/MAINTAINERS              |  2 +-
 board/toradex/smarc-imx8mp/MAINTAINERS            |  2 +-
 board/xilinx/zynqmp_r5/MAINTAINERS                |  2 +-
 board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  2 +-
 36 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/board/CZ.NIC/turris_omnia/MAINTAINERS b/board/CZ.NIC/turris_omnia/MAINTAINERS
index effce8a753b4..33ddf51ce42d 100644
--- a/board/CZ.NIC/turris_omnia/MAINTAINERS
+++ b/board/CZ.NIC/turris_omnia/MAINTAINERS
@@ -5,5 +5,5 @@ F:	arch/arm/dts/armada-385-turris-omnia*.dts*
 F:	board/CZ.NIC/turris_atsha_otp.*
 F:	board/CZ.NIC/turris_omnia/
 F:	configs/turris_omnia_defconfig
-F:	drivers/gpio/turris_omnia_mcu.c
+F:	drivers/misc/turris_omnia_mcu.c
 F:	include/configs/turris_omnia.h
diff --git a/board/Marvell/octeontx/MAINTAINERS b/board/Marvell/octeontx/MAINTAINERS
index 1f3b12b1abf2..fd6cabcfad7b 100644
--- a/board/Marvell/octeontx/MAINTAINERS
+++ b/board/Marvell/octeontx/MAINTAINERS
@@ -2,7 +2,6 @@ OCTEONTX BOARD
 M:	Aaron Williams <awilliams@marvell.com>
 S:	Maintained
 F:	board/Marvell/octeontx/
-F:	include/configs/octeontx_81xx.h
-F:	include/configs/octeontx_83xx.h
+F:	include/configs/octeontx_common.h
 F:	configs/octeontx_81xx_defconfig
 F:	configs/octeontx_83xx_defconfig
diff --git a/board/Marvell/octeontx2/MAINTAINERS b/board/Marvell/octeontx2/MAINTAINERS
index eec1d77dd108..0941a5269b2c 100644
--- a/board/Marvell/octeontx2/MAINTAINERS
+++ b/board/Marvell/octeontx2/MAINTAINERS
@@ -2,7 +2,6 @@ OCTEONTX2 BOARD
 M:	Aaron Williams <awilliams@marvell.com>
 S:	Maintained
 F:	board/Marvell/octeontx2/
-F:	include/configs/octeontx2_96xx.h
-F:	include/configs/octeontx2_95xx.h
+F:	include/configs/octeontx2_common.h
 F:	configs/octeontx2_96xx_defconfig
 F:	configs/octeontx2_95xx_defconfig
diff --git a/board/advantech/imx8mp_rsb3720a1/MAINTAINERS b/board/advantech/imx8mp_rsb3720a1/MAINTAINERS
index bc967af4f509..02ee85fd7b1b 100644
--- a/board/advantech/imx8mp_rsb3720a1/MAINTAINERS
+++ b/board/advantech/imx8mp_rsb3720a1/MAINTAINERS
@@ -2,6 +2,6 @@ i.MX8MP RSB3720 BOARD
 M:	Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
 S:	Maintained
 F:	board/advantech/imx8mp_rsb3720a1/
-F:	include/configs/imx8mp_rsb3720a1.h
+F:	include/configs/imx8mp_rsb3720.h
 F:	configs/imx8mp_rsb3720a1_4G_defconfig
 F:	configs/imx8mp_rsb3720a1_6G_defconfig
diff --git a/board/advantech/imx8qm_dmsse20_a1/MAINTAINERS b/board/advantech/imx8qm_dmsse20_a1/MAINTAINERS
index 8292c6ba7122..8b933ad336b5 100644
--- a/board/advantech/imx8qm_dmsse20_a1/MAINTAINERS
+++ b/board/advantech/imx8qm_dmsse20_a1/MAINTAINERS
@@ -2,6 +2,6 @@ i.MX8QM ROM DMSSE20 a1 BOARD
 M:	Oliver Graute <oliver.graute@kococonnector.com>
 S:	Maintained
 F:	board/advantech/imx8qm_dmsse20_a1/
-F:	arch/arm/dts/imx8qm-dmsse20-a1.dtb
+F:	arch/arm/dts/imx8qm-dmsse20-a1.dts
 F:	include/configs/imx8qm_dmsse20.h
 F:	configs/imx8qm_dmsse20a1_defconfig
diff --git a/board/alliedtelesis/SBx81LIFKW/MAINTAINERS b/board/alliedtelesis/SBx81LIFKW/MAINTAINERS
index 31ccec0e9b7e..79e23f6724c8 100644
--- a/board/alliedtelesis/SBx81LIFKW/MAINTAINERS
+++ b/board/alliedtelesis/SBx81LIFKW/MAINTAINERS
@@ -2,6 +2,6 @@ SBx81LIFKW BOARD
 M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
 S:	Maintained
 F:	board/alliedtelesis/SBx81LIFKW/
-F:	include/configs/SBx81LIFKW
+F:	include/configs/SBx81LIFKW.h
 F:	configs/SBx81LIFKW_defconfig
 F:	arch/arm/dts/kirkwood-atl-sbx81lifkw.dts
diff --git a/board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS b/board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS
index 6b722ded250e..25b94774de25 100644
--- a/board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS
+++ b/board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS
@@ -2,6 +2,6 @@ SBx81LIFXCAT BOARD
 M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
 S:	Maintained
 F:	board/alliedtelesis/SBx81LIFXCAT/
-F:	include/configs/SBx81LIFXCAT
+F:	include/configs/SBx81LIFXCAT.h
 F:	configs/SBx81LIFXCAT_defconfig
 F:	arch/arm/dts/kirkwood-atl-sbx81lifxcat.dts
diff --git a/board/amd/versal2/MAINTAINERS b/board/amd/versal2/MAINTAINERS
index 282eaddd7532..3c35f9c30100 100644
--- a/board/amd/versal2/MAINTAINERS
+++ b/board/amd/versal2/MAINTAINERS
@@ -2,6 +2,6 @@ XILINX_VERSAL2 BOARDS
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
-F:	arch/arm/dts/versal2*
+F:	arch/arm/dts/amd-versal2*
 F:	board/amd/
 F:	configs/amd*
diff --git a/board/andestech/voyager/MAINTAINERS b/board/andestech/voyager/MAINTAINERS
index b87026ee383b..c0eee0f9eb4e 100644
--- a/board/andestech/voyager/MAINTAINERS
+++ b/board/andestech/voyager/MAINTAINERS
@@ -4,5 +4,5 @@ S:	Maintained
 F:	board/andestech/voyager/
 F:	configs/voyager_spl_defconfig
 F:	doc/board/andestech/voyager.rst
-F:	include/configs/qilai.h
+F:	include/configs/voyager.h
 
diff --git a/board/atmel/sama5d29_curiosity/MAINTAINERS b/board/atmel/sama5d29_curiosity/MAINTAINERS
index 54894d6cbb68..58f918c00c41 100644
--- a/board/atmel/sama5d29_curiosity/MAINTAINERS
+++ b/board/atmel/sama5d29_curiosity/MAINTAINERS
@@ -1,7 +1,7 @@
 SAMA5D29 CURIOSITY BOARD
 M:     Mihai Sain <mihai.sain@microchip.com>
 S:     Maintained
-F:     board/atmel/sama5d29_curiosity.c
+F:     board/atmel/sama5d29_curiosity/
 F:     include/configs/sama5d29_curiosity.h
 F:     configs/sama5d29_curiosity_mmc_defconfig
 F:     configs/sama5d29_curiosity_mmc1_defconfig
diff --git a/board/atmel/sama7d65_curiosity/MAINTAINERS b/board/atmel/sama7d65_curiosity/MAINTAINERS
index 054af3c65416..0720ae3c6a03 100644
--- a/board/atmel/sama7d65_curiosity/MAINTAINERS
+++ b/board/atmel/sama7d65_curiosity/MAINTAINERS
@@ -1,6 +1,6 @@
 SAMA7D65 CURIOSITY BOARD
 M:     Ryan Wanner <ryan.wanner@microchip.com>
 S:     Maintained
-F:     board/atmel/sama7d65_curiosity.c
+F:     board/atmel/sama7d65_curiosity/
 F:     include/configs/sama7d65_curiosity.h
 F:     configs/sama7d65_curiosity_mmc1_defconfig
diff --git a/board/atmel/sama7g54_curiosity/MAINTAINERS b/board/atmel/sama7g54_curiosity/MAINTAINERS
index b9f1a271c09c..3eb2657ca1c8 100644
--- a/board/atmel/sama7g54_curiosity/MAINTAINERS
+++ b/board/atmel/sama7g54_curiosity/MAINTAINERS
@@ -1,7 +1,7 @@
 SAMA7G54 CURIOSITY BOARD
 M:     Mihai Sain <mihai.sain@microchip.com>
 S:     Maintained
-F:     board/atmel/sama7g54_curiosity.c
+F:     board/atmel/sama7g54_curiosity/
 F:     include/configs/sama7g54_curiosity.h
 F:     configs/sama7g54_curiosity_mmc_defconfig
 F:     configs/sama7g54_curiosity_nandflash_defconfig
diff --git a/board/atmel/sama7g5ek/MAINTAINERS b/board/atmel/sama7g5ek/MAINTAINERS
index 4d1c6f666c0b..e2dca59f231d 100644
--- a/board/atmel/sama7g5ek/MAINTAINERS
+++ b/board/atmel/sama7g5ek/MAINTAINERS
@@ -1,7 +1,7 @@
 SAMA7G5 EK BOARD
 M:     Eugen Hristev <ehristev@kernel.org>
 S:     Maintained
-F:     board/atmel/sama7g5ek.c
+F:     board/atmel/sama7g5ek/
 F:     include/configs/sama7g5ek.h
 F:     configs/sama7g5ek_mmc1_defconfig
 F:     configs/sama7g5ek_mmc_defconfig
diff --git a/board/bosch/acc/MAINTAINERS b/board/bosch/acc/MAINTAINERS
index 1b880037121f..473fc0855dd0 100644
--- a/board/bosch/acc/MAINTAINERS
+++ b/board/bosch/acc/MAINTAINERS
@@ -6,4 +6,4 @@ F:	board/bosch/acc
 F:	include/configs/imx6q-bosch-acc.h
 F:	configs/imx6q_bosch_acc_defconfig
 F:	arch/arm/dts/imx6q-bosch-acc.dts
-F:	arch/arm/dts/imx6q-bosch-acc-u-boot.dts
+F:	arch/arm/dts/imx6q-bosch-acc-u-boot.dtsi
diff --git a/board/comtrend/vr3032u/MAINTAINERS b/board/comtrend/vr3032u/MAINTAINERS
index 132101f4cd0c..54c4aa229cec 100644
--- a/board/comtrend/vr3032u/MAINTAINERS
+++ b/board/comtrend/vr3032u/MAINTAINERS
@@ -2,5 +2,5 @@ COMTREND VR-3032U BOARD
 M:	Álvaro Fernández Rojas <noltari@gmail.com>
 S:	Maintained
 F:	board/comtrend/vr3032u/
-F:	include/configs/comtrend_vr-3032u.h
+F:	include/configs/comtrend_vr3032u.h
 F:	configs/comtrend_vr3032u_ram_defconfig
diff --git a/board/comtrend/wap5813n/MAINTAINERS b/board/comtrend/wap5813n/MAINTAINERS
index c6764831b2bc..8c8e0769f51f 100644
--- a/board/comtrend/wap5813n/MAINTAINERS
+++ b/board/comtrend/wap5813n/MAINTAINERS
@@ -2,5 +2,5 @@ COMTREND WAP-5813N BOARD
 M:	Álvaro Fernández Rojas <noltari@gmail.com>
 S:	Maintained
 F:	board/comtrend/wap5813n/
-F:	include/configs/comtrend_wap-5813n.h
+F:	include/configs/comtrend_wap5813n.h
 F:	configs/comtrend_wap5813n_ram_defconfig
diff --git a/board/coolpi/genbook_cm5_rk3588/MAINTAINERS b/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
index 0496cc93b599..15c2354e8225 100644
--- a/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
+++ b/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
@@ -1,7 +1,7 @@
 GENBOOK-CM5-RK3588
 M:	Andy Yan <andyshrk@163.com>
 S:	Maintained
-F:	board/coolpi/genbook-cm5-rk3588
+F:	board/coolpi/genbook_cm5_rk3588
 F:	include/configs/genbook-cm5-rk3588.h
 F:	configs/coolpi-cm5-genbook-rk3588_defconfig
 F:	arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
diff --git a/board/davinci/da8xxevm/MAINTAINERS b/board/davinci/da8xxevm/MAINTAINERS
index 993b22f2f638..c12b864b84b5 100644
--- a/board/davinci/da8xxevm/MAINTAINERS
+++ b/board/davinci/da8xxevm/MAINTAINERS
@@ -10,5 +10,5 @@ F:	configs/da850evm_direct_nor_defconfig
 OMAPL138_LCDK BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
-F:	include/configs/omap1l38_lcdk.h
+F:	include/configs/omapl138_lcdk.h
 F:	configs/omapl138_lcdk_defconfig
diff --git a/board/friendlyarm/nanopi2/MAINTAINERS b/board/friendlyarm/nanopi2/MAINTAINERS
index c8e2ce7b7c0e..781f00dce6d5 100644
--- a/board/friendlyarm/nanopi2/MAINTAINERS
+++ b/board/friendlyarm/nanopi2/MAINTAINERS
@@ -2,6 +2,6 @@ NANOPI2 BOARD
 NANOPC-T2 BOARD
 M:  Stefan Bosch <stefan_b@posteo.net>
 S:  Maintained
-F:  board/s5p4418/nanopi2/
+F:  board/friendlyarm/nanopi2/
 F:  include/configs/s5p4418_nanopi2.h
 F:  configs/s5p4418_nanopi2_defconfig
diff --git a/board/gardena/smart-gateway-at91sam/MAINTAINERS b/board/gardena/smart-gateway-at91sam/MAINTAINERS
index a5e4c71b824d..b115999fda61 100644
--- a/board/gardena/smart-gateway-at91sam/MAINTAINERS
+++ b/board/gardena/smart-gateway-at91sam/MAINTAINERS
@@ -4,4 +4,4 @@ S:	Maintained
 F:	board/gardena/smart-gateway-at91sam/
 F:	include/configs/gardena-smart-gateway-at91sam.h
 F:	configs/gardena-smart-gateway-at91sam_defconfig
-F:	arch/arm/dts/gardena-smart-gateway-at91sam.dts
+F:	arch/arm/dts/at91sam9g25-gardena-smart-gateway.dts
diff --git a/board/imgtec/xilfpga/MAINTAINERS b/board/imgtec/xilfpga/MAINTAINERS
index aa045325eac6..93a67e3af34b 100644
--- a/board/imgtec/xilfpga/MAINTAINERS
+++ b/board/imgtec/xilfpga/MAINTAINERS
@@ -2,5 +2,5 @@ XILFPGA BOARD
 M:	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
 S:	Maintained
 F:	board/imgtec/xilfpga
-F:	include/configs/xilfpga.h
+F:	include/configs/imgtec_xilfpga.h
 F:	configs/imgtec_xilfpga_defconfig
diff --git a/board/intel/agilex7m-socdk/MAINTAINERS b/board/intel/agilex7m-socdk/MAINTAINERS
index 9a5b80ae4dfe..eea2810d3287 100644
--- a/board/intel/agilex7m-socdk/MAINTAINERS
+++ b/board/intel/agilex7m-socdk/MAINTAINERS
@@ -7,4 +7,4 @@ F:	arch/arm/dts/socfpga_agilex7m*
 F:	arch/arm/mach-socfpga/spl_agilex7m.c
 F:	board/intel/agilex7m-socdk/
 F:	include/configs/socfpga_agilex7m_socdk.h
-F:	configs/socfpga_agilex7m_sdmmc_defconfig
+F:	configs/socfpga_agilex7m_defconfig
diff --git a/board/libre-computer/aml-a311d-cc/MAINTAINERS b/board/libre-computer/aml-a311d-cc/MAINTAINERS
index b4b77acd23b2..a5c4bcdb998c 100644
--- a/board/libre-computer/aml-a311d-cc/MAINTAINERS
+++ b/board/libre-computer/aml-a311d-cc/MAINTAINERS
@@ -2,6 +2,6 @@ LIBRE-COMPUTER AML-A311D-CC
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
-F:	board/amlogic/aml-a311d-cc/
+F:	board/libre-computer/aml-a311d-cc/
 F:	configs/aml-a311d-cc_defconfig
 F:	doc/board/amlogic/aml-a311d-cc.rst
diff --git a/board/libre-computer/aml-s805x-ac/MAINTAINERS b/board/libre-computer/aml-s805x-ac/MAINTAINERS
index 7cbc08aeb6c8..e434e5ed2289 100644
--- a/board/libre-computer/aml-s805x-ac/MAINTAINERS
+++ b/board/libre-computer/aml-s805x-ac/MAINTAINERS
@@ -2,7 +2,7 @@ LIBRE-COMPUTER AML-S805X-AC
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
-F:	board/amlogic/aml-s805x-ac/
+F:	board/libre-computer/aml-s805x-ac/
 F:	include/configs/libretech-ac.h
 F:	configs/libretech-ac_defconfig
 F:	doc/board/amlogic/libretech-ac.rst
diff --git a/board/libre-computer/aml-s905d3-cc/MAINTAINERS b/board/libre-computer/aml-s905d3-cc/MAINTAINERS
index 4b75c815c07c..274518d13a3b 100644
--- a/board/libre-computer/aml-s905d3-cc/MAINTAINERS
+++ b/board/libre-computer/aml-s905d3-cc/MAINTAINERS
@@ -2,6 +2,6 @@ LIBRE-COMPUTER AML-S905D3-CC
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
-F:	board/amlogic/aml-s905d3-cc/
+F:	board/libre-computer/aml-s905d3-cc/
 F:	configs/aml-s905d3-cc_defconfig
 F:	doc/board/amlogic/aml-s905d3-cc.rst
diff --git a/board/myir/mys_6ulx/MAINTAINERS b/board/myir/mys_6ulx/MAINTAINERS
index d4ee66118269..7f7850a566e7 100644
--- a/board/myir/mys_6ulx/MAINTAINERS
+++ b/board/myir/mys_6ulx/MAINTAINERS
@@ -1,8 +1,9 @@
 MYS_6ULX BOARD
 M:	Parthiban Nallathambi <parthiban@linumiz.com>
 S:	Maintained
-F:	arch/arm/dts/imx6ull-myir-mys-6ulx-nand.dts
 F:	arch/arm/dts/imx6ull-myir-mys-6ulx.dtsi
+F:	arch/arm/dts/imx6ull-myir-mys-6ulx-eval.dts
+F:	arch/arm/dts/imx6ull-myir-mys-6ulx-eval-u-boot.dts
 F:	arch/arm/dts/imx6ull-mys-6ulx-u-boot.dtsi
 F:	board/myir/mys_6ulx/
 F:	configs/myir_mys_6ulx_defconfig
diff --git a/board/phytec/phycore_am62ax/MAINTAINERS b/board/phytec/phycore_am62ax/MAINTAINERS
index ded4a88d1997..1e3d90a01a22 100644
--- a/board/phytec/phycore_am62ax/MAINTAINERS
+++ b/board/phytec/phycore_am62ax/MAINTAINERS
@@ -5,7 +5,7 @@ L:	upstream@lists.phytec.de
 W:	https://www.phytec.com/product/phycore-am62a
 S:	Maintained
 F:	arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
-F:	arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsit.dtsi
+F:	arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi
 F:	arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
 F:	arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
 F:	board/phytec/phycore_am62ax/
diff --git a/board/phytec/phycore_imx8mm/MAINTAINERS b/board/phytec/phycore_imx8mm/MAINTAINERS
index 5cada15ac4b3..e60bb94b91fb 100644
--- a/board/phytec/phycore_imx8mm/MAINTAINERS
+++ b/board/phytec/phycore_imx8mm/MAINTAINERS
@@ -10,5 +10,5 @@ F:	configs/imx8mm-phygate-tauri-l_defconfig
 F:      configs/phycore-imx8mm_defconfig
 F:	doc/board/phytec/imx8mm-phygate-tauri-l.rst
 F:	doc/board/phytec/index.rst
-F:	doc/board/phytec/phycore_imx8mm.rst
+F:	doc/board/phytec/phycore-imx8mm.rst
 F:      include/configs/phycore_imx8mm.h
diff --git a/board/siemens/iot2050/MAINTAINERS b/board/siemens/iot2050/MAINTAINERS
index 1b525356c2d6..2964de6a1631 100644
--- a/board/siemens/iot2050/MAINTAINERS
+++ b/board/siemens/iot2050/MAINTAINERS
@@ -5,5 +5,5 @@ S:	Maintained
 F:	board/siemens/iot2050/
 F:	include/configs/iot2050.h
 F:	configs/iot2050_defconfig
-F:	arch/arm/dts/iot2050-*
+F:	arch/arm/dts/*-iot2050-*
 F:	doc/board/siemens/iot2050.rst
diff --git a/board/sifive/unmatched/MAINTAINERS b/board/sifive/unmatched/MAINTAINERS
index e601a0f3288f..022434333ef9 100644
--- a/board/sifive/unmatched/MAINTAINERS
+++ b/board/sifive/unmatched/MAINTAINERS
@@ -3,6 +3,6 @@ M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Green Wan <green.wan@sifive.com>
 S:	Maintained
 F:	board/sifive/unmatched/
-F:	doc/board/sifive/hifive-unmatched-fu740.rst
+F:	doc/board/sifive/unmatched.rst
 F:	include/configs/sifive-unmatched.h
 F:	configs/sifive_unmatched_defconfig
diff --git a/board/toradex/colibri-imx8x/MAINTAINERS b/board/toradex/colibri-imx8x/MAINTAINERS
index 938c2ca0ca01..1aadf5450b3c 100644
--- a/board/toradex/colibri-imx8x/MAINTAINERS
+++ b/board/toradex/colibri-imx8x/MAINTAINERS
@@ -2,8 +2,8 @@ Colibri iMX8X
 M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 S:	Maintained
-F:	arch/arm/dts/fsl-imx8x-colibri.dts
-F:	arch/arm/dts/fsl-imx8x-colibri-u-boot.dtsi
+F:	arch/arm/dts/fsl-imx8qxp-colibri.dts
+F:	arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
 F:	board/toradex/colibri-imx8x/
 F:	board/toradex/common/
 F:	configs/colibri-imx8x_defconfig
diff --git a/board/toradex/colibri_imx7/MAINTAINERS b/board/toradex/colibri_imx7/MAINTAINERS
index 80770cc71a96..afdbb9b104ad 100644
--- a/board/toradex/colibri_imx7/MAINTAINERS
+++ b/board/toradex/colibri_imx7/MAINTAINERS
@@ -3,12 +3,12 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 W:	https://www.toradex.com/community
 S:	Maintained
-F:	arch/arm/boot/dts/imx7-colibri.dtsi
-F:	arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
-F:	arch/arm/boot/dts/imx7d-colibri.dtsi
-F:	arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
-F:	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
-F:	arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
+F:	arch/arm/dts/imx7-colibri.dtsi
+F:	arch/arm/dts/imx7-colibri-eval-v3.dtsi
+F:	arch/arm/dts/imx7d-colibri.dtsi
+F:	arch/arm/dts/imx7d-colibri-emmc.dtsi
+F:	arch/arm/dts/imx7d-colibri-emmc-eval-v3.dts
+F:	arch/arm/dts/imx7d-colibri-eval-v3.dts
 F:	board/toradex/colibri_imx7/
 F:	board/toradex/common/
 F:	configs/colibri_imx7_defconfig
diff --git a/board/toradex/colibri_vf/MAINTAINERS b/board/toradex/colibri_vf/MAINTAINERS
index a41bd165a7ca..330324ff1d1e 100644
--- a/board/toradex/colibri_vf/MAINTAINERS
+++ b/board/toradex/colibri_vf/MAINTAINERS
@@ -6,7 +6,7 @@ S:	Maintained
 F:	arch/arm/dts/vf-colibri.dtsi
 F:	arch/arm/dts/vf-colibri-eval-v3.dtsi
 F:	arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
-F:	arch/arm/dts/vf610-colibri.dts
+F:	arch/arm/dts/vf610-colibri.dtsi
 F:	board/toradex/colibri_vf/
 F:	board/toradex/common/
 F:	configs/colibri_vf_defconfig
diff --git a/board/toradex/smarc-imx8mp/MAINTAINERS b/board/toradex/smarc-imx8mp/MAINTAINERS
index f7fcef1c0921..77255a3e35aa 100644
--- a/board/toradex/smarc-imx8mp/MAINTAINERS
+++ b/board/toradex/smarc-imx8mp/MAINTAINERS
@@ -3,7 +3,7 @@ F:	arch/arm/dts/imx8mp-toradex-smarc-dev-u-boot.dtsi
 F:	board/toradex/smarc-imx8mp/
 F:	board/toradex/common/
 F:	configs/toradex-smarc-imx8mp_defconfig
-F:	doc/board/toradex/toradex-smarc-imx8mp.rst
+F:	doc/board/toradex/smarc-imx8mp.rst
 F:	include/configs/toradex-smarc-imx8mp.h
 M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
diff --git a/board/xilinx/zynqmp_r5/MAINTAINERS b/board/xilinx/zynqmp_r5/MAINTAINERS
index aa50e6dae5f5..0f096d2e71f1 100644
--- a/board/xilinx/zynqmp_r5/MAINTAINERS
+++ b/board/xilinx/zynqmp_r5/MAINTAINERS
@@ -3,5 +3,5 @@ M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
 F:	arch/arm/dts/zynqmp-r5*
 F:	board/xilinx/zynqmp_r5/
-F:	include/configs/xilinx_zynqmp_r5_*
+F:	include/configs/xilinx_zynqmp_r5*
 F:	configs/xilinx_zynqmp_r5_*
diff --git a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
index 79981aa43f13..7e0842ae675c 100644
--- a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
+++ b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
@@ -1,6 +1,6 @@
 ORANGEPI-5-RK3588-ULTRA
 M:	Niu Zhihong <zhihong@nzhnb.com>
 S:	Maintained
-F:	board/xunlong/orangepi-5-rk3588-ultra
+F:	board/xunlong/orangepi-5-ultra-rk3588
 F:	configs/orangepi-5-ultra-rk3588_defconfig
 F:	arch/arm/dts/rk3588-orangepi-5-ultra*
-- 
2.43.0

