Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A46CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 20:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE3868389A;
	Tue,  4 Nov 2025 21:43:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="avwI2ZuG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 189CA838A5; Tue,  4 Nov 2025 21:43:09 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5648004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 21:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c2948b774cso4049621a34.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 12:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762288985; x=1762893785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RL0VVpQv5fI8P0H0CZCJGjg0V7CruSAGmzXT/iSsrXc=;
 b=avwI2ZuGd+NfTLLU/AGKjOaEQ0lK+RzntVdio+kD2ITRFcUBhY6odm2oIhHSK6jBZH
 Z0n4yYUOb7ZsaPrrC1lywM9kcBkOIkyrigVygtgothlR6kZTKlFnO2FcWtBza55CB+rq
 SLs5oHCKO4k8kjDzWP2oZ6k9xfWwQP44gBgPJzmy/20LmoWsnwRDJSaum/xt1GVwJ2a8
 xr399ctckhDcahPmye0QKaS2cCVHaAobBJ3JhfZciHY8qieePLGdDGgXmw0SsKmaJP4r
 7xFKOLxKeF1zwgI2IdrHrNVeXe+fMy21+uy8sU5NaowEEKxg7MjBEjmpH1SsWpZ22Xo2
 kdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762288985; x=1762893785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RL0VVpQv5fI8P0H0CZCJGjg0V7CruSAGmzXT/iSsrXc=;
 b=Fmz62866FKJf8fkPNqCwH5eOc7HtNE3dTVVsdxwKSiO2E/b0Yu4mLw8rFrJS6ZVBm1
 /fQ2MXFwNQ+GQv0015dYDbUgR+Hf1+3IpgV6+K9H+eJWsf7Uks59efqFR7cshDSemlwZ
 aVmrlXaH89U4rXhlCAKfNWLb7Yj7B2avNgOAz3cIG+XjU+fRUfIWDWuJZX/9cKJn57v2
 ubcNyIFWi0iMiDoKOeAgt8SeiHM9ZBKlLE1hF7l1r0O9+MmreRKkW1Sy+U/Z27NPZVY7
 C68Ku148SET9zlSi+132lqp88uagPff8HDPaugWiIs8Y9SGBO4HNynN2Dch06am0tX5G
 3sQA==
X-Gm-Message-State: AOJu0YxN5OGyBgM27rdgRxmJJQX9k4pwhOxb7CsHAkJ36ASYFgisQv9L
 bNxEFiR1kGNxDmnwdcOaozyOTgbvyM4Um4JJqUfg1p0mNsaX+MifoBuTaVRn+u3jNo2adhZrrbf
 ib/JIfCHctc/2E+XmeIe+SmWdpZjL0S/xdkGi
X-Gm-Gg: ASbGncvjMdG9JFe/Nztqi/aNMhhBDC61HjbrqJsEklPyKiBbduEovOazEhbSwlD/VrD
 uoO0CFBGod8LdlkPWmsLJ/Q2yFFv+LoFOaGa6FpRFsgecuFGPikoC41w0jeiNSlFO3GsAwoc2Tc
 otlSp7ZQe3wm7DWE9b2ebhj2ZdgLEJWo1owZN5qJdhFUcX3Gm6bCp3uCyZf6+9ZA49dLvKL36t3
 5HaHnG/KU9ioXgkRzSmgQYXM1h734I99V7JEy1Ipb9Dl4tYZ1xBsJWpwTZL
X-Google-Smtp-Source: AGHT+IFgG4TW/akHc2PGoeoiPq4LqWUR7vx89cTNpAVTLLUAe2H6SkPNRNeDTQSiWJ1/g+p3bOoKdKOuY5cZGNSqwc8=
X-Received: by 2002:a05:6830:2646:b0:7c5:3aa3:4927 with SMTP id
 46e09a7af769-7c6d14aca43mr467764a34.25.1762288985215; Tue, 04 Nov 2025
 12:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20251104010003.525-1-briansune@gmail.com>
 <20251104175123.GE6688@bill-the-cat>
In-Reply-To: <20251104175123.GE6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 5 Nov 2025 04:42:55 +0800
X-Gm-Features: AWmQ_bnie-6_JVBUV7KxQ5kB-jAh1RpfzoBQiJf691KGaepc0zd1jLh4biTspHU
Message-ID: <CAN7C2SAvyfUyTqy8sqKxPWPG9Bu+aYiXGjMzfVJxR+mc59TD4A@mail.gmail.com>
Subject: Re: [PATCH v6] Add optimized Makefile support for SoCFPGA handoff
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

> This should be able to reside in arch/arm/mach-socfpga/config.mk and so
> it should be moved there. It might need to be done under "archprepare".
> That would also let us gate even trying it with an ifeq, like we do
> currently. I also don't see that you tested this "make O=/tmp/somedir"
> (which is not the HANDOFF_PATH thing) and I expect it doesn't work there
> as it references ".config" and not "$(objdir)/.config".

I am not too familiar with make O=xxxx i never used it.
I will check what is the issue here.
Meantime, do .mk is same as Makefile or not?

> Finally, since you mentioned AIs in other emails, we do not yet have a
> formal policy for or against their usage in this project (it is
> something we need to discuss) but at a minimum the Fedora policy makes
> sense to me if using one:
> https://docs.fedoraproject.org/en-US/council/policy/ai-contribution-policy/

I don't think asking general on syntax run cost is a kind of issue.
Otherwise it will be a huge trouble to include all people or even
referenced website from the beginning. There are thousand kind
of syntax that can make things run. I will ignore this policy, sorry.
Even google these day uses AI supported engine.

Brian
