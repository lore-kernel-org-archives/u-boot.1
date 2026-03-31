Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B196109B47B
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 15:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EADFD83DA6;
	Tue, 31 Mar 2026 17:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OIrOs4Ha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A0E583E7A; Tue, 31 Mar 2026 17:00:22 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5A883A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 17:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b9c01854477so116248466b.0
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 08:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774969218; cv=none;
 d=google.com; s=arc-20240605;
 b=Pn+Sl0r6fL+nKchPy2SWJEfn6SKFkcVKa71RCUjeinGfq+MjhjA/OH1mhi+m0Sx9p8
 Q1LyDDroAqmJH6CeLdQl4OkeAHNVFHuSJQXxN2qvLxf0oFWadS2HjnAEjiWXutC8WWmb
 82ori6UYRLdBye/yhauwvtX3gP9CSgvzW4utDLUvB6gEYL4k/8pj1dLvS/WrQaIaM8rd
 aVVbv+VXn6jwceNMhxHaLHt8wH3Iv1HKHacrTj1laMH+RjAlhF8ZdI8gIj0JGFBMco08
 avyXSDlNg/tjeRQ8wS9V4JjdO4mLZ74gtoQYz/eJMva8emdPgqvva4/J1cpDeIJnh5q2
 NPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eDbIubeSkDN31jt/2utLGB2zWdXnpjZuxtVWZUeNtdE=;
 fh=HEYY+ebqCe+HuGQnjMxiJCpsExCdhse33eX1gNbrXSI=;
 b=X4689SJrhtznOTUQ9wZO7GeGEovJSi3mhV92QE3h9ztU4dBDwfVoXyEpx6tGQMq284
 gvY3FkmQxiZL7Nrn78VOFP1m5pvR1m64I9EQ4N0n7YsmOpAXDAS0riqKB35ub6CagKfM
 8O4P8D0sNweBNf1aogiekgy1qNVvTL9UYI3cyZ85dWDLojqa1AzROnzTyO+5WIHAAzbp
 24pMNScbzSR5bdUKH325V37i3Yn5YFCuBIc8/TBLZ2BhRA+RAC1HlmnKdEz3elXiY3of
 JWM5DKvco7vdKZ+BahiqFBCdBH3VS9+NOCe2MqXE2U1zpOY54nuTlUWkI03FHMqr8hzy
 Tqmw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774969218; x=1775574018; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eDbIubeSkDN31jt/2utLGB2zWdXnpjZuxtVWZUeNtdE=;
 b=OIrOs4HaodEF25JdFkdvQg+6orERn6Juk8mOex2K7MOfjaUYIULbwvYs9CmLL0+69g
 5VUkJz3aN3tZXFM4ETO/Vo7n4krFI63Bbut+T6YhD0lxBzJLFJ2bYi959I1hKWRP2fnr
 x1cB3l+Ui2opHhdpjQYwqvTLem8/l9UC9G3d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774969218; x=1775574018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDbIubeSkDN31jt/2utLGB2zWdXnpjZuxtVWZUeNtdE=;
 b=naGK2NzeanY02rCm2JUEG1WYSq2TmiNBkeGT1tGp9wN6AdDsZO5/p4h6j0lbmaL2nY
 0gRs00cAJRKDrxyqvsbz9Iw4XL3HALblcl7bsyixIkOqe8VkWAbZMZp+Ip8saiBcVJdW
 4r+XsYIcpDV3ZUKnZr06DGnVkAiAD9HBza0D1LWpzXw5DHj4LwJipG3csTgF0F7zqh8+
 wK9geW+Cf+X9ZvoXHpG3S1nl8TTXz4afvP8NX5TgO0sa+W/qecIklK0VgUB3oxom7SZW
 qAZ2RiXFkPJByYGg3c+8T55cvGxF+D7LEC8iCNxp3Z2J/w+/HQsrSW6N4/XW9GOguAUk
 jXkg==
X-Gm-Message-State: AOJu0YwHYgcI+DXopgrb6G3ZLYNiFBC47m+K1oWI6WHis3AgzEIQIwVs
 xk7jOmETdKhn4/8NJJyrifHxpJAgBNZR7QjeAr4y1AvhRC7quHaiBJhUPi5S5KlAANdBikRZeyB
 zAV2+tLyKzccN7QDhkf2CFhTxWZEvAUjWz9JtpuKI
X-Gm-Gg: ATEYQzwd4QGDuEHq+OKLFBWLeF3TAVsg0aux2eaTaiZW6DsDfgNLXulqjCv4THri+VI
 7/sjteHaNngj6JSOi1RCdZrYBsJN7K2ug5hMKr2zbpgk+Iy09TsECccB868XatlmIo2mXYE7CIK
 Y5Z8wEhc6C/L/Pglm9pNMrSyNOnPs/8VL2tHPorhZrsER8U1anFSHOuORe8d3uIA7yWLX3bjkNN
 bluwGkXEWv3OmaU30F7UJB77McKh+wzhPZLLRM/YNaRXcT9wnHcEZo41BFYQaIcLrEgQO+XIWu2
 w39lww==
X-Received: by 2002:a17:907:1b10:b0:b97:c45a:840f with SMTP id
 a640c23a62f3a-b9b5056f9fcmr1011856266b.32.1774969218468; Tue, 31 Mar 2026
 08:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
 <20260328171624.2377527-2-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260328171624.2377527-2-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 31 Mar 2026 09:00:06 -0600
X-Gm-Features: AQROBzDlha_kiuWArj551uUqhTfSfVIMIBXou8MXMMywY_RdOTxSh3u_u2h1wKY
Message-ID: <CAFLszThzWg9M920btRNpqUF64i-CVCeDDt71E=vi6p8iJoh0oQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] lib: uuid: add partition type GUID for extended
 bootloader
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Sat, 28 Mar 2026 at 13:16, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> The Extended Boot Loader Partition (XBOOTLDR) is a standard defined by
> the Discoverable Partitions Specification (DPS) to host boot loader
> resources outside of the EFI System Partition.
>
> Defining this GUID (bc13c2ff-59e6-4262-a352-b275fd6f7172) allows U-Boot
> to correctly identify and label these partitions using the "xbootldr"
> shorthand.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
>  doc/README.gpt     | 2 ++
>  include/part_efi.h | 3 +++
>  lib/uuid.c         | 1 +
>  3 files changed, 6 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

(with Heinrich's change)
