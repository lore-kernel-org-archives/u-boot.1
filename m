Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707D1C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 16:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8048488001;
	Sat, 27 Jul 2024 18:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K2i7gON7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CDA2886F1; Sat, 27 Jul 2024 18:43:04 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3E4587B1A
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 18:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52efa98b11eso327897e87.2
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722098582; x=1722703382; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUBHODyOyQv+RYhzo4y+vIriBWo6Cr0QZ5bW+WCmSGY=;
 b=K2i7gON7VkUPIVI4lXjzgKFWcsBnT+tckX86HmLBn8A+YXLK0NYLBBX0IPVp6PNgG/
 jxeqRa4n2p4ga2mBRk/4Fxf3KTUQZUWQ4a+qGvM96eD27wHekveI/MzER01JS0v8XwyD
 lCl+ptcLQZ/5sgCZEJ4WYNh3sAgbTDbIEPe7QVldbKeOJ3j392T5C8G8p1A9bd+PqBrk
 4k5W0pWzJuMQGXIdVh9Va2Xdwml4kj5kA9IzAGCz8jYE7uwtvx7IvbLnP1hcoO3ClIJ4
 lhuDO1OwMOM3lNrAweu12xOGDGw4e+UjhoXCuM9/wBOw1Z9Igmn9V8VbKSgNBm8Fnqj1
 /DBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722098582; x=1722703382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LUBHODyOyQv+RYhzo4y+vIriBWo6Cr0QZ5bW+WCmSGY=;
 b=b8/IyEhSlIdrZVhE6sqKqV+009gniQf6NuC/C3kvdANpRURnNjLVLMeUJ1LfMBFs9t
 1JbaADZ8uu3ugCEa7RN3GKI2hLQE2+PQH8sDx49T8NDl57cg+HFk2n0Z/UenHnvSJJl0
 2G09/56AEr1CFmBNpde3OlpcDwrIk0BIPqdjIffppA+9uneLKN14TRV5U4xQYIJtTG1V
 T1XubZJdDSTE8DmE8Henrtr1w6SWEdsBfDt+E1yR8rRuzLschgYmsaEcVGNEUmt2SMuR
 F1nvOolSqL4aVIV2t0KOSBf41CV/lM+OiWplWahDqwFBOy2IxEtW0P6YW7QQzgYfvu2n
 DG3A==
X-Gm-Message-State: AOJu0YxxUw5cfxTCsqwkS8fj1Fv23oCGHNBCGxqM9MaM5mCLIuXJlrBd
 4/aQsM1bmgZ96zfibwTEVMwFgsEV5sf/VpMFA3OvQR/FqkKPQiB7vLyjFrX94/7gNHKEPzu7sdQ
 iQaqj+5/A/jL9nUfyg+B2QvkxLOM=
X-Google-Smtp-Source: AGHT+IHcDZtU+KQaIDpJAFEZ0npTUI+XE4M4rHNzc5+ssI+4LIjThU9I1N8qRHk3sKjm3Aj7pdoulXstXO/9zYnMyY8=
X-Received: by 2002:ac2:4c4f:0:b0:52f:3c:a81 with SMTP id
 2adb3069b0e04-52fd5274c82mr3856334e87.3.1722098581428; 
 Sat, 27 Jul 2024 09:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240726102954.14546-1-Zhiqiang.Hou@nxp.com>
 <0a40ee6f-1fa1-469b-ac9a-f7d8b6ca9f40@denx.de>
 <DB9PR04MB9236DE687B0FB9543836F55084B42@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <2abff6ea-7669-4023-b71e-bb9605ffb214@denx.de>
In-Reply-To: <2abff6ea-7669-4023-b71e-bb9605ffb214@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 27 Jul 2024 13:42:50 -0300
Message-ID: <CAOMZO5C+b0-9FSdugkeje70RozqnedPNQoHfPPcuvwuJ8MfRvw@mail.gmail.com>
Subject: Re: [PATCHv2] clk: imx8m: register ARM A53 core clock
To: Marek Vasut <marex@denx.de>, "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
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

Hi Zhiqiang,

On Fri, Jul 26, 2024 at 5:38=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> Uh ... why are you adding this patch in the first place ?
>
> Is there anything (driver? arch code?) which requires these clock ?

Marek brings up a good point.

Please explain the motivation/reason for this change in the commit log.

Thanks
