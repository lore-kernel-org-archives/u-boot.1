Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72594E63F14
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 20:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB4D780B98;
	Sun, 15 Feb 2026 21:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qWS3ZKwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD2E980FA1; Sun, 15 Feb 2026 21:59:31 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D2C58063E
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 21:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4ba9abbecso3045838a34.1
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 12:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771189168; x=1771793968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFRQ3b6hdrBlnFUxyZFhT/xiKIOQRdr4x/1kaLylbFI=;
 b=qWS3ZKwPtBEph4PyfennL+jLO9AGlPaSsDMkZsAm3o+pDGhLiJoWb94dkrhY5gGjGx
 NZfHBxLL6faRDyrbpiZhm7EEwmI9ZrZYqcGoMIlL9tRpQFdUHss6Xb7TlGIY1exKCIgs
 bZNHivtBzjAEu3FkjA2Tq7YFbnbA+P1UOh7gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771189168; x=1771793968;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RFRQ3b6hdrBlnFUxyZFhT/xiKIOQRdr4x/1kaLylbFI=;
 b=T9DnnhQw28j1I66Bs2WVvUruoAHMTnt5/eCU7kP4M856rKlKl/Id4ryMwDIGkzawA6
 Lxoi+6q61MqkaCi+OEv+niKC132VCSpqOIQFXuiZ/k3lyw7jwPYE8eLxamkht/rHnT8u
 U87EYkCFLapdm9DGCG2LmCr6u7eLGcgoe9goIw58DyzFmtauTw5zZH0xfpzgvl2CABbk
 nm8/e9oOfekREZsaaEF0FseiehI6EJGrdvCUcKY1lmNKgtUhHVHg2vGbPKcGACF5DOiW
 9DvLMDmIUfalHtF2geHNB1TSN6bT35vfqOMI67k4m9VnW2flb5QFJgaQFigH/jHY1YpK
 +ZgA==
X-Gm-Message-State: AOJu0Yz3oIEQnhfScaKEFkS6JY3smsOh00HI4pPraDgv07d1OFChvk9F
 n4/dNKaD5v94HQ4FHNgbaWx7+0ZjS1okzUszgqcgZrScvKduYvTDcaZnXInjyzpkBuw=
X-Gm-Gg: AZuq6aJsxXf5akiPY6VZOK9SXeTXrKbwdpDwzG17owTEipm10YZK7uRxAx6Z8U9nxDo
 tpyAZcocLqa5ZyTISXjTZsEG5UafHVuTF1gxp10OAT2Q1WbOHtBB+zD8AEoEWS2rCGAvoIP5I+p
 S79YSDi0Gsld0fzp7ZzyHMHzjBvHFHMaVhPqyJ3XoMc5X0Jyv3RoqQ/iL5AX3vvYM9EpEpmm/RD
 LuaahNCh30OEKfmHCszMHInW+Xx1iEIuoqr1T5pWPIyjHBfs5W0kViTGjHK7XAWpp9/73o7e30g
 L6TnqDEOmnaFwndZeEh1XxVGy1b/fZJQqa3cSIgOqy6JdvVQ+4cCz3fHdYkgQJSLLvwPgPdLOpN
 ZVF0fCxtuy3VB0IiifgUu8L/QyVgWMz+bZW5QK8XjuPWcG0lPgS/mGWPKk18hTio0FrniImE/es
 cZ+cscTDw4e7NaJ6ip7IMVoz7ga8iU+s6EM5m8Hiyxyb3iUAeCHkAwFQz7aAMTBDCVKVEgjS8YK
 NegJv4FLG+G57sZMMALmVwzMMK4eok1dVhZaIO4nPHBta7WoYRUtyl4G4LV
X-Received: by 2002:a05:6830:4c07:b0:7cf:d1b7:40b6 with SMTP id
 46e09a7af769-7d4c3002e52mr6242191a34.11.1771189168093; 
 Sun, 15 Feb 2026 12:59:28 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4bb66a066sm7979436a34.19.2026.02.15.12.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 12:59:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Michal Simek <michal.simek@amd.com>, Shantur Rathore <i@shantur.com>
In-Reply-To: <201ac11f-a236-4c9a-8a44-fa9403c90ef9@gmx.de>
References: <201ac11f-a236-4c9a-8a44-fa9403c90ef9@gmx.de>
Subject: Re: [NEXT] Pull request efi-next-2026-02-15
Message-Id: <177118916707.2201206.6965409000161167065.b4-ty@konsulko.com>
Date: Sun, 15 Feb 2026 14:59:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sun, 15 Feb 2026 11:07:53 +0100, Heinrich Schuchardt wrote:

> The following changes since commit 136faf7b0cc92af1d38b0db1bfaa5405e884ee2d:
> 
>    Merge tag 'u-boot-socfpga-next-20260213' of
> https://source.denx.de/u-boot/custodians/u-boot-socfpga into next
> (2026-02-14 11:12:59 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


