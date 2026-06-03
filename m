Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27CACD6E60
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 23:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B4583EF9;
	Thu,  4 Jun 2026 01:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qDDcRuNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F76E840ED; Thu,  4 Jun 2026 01:34:08 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E36E783314
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-486503ae8f0so60002b6e.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 16:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780529644; x=1781134444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekIBR00v6oVDUYL0PxxK6USPnxd4V/d/6GKkZKxvZq4=;
 b=qDDcRuNs8J7c3ayJsiLr9TXL9vOYlH6g+ZmV6F6U5W7ylXnqTtctkF3YghbWTC+XPn
 9mcroilnlqB6BhrJBg+ydDtYzG4u95Bk0osK5XL8vkRCE42Os3+bFAVSKHLh+inUvJQE
 WVGd4V0K7tCrN1maU4wWJZNC9Pyykz3d+NgHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780529644; x=1781134444;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ekIBR00v6oVDUYL0PxxK6USPnxd4V/d/6GKkZKxvZq4=;
 b=ooV3ctUEBGIanAQfQJtcM2cUrDBL/1HcK++7Kh8WsF7aJfc6qyaS+uVquDve7lH6t/
 vZAesPBk6LFbYBBCegY9u3cBtFOohrA8pL3C5Y3kAA1NlkrQOxZLpbDeZrx7ahS0dnXy
 yAHZHnK9VSqPrG0DNDQLQQvyVEvQlOyS023ngjVozFI6egt7s1vnPdErg9ixtCPJX/xU
 u9PxfFNH05VudN/tlS1+q/F13fRuyqlH4utp2wqvBNAnJ3cDIWDvFcyUzdSc8H0Pmwlt
 BEt7b+xSzmcqKmebpNZ+8MvpXbYmIOI/W1Igl6rkbKyNzvP1L1ShLKgoaMllmVDjdubx
 MtFA==
X-Gm-Message-State: AOJu0Yxsa/6MXboHjPOaCLbGFAAFGvB1gwvdhd0sKtQE/l3GftsXuvxK
 ONOWj48jQTxcyPr2cs0L/AWVgoJbM9jTsCLH6gRigAvZsaJpCdYPXJNbQ6EaRBdfDWY=
X-Gm-Gg: Acq92OEAB6E5fUogliB2Z0sWAr3itCqJXRrfcDOCitCV0+ZGdEgsestMripR+9RC3/w
 HNRoWkTOzrk4KcfbSPv1P1gtpgpMM/PSgJBI6kO4bDk7+rZt67s2zLDrSUdpYmgriOw6LQg5ULG
 IonS6lFIV9he7JuM6ppVhdxCF457HImBNUCJwMohQ292UhCuEH0eeLPvbD+XkSsDeUJFlBMKCEZ
 LN/deZ9hCeo50eHL2qocHGuK8vezAG2EkAr4HjuloszlUuNAPexVE55uBInheXNrlLN2/U4Ttvk
 RpJwpFpJ72CNB2dJihFss8htT3Tszc7NYef+CvSQo+65bI39oZXcAZ70+pkCJ7b0Y7qXHBOo2gM
 JPslTZNYEIRew5kY3utu/Q3DVl1EtOikkmHOnztTIJIE7Wc+Zb+uo1BKA5SOA/HPvKhquP3xsJS
 zQ4ShXVxGsLP9ww+ON6ilUpBz8k8Wu27MQwvCA8YUW6+RLtirIosh483gPysds+nZtjREDmckSm
 M034/GN9oWjnlnDcoUJUK+B8evP+UrJ9L54PDUb14a+1RuGosKVgoPZoMtk
X-Received: by 2002:a05:6808:c144:b0:485:4179:aae3 with SMTP id
 5614622812f47-4865accbc61mr3726431b6e.43.1780529644659; 
 Wed, 03 Jun 2026 16:34:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7263efcsm4075787fac.0.2026.06.03.16.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 16:34:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de, nd@arm.com
In-Reply-To: <db435411-332a-44e6-9589-051d46667308@arm.com>
References: <db435411-332a-44e6-9589-051d46667308@arm.com>
Subject: Re: Please pull net-20260603
Message-Id: <178052964384.2289458.8419325638903897625.b4-ty@konsulko.com>
Date: Wed, 03 Jun 2026 17:34:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 3 Jun 2026 18:15:16 +0200, Jerome Forissier wrote:

> The following changes since commit 30b77f6aa146c96b831cb4ece038130b655b6a41:
> 
>   CI: Sage: Drop rpi_arm64 lwIP variants (2026-05-29 11:03:25 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260603
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


