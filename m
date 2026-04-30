Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A353ACD13DA
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 19:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8928F841D7;
	Thu, 30 Apr 2026 21:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b7eIc71g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 393C180433; Thu, 30 Apr 2026 21:28:12 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685FA80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 21:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8d4f78fc9f6so127494585a.3
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777577288; x=1778182088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YszaYLo8lCrz+C+AIeRc8M8XI18B45A1oe3Vj3yxF5I=;
 b=b7eIc71gXgeE2Qgp4uCfPHHlUJ7wlWwj6n6Mrdhq/Xtk2nUHDzT+5jvxFgYFkcMK5H
 GMwkdQ5FLHfUjci4uy3sBmFZPr3TWOBB0maFFQKu3+68JtsmJVu0bxXjN4okJ5KXTZln
 R539vREbpCb22RWkTU1WE2zO//a5VyUgBLJYGuVwF5/VnjO4Sl/wgdzeaJu9BNsQIYXh
 ujuuGLI57ddeCkzcls7OHgFlPupln0ElokUkYVd5Wf4lUvmPsVA3RPzPW1jVlJE/+syW
 0IxUZFq7q1GQOtv+mz0BVZHsc0aQAA8+x+yoc3dugNWup9JA4u03xaczeITo45tFROSY
 Ln/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777577288; x=1778182088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YszaYLo8lCrz+C+AIeRc8M8XI18B45A1oe3Vj3yxF5I=;
 b=TXK8R48Pj+dxTutPZl4BIWyGYR6iRjb5UL5YPeTP4IPxcjrBBUXv4JcKNv1sf5Ucrk
 IcibdgkQ8f6G0WsrcvVoerHPQX3GlI4kVzf180Ki+ijwyBAES8LdmsQLNQo0xQZ1JnRF
 9jizChODnAel0YbALa80iD04xaYeJFg1Caq546vZDNzzLEoAQz1c7KNl6jQ993SeJiq6
 qe2DO1lFBSBumJ1sWCWf7p1UO1jVvJyEWm7cDRx8aBXtrIR862viIUa5c/HraQ+63IoY
 sUxwLBWlyuEetIfixOu+d6f68w8dWNBSbgXTQo4sSJNUXKFgdPXFAmZ5Iy1kS0LULvMr
 o/NQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Yf5opxPXC4ICNkCCblfEWIOqwUrb0Iln5DxKBvTH3U1rFK03/ncngTOBNZDd6tsotgYU23Wc=@lists.denx.de
X-Gm-Message-State: AOJu0YxUdvc1Aqh/owRvNuaa90Pan5bMBEwhpq3d//QuYvfA0Xw8HpBw
 ygyswXe5B3eL9uIJXlBsfDOCEsTfLfw7ujK6rh7H+Vs/ds7yPMLg+w/n
X-Gm-Gg: AeBDievgCltuxRgcv4mG5PAMEyJPok9k66u0iSyoavQ09Bn88p4JzgeWPZvQkoDbGHZ
 1OmSNG/lm7JIXaUcaEyn8MpjOG07yU+yWTZFz6bHz8XFTakMR4pX0UUK6YgO6HFKhbzlbPhwAeD
 lx6RYJ5XNWtyQ93Ep6dACARIm6ZDRPcxkoO1JL15peYwSDc6tbvJdNy81v4pDe88O3Sz8Kfhyoy
 gjJWxTVu6chELNtdMA4bLkrvfI4ftXvjVa9m1GHrhBv7d1zuspD7D8e/Gijj4navfmU3eLUS0cr
 18FP+k0S+9Y5CM8KoLBI5UGiMUXOKrbrn5Z4FCiZnCdCds0B4H/Xk6tY2BeCct7AJDEydGqlxsP
 KBvpNoBMUPh40vktwR4e0EgaDaPP0OQl2MaMZEcyohx0+4q268SFGAVgRJP5+kNDsmuTmKNjmp5
 AuKh/u69uovZrKhfHlhz7+we5LvuSaeiy16zTXsEG7vZj8ZzyE
X-Received: by 2002:ac8:7e84:0:b0:50f:bb77:a085 with SMTP id
 d75a77b69052e-5102ab353ccmr64448021cf.12.1777577288225; 
 Thu, 30 Apr 2026 12:28:08 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d3485c5sm2778371cf.30.2026.04.30.12.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:28:08 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: sjg@chromium.org
Cc: caleb.ethridge@analog.com, jcethrid@gmail.com, linux@analog.com,
 malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v5 05/15] mach-sc5xx: Add USB boot command
Date: Thu, 30 Apr 2026 15:28:06 -0400
Message-Id: <20260430192806.4875-1-jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFLszTiZRVXXtg_e1FimCOGvB4xNUxCAg3nd8Jq+QBk=TkmwYg@mail.gmail.com>
References: <CAFLszTiZRVXXtg_e1FimCOGvB4xNUxCAg3nd8Jq+QBk=TkmwYg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 21:54:39 +0200
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

Hi Simon,

> Just to check...should the partition for the fitImage match the rootfs
> convention used by mmcboot (load from p1, root on p2)?

That is correct, the USB and eMMC have the same partition layout.

Thanks,

Caleb Ethridge
