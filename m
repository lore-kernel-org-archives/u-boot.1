Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AADDC3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1126888BC8;
	Fri,  2 Aug 2024 21:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hEneH68g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E8D88BF0; Fri,  2 Aug 2024 21:24:21 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E1C288BBB
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52f008b40d7so1525124e87.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722626658; x=1723231458; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWkwZqoWmbkFwocnlEKJfPmb3IjrYTWhDGcAimvnv6s=;
 b=hEneH68g4jtu9xirSNlSMzKSyIDCHzidaRUDGotsbkzix6Iwm13mDzfvyqX2fJ0R6L
 qY+duC+hVQb84EsMuifMIiQQMR0hJfqXZn2xpmsezsmo7RlVHlXEwUDvbAtsmwC+qypu
 RNLOw7jksisVDN6TGOYXj195DRf3XTXQSoQjAkJuHOlvm6vh2F6v/ANL8znxNoEY+N8A
 Zt7Qx0XkOiitbA2ZR2ymnIa8HkcvPOj+7QkfGWN+nfqeywX65Ri3OqfHbpAIjPGMOSXR
 kwvHnLH0is9pUXuRnkuZb7AqKiOBYhOUKHe/9xFEprCfKb7D63Jlp9exmmnX1gE2on3S
 +zAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722626658; x=1723231458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWkwZqoWmbkFwocnlEKJfPmb3IjrYTWhDGcAimvnv6s=;
 b=XaOgmioxJGszpHyNckE+tawJyOnAjG1mut0iwAM9VC2EFN/3F8wIJz2IZx3nrodgtH
 /OvNbkR+niEf+ZiDmNYtug+1O+/2fX+taFXVMQs7sc6gxrAZ7s3YGogjETDiQWtiF3LL
 FbgrrVWCkolrIzdfeh9fvNNViBbKyhL+7nNjhSCjENKf4//v3P1fcZn6D4zjUcpJmc7N
 gz6DJku/S9nSB2rQJ2jFk5pdTObXuXeeDRN+xU6PcijmkptW1jkJ52uIyycWsIQXTCPp
 X3cJmwECOwM3ihhRI3Shu9kAylm8vw+rEVbcIIGNJ7JyOxTZym5nyf1FVX4zvaDN881B
 9g0A==
X-Gm-Message-State: AOJu0YykW6Ekh3wmbfnva47H5q591QIFYoUdJLm8otJ95CJcIZ/jMNzf
 FLMWxO2veTrGoc90+yUArLuzI1jomnSmNN1xQIzDj7fo7QNgXJcnPunPCKI1N18bmPy9alzW4re
 w9dN2p7if/O7zk+2ae+R3ij0yEiVy2w==
X-Google-Smtp-Source: AGHT+IEUE2YcyUub7UxJoSVdEeCF9I7/28BADgwXiK01idgU6xSVxPZG7Er9biFHrH6emyC1vSYKjf1MXrqFQt/HWOY=
X-Received: by 2002:a05:6512:3da4:b0:52f:c438:883c with SMTP id
 2adb3069b0e04-530bb362e75mr1694003e87.1.1722626657938; Fri, 02 Aug 2024
 12:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240722175935.2165598-1-festevam@gmail.com>
In-Reply-To: <20240722175935.2165598-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Aug 2024 16:24:06 -0300
Message-ID: <CAOMZO5BujJA9vQA1i7OEKEVGADFRnjsam23ZKnTNaambmoSSjw@mail.gmail.com>
Subject: Re: [PATCH v2] warp7: Convert to OF_UPSTREAM
To: festevam@gmail.com
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com
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

On Mon, Jul 22, 2024 at 2:59=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Instead of using the local imx7s-warp devicetree copies from U-Boot,
> convert the imx7s-warp board to OF_UPSTREAM so that the upstream
> kernel devicetree can be used instead.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
