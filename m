Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241ACCCF9EA
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 23:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB69838EC;
	Wed, 29 Oct 2025 00:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hZJSxFEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41A6583826; Wed, 29 Oct 2025 00:57:43 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7363C83893
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 00:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c5338b1d10so2504023a34.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761695859; x=1762300659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xJK7TpAUBIBIQbfX+EBZaPOfwIg+ptzBaWe7dAJXMxc=;
 b=hZJSxFEEyN9duabryjmQvWrICgguEPZ24IjJTk6TNCTc4C/3ny+EBaFsMD32Er00ju
 SzsAq7SkuJBtAhklVuESX0bABdkTdGyMHWDCcCGLByTD2XR6hMh2rbcLH0HOshvTeFDL
 H/8x4eQRpCXObmdWB6hIRLuTllxa5mk8ouArM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761695859; x=1762300659;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJK7TpAUBIBIQbfX+EBZaPOfwIg+ptzBaWe7dAJXMxc=;
 b=UU7kvN48Qse6ybWifLNuFiZKBix2PMZT86GJimqdIQgo3Jfh1sPnIwkIqubV5OdvC0
 4jVhyymEqMnAVs0s1kDx//CcjZKaLGAdqzXVIohd8Ws63noxS/wRfTRuyEi0rv8E8oYq
 XptLDCDyETK94Rm62gBulyV/99zMIz2e+kCW9YEaL3U1xjmS1ceWK0FpeFdY9lfHUT3w
 M8H+2puquiz03TQOkOzM0K7WrCvXu31YK+ad5dTmfov0k2C4HXpwCjz2suT2nHbBmyQu
 xFasLUFfL7jBrsUEdHs29zAMbxD/fXW5QRQ0pAyvmZpWeU1HZHyHb3Ztewd7XpOhxzZQ
 5cFA==
X-Gm-Message-State: AOJu0YxylABPjrG3lh/0M0cXAWuro1NqpvUY2/AlwBElWp95oNQlfE2S
 zc5RthAbU8HaP4GtXwNFAp6GrUqPSDsCA6hHJUW9RoergsMwSRQKMGxcMtOTZb0yhuM=
X-Gm-Gg: ASbGnctSXkXM+rE5Qa/dpPXKTLBpMyO22Trj3X/NsUPy9Juv1+oPGiCZrAqrKtciGBb
 AcyJD/l/+xD/sXHcdLUlQOmy17vGza4MYyFNCEMKnEBJNCOOEWyzxJoCqPgXftNxzOTkHJuyZ45
 4QAgQ7R4HKaeScYeMc+mYWT6mrUt0xKXHicRggsdWQbgF1oHyS1pqxQXhStunnKYys5jPXVJ1Jf
 8xePyECLUSDNzcKde2yzffhqjtbitlwXOJcR6T4x3pmGP5KvMlJyaBrdatZUlotaudNS38aEVWk
 m5n08G+f2VATus7vzyFrDU+a2y70ILWWOLz+FHKoADoh/KEKyd+NQLBIU+yC6IU1/CUQWQB5IET
 aTq/xagmBlN9IOoSHlQBZyKJtIEGfyW3zF9xvlthYq3cB49RyRN7n2PQt0Z1BuAxb3KYkFuW+hd
 o4js6OX5glimD/RACmDVwUIveyoftR1r8d/GWEOQ==
X-Google-Smtp-Source: AGHT+IFRFMmqZbzQWHa2i7fT17Sv13GCxm7DzBk1kBdzEsjdCX9EgoSKr8ok2mGJKgPEq4WQiWqHDw==
X-Received: by 2002:a05:6830:628a:b0:785:1b36:69f2 with SMTP id
 46e09a7af769-7c6830659c0mr769448a34.14.1761695859249; 
 Tue, 28 Oct 2025 16:57:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068a6sm3646234a34.25.2025.10.28.16.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 16:57:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250804215719.1413106-10-trini@konsulko.com>
References: <20250804215719.1413106-1-trini@konsulko.com>
 <20250804215719.1413106-10-trini@konsulko.com>
Subject: Re: (subset) [PATCH] sysreset: Tighten some sysreset driver
 dependencies
Message-Id: <176169585845.2287207.15564529663598522178.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 17:57:38 -0600
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

On Mon, 04 Aug 2025 15:57:19 -0600, Tom Rini wrote:

> The MPC83xx sysreset driver cannot build without access to some
> architecture specific header files. Express that requirements in Kconfig
> as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] sysreset: Tighten some sysreset driver dependencies
      (no commit info)
-- 
Tom


