Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE714CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 14:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82DB140959;
	Fri,  9 Oct 2026 14:58:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rsOi_2CdTsrQ; Fri,  9 Oct 2026 14:58:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A55BE40955
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791557935;
	b=SvPoCDT0iOqs/ojvHrqjMxEYLvHgtx9w5IgvR7WNreZ/ekTnZtFcseMFgMpjnoMLQS6q
	 8M19IBI/l/VNTKnUoKxv3PtGze62NR8MwK0Sfjs1EzngQI/eISGIsOHjOlH0k8doTdhyX
	 AVD2WWshdluYs9U1YHoz2dmBWkDEpnQEZOPpdVJlIW6DstFDantIUIPML7/UZM9RP8b8C
	 gmZR+r936lDwN7ldX5roWP1DnHVFhw5n+szIPxl5HJaR9zt/awzYAVskA3Pk//Pvc7GFM
	 fiIMHbNLLKyF2HV8q408kxrFgFCpb2dCbBguBeYyyqDexIANxoxo8j3bpXabN7Bg7/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791557935;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PKkWiqqJwW8P4kod0pfn5okYOxCzCTzzLqn2wYe0uC0=;
	b=MoOH6BovFFcZ3OsdyrQ+2TxRCGoz+HTtrWoE3Ib+HM3MPOqCgtrfVlwKCdYWRINuAbvU
	 r76uC4/UUacM+6nUpQUnlFgC8UygCrSF24eZj1gXBdJeoyQhu6LyZuxiVfv0t8RUKe3mV
	 ekJeWpeXUQj37utV8Rlv4eb7khOmwXh+Zce3Rxc5XmaKSzE5jDPKB4vRMt3ifKTXBDZT5
	 dCErozMvbY+1++CHs+PphiTVLDG0ZWux6A6nGVQdR6Q3JUC4KENGERPYvEiT9gUZzp/Vz
	 rYu9pZUfEe0VgzsH2Py6SqYEJ5SybpUWtR7cspEyf4pW47NSvok8piCc5NdbyAYdjNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UmtFFeos;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791557935;
	bh=PKkWiqqJwW8P4kod0pfn5okYOxCzCTzzLqn2wYe0uC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z8WTwV1KMZDTtv6voAmfNF5CrphKH498g2iv5HH5tUIJ70YUuCTuikjPw66oVH9/6
	 Xwy2L210lz34VTELqCf6M4xIfD7cZY/P/lG5ogpzLo0gsxktTuXwQSw20t4nk3xNqq
	 l9RpbXwLIMeSdYiMYwQ8AVpAPCaehYUsn3k8L7ke8teOlqkRMhJnQ7OgZ6kLp4cHAT
	 5d0XB2PLjZC2eUGCkx8MuuMAQxy8v3pioZx1GjzQHIR16bqBZQgpdre67WNi29oSsr
	 vy/MC1hTJ3Zj5ZHl0Hzi3/l3f81o8iRVZbJdp5iJ4xIcTK3fynJnwIW5SA0RNa995N
	 GEXBYrT+tQXPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A55BE40955;
	Fri,  9 Oct 2026 14:58:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B718B2AA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9008E40956
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:58:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJWH3tfM5D48 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 14:58:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC79540955
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791557933;
 b=GkiLcJ3f4zTOyk8V5RK5dwjrIdoesGNfYReaB6uvwN+T1+rGyFE6YRnhWht6MapFeezH
 tVcdbCF34KGBquwbmu1TZKoWYsxgxvIrsKua7SCI/ArbXFjPZz6Hojal9tGmezuNBSk/p
 A8p1vSBLt0wroIrY4bxTkMrL8ilx4HU1fZrXBkR8Ax5wZNNYAfPLsdK2Ojg3Och/62XXg
 tZLS9xUmOfkH9hKEFMZbg/d3zrJv9c2B180d2dulVbNY4I5fbAYmtpBHBcOEMKbPnR82+
 a7UDzdse0sgPEZOPCfJzsz2Aq7drSKWOx2eWakPtx4UMcpsVeDc5gUPy6x7NyoC3WfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791557933;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=PKkWiqqJwW8P4kod0pfn5okYOxCzCTzzLqn2wYe0uC0=;
 b=JnUBSAxhnBYfFdXgMVhAJ6HUtz6Tf7OphHl+HpqZpv2SxR+r5qhL17GK7lSGEwTFcU8c
 oPz2Zqbi+1BBA+UUGBj9A2Y+yGc8KASdpcqVipC1Q5NT+/7fzlwB8z0JBSIRpzNaNXxtD
 glH83gLyHCZMYsZNMR/p10EjJytv2UMxn1WwA1MUE5rdjLc+beYnw+cPM7Ct64m4cEV/0
 9mVwi0xl20Wl6Um/VuTG850Q8lBpp+2X5+CJNKGP909ok07erpVMa8G7lhtjjx0evLZ9x
 EcqmM7VNeSZVyLbFqh751l2Sqv2kwZc61PpGJZtFwMAWgZ6PChT93HsyVycJVCHo3BQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UmtFFeos; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UmtFFeos
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC79540955
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:58:52 +0000 (UTC)
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3550c917fd3so677061eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791557931; x=1792162731;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PKkWiqqJwW8P4kod0pfn5okYOxCzCTzzLqn2wYe0uC0=;
 b=UmtFFeosMWrGO5wt6UKsFo9Lsa/NVkbz/5PI8C/hauxEhhk39Za4s+KMVewxjuENkg
 Bv0ma07VbmsJlQEIoHtjOGwXOGz4C8bZDsaMoGEKO+r2NAJQ4rBp8wOlKquQMIjXEi4q
 JCA8gizBXfvtyQDjR1va4YjmMUuMPYAzNsK+jkcQWNDG+HfLP2io+DioAFdk8XoVwtGM
 yDvc8U6K1LRLYI6Mgz5boUxjKr3o3ELL5BIXvmQOEcTDyge/A1LxQtyAlJ+ky3Ae00oy
 shnKtGVcWfuGfYXsJa5z0ghI3m87QprYpYuvAlLpw9j2deLTk1kC011nmdVWt+9d8bX7
 CTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791557931; x=1792162731;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PKkWiqqJwW8P4kod0pfn5okYOxCzCTzzLqn2wYe0uC0=;
 b=yQkRXX8KJyBBKRJy6BBfH8P+37qF6tP6QzugzPiJx2Pz53VRCBAcSZk6nBOuiSdv8T
 O1H85um24fbQtZHRKzBincxEXV4MbWb77MnAvLmVDSThLBIhJIEd7prpzknGY3Qr7gxP
 Si6P2ksaZGNbXsOTAbaYc0EIiGXqHE76XV11TwgcnGqNyhhn++DSxGPSD73/+C0GTOjf
 B9w2Ef8No5cadtAyvrutJB9oBlragmYRj+rTO1Hs/h+ffShvg0VdXfK4HGLHMuCCpHBZ
 5E9o3HuNtM0J5KRgBlHxgVOk7vlq9+tXVrCPFMKZMprbMRfBdJ2B+Z9V+UXekgndslEe
 sMjg==
