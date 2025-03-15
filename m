Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6724AC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 12:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6BEE80F4C;
	Sat, 15 Mar 2025 13:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="esL6M/Ui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4359080F70; Sat, 15 Mar 2025 13:57:52 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496FE809A4
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 13:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5dca468c5e4so5193375a12.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742043470; x=1742648270; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W48Z/ZazGxMy15UKGkEMBx1FY7T41hE2nvIniqqxlwg=;
 b=esL6M/Uiv5sg1g0N5oigN6pfvDqjW39bxKrsHiDOUAt1AisUaP6ACEl8VxfCDVDaFv
 t3uynPxbv/VEOy+szRbDLNQMIXGuiK0+Hv//TnJQRwr9/4bYGZflKWtbOQ0T3u0BgoAO
 4gjeoM6dRZpEgZt9qxjQLfeCOALr7Zl9hDGb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742043470; x=1742648270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W48Z/ZazGxMy15UKGkEMBx1FY7T41hE2nvIniqqxlwg=;
 b=tuvo25PwBjGftwLSkYJDxLjamWZPEZHH7iJDNMkUBjgo0k+a+QpOedyM9PBSdLvMjx
 +rOE3kFNR9teViS0rn7uCBtHAENiQ6oh7/I7jPr9P24tqGq/gQGQ4T4hh8K65H40Lj5n
 BJS6h/wzBuKAYi484Bw2SBXb2CCSGPt9xH89nVnWrdLDc/6mTJFkGEn0TT/BbFRwbAcB
 wBE2OPyShNr2ZWBehJOZTyAe8xw6jdmfuQwxSXsJ+zFnm707+DZVhriJVnjq6p5lKQ2h
 /rvCV1v2AVv8GSgb7+RIU6jF1o3IE1kKyuxAbVlqJjgBBpfGr3xCDsippL8f0j6u7ena
 GAOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU82VcKqWlC/6VMKtuwF4mZBglTXMYDbasW4+IL+nYN8zsxzJJBg5GHiDux1zHdvH/uEBjst/s=@lists.denx.de
X-Gm-Message-State: AOJu0YxsM+s8St+K+n06XyTUo/w4CkVmPWQNeDpV16MvgMdvvqkmOwO+
 snENt9BJS4JbEmdtC+tPp5nQNNu/4CaRuHdGZ5licIRi2t0S07VdhTRrN7VqjPwMkOxcWQrwYIS
 D4kn0CzqvhV0ScB3WkRmGkQXMM2fngmlfYtyB
X-Gm-Gg: ASbGncuypJdE5sWwKPghguOVZuX7sgVA3WCFRu5lhZMquiuS591aUF3rxL2+uGRDzGn
 ceHheGK/xNMIRetQO2Hv0wmqUgD9oYtofxe3nlggJwm15RfWyRFyzNBjZI6x0C0vdz8wwGsXQNK
 vGPqMzDrbxhqXzEJxU2z8O88uaKQk=
X-Google-Smtp-Source: AGHT+IFURLHqj3/Rw9EwBRzMU08SukuuAO4XwuQp9e6Tzc3dZLfRS289hSFYIzTGqRZ2T8EvzerAyGL/F+Ppk2bcM+M=
X-Received: by 2002:a17:907:d92:b0:abf:609c:4fa8 with SMTP id
 a640c23a62f3a-ac330109976mr701145266b.12.1742043469777; Sat, 15 Mar 2025
 05:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250314181031.7978-1-swarren@wwwdotorg.org>
 <20250314183203.GE2640854@bill-the-cat>
In-Reply-To: <20250314183203.GE2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Mar 2025 12:57:38 +0000
X-Gm-Features: AQ5f1Jrc6xqemm3Qv0AnthwNjP-dpJLEkh8xTckf2AUVOsAz4bzN2ABgfo8rdfA
Message-ID: <CAFLszTjKJjt6wPpHRjVYTNQKdavPvgC22AHYZve8agw8LbZZiQ@mail.gmail.com>
Subject: Re: [PATCH] disable mail for swarren
To: Tom Rini <trini@konsulko.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, twarren@nvidia.com, u-boot@lists.denx.de,
 Stephen Warren <swarren@nvidia.com>
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

Hi Stephen,

On Fri, 14 Mar 2025 at 18:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 14, 2025 at 12:10:31PM -0600, Stephen Warren wrote:
>
> > From: Stephen Warren <swarren@nvidia.com>
> >
> > I haven't been involved in U-Boot development for quite a while, so
> > CCing me on patches isn't currently useful. Add a .mailmap entry that I
> > believe will turn off patch CCs. This can always be removed if I become
> > active again! Remove myself from a few MAINTAINERS failed and the git
> > mailrc file too.
>
> Thanks for your time and contributions over the years Stephen.

Thank you in particular for the test/py framework which has formed the
basis of U-Boot's CI and has served the project extremely well.

[..]

Regards,
Simon
