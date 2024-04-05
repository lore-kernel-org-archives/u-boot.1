Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E719CD1284
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 16:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A40884CA;
	Fri,  5 Apr 2024 18:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TjwWqCCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D2B883E0; Fri,  5 Apr 2024 18:48:41 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3AE884BC
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 18:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2a2d2120284so269128a91.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712335718; x=1712940518; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG921tBJ8Wl3ymp6YCill3ZVJOXnU/j/KZ3jHX/ze0w=;
 b=TjwWqCCTs5iHBqVqj2fRLktwMnCKZKXm/DjHUXMOHYEPUKyysKFTRhpsXI0cekE+5N
 5WWi4qgMCJ/Y2eAllLnNLU9EDbo+YLbIsw6Ol5Dh7qkxz9R9hAgVCN+nkw6nS30aZbIR
 REL92P8yGVTM8jTYZ950TT7ibbHVxb2ou/ATXi/oSQyyz9ZumLSq6wu8lL6tkMMV3U+H
 Ugtu/OjckfQM34W7/VmDdaCzjGabHPyPigePzsNtx3smSDeD5+0qQUkdVV2EoF3KDGnd
 HainP0qmYlEbd92CaS5cEjtViX8LLySdJbwNWggjg9oLALV4OKo0JFyZY8Yfex1tKUKx
 tMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712335718; x=1712940518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aG921tBJ8Wl3ymp6YCill3ZVJOXnU/j/KZ3jHX/ze0w=;
 b=XOLrlmpiNJqNYfc7K2o1LhTMPL2b10uI9cwOeZl0EbSNhHa+tSDIepqXi5K7nhrQcl
 2MoaeoSg+rJp71PeDk4QgQ/Plm+TcHzPwko5qxmsVIszh5xExTyfFpJqJ9NHjgtrnbE/
 YPZIKc2MrO2/Pz2Y+ih07VYNKX2dhNoDL2FE3evwFZgxtXxzECzXKJviA7bfX7rm1ws2
 xK+2oXDF/n2mkGL8uuifld54T7RTOoiJdMi4fnDC1jPJVdpmZTg9N0rvntKPtUg7uX/c
 pvPvYIhAt7T66Q8h709VCA5T21y7BZx4jr3p5m/4dlS5M/1K0VHWi3mhlWZYBC5Rw5UB
 gm/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXzpqr3rkk1Zt57GyvOpgoMgid7hLTeJZU6kO7uUGeOiDXBRKDvXDz+Qb9WrxH0Ah6b1rqxXv0tw9Fo8JxRAkd8IuMIQ==
X-Gm-Message-State: AOJu0YwNLpNVl3EoUEQva6VUwRSfSNiXL+cUzaPjnSKdEQBpD1vUeZBC
 NpN/tbYrNjsHhRVHnmDbjiODkTCvSaMVsDOYGn30c+z83ro+1MDhX+WGPdTuK3FZ5CUpmcZgGzV
 FiuJS6rBUuXIqaa7OeIZ17RW7t7k=
X-Google-Smtp-Source: AGHT+IGr9Pv/lCPk+ZalAnP3xCB34XNG7Y7hqPTTlZdu9qrN8n7NGsIw99fLSzHIGy3V2Qwx4w+xO3y3UWmemIG1B5Y=
X-Received: by 2002:a17:90a:3003:b0:2a2:2dda:6802 with SMTP id
 g3-20020a17090a300300b002a22dda6802mr1876398pjb.0.1712335717667; Fri, 05 Apr
 2024 09:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240330210331.2820862-1-festevam@gmail.com>
In-Reply-To: <20240330210331.2820862-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Apr 2024 13:48:25 -0300
Message-ID: <CAOMZO5Dw+gpzJV+STv5uvkaZ8uj2r_H-TPrMQxFkZ8S7HbhkYw@mail.gmail.com>
Subject: Re: [PATCH v2] mx6cuboxi: Do not print devicetree model
To: festevam@gmail.com
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com, 
 u-boot@lists.denx.de, cgmeiner@igalia.com
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

On Sat, Mar 30, 2024 at 6:03=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> The mx6cuboxi_defconfig target supports several board
> variants. All of these variants use the hummingboard devicetree in U-Boot=
.
>
> Currently, the devicetree model as well as the board variant name
> are shown:
>
> ...
> Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
> Board: MX6 Cubox-i
> ...
>
> Printing the devicetree model that is used internally by U-Boot
> may confuse users.
>
> Unselect the CONFIG_DISPLAY_BOARDINFO option so that only the
> board name is printed in board_late_init() instead.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
