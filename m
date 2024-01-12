Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1698BC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 20:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 366E787021;
	Fri, 12 Jan 2024 21:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JaEZ2It8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C499E87883; Fri, 12 Jan 2024 21:59:28 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A581886EF1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 21:59:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d3ae9d1109so12235975ad.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 12:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705093165; x=1705697965; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xP1gUdBxSe8/nAk4ocDa4j6GkewGR+EUQUaONkGxo3A=;
 b=JaEZ2It8001SYoanc/tDdmWlNDG9QK6BZWGfvyjXPicaxIfzz3y4gllh0Qk1n3tzMt
 Iu0S9o/77Nk476/0iS8U6R+2KGZUpwYPB+9xWhmzqffzbni+To03lmok/N/QCpZB7VEn
 ywstQnFxKVbTaNExDFtz/lmtch1gzYIW+h5SvnpeNmU7WHQQvYT+v71SwbVPHr3oCSab
 SkiApE7zXLYnazgAjpoEwJGuqUYydSbvEcqm3cCgT3kPQSDyPTIyvp5yhjxpHnTfMeIf
 Ef4CI+4+jl7cwVZVD6PbVRRZgGIHWDtHAgl3f9Mo0YX3yMcCG/GQ/k+pj3Jwf6S4iQvO
 Hgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705093165; x=1705697965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xP1gUdBxSe8/nAk4ocDa4j6GkewGR+EUQUaONkGxo3A=;
 b=aT0fK/5ioGv6LRwtxUM/jzha0EM59iL6xtOR8PhyenrJUt+uARZk4j7JXnxnfDLcn6
 hoZN/GmycgkJEHoJYON/QJ3UU+IjNuUb5EyRxy8x0lG56wMiTf0Z+nB8iXKodnmf/qrQ
 wJXcYiw94YcumhxQIk/xBZNuwy7RiT2d5+PjkbgowryY9GcXLQSi220lVLiEixwnh5Sw
 SRLLcF0iBQeEH/Z1T9hIDZy/G1MVgzknh+j7lgJ1TZMlUXShmm0Mh9XSGt8MbIDlWYtr
 ucYnzIMBvN5x8c23f7vwNkiocTTWxBwAwxuCY971vTRZTuhgahjibFp8gqs0/fAw6XCm
 PCLw==
X-Gm-Message-State: AOJu0YxUC4K1a6xf7i/7cmWPUfHsEcuga6/P+BdiwTg6gRDYCwE0xiQp
 +O5nw79epi1w7aGSbKZj5kAdOnVAgm3SqKS0exU=
X-Google-Smtp-Source: AGHT+IFsq0uM+Zwxuc2JiTKQbMTdk7pIoj9M8tjBskGKNMPC0A5/gyJ/Kff2grYUkgTqOHiP2BvEZUWQpz4+ClF58jU=
X-Received: by 2002:a05:6a21:6da2:b0:19a:49c8:b9e6 with SMTP id
 wl34-20020a056a216da200b0019a49c8b9e6mr3521412pzb.0.1705093164984; Fri, 12
 Jan 2024 12:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20240108211140.3270595-1-festevam@gmail.com>
In-Reply-To: <20240108211140.3270595-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 12 Jan 2024 17:59:13 -0300
Message-ID: <CAOMZO5AxfY6NA-iWaJ3TW5s4J4+Uxoe1GQKnGjYHSTxZZT1uEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: imx93_var_som: Adjust the underline length
To: sbabic@denx.de
Cc: m.othacehe@gmail.com, peng.fan@nxp.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Mon, Jan 8, 2024 at 6:11=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Adjust the underline length so that it matches the title length.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied all, thanks.
