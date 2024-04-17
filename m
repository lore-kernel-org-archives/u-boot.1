Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F469C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 20:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C44E884E3;
	Wed, 17 Apr 2024 22:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WDvEGfzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81CE388134; Wed, 17 Apr 2024 22:48:28 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 340B0884E1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 22:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6eff2be3b33so239256b3a.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713386905; x=1713991705; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mb4ZloxAQzvVhjPaFo2OSI7Cy4dAzkri+4ZXBv2y3Gg=;
 b=WDvEGfzqHnSJmK+IyEsHMzc0WefV0h7obrkp7yW+l0HeFt1tRcshhR84CifzGu7mWO
 YnffjSE8UKyvWVB4soemi/xm3mGGoMmNaqg1yAMfChDezmdBP+gd9KG32sQDnPAsGUPH
 iIBtZts2E90jleSIE5cAX/rHQm3ui9Qchj3BICBdA694VI+AYUI+5nMd7vFWiYoZGpGS
 cQY0sDwvJ4qLNLfOuu8fp29NSLjGJAIF2iTtXVn9dbGBWtmto9U2WQoMpJdHSz/eyGfS
 QQFBGOaz+jv/jonPVUhQBRepVBpMbPfXan1PeBl8GhIyjMS6SZwYBly1k2+ZUcllARZt
 0aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713386905; x=1713991705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mb4ZloxAQzvVhjPaFo2OSI7Cy4dAzkri+4ZXBv2y3Gg=;
 b=a2APG6eo/02W6EPffGz8EceqXoBm6QXDwqCM7Fy+AJH31C6574OevCbtuR9Aox0UcD
 a30gbFUkLrSRUX7NEoviaWg66krAp+gphFBSdpghHy9gcMZt8QxnEVTgYevma5KpliDe
 uWpGy/ia1w5VmrHt5Ct1fktk/MSRxQfnwetwjlipvRDXQphctJPzDJRYBSn+PmFRN9f2
 ZQ+YOFBSSouRL6tl8dqnc2L9o/uAJ9XdOAe9d5qgYrXe/DqZReDeiuEB6HG68oo8j2cP
 A/K69XesA0w4J/avWvezfgA2XS480QfDDkxWwpvbbUSZXR/8hFvBD1dbJy7a26VIlilL
 Bmzg==
X-Gm-Message-State: AOJu0Yz966VIK7IXV0C+PcOEf7syVVLTSYq3dqGJavCqLhoIyuyg4V8c
 vcVXeGTYgHI7eO5/Y+450vfjQ9INo7wvo0t11tCbrHhIkwnDJVZUHa+ePqHIYOqR/ZBXtkxzrws
 uCCNqK8iDQApvNb56Vxkbqp2oFbaRSdeufzdmGg==
X-Google-Smtp-Source: AGHT+IHHH5UxyxB2vgkBTQA6MJPuNNSAozgrEoSYQuwRQMI+bZY4h/KaGQlW8DMafYrEM9AkkNyz6mP93A6IaO07Qg0=
X-Received: by 2002:a05:6a20:7346:b0:1a7:8a55:b070 with SMTP id
 v6-20020a056a20734600b001a78a55b070mr1136052pzc.37.1713386904677; Wed, 17 Apr
 2024 13:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416192340.GX1054907@bill-the-cat>
In-Reply-To: <20240416192340.GX1054907@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 17 Apr 2024 16:48:14 -0400
Message-ID: <CAEfUkUJh27YaUM7kCJ-Y74zhm5VqzLD6Xbw=n1mZsVwjEhj+EQ@mail.gmail.com>
Subject: Re: [PATCH 00/23] [RFC] Integrate MbedTLS v3.6 LTS with U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On Tue, 16 Apr 2024 at 15:23, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Apr 16, 2024 at 11:59:56AM -0700, Raymond Mao wrote:
>
> > Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.
> >
> > Patch 01 and 02 are for introducing MbedTLS release package.
> > I have to split it into 2 parts due to the size limitation of Gmail.
>
> So to be clear, for v2 you need to switch this to subtrees, like we do
> for upstream dts files now. And a script to automate the "merge a new
> release" should be done as well. Thanks!
>
> Just to confirm, for v2, I don't need to send the commit that was generated
by "git subtree add ***" but just state the command as a prerequisite in the
commit message, right? Like what was done for the commit id
"5b825032957c2613ef2f8f639e949ae02cb5bdff".

Thanks and regards,
Raymond
