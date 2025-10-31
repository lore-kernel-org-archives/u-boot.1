Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07273CCF9E3
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 01:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B5883642;
	Fri, 31 Oct 2025 02:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ORMNgEYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D5283887; Fri, 31 Oct 2025 02:51:00 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D00B8331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 02:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-378d65d8184so22643151fa.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761875457; x=1762480257; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3RQPmlEekhCXbyCAYpnfiWwEgW9qFh//QEKKaKSKr14=;
 b=ORMNgEYx4Z9NiSukILQGLoQ/sZfMlJJ5G+o8eTJ+xfpmcxG3icVT9u+2yy+D6CNKV5
 kq78y7CQnruIWjc4RyYA05Ue/huvzp0wqDrBkmkH8N6xgxTnZZWIXqzWW8U2AGZdKY8l
 TYP5JOnZQMFYbCFPCvlumJbFq41ANuvxp/4oVXK9vXwJqvnhRKZxZmlFLchDgoTnBPda
 84AUDg1Sh6s85L4g1hoD0eGCPxea+zeJ97d2SHL8/wLDW+3M/is7pbIhyby0qIkpNWVE
 yrC20+tOgpTGuCvyUJL8ftFGu51qhiQpMcCRTpmx21vcc384/tIDFKN7rAQMu5i5aZ0r
 ENPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761875457; x=1762480257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3RQPmlEekhCXbyCAYpnfiWwEgW9qFh//QEKKaKSKr14=;
 b=cTqodXwzCLZcWVABVMv4ta7OQLBniUX54nPBbK/vXwI9N3Pnl++zSZRFAV6uqH5slR
 wI0xKnCzhhQjESjcpsb85sL9ka+EkINJay6capejBZ64naOeKxYLn5D5dmruFOz+6XvC
 fYoEXAN3hgmH3gT0OyCzy89YecDn9WFzCeQsDscJDbmQGBeKHMSye4v4UF+7iOHNhoGy
 he84KsRPpkrAdwB8eM4Xibt4rajgZs+YPPcdv8HcmwP1u2vHe6dl9emyfwSSFsWy0Zu0
 VNGHqO4/jLdc9UYxM0k3kBfgNmkCZODRp9LHw61cW+yj+mpdJ9aCVgihHtjaOBgSZcz/
 Uhuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYfwCXXMwmpd29f37U9ZlzZFyvX1+XdJexh7cBQe7oJsMjhak3XOQQOsts1/iGOYWcqt3kJWo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0Z3U6bC0d763JP0lnYsNk/SBPGbxrF3zbfLrda582TfjzUdqH
 G4sbl8kinPhnRB/qyhlSLa/bkwKIymDXszzSi4GVTzGsban8JC5TtYZjTk/3vlpYApcW2DDS/mK
 mBdhd9NogzdwdlP0+M3Cf4+prmkV+Kkg=
X-Gm-Gg: ASbGncskh3KCcxnYVRo/XlXou4otAqZsdEM+niTfoul7uOgq6+YjDUOd7axYOc3G7iq
 SPUw0m7k7RtXSeHkezTdAVSnb3V0XzOeh/t/9FA1/t3OwfOthQQLYyQArU+qSyFKM4iPUpkcZWy
 rKr/ta2PDRpXd4pWL7dOJFgP4bHxReLKXimd/bKg+yaD6t0eGR578oIPXYb6TteWnu60a4SRVGU
 TtxrAtcM9OCVFr57CXcRUbriQJ7IVq6zIRA+xgPFqJ1vhQdntqGeT0tjz28xN3sdIaHq2HLcg==
X-Google-Smtp-Source: AGHT+IEXlPpW8zD1mAIU015YyrIiOHZbabzx8oHWzfntSMtpPTwB5z5xZQrSRt+KtxAiCKSmx92WjzjvbHpUY9aRS6Y=
X-Received: by 2002:a05:6512:304d:b0:592:f814:7c8e with SMTP id
 2adb3069b0e04-5941d5252e7mr645595e87.24.1761875457135; Thu, 30 Oct 2025
 18:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251027105859.258497-1-ernestvanhoecke@gmail.com>
In-Reply-To: <20251027105859.258497-1-ernestvanhoecke@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Oct 2025 22:50:45 -0300
X-Gm-Features: AWmQ_bkIm0kZC30vN7lVH6Ibu3fNb5Tsr2xFU161RyP0d3u-9ZZcH4Q1M9L0Xho
Message-ID: <CAOMZO5AMcdaUcKa5YRAw4JPhZ_9Zb1zXXxRd=SSneiCuGWdTTQ@mail.gmail.com>
Subject: Re: [PATCH v1] board: toradex: add Toradex SMARC iMX95
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot@lists.denx.de, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
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

On Mon, Oct 27, 2025 at 7:59=E2=80=AFAM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
>
> From: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com>
>
> Add support for the Toradex SMARC iMX95.
>
> Link: https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-im=
x95
> Link: https://www.toradex.com/products/carrier-board/smarc-development-bo=
ard-kit
> Signed-off-by: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com=
>
> Co-developed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Co-developed-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Co-developed-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Applied, thanks.
