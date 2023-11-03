Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7723C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 18:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 527218706B;
	Fri,  3 Nov 2023 19:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gxogx1RE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBE5386F32; Fri,  3 Nov 2023 19:17:15 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90E2C86F32
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 19:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-27fe16e8e02so395974a91.0
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699035429; x=1699640229; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/4udU5o+HpsmfWU4kmmFrhZ/X52fNMWrjQ3Wjafjrs=;
 b=Gxogx1REZDEGSd4T8cTa88+6owK8MKupJNAp0sFdQwpdRpfHD9mv6zysDaXpI/wFmb
 neUT+QjQO06EB1iltjStISlkdO4HsYRk6HsvG9aF2s2HBxPG0qIgepB+prKkneppqzA9
 szDvpcnN1tWHXDmXtsCO7+0GkD3L2/oq/IYS9+2nqBUTwFvXHixDTOlV95TKja7Vh8qW
 5xnSMqbCsolvgt4ZhRozWM4NmXna8a+2jOhYUwI8J802f253+0TmzdWUfKchSMlyLkQm
 anGI7WpAkyLVqPZYSF5ouS8g+z43rPe7OJN2NXxTWxtaS4j/fSxW8u2swZZ+0yXrGs4R
 juqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699035429; x=1699640229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/4udU5o+HpsmfWU4kmmFrhZ/X52fNMWrjQ3Wjafjrs=;
 b=s87TEsA84jwPieXlSvbO0Laoyf394SUJ4vS1yWYlfqfx62D6UW1PuSbItL+ZRvNK5Z
 2j5XDO1KAESKsATBJhFv3x9ZQCkWG4157BCz/zVLFHXr/Y73kHIQDMuZxSClQHHFDEma
 obVktk2RoSFaSYyZLwcN7kllDNsCi+KCnJtTXINyi4oMXPjyj4Kt86P2LTj+fJW6tmO2
 Vm0B4gtrK218vAIKEZtWiDQghlmhhjNA5M/ioxecav9B3Qc73MZX8a4eqELLHF4Blo69
 TlircCmBILYEsqx+KOedCybX4ZJblmsb15CB7UVpugF3M+9HLwgnaXgzLFBFGq3nOkCD
 3vTw==
X-Gm-Message-State: AOJu0Yx/imnWnv7QG4Gx9RuEU0nYNInm8FXf/BZnVvIlsHgUBFMtjDC8
 9CyrXcx6VhHmxCOAos//nuqWj1w9bXWVSb7VEKc=
X-Google-Smtp-Source: AGHT+IHznSziKuoQTH41kM7ytyCKmYdXgQl2UJsG3LIPfnIC46DR9lzaqZdT8z3RCQi2ipZhdu0I3KuFbbHhaUev1Bk=
X-Received: by 2002:a17:90a:b896:b0:280:2bcc:65be with SMTP id
 o22-20020a17090ab89600b002802bcc65bemr18164369pjr.2.1699035428830; Fri, 03
 Nov 2023 11:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231102204454.269-1-egyszeregy@freemail.hu>
In-Reply-To: <20231102204454.269-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 3 Nov 2023 15:16:57 -0300
Message-ID: <CAOMZO5CExQY0UOdyBiv+ppbTYfrw9Y12-+Hj_zhQyjCDy2JRCA@mail.gmail.com>
Subject: Re: [PATCH 1/1] [u-boot][master][PATCH v6] pico-imx7d: add baseboard
 SD card boot detect
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br
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

On Thu, Nov 2, 2023 at 5:45=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Technexion PICO-IMX7 SoM is supporting USDHC3 (eMMC or micro SD on SoM)
> and USDHC1 (SD on carrier board) to use on any carrier board like
> PICO-NYMPH. Based on the U-Boot version from Technexion it adds
> baseboard SD card boot detect to able to boot from selected USDHC1
> or USDHC3 boot devices.
>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> ---

Also, you failed to describe what were the changes compared to the last ver=
sion.

I have already pointed this out in previous reviews. Please don't
ignore review comments.
