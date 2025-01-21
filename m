Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9FFC0218B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 17:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F1248078B;
	Tue, 21 Jan 2025 18:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qv86pVQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 772AD807E0; Tue, 21 Jan 2025 18:34:24 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57BC0807D6
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 18:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6e9db19c8so535835685a.3
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 09:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737480860; x=1738085660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sM79TuzXcawjKa8pNXmRbdjzIyTX5hAz2vmZJ7J/y8=;
 b=qv86pVQPlPlXqwYtb4XPFBsEBt1sZL47dy2HzsHt4h2Xqbk+0gPcr0rQAB9984t8q0
 3SDSVavb0hymi5XIFDSD+8UpBgnDvsovS1kkJI0a5AzNsssPL/yxdPsY/pCUyKpnHFPK
 pBG9hmJ0s4hcAi0AxO4Zc9i3APg6rFv/sP/88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737480860; x=1738085660;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8sM79TuzXcawjKa8pNXmRbdjzIyTX5hAz2vmZJ7J/y8=;
 b=tMpVJAw6PFT8I2mHPxsznBYMtBBC6XIMm0VH2aPi+ZicF58s+Mcog29eBh3+OgK2m5
 jy5zNs55LP04EeY91De5zR2PExFCYlAcEca32Pm0qNiKQpxKRIbcBu9xitsB7n8jqw/0
 bJvurcwWam5+8DGCyM5U7n2bjb/ofzPQuO2KN+9inxOG3hbm5yC+usVI6QUZlC/vFLYM
 HF/gNWi0hc29MhxeZAUpyg3GMwlSKDlB3yBNTW9ttP1S/wa4rSA50PjqC23+iQzeN1GI
 yfv42AR9T3p5tyjA+VaNOmroDRfPM80iUZzCQlEM3n15+nZa4rZQpOza4XtWoQDcNB6H
 GB8g==
X-Gm-Message-State: AOJu0Yz7p0/XAVU85qk9gWSC3/QfoTnzHV/G8UgF87XmR2O+mBWKj9h5
 5oULVttkXVwR/rXTVXRIxByf2Dg5RElWCQZvtqSQbLgqWfQ9F/SCgiBQvsXfwvdIVTfXjHEJ5l1
 7
X-Gm-Gg: ASbGncuFgdFwG3P4KwlptSSC2FjaQF3oi+5AmFCCalBqqMtJ/Sz4oWK1SWXh0nvh9f1
 kzK2D/UAO0QmWlRZ05l/WMcaCSEIRCWVUMUXJOmHV/nnj7+bMeCeBxYDCYIcEz4brMPJ3tGVkM8
 TTncetGrsGZ39/QhCMgM6i/8f6WHREUV5uVy841a/jW4l7S9g8DLQgXgoBJEXEPWEFw4SwST5gp
 RlngCo4gHcoPFAyHHACJKonYVyHAgzv8lCPKnNqs3zgqtocX7faB+l+BZeWMuS63w==
X-Google-Smtp-Source: AGHT+IHvVpaoW3jQ25m0VbfDU2JI3kKCf8/Tg/9VgMCahYh2/xGD+b1zrfwtB2jUz/LJTsyA+FjqDQ==
X-Received: by 2002:a05:620a:170b:b0:7b7:106a:19a2 with SMTP id
 af79cd13be357-7be63249e80mr3127496985a.31.1737480860329; 
 Tue, 21 Jan 2025 09:34:20 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614746f7sm578462085a.9.2025.01.21.09.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 09:34:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
In-Reply-To: <cover.1736851116.git.weijie.gao@mediatek.com>
References: <cover.1736851116.git.weijie.gao@mediatek.com>
Subject: Re: [PATCH v2 0/2] MediaTek MT7629 OF_UPSTREAM migration (v2)
Message-Id: <173748085946.2982616.774617278743530499.b4-ty@konsulko.com>
Date: Tue, 21 Jan 2025 11:34:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 14 Jan 2025 18:42:47 +0800, Weijie Gao wrote:

> This patch series migrates MediaTek MT7629 to OF_UPSTREAM
> 
> Changes in v2:
> * Remove mt7629-rfb.dtb from arch/arm/dts/Makefile
> * Add wdt-reboot node to make reset command work
> 
> Sam Shih (2):
>   clk: mediatek: mt7629: fix gate offset of peri clock tree
>   board: mediatek: mt7629: Migrate to OF_UPSTREAM
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


