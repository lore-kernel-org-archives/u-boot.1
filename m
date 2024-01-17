Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A843C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 12:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7EDB876DB;
	Wed, 17 Jan 2024 13:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WkRdsE8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678A5879E5; Wed, 17 Jan 2024 13:39:33 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D748206E
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 13:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e6ee8e911so13074320e87.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 04:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705495170; x=1706099970; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSz/1sJNsR8v/7aa7YHZEWyDdRaLeW1vD03f/0mKWk0=;
 b=WkRdsE8IzqadJdb3woBjb5DZrVCR+Ac65Co2QD1dVmRBi9OBDXlmPpLJVa7sXrtYZM
 VXWq2sw1T3RwuEJv2Uzk5v6hSgx5Rr/h361w6IQ2tf6koFY5iQ1f5BPR7BH+LXMXkpmI
 wwlrG+lLBejYAiXW9nG+ke09cjTqQv99bDvzUow0kgKsmd+eOHBHXViRUXiv1pkhmNT2
 L3oKtjBmkwUA4P/cW46rxrfP+2Qr0USoEUoCsvbTMG90EghCHHzi/JZ6wliEFxUyMpjU
 leWkbu3CB9eXLyq8FP+dril7lbZHa9aIdyvr8vJ57cv+H46ZUP0Vu3T5V4XUeCtr1blq
 FA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705495170; x=1706099970;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FSz/1sJNsR8v/7aa7YHZEWyDdRaLeW1vD03f/0mKWk0=;
 b=nZHi9TGxrMiaK3+FjvxJqZb9ll7YqWVnNpu2YlX2Zt8RLPBzpnpjVIPxc0CkOAjph7
 PvRaDQLazV9/9HI3wiZUCUdcXXlfzzMqgDO5e1/me8YLllOZFDvBQ9Mxaj8s0O6CPhZL
 SkCO0YBoBGOBrbSQjFwBdtU7j4LTHp/nALy0rO2amROEl8MUZeufl61aQUfKUK+nLGQ7
 lHrGc+bi/inG1PP2VeGRhXIUQx1nSyd91xlzHkvpfyScTPKaUN26gZSwpMHyjqOCuZve
 9mCcJVMBMQdxScjTdQblhdE+cZjJxFw8AsE1EqbDGr/tTmjOd+7540Ge5fTWMZ5yWnlE
 RXeQ==
X-Gm-Message-State: AOJu0YyqS//828JJSuPu0hUkpP36Fmrr0n9h0w3ihCFRwHvX7HjhKA05
 285izJVW8X0fSlSniz3AuayntN8HVYcSx0lS9gs=
X-Google-Smtp-Source: AGHT+IHpjk6qWyhy5gbaJwXxZZREI7/76JaD1y2ZqkZmJ5z+w26S/uZJNwq0NJ9xKEHbI7c8V7B5mjoZkkIzIcuw8Jk=
X-Received: by 2002:ac2:4d1a:0:b0:50e:e420:65eb with SMTP id
 r26-20020ac24d1a000000b0050ee42065ebmr3559240lfi.128.1705495169658; Wed, 17
 Jan 2024 04:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20240117123714.50380-1-patrice.chotard@foss.st.com>
In-Reply-To: <20240117123714.50380-1-patrice.chotard@foss.st.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 17 Jan 2024 20:39:17 +0800
Message-ID: <CAEUhbmXCaduJq174B5OPRcM=rEHq23CqXEMnU-hTmPNGKiwyyQ@mail.gmail.com>
Subject: Re: [PATCH v2] common: console: Fix print complete stdio device list
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Bin Meng <bmeng@tinylab.org>, 
 Ion Agorria <ion@agorria.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
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

On Wed, Jan 17, 2024 at 8:37=E2=80=AFPM Patrice Chotard
<patrice.chotard@foss.st.com> wrote:
>
> In case CONSOLE_MUX and SYS_CONSOLE_IS_IN_ENV are on and
> stdin or stdout or stderr are missing in environment, as fallback, get
> these either from stdio_devices[std] or stdio_devices[std]->name.
>
> Fixes: 6b343ab38d ("console: Print out complete stdio device list")
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>
> ---
>
> Changes in v2:
>   - simplify code suggested by Bin Meng
>
>  common/console.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
