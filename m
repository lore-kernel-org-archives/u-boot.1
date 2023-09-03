Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F15C71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 18:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3667867EF;
	Sun,  3 Sep 2023 20:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="L8iB+dyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E883866DC; Sun,  3 Sep 2023 20:09:56 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F1A3867F7
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 20:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52a250aa012so900816a12.3
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693764593; x=1694369393; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FzVUUPNTxqJWEIvHjYy/A63H0tWXScDAYScFtiI+YGU=;
 b=L8iB+dykIaE8Hq8zM+4sAIyVhsnGKjXcvm5O92F/h7DlgYDIyr/KYN4Ucw8dyTS5Ma
 3GDaDfUPn+05wzX4/Igodo1hSDzCuK4QzoJAbriS33O/S7iO4tIG+mDkKS0CXqUVrvJc
 2xVjvGYDPgXiLwXNIFL3ow3ym8O3Zk6kPjZUO8qQRvVyevWN/ETctc1Co/kwRcHHryKB
 XbupSS6iVbGslXYgwN7HXV8ve6HbQCWooW1LC8oikZpsp4Vhrdy5H7KEcMwLUb7uzP4A
 xPbiMvJd+nofPKV6X5N2APPIOmMVH3pRewirxKFwXqwc7lPQepIZAz4I8EBNH0vWSgtq
 uyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693764593; x=1694369393;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FzVUUPNTxqJWEIvHjYy/A63H0tWXScDAYScFtiI+YGU=;
 b=CyI76ki3fag7ZksoeroPNxVD3xpBcLdpRA45js0+IpQryFPLDb6LugavwHEefxNjWo
 DLbBnnYd/CrbXbTKXxagXCX6h9QJ2Nf6euhc5Y5PFyRxusIdUeaOaunmlWR65+fHr8Lg
 G9l3AOpYBE3+FHd5TUWrmP3HKR6i4V4YEaeTmHODN+OeFWW5b8Q3dlo9mNllbgrmNSZL
 Vro2ZfQCQ7bT98A+JVmGldl5O7AlOn0x7caI8qKwbBfJRM1MUjIW4s/VJSif/UBGONkA
 6yE+zFoXWYjx8zx5zc1m2YLo6XvS/BN6Ro9+k/cmkSzvxjjReuVLDuvyZTVKSNw5Wnrc
 o7QA==
X-Gm-Message-State: AOJu0Yz9koCJvFVCEjIn6XQ4pMTcibkwyf0FZlnZlvJmR4FVfeITll3a
 4+iha31JnWzjoI9DglyGo3E1yQgQ8kHSnZH8Wx1N+AvcJKs1H2fkQKE=
X-Google-Smtp-Source: AGHT+IHDr4lsYHbyWTH2M2pRN4/ua3/tmLmFZexjwTDNoZaWOqvPh45aIQX7DtdYIL7p451w86cTH1qcTa+2mdQjCNM=
X-Received: by 2002:aa7:d481:0:b0:51b:c714:a2a1 with SMTP id
 b1-20020aa7d481000000b0051bc714a2a1mr6524963edr.7.1693764592899; Sun, 03 Sep
 2023 11:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230901204143.3617876-1-trini@konsulko.com>
In-Reply-To: <20230901204143.3617876-1-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Sun, 3 Sep 2023 12:09:41 -0600
Message-ID: <CAPnjgZ3wsG+-kFYnsn0sHVFRa-UjK1Vrq3VzcsQCRG38g6Vp5g@mail.gmail.com>
Subject: Re: [PATCH 1/3] Azure: Rework test_py job to publish its wrapper
 script
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Fri, 1 Sept 2023 at 14:42, Tom Rini <trini@konsulko.com> wrote:
>
> Both to aide in debugging of any test.py issues as well as to make it
> easier to split the current matrix in two, have a new job that creates
> and publishes the current wrapper script we use for test.py jobs.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .azure-pipelines.yml | 161 ++++++++++++++++++++++++-------------------
>  1 file changed, 90 insertions(+), 71 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
