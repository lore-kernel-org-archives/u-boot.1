Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30033D637D6
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 21:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 485B783A3D;
	Tue, 16 Dec 2025 22:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MLki4/X4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5AC383A24; Tue, 16 Dec 2025 22:53:35 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B42A983979
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 22:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4537c9405ecso1457604b6e.1
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 13:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765922012; x=1766526812; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1wAjpED/3iuGJiLpuS+LNGiFWGS1IB6D8o2oXDW4r74=;
 b=MLki4/X4Q/3hgC7sOTjGMpzEdhfHhGhQ2UEhueyUo/opTMFiB79/1srqtaqAvi+8zk
 3CN9Qlf8UXKxwq08At5Sb5p0qGlxLBH2Sy76tEq6eLW+/h2xmb0ns7B86fah/ForaxQL
 sCt/vI2Bj5x+duo4Rxp+ICX54mIMh439H4taM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765922012; x=1766526812;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1wAjpED/3iuGJiLpuS+LNGiFWGS1IB6D8o2oXDW4r74=;
 b=o7tT9oYnBJQxGsLA8RKAS08rS1HByNRMs2Yk9Kz8Pv86kygtmSj8Ik2QSmo1tuBg7a
 HHRhY8sTOybmxjemGXdPIPN/jBKjXtWC+dQVQcxkFfYAhHnE2mbt5ia/4Nj8uK5gZG0r
 OlobTJ5Do5B19uvCgmDv60B3CmM74/kHl34bLyFrFEEFCEMDrc1udyMHT274fZspOtWp
 Av9C2GHrdUi0irp6eVIEVWUI5dO5fbAW6vM22iIOBYFXY+cf1p1On04ET4eWjY3uXSuQ
 PGEuZZ66X1KLd0qHGQIZCb6p3QH3DzlUp4IB9TDT8MryaYVtBinZ5vopHAP93Je4VFU1
 ZeOA==
X-Gm-Message-State: AOJu0Ywv7gqVrKMt3CwNQNfp6VP7xANYIjzx00B0ZF60L+s+pRGWPdUt
 ZvIxC1AywQH6TouVhQlwAkle10uoyY20/rBbkVY6iBTE/NzCAEcD0sui7xFLKQLjlCU=
X-Gm-Gg: AY/fxX55ANt1ZEkulMzQoDedofTZkvTnOtRc9GEatFYZHiCOugM3yXNX+LsWo/4e/4i
 H8L+6WfiDF6/pbhWlmEohX2NQ+syDzrdhXSU98pgmzzojjEpHukfSHPgLV3zx8WFxZoc8foimIJ
 RkL9l1P/dYeaGXr7Xkg41jPLtnTxPhmpbw2y+jHO7debNHbAm9gVopZAJvKRMH+oaVVTQVwKRQ5
 rrk0YN5XiqmVZixgUqXHKv3BXO2blqaGFfI2yL6/Q9Dn4YqZyco6YgBEPCoDeJgLBFTjWW6J+e7
 QmKMnL1lcgT3+32bhN62m525u3G/yuN1cbopAOs1GVEMy/4GyqFMPZxNBsUvkEDZNoH2nS70PX9
 koosuMK96NV7ziK45CKrnJDkl70HSVaWHp0wXqshCPyCGpBbuuXF9M21O4tnChNRexWGpsv9gi0
 DRAuluo2Pm0TORaZmHC/pJppvnmfIenPT6jcXjGtLrm/35XKjsPzXVgacCykc=
X-Google-Smtp-Source: AGHT+IGdjinuFna1LZ0NPcAervR6xL1XclqWgk/E2h+lwdGXPjZpA/WhE5B6EAar0mcdjmqG7BgT+w==
X-Received: by 2002:a05:6808:4f64:b0:44f:ff2c:f65 with SMTP id
 5614622812f47-455ac910092mr5746895b6e.38.1765922012515; 
 Tue, 16 Dec 2025 13:53:32 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b9966dsm8814255b6e.9.2025.12.16.13.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 13:53:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
In-Reply-To: <BESP194MB2805A2491EFE4D94C777F9C5DAD8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2805A2491EFE4D94C777F9C5DAD8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] pinctrl: single: Add missing free in
 single_allocate_function
Message-Id: <176592201175.2225391.11004667963491995629.b4-ty@konsulko.com>
Date: Tue, 16 Dec 2025 15:53:31 -0600
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

On Tue, 02 Dec 2025 19:39:39 +0100, Francois Berder wrote:

> If func->pins could not be allocated, one must also free
> func variable that was allocated previously.
> 
> 

Applied to u-boot/next, thanks!

[1/1] pinctrl: single: Add missing free in single_allocate_function
      commit: eb52d3fe8a591d6daf6d01570ed19ae88b1e934d
-- 
Tom


