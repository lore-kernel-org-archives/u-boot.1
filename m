Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CB5C3ABAA
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 02:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BDB581F7E;
	Sat,  3 May 2025 04:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J+hbe+/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80B6581F7E; Sat,  3 May 2025 04:10:04 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31B9A81F66
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 04:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5ed43460d6bso4004256a12.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 19:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746238200; x=1746843000; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wZ30ZqIYmLemSyHWIEzfOut10dWSnGmLKN2XgsZY1P4=;
 b=J+hbe+/G/h5G6YiSXpJWdKkSy7N4RTJXilocqaHaW7hoSySzIGjX3NAvaz1GUqXmWi
 05IYUOyLUbYiYk3gERhd/FBi8Yjo4RkQ4VETG/DBc1g6oj22EgtRqi/3cdNFaTJU+Uim
 /GfbIHly+mb1ILnD83I005egHaAZdG7cB9bvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746238200; x=1746843000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wZ30ZqIYmLemSyHWIEzfOut10dWSnGmLKN2XgsZY1P4=;
 b=SPlkRv4xmutZf67enywcN7Gxqoo7WoOwCNVeKOfRPEFBfVk+zNdXo4dEBbw6IoJOBa
 2OsAi2QjA40TiN82Y0j9TpWcBbY+pQads2wZYhxhfb5PDz79N+TKUtsv/Ek1rClrZP27
 gjVx+8deiG4u+zMLk0lGNW0Yb/nFmU2J0YBUgMvN8rscKgpljoC+j4yq46g8FYSTCLYp
 uiX9ye7EChNl9P89VtDlWshoAsS5XZb3PpJkroLkFCn9LGvWVl1KyKL8WcHM8mpy/84R
 Gjsc9gowjrUIxspa/JfadLO0Luci465q6YqQp4OwJYjztWCdwwJQ7YxIWvFTixfJUNJ9
 G0Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQZ+30xzY6C6YygKm6h89ATcZ0iQjC3P2LTx3sCMWrT7r0YydSAGuGr69dbptSQmsRyAn73r8=@lists.denx.de
X-Gm-Message-State: AOJu0YyvluMbssGeoVpUU+N7akou/JxYKQYULpqmTdP+QMtlFkBN8j9x
 WV+zKJ38Rbgft8B70oo0/NuGIJkNxob1eXS16NiBSOBNYOScySvLYAfJgpV2aKU0grDyok9DhUM
 mpgFmbj/w+g0BngBbtw82LS10YL5tTMhUakfK
X-Gm-Gg: ASbGnctkdDNrUN6VWJrVk2puXc0+LP2Gkv3T1qaLFZl3FPw1HIb+ctuFFtgG9U7XDsJ
 MXFMfBpGJhfQz6Mac9H6GaROX7AFs4uL1gozC6RI0hhG+17h+Yjbnctti56a+QiQDXGWQJfMaus
 UbAE3+21Hi/1fLP4c7S1y2sgBrD09YLZsapQ==
X-Google-Smtp-Source: AGHT+IF8tf67s4MowI6g7qQQ7PvN+dG/ziCSNcRXaFrzNA0mmlYcX7LF7oK3t4cjnA7WzKoLKbbuxLuLgHMWj3ixQ3I=
X-Received: by 2002:a05:6402:84a:b0:5f4:d22e:28c3 with SMTP id
 4fb4d7f45d1cf-5fa77fd6baamr4206117a12.4.1746238200631; Fri, 02 May 2025
 19:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
 <174620317246.1348341.13335565510376078911.b4-ty@konsulko.com>
In-Reply-To: <174620317246.1348341.13335565510376078911.b4-ty@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 20:09:48 -0600
X-Gm-Features: ATxdqUGxqVbJnToL946WUG3MReMi2gIU3169Guv02jzwtHgUxUUvBeh8bgVb63c
Message-ID: <CAFLszTgv8vVkK-ts7zRPN2p6oLPWwTKuTk=PjNse-AC2ZgV8WA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Qualcomm: cleanup OF_LIVE fixup and fix RB1/2
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>
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

On Fri, 2 May 2025 at 10:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, 11 Apr 2025 14:47:37 +0200, Caleb Connolly wrote:
>
> > Introduce a new event to signal that the live tree has been built,
> > allowing boards to perform fixups on the tree before devices are bound.
> > Crucially this allows for devices to be enabled or disabled, but also
> > allows for properties that are parsed during the bind stage to be
> > modified (such as dr_mode for dwc3).
> >
> > With this in place, mach-snapdragon is switched over to use the event
> > and some hacky U-Boot specific DT overrides (which had to be undone
> > prior to booting an image) are removed in favour of fixing up the
> > livetree (which is not passed on to further boot stages).
> >
> > [...]
>
> Applied to u-boot/master, thanks!
>
> [1/8] event: signal when livetree has been built
>       commit: 993a9db918af451c68851522c8770e582b717629
> [2/8] mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT fixups
>       commit: 5a1dfb27f9170d35a475ea8be46b5d7c037ee837
> [3/8] mach-snapdragon: of_fixup: skip disabled USB nodes
>       commit: 0ec337d03410a4a0b7402ae72968470cf63f0c55
> [4/8] mach-snapdragon: of_fixup: remove confusing log message
>       commit: a6cc4ef343dc39c17fd5b833d983aff2f26c94b7
> [5/8] mach-snapdragon: of_fixup: update comment
>       commit: 9bc7eef9bf58c4c1d453cba81060dc61375f5354
> [6/8] mach-snapdragon: of_fixup: set dr_mode for RB1/2 boards
>       commit: 3b983cf48e70ecb6aadca788d0d91a021340c802
> [7/8] clk/qcom: qcm2290: show clock name in set_rate()
>       commit: 229fd3f9a8d4dbaad7c9a2e9c1b62d14d0753b0b
> [8/8] pinctrl: qcom: qcm2290: fix off by 1 in pin_count
>       commit: 2803a466a96153ab01c5789321e48397b6bae9c7
> --
> Tom
>

One of the patches in this series introduces the concept of two
parallel devicetrees in U-Boot. So once we do move to livetree 'for
real' it won't work. We did have a discussion on the series and I
proposed a couple of alternatives, but have not heard back on those.

As always, I don't mind what is applied so long as we can change it later.

Regards,
Simon
