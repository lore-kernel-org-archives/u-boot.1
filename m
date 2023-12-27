Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF83C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 19:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E385C877F3;
	Wed, 27 Dec 2023 20:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xI5b3MjT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC0487801; Wed, 27 Dec 2023 20:21:55 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F2C86D37
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 20:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso4247334a12.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 11:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703704911; x=1704309711; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sw0l2ErV5qbiaZ10sK7ydij4Ybr3/CF/RyZNGZ1NdnA=;
 b=xI5b3MjTaBwnalqvOXxjNFqsl6omVgmg/LFr6NGuvQHUu/1qi4/sxzT/sWmTx20rGZ
 Ki91Q8bba+/RYAoraUUjinYOe3tV0x7E+3pm97mTeU3O+rDD+qy8oEHDWA//d9ovayg7
 Oi7Ouy9ltgX+NU29Un/8TjEfNH4SfRPYf8EhZdL5lVmt1bZ023knkYuCy2H+ApGJGO7u
 ShS+dj81cdbYUBt+62oFDD+akWaiygW5Leto+GSiTkjghDcqCsRq0apZYQL2ccfwc6Hh
 tvaXs3z26Rcy30TP2aUl+jdiyyrbiqrk4euAApRdc7HB7AM3k2ckwWGy2AoIfKdbUkvO
 KYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703704911; x=1704309711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sw0l2ErV5qbiaZ10sK7ydij4Ybr3/CF/RyZNGZ1NdnA=;
 b=wrtVBa33XzvpR4fp3wT2gHWU9/GL8JT6tPjuiunJNVEPbBbT+FHr/JPXyRG0UmcRdm
 EWu5aO3CYQqXpqvbWmsX0oUZ3r5Cn+UJje5z7u8CW//DbmVwmvoDDF5jHrKBku6mS/EA
 +mmSf7VXK8NU9uVcuR6AEN/XICJRSnIs0zv5ZBHhB3b5twYhEA1JmFaAH956DwYfk9cy
 mexmEXhVY6SaqC/j5S1iKXSop709+Ds/qnDrnNYcHhgFEQwn34uJ0BjGIjQXYStwi5+9
 FrjTWCP1k2zfa8NmwR2DFFJ3woD/eBQkz+jQ1LKjGrjBStren1NomiCQpjybEVe+B9K8
 uEGg==
X-Gm-Message-State: AOJu0YwpxTeFLLqJMIO02PCur/mcJ3gUCiKo/xRWgCzv4+ugkgYbhMd/
 BrpNTqe97vKoX3Z8dzSIh2FLRLxvQz5Fi+Gbf95VQeS6JP/b+Q==
X-Google-Smtp-Source: AGHT+IEoucSk7KQo3NjR8bD9T/kIyvVW66qGzyyGUnhJ0s+d55seg4Pcdxmj7P+rJO6uZXydDX86/+QTrF/zS2nLIJY=
X-Received: by 2002:a05:6a21:189:b0:196:5c5:186a with SMTP id
 le9-20020a056a21018900b0019605c5186amr2984003pzb.6.1703704911451; Wed, 27 Dec
 2023 11:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-7-raymond.mao@linaro.org>
 <CAC_iWjLs3Tj25hr7zD4cWCsRRWhB=DNerOr6CjH2PQeOfAaBGg@mail.gmail.com>
In-Reply-To: <CAC_iWjLs3Tj25hr7zD4cWCsRRWhB=DNerOr6CjH2PQeOfAaBGg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 14:21:41 -0500
Message-ID: <CAEfUkULP4W+wp7Z7YebFuJwXmUvRxayuwbCqRg5jLBdp_QwVqg@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] bloblist: Drop spare value from bloblist record
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Ilias,

On Wed, 27 Dec 2023 at 04:43, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Mon, 18 Dec 2023 at 20:20, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > Drop spare value from bloblist record header.
> >
> > For now it is still present in the header, with an underscore, so that
> > tests continue to pass.
>
> I am not sure I understand the commit message. Doesn't the spec define
> this as 'reserved' now?
> On top of that, it's a better idea to follow the spec naming. It's
> easier to map the spec -> code for new readers. So I would rename
>
> tag -> tag_id
> size -> data_size and
> flags -> reserved.
>
> Can we at least do the flags -> reserved in this patch?
>
> The spec only defines a spare field for TL header (bloblist header) but
not for a TE header
(bloblist record header), so we just remove the spare field, no need to
update this patch
I think.

[...]

Regards,
Raymond
