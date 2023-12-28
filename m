Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C02C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210F087A15;
	Thu, 28 Dec 2023 14:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QQu7Ynvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1599B8774E; Thu, 28 Dec 2023 14:37:18 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8118774E
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-68067be5393so5828156d6.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770634; x=1704375434; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YcqIsNxRsOrTCZLOBHXbqs+1Z/SMstRyZt9Qsh+UgY=;
 b=QQu7YnvoFIsLE/145UJoiSeCem6YAZV0dC87XiFHjU4spk06y5YUTHXKhl82p/+vR/
 JDn3gz0QF0IDaK/txz86r0zeJFTB4qD8g/zCj0wV993RlMfYMpIgp9t/fdUIGpbRafsM
 MPv5HhVnm4auRGm850d1/ylDw8LPeJTsAWZSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770634; x=1704375434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YcqIsNxRsOrTCZLOBHXbqs+1Z/SMstRyZt9Qsh+UgY=;
 b=U9whdb019FGvQrDyIWAwXOn9YNRoD6HGjnOkQw9vTJ0P7FnFVHHf/xKkiw6WqGdhmA
 uZg6tkPYNCj5hNpjKYPPxACMTSAxZ+6dYWds+FGdM/6YXTVBuFVwKa0G53uS7tU8fWwF
 ffY2TlbmsGFBx1oi/T69MVwf7h1kGf4liHfYqL/Zju+aG9q4TUfnMEL76KVBHtE1Eo4+
 Zl1/iMsU3DDaW03AnFpTZ1nSg0ZQDmIyvDRdWjrKUf0Q7s0eLA4zd27i2k8hZMom+wqZ
 W9x4QtHJiMJyrsNoUB7elG9BaLYlPIxvy0wfBU/b01weU8SmQbdrqiuYpypuOumjId83
 VpYg==
X-Gm-Message-State: AOJu0YxtbVV0mJrbF0bjgxXPUrwBHbMX3zdFaTX9yezNIx53beW97CKp
 bNwPieSZh1sRVZhnRlf5qbGLdWh/keGGXXvVJjvGXYkhwJMO
X-Google-Smtp-Source: AGHT+IFklW9qO1Sj0Tvrb/KCTtP5d5t8efhVzjjzaePYVERVSOdtwvEHG8Kf/6HPHog7yOZFKtECKdZgF+bFFfREgZg=
X-Received: by 2002:a05:6214:90b:b0:67f:fc06:5ae3 with SMTP id
 dj11-20020a056214090b00b0067ffc065ae3mr6109036qvb.81.1703770634754; Thu, 28
 Dec 2023 05:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-5-sjg@chromium.org>
 <CAC_iWj+yGhUVFh+vJ14C2htibdd289SrPjz0Y_r3GL4uF4Zdog@mail.gmail.com>
In-Reply-To: <CAC_iWj+yGhUVFh+vJ14C2htibdd289SrPjz0Y_r3GL4uF4Zdog@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:03 +0000
Message-ID: <CAFLszTgXZ3fMZkuYRJUzSBv-VT659Q5bYLyVkEh4=-36TM3+Bw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] smbios: Use SMBIOS 3.0 to support an address above
 4GB
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Dec 27, 2023 at 11:05=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
> >
> > When the SMBIOS table is written to an address above 4GB a 32-bit table
> > address is not large enough.
> >
> > Use an SMBIOS3 table in that case.
>
> Maybe I missed this on the previous revisions, but is there a reason
> we don't always use SMBIOS3 now?

I am not sure...there was some comment about it not being supported in
some cases, so I have tried to accommodate that.

>  And perhaps try to install SMBIOS2 if
> 1. we fail

due to?

> 2. and the address is < 4GB

We could, I suppose. Effectively we would drop generation of SMBIOS2.

I really don't mind. This whole SMBIOS thing is a bit ridiculous, if you as=
k me.

Regards,
Simon
