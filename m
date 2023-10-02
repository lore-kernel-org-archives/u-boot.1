Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2876DE74911
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D049A87184;
	Mon,  2 Oct 2023 20:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mWkcV4qC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E1B871DE; Mon,  2 Oct 2023 20:57:00 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73928871A1
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b6559cbd74so8294966b.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696273017; x=1696877817; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RD+H2uTj+XNEeSHBGd7AQsNHdtip6IyFSYjoY29V+Wo=;
 b=mWkcV4qChSjH4OAveILRmxWGsr6xB7BAoEOhu7C/icLFelRRYsVPmSNtL19TqEf0/L
 iCrB4WLye4zX25KA8eM/9sxuIQbxZYOpbIEQtDtvSSJLwd2/BjzTA7YqlbRFkeMr3W7t
 u30/lfA6GBStpQSM0yiT0n6xEEZvCPqSwpQg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696273017; x=1696877817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RD+H2uTj+XNEeSHBGd7AQsNHdtip6IyFSYjoY29V+Wo=;
 b=a12bXgXaBEKwp5VmVzVUbIBMPJxGTMrnwi10/uQDmF5hS8hxPTyTdUQ8Mmce2jKLbU
 1bIvWk24fSGgWL5JEEbDPHatSsl+r0LerfWzeuh4tH4AMqQnzikcjNZ4tYxRLwF+DaRs
 uTdeDvNXiQK1ki5QCWP8eGqU0AsYTaRbRG80SCGTfJvFhWuKrr4mjKFGL8SFLDM1HsiT
 FHMOr+flIpXCqRHUmhp8DQtbs0aQNIT36cOpwQ4wpdzYjdJgJjxVDeVgJO8lBv6F7qik
 uw05Iy5RPhqB7Nn1EKKPXhBjSG0ng9vXml/w3qMwL70OzEZXe7O7JP6yMYKcYlck7lxd
 aVog==
X-Gm-Message-State: AOJu0Yx2XnBhtjSlRl2cLt24RESNqOV+JI+7fqyOl97gsllLsjWrtGvw
 m4uvxn2mWRmzxmBA+AqFQoOfLaEzLRCW7MVbXZxArw==
X-Google-Smtp-Source: AGHT+IGxBaL+g+tEWvndgh2lHriWGxviVQOsyFbIDzC+xJWJmXE/bypV3vqvxIVbSTR1iwPCgLOfwTBgCBUZoqJHRgk=
X-Received: by 2002:a17:906:109e:b0:9a6:572f:597f with SMTP id
 u30-20020a170906109e00b009a6572f597fmr9942882eju.38.1696273016769; Mon, 02
 Oct 2023 11:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-2-detlev.casanova@collabora.com>
In-Reply-To: <20231002152142.76516-2-detlev.casanova@collabora.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Oct 2023 12:56:26 -0600
Message-ID: <CAPnjgZ2e94hB2t7VQA+QkzQXFAvhf=46fA0Gpo17cwVrzWJZAA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] sysinfo: Add IDs for board id and revision
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>
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

On Mon, 2 Oct 2023 at 09:21, Detlev Casanova
<detlev.casanova@collabora.com> wrote:
>
> These IDs will be used by the sysinfo command. The new IDs are:
>  * SYSINFO_ID_BOARD_ID: The board ID as an integer
>  * SYSINFO_ID_BOARD_REV_MAJOR: The board major revision as int
>  * SYSINFO_ID_BOARD_REV_MINOR: The board minor revision as int
>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  include/sysinfo.h | 5 +++++
>  1 file changed, 5 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
