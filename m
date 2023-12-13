Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0791C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 226DB87824;
	Wed, 13 Dec 2023 20:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wesib2go";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F77877B0; Wed, 13 Dec 2023 20:52:19 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DB7D87824
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dbcd9af2428so612816276.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497136; x=1703101936; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pdUMfTnZDj9/hnx6COdJ0b8tVKU/kVgKfJrMaV+MDV4=;
 b=Wesib2go7FB8S9sTN51XiHjy+dPgf0AvjoAY2gLIl31Je6DzCldMJMvuOOjnCTWScO
 J/5B1MqMdg1zCfF2WQDelpqeFQzhGGkUkfGax+6cys+I3utcDgDkVwGl075rG4Wzcctw
 gZmmxwrousVFIUAXXeNuUbPXIrOWdCGq2XmQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497136; x=1703101936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pdUMfTnZDj9/hnx6COdJ0b8tVKU/kVgKfJrMaV+MDV4=;
 b=bD1MTHOf7bgQRdbDcdDKFnAP6TYDeYCDIJjXYnigxOhntNngOPI26V6OY5NsJyIubN
 y3HzyQo1G8ts0guQELCkNm5paaFs0f2E5hW5hz5QFm8178ynH8i502HxCCTRh3ITBqBI
 cy/DqwmPMloL5mZWF6zkwIYV9JKD+deFR4viXPIrG7zJWfhE9j/EibmE3LHb1uvo3S1X
 Svt7+sQ6e4q3nILulwmjoCn0ScweAU5HnkN8hEMnD94G5ysErpGy2TTW3+g8/oqlQ1fR
 U4upWsXHb0oGIg1wdxzZR5lrhVvYrCz6cjdOfyPyReLQkj74qjLGr2L6IFKlz0AgjlND
 z2jA==
X-Gm-Message-State: AOJu0YzKDbG5WGKOSxLFc6kESHXf+Jjxai0Sel4KTDvcjpje3G1gT4wn
 odksssoN2BLVGS6Qjpo9BwWMgSW5LEHto79A1X8eHTJWbEqoto3wA3I=
X-Google-Smtp-Source: AGHT+IEWhwjeB6uIVNSuKIl0Xtjx3/2WRYHPFYibdbwAjmPzjhbRw/cJwI18aoYxFK/3FlmnYUVKiOIeMOPU6SSIPH8=
X-Received: by 2002:a25:2415:0:b0:dbc:cc25:8a6 with SMTP id
 k21-20020a252415000000b00dbccc2508a6mr1412498ybk.43.1702497135962; Wed, 13
 Dec 2023 11:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20231203044719.667116-1-sjg@chromium.org>
 <20231209135324.GA3191433@bill-the-cat>
In-Reply-To: <20231209135324.GA3191433@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:51:34 -0700
Message-ID: <CAPnjgZ2yZyVG2yxZ33XbWYk1ax-V9Vdj=wZqdwy7n_uT41-2fw@mail.gmail.com>
Subject: Re: [u-boot-gitdm PATCH 1/2] Use Google LLC for Google
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sat, 9 Dec 2023 at 06:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Dec 02, 2023 at 09:46:57PM -0700, Simon Glass wrote:
>
> > The name changed a few years ago, so update it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Applied to gitdm/u-boot, thanks! Do you want me to do a quick search and
> replace on the stats pages since v2017.10 onward or just for future
> releases?

It's fine as is, don't worry.

Regards,
Simon
