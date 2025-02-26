Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738CFC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 21:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C1E80F12;
	Wed, 26 Feb 2025 22:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U8oxWdzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E3B80F88; Wed, 26 Feb 2025 21:58:22 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32D808081A
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 21:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-472087177a5so2710081cf.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740603499; x=1741208299; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to; bh=8E39Qzn42DuGy8YSJ4XTiVTAmUqpDwmZcEIs+BjMb44=;
 b=U8oxWdzpHoT95xv5lbCgwkKDdSo2uXNR4GIbLCPGdnzOW9l5JZVkPJy3XXOB+V6Y5h
 SN1aGnnr4g3nBfs4LbBYLhydnaNZngOMXupGItfW4eEN1wJZ8TcYeMVmpb2JU2UZmg/b
 4j2AK+VVxk63/KMo4hf5/qmK8/aNvzAfw5Www=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740603499; x=1741208299;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8E39Qzn42DuGy8YSJ4XTiVTAmUqpDwmZcEIs+BjMb44=;
 b=F2apx9MXBhn/ILBBWFv4F9TxxJnCF9Ob+TL2ZY87TzB1p7mEyxx9N58i3T0tn4ilAF
 PrJjsOBE6WideomxXl3/Huo6LW2hZPAvrPCHj7rUjq9QYssEKL3xEvS4CffCJnWdG2CP
 0jSByKz8OAmnq95aYFRzHzj1zjhML68Tz6SAfLZ0Asj7gsJ/ztPGqewHvC/+U38l8gL6
 srwkNAEwZA9B8Qjn4Jf2e6LZF4YG77k+3znAAAk7FflKX6bXTEwEQHqD8wzQGRGionKA
 dGA/7lMQ9m9CerNalWk+Jkf5ZveZ7y2r4bVo/zMLERhMd1qKFSkPb5EmfMcxbu8rtGXF
 MHkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPWA0SoiW2LYOtHQd6DD90EZ0eHO0uY9t6w4SNvnZc9u/lE8nOcOH8cW1aOInrEqjm1zVAgWo=@lists.denx.de
X-Gm-Message-State: AOJu0YwG0DQsj3Wx4jrw0bdd4CzUbPddsmHkYtRs5TvkT/1ibyL6BBCj
 ELQKX8nB+sX/Z+Z/eix8MEAmOG3AdoOSt+/SDlZTIzmGh05HugpTjyBQy8LvENZFoyxo8R74BmY
 mPP2VlcUUH8P/EXw5NffqFZdckH7pkeSyAi0/
X-Gm-Gg: ASbGncunWqez82dnm/XnFd9NuqUi2IGgbUtsLUoDfkmPU7I5N8Tcu9ilyNdzOpEsF1R
 1+wL++bTd8961WfwALnWR8MaJNynoA+RTrATGIJh8aCsWWi6mUw9rTZ5jaFa0kUpmrCoB3CZhcP
 5ZqAjjrlT5pONoPWdNwkdPxKQx0Zo3aXNfrlE=
X-Google-Smtp-Source: AGHT+IFAQ8zM+NMeTF4go+7QHvzn89YFbtD/FEb9QUtT/AVVpsMLdcCR3DJbi2Z0e9iTskEayPaz5og+qGP3z1E4wUM=
X-Received: by 2002:a05:622a:81:b0:472:d6a:24ef with SMTP id
 d75a77b69052e-4737721aa07mr123917991cf.15.1740603498919; Wed, 26 Feb 2025
 12:58:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Feb 2025 12:58:18 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Feb 2025 12:58:18 -0800
MIME-Version: 1.0
In-Reply-To: <cafefdb1-f6fe-4100-bfcd-9c8d98568dd4@linaro.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <af7c7c35-04e0-4374-b99b-addeec485619@linaro.org>
 <CAE-0n502oMFrpxpu1bdh2zGj4--SybHbAPE1ndXr1f90vTme1Q@mail.gmail.com>
 <c39b654f-c93d-42d9-aedd-ca06f1d9169c@linaro.org>
 <CAE-0n50U4c+9Y7uOBT2Go5yobBZwXmK63XhiUze6XoOid83ggw@mail.gmail.com>
 <cafefdb1-f6fe-4100-bfcd-9c8d98568dd4@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 26 Feb 2025 12:58:18 -0800
X-Gm-Features: AQ5f1JrGXgpo2uhoFH4AnThsIrOsnyhXV-_DvsbbQNWd4rk-_oKvXIgFG77fVy8
Message-ID: <CAE-0n52zuH9gf8zfTFjn=v=FwvmGfBY+7iCre0gYBuGxhb2XGA@mail.gmail.com>
Subject: Re: [PATCH 00/12] Support to run U-Boot on sc7180 Trogdor Chromebooks
To: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 26 Feb 2025 22:02:01 +0100
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

Quoting Caleb Connolly (2025-02-26 03:04:29)
>
>
> On 2/25/25 21:49, Stephen Boyd wrote:
>
> > this supposed to work in general? Should I be storing the DTB on disk so
>
> The SystemReady approach is that firmware provides the FDT, if you don't
> pick a DTB then the one that U-Boot itself was using will be passed
> through instead, this ought to work assuming there isn't too much churn
> in the DT upstream (and assuming you keep U-Boot up to date, I'd really
> like to spend some time on LVFS at some point...)
>
> However, acknowledging the limitations of this approach, there's a few
> pieces that move together to try and load the DTB from some well-known
> paths on the ESP:
>
> 1. efi_load_distro_fdt() - this is called into in the "bootefi bootmgr"
> path (which is what you should be using fyi, see also eficonfig) if you
> don't provide an FDT explicitly and will search for $fdtfile in /, /dtb,
> /dtb/current, and /dtbs. This works on a few distros but not e.g. debian
> which puts everything under a versioned path.
>
> 2. $fdtfile - the filename of the DTB to load has to come from
> somewhere, in mach-snapdragon/board.c we have some basic logic in
> configure_env() which tries to piece this together from the root
> compatible array.
>
> The $fdtfile logic is not flawless, it only works on boards that follow
> a specific pattern in their compatible and filename, it just happens to
> work for most of the basic ones. I would be happy to see this logic
> expanded though.

Ok, got it. The way ChromeOS picks the DTB is based on the compatible
string, not the file name. Hard coding the fdtfile sounds like a
solution for now. I can look into writing up some coreboot table based
logic that does what depthcharge does today to find the best matching
compatible later on.
