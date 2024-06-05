Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF86C27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 15:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1841C8813A;
	Wed,  5 Jun 2024 17:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R4jCozPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC0D87BF4; Wed,  5 Jun 2024 17:52:35 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD77287702
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 17:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6ae1b32752fso34885446d6.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717602751; x=1718207551; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G9DkiBC4tySNS/9onySsxVL3t+/SNNKP5h+Z8OtNWk8=;
 b=R4jCozPlFfc5gZlueQc7DQNYIF0bXekmzSwCp+mWtk8IH7G2s650XWYjWIApcUJ4k5
 7tqgJyOChksa1hQKNKNJgec9liHpGD1LxKPT+B7puFbotOnTmfCiN2ehkkmem9LWdTvV
 EMDdRZLV74hDs31e72AfFS0YZSZXU6GqHmm68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717602751; x=1718207551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G9DkiBC4tySNS/9onySsxVL3t+/SNNKP5h+Z8OtNWk8=;
 b=bq9xngV4HZ5YV6W900T0twaU+2ffvtKHWmr4kPeliFjy9cBpnaAwOtvE4lnSX9QbCj
 lo94kMRNJ8Gt7KlYOhqC8JXcedfBjs34PQAuy0e3FogDqCVr16F9znlkEv2DnNn1yj+C
 JIuFFQ9WStv9GcgWzefEyJ/ZcF1V7YhRWS6cF1Bajywu5SIWAoVE4XSwGNYqzoeU+7j7
 To+aNCX291zsbq4fThWwqRm4nOhVhC6daVgBwSUS9ssA5SMpdZK7ngqhtZump8SMFr5o
 UXzLZ66qA1zBe5lCxlIEFCbk3ExK0AzJu2RQAInClZPnZbk9E9UTIBFbtpiVLjh3O0r3
 0+jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxWJ5H/SibsbIOpWz991+BLQRDFT3SOLqm5dOrHz4DPPMYAQ6Zcj1UVC1DWW767a6JlofdYnyRl/jz+XToB4QG4DtLGw==
X-Gm-Message-State: AOJu0Yz+7WJn+NI3gWRo4JK1bpFmymFp5kX8gpZfT+1HKRo1H0qSMVyS
 Tjz7LZzldchzgcA4XsKTSv0rfG4PKtsDA0KOXi7RtcUkxa5s8PRgQ+PB2FnhuuafjQdnVr4LAgM
 SIOBCll7wXqaNjh6Qe/jTZeskQWPvvPBsTwJAhd3x2HKboyBVbQ==
X-Google-Smtp-Source: AGHT+IGThIt46bIdU+LTwBrx+49FfAUBj3Q1NwfffeO9ZGYTRhAodJ50alaoq86rGWVW0d1jP5GciIoNbxRc0pOPKSg=
X-Received: by 2002:a05:6214:4402:b0:6af:38de:6ac6 with SMTP id
 6a1803df08f44-6b030a9617dmr23676746d6.59.1717602751373; Wed, 05 Jun 2024
 08:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240604195256.1820285-1-sam.povilus@amd.com>
 <CAFLszTgRAwRrhMQfoUDHg9tGaTf4zLBtHR_QWFQRodh4JyoNJg@mail.gmail.com>
In-Reply-To: <CAFLszTgRAwRrhMQfoUDHg9tGaTf4zLBtHR_QWFQRodh4JyoNJg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Jun 2024 09:52:20 -0600
Message-ID: <CAFLszTgb7ihDDqFOhruwFo9zRN_3ZhQu+PQB+Hn6NGLvoBewiw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Cleanup fit documentation
To: Sam Povilus <sam.povilus@amd.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de, git@amd.com, 
 michal.simek@amd.com
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

Hi Sam,

On Tue, 4 Jun 2024 at 20:13, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sam,
>
> On Tue, 4 Jun 2024 at 13:53, Sam Povilus <sam.povilus@amd.com> wrote:
> >
> > Sam Povilus (2):
> >   doc: Remove extraneous curly braces
> >   doc: add clarity to what a "fpga" image is
> >
> >  doc/usage/fit/source_file_format.rst | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
>
> This is now at [1]. Could you please instead do a PR for that?
>
> I am not sure yet the best way to incorporate or link the FIT spec
> from the U-Boot documentation. I suppose we could employ a script to
> sync it?

Hmm actually it is at [2].

So perhaps we can just link to it and drop some of the files from U-Boot?

Regards,
Simon

[2] https://fitspec.osfw.foundation/
