Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF5ECD484C
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED29786B0D;
	Fri, 22 Sep 2023 20:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nvRJ6Dhm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5CA86AFE; Fri, 22 Sep 2023 20:28:50 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C31686AFB
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59e7fb87f1cso32134597b3.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407326; x=1696012126; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WK7387JaUz7oYouW6uq9RcPkPG1rItb39/SU2l8cVEs=;
 b=nvRJ6DhmGLtQf7hgJRL5E3C7ARGeBHJ95+1AChA6Lh7qPIEIl161XLqUNI1z/UPOBR
 RrQfJDY8V1b03ExKGXMD3fA9/326KyrBtx+HD54C9WNXviIFvDoirAfOMAXNb9OgUNDB
 mK/jtAQVP1euzStQTH4TWqABvEQsAxZQ1cDmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407326; x=1696012126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WK7387JaUz7oYouW6uq9RcPkPG1rItb39/SU2l8cVEs=;
 b=r7KrlSzVh4RC0BDFJnzIjob8XfuU+LtWL5ZDvdQpOgMa9viCSrQHFh9p1etTP1Q/BR
 Mc/5quYXq0YLgFPfmipAQSnH7d6vL0MeGrobqYvxfeJEy7TfzvNXqaCVp/kVjTtsT4Tt
 NNclvQO1Dp51kJuZGGSqoouBe8K3F+skyQuzWRk9VXACe1Uy5xzk+5Ipy+N8LB6tWfkT
 tvCIAjAEAUj+rfBd0Jij/55GQ6v8iW/eYCKlvN/1lq4vzxsx/L996sesv8gtmFe/JlTZ
 qcJETSRESJeYDZLhjA8T/STvfDq/+/p75n8o5sANzgmMKrccatmB6p0DmHHpKo7wL7oF
 13kQ==
X-Gm-Message-State: AOJu0YwA9Nwh4l10wK7KlrnXQ8kJXxK96oO5u6I+qPWO5FIf0aF/uue4
 x5ygyVtBgZP5Y7RtYsNal8NuKSc7eK5OM/8apKp48XS6OkiCyILIXiA=
X-Google-Smtp-Source: AGHT+IEFRXnuwRozInoqj3j8GELnVx3CVjCPjAfQI8p/FuF79OLk0EdQ0y07I7OXXakSLmqbtNHUL8qm0XWXa98YAVs=
X-Received: by 2002:a0d:d54e:0:b0:56d:2e22:8b31 with SMTP id
 x75-20020a0dd54e000000b0056d2e228b31mr518785ywd.41.1695407325747; Fri, 22 Sep
 2023 11:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
 <20230920225811.153474-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:29 -0600
Message-ID: <CAPnjgZ1Z8y8J3WBqHLbzSYe8hhUGcCpMobAN6W705n448iwZoA@mail.gmail.com>
Subject: Re: [PATCH 2/9] cmd: bdinfo: Implement support for printing memory
 layout via bdinfo -m
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>, 
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 20 Sept 2023 at 16:58, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Add support for printing memory layout only via 'bdinfo -m' .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  cmd/bdinfo.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
