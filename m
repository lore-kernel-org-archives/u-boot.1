Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0015D35154
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 20:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B34984020;
	Wed,  1 Apr 2026 22:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ACWILQBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 808EA84073; Wed,  1 Apr 2026 22:25:03 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A25BE84011
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 22:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35d99bae2ebso91041a91.3
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 13:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775075099; cv=none;
 d=google.com; s=arc-20240605;
 b=RVYk6LsikocY0IeOzM+cu+DYY9KGHrMmKnnK7d7eWHP6dkVcAT3vbBKnz7fhgUdzWT
 M5W5x3EMB49AerG2PTO3MEOmHrJarIbXxZu3apaxSnov5NNrCq+Fz+IdW7p5P4YF4xe6
 L8CPyw8bo9eXiLNMy2kRgbh685TKHtgc40jTiXt4ah8UnuZXXLly0MxwzCdZEna02KQr
 jMWOP7Y2+6p7Wu0diPnt4wj/KfsjTjtBd4m83debBjjQlI+zuuuDbT9CdoLooLQr2qjG
 kwpdIjUKcFV8nmretbxKvGFZYG62VetXUG67Q1N3iNPeOB9pgs8O16xp/V5gftuBQSV8
 zN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=a66ck0XS1Ds6MpxzvL9hqN/GOrCBu9/co4fkmLls5hg=;
 fh=RnB5lhiZ2zWwUKd56qUm2o6d636ryv0VxB/lSwXL6qU=;
 b=MPqMs5NEzSuwevbJEsU7TPXG37W7O/5PFRE0/Jw2lK9E6CeFM0rWZOWcPxIhlZtYVG
 2f6G/DrigBVY3bZ+DfULrIr0zrfAB/PvZg7QyOw5MGUn9xwdpBxYxrgwt4KTe+oTRGT8
 7u3t9kGeQkTaf/zrlSaRT5F2KtbLOzLDN7KGmN6ctHj3NP5oSnWyHbEEsVIciASk4z4D
 aHNKoMM0SNdBhITt0SBXbnjC2xhQH44JV3hEH7CiwFoQZs32cAch/iMWd3cbsrxEy6n8
 bT3XjwhOBIOUcv0XBhbaQnKgW66EHhkflqJSn3/u3i5Cq+zuYcixcFr0t6PInBATudJg
 MiHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775075099; x=1775679899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a66ck0XS1Ds6MpxzvL9hqN/GOrCBu9/co4fkmLls5hg=;
 b=ACWILQBzG3rWEYaiPAxGzKvR6r/hsKRdBfirzCQIZmgr+q2cr80ucCfucnPKN+7N7f
 vOgOa8x/zQmvgZN9RDe/CqfH7+GOiuMdO+s15JAOUJYxTyxcVIk45Y88zk1sNFiqG3Qf
 I+Yv3Sbr3Ht64Xhk+XiL3O5gq7tFPZ3CFtqts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075099; x=1775679899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a66ck0XS1Ds6MpxzvL9hqN/GOrCBu9/co4fkmLls5hg=;
 b=pxGcxqLHjH/HkzZRG9nCbhb9h/IEV7OHXhkNLlZ0rRhkRQ7y6hV2yfnebp3gF4pkj2
 TkFep6eOxinR8zi3gxCfStMUx+Gsd+LtxC24Oy0LXOck6U8Yyng8bCEfoRjCdR2CK1eE
 LzNxmaq4FJGx/pW8E9RC0m8e5SKlDEtmIDe8w1A1j7vVpvdQnbjZqDhgBOA5pmNogRRX
 7R299BQSav1NZ+NNYhYzRapI8R2nGPZyoyHQfir7vxVhEdvc7HXdow/KZusw2KUfuWhW
 NjF3hhywvCTk233GfU1C/No22uV4E385+KSD9fAACS+Z3IQPDhgtYLsjHosp5aaev1wg
 priQ==
X-Gm-Message-State: AOJu0Yxf5hLFsLl5Hwh+nMe06FlG+THy322KmUi8gfQaXE17f/O4fF5o
 OGd+RHHNYriEO4/62Rooe4Qs5GX9PT/9v2ILOSCUFbaWogSAapPhKwN+x4DSGcojN0qQVDTbboK
 0lNLRgy6kH65wNRfJm72YZCo71mEThNWCd7//f5uz
X-Gm-Gg: ATEYQzwdWUdw77SmNu0T1lGm5vVWfqoNEKXPZM+DQ3T0GcwcWlGThtsT2iFzMLf8x6e
 Ba6coqJvAEFJCf5pvl0VImDy5Vy6Nq2O3u6Q3Lh78VQZ9ONhFJSDzyho/Rm8PIFW/ieyty7grYD
 YgEekkMLKy8nys4IQO+cG6beRJ9ulTZdylmmsW8l4WDQlLWRZhhonyRyL5zZJqzLCU29NmMoPNX
 /e4ZzChpzaLg/LuQtjlJS4JUzi6Puikh6HfVKIgGfIHbN9yoOekaZswy+5wTPyShsr3kV8N41G8
 0F6IKBMxP3BHwEM8GsZje8W1hX5KzJVfEE9hb5Q=
X-Received: by 2002:a17:90b:1a90:b0:35c:f82:fef2 with SMTP id
 98e67ed59e1d1-35dd40db5f9mr582280a91.14.1775075099099; Wed, 01 Apr 2026
 13:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775023421.git.michal.simek@amd.com>
 <ae0079a2839dceef08f3324714d45fb48d5d7100.1775023421.git.michal.simek@amd.com>
In-Reply-To: <ae0079a2839dceef08f3324714d45fb48d5d7100.1775023421.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 16:24:42 -0400
X-Gm-Features: AQROBzA45JIPvaQHGPtdplYn6z4iE1m9rpf4u2TVWpVxGs-YjG5R3R5pW2zMt2o
Message-ID: <CAFLszTj3LPM1H41y5dJnjCpm7jh2rH1UpJE3hdSqSUmsRUoR_g@mail.gmail.com>
Subject: Re: [v3,2/3] event: Introduce EVT_POST_PREBOOT event
To: michal.simek@amd.com
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org
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

On 2026-04-01T06:03:43, Michal Simek <michal.simek@amd.com> wrote:
> event: Introduce EVT_POST_PREBOOT event
>
> Add a new EVT_POST_PREBOOT event type which is fired in main_loop()
> after the preboot command has been executed.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> common/event.c  | 3 +++
>  common/main.c   | 4 ++++
>  include/event.h | 9 +++++++++
>  3 files changed, 16 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
