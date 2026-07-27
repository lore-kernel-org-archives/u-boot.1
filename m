Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88036C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 276B16066F;
	Mon, 27 Jul 2026 08:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GxUOIqQyeNQj; Mon, 27 Jul 2026 08:43:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AA84605DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785141838;
	bh=kUBVtkFgkN0+1bvYLGNthO2T8Vd2r38D09bji2RzPls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gpn8Ot6AzhqUJOCn2KUEcFeNvuVLGFxWaM9DXTg4l6+jy2Ju7l3x2zvt/UXqpUTld
	 lmsPK8En4HAoZVkqVRcTQS6fDdrU2ERszvi66cWS/XI3t/S1atx1qDq0vDh7oXtmbm
	 Ps+3NCMWjybeNUFJx4/3hYhseA+9hh2K95/N5S6DYhG7gduzo2Y5dUgg2o0rx/VSKC
	 W28I42U929lF++3A+GXgMDPnz9/MkZ+ErrgTeKjDQrIfzEn8+wrSexWM9klMcSNByj
	 H62mfuoFnwzSej59bGBU9oXUtfEJdU1AGhE6qObh7byx8lqBL5tUhDHMALpjth9TmC
	 dDFrfqAAj+Wfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AA84605DA;
	Mon, 27 Jul 2026 08:43:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 580AA45B
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DFF140581
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zQCN5JyLOJno for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:43:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6D10D4057A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D10D4057A
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D10D4057A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:43:53 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47f9ab7ee38so1085755f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 01:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785141831; x=1785746631;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kUBVtkFgkN0+1bvYLGNthO2T8Vd2r38D09bji2RzPls=;
 b=SI6c5T9wSaEQQx/b2mbwopgnTFtVbcY6AjjqgEGg6v/WzMR3ydAzhv7BOmkvYRx/Iv
 ukBlP7Q2El1AvME09zu9e9vIHhq0ZR5SZTwaKTjnfHQh78EZLeI0we89urtX/bsQsbin
 72c4rZaL6emJagLZB2AnXUwJbb/ffbdJ/psmwTJ2FqRBDfuefdrqMBt56vkXbSFy0XyT
 U3lbe8P5emVjt9EJwCj+qCFKNY9PMuChQQMzmQVOj0bWKeHyUYCozZfHO3kKNjKa0Wj6
 YX49zcqLQdr3b7kQYVv3PSgKEQW36vuJRnzVw1xM5gjBs7+Om7r8vE8OOXAwwmtpBIr5
 U31g==
X-Gm-Message-State: AOJu0Yy/nr5jqw1C8lHJWH0ppXmvpQ6oQQZBUUf1uoAzMTELYduYCl7e
 jfNHPgDnIzwUMd9QUmATvGhf8ORvDa9/vzv3rx1Oa1IlRN+hiFzKD2yjXjaA1Dgy6nQ=
X-Gm-Gg: AR+sD11Fa9FbBcmtCoQ6V3bnmP5cNf9RSVReKoLhpCX1+svbALNTdtN+UWB2rODgQsO
 0yORh2PzD0J33K2vR+nMHUpA+2wup5OlTULZEH4hk23Hn+j9FsSLbgHzsDU2izZ9MPlmYokGx0d
 9zF3DmVqMYhPbVm0DHlDEQU/q0UktS7MfuzqEL80RxMfVf50qfLLdGwYnt8hZpL3Lfy51EcPjvh
 LGLCVhtfCIUTbSL2H/nwAUfcPcGetnwM4StsYkDLawg4UhlYvp1hN5wxmEKS4zLx+6IugFBNoRM
 gFE9WxEEXdtleXOZ+WQfGqOkWJlXd1RjduFUrSQPT6+D1gXBrBOPhrYIta1MYRe7erT9lq0j8oS
 j40T1h4TtmSglkEQyTU3xZ2NypYi0GxAIP3OLsQysNpL3SBNTWpDkGbgwEZ5B6o7I+EPFE/y68K
 iZbLMUl0KNS7XT/EajnR1D5j4i6BPmoJGOLQIiQDSvEzK2V/eLPTPs3RI1d9JZL52Zv+puTZYoZ
 EftzTSz8G7VhNN05W5UdNqwmNRz4Cm9d6Jlq5WS7uhyXfakaKIH91ykNf8gmTwQ3TG2PfBHEHaM
 YVGD6itH
