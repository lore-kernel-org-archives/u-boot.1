Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D78CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 14:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF65B60B51;
	Fri, 16 Oct 2026 14:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hCrwbgJ8lsxu; Fri, 16 Oct 2026 14:34:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F217560B1C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161288;
	b=ZxCkOpKfralXl48uqSFAuZaWbn4D8aVw3HrsxBnEAwIuUpGVxOeyR7Ub6X5MrEJEMqkv
	 srrsivyw7GfBj1wbK+64mtv8eVfmIPDMBOdgWnS5nC5jNDPZijCQtEW8ggEdit9I9rj/H
	 vuXf0NPO7E/qtnZOvY/98ovtkkADuPYd2Ex1TVr5EZ7pijwa7CkJsgPalG591GhMlXdEr
	 UWKtvnCQiEZdawQryPuBWAG7h6czEpFkGZUmxitsiZIlLWyDizrJZsZ47FA+4XBoUrLdE
	 cWmj3v8dkIV3AfoHV6YqvhnkaE4dcukUDhvaZYTWduKlc8JRnuM4MvfWK9d5W0/NiwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792161288;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UaqIJ3HprBElzHn/kXw3JjhnqwWEvR/by4N3r4QbXg0=;
	b=qBuQdfgZgFj65oZrMmqviT/2N4wmZjbFwhYFRZWWwTmH4u5+yzvW8roAwI15H3fDGICq
	 SfnJNfyL8h7KSQwsKoUKsXN5Mc4hnQxrVtBmBViCxqmrqrg8mJdmamO8w6q/vzk4IPNY3
	 +JmQV3sV1NOwLdQzfXmwy6e7tGdKIRos91Hxw3t4o4nchNVQvUSJWWCvFYX2V0NdpSyoP
	 wyxD2L8HeT2tpZyU5CAzKyy86ieJom2aJ2Ixlifw+awA9wbjlryZt9aQCC3kGtBUaLDdK
	 nxJVYO4tqlE66GWzoxq+45rlcEZaLTOjAvWI+OrZQEvjK7Ydv0EPwQVuCGtIv6TYd/g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=f+xhkbRH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792161288;
	bh=UaqIJ3HprBElzHn/kXw3JjhnqwWEvR/by4N3r4QbXg0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GbsLHPkZAnubIcYKlbTWLv9UJBc42/rTATM1CtzG24mcR2TMl+pb9uGQa5VKtSsut
	 Dv49ePdxh5kuWk6RnoVY0Kp4zKoFtSF5N4qaQHTDiSQIwaOvLO4uZIMFUNLQYF6jGz
	 1OIXypeB+0HqnaSiKw3Z9KBsusX4D/hCJdWaTW890ZCdQUGXhf97BgisUP3FBvQEeF
	 yXAnBVNO0CeE7ZJSGTJk02w2MWokejd659xbeS1K5gqFwFO7caPo26Hn3cBqlrSuQ+
	 FqpCAlbO6z2NczbTBpzLHdkGyCXKLfUUdAx42YZU0a/j1a1ScVvR1DpSe4niVXqjoH
	 FQGpTj6pcJXBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F217560B1C;
	Fri, 16 Oct 2026 14:34:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CFC97AD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62E5760B1C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C5DH16PuStyB for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 14:34:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D27E060AD8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161286;
 b=gnrV6S162jNypLON+jr65ENPACHYOzJSEQPBwPXdj0zIb+SpsvKC7hH0IEZ2EOUldcQy
 XNDTKS+2squOQFKuRTHaec6W+IHP/hCNktp/P+YOJfqAij8MUKz7QOYwVAoFO0E3D/Nrk
 trWIg5zlcbCo8fK9jSMqP/rV0sEj/QI6ny9ZftB1BAzpTZyIvcLFj0ySXcJLp63IYDjIF
 ZSUsr9sZpe7ahZ7auJf4gULxPDX2Ko6xp1L27SOz9KuAN5OyK5hZ1CE6WFE0PUUs1/vPq
 HxqlVASm8pjasxba1aP/BB2+s5s/lMDQdqLka79koS3wSXNq11ToXwMbeXAZGiXy/Iw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792161286;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=UaqIJ3HprBElzHn/kXw3JjhnqwWEvR/by4N3r4QbXg0=;
 b=M9/VQzZ5WMQcQfjPhWJreU1BGtfnVlaHyaJMHbkbS6zTkP9PQglu0fP65F4zr2PEcZYB
 kIhwdaVcWWlqn2vWih2v84UFngaOGGmge6TFZOfdwTnH5DBtUvYBxd1Riy6WMC4dqDy2Q
 SaLtCooenUA47BYxJcO+ggVjzL+QLHx13yH5fWAIOGwWjquYwFQe3BljhuHPlSCGqb1k6
 X9aBas0qtHMD1lY+64K33RLk+E3HLBxNh836XcRDD4T1ZZdihOn814I4HPDgbkgDDCsmU
 XlpHh2BrGGzoSvTpClt2AvY6Tf7XOCh8hcjMeYE5EgFwYW5EYirYug+Eope0jgS5KFg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=f+xhkbRH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=f+xhkbRH
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D27E060AD8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:46 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3ab60ff4273so72294a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792161286; cv=none;
 d=google.com; s=arc-20260327;
 b=A/Le1KTyGozusMOSMH60bP376AU96g6cmFEQ4IVasHLHpdHvXj8oaFJIGYF2sNri8F
 Y9vtrSMW5Tcjks44Hsu4EMM+VfiCj+Vi72l2uFQWVltlpGnYFoRe6XUwUqKAxcXQ+azx
 ++POEW9b7GHKnvZfmMxcAmlKw1VZQxbQwhQ4vMiXVoZprs8ULvOtlWda3eIYnMFBcId9
 ACsQETzFHmkQjo6Vb69n09G/TxMYqaQyTinC4HZMe7/X5hgCxiFqdqJk3pT0w/MlVkbe
 mlKDHzp3qKb6lccLO79tpNpZuLTnJ6SawcmPRk45oiSAw2kT+nlST3v0pqP6IrInRiyl
 ekMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=UaqIJ3HprBElzHn/kXw3JjhnqwWEvR/by4N3r4QbXg0=;
 fh=jv5hFG073+Vaqj5mru+SByF2ajjYuH/8tP6BXYVF0Ao=;
 b=gdKY9Ze0tzl5UnBLeRVTme2frkCtPrYDG2N7WK1bfVuYlh2innP5m831BDd9+CWt7D
 0c7EyttvctYKEaXCfRIIGcXxyALPbXdBEsndMVSxJtslHHzEDwiB5KO0kR6je8jCvgBR
 gRexjS3Cw2l/BXjrWx2m2Q2rs72biJp5zThqnFsUczjIJC7cUfKqFSPRmkI73n3i57z2
 HRmf8t3Eh0l40dI5YeGs+zTdqMAYWaB+JOuyrDHIGJJIdhCuwV67ZYf0J2s+k0dG9jxK
 /uPVK4njC2h3tptcNsIAhC3+XvVZ5PwPwEDqBZQaA2FidHTnLbQ8BXpuNg3VZhwxTn4Q
 wC1Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792161286; x=1792766086;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UaqIJ3HprBElzHn/kXw3JjhnqwWEvR/by4N3r4QbXg0=;
 b=f+xhkbRHTNWXIREY8lCVrdp5peh8A0+c3tco/Y+27aZAnPh6DG/kB8beP5z4AHtFGp
 lyBv02Fa2vbkXCR0qYFszhq6s3mUrY1fKCcuAAuMDZnThADgc5VsXfR6ridHf0CDcCa8
 bIGzteCkHut7zYuG47CzHimLGIY5tfhIPfkQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161286; x=1792766086;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UaqIJ3HprBElzHn/kXw3JjhnqwWEvR/by4N3r4QbXg0=;
 b=TYjdXXKGvbkAZm3WMj6YSGDqcb0KedsoK/VPPlxQsT8m9hPwrJnKE9yPM3Otg+5NW/
 lYnk5n+KcCmWBbE6NF/lYShDf7Z9ujUJQXrNO4ZBQz/G3zQAKloSq9g07x2e7mNtKMwq
 YpWUyWXCModGPtHkkrPsnuJTqWRKL+APv8Jy/cEkR/PEHReXXgroMr40z8kuQk6BODPH
 nxcoWz8ZTADZweZTfRKLTkRQSwI5zLgve9x48xR9x+i2j5PtnWIj7rNpM8bBzHrrRvnh
 VnSJaqruarSe1/WaF+bv0FPJNcVUiCmkpEZU/VLJqEIBI/N2MIgUHGg61RrFQ6zmf1Lj
 uZkA==
