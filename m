Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016D5CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 20:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9081384707;
	Tue, 19 May 2026 22:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U/l0iA/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79DD984713; Tue, 19 May 2026 22:04:10 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881C9846EC
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 22:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd4f8260e4eso824556666b.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 13:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779221048; cv=none;
 d=google.com; s=arc-20240605;
 b=brILNfzhOMkWtCZfGfxMbkbMENLo7SHXVePxQRpPyhXlYQ+7g2PLN/ZOQMPSkwJWxr
 3UmOvlMXlu5EqI+/PrXkCxs0cWSdN1boOHw9W2V45ydlloQ3k0L9tLa4Y1u9kCHmzB3z
 h8g1zcRSKLRsyIt1rhkXjeVvG0DO5DMCDPuJTdqCnt7u5PoBeA/FD2AP4HvEVzsVXC2t
 bwkCg9jDcx0mK4mCCbGDP+Q13MChak0nAe68arVYuGw/eJrgzmUmSP8unjQCdH39WU+e
 0FB8O2mj/AdEgcV/xz0IlihDjUdhC5C80cs3wlMHYOJ1md8ihwQjZ/zeUwv+mqKoeGTA
 muyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yTPTI2psMEWp4a1n1BamC1BC0M+zxkzs3hcoRXtiIUc=;
 fh=dt3AX8r9dgCAuxTeBjPm7TE7a6blUpNL3IRU3h0lT0c=;
 b=helofeStOeFeNhL1ahG81SoEFHux+rO2YGJGcz8YrZZQG9Km9/2xBwn9nYWDoO5Z8S
 HSmGawx+VbGbG1TtNf9sV0QB1BrPJ/VFQdMmrwDnQUjToIAkxcWjhyCGWEFfrgj6Xxcj
 M18kMrKoMhKNybb2a7MTbBphKQihKriWYs4ZEN0xvs1aI3rImswwUxCaWp5yH0W10ib5
 C3tUOcMhlGd8tGafxmm/hOi58MFSKKYF4c6O1xjKCK6v4NPgmdSUgH7GzElMICAIKMsy
 u2brejedjCINJvwtFmXWCB+hLfo9m44j0ifhE+shsj90IYKEGEZO8QnLi2WlT6E9Iz44
 eZHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779221048; x=1779825848; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yTPTI2psMEWp4a1n1BamC1BC0M+zxkzs3hcoRXtiIUc=;
 b=U/l0iA/tloWcx8mHJaf+w7z3I3yM6jDwRLPil6AMxQTFgbDxKUKq+L1HX5GcuI/n6O
 TWURvQsxwr7JkPuF1Ev2QQPJnmQzR+qyVs0mSnjvIzyVOe7NkDKXmVPqy6FvyMcE7N5t
 W7nMrkeddknL4Zcvo+HXQXDGWI5lEUnovXsew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779221048; x=1779825848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTPTI2psMEWp4a1n1BamC1BC0M+zxkzs3hcoRXtiIUc=;
 b=onkmZfDp6odmKngeXgRJq+9zcmR22wZplvxA9QhkRfd52tllyckPC/LR/KsJshBdaC
 hfQjECXBIqqxX/EYUu7mHt6AtK2rhe7O46q1f5DPDaicIIYZx/9gsbHpEs9fRGd8inj0
 /Bqh4KICzKS1N5oKZrpLfK5K9G+PrKRULRsNniivt/4sZKUZ0Md/iCAKlivgGHiZvF3J
 Rn4s1Ze4wgQFz0YTSdFojmVQMoGxNjhmKWWnLp/pqRHBI2MXNBhCkZ8GaatRE0TWIa7G
 zpTkSJ3eT1+SRWHaFdFta3e60KMwnh80Tr/08GEKo2bb9W6pgVKFn8m80neQSKgjps9y
 WM/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/AAtjGnV1gv5GB4WxuxBLlQPO09wyePT/ioWfXgWF39zLllifZynqX8xeqPyKJusTC17tUeJg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxd/M5rgMafoD4VAdX1pj4JU+m0SCdo6PaBlYJoRJ/COZY90VOb
 Pyg5OJVnFxY4bxdISCHcxVOW1tD/Iy8+F0oxsT2OMagF3WdXx27Wx8oUaLujpgtAR4ZeINnBAxP
 T8kDt9o1lOXO/y1k2r8/f17wggHyOqTFnikFlbzjY
X-Gm-Gg: Acq92OGgoxNqvbs9i8m+I+oy+7wUKSVMOKO9S68HJco5l21Bbhxe0sjq8xeMbhGf8SM
 U6kWPf/MjbpybXMfVOvPNucBdTb2rX/B7OaN84Ukb8sI/5MGewktePVF7eXl/PLlf0Wszt8+o8p
 p7BvOFc0T3zHq/NkwSywjZifsQ6XVBwf+qHHX8zjNk8YiY/OaYNoXmwauv5zy1K+/w7VI1L//NF
 OEZwCeskRbYbhkQrMDU2rFu0dRonbdXLY8xt76KenOVbams5zWKKn9/IwfHV56gaNa+H+dRqhlh
 3lN5gQ==
X-Received: by 2002:a17:907:93d4:b0:bd4:c6be:5f2e with SMTP id
 a640c23a62f3a-bd51777c81fmr866607266b.3.1779221047779; Tue, 19 May 2026
 13:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 14:03:56 -0600
X-Gm-Features: AVHnY4J-5Cslh3TMp-KY-sWqlxb2CJgZq_WdxDPFvN5BPPf6v7zAc8rA9tE7s6I
Message-ID: <CAFLszTgSmMSKzocWFkAMcq4tHb3ZbbjJ=Ouby=iuSnfAHBmmzQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] fs: ext4: don't read time fields in XPL
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Daniel Palmer <daniel@thingy.jp>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
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

Hi Heinrich,

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fs: ext4: don't read time fields in XPL
>
> The ext4 readdir implementation populates dent time fields in XML
> builds though that information is never used.
>
> Guard the three rtc_to_tm() calls with !IS_ENABLED(CONFIG_XPL_BUILD),
> consistent with the FAT driver.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> fs/ext4/ext4fs.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

> diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
> @@ -319,9 +319,11 @@ int ext4fs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
> -     rtc_to_tm(fdiro.inode.atime, &dent->access_time);
> -     rtc_to_tm(fdiro.inode.ctime, &dent->create_time);
> -     rtc_to_tm(fdiro.inode.mtime, &dent->change_time);
> +     if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
> +             rtc_to_tm(le32_to_cpu(fdiro.inode.atime), &dent->access_time);
> +             rtc_to_tm(le32_to_cpu(fdiro.inode.ctime), &dent->create_time);
> +             rtc_to_tm(le32_to_cpu(fdiro.inode.mtime), &dent->change_time);
> +     }

The le32_to_cpu() addition is a separate fix from the XPL guard,
right? Please mention the endianness fix in the commit message, or
better, split it into its own patch that can be backported
independently.

BTW dent->size on the next line has the same problem, doesn't it?

>     fs: ext4: don't read time fields in XPL
>
>     The ext4 readdir implementation populates dent time fields in XML
>     builds though that information is never used.

Typo: XML should be xPL

Regards,
Simon
