Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5687C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97BFF80BCD;
	Wed, 29 Jul 2026 13:40:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vMrvKfShFI40; Wed, 29 Jul 2026 13:40:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D97298113E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332436;
	bh=AG/pvMc8FjoqueUmICfCGqDVj9mo+7zMlfgyKAzJ1v8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TN2qjjB5OFpWWBC0cGSI4FtaWtq7g8y16PUlXzdDZiCyG4c++gk7Sl0wTUY8TwsAV
	 jjkvhDI/CRAjGQ0rz/RfEpor2lHAIKmwt8F0HxK5RGDIUcT0DvehV/YQ6zIy9pO+ck
	 35CZdnIt0fIGi9qC6d1QZiG0BCNKTSL+T3v/6MYPEta/3D7gzTwG/Bi6jC21q2Ijch
	 gZkaD5XnDfXvA//okK97Xe9ygtUvZ/Qepf81O6k9yNjZaIlthkKZy2vWY5ae/dUXvr
	 9/SGnyDObUqSfO9RgqOQCQa1TtxD33glML/bB4BGzTbs8B9+ohjx/NTOdOxaWJNW43
	 LvOFxbnEztWRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D97298113E;
	Wed, 29 Jul 2026 13:40:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49DD1788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28D1760B20
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dW67vpCjo3Dj for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:40:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 38BD160811
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38BD160811
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38BD160811
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:33 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c167aa9500dso128792766b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332432; cv=none;
 d=google.com; s=arc-20260327;
 b=M7QWYfK8o9NJI4R9Z9TIZvsCsBgIT4yIkaL5w/sv5OuRV36209XHVcmaKH3B4nPWMt
 6jMkEDzygXwPmUHj+8hjAGkOzgbu5iM7/dnE71f/cVp+LUVdiE04Wd0AyDRATf+SREyB
 qBFtuyQHP9Wm7l5tpt2GcLiwWaff0PznvkpkiICyFp3PQYtXIDHyvV5L8Cfl/bMGEG17
 x52QRLyHmKJtEunfVd/9pJkGeKuWQ/7zrYpv+LPBnTT2WrzFy1o4KluYj9s3YHMICzxm
 ct9ntBfim0OE+ZYz+0WwIs158bLAAX1i5D5Yzh55+L/qhf6fcgg2RGEFgORbXJDCiz3y
 UZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AG/pvMc8FjoqueUmICfCGqDVj9mo+7zMlfgyKAzJ1v8=;
 fh=0DSvdsujKSZ39fVAqXtZ4dBEushvyWjCrGws9i6z4f8=;
 b=PmZ2EGcS44xlW4+HxiqUrwlU0+vVX7FXGjmgbQq+Yk+zLZZRqZPwO+XtmTGNuGwwLc
 XxRF5iQVHoMdY84XCG+jG0PdW+SuyuV8rqQFj6IAQODQqMqi25FZz0LoNjFMdYCNwB4L
 xcDaxwEh+WlzdAORJD2dVwJToZbjNORLQjm1HFbAbC5KrNnDA5ho357GaPO1cLjfKkG1
 8Ti7Z8oXFMMBaTS2Ggj7+RDC7zF1nmA7FVwffthM7Ph4LaIBRGr7hAnLzoZsyPFaxnPf
 PJ2ELiArlZQydvoCZfreazRIekcCZOAE2Zc279y6vY+O9R0/tTXWnYKXgOd0wMJDkK0p
 JaFg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332432; x=1785937232;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AG/pvMc8FjoqueUmICfCGqDVj9mo+7zMlfgyKAzJ1v8=;
 b=q04APeFVhuTdxVZdxyfna3lxQszak8PcF2suSG4/gMmO6P7ogscvmiB6gwnxRoWGgs
 mO504J3j9i2zL3/mw9zJWUJzZ+LTNYSzJhy29BpaTQihrpyjunGADx5o3q38PG2WLtHL
 nuSyb557prEzvazbZLAVLE79gb59P/1b3gwmd+MnSI9k4i9793FoH1hjoZv24JJATEt+
 tYUpIES9K/k8+t/ObfIrxwjcj5OCzqnDtTea/N01K5if5iVD1tepBs4lcv/9i9UQ16WZ
 TmrCIWjFGciVa30EW0rXfeP2uZo4n6oqCGWrcfDAyW2vFwPJOZyh+078ms/DAAj/pCsc
 kyiA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVOu8j7OMhPgkBe5PMjpJIHB8vnA/CJrRup+I/LsRxPcUxOLWKN8wIi/1hk0ewnZwjpkkey+E=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwWc3c5vi9HJeaFRriHfwu39+2ChY6LMqCsQCggu9eS2TMY1KPo
 WOEGpMO1Li17cKV9cJKsufyYRnLuhveY0ff+Kvk4m0B4d9VktWcJtVNc5tomCO08mWjkNZoKXCN
 QmLhGwqJpG4qoX83dBl0M7QCKTUlHjIdd+fcpv4vV
