Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF459CA5FE2
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ACF260D70;
	Fri,  2 Oct 2026 16:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nIsgoGfKGthy; Fri,  2 Oct 2026 16:36:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D600060894
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790958976;
	b=XfK9BGizu/s3EtSHETPpNNJ+gifgB4McdZIiyf7yh5oHUxSNPeMJGUJzg8xjwFDi2HR7
	 zi/BkKdEHxN2xMDBGFLx1W0JMzScaOWkk6qoS+We3hcbK1hJc4zzBeLuuBeRVKWPEWQER
	 zOP372eHjWP57IREz04CqcNme/ef4Vb+VFB/MUmekBwsfiUK7ArMh9bBiGd3IUsaf+Z0+
	 suBf0uorbw5D540oEVIdDTob1EP9/VmvXTQ0po2Liqo3ExLl1PyDGDzBd6Z0en/50lCnz
	 jVZdOfwGjO3uvRpoxkRACVf8w5T9oLsSDM9GoWSomiOi1blDp284+gKUun5To6cjw8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790958976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gMgG+0K2J1pVQUTkXBoErsHytVULtKkm8nur6Uj2A78=;
	b=ck01xMOW04APnCIEiTnsYBTW+wrwfR9c7ZltPPr1zDWg11bRjvPVxAX+8wVc86Q1Ktg0
	 NShGw6tlJCGlEEzwWHc2GFghf0vUbIFc2/QhP/V/sir0uV6qo2F/m07jbaErXHdUMbEDY
	 mfhm9UG87FGSjloY8z0Q6Sh/wSY4uZkUDAmIBfnO3pAMt19M/7+IW38yU7cMsbsCNDd3J
	 07tJsJwUDY6E31BeXHQcAO7kisSxka3gWehPXHM8hULNby71qqN3sC8s7pABy9eaIUCxf
	 cAQs46yNcj1e5v7Pf3rE6CHMljMQylhJvLWlc38qd0eoOeOaxG7EZHLm6NEuY/GFRKA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790958976;
	bh=gMgG+0K2J1pVQUTkXBoErsHytVULtKkm8nur6Uj2A78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gLCkWMUndTJlA+wxBq+gutMZDWjzvz5NNlWeqM8BAj/wYDRKTngd0w4ZzgNDwTOwm
	 uHk+2PF3U/qloUAzeDfzapXBbTpoarRwL1kcFzvIF5vikgLGeUiTx1rED2xn3w+M/J
	 HASVbh4gDaJGVdeXxR2BJPhPRpdUxwcTXSEZpgJDIh1Sj1R0ZmAnZiz4dltiEo44MD
	 0BFLGv7uedNrnmlanTyiIoc+ZiEoSjdbB3W6PntU6eBQS4Zf+18R0TX1jM2wNbS3Cb
	 F3L0I9lQD4f8qs5uoXTI2VkFhEV7ElxJK9k3MG/BquUqDqKR6KiW/Vrpe95XAbeSxC
	 mkHe/rlnBlddQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D600060894;
	Fri,  2 Oct 2026 16:36:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 39F582E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F13A81227
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fpS0pS156gsA for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 16:36:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3EA1E8131B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790958970;
 b=hzHH61uscBThorXTcl3G8XYTphRJ/uDuiTgugFAnfCoVmaSkP7kEHJ9NzakBtWeOCQQ8
 28MPrGB1mgrxXnxZS91Z/58CbZ27r9RXhYeQnd0xClgL9+p7U0VYp4Xz2ERvHcOMn+GHn
 1Q/NJ5+2lTr3M9yrETqohaon52CCs87ZOXNc/7VG1LGZQYaCe7jb/KokkmTZRpYYGqJtX
 N57M/wtdwWXeeX8crAhnknwklMIX7FKt7zu6cOaluxdmgMkoWB3eUUb6bKsEMIeIr/6B5
 HWOu6ok2GqTmodN6jjxoZ+f0xaUCJ/UeBMoH1FtgbgQrSEuJ7J87VXatWKqfDvqObvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790958970;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=gMgG+0K2J1pVQUTkXBoErsHytVULtKkm8nur6Uj2A78=;
 b=PA0jSr2QWsAZPYgCAGPyszidBM0ZbojIQmF6G4pxZ5ohCn3xjLLOTsfEUA3r3/mAyN/q
 NS2isEz1Azdsr/DouF8ZS9p1xHVw5ftRLpIYkf2/zmW74a+Y+664xiqokZdqYnAFh/yYo
 RYIvsoaup/Ji8G2AvXuICZv8nTPS+E2dX+jUmFQDEz2iVSxYmG0OQIyTHkwJ3HE57RSAm
 eXg21/jRzO5+ExjCyFeYxmqKUJ3cttUnmPMAIfCLUYhW758OY8UFxA7sx1j1p+HDN7ZwE
 M406Nv3+qy7C+m+hFlig+A2l7iAs4+b5U9UUeL/fnL667x1ZskJ+43JyZouMc/VLFZg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KT78V5h1; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KT78V5h1
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EA1E8131B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:09 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a11603310fso985615e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790958967; x=1791563767;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gMgG+0K2J1pVQUTkXBoErsHytVULtKkm8nur6Uj2A78=;
 b=KT78V5h1BOFF2nPtZKqJaksjpuCjHrNTHxmF+4Awh8aDhk+6PwnahTVDmYuag1yLoF
 p+XjphNl94eDFcNB4mYEBUBvcw/rI872TsTfmM9E8Cgs54V8NXB55NvMPTOJNZOaoUue
 uMXsAwmyVi7PA2nOy0XSAxR0nMAG7jY/QH3u7s1x4c7EFzryncBx/Z/wBHsh4vy6j36b
 UnbFS3fid+3qKtWPa6uqx/MR1ua/o5i316QGKmgGa7hbU54r+ti6fQPQzfxupsg4kFtm
 Cbzls8VkDdehbItzo7kXll1KMTq0NHMvjfxDE9kpBap+QqdltbuwJy+G9zELSjUix81m
 +GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790958967; x=1791563767;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gMgG+0K2J1pVQUTkXBoErsHytVULtKkm8nur6Uj2A78=;
 b=nfMrOmLYX3sRfnm3NE/857qgZoXH3pbIgwflPEZP1MqvsRxL98EuDbJGVkU44CFQr+
 S1gooXp5mVc2rity8ioIeY+tfVFVnBg9/WguUHVTSIYS5Fu+/P1GmPj6U1CmGSAxPQBi
 KioWHxt5clt5PAKLrWn4AhYGmU12QH01oM4TZCHaJQcKayg2PCQg8uIliH9pxRyBAo19
 PJm76G/OUxnWqcLGgidBlqPDYrFVCtnpqHw/vSmGky277p9QOoeRCWq1dM80DfhHi+wm
 HPvNnzDvF+YWzguN3LUUi3mB5PmSEF4E9axxvbUMN/din47gUbzXvDexemwjQIos25sF
 7acg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFmV7dYz0BPbq1s4a5b4h6n7fNRjjX4waG/6XI4QPcWfwdW9zovvMWLfzWrmJNuIYO+TWqYIg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLKj8XJL9jb34rfrDZmm6ySo+kGAsTkjpUYfVwxaU49ffFiV/LQ
 Q0hZuYdg3agxFAc6ysxegmLDIfQ2Ijqw352iFaoRZ0r099Nlg2R1AK62
