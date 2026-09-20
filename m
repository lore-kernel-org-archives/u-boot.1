Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7E7C982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F913810F8;
	Sun, 20 Sep 2026 15:49:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZ9zFZzey0Lf; Sun, 20 Sep 2026 15:49:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7003F81128
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919385;
	b=h2NzwDwiUYOsGscfbbOpixSfw15qQNtc8u+rkiZ1gbC6oYYkF+3cOQ+LsOQK5Da6kb83
	 HZIYUGVNmlSq6tQQfuEOULtrNYadtANPVvooJRjcCasKxkvT1QNckQf0CQFBu8dy6C57e
	 7QoKgIwCXuwSYwhNHFK3u4kFM/5w0lz+eiC0L9ZQ7fS6lN3velai8ZlmKkPgXgbrbcNpE
	 LcbOqg9IrErgOwN+TzkVaYhSyctUpHGRj1dFlR2Vqy+YFOvd27bO0WwWsTNW9Wk35eIB4
	 YIW4JHax2frsoyW3oI5yFGjSkuuI3RHDF8qECjNQVKWSwyS3jl7ayoE9YFS6YVg58DA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919385;
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
	bh=wd8E4D0X3wI1JF4b6EMpmO5wsa9kEww0cFsYiomcLWc=;
	b=Yw1fUnhI0SuwJWSagnuvrkUijiK7KBASRmvMPvXrONu3pSQmf9hpn9ctvtzjyIUW6QZp
	 uckV9AlddnCmF9iWT/BZ9PGgubFdrJtRCkILCpn2QB7GkiLOoTeVzNtRftqJwRjZDaLwv
	 fjU1udSlmLv2NIWizXUxD56EB08Ibl9+63E4tmc1f6VbxBJ98ec+S5h1lfJDyBUC3URey
	 Nx664uw9SRlEL+SXweZoXLgn4i8QKox3sR86YXTb4dSYn9oAf8wVitP8Ir5mbtloS5Vwl
	 8Q/N+1VUWsAlrvA2c5DsHl4U9K+015ABiSDZjqMI+SRsZz4WzPtbceYyq3IDn4g2BpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J1zXFeLM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919385;
	bh=wd8E4D0X3wI1JF4b6EMpmO5wsa9kEww0cFsYiomcLWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sThziSIPVjH/kqcWqj5heEIC6PH28odPRcNWz70v1TlsgNSRg9HrqEq3OXUrxnaud
	 tPvBHaApCNxx7H37PHEP8E3M8+DbqrlCMnuONQ8FQYLQuzT8IPyWZpgdOdDcQ0WV3y
	 8D4xeamSPFN/87QHfGnDNBNBlGx/TOcWb7X3UPuvKGa0EraFfY67E8AujmrPRD+lM3
	 qLTxgR5oIUdBUzL2YEYsaAX1V21eCMKqja4yvGucjUfgW3IaU836nFX3UE1vguRcjH
	 zJAX0zPyuiAjyqPn46JXRaBXh+m2YwIBiUFlWWjdDRL1dzSQyPJ1qdM4hnYlDuXDlc
	 7d2W5JWZ5LuLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7003F81128;
	Sun, 20 Sep 2026 15:49:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E4B124D
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F59F80F19
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVtIXcVndtpW for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 14:16:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EB7CC80F15
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789913804;
 b=AFb92ZrsoWRJzBZquvCNe0DLxiXssz8xK3HlWMGzjcn5PmhLC2V5VfNr4hAA8jyRItlY
 BvfJG4HCNpjh3Cz5p79uS3sj9O+RpBWJ04I4OS8WMCwnP9cKnTapWFltjDld/WDo6x2ae
 qwAhr2TbLBoaCgEM3aYgVeaxPsVKuk5XH+jibJGA8JfjM8MxSnPsCXo6eR/9MpJt7tK9P
 nLAD71T3cIFXJ1KCgrT7BtMqARRLY4PE7l+pbZaRsyik26rYN4tKbZoItNPA62jZfOhkI
 asl5Yf+wEBBHRSGd9f6UxtTPt8BBLwZeYqJp6GWgQMp7bCJ6yGB2RJj5c+XDkzIVGEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789913804;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=wd8E4D0X3wI1JF4b6EMpmO5wsa9kEww0cFsYiomcLWc=;
 b=m79thU2ZmnzqfihagBhir1QSVneQwBRcRzw0eTn76nmsW3YDo+NT3QVAks3J6sMD3zTG
 BzfRSNLjLY8fJrcJsS7PdF196yfaUVvLkd7h1kbdeVYzXSEmBSVxs9wQ9xYIJGZFXqxDT
 sihdGnxVGs1huUZX+Gg0KINoEaxE73w/ZHd9LvyORXj5G4XBNLpXZWjEztPOQdyweP06g
 IgRrHuKkkrfE7HqA+xPcYvXSg7IfrB1fqftYvU9zV3dOH4B9WqJPdQIXKAYslSBEW0ZDd
 u9qrFBy0KM70PS0dGVEA+DzEPUfY1n/WOFbKjyr8wHBl2Np1PmzRUuTDOwnMhBlPv+w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=J1zXFeLM; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=J1zXFeLM
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB7CC80F15
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:43 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so29963715e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789913801; x=1790518601;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wd8E4D0X3wI1JF4b6EMpmO5wsa9kEww0cFsYiomcLWc=;
 b=J1zXFeLMZje/ThqfmLvPDvoLjchIdoHeNYWkmztEf/xkuGeL0TOuCLT/C2vniIyGh2
 n3N98lkikuXnqhc6LZ0zjlBVhgXznPakOym60NYcEpToRNUdbh0R7iCAshko4siLMC4V
 3PeLtFXgMhuB6BtohCAo3KEGaU7AZjTY+6BaKzP2KaLzsCIPLZXyzz3G57XypMCBy499
 7CAbIO2p6zdHxwZXzqXpPrsokXUQZidq/FmHTaj8/OvBmGRdInp3Gf8heXDDXNz3UFmZ
 C5T3vvaBryOnpl6fhRD/LW3Hz7P3Gocrd+2w8Zy8pHzdk95XuOz5JXyxJ+lbjjtrCuUw
 kLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789913801; x=1790518601;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wd8E4D0X3wI1JF4b6EMpmO5wsa9kEww0cFsYiomcLWc=;
 b=u2ZdbAn3ic38HmJUIse7H0dnp2CsIQ4a+D5SvEy6meCufU9avYP42gV6K0fLSpc5PC
 UhApjkiN3/B1MXNybIPOwYe26Tt2k23AyDFfqiceXw/xr1f6ecOfL2xm/Kmarez3hAPf
 FTJDqtAq54fxMp9S74Xo0f1dkd+w2LAIUXvFwTLK0eVmAU2tO7kab07mXbk6+LCnBfOw
 7i8uYQASCnQn/tL52zZ8sW/1sdtFT++K/6UVA25IR9acCkxdFdSUKyu80W5r/v8MytBR
 L8OPer4OHBl1nzgXWxW3K+PvvWT2e+Y2C4wHpLl2Y3TfdIBQV8scZU+02QAkOp5a9+cP
 Sqsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6KgIY233BlXssVyCeYJb3kISSIChqVyCCy4nEKJpCZrQdMrRYjjCV4cm5DMOKK1fO/y05QNY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k0riwKsrhwXpL4CWQDNdQza+Hh8GsOV4BS27njMXszkFSS2iPm
 MCJdn67pFmAGZPM+Funrcr0Xtqdc5Tmctcn1KYdW34wvCceEwffpeKYf
