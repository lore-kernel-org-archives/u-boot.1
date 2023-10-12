Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68574CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C922B86F31;
	Thu, 12 Oct 2023 05:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DcR+E19g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E86486E0F; Thu, 12 Oct 2023 05:46:21 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BCF786EB1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7b92cd0ccso6963417b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082367; x=1697687167; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=btkKJ9TKiKw0RH2pPuu4FPhKuCPNdlHlQlD8TOH3SJA=;
 b=DcR+E19gALaSDzW+3Fa3uZTLKZdIEXmUkViBhnJhfiJirJ75DY4kTNcAFk2svn7GXD
 m6K2s8KkwTu8g/1ht2vCsJg2M5Nq/sVj8hz5Mrb4ODRDLS5uyqnzI1zaNathDqNeQdQf
 jL9AahSPu5VWBFt5pokrXs3rTtM31oB/cq17w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082367; x=1697687167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=btkKJ9TKiKw0RH2pPuu4FPhKuCPNdlHlQlD8TOH3SJA=;
 b=rPFarlYRpQY8u2a3QQbfSkwL3rmLo+KrXH3oLJKBLmffLQjk3bG9mbQK6BoyNiqoGr
 wU6FyaG4DIVjoMbFFbFx2zvijaRTQ0SZ5wEXzuAqee+8X31xGTSh+zP/nkv7wj8dCWT2
 wEnoLW/JtS4821AvcednxyZWCvKrgLxJECXc65zKdiqmQgqjOyBrSt3wLoforSx4cvmb
 UxPJLYSvukvuizTeQ/U6EOstAFx3a/yHKtBQF0pOXX+2q0LR0/byN7C2FzyQuKwxwdac
 YgFmRRSBsbPuOXuQWFbQs3+PMvmb+idFJB2VRUgnh5u/dI9VcRgzg3jMCiKYgff47Enw
 EhEg==
X-Gm-Message-State: AOJu0Yx1MkaDfVLF+nTTh7gQpBqLZ1oIX6WuMgJMEsZ4FJrlGrd5LI/5
 RY71wbZcC/Ysy+zMHygN8s8UJwMZbl55WuGcStg0Yw==
X-Google-Smtp-Source: AGHT+IED8jVH64xerIEmyDlQ/iokXbUPTNH63MxiU3xZz6FT5PqGcHH2bWFPyOjypGd9W72M7ARRzTsGif+yOqgKNt8=
X-Received: by 2002:a81:4fc9:0:b0:599:da80:e1eb with SMTP id
 d192-20020a814fc9000000b00599da80e1ebmr25750523ywb.24.1697082367513; Wed, 11
 Oct 2023 20:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
 <20231011100707.1007417-3-takahiro.akashi@linaro.org>
In-Reply-To: <20231011100707.1007417-3-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:45:17 -0700
Message-ID: <CAPnjgZ177eaFXeoS32fsBeyxKVQTJFQY0b0wbGTE82EqKXCYJA@mail.gmail.com>
Subject: Re: [PATCH v6 02/14] firmware: scmi: use a protocol's own channel if
 assigned
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, u-boot@lists.denx.de, 
 Etienne Carriere <etienne.carriere@foss.st.com>
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

On Wed, 11 Oct 2023 at 03:07, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> SCMI specification allows any protocol to have its own channel for
> the transport. While the current SCMI driver may assign its channel
> from a device tree, the core function, devm_scmi_process_msg(), doesn't
> use a protocol's channel, but always use an agent's channel.
>
> With this commit, devm_scmi_process_msg() tries to find and use
> a protocol's channel. If it doesn't exist, use an agent's.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
> v5
> * new commit (fixing a potential bug)
> ---
>  drivers/firmware/scmi/mailbox_agent.c     | 5 +++--
>  drivers/firmware/scmi/optee_agent.c       | 5 +++--
>  drivers/firmware/scmi/scmi_agent-uclass.c | 7 ++++---
>  drivers/firmware/scmi/smccc_agent.c       | 5 +++--
>  include/scmi_agent-uclass.h               | 8 +++++---
>  5 files changed, 18 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