X-Gm-Gg: AYBFou3zlZhCxSiRlaYgVw5G/78zOMlsZmr8Rdq+EIxucf5TX8gkDMwh02DgS6ZL24w
 Ah3WVFXvTlBwn4QiiTuohw9f/Fy5Gsvmt3BAxOYnkgk8GPiQjYgmKEM8GXaIAhw1d8BOJB1RUrD
 YNaOxi/2blmWNBg0pbCyQaZD5CmY2AO3lOu6uParv7xA5wN4JI//3s9iQO+HADXtGIE3wP+5R2R
 rGSoYwF9iWBMYqcWnlolJ8mGi3SsnykqrTiyV6GDgddpuruLZy4dTeIZ12SX3gDRObNRUaDMQgX
 FJdntTKFPUY822fUedZoIWux0I3NsFiW6mFg0muM1i3w1YcJSg+Ki9S/w7BWIb+EP+NxxC4t32P
 3j+AX99pwpqAeSSTsoaHFTlFwt6SiAA9k5MVr/hH6E4PN7iBQCyFQK2ABLJfBLo1OnrBS2qV5QX
 dtAKrA8O3jHnQ3NnYczKKhT83aAgAD9IcqXC4wXcRpguJQGlXGMAYiWH6St5aLso8dStz/e+8RE
 O4N2V2f8w==
X-Received: by 2002:a05:6000:4208:b0:48a:fcd6:f351 with SMTP id
 ffacd0b85a97d-48b1270afebmr6151674f8f.20.1790958966761; 
 Fri, 02 Oct 2026 09:36:06 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.234.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ae1sm7135338f8f.39.2026.10.02.09.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 09:36:06 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 02 Oct 2026 18:36:01 +0200
Subject: [PATCH 4/4] arm: rockchip: Remove useless SPL_SHARES_INIT_SP_ADDR
 check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-config-v1-4-11bb20983682@gmail.com>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
In-Reply-To: <20261002-config-v1-0-11bb20983682@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
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

The ROCKCHIP_COMMON_STACK_ADDR configuration option depends on
SPL_SHARES_INIT_SP_ADDR, therefore the logical AND of the two options
values is equal to the to value of ROCKCHIP_COMMON_STACK_ADDR.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 5ed774159be..8e377066a43 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -798,7 +798,7 @@ source "arch/arm/mach-rockchip/rk3588/Kconfig"
 source "arch/arm/mach-rockchip/rv1108/Kconfig"
 source "arch/arm/mach-rockchip/rv1126/Kconfig"
 
-if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
+if ROCKCHIP_COMMON_STACK_ADDR
 
 config CUSTOM_SYS_INIT_SP_ADDR
 	default 0x63f00000 if SPL_TEXT_BASE = 0x60000000

-- 
2.34.1

