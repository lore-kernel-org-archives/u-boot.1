Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7FFCD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6053384881;
	Wed,  3 Jun 2026 19:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z8B7rpKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB8C884881; Wed,  3 Jun 2026 19:05:36 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E5F7848A9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36b9b15af73so6321684a91.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506333; cv=none;
 d=google.com; s=arc-20240605;
 b=YYk7OfdI6Ii7SGQ4xhSDCV8w7gcXmxIcSFDftGnJ16c3hkocfnUQWK+jd4ZNpoOhGT
 nmtAhkBvzVCniX64owctcF5iv6y0q5UD4OP9IKwf6H7MW8LHoiP7cKCMIBUsfMyYOLEf
 Y0rIdvCO5J1xmzBM1PJ65zS9PSlDX0tFhY3oJb5esXYvS8N5mAYTxeBicolfduhsQQUc
 xJxw/pwTbQmX2ZGhoag2wAj1JeP21JjEsAKsz/zlBkQ+rkPA6DfwWjYzOWeuYs01KH6H
 esPh+w9XdclUXKMaQGK2Wi6+/lGvdbG52VizCqVIWcY2w0MqYxSkZtlPE+liqHmqhL+F
 hTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Emieq2l4rYddL7PktRi/QEcRsRCM26E7+6gELYGuLnc=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=SBAOuVcoqOJUZBX8bQyWVI9BcPcVRPKKI1x4pC3qYb0SCCIMiQTb+QSgr0cq9jwRLE
 0W//i0GOU2yaGR+RxZk070m8b9ba4SZnx0qZ1m/9wDhwZYKKl6mGEz9dOWLzL1CXS/9I
 j0NVbEyIbFqT57Knq6hXxgY04HMOOVi6qCIoFSVjKGIaTjBQ7Y9UuoCtj6fkeX5SQdIi
 hF9Xl2h3g3DYa9GR9zqLfkVXg2wF5c+v4lI30jDtSqSMz3le4nlArffDMLtkVqaps8hS
 1qChwgVU8YGx+bTRgnSCb+VclKAH2nyyCy2fwHiYfsOv/fMH4Nj4IPjNoUgsBAEuXS0C
 M+oA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780506333; x=1781111133; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Emieq2l4rYddL7PktRi/QEcRsRCM26E7+6gELYGuLnc=;
 b=Z8B7rpKE9FVRChFYHMRRH5DL43+I/rMJZw5LD6VSRifUvD7wxY0VtQxxNH4Rw+Y74h
 lABwWfhlcUxPVIp1mZAOaLNbiYetZfbbFWpcKcfqNRCiGSM5pNFaN2o/ZUX2yKkyDO9R
 ITNbLqIpG1hS7HHK+EpF/+ELsDINJZOJLgkAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780506333; x=1781111133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Emieq2l4rYddL7PktRi/QEcRsRCM26E7+6gELYGuLnc=;
 b=aS7uoD9IsDTqI1ulEaEuClTfxC4V9WiR9mvDlU+L89QwrwZnXHbuDB6zPiwHVeLcSn
 f3CQtFq628+dZXBGUKYFmJzb41Fi2xXUHsRdRJVhXnYzjj3vaTQ+ZU6iZgLLUw1tS7Rq
 LkgmaejqzmOlPPdSdO0nUFNhbFEWAmGsDw9dvITjX69QuGHJKjiJvBCZF05+aPnxJeLt
 lVY9lizW0viYlrSXTr7ktDgRFVcfOU+g6sYLIR514uwyFMMlJQWqMp7YJgMxxqo48haf
 9t4GUp0+91FJV71+ui1pYTnTNYsAS+8ONa/rNENZ+zsS0FeFFdJzuHzCoHOX3Vs1+kST
 Q1Bw==
X-Gm-Message-State: AOJu0YwMG/c/cqGkoCLbOK9g/sR2/T8suas738G4nUF7sR7S/5k6JYNf
 lFurUUJUvY0J1+vm4yz49g5bcsL0hKX9Rk/y+MOdgUXiQn6f4V5Ri1BCHJltwRP11yFZeL2G7W6
 QlYrKz14jr/nQDfD8NpzTQ24VPkGyLEb790kyCXi8
X-Gm-Gg: Acq92OFDFHTPlrzyqADAQMuqfaFKzhggJonc5jUHI3RYd4f2EgQrkmtTGZPMIUjGQ1C
 aWLeTJrFjiQmTOi4FhO/Lq9qhrq3USWXD2169nPL4IeM8HMzuRmZ/5vRUxdU0k5SbqORAZQpIlG
 lhXK//DMw9Jr9svNlJv3tl87YFeQIqQEhQLS85oo8VvkjEux7ZrggoKDEURUYLwJApuVbKjxS5T
 ylq5b6gtyx2siDBfoni0w/BZWFv95L502W/HprxDz7v7YLCzIp3JPaiX5SJcTVVMwr0+jaYZIGZ
 Wihv2AJQ3jrTBYpJ
X-Received: by 2002:a05:6a21:330e:b0:3b4:931c:3c7c with SMTP id
 adf61e73a8af0-3b4979857f8mr5195807637.44.1780506333110; Wed, 03 Jun 2026
 10:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-5-dmukhin@ford.com>
In-Reply-To: <20260603070743.1268544-5-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 11:04:53 -0600
X-Gm-Features: AVHnY4LZh215GQQ5zFP6OkVslrVMthoV56TRkjVNtTzNFD0cPkmNRyKWyAhjecA
Message-ID: <CAFLszTjtfKo2+B5VxZ=LwkSH016CnLr_p3oxk95p+8bcarAcbg@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] reset: x86: Use cpu_hlt() in
 pch_sysreset_power_off()
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

On 2026-06-03T07:07:36, None <dmukhin@ford.com> wrote:
> reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
>
> Use cpu_hlt() instead of open-coded 'hlt' in pch_sysreset_power_off().
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/sysreset/sysreset_x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
