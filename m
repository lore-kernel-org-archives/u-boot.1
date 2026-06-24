Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BA0CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 07:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B12B48460E;
	Wed, 24 Jun 2026 09:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wmxPwjm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0A6784671; Wed, 24 Jun 2026 09:05:17 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80BB380287
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 09:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-662b76dabfcso685357d50.1
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 00:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782284713; cv=none;
 d=google.com; s=arc-20240605;
 b=NAen2uCpltFNlJM4F8AvTPCFTWhSaVctLwZdXhdnf0WTYuj1PqSCP3yF56r1aoOYNI
 jbmFPYjxlDHho8ai8LFXpaFtPpqfUJQQIVk7Sf8gc8RJNQ8iHTB3ZQ/8yGihOSBDXB90
 F1SIVQI7ppyWbG4xzNzIxTGMeMQMt2ivA5isml9YiaLcNd4rz1zFWc2XdWIt0E1GKb1i
 shFm3u9wXGIOuWaDCCmEf5b7lFPgNJGK9NhsCQf3eFjxs31lp8tlBHPcNufhY3GTNout
 XNYVtDotIG/ayKDnxnMkTbCJ9gbQCSOOJZPHybyDpc919/ildGpdBSkA0ssplDqcV6/h
 K9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B09LfIt6Csrk87ETepLtXG2yNUla+bGdw/hWJnR86Ts=;
 fh=54JDj7LbReWtHbhc9FjSoB0RkCSq/B333Hvp3I6vuys=;
 b=IReJVmXly5q5qCJKomQE7EFGgkjEd17dR1OuS18umas01cvsrKTLNq67cvSPju8//y
 26SZ3fdKI5uOKfKkouStSIe0D51yVBB4Il6TD2mqIlDapZqeh5h/yV6GSeZYWdiwGEYS
 DnH82Tr+Jz3tThBCK4+OO/YIOhEWvtj7M2XqxxI0Wh+KQRZQOv2MgThJ7qLuRoqvUZa/
 isbisXXser8dViPR+TP+mOJI6BliQYGTvgTbHp8J/xuRAdQOd4jbgAH3MLZY+Erjhe3o
 xdQ+1de4dsGuQeffCmm5CWpM0RmVcc9iz3rqwYmQRfHHxqLQQWUQ5nEmAahrAhllRaga
 noEg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782284713; x=1782889513; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B09LfIt6Csrk87ETepLtXG2yNUla+bGdw/hWJnR86Ts=;
 b=wmxPwjm35dTRFi3PtxYT4xQeVjNm6lr/kZpibZPmf3rglaLurBklNj133oFRaQ27M7
 KBG0Rp8TDVU69Gzs7Hj/+oCATjrjykdZsUXxAZEcJdBeFvU55eW8xgIklOyeD5YvkHAl
 5g1psGY1qDvcjvPIJtP4ieQ8UBXTpNUnmUXnczHfnqKCmVsXi6PjQN+BHqiy5HesWOMi
 95RlVpYe8+miKiFgWVupesHvMDaAcltDhxvWI0EXqi+c2c22+xE6vi8LcyI1CiIanP2Z
 pZQUQBrWKKu3pUnn7cbxthw6Y1PY1630WlnjnJuOmIqmndVYf4mUqjf5Yg9dl1tvX9OW
 Hlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284713; x=1782889513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B09LfIt6Csrk87ETepLtXG2yNUla+bGdw/hWJnR86Ts=;
 b=S9gd6XPhsV8MIyHU9yjC/QMtPlzuCRFdJtj+KaOYCS3ZkYzYzpO5jXWHKS1Qx/c+Rz
 TyzI4+647dsGlJOExUe/f7TMSXcHlvU5oX5ArvarIlPPzCpmxPpUksy8lZPqkmIyFdLk
 7vbAUuvkFaG8V503LDZa/UgLk9ZQhFkWtBqHU9OmcOWvl/ht3+Au0jerAsCQ8AZJtXeJ
 w61F/UvjMyngKTwZus6efbhjb8VOjlE/Pz9xQIMVDvH3/kr9l2qcD50r4wrOG4H8tL7S
 VbA9pBasKuhemCz5Q7vvBxoZFYfimQr6ZbJqJXuARw7SSXa6niWa/W7s6St0FmFC7MaR
 /fHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMlxFyx/KlmqPSXEpKxGMlv87y5ABsD3ami5DV521rxOOs+dESXfhpPP609NsfB51gxnO2Pdk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2tsEhKiieYcloVQiGi7erqQTCkXj1jPY0ic186uV3KQMEaweS
 v1+zBkUdEIr82HYaSq7L3Zbi3ZYPkZSNLqhx4yVVDoA+zK4P2l5wXjxuAudazvnrEt3gliBiqDR
 MOD42KCiuBvSYejl+OGIHKL1dFPY9NQLrGm3+MVaoXA==