X-Gm-Gg: AYBFou3p5XAD/Rf8qkNqNJvlvW4oXu8Y60bW4bS1Dgg7wbmnxfmervggjrPjGIx80rX
 HkmKsN+dZDnZDaNy3+LBEWG+7lFDLaFIi7YXdNedOQBE6izs/V5ZyVFCokCaGGRFv/g2YOw2p+4
 9pfBDKYqPFBUwWYgUjkPUpXeL5RAAzJ5PyM9Mk3Et1JCc72dlO6PkV+FnBzrj6rKvuPbm5+/s83
 fyPIe280bR6zxvodPZFNXP1q84Kh+vRGDjqc4p6kXTp4h55rJgJEOk0sSQagMM+a5SENMVd5uVP
 srKjAzp/ttdqE+3uS/1v5fqpFtYQmWqYnonhsRlBRmHxQBXfrJt5neymZnQmFUoi9M6jDA40/hv
 l8J2agB5Ewg+BM1LCjkfE1ghCvYOh0q2LoKRqx7K8pnC2MsoFWud276Mu8Ig7pKmVaMNeXw9IVB
 1z0uelvqNIedgUEZNDdTpxDcj5VI898AnGXlyPUx6mOlYzDNpbWD1WRO9Yh43Y0FsVpR56Xu2xr
 zmvihuE
X-Received: by 2002:a05:600c:1c1a:b0:49d:1de5:ce0a with SMTP id
 5b1f17b1804b1-49fc56d4238mr137640175e9.13.1789913800833; 
 Sun, 20 Sep 2026 07:16:40 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.151.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm184107005e9.3.2026.09.20.07.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:16:40 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 20 Sep 2026 16:15:55 +0200
Subject: [PATCH RFC 11/11] configs: rockchip: add DISPLAY_CPUINFO to keep
 SoC info print
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-reset-v1-11-42820216369f@gmail.com>
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

