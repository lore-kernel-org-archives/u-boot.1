Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEC0C982D8
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2731340F40;
	Sun, 20 Sep 2026 15:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kBQ_m4yIDqH; Sun, 20 Sep 2026 15:49:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0B37940F32
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919383;
	b=sO7whHCx7G0TiT18fpQW8JiA2FVopznYWwE40S/2deQwY42DBi53idAnE7svUWL3LTnR
	 s3+O9znScZyChKJZ+pkIENO6Q0P3wMKQa3nRu12iLNrBwg9KcqyHrkT99rZeC4QA+Elvm
	 qWZyapYqrrB9CHgX4uzZsRCEPakusDyCAkiuWKW3i0UaEoZ3PZM+XbsCfrx4zGpE/K0HM
	 c/1BTjsdr6kA8IOJDUewlqCQ5QfbuWXRrG4ndJqO1Bgu3RXKvwgxvTTz7nabfjRuctRAH
	 X/cfCHg92oQM96DaasyFEO0WVjo0co9+3zoY4JTWnR5Q7kJxPYBLopou/VsmAdaB4Kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919383;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4403ZLW9HWuVXQKWRAO07O3Fk4f6iNg3sQktLgpXu7Y=;
	b=L2/58xfqt195YyYmFu+YyFb6Tm8gEfcYJp2U1R4kcd+B4NWu8v6HmvzfHydNigZ5A0Hl
	 8GuJfFfKYIrb7ry9L/FDf/TWNXpK1/rhSpQYJ1MRkjQbD8FRrU1u3BJ7lbVry8reh1Si6
	 02hH+rvBQO7OS5izP82JxjVY789upvzK9WkkpK15CJSu9vslg4c4gE6eeLboRXL5aBuKZ
	 tW7ba12FINAqjyKDqfLPjkk8SC7hVQx9hwiWmDnCxgCARCPTk+PLZuNehTcDAstcx1Gx8
	 4cSMMGsaExaN4fIS3KvtFcE3Z2NXq5o7shX9ZHILK5ZzJDbepBjqHaIZK66/E76dEQg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j9my9TIj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919383;
	bh=4403ZLW9HWuVXQKWRAO07O3Fk4f6iNg3sQktLgpXu7Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yq9jSpRDQPUwcVmJwE0pXZWrvcj0wipJLY2dAxkVX4qhCUM1qax5O4DTP83bV0jt5
	 j2T0SjVlAVnmwK6RuKBYeZFDG8Vmt5IXpVomvdJ2keIVFxeuGksa6YX9aynBEmyupi
	 IazpRlBc438HFIs+4UvktBeUPYtk64w3IjpKNWDfwom5sPMsNxkmgZJ6IwLXEvwK5k
	 q0SwwPMZnCEFYNEjHbHg8uHL6oYEoT/cfkCGCk+vLd1jScRYAv0QQh3cK+BgjlP+7a
	 QmLXXCicQnbTOXX9jA9qlGTkOh4DqtR6+ItV7+pLj9WQhu5kJDqnWNV1/1zvrkTqE/
	 uAnvDrQEjLXNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B37940F32;
	Sun, 20 Sep 2026 15:49:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8569425B
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BA1240E42
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TtFAFh0D6cZw for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 14:16:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8295340E3C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789913801;
 b=Wz+yyrCyK+XiNU1u72VXtvIIdXnjEqtAeZGf/FVJyn9mMoIYX97FCLIyp7KBEddoQ0EH
 r/EQK7DpeUHTNGYtzJRrkMYBhEyU4TJJMlWeGa7xSP7a8U6aRnHB9XJbuLd9+mfqWGFT4
 y9L5NjgF5NI81sOoc3uAf9NEdT8DHBIRD33bHM8EAZYwq4YTyzn1/+o3EZfdLIvH9RhiP
 +fVB+6fYfdNPidvmBW+WV6AYlwOz/NxjMaurDn1DGT46DPdkUm3Fj2cfIMyt2K4SK3+bf
 xfQ0gBbPlHdNjBB3uitLT6vgn54etHoP9E/3XpKYy6kbasTu7M3UBVZT1AIx+yCQgYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789913801;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=4403ZLW9HWuVXQKWRAO07O3Fk4f6iNg3sQktLgpXu7Y=;
 b=Frqunj9OTW9/a6H3+MyhH4PQGRAZpFhZ1v4slupGxaxjoIj93XVi18N+q/fkdyyawbRk
 t3PnFNQWt9ELdSl6aP1up17++HONKhEnCRaXzdiF668EYvgLweif2sanjcwg6Cr6wABHr
 QyJCX56t/EE6GwofpB3D1tSqa/L4JYSSStWcuiQlfVfo9ekohXXSb1ISEs8Rb/PHg9xIx
 v3kItd8ZZWesD4ebwa7yeuJjCho+pVAtWa0JeHOMKw/HugF5FQqNoOvBVI5Ez7iGAgizZ
 SAXgQctxIDM3aFSsPfZQ99URCKNZZb7tYxrzU2oXZeUNsXQeIn7FuBINmGwgVYZ97jA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=j9my9TIj; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=j9my9TIj
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8295340E3C
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:40 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-484366874b0so1205480f8f.2
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789913798; x=1790518598;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4403ZLW9HWuVXQKWRAO07O3Fk4f6iNg3sQktLgpXu7Y=;
 b=j9my9TIjVHgH5clMbR/7ZIxEjH1wfkJuhiKgzxfkviaIlzFs77A3vbSNDa7ezYyWdj
 HpDI1ghkxA65X0h0fVEQG/d1E9a9ojBWABfREaxifV9vJPlvhaSPm35Sjgx1suYOdraJ
 RiGnE7Vf7gTINbsVa1dxk7g+EM2/7RVAHEiDFYrzH3xhDxi55pdws7IT9cr7iBY8kn/K
 bbrok3q/U45bevjfmPTz9IHidGm2mbdiTe3auy8LHf3ADUodlAwa7v0ihSR4JrZ4RJg8
 fxNf2zAoVuC9l2W5p7RnLXhr+LNqrk4hGaZuDQkCMhOxYgv8kI2I6hVy1aoYxPO4pcLA
 N6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789913798; x=1790518598;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4403ZLW9HWuVXQKWRAO07O3Fk4f6iNg3sQktLgpXu7Y=;
 b=LA4Cro0cAPGFLiIEh1dSaCHTPgNucr6Gz72hsmld9PUvVBn1JygmBCxNVEkgIqaI9k
 apcSiNEPt5kxA0SBUXDUInvI7K079oLBQthSxYWmHvlYmH3hQwAOdfTiLDd6lhSFmxAD
 pQAsUEKRv4VoFalyqqmMqZ2mVfngtg5tdOCBQOTR2lk+gR9mYvT1sZueEuq0YzjVjgwO
 M/f7vzUXaqUjGn20f9MOTn2hJfOalO8H3LkWqKBT9HsciUE/hJket+v0QNemHjZujmVf
 a9ZoMXnCToznzmQCggc0qBaQ5DmBMCBJavQUoh66mkWBmUvrOypstvhcGwGBzFsSpSgb
 ZXYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWr1MuJqvFDMKyACpkhEnXLZPGRUZs91pW1Zv4f+Gu3evAxgX5EGWyz2BW+rWpIs1xVTO1jck=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mrGy7CJ2lcBZDqhSnFPeevy733r0zcbPgfpLNBCWftAX31aVjS
 6hj67CINUv5JBenTBbdj826odtxVRIlLWNRIlODfg0+Lq8+rAJQPjawf
