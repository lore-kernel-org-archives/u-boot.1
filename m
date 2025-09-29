Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0519DCAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 18:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6613F832AD;
	Mon, 29 Sep 2025 20:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xJZHxAM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E4EE832DA; Mon, 29 Sep 2025 20:08:48 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE50C82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 20:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex.bennee@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso3913867f8f.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759169324; x=1759774124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sa/is+6Xat5RR1GzShQnNksnpgfay0FQYp0bODEPB78=;
 b=xJZHxAM1Q/m0M7KW7AlnbN4Ub7jZ/UphoLVz/0JiupURJM3pcwd/54G06P/9LqcIs1
 Yx26qqo7XDf273eAWKbLS7bfIDhdRgPY7MTph5dSKKlTqneko32RuyCaIP9sg+4pIbWe
 ZxW9bdhibeeIWOYtKubLgbCUWuItp2fwC7xojO1iS5rczgeU0lejzTybt7jUoTcZ+gC4
 RV+OBjIE+gletPvcn618qnTnNJejDgkpv1vVf0Hk/aOCFgGERxgBNdz4Adg4IkiVtpCK
 CyT9KfgY8QlvhZkp5Y8/k0rwL94FN7QS71b1wLDV7Vr/D38RxlsqxFrjA7CXMj5MSU+h
 q3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759169324; x=1759774124;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sa/is+6Xat5RR1GzShQnNksnpgfay0FQYp0bODEPB78=;
 b=DlwUE8u5UekU2WSUa9Vtpy+xBKJ5nTVPR+gxyAWf9fOLKGpc4xdczrth2dyc6aLUoO
 8qmSQS/PY/XWeT2PPvlRz+KlZIUhRH1KeBQNoicmKZSlvmVImcrotHmrXUotqYS97NSe
 s/I4LWNV1LyURYtp1nQARZec+P8eunJEcVFCSa+HIQzCydTYUz87c8+pQddc2nVujFGe
 X5B6eKoqfuKYS/uIzLVfHgQ/4nnJa9deCeeTcb6yNA/Iy+YdSqoN4zEWL6UKGLYDxSgm
 hiOa+b1gd2ngk/athqCHOZjCRw6KX0ba9E8JL/uHppciJEZvWWy1UpXyszfRAAEG3h0c
 Hz5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu8q+TpnWCk8/5o7taKHukVicc+m5vKPXCrzGaSJ6Fhw+3uVy5OTT/CVSxtXq4lgz522CR3Hw=@lists.denx.de
X-Gm-Message-State: AOJu0YwoF5MVt0d2ZkMdjFOlU/X5EAQexDkzA5asaXPjG3xorocAOJzC
 AD2ro7zIeVp9qwJVdh9IV97wZ5cHeQhj5ri3JdSE6hToLPJVFgZ4IqAKQVNTUrxVC07D+i9GIXK
 yiub/g4s=
X-Gm-Gg: ASbGncvMevg09YC2B095p4FCW6Z+BWFUj40JzKFAFIhjAQRAisLxVSdKpZnNh5KpY3G
 BvaEK+kU+/gJXGh41ShrvbHE2Ip69PR2DJ7jvjYT+FFad0Z5JGrT8LIh21pZaYqOaM/WogvyipC
 URpQ1UziFYq6TVdjdUZCaPLuR4RYRDhxat3zaDOs6E9JZ7u1JjGD/1K7SkmQnvZAGYS61MOLZas
 yRsYt7NIHPV59u/Xz4psVln4I9VAtohAlqK0uOMbzQxP0mA8qv2aJ1iMY25GauTcE8t7a+Me5rJ
 Fy+JyWMx00Nk0g6DlyT1OTVTdV9hrpIZjqVraNbc5fQUL6AhHomi6EZ+4Neq3ue3K5JdLOKx7f0
 oicZHN25qj0l8qBFXLOSNqS0WwcA2XA4xJA==
X-Google-Smtp-Source: AGHT+IFAxtUjiIk7vr20gQ6yIbeAV+T0Rh02llDqnwwkppPPARBCp39aKCZQ/1jHRmaYFYXiQdBang==
X-Received: by 2002:a05:6000:26c9:b0:3e4:e4e:343c with SMTP id
 ffacd0b85a97d-40e47ee1947mr15166498f8f.31.1759169323782; 
 Mon, 29 Sep 2025 11:08:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb017sm19201532f8f.3.2025.09.29.11.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 11:08:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EF1FA5F83A;
 Mon, 29 Sep 2025 19:08:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 u-boot@lists.denx.de, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] link principle license to COPYING
In-Reply-To: <20250929165042.GJ6093@bill-the-cat> (Tom Rini's message of "Mon, 
 29 Sep 2025 10:50:42 -0600")
References: <20250929155142.1647606-1-alex.bennee@linaro.org>
 <20250929165042.GJ6093@bill-the-cat>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 29 Sep 2025 19:08:41 +0100
Message-ID: <87tt0ljfme.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Tom Rini <trini@konsulko.com> writes:

> On Mon, Sep 29, 2025 at 04:51:42PM +0100, Alex Benn=C3=A9e wrote:
>
>> Some license scanners are particularly dumb and when combined with
>> automatic license scanning for FLOSS accreditation on forges cause
>> problems on renewal. As GPL 2.0 applies to the core code link the main
>> licence text to COPYING to keep everything happy.
>>=20
>> This caused issues for the QEMU project recently as we mirror (two!)
>> copies of u-boot in our project.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Since Daniel Berrang=C3=A9 posted a similar patch 3 days ago, I assume the
> gitlab license renewal is coming up quickly.

We fixed it by temporally moving the repo to another project (although
it seems that is not a true mirror as mirroing needs the full paid
GitLab). However it broke a bunch of down-streams tracking earlier
branches.

>
> In principal, I'm fine with this and will apply a patch shortly.
>
> In practice, we've always had to get a human involved at Gitlab to get
> our license renewed as we're clearly within the required terms, it's
> just that we've also got some further reading people should do.

The GitLab process is a click though automated one now. However I did
check GitLab identifies the right license with the patch:

  https://gitlab.com/stsquad/u-boot/


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
