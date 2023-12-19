Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386F4C46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D1F877FE;
	Tue, 19 Dec 2023 18:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pb5IKYin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B914E8709C; Tue, 19 Dec 2023 18:46:32 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D546877CD
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5e745891a69so15265547b3.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703007983; x=1703612783; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxRYye+uFrBXshSuyM5wwistanGGjRNnGkwiRbFmBVc=;
 b=Pb5IKYinFq3FwHlpY76ny4Xf+enekd0HpMmIhpzBMAvPzJHywuOIp84jqPy0nyOGxe
 4ROIODgHjW8Tl40wfOLe3maFh6/auz3YX5NVLiaCyhwQU6yc8Gv2x6makkWqMueLM4En
 215nxt5g4SBffNLe9ZtLjOmai4lvjxzzX0Jmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007983; x=1703612783;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sxRYye+uFrBXshSuyM5wwistanGGjRNnGkwiRbFmBVc=;
 b=HqWuarW3KEXXvQP5nN45KAsoKGPgh2zTlPL4nBsFNmh6OvCI95MRMNwReUK9f3K7i3
 KkIl333vRAO6SMXJt7+WC6ygoOmJ2895v4PRReKWYbsyp9czjBwDCTcg2BmoB3iGDWXh
 bnuXBS24DnnYQmV55tXDuZ97YvWXLNSXVIzEE8ksWDd/L1C0/w4U9wPBV4Uq7JxiZcW5
 ANypQSAhHP8bhX8heOoZnzO+SSkrEai1Rfvlrn4DAOVzrJjHr/pP/HUNqVcRS9/QpPEC
 KMLF9kOy99KQj9jW1FH52J/jGy4NVUO6QFvDnsjiMWqRF/YF0iSaXlnzrlJoxQyy+UOT
 HATQ==
X-Gm-Message-State: AOJu0YxPgs0BPXvOGl9lFSf2FbaL6vyXefvXfmJcQNam+7QjILv+sFZS
 EnxOMwMzEozAmejaRGcX6X1mcw==
X-Google-Smtp-Source: AGHT+IEyOaDVyaZ/6zqLGa9I+jj6EVYrsPEQ0Zwi3PS8Lxxwlt30MrIDfkI350/BucmVP2p/rznlyA==
X-Received: by 2002:a81:a507:0:b0:5d7:1940:7d63 with SMTP id
 u7-20020a81a507000000b005d719407d63mr13594272ywg.58.1703007982995; 
 Tue, 19 Dec 2023 09:46:22 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a81ae07000000b005e79f80959bsm716585ywh.112.2023.12.19.09.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:46:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Julien Masson <jmasson@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
In-Reply-To: <87plzm450u.fsf@baylibre.com>
References: <87plzm450u.fsf@baylibre.com>
Subject: Re: [PATCH 0/6] Add support for MediaTek MT8365 EVK Board
Message-Id: <170300798190.2765809.16611475591002385370.b4-ty@konsulko.com>
Date: Tue, 19 Dec 2023 12:46:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Mon, 04 Dec 2023 11:48:49 +0100, Julien Masson wrote:

> This patch series add the support for the MediaTek MT8365 EVK Board [1].
> Most of the code have been copied/adapted from Linux tag v6.7-rc2.
> 
> For now we only enable/test these features:
> Boot, UART, Watchdog and MMC.
> 
> [1] https://www.mediatek.com/products/iot-genio/mediatek-genio-350-evk
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