X-Gm-Gg: AYBFou3Rd/eohrXrxPyhSRiq0tChA9Dg/ZdVKqv8eTVk/Ikmqwv4IKnzYe0wbzgtB0C
 rzpjlAQyLtrVJeACPClno7LsATn1yd0XvtrQpAb4rlwbg2aN2r7dz6Jg4AkfyJkl01UwpyQV2ae
 eH+QWrC9WQPVN03Q09xn+bfSddhOwTqJ04pUy7lEiqFczyoNIOJpdzLGeoCn6WWMHDK5OQvP6kB
 h1rDSKr/a6BJKQQ3RofDsGUFaK72Q6S/tWPRBo2DndKOLNTL0Rk2jAsW/d5NQxdHyyPgDpN8U6f
 7/MKLTFxtlsFdCqwg+sGR85eDFRDFpbPtH5V0UrCIbpqGp1p9Ek9M0wHr10ngYdLgA8bdXPmrbE
 f8DiLUTXgIeO+yXXedPQ2qbgZ9aXDO5/MVSpstIA8mA+egMza3U+Ji0hYROug9ellhGSnM/fMCe
 hs3o/l1cQROOd38oggRoKjntNmFPCpiYuEBr9QQdG5Va4qmsraKIAKiTvaA6wcAv52rWnKwIpoA
 QCKs8lU
