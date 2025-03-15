Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED905C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A91A38168B;
	Sat, 15 Mar 2025 15:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g/6C0k4W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6987F810EB; Sat, 15 Mar 2025 15:27:13 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5405180756
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e61375c108so3883554a12.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048831; x=1742653631; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vUzLVYF7DzwQuOngu0LRMNlzkHZSXDDcOE1exCcGkZo=;
 b=g/6C0k4WbAU5IBxXFDGmKFcgtTkelCCfK5JgdcaYrmoDQfyhHE3u24DgxAhq6KvRDO
 8tsyWUeMwKok/x6QsnMKnT5cz2btL/A/xl9YztM/e2vPsTVksWmFmOBnUuxvBBu77Kw7
 zuOgEwpPFnpIBKl6qKXmAhmdyrZtYDsUbqhik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048831; x=1742653631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vUzLVYF7DzwQuOngu0LRMNlzkHZSXDDcOE1exCcGkZo=;
 b=figbDdqyUGssoDdkrYYAeo2V06IwCcZ8If1vJjP0pS4KPbrsaxbCojZ+uRH74Potkk
 bsJc+fmveuPBpVi3Vfn9CmPJnbeUMCRkBEDPrWr5Dlwoficzt78+gRimGdWLYWpLqndR
 3JYqzn7kcpT3gD0IY2MZFcK6ehfPBkoFSkngUlR5Rek3xTYHX883peomMGCS76lcQBbH
 i64Ezf64qkddD7nFkdOHx3DcyRIbkbybfa/nvZU2W+S+VYeolYzzsHR3WP3MVkdSlFCc
 ANOB3D1ywEgImR9vJxIbmmneBtw90GQsc/WEf2KlQU7jVRAOPMb55BLhmbuLhnT3XWfu
 fHmQ==
X-Gm-Message-State: AOJu0YwlaujzZLkvSmsg9x3Ef2QoeGCM44sGW8NPFY3DGiDm/hF03xLN
 EyJGyhDSY7XxTm2OGBunqnjqMqCQyVhRUjrdHELzHOJEQP0OdxiEfUC7mRqHpSnUorENEkaBDIM
 6jDVN/H8ZASJHAN2gJ+IZaw8z9Cf18AFprhwG
X-Gm-Gg: ASbGncv0NVaCGJj11gcglVfrTOO9x0J6S96eJ+fpqQij2CnN9i1T2Fk8yQQ7ZW1kxBB
 h290O/UcsH+9FwN45DEwlVKVHsRzSevI/Xx6cmb6ZOZwhT++FA1gzA7+RHfFjM+nJ0y0b32N6az
 arEgMyphvZfGNHwwqf0wbxRHRj2lY=
X-Google-Smtp-Source: AGHT+IGe1piTVu3iRDPBuuhWUO76kmXPV/nKm05tJ79RyTMY5JPecjeO2nNjKiOsHCaPvWE/39ibxuVNxT/8CcVjTAU=
X-Received: by 2002:a05:6402:5210:b0:5dc:7643:4f3d with SMTP id
 4fb4d7f45d1cf-5e89e6aba08mr7146757a12.1.1742048830756; Sat, 15 Mar 2025
 07:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250306160428.3041057-47-sjg@chromium.org>
 <20250307142436.GM2640854@bill-the-cat>
 <CAFLszThxRPX8N8pnJfEkm60OJ3BxJx18YbbfVE_0janzmOdWvQ@mail.gmail.com>
 <20250314161518.GT2640854@bill-the-cat>
In-Reply-To: <20250314161518.GT2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Mar 2025 14:26:59 +0000
X-Gm-Features: AQ5f1JrY9EuQWHJY321BkUslNTJErvOQaOh4Vk6G6rCK79Ldz3rEhE5yC6lfn6s
Message-ID: <CAFLszTgDW3=zWZUgkyJiU=nMiSW+DZ1_-+sbJri9JbAs+zUQgA@mail.gmail.com>
Subject: Re: [PATCH v4 46/47] RFC: test/py: Deal with timeouts
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>
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

On Fri, 14 Mar 2025 at 16:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 14, 2025 at 02:44:00PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 7 Mar 2025 at 14:24, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Mar 06, 2025 at 09:04:13AM -0700, Simon Glass wrote:
> > >
> > > > The distro test takes a little longer to shut down and restart, so
> > > > add more time to this operation.
> > >
> > > In the test, make use of u_boot_console.temporary_timeout(val) ?
> >
> > ensure_spawned() actually sets up the initial timeout, so I don't see
> > how I can do this in the test. It is immediately overwritten by this
> > function.
>
> We use this in a number of other tests today, so it either doesn't
> actually work anywhere and we luck out, or you need to look harder at
> how your new test is written? It would would be good to know that it
> doesn't actually work if that's the case..

Hmmm it turns out that the problem was one of timing, where an arrow
key is seen as an escape. I'll send a v5.

Regards,
Simon
