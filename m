Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3861CCD98EC
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4912E84869;
	Tue, 16 Jun 2026 16:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RhY1wUDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AB81848C5; Tue, 16 Jun 2026 16:53:34 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F46B84869
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-69e7dfcea4dso3091875eaf.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781621611; x=1782226411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZPxNJ8nYjo8rGlVAAXM0+7Bt/HE8Xdsn9ESJBwsNYg=;
 b=RhY1wUDqfC4EO4xwA+USg+cgt7g36sWkUbl+To4pm2aKIMWK4wfD/xrckkDUBkqb3K
 suCKyEy2BuTpUVzK2rd7J/KRnm5INyC0PhUV7yjExuTN6TSIA9BUS+4ssCTEoDRQUyZJ
 lHSKNa1s3DWMef6v7vwGWUCTbeCNSAyaz6M94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781621611; x=1782226411;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BZPxNJ8nYjo8rGlVAAXM0+7Bt/HE8Xdsn9ESJBwsNYg=;
 b=LGs2thGVUDrHgNSq4YXf3HWiOcgsf2BtfcGaF2VXb3Fq+Vy9nJGB5bhaiEWQ14vlWQ
 YhjovU7PqEuE+Ky1DUiIdrZl63eC9wrj6V2QIcfED3GWQ03nZbDYXdWVGtslilatvjyY
 YcEhP8Dj/1UgQQZpKTG/Nr/NDwUezj7rRCMd1/civV4PMF/pnuU888XtJnQEo77oNB5n
 gSEEfz3Bu0IbaiSbJ/m+KLReNmLiaq/3FIj5hZaUZE/BCOK1Vw11144llEWAY2Eh2bBO
 3ZwfBl9UhV2nxqKcJzPUfKt9FNV0peDE+5XwglzM+/WTNFt0hQSEY0nWI0qG6+g9OcS6
 8znQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gHHFGcSDRjLQAfVPXT0xbv98O/zYZeGrm3bXD9c/XfCnppTU7qXV6kgCfoF71BYw4ccCa9fI=@lists.denx.de
X-Gm-Message-State: AOJu0YwHEKinJ9bYk+sWPMw9HxPG6eSwx0Q4yR3Uxju0Ik31MvoGlWnj
 N4rlik15eSClfhKwinfsL8iF1bTEUIdPy7jHU1yLAt8QnHirndjn743rELXCan6qwKz8XrAL2KP
 yDe3trSM=
X-Gm-Gg: Acq92OFWbwOqTdZsnElRb0YzlwBkonvAaxULLSSyUQVc3sH8vxoGTsqysh2EjWQvLTi
 jKodzKo9TONRScGoR/nzWxHwbi9hWWo10hpLR/HKa3F4S++wms0GhV1tPhJwmi5/YMGywtbMksQ
 NfGrJJ3VNIPTIHJxGaCtYyCWh3LPpqVrrZ5ALIkBbzYLWV9BcTHFYNuXDGvRb0q5vmYB3zAkVqc
 J10Fh0adYbzxmvzl2PVwkjsRFrUCCdnE2/OHu0mc7Es9xYFs8ShWX/AM5AWSIWUPnF8eHe5GGpx
 72Mg4pb/o8HKXiV8KyhVX3g8FN+r9Rl4LU2t2alwYTCh2XftvKk3I7A9OmXvsMIMzQbF2+uxPwW
 2wcsP06mfEBJFZ2SqFjsrGIIjniz1jBd3dMqKHz3zIzOCT3FCIygFKQVd9qNV4YUWTXqT3WyKsT
 wzY1J50MAcjUKh298ZcWhd3QPRMGVvV5BNSwLlRUgQd/6LZnUOLJdgXj6rty37VH8LG4imdUcjX
 /mzaSF8wNr6FpwyMmCZxSWCmgUsSSHdocYfkjdLxynatCa56w==
X-Received: by 2002:a4a:edca:0:b0:69e:9af9:ab3f with SMTP id
 006d021491bc7-6a0a3fd48c3mr1972438eaf.22.1781621610995; 
 Tue, 16 Jun 2026 07:53:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69f00edacdasm4966357eaf.11.2026.06.16.07.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:53:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de, 
 kever.yang@rock-chips.com, jonas@kwiboo.se
In-Reply-To: <20260613172444.4023442-1-heiko@sntech.de>
References: <20260613172444.4023442-1-heiko@sntech.de>
Subject: Re: [PATCH] lmb: Add the Rockchip architecture as requiring DMA
 below 4G
Message-Id: <178162161010.1615775.17472154153061374221.b4-ty@konsulko.com>
Date: Tue, 16 Jun 2026 08:53:30 -0600
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

On Sat, 13 Jun 2026 19:24:44 +0200, Heiko Stuebner wrote:

> Loading EFI parts like a Debian-Installer on Rockchip SoCs creates
> interesting results, in that on some boards the Grub bootloader can't
> find any partitions on a USB-Stick, or loading a kernel from Grub spews
>     EHCI fail timeout STS_IAA set
> messages before failing and on others the loading something like efivars
> from an eMMC creates read errors and making the MMC vanish from U-Boot.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] lmb: Add the Rockchip architecture as requiring DMA below 4G
      commit: 8b154abd31e499d7e90d125d36d997c75daa6b05
-- 
Tom


