Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14DFE7E626
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 11:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7736686D47;
	Tue, 26 Sep 2023 13:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="D9+JK2JM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5503C86BEB; Tue, 26 Sep 2023 13:37:47 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A289B86D3E
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 13:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5334f9a56f6so9532374a12.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 04:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695728263; x=1696333063; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R95ARRG8a/rSE+6bNgFXj3DkpCYQEZH8VYTLPTbk9Ck=;
 b=D9+JK2JMRNiasEA2pGRIPMGmlFeHA3YlJrypaRatOlm3LFS3eJAMYM99Lv7PBXYd42
 XBJAPPaDcrCo3qr5D/RS5MzwMXjfW1diIMo4RfEab8nfM4oQLsncSKs+H6KSyHlFvtwa
 ttmsxP2FInlbfyEQ+ZnAvIlpEm0e3Vwm2qT7lw3oUM/5YI2eK/VOLKVH7td/ZD2uXXcU
 2b2efkwwM1+0eUKT4/pxJwJ8zbnXhcYGvRYxKU8aKJOmapcS/2EDudZO6O5UcGylizve
 7LVNqa5XsvL/VNu668+JN9Sipqz0kBtIZqpbqF65HTeKIuBjDKnXecohf6JCbo51Kzq5
 Yw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695728263; x=1696333063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R95ARRG8a/rSE+6bNgFXj3DkpCYQEZH8VYTLPTbk9Ck=;
 b=NM937rqn3eWUL4ehE1H52hDrXGJnsG7Rl9GsSHlXmn7FG4SliAst0kjIZ4CYSnjv6j
 DMAa1LDw2hzZuJG08CxMwv40wrREECJehO7Xta9Ag4btcaMVy4ugFQpuY9jjT31WEMP8
 GNJ4GY99CVTVx7DakQEtZwXKOf57pZhxgu5/ZtbdHyleq5oYb3aRVXfyvA+pi2E4zmHJ
 gnuziV2Wnynsp+Ci44Cb73fMpFrw7KO67ToY4I8H/gT6roU3fNiTlXNLxVh8yMVKqt9m
 DLhyhyid1TEv0dSJNkvmXyuvXiWPw8tSbcnw7XPBQucjaDwh3n7PyVfzrqP20WF+m3B0
 ihAg==
X-Gm-Message-State: AOJu0YyyDiCYBJ6LUiyEq63Gp4Ejq18n7YSZ3+727t4LCHrNBZo9eCFQ
 O+Qc05vygzhlYxCf7RF3b4E15TFGUkkrARgrNyyTMUAadPqOYrYRZAw=
X-Google-Smtp-Source: AGHT+IGHxj2s9/A6L/gTgasRsTxBYiszQ3JAzwmMy7InJ/zCm3HgzPUsU70ZLl95tpNz3DQ6QoqvREbMjmP+kvM5jkk=
X-Received: by 2002:aa7:d618:0:b0:530:d8df:afaa with SMTP id
 c24-20020aa7d618000000b00530d8dfafaamr7690204edr.41.1695728262877; Tue, 26
 Sep 2023 04:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-2-maxim.uvarov@linaro.org>
In-Reply-To: <20230926094124.7024-2-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Tue, 26 Sep 2023 05:37:25 -0600
Message-ID: <CAPnjgZ2OV8ug3+3ji8nEnK7cwONu7KFa2zSyP5urKWUkQvMqJA@mail.gmail.com>
Subject: Re: [PATCHv10 01/15] submodule: add lwIP as git submodule
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
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

Hi Maxim,

On Tue, 26 Sept 2023 at 03:43, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> add external lwIP library as a git submodule.
> Use STABLE-2_2_0_RELEASE tag.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  .gitmodules            | 3 +++
>  net/lwip/lwip-external | 1 +
>  2 files changed, 4 insertions(+)
>  create mode 100644 .gitmodules
>  create mode 160000 net/lwip/lwip-external

I really don't agree with having submodules in U-Boot. It's just a
huge hassle that we don't need. We still haven't figured out how to
deal with config fragments.

If no one else is interested in maintaining this stack within U-Boot
and syncing up every now and then, perhaps we should reconsider
bringing this into U-Boot? We would never normally accept such a large
body of code without even a MAINTAINERS entry. Without a network
maintainer, even the integration layer will struggle to keep up and
up-revving won't be possible anyway.

In any case, if we go with lwip, we should copy in just the code that
is needed, unchanged,

Regards,
Simon
