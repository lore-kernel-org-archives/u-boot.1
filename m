Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CF6C18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 15:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A068B807EE;
	Wed, 26 Feb 2025 16:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QYXPcQL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0A880805; Wed, 26 Feb 2025 16:43:04 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B5B3805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 16:43:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fcb6c42c47so10785501a91.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740584581; x=1741189381; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AVu/fmcbzp0mreH1T3Uak1Wex0ftXDQbk0n2Lloc/fw=;
 b=QYXPcQL+Pg/mxulQTGYLTLYrooOmChtETBDkv3AuknqReh0H/5jMq/EKOvOZk9OWtG
 C8UaoZaKeyTp73iRbNZflNCyf1GimyBxUSGsJnzXrSSPLdCNyBj8H8P2QRufrUlaTI+Y
 MY2ObFmM4VlsGAuF1SXDx60IIAgipVju/y08zeZokxz9nSW5wWLLceILVrxcabA7oKtE
 zVmHUAG79RyhvtkOjW4HA7WVYX2Xl/IKvQsUN9X4sQNum/6BTnqZzIgJlu6FlNOOEF5A
 4F+/fDwo4UhiMXQIsoiWK6CLN3apd8VtMvLjKe7CwRMxm/n/X5SKEpDgSUKzvSgO5kqO
 63Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740584581; x=1741189381;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AVu/fmcbzp0mreH1T3Uak1Wex0ftXDQbk0n2Lloc/fw=;
 b=od2MEC2IAK9aA9pN0oQWPzbgcxLDt1MsXbgcs+yBfvsCxym3IKup5njwBxsKzGujeb
 Kljfr7t0L6rMzCFRqFuoGlUtlAxR8FfiSa2iCTCdclU+Ya8cDTKXXF4Q8CHH6H72YuFD
 hSv6DIW7rIO7ATNHw9rVEgKVKylB+yATlzJ+8Ku0XlYY8DLOs6z+dPF93M3YlDvVXCNP
 4s4m3/1AZrziR4yFzKy06zz5yeNGmi66ky362GPXmch+FqWCyW6yg6ZkNBec/TbBYMdT
 6XEm/Ipa3GLXJeFqShH4MHGiCp9+4R3+uv0Vj9m5ubfJg6n6MdooIV2/zsNonhOIkl5W
 krxA==
X-Gm-Message-State: AOJu0YyJepRnyt7zWmYZpz9UuBevrjyD2y/WKGE/vzy9b4qRt3cAmq/F
 hBhfH9gM0YbC5MXs5EemlKBLk+DRBa2KvTOUZZo6zhOda7lkguAQh8UBI13lugjmosVkwOwrgoF
 8FLbhoQPFvtMrk/BeE6nAbBFbQn52nXvH
X-Gm-Gg: ASbGncvbWLwGgip6ZcBQFVmzW2LoZr0+Uysnzl+pDsNOsXdQxJi7ZZjrP7nknnPxU76
 zp8kr7hGSMGCGGQN8nlEOB907+T47G8NJgWTrTou1BjmNEs1esifTa8+2OL0aGnNJmk34DBRHZz
 DGS+Ox
X-Google-Smtp-Source: AGHT+IFSlrawgtSK86g4jUNuwbVpobdAbrrY4O3Mqa352h/KJD8/ACfVukEvib7gwBgPLB134FZDRY2zfz6dBn1GGTI=
X-Received: by 2002:a17:90b:5407:b0:2ee:c91a:ad05 with SMTP id
 98e67ed59e1d1-2fe68ac9087mr11144822a91.3.1740584580818; Wed, 26 Feb 2025
 07:43:00 -0800 (PST)
MIME-Version: 1.0
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Wed, 26 Feb 2025 18:42:49 +0300
X-Gm-Features: AWEUYZkqVpAQH_obGy9F4pEqHwyP7mZjfioxvUXxmfLfRGWsalv_u1KP7rYQ30Y
Message-ID: <CAJs94EbWwOTyX+8L8cgeUi=O9NaBfwyO4DKiaG_megYr-+5mPg@mail.gmail.com>
Subject: Watchdog behavior
To: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

I need help with the watchdog. Unfortunately, the in-tree
documentation is sparse on this topic. Currently, I am continuing
hacking an Allwinner based board and my workflow is the following:
u-boot runs EFI grub2 which loads Linux. u-boot starts hardware
watchdog with timeout of 16 sec and everything works well until the
Linux kernel exits EFI services. The board is rebooted shortly after
this message. I've completely disabled the watchdog in u-boot
configuration and checked that the Linux boots fine, so it means that
the watchdog is not disabled at EFI services exit now and not handled
by the Linux kernel as well.

My question is how it is supposed to work by design? What is the
correct workflow here? Should the timeout be sufficiently large or
should the watchdog be disabled just before switching to OS?

-- 
With best regards,
Matwey V. Kornilov
