Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D69FC021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 19:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C43C080C8F;
	Wed, 12 Feb 2025 20:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z2NXjGmM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B4A480C69; Wed, 12 Feb 2025 16:46:32 +0100 (CET)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 185D3809D0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 16:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathanbaror@gmail.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5203e42d3a2so2173693e0c.2
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 07:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739375188; x=1739979988; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BKRx6rA6j8Lll2ToKch4l26Y6wZ1aehzxdgKxHRJqkM=;
 b=Z2NXjGmMnekM2AArLff+bYiE02pQdDMFKTi2JdIEU5U4Wer+oHID4ZNrMeSdChCnM7
 VJ4nmi153mSvj9aAXUrEEUmtlsEMXTnmOxLktgDLJDJvwvNSgEpO9nYwbr8BOZxC7oOf
 gBSFUeJbkWaTA2/iSEAaFv3qL/k2/I2+7BNF6kVnRmRPBSm3p8hGGn4GFt1mwb/NjrsE
 mLiKEcWEhLbWWcafjmxKKQfyd1g3Y6cGYJpu05aeKQ20hKmIVhQ2qqqsWGz8Hg/w9q++
 twD8CP5TSJcUKf0Vs6d+pKitEBUE2vBEZJKCJrPSO8WTL26Nq2JrZSPfuC2q6uqMiHS5
 EKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375188; x=1739979988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BKRx6rA6j8Lll2ToKch4l26Y6wZ1aehzxdgKxHRJqkM=;
 b=HHdjBRkUbiP3viOFovZfMhhzinUVO+v6a11fPRBzupvPss+u/Mu7+64jiyDEXe3ytS
 NtC/+yhoOtn7P8kMI10kVwLrl6vYuQT+jVV+rvD9ZNGmECsK/p0E1QsYoVVbUhXox9jZ
 Fm2Wq/FogzmmMZPno1ABcO7h/oFAUWITQB4yrPU0eH00E9TGFBFH8DqharKNeJaFbi3V
 NrGc2LynAyMdnEnxcEbzAqAg05zR37P9qWRl2VB14eO6lAmorK9J5lkDH7C29cJBuf/T
 RgYrcW5Nm3X/Ocgqo1n9UG+BdcVWXTZnTgEPr4al8q+rOav3tADcGzN+c0ILqmpSlBzv
 CXZA==
X-Gm-Message-State: AOJu0Yyr+//V7jljLbGx9aXMSFwc/mVTrvJcV0rFXYVppyRte0/az6j5
 QOhtuibwb93J0vcmSXYG8v3OKQFsM5dzeZ2jlXHWMnjTYWHH5S2TlhhDWljefnlxC2g/X4TJjwM
 JNkbmaNyYRmTle9dT1V58glGZUXU=
X-Gm-Gg: ASbGncuO9kUQIk/FltcQdOFfak98ljHexK5yFJwUGeeHasgep41E9qLJ3YzzJpDFZ04
 mIsoDvSJlBKeHbL5E9hz0yfY5YOG4B//0fOU04uZF63rE3vriI2Skvl6YiNTEhK51bFttUaGk5/
 acuhn+hyv7E5JvnSkLoFOeOLAVn1zm
X-Google-Smtp-Source: AGHT+IFUXaj7pTxF+MMgx2A3vgbdnaaqDBZCKi1lpvLbMUVAg6VzSFiet0KiSGrIxW7sDjggSm+oP6QQxJUntUpYnuM=
X-Received: by 2002:a05:6122:658b:b0:520:42d3:91ca with SMTP id
 71dfb90a1353d-52067b20b17mr3010344e0c.1.1739375188096; Wed, 12 Feb 2025
 07:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20250212093057.3975104-1-hsiangkao@linux.alibaba.com>
 <CABMsoEFTGzKhFn7eB0cjg2peCd_DubF-X6Rpq2+1cRVm_J0Q0g@mail.gmail.com>
 <e16c4550-2a42-40d9-a57a-9be488f89381@linux.alibaba.com>
In-Reply-To: <e16c4550-2a42-40d9-a57a-9be488f89381@linux.alibaba.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Wed, 12 Feb 2025 07:46:16 -0800
X-Gm-Features: AWEUYZkYSt-qan01dEQcZ8ZySJsluC3srYsglELxaBdiBlDAXSsTROq9M9DPYKs
Message-ID: <CABMsoEE1mi2RaUgNU7Q-DxbmMZ-i2hWODJrX1NfxyNKDRv517w@mail.gmail.com>
Subject: Re: [PATCH] fs/erofs: fix an integer overflow in symlink resolution
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 linux-erofs@lists.ozlabs.org
X-Mailman-Approved-At: Wed, 12 Feb 2025 20:08:29 +0100
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

Got it, looks good.

Jonathan

On Wed, Feb 12, 2025, 7:33=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.co=
m> wrote:

>
>
> On 2025/2/12 22:17, Jonathan Bar Or wrote:
> > This is good, but may I suggest using __builtin_add_overflow instead?
>
> They are just the same.
>
> erofs-utils follows the kernel style, mostly the kernel doesn't
> directly use __builtin_add_overflow, instead it has a wrapper
> check_add_overflow().
>
> I could use __builtin_add_overflow for u-boot only.
>
> Thanks,
> Gao Xiang
>
> >
> > Jonathan
> >
>
