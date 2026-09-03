Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47581C624D6
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B84840B35;
	Thu,  3 Sep 2026 22:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0mldzlJyCCq; Thu,  3 Sep 2026 22:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4B60340B27
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473596;
	b=qT28NTPkWlUPSvOXWNePABHxCCBuYCmqGAgm5EuU8/GiIEYbzyYlRHcO+eISCFhmTvrE
	 +murAc+M8xYt9y7foK790ilv3pyJ8MN1yU4ADI1/DuNc5fxc9gl37fWjH30JJx6OgFkuT
	 JHHlNKgpzmwaDBJfl5TFE006MT9zC/u+65c+c1q8Jjc3uVdBcDO8OeHadpuZi0pvYjaZb
	 9vPFoKyJwHKJjUimjaUqcNOmfrDZ0EfDkYBejvm78UZAqfMemRGfja/Pa0af0Ht86m0tR
	 0r9mZ3qpDj+xlaXC9u3IaUEx9Fi/Mx7r2gOJGiTpFPbB4obb3/68wTREMTVb/UcLtJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473596;
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
	bh=8ggS6eCv4RP1OMFuLxvC2C2V8PAYXkcoIFh83HmlGEg=;
	b=ZUOv1t9ORRdno3x7eLlep0zN1V+TKABQWU1D1H0clhdg/Hop3ZnPU8BdlUieW3rRp/Q2
	 /2JVjJj3Y/BX8DyoN3P9/cxMe2OKShDuHZJjVxA65aDyrw65cRwCbWtPz7VeXSAtEqynR
	 C6/vCKtAwQl+YlAdaVV2yFA1M5AKrPb2pptbkHOO2BFQmaNEh9GCo30xbnGlAj0DMCalq
	 CS65jSIkWjAvpdVPT0dk3NmGizQzLc0Wdpr5DYMeLy6Oqltz5Le0qHB0LMejGWsgVEA6O
	 GpwwnEcHG148hEaUX2SnT4cD3JkojIxGmB1trRgQ2kt6Qq9u0NKzkCwmnJGgIVbtlpA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Q2uwBNxn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473596;
	bh=8ggS6eCv4RP1OMFuLxvC2C2V8PAYXkcoIFh83HmlGEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e7DK8ACdmqp5pswQU90SlexzDJt4A6g+4lICP5wJKWt7sPZEylzifNGLfFpJ080zj
	 /VGlDn8olIPSiB0Rx9QPbjq8lDQ7RLxKrWvDOOAVwJckadtOQQ9PhfElKwMe/AeVsZ
	 BhvDFWZViXCyJZhPJTBv5Q3febaWSMziwJcVVlGym20u9NmleBLT0ez1aKp+ygbTCL
	 GmD/eTfx4rgU+tLIFduwrK8oJUSj1sbVuTWZ7efUr5deMz3Z3i+5zvvFkAIQHgZ9X+
	 1pAB6B+ADPLU5/wpwgdTPYCwPEw4dgA0ZiKzu3G2Tjbjw6NGeQsz3cixLTlUNhXdP1
	 vIt2w7HXLd5Bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B60340B27;
	Thu,  3 Sep 2026 22:13:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AC6F7422
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9264440AE8
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DsNxadIYEeoc for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:37:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B61A440B00
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471470;
 b=IckdPSqsCsFseFnq6GGGiBor9alCBTVE/Erc7fEXotvL2De9IYmoXYsQm+e0yGCts1/M
 UKBUJ4Q3e+tPEEkUgIksP85rw1HdaHsFIYV+jvcy64mzUOftm1Qxl/z+ScKbG/59AsNJ2
 /j65cEFWWDAlCDtLRJw3TaJvxLstn6qJ6l60qbanONxzCUvRRjc2YbjKp3p2t/SwqPaYG
 kTKqGoCPeBdtMj8pEVRfym3guSWFBzqwroCtbH0K9T7OigZfBiR263rc12R8YlbnjyccR
 /cROqKNgK4ia3cmGfXGBL/0TMc9ehqVXa0UTm7fvvqtp0IbG553frBpNzp1oBt451Gg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471470;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=8ggS6eCv4RP1OMFuLxvC2C2V8PAYXkcoIFh83HmlGEg=;
 b=tD0U3YbdoSfY6dAvJGJe3seruQNcJmOwowp+HYFA2IKaJZ3ni0ywI8kyaL96xpx2aH6H
 FFDegyfgVzLUO/op+OeWQo3eUnF1Qu1ANuPsX9rdaVqEQXuzgl0yCLT9Q+9JCHfsu6fBE
 0LdgZx6S3fdtb5BFDKnIidK5T2eM9piShwW8FZIKgeI06dIpT2rZm0oINkWC0PnoshO+0
 GkvwJz5pXESeuFxjLeeVMHKEGwrmvBtNWE/EuODSKnVyGyhGATErmBPl9mafdExKM+qHa
 LcIQDZs+GPVu48ZBLX9YqCqnYRh07/A+j2yS7glaBlPl3fVzD+BP56wTPt9P3Zly6Rw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Q2uwBNxn; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Q2uwBNxn
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B61A440B00
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:48 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6b1497f0453so229873eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471467; x=1789076267;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ggS6eCv4RP1OMFuLxvC2C2V8PAYXkcoIFh83HmlGEg=;
 b=Q2uwBNxnbNzd3YAeskNHK1wDkDNVLd+WW2dkKlHZ9am4KY67DQ7KAWGFXAj/Gzntgq
 gIWESKfnsnATqRQVxGhhGpJn3ojKVtlcnemohYSVqYvO/GF/XkclG2HpzThvQSwDEPye
 u7fi50QbctCOi2J3GrpNi2QHRPlydwPJ5u1CWzajQB03W4sK13+/0D87Fsf6VGnHYDF+
 JeKMwHXn6+HPzX2DS1i46njlFqo4u2wxBLyUvG9vxXlbK6IGTtWWfrQqJfnStwjGsi6p
 dk4nV5lwMYeU4I/O9hYEsZ0LUuVJkYSRUAofEOqbsfhjqY86fkz3BG0qDIXmGeOohSqP
 EWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471467; x=1789076267;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ggS6eCv4RP1OMFuLxvC2C2V8PAYXkcoIFh83HmlGEg=;
 b=QSSxbDdWcWkdSaCEh7gcv7HKLva17OZnjmXTYNOqmSR2EUGOgtqVx2VugLLtEGzeYH
 xOC84TFl+xjTZYmP74mUHyG9/sON1ZP+GwC02JacC9z6zdEpyCRdzyA2hpZTe7jLtFf0
 wRM2yNjlWrIpFvSRhfuftmCK4RMB0tqKzMXvIsUc01lR8QpaO6nw3nfqPv001Pb9CzQF
 DwFYcKMdIliq/0YUlxEr+p27mF5cfmeDrSM92jl/eAm3Y6+XDJ1b3tPJkdDyAWu1jlvp
 g1ENlHccjMclHkJQerskpDLaaG0O3plND3u+HbioJOWXW6KMds4Ql7h84EsworCtxMyn
 6xlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw47vW5vskLtDzIcKhI5zexGBAzgMJf9rB9bIb66UwO4RjnSKk1u1CYTtLJek5rMmjfJ/06Q84=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kZXF0hWXetC5kWu8iETxvKkjB/dzU9TZxfo9D94NeB1LLaGS/Q
 Pb8iE86ModMYbKq5NEG3TcAXPubRcWMtkpyoNHzrjtLJcepU/1+hmSn3FU/EZJ66Z9o=
