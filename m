Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981F4C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 13:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31D2A801FB;
	Fri, 28 Feb 2025 14:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="teTXlOTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE910807D7; Fri, 28 Feb 2025 14:23:33 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57E6800B6
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 14:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6f4bc408e49so19480467b3.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 05:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740749010; x=1741353810; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2eEyTKORNo8/zYii7aU3A6jgFnQPOLAFKnbRyuVLjfQ=;
 b=teTXlOTVruKZUfn4U5UGUlnD6nHuJVunOLfZcFTxJb10TZ43b1w1bFNYMKlfNZZhuv
 Rw3oVQpDWkHj6/JnEsPkRdp4iJobWg5O2ZOXN4W6vWx8nnXBoeh9/rKolgGiDgnttZmB
 PV98ep68O2MC45XSNz1nZXdMAFdsxdTrsEcLOJgSf7HI/2xSixkXEFbunTLw5Ar+Hngn
 eEGsDvB4HozekhIImpZalCxRsDIirB47Cg3r6z8AeKMHmgcF05dSDaqo4WvcBkAbIhvJ
 RTuk2g44SU2ClLsXsDe4h+/5MCvbiHZncXIGCSVUmrD8hCZ26Ktgjt/t2qSUlIyaMC/W
 v4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740749010; x=1741353810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2eEyTKORNo8/zYii7aU3A6jgFnQPOLAFKnbRyuVLjfQ=;
 b=Q/5RPnfz6XbDyoQtCO62hG1mHHv1Lt1FUNCeSGD4QRlnPBBgle6eOxXUObZcW8GywA
 P97r3zjliGzSVwXVSagIzyrGPju5HTvLuZ4ikavLSUVL+r7RZlQLghH26IGYgrgjI/z/
 nGWMhA2zw/iDOufuNNcyRcZK7FuzENKRkJZA075DOsB8fiIjj3O/KvWNkoHRDqPD0q+V
 o2bDoa6J8mUMseUv3eVLpsYLOi4TsFm5a3CR+KvU3kFwUFhK9L6CqUsi0Ly9ii9ctrlE
 8RMtHJkbxVVzQi/ZFgpch0vRMTiWzNoX6bBw2vWDTYVdautSH/j494XMaiJs3RqBhEUi
 yxkA==
X-Gm-Message-State: AOJu0YxzftJmc9Dbcypn/kZ5tuGwJeTYBdVBQnwYtXWdiexkMfS2Wxal
 Woc3aGvfAHcGd3JdVm74M2frzXOCe+4GF4Yd7a91954UwGBYHpKBhgAeTj9CQStwKi25+CdAVzs
 QH93VBOy8L/H3co6DmtsHptPQ+U4XkwqZfXf1VQ==
X-Gm-Gg: ASbGnct1H2bEh5/Cp4/3CBNf0B41aRHEwzWwlhDz8Wq2dtHZhOfyQQchZ43KzqSb9Bw
 YdImlaim2HpAZ9VVtKZt/BUVtAkoFwMAvLJrj2EianrYm9rOa3iRCG/HGdzwB4JbohuovM32l5E
 dy2hnjcyGOMCw2el+ZxdH603PMqh2gcPBjQzO9jhM=
X-Google-Smtp-Source: AGHT+IHDrEzmV59rxxY7XAjQ++P/8WXr92/mwyJ1KjTvtter9yAu00WyCcS+L3BBRdPTUT5UvrKK4fV2tT2+qImUaUQ=
X-Received: by 2002:a05:690c:350e:b0:6fd:4670:80c6 with SMTP id
 00721157ae682-6fd4a21dc1dmr42428657b3.37.1740749010571; Fri, 28 Feb 2025
 05:23:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <f209e0a9ca2dc8687599d9938fc319779cd8e08d.1740499185.git.jerome.forissier@linaro.org>
In-Reply-To: <f209e0a9ca2dc8687599d9938fc319779cd8e08d.1740499185.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 15:22:54 +0200
X-Gm-Features: AQ5f1JoJV2DKWBUR8oq4DyU82_QlcGp_vBzS9WK1jgG7ja2XH97L9rJ6g1rgMTE
Message-ID: <CAC_iWjLDHeBTXKZ6aMef5yMgURDUY86gEbUuwD6GCx81B63Utg@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] cyclic: invoke uthread_schedule() from schedule()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
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

On Tue, 25 Feb 2025 at 18:35, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Make the schedule() call from the CYCLIC framework a uthread scheduling
> point too. This makes sense since schedule() is called from a lot of
> places where uthread_schedule() needs to be called.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

[...]

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
