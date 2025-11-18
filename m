Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92123CEDD8A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7E0783CB1;
	Tue, 18 Nov 2025 14:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PGr+FTdw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F8083D07; Tue, 18 Nov 2025 14:57:05 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66E9B83C5E
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 14:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-789505a2fe7so24066047b3.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 05:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763474222; x=1764079022; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4yGlgPm1nFGmcU25xGOOVzu+BsHS9ZvfVwNIF1e6QPk=;
 b=PGr+FTdwvZsgEbNmCR2wqZ7YZNjQykGLB3RP6j2ZlOlJ8Y83ukkGJ3Y6lr2/CFqPan
 0zx3/GMvSOoGB7is71KQ9jaWLw4sfDfczb8SIrDie9wdjdqMnVtfk+boBU5P+qUl4Nwz
 f7p0WvamvJzKGOfEK9SvTzl5lFKbuBLf0ypn0Nk1s/+f5uOZwOngB7Kp0qJQUCnRzLjX
 fSnWBTvwkPj1NVwtHMjvGFoGJ6g9v2orRiSCJe9PrIqdrnX4z0BBM92n2eg537jz0dZN
 JfzsLUIj5O9uBEsqIq5BzmaWPFMpYP1UGZOgdph6Fs0+4RIer+gVyLTahL89/vNRtk9b
 zEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763474222; x=1764079022;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yGlgPm1nFGmcU25xGOOVzu+BsHS9ZvfVwNIF1e6QPk=;
 b=M30oXqYKwi46e24H9Y8JAMevTyY87d9CwGXk6R/HC1t7AxpRfeRKm+ixBz0paDSgmG
 LoKP9Jq9hA9zt+ZsIsax7p+13Qpuf+99pIwRetZNXaTA/7HcJIo/iadyXo7D9EJEKWwu
 RXYQMF3WKXgSj2kRdgNiwK/J9xme9VjOuPjOTr1Ewm/0KJLiu2a1gBzWPucnHAASpzGS
 e7pq4LJBVfD+cxFBl7SjiIzpMmWz/dAsm//HoNwqz5/4bw7r4yXbAenkYf4Jwi+q8o7L
 dPPCDigQHO+Q0b9sRpAa/pmIlJRhqM1S84ge3nfOJV2amig5WkDw4b67jaPWYTnjA16I
 uwTw==
X-Gm-Message-State: AOJu0YyzDHeXYvpv5s56Z9qG+pVP3qwEsL2o2pZAvxp/75eyuPNBjj5q
 +og90J/Uh+ih5YbE+AC0s0//bpXLFSr6GbromSVla/oQYlJ5dMFsM98A8pEoC6kqJegGd4vYjfA
 C3M4WGrZB3LjBHMs/b/WZzcXlROJoEqzLcbnDbWGjEw==
X-Gm-Gg: ASbGncsnpFQDjC9Op10Qs+5pL1sX73vN5iT38UKQejLD44NboZU96QefU9GkQeXQybh
 B2E2EdhtTO4Uib5Zvk00B1zrdOaGk4ffAGbufqG4g3Sic8KAqqy15qMJK197p7+lsEd0BjXEtJN
 4OENrn22TTPv5ZLmPaXg3RBK8NnDDsr/004iesOSkDTzr5Zd3jFEkqjRRZjwZZ6myilP1RxsFDd
 uM1ADFkze5rTVGO9w6Cs9zpGNSi/jeG3z071croHzgM/oBAodVptUDq8sZ3DVK/IjJ4obliyR9I
 1/QtaKHS39fLWehP9IknxJxL+LepgYxfIr+qlYr0dJM3KYG6JkoM4hQQ6MJBjA==
X-Google-Smtp-Source: AGHT+IE6oN1640ADr563s6LUhlmoaYzSgwO84scQ23kkjB8k4CWVHMPT26CHsYmLhVrO6N7H0EXhdD4qqgORSnl3QHc=
X-Received: by 2002:a05:690c:a05b:b0:786:379a:51ec with SMTP id
 00721157ae682-78929f3d1d5mr112073287b3.46.1763474222078; Tue, 18 Nov 2025
 05:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20251113115558.947903-1-marek.vasut+renesas@mailbox.org>
 <CAC_iWjJE1meO7UonS2-hUSkkcnxQWCerqdN4mb_wcR7rpVXy+g@mail.gmail.com>
 <20a873e8-d17c-43af-88af-ca14219859c3@mailbox.org>
In-Reply-To: <20a873e8-d17c-43af-88af-ca14219859c3@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 18 Nov 2025 15:56:24 +0200
X-Gm-Features: AWmQ_bnszEkw7q7XA4sVs2rY6nG_ImcZy8ekxEZ587xW4gJ0Dyjjfl4fWdf1Ub4
Message-ID: <CAC_iWjKWr-J3pxmwT5mCDXaAiRxYFiX=hfHGdp2x81-0WzbEpQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Assure fitImage from capsule is used from
 8-byte aligned address
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>
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

Hi Marek,


On Sun, 16 Nov 2025 at 02:20, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/14/25 8:03 AM, Ilias Apalodimas wrote:
>
> Hello Ilias,
>
> >> +               img = memalign(8, image_size);
> >> +               if (!img)
> >> +                       return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
> >> +               memcpy(img, image, image_size);
> >> +       } else {
> >> +               img = (void *)image;
> >> +       }
> >> +
> >> +       ret = fit_update(img);
> >> +
> >> +       if ((uintptr_t)image & 7)
> >> +               free(img);
> >
> > Initialize img to NULL and make the check a bit simpler to read (or
> > get rid of it overall)
> This part ^ I do not understand. The img variable is used by
> fit_update(img) , where should it be initialized to NULL ?

The patch might be misleading since it doesn't show the entire
function. But from what I saw 'img' is only initialized when
'if ((uintptr_t)image & 7)' is true. you can initialize img to NULL on
the declaration and just check for that.

Cheers
/Ilias