X-Received: by 2002:a05:600c:1549:b0:495:636b:e4e9 with SMTP id
 5b1f17b1804b1-496b5f48230mr95188625e9.22.1785141831303; 
 Mon, 27 Jul 2026 01:43:51 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4ed6b76sm216330695e9.2.2026.07.27.01.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 01:43:50 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 27 Jul 2026 10:43:45 +0200
Subject: [PATCH v2 1/2] edid: add default EDID_ADDR macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mt8188-add-ddc-i2c-driver-v2-1-bf1c45fcd588@baylibre.com>
References: <20260727-mt8188-add-ddc-i2c-driver-v2-0-bf1c45fcd588@baylibre.com>
In-Reply-To: <20260727-mt8188-add-ddc-i2c-driver-v2-0-bf1c45fcd588@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Heiko Schocher <hs@nabladev.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785141831; x=1785746631;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kUBVtkFgkN0+1bvYLGNthO2T8Vd2r38D09bji2RzPls=;
 b=g45sNU396wFE89EQudRkgmoECBcHIomSioAJEQgYNY5laxhbtu1bUsv1BxiSpzjC1i
 mRooPt4M0/cFDM5iqT8Gcf3cR/dTCe5uZTqUVV5zkf0uGVquJv+MP0EDNBhglrLTEB0Z
 ABz+KBGFtuy7EF8cRoU3EnIDQCvKx17yNlWiPig/Wh+hZk5yjHMxr8NNPREH7L3dZpJB
 4nQZe1aOKMXadhGF9K7Hh5IKehjA8a1lBHYFyfy32axxLyGDiq0vMC8lGJq6yNMPb9lC
 OQL6FKJ4OOuzWwCAc0ahjEUMLfDiRUlnV8XCqStNfJbHSmQLPqKng42EbcOP2A350uOd
 WAMg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=g45sNU39
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

EDID info is most of the time stored at address 0x50, so define a macro
for it in the common edid.h header.

Also drop the now-duplicate definition from the Rockchip edp_rk3288.h
header and rely on the common one.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Reviewed-by: Heiko Schocher <hs@nabladev.com>
---
 arch/arm/include/asm/arch-rockchip/edp_rk3288.h | 1 -
 include/edid.h                                  | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-rockchip/edp_rk3288.h b/arch/arm/include/asm/arch-rockchip/edp_rk3288.h
index edacf102852..2332ae30953 100644
--- a/arch/arm/include/asm/arch-rockchip/edp_rk3288.h
+++ b/arch/arm/include/asm/arch-rockchip/edp_rk3288.h
@@ -527,7 +527,6 @@ check_member(rk3288_edp, pll_reg_5, 0xa00);
 #define PLL_LOCK_TIMEOUT 10
 #define DP_INIT_TRIES 10
 
-#define EDID_ADDR				0x50
 #define EDID_LENGTH				0x80
 #define EDID_HEADER				0x00
 #define EDID_EXTENSION_FLAG			0x7e
diff --git a/include/edid.h b/include/edid.h
index cee7c4c7637..77a5d258311 100644
--- a/include/edid.h
+++ b/include/edid.h
@@ -14,6 +14,9 @@
 
 #include <linux/types.h>
 
+/* Default EDID address */
+#define EDID_ADDR	0x50
+
 /* Size of the EDID data */
 #define EDID_SIZE	128
 #define EDID_EXT_SIZE	256

-- 
2.54.0

