Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAD6C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 16:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38DB1887B8;
	Mon, 29 Apr 2024 18:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QhjN1zhr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D53887BF; Mon, 29 Apr 2024 18:49:19 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93384887B0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 18:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dianders@chromium.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-43a5715f71eso23836671cf.0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1714409356; x=1715014156; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pt1BAPBA5Dwd88qO91Kw8NCtcgY/6aR6zS2cJhDTC6I=;
 b=QhjN1zhrbn6lJP6P+jgL+z8D0fyzbC2rOMV5+kUXmyvXq6N3v+qHKMp6OJ4uFar32F
 a9Z1LIWGZ4GV97K8rxdi4F9+BkCsJmyJlJqccCpZam4HzPQC1LhbK8SBOh+SReD2UIFS
 ybMaqFHdXzDDwcy0HBejVj+/KVnvLeETufcK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714409356; x=1715014156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pt1BAPBA5Dwd88qO91Kw8NCtcgY/6aR6zS2cJhDTC6I=;
 b=XQyN3pNKz1lR6sCV6BVepM1bSVIzQOMOF/xl6mCdD0IgmNQc0BDXs3XD18lw38lSxT
 e4sycgNhhUO4gOpIFBM8hyC7O2TIb/O46Bxkc8aPZMhd+084+kHqohpuzfb43uqYPokg
 XafkNMqqugN0d4Unwj/7ze0hXDh1QdMuWJl5Nw8tewajSZyCkHCnj5RSeTR/igHmttpy
 GiLZFvWK2oWTiAkjlB6ypwtefjf05z/EunQe15H2VQPRpwvtH4uVvA/tIiz/as+b8NA2
 lW6WdVNYCNdwRyNc2smiI/vY0P1bZC1HwaVecLGAP/XCVl30B8eECIptZ8BuhdiAQdMX
 V04Q==
X-Gm-Message-State: AOJu0YxPntwSJffYjic6y+gS7jHxAhdlLfbftkT+fCmO3PaYqc8JCwaT
 zJ+t9ZLaqD2/SoBucp+S1HVE87u2Ltm1BW1+6E6Ov8k1LFdcW5WCdaa1HGH7vDqSP3/BN5oMBww
 =
X-Google-Smtp-Source: AGHT+IHvpg6GtwrE4Yvpt7vGKwqcsT8mHfgBcxgSgsEzyBbUGTZ9936IO2YC6ktbYcuV+CmkaGfGQQ==
X-Received: by 2002:a05:622a:11cc:b0:43b:7be:15a1 with SMTP id
 n12-20020a05622a11cc00b0043b07be15a1mr96035qtk.12.1714409355650; 
 Mon, 29 Apr 2024 09:49:15 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com.
 [209.85.160.171]) by smtp.gmail.com with ESMTPSA id
 v10-20020ac873ca000000b004378b8ef629sm10552311qtp.31.2024.04.29.09.49.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 09:49:14 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-436ed871225so1601cf.1
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 09:49:14 -0700 (PDT)
X-Received: by 2002:a05:622a:164d:b0:43b:fed:fcac with SMTP id
 y13-20020a05622a164d00b0043b0fedfcacmr133076qtj.18.1714409354182; Mon, 29 Apr
 2024 09:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240419023632.29078-1-seanga2@gmail.com>
 <20240419023632.29078-4-seanga2@gmail.com>
In-Reply-To: <20240419023632.29078-4-seanga2@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 29 Apr 2024 09:49:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Unkeyszq8FZOG3NODgTK2ke8OrHNR=K06k55ZmUoTA8g@mail.gmail.com>
Message-ID: <CAD=FV=Unkeyszq8FZOG3NODgTK2ke8OrHNR=K06k55ZmUoTA8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] patman: Add a tag for when a patch gets added to a
 series
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

Hi,

On Thu, Apr 18, 2024 at 7:36=E2=80=AFPM Sean Anderson <seanga2@gmail.com> w=
rote:
>
> When a patch is added to a series after the initial version, there are no
> changes to note except that it is new. This is typically done to suppress
> the "(no changes in vN)" message. It's also nice to add a change to the
> cover letter so reviewers know there is an additional patch. Add a tag to
> automate this process a bit.
>
> There are two nits with the current approach:
>
> - It favors '-' as a bullet point, but some people may prefer '*' (or
>   something else)
> - Tags (e.g. 'patman: ' in 'patman: foo bar') are not stripped. They are
>   probably just noise in most series, but they may be useful for treewide
>   series to distinguish 'gpio: frobnicate' from 'reset: frobnicate', so
>   I've left them in.
>
> Suggestions for the above appreciated.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  tools/patman/func_test.py                           |  2 ++
>  tools/patman/patchstream.py                         |  5 +++++
>  tools/patman/patman.rst                             | 13 +++++++++++++
>  ...t-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch |  1 +
>  tools/patman/test/test01.txt                        |  1 +
>  5 files changed, 22 insertions(+)

I love it, thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
