Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5407D2F326
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 16:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04CAC836A3;
	Tue, 13 Jan 2026 17:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WUKz3FkM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6948982C7F; Tue, 13 Jan 2026 17:13:27 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BA8E8352B
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3e80c483a13so4660427fac.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 08:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768320804; x=1768925604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxoyoWyT4cj27gFlC97hYNNO9eTcfuVqQUC02DdQZVg=;
 b=WUKz3FkMP1MIw3UQzis+2sa69mmCGoILHq7j1Uz+CAmaHyvChrRtN5TDYFzsQlK78j
 O7t0/0t04KJuQkr1IJRfg/W2sDBpZp0RRi0tL8yhYOCQjS4rX2DqFYqma/cFtRfAS6SI
 LJjwokARySQlYKM8Iu1zj4WA3t1j5qRF7r3Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768320804; x=1768925604;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AxoyoWyT4cj27gFlC97hYNNO9eTcfuVqQUC02DdQZVg=;
 b=Bo5SZymK+JQrt+2bHkjYwAuyIGk86pC2n7S7a8uPAYz52NdkGihOTRkJdn2+wGQnLJ
 RhJHPHKiawBX8Uopbl6rBC1m6BnY1CHmahdj62271LWAt16jKjztIqXmrQcojhQWNxKp
 NBSl+w8pk3x92ou+MamWc+/ioominqazFdNSlixHtAnlhHmudb4r7zhHri+tclwXgEwE
 6hlssbQTsf2UX57Y+FRYwuvg5/B3guuLxEueT4SSqF3if+jfPBurk0kLqk9b8U3Ux9H6
 3HOMVzj9G7CtMsmZA8fuLyiOU49jkmMT9btaNT+8GFGlm9xopuk0VyKl15aRcuoXxnS/
 E60g==
X-Gm-Message-State: AOJu0YzIzdd4SmFDZYTgpIqaltwaDd/nZ/d/WBX8iRsq82RgFuEXVZkA
 kOvJslCAcmjEKV/okB2zziUJvP0KolFoAOzred91DmFBYHaSRLkHCEqFMoU4lNpI6RA=
X-Gm-Gg: AY/fxX7qzeIlEXmrX9rPF/naI6XotNCACtSistmWMzr0/Ce7Lg7tBq6ABPXyuDSinXG
 51bIGnHXFSiH0JdCYfsiPmZ+/3r/JwmlbneUWMygNMRjbm3754PuVf4q/D3b5pPNLpJ6ZKJpN9H
 fOtuMZa/eHE9qqULbEEy5FA+kRUBA7vzJzlrxEuzaG5oSc21X5fy+1GsFpNUosnAd+VHF4UKST6
 mN+Y4gjWsFdUbJsXqmECWr1ZZm159l8fdZ5bb7cuTil0xr4lMUCMDNmJrFNfbk3gbf6/65io1wh
 UOf6NfTaajwFDRZy/nTyRNfIVQ7RX7gTDZc5pl60ulCIxYu/nB6xiuiMj6QohJe+dgyNUg0tpbt
 6VENQWrZPqzf/DeTNMOUpkqVXt35eyK67PKqmkT8axrsNdwwECa8Ltit3i7UrRz1sYTqaxIk1gS
 Q729S6UkQBycsm5P9rOm1AxWWOAUoDVkTWM2z5Am9b51alVocNsfmGx3RdbMUIwJvTLI3zVxzb9
 yhNOYkX1gs+U7RQ7KOpQjM5rCRqD9QOuwwYbw==
X-Google-Smtp-Source: AGHT+IHOh6ZNbDnQzKR81/4f9PQRbJCdUd4iSsqXTttuzOEy4SU50pmEuBA8vDcoZd9W2GRbd1n7Mw==
X-Received: by 2002:a05:6820:2221:b0:65d:4d4:e7b0 with SMTP id
 006d021491bc7-65f54e36a56mr11375123eaf.0.1768320804026; 
 Tue, 13 Jan 2026 08:13:24 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ccff66sm8575162eaf.16.2026.01.13.08.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 08:13:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shiji Yang <yangshiji66@outlook.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <OS7PR01MB1383436D15128C22D7F9203D6BCB8A@OS7PR01MB13834.jpnprd01.prod.outlook.com>
References: <OS7PR01MB1383436D15128C22D7F9203D6BCB8A@OS7PR01MB13834.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH] pinctrl: mediatek: MT7981: fix GPIO9 register map
Message-Id: <176832080309.2039494.12160391039197607835.b4-ty@konsulko.com>
Date: Tue, 13 Jan 2026 10:13:23 -0600
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

On Sat, 03 Jan 2026 16:42:39 +0800, Shiji Yang wrote:

> Ported from the Mediatek SDK. The upstream Linux kernel also has the
> same register map as the SDK.
> 
> 

Applied to u-boot/master, thanks!

[1/1] pinctrl: mediatek: MT7981: fix GPIO9 register map
      commit: a1d1fc8d8c8699d80e1b9ab3214752e5882d3740
-- 
Tom