X-Gm-Gg: AYBFou2IMEWiNDfz+u9YD2/BYhnJFhV07l8rechwRE4G8QTuSfz84ui4xL1KYeRXg8P
 j6olXXMbHwXoLSNSDNj+6Vqx3llP76mnhGV5gvmEjYisi/LJVatlhfsjk+sq7JSlet1Rmxb8aN/
 VDMTukHq8hGuw1MoXy/9LI2/RQzit4Cy/g0yJ6ETbipm1ZvACPNm3mZXLL9gYC0CXc3tArewLXB
 gSwb/0qPlNPoy6ePwa/nTTAWWYhp7QA+83nfNHoJDoxSKodW3RAfmS1SZ2wMGWM1KkFBE4eSQHg
 W6uhuVhurgB/LIHA1XkyGsRO0ioFKFI8no6gYbLejao8CNKD+0cK+OBH5smeYXoSlgfNA1Mp6KW
 vzxN3L8IIAvkQRZyVeqwncplHio8EecMR/E4T7KG/v8mrpqldiTs6U2+Q2J6PPAGqNgtGnIRFhS
 3TJdUwhVlRT/6MmO7cWdOL6QqIuEaCjYfZ/Fu4Z2IkhODGn0DwQ9ModdMVG2AhP2Zyo9hqvcbf7
 Ps00VA=
