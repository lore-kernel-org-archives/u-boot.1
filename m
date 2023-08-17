Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935BBC2FC29
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D077586B89;
	Thu, 17 Aug 2023 15:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aZ1QGOcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B7186B7E; Thu, 17 Aug 2023 15:43:00 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC7386B84
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-58dce1f42d6so13150247b3.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692279777; x=1692884577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ogQFvlFWpunDOPqbE6qTr9FrFrj3PZXwYaJXeSh8Wf4=;
 b=aZ1QGOcBXyiRBC5RKqQAeLD8BouLVUcajkeBPTtZfd+u5pDhhdFP6xPrpILmjkstdA
 eJGlz4nI4Wbjg/4C+XevFg5xABqnfT1f9DquW4LtrmqxuNsgxX7ReqmD+Gsq6qxfzIi6
 EX4sahLnM9MmBPheDN0LR+ETaz1Ul1tUW4jyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279777; x=1692884577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ogQFvlFWpunDOPqbE6qTr9FrFrj3PZXwYaJXeSh8Wf4=;
 b=KDpuIbLEV0w/zzzTPhFpHybaTmxB7jtBdCLh2+1SK2POvsfl/ibmso7Cp9YfdZfpxt
 /HqRUtTgfdYLvnQR2LefawN7Tfz3pAgaQuwEgJxLyPV4Jusx9h1ba5SQYzG0ODJwxky2
 2EUTAfPjCO9ZbvtZXUyxOKwdEHSZ46tr6l5XcyZoLim23ht9MSNP/D75Lr4uDxR+04cW
 sPqd0jsDT7OAHhHMlfciHJJqE8U+IHD8lhulNWMDOOs5Ekn1l3BXoeQBCwMilVkLhJrc
 vejUUh3uJ9nGqzmO/yzCcGEe3Zzg3INl1RvrFoKQZ5mClDdBbQ5F9CwsRr4+quYmqtxL
 C5FQ==
X-Gm-Message-State: AOJu0YzY1DpErtddIX9cIen0vXvpYZhC26fAnE3zEzJnXLsEqtaazdjR
 uC8P86pAn4/Wa67f32lUZov0Nem25I//DRu34jLA+uFGJwdjnxjHO08=
X-Google-Smtp-Source: AGHT+IEjOpVIh1Ev6qIxsYdAgF9VAlIRRkLlX1NpkLmrMV+xwsakerNXTHdmJcdsklZEntgPu6xvRTMXBphSy72fU9g=
X-Received: by 2002:a25:2903:0:b0:d73:ed30:1162 with SMTP id
 p3-20020a252903000000b00d73ed301162mr590495ybp.28.1692279776712; Thu, 17 Aug
 2023 06:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230812002823.82576-1-seanedmond@linux.microsoft.com>
 <20230812002823.82576-2-seanedmond@linux.microsoft.com>
In-Reply-To: <20230812002823.82576-2-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 07:41:41 -0600
Message-ID: <CAPnjgZ1NTRFwKnd3QSevNPOiSSHO9vz1UaS1=rLXbNE9sWhT_w@mail.gmail.com>
Subject: Re: [PATCH 1/5] drivers: security: Add security devices to driver
 model
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, stcarlso@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, abdellatif.elkhlifi@arm.com
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

Hi Sean,

On Fri, 11 Aug 2023 at 18:28, <seanedmond@linux.microsoft.com> wrote:
>
> From: Stephen Carlson <stcarlso@linux.microsoft.com>
>
> Security devices currently implement operations to store an OS
> anti-rollback monotonic counter. Existing devices such as the Trusted
> Platform Module (TPM) already support this operation, but this uclass
> provides abstraction for current and future devices that may support
> different features.
>
> - New Driver Model uclass UCLASS_SECURITY.
> - New config CONFIG_DM_SECURITY to enable security device support.
> - New driver sandbox_security matching "security,sandbox", enabled with
>   new config CONFIG_SECURITY_SANDBOX.

How about calling this UCLASS_ROLLBACK and implementing that function?

Then you can add this device as a child of a TPM and the TPM can
implement the API.

Regards,
Simon
