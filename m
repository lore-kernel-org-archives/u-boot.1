Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CD3C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 10:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A358487A5E;
	Thu, 14 Dec 2023 11:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LCP6VkK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2631787A66; Thu, 14 Dec 2023 11:33:45 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F93D87A60
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 11:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so1377682a12.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 02:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702550020; x=1703154820; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjo621yv41iaT24rYAFe8tbxVd+E+w5MGVTUDKJhNoQ=;
 b=LCP6VkK3LYH9iVpXQFLs3DNyYW8R/MFcxqyOjLg3/JRXkhohBx/wzAVeM9aW6xcGOz
 5IEclhpJChfnpgCu39IWiZQ0lM7p0nDBidlIRn8ImVF9ZR+iasarJKV4yHdwGdRLEIEN
 gN3DTAs3kHDeBj38iYCCDjhNldT1nMH1JWKkO/RI0sAcm6bqbZYetjsakoOQmDalbOL9
 Lb7BDOEPfAqmShXgirfcVBmbUkZ9YU5HWHJXn45EKjOimB3/kNAXk+TDhBjfI3SB4+vj
 Z6GCkZFsdiEuPiKUKXSiXebQprtbrGyg6EyElYna5AL+PE8mCh5mN3Pw7G9CKDPBwOTk
 P7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702550020; x=1703154820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjo621yv41iaT24rYAFe8tbxVd+E+w5MGVTUDKJhNoQ=;
 b=gqeGaxIAtzG1aOTFqGHjvrZp7w6gBuG+xoJMh8Fg4b/5PcdhwLYb3EM1tfuVTpFSkU
 ePvjk2bAm2rz/4n1g+ejpAkkwsevjIMsVAXfOH4cS4Yoa+qFhIJazaSlJPvtti7ocJBh
 /z98L+GDr/eIzee9L17Sz6zFa/iUX4EtMLB5kMDIv0NnV8qy7nccN+fV7P6yCwRoyjUq
 0nKRfbW5x7xNAtvTHHDD6RTcY9BQzbqev9qZzxHpUN/E+hhPcjFjDgZBPfkgPqUx5UyR
 l+ms40QzUELJNvm+H7Wq5XdyjUc+/rEAWvM7COY+02E65AxjKJ5q5WXLL1KZKFnW2jme
 l3Ow==
X-Gm-Message-State: AOJu0YxEqTwRZ0dkvBRXzxNpxQguxlt8JMYihi10jYsr2B30K8PRrazY
 Hazc0MSSPoHKEwOwLFlOuVu74XhRNNwiGFHbOE0=
X-Google-Smtp-Source: AGHT+IE9Jdquxmi18fXJ7W/FRQR1M0NMS7ToLz1iJ6pltmaGr420J1O7H9LveRBbCVxRCyGFaW9sBNa3Cfdv/InwCcE=
X-Received: by 2002:a17:90a:6345:b0:286:4055:63e0 with SMTP id
 v5-20020a17090a634500b00286405563e0mr16323860pjs.0.1702550020526; Thu, 14 Dec
 2023 02:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20231122233753.64481-1-marex@denx.de>
In-Reply-To: <20231122233753.64481-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 07:33:29 -0300
Message-ID: <CAOMZO5D+N9gNj7U_x5Z1YadqbBH0wfMe2qxa46JkWmdZ0Wrsaw@mail.gmail.com>
Subject: Re: [PATCH] arm64: imx8mp: Enable TCP, IPv6, wget on Data Modul
 i.MX8M eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>
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

On Wed, Nov 22, 2023 at 8:38=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable support for TCP protocol, wget, and IPv6 on this platform.
> The former two allow users download payload into the U-Boot from
> a web server, which may be more convenient or easier to set up
> than TFTP server. The later is enabled to future proof the IP
> stack on this platform.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx next, thanks.
