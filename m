Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CDBC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E64B882AB;
	Sat, 30 Mar 2024 20:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="coMbYMIy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DB8E882D4; Sat, 30 Mar 2024 20:51:44 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1401B87073
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e24bd6c402so192765ad.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711828300; x=1712433100; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHsj+mFmGq1CdiarKC7pDGeco2A+P0yNsNblMPQFW6g=;
 b=coMbYMIypnliQv1DUZ7oVx6kGwNtEedG3D2feamMf9Ea8Flc2gl5hFvQEevpr2/MUe
 fpYpi5KwFMelMLeDgSTXOR3eGrE1EctVSvy4tlMHqaAsmpT3rVFrJs1xjkXZIBIMe5tO
 zczvynR+BUL3qwF1krO16qcvjpebMfwpG9aRsC0YVKd/Gd0e7ijKOoo6OABQqktI4PJK
 3JoB1kVA7Vl7NI0SO6rpc5AgtQG8Al5yU3VPXenBDJ/Z05tYUH/F7QbKSL1FwWQwTm8y
 v1pa/7A+IWBZHyThDpxjISMP5g6GYe4aqf4FfmvVHZ4E/BSlH/gjdv8AdFLxuXYE/aVT
 kHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711828300; x=1712433100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHsj+mFmGq1CdiarKC7pDGeco2A+P0yNsNblMPQFW6g=;
 b=HvutGNr9IajqKiZCr+E0rPhKFqLEs8pVtWg/icJLDCxFvqSzvL5F9aW65PRgIN900p
 VOE+VsmwfzvmNcXioW25qUmRRP6Fv1ocdXB+CBqs1ODOxXAPyIe5BOBOdI8I9hGgE20T
 1h6EDXBj0GZ9+vwX0+ChQT4yHOhohAH1S2TyQ58+mVqh8PpUmSlXvHToYNNBD3L2crdG
 AD0LR3Og9Mw+fYbY1c1lifv1Q2pTUJX9AaT6SA3fLMhzL08rXmOMxPSxeUfMLDMhwud0
 cNPaOWM0StqtdvXzg/vb7CwZG/ehkGgrJndY9T8/pT3YL9StDin51bizqCUROV/1GZAq
 63qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYo91Hn2iybWGNLP4xrOh2ZkEujCHK7PXSLaZ39IkWYYxRulHnyXhjMaN0jvuOGvhFI6e0MDUFtjThYg1wxiI8ttqMHg==
X-Gm-Message-State: AOJu0YyIbA9njsGg5x0+eyVkBw2gULIaBvRIXTIuk8/VNH9+YorJQ7pJ
 LcZJsYcIexFq6wRy16kIO+5xqmdG9Wp5aSwRMbHVKeFGlSmtcyKfgOXqL7QgzHFtwbuc8RprR+V
 M5Ff5HhhnSbrvPLBI1V/TMIVJFMd6l4TkUuU=
X-Google-Smtp-Source: AGHT+IHRXWRLqeVJkd6ADOjSP4exBzZl59wCoV2Uxe7VTAGGKbznf/6N11Djj9/64zOQnnl8ot1x/d3y5Uh0bl4eWLE=
X-Received: by 2002:a05:6a21:3385:b0:1a3:a936:eb07 with SMTP id
 yy5-20020a056a21338500b001a3a936eb07mr7089017pzb.2.1711828300680; Sat, 30 Mar
 2024 12:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <1711623055-62295-1-git-send-email-ye.li@nxp.com>
In-Reply-To: <1711623055-62295-1-git-send-email-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:51:30 -0300
Message-ID: <CAOMZO5A2mJ6BYU2vG8nFxDyk05_h7WjoLozxuDsKyi20hkRGXQ@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: Fix incorrect return value
To: Ye Li <ye.li@nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 ye.li@oss.nxp.com
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

On Thu, Mar 28, 2024 at 7:51=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> The spl_spi_get_uboot_offs weak function is defined unsigned int.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>

The original Subject is too generic, I changed it to:

image-container: Fix incorrect return value

Applied to u-boot-imx/next, thanks.
