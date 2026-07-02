Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF168C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C5E84CA3;
	Thu,  2 Jul 2026 10:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ar1Biy2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB6F84CB5; Thu,  2 Jul 2026 10:04:17 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6661484C19
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-664ce3000e6so1399216d50.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782979454; cv=none;
 d=google.com; s=arc-20260327;
 b=ipXoLkxmAv8QjuY8dln903mOKd/GP7sLY2gq/7zrKQ5zda/l5QL2ohnPhCaR2vM5MR
 2WII+rkFCp9UNMgANhYYWblNTZHSowYdqCTp2A4gC3pE2zHqBSi3uHRpyiqC4VKHHHnL
 587nqOBV3+HDCvxU60Ev1RzGRmLB/r6ou3/GAEtxuL9XrxmsNtb+whhYX8Bc9ZpDspwb
 hQgcChmzZrqdg6XQli6La+evCUT38N3ro055oFR9hJs0lA8eiy1rNrsMlfpmTsgLh7RU
 UJABfCQBgfkEvODQ7eki61vnz/DTvfwHIlDsynrZnQX1AliGVTcyRrXHEaT2rJ/0yYEj
 N58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hcvFEWi5K6H4v5afPcUtiGjEbjaImQ5SxDv+/CgC0VY=;
 fh=/Nsu4KeIY/BckAkrFd38YurCorn6dwrZh11nSZtiKSE=;
 b=r3TLWPbH/LqC77r8LVRbiYu3IOY4SiamLeImvI//2Cw1ZTsYm+gzrCf/RClHNhrXoy
 ath8Amia9ROC3RxR5qnnOH4UeoenPoPM9NQayJ6R2Ers4rE7JTnh9HRq/JE4AZWFsmL4
 QhBs77i4q8tAI6OI31xCSDZ5dQPHj75coEQIXh3oUQTmYgPxJ+v/8wO8l7UPofUzj3kY
 +pto8mg00Xpi/yVyp8cl7JQWmbR3VFNf8N4joGcByPauuAdqfx3rTokoR0/AOp0xEEHe
 LavZx+lKRwbblfgBjQE4hYESEMVavKjFERO636kO+L/8AvolIWe/T0q2H7APP+30Q88z
 TJIA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782979454; x=1783584254; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hcvFEWi5K6H4v5afPcUtiGjEbjaImQ5SxDv+/CgC0VY=;
 b=ar1Biy2D50hMiHFGYnV9JvSJdiw38946fDvW4tzOq+u32IrpYxQmM62XhJKx03Vgit
 Aw67o5PuLV2dAeKOFjgMAO5viGZpcBO0GZUfzllHNLbau7GfZPu7RSq/6BMiYq8NEfiO
 PX9SZBJNkkcKHxluXr9Ni1tpdLQTuF7W4CvaNXL+zl9xSu0FEWOPI2kpfA0ouAo5kSR4
 OJ5QVr9S0R1JfJMbhwwA0c18uyfQv7XEUfNmy5cEZ4ywiBndrnv7FxOu43roHTHIMQO7
 MgD4F1eHIb0QQlMvgKjJ8fwGstzZ9bGAmehDBa3WQmDGkAy0jMbAI3Sj1gekeWypiBfW
 OlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782979454; x=1783584254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcvFEWi5K6H4v5afPcUtiGjEbjaImQ5SxDv+/CgC0VY=;
 b=S76u4vaIUNrb4/u49c1W6gWsJKWGQt1zsu1g2iHEkVDWi1apHsG9FmRiNaV3HE5Pq3
 zqXMbCe2GYE2DEPFYsLQwkGizi6q0PAyb7f6u6WYsljGeFtS/9v3zyjFe4eeHFKflfeN
 gvam6NfVyaSUP5Nf7Z7NK3k6ZsMYFqiUc8Y9r9KQgc/DcUKH8h4k3PRPB78IOL6rXOwl
 UCrguWU8NBinW44a8EqtHNtvMAkpSNZRTZopSB6ljqhvM3Fn3KcGwfAquHTHE1THnVDH
 ika/dwwyJnAZMgAWAmyzyvOHPdE4SqPcQPMzCgCUE1yqyekTUnDmy4nKiDFd1poid21v
 +n5Q==
