Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1710C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7412C86A2B;
	Mon,  4 Sep 2023 16:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="LwN2wjKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDE0486932; Mon,  4 Sep 2023 16:43:34 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 387F786A3C
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce529fdso2026857a12.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693838611; x=1694443411; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5OQ2dSgXKCNBj9cCui6QRIUvc3GphFmZYBWFgYkbe+k=;
 b=LwN2wjKuLL3/Hh+ytogFd12FIVYbyNR8DjPzE8s8Y90ZjrNPXuB/1QuTnU2XPl1Ts9
 XABTGQXKaj4+m1adsQG3RFsqG5M/uQMEfmTXeUX/AAzwrBoC4+YEnDgoAnw/ow4KIU3b
 HzKjQhqubxn3/C51jpuXLSjP8RsguD2sgJX/sKr9YKK21gjtdscmW2HVkBN4czUsxswy
 L8c+Dyhy9CPWbzMtop+y48O1IQWI/83yVDnsq8VquNdh9QFsnUJXg2dkzzKAhYLkfzGV
 LobO5fWqgKbgsn6YepL1OtyUrg92+OfiHbPBQWQpQCeWZ744lpdITP2nwBbKIpGhtpzb
 1gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838611; x=1694443411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5OQ2dSgXKCNBj9cCui6QRIUvc3GphFmZYBWFgYkbe+k=;
 b=ZqfW8xkMllhkvq/9jePFXl3S+rc+sCFu1czyoIwFpPon8qBFl8jpYpsidyAoTIO+OA
 pyNGRo5o39c//7dHc1WFVzH4MTdKvtjFMMjGlLPvtQTq/aAlzzcnHvAiqMPdAb7mAxEP
 qiliuv3fZ5v8Mfu0Hnv55LFrnNdkvQ71pAfBOa8qoK4HClYNYAeMQmOl5vCOsRkvJpaS
 Gr4S6f0BpWI4VOJ5hh3oEZeabtZ/wWpDoVKFaANv4+xZFjl2vbMZzDLGlV0zmfE1lh6V
 Kl7gsRxhDKGhB32mtRjG4Q0N/e3ttWh4Jhju5dDRmMQNh+cZsSs/K3K+mJYXMsAlQVJm
 T+Mw==
X-Gm-Message-State: AOJu0YyrnnaBhvupc4SdAa6aUH8DVoPEb8WoeCUlrK54wvfVWjGirGB/
 mkSuyUz9Fr0gbvS9WBbn0jgjlZMgAdOH7ZMDUzFyb016WFgaBbnlhQA=
X-Google-Smtp-Source: AGHT+IEayoBbR7aVxWVKejpe1gKGvsokYXXodwsp+mika+xYq6LyI/OGFzFoCvmrdzZ54LyF5WM46jFuXUN6OdH4/gQ=
X-Received: by 2002:aa7:c48b:0:b0:523:b1b0:f69f with SMTP id
 m11-20020aa7c48b000000b00523b1b0f69fmr7185473edq.32.1693838610536; Mon, 04
 Sep 2023 07:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230904032035.11926-1-venkatesh.abbarapu@amd.com>
 <20230904032035.11926-2-venkatesh.abbarapu@amd.com>
In-Reply-To: <20230904032035.11926-2-venkatesh.abbarapu@amd.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 4 Sep 2023 08:43:17 -0600
Message-ID: <CAPnjgZ2S6iz8KPG0pVn+XLkfK97oPSLVQcMCQeq3WNyHTZkJAQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] xilinx: versal-net: Do not setup boot_targets if
 driver is not enabled
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
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

Hi Venkatesh,

On Mon, 4 Sept 2023 at 07:58, Venkatesh Yadav Abbarapu
<venkatesh.abbarapu@amd.com> wrote:
>
> SOC can boot in the device which is not accessible from APU and running
> this is detected as error which ends up in stopping boot process.
> Boot mode detection and logic around is present to setup priority
> on boot devices that SOC boot device is likely also used for booting OS.
> Change logic to detect this case with showing message about it but don't
> fail in boot process and don't prioritize boot device in this case.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  board/xilinx/versal-net/board.c | 76 ++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 38 deletions(-)
>

If you switch to standard boot it won't try to boot on devices which
don't exist.

Regards,
Simon