X-Gm-Gg: AfdE7cn7OBBUV6+4JWF5Uh8avunnHXu6OMwb1I0q4gjuJACnKIQmn/pdeiWbc1yu+mL
 sZRnUcdHA214OkH1JmeWBZaD8ceigVa/V2HEtzMmeL+7HrwmPjzp76Yra8BGWD6Ngzt9ygizss6
 Y6UeSll1zkY6JRR2swvXKrfaz2rlsoIYVDyHLNrR57HbHeWBgQ7PjavOriv5OFuhhAZKLKzvAze
 IvIuA17/NFAShDDjFUerlAhD70bqomEgS/Lco9Zak1fGOAmqAkHl5GG10SbsWJk7BgVtwHdPUOu
 LX0f9xfFYaUPLz5MPKf2RZfrjziydMzAbmkYyCjAA/4AjRy51fmoyj/5ucJPl+Xjmr2aPulgWzc
 zrYlFgKExqX8w7pP/3ryU3yxeXoZxncDl9K7JOwmK2eIQXBbGqP78u/R52I5RXnXC+QmJASqRhT
 HdMsgPPEkJhDfFXIe/AeP6DKblUz+iqIYqIme2UUL1FBmtEelVDMmuXpVFq8FsL+2yAP3A4gEKt
 0m2nQa8jjbvjCNPNCLBE5MIFn2f+QH8qPZregQAEag1WM9zz7kSaMR6DFB7HyD74tFAqOF+vK7u
 O8dQ2AlAAQ2fybjgvSsih+mtweD+FbsiIv2FkAbT0Yd8MxcuF3qvoy0IJQEGWYkFPuXy04Hn/NQ
 iC5UkQg==
X-Received: by 2002:a05:690e:148d:b0:660:82bb:e9db with SMTP id
 956f58d0204a3-6636e5b1473mr1678556d50.40.1782284713208; Wed, 24 Jun 2026
 00:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260619231719.3823195-1-rs@ti.com>
 <20260619231719.3823195-2-rs@ti.com>
 <CAC_iWjLszH6_c4DXFV2qqQoyhEC9R7emeOKoBO4WvEn5Zza2SA@mail.gmail.com>
 <DJFTGZ0I5LGG.218A8NZ1QBD6G@ti.com>
 <CAC_iWjK+ceFGMkdH0QmkDXcxu8YxD4uDr3dUgwpmajS8+pw9sw@mail.gmail.com>
 <DJGOC6IRTWKF.2ONXRLRZWJWQ7@ti.com>
In-Reply-To: <DJGOC6IRTWKF.2ONXRLRZWJWQ7@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 24 Jun 2026 10:04:36 +0300
X-Gm-Features: AVVi8Cd-dqF76ougH7kvXHHOGU0HTAfeFCZYQ37Ld4x2EMj0rZgPTu7EgFsTHOg
Message-ID: <CAC_iWjKEXzK6M6TLVLJ3ysgDx+9oCL6qv3tvhRqx+w-WYbXChA@mail.gmail.com>
Subject: Re: [PATCHv2 1/5] board_f: add a board_setup_dest_addr function
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, sjg@chromium.org, u-boot@lists.denx.de
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

Hi Randolph

