Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F0FCD4F25
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 17:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 970C883E81;
	Tue, 12 May 2026 19:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q/AnGL2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A978341A; Tue, 12 May 2026 19:47:51 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7225A83E81
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kavita.mnnit@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6967fd0416bso3090160eaf.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778608068; cv=none;
 d=google.com; s=arc-20240605;
 b=Z2QX/2ss5Kp7EJArmwK9mI54AO8zxeob8fbUbb0d5tIuKgPnzomCv5kEwTYQMbZsgs
 QwPa1YD3g8O2pV3yCCZXuVwT2kppssrJtpun8wcMf6jq8ddcRBkRFTzWqLu4zOvThPip
 LaPfHTTXXR3PK6fgteoxef8VmjJY/TZdnAquSUcIuYYsmVBOxXSX2AdIuwgKGvFd5y52
 /th2rxoM3bUNjMLQLVyk6+HN2LlJM5UCiW0m0FEGktwSQqm1QXJSNmEPyAn1eEfwSm/I
 zBHSJIF58t/u8O0cK3cVqk/SjhZBdkgRkGIBi7pgd+bPrswaeQwh7bS7aahBLRDoNpji
 G3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=biMiSnfzD/8j5k64KFRdfRhBUKCslVnQL+phLw/Y0lA=;
 fh=NyT082mUonDPeH6Iqd6JdnkoAvSYURP6hLNuxsG7VpE=;
 b=d+CFbOCZWQ50nEMGPUUsiGz2ack/sAPq7QbI6sX97J3hR/ZP43TlrnyrI5qeTsQ437
 lH+N7YmR0fDpTEkrK+YhQKwQamQZ4cbVe18/VAT0eAx3hG282a/WWS60QkLBRSagkOPx
 qmzcGZWXFRqXgYURiGIHJ5vIst2PqI5tpkCiaRjeQBjW6tJd0jr+iTpYVysBykANqt31
 XPUmvnVBuSm0+/wLQ+vuJ9TyG+SE2KatPqj4/Nkw1h+jwggUuIQnVZ+4dNmZUgLDkcYZ
 5kTe6EWhJ7X5TYAQEnPNh3skDscKT2cfFUXuA0y1/JSKHPm87styoH7q4YsRMFl6i3Sm
 1SMQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778608068; x=1779212868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=biMiSnfzD/8j5k64KFRdfRhBUKCslVnQL+phLw/Y0lA=;
 b=q/AnGL2IhV2aGUc10nWBZGQ92jAu5mn33DHETAqopCzGJRWLllOWH/Af0vmtOUEZdA
 yoxDo6IgGSdNd4liC75Ps2DlD1a0tsyvM/874J3ZlcxuI7qVMIBUOdK342dcHeFZKOpI
 o7VTmNa+ds0yEU9mTUMWeTU5CrA5vT4zu6VSCHgSOrg67Rgul9S0JODpxHcXom/ouDUr
 9dPe1pJR2PxgWWcSDAXOCvwJpx2zovgtJgrNsiSjqXNiMXg6nPbqh/CQy5VohCOolYag
 OghRxahEnhSdAFQoqUJRhUpkVnZoJ3DkTxUSEMPAnmRSY+9/mL+dA4BLwvyIWIGFwzn1
 sP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778608068; x=1779212868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=biMiSnfzD/8j5k64KFRdfRhBUKCslVnQL+phLw/Y0lA=;
 b=mW11a8kxZ2BXgAHWAKgC2g2OdXG0f2QUg+4OC5AX54adkjwce3JZzBlCZ2QGkfJMS8
 MehK2Xv7/PPPqtFPGP8LC5hy+UgCx/BO62Orq6KatDe5WtL9EpNlPGOJTGuzMyMLROaY
 qURqWqsa6SxkzuSJ+2YjIcHiPXBe0B51Zy7GDf5luU+aowjUUfhclmJeqgXT99QOyEPq
 j15yH7G20UxAvzldOdElm0wiqeZS0osUqtONePpuY7AaYAtyR3/BVz2lCwfNS8ugZ9zo
 drOAnEpKLK58bfZgdDHLc/LT9qh+tnFhw+zlvbdCneLA1zMsdGm988wYQN8PxwGQdz37
 JyNg==
