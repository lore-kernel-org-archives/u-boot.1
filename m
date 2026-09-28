Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4C7C9832F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 752EA60689;
	Mon, 28 Sep 2026 09:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e9v6K90wKDef; Mon, 28 Sep 2026 09:17:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B37AE6067E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587059;
	b=ml82YCfPu9QQrIaIu7hJjKwwgVtgObkATCzVOFCc9krhodW9/VqcT0m4QU2/xiqX73Ln
	 up/7Mn9jSbNvl4OxIjc0wScf3O9IPY7Qr63VIK2sbfUdQtNgb9OqrCvSeTrAq/P7i6s76
	 YmT7wVkb2oN1vjSk1qzjM1b3K+ZKKOz/zb4rxXlxIy2ux9TqL9Sk//qLS7y6dD0bm7Bac
	 E4CvndUl4eNZikhNrpEzLohyZ9B1Y+9jYwaqC3mDsIs1syl0gzT/RzSAWmV8GvJyVpjFM
	 N35pBng/EZDYhmlgDaYVTQYo8qR8pPnWCKKXJ6ZXMUo7mR1bH1WDxhfkpfPQMm/dhkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587059;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
	b=cx1iw3XYALVIYhgSXxwzq6O6MqGT0lEfvfZmjW63vBzeY8IYyMRDTXmBNFU4b8YJ051p
	 iT3JmzHxkqlTZqmA4F2amTeAeM9TqPWq9A/+KqrcubcJJ6fymXQTZV12kKjIOHY5kNglh
	 yA6ixu2NfGWxsa1Uyg5U0JkWlkFAqkkX60+DlsKzdt80a36neT96aB1vBDeDj6zW6iHoB
	 o5rQLsiv5szPTMxaigc6U6f6nykjp6ty4Z4MWNXTP8uyyMy/zjiZPtZD/XPKf87T8vvPr
	 FAldhSqGvZr/DnOZyA4OfmMLbPcNZkMAEz8mjtf2ul6fFg4t9vcp663h6RiC2Jm90Aw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587059;
	bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lDNKfX8RiUZ27zt6Ccl/y1947rAGBfkN5/BA7Dz2SqBM4lfuIAOO9BYMov8R+CGiN
	 SntIWZG63CCzTfWyqB9BtRBD9WlpGfdkcft8Zz0VBzrx/HK0NaeN0Sc19Gn0qEfTKG
	 yqCyiFx1sUZDFGyZf5nXn+B4c7Qw+Ox0fWmtp1X6ZYLUVTzIWDldBJ/IBtOvEN4jiJ
	 vxxcKa1v6pbCOk0zRLf+9GnsWB8nLJ8Sicj9PsD/0FSOOEepvxztFT0Mj70DnomL9l
	 yn1v0Xrx7V0kKXQcCwp2lq2BKSEFTiYXfIT5qccpVT0kFaDo2MsJt6/i/9As6e/7Lb
	 afgmrI5D6G4kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B37AE6067E;
	Mon, 28 Sep 2026 09:17:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A17E824E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 879314059A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWLW-hRgC5OR for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 90FB94058E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790587057;
 b=DthHh2/Vbl4RKUsMlLLnjSqpVnJGAMHKiUqI8JOBYev1wYbCLotyMx9a7E9AwR5vFqc4
 bDnv3zaKj9hmUzvIuclPrKALSUdd+mgJ9SxvVbKz4YDKDJYmfzLoFGxLZeaxFW8MngrjB
 oz5XYi+GYjq9DU1Nh/zd4mRkgeX0+meYXoojWXvbWr77bPHc7gMynOrxhPxofLSICoPSJ
 b1ELbzah2QG96sImd6FL3DMi/5m0rdJJv2XmbHUF+abcSe4pxXCtpY2UnflTSJdlBlV8K
 E1/ynTr88OL5aRc8FB42fBSGqkkiIvLdkXCB9lUbJ9llvHbNbmOMkmMssDRl1wE4JLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587057;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
 b=iugoDll6rOQ099sip/YmYTUjcEsHs4GT2gCQ+E97C6Xmt6QkuX2rAoTiISppRQpr3pBu
 ttj5YGdkpXmV0uMwgQLKUlomu+fSXhHswuZaJlAHKlpYpNaYMS0L5pIQYAoaG9FA9hiON
 9kjtJvmjLB3gllq7rPynq9lG0Im+ZqEUpVs+6QURtI0GZyXjoJp8EmgFtZ9bV6h+52BVd
 MnnJDLBlCkSAPEVDb8qtho1lqpFsgjUyT5s6cU/puvjwJVYaDhp2CVcodzwIbJUqH85Ns
 ZN0tQkEWkFSZOwhWgwsb2th6VYeL76uN8chjCjtQCbY3yfiJtw6skfqAE0bViBVxBXw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VWdeEgZv; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VWdeEgZv
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90FB94058E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:35 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso26160955e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790587054; x=1791191854;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
 b=VWdeEgZvqTSz6Js/7Gu/I2WVYVUKetSMvW1ufeMF8RuUgm75bZAuftrSVn9+S6n2k3
 79x5Jc4b6hLEa5IPuMwFaochjwQyEGMypkHxYhEIYQqUlBF5CWTt5EHDwKX8ClodCSEr
 I3eFYnjPOkd7QNV0TWANtMoWy+Bw77KBFOuu83f2g5lU1OK40YtidO5YMsCZqXWxb8ow
 jwmo8b3I2+3WPs0imPvoUT2kFkCazauWnyMlWQnu+MqBPu1DY6FxpdTQ6S2SkiUCmDSD
 1Uzk3iSdBdYyG9wX+fUyk9h8GrzldOKmJ2KznzUIaRDP1tKvHEFWjCnvn9AiuTBSYD7x
 oQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587054; x=1791191854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
 b=vRqv5HMAKsuzXjLUAK2o8gH7y6fpbhySpaxurtR2ClP1/VJZl3gOgD/2iEq1bT68nX
 93ABHSe2VUazpzJmSNAlSRQDKt//ED6tJeZ7lkC9ra+9o2bum+CarbkY7HyhIAAWWjp/
 lddMcIFBHTKSXFDc6pKsvzBDUcu3PEf070C1fIsXEtat00trBpclowg41Tl7G+z5GUur
 gQFcEdxzHoVMRa3nkGBi64wTXZ35ZCsUlDZlK1ckSlYmd0dyLwtmQVtvTvQaf8IqIEL8
 O3+Km+ZPoJDguWSuE1gs0pVYxyAtNAnqHGbPSmrps9AZMUnSpRVG94sQhCv9+If1NPYS
 jlSw==