On Tue, 23 Jun 2026 at 22:26, Randolph Sapp <rs@ti.com> wrote:
>
> On Tue Jun 23, 2026 at 2:37 AM CDT, Ilias Apalodimas wrote:
> > Hi Randolph
> >
> > On Mon, 22 Jun 2026 at 22:15, Randolph Sapp <rs@ti.com> wrote:
> >>
> >> On Mon Jun 22, 2026 at 3:12 AM CDT, Ilias Apalodimas wrote:
> >> > Hi Randolph
> >> >
> >> > On Sat, 20 Jun 2026 at 02:17, <rs@ti.com> wrote:
> >> >>
> >> >> From: Randolph Sapp <rs@ti.com>
> >> >>
> >> >> Add a weak definition for board_setup_dest_addr, as a way for specific
> >> >> boards to override the gd->relocaddr address before the relocation
> >> >> actually occurs.
> >> >>
> >> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >> >> ---
> >> >
> >> > board_get_usable_ram_top() can be used instead.
> >> >
> >> > Cheers
> >> > /Ilias
> >>
> >> It *could*. Just felt a little weird to artificially restrict the usable memory
> >> because the stack just barely runs into one of our reserved regions long enough
> >> to break a dt reserved-memory allocation.
> >
> > I am not sure I understand this without an example. We always relocate
> > to ram_top for now and that's why that function exists. I've already
> > started to clean up the relocations a bit [0]. I don't want to add
> > more functions to tweak the reloc address unless necessary. Generally
> > speaking the reloc address should not be board specific at all imho.
> > If there are areas that we shouldn't use they need to be described in
> > the DT and the core code should look at that. I am ok keeping one
> > function to change this, but not more. We also have
> > arch_setup_dest_addr() which isactually board specific (look at
> > arch/powerpc/lib/stack.c which is the only place we define it).
>
> Alright, I'll add a little information about the specific predicament we're in
> because of this board. Our ram_top is something like ~26MB away from a reserved
> memory region defined in device tree. After the relocation, before we can
> reserve the dt regions, we actually creep past 26MB of utilization. This makes
> the dt reservation fail in the LMB path, but later the utilization retracts.
> This lead me to find that some useful warnings were disabled [1] and other odd
> things were occurring as a result.
>

Thanks this helps.

> We can't even parse the dt without first reaching into one of the reserved
> regions. With everything using physical addresses we can't really relocate the
> active reservations to avoid this.
>
> To be clear, I don't even like the solution I proposed here because it requires
> coordination between a device tree and a local configuration.

I think the reality is that we will always have 'special' cases and
we'll need a board function that tweaks the reloc address. But that
should be the vast minority. I don't think we can solve this with a
single commit. But cleaning up the core code will give as a pretty
good idea of how many 'special' cases we actually have.

>
> There just isn't enough wiggle room here when u-boot doesn't have a real stack
> size limit. We can't fully plan out a memory map ahead of time nor can we
> account for this at runtime. Please inform me if I'm missing something here,
> still fairly new to the way u-boot handles things.

Ok so from what I read board_get_usable_ram_top() does solve your
problem, right?
I suggest you just define that and revisit the whole thing once I
clean up a bit more.
For example, I don't see why we need arch_setup_dest_addr() and we
just can't define board_get_usable_ram_top() for the affected ppc
boards.

>
> Thanks for look at this Ilias. Hard to get these kind of discussions otherwise.

YW, I do care about abstracting this nicely and reducing the board
specific code So if you have more of these cases feel free to cc me.

Thanks
/Ilias
>
> [1] https://lore.kernel.org/u-boot/20260604155038.3182-2-rs@ti.com/
>
> >>
> >> Initially this was proposed because there are multiple runtimes with their own
> >> allocation techniques that could potentially take advantage of that space. If
> >> it's still preferable to use board_get_usable_ram_top though I will change it.
> >
> > [0] https://lore.kernel.org/u-boot/20260617074846.84362-1-ilias.apalodimas@linaro.org/
> >
> > Thanks
> > /Ilias
> >> >>  common/board_f.c | 9 +++++++++
> >> >>  1 file changed, 9 insertions(+)
> >> >>
> >> >> diff --git a/common/board_f.c b/common/board_f.c
> >> >> index fdb3577fec09..d9d09ac94bf2 100644
> >> >> --- a/common/board_f.c
> >> >> +++ b/common/board_f.c
> >> >> @@ -328,6 +328,11 @@ __weak int arch_setup_dest_addr(void)
> >> >>         return 0;
> >> >>  }
> >> >>
> >> >> +__weak int board_setup_dest_addr(void)
> >> >> +{
> >> >> +       return 0;
> >> >> +}
> >> >> +
> >> >>  static int setup_dest_addr(void)
> >> >>  {
> >> >>         int ret;
> >> >> @@ -362,6 +367,10 @@ static int setup_dest_addr(void)
> >> >>         if (ret)
> >> >>                 return ret;
> >> >>
> >> >> +       ret = board_setup_dest_addr();
> >> >> +       if (ret)
> >> >> +               return ret;
> >> >> +
> >> >>         gd->initial_relocaddr = gd->relocaddr;
> >> >>         return 0;
> >> >>  }
> >> >> --
> >> >> 2.54.0
> >> >>
> >>
>
