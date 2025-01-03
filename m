Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A975EE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 01:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3962F802EF;
	Fri,  3 Jan 2025 02:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c9vVy8A9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0BB88034E; Fri,  3 Jan 2025 02:41:58 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5588180196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 02:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so21719814a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 17:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735868516; x=1736473316; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CAB/zDubYK/PULdDc5624YA3knPxGHoOU0YmFnSk0U8=;
 b=c9vVy8A9KEsRzsySZrn5OMfmkxS/TY4dJT924N2GuiadXq2NtK4YrTZB267l5ox6di
 uQLCPx3jrI0l6w8ZwLnYSXKikz2LljqsB1yp8fq+wBNhFrsiED/qgRCsXp+z74ZJBHpX
 r/bKgY+tnRcRBYOHuYT5WXhPYJ/CEcccZWbOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735868516; x=1736473316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CAB/zDubYK/PULdDc5624YA3knPxGHoOU0YmFnSk0U8=;
 b=YwPS7fkupZncsiW9A1dVdkXMtHoX00H6hsBw9b/A5kwoULujJIR77iJy0zqfDsJars
 DSdfAIjWufxCxXIea3aAktLZir99rSN4yRnEY0lK6DIYMttHCkJ9GnRAXien5e9nFHLz
 BUeblD0D9doZLnP9p/8w8J7qb8fDa2P+U7uNLBjM0hsPveHH9dRfWSWoqhPuKYpoEuHx
 3Nl7/DMTIdGKLkIlrT0w3lwMnqsJtu2tF5r4FKKeLWjGTy6+2POOGxq5Sgrknc8lpSkA
 u8QLKPBITDwLW93b9QY4lhJ01hoqk/t/ikXI4GfRwaDXTvNmm0D5gnStQ2MRV/2qORSv
 O0lg==
X-Gm-Message-State: AOJu0YxvJ4DdXPQLez4WbdkNICuGxNeJTWGtMthGyH2qJppQbfuAx6yg
 f3Yu/mX7MmlOU4afwoGjCGmfj6a1MrrHgZrjovdJyh4Vj5GfN2I+GFCyMNV9guB0D24WkWx1sRH
 QVHtm9ASfQA+GnOxJKV/eiORBOWfNALXHWFb6
X-Gm-Gg: ASbGncsqVKTmji6P48G9uN8eVoKlT5D5vIRQXncjtkLM4CYoONRdaau0ebb+9jbQWJ7
 Lmmvyf8VG6PAt3df1SRZBfP7SyWHjbAt8hXWT31Kj
X-Google-Smtp-Source: AGHT+IGoT2CbY6z2GeSc/eVp/0u5jgA0gxREQ2kqjG20Uo8Ptmy533nVJ8fy1dpElVvhK6SpL+YAWkWsrKc5pd35WhA=
X-Received: by 2002:a17:907:1b81:b0:aae:bac6:6659 with SMTP id
 a640c23a62f3a-aaebac6712bmr2770105366b.7.1735868515758; Thu, 02 Jan 2025
 17:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAC_iWjKUdqGkAEXyz0LobkCgF_oX9dC1xCzz2qEWXbuOhkg=Kw@mail.gmail.com>
In-Reply-To: <CAC_iWjKUdqGkAEXyz0LobkCgF_oX9dC1xCzz2qEWXbuOhkg=Kw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Jan 2025 14:41:46 +1300
Message-ID: <CAFLszTh3bnjisKqnDUvRCip2wdL0hJr+EM40+SbQ76h_zgg7Kg@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Drop BSD license
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Fri, 3 Jan 2025 at 08:15, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
>
> Apologies for the formatting, replying on mobile.
>
> On Wed, Jan 1, 2025, 21:58 Simon Glass <sjg@chromium.org> wrote:
>>
>> Linaro has decided to write their own version of bloblist from scratch,
>> so there is no point in having a non-GPL license on this file. Change
>> it, to better fit with the U-Boot project.
>
>
> Apart from the commit message being wrong, it's also intentionally provoking. There was no bloblist in TF-A.
>
> The TF-A code is implementing the firmware hand-off spec [0], which Linaro participated in the creation. The U-Boot implementation was adjusted to adhere to the same spec after the TF-A code was merged.

The U-Boot series was [1], for reference. This was mostly about using
different tags and shrinking the headers. My clear understanding was
that we were going to try to have a single codebase, which is why I
changed the license.

So, since you have a different view of events, why did Linaro write it
from scratch? Was it to avoid having U-Boot code in TF-A? Or was the
author just unaware of the original intention? It isn't relevant for
the commit message, but if you can find out I would be interested.

[..]

Regards,
Simon

> [0] https://github.com/FirmwareHandoff/firmware_handoff
[1] https://patchwork.ozlabs.org/project/uboot/list/?series=387200&state=*
