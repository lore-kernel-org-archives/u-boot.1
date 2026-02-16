Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EECE83829
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 19:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9024883E13;
	Mon, 16 Feb 2026 20:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W449bPMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF1883AAB; Mon, 16 Feb 2026 20:39:13 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB6383CD3
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 20:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7d1890f5cafso1223656a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771270745; x=1771875545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0J9lm1e56Yd2rTR+Hp3aw34GupMDUGW6QOct/+3RCo=;
 b=W449bPMmT3nr78KZTw0lttF4f8yFj5iu5Qd65lFB5bGhk0AX5rz9Xr6OG6DcZKk3B8
 4CyGtKRTcejH2YRWptZKaQ1ssnS73ClslIonJY1mEGCe7RcP/411v7gpYxrQownQCbnM
 QTEvWhE/XiHshwFdq689A0mEa/xXbsoQmTXb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771270745; x=1771875545;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j0J9lm1e56Yd2rTR+Hp3aw34GupMDUGW6QOct/+3RCo=;
 b=P8vBiiCsuhJDj0RNfMeBfRLGaDmcEVgT4xrknOEDLMpX940m7qbltuvcvZ/TUkVRJ7
 P4Bf9jpl+vcr8t4Vne4U5Y6tQD3+qvWaFy7yN/6WSs1kBpCmsmG7sVhEbeUol2yTCkrC
 mYa2E3qoyAfer8x+NZT9QFNSTX4udzRJsGzhmfmWNTMqTnL9nvIi6xanAUaE7CdjEevO
 HGMYFkm82zmTFbCufbtqgciZhDsRtzmdcaDE7j435ytPvU202Zc9IedZtLnUxjX47/fT
 8GqqwyHQ7CRLyEVdpePoSyGWtEFGxVANtCUa0q4ATGMQocUiP7MwB4ANSQT+jXjNJJux
 tpKw==
X-Gm-Message-State: AOJu0YwH/SpYQp5lm3r92EsgA/6HOhfbhCP+DZ5nkMQbJWBphFnQ97Q0
 UiKKEQcNTXqASU1rn65K/oX49VXrq8cJjzULvRm3zncXCDaPmGyZbj9F/8lqsL8NXUM=
X-Gm-Gg: AZuq6aJTeHPJUEDjzzuMRqCiUcRCFIIXJG0NGZvWlkauCIpVZQapxI4B5x+imk93WFC
 rmWP5YaKuCbGcTrhEtGrLyqeUaXPAelL4FXVdMbc0HnGOqZB8Hg/b65pm9x01Feh0t8SfFAhO+f
 uqeT8xFpGmEBXEpQ4AMgO1ZivPrrqKxX0xgEkWI4WVoxDg1strXeateSndC3PFsd2cMJlBhGWgr
 O1v60zjqQRUDqS4V1y3J7Nv/YpHXYqq9SOF29AQeCmI6hhLK1hfXxg/bTrTLTw8JXCE30W9aiJd
 wbRBc4gfqRZlRsVo46qa2TorE2TTamBX7hrrHM0I0t5LY+PpEGcTjWUFM1fDRlAzp7/yPbVNAoM
 iuQ7Dz/aYPLMHHS3ZBNuA8lZVM45a++9NZlDA6cvxQ8iFo6P1ydCuOLujfgmRuLswnmmoECDj9j
 N2DxX2IzowyElAiJCG4iqYm/Ed8hIDTXUeRX6qNQo1IMCGMcrQ9NfKT+M5o86BUZyKpUfrOAqU0
 SL/lTn597xT6OP/im5ZAN+fsRpFT+GoVB+hjCcFO+oE23xZHA==
X-Received: by 2002:a05:6830:258e:b0:7cf:dbb4:320e with SMTP id
 46e09a7af769-7d4d0bd1ce1mr6323680a34.18.1771270745371; 
 Mon, 16 Feb 2026 11:39:05 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f9483sm14142543a34.20.2026.02.16.11.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 11:39:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260216174618.56494-1-marek.vasut+usb@mailbox.org>
References: <20260216174618.56494-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <177127074470.2634449.3919799247715917618.b4-ty@konsulko.com>
Date: Mon, 16 Feb 2026 13:39:04 -0600
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

On Mon, 16 Feb 2026 18:45:42 +0100, Marek Vasut wrote:

> The following changes since commit f9ffeec4bdcf1da655a0ffea482062adde78fee8:
> 
>   board: toradex: Make A53 get RAM size from DT in K3 boards (2026-02-12 08:12:09 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


