Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE479105F7AF
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B27584372;
	Fri, 13 Mar 2026 16:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pdyf/zod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81DFF84307; Fri, 13 Mar 2026 16:00:17 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BDE08430F
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-67bb5e4d06eso823529eaf.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773414014; x=1774018814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xAJbxT1W8/HFyI60D6KvcnReB20ZIkBLazq2rbfb49s=;
 b=Pdyf/zod6hTgybK7SNq9SdrctCfka40ThEkLqskToER00NXIYFz70b9Qzhho1SLJUA
 duDVHGg5PbKgGx3k8FYy72MQdDPgdNLddDHEXrNePKqKu9Q7heJjkT7Waogp4nL5Of8s
 LAtLUdjy1aLsuB+h1Z1znlt69C5tabbOs1aks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773414014; x=1774018814;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xAJbxT1W8/HFyI60D6KvcnReB20ZIkBLazq2rbfb49s=;
 b=sP1GAwutAH0HTkJDRqOo24Jg4455ys0nvyzZaQprwBC1dyB0idZvG5MWUoO2d9aJLx
 2kFpm8A4AG3ASwCBNnmD3683ZRCcIcvoUa3RcDDWFVrD9N4e7x86E7DKlTzozbAajsYK
 VthvhIS7hGxkQbPP2NnQoTx9VCCY+EtH6g7jYxIu6ih5JT5CijTLDHlQPS+Obiya12jP
 KxsW2be6Cp7R1/84JpUniBGU7biknJfqQKi3OpJC3eUw+jV88jFb8LXGezfqVMDlbdaA
 5HN5Hm5KjY4oSPX8MrP7SRdT/pkDzTx+14RVLfqoFnF4VGb+TXQ++JLMJm4u/LKdReHY
 I5ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLVJuWAmBdNuWoOqDtSQHx8JHHRr2f9ePMv5jwFiW9vu8r5SDx1QdcDngq2cFMCf4Ptyp9784=@lists.denx.de
X-Gm-Message-State: AOJu0Ywro/QkOwKqXjVVfVnWMwQgErTMu9jM8oUFc82aLoHyE34BG4mp
 p8dvdzKiQ0CVuSAhKGCzOTawZIkIqdv58YMOZ7FJklFwqE6O3fEt8LdFUpusXARbMR3JgczT+Km
 BtDzzleA=
X-Gm-Gg: ATEYQzynrAQSpcuhchuDY4Fh3I8vH8o0ZP5U6Usxr6d1aLYqjUU3SO3vzNyQofN7WxO
 Yw+46kpNQlCtDxKad9R8hGJFiAf3KeJ7y1qoDMuKXXillKvRhIYNu21mm12qTDkrbS/h2gy1IgA
 Weo836D60d4VopgSEuAJPb0crJacxpgG4dITrItnx5j5dLUxwD8CtSmiCHDgCZdU0SNFzJ1943g
 0/SjA45/nRHb0Px1gmbWV2+EmLZLWaYV4g4wo3DodX7Vl+xdI+46QfBHQWLRQ40zHc7mDRauIa9
 lS5eh8PXrfWjthQD27yKGjxXYRF94+yPOE84RKuSMBtCswh2giHrMBk6aylwvAJP0umLdb6qt8D
 nd5k1Q5lSvzMfksqm4mJv/9AHqg3FjexJqSZ+qBK86DaXjXbw/6SYxo4u+b7+Vx4pYhlp8zj62N
 J4ZOAfxI4/SkWPufHqpc/cw7vFhVJYCTxDHJu8B7egxN5pN3PRT3kUZdFPY64sOYzZPOevMtkSf
 R4SABLy0chvr67+wcWLeBufJnUIhrXrDCaGZMqOKxnUyZI=
X-Received: by 2002:a05:6820:995:b0:679:dc78:3ca4 with SMTP id
 006d021491bc7-67bda9e1a25mr1941076eaf.31.1773414013902; 
 Fri, 13 Mar 2026 08:00:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e69c79dsm7699563fac.15.2026.03.13.08.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 08:00:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <CALeDE9MMW0L1xyWFW6Qdh+_XeVKrEK_1a2ju02E7=wy-YcCBtg@mail.gmail.com>
References: <CALeDE9MMW0L1xyWFW6Qdh+_XeVKrEK_1a2ju02E7=wy-YcCBtg@mail.gmail.com>
Subject: Re: Pull request: rpi-2026.04
Message-Id: <177341401269.1035624.16270047628763268796.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 09:00:12 -0600
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

On Thu, 12 Mar 2026 15:25:45 +0000, Peter Robinson wrote:

> Please pull the updates for the Raspberry Pi.
> 
> Updates for RPi for 2026.04-rc4:
> 
> - board/raspberrypi: add bcm2712d0-rpi-5-b for Raspberry Pi 5
> - board/raspberrypi: add multi-FDT support
> - rpi: pass the Video Core logs DT parameter through
> - pinctrl: bcm283x: Fix GPIO pull state register values for BCM2711
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


