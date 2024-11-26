Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF65BD3B9A7
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B43389C97;
	Tue, 26 Nov 2024 16:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gdGcagB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3374989C96; Tue, 26 Nov 2024 16:39:04 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3314089C98
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa535eed875so505304166b.3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732635541; x=1733240341; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aZ2DgF6O3vxgyDeGmp2dQwrMnFfyqQDz6rUnAu4LNRM=;
 b=gdGcagB5EZEmiYntdOaeK3nNWqYNITMXccgZHaM07q3/l83I6SwpwXXAGdabZYNYuA
 jfBXJ5gmzZw0CMsuHvxIlKBpiF1JAGhdbdyS9JJPO5W1c047GHfR48d9TY2FXV9wjD5x
 7Ej5W8zJQSkVUO2WLRYvtk7y6afWQDg7cQXkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635541; x=1733240341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aZ2DgF6O3vxgyDeGmp2dQwrMnFfyqQDz6rUnAu4LNRM=;
 b=E+1aDXjLsxvafVRzQFsaKGE61oHTZ/LhI3cbJnqwDisbGv84tL4y2G50vtyK6kL6TV
 Rn4P/2Wu1l1Mp2ybyEf4wooICZZ51HPKQm+bSRRZDZHfhQfTcU1igMSfFKEE/NBQ7jVw
 fKHFUIxBMh9hH3l69plm2bNRrdGCZWUaEBtHIGYvoF/UOhBs59rQ/IDqVfD8vWjw00g0
 C+YKkRyEA77ig9YftGfqnh8qTubK955+RQu6kdz5hebl1Usj3fjxI+ke5EsXUJfpxIsN
 w1AlibMcpoUmcO/2kPUoI3QjQZ+9gYzIXA9Rc6bbxZMmTYvqW89drQLR8h+odCBiuMQU
 VE6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbV4+1fkXU6W5tukQBcv95B80ojmNECWuQHkm5lEmEWyLJwyvVWEzGEsP/sz2swIXzcPq3FyQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yykmg6q1od02oYK/iZgRm/3rHQQmg9LU7uuMeDCQcDzbyAdopHc
 duWQw5/ZxXUjsrS0IpVpQ677Dkeskbs0dsgd4+6wq6tXWA9dq7d5bbO2+Sdf+D2+wBcGuE8W/V/
 NsEfc8TT9AknP65cKmjo80kBbQBr5LGdmG7pS
X-Gm-Gg: ASbGncu5CA+oz96PqHdUlx4y5mnwK/KveCnpYmyWSxMmluDgjE+Sl8qgF5Bn5i6uRJW
 S3Tc4UTcqr6guvlI9X4Sw/2DC5k1fnPQ=
X-Google-Smtp-Source: AGHT+IHxVROxzP5xoTx/Z74d4lJP0in7emGdHx/vMJWwDyI/ArOVMDp8iFmnkWJ3e15jvCEvgM05EE82wdQguVrjop0=
X-Received: by 2002:a17:906:3caa:b0:aa5:158a:fc18 with SMTP id
 a640c23a62f3a-aa5158afe46mr1255471466b.31.1732635541601; Tue, 26 Nov 2024
 07:39:01 -0800 (PST)
MIME-Version: 1.0
References: <20241123212922.304316-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241123212922.304316-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 08:38:48 -0700
Message-ID: <CAFLszTi6kMR42eYfzZRH3+AwW44yk6jsckOkDCJzqiSZCoLHAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] test: add command to 'Lab failure' timeout message
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>,
 u-boot@lists.denx.de
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

On Sat, 23 Nov 2024 at 14:29, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When a timeout occurs while executing a command a 'Lab failure' message is
> written and testing is stopped. The user is left in the dark about the
> failure cause.
>
>     ! _pytest.outcomes.Exit: Lab failure: Marking connection bad - no other tests will run !
>
> Add the word 'Timeout' and the executed command to the message.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/py/u_boot_console_base.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
