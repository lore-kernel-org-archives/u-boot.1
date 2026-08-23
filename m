Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48247C5DF9A
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 14:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42B4F606BD;
	Sun, 23 Aug 2026 14:58:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jW6NedM-RCVv; Sun, 23 Aug 2026 14:57:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787497079;
	bh=nz6ylwwtevrKYRXXJ81y4D7FpnztqCpcOR2mDMQLPuM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bcZTtrs6JNMrIAbV7vbqzOtYfH2WGcBOES+NKqu2z4KDO5M429RF1zOsJniZbcyvS
	 tsB97rbW8vrWe0E22hL0uAUvKZTaPU3eqkLc+QKmqq6aqBRnDxvMskVgaQRePw75dP
	 rtjsMnfVt0Lj0Bf94uKxhZTRz2WnYatNWGut3cdbimIWlRbhnJsaPQ581xCrsFmjCq
	 ecnjHPYDnZnOznCIvDA3Eyzw56lIB+7pyRwjp4XV8yKNLe0FA8n7JA6tpsRLre+WDH
	 xRPpsykE0QqSiX42XYSPHsw8f3IdrYh7a07yxRkqfAeZYEYjTSEz8R5LY+IGBg21UG
	 wQvDdhvGcHI1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06978606E3;
	Sun, 23 Aug 2026 14:57:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40957336
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32EDA606C9
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4i9QphZLSZL2 for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 14:57:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ksvnRUBn
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73B206066F
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:57:50 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7f3ff92cf4aso2740418a34.1
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787497069; x=1788101869;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nz6ylwwtevrKYRXXJ81y4D7FpnztqCpcOR2mDMQLPuM=;
 b=ksvnRUBnPRGoqS5l/Z2MVeN9tEBYYPIVcvR22t8YP4VOPjX1Bi1RKab42IdkqCRyD8
 Uk+ISyZfDEbviw+0+a1n33SzQP5D56ehxiHVFgDIht78Xk0Npl3C5LzTeKeFZLM8MaFR
 47f32cuyfY8RnwavEsOLFWDa1+x8qSXq2A0+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497069; x=1788101869;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nz6ylwwtevrKYRXXJ81y4D7FpnztqCpcOR2mDMQLPuM=;
 b=MP5IVz5P35mHAVEt9Hnjqj86pk8iQKTUtYDI0HrdWXNTzbxmYqSSaUNTiVJgTkGhYr
 fpLIlK+Em5zeHVN5OXiCptBmoSYsDm4km1xvRkFzQuTdm+zR18Lawg/znqbwk+wzThi+
 LbYTUv3FL64jpWYiJ4gaKbaQfP8xz1S8G9rm+9CdCAdyL7qUfE1rZjuek3f8bKXjQm34
 6JurdtUkcFpNphB0w0VHbn3jUs4Dg3cb6jiaSXB+qhebAuP3p7znFMlibj0aBhEtquUX
 OsB4zRmJvkgdpym4jvIpL+4POQLyf2p2mC6f1TAdQj9EPxEwfXsEPGyghEcE2tlEu8tI
 nvAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZKNPTPeJEFxzptvhPP9bdDUcDnF42l9JIiaM3Oko6G1xPdeJqqsuca5j19yXhFhXPMGdWeQ0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lFI4+x/XEKGe6mY4eTdtLJkR1xxp11nrN6v37KZ8LNZnt+sEyD
 YNfURcX0oiPJNO+a5FVJITrx8jk/R8d6Bkxx3MWLgrEtB2VBoEcf44OhageC+lRj4mY=
X-Gm-Gg: AR+sD13RY18xFaBAt+6p99P2uupFaPEUuGUTdj9mGEJB9eIvxGzXB2VV+uPtdvzZO7s
 2qR0C9sU/zgXVXXepTxSNuLBUzDjv66m3dT9G2FOaw/7A/cd4RJEey8MFOu6xfrtVoMOisotjHr
 RKH+8pohGJ7idG4GOpjfb88mUjk6H1hz8GtQtTqzyw6pQZkfuxJbwCQ7ZV1fA3pZ4+yIw5i3Hkd
 /4QnFYLanlGWP6jSJCT1OuwKx+WZAf3UUfrJ2Ch6FmqdOjhF0APJK6Y5WwckhEb9WGofdHTpIzt
 k/lXA5p3oFjfE30oSvbCWEboz9L8Lmsf1nncaNfyLOuWqNwIhuYzQrjeoHgnNfiJBuHPfbqRABI
 zcZRmQxyj5G4FtvkYNHoa+ZDVq3LS6sHyUNKA+d9nJlAWk42dTvPJziwueluEBIGjl8qIu9Nue9
 UcqovqhqOf7U782Ta2pIrb/AW2GcnPSgDJGPY7qik9BUY33pf1XDay8UJeCo1HjGHb3kGjEE/6D
 DPXtphhS8dFMAmV1/bd//rxIsqkMOMg07xHu1VMVDERIrsjCj5bqG5up4t1ADO5U5d+kVXlvE4D
 362gk0zI
X-Received: by 2002:a05:6830:3c0c:b0:7dc:c4ae:a689 with SMTP id
 46e09a7af769-7f461348fadmr24954572a34.2.1787497069206; 
 Sun, 23 Aug 2026 07:57:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc89283sm2028583a34.24.2026.08.23.07.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 07:57:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Markus Gothe <markus.gothe@genexis.eu>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20260809232726.2436904-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260809232726.2436904-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH] pinctrl: airoha: sync with linux-7.3 driver
Message-Id: <178749706837.206448.895471974507405553.b4-ty@konsulko.com>
Date: Sun, 23 Aug 2026 08:57:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, 10 Aug 2026 02:27:26 +0300, Mikhail Kshevetskiy via U-Boot wrote:

> The code was synced with linux-pinctrl/for-next (future linux-7.3) branch.
> 
> 

Applied to u-boot/next, thanks!

[1/1] pinctrl: airoha: sync with linux-7.3 driver
      commit: 2d379a529c257606946831a6dac1c37de6a3f8c0
-- 
Tom


