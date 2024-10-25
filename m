Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0843BD0C600
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE4B88ED2;
	Fri, 25 Oct 2024 13:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UvE65Qum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71F2E88B8F; Fri, 25 Oct 2024 13:27:29 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7317088ED2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb559b0b00so16982391fa.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729855631; x=1730460431; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=biOZ7XqlH/JyPHerVXE/GRedrOle//tQnswYQNNK7hI=;
 b=UvE65QumSFHTScebUIToba5HsqIHjGkCZ/+42b/6MVbvgpbJRB6KtSs/j7dmIl8e1w
 90TCmDb3gkB8F1NTtLpfP+BbOVxlqxP8xlfs7Yat09xlANJas4HErTjGdsnWn4OJm5Zs
 n0z4tMVYdVI86VflGfjnbd/3Jxl/UY6MfT+a2oyuxcvNY3CMuuDYU92AxQxmt6NqQOdJ
 tcrXOQGb3k1i2KEvQJFWdLS49jhcKF6e2zS4J1SKT1l7gVYvAaOa/GS0PbXX8wht1sCI
 B0SGkQ9wWKuaetwrOZr+oQHckGuGSfrM5MLGa/JcJdLqbqlyOiiKt8BJYoog3N958SE+
 cBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729855631; x=1730460431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=biOZ7XqlH/JyPHerVXE/GRedrOle//tQnswYQNNK7hI=;
 b=O0WABUcrKq819J34hd46nacepML1VG0c+9tCHLcn20DjJXrSFmL62yzRa6ZCwchjQ7
 ZA/Vz8d5FNUMckA9oeXadArcPEvsFIWgQdvM9BKb2n0twfnAAxDjdy3uAPx6/E3gopRT
 URbID4Mb+IsxVl6wjN7cPBCmjXqViOA/7nmDxD954MGpfYJW59H0cleWuIFNBC1l0CbK
 ZqTvIVXTfSA0B2XYYV9A5twlgqCmp9/6A0Wsv+aId3SAZe2PRF7YsMmKeaJaxCJVVlX/
 kwSFE6Y2L3/T+1sTez+b2uxNbit16nzDXDgigLcz9Lce2F5/khjYJ7VJhMfjK+QFU4mg
 KKiA==
X-Gm-Message-State: AOJu0YwdZN/pFPehmdBbr3Qu4qENx1K3CCUBrD94GR7Hq/zlCRjoG2Gk
 0jbapCaZofAnU8ugSfc1xI0ez4twiDDVe4RPAU8W5QI2nqC7zBSo3j5fmq/j+hr1h28zNgqNTmO
 /GGvgjpm99KuXdE/oXemKnxCDE9Q=
X-Google-Smtp-Source: AGHT+IE0t0ELW0oIqPhFzi5KPJRTxIAikhGTanCVINnxHce5lSMOXnGoqtObebLaLv0QtW+gy2H49aPTjaHUUEm5sGQ=
X-Received: by 2002:a2e:4a12:0:b0:2fb:7f9f:7f50 with SMTP id
 38308e7fff4ca-2fc9d330671mr39777931fa.13.1729855630330; Fri, 25 Oct 2024
 04:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241019220322.341324-1-marex@denx.de>
 <20241019220322.341324-4-marex@denx.de>
In-Reply-To: <20241019220322.341324-4-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 08:26:58 -0300
Message-ID: <CAOMZO5A9AGG_X=ztxMZWJvVH4yV63RvCm0KdugpUCpqoXcxXfw@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: imx: Deduplicate DH i.MX8MP DHSOM defconfigs
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

Hi Marek,

On Sat, Oct 19, 2024 at 7:03=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Deduplicate defconfigs for all DH i.MX8MP DHSOM by factoring out the
> common parts into generic _dhsom_defconfig and including those using
> the #include <configs/...> preprocessor macro, which is applicable to
> defconfigs as well. This enables CMD_EXPORTENV on all iMX8MP DHSOM
> systems to be consistent with other DHSOM systems.
....

>  create mode 100644 configs/dhsom_defconfig
>  create mode 100644 configs/imx8mp_dhsom_defconfig
>  create mode 100644 configs/imx_dhsom_defconfig

CI complains about this:

$ ./tools/buildman/buildman --maintainer-check
fatal: detected dubious ownership in repository at
'/builds/u-boot/custodians/u-boot-imx'
To add an exception for this directory, call:
git config --global --add safe.directory /builds/u-boot/custodians/u-boot-i=
mx
WARNING: no maintainers for 'dhsom'
WARNING: no maintainers for 'imx_dhsom'

Please fix and resend.
