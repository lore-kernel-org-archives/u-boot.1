Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764E6FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E72984508;
	Sat, 25 Apr 2026 20:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z9+osa0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A95884440; Sat, 25 Apr 2026 19:26:01 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A17A841D7
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8a3342d301aso87019166d6.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777137958; x=1777742758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwNYL0uko9ntwPU1BulCROmnjKtyGYQITo+Uxy91DtE=;
 b=Z9+osa0TAwvuedNFPePZ+DND7vqwn64NtQTnX59KmA25gyrQN5RH6F3WhsZ6k4Pi/t
 C0sgGJRtRm3nfg0CTRRtuGzKSlm8g49NbdzILHQCWLyauK4TFOn3CCIrJ3G+N1FASSAv
 ofKgJFRkKWGtibcz56UCPr6z6qYHjKYx8a4EaEiDEei2PBo8X4DBBemD9hUmLB92/oxF
 ik8CemTWheGrADuPdY4b4gW4mVRYqrw0U9/l9ZTqjP5+TCQ4U1teClhhcjvtvXKoE9Id
 oRfXaGgi/3s0wOSE7W5GuhwCZcAHsy5C9WiSdbnepG77q22PxahxGvfTqVt7k+QPiKwV
 X0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777137958; x=1777742758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kwNYL0uko9ntwPU1BulCROmnjKtyGYQITo+Uxy91DtE=;
 b=O5Fi8NaQgL/mXtSZh93WTiPl954LfkW7JNumXIZKQM+VNZYb2iuRZrxsAbueKxnu5v
 JIIeuCEd0ziI3yJTJkIx1KoDl/Pai25tjKJXBmy0ogSwD4VF1TvwSJb53ZrHlYuKQ+b1
 IPO8FWeTXaVKG7vCwsfrG76abc14YiAKlTq3D9/uMqBAiyYkQJcvpdFLcNxBO1+5qVXG
 lepIw3kuxPJvLnbnyS2C5Xpjrk2oG+EueiyneS33IbrZ197SR/LgvUfbCPoF6+90BFGi
 dm/IhgFRV+FJ4JO76aQdugQZmDEvhJieKZCAz5SKfPS/c0AEyYvyWEkXGjukQnA/JsBl
 /Gcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fddnQZ+DttHYaAFiPhbqRHyf53Hk6AXkvFerofrZUna8HlaXp7nhZ3WrT8ctl92ZGRy/EO/U=@lists.denx.de
X-Gm-Message-State: AOJu0Yzm0f5muO+1sZgkHWj54EpzcbzAH2OlBvru07agU5++5OF7XHEN
 naGzzGDnDMJor+M5w9+jucpMI4LkDAY+Cy8m/p33DU9oJaBgWVtzq3atbcnQTnXH
X-Gm-Gg: AeBDietYNnf74qgXdpDqrN/5RN84ToZXjX92vVHNfoQ3c/AucgElt78DLvaScb+8yBs
 KaBY0VexYj/Ww0CQUQLdY4gVXUMVXKBhW/GGNnPMw9IfmVAoM3TVRBftF+bIeafF32qJeXytfLW
 jH8PtYWpk8ByPuYj8BcgQZ0oYvzU6ANoqYZLTstQLQW1IDU3goTUIGcrvcUqDYqty8DicNNmALq
 NgFQvCwIJQbe/7heMAS1u+5NSEIOeEaQlWDBkVe9A/R9Ah6vnpL52p1bXx26yQUX6+rbpLqq47L
 yNMaHRiSOyD5bbxaZ5kRRAaGRkQdofJBgMfgyLOPQf08BEW7pr9zEJhMestm1kph3hAGQ+YOfkD
 vessMlzxcEas6trrYyjLWIIXRVn6Q7CJP4SrPzHRLu2vfCzp900zQGq1kRQ3iCERsIwdkn8bUT7
 0nqMWTjdxv1wnMDwhlz0euOTXazLUQpw0OEoDyOS0TO4du
X-Received: by 2002:a05:622a:130b:b0:50e:6313:6e13 with SMTP id
 d75a77b69052e-50e63136f8fmr243184441cf.5.1776954484840; 
 Thu, 23 Apr 2026 07:28:04 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394c1fddsm168672631cf.30.2026.04.23.07.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:28:04 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: sjg@chromium.org
Cc: caleb.ethridge@analog.com, jcethrid@gmail.com, linux@analog.com,
 malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [RESEND v4 09/14] mach-sc5xx: Update image load address
Date: Thu, 23 Apr 2026 10:28:01 -0400
Message-Id: <20260423142801.27432-1-jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFLszTjeZgWvTeBPoV9d2fgFzMXL_P9eFNJ+ws2NWT25PB8OCw@mail.gmail.com>
References: <CAFLszTjeZgWvTeBPoV9d2fgFzMXL_P9eFNJ+ws2NWT25PB8OCw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

I have decided to keep the commit message as is, since with the coming booti
support the image at this address may not always be a fitImage, though all images
will be stored in the SPI flash at the same address. 

Thanks,

Caleb Ethridge
