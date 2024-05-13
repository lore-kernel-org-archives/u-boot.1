Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AC5C25B74
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 17:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B6487C75;
	Mon, 13 May 2024 19:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tHJgGlFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1437882FA; Mon, 13 May 2024 19:48:20 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7478688013
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 19:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c99e8e372fso1664988b6e.3
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 10:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715622497; x=1716227297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwJBFR4MCt0URSOLscdOzh3tZvrPnEmY9ldhGbOtKwc=;
 b=tHJgGlFyaTsKOywkflysyfnSdnbS8slsdEqaejV4VVKdbMSyT2UYov7tssy17IO/pG
 8KPal4We4YvC8lNw4NyuKT1BvRk/IO3t1NGO+6z5dVNdfEbd6Yk36IvdcCKzcG0vJdBq
 grjzaU6O71bN6PCYB3ZpHkYQluqMNveQF2bCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715622497; x=1716227297;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zwJBFR4MCt0URSOLscdOzh3tZvrPnEmY9ldhGbOtKwc=;
 b=EVj8AJQGlVwxA81RazUxxAML9hnM2aoPTj3koEjkEkRWJsrMhi9200wnaFRhwL5tRe
 Le/VXKragXFMvfModGd6t83L77SyVYkfBwGklS5j4Hrt3vz8Z3iVZnI2gQgRfzcHSK5H
 7JDRrRmGSUe+VsakUV7HcyXvVwtmCmk2R3dW4JVFnh4QqDcr2JSO1JNUVuDHt261LxvN
 mFOD9SavirbV7mm8EtuMGlWAmNILC15tf6unfQS6i1tSTHw58ESvpgARu19auxnmtnJk
 +SZywkBwjGnwZTmIqmntrAzHU+g+ql6+rfsFdpLOzlAJ+hvYWCbrfYyaqWzErOIlmsoE
 8OyQ==
X-Gm-Message-State: AOJu0YzS5nH4S0DYruJVRpd/h3IX/iDa+ab73lxvwCK7MGrUcbeYuFLw
 jDKOg+rH26G4cNWF273RyhdRn7sYqUligEzjoUKi4IZiQR+e7E4SjLMMvIqrHslNGYzhO+jUnz2
 z
X-Google-Smtp-Source: AGHT+IFrIOP2ZYY0EDK8JeDd6I5DTCsTBVvii4ox2GTBKysEmkdOo19DewDBsZJVAS3xayBq7PGvug==
X-Received: by 2002:a54:4186:0:b0:3c9:9598:c74a with SMTP id
 5614622812f47-3c997068184mr11476105b6e.32.1715622496871; 
 Mon, 13 May 2024 10:48:16 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a32e0fa401sm21966386d6.111.2024.05.13.10.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 10:48:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240506212230.2948754-1-trini@konsulko.com>
References: <20240506212230.2948754-1-trini@konsulko.com>
Subject: Re: [PATCH] doc/sphinx: Bump Jinja2 to 3.1.4
Message-Id: <171562249597.3674659.6728312247525574762.b4-ty@konsulko.com>
Date: Mon, 13 May 2024 11:48:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 06 May 2024 15:22:30 -0600, Tom Rini wrote:

> While we unlikely to have an issue with CVE-2024-22195, it is simple
> enough to bump our version of Jinja2 to receive the fix, do so.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