X-Gm-Message-State: AFq9FYJPzDFzVEmzkmriQqrnGFl1ca6KEJp2g8zEqdc/80JE30V5qjVL
 /m/LnosXQXO3v8TlMo+qOjgUP0nNNu5O+IJMIBKCoO4sQU17XHIS3ZNCINmCtdlxgx0=
X-Gm-Gg: AYBFou17pNTXO7f5GPxpv8F3p8fx70bQBDPzqjS0WitYnfR9LhuS579zo7WAVY9LpcL
 uz+qomyzBT4X8qhQd9DUTlfWgZvoT5HYSMwZX4YtNP7P0McnPZLrq+n8ZbcP70pflQYPkxyI6k2
 zBEKu6jwWU9ogYIcf71prANC2ZgEHGHQkYBVlYc1N+RU5698jbsFFsjv+0CwmhCF66B2PqEpszl
 nG3Z5MsMfYzydO5FWVuMh/WCzSoRRFYAIhjN3DM3y45zJF3Igv1S5NhaHo6dsjUgoXeXZXdG6hT
 hJRSv1e5YIouuS1jfQeVe2EBOrPwFGmp6JpeXeGQkUBuFFAEuyeb9xiCWx6jnwl10ReCcAt6LUC
 lJZS6urN7DB69b44en3TGYvR7jQ+n1SpBmQ4rhZ04XDqpou4GqoGAh1DHW03gbgw/r5e1K6+kkf
 uyqgWQH2c1tll8Ib8pP4qJpFMRIB3hRyCrnqiHvv1ptsQhU8IPnuNFU0MpAOGXLYe9txRAgoHH9
 w2m+xW+Mi0/3SVtSP93KDD23PyYHE5F4m+25zYV5/ThpA8Y
X-Received: by 2002:a05:7301:4b0f:b0:350:4fc1:f22a with SMTP id
 5a478bee46e88-3537e0ba5bfmr2944165eec.21.1791557931022; 
 Fri, 09 Oct 2026 07:58:51 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::ffae])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm7126892eec.13.2026.10.09.07.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:58:50 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Fri, 09 Oct 2026 11:58:23 -0300
Subject: [PATCH v2 2/3] configs: milkv_duo: enable BOOTSTD_DEFAULTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-milkv-duo-bootstd-v2-2-c4679e726d10@baylibre.com>
References: <20261009-milkv-duo-bootstd-v2-0-c4679e726d10@baylibre.com>
In-Reply-To: <20261009-milkv-duo-bootstd-v2-0-c4679e726d10@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>
X-Mailer: b4 0.16.0
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

Enable CONFIG_BOOTSTD_DEFAULTS so the board can boot an extlinux.conf
with standard boot. This sets bootcmd to "bootflow scan" and enables
the script bootmeth, the ext4 commands and ping.

The rest of the diff comes from savedefconfig.

Reviewed-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 configs/milkv_duo_defconfig | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index f1f3930564b..8c6778442e6 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -11,18 +11,15 @@ CONFIG_TARGET_MILKV_DUO=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
-CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_SYS_CBSIZE=512
 CONFIG_SYS_PBSIZE=544
-CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="milkv_duo# "
 CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
 CONFIG_CMD_POWEROFF=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_PXE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
+# CONFIG_CMD_MII is not set
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK_SOPHGO_CV1800B=y

-- 
2.53.0

