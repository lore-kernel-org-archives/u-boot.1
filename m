Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA2DF327BE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1035983FFA;
	Tue, 21 Apr 2026 09:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JuZ6DabF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC31784309; Tue, 21 Apr 2026 09:58:43 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E200B83C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9e00649769so551016866b.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776758321; cv=none;
 d=google.com; s=arc-20240605;
 b=G1WVrU8Q7zxkSz4XNv5gHabsPVwlyAW1pkotPyyy2EieZGu/5dz2DI/ynkcAqw3SWF
 LPdJdGkSpJ5bAMnoKlcmus96D/grpj3cbfVEWrzbg4JDf6TzG0eQz3anXNMxJTFkX/CP
 0o+KCuaJuQnwlVhrBkFjZrNT2lMehZ/RcaMrbrZWCPpNJBIdgGDxcRwmkBVZsCi0EFKS
 KUGJDme2StOAyWVXa25bDrhl45PjnRt2SRe4rWOlbeW5pz7oyM7NqG6N7CeuSI6yq3uE
 AyVPZIYki+2SGWYfeIDW0LOULZnD79wtP5lEz39SNieqHAzyUz4Yusy5fQwlD7X3VHNX
 2T/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pty1oS1gX+eSLZIpdQTU1tSgzdwwRsshKxjyhB2SfpM=;
 fh=b18uCgLv6wZxa0VDbhih661tjWnVZzC6sSbr5BOYWm4=;
 b=OUpasw+XFXBJ6V8mFiHVQOShRRQSYdsSWVxynGD3Qx+qv80V/OTFfl2ASFn/fBr28X
 hNZvkquuuNcLGV1Z5tppuDHsM9rWQf69j4aja8cyOzY5S64F2e/FUmwzmk01ozIJynpR
 fA8Cs200NbHoIqgsVclfb6PQoGw1RLiX9r6e7jkIRUn1ieF9bW5xleHaUOLTkN7mMYKs
 GQvA+Ejo17t5cBAlzzMXx0mF0oNvDillVplmM8WISc96NR2CNOl7WaD5Vrm21CWIiemY
 Ha/dPJmKhuy2G3dKYVDiGg8f6imwENB5/2fgVyfVw6VrL9JnWQqxc7jJj81CzECD54vD
 Z0Mw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776758321; x=1777363121; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pty1oS1gX+eSLZIpdQTU1tSgzdwwRsshKxjyhB2SfpM=;
 b=JuZ6DabFQT4Oq66ap3cx2VOT6YLy6TXBj5bTr4kgx/Z3u/jKnoKiqyhzPLd88onMB1
 QZNUOjDrhdhhkKq0llwLocRniEL800R79vhxHFr8n+WIrZFmAf+B99qyFuO/mwAh2W5O
 Oc735Q2+q5Syl+8zaMeCzuxrArPs3UIrDV34U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758321; x=1777363121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pty1oS1gX+eSLZIpdQTU1tSgzdwwRsshKxjyhB2SfpM=;
 b=ekClZIH1cH8DhqccgaXtCJ50D3iWE1QOwoO33ay/SipRiB0BcBjwY6ncUhroWKpExy
 AuSYh+feQk40Um8PJ+wxdztxdaS7V3dbr08fDouwyqxYCprMx5CQ4pBGKUKYFPqeICVI
 R8a5vMHPE0EtZuV3e5ZDsI1EzHOgLPD59zaIS+7X6c8T4SV2IAHp0yhSMMFgwyt5tGVd
 gJP5iGwWTpwrits/Php4BEUGIcyPp1k1Zme1yxsjuoCl4EBh1NUE613GiHmIuD2TlPkc
 QudfiHTL0I4NnDoIe+L2U3bOzFmOF5K1h81FVv7dHc/m5JniO6PuhyxmovCguwoxMbSM
 FHBQ==
X-Gm-Message-State: AOJu0YxM4fxYgitXXSgTMQimgFrbKPbR6UM0/sTa6bNjFV+GqNHmwEj9
 pJaqwUfw730giLJrWkuh6QcXwFuG6DNFzrL0yz+fmyJBWEWAUzjpPTo2b0EC6ZS8Ut2OXUJvM2w
 3PqJibTDO4frdcMwZVci6xrTUm63PaCQY0YsH8TwZ
X-Gm-Gg: AeBDies7EsAOhwlDM27hFxOa4Bxu3Cux7mTeStTASC+E+tYq+Ky3JCX4HyI1etMBbHG
 FNoB86hTmobhAsSwIwNdwWHJ/9eI6QXiyMw+N92zHHCCZmfrrwuE/zKwJ4m3YV+Ns6IZpPIlyAk
 vI7Gwf6SCW+0kdaFlTD3Li7L1MgXq983ZIN+hvbaI5z4IQUDga55TrU9nSDrgTK9xeb3eWGGRct
 A1uIp8ldGviNitS+BrTwO0nh985QpvnNkiSP2Zv2GQGPEyGEFCtMwkTccad2Rj5cPQK0CElSWda
 Ht0hag9H/7AS9k4RdTHQ
X-Received: by 2002:a17:906:c3a5:b0:ba9:2282:2897 with SMTP id
 a640c23a62f3a-ba9228229b5mr118693766b.15.1776758321235; Tue, 21 Apr 2026
 00:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260420163551.515651-1-sigmaepsilon92@gmail.com>
In-Reply-To: <20260420163551.515651-1-sigmaepsilon92@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 19:58:19 +1200
X-Gm-Features: AQROBzDLV53UYOQyTw3wpikaM2s5m9iJmJlKmuDQd_nCXcxi0Sn_WnLwdSwyZg8
Message-ID: <CAFLszTiMj0-1_NN8bkGLh2D4CcPf2vHQ76yTP_WqouQOB=Boig@mail.gmail.com>
Subject: Re: [PATCH] fs/squashfs: Set ret to 0 on successful read
To: sigmaepsilon92@gmail.com
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Eric Kilmer <eric.kilmer@trailofbits.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Simon Glass <simon.glass@canonical.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 2026-04-20T16:35:31, Michael Zimmermann <sigmaepsilon92@gmail.com> wrote:
> fs/squashfs: Set ret to 0 on successful read
>
> It might still be a positive number due to the call to sqfs_disk_read.
> This only happens when reading a file from an uncompressed squashfs.
>
> I found this by trying to boot using the extlinux bootmethod, where
> positive values are treated as errors.
>
> Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
>
> fs/squashfs/sqfs.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
