Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C74C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6462E8643D;
	Mon,  4 Sep 2023 18:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iAqYga03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5309F863DC; Mon,  4 Sep 2023 18:50:08 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B753E8675B
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so2767803e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693846205; x=1694451005; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8ST3YO6d4HtOs8H/+8A4Yhl5X6DwD5hS8QdC4U13Gok=;
 b=iAqYga03HNzVmq5/ulkrBMfAOsqXAJiQM/1uXI+95PyWH3PWT3vpnOOZrcAt6qPWjy
 v75ciuCokk5ToKEB6hhig14l76KiEGRwTW+irDWVqz6D7EwHtuOMmNcSx+9GNUbyMAaI
 iwLHnjSGvUtCHSY4kq/Brc1rXOaer6g64kqio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693846205; x=1694451005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ST3YO6d4HtOs8H/+8A4Yhl5X6DwD5hS8QdC4U13Gok=;
 b=gPPWD2CjQhsilwNP2xj7AFkem7ixSaM6ivQ9ePE5jC8gltW+WVaAuMEMDosEXgEijr
 CpJcRrk1yDe4FB/vlNbp0lgIH9iUhIsX95jcWkgBmSUgZ0ESNZUKP10eToX4c2F3l3ht
 pVk7LfHDq0gB1TSIyRlccDQgdAKQ2tZobeKzXh7cwdDQc5GdSW8sS0o+PgclHaoN1FJF
 a5EBhJAaKdCke632DkjnugMXZtAa7oa/4m2DW6NCWeL4+AlnRaccVyyKpf/aR3cCGNvl
 4Fv+2x71zOhh6y8LaGOqKITB1m7AqAmNyb04cTQerVvBnmrcqNVhOtdQwLnB26ASaGGk
 cXYw==
X-Gm-Message-State: AOJu0YzukgHR7GoMczX8EE4wrX5QQJilAKbDYD8en3+yQPY8cWfmtOOs
 l+hFX7BxP0bu1pncEO2mxJjU/Y43rjHCKyMxpcb6ROs0uet0QuiU6Qg=
X-Google-Smtp-Source: AGHT+IGON6CJACmFYmWzOVEMVo+EG+NbSLdOHwS69DTbzIZ3itpJfCNHQCoQTlktVldTFAgKHbzOM7mhXRuirfLFj6E=
X-Received: by 2002:a05:6402:142:b0:523:33d7:e324 with SMTP id
 s2-20020a056402014200b0052333d7e324mr7578979edu.38.1693846184509; Mon, 04 Sep
 2023 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230902073524.87451-1-heinrich.schuchardt@canonical.com>
 <20230902073524.87451-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230902073524.87451-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Sep 2023 10:48:53 -0600
Message-ID: <CAPnjgZ37SmabS9sRn4ZARdSuHUTh=YbrtmuFkJQ1sv-GRXx4zA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] cmd: gpt: fix gpt read
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Joshua Watt <jpewhacker@gmail.com>,
 u-boot@lists.denx.de
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

On Sat, 2 Sept 2023 at 01:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> To partition a block device the partition type GUIDs are needed but
> 'gpt read' does not provide these. Add the missing parts.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         use accessor for type_guid field
> ---
>  cmd/gpt.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
