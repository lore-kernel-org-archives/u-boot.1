Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DB8C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 13:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FB21879CB;
	Mon, 22 Jan 2024 14:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VhhfiU22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FF658796E; Mon, 22 Jan 2024 14:01:56 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4094A87BF9
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29054ccb9e7so338205a91.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 05:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705928512; x=1706533312; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBCy9ldY/PVqkbAe1II8b9xlnjraYe1NMOdaxYqK0BI=;
 b=VhhfiU22XoG9tdXMRNV8l5lqVmzU59nhsQBSFSU5zHGM7v9VO39RRflwLeG43hLE3i
 T4eY81D6XkeQ2wHzT2V5r+eiJ7/CQjzQRak2Q+xcBctTvOuCxFHjbGiilvghkQ12ywvn
 Cc19OHAErjjyp2uc0q0mcMUAR378TtsEXUh4gFYArPgGYbufYGiegZvMKF7ec7opsAON
 5M/1Pk57hQifMiokFngelTmnULqnP1MvA8MiIf/mc8NSIlRoF8LCjBi9qs5B1lKEBz3F
 KTTp4L0oOGX+e/W6UM3Pj2ao+SGroOqn+Zu8dnA0xaejwzZhZw5owgiIM+BDcFhg6Ic+
 qYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928512; x=1706533312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IBCy9ldY/PVqkbAe1II8b9xlnjraYe1NMOdaxYqK0BI=;
 b=ecyGQQ5EJpxX351FOo3pcVjWPnyPKZxlIJBzhmq4e3DJarZWZiPleNwdcwIKKPlJFD
 6MUHWBI/OdO9SwGizlJgeemDkbhlYZKaiXJhlQqLqW5Pgt2HluBMlBRNaCiWb9JNe0rS
 d2KQkcbuuv8q335xvPxG1u1CTuso4QfDNuzHodyqquAWxnZBVQd3Rq9LSTS8Yrc332c7
 KrtB/D9mfu6kNqEgt4uPaOugb57CQWQVaiGskejjyZLhja09SMdD6AigQjr8eNvEQTql
 avUzFPhHW1SzD2bARuZhUG0z6CX9JlJb59J7FRsRBN/cFi/ZQYDqGSCD42iZIxfA0YwB
 3oVw==
X-Gm-Message-State: AOJu0YyYRD2BwZouxx5f9d5ZcOGax1FBQwCJfBIdbRS0YzZVRpIyk6f6
 1YoJx+9xk01RncnplxqknQKC0/h9ciEfQrLeSbypVA/rikOmRI9BwWmXq8eDbs9zfgHmIfS9FNj
 /ZWh1f1wrewt5FCj94gcRNCWPMh4=
X-Google-Smtp-Source: AGHT+IGSHRtHHdhOXfayL1Yf47qTj3L66qo2qTnWAxXoMZ1TtBxXL6qt8q8jJuoElYz8FB61G9kvx0DVgv7ZUl+mbO0=
X-Received: by 2002:a17:90a:cb8c:b0:28e:8e5b:73fd with SMTP id
 a12-20020a17090acb8c00b0028e8e5b73fdmr5210904pju.4.1705928512334; Mon, 22 Jan
 2024 05:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20240120003610.124981-1-marex@denx.de>
In-Reply-To: <20240120003610.124981-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jan 2024 10:01:41 -0300
Message-ID: <CAOMZO5Bkrnn9oUnFrj5BBqiBSrFwQs4eaNMwoyt87S7oBXW-Pw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Fri, Jan 19, 2024 at 9:36=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Linux 6.6.y with KASLR enabled would print the following message on boot:
> "
> KASLR disabled due to lack of seed
> "
> Enable the 'kaslrseed' command so a random number seed can be pulled
> from CAAM and inserted into the /chosen node 'kaslr-seed' property of
> Linux kernel DT before boot, thus letting KASLR work properly.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
