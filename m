Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A8BC54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A7FF60907;
	Tue, 28 Jul 2026 18:53:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xaV7HGt1Ii7E; Tue, 28 Jul 2026 18:53:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25241608F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264799;
	bh=VwQ3L9Z+T+i/aAhNdkqDsX8BmThGWqMa+uyoPLHjZ/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v2slAux69/XhgOCm5CZi2TFVRjNrXHM7oE0BY477X4sTNWsicd0vsv/L+YFt++04a
	 XikZOn0Dmpf49+ZGaoiqMT/h4a+srOU64Bte060TIUrnerGBPvQotKDLJ+HDwISiZd
	 JoXpQuPlW3mgUBNCWYyCPKTx7q6fkKpAvLNeFTmk4aIZZVwe5LEj/8t4O2VhIpk1U1
	 ptkzNYBBhE1gTfnVCec3tncqO9zETSo4whg6OjzrHL4/3uQlAwmlOjeJb88zeCOLt+
	 T88kOVQrrH/xu/LYelc6o//US4hw0+lvCO/8ChRlDrRHk7LavyxkCqcwC+mLNJ83Be
	 GvFXKFE96lDHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25241608F2;
	Tue, 28 Jul 2026 18:53:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D0D826C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3EDFC81316
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xxbWNx_7AETS for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:53:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6C65881296
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C65881296
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C65881296
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:53:17 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69ff40d9cbcso147762a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264795; cv=none;
 d=google.com; s=arc-20260327;
 b=H2+t9u+10FxQLAIB6okn1TsdTwqceAcjJ7LBJ2t+7xE9HjOjqxE3EUElEpBXqHkJT3
 QukOcM8wZKyZcK+qbzXSVtyiZGf+N4ebsVn6z4TK1jFIWBobPhb18Ej2usaJaPtvv44f
 /EXolOiaXyEX403gAS4KAzxwjYQrTxOsA27t4MELiu+qvV69VkX6XOLLSbmAAy5FvuPY
 0qJDMJpW4JiicmnQNZCo+jSR5O3Z3qGLCJzQKbbd9XeSlCa/sENIqKhtniuSiFo7vFu1
 /7YvbhHUnHT2m0s+FJu7sibpdyzfHOPe/htylheg5K2HcNqbA77dTMyeXUdWlO47jXrM
 bdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VwQ3L9Z+T+i/aAhNdkqDsX8BmThGWqMa+uyoPLHjZ/4=;
 fh=bgUFEcBYfJUCcOuYSy1UFwg9ErLTm4lhm55UpG/JFtw=;
 b=dbBqyAgJIKeiap4VUQ5qI0OgXJbDsEiA1Y6eXflsMJKnsoLO303p7sUIRM1zkbMl8T
 3abeAVM6YK0qUgNsPDL+tVxzDurNxlcBh+bGdHIlobJylPqm/8dZFiyH7AreeD4Jx3RT
 FTlLosD0Z3QB6JzFXT0XBxTYnPlCO4muoqRTtUjVylqMQXR44ULjxsMdMIsOPOVYCRF0
 0AmuFAqCBIvyG9Yhc13CU0zW12LXmfS+SVShIGo8YIo4lyZv7pL3Fez2iI+w4Y9iwP3D
 4Owaf8yqsSsv0UsZgd7Mma2NCbay0CjBt4Jm59zhjxH9FsccbwJTWUdp9F0p0EPKsLax
 ymEw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264795; x=1785869595;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VwQ3L9Z+T+i/aAhNdkqDsX8BmThGWqMa+uyoPLHjZ/4=;
 b=VP9kY5ajlmPyrJFbTMk/PeOkxp5n/HX8Nce91cuikV9sIiwKM14+HAeRcF1JI+11jl
 HDgh7vfU2n6I8oD+c0Jrx7zx+3NocYDZo4PpLaOlHpialYTSmpdGU49z4oMy46dZu2+W
 w8mN31yhaYKJ+5h9KmAmyPy6GASO+P/VqpbAQb0mNky3XhQJeHfUT0qlzgqoH+J1hnyJ
 yhhyy5KQRDQ4Do0RwEaU5Umm0fGSANQSoP4AGlbmVzOLakXO3i0Ng3S+FLw8uhrLBEit
 tetFMXxSTsXTNqCtSPWFna25/urYnUG2eFBgesqQfCBAaTDmbKC49DcTV5gNRJg3t8KT
 aZiw==
X-Gm-Message-State: AOJu0Yz0SJmSHfKKweraUe38z50EyyM7wp/ccHaZI6IQH0hkulzA9us+
 g6tUJ7KQ2SgyTiN8uVgLYPFrErMZjhnC37BgnzBkvou6fQcUtTWFbMzX40DtzJVsReOgdIe//Zo
 Eg5fsspPL8oZFlz35td2WiZRe5y3xVvIIBGJmuNxt/kfTlsOuZ6I=
