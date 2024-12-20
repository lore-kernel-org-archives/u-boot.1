Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A40E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 17:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B21803B9;
	Fri, 20 Dec 2024 18:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BZi8wtnO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BB3480381; Fri, 20 Dec 2024 18:37:45 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 368228042A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 18:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d7e527becaso3319001a12.3
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734716263; x=1735321063; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G0vQN4Au18fnXODqQXrjPWTgFJnwEAI7nayV8hS09MI=;
 b=BZi8wtnOADJvHxdHni1XqWY7m3S3PtDxb2OUn+PsZ5SewGMkjAh+fDUAtn1NYjxbrn
 9TUjZrc12T7n9C6ccFC8oRMSWy0YTIUu3fXqkbaw3KDuE3BhOUEb7cfYCXhiFJt8/Fvu
 7DJWLYI8fcv/EmZW6JHcH5/3llJZfV9QpoBf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734716263; x=1735321063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G0vQN4Au18fnXODqQXrjPWTgFJnwEAI7nayV8hS09MI=;
 b=ja18YMoJWZlKmJRHiiojtiFtoykynbIoTUZPwUmbuRFzn8+5a9cs7pwZZLUgjoyWAj
 xE495FGrq+Dgz825DQMb+MyVYoKO2RaQeDp8YTVafjzY+SHk2Vt4DAjElQ0ZeZen7z/e
 OwTiILA2A1a455ioOXdKE7lvbzugAm9jJ+aVIKK1tabOLxHqR+L4eHVAOAJOrVS9ZLB0
 MawIdz4Fb3777BYA5B9XvArkqwFOw54K3D8RDSRZapsBT9dqeYuaSRueXSJfZ6pbrQbb
 eHr4AEuih0v2Paq042+QGNtsT3E/wxPA6n/6mwGo4T6NG0L9V0e/tIepwkFl6YXOjQ9r
 zGKw==
X-Gm-Message-State: AOJu0YxN2RNFqKdGRObb/3QSngTttzZgCnXz5KrJUFCk26M0BBOZG/rr
 8wcEoO3tNLh0TfybAizlO6kIQ8pXybQKDHL+9+bM7pYA7G7LZg84xmJxIFA60bIlXdvwUv/F+cO
 mEjauWEmAnOjUDP88cFnSqDf341pK8P48BNGLMTP+ErEy7Jw=
X-Gm-Gg: ASbGncvqKwCU1q4L/ck535Ci06dSQqwztvre7aGiGoF3DXeYzkbLOURhYZRGG/RUnzc
 NqNxBC4hk9iHQMhBjxBQPFWzOEAA0A9Aaj8ejxy0=
X-Google-Smtp-Source: AGHT+IHR+nA0RAL+5ZYedleNRHip5if3vAOQAbC5z9A/dm4qzjCk4UyhhyOtSszizWh+HpN4P/vdWLkJpzCUFWVTuUE=
X-Received: by 2002:a05:6402:5204:b0:5d0:ced8:d22d with SMTP id
 4fb4d7f45d1cf-5d81de05c3fmr8935275a12.22.1734716262707; Fri, 20 Dec 2024
 09:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20241220003438.88899-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241220003438.88899-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Dec 2024 10:37:29 -0700
Message-ID: <CAFLszTi_g+TS9eU5JqFoTzcxf7dOhCV7QPaCPr=fch1jbm9gAQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: move tools/buildman/buildman.rst to doc/build
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

Hi Heinrich,

On Thu, 19 Dec 2024 at 17:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> All documentation should reside in the doc/ folder.

Except tools, perhaps?

>
> Avoid the symbolic link by moving the file.

As mentioned on irc I suppose this will break 'make pip' etc.

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/build/buildman.rst      | 1410 ++++++++++++++++++++++++++++++++++-
>  tools/buildman/buildman.rst | 1409 ----------------------------------
>  2 files changed, 1409 insertions(+), 1410 deletions(-)
>  mode change 120000 => 100644 doc/build/buildman.rst
>  delete mode 100644 tools/buildman/buildman.rst

[..]

Regards,
Simon