X-Gm-Message-State: AFq9FYKlT4bDM1wH3hQtGIL9/oLnCQbliAD6EP34RTxGDFZ/SNSzXeit
 1G/wnSG4X7wf3sqSX58wsdIBE4u8zg9/E5JmW1Z9b4VSyLB8I0ST/e0UWWy76qDpzc+cnZcO70k
 19UGDi88MpF/+iNQqt8a0qSJyWL7VnVVZeiKeM8LR
X-Gm-Gg: AYBFou0HQx1IGr3LUNHnvpkrhBAIcpFjFOrM0VvQ9L0fue0JN+EWBkb03qeCN4cEX0H
 X80QaiF6QOc9HJBp/f6x/XiziOjqjcI5iDtDKVeygFTarPKjSlCoCIxnlYWfxzNWounC+uGVFWA
 i+PSTkbmeUV13+I0ZhY4srKeFRTtZZ0ewSE/tPgAtZ1oEbkDoT7aS6k6wj4n/4WK+tgrQ10P+TC
 mCydJ8m5XlFJp+7lMfStA1WtjmKQxAZWksyIdyNkAWhWhO842UJTI4Jx43s3w0ZoNVrGak7v+v7
 w1uix/DzydLaRZnnjk3sakPRWIu3nD2yTbt0kv+Vh7BRd0UhngWr14TiPqqDZhQatg==
X-Received: by 2002:a17:90b:4fc8:b0:3aa:6b5d:a00a with SMTP id
 98e67ed59e1d1-3acef59c195mr8454a91.53.1792161285650; Fri, 16 Oct 2026
 07:34:45 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 07:34:40 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 05:59:29 -0700
MIME-Version: 1.0
In-Reply-To: <20261015111328.1269775-7-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-7-bin.meng@processmission.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Oct 2026 07:34:40 -0700
X-Gm-Features: AclHuK-tq-NW_mI9f6geszROn5Bejojyo1fmzpHwUiYDQ_HfMaZThkReuglpWDc
Message-ID: <CAFLszTh7n+8eRS9D05QN6ffV3x1GPs92JdMcstjgvr-d4cxZRw@mail.gmail.com>
Subject: Re: [PATCH 6/8] virtio: blk: Validate configuration before creating
 the virtqueue
To: bin.meng@processmission.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>, 
 Daniel Palmer <daniel@thingy.jp>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 2026-10-15T11:13:15, Bin Meng <bin.meng@processmission.com> wrote:
> virtio: blk: Validate configuration before creating the virtqueue
>
> The block driver allocates its virtqueue before checking the advertised
> block size. An invalid size makes probe return -EIO without releasing
> the queue, causing a memory leak.
>
> Change to read and validate the configuration before allocating the
> virtqueue instead.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> drivers/virtio/virtio_blk.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
