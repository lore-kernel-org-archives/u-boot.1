Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30559D0C61B
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 14:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB8788FFB;
	Fri, 25 Oct 2024 16:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AXSJwmjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9A8D88FFD; Fri, 25 Oct 2024 16:47:52 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C978788A4C
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fb58980711so20885061fa.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729867665; x=1730472465; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoKqrGqG+l1O+i2J7JoZdU/UHizHbbKCV1jpj25ftGk=;
 b=AXSJwmjgSi3ud2oN6xgy2w5psYOhVemkiMZXNiJCHpshXt/pUMkhBEIOOUKn6iB9h4
 6OR0QwZ2T5rlIsMqqabOYcDdksQx/NrEaUib1TiFb4H97dlbWVPV1aicS1i9Duiuyj8R
 uJHJi/LeHfTcwUDeyNhgBpCI/epvxA9zpzHVQSer4v55xK0IRRTClWn2Yt1zzuNwRMou
 WKVWcUIMH8Q285QI6yT0cAMBR7xPiwlo7kPyP9DhZBX1y6W7ma1/tl3rqceq6/D4P1G5
 b38tR/DQvN4VnbbAL68BSoHhahwQc5Ne+I9HFm4bel3Xyxjb1vi5xnhn2Xk0jIUQURNb
 cyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729867665; x=1730472465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EoKqrGqG+l1O+i2J7JoZdU/UHizHbbKCV1jpj25ftGk=;
 b=rARSodO1PPrjQnjSYSV96I3URhpH9CCUVql4aIhdAHpDTfhTbUYdMCl2cUfZNLlIk0
 jKCZGohgiXtmq9m20WJE310tYqCSX9cKR4oUJGiQbZ66+Pz2HGk2JgXTE6J42hMOTK4Z
 TMfrdpMaryJY1GXVsrh9cXPxvW+g/v5Cq9P+UXC5qA8YZkhS76e9YpXcLYaiiJ7wwKjj
 LKOTc1zwdYTC/0X6aktPu8ikddb7Foi1CSFu/J/cPKqBWczMOtlCnhBLzat+H89gHG0A
 M48zAic24edurv46v0Q2jAG2FW2H4aVyTeY7swXO7IcfP9xZtQ6IlOPMrZgjBkp52YwM
 LkQQ==
X-Gm-Message-State: AOJu0Yx3HSPzxceZtxHt8ZIuB7Uhg1JQqMFaHh9DCasz+mvF7/4cVMc0
 QLUfc7Rv1NpFwODgvjRSZFAMM3ZsPhYNUhjIDepolLr8GtG8tvzfdcJ8MTWjQCAyEjWvws1yWnt
 zWaLZ9ohGW42thVyMRlz9KOpEZK4=
X-Google-Smtp-Source: AGHT+IFwsnNiDgX2WEH1BPsqkPXb3p7dB/n4mqttysJO836lEC7ZJyRBruds3fh2sQQ68ZCtijmlgRRNpvECoIzXCy8=
X-Received: by 2002:a05:651c:2209:b0:2fb:61d9:d72b with SMTP id
 38308e7fff4ca-2fca81c1cb6mr37767811fa.1.1729867664710; Fri, 25 Oct 2024
 07:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241018175549.361096-1-festevam@gmail.com>
In-Reply-To: <20241018175549.361096-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 11:47:33 -0300
Message-ID: <CAOMZO5AWZjJ8O+SyvRHV4yQ4AF_1jOqwSJsVZ-dTTH4Mz85Y2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mx6ul_14x14_evk: Remove unneeded USB board code
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Fri, Oct 18, 2024 at 2:55=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> With CONFIG_DM_USB, there is no longer the need for any USB board code
> anymore.
>
> Remove the unneeded USB board code.
>
> While at it, also remove the uneeeded CONFIG_USB_MAX_CONTROLLER_COUNT
> option.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied all, thanks.
