Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4965C624DE
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E4AB40BC8;
	Thu,  3 Sep 2026 22:13:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1PE7u2zjdGOe; Thu,  3 Sep 2026 22:13:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 09D0E40BC2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473632;
	b=HL9jbfgQsYwo2LDMMJkCLpuYak7h1PXC9upeuRpQgbMnFibQEyrI3taQZ8wgkg/3CeH3
	 uRl7MzXLFghIxh1BRXYQIggOlcLBxBuiuubPRE68GsYv7QbLBySXCQeMdImx2MmV7EpMz
	 MRZJRpjV14J2q6QCTM7fSgVjPi5vBHYKz9apaJVm840CkntnhXxohaM0FQv4RC8yclB7n
	 NpjvqeLwtmnUMGw7Lc97jBy86BUPKOno7XLFUxS4Jc+Fkacp9HHO/3ydLwnmsQy0lY8HB
	 hTncZl/8MaSN+1b/gC75yyy+m53Nb9AJtYhD6MZ8B/yVuZSn+AaIQJvZJahZD+yCpjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473632;
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
	bh=vG9/dmjenCGS6B8Fx2aV5Hno2/5cH5UnKZMZuJYDh7U=;
	b=gDTffUZBGgTFbjHWbkgjWOnZVrxrIhXm2odVEgJVg8ImsVfhhriD2hFi2QpttSsESwTH
	 oTjHPybymaha62wXNVS1Sn+516yf5OltEUfP6uJ2FWuqdc5QKWYm82EfIUTcYxfbwbFbg
	 bfPELDEFQn53GGjW1wyCZJvxKni+3dbNtoHlCGYpvI6T1RKfCq4mQK3RnJXBuA6iHiz+v
	 aVp3XdqJccK4kD4p1d7CGZ3/C6tJGkdsyBh0FN8BH7nH1juGyiEYArekRSwNT2AmQayvq
	 HBNB3V1pio+7MxepLMua3lM8munW6wZKvEeyE07MiouAEtRd9dfmmT0GKyxZwKRjPUA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473632;
	bh=vG9/dmjenCGS6B8Fx2aV5Hno2/5cH5UnKZMZuJYDh7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QitENjgwpx1otk8O49aHjPe+sURQX7cb+8prFzufsYqw1XpXfpB4qmQkEqTTG+Dz4
	 IYjda/erkIMR2bPlRqpJEi9bCJXoi5v8C2bucAcplTqfDQKhK6c7JsrrbS7fwL3KF2
	 l+IB0fCbBykc3WnhLohU59xi9hkfG5YCU4Pbkd3hmvdZ6A/jvdk0YT4dQIN13tgbuj
	 efXb/zRhwT2kVYB8dqbFY/S/LJgifisGjFwwA3afs95F5mTgWNsYVDPwBreNysvFa1
	 zA4+F/8+HcksCVdYIOAvY7rXu4kbPWh+qOn9j5vlAl6zup2ai2ldZbkDi76E9ZOMuY
	 j2ISo8tPuEG5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09D0E40BC2;
	Thu,  3 Sep 2026 22:13:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 04225422
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE6A460B6B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RVxRWf7mGt45 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:38:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3288760B4B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471503;
 b=lNGPh6BEAZs0teLIsQliUlcAXXH28eR52hvn1lzuGNUdh30jF1kRVRAjYtnk16WzJHSn
 H0P9eXm26uD8Sn+8J28ASzo18yivGoA7QLQYKBrSzA6xRGkR2eUP3hdB+G0uNiS4c3BO7
 fRpf41/o+W/q65rlPNEFrGRHqp0JCNAttWN+F45eHEI1Viei6aOYWB1RhBRh8M1BDevny
 2niZGpIqCuiZtrPgVqAiP9fNG9opS0ytTQsLKDp3d2OCsYVOeh4W7c5kOBqj8+iBxH+Pu
 YsKixP5qcwjwsF/ywiQMdjPHYui9MwpSViN8XE5vJsnRA5cPxbrPePA0RpDmQZNiCrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471503;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=vG9/dmjenCGS6B8Fx2aV5Hno2/5cH5UnKZMZuJYDh7U=;
 b=AJ/Wwr/Caa8qRl9Eh/vs3vHkAz3EDgMLYlljR7AovsysLGe309YAHRuJLX1LMYRG7SDK
 wT61fbIfmgCzGa3kv2nSFhwvyzChFesNKqbC4uSwgmOV4JL1xQQIIWTmo+swRs0VpQqAd
 77sap8y9kH20hB7wXHS0r8f7hPulMFYkjiHd46an8U5RCTd15ciHyT3Ehpgd8JgqVMjy0
 /nCgGzhr/LUSLSGdO02Xz7BUxq3F1ThLqbjmxsEerUcXFTRl9InGxqX10Y88rmaH14wuu
 2uv4aW/uao23Cgd+69sli6F01mgwzY5wDPOi5/JjaWElFFjL1Mz0aQXI6N5T4NYly2Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cUryVNb3; 
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cUryVNb3
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3288760B4B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:22 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-46ac530b9ebso254608fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471502; x=1789076302;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vG9/dmjenCGS6B8Fx2aV5Hno2/5cH5UnKZMZuJYDh7U=;
 b=cUryVNb3cZVWJDUJz3dJjSeK426mnbad/KWqgqGEhF5l3xw1hAHo9NSV8WUziXgD62
 GwRcrCeBHq8JD3+6Pq0arvd/csfuCIh17kbT41JiIYU2yP/n29zF0JmBGsKVWUD5jOVX
 EuVqNy5bxmfZd71myQRRHnLxvvJmcpeon7X+6v5/Vm+zoRcQVNhxNCsRpLLTKJvsZ1kp
 tweDUfe7yGLGKbtzF0H63Bbvvk+Zw1/mJxSv/VXk/VsHBshjW+07rRbiTctOhoOrjofA
 +0gTJo9I46Mw6AbrhOtctwxBtTZ0NdR/UbmYk9El7ycRjKxNDnRBhv0ALyDtAk6c8NrV
 nY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471502; x=1789076302;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vG9/dmjenCGS6B8Fx2aV5Hno2/5cH5UnKZMZuJYDh7U=;
 b=bHsJz1jAHlVu5wHkq2Qmmtih3ZEDIaf2aNS9pWBHIw5PrEcKNGtKj0RrcreZ7qJ5FU
 Uj7D2wTjts+28tK28TO8t5NRX8j8hopuyDeDt57J42gZ/syPJh3WR8bJuppwWh7EYzG+
 DFvIe1MmvSeRvPeX1XZj3VmCxz7zYCJcU8GvOgWcVJ/L7HjW1TziPZhOkfNSdzXbRTb0
 R6MtT32QT2EFgSJqIwOwU6XiuKW2RmqTlCsW0ZeQjdAOwZkGhn/zhOF/VCKKYm/yBX2S
 30G/U5Ptq884g2SjcABvoizQqSlVSYkJS1mR6xsnxhFMUoPH4sAmjPIToUhGHKaYqWRi
 E8fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHhd2zfz2d/lEK5gejvj/G+bBojVnU1E3patgWSYMjMfoGLogLcvHSjY00WcWMN62cjrnfdNM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nkjJAmNoU1IeruJouWzo0SXPvva2+lT1233nIuSV6Gjhv8sTfW
 NB7Gvu8q9aSDgE5drTJUIroFnssKZkmAdXexfH32DMY9aVpUaDkQWO5lmma9xcFlXnE=
