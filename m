Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39932C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 12:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EEFC81D5D;
	Sun, 23 Mar 2025 13:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ul7w07uF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137B881E3E; Sun, 23 Mar 2025 13:26:38 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1848A800C1
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 13:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso30113325e9.1
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 05:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742732795; x=1743337595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mAhlAT+/98rrfJSoUU5no+EjGnxDlALOlnurBbcXCo=;
 b=Ul7w07uF3/ZRG9YKvP1TB9qfxavFfLLyPBZBgxhhGTbp6HlZnxg1+V/hypcs6BrgG/
 f3MG2T9ox+Cta668hGQepHhAj2cJanXzWJRx+NMKHLBJ5TxIH0k9gML8HmMRo+RGhRz4
 LPOkHPqGezcvIJumkbfsJWcKQPPggGvQFQnkPNklsD5BuLCTyCexy3lUPzpJbsvBoFjm
 jYArWdnluHq7i5E/1A7/+F60HZbrvfeBOIWFh/RkQ2GLcMDx1uPx/gzEWP31rnprh5v7
 wWPCtP89CmTAYsK0NVXHmrn+J4ft3yWK5U5dsgPkNnsyTexDr1GpfNqwaAsktnYlARaX
 CUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742732795; x=1743337595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3mAhlAT+/98rrfJSoUU5no+EjGnxDlALOlnurBbcXCo=;
 b=Op0W6BBhUDBKybDTzkBQp1ZBIzpxreGijTFaRl9Y1q/yTQF3d19nUzuAa8bsfAqv94
 JfNtUqUFcW/ioXnuwnjhwQSuc4aKnasCidys1tboe1hctQ/YkPqsS/gboPpE44EAKCl+
 ZmGWL4xfkxBcToTVtV36fIXrMWcM6i6rid4JhuUDBwvotjflHGQJSHIapUhQsn2BdqHD
 BtcCQIbRuwxqdkNk8oPpvGCCjcSibpLfqrKVOGwTn/hPgor9V1ET9wY84KffA0UOvkgS
 V2cDapgrOak1JF2PM08E9TghzHGs5RaNHQxGDurboiJyHtn1a4Kik9C3mwE0C1ouwA1x
 cdJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPDYkRmpja6EJRcpdBuUJc4fgzScNywoya2sWr4/SdFw9lUkTp7n5BA7Eh9BCEr8JuBri8R/A=@lists.denx.de
X-Gm-Message-State: AOJu0YwFybXalmxWSJz9WCgh7/t7qYJSbeMaVykMDDYTNI5WsEIm5+gM
 Jq/LNeBNY3gTP3392nGZ+2GhLgus2ngFN3qC5LLTRVY8PW1i3JD5
X-Gm-Gg: ASbGncvfZWBE20P+U7qpOUw+/8a8Imp7HWybCLoUWpSyRqlxTo9VDoo5wjX3EZuunTw
 xulUpNsEdoECyauMRm+NDPVqqgd1x1Bc1cnwJG2NJP8DzlJLZTyeqyZfa/FdUYiANC7qTNlXLGk
 lLjxTGFlsukzydYYhwtxHDKH1iJe1aBw9CYKoABQw7ALwV3Wy1xzhU+5x9n7CCMjfDqiSFnbgrL
 mij5ZyZ7VG1SSYzFQad5K0rCevYOxfQ5aNu1g2tmeMNyI+Hn3a8jICyPvKhQ1Ry1n5oc/ES3ibv
 Ir1slhxqbAESgzdrAhZSGTxM5Orp+ExPQ2jpRl4c+3fPLlpml/COAbGmbWSkcvFWcoak+g0GyIh
 H2roaEmrKT5LeL3+w5oW/
X-Google-Smtp-Source: AGHT+IH9q1gv5DOJq1ciRnDFp882+AcCwsn+mb2Rir3rjDj+8leHkDhgXFF5ihJNuv8r1/5ra57nvA==
X-Received: by 2002:a05:600c:1909:b0:43d:aed:f7de with SMTP id
 5b1f17b1804b1-43d50a1d216mr59845225e9.21.1742732795153; 
 Sun, 23 Mar 2025 05:26:35 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9f0107sm7790915f8f.99.2025.03.23.05.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 05:26:34 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 28/34] sunxi: armv8: FEL: save and restore SP_IRQ
Date: Sun, 23 Mar 2025 13:26:34 +0100
Message-ID: <8544399.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20250323113544.7933-29-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-29-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne nedelja, 23. marec 2025 ob 12:35:38 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> Thanks for Jernej's JTAG debugging effort, it turns out that the BROM
> expects SP_IRQ to be saved and restored, when we want to enter back into
> FEL after the SPL's AArch64 stint.
> Save and restore SP_IRQ as part of the FEL state handling. The banked
> MRS/MSR access to SP_IRQ, without actually being in IRQ mode, was
> introduced with the ARMv7 virtualisation extensions. The Arm Cortex-A8
> cores used in the A10/A13s or older F1C100s SoCs would not support that,
> but this code here is purely in the ARMv8/AArch64 code path, so it's
> safe to use unconditionally.
>=20
> Reported-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

I have sneaky suspicion that this is already the issue on H616, but I
haven't yet confirmed.

=46WIW:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


