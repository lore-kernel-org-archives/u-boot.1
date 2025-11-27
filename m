Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD5DD11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 12:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6FD8432D;
	Thu, 27 Nov 2025 13:16:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h17l4WNg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F7B842C7; Thu, 27 Nov 2025 05:15:45 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A5D842BF
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 05:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=davidzangcs@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3437c093ef5so467801a91.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 20:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764216941; x=1764821741; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o32Wa6PqOrZUKiHEIDfKUl6PzZPpX4K6DMrjKMjnNTY=;
 b=h17l4WNg77ZC/WmwyoEZbmya7ZwtbkMwJEZASDm2eudfvS/LozTNvt46XGzQgfHNQ6
 i0UIQIvWNyE9A+2wANhMIZPKKSZeYr0q+zmJp4Tz9QP9iw1xUZhOyR3/zMRLElJA/1l2
 fLZQIU+45rsBK32OWTRec3RNniKgJScKBRI01N+D8zObY+DjcZQPJKazgXTGsZwnS8he
 pxSwInldYOIHGyFYm+aMcusZ7gQ45niwqMpIxRnhlumnMgi7/EwKJmddmCnOmm4zDyHm
 3LjaQ1OVYnculxQ2UToCJSZ1ZZD1yGGfIwFfK8iGq4VwGWBjhenT3Rit9Ci+EyaKtKhZ
 hdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764216941; x=1764821741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o32Wa6PqOrZUKiHEIDfKUl6PzZPpX4K6DMrjKMjnNTY=;
 b=g4N7scinlhWN/MKG4U9HZD1VtFBl0pisWRUcOElHpR2ic5TC5WvOA3Ief+EieUXUop
 pfcaBV4VAGtaTJhFgGpB02Bk7i4DwjuTodXVStsd9O64x502h7BlLaMFu5M+P7199uGg
 Poi8YMiM3yj6yTHW6VhgPT7hzX/DMJXr8r/MG/Wi+teSHiTqGDBi/s6/4KCWAf6+1lB1
 w2PQlTAIkd0JwVeTUI7Q5659TEjmN+CMd5/a0vrULGkBEVZjyvgfVJO4A+L1sqAhZ0ah
 5rQi23dfivr6OvXgdsHmPeW484SlJoylf5sI09VQp6Yp1g+6BD32f83E+bJR50dWN/FR
 XJ6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa6yDun+c7A/c6+Amipu+wSIj1IWyO2KCM008NWOsXZ2XDkuFFqZIl9/Mf2FHaN8UxvDoxj3k=@lists.denx.de
X-Gm-Message-State: AOJu0YwF67jOBs6FDN75f52HRyFcGalzM8TzkkNCv98tM9ss/kgPPC66
 IFhX+RRQFlg/GhekzTXd3T8vxn5kBFQ6m9O1Pr8RTp40qYA8LaaDVpDg00jkemdXWKfDRNXHrRv
 eiL0suc/tMiAdYf0wUwkIgTGBK5pXJzNw/Ka5
X-Gm-Gg: ASbGnctweC0v9Hl7XkqTzzgnrHJnZPsrm5qmzjz6yU6DGuHq0iubZMn5yN5ohV+6WKB
 tkTl6fDZb26/UwlWtmxmYqhEZUrGAyI9AqYbpiiNK6vkXPXOb4h3v7+aXRuSJWvYh/Cn/DTr8+W
 dGVNKj05OusZErzIRu4B3/9UwUqFckpWcAhrVu+taylHbgfWTnZn6xC8bgBVhmvaR/1ZM5FJ16v
 LwAtdLKdUsXICQ5xzICsnxRVsS23pLsWsarIeS2MGc6diDUqJva+KEFOlfY5E/0ePLu
X-Google-Smtp-Source: AGHT+IEYJw3Ag4A0FDyMNIi/ZlbMOjQ/rLwu2HSlCV5tN8X3i+gYSJM+liRMrYgpwliW84e7nHpEYYOEP2WEjt+FnWk=
X-Received: by 2002:a17:90b:4b09:b0:341:6164:c27d with SMTP id
 98e67ed59e1d1-34733e2d49amr20769526a91.3.1764216941495; Wed, 26 Nov 2025
 20:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20251027002458.16741-1-semen.protsenko@linaro.org>
 <20251028165056.GG6688@bill-the-cat>
 <CAPLW+4=JOiPk+gOHH4umevJxJweitAn3dpec1xTe9ZrgCAVAMA@mail.gmail.com>
 <20251125165112.GR2125796@bill-the-cat>
In-Reply-To: <20251125165112.GR2125796@bill-the-cat>
From: David Zang <davidzangcs@gmail.com>
Date: Wed, 26 Nov 2025 22:15:30 -0600
X-Gm-Features: AWmQ_bmvTK11VgnqiIBAbT-wekwm8_SYVFBToNfc1mvMN199akL7pwV5EMzJLF0
Message-ID: <CACwB3C8g2QGzQESKGnBr3BFU84y8H7d1K2T5Z2cBrvZ1U529Hg@mail.gmail.com>
Subject: Re: [PATCH] autoboot: Fix inconsistent countdown output
To: Tom Rini <trini@konsulko.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 27 Nov 2025 13:16:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Thank you Sam for the fix.
Acked-by: David Zang <davidzangcs@gmail.com>

On Tue, Nov 25, 2025 at 10:51=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:

> On Mon, Nov 24, 2025 at 02:49:23PM -0600, Sam Protsenko wrote:
> > Hi Tom,
> >
> > On Tue, Oct 28, 2025 at 11:51=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Sun, Oct 26, 2025 at 07:24:58PM -0500, Sam Protsenko wrote:
> > >
> > > > Commit 5f70be08b015 ("Fix autoboot countdown printing wrong")
> introduces
> > > > inconsistency in how the countdown is displayed. For example, in ca=
se
> > > > when BOOTDELAY=3D5, the next output is observed during the boot:
> > > >
> > > >     Hit any key to stop autoboot:  5
> > > >     Hit any key to stop autoboot: 4
> > > >     Hit any key to stop autoboot: 3
> > > >
> > > > That happens due to different printf format (%2d vs %1d). Moreover,
> the
> > > > mentioned commit fails to handle the case when the user is holding
> some
> > > > key before the countdown is shown. E.g. if BOOTDELAY=3D101, the nex=
t
> > > > malformed output is being produced:
> > > >
> > > >     Hit any key to stop autoboot: 1 0
> > > >
> > > > That's because the fast path code wasn't modified accordingly, and
> still
> > > > tries to erase the number using '\b\b\b' format.
> > > >
> > > > Fix both issues by introducing a dedicated routine for printing the
> > > > whole countdown line.
> > > >
> > > > Fixes: 5f70be08b015 ("Fix autoboot countdown printing wrong")
> > > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > >
> > > This seems the reasonable path, given everything in the following par=
ts
> > > of the thread, thanks.
> > >
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > >
> >
> > Since there are no new or outstanding comments for this patch, can you
> > please pull it for the next release?
>
> I'm going to take this for -next rather than master, soon, as it's just
> cleaning up some output. Thanks.
>
> --
> Tom
>
