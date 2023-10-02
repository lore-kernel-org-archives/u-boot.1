Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06941E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:40:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66AB87255;
	Mon,  2 Oct 2023 03:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="lZ50KQ6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5ED871A1; Mon,  2 Oct 2023 03:22:40 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D1E387286
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-503f39d3236so24629178e87.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696209743; x=1696814543; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gqo5wG7uI9M/KEi5Br/N0x9OeyxChDzsmAweW3frd2Y=;
 b=lZ50KQ6aXdc9Aq3xlcBJ6Y9vVv29kQsHypZzfo8J6T9f5NS6yXp3DmdwPRblCFyd1K
 iFqBQjmGyTjvDgyQrbhAk6xr9Z6dg3uLQEipSngouEGPRIK/55EJaKFSdhiDfNLkpTEk
 99ihFpR6A2Oqr95sLx7S7R34bNOiP3WBP0TIrvlJKIbJ2F4hJeXBXj6sMlM4ef0JPV9U
 lWucYlYAswZ0onvTc7n4/G2e4rrIAeryAaaKfxXFCpDpC0sgVrFmLnawhhWX3XcgU4/Z
 hziiHy05/3xRpHa4xOksQlYmMz3W6YgcybwfzPPX7gmWARo9MJzv1iMjT6YsnqVcjsYI
 yaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209743; x=1696814543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gqo5wG7uI9M/KEi5Br/N0x9OeyxChDzsmAweW3frd2Y=;
 b=b0cTCnqMVpO714VHJZmLyljh8FjDRkQOwPB/aXao7DTAZ3WGSrvzo4hFPNs8jkrI8R
 oHxwarCcfCPFFqedYMNyI/kJkq8OyKbUXdrVC1FvNZCntHXShLguk/Gl6rUjQv8WEhh+
 v+xUxj2ODIUckOar+IEbMwaop9YZTbCPGoVIijCmrQvGMnGPPnQTevo0NMRjDzHWoOQi
 whbtJVg4biZzuWft6K3d2eX4n2nCsn04wraBYQYHJVplr4GLBaG5yrCtWESVrtjQgOgN
 MBk/j449VElTTcS5K4C/LkEf0nLsV0ITx5ZHBpHfqyU84dE3K5olrv9Ww9CBtV/qTYJa
 hIkw==
X-Gm-Message-State: AOJu0YyS4zu7EiSA/NMRh+oncH9NVR7Q2dna82k1ICqVG8RWnO1ns1XY
 mojH06LL25TNaVN8aa8Np05cQLrPlAUwaV1WKN4PPA==
X-Google-Smtp-Source: AGHT+IFnGd1c661QS9GKVn+74M2V3uPGiHFN60k1VWafzIHXcZag3/gS71q+/WlHvsrQH/mU4ZO6u+s/BFknjhuZmis=
X-Received: by 2002:a05:6512:2807:b0:500:7881:7b2f with SMTP id
 cf7-20020a056512280700b0050078817b2fmr9673508lfb.54.1696209742979; Sun, 01
 Oct 2023 18:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-11-maxim.uvarov@linaro.org>
In-Reply-To: <20230926094124.7024-11-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Sun, 1 Oct 2023 19:17:45 -0600
Message-ID: <CAPnjgZ296E-XT_5Kn6Ra10nQbP57fLHgaC_0g7as9worUip-5A@mail.gmail.com>
Subject: Re: [PATCHv10 10/15] net/lwip: add lwIP configuration
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
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

On Tue, 26 Sept 2023 at 03:45, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> lwip configuration can be tuned with header file.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  net/lwip/lwipopts.h | 178 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
>  create mode 100644 net/lwip/lwipopts.h

Reviewed-by: Simon Glass <sjg@chromium.org>