X-Gm-Gg: AYBFou2oU/osJv4melrYOmdPhrMkz4RlNeG1bAbnmopKJRHXfdi10eB482Ra2SiDwRv
 uphGpUK2h4BOebvBdOYIsqR9RbfLFeO7XwaRwLIAmsm0bLqVsSZiQndq/hryuQ0e4J7PY5f+WlZ
 fwocR39MsUhzKNhlZoVII4j1I14wEIKbHJ6MmMYeGE7DeESeUOipfDyejWDjkmohfxMxChTSSDS
 MonR9I8z4A2pYpItCaZFRBAzrHBolOZ/V1Cu6KlLkgxHtCdfY+cVEo2wkzbc5WuNvki6kzV6l4P
 K5/UeO064JLOwq1OCfBdAmf1eg39iYcKzxq9uxK6hesv4chyj8kOaedOJ04ECkJoqJ7nxQn1vVP
 Vvu9IM9WANSsmaWvgn1MkgOuDIULye9AACUY+lFPG0rm9UJLy9Vm3v6vbMU4ct8PEwLAv7PC2Iz
 CkgCDQQKXmR+Q+Dp+NcLCZcN5TQa+lYBZkybgVg2Zt1o8BF59eGEh1MT3TOuR73S2xnA==
X-Received: by 2002:a05:6870:b493:b0:470:e96b:43e4 with SMTP id
 586e51a60fabf-4757d26a650mr298818fac.16.1788471501717; 
 Thu, 03 Sep 2026 14:38:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:38:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:58 -0500
