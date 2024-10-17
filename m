Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0897BD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECBE890CA;
	Fri, 18 Oct 2024 01:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lxM5Cjws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6550189059; Fri, 18 Oct 2024 01:11:36 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7307A89080
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cbd1ae26a6so10305976d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206692; x=1729811492; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aO2lyzxQzWLA5ouXr8bqKPGkwg6mV0j4fDe5TILFUHc=;
 b=lxM5CjwscL1B9RYpxXrfIasFe4jb7jY4cqt+aV7dr/MORVzZ6TrTu1a6TFtinF1kl3
 wgPWtjCB4C6oXi4ZHBrg0hlHdR0I2xFfA9ZMXGoaH2Ia/Y3vKr/Om6Cdx+OEUuLQDO8S
 AMeaecRHCVOotmHyFnutmgczEPzRvF/4oBfyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206692; x=1729811492;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aO2lyzxQzWLA5ouXr8bqKPGkwg6mV0j4fDe5TILFUHc=;
 b=vOxuFVgKk7Ztf34qTzFHwq2Ej6egQ8NYqzjJ/2SzMILaNbJE6Ty2VKU6SR0mkkduIl
 M2d0zQKkn6dsONLsCEVPPgA7PuMZOULt+37ovg0cKe7MyknL0ugdNBDVk8GThTtFXA/q
 FLFtiWOZmk3OOqGAASiNRtVs5zD6MfY0gpLr8C8U6RgsHUKqp/jqwWIrX16CeyUiPMh2
 oGbr1amvSJGUt3bZsi3t50+IdG5/u6dmuODnU69pAmIIEbk2K3ARXfmRNx1XcXYaAApw
 udK/otwNpxJButcLJBFzWXgwQZqO1pkO/uJAGJEvAiXnoFyYDMMNCBjSXXOaGXtyqY04
 mzhQ==
X-Gm-Message-State: AOJu0Yx+vGbcFXaWTETtQhKgNkZetbE+qsRo4hxDuQvkNMQwx2wVzwQa
 mZ1YfUbRlHT/spCRXCsy1Y9/lLYxynNCPDfm1fHRS7oXfPcjLZTsYznAFxBJOaF6+1B8q+Oajsz
 QxASpfdCL0mTXNKWNxs9kZAW5nVfLeKSZwS5Y
X-Google-Smtp-Source: AGHT+IGMUGCOCV6Tfg9U/b2XJAt30No5DU/6Y9FtwbcFczBvRpfzBNeNj/NVHRnjeBkF7QPg9B/+/kKogzcYqhewZHs=
X-Received: by 2002:a05:6214:4607:b0:6c3:6c66:af6e with SMTP id
 6a1803df08f44-6cde162cf73mr7599946d6.47.1729206692403; Thu, 17 Oct 2024
 16:11:32 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 23:11:32 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241015163454.GP53053@bill-the-cat>
References: <20241015163454.GP53053@bill-the-cat>
 <20241014223212.2212442-1-sjg@chromium.org>
 <20241014223212.2212442-14-sjg@chromium.org>
Date: Thu, 17 Oct 2024 23:11:32 +0000
X-Google-Sender-Auth: ymjgzLSESKZhRzArMj7TrMNeXyQ
Message-ID: <CAFLszTiFbCyDykZst2ro9bRmQAn_o0Sn9e37cpwUZLDkg5nV9w@mail.gmail.com>
Subject: Re: [PATCH v3 13/20] docker: Update coreboot
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

On Mon, Oct 14, 2024 at 04:32:05PM -0600, Simon Glass wrote:

> Update to a newer version which supports settings in CMOS RAM and
> linear framebuffer.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

-- 
Tom

Applied to u-boot-dm, thanks!
