Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A895F34C5E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 14:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B3784246;
	Mon, 13 Apr 2026 16:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E/3fEJfL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A7284239; Mon, 13 Apr 2026 16:58:50 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D191839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so725589866b.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 07:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776092328; cv=none;
 d=google.com; s=arc-20240605;
 b=YPhnMNW5NNBYUfxIdrEUMAHNWkowjFw/RFakzXv6cPbdzeUbhCg6KMVCCMQPb0hUTj
 xX/pQE/71bJz0dZaMYAw4+ERpTh3Xn44YXIaYGRmdAPmcIvFAUBoZ6dgqH1PqL/vxSu4
 W8SMn5+uYwjXDhf9zVcDPTXVNXdYzrFaWIKbyg8NbwjxhSrR6gp7uIDrBoLuw9028D0D
 f7EqwNaMBRfBnv3MqcBhCFru0F/pP9kX8bacivejClNaMf7ER+xT4g1YLYDpjTH1pRWo
 jdKN7a2O4jpaUmv3ctsg7/4reA8DcfmSFphM66UcX/UM0eRvIGhooFCb+0+fxbj6XZdm
 1Gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X6VlWPu1Dl+8Gw2vcP/mZUx+Zl4v1mJkdl6FhchbWyE=;
 fh=dF+eCHOIT6SIbAzI5tBwPFZclvSQgQQ7Zo1JXO6SSnQ=;
 b=BIYbqcr3u0arQFww9ME9j1mgn+V2Rvl6okhQK1k8IYTXLt2zysvLtMyJvJxfw747Rt
 m9MgN7y1pm0shg4FIc7+7dwBsmC04lsgDEy931/XKKHMatbh9VHJICfA8dTsOKxH7K5V
 R6gGjRJa2tKYthESFcIR6N6DN2i+KZDYLzSDzvqdoQwAjr2O4OWrfmsPAEbEhxtHJYas
 P7gcWzUvCwVU2m9ILHb9FLQ2pZuLcIrIGWJLG3oVGEECYIk6AAD0tcgMebr3tpr6q+En
 7pCGJxSbmwMHN49KxCG8KHc1jSW1JX4QMfWelxMPPfp9eurhc1f+3My+TrrS5cenLJ/H
 C2XA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776092328; x=1776697128; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X6VlWPu1Dl+8Gw2vcP/mZUx+Zl4v1mJkdl6FhchbWyE=;
 b=E/3fEJfLYTAl3/KaRlAYbQpvBo7QZpkNEgQx5ff+duMOjD/jYcNBv6mV4t7i/3Cpqu
 GK/VT+ywcnAvxJE8RjWSjclpMHj2aXqzuXOzAQEeWbOVofznqHf2M++OZp232gMIRAOx
 DwfnfhtZONiBOOakaNZV7He9T75+6UlrwJ0h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092328; x=1776697128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6VlWPu1Dl+8Gw2vcP/mZUx+Zl4v1mJkdl6FhchbWyE=;
 b=UeOFc9gCd4FYb/i4iXpu1cW/OQbYStgBDqMYMH2ulrwqosHaB7mcGJelzWTeVVwvmF
 M3sTFj6Llv8smnZJsAoZLlRW7VjA1LUsrOMcmpfDRybAGvOA0ms6So1+fMlP/v9LAj+B
 G6mtyv4QS1TZoVGkNnV1miINHaHrrvi4mZZ4hFTDnpcRuvFgY/pVo3ATJf+TX8AF/qTg
 tfYRZnZ7o/Ap56lwQw1/XjtBIG7yzCQp/MTCCbdaoOkKuy0aYYKwtpsPWcn6lda0F1yi
 elhR+hI7aW4pTAbOd8PImiCGeERQWD/Ijppy0yVFeoZ4H5KuntO3vls324REdqQ3W9fM
 Fnhw==
X-Gm-Message-State: AOJu0YxapneD0Ng8nE7lkeFyb1zQ6dJrvM8fq48ULX1gIh/j/HmbcRia
 m7wmEecemJcVlCzdMlKkFmFO+PBqTCYx+9uvOIfF8Lah82SbOljpOHXjh7LMIwA4nq2E7S+1YkY
 yeJv2+L1sADveL7vVgjTVvM44NTnTJQTJAueCLe0x
X-Gm-Gg: AeBDieuKcLSRRRbUUtFkdSaIrL77LqYwEx6cDA4TrqiZyk/u5IzoKXVEBpfT45YyMgx
 qLX2xbZtsSeE0Mr2RMqOO1fsCy1oH9cpVeKHlhxwRgYo+6snqzEkwn6rTaf8Ls8vgU0cJi9QuR8
 2zgCjT3wThxaTm4uoFxduigLc2fxUKoTny/QTsQtCcRSC+paD6mUH5KQSqRXW2uP7aJlg20+a2K
 M3vjzCX9LJGIx2w9dn/zLWSdtRSbT6Dn0yaWFBAelHUvKmVRqO2iDTTtvf3U+9OeGUy8GjduAyc
 8Th/Mt3CsecXEdsh
X-Received: by 2002:a17:906:730b:b0:b9d:fd2b:2337 with SMTP id
 a640c23a62f3a-b9dfd2b23edmr109790566b.20.1776092327617; Mon, 13 Apr 2026
 07:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260412195947.1982729-1-ravi@prevas.dk>
 <20260412195947.1982729-8-ravi@prevas.dk>
In-Reply-To: <20260412195947.1982729-8-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 08:57:26 -0600
X-Gm-Features: AQROBzAPjbvjcz_zqa8Hni8KjHfJCYgQb6nrqtMh8g__jgZmH5TrbRDiQK0yHL8
Message-ID: <CAFLszTgAybTnfAkkx4YvRXW3NLcmObjW6XxBJG6cBZbvzHCfiw@mail.gmail.com>
Subject: Re: [PATCH 7/8] common/cli.c: use memdup_nul() in run_command_list()
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-04-12T19:59:41, Rasmus Villemoes <ravi@prevas.dk> wrote:
> common/cli.c: use memdup_nul() in run_command_list()
>
> Use memdup_nul() instead of open-coding it.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> common/cli.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
