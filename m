Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ED9D6DDCB
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37CF889356;
	Fri, 15 Nov 2024 05:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WlS86kM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4E1A89353; Fri, 15 Nov 2024 05:26:47 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C994089326
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so2095310a12.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731644805; x=1732249605; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GMx8tUMIV4JWMcyRjj6LKo48rzl/3sJzodNz2ZmIqWI=;
 b=WlS86kM86/FfAvcq+qoSvE1vx+mPhIL5ZLt8tDQCZ0ldsBVzv6L+ZeAxaObvsfBSW0
 g5AgBTIdU2YkFHmO/zwp7nUNcHn9PCMMMvR7NwPFDU1LLq9b/9fSoZNEjaCzcBQYW+qB
 qJKQBR/JYK8wTAoTti138GGN1oCEs3Vs0DFlcydzXez6O6yPwFh9d5CiartYoIXPHCTR
 31NEbgUsN+EqMUgL385nZ5aXntO5TzlKhwtJslO3UvokjkXm50L5BQM4VfQGp2aKyAF1
 BCuyoiwxnP3UXDqtcKrgm1g5LKtBCN+F45H0g8MFb5hAdlgM9lo+1psMlRF9WgqXABft
 3nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644805; x=1732249605;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GMx8tUMIV4JWMcyRjj6LKo48rzl/3sJzodNz2ZmIqWI=;
 b=vVfsavSu81jT7rw0Nl3p0tHrbzWHJK64MpmE6UcF5Ocp65uXOSR1bQnZQCbWyDqwav
 Eqm7ik01UFMOGwa1KF51aFa+szMIrnvRjDIvWNkrz2Djjfud3FZ3N0Iy9GX+g77nxRgG
 fnK9OfNSdyz3Fz+5o5vNDqlD+BJeQl+w/+APmXOIYDFyWPRAWjqyeoqBqseUp5E2YDK0
 laE7H6xJxQXGFTMGPVYpajraiGUv+lJQv/ZP+p/ZKAwXRMgAa2eXXnEFVbhiHF9QXA0E
 82iaPr0eNph+KLEUPnPzLmskV31+vEusYv6r2cRzCalBvU4OxLH2XTfTJd0QXLKMPMuc
 nMzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU47FOKft/ZEWJ1nGKKKoKXCyRvsGImMLPVOvynuamv5dw38e3TUpm6lDfG5/VzWAGKZOR8qXg=@lists.denx.de
X-Gm-Message-State: AOJu0YyyrNDo9Po796dGv10iiS94HTf5syYFx8Cv2xBk6s1f/OE78nu0
 ng61ZZEU4iQvMwAPtXRzUIV2JSBjwGfWBo1x3lGYifTEbO+3dk6KPbNuas8ZdU0FLGlyjIZz+Sw
 vR8aMDPlHnaIkCBsMtyBjapJULiQpq0sl
X-Google-Smtp-Source: AGHT+IGvrziUz/zcwugaXfOJ8Ht6QzE+dbIKIhSbTpmuctUquwD2K0ZMVJX/vW9YTKS50rsARDJuJBim+2x5sbT010w=
X-Received: by 2002:a05:6402:22f5:b0:5cf:255e:1919 with SMTP id
 4fb4d7f45d1cf-5cf8fce63c6mr593867a12.24.1731644805013; Thu, 14 Nov 2024
 20:26:45 -0800 (PST)
MIME-Version: 1.0
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 14 Nov 2024 20:26:33 -0800
Message-ID: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
Subject: Git commit failed with mbedtls/framework
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

I am on 2025.01-rc2, and I am trying to commit some files. The error
seems to indicate this framework directory might need some
modification. Did I miss something?

error: 'lib/mbedtls/external/mbedtls/framework' does not have a commit
checked out
fatal: updating files failed

All the best,
Tony
