Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1761DCE9D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 16:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0D383FBC;
	Tue,  6 Jan 2026 17:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q1kvtB5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 585BA83FC8; Tue,  6 Jan 2026 17:23:54 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3239883F9B
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 17:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-bd1b0e2c1eeso841566a12.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 08:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767716631; x=1768321431; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0zCon2aV98761RPG2w8gXYDUpI9D5J04SYAshpc94V0=;
 b=Q1kvtB5quPOUFVr2EC1Xvd3NwAXDVwO0MoDZ4rSMpKY8sAdxgEJzxWe8kEMEb8XZKB
 lqejCQkCAZ7ivrPafuQulO6WWObXFWh/GlKLttdvntfevuRbRwl9hzhEp72Ym9kY/MH2
 uyhbf1dDcxi6pCpRcxFMNDGDowaInbFK3nLuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767716631; x=1768321431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zCon2aV98761RPG2w8gXYDUpI9D5J04SYAshpc94V0=;
 b=ipr6dVB0//h+KlGYjpB4mEL1OReRlndK56sMtF6OPPc/JZN9lQIhx4TR4jay/DGfy/
 gpS6JW/a4Lm9wo+ZE+1CQCQBRxNqdGzwRCLCQ7QJlCPzzumTnXHf8VxFyiIv1AoKdLVz
 z997NmXrVKQjQwv+2kkuL9tu+iqiUjOLP8Z9inNZixQTgMIKY0CqptIwSLVUjSxVWwkv
 bKdFY+d3yzorL9qUo76CkPiNW6dYt4dzdWGD0hLmqiYDTUooXF2FVcPYsl9GgWn7y7Of
 EA+bcFKD69BTXzsxcSFYU6KkTWoD3FFCFhPbnuPaAxd7vU7CjkQlr8n1o7B21rDXGUC2
 YAsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9jtTvBNB4va1Isn6bcugFOGXxJLAGKLrMymJVfXMnJc9OaLdWRg5lVaAb80da+aRdAM06gHM=@lists.denx.de
X-Gm-Message-State: AOJu0YwECYVSICzqW9NtDm8AumO8qBH5fvDrpUprGb7ooO1WlMjDJBDH
 5T9ZiecRM4FNsHMbFEFvhi/0A3WtCOHqe/F5mONuLfRLUeLdt+o1PtZXcIvkt+HDd/HoXuRqNoY
 KFf6fuajFBbLOLckXUrvQQWUFrd9O+v1aK0qNZM6GCZE++Y0i0BE=
X-Gm-Gg: AY/fxX5d8j9gHjnRa3DgC+O+WAuPPwVdP/VU4ZP/yY5bU0a8uxBICHTZgMst21lys3t
 wQD2IVj918IKhUbbOzDn5uY9LULWIZ/2kS1UYwQPnrbGko1k/08SrCMTo0w5JfMveZuz2pJ0gB3
 v2CDiXeeU4dlKILdreXxh05lrR17ZBjQUNeJ5z9bhend+wgo1NjVVg/We3c8RHlO/Olc9m9DssC
 bTxPlSHEBEqT8kP29wYNd0yNhJTuyDHk08qlGUo81aHSx2bBb7me/7dVv0F2tG51H8WPA==
X-Google-Smtp-Source: AGHT+IG1S67zrNXSSDo8uFhwItV74dAnpLILv4UaeEGtWOezcVXw/xIer47RD2C7bGyVy8jPh/nNDIKpsdkiwka0CYQ=
X-Received: by 2002:a17:90b:1c0f:b0:340:2a59:45c6 with SMTP id
 98e67ed59e1d1-34f5f25a1d0mr3405214a91.4.1767716630665; Tue, 06 Jan 2026
 08:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20260101-clk-reparent-v2-0-3eb42b78c7f1@outlook.com>
 <20260101-clk-reparent-v2-4-3eb42b78c7f1@outlook.com>
In-Reply-To: <20260101-clk-reparent-v2-4-3eb42b78c7f1@outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Jan 2026 09:22:26 -0700
X-Gm-Features: AQt7F2qoow5rsvZZ6ofOPJmFU_xT9DlCALBOztAdlWUysoiljzfdGKf8aWNVc9E
Message-ID: <CAFLszTgJ8R1doWmsXab=1M88sOFjJkVLBOxhQaQx8fVzcGsfJQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] clk: allow assigning parent lazily
To: forbidden405@outlook.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

On Wed, 31 Dec 2025 at 12:52, Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
>
> From: Yang Xiwen <forbidden405@outlook.com>
>
> Don't mandate the parent device exists when registering a clock.
>
> Instead, cache the parent name in the core clk struct and resolve the
> parent in clk_get_parent(), which is called lazily upon real use.
>
> Disable this feature for xPLs by default to save size.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/clk/Kconfig      | 12 ++++++++++++
>  drivers/clk/clk-uclass.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  drivers/clk/clk.c        | 14 ++++++++++++--
>  include/clk.h            |  2 ++
>  4 files changed, 68 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>
