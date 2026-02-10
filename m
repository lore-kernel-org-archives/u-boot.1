Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF963EB26E0
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F1D83DCB;
	Tue, 10 Feb 2026 17:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fVKqk4gf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F71D83CBD; Tue, 10 Feb 2026 16:58:01 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3745A83B03
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2aad1dc8856so20300415ad.1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770739078; x=1771343878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiwohQ4Gj9WOQUXCBMMx0/lBAQltyq7XxpaIEEMEEok=;
 b=fVKqk4gfBIG3ZsfDC2ZeL36o/obL5pzsSTrYv4qkJi0i5RrtB3FrVhvAThdgGxRiMi
 SfP9OHKWkLXM1Myjy8uYwWTOmSD/CkptbZFn8QPDEg6CA4RaRv9PItbSe1cHiBGfyLBA
 BK3IIEGX0XW6Ct9qkOCope/VT8zgzEtabtr46h58HQYarKM/Ri8F8Jt8h6AjCL3MHSuX
 XtcBjwkPNdXtn66NTYB99zDRk4TO8CXi21ASF5hCq75ZCOGUwzVy9ZbAxbtOQEFopR3s
 FiYFEcMxQ2XXH48HAfALv9GWxwHP0uJziT0PkmfzMw+5DIspT89ls19DYF/Leo8ldAL4
 3x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770739078; x=1771343878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CiwohQ4Gj9WOQUXCBMMx0/lBAQltyq7XxpaIEEMEEok=;
 b=Swxh7yfA2MidFjCwt8EFQQa3NKdXYAzBsu8+yGl13xA1aCx9sKaCfo4r3FcLI3aZk5
 OaNlbe2b4m4tujKef1jWjPF2MSG0HShPIJw6jUrhIy2dQEgwZZTg8DE3xUww1gbKC3os
 Dy0pbxVI1U0XdTX5l+W3Q9d6W/WnpOtAAVbLftQ4MoF64hrY6NjTXaj7+71DMJ5wQuj5
 4qp7dz7odrjB+fo2Ba2jzznkigj9eLr760fWxwzP7XoyVjSvDdxtYcmFw3rwDijwu7Z0
 Cxi9cO62pLXgBGcVdnMggTFHZxuGhzw5Sbwf7IZd2A8mDcUkBsjW2Q+K4/8d/9g2D+tK
 ew0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ8ZxVELTNgkgSThg9wcEIHRBFkj5jbETZAb3zx89mEP541CmXHhIotdFKioYPlla7UJ7Aohc=@lists.denx.de
X-Gm-Message-State: AOJu0YzMzcgywL49bw0R9GrYveEJnGO2lWAg0WsC3NUgTP7oRaP1we85
 lFUErsUTmvbUluWiy9JgoaLCmitN6I09AtMG1JqF8UdYDVVgquBbZdBf
X-Gm-Gg: AZuq6aJMTk8qP0A3nQhOQSAiBCSsW5uZp/s2bLtK46EyawGBbAxI8QOfO7ngbJud9Kc
 YBVEPG5OWHOkFCm1qO4oV7sexZoSY3oGKQbVE7Idd4odGiaMsZ4U51RF8HQjwlBgx1o0tIn2/B5
 NZLGprIDB2MoHXW6HpyNMLoh85r+S11ZfqLDPCfApEa+S7a44FDP04tfHjn3Zv1MW/f8osVCdJw
 DSMWlM9uYs+/ekTmfgvBAIIBQ6EfXqn1LWrmSYqPP+djtzZ5+D1c/PERTtYqrvNVLWTMPmen0cz
 zl4o5D78wNLWWPAAN04u9pX5Y4faSH0IErT8f8zJG5MPKiTxAxsaRvh4hy/YB6LmKDhHuKAg+HP
 bgwJVlXj7LQotzMSU+IJ9T5bO9qLnK6Q38ei+yc6XUJLMuZT5FEfHMhPlBVvrji6bHcFU1q7wLd
 JwPl9wnYl8xIL4pxPyrpBhEqrQPNRcCQ==
X-Received: by 2002:a17:902:d491:b0:2aa:d320:e96a with SMTP id
 d9443c01a7336-2aad320ecb5mr101977595ad.27.1770739077479; 
 Tue, 10 Feb 2026 07:57:57 -0800 (PST)
Received: from ArchLinux ([43.251.91.63])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2aafef16dedsm51353845ad.0.2026.02.10.07.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:57:57 -0800 (PST)
From: Biswapriyo Nath <nathbappai@gmail.com>
To: Alexey Minnekhanov <alexeymin@minlexx.ru>
Cc: Biswapriyo Nath <nathbappai@gmail.com>, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH RFC 0/3] Add clk and pinctrl drivers for SM6125 SoC
Date: Tue, 10 Feb 2026 15:57:43 +0000
Message-ID: <20260210155745.48819-1-nathbappai@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <39e525d7-0145-47a7-a739-b2b4c68f6801@minlexx.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Feb 2026 17:45:26 +0100
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

On Tue, 10 Feb 2026 15:42:58 +0300 Alexey Minnekhanov <alexeymin@minlexx.ru> wrote:

> Hi!
> 
> Is card detect GPIO set correctly for board?
> 
> Maybe you can verfy card detect is working by repeating the command:
> 
>   gpio status socXX
> 
> (where XX is your cd-gpio) while inserting/removing the SD card.
> 
> --
> Regards,
> Alexey Minnekhanov
> 

I have verified that card detect is working. Here are the outputs.

* with sd card:

=> gpio status
Bank soc:
soc98: input: 1 [x] mmc@4784000.cd-gpios

* without sd card:

=> gpio status
Bank soc:
soc98: input: 0 [x] mmc@4784000.cd-gpios

Thanks.
