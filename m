Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FCCC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 14:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D727387E0D;
	Tue, 23 Jul 2024 16:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YQGRkJ/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C77FC882B6; Tue, 23 Jul 2024 16:50:51 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DADD686419
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ee9bca8652so7104231fa.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721746247; x=1722351047; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPaFV5qRccvBkMnLgNKprD3KDbapBhgT5bAQTmptFiA=;
 b=YQGRkJ/JLALgmYyoQ0HBu3dZMM+WFNyUCO0evSPM04JIH4EyNi6dcJCbpkWrdSDpNy
 Y0NShXuzim0/sajwsbCkcsVF629Q/WPfEbsoLn4tGwFUg+kYMXu0L20ujfc36EYCK3Ci
 VUne8wCpzjKpqp/qVy8NH4ks6EWbIwFH6wI41jwhwcm85fiaonOEGylA1RtRS/8se8hT
 sXVf3kdrNsKXajxUK+zW5pNgc7jYz5XvmS5ArCVAzkN2xofY8939sw6TpcjAeaybOxWb
 39nuWFkukjiW4XOQrakzDrxydMFl51P7iquCUugPkUaLzReiRS9zFTUpxsl4YTjrzRZh
 uznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721746247; x=1722351047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPaFV5qRccvBkMnLgNKprD3KDbapBhgT5bAQTmptFiA=;
 b=vN0g0Wtiz2Uu0RlEUg2s4XVdNwqwIcFeFwtHKU53P/BmWhR5dPVzguClGTz2G6NOhL
 AARxa3kjMWoCAnW6Xe6W3YZdx2Ls/SyRnpb1RNyc9PK/CbDmdZs3nGt7M3UMLKLFv16O
 ee/EXbdWJwtags34GMsSBxdKLg1u3QbNEnoKjwC87GeHCHb71oK/H7K7AiNmRYX93hsN
 wzRZiJ+2Pk+F1orqE0U7V2yNzmWYn7r4o59Jp0smrpwjoz5m2clkpNzB80JG2/imnFvj
 5oCc3MaC5YVewBc4D/d1Jv6Zghoa2WJaQJKRyCukGllUAS51DjMmiLnEOQ1zP0ASZRz8
 YSxw==
X-Gm-Message-State: AOJu0YwHCEKX239Pn5Q2/LsQTL3dmVyNDSjWhem+hJ28fpv4qO66OoFL
 Lp+Eo9CkuY5M83N/CFwlsaAqaHY/nzhIVG+CbfmgGroOxvyQ21B1JmTP1w3CxlJgNEgDJOJEwMG
 zfZqrI2bsJLtn1zgFqwPmy+xeLV0=
X-Google-Smtp-Source: AGHT+IH9rQkJgJ5laGdLQNeZxSQ3HJCjEyBxmzCCzEawThZS7Zp8DJpf4VnzXMzN2qiP/a6ZoY8RzvO9tsJGzFw2DWo=
X-Received: by 2002:a05:651c:b10:b0:2ef:29fc:f950 with SMTP id
 38308e7fff4ca-2ef29fcfa83mr37997211fa.6.1721746246774; Tue, 23 Jul 2024
 07:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240723150400.16650-1-Zhiqiang.Hou@nxp.com>
 <20240723150400.16650-4-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240723150400.16650-4-Zhiqiang.Hou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 23 Jul 2024 11:50:35 -0300
Message-ID: <CAOMZO5BUguY8vbw9gUux=jfZ312q5pAr3FA0YKq_wAQiCvfEfw@mail.gmail.com>
Subject: Re: [PATCHv1 3/5] cmd: cpu: add release subcommand
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 sjg@chromium.org
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

On Tue, Jul 23, 2024 at 11:43=E2=80=AFAM Zhiqiang Hou <Zhiqiang.Hou@nxp.com=
> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add a new subcommand 'release' to bring up a core to run baremetal
> and RTOS applications.
>
> For example on i.MX8M Plus EVK, release the LAST core to run a RTOS
> application, passing the sequence number of the CPU core to release,
> here it is 3:
>     u-boot=3D> cpu list
>       0: cpu@0      NXP i.MX?? Rev1.1 A53 at 4154504685 MHz at 31C

What is this ?? and this super high frequency?