Remove DISPLAY_CPUINFO deselection from all configurations that were
relying on DISPLAY_BOARDINFO(_LATE) to print SoC information: this info
is now printed with DISPLAY_CPUINFO. The change affects all of Rockchip
board configurations related to PX30 RK3308 or RK35xx.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 configs/9tripod-x3568-v4-rk3568_defconfig     | 1 -
 configs/anbernic-rg-ds-rk3568_defconfig       | 1 -
 configs/anbernic-rgxx3-rk3566_defconfig       | 1 -
 configs/bpi-r2-pro-rk3568_defconfig           | 1 -
 configs/cm3588-nas-rk3588_defconfig           | 1 -
 configs/coolpi-4b-rk3588s_defconfig           | 1 -
 configs/coolpi-cm5-evb-rk3588_defconfig       | 1 -
 configs/coolpi-cm5-genbook-rk3588_defconfig   | 1 -
 configs/easepi-r1-rk3568_defconfig            | 1 -
 configs/evb-px30_defconfig                    | 1 -
 configs/evb-rk3308_defconfig                  | 1 -
 configs/evb-rk3568_defconfig                  | 1 -
 configs/evb-rk3588_defconfig                  | 1 -
 configs/fastrhino-r66s-rk3568_defconfig       | 1 -
 configs/firefly-px30_defconfig                | 1 -
 configs/gameforce-ace-rk3588s_defconfig       | 1 -
 configs/generic-rk3528_defconfig              | 1 -
 configs/generic-rk3568_defconfig              | 1 -
 configs/generic-rk3576_defconfig              | 1 -
 configs/generic-rk3588_defconfig              | 1 -
 configs/jaguar-rk3588_defconfig               | 1 -
 configs/khadas-edge2-rk3588s_defconfig        | 1 -
 configs/lckfb-tspi-rk3566_defconfig           | 1 -
 configs/lubancat-2-rk3568_defconfig           | 1 -
 configs/mnt-reform2-rk3588_defconfig          | 1 -
 configs/nanopc-t6-rk3588_defconfig            | 1 -
 configs/nanopi-m5-rk3576_defconfig            | 1 -
 configs/nanopi-r3s-rk3566_defconfig           | 1 -
 configs/nanopi-r5c-rk3568_defconfig           | 1 -
 configs/nanopi-r5s-rk3568_defconfig           | 1 -
 configs/nanopi-r6c-rk3588s_defconfig          | 1 -
 configs/nanopi-r6s-rk3588s_defconfig          | 1 -
 configs/nanopi-r76s-rk3576_defconfig          | 1 -
 configs/nanopi-zero2-rk3528_defconfig         | 1 -
 configs/neu6a-io-rk3588_defconfig             | 1 -
 configs/neu6b-io-rk3588_defconfig             | 1 -
 configs/nova-rk3588s_defconfig                | 1 -
 configs/odroid-go2_defconfig                  | 1 -
 configs/odroid-m1-rk3568_defconfig            | 1 -
 configs/odroid-m1s-rk3566_defconfig           | 1 -
 configs/odroid-m2-rk3588s_defconfig           | 1 -
 configs/omni3576-rk3576_defconfig             | 1 -
 configs/orangepi-3b-rk3566_defconfig          | 1 -
 configs/orangepi-5-max-rk3588_defconfig       | 1 -
 configs/orangepi-5-plus-rk3588_defconfig      | 1 -
 configs/orangepi-5-rk3588s_defconfig          | 1 -
 configs/orangepi-5-ultra-rk3588_defconfig     | 1 -
 configs/pinetab2-rk3566_defconfig             | 1 -
 configs/powkiddy-x55-rk3566_defconfig         | 1 -
 configs/px30-core-ctouch2-of10-px30_defconfig | 1 -
 configs/px30-core-ctouch2-px30_defconfig      | 1 -
 configs/px30-core-edimm2.2-px30_defconfig     | 1 -
 configs/qnap-ts433-rk3568_defconfig           | 1 -
 configs/quartz64-a-rk3566_defconfig           | 1 -
 configs/quartz64-b-rk3566_defconfig           | 1 -
 configs/quartzpro64-rk3588_defconfig          | 1 -
 configs/radxa-cm3-io-rk3566_defconfig         | 1 -
 configs/radxa-e20c-rk3528_defconfig           | 1 -
 configs/radxa-e25-rk3568_defconfig            | 1 -
 configs/radxa-zero-3-rk3566_defconfig         | 1 -
 configs/ringneck-px30_defconfig               | 1 -
 configs/roc-cc-rk3308_defconfig               | 1 -
 configs/roc-pc-rk3576_defconfig               | 1 -
 configs/roc-pc-rk3588s_defconfig              | 1 -
 configs/rock-2-rk3528_defconfig               | 1 -
 configs/rock-3a-rk3568_defconfig              | 1 -
 configs/rock-3b-rk3568_defconfig              | 1 -
 configs/rock-3c-rk3566_defconfig              | 1 -
 configs/rock-4d-rk3576_defconfig              | 1 -
 configs/rock-5-itx-rk3588_defconfig           | 1 -
 configs/rock-5c-rk3588s_defconfig             | 1 -
 configs/rock-pi-s-rk3308_defconfig            | 1 -
 configs/rock-s0-rk3308_defconfig              | 1 -
 configs/rock5a-rk3588s_defconfig              | 1 -
 configs/rock5b-rk3588_defconfig               | 1 -
 configs/sige1-rk3528_defconfig                | 1 -
 configs/sige5-rk3576_defconfig                | 1 -
 configs/sige7-rk3588_defconfig                | 1 -
 configs/soquartz-blade-rk3566_defconfig       | 1 -
 configs/soquartz-cm4-rk3566_defconfig         | 1 -
 configs/soquartz-model-a-rk3566_defconfig     | 1 -
 configs/tiger-rk3588_defconfig                | 1 -
 configs/toybrick-rk3588_defconfig             | 1 -
 configs/turing-rk1-rk3588_defconfig           | 1 -
 84 files changed, 84 deletions(-)

