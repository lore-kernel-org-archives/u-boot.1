Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F132ECD4F21
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 01:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 716A380F0E;
	Thu, 14 May 2026 03:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lywboI4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563CD83E81; Thu, 14 May 2026 03:51:19 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A3B080086
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 03:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dbec19732eso6829077a34.3
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 18:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778723474; cv=none;
 d=google.com; s=arc-20240605;
 b=kZuxa6c63hbYPT4iWgMUICPFaW/xANWg2HbXc+Pi+pr4LMbQj3M+zmntQ8EE1V2Z44
 Q87PVjE9D+sE2VIwEejA41u+s6WZ90r/ZyepOUT2+xlxZvxUwvqSAnpMWsPRSVAMsHno
 8WgMNhZ6Wn0uYHSQTAHa36VZgjQhCsdoyO4lrCLmkqhuScY6WHyCdRE35oD5cFhshpGT
 PTGTi9mH5yZHH4Uc0hhzS6tIfH+yDVhhtc7xqIsIPbFqkdpK/twRx1UOfHIMy6Ccf5Qh
 9PY//9x+j/y57LWBPrDWFGUpR45CgerkNtW8Zi19rDiGW5Fpq7JQvDgt47WLkC0byO6+
 vpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=6BdacviTWIryEoR2UyAHJdi80CL4fko8u1MhZeoeKCs=;
 fh=4yc93iyPqDP7BkfqJbnNzAyENSh4YnI9oOE4MBhXVwM=;
 b=SUEcnEjmiFHJN7XRM/VtC/DH5v+kIFGW0k5NFG2wnBardeC0DDOnnsi4APrMgFWufh
 Vg5YWSc3hU2UxsJ577ABGSztDR80f70AwmhzwYvYU1xG9732n6u2cMTJF8yYc4Vvfd4Y
 rNXAO1LjTvSdo1uFjfI6oLCUC70OjB4sAN8HytuWohqYdL3PW/CJnb9VWFhqHqEM1TZh
 DOLhSXPPkcQ/gvsyPsxB+5NhsOSiKzSlYOu6ywuj77bJwrysYh33PoWfaFFTgsLMhPUK
 bPaL2z12/KUdE4yXCUK41IpIF+1zc0FRQ8ONr5ALDqewFVxLexz0h3sDff6wx9fbRnT5
 6iXw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778723474; x=1779328274; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6BdacviTWIryEoR2UyAHJdi80CL4fko8u1MhZeoeKCs=;
 b=lywboI4w+f//11qOanTqqX9R1eTSpJ6PazbdkVBLUCVYesl//MVHITybtim/BDf7x8
 dVeyPFqS+hw7JN9vQkS0xHlHNA07hXeNhDVHy6lFJmP2Lx1a5FGnEvqep7+aFxPzAQJ+
 cSpBo4HHabcymucE5scEORBhh3UpMbTamPvxJJoz5tcPRrCmMg207RwFmC1mLr1LtU4D
 J9vjMa0XUgYMTX0DHpTCCoEeO1LXIB9iW0lHoiST0gUrRMAx/sz5Ldt4GyLk30asXnDn
 opDUAPD05zPwcVBEycyDhgNxSUeFftYXGF+VpyFjdg8NH2H1D774E18YPa+uv1war8SF
 jQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778723474; x=1779328274;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6BdacviTWIryEoR2UyAHJdi80CL4fko8u1MhZeoeKCs=;
 b=ILW5EhM9uclQl/1HPE7NPIUWZfBWPa8/ci6qXxb+665OMLk0wV1tsaGWb9NUSdAD1w
 5YibSUP4ay9migmTq7bz/Prk8s5cGHadMKARxQT5hbdvKYXl31NTfhTnl3c4BL15NLDn
 8+qO684G4UvWCviTM/mHa+j2loB8d+MJmsy8szxYmXqcgF09SP2rRZV6nRruFDJ2BAmA
 tUeNGZ79GnIrwoXZOVOGry/dVEWYnNfBrx4dE8VIhpxvsLHDToAwW2ArHOLjm5YMszWi
 GDDxiwfQNRFY9ZnbmboAGW3b6nWvLzLovk2VIbwpDbu4kSMPkrQkKQ/kOHug5XuYrT5y
 lf2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tlD/Fy+0gUI7+srfBVWQnaXT9RQ9EA/wjf/ZAvi42RXN7hHdom/slA7VuQWoPC6dnPQF6gVE=@lists.denx.de
X-Gm-Message-State: AOJu0YzsyKNaLElTdIQyZodIbffj/ndMW4C5Ms9bORKeWITUaUdDP4jx
 0JLGo7R8vntgYFquifPiS6ks+/NrPNSXMZ3EGh9pRvtccSuYHfFakJjLMDQ/NqOsm3dmgvYawY/
 CXcSBEHIwGsCXJwkSMHPCKkeNjED06z1zuqqTmF7R1Q==
X-Gm-Gg: Acq92OGmXCuv1Oq43wtGmSfV+NG2R/cJZYMmsOmRcbN4MuUS/QzmOGt+51uW283ezFZ
 7J4oTrryvlvQpGRXhkgLcntFbzJSElVtY5KbX3RitqeArObdbQIyyJsFftXThcRWcyBx+EcRUOP
 tG1IUuwUqRVFqnMWgF27w1LmwptNkl1F/vfL0yzCntcE6MPtTwwytRpJUeem4E78kDhLxwtVW20
 GQ0xZVGvSIcbFfI8G531YQw4kFmH0b4yVkezAqcPw6GhS+rYhA/ihfKbNh1OwvgqZebPGP+uwAt
 ZadE/F7KkA00xSwNLPI=
X-Received: by 2002:a05:6830:310d:b0:7dd:91cd:2b19 with SMTP id
 46e09a7af769-7e3dc88264bmr3441692a34.14.1778723474419; Wed, 13 May 2026
 18:51:14 -0700 (PDT)
MIME-Version: 1.0
From: Sune Brian <briansune@gmail.com>
Date: Thu, 14 May 2026 09:51:05 +0800
X-Gm-Features: AVHnY4KPdF0WaohRzk3nustP5eYGJZ0ojcM5xY5AQI9CxdnYDDk5J1eF7sH75io
Message-ID: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
Subject: U-Boot patch submit standard and requirement
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

Sorry to bother you.

I am curious that for me myself I had no issue to follow
the requirements [1] as long as all patches that are
passing the review stage do follow the rules in [1].
However based on most recent commits and reviews
most of those are not even close to what [1] mentioned.

So at the end, reviewers in U-Boot just made their own
standard and requested contributors to follow?

Rather the U-Boot itself should all follow the docs rules?

[1] https://docs.u-boot.org/en/latest/develop/sending_patches.html#sending-updated-patch-versions

Thanks,
Brian
