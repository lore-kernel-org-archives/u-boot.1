Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23895D6EC00
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 11:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD4C8921B;
	Fri, 29 Nov 2024 12:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ljExnsd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5142F89392; Fri, 29 Nov 2024 12:24:11 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4406B89215
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 12:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53de7321675so1832431e87.2
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 03:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732879448; x=1733484248; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZ2ceZO0SsFkG1X6KVpF3vjcQ+S9Cc4Hnkje+PPCup8=;
 b=ljExnsd0CkzsRJpvO/ILtZSfBIkH2Wix6mSAZiDFS9fTD7baNHqrerWFinqYa26vmf
 s1GYWIn9vUzf4bHZwwMgKmvmt/qdyaj8tdPSaJgLY7O9VnlKvLEBl/8JSxMaPxrb5o2z
 B2CyINA0HmOIrFWs2rDCwFjxAeCAVkSV6T44xLDodsbVh1PzlkGiXYBerUYuHjCDUEIE
 ybpojFkNghjm5dSziBK0FtJ+FCaQCpWb1fq9KyFUwdMnBEYj9hT1nVivM8JkrNj3sQDb
 nDQ8qpuYpT6T/rhGGFVuVlp7y9KA+eNnqD7413C3iphQWJ+dCz+dTk0C5l05pTHs4ZWL
 z1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732879448; x=1733484248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZ2ceZO0SsFkG1X6KVpF3vjcQ+S9Cc4Hnkje+PPCup8=;
 b=HCWimx4pclGIMpw1tNSFd3hFRY5GBQhpqPDBNHpGtMAOh3R0FJnEo4uCuw6Nzg8StN
 XRK8KRQTqe1ALZY37QtKPC1jbyvweUSHmasyxVi5ubtpACzHFFthp7SQUm+80BHNiNw/
 LGoqQfU5Hqivn69PAcubuBWrZgrNvajDb63/X6uMa0x3PbXi4/e5hI/8triQgb+/oFex
 at/P5Dm5LLFv5x2e9OUCtXVB0iboxT5YjR/RjBDpkAc4Gkk7jDfSLF8Q6SvH6ubTIr/e
 Ra8uEJW+EIrWuqMvCKnPZgAwwvaJJhdO0PUUfe0GFCLadTV/gazEVNwLpq+uqoxrfpIn
 8YGw==
X-Gm-Message-State: AOJu0YynZAVifMVu8+hVltmJdzMOMdqMy5MpE1KDmOPUXOZVjOHeMzBW
 UGDJlfb5RwEIVuT0DLIduXiDfJl7vydn53VfeAGzwZPJ5wFYsmTZjL5jPVLUzCbSVHCVk4SpmU4
 fdGxBJMNN/kG8/C9KY8XOFgxRLYWaaPKV
X-Gm-Gg: ASbGncsFphL9lcJpNzvVXzSTGqXhxXGHOI8+h3clsB99nhFXllGxGE4zUjLfK6ITC5n
 qWb1zhZT0Q6PCQPAQEjlmMdfZyaMFcWWqo7/V3eB04jG+HLEym5PskQb3WM4/gcg=
X-Google-Smtp-Source: AGHT+IGr9Ak9nb7I9FIHRohEBfOyzosBwLj8T7xuaGT9nbkFA0+kdL2aIwRmtJVc7oWiyze0JfgcTAvkn6d8AKKd7As=
X-Received: by 2002:a05:6512:ba6:b0:539:fed8:321 with SMTP id
 2adb3069b0e04-53df010eacbmr7019719e87.51.1732879448266; Fri, 29 Nov 2024
 03:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20241128151233.1962926-1-alicja.michalska@9elements.com>
 <85619442-4c18-4cec-8176-d7239e023474@linaro.org>
In-Reply-To: <85619442-4c18-4cec-8176-d7239e023474@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 29 Nov 2024 08:23:57 -0300
Message-ID: <CAOMZO5AsTCxvO+QuB7CGPu9nLeNmywo6N4XkNukTWtd7KtDZ6g@mail.gmail.com>
Subject: Re: [PATCH] Environment: Change reporting "nowhere" as "magic hat" to
 user
To: Andrew Goodbody <andrew.goodbody@linaro.org>
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

On Fri, Nov 29, 2024 at 7:35=E2=80=AFAM Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> On 28/11/2024 15:12, Alicja Michalska wrote:
> > Make string more user-friendly
>
> I disagree. I can make a guess as to what 'Loading Environment from
> nowhere' means. To me it suggests that it has not found anywhere
> additional to load an environment from. It is a bit awkwardly phrased
> but it can be understood and it at least sticks to reality.
> As for 'Loading Environment from a magic hat' - I have no idea what that
> is trying to convey and that lack of meaning is not, IMO, user-friendly.

I have the same opinion as Andrew.

It is easy to associate "Loading Environment from nowhere... OK" with
CONFIG_ENV_IS_NOWHERE=3Dy.

Changing it to 'Loading Environment from a magic hat' will not make
things better or clearer, IMHO.
