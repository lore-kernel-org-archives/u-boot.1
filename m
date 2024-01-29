Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F048C47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ACD487D6B;
	Mon, 29 Jan 2024 13:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eBEnS+gx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F8487D6B; Mon, 29 Jan 2024 13:12:42 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C42B87A00
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5ffcb478512so18051147b3.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706530357; x=1707135157;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQNNkLEdFRbSLCaaza6xpsvQ3FU3WJoTWIxk0fOErDI=;
 b=eBEnS+gxvtD81XPZn79MA4AZKGKo13WNea0iighZuOcEyK/F8x6jqE6ZjHZX0KMTLl
 EHK/hCUb9Jqq83Fc+eNcKiZwhHDHbPUT4NQZINu44X3XzGm+/ImqFvRbjN330WDAZQgy
 QfyAO/8yrVOIpDfz0ORSqiYwHGgYl5BKly/eE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706530357; x=1707135157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQNNkLEdFRbSLCaaza6xpsvQ3FU3WJoTWIxk0fOErDI=;
 b=HPTEIpK1SKj+oNtIqWKW+Ea2c+3X8CayOENDowL4N5pOun+N1kWM84MTs6Mmr+jKKQ
 UQwHFbvICB14l2WcpbCTW9tg3N0Dh5GMT6Dag41/nT66eCJBLP4Nm2XBpChigjmZ7zAA
 ymzXvuBi9klaLBTVnWn9nPaXVlF2HD7/5McV4yg4O3NlNm8KoLc2aEMYOduJqJHFif3s
 cBhS8WFrbl2u1bnFB/Gn648DNpHRfi23q56O5HIGQalkQXIKLL+Qpp5ZgbyE+uAk5yC/
 6dLJOKgwsUOBsq2KzFyY5482l5QqJXKpx2W3aOHBR7X0SJGQzaZ/IFFGxtm3/Hr8A29Q
 O7Kw==
X-Gm-Message-State: AOJu0YxjIQ6Bfm8Osjg7AGR7swHtJfUG7Wxj3IfiuOvHxrJCpSY0O/v8
 IBbqffFPEGqEJrGRdkUXeWvNqgNDVE+vqj/XlGWc1mbYmMSL7vs/JkH44MPcUSrjjQY1NdGfpNr
 /IHK1C/E62YGIDgu+z5WUpKqt+ATUUAsn9jZGag==
X-Google-Smtp-Source: AGHT+IHYCEWvR4a6sZWrn4pnPnj8K77mmeZ+5y1O1+pae1lOfJmGpkLD79ZDff12Si1xHs9F3WS/9/ZA2/100O1tsG4=
X-Received: by 2002:a81:ca50:0:b0:5ff:9565:6f59 with SMTP id
 y16-20020a81ca50000000b005ff95656f59mr2302250ywk.3.1706530357049; Mon, 29 Jan
 2024 04:12:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
 <d0aa3dcf06edcc781d256a603f3d6ef4710affd5.1703220284.git.Takahiro.Kuwano@infineon.com>
In-Reply-To: <d0aa3dcf06edcc781d256a603f3d6ef4710affd5.1703220284.git.Takahiro.Kuwano@infineon.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:42:26 +0530
Message-ID: <CAMty3ZDcCsT_As2UbkUO3EKGL=PTSGUSohQENDNq0SgDWJsJdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] mtd: spi-nor-core: Consolidate non-uniform erase
 helpers for S25 and S28
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, d-gole@ti.com, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
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

On Fri, Dec 22, 2023 at 11:16=E2=80=AFAM <tkuw584924@gmail.com> wrote:
>
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> s25_erase_non_uniform() and s28hx_t_erase_uniform() support hybrid sector
> layout (32 x 4KB sectors overlaid at bottom address) and doing same thing=
.
> Consolidate them into single helper named s25_s28_erase_non_uniform().
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