X-Gm-Gg: AR+sD13Ds9WYp8OUgArJ1QnQw4dJw61iPzq0uLp03idhkQEWn6yz8q5W5Ocq1irzwlF
 nw0KEZLu3j/YEJKpdI2FRAVA946M+YUg5E0rC5ikghJ8cYCd6nbGEHtos8iA/Pj3O+EH++/Mmap
 UmafVhLYxiOYF2Bi27FAumrKvtwT1SxiquozQ6dhjVax1N9fQL4Zujo1Xo5bFDuFJRZ6rKNG5Tz
 Cu0NNeSVKNcEXct4w19DzVNb/rouUhS5TKWZzzcu9oyOL5rf1J4sFckHSUK+9Ilw9O7wizjaIlH
 XFoKHeRd7xCypMzdXlxFQru4vruYEsLSXlg8fHIvGUiqtVMiApjTKQ==
X-Received: by 2002:a17:906:fd8a:b0:beb:133d:cf02 with SMTP id
 a640c23a62f3a-c1f71e43cc8mr361203466b.26.1785332432025; Wed, 29 Jul 2026
 06:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <e6548232-326a-457d-b207-194af4ec5bd2@gmail.com>
In-Reply-To: <e6548232-326a-457d-b207-194af4ec5bd2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Jul 2026 07:40:17 -0600
X-Gm-Features: AUfX_myeBWILJ312Bp16xHfXN1Mwt5YnjiunOWwZVHhM0vD0BvIzCCXaKj6Tr5c
Message-ID: <CAFLszTjFZ1V3CuvzCjfqZ3sAdhYeBz65X6c7nRC_WpCNcTAZ3g@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] rockchip: doc: change TPL phrase
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785332432; x=1785937232;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AG/pvMc8FjoqueUmICfCGqDVj9mo+7zMlfgyKAzJ1v8=;
 b=CuLQiWHaplm1o9VKH7OKIUXnB9jnTZN+7FVMJszFs7126CIBUVC6ShTSRNN99zKo+B
 aRCQQrri44vH/PR/P71DnZB2Z/qTIBTxkChKl/jL7dxtUMO9DCX/3ef1FswtHmcow0Lm
 kIJJk8ieREVOzb922LsIv07CoJNS1JmICtOxE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=CuLQiWHa
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

Hi Johan,

On 2026-07-28T06:51:38, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: change TPL phrase
>
> The TPL phrase in rockchip.rst has some spelling and logical
> problems. Rewrite and add missing structure by changing to a
> list view to better separate the 2 choices the user has to make.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/board/rockchip/rockchip.rst | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> @@ -217,9 +217,11 @@ For SoCs whose TF-A code is not available as open source, use BL31 binary provid
> +* For SoCs without U-Boot sources to initialize DRAM use the DDR binary provided
> +  by the Rockchip rkbin repository as ROCKCHIP_TPL when building U-Boot follow
> +  :ref:`PackageWithRockchipMiniloader`.

how about: when building U-Boot, then follow

The first bullet reads better with a comma too ('...to initialize
DRAM, follow ...'). What do you think?

Regards,
Simon
