Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31C7CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C72786D24;
	Thu, 21 Sep 2023 03:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="VgW4tKDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 354B486D78; Thu, 21 Sep 2023 03:06:30 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C3CF86D29
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59c0a7d54bdso5568927b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695258386; x=1695863186; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E3yB+Pl7pTIjTNWwpsJppSHyHrEJDFSVOGeg09ihzV4=;
 b=VgW4tKDTjktlIan11WotJmj+BD1ENU4+imee4T1AhQNUAyBothJghs6Z8EPEhTNq/9
 OFBse745keaZyafIHCuM9UneCPxrA3sPXrmjFmIP3xGzL4ZlPvWEy8Ldwy7l6v4jkRTi
 xQr5Q105QdHMePQ21r6Qtqbu6Yz4Ss/slvo3erwHlpMkLUoYh3+EWxPO1QcYQcIvHJdI
 ikQfKG+LGft3uqZsO1RlBdq69CuNFXCoIHwWKOS5xq6Q39uM1iTK40hcXSS52M4P03bw
 LMdQ/0om3HADSmhK6+ICuRHVvAASDF6+Awkxb3cjjefFKnO1dLNwcxQLQkpNhN4JMC+E
 MLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258386; x=1695863186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E3yB+Pl7pTIjTNWwpsJppSHyHrEJDFSVOGeg09ihzV4=;
 b=HfQWT/Lbh1vJFJNyBd8fwaRiR7BUqPDB5gEWbOyQJDTExIDSgScmuIZOQ74PZOraC7
 iihmTYG+P2u+e8JZDgtOUtbaME+NwKxRfpis7E88PTOJgKnvPN6abvvkGO8aTbERtBMJ
 9euQ1T4pnT+YOvpwStzPYKcSR+Hk9zdxYZE3V1OlkQQLhCSEtAcg+1rF4vkFVCwoYZpX
 nD0EsyoRtTkb4YAa8EuMwj9xBaCC2ohjgoredqn6HshqcxBWT+q8Gf0U+AlyGwgy3jU9
 YNzCkBk+I7vQ/3aICk/VMlQNaq1eK+nkKRL/hBZK8hJV05y4gEJ2NUg3nnC4ph549ani
 qBxA==
X-Gm-Message-State: AOJu0Yzna3ZVp8cf8d4fK2cmpBLjzZNu3elHB2z3ILEIignG2hShXCj6
 vTILpBk0u3bd31inFdLHflul7EB+NXmFsn4mijDE1Q==
X-Google-Smtp-Source: AGHT+IGrCRqLUHiqFWdxD4OA5G5Q1eAhuuUQ43+run9wJMYHpLz3VxhwmLjxx5qcwturYCa2huZg1OYquuHLT0QstJ0=
X-Received: by 2002:a0d:d546:0:b0:59b:69cf:72f1 with SMTP id
 x67-20020a0dd546000000b0059b69cf72f1mr3646625ywd.45.1695258385895; Wed, 20
 Sep 2023 18:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
 <20230914161828.3662-2-maxim.uvarov@linaro.org>
In-Reply-To: <20230914161828.3662-2-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Wed, 20 Sep 2023 19:03:07 -0600
Message-ID: <CAPnjgZ3tr5rqdPfnUS=5F19-7R9SU6fpe3F7o9+TghKs=m7zrA@mail.gmail.com>
Subject: Re: [PATCHv9 01/15] submodule: add lwIP as git submodule
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

On Thu, 14 Sept 2023 at 10:20, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> add external lwIP library as a git submodule.

Oh dear...what is the motivation for using a submodule?

Our current stack is nicely integrated into U-Boot. This would make
moving between development branches much more painful.

I would much prefer that we bring in the necessary code, and that you
send a patch every 3 months or so to deal with updates, making sure
there are no code-size regressions.

Regards,
Simon
