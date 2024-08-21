Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC484C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 02:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE1688AE7;
	Wed, 21 Aug 2024 04:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n4gISgS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF0188ADC; Wed, 21 Aug 2024 04:11:15 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 942AB88A64
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 04:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6bf6e17cc2bso31819506d6.1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 19:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724206272; x=1724811072; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKQafpbRoF+emZTyosjU37Bzq6juPKNSjeSvhqI5XHE=;
 b=n4gISgS0KD4rj6XAUVB6pcZkVuydSQMBnqsYp9BZKaUP4l/mGidVBe+N4BNWVefUdq
 EuQvMJTi2fb/sqfWXaX53icSYkeGYfXcMK22DrrOOSf/d3mpJglwIU+1q0aX962pLAV3
 /UGtkLGAwuycxsfNqzjhKfFJXkZeW/ZKWWa9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724206272; x=1724811072;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZKQafpbRoF+emZTyosjU37Bzq6juPKNSjeSvhqI5XHE=;
 b=X+R5MMJIOwIyy9TgGvpyt2OR+zvN2U/hos1gYhyvqVzn6cFZHStM7nYReJEwLDVzvr
 P93YmpW50L7oga8bFj7cW+84H0mm7W9hVOYGgfWHYwfD/pZnRjwwZo2wjUQMPjeZiGFn
 OwQ+aw8H1Taxo6vwcIBFfdcbPcJ+J3d4AUpPih5IX84Xbk9IDV+ztKLl0vbMzT77e7Dw
 iDRicj1MqhTN746FrPmxMToEd9PhrnkhFwT25Ucd7IjZu8/9Bwe4oZkPCpwyVjHDYhCa
 necT5gPx9Lp4fGjzUYuP6y7kw35RrvuUWGLHqsh6/pDzeYarrQoDGRlGK82byOOZvG7E
 ++qw==
X-Gm-Message-State: AOJu0YzIIKBqPqkq7LHnYR+TrBkeI99fLYQaeaOBAcZym0alWQTdX6KJ
 1We4GNEqfcjMbvcbTqBKhDTjjvGpDMPpipIGStspNGHSj3L/0ad8vMIHtFgAjGQqQDQVbCMWeGc
 AZ1v8dY9+q8wxoyYnp0Uu3bkYcLyMXopW4hr8drqXyzQJL8A=
X-Google-Smtp-Source: AGHT+IETtiG5hQGkaSIfmIj4S8qDsUyfG1QFOjSM4Wh7kwadgfi9NOAPgNdXe3/0qD7Vyc3vTe78TdECnjMQ7NN7AeQ=
X-Received: by 2002:a05:6214:5991:b0:6bf:7e06:6111 with SMTP id
 6a1803df08f44-6c155d485fcmr17718966d6.3.1724206272517; Tue, 20 Aug 2024
 19:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240819210719.71747-1-trini@konsulko.com>
In-Reply-To: <20240819210719.71747-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Aug 2024 20:11:01 -0600
Message-ID: <CAFLszTgtTgBYLr0m7XF9Np92YJtUpPZrsTUqd=_QBVZ_=f9Jig@mail.gmail.com>
Subject: Re: [PATCH 1/2] pytest: requirements.txt: Resync with the rest of the
 project
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Mon, 19 Aug 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
>
> In order to build the docker container, which contains a download cache
> of python modules, we need to have our versions be in sync in each
> requirements file. Update some of the cases where which are older than
> the rest of the project.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  test/py/requirements.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
