Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CFBCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A78C8498C;
	Fri, 26 Jun 2026 12:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WJhRCPOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA5A98404D; Fri, 26 Jun 2026 12:38:47 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB70A8497A
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-697763eeafcso1260508a12.3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782470325; cv=none;
 d=google.com; s=arc-20260327;
 b=WHtLYdKQLLvouuIi9FFInz7SawJUobrM0YqpoeVuosCahtVVAGRrdQMDJhA28Q2Pdm
 00bKSOptCrlWtPJo53cYRX29YLKoBpj3f4UAqIXPfhhDEvVUwDwacCyPsDuByTo1pzZq
 csjL9cmraT0+0nX67AojypON3UZFSiLv8rAUFNgXOLzVgw61t4BaGkpoKW1j3adVjUs8
 jnq7s7lnisCtJVHDMjYgDEllPMYro7eY2IX09C6GXFLBSXyVgCYqdDZTr/3IzpdtrPfp
 BfsL+kVEo2cOqlmin3DXjP4sfqJFOt3T6vjkWnp0L5Ehp468WZnz+sUg+rva6WhdO3+a
 8KoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i0p0i9ONpYiHH811x+bVrWjReBEpNVK3+r9RkiOpVSo=;
 fh=nyKLZbC5pO9EO6FCB5YQSf7kr334RAPXhBSMuZ9b11E=;
 b=gBAVagAVGGO0NKSD4xW0eiSYpBcHrl5rc1Qz1YB11/bLHkmo4vQLqKqIrnnMdVUadZ
 4uQTPRLfpdyKOGO+PbKivAoXtLCnkXxdrk5UIfE6IyPR9MFzbSEcX5cn9B05fJXt0ms2
 t8grFyIH5Rzsd9ylarhHEJ3nptePgB7PqRGtcEqSRAw0ZaJ14jAOnIf/MLzMeubIvXCm
 X/MtSD6gYBCmACHDiW2tqTq1MvQCF5WfqyyimmnteXzQ94aORBmiR66JYxEw5s0ojwqD
 VwSMhxC+nK98rjpIce9giRYQYsuEaC/38ftqes2djb1B+uS9JdUaFrTKZrMUAo8I/fuZ
 /ZAQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782470325; x=1783075125; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i0p0i9ONpYiHH811x+bVrWjReBEpNVK3+r9RkiOpVSo=;
 b=WJhRCPOpGkDRmhYIYtjQOrFHRJgIB+qn+ZWasBWudebkpVct4Us9ub6RuvB9BuiN+8
 JCbQTN8GVx5s2+qQejsZM8Z507gs21inWrmCjn6BNYIiRyhxc4M4ZGG5sMaESJ0RkT9w
 BWQVUACZZwYRcDgxRpDd/uttwsFm8EGTDj/MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782470325; x=1783075125;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0p0i9ONpYiHH811x+bVrWjReBEpNVK3+r9RkiOpVSo=;
 b=XBXg+SJAEt5AtCemSLj7pvO3w4VuVxz/B7/QANu/StiRCP2pm89DC/km2pGo4nHgKU
 1FPkWG+MycIG4pHCpE2ylzK9BQ9W6A1sPqnrYwN0qA8hfuNdvAWR950Kk7zZJCA3PfNg
 T4Oe2IsCgPk2KLBLwueLmt23u90+Fj8rcShDMAq6IfXPtB03Es+xr8m7glZNqbX4M2/d
 wCAQfvSyZd/txTMOkFepquSWQx5sXk9mmAABizBidWsazISAc3g/f9mYL5BjMi8f3UU9
 FVEl7/UXgUWs15sCC/qt1A8MQFY2M79NNAeOYXikxE/p3JheTTCC4xu7tEjQmxA949eW
 uNQQ==
X-Gm-Message-State: AOJu0YwuaY3GISTrmfOnZWfGSmwszLcyxlOSKN0DNPqb87LEZuCOh018
 oiNPtHLlzayG3aIv9JZ5hg7LGRkOzL5wm8ZWkykd1d/0kMHTIOZi7OV+pBbTFvqd07AkbB6t896
 skjxrOTJt+za1K86ZW/IHpMHYaicAqgAXSBuru+i9
X-Gm-Gg: AfdE7cljGYt9D0o19pxB7MaTPXd/uWcqdqrFtQk68d1Cxy6J3TyGPBusFswpqA02axL
 v7CT11am9GB+y5gL3GcxUP7G3NuRz63KL/UXrrsKk5ObFVyEm044ZI7ZXPxJwKIUupmz0dyPij3
 J+pDBE+duNQX/T6hSivmh8qWeoqUSObvowzBM8wKwqaoTjHVnzugTuSyDJwXy5zFKeRC+2Ua77j
 OlQhl3BqD6ObBZwnBaK9t6RNI4txB0nKy07kcko4qhH8mgPCd6dE8emtKQpiNfH/M2ospr9ug==
X-Received: by 2002:a05:6402:a295:10b0:698:1504:e3de with SMTP id
 4fb4d7f45d1cf-6981504e4dcmr1192325a12.29.1782470325310; Fri, 26 Jun 2026
 03:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-3-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-3-170c9cbe5099@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jun 2026 11:38:33 +0100
X-Gm-Features: AVVi8Cd84j2WqVvkOTT60TQNxxIgA-FJWcT8xgNXysK_lsuGULX4Mon_ilUB57E
Message-ID: <CAFLszTipSeAB_nwqbhtpDmGbY0Sgv+VP7Kqd5hY=3Br0AFrBfw@mail.gmail.com>
Subject: Re: [PATCH 03/11] qcom_defconfig: enable PM8916_PON
To: me@samcday.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>
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

On 2026-06-06T08:47:32, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> qcom_defconfig: enable PM8916_PON
>
> Enable the new PM8916 PON driver.
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