X-Gm-Message-State: AOJu0Yxu7LzK/ve+GViNRcL5lMyWFC4UcHbPwmzeZ68V34IY8NG2km10
 IFRI/0HSxXebNZ1/dprLvO5uRK2IjaYjy16gAgkq27pjSgHopYrcJeGeAeySVMCYy9aIdkVuzkS
 aRe9sNTZf9QMo3YwOsBwqZMFjPTQkqLGVFErA
X-Gm-Gg: Acq92OFVzICPv/508B+SHvI92jJ9BYWoXVHoQIQsPdZzxGfpwTL3wF/4tWbhgMlZU/y
 dq/PXdw/nUhNvjycJMHpqjIdSsBn9x2lzwAGL+4Qhd5ye5bu1UnC0YpTGanWd+UhKxbITTbTOma
 QlfcLf7i4Q6pzcmLXEkwVdvrBUVu0fdkZxnRgrNm+bFb+4RUMDTJ6RmMPRFfUZKM5mKeDn900gp
 NlQQ0CzHerKjYz71sKlP2OC33ALmII/TUXH+i0I0PA1q7BrZYfCPnJxKzlg8sd7Y8IgeVENQPzI
 Kd+40RLoKHIep1ZmYfZ3jvsLCBhkBakLGdIynni7xiSWs5/+ZQ==
X-Received: by 2002:a05:6820:1c86:b0:694:8f3a:3f3d with SMTP id
 006d021491bc7-69998cfdf79mr16007550eaf.35.1778608067964; Tue, 12 May 2026
 10:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAP3gb7avhnVqkBAMg-2f5GXZ_7u9rU+Dm2UoNhYHKdvBj64Vvw@mail.gmail.com>
In-Reply-To: <CAP3gb7avhnVqkBAMg-2f5GXZ_7u9rU+Dm2UoNhYHKdvBj64Vvw@mail.gmail.com>
From: Kavita Awasthi <kavita.mnnit@gmail.com>
Date: Tue, 12 May 2026 13:47:37 -0400
X-Gm-Features: AVHnY4L-LKmK7MpaFcRPqD-wGz7XVVmlaVT2r99t6NlqwtiW-NG9680DtpddRLo
Message-ID: <CAP3gb7auCsWCM0MSNGDqGzpCK+-kUDwjYqdt8+5ApT-vt72=2A@mail.gmail.com>
Subject: Fwd: USB3.1 detection Failure on u-boot
To: u-boot@lists.denx.de
Cc: u-boot-request@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear community,



I am struggling to find a solution for USB3.1 Sandisk key detection on
u-boot. I am getting following error Bus usb@32e40000: USB EHCI 1.00

scanning bus usb@32e40000 for devices... EHCI timed out on TD -
token=3D0x80008d80



      USB device not accepting new address (error=3D80000000)

1 USB Device(s) found

0 Storage Device(s) found



I have tried a lot of solutions, retrying this step, increasing delay but
nothing worked out well. I am seeking help to fix this issue.

Here is the link to USB key:
https://www.amazon.ca/SanDisk-Ultra-Drive-Type-C-Flash/dp/B07YYJ63VF/ref=3D=
asc_df_B07YYJ63VF?mcid=3Df22780ab44ce3a3baad4b52ec9169584&tag=3Dgoogleshopc=
0c-20&linkCode=3Ddf0&hvadid=3D706724917347&hvpos=3D&hvnetw=3Dg&hvrand=3D160=
19694204985405935&hvpone=3D&hvptwo=3D&hvqmt=3D&hvdev=3Dc&hvdvcmdl=3D&hvloci=
nt=3D&hvlocphy=3D9000441&hvtargid=3Dpla-858626018619&hvocijid=3D16019694204=
985405935-B07YYJ63VF-&hvexpln=3D0&gad_source=3D1&th=3D1


Has anyone fix for this issue? or found this problem before?



Thanks,

Kavita Awasthi
