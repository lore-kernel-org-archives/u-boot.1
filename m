Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3998CCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 15:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EDF286EB8;
	Fri, 13 Oct 2023 17:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aEq8+ZQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A72886EE4; Fri, 13 Oct 2023 17:15:45 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24B9F86D62
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 17:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so6945639a12.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697210115; x=1697814915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wfmjW2Q0iCzoAVC3etv/frQLHIeT1tox0zi056VabAw=;
 b=aEq8+ZQQqk4Sj3en3NTbC3DU62G2v8BfYqad6aJTnsNEHTG6xh07t/C4lvyJ5vqKGy
 61xOwKslryWQWYQtOfvA8i2i0HiMXNB1FktnqOXpmKZpuYh1E83DKyfN1t9BUUo6ZNOt
 xm+6118Wgn0GE0ATT64xauJRG4u3B0YCqWLrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697210115; x=1697814915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wfmjW2Q0iCzoAVC3etv/frQLHIeT1tox0zi056VabAw=;
 b=sGfy3a9yDE0kqnnyMGb8iaSa33FJii757zMFTqWWwNxvc8MthXQoxwmaX6Y2EBVm+T
 4Afk4MDxOx1c7r4AzRDxVKqrFEjtVnu+MN6q9I7woXWicQbDFSqNmY7wZKCaqrAr7zkJ
 1A8hTGmKHT5vesAasg8JJKob+zkbLv6dvUPyyjNHYjJdaFuH9qu0GSA2OF3apb65+7VS
 J00zjUTDreMTTWFws3eIvPGYwUZuvU7r4+sBoilmYn4G5/W7oX9YAzD0l6TtzHC0cyyw
 EFIT0kEdy5KKsrSHVDSRy4iej4xJKgsd7qz0eo0HeeeRBCq/WBlXFqc8ehzYY5WE5g/8
 aclQ==
X-Gm-Message-State: AOJu0YzXJeDnjMiKJuPVa97aAPIpWge60nmVw3jwOCKZG9WBzT3kZJqV
 pnOi1tw5GTVwrfxAyfxEuItV7WO/MX6x7UWfaH7UHOFitNPMloM3Xek=
X-Google-Smtp-Source: AGHT+IGa7EssYnxUUHOgtPksff/tK4nMwiAb/QRJg+zGBebmxJIk1Zltb6X14bJW8WozAdsbBu4Dew9ZGZ3seu7bIOE=
X-Received: by 2002:aa7:cf8a:0:b0:534:6b86:eda2 with SMTP id
 z10-20020aa7cf8a000000b005346b86eda2mr294745edx.21.1697210114979; Fri, 13 Oct
 2023 08:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230359.2005249-1-trini@konsulko.com>
In-Reply-To: <20231012230359.2005249-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 08:15:00 -0700
Message-ID: <CAPnjgZ0dHBBAAYLx-jLr7nHSMBcTonH2cHgMJpb1KasbY=V55A@mail.gmail.com>
Subject: Re: [PATCH 1/7] checkpatch.pl: Make common.h check boarder
To: Tom Rini <trini@konsulko.com>
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

On Thu, 12 Oct 2023 at 16:04, Tom Rini <trini@konsulko.com> wrote:
>
> At this point in time we should not add common.h to any new files, so
> make checkpatch.pl complain.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
>
> This causes a bunch of patman tests, for checkpatch, to now fail and I
> don't really understand why, at all.  And that was before I added a test
> for the new error, which I had hoped would clear up the problem.
> ---
>  scripts/checkpatch.pl           | 8 +++++++-
>  tools/patman/test_checkpatch.py | 7 ++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