X-Received: by 2002:a05:6820:2d09:b0:6b1:9944:552b with SMTP id
 006d021491bc7-6b6fcac55ccmr1512240eaf.19.1788471467530; 
 Thu, 03 Sep 2026 14:37:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:37:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:46 -0500
Subject: [PATCH 02/14] net: mt7628-eth: check dev_remap_addr_index() for NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-2-db945bd5e712@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=mfDzSMFFkxWSjTXwciTnRmuGx81gTXYcXBlskJL7z6U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmehDLusYEGwDWKeBXMPfmLIlTTeyHWdUubuUV
 1cU5sYsN6CJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnoQxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A4fwH/jragHTJ0vHK2db2lTIf6cpa8GgbSLxX5E1y7/m
 ivBTBs78N6jwOmFCDxvuXkJpEySJ3O6YG4WllmvBu9HIqGIbMeuYdSXd4cUUJVZoPka0KNkIuzn
 Wdz52MR+vWTM4m8vL1VYwiBlEqj+ZkyTZ02pr3QUeRvJX+5LS1VBsvSIgOIzZAjWDTg5PjO+LSa
 LwUs6qpWyNFPLpG/DkRJRXdQop6h3Yc+1WWnMw+URQXCSiqTqJdmJWP6f0RAX8/XCjdQS0cyiST
 KxVY7fL/79UEISp3CUFEpcXWTt3A1yKpJOhrbk7Ts2g7l5kadcYfeaFPgDZU72Ghg9Pd1DFn/7M
 FzOo=
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

Check the return value of dev_remap_addr_index() for NULL instead of
IS_ERR(). This function only ever returns NULL on failure.

Replace the now-unused <linux/err.h> include with <errno.h>,
which is what actually provides the error codes this driver uses.

Fixes: c895ef465059 ("net: Add MT7628 ethernet driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/net/mt7628-eth.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mt7628-eth.c b/drivers/net/mt7628-eth.c
index fc8a6bb331b..fc99320af20 100644
--- a/drivers/net/mt7628-eth.c
+++ b/drivers/net/mt7628-eth.c
@@ -15,6 +15,7 @@
 
 #include <cpu_func.h>
 #include <dm.h>
+#include <errno.h>
 #include <log.h>
 #include <malloc.h>
 #include <miiphy.h>
@@ -26,7 +27,6 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
-#include <linux/err.h>
 #include <linux/printk.h>
 
 /* Ethernet frame engine register */
@@ -562,13 +562,13 @@ static int mt7628_eth_probe(struct udevice *dev)
 
 	/* Save frame-engine base address for later use */
 	priv->base = dev_remap_addr_index(dev, 0);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	if (!priv->base)
+		return -EINVAL;
 
 	/* Save switch base address for later use */
 	priv->eth_sw_base = dev_remap_addr_index(dev, 1);
-	if (IS_ERR(priv->eth_sw_base))
-		return PTR_ERR(priv->eth_sw_base);
+	if (!priv->eth_sw_base)
+		return -EINVAL;
 
 	/* Reset controller */
 	ret = reset_get_by_name(dev, "ephy", &priv->rst_ephy);

-- 
2.43.0

