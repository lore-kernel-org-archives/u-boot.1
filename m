Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F96AE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0442C894BD;
	Thu,  5 Dec 2024 18:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YQc37z7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68AD8953D; Thu,  5 Dec 2024 18:57:58 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1283894BD
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 18:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a68480164so154128066b.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733421476; x=1734026276; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n/5wyvk8NHLhumZQrtCNKLwXbvh0LeW6wkxLzacjHTM=;
 b=YQc37z7ckpW3gtKfdM8zSZ4snGQBfPTpvKqPP8jpR8n88/sgM1e/4klP271cVPP0cM
 KMKbd920LhL3vtzrgk98RFiJSNahPQFjeTZpjQxmDOh6JULUFwjxBampY0EbZTeCPhYa
 rUW1c3bOuKRVV1lVfpU72e+6H63aE/rhE1OSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421476; x=1734026276;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n/5wyvk8NHLhumZQrtCNKLwXbvh0LeW6wkxLzacjHTM=;
 b=E8J3pCV6ccaxZbcbw4YzNO4ndSDYUr4tJ4x8/21i4uuIF2xUG4Y+fYfek8MMsZ/sPG
 EZ+i6om+QkBHAxINXgJVqox4A29uFqZvS1+JGfTsUAZORehMilJe5KunRomWMQZcvQYu
 K3Ir+Cd0vSca+SVMg5R7eSRrfaqJIv781Kv8yWDFXn49O6vKWm3hHhHyjR27I+Yrfhwh
 5fHylKy/f20QdQEu7TU/kw9PHKSPS9cA5Mf4x5EF0jdNs+dGBwLV7AU/3CzJN5tXyAVe
 aMSBhU6rvdNk4NS7dhIrOlbXtVDk+l0XYMBQLoxxSZJlSUuUqhUVGXhGQsMPQGPm4JLC
 07Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbq7xLMUt9xWftM+We9SHEXeYkVhfqlm7IOQ5azLJtb3xzXt5/CUJbMQ5COcqWrQsLYZk5Eyw=@lists.denx.de
X-Gm-Message-State: AOJu0YzGOMEmOaP4EZxqzhxCky9lXSDfsZtpmsX1hSjJSeQU4zDqdk62
 o/3tp6nVPBbX79bHsPqMt2+DOZoaZCe19sm6Rli9gbJkKA01NiUvuG4IiTEWe23EQLWEkETFKCi
 tF75nDdPc0PwwVx0pJwPWgnfahlbWduu3H4kV
X-Gm-Gg: ASbGncsmhbRdK1Ef8Z5RwssEGPOMPuENeedGZrsVozuojFmjBHvd1MrV07Mfcv8n0am
 bUMa713iiLB48rUhoGmUZeuX91De/0PPA
X-Google-Smtp-Source: AGHT+IEoRFqtgP08qxIApgoZBWaTSFZNy0qWepxXOD3IZaCmWhm5ow8eOwql1OKHkmbAIQUf4qIbVatK+hCt54KBFQY=
X-Received: by 2002:a17:907:948f:b0:aa5:308c:3489 with SMTP id
 a640c23a62f3a-aa5f7f4a73emr1184413266b.58.1733421476282; Thu, 05 Dec 2024
 09:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
 <20241205-ge-mainline-display-support-v2-2-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-2-4683bb4388dc@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Dec 2024 10:57:42 -0700
Message-ID: <CAFLszTh6CB-UbtkSjfvcmR8qAV9aq34p-OXhdOQ1sidzgj_NOg@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] dm: core: Add a helper to retrieve devices
 through graph endpoints
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

On Thu, 5 Dec 2024 at 06:54, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> There are already several helpers to find a udevice based on its
> position in a device tree, like getting a child or a node pointed by a
> phandle, but there was no support for graph endpoints, which are very
> common in display pipelines.
>
> Add a new helper, named uclass_get_device_by_endpoint() which enters the
> child graph reprensentation, looks for a specific port, then follows the
> remote endpoint, and finally retrieves the first parent of the given
> uclass_id.
>
> This is a very handy and straightforward way to get a bridge or a panel
> handle.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/core/uclass.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/dm/uclass.h   | 21 +++++++++++++++++
>  2 files changed, 83 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
