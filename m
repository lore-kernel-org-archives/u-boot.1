Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F407C624DE
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFA3040B3B;
	Thu,  3 Sep 2026 22:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 88M6xxRtJQjs; Thu,  3 Sep 2026 22:13:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5A18140B2A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473598;
	b=YbTrSxTMZ/A77Vulxp+vskGsJI8bERMi+yusgCNBB7kGJkNk+x9DlA3xoDIuGOZvQSN6
	 DxWpcve3VlITy4Rlp4IUFBZZp0RXuaKcHYGNpuJcsjUezKP9yPY0YLLzFGpxKfLq9kWi9
	 aTIBGI4Ey65FtHbgd1Ei3w/YwEVaAWqFF24jtVJivJzmli3W/uyFOL0xjXrqcnfWrnQY0
	 +v9w0MSIB1Is7KTjv9E6A7M5WHppGtb9c/fmTYeFOvxLGF5BStPaAM4uGuMhr5Tf+IYJP
	 uYNnpdaGR75K6rAC3z9XFuOuQerEwnl8PcT97Ku5vtslIxA5UPo9RRxfYQw8oLczwwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z9tw8ldpSMDFoXK7S4gblzI/0QK4OrR7V6OKHyCxewM=;
	b=Fm4Bjf7ZawcVUdc0UVIFHK2jmMpsqYz5NqvI51hyxLSabKupLiNceF8K1AJMN56Xvw6e
	 dUHh8rs+A1uTrMYNaXiDvhZsFTG5vRuis1185BBzvA5T8nM6qrX0z5b9tInd3TCi/LA7+
	 m1Qk+O1NR/W4nwZ/xRC0zFfsyLDDFYTF/xXJ4Sqv/wfjqQ2tQP5vVSe5azSCrRAAX6kfr
	 zyiKOxjNzcFH67F34SvLjwHSqR8Nf4QTT3fbMAdUUZpvtZHk/L6EIBxI2rgfBnswz6kc7
	 Qp2DWcpsVA2Zhb+Tif4BowFeowViYCApl6W3RzcgjI7NpIyOQVRxCGVXPZzrjOmryqg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ADLI4uRp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473598;
	bh=z9tw8ldpSMDFoXK7S4gblzI/0QK4OrR7V6OKHyCxewM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ExP/XhPkgvuWadVezxTdyHXBOEg0kYRuN+WbMt6wNwqV3CXUXqWNiZvqFuqFGSKUx
	 TC9013coEH44/HXYV6s75RKoYLDFol9k5BHOKRYC6PkMNqby0Umf6TOm3mQzZ59KVa
	 eXF+NcX3IJFNf9G0Vj2K72O1ewQAYTZCKnG+vHWZf845AeTeQl1GrOcfxDG2yriNwf
	 2jXvqES5ZMikIy3H7lzKNJj636q7H0bgD5tZPYFz1IOl/s9v7ojF9EkrgI+N/ik9VP
	 t+XfjTzoMD4nNPtBcMOc1+UuLjtlFXXesUJPtBGocAiO/Ca2p53LdZ3PlR+r/M5qqJ
	 KAnnt8Lyd2M+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A18140B2A;
	Thu,  3 Sep 2026 22:13:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F1C72363
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2EB840B00
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YOz8FV_nzDr8 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:37:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2F61F40AE8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471474;
 b=ZPXM8CkTU/yU+7EwkMxM70z4C9kKZ37eOHTAzmqI9nSnUVjfX93S6pyLJSDNaTeVyjL0
 aqk5VAge8erMDqxdVIr35lsUxCT8cK8jNeYRlMMaRCQuWOt6uj9CBY5/LKH1dW/T/Hcwu
 fwavDhuFebztrKf0AviYdm3nojtGt91kApl+LtbnjZyskkyyQ4l2XgxXoHWFSJP9fS46F
 pjFsh8EFZWyoUtzHKyZldZTvGwkNhMYPbLoqUk6LYxequIyKx6KE9Io2UN3Ldb24w+Zgi
 lM96UiuvaA+6GZruBpZvt1UqVI28rsGcSbIMKblaLLTgKIZCi/5i6rU4NN4BVpJwu9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471474;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=z9tw8ldpSMDFoXK7S4gblzI/0QK4OrR7V6OKHyCxewM=;
 b=BRHXBo6hV9ur7mBwCKpAnyNcUUr2KnYIq/kErMjWHwrT8bFq/f8MZH4w/ziOo/b3XMoH
 B3r2mez/7Feuf5YS3lsTbNwdVdUZ71P9LQnkP0762m0i4EXLNoVUjhjs/EsMIRQ8V2BpU
 FrUQIO+BAcv6l7NIV0X6QU/9cCWOFqzJMREqH/u2ud8yoFAx6KOnlF8ZGCowMyf0MOUwy
 1ADUOVMj3nLDk4n/E4RUHGgkNkjMGkhbe0KxtrBo84zAt1V4YdlL+zpGnw2xGJISa2Yys
 EMLlSWaRumP0zldlXx0a4nKtS6ZFox71AF69y0EzT9QfpdZkwEbATIuVMRlSC9LPvog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ADLI4uRp; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ADLI4uRp
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F61F40AE8
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:52 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6b1497f0453so229937eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471472; x=1789076272;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z9tw8ldpSMDFoXK7S4gblzI/0QK4OrR7V6OKHyCxewM=;
 b=ADLI4uRpWewxTGCOYXXsnnMNzoaGXejH271zoUHK82xtmNWBKbPOlQZZwVDevGPR4o
 ap0wT/IThBzezBQCsG//PQIqMNLFg9o94xDwvlwAOexpRIZmuFvKhWqrP6TjAR2P7wpW
 nnj3k8RgYnJEqa5pbfbCLFavlCkrtlPL0thOvVQWqqGgAdWN77ws8AHATmrx3cL2L0GF
 ts7vIN+4hI9OIAGbgc3oTq1wVtbv1Me8yZHXIGfvL1bZQeOwUPuAQAubOC4yQFzO8izI
 ZhpUgTEVRqBXuWEbapK1GdgzVTf2z9p/C+lRzQ9yTxL1BTxFf3fpZgOQfVutWlYlsIe5
 7bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471472; x=1789076272;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z9tw8ldpSMDFoXK7S4gblzI/0QK4OrR7V6OKHyCxewM=;
 b=StDa+8VHXjgNuNl6bRklmvCI+3ldoFHyGqwNtBVEPIcy5h/7PdAzIEyE9oari9rsgH
 MEyUy/D2cqwEbrDUh4eonz1b8dQ0Xzla/wcpvna6dwuqiBbGVm4KwXM9sCegbJN2/e6D
 lYZtaf/5767yIWSkajyUU9CufVxDXYW9+GCKwJAgcW+hQh64F0P7GHewFkLL79XV4kLh
 Qa9329qwBuIQlVcw8X8vR/1La45lEBirvZDpWkZcaCTlM+l15zMv74pnLIeZ7riK3Gir
 0W6mdkokRuf1m9nX0YIL8mnHQOIr2DVU7038zQjPyRaOzXa5Yg4Yw3M6yvrDQSBeRCJ1
 h7ow==
