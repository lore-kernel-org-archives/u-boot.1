Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CADDFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5C1B8420C;
	Sat, 25 Apr 2026 19:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZFN/2NkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07CC484319; Sat, 25 Apr 2026 19:47:07 +0200 (CEST)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72BB084178
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-56d9f191ae6so5811684e0c.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777139218; x=1777744018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zg63SU0ClNRpmtb1Ufs27t7wE6wtGca1hRUNY6gvhVk=;
 b=ZFN/2NkK77MqV2xASqV/HTmX1hwh8ig0rr6YINOjl68a3eF4dpPN/3CylGzS693Zg+
 9xCBZee1zgLfj46rsCySRrArRlRCBnFV+F8ZIMwj6O41FFEOGa3s8ZPuypgACRZJznl2
 tAsRpqMEooo6CcpDklKJq0uhuclbeY8X1aXPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777139218; x=1777744018;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zg63SU0ClNRpmtb1Ufs27t7wE6wtGca1hRUNY6gvhVk=;
 b=Y1+KwQ0y1gxMgv2+3sIlzLk6Mp8wMJaieUpGzI0gpYG0W5XfTqe92ftwdku9t5r3hj
 3cfHXJxo+PBitf1vvCl+1x2CqFBS8wlhdhNSSqKozS1cq0ClZ/DYwCaDsxH701873PUT
 tns/1RQtPAenM620dmuFN0PRsq8ec6wY4Ks8auMJ3yCVC1EPxcCGDr2lykDpOdKF9W38
 csyBhqIasnkhAsFqnnYagaYvqRzMdsmzJ4BNgBpDu6xk3xCrzSJ8s4Jjl/HFlZckU4uA
 xL+2xz7OGaMUA9pMU4Zt+mlhcWQjSrtS0GmZKhpRbzaxzgHdCyEDKxlnvZ05ktKxFVMX
 cpLg==
X-Gm-Message-State: AOJu0Yy9zw2+qI5wAI1p3aFS42ynml/ybhD9Ew0//n9D48BfepBayN66
 FSfIxTZjvrf5gueB/ht8G31YyCUwv5KRzdvuuYBpRdC5UXjBj+jeSxzAZZ/IGx/WVV0a+nwg/+n
 D3TSVI3O9vQ==
X-Gm-Gg: AeBDietZZ7ofudJq7czMnID+/bPpHJ65iaKKKtGEENBdcadXVavfdXl62wNMviy7+Kp
 WGIUFrDwqr1Y4Z7KnqK1KGe8yWTbGL6Kxqh0d8x6b5ICx7tOrPb0yzpHq3EZv5PLg3BRo91+E4n
 w/uAjh2EgFw6YdfJez0DRfp4DLrGF1r6foZP9CnSSp0J50coBLCef0Nbrk6x3N5u4bbDtK8nem1
 NeWnGt8jqLpDOCZqtwKgk5stgGfMeAoJw4C5c1s7QbmYDsS3SKhWqKuUAikbkcydQ4eliEY+lN8
 2GSbHSZSDC9kG4sMI75EL2CCKGdDPncWUKZZUgI6LKADhIqzJ7z9YOLyoo7qNli+4/bMNdswoqF
 8/CxAbeEuy7tYrE5bPm2qvFBD2QKKfkQwMkMoi7f2deGjjzEtwDA5Lyg4xKjfv3P4ef766GVVAZ
 hSPylujqrxVpyx9bik46MjAnykXNdySY9miBckQ+UKoLxsTY5XWdOp+jL6+0MjsUVFAd45hW2lj
 fDbaRWIZ9uLK3kJXhcA/2awxGnVMOIfscdMX6FY4MLcJ9hJqkbnNTpce19U
X-Received: by 2002:a05:6830:8496:b0:7dc:c301:d0b7 with SMTP id
 46e09a7af769-7dcc301e1a6mr12850669a34.28.1777056652384; 
 Fri, 24 Apr 2026 11:50:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc975034e7sm19832464a34.6.2026.04.24.11.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 11:50:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Eric Kilmer <eric.kilmer@trailofbits.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Simon Glass <simon.glass@canonical.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
In-Reply-To: <20260420163551.515651-1-sigmaepsilon92@gmail.com>
References: <20260420163551.515651-1-sigmaepsilon92@gmail.com>
Subject: Re: [PATCH] fs/squashfs: Set ret to 0 on successful read
Message-Id: <177705665123.2527258.13932648697567149526.b4-ty@konsulko.com>
Date: Fri, 24 Apr 2026 12:50:51 -0600
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

On Mon, 20 Apr 2026 18:35:31 +0200, Michael Zimmermann wrote:

> It might still be a positive number due to the call to sqfs_disk_read.
> This only happens when reading a file from an uncompressed squashfs.
> 
> I found this by trying to boot using the extlinux bootmethod, where
> positive values are treated as errors.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] fs/squashfs: Set ret to 0 on successful read
      commit: 30885b01aaa4bcdfa3fee9ca3066d3af563e6688
-- 
Tom


