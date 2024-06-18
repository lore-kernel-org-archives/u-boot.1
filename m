Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E951FC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 18:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD7E8883DE;
	Tue, 18 Jun 2024 20:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KVh3I2um";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46C0883D2; Tue, 18 Jun 2024 20:57:55 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5569988363
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d23a0a32afso3137515b6e.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718737072; x=1719341872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwl8iX+ggXBXe7mdDYRC/wSxgQ2VDfzBsTxIDHP3aFc=;
 b=KVh3I2umzqhSB1wOWJ3+BFlprguFWd5P5WL46h38SvwbFlSMirnO5dU2lEsafAeVqh
 OjSVv8sfcSVXjNELwPNNbbKleEXe5xPk99jQzsSMEcZFVy/GMemOo9h+QPTjH//hgLaT
 1geEMd9ajFUo9HP66zErfomviJr5P8kvmQ97I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718737072; x=1719341872;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwl8iX+ggXBXe7mdDYRC/wSxgQ2VDfzBsTxIDHP3aFc=;
 b=CmgS8+wmwJ+2j3BQhyD8RB8CWENZHJWdNdV391/4xJ9Xfoy+XS1/yAhbAxSkhduiD6
 qKKet4bwa8HJlY4qTIwm4OMN3SY7WVZiZxkA+q4kgloMZNQe1b0N5VgxLeJVgMHiOSfz
 CuTmZtcjBK8tiFDVFKDk9iiQWArY9U5eYojnz3K2tfpkoMbdyHkv73pWCmhFrnqZJkR7
 348pRjCcrWr5m7xh9dIA0/nmcSTt6PSEf3dkBYjn3byjoEuz8wIHg86G079Y+lZuizSy
 e2PNXPQuB/Am2/qVMAURCUyou5mSaf2kiyiMMLq8pj+eYi7vi9XQt2NmbG7ozCSTkf2P
 NGEA==
X-Gm-Message-State: AOJu0YwvHFWZVPwQE8gVrLtcMWe5eV7ijrvhB/rjI1En3IrKBqmHaPeQ
 FM94x7Z9TCJcVF//POPtJi4rkarhzZDHIOawBhaCASvcOM1m3nPmH4a0s24M8LQ=
X-Google-Smtp-Source: AGHT+IGVJzaPdoesrPD8PJVcWfV9Ld5j3m9Yr3gVxNrQ2ot0wK6TKs/WM8L6bkDIsbKcd6JEC+iFFg==
X-Received: by 2002:a05:6808:221a:b0:3d2:4684:e50 with SMTP id
 5614622812f47-3d51b989417mr821341b6e.7.1718737072217; 
 Tue, 18 Jun 2024 11:57:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476e31cbsm1875120b6e.50.2024.06.18.11.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 11:57:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240614155118.2606211-1-j-humphreys@ti.com>
References: <20240614155118.2606211-1-j-humphreys@ti.com>
Subject: Re: [PATCH v2] configs: j784s4: Enable RTC emulation
Message-Id: <171873707121.3326390.14585374541176345095.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 12:57:51 -0600
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

On Fri, 14 Jun 2024 10:51:18 -0500, Jonathan Humphreys wrote:

> Enable RTC emulation for System Ready IR tests.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


