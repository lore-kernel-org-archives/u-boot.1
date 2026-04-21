Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36181F8FA90
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C3484337;
	Tue, 21 Apr 2026 17:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JklCfbs/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEF4783FFA; Tue, 21 Apr 2026 16:26:03 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1091F83BC4
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50fb4a7d704so5828391cf.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776781556; x=1777386356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U744R8zHaoK63i8566XE1JZFmuQ6DBRrKMnjLH9pZUg=;
 b=JklCfbs/681mUeSrcdob/QgpDLVPuX/BCeRGJsaLD2o9jo5zUy04sdbkU98rIgI8AP
 vpljabkCl3c7+m9RFEhb04ikUn5JhK1aHLn8KF1MiHpjLcwgmZJaVxAeAYCxX2fwgSo8
 M6BtcbTcuMlpJoe3W/QbdrOMSFIm49b2EHNrcsf2QtSGzJGYzTHDYc2YvFIPiuQ8IMxP
 CE3Ed58xnKeJA+Z9e/dqxztMurjSG8RwzH4S2ZEkTtmaGiBqUXW67w+fwkBbD/jJ+AOq
 T1uLFTeqLw199hVqQN97yQghAMZ14nrabX+t1ctC64H7jujCazHZP8mr4fzFI7f5IWb8
 0qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781556; x=1777386356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U744R8zHaoK63i8566XE1JZFmuQ6DBRrKMnjLH9pZUg=;
 b=Aq7WneGzY/uxv45tO+ZUbVuQI5qJE1beYLzKWrqLf/cC1u6F/XLy8rm0SFSifWZoyM
 5/5AxKDGUlYiN6En/Oh1r6aWeWqywAATVPpultHrlmHd5d4dRFIkUf3UV0OfNLi6/eFe
 nHIcZBE09uXI5AktxZmq9XStwnUCu4SfUbF2F2OVwXtGScD099a4qW7d+SYlczqmIBCu
 Ey4xIbGQIH2u99cvZ7q3NYwtOLVYRwoEIaTy076YUf266SyCrGso/2Nn41TmuVSpQt4h
 Ot/neagaa31OYqDn0hq5PvwWZazFmjtmaNW4WD0c5y/6NnEuKCGo389bJ4Y0WAKiXyyl
 o+xQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Z91O6CLpKmR1JaAb15hxV9tVyUtiTwbKGrMMx/7XWkhI/vbUpYPI+VC0/2Yw2FQWiEqguZms=@lists.denx.de
X-Gm-Message-State: AOJu0YxwFrw3gnH6CRetuZvINfNDy+4vRSu6GvSihBOQvZsTJwkCDFSJ
 HDRfAwCoJbN0nq5xgfeAae/1sY7zryhQkHpXNGTIX45FAoeWoXvrGD6iLz1i6ZRg
X-Gm-Gg: AeBDietjzVxrFCEfiuxmsS5B7eSB5xPflQ+W49r78Z7OwvayZnAO0yFcgsF6uLeY+/Y
 x0eh8soopPKLr3u42G3W1FnuIRfL6ZQlu6nOP/xZ8skQsY34zlRFwyWFzL3vzPEjVt8j5LqD+CK
 EOe+hLDHZ+eyz5iOfk0xzHrQXxpm8++TLgDb9cLC/eo/9Qoi0UaAZt7z2lFXbqJBQ1q+XRG+Jdw
 ifU9AGUzmNvyicIE74sv1y8eGdBBRWlsjMqegFAl+x7SVvf9MkXN5AvSvhytSq8AEozpqo5VT5Y
 xG/kvodHXyxxJcha6EEHz01RuZgQXisShngFsh55Y/mYmOa0tLhA1ROXJX2ZYh6YMJ3+tJxoVKO
 j5d+rsUV/DJBqZs4ephFKL1LXXPXhoDTHKUEZlmtEGAl0n73FirGa01q439lsnacbW5OZ0YWkkG
 cpCEsm+rWu2dACqF0kIK6UvRe9JwmxJhRJ4ODwynXcXnKTvk5XBaj5I0Q=
X-Received: by 2002:a05:622a:1208:b0:509:44c3:5ffa with SMTP id
 d75a77b69052e-50e36c69265mr255146621cf.52.1776781555773; 
 Tue, 21 Apr 2026 07:25:55 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e3945ae5bsm112398661cf.23.2026.04.21.07.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:25:55 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: sjg@chromium.org
Cc: caleb.ethridge@analog.com, jcethrid@gmail.com, linux@analog.com,
 malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [RESEND v4 02/14] mach-sc5xx: Remove update commands from default
 environment
Date: Tue, 21 Apr 2026 10:25:53 -0400
Message-Id: <20260421142553.4157-1-jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFLszTgLk38PdE1J6iEfqG-T3dSOJN4j8q1_7tPjngM-dAoPNQ@mail.gmail.com>
References: <CAFLszTgLk38PdE1J6iEfqG-T3dSOJN4j8q1_7tPjngM-dAoPNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 17:12:16 +0200
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

This comment is updated in the ubifs patch to remove the reference
to the jffs2file. I will also update the commit message for that patch in 
the next version as you mentioned in your reply to the ubifs patch.

Thanks,

Caleb Ethridge
