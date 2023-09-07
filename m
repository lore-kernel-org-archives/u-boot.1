Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273E8EC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B2D86A26;
	Thu,  7 Sep 2023 17:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PDvbs9dH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED9D786A22; Thu,  7 Sep 2023 17:57:50 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 629F8869CA
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c1d03e124so136195366b.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102268; x=1694707068; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V2vTitav/bRxMtj9mQnX4b2tQrdqBTPBB6z8lgcfJxA=;
 b=PDvbs9dHfrqnp0UkAGmyvMhv500KihCp+b6IXgSxvjIY2ocoqLBl6UzjJx67GucN9L
 RY+/JQkt3w8n0jpWE73yxXi1CrRZZFirdSXsa0qR0MHCXo/RmyZ12EW1fftI9ZLSjewN
 n6THYKTDw0CY+MH8xNxz1AX6RPU/kdXlPcjWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102268; x=1694707068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2vTitav/bRxMtj9mQnX4b2tQrdqBTPBB6z8lgcfJxA=;
 b=bitwDGNo7bLIR9mEAaIAYvsCUyHwiXvLImAqBydTPZKIyHvea+bQvvRFKirHjr+Ul3
 5fxyBVKjM4GrK9y84Oo1DEmOzNVY05qjtCVspq1RDgXwo8qjlx5zNOMDeTxU1EmZ1jbK
 CKbj3Lc87Xtno/LrcEU9kobsG1sNIxUF3OS4T8yfJgQ2AgAeG2Pj8fLEWYQFBKHxlzRx
 aJ9v57NxkBjGipxi1oKhOPNKjZMvTCF/DsXT3idLcAH9wgW4vd8oy0COo6qgsVTQiS0n
 Euj9Kf/o4giGLLOoKzEROcR9SCpt4s29aEYCJA9EXIpsDJivkW6x2R8ktEQk9O/DQoZ0
 p02w==
X-Gm-Message-State: AOJu0YxD+2/Y0G+c19W4W/x+G5vhrIY5WvdczO7/3RqGKxusw7v33aSU
 2lK/CPsmg+a+sXnZj9qaoCYilrc+ipv1EgOvSR7Ytg==
X-Google-Smtp-Source: AGHT+IGCSj1b/VBENISnX0hLG/cPPd8BRMz20mxprK0bm5DMVI5oSXTTZoVaNe+AmxFuZnKxJYurHMSuEciRRI1sSXI=
X-Received: by 2002:a17:907:7627:b0:9a5:c79f:bed5 with SMTP id
 jy7-20020a170907762700b009a5c79fbed5mr4563296ejc.16.1694102267725; Thu, 07
 Sep 2023 08:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <f0276ada1166fb05bb4277c213b4c8f96b63173f.1694091345.git.michal.simek@amd.com>
In-Reply-To: <f0276ada1166fb05bb4277c213b4c8f96b63173f.1694091345.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 09:57:35 -0600
Message-ID: <CAPnjgZ2SDWYZYSqpfqtqeZZN00UOy8=TD7-tFgSjbJYA_b9XwQ@mail.gmail.com>
Subject: Re: [PATCH] sandbox: test: Fix typo in test.dts
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nikhil M Jain <n-jain1@ti.com>
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

On Thu, 7 Sept 2023 at 06:56, Michal Simek <michal.simek@amd.com> wrote:
>
> s/parititon/partition/
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  arch/sandbox/dts/test.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