Subject: [PATCH 14/14] arm: aspeed: ast2600: check devfdt_get_addr_ptr()
 for NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-14-db945bd5e712@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xkJj3ssP/c3X9wy9bUaOG/IsYkrr07VqGorCax3OpHk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmeiTHBo/s3XZnwNTlzf453GPufWbsFfgj2YTg
 XLfNih8t2qJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnokxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aa50H+waqou1HiU5IZojKd7sjy9JEgS9ZW0vi8UVoF2k
 ofFnOh/bzy3nUm4OglY+Lpv2RVSpoyHQCnmzmvT69mj+iRcOz9Hv9wFN9wQktCywMlpHES42Ynh
 EzYmbULrIsiBK6JyeUj2wwRqgtrhFtSYHddEhO6WthOMrVfz6PZmerpmtFn3AecSFS47aRX92Nq
 4fqR/uxLrGU8MB9vfyGKZsutpcc4FMBAD6CkRLg8vP3ebYOvF7W6f6Phkjkfv/qIeONyuwf6RNr
 5ELRosOmqpMrbSt84FKAzE7zPD6jVCkgDoG3xATtMIWdRyPOQaXWRJ0/Xe7l8C8rQ8tVzpSlydW
 ImEM=
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

Check the return value of devfdt_get_addr_ptr() for NULL instead of
IS_ERR_OR_NULL(). This function only ever returns NULL on failure.

Drop the now-unused <linux/err.h> include.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-aspeed/ast2600/board_common.c | 3 +--
 arch/arm/mach-aspeed/ast2600/spl.c          | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-aspeed/ast2600/board_common.c b/arch/arm/mach-aspeed/ast2600/board_common.c
index 4c0b705ea88..652eaa1c286 100644
--- a/arch/arm/mach-aspeed/ast2600/board_common.c
+++ b/arch/arm/mach-aspeed/ast2600/board_common.c
@@ -9,7 +9,6 @@
 #include <asm/io.h>
 #include <asm/arch/timer.h>
 #include <linux/bitops.h>
-#include <linux/err.h>
 #include <dm/uclass.h>
 #include <asm/arch/scu_ast2600.h>
 #include <asm/global_data.h>
@@ -81,7 +80,7 @@ void board_add_ram_info(int use_default)
 	}
 
 	scu = devfdt_get_addr_ptr(scu_dev);
-	if (IS_ERR_OR_NULL(scu)) {
+	if (!scu) {
 		debug("%s: cannot get SCU address pointer\n", __func__);
 		return;
 	}
diff --git a/arch/arm/mach-aspeed/ast2600/spl.c b/arch/arm/mach-aspeed/ast2600/spl.c
index 60f2c5d291e..e5813fb2b3e 100644
--- a/arch/arm/mach-aspeed/ast2600/spl.c
+++ b/arch/arm/mach-aspeed/ast2600/spl.c
@@ -6,7 +6,6 @@
 #include <dm.h>
 #include <spl.h>
 #include <init.h>
-#include <linux/err.h>
 #include <asm/io.h>
 #include <asm/arch/scu_ast2600.h>
 
@@ -36,7 +35,7 @@ u32 spl_boot_device(void)
 	}
 
 	scu = devfdt_get_addr_ptr(scu_dev);
-	if (IS_ERR_OR_NULL(scu)) {
+	if (!scu) {
 		debug("%s: failed to get SCU base\n", __func__);
 		goto out;
 	}

-- 
2.43.0