X-Gm-Message-State: AFuF++kSNYSE5Y2fyrtZ9D+2jYCcbK6CoCXPNTaLnHpgyD7IMSDWseXM
 +BoYEpdiLAfKo4i2IFLBZ0yLeJnpCrWJqkrpSdvgiVmR/YvrDe7K3bWt3jkpzl9r60wDonyOGte
 zl2zlsOs=
X-Gm-Gg: AYBFou04M8mmwa7sKpUpcCO1vCHZET4GXYEnKGu3c3HzntDbkl+ppHNbYFcIuu6KzcJ
 a5YylL7gY9iaekFczhtlbhhkUeWDlYThudD2pr3b+IRwG0TKECluEeTkNthw7umGxpMUBOaTvMK
 AAJYeAfD6aEgSBlBiwaBMCAbJXwkEBlCbuXguFc/5b9KKCzHUGJpBESuyNgRFdeR7Yk+Pc7hOaH
 1DUQNbF4RWc9KsTOpfrR6pd0roiFr+03dKdzrTcb4iV6kLVlHpcsk8bHw4oV/oFE5K4D3X6Tdkc
 i6vIiLCq18qcYADsgStZ5jAIhN1FC4p6HA9PZJDQ5KYcLaNwWFXSY3/0sr95IbvP+ESUtiaUI7R
 INwP9U7M3SRZV7dRVTFEVNx8+L8rp3xDuRMazpwRLB8u+x+VAeEZvRkFaQKouJJdXlMhdxut2QM
 EomVHmU71U7PnrRCE+Uvg+gEhjipQ4RmPUVrH+MMEnICvblJgI0zCw+YjFecNNM7cY9WKanW+qf
 ddlNQ5vI+ovXfhtNXUudfVaDGyxmEzzzlavBfr2eC0TL6W3ULPwzH63QkVctoLBWNJI7QFzcL39
 +43N2ew6OrB42sYhb9nkX68qv3x7LiiSEYodEAoJKDm8uHYiD4EAmyhl4cA7J4D+NA==
X-Received: by 2002:a05:600c:a16:b0:49f:eddb:bcb1 with SMTP id
 5b1f17b1804b1-49feddbbe6dmr178678575e9.25.1790587053998; 
 Mon, 28 Sep 2026 02:17:33 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm26404622f8f.30.2026.09.28.02.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:17:33 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 11:19:36 +0200
Subject: [PATCH v7 01/12] memory: sort the Makefile alphabetically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-add-genio-510-and-genio-700-hdmi-v7-1-ee4a61a8ac1d@baylibre.com>
References: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
In-Reply-To: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
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

The obj- list is sorted by config symbol except for ATMEL_EBI, which
sits between STM32_OMM and TI_AEMIF. Move it to its place so that new
entries have an unambiguous spot to go to.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/memory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 77294fac69d..d5f5b073672 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -1,8 +1,8 @@
 
+obj-$(CONFIG_ATMEL_EBI) += atmel_ebi.o
 obj-$(CONFIG_MEMORY) += memory-uclass.o
 obj-$(CONFIG_SANDBOX_MEMORY) += memory-sandbox.o
 obj-$(CONFIG_STM32_FMC2_EBI) += stm32-fmc2-ebi.o
 obj-$(CONFIG_STM32_OMM) += stm32_omm.o
-obj-$(CONFIG_ATMEL_EBI) += atmel_ebi.o
 obj-$(CONFIG_TI_AEMIF) += ti-aemif.o ti-aemif-cs.o
 obj-$(CONFIG_TI_GPMC) += ti-gpmc.o

-- 
2.55.0

