Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B91C02192
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 00:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F3C8806C9;
	Tue,  4 Feb 2025 01:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WHaPX7I1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C4BC800CF; Tue,  4 Feb 2025 01:39:13 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D258380050
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 01:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab744d5e567so138486166b.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 16:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738629550; x=1739234350; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoY02CGZ9ZUsgsC+RppBvo79uXAhBBQvzpYKRYNOijE=;
 b=WHaPX7I1YlCg6gIalDofBrsaC2YEJxXUts3ims0YLmZrH+Yfm7UIguLhrWlMGpTxq0
 +yxcaV9XsBAeBrqUHsvMjTxYB/EROFmePEM4ggH1tY3iJFObCz25AYYBigkcip2R/Hnm
 POaX1l0K/lYNmoAG2rZ872qD8QOj6zv8wJza8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738629550; x=1739234350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZoY02CGZ9ZUsgsC+RppBvo79uXAhBBQvzpYKRYNOijE=;
 b=KDdNFAYbHYaP5wXLvr8sTiiwUvizpr+hgnjw2zErkRDbJw2dfzhFocVygbVjKTgJJV
 v9rrHArhXFHGBPKmmrkabyBZONMhnOAcOsZ9JFDlqS0hKAEOQA73DnphIFDNs6Fh/jXs
 E+8y7u+dZRDuVN4pX4hqlm+0iiuXYImMkJY+0bwbW4UD9y3nK97Ez4pB/jM8E4MhYx6H
 zp3gr/tBcPYCJQnQRgqQ60S3C3kOp9Yn/riIgz3va6pQsNH3qxKw++A0vUQ1yghmzlvG
 +W/hCx+M/w06upADc+TgcoASfi8Wgz9vIXBR6+FNCJMDUE2OVkhQMmnRcxJwI1qkp5bJ
 Cf1w==
X-Gm-Message-State: AOJu0YxirF0V4Sxe9JbIUBOwbr+5MqNW01HfAwi6c0ZJiMlYiyQnFIP3
 pTP9msYDJ7OPUFjSNCF2ggIkwQJ5aQQJg5EL0398TItxtMmVfyoUQaCb1LVyoSgSsLNl1V4vPdH
 ml6BXnZy+pwYJhXq1N5qQHm1vNwlPIlk55TVD
X-Gm-Gg: ASbGncsZnbUq945riSj6zrR4s5G0TO70TnyY7JExwejsW+Ilqd6/AYO3DmITlPAFZMx
 2zpRm1Gz6vblCZtKZVxUH9FB8jrt7fDPykBbZ31GcZonOKfhMpXiDt6e3RjFB95AFMz97JU+miQ
 ==
X-Google-Smtp-Source: AGHT+IHs5Q+4HxQH20RPtrUzaAMDG0lWSuE53KJb4RNNlcJbvj1LrfXrVfdDiMLFWoKzIxU7i8SAOx25mwts0VI84Bs=
X-Received: by 2002:a17:907:720b:b0:ab6:504a:4c03 with SMTP id
 a640c23a62f3a-ab74848045dmr116386566b.24.1738629550359; Mon, 03 Feb 2025
 16:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20250203163250.1618-1-egyszeregy@freemail.hu>
In-Reply-To: <20250203163250.1618-1-egyszeregy@freemail.hu>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Feb 2025 17:38:57 -0700
X-Gm-Features: AWEUYZkk3t8d5kuiDkm2Ce6OE8VVE5PKuA68yU1XJ0h_qqH31nDom6U1PcPbM8s
Message-ID: <CAFLszTg9NgXUYB_LpWidXruzrV5YoS=o2Mn6m0DQNSHxefTWMg@mail.gmail.com>
Subject: Re: [PATCH] zynqmp: Save "bootseq" environment variable in dec format
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, michal.simek@amd.com, love.kumar@amd.com
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

Hi Benjamin,

On Mon, 3 Feb 2025 at 09:33, <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Save "bootseq" environment variable in decimal format.
>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> ---
>  board/xilinx/zynqmp/zynqmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 8cdd9d8600..820fb252a3 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -488,7 +488,7 @@ static int boot_targets_setup(void)
>                 if (bootseq >=3D 0) {
>                         bootseq_len =3D snprintf(NULL, 0, "%i", bootseq);
>                         debug("Bootseq len: %x\n", bootseq_len);
> -                       env_set_hex("bootseq", bootseq);
> +                       env_set_ulong("bootseq", (unsigned long)bootseq);
>                 }
>
>                 /*
> --
> 2.47.1.windows.2
>

That seems confusing; why use decimal?

Regards,
Simon