X-Gm-Gg: AR+sD12XxqLHEBJQk8i6cEuOwaEraLQJFiTi8LxMV5KwK0sfXSSma1gBTItEveyu4Zh
 3QUbR3tvHFlcxh0myBp3erP056c6wPrxNBo9RYUqA/1NLPeFhRIgQ/331ly2seNNFZU/LYJ6bfV
 F5vvonNcIUo+ygGE6CJqBg2MXcZPbYnSGjPi85OeLpVvv9zysPDQQuxtWMt6dKq8ctYTZvORCCN
 mMf2byuEj4C2OW9hx70gEU8nKbe7uOE9mPlub0rEkANcffCeS+/rHq8FMqw
X-Received: by 2002:a05:6402:34d6:b0:69e:1294:36dd with SMTP id
 4fb4d7f45d1cf-6a0349454b0mr1926088a12.0.1785264795531; Tue, 28 Jul 2026
 11:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260728175407.90993-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260728175407.90993-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:53:02 -0600
X-Gm-Features: AUfX_myg1-5GR2xRBpbKrgYmQ8PxbB_ipizpCbre_6WmUUjNrIfIZtc_rgOQr1E
Message-ID: <CAFLszTjeLrWTz_Nwr5HBB=Rk8e2=Q5roXsw=X6UX9f==6rc4Nw@mail.gmail.com>
Subject: Re: [PATCH] doc: cmd: gpt: Reinstate gpt setenv
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785264795; x=1785869595;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VwQ3L9Z+T+i/aAhNdkqDsX8BmThGWqMa+uyoPLHjZ/4=;
 b=m+/yMBaa99ANG8uCdxLZppxoLS30Oav54Ryfgg2kpvFh5b1xYCXCoecMEZ3AvYq6R3
 V2hbjrBXjCnoF4hNakkeyjphZDTJoKwcpOI8lxwLfoaqjjpuTzrtQ4jjkvgmfqFWhutk
 mOg04CwVkdome4TtvHdHrCB9Y3nnGOT5xxnP8=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=m+/yMBaa
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, 28 Jul 2026 at 11:54, Marek Vasut via U-Boot
<u-boot@lists.u-boot-project.org> wrote:
>
> Commit dc3765ede5a4 ("doc: Switch from setenv to env set") was
> too eager to switch "setenv" to "env set" and also incorrectly
> rewrote "gpt setenv" to "gpt env set". Undo this error.
>
> Fixes: dc3765ede5a4 ("doc: Switch from setenv to env set")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  doc/usage/cmd/gpt.rst | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> index a2f116d05ad..6afc634eb0a 100644
> --- a/doc/usage/cmd/gpt.rst
> +++ b/doc/usage/cmd/gpt.rst
> @@ -119,10 +119,10 @@ Sets the bootable flag for all partitions in the table. If the partition name
>  is in 'partition list' (separated by ','), the bootable flag is set, otherwise
>  it is cleared. CONFIG_CMD_GPT_RENAME=y is required.
>
> -gpt env set
> -~~~~~~~~~~~
> +gpt setenv
> +~~~~~~~~~~
>
> -The 'gpt env set' command will set a series of environment variables with
> +The 'gpt setenv' command will set a series of environment variables with
>  information about the partition named '<partition name>'. The variables are:
>
>  gpt_partition_addr
> @@ -199,7 +199,7 @@ $gpt_parts::
>
>  Get the information about the partition named 'rootfs'::
>
> -    => gpt env set mmc 0 rootfs
> +    => gpt setenv mmc 0 rootfs
>      => echo ${gpt_partition_addr}
>      2000
>      => echo ${gpt_partition_size}
> @@ -231,19 +231,19 @@ Set the bootable flag for the 'boot' partition and clear it for all others::
>
>  Swap the order of the 'boot' and 'rootfs' partition table entries::
>
> -    => gpt env set mmc 0 rootfs
> +    => gpt setenv mmc 0 rootfs
>      => echo ${gpt_partition_entry}
>      2
> -    => gpt env set mmc 0 boot
> +    => gpt setenv mmc 0 boot
>      => echo ${gpt_partition_entry}
>      1
>
>      => gpt transpose mmc 0 1 2
>
> -    => gpt env set mmc 0 rootfs
> +    => gpt setenv mmc 0 rootfs
>      => echo ${gpt_partition_entry}
>      1
> -    => gpt env set mmc 0 boot
> +    => gpt setenv mmc 0 boot
>      => echo ${gpt_partition_entry}
>      2
>
> --
> 2.53.0
>
