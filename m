Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7060D12D5F
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 13:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C7483AB8;
	Wed,  3 Dec 2025 14:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cYc6pbBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5898983F82; Wed,  3 Dec 2025 14:42:23 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D7DE80FA1
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 14:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-37d275cb96cso56395801fa.2
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 05:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764769340; x=1765374140; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uv8S3BUtgLam1OzpQPT9BN/qmdpMHj7pWM+zrsJnlM=;
 b=cYc6pbBqHTeih2K5qeOvjhoeRXtQIuH3F5LrYPNFGhgahm8qwyiZbqf5aBO7yVkxR7
 iTlFtfjMzYf9VYPwaHJOs0gwSTdrhWIu4L1w0Pw/k5xf08mE5GGeoS50LnSlA0i7xuJl
 f99ArDcBzIiduQN7wf7olW8DetHt1owKFhh3fH2HugZJudsVic5Lnpl1YzEATgPv0g66
 dXrAGkDDAsPPXpOo9GOvAB7kJIOftRZuJRmJrPO6qt9vwQA/QOD9eUf77+uhkdrQ4gVU
 v9+cxsWxB2pwbhElApiC6MWfz32jD8xhrxn5HTMKW5RqLvtoHtM28alWqRspHoRUwxYa
 21BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764769340; x=1765374140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/uv8S3BUtgLam1OzpQPT9BN/qmdpMHj7pWM+zrsJnlM=;
 b=bPPsEUXoXqLAmVprIG+ZpIq9HFPoLGyk6PQHBVL2apAf+dSJhNUT/Fm+DMQ2dJmf+w
 iTdVhYueEt7623eNwqe8JedirV1tkX5V0qwK+7vxN0gXBe3eY8qur3vdQxNiZwcjIbou
 oRKho30/LQIBUA5mh5460WsXmltK+5Gqdp6/SLBPwQQ/l1k8mzwwBN86p3mK0tENr7lM
 G0AMWLxtzmZsvksjeSNnImv7CkHrNQNm4SZViQcYprdLsRpq6So8zfrjbds+73Nts9T4
 SsR67tjsF3BspbppNHww298X5zI7wbYGkUCoA52+8dZcgZFi257G0FOtFjn96nG/Mv2S
 D6iw==
X-Gm-Message-State: AOJu0YxLnTYdXSh2F9wHPJLWdBy0Bd1Ih0FxI1QpW3o+aJVPk9fWP2hO
 N9DletE/wsYVxXVQwIQYZdF+QMhnFgUITBfJ6kSNVuVDSDOtOApzgU2g7FoYFvC5PnoYu/toFKw
 la7bcfmFfD7ZSgQCNCFDMk5EmkzEp46c=
X-Gm-Gg: ASbGnctfTYK9WIql1dSgoZSwVu+Ysb2jUYTgef6mWxoexYDXvzj9xhoPqY0wHSHk4/l
 xJLOml3y7N2pH6sXNnGPuAaads1nZUc9SlwQsnUYCjpo0mwC55HhCFvixspeGYPNBfWHa/4BUEm
 meYYHe+C2NvkRhUNudF5W6Dbuh7hG3RWXVdP4c75RNrurgqXJPpvTWkC2zlwdBG99fYwgB32qdh
 uq5W0Rw7oYQmXVLQrgO5i9/FQ2/GwL9HvXGDrYdzlJSHUussaN5Xa6hpoqGKbLSG984ygqLrD+H
 ZAc9yvn1rbLteTHzzS8YQVG2vOg=
X-Google-Smtp-Source: AGHT+IEp1zKmIx/QDhEt1jMgCHUzfCennp8S0tj73Q/6Wnk11kvpb/+aijpctm27o3gBoZx3jkUI6PAlhHGSrJIqQNY=
X-Received: by 2002:a05:6512:2206:b0:595:7dc5:165e with SMTP id
 2adb3069b0e04-597d3f7b229mr922284e87.25.1764769340411; Wed, 03 Dec 2025
 05:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
 <20251203-topic-am33-evm-lcd-v2026-01-v2-2-262cf4f34eb5@baylibre.com>
In-Reply-To: <20251203-topic-am33-evm-lcd-v2026-01-v2-2-262cf4f34eb5@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Dec 2025 10:42:09 -0300
X-Gm-Features: AWmQ_bnQf6rQAEF856bZT8KmIQdbgBrDPwCl_RWDC2MohjI_OHcJRk4VxOHNBHQ
Message-ID: <CAOMZO5D0wZc2BQrKg=nRT2fPdPtsH=fCS1Z081KVrmR=uGWexQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] panel: Lightweight support of get_modes()
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sukrut Bellary <sbellary@baylibre.com>
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

On Wed, Dec 3, 2025 at 7:19=E2=80=AFAM Markus Schneider-Pargmann (TI.com)
<msp@baylibre.com> wrote:
>
> Linux uses get_modes() to fetch all available panel modes from the
> driver. This is also used to fetch the modes from Linux's simple panel
> implementation where a list of drm_display_mode structs is used to
> define the different possible panels.
>
> To make our work easier, create a compatible way of fetching and
> defining these modes in u-boot. get_modes() fetches the available modes
> from the panel driver. The get_display_timing() call maps the
> drm_display_mode properties to the display_timing struct. This call now
> uses whatever panel operation is available, get_display_timing() or
> get_modes().
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Allowing U-Boot to represent the panels like Linux does is very helpful, th=
anks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
