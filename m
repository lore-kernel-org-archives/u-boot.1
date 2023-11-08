Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C79C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 19:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ECE6871A7;
	Wed,  8 Nov 2023 20:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="j+TJU+vX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E94E871DF; Wed,  8 Nov 2023 20:16:28 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B0DF871A2
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 20:16:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dimorinny@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-54357417e81so1945a12.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 11:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699470985; x=1700075785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n8rrYBoIVGNEKU0eX6gBX0jQrrw4l3ShYbvpxLhZvqE=;
 b=j+TJU+vX9zC9QZn1C6tgZ7nQVs3JX/P0ga8mPcpDLd2l3va4JePlOt+0SfFVS8TKv6
 wg0fz1dGK75QPmzxzNfeo5aqcQsvA8N2ird6UiOfSxZ9A/7gdW0qxHDmdxJRpJI8zBEp
 8RmLEcfTo2uLUtezh6gKS5hUlg7AbLwCUP1n3wxF2pEBWjxrxvgW/sqj1aC+Pjzb374e
 7pi8R6gS4hEPqxLzhpo1pkys48jFMBPFtThPnaIDBG3QiOiWRpZA/nNoXU5eTQCBPkwx
 dCsIY/CRg9UVCzM8eR2AOY9PR6seREocKusm+EvbN7U0gdP/olN5LNiKU7/lXezwuLu/
 qV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699470985; x=1700075785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n8rrYBoIVGNEKU0eX6gBX0jQrrw4l3ShYbvpxLhZvqE=;
 b=XvwotmvsNh2uRAMMdfM0K9wFFXzVh+hE0xXUnm3EzSnBWge+kAoyFcWjxxAjg+ra4v
 P7gWtAMQ2NlvttiDdczYsDakGARv+C4E7hhVs3vWTdwvkjyDami9jd5CzREluhw2CKRo
 TV5XEQ45EC0yOlAS8Pe1jp5Q5npTNFt7zePMxGDjVPmPAmMbwGvqD4qy5hfjTPdhDnnS
 zt2DW9xpQEswT2/D7SoLVAUsZwfQaNi/E12nwY7s4qwgJCf/K8uspbheq7b55sR/EzNK
 e/UUWWS0BY4EUlpXH1ucllla047M+8CvcyfYel1sLEtFUz6tMFxg4F9JOXY/lDMCCbuJ
 +yPQ==
X-Gm-Message-State: AOJu0Yx0qVSuamcLKaAxUjQ2w+zUbx5cBp+dHiCT62IGSkZI4kvy9yNW
 KoadRbcuWbVAYlv0HImMdeo7DuM0FMrNXY1RofrltA==
X-Google-Smtp-Source: AGHT+IH1j5DEY/UyDDLeKiGTfv9O7Iny9MU+wVLkAhObcAMWvfgUPO5jqftJ+hVTsKwjcbyyIgPKTsrMz7+KalSBllM=
X-Received: by 2002:a05:6402:497:b0:545:94d:7b with SMTP id
 k23-20020a056402049700b00545094d007bmr5826edv.4.1699470985157; Wed, 08 Nov
 2023 11:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20230725215658.2118831-1-dimorinny@google.com>
 <20231108144549.GA1077075@bill-the-cat>
In-Reply-To: <20231108144549.GA1077075@bill-the-cat>
From: Dmitrii Merkurev <dimorinny@google.com>
Date: Wed, 8 Nov 2023 11:16:13 -0800
Message-ID: <CAOWkq4=swv0HtS8rUEWwPYZV50B88AAgLHjFt9ykJsOpUrQeoQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] net: split IP_TCP header into separate IP/IP6 and
 TCP headers
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, rammuthiah@google.com, rfried.dev@gmail.com, 
 Ying-Chun Liu <paul.liu@linaro.org>, Simon Glass <sjg@chromium.org>
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

Hey Tom, huge thanks for sharing that. I agree lwip is the proper way to
handle this, will try out this patch set and eventually migrate fastboot
apps into a new stack.

On Wed, Nov 8, 2023 at 6:45=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:

> On Tue, Jul 25, 2023 at 10:56:52PM +0100, Dmitrii Merkurev wrote:
>
> > This allows us to reuse TCP logic between IP and IP6 stack.
> >
> > Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> > Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Cc: Simon Glass <sjg@chromium.org>
> > =D0=A1=D1=81: Joe Hershberger <joe.hershberger@ni.com>
> > =D0=A1=D1=81: Ramon Fried <rfried.dev@gmail.com>
> > Reviewed-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >  include/net/tcp.h | 54 ++++++++++++++++--------------------
> >  net/tcp.c         | 70 +++++++++++++++++++++++------------------------
> >  test/cmd/wget.c   | 48 ++++++++++++++++++--------------
> >  3 files changed, 85 insertions(+), 87 deletions(-)
>
> I do want to thank you for your contribution. However, the long term
> goal with the project right now is to move to integrate lwip as the
> networking stack (and in turn have more robust IPv6 and wget and
> similar features). So, I don't want to pickup this series (unless you
> think it's still important here-and-now, given the above). I would ask
> you to please keep an eye on that effort and either try out v10:
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D374882&state=3D=
*
> or keep an eye out for v11. Thanks again!
>
> --
> Tom
>
