Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE445CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 20:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83A2C84859;
	Tue, 19 May 2026 22:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hY5Bd9A8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C4AD846EC; Tue, 19 May 2026 22:01:06 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB96F8485A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 22:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd4f7f05e90so787566366b.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 13:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220862; cv=none;
 d=google.com; s=arc-20240605;
 b=W/DZjhZd/TewOcYq8qvkJC8dr0ieOHvUxUAt1G7ACJwl8lmkVgXwFGXuyv8Vs8zd8V
 OaCuaAPUOPHyNrFP9iR2VGgW7aZbQNzzErXd0ANDSh/atQ+wNHQAHuau+k07hE63u9w7
 h1BGuvzNMNpfcOXi3jNeiVocpBYRyiq7+umFPbDBhzhX3yIeRoahOhaanLkxJaVjv0q5
 WLM09FTi2MXarh2SBqtWFKy951/oVeuP4zHt6uU+YOiSizCh0od/JD4wEvZ9PNUB2jS2
 dLHXKK8aIgxICk6qXxvMGxj6JCGpR8q5o5RF3iubuxoOilqX63QNVt3kO7SReop2gTHg
 Kd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vbh0NFfYO4h9OFTgpkaMR9KjOE/0yqKQ6RL9bFCncmA=;
 fh=Zyiz5WhdFX4xeqODDp8/Bl6h7yi3TGi6yGNhBVPjmPI=;
 b=GEsnuPmEe1A0q21rdukGxG9Bzr/HfzOUZqvpdFoIbtcbCTl/f/GqQ5MC9jEwnj0pkF
 Ua/OMD99vD8yGd/6ovRVPK/q5VPrXG9OhN0MRqUs+Ykv9+C/zhHLny25yIAEBIDCLmjU
 UPDlUH/eKZQ0Zr5HowhnkF1vnbgFbjfIdqQ4Ex4W5kIZeYhP308ydPY2qm/f+AY+VpFj
 SaDVX4Hi03yTgMjvMeF9Dn92D2xy9ousHG8Vd+FoHoQSafdXsBOjPeKVQl1afAi51sGt
 DrrwMSWXGxsXIjvtfmczBOcZsiv65swTDv3IofZrDetTSqyxTgNB1YciJCnuvpzRwOIh
 xKHw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779220862; x=1779825662; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vbh0NFfYO4h9OFTgpkaMR9KjOE/0yqKQ6RL9bFCncmA=;
 b=hY5Bd9A83Oo+1XYbhUrdOAA9Lb2sMvAqI5PofHcOlBpqEiqjOoEipmks21gYanizhw
 3XSCweIX8xPqIwvkfsQqdrZ1CTjV5Opcs4gMmFcSW8J/68/7PWMpkdVCtz4RCrwq4FBG
 1CE3bAp+RcvB7AZIIYO9YGlHG8pHD71OT+sJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779220862; x=1779825662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vbh0NFfYO4h9OFTgpkaMR9KjOE/0yqKQ6RL9bFCncmA=;
 b=HW3Lt8ezZnlpm+YO4gm1Kwsu7jK2DM+l6P17rEieMFnerMBYseSndY5xZ+J7p6EzxL
 NjVqsb07P2pxCLNjHZbOiWEPsQ2nnBVWoUD2laeFqeTqi116bT7qoUYgeh/nVdmCG1Ie
 QZ1OrjSqqv8KHyCIIQeNEeHfKwz7J7U5pAlCHhrESgPtI63d7YJTuZWn7v705eCVXUPs
 KpmqO/fXvjUZny82rgblDrHQfKDvlsjNwLbD3EbeqjUdkdnuFWD9iB99FEGA+KjLPaNt
 vsbViLZGH62v4xGWMAfV8nZbOd4a7PcE2u16ogZ5RxHQYeMdh5ngbzrHm6P3DTa8wbCH
 ItuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xZ/S4VvcTAQihEX6i67BzQWNbb6wekZcAwVx31Z3TPFdVM+rEnJ6WCIaYJjd2xZ7lrtQLgGc=@lists.denx.de
X-Gm-Message-State: AOJu0YxFgl9WD+E/Y6p6XazE3TAZ2ux3AJAb7P9NVAlCF9ztlJgfSNyg
 AuVVsuNFq/lVwlHI+rZIQ59XwShI8Tww4wJNGrqdZkFpnHUXibJwgTCW03Vv6bb0CF1zDCy9nEl
 YgzP0QnTZ+0qLhBk6stCFQ0A1z7IGl6T7HahXIdjy
X-Gm-Gg: Acq92OEAssEAd/e4Ol1rpXiy1Q99BCLpgKRnGmjyRAwxFOBRONvvIkRCBTqBybmZDeU
 4GLdBj+HjfQhykXurohr+ZkR9kTO0RUjfUrVcXf0Cd9By33/LBfmktsXQcuMWETfUwPM9hUPKRE
 Hh7WJVlY4Qlj9UBP+X1Afzcy+pNoVVO3F+DY5n7q3ywvG5GaRBZ7ki1bLl/+2qAUXSPQqBTJTJr
 am+d6owJ3e/HM+S9lTjJ2lXUslg7CRogNx4Q+EmXw5FqPC5fRQCF0Rt/17zKZ6mKjEmy9g3WadI
 DDrP/RrUqczR24g6
X-Received: by 2002:a17:906:ba85:b0:bd4:a849:b13d with SMTP id
 a640c23a62f3a-bd51787314amr1335676566b.22.1779220862148; Tue, 19 May 2026
 13:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-10-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-10-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 14:00:49 -0600
X-Gm-Features: AVHnY4J9Zgg1_OX6BrYTeki33IX99RL9jRjB2_ATcCFyrhat1Hva9VzwJeraCtQ
Message-ID: <CAFLszTgsRzmqmfP2Xa3bOqqEBeL+riN50vMgZJT2LXcebmwt6w@mail.gmail.com>
Subject: Re: [PATCH 9/9] test: test_erofs: adjust expected ls output
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
> test: test_erofs: adjust expected ls output
>
> With the addition of the date field the space between columns in the ls
> output has been reduced. Reflect this in the expected lines of the erofs
> test.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> test/py/tests/test_fs/test_erofs.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

> diff --git a/test/py/tests/test_fs/test_erofs.py b/test/py/tests/test_fs/test_erofs.py
> @@ -73,8 +73,8 @@ def erofs_ls_at_root(ubman):
> -    expected_lines = ['./', '../', '4096   f4096', '7812   f7812', 'subdir/',
> -                      '<SYM>   symdir', '<SYM>   symfile', '4 file(s), 3 dir(s)']
> +    expected_lines = ['./', '../', '4096 f4096', '7812 f7812', 'subdir/',
> +                      '<SYM> symdir', '<SYM> symfile', '4 file(s), 3 dir(s)']

Patches 7 and 8 took the flexible-regex approach (' .*' / ' +') so the
assertion does not need touching again next time the column layout
shifts. Since EROFS goes through fs_ls_generic() too, please do the
same here rather than hard-coding the single-space layout.

Regards,
Simon