X-Forwarded-Encrypted: i=1;
 AKwUvByYEDfpLw9Oen4qJNtoxBALUkSuaAO6uqVsyONtJAUFJ6C0gKz/jMGL58hw+FtXww2XuSf53Wo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nEC/qfAG3Bj32fteX3Xil/xX14DHx479klHUu2v4C8s9D3eTtO
 tT40R1UeFBJzY0/yHtf3X1ghJbI2bBJs1YR0XX0ZhOcWsFJVpWC2R/uRFJLEaYxSnEk=
X-Gm-Gg: AYBFou2errWrdLOnQt7SGzDQH0wtRmwIDqflDmys6w2ChWH5kJiJvyCkexX3/vD2Rtq
 pqsaczJtE6ILoP/hOhevZs9TEjSA60ImlJp3xhZ6CXvWIVzwPO+i/M2Y+y/B3kn04LN24M+4O1R
 ZsO+nR1efpjnqGnZoxpn2DZvZ2QcfE4lI+kQVUtktNmrnAjqXNaYOaTp+hkVzyForlwaga7UuYf
 nNQX7iVuU2sQpiwqEXE1293u6J5efST/h740Q15hvh2UzVnn/imWORxt58lgd0hXTGCGGl13xRe
 v/8etWO1WhSSZ5j3Vh3qiIvt6mN7yl5PI3ukJasDVOsVeCWqH8lWTXx8u7TopnKvzRX0+6Of5Eb
 B0lHrU9sq16z5AcJSswqr1WMlxxXh7hLcTwBssBwSc0zYwFAx25OqHCD8bImVFJK9gggiVJoDB7
 kiWhfNz2A58H6wYCSeSGYkYOjkIIRjFeSFH3UXO708Fn0yccD5vSanPclkzx6h08xZtbH177Ld0
 wV2cG4R0hUA2F70MA==
X-Received: by 2002:a05:6820:221d:b0:6b1:4357:9fe9 with SMTP id
 006d021491bc7-6b6fa5e8a94mr1407278eaf.6.1788471471650; 
 Thu, 03 Sep 2026 14:37:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:37:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:47 -0500
Subject: [PATCH 03/14] net: airoha_eth: check dev_remap_addr_name() for
 NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-3-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sjoerd Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Dylan Hung <dylan_hung@aspeedtech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=821; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=9zAs7qGYxmeucWU2J84Hf4fNwSXIBflmsEw2Jih30Lc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmehK9EU06MnR/yPLDRBZdujMoqbIrt9ZihiSk
 7Xjz0m7ZW+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnoShYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Atf0H/1XJWZ3eFEczI0AyN1DwjpY+qgt6AsX5PMfQpVr
 1IaOqACZ24G5YJKokc3K6b3jAgr6lVA/7Tz5IDGvJ2OG19rAPtOcAkLmPEAf3ZjNOHhnMOwaXPx
 YdimGUEXLt4chQbIyPMt5qP4DFItEoA06SlucPJlXKyXf8upmgZTXtJER3Cwm+OWlXTyvBMtu5L
 atWgmSkotmmC/++fBCNLJEnACCxFQlPZNQxiNoLOAptKgx6tXRGH6/Cehvymfh7zbuq0yS+3Gcx
 VEMKxuIHUcaO9qOKqNySR6Zz2fDJizIqvZxtiliJR2dnYEU0MpnqDqSWScFQNwRYOVljAnRw7Q4
 VuGU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:11 +0000
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

Check the return value of dev_remap_addr_name() for NULL instead of
IS_ERR(). This function only ever returns NULL on failure.

Fixes: 74fcb6a7a7e9 ("net: airoha: Add Airoha Ethernet driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/net/airoha_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index e5d39b95cc5..ac72df5b660 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -687,8 +687,8 @@ static int airoha_qdma_init(struct udevice *dev,
 
 	qdma->eth = eth;
 	qdma->regs = dev_remap_addr_name(dev, "qdma0");
-	if (IS_ERR(qdma->regs))
-		return PTR_ERR(qdma->regs);
+	if (!qdma->regs)
+		return -ENOMEM;
 
 	err = airoha_qdma_init_rx(qdma);
 	if (err)

-- 
2.43.0

