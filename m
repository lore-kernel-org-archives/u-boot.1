Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38538D30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7887892D2;
	Fri, 18 Oct 2024 16:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aupvwMjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A310C89227; Fri, 18 Oct 2024 16:58:51 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D027892B7
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7181885ac34so616546a34.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263362; x=1729868162; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mr/U29cUQCuGPbzEnrMggtsU9WF2C85lTH11lbrPR+I=;
 b=aupvwMjmjkeBnvDY76C7Q+PCnxDwlnud42Ih6xaG8MpAYIB9RxK00RGADBnbX901gV
 XQZnr47uQvJiXst+a4dJyrGpZYQGUpT5+UuLb0aDrGpGgcbHTFAdmgfiC+Dnb4zHFSgq
 P8vMrHq7hMK/6ifPGm0wlv4E247peF++ClprM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263362; x=1729868162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mr/U29cUQCuGPbzEnrMggtsU9WF2C85lTH11lbrPR+I=;
 b=a+deJskiIX0foB3xl21H0mN0dNKjnCidZ+TzwHE1peJY0IwP2HsG6ATX9VQHLj9C8W
 +YoCbrHNZsTmF3UbXfbHcm+T+izCnnf65vnMYhrC5qQx1cvT8Km+JXjWzHVtjaz2b/Ej
 Y9VJUz6Xqckv29qTT23SiJ7tVsiDyoDrfJW44sYMyDw1GfwN8O3kfGkLiMq2MT2R5tZO
 wc0HgUok9nuGnF0cnQgECMmldqhiH8RT8Rhn2oYFmAbL13MPVLv1Z/oc8mVT/248s23b
 zTLfxUb7D7cS/pw80AVHtCxnyNFO6Ch6QRZeTLBbBO+AxpUb2chcfTi4SUwju1L7YR11
 7OiQ==
X-Gm-Message-State: AOJu0Yz0V7vqpNUNHFY82dN0U9V340b2T9XiJeYtQaqGpODqDGCBfihk
 O3eNENi+RBqn3AQFWifGWIGyEcNjsoNX8WoNJtV04A+WqsOVMfUHW/rXC/BKpKZDKPIaoF4hvj/
 wYY10w0mf2q5qvPSmw+ImcONwLlbtY7Vo7Mi0
X-Google-Smtp-Source: AGHT+IGxuRSIM/GxMRQjZFR2cyrweNbCVgzhtpLk8k036ESL0QGdjxbSfd5uIOKpqtulwIcskCkpcAAm3x2Gu9QADUk=
X-Received: by 2002:a05:6830:91b:b0:710:dab2:684 with SMTP id
 46e09a7af769-7181a89f09fmr2035648a34.25.1729263361981; Fri, 18 Oct 2024
 07:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241018030027.842749-1-sjg@chromium.org>
 <87jze5ao26.fsf@prevas.dk>
In-Reply-To: <87jze5ao26.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 08:55:51 -0600
Message-ID: <CAFLszThFNXxM2cWdMHWFP8NsH5x6-X9u7aWNpPokgLWRAA55=g@mail.gmail.com>
Subject: Re: [PATCH 0/8] membuff: Add tests and update to support a flag for
 empty/full
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marex@denx.de>, Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>, Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
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

Hi Rasmus,

On Fri, 18 Oct 2024 at 01:05, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On tor, okt 17 2024, Simon Glass <sjg@chromium.org> wrote:
>
> >
> >   membuf: Support a flag for being full
> >
>
> No, that is the worst of all worlds, especially with it being a
> build-time flag. The right implementation is the one where the head and
> tail indices are free-running, where you get such a "flag" for
> free, because you're not wasting the top bits of the indices.
>
> https://www.snellman.net/blog/archive/2016-12-13-ring-buffers/

Thanks for the link. It is an interesting read, including the
comments. I've only written one ring buffer in my life and this is it
:-)

Which option do you suggest? We don't currently restrict the size to a
power of two and that does seem like a strange restriction. It will
make it less useful, e.g. in extlinux_fill_info() and potentially
replacing memgets().

We actually don't have to worry (today) about threading, so option two
could work, I suppose. I don't like the 'length' field any more than
the author, but we could have a simple function to turn it into
(pointer plus an empty/full flag)

The power-of-two restriction could be lifted by use division instead
of masking and making sure that the indexes keep to reasonable values
(say no more than twice the buffer size). In fact with the limit, we
could just subtract the length from the index when accessing it, if
needed.

But overall I think I'm with Chris.

>
> If you want to do the churn of renaming anyway, I suggest doing it by
> adding an implementation using the proper scheme under the new name,
> switch users over, and dropping the old. IMO, this series as-is brings
> no value (except for the tests, of course).

OK. Do you think this series gets us closer to that, or further away?

Regards,
Simon
