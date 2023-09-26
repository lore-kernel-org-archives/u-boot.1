Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A8FE6FE31
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 00:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9ECD86B4E;
	Tue, 26 Sep 2023 02:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fJZIifNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 719C886A94; Tue, 26 Sep 2023 02:15:26 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E158805CD
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-27730028198so977064a91.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 17:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695687322; x=1696292122; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=strSPlqlxUu4gT9KV4A+Byw4A7IlhiWyvi/YoPM2xOs=;
 b=fJZIifNUymBdiNFwihpmEYN0NBdGx5Z0ko23ZooXz3ze4HzgEkOHhuwzMABUIYy0Fc
 kXZXlg/Fnk0FeCoE6TByt6LSX+5xJx9Z0QnIiPKEemlC13+9wOZKE90Q8vQaJ6rkYrc+
 k4cMyj5Wgk7wx5fRI0+MUhio7gJhjbNpZW2Kj/7IUrRcXT1364JQ+hVXlhEY0JT8/1j/
 CZLGwRSLxCRgUG+tgZQfLNFsrf16DXhcZE0vM86rDXwvDJkqNibzUJ5t8U951AbAzs2W
 Q1WTgIEHZaiT+xkNb7NhE+T7Ai2X1LHNFdtphzR7HSjVD5XFvweQ+4LGTOKOWxQ03tFl
 EriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695687322; x=1696292122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=strSPlqlxUu4gT9KV4A+Byw4A7IlhiWyvi/YoPM2xOs=;
 b=tmtlWRNRtiizh+KU4ebj2P2OEfLAWXO4L5w+seS1QToMmgLZ5VzbPOwBbnK8P3mhkh
 mPTd+7BP11pnbf+CtSjcNaewoYSOcCpFD8OpO0bS8vq0uCaZ/5GarP4W04RV03NOWBsD
 azePKXzyFtmEHz0N2w4xkjGm8PC77hyEl2ieci17pF78TAxt+/pYd/RcXD/xtES3ztI7
 Yfzny6nAZCfcGTawSCju7hV/92Nz/SguoUkMD0snguFwXCGFB2w9C4zm6B55lgKjmYHl
 YJj9L38biuEJd1/dqtFz4xHbiI/bYbgZV1jxjJUmjTOH7wJXjKJ7xfnxD/NYa/+cY9Wf
 4TmQ==
X-Gm-Message-State: AOJu0YzwhDiMEy4v3gE3ewwpSIzJbC3Yij5nwo+DEUbuUcJotOLhRyhu
 70SzLefft6GmWG8LHRwGIXHywpnoYUJE4s3NbD0=
X-Google-Smtp-Source: AGHT+IG9ER3zc3caMF3aM1wfDmOBx4LhtsQZ+qGnMyQR5yB8CHxtGnWSSTdyBuyVKKi+oW4+kTG+owxKSb2X7pYf5yE=
X-Received: by 2002:a17:90b:100e:b0:277:2d8c:5c17 with SMTP id
 gm14-20020a17090b100e00b002772d8c5c17mr5924457pjb.0.1695687322352; Mon, 25
 Sep 2023 17:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
 <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
 <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
 <CAOMZO5BzrfvLDrtqBk1dmLqb9-GxzZs8nRVY7GxqCRY34pKg4w@mail.gmail.com>
 <CAOYdKdgyXi5g9zPNOCBtsrA8KV0L1O0Oyh4Ne-Q79Z=EgGs=zw@mail.gmail.com>
 <CAOYdKdhvKEaeyv5zhXiswuF-Kd6ee8FmdN8MoMS9=5VTWVgMXA@mail.gmail.com>
 <CAOMZO5DS2VHPKvVioSW=7fWfnrP63A6wdga6pFmFuSK2QF8gSA@mail.gmail.com>
 <CAOYdKdjALruh9v6HBO-MSjzZM0whYhbA5YLJxbKk7yQk7cznGw@mail.gmail.com>
 <CAOMZO5AVuBxGFF_itcxvdG=W9JoRtyzzeeC+wji__uUOQirwZg@mail.gmail.com>
 <CAOYdKdingLtAvEnth8mSnazQ2fZ_kCsM_2P_dX7tbL2xe9wyVw@mail.gmail.com>
 <CAOMZO5ALK_O-648FaHFrjJc9EiU3J=nvv1rYDiLOGqhjt3mmkA@mail.gmail.com>
 <CAOYdKdjEOsLmkoJdxk1CmLk6_AJFZhuS_7fWxWOm14Av1n7gHA@mail.gmail.com>
In-Reply-To: <CAOYdKdjEOsLmkoJdxk1CmLk6_AJFZhuS_7fWxWOm14Av1n7gHA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 25 Sep 2023 21:15:10 -0300
Message-ID: <CAOMZO5BEqwT+t7hw=neAfww_edg61cC6eggr9NNL3OS3jXOY8g@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Rogan Dawes <rogan@dawes.za.net>
Cc: u-boot@lists.denx.de
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

Hi Rogan,

On Mon, Sep 25, 2023 at 4:27=E2=80=AFPM Rogan Dawes <rogan@dawes.za.net> wr=
ote:
>
> That outputs LLC about a second after the mxsldr terminates (kinda slowly=
, the individual characters can be seen being emitted one at a time), and t=
hen about 5 seconds later, "Pref". But nothing after that point.
>
> At least it looks like there is something happening, which is excellent!

I pushed a change in my branch. Please give it a try.
