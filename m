Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D684CD6E45
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 07:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0B46844CF;
	Fri, 29 May 2026 09:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EBu41oeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8AF3846D0; Fri, 29 May 2026 09:02:18 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD32D83FF5
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 09:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bd01481e592so1950035066b.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 00:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780038136; cv=none;
 d=google.com; s=arc-20240605;
 b=IkKEmnqMiRRKn9HijFs6dD3Y/U5GG5NR6FhW9V1fKlB2N6eclHmLBeQK1KgAT8mr3L
 YZtIaW/tiJKPqJUM2a7BpWGcd5/n247TGe+F21BiUp+Kk22+4X6Rh4KjnPsWYPNs1Uox
 yehYwQ9MhFE6DNKmIz9VCjWsrXgUoksGSEH6vue5OMjwN8zGSz9haBUMbxzR1Fo9B1yU
 almjAtgZPu9R1N5r/kghA5kCuwx54WpP9ddZ8+Fv2loV58Be+J4wdRU3rVpKWphKKJp7
 l0NsetT4mNO1X762+1eMPnOZ76gAjoAYlk0h8GimianKAIcRxPbLspA4uEZLRS9IleAr
 xTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vSIR3sKYRpCQR4LhzGSkecC3B8Ix7Y4n+LXi6KNCTHk=;
 fh=Nn4VN7BWqp0JIm1ewtuM8b/pnYtqTA2Rbh4QL0BdsEk=;
 b=T0HGhbGLWZk9snd7Dhr+eUCXLvgOMWeOfOPyriQx0JB6Du1GY+DyZVIjaIF+QHGohW
 tUf4sHXDUCniZ8MRB+gba/xLY5NboOfzpHzLZipjQvnEwIPt8+p1TR+GL9gUI/no1Jj0
 lAdZIaf8nWZW2TsMl2eF2YlXZby7XnuKZCYZnCcxYZLZam5BgSxL2FYRoXM/wuZ3lbIo
 6f4fBqLRpVlyy5XnIrUrr0z0eiDqHqAjxBm/gryQmkidEZfGtKt/EUPM9dpsqnWa1lFb
 cOGB2iCJZNTqsZBNZP3gI17XrENOqgwR6ptXI0j730HLN6/fLLsH9XsKsSXCdZO7xdvc
 LLWA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780038136; x=1780642936; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vSIR3sKYRpCQR4LhzGSkecC3B8Ix7Y4n+LXi6KNCTHk=;
 b=EBu41oeC9fY19x9c3Ke2QcQOH7u28oRcDDYsUsRzZUyTCvz1vtISbgJXvuOD4izgZG
 n/3b1meYadHquvCjfCASCd6IiKOoEmrfuXIZiB1iIN+LmSj9LZJyyyQz+02usakBi25e
 3BwnLPiqln2l63QfnQqMqUaUxDqD7qNSmdzXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780038136; x=1780642936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSIR3sKYRpCQR4LhzGSkecC3B8Ix7Y4n+LXi6KNCTHk=;
 b=hCRKbwfhQm/oNVkjyEg/aQMUa5Kfnq3LTnItNx+caKIWERFum595tQu6brXy2OoCH0
 JMlbs2rSfaq2KLa88hKtl6ZYtdojsntMjwLoPOj0XzfwfgChoneAJyPxOBDnUXzOnPyu
 xI9G8v/xV7kRzLgiPvpuzKl7t2MUxBx+S/PAtA+1YKyvt39Num3LLPBMr9KOM97SjZvt
 GfbiRdPF9rlgrA8he2a8R4q55TUhUtEPg1id7cG1TjCNEgUqaO/KysKZsW47fFMmO05E
 Ve/hSBtVPveAEjwxh2ofo38k8VPpDzE+XvjcYDhu4KfzqWxdIUwgH6JMPd2eIo5fSKuz
 jNTQ==
X-Gm-Message-State: AOJu0Yzdq/usIQTBjb+mcPMd5YML+c+lED3s0UZzub1368YdfKc/xQvC
 nLgH9941nbeWOnJ7cGENfSauEiIKdfsNgALjqLXFKBIuFwUb7il2Vaa3tC9qZLgjtBqyd8F4whi
 XvZK6LD7yulyeswogoL56azbJ9ZWPaU4Uh4J1KzOe
X-Gm-Gg: Acq92OEc4tYcZ06xNEIbZ06Pg/76JkO2QDJ4aQu8qMQG3DJ4sEUudLV6tcUDc320WKZ
 S1Y57iMsECCtSjUPnLKaKxzlzSE4x99tcEFI7vrv0qM088NzdQplQznEPKGa5zNpESnbETbug1S
 W05TYw5RWMQS1aMJukCUzCo10/IqEdKX72QJeilMNVr7yU/wR0VrETGA5IupXMUguOJdHXH3RwY
 hjDNK9Qt1gWWYIfyApySj2w/pPGBcOEvit9T4y/uw6mZp2Df4Snxz/AF6emK7qPvwTcHAdhOvjP
 idb8s/UKo3or7mtjSSBHw9t0sB0zPw==
X-Received: by 2002:a17:907:3f1f:b0:bdf:8e2a:1092 with SMTP id
 a640c23a62f3a-be9c8c68a2emr66311066b.3.1780038136054; Fri, 29 May 2026
 00:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260528114900.1505642-1-ludwig.nussel@siemens.com>
 <20260528134802.v5.5.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
In-Reply-To: <20260528134802.v5.5.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 02:02:03 -0500
X-Gm-Features: AVHnY4LSlKbFBbZ0uxKm-3rXFBqiMvCNO-Za9hqQJTYyLCJ1qeu1mFE5nFPrw0A
Message-ID: <CAFLszThE59uzWLcg9OQawzwgKtKgr7VdvRHu+tiBTETduUDwew@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] iminfo: also verify signatures
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Ferass El Hafidi <funderscore@postmarketos.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Yao Zi <me@ziyao.cc>
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

Hi Ludwig,

On 2026-05-28T11:47:57, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> iminfo: also verify signatures
>
> The iminfo command already verifies hashes of images. This change
> also verifies signatures of configurations if enabled.
> If FIT_REQUIRE_CONFIG_SIGS is enabled, iminfo also fails if
> signatures are missing.
>
> While at it print 'OK\n' in success case of fit_all_image_verify()
> too so iminfo output matches bootm. This will simplify the tests.
>
> Adjusts error output slightly to be on stderr
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> boot/image-fit.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  cmd/bootm.c      |  8 ++++++++
>  include/image.h  |  8 ++++++++
>  3 files changed, 70 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/cmd/bootm.c b/cmd/bootm.c
> @@ -329,6 +329,14 @@ static int image_info(ulong addr)
>
>               fit_print_contents(hdr);
>
> +             int ret = fit_all_configurations_verify(hdr);
> +
> +             if (ret != 0 && (ret != -ENOENT ||
> +                              CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS))) {
> +                     unmap_sysmem(hdr);
> +                     return 1;
> +             }
> +

Please put decls at the top of the block.

Regards,
Simon
