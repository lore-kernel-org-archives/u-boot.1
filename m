Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1122C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 11:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D89D877EA;
	Mon, 18 Dec 2023 12:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UnBQI7xG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD71877EA; Mon, 18 Dec 2023 12:38:43 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7375A8773C
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 12:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5e745891a69so646007b3.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 03:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702899520; x=1703504320;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nir/ny9zCIziJl6oq7VlFDcFFx0Ad+GR0KBgsiYL1FY=;
 b=UnBQI7xGqt1SlNBTAoh6S/xHJpaYvo2QcZv0XPG3XjormNf/5s+NEBmUPr5UIzlgSI
 Ile38plJeIov8ypXBZlP/8ZYhEa7Hi8i9HHTUUzb/bHnY0E8TWO8IycweTM7cM1lVpjw
 xPGxlTM6AexoWN0y0wbpexqF8eq43GoMwRqS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899520; x=1703504320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nir/ny9zCIziJl6oq7VlFDcFFx0Ad+GR0KBgsiYL1FY=;
 b=Oy2LWP5otWZZ9d64nuN3hy6Keft4TjJ57Ndlu8z0+zXR9cU0iabYBpOK9TkILGnGom
 LN4GAMHe1ajEZSC1DIO/1jTSao1qtSWny/Z6XtbqY1Y0S5SzTYt/+eMOqxY9EiJwsQ9s
 HAuXvo6GwzRbxczPyOyQLHtkhJw9YDXru6Xan7XBaL2LECT2yyxy9PbT7q5OZVdjnP2X
 0fjwzx5JIcKAdal8sn9rbLqpmbl3BGHShLJJwd2R3GxlwvwLlDWfeTAShYW6a4kQ9hg9
 vpyuH7S656ALjHlYsj2DHSIMdSH8zPyOK8n86SDlzl7ZmLLMjYrVc7hxgd8YocNbdAlY
 rGsw==
X-Gm-Message-State: AOJu0YxnazhOmt0WOLAlkO7i+NoJ06k550dQtfHqrte3twGRZKpBBSWm
 119JTAfXode+Fgr0y+wBo2i0CPuyi/abzOsFwsWLQRSKKHDkNvW48+Y=
X-Google-Smtp-Source: AGHT+IFa+TtstrN733rPtTFtTexrd4XMMHChWH6TVnhMsyc72oinDH41+YMyQ2Wk//814P/KcgUKhpAlF+d2SR6bZD0=
X-Received: by 2002:a81:7c05:0:b0:5d7:1940:7d79 with SMTP id
 x5-20020a817c05000000b005d719407d79mr12154132ywc.80.1702899520165; Mon, 18
 Dec 2023 03:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20231204085247.9772-1-venkatesh.abbarapu@amd.com>
In-Reply-To: <20231204085247.9772-1-venkatesh.abbarapu@amd.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 18 Dec 2023 17:08:29 +0530
Message-ID: <CAMty3ZBKK1fB3jGZs9PrrUi5d26Cm4XBRvBgN_KREjYV8eZzgg@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Add IS25LP02G flash support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com, 
 Sreekanth Sunnam <Sreekanth.Sunnam@amd.com>
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

On Mon, Dec 4, 2023 at 2:23=E2=80=AFPM Venkatesh Yadav Abbarapu
<venkatesh.abbarapu@amd.com> wrote:
>
> Add support for ISSI 256MB flash IS25LP02G. This part supports 4byte
> opcodes. It also supports dual and quad read.
>
> Signed-off-by: Sreekanth Sunnam <Sreekanth.Sunnam@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Fixed the name to Sreekanth Sunnam.
> ---

Applied to u-boot-spi/master
