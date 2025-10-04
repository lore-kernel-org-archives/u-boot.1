Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8270ACAC5B0
	for <u-boot@archiver.kernel.org>; Sat,  4 Oct 2025 02:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 947EC8386F;
	Sat,  4 Oct 2025 04:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qZQPj9qW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2878083887; Sat,  4 Oct 2025 04:04:31 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38CC98383E
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 04:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3322e6360bbso2879804a91.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 19:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759543467; x=1760148267; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NGKDLDWKx5NWBOmPbvTVG7oOceNQF49OFL2OYBmW64w=;
 b=qZQPj9qWwxzKbo0TYwkjoXZH4wknOvHg5xZWTLP6Gjof7KAhPjw4pCvpU5zkIViJAu
 fTRYBJEumY305oJf1br6iyjrGA4Y9fOWqePP7GldLsNGc9IPtSuGJlRM9Rxu3yU1UtL2
 REdXnzPwVuAvBkpyd9wuYxbyS5X9XcZUtSrqqkHPR/qPmAHwIlHoFnu2/kcrsoWxZ9aY
 w3Z8QmN294oOPi0tmKDNAF1fCr+udt0KG/wX7mOv93oXhSrE3YFfpGD6r0DpF0SVc3qO
 +BggrPe2oJK9nUZeeGWfC39wmum0Ij7v/ZHdfFpkay0ZN39w1aY2RXG7aO5z0t0V4HIv
 StcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759543467; x=1760148267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NGKDLDWKx5NWBOmPbvTVG7oOceNQF49OFL2OYBmW64w=;
 b=e4G0UlkcFBUvsdB6BPrIwFioJ8/NhvfAswjyy61UbSd26SxKxOJyl2DCNkP0Bz72kU
 mVlJ9gvu+N4rMhQolM2Ad7fNL4zz13PoqHRbQsijLUy25N+/Z/GbOzBMdfYKeSz+diRZ
 rXk4t4nXU9dQaUc8lwQB5iqy8kBX6HNHss0v1ciXxS8HrI8bwHodplQV5dWhjbX8/cFx
 UUdMJVzWHZAO6WxgDhaHSDJGHV3u1HJW/xbFMKbg4FaUi3mdpFmPk9g1lGZYxY7KrTZS
 K1OXXzLkBkzRaiegbpQDFRJEMvaCFsGYa5cSKHhjY/wjz4Bs00pvukQ+ztovCH1T6rP1
 SZ+g==
X-Gm-Message-State: AOJu0YwN3KPsydGqyZnWEjSgYJ59WARtxlUsu892MnYfpgocShfRkt44
 tlG7T8ayq9VThWUUhVPNzmSfvndEZz6n86e9tTXkxW4JiLiuOt9zwk4qS5DOAYz8ZbhTPVDAq2y
 GF+R2Ou3lZDTdvgri3T5y0nZVCHpAe+/+4DN+6DD8cw==
X-Gm-Gg: ASbGncsu86WvYR+PnFFetmZfkjz7OJ8QByTzKQNME3/CRnmXpPauKfx5ktNiza4iJtS
 aJmIf1evPo0Y3UDw6ACxtd7n5si/vE4Dn49VtvBPhPp9FrpVt9KlxxlFFp4iEg4FomSmk0Uq7Xc
 jHRtR/KOP2M4PJXBxZc2hoyUfr+7ZNmUrUIbhrDa+z9kbTiHJMFPgqN7XxXiwBFu/em5D4duG6p
 v7QNkpQ4AIHujqw9AOeVgZPtQtxwp2YSFYMnwYt0sGJ3/psFHV9Twko6g==
X-Google-Smtp-Source: AGHT+IE7t2YGMMNpc+D3RNCh+GdMioXcsI6h5UjTNVXuRXQ1IMy+/uSqbL2a80Jiu3NAyWjXqtCb4bChVhdLeGB8ABI=
X-Received: by 2002:a17:902:d4d2:b0:267:9a29:7800 with SMTP id
 d9443c01a7336-28e9a6609b7mr57129255ad.59.1759543466683; Fri, 03 Oct 2025
 19:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251003192222.767882-1-raymond.mao@linaro.org>
 <20251003201331.GS6093@bill-the-cat>
In-Reply-To: <20251003201331.GS6093@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 3 Oct 2025 22:04:14 -0400
X-Gm-Features: AS18NWC2x_zw6rUbW2B9_dilnn4x4uLt8WrBW_HEhszcQ-cXOMuqqzYFUthaZLE
Message-ID: <CAEfUkUJa=eTq4MkjosnN1SxA2Aq3ySTZrSiHj3474otN8VLjfw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Enable Firmware Handoff CI test on qemu_arm64
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>
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

On Fri, 3 Oct 2025 at 16:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 03, 2025 at 12:22:14PM -0700, Raymond Mao wrote:
>
> > This patch series enable Firmware Handoff [1] CI tests on qemu_arm64 by:
> > 1. fetch MbedTLS (v3.6), OP-TEE (v4.7.0) and TF-A (v2.13.0);
> > 2. build bl1 and fip with both Firmware Handoff and Measured Boot
> >    enabled;
> > 3. pytest to validate the Firmware Handoff feature via bloblist by
> >    checking the existence of expected FDT nodes and TPM events generated
> >    and handed over from TF-A/OP-TEE.
> >
> > Pre-requisite u-boot-test-hooks patches [2] are required.
> >
> > [1] https://github.com/FirmwareHandoff/firmware_handoff
> > [2] https://lore.kernel.org/u-boot/20251003191918.767698-1-raymond.mao@linaro.org/T/#t
>
> Generally, the changes look good, thanks! Specifically, did you trigger
> a CI run where you pointed Azure at a fork of u-boot-test-hooks with
> your changes? I'm a little concerned about the fiptool change and I
> don't see a CI run where qemu_arm64_optee.. was triggered, only:
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=12044&view=results
> where it's not. Thanks!
>

That PR is missing the last commit (adding the CI jobs) and still
pointing to the original test hooks.
I have tested with my local docker container (has a test.sh that
simulates the one from azure.yml, and points to my test hooks working
branch) and all works.
But when I triggered it this afternoon at:
https://github.com/u-boot/u-boot/pull/818, I did see the failures...

Hmmm, I will compare the log with the one I got from the local docker
container to find the cause.

Regards,
Raymond

> --
> Tom
