Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B5AC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 02:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B5B87608;
	Thu, 30 Nov 2023 03:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SSbHBPnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1D31875BE; Thu, 30 Nov 2023 03:45:54 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 853ED86C47
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50aab20e828so684166e87.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701312350; x=1701917150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PgpNJCkNaz8vhzbN4iVV0mrFzetZs3VOM3BgMunrvtw=;
 b=SSbHBPnWuSlPJnql55J7FHd3X8p+mQWvQFifUe94hFYxt2A+kWJlIjoYnrfVJt4sls
 ITwbKYf5YNRhBTzdpVsBMdhMpFCV/Mdsz8UJs9vjzP1wXWgNc7nCZxNJWfyqrLWOuj95
 ys91b0f65F511jDr+ms7XNnjbWY2977dF1mwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701312350; x=1701917150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PgpNJCkNaz8vhzbN4iVV0mrFzetZs3VOM3BgMunrvtw=;
 b=SuVmYK7TFyHmIqDvUnKH4VTV+DZrnnZGfIlNEgqWKMY1BILua6s6E4TRvL7RzXBI+W
 /C17FMIlC6k9OquiXuyZAW+lzvMsKXMLFQuNJfl96gyq6U8rV/nqN8pC907mlTbZ7/Pr
 l5sTgNPQ8osZFJA9REfH4Jcf86v+zHWSRHXx6JFxKP1OMevUL5ZHmV6L1gmNAmZNZufN
 LPxSY02k1woRhmZO0/BK4mrS8Yaub2o/tHNW5Up4hrEpAkMtGeVAOHmDNsLqgxuW/pzu
 L2rM+3WIgp31bhpzdwQ58yXh4pEv8ZfP7OCZ3CcpNJpsHiQprlFEmpQ7e707sK0tO4qT
 CsEw==
X-Gm-Message-State: AOJu0Yx9tQrASPXGxP9jAWndXh4nOkZP5smRhjiFRxKrG158SWL6ijhj
 /SXLNgg2BzXnxrmfqv9UZyNObMPh3TsuazfAV2rnVg==
X-Google-Smtp-Source: AGHT+IHLwSF7E66J04MUW709Mzpwehrw+fCHCJeNosR9kdiuXk41HFtFblv6wbw1/38IDHhJ+Plz3msVj3sEJ2iBu6Y=
X-Received: by 2002:a05:6512:1242:b0:509:cde:952b with SMTP id
 fb2-20020a056512124200b005090cde952bmr17786849lfb.10.1701312349559; Wed, 29
 Nov 2023 18:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-2-maxim.uvarov@linaro.org>
 <20231127181607.GL2513409@bill-the-cat>
In-Reply-To: <20231127181607.GL2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 19:45:28 -0700
Message-ID: <CAPnjgZ2CGQpCkBbHtSUAjGosiNv8XPs7P5MrO_gtjPzQ5QWoOQ@mail.gmail.com>
Subject: Re: [PATHv11 01/43] submodule: add lwIP as git submodule
To: Tom Rini <trini@konsulko.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, goldsimon@gmx.de
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

On Mon, 27 Nov 2023 at 11:16, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 27, 2023 at 06:56:44PM +0600, Maxim Uvarov wrote:
>
> > add external lwIP library as a git submodule.
> > Use STABLE-2_2_0_RELEASE tag.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>
> And just for the record, we'll re-visit submodule/subtree/whatever later
> on, this (and the final parts for CI to be happy about it) are a means
> to an end.

While I understand this, I would still like to see a patch containing
the actual code. We are at v11 here.

Regards,
Simon
