Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B073CCFD356
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 20:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0405A83EDE;
	Mon, 24 Nov 2025 21:49:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HyLZP3F3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65DDC83EEF; Mon, 24 Nov 2025 21:49:39 +0100 (CET)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1596983E8E
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 21:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2a45877bd5eso6260460eec.0
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 12:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764017375; x=1764622175; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EjfcxvuUhcJTeVAklckIWfiYHknf14MOm+tMvE7wDBQ=;
 b=HyLZP3F3iwsc1oiCQygldOev/qrzllRkIm0S5yfQQP1/2wLtOToVmnduFKdqEjz600
 wXqf1l9eJuas0aWzwEGmeAXCuIkULkYwO3CEb8mdnsxL9Cc/C0iPpM3B2o7GVWuGDS/B
 WcoxrRqyAc2BDDkwxlPSkqxrhdwdt6Bam+j5cAe+grWhIEGeasnPRP+olWjCOvaRxZ0K
 KTrFLLFgVW31n7qA6+DFqBHmfR1M7bcfqvIDhq+vBifUYJZoq3/6bVp1boOnGoO72KwH
 9ZmeM1exUNcvVbk09Ryv8JdNHLQBlQiebpp+IJCTXQcmCItHlP++BCJd4G6uwyp7oshs
 4rmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764017375; x=1764622175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EjfcxvuUhcJTeVAklckIWfiYHknf14MOm+tMvE7wDBQ=;
 b=kxu85IIXeQQhmb0wLbXMdOZVju4K9L4mMFkcUx3JJZP6Fn1Wg1wwbEd4Ski/zMKmWR
 fsXYbkydyiXirgPa8r6C7yW2W48r+zoHLLQughdchMx7qObNIWPvjlKAcssNMn9hnbZE
 ykdl9bylTV8Nw12DGwDg7JsM7JvZGOK5i/SpbgI7X3vtnblD7ZFkfaYkiYdFd8jnQSne
 stJ4e5UPyKRoJTvIqc8l+NzJvTDYEQT82+9t9fNibySUkONsmbmoDN21aFNC0MP7NEIx
 niRXXnVsBZHRleiUlimpowc4Tslp3/Nq4dvfhF8NybX1vXF0zJDDUOOBM5FHxKQu0wyA
 HOXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAaBEITAnUTZCqPdrppLyLiHnZvYhFXnBhmHNVCDRFUhRpvNsXgnMjmwsU7XRq6QnswvdSdMI=@lists.denx.de
X-Gm-Message-State: AOJu0YyrFqSnOg5nAClW699sdNrT/soPxYj32ddjU1uu6A2UI3HfDyP8
 u6Zu4f/un5Tna+72jwALTizI6fz18KFBGplomi0W5rExMesO8f6Fkm5AuwgAl66anrSk/GVJ6xp
 eF5JigVdTwu65LW2zn9ipy0s6l5ZShadcAB0oQoO3Vol80X4VfU7L
X-Gm-Gg: ASbGncuZaQvAFYwIRsRcl9fZRuq9y75DnH/2YR2+Ug+IIZIEImBdtH7xAZaFpCMT+sp
 +Hqb976vYsr9e2zk7tz2s1Qh7bbnHCZmYh3XluszirVMEKQghLmk6/Hg4eiGguk/w3d+tNrOh+y
 BWY8E6Ez03nSvD08OY7oXDsa3OJFHpYkUHRqxCYDrPe3HaXpCptlzVIHbHP7MNAtBwJBy8GpQvJ
 sBOcPztcERV5DWMl0PXa2l0QnPHc0N2RygQYBZuHDtJLlQKYHs/PaZbVGXOGFtofOB/8o7akHjW
 wpTWoKSi6jel0dCLZEmKJWvKlD8QsQ==
X-Google-Smtp-Source: AGHT+IHCzlLPEwDIyTzBBuPsrRUfUXCFHFxuTaQYKhzhrBcOHFZ4SMVX2UeW9vF3Z9DOm/xaQ24DhE6HlWteTewWJTE=
X-Received: by 2002:a05:7301:52c5:b0:2a4:6d38:527a with SMTP id
 5a478bee46e88-2a6ff530720mr7108187eec.2.1764017375386; Mon, 24 Nov 2025
 12:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20251027002458.16741-1-semen.protsenko@linaro.org>
 <20251028165056.GG6688@bill-the-cat>
In-Reply-To: <20251028165056.GG6688@bill-the-cat>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 24 Nov 2025 14:49:23 -0600
X-Gm-Features: AWmQ_blETenS_4FV6u3TLvmAwEG7EecMyZhrk6r5JZeluEGCIRxSE86R2ZEH2xI
Message-ID: <CAPLW+4=JOiPk+gOHH4umevJxJweitAn3dpec1xTe9ZrgCAVAMA@mail.gmail.com>
Subject: Re: [PATCH] autoboot: Fix inconsistent countdown output
To: Tom Rini <trini@konsulko.com>
Cc: David Zang <davidzangcs@gmail.com>, u-boot@lists.denx.de
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

Hi Tom,

On Tue, Oct 28, 2025 at 11:51=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Sun, Oct 26, 2025 at 07:24:58PM -0500, Sam Protsenko wrote:
>
> > Commit 5f70be08b015 ("Fix autoboot countdown printing wrong") introduce=
s
> > inconsistency in how the countdown is displayed. For example, in case
> > when BOOTDELAY=3D5, the next output is observed during the boot:
> >
> >     Hit any key to stop autoboot:  5
> >     Hit any key to stop autoboot: 4
> >     Hit any key to stop autoboot: 3
> >
> > That happens due to different printf format (%2d vs %1d). Moreover, the
> > mentioned commit fails to handle the case when the user is holding some
> > key before the countdown is shown. E.g. if BOOTDELAY=3D101, the next
> > malformed output is being produced:
> >
> >     Hit any key to stop autoboot: 1 0
> >
> > That's because the fast path code wasn't modified accordingly, and stil=
l
> > tries to erase the number using '\b\b\b' format.
> >
> > Fix both issues by introducing a dedicated routine for printing the
> > whole countdown line.
> >
> > Fixes: 5f70be08b015 ("Fix autoboot countdown printing wrong")
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>
> This seems the reasonable path, given everything in the following parts
> of the thread, thanks.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>

Since there are no new or outstanding comments for this patch, can you
please pull it for the next release?

Thanks!

> --
> Tom