diff --git a/configs/9tripod-x3568-v4-rk3568_defconfig b/configs/9tripod-x3568-v4-rk3568_defconfig
index c0e7a565359..ca2865d851f 100644
--- a/configs/9tripod-x3568-v4-rk3568_defconfig
+++ b/configs/9tripod-x3568-v4-rk3568_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-9tripod-x3568-v4.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/anbernic-rg-ds-rk3568_defconfig b/configs/anbernic-rg-ds-rk3568_defconfig
index 816f78da4a3..a464130bb4c 100644
--- a/configs/anbernic-rg-ds-rk3568_defconfig
+++ b/configs/anbernic-rg-ds-rk3568_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-anbernic-rg-ds.dtb"
 CONFIG_BOARD_TYPES=y
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_RNG_SEED=y
 CONFIG_SPL_MAX_SIZE=0x40000
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index 854de8b00a4..d66120f8100 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -24,7 +24,6 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-anbernic-rg353p.dtb"
 CONFIG_DISABLE_CONSOLE=y
 # CONFIG_CONSOLE_MUX is not set
 CONFIG_BOARD_TYPES=y
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_RNG_SEED=y
 CONFIG_SPL_MAX_SIZE=0x40000
diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
index c5199a39448..08c999318e9 100644
--- a/configs/bpi-r2-pro-rk3568_defconfig
+++ b/configs/bpi-r2-pro-rk3568_defconfig
@@ -15,7 +15,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-bpi-r2-pro.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/cm3588-nas-rk3588_defconfig b/configs/cm3588-nas-rk3588_defconfig
index 5b5ef8d5ac1..78d4b6f003d 100644
--- a/configs/cm3588-nas-rk3588_defconfig
+++ b/configs/cm3588-nas-rk3588_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-friendlyelec-cm3588-nas.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/coolpi-4b-rk3588s_defconfig b/configs/coolpi-4b-rk3588s_defconfig
index e6772622403..e8a567008a7 100644
--- a/configs/coolpi-4b-rk3588s_defconfig
+++ b/configs/coolpi-4b-rk3588s_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-coolpi-4b.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/coolpi-cm5-evb-rk3588_defconfig b/configs/coolpi-cm5-evb-rk3588_defconfig
index 4326e116849..1d83c1ac235 100644
--- a/configs/coolpi-cm5-evb-rk3588_defconfig
+++ b/configs/coolpi-cm5-evb-rk3588_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-coolpi-cm5-evb.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/coolpi-cm5-genbook-rk3588_defconfig b/configs/coolpi-cm5-genbook-rk3588_defconfig
index 85fbde72646..4af78efb8e7 100644
--- a/configs/coolpi-cm5-genbook-rk3588_defconfig
+++ b/configs/coolpi-cm5-genbook-rk3588_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-coolpi-cm5-genbook.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/easepi-r1-rk3568_defconfig b/configs/easepi-r1-rk3568_defconfig
index fa400956b63..d762675337f 100644
--- a/configs/easepi-r1-rk3568_defconfig
+++ b/configs/easepi-r1-rk3568_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-easepi-r1.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/evb-px30_defconfig b/configs/evb-px30_defconfig
index afc45308bee..71e0385e3e2 100644
--- a/configs/evb-px30_defconfig
+++ b/configs/evb-px30_defconfig
@@ -19,7 +19,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-evb.dtb"
 # CONFIG_CONSOLE_MUX is not set
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index c0eb5bbdcbd..35067f901ad 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -15,7 +15,6 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-evb.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
index 4a5a7454e10..82e4b6f0db8 100644
--- a/configs/evb-rk3568_defconfig
+++ b/configs/evb-rk3568_defconfig
@@ -15,7 +15,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-evb1-v10.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index c7f6256a626..258eb68b6e0 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-evb1-v10.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/fastrhino-r66s-rk3568_defconfig b/configs/fastrhino-r66s-rk3568_defconfig
index fc753516d72..f993fd009a4 100644
--- a/configs/fastrhino-r66s-rk3568_defconfig
+++ b/configs/fastrhino-r66s-rk3568_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-fastrhino-r66s.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/firefly-px30_defconfig b/configs/firefly-px30_defconfig
index 316f960d32e..7ca339449bc 100644
--- a/configs/firefly-px30_defconfig
+++ b/configs/firefly-px30_defconfig
@@ -20,7 +20,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-firefly.dtb"
 # CONFIG_CONSOLE_MUX is not set
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/gameforce-ace-rk3588s_defconfig b/configs/gameforce-ace-rk3588s_defconfig
index e4050bd77df..13952dda6dd 100644
--- a/configs/gameforce-ace-rk3588s_defconfig
+++ b/configs/gameforce-ace-rk3588s_defconfig
@@ -15,7 +15,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-gameforce-ace.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/generic-rk3528_defconfig b/configs/generic-rk3528_defconfig
index 130aa124298..22d38dc5fc8 100644
--- a/configs/generic-rk3528_defconfig
+++ b/configs/generic-rk3528_defconfig
@@ -10,7 +10,6 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-generic.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_MEMINFO=y
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index a33c3af9255..f0d023bc3e3 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -21,7 +21,6 @@ CONFIG_SPL_LOAD_FIT=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3576_defconfig
index 5e25653820c..20791525fc1 100644
--- a/configs/generic-rk3576_defconfig
+++ b/configs/generic-rk3576_defconfig
@@ -10,7 +10,6 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-generic.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_MEMINFO=y
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index ac450e6d757..0661dd82150 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index ed3883b4f9c..c754b5cf6f1 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_LOAD_FIT=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-jaguar.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CYCLIC=y
 CONFIG_SPL_MAX_SIZE=0x40000
diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas-edge2-rk3588s_defconfig
index 5fc7ce702ec..189eca6dfee 100644
--- a/configs/khadas-edge2-rk3588s_defconfig
+++ b/configs/khadas-edge2-rk3588s_defconfig
@@ -21,7 +21,6 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-khadas-edge2.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/lckfb-tspi-rk3566_defconfig b/configs/lckfb-tspi-rk3566_defconfig
index 7aa218345b7..f9491e35b38 100644
--- a/configs/lckfb-tspi-rk3566_defconfig
+++ b/configs/lckfb-tspi-rk3566_defconfig
@@ -15,7 +15,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-lckfb-tspi.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3568_defconfig
index 7548bf60b06..684dca4dbaf 100644
--- a/configs/lubancat-2-rk3568_defconfig
+++ b/configs/lubancat-2-rk3568_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-lubancat-2.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/mnt-reform2-rk3588_defconfig b/configs/mnt-reform2-rk3588_defconfig
index a6ba0aa5178..e636607ebfe 100644
--- a/configs/mnt-reform2-rk3588_defconfig
+++ b/configs/mnt-reform2-rk3588_defconfig
@@ -19,7 +19,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-mnt-reform2"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index ba9a5adece7..4800300203c 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-nanopc-t6.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/nanopi-m5-rk3576_defconfig b/configs/nanopi-m5-rk3576_defconfig
index 88b6d0f9e86..41cbc17849f 100644
--- a/configs/nanopi-m5-rk3576_defconfig
+++ b/configs/nanopi-m5-rk3576_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_SPI=y
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-nanopi-m5.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_DM_RESET=y
diff --git a/configs/nanopi-r3s-rk3566_defconfig b/configs/nanopi-r3s-rk3566_defconfig
index 2424c7477c0..b7d34dbd6ff 100644
--- a/configs/nanopi-r3s-rk3566_defconfig
+++ b/configs/nanopi-r3s-rk3566_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-nanopi-r3s.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
index e75a24dadc8..8ca5529dfb3 100644
--- a/configs/nanopi-r5c-rk3568_defconfig
+++ b/configs/nanopi-r5c-rk3568_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-nanopi-r5c.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
index c971f376b38..54aef81a0a8 100644
--- a/configs/nanopi-r5s-rk3568_defconfig
+++ b/configs/nanopi-r5s-rk3568_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-nanopi-r5s.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/nanopi-r6c-rk3588s_defconfig b/configs/nanopi-r6c-rk3588s_defconfig
index 861e3234d29..893ba437fd6 100644
--- a/configs/nanopi-r6c-rk3588s_defconfig
+++ b/configs/nanopi-r6c-rk3588s_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-nanopi-r6c.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/nanopi-r6s-rk3588s_defconfig b/configs/nanopi-r6s-rk3588s_defconfig
index 743dfca441b..f6d1d6e4d17 100644
--- a/configs/nanopi-r6s-rk3588s_defconfig
+++ b/configs/nanopi-r6s-rk3588s_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-nanopi-r6s.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/nanopi-r76s-rk3576_defconfig b/configs/nanopi-r76s-rk3576_defconfig
index af149dc4ba5..8a961b650bb 100644
--- a/configs/nanopi-r76s-rk3576_defconfig
+++ b/configs/nanopi-r76s-rk3576_defconfig
@@ -11,7 +11,6 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-nanopi-r76s.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_MEMINFO=y
diff --git a/configs/nanopi-zero2-rk3528_defconfig b/configs/nanopi-zero2-rk3528_defconfig
index 2c725380ef4..4a3917fa3f8 100644
--- a/configs/nanopi-zero2-rk3528_defconfig
+++ b/configs/nanopi-zero2-rk3528_defconfig
@@ -9,7 +9,6 @@ CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-nanopi-zero2.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_RNG_SEED=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
index 19f129e96f0..1b18a8b7a0e 100644
--- a/configs/neu6a-io-rk3588_defconfig
+++ b/configs/neu6a-io-rk3588_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-edgeble-neu6a-io.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
index 2cf5aeccf51..badfe97343c 100644
--- a/configs/neu6b-io-rk3588_defconfig
+++ b/configs/neu6b-io-rk3588_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-edgeble-neu6b-io.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/nova-rk3588s_defconfig b/configs/nova-rk3588s_defconfig
index f7d7492ff46..8fcb6997e22 100644
--- a/configs/nova-rk3588s_defconfig
+++ b/configs/nova-rk3588s_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-indiedroid-nova.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index dfdea66cd70..34953971ac1 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -29,7 +29,6 @@ CONFIG_FIT_BEST_MATCH=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3326-odroid-go2.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x40000
diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index b00985b0405..10651005863 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-odroid-m1.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-rk3566_defconfig
index d59882a2a59..0b3257fce0a 100644
--- a/configs/odroid-m1s-rk3566_defconfig
+++ b/configs/odroid-m1s-rk3566_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-odroid-m1s.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/odroid-m2-rk3588s_defconfig b/configs/odroid-m2-rk3588s_defconfig
index e71e61ddb0b..750081fae03 100644
--- a/configs/odroid-m2-rk3588s_defconfig
+++ b/configs/odroid-m2-rk3588s_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-odroid-m2.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/omni3576-rk3576_defconfig b/configs/omni3576-rk3576_defconfig
index 13ef3112f1b..b2303ec9699 100644
--- a/configs/omni3576-rk3576_defconfig
+++ b/configs/omni3576-rk3576_defconfig
@@ -10,7 +10,6 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-luckfox-omni3576.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_MEMINFO=y
diff --git a/configs/orangepi-3b-rk3566_defconfig b/configs/orangepi-3b-rk3566_defconfig
index 1cd78789fa1..2dd420d686e 100644
--- a/configs/orangepi-3b-rk3566_defconfig
+++ b/configs/orangepi-3b-rk3566_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-orangepi-3b.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/orangepi-5-max-rk3588_defconfig b/configs/orangepi-5-max-rk3588_defconfig
index 0861df962cf..0d4e8690a1f 100644
--- a/configs/orangepi-5-max-rk3588_defconfig
+++ b/configs/orangepi-5-max-rk3588_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-orangepi-5-max.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
index 52523f87aec..8b4f6cb5b19 100644
--- a/configs/orangepi-5-plus-rk3588_defconfig
+++ b/configs/orangepi-5-plus-rk3588_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-orangepi-5-plus.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
index e0eba389289..08e81204365 100644
--- a/configs/orangepi-5-rk3588s_defconfig
+++ b/configs/orangepi-5-rk3588s_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-orangepi-5.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/orangepi-5-ultra-rk3588_defconfig b/configs/orangepi-5-ultra-rk3588_defconfig
index fb7f4432983..0159868350d 100644
--- a/configs/orangepi-5-ultra-rk3588_defconfig
+++ b/configs/orangepi-5-ultra-rk3588_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-orangepi-5-ultra.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
index f284dadb99d..7ad8f0937c4 100644
--- a/configs/pinetab2-rk3566_defconfig
+++ b/configs/pinetab2-rk3566_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-pinetab2-v2.0.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/powkiddy-x55-rk3566_defconfig b/configs/powkiddy-x55-rk3566_defconfig
index 37a359c91a9..a1d6891d5d9 100644
--- a/configs/powkiddy-x55-rk3566_defconfig
+++ b/configs/powkiddy-x55-rk3566_defconfig
@@ -15,7 +15,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-powkiddy-x55.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/px30-core-ctouch2-of10-px30_defconfig b/configs/px30-core-ctouch2-of10-px30_defconfig
index 06b60483841..9ecfd3ffb1c 100644
--- a/configs/px30-core-ctouch2-of10-px30_defconfig
+++ b/configs/px30-core-ctouch2-of10-px30_defconfig
@@ -19,7 +19,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-engicam-px30-core-ctouch2-of10.dtb"
 # CONFIG_CONSOLE_MUX is not set
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/px30-core-ctouch2-px30_defconfig b/configs/px30-core-ctouch2-px30_defconfig
index aa6e44f5348..fc9f9e6d1f0 100644
--- a/configs/px30-core-ctouch2-px30_defconfig
+++ b/configs/px30-core-ctouch2-px30_defconfig
@@ -19,7 +19,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-engicam-px30-core-ctouch2.dtb"
 # CONFIG_CONSOLE_MUX is not set
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/px30-core-edimm2.2-px30_defconfig b/configs/px30-core-edimm2.2-px30_defconfig
index fcc27ce8761..cac8f114158 100644
--- a/configs/px30-core-edimm2.2-px30_defconfig
+++ b/configs/px30-core-edimm2.2-px30_defconfig
@@ -19,7 +19,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-engicam-px30-core-edimm2.2.dtb"
 # CONFIG_CONSOLE_MUX is not set
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/qnap-ts433-rk3568_defconfig b/configs/qnap-ts433-rk3568_defconfig
index 63833196675..b14463a4aff 100644
--- a/configs/qnap-ts433-rk3568_defconfig
+++ b/configs/qnap-ts433-rk3568_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-qnap-ts433.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
index 780fd581f0a..0472f8d04bb 100644
--- a/configs/quartz64-a-rk3566_defconfig
+++ b/configs/quartz64-a-rk3566_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-quartz64-a.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
index 4d92a67cd73..0675c2db190 100644
--- a/configs/quartz64-b-rk3566_defconfig
+++ b/configs/quartz64-b-rk3566_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-quartz64-b.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
index 0ad74e8bbef..c2bafb39ad6 100644
--- a/configs/quartzpro64-rk3588_defconfig
+++ b/configs/quartzpro64-rk3588_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-quartzpro64.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
index 875f0b76fa5..0404af39cd2 100644
--- a/configs/radxa-cm3-io-rk3566_defconfig
+++ b/configs/radxa-cm3-io-rk3566_defconfig
@@ -15,7 +15,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-radxa-cm3-io.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/radxa-e20c-rk3528_defconfig b/configs/radxa-e20c-rk3528_defconfig
index 3d86ac51c9b..7d47a8d4a25 100644
--- a/configs/radxa-e20c-rk3528_defconfig
+++ b/configs/radxa-e20c-rk3528_defconfig
@@ -10,7 +10,6 @@ CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-radxa-e20c.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_RNG_SEED=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
index 779d540e22d..3a3d18798eb 100644
--- a/configs/radxa-e25-rk3568_defconfig
+++ b/configs/radxa-e25-rk3568_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-radxa-e25.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/radxa-zero-3-rk3566_defconfig b/configs/radxa-zero-3-rk3566_defconfig
index f5cf09a5e4a..994e852d101 100644
--- a/configs/radxa-zero-3-rk3566_defconfig
+++ b/configs/radxa-zero-3-rk3566_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-radxa-zero-3w.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index 75646935105..b0d79d84d47 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -22,7 +22,6 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-ringneck-haikou.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index b775a6e1352..9a5c2a35d36 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -15,7 +15,6 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-roc-cc.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
diff --git a/configs/roc-pc-rk3576_defconfig b/configs/roc-pc-rk3576_defconfig
index 53491efcec2..f747866a157 100644
--- a/configs/roc-pc-rk3576_defconfig
+++ b/configs/roc-pc-rk3576_defconfig
@@ -10,7 +10,6 @@ CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-roc-pc.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
diff --git a/configs/roc-pc-rk3588s_defconfig b/configs/roc-pc-rk3588s_defconfig
index 226243d7977..a03b062418b 100644
--- a/configs/roc-pc-rk3588s_defconfig
+++ b/configs/roc-pc-rk3588s_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-roc-pc.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
diff --git a/configs/rock-2-rk3528_defconfig b/configs/rock-2-rk3528_defconfig
index 2219bc9de56..d87c518a534 100644
--- a/configs/rock-2-rk3528_defconfig
+++ b/configs/rock-2-rk3528_defconfig
@@ -10,7 +10,6 @@ CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-rock-2a.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_RNG_SEED=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
index e753185610f..b780f7d3a04 100644
--- a/configs/rock-3a-rk3568_defconfig
+++ b/configs/rock-3a-rk3568_defconfig
@@ -22,7 +22,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-rock-3a.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/rock-3b-rk3568_defconfig b/configs/rock-3b-rk3568_defconfig
index c3bf48b9e34..470303653ae 100644
--- a/configs/rock-3b-rk3568_defconfig
+++ b/configs/rock-3b-rk3568_defconfig
@@ -22,7 +22,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-rock-3b.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/rock-3c-rk3566_defconfig b/configs/rock-3c-rk3566_defconfig
index 417aa33a663..413cccfe235 100644
--- a/configs/rock-3c-rk3566_defconfig
+++ b/configs/rock-3c-rk3566_defconfig
@@ -22,7 +22,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-rock-3c.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
index 93faf09962c..ae97d7071c0 100644
--- a/configs/rock-4d-rk3576_defconfig
+++ b/configs/rock-4d-rk3576_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_SPI=y
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-rock-4d.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_DM_RESET=y
diff --git a/configs/rock-5-itx-rk3588_defconfig b/configs/rock-5-itx-rk3588_defconfig
index cb014de4188..4950f66e00d 100644
--- a/configs/rock-5-itx-rk3588_defconfig
+++ b/configs/rock-5-itx-rk3588_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5-itx.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/rock-5c-rk3588s_defconfig b/configs/rock-5c-rk3588s_defconfig
index 3d044a81498..008c5cd1974 100644
--- a/configs/rock-5c-rk3588s_defconfig
+++ b/configs/rock-5c-rk3588s_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5c.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index a62afd05c4c..7aaa0344e29 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -15,7 +15,6 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-pi-s.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
diff --git a/configs/rock-s0-rk3308_defconfig b/configs/rock-s0-rk3308_defconfig
index f8633961495..39ee5a83d55 100644
--- a/configs/rock-s0-rk3308_defconfig
+++ b/configs/rock-s0-rk3308_defconfig
@@ -16,7 +16,6 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-s0.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index 24b2eef35f2..948e0ac3457 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index da5fb3a2c30..06985dd89a4 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -25,7 +25,6 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/sige1-rk3528_defconfig b/configs/sige1-rk3528_defconfig
index 150e0fcc718..c199a08a10e 100644
--- a/configs/sige1-rk3528_defconfig
+++ b/configs/sige1-rk3528_defconfig
@@ -9,7 +9,6 @@ CONFIG_DEBUG_UART_BASE=0xFF9F0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-armsom-sige1.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_RNG_SEED=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/sige5-rk3576_defconfig b/configs/sige5-rk3576_defconfig
index be46f63798b..1f9c54eba99 100644
--- a/configs/sige5-rk3576_defconfig
+++ b/configs/sige5-rk3576_defconfig
@@ -10,7 +10,6 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-armsom-sige5.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_MEMINFO=y
diff --git a/configs/sige7-rk3588_defconfig b/configs/sige7-rk3588_defconfig
index 00b9759715b..c2da8aeb3cc 100644
--- a/configs/sige7-rk3588_defconfig
+++ b/configs/sige7-rk3588_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-armsom-sige7.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
index 7de159a8881..ac2a73af348 100644
--- a/configs/soquartz-blade-rk3566_defconfig
+++ b/configs/soquartz-blade-rk3566_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-soquartz-blade.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
index 4455ee5b5aa..0b04341a2c0 100644
--- a/configs/soquartz-cm4-rk3566_defconfig
+++ b/configs/soquartz-cm4-rk3566_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-soquartz-cm4.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
index abdab514496..100a419b4fa 100644
--- a/configs/soquartz-model-a-rk3566_defconfig
+++ b/configs/soquartz-model-a-rk3566_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-soquartz-model-a.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
index 105e8e10e0b..45248eacd1e 100644
--- a/configs/tiger-rk3588_defconfig
+++ b/configs/tiger-rk3588_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_LOAD_FIT=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-tiger-haikou.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CYCLIC=y
 CONFIG_SPL_MAX_SIZE=0x40000
diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
index 14b231ae3e2..5ab792ff29b 100644
--- a/configs/toybrick-rk3588_defconfig
+++ b/configs/toybrick-rk3588_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-toybrick-x0.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 0b3efec23e6..f7aba44bf3d 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-turing-rk1.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set

-- 
2.34.1

