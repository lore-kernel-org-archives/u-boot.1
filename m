Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBF5CCF9E3
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 01:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C1C083642;
	Fri, 31 Oct 2025 02:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VtM2yDf5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F00C783893; Fri, 31 Oct 2025 02:51:46 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E138331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 02:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-592fb80c2faso2192576e87.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761875504; x=1762480304; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQSbuFlvEIHu5BxE3Gvi7/j673ZV1lbmqOnC2efIxJM=;
 b=VtM2yDf5POz/4L04rPzlfPUmeYzKhYcDRyF+GOO4G51+Czo4RU8QCqf2SMO/1HL/Os
 6HTBAuh+IE/LBzbXZqGtV7ig1PPbEsus/GA5pWdcQ/Nw2XqP1zYjUr8qFnFpjxNM6CAz
 vmAbt3mxZtwdrPfZ0EamnH9HAs11hgj76/erFnCXItt3btElBkisMZpqgoacVEv4b+Ee
 3ZTDAY+pmW8LP/c4yCE+zqrEKoxcKetIGX83URVf2GJV6W6CcASEIsp7jI+xj/Frd8MM
 W2NkWNEmhVZx4Q5K+T8BxAjxCb3Dhzql5eoxnB4UzF+AE9PK1SyB+I6H4EcPfy1YJWPD
 2Aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761875504; x=1762480304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQSbuFlvEIHu5BxE3Gvi7/j673ZV1lbmqOnC2efIxJM=;
 b=meHOIPx4CmIfGct+Dt2OO7oPBlpMgmCZ3gQqJlzp2EiKTJhUCRNe2QfA7jlmPXj3e8
 CCM93OU/vSLoKH9HhLNnoPZdgmWaB84+RiJmiixr3uhcSbnZ6XeR/VzHgzqtvgUuSMxD
 vOJHSg0PSWHZVxXDp9wiKTdO6oZvr0PP+C5I0N+g3R/0VF/j0zxRIwDfzQzmX4qLemEA
 FaLfNP/VaJltfwaVPAScWJZHB12llbFbYEPZsMzaEoG3JF7mp1IWLadV9VtNjoqVb6Ho
 jttLQbkAq5Eful+KWK8WKugETfTuzZD1BvW2EIKi5Lb9lnjPg51PazKr5XNmXxbYYMqb
 Sk9A==
X-Gm-Message-State: AOJu0Yx7pg56bHP1V+C1PJ0uMkIwQvVb3iI5OKfrsFjEKY05G3ozuGHm
 /udmJ1I0Bn9IBjHltfPQ9pjH4jAYFDt2Ke3yyijE0XGbJISpXYRaxk1XfFqipshjx9EdYQEv58q
 JlM0og9FcBhYJqh2cKMzK6fqFPux4DExeDf6J
X-Gm-Gg: ASbGncvAUTjKpgyIzJpit0YV4uZvJ7bjNhvFurfWfXh1ZEEGjaMs345xA/EKmQZqpvX
 90UKqk2YXYBYCNdRrhGEdXj7rqx2aibs9xhPIUeJ29zhdFQtl9Fb333HyOXgqLBJM/C0NDz4QCQ
 ejyyTP6CInQZLFLmb6PRZmKJUWLIxVlx9UC1KIsWCQrUgzr0P7U0Ftp5bOTL1D40CjxpVK+b6Wv
 6IGV4gOMYcoNDNAOSkx7Ux7n3dnpqdJdig7ht0a04x0odd7JOvHLVyBIsrr1hLPggq/zl14og==
X-Google-Smtp-Source: AGHT+IHJog1gWGWyhXIXdhzyVY1wNbvWjXqixh5iWiaBLlq/9E/fvVHhPyAvVUiCQ+M8f3ufdv1VPb/0XN9B+9077+o=
X-Received: by 2002:a05:6512:1593:b0:593:d69:ea07 with SMTP id
 2adb3069b0e04-5941d565de4mr660315e87.57.1761875504223; Thu, 30 Oct 2025
 18:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251030141440.250629-1-festevam@gmail.com>
In-Reply-To: <20251030141440.250629-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Oct 2025 22:51:32 -0300
X-Gm-Features: AWmQ_bmcZd7FVId9n6GpCzDXy6288of8nkXHySttDRJcqwFSSu36uj0JD4O5eNQ
Message-ID: <CAOMZO5BDqv9e1Z99OeF3c5DVgkkvOpDPqgcwNe7ydx521hHoMQ@mail.gmail.com>
Subject: Re: [PATCH] imx8mp_evk: Fix typo on maintainer's name
To: peng.fan@nxp.com
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

On Thu, Oct 30, 2025 at 11:14=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> My last name was misspelled. Fix it.
>
> Fixes: ae09edaeec3d2 ("imx8mp_evk: Add myself to MAINTAINERS")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