X-Received: by 2002:a05:600c:3512:b0:49f:ce78:3567 with SMTP id
 5b1f17b1804b1-49fce78363dmr52399085e9.24.1789913798159; 
 Sun, 20 Sep 2026 07:16:38 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.151.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm184107005e9.3.2026.09.20.07.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:16:37 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 20 Sep 2026 16:15:54 +0200
Subject: [PATCH RFC 10/11] configs: rockchip: resync Anbernic RG-DS with
 savedefconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-reset-v1-10-42820216369f@gmail.com>
References: <20260920-reset-v1-0-42820216369f@gmail.com>
In-Reply-To: <20260920-reset-v1-0-42820216369f@gmail.com>
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Levin Du <djw@t-chip.com.cn>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Alexey Charkov <alchark@flipper.net>, Fabio Estevam <festevam@nabladev.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Chris Morgan <macromorgan@hotmail.com>, 
 Coia Prant <coiaprant@gmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>, Andy Yan <andyshrk@163.com>, 
 Liangbin Lian <jjm2473@gmail.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Tianling Shen <cnsztl@gmail.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jiehui He <jiehui.he@foxmail.com>, 
 John Clark <inindev@gmail.com>, Sebastian Kropatsch <seb-dev@mail.de>, 
 Jagan Teki <jagan@edgeble.ai>, Ilya Katsnelson <me@0upti.me>, 
 Niu Zhihong <zhihong@nzhnb.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Akash Gajjar <gajjar04akash@gmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Eugen Hristev <ehristev@kernel.org>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, 
 Martin Herren <sputnik@on-the-web.ch>, Torsten Duwe <duwe@lst.de>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:49:13 +0000
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

Sync the defconfig file with the version from savedefconfig.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 configs/anbernic-rg-ds-rk3568_defconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/configs/anbernic-rg-ds-rk3568_defconfig b/configs/anbernic-rg-ds-rk3568_defconfig
index 399a216a7c9..816f78da4a3 100644
--- a/configs/anbernic-rg-ds-rk3568_defconfig
+++ b/configs/anbernic-rg-ds-rk3568_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-anbernic-rg-ds.dtb"
-# CONFIG_CONSOLE_MUX is not set
 CONFIG_BOARD_TYPES=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -31,16 +30,13 @@ CONFIG_CMD_PWM=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_CLS is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_LIST="rockchip/rk3568-anbernic-rg-ds"
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 # CONFIG_NET is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_ADC=y
 CONFIG_SPL_CLK=y
@@ -68,6 +64,5 @@ CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
-CONFIG_REGEX=y
 # CONFIG_RSA is not set
 CONFIG_ERRNO_STR=y

-- 
2.34.1

