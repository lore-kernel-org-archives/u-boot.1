Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9309FC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 04:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A7D240595;
	Mon, 27 Jul 2026 04:02:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ppXY2gQrIbtL; Mon, 27 Jul 2026 04:02:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF20C40596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785124968;
	bh=e0PpFcnAcayxGEFMLunfaE/yCS73ZoXSIqRfJi9mqnE=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uTBC9s8TwwZywAX+iicylxWzbswzKa9bCDI/ouh3AjYiwdb+StlQayvhuIpzLvHF3
	 05W1sbMjEd0p6uz23XVxCqrTYZUvU6/IKGoi4rCaA5ANFrCGb1g/cGG1lUChKLSlsO
	 kluUqG0gJXx1CdKOkw9k6KzBcXFo7RNHotPR36E0xv0Mp2ldN1ccyY5mPKvGLWFSY6
	 WpCgZ4kZtifdY/6zoDM/DmRiOlQWMPOZd2e9Y6alR416U7cbJyGhHpcX5mUCDHSNdP
	 kdKcPp4T5fAcId0dShmq3m6W6OA8gUotJk57VlZpD+zesbBbAVg5epA+DUrgRTvnqO
	 4dFi86ByKE8Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF20C40596;
	Mon, 27 Jul 2026 04:02:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BD9C2E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 04:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5164D80C84
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 04:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VpDxioKLHwq9 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 04:02:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8FCE480B97
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FCE480B97
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8FCE480B97
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 04:02:44 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-845c92bc464so1647435b3a.2
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 21:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785124964; x=1785729764;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e0PpFcnAcayxGEFMLunfaE/yCS73ZoXSIqRfJi9mqnE=;
 b=rXknq3kjoe23g1rFClgvptx9tBBt2rHKI8lwTABikl7yVsxjDZcEicEF3YB1EE7FtO
 sy8Am9yclvFFSnt30Fu9abpP9ZJfoyp34sq8sFdlFejU7ID5rt6y7EyWd7rlkiN4M216
 lOPIjxW+dkKtRIl7EDLRUiPB83nn8YuDUvFBYC0Y2usH9vaarUdqCflG/aQYz9k0SQzW
 wo1uVhwtOt7qFm3gpWZCAMHFPNCIU+CQbLbPlRF347dloS0t/WolWygqubevoNDaa7tw
 C+WJp3XDPHoS+xxWAX+e/KDH3WMMH27ig64OxEIfA5XaShdze1o5841ZMshUS0yKGbGy
 PaWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpB8NCMiW9DdcT0ENESiPxkQVejz/aclTt/4yFOoY7rx6r/7GNi6KRiVpHe6r7CqbbAm1nd+Kg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw8tPlQgigI3IE//rFXocVcqy6XPgEF3iNaHU9V/007AWaPrRDT
 Y5nfvyrw2h0lx4l0YJBJMURqv08UzCZrj+fTntCiIT+N7BRlGfo0MbTMiMLk2qusAAzsS7tEK4r
 2tZF0u6Q=
X-Gm-Gg: AR+sD10MvDA5tvybjCFIK4KMFF5Lb0DcX93dJMc2CutPn4Qv4mHeZLoWhk4qRAjOh00
 foeM0Unanz6OM7gZFXCB4z7qmQYVkpTFugvBVypBcVVahAEcf8etPwmKTV3aq0Q0jN0EmSXu8Sz
 Xi7/9GmcAvUlbkFMCDpsVJPuZ/p3xOHJZpq/IiSmkC5sFuV9z/VDmO8CD8F1BmS7VoVSBXjjUwg
 dQGSj1ZuW5Ie0oSjug5YZvX83tvObLp5J2KpCGyRCAJU0dm3XykNkWvIM046Ks6m/Pgf+iAUGJG
 41/87Iq4pb5HgfHICHb7ncvI3wod7uZcp+8tGjjolGyg2iX7MvILc5D40DPNDYemLCXYuuQuoNe
 sbHIimsxfPwzV9rRPO05mNR1rb+iXTg7kzsNZN4AroRFE9zejs6fhs+gIvnXIwFl1qQzO21RLAZ
 vWdRH0ePr/SVrSMpY69Wp/OiPZV74VD6iMcq3WhwqY7w==
X-Received: by 2002:a05:6a00:2d25:b0:84e:3a6b:499e with SMTP id
 d2e1a72fcca58-84e59600a4fmr4829357b3a.78.1785124964178; 
 Sun, 26 Jul 2026 21:02:44 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e5327f3fbsm2440835b3a.19.2026.07.26.21.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 21:02:42 -0700 (PDT)
Date: Mon, 27 Jul 2026 12:02:37 +0800
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] serial: sifive: remove busy-loops from getc and putc ops
Message-ID: <ambYXeCfsmhr9qL2@lliang-1876.localdomain>
References: <uqth4koabpkytf4u2nbq54cszi5bsaov35x2vlc6mfzigwhv4e@ejbsksdz42cf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uqth4koabpkytf4u2nbq54cszi5bsaov35x2vlc6mfzigwhv4e@ejbsksdz42cf>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785124964; x=1785729764;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e0PpFcnAcayxGEFMLunfaE/yCS73ZoXSIqRfJi9mqnE=;
 b=AM9pUYKKP3gUImhSTZkp0QgyWOujgKXv1Dd2E8b2m40oymboe0nJzpjvJvhqAdhquQ
 PH5HvLqyP2cqK/hXHDEC/6fDaWqSuKam67nI7tcE9PGg9m6MHDTBchhk7Pm+BKHpMZgy
 U10nElI/GGiYHR0gIpFsCc06xBCc6rwzJt/bvLQlPPiYZXSoY5yJFa8IjDz1mFX9uUBj
 ZxaRRsIG8c+gfTj02qB0EsMrew4jBHpYT98TBPCbmm2Y/009m2TaS8Ued2pCxz+MX9Ht
 N3s4uQMtjXs8tEEu3D15tDb8MapZKZhxoMmw8v6RglqgGp29yA+nkDpyKV47sRxTYmR+
 9kUQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=AM9pUYKK
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sun, Jun 07, 2026 at 09:06:31PM +0530, Naveen Kumar Chaudhary wrote:
> The DM serial framework in __serial_getc() and __serial_putc() already
> retries when driver ops return -EAGAIN, calling schedule() between
> attempts to service the watchdog.
> 
> sifive_serial_getc() and sifive_serial_putc() spin internally on
> -EAGAIN, which prevents the framework from calling schedule(). This can
> lead to watchdog timeouts when waiting for RX data or TX FIFO space.
> 
> Remove the busy-loops and return -EAGAIN directly from the underlying
> helpers, letting the framework handle retries with proper watchdog
> servicing. This is consistent with how other DM serial drivers (pl01x,
> meson, cortina, etc.) implement their ops.
> 
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> ---
>  drivers/serial/serial_sifive.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Applied to u-boot-riscv/main, thanks.

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Best regards,
Leo