X-Gm-Message-State: AOJu0YzOtLulfps/T0ne7ZUBDnHFuT9GUwRbw3bF0PyafCctAN0CBweF
 Q4slY2e+LOWWaYRqCOGvavuTFAnPonYjE7sTjzCn2hPI21jnP8O6cOAO3FqHDjRd6qfP5homMrX
 AQK5y3rEHO02ygBceibqjRF7dVWJZP0Wdv+HMl5pvnvKxjqmcfqGE6NE=
X-Gm-Gg: AfdE7clz0X0BrwoJ1XbizMIbNEae1gnBaOs00P7Vgl4VKsLts5NdBSY/zXQje/jQ4EW
 DILlvrP09KAJVIycMyjJukUP6bQbTL2CiDpyaAxZ7ZSahylEhLUzSx7J5tKogYgllnyfFq81bJx
 75FPzYj5VRmnbQemz1G478R/LQtB/X1Kq6CA9qsTfprGqvayrtCimwUccT1oJSi24kxPKmau9ML
 BJKjDb++/H1B5P1foqnmmIGY2DQ4mNc65u52WoA9n4zgcadYR+9elfxksCfrzjW+2ylgbCqzQlk
 EAhFp3HX+Q1G0gbbk3dRlYpPSLpFOl2kl3JJYSO84dQ1V5D1MRCTm1aOTF6rn7ywxKWtQmp9ktG
 49uQ9qMLQCBJZOsGEA0k/4gcWoHaL+6b/l4C62aeixqn1GCpl3tXBCFGFHkiBWR1PsqSoejTl/M
 Qd0edA7QSY/W7jK/X0xyWspJRw56pgJecCCy6h+gvolGxBs7oxQli+1ejmWDNvhdUcjKPvzO27F
 HmWP2qDzeeEo9V2/0zcWKRFXG/jbyP5ku2DW51TdW6m5xt/48NLvSIu5oP+CMwbSvYa4bWPYS0V
 p527cjfdeQZZLJrzuZFmcfQN3AIJU4lbv9pLbEbS82zGdrd46fX75Vrx96UTs65HQgJNPjk=
X-Received: by 2002:a05:690e:4105:b0:664:d642:2259 with SMTP id
 956f58d0204a3-665915ae85amr4055777d50.8.1782979454019; Thu, 02 Jul 2026
 01:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
 <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
 <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
 <f63906f9-29a6-422f-a111-855cdc8d1f2b@amd.com>
In-Reply-To: <f63906f9-29a6-422f-a111-855cdc8d1f2b@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jul 2026 11:03:37 +0300
X-Gm-Features: AVVi8CcHGuD4FB1jrVhAMCaFJ2ZAkTzl5sx3T-TvYSoGZjDdzSbV2Go0qJJVo94
Message-ID: <CAC_iWjLfC_U=q+iPCy-BXLXwLiwjXBe3UHqH5XuvU1gkyVxKkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 2 Jul 2026 at 10:49, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 7/2/26 09:41, Ilias Apalodimas wrote:
> > Hi Michal,
> >
> > On Tue, 30 Jun 2026 at 16:18, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >> On systems with FWU enabled but without the required DT changes the FWU
> >> metadata device is not found and fwu_boottime_checks() returns an error.
> >> Being an initcall, that non-zero return aborts the boot flow
> >>
> >> Return 0 instead so the boot continues. The preceding log_err() still
> >> tells the user that the FWU device could not be found.
> >
> > Won't that affect the board later on? E.g When you do capsule updates,
> > updating the metadata will fail
>
> Do you mean on systems without mdata?

Yes. if the config is enabled it will make the capsule update code
searching and updating metadata.

Cheers
/Ilias
>
> Thanks,
> Michal
