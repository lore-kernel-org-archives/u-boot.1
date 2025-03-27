Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B023C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 14:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A8C81D65;
	Thu, 27 Mar 2025 15:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aAzyRXt8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A77E881D4F; Thu, 27 Mar 2025 15:50:07 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC9C806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso8303455e9.0
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743087004; x=1743691804; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rXREG4OJDboSTawnhJI6FA3tveuXGpQ0UHQksSQ/usQ=;
 b=aAzyRXt8P4N8cNSfd8I65trYKh5ZxAVeA3kq5PcAYedXcV7Q91sbFcfZAkXtyIFpcS
 0OAJVSiGQ8OPtNyXbwyVKZ7FYLNiFr2H60wCrDq2PC7EvdnqEz2f4Va0y0GyGEuzD6ky
 9KTSU8mx/OMc/M0wjvrzPOWqmgtaSE2xFVofNKysKcLatwsvUnoa87Ur8D1XFhDNdmZI
 DBUDaJqNgSGhcIGsjCxNN7UJDdQE6ES4WFqJGQpPmFQj5d0U30F7wNbrlZnPw0O0xDT/
 b9bJplvHuwUO0c8yqdbJW9bJDOG5oZ3e5cwqCmqYy9XuIezFjuIUFhNDQ9JNYnXJ6E4v
 VJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743087004; x=1743691804;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXREG4OJDboSTawnhJI6FA3tveuXGpQ0UHQksSQ/usQ=;
 b=V6e/kMpBe3brg4Ziie+DaP9qHtTrslN3o8x/uxFW9hMWntLCOMeruYlR3FD2tEEs3K
 FJT7qxaJ9L0fzI1zTJpb+Pz41TkulH++j9r6pvQPGFGDPJcTJPCfXw+jWu82wKKTlH82
 YKHtNOCDSXo09D2WLu+eT2hONjLyd6yTcJT6cR0eYxgE4Xuqy7xqTuEfE8defOAsBaaZ
 xYH4LCXVzuTG4+QpOofcXGC+k0oMALKpsfv45ciSf3UE1TRyAc4+9nmMvdnMmYJ27oxu
 mgP58NmX6nQdAujJmc20aNeM79l9nlgQgqKlQlj9VirzE3e8MU3pAKu8KuFIgyAWAPbn
 OMgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfMkRQhCxZ987DZ+z2jOLBgyA6UJO9PkawJSl2ZYaO3gvvqu/ZhE4zioVcEaV3JfTRklUeEZA=@lists.denx.de
X-Gm-Message-State: AOJu0YzoWUiAPjcR4Hn9cn/F78vD1DSy5kQVYPnu/OSh0pwEeJd+ACTD
 buRstOHlO4K0g46n218UuVX+qJl2ufN/2JNzxKjpmLmdD110xiJC
X-Gm-Gg: ASbGncuYicbXJJSwvPmQ/198cevMGhOHq0TDVRXyL2YxpndVQJHIC0VRP++35PRUkLA
 6+8ax088VeUsSbZ9XwgBSUKl8jQoko/HLUdQmaatDPsOAJxwrcswGMcOBCsY3VR5bNDVMo6b868
 LgVs1C46+sA2L5fPNeoVIka3amiUTd50slE1FQjLkMm+MiUxvBQXDkFhUPNtcNqE2TTNZcwEMl0
 Vfy6LdSgdJoRryK8aRsDXLiVqZFdOqgoqNEXQ/p0kexjZtE1+kFFM1B6uvipp54BvaNhjrIcqvH
 AoAhRLMf7UoHSEJxfe3IdkMLGgqva6z/Eyee5ZXuFl37QLgMtyp7nlIZ6bcBAgbtuDmm8li7aGV
 OdJjkOOK52CE=
X-Google-Smtp-Source: AGHT+IEggJiTwOVVfBBGvm9nzszyhtPun6UWmNoV3wrtbJlUX6HlVEtKT3faOGRsIEbmad9c+30N1Q==
X-Received: by 2002:a05:600c:1c28:b0:43c:f629:66f4 with SMTP id
 5b1f17b1804b1-43d84e67622mr44744375e9.0.1743087003991; 
 Thu, 27 Mar 2025 07:50:03 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9eff9asm20499716f8f.92.2025.03.27.07.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 07:50:03 -0700 (PDT)
Message-ID: <67e5659b.df0a0220.19a25c.f830@mx.google.com>
X-Google-Original-Message-ID: <Z-VlmTtCGDAKmuAa@Ansuel-XPS.>
Date: Thu, 27 Mar 2025 15:50:01 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: drop NUM_CLOCKS define for
 EN7581
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
 <20250314185941.27834-6-ansuelsmth@gmail.com>
 <7923a39a-184c-4774-ad94-4d72563c8b60@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7923a39a-184c-4774-ad94-4d72563c8b60@linaro.org>
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

On Thu, Mar 27, 2025 at 03:43:47PM +0100, Krzysztof Kozlowski wrote:
> On 14/03/2025 19:59, Christian Marangi wrote:
> > Drop NUM_CLOCKS define for EN7581 dts/upstream/src/include. This is not a binding and
> > should not be placed here. Value is derived internally in the user
> > driver.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Please drop my Ack. I have never acked such patch for uboot. If I did,
> it was by mistake - probably you CC-ed me for some reason.
>

Some explaination, uboot introduced the concept of upstream where they
"import" linux patch for dts and dt-bindings.

This and the other patch are the exact upstream patch with only the path
changed so I keep all the patch commit message with tags and added the

[ upstream commit ] thing.

Hope Tom can better suggest how this should be done. You were CC
probably because the git send-email included you as present in the
different tags.

-- 
	Ansuel
