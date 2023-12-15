Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35B5C4167D
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 01:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5663187B43;
	Fri, 15 Dec 2023 02:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TY17kwNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5BD287B58; Fri, 15 Dec 2023 02:18:26 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937EB87B40
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 02:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5c6910e93e3so47503a12.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702603103; x=1703207903; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrTpygv28SdL/8QvVPMVis3C9ZEM2pLHOLHSCo+wCOQ=;
 b=TY17kwNBBpDbmJUE/mag+jxrTvz8SQ+G9FvqRpFpNlacaFlprgO02f1Q4IEICrEv/6
 2dVgXak0Oc5OwvnMTeEeuuItBTgPFtM00/W2w3roqDWZgZSDwvi4xs/SKVu3pWBNl00A
 sAPOiPTwYjJcLOCZsqbW8/+s5CsdoIh+bDcIJHJfsMPX1al1D0hm6j4SitD0ztm9oFkG
 a6CmGHD+llc5nj71Qc74iOHmxgbIFSsdhUOoShedAayNOhE+3yUB4NwPUMYhLW857zx5
 Ikshf4s/KTtxXDN7STV/R9X3+p+6ljiyh0gH0OGO5d0pS0rnUsUIqOcwUTOFLVYKhWx2
 9KRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702603103; x=1703207903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrTpygv28SdL/8QvVPMVis3C9ZEM2pLHOLHSCo+wCOQ=;
 b=M+pcfztX5tLm8mKImrHe3nSDBMWvwrhCCgvZ/jKqfWWBTqARGcYNUGPIt1M+SwC+qN
 LojrchVTnGqicZWwjmkty+yGOJJEhWb87Whxfxz3yh2Kqr9mvKoiJfvJjL8ff3QMbOv/
 yGAOtswkVJeNsLuOMSYaXiogl/fSSTuYBCtLVxOOU1oEsvGe7B0VhZ48g06jIrItPD+P
 LkThg/o9zDSKLDVdaUh4imKcRqwcDYyROpdV727xVwOo5u5uzDlD5xrGdKCZiqnu8Ui1
 0khyrzaYyBlC1VbRNUygiG4J70Y6ISUaQR8NeGigevMsborbaJDGqxRI+RDT2/HULN+i
 tmuA==
X-Gm-Message-State: AOJu0YwDQxhOhvCp3Cjw0BoaZ8q4JRuU6SnIKUfUbhbyfaYEt1eGXRWv
 SYZ7vsU6zPDLTF+s3OErXMuWM6Zq/adPtjuXc2k=
X-Google-Smtp-Source: AGHT+IFddKe5sg8i0CjGg2kviC5rhvhlIbiJluuMuW+fRg4/2Hb1uPF/rsHJF2+rNksz+jkgtdx2QO/t48UafMlkk1s=
X-Received: by 2002:a17:90a:9905:b0:286:7cc2:4c15 with SMTP id
 b5-20020a17090a990500b002867cc24c15mr18441469pjp.0.1702603102979; Thu, 14 Dec
 2023 17:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20231202015620.213638-1-marex@denx.de>
In-Reply-To: <20231202015620.213638-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 22:18:11 -0300
Message-ID: <CAOMZO5ASqQHd9HprdrsrfCiRrGjxGSLzJQae=JqwPc-+vUszAw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable CAAM on Data Modul i.MX8M Mini/Plus eDM
 SBC
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

On Fri, Dec 1, 2023 at 10:56=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable CAAM in U-Boot to make crypto available early in the boot process.
>
> This has a side-effect that in case an older kernel version contains a
> broken CAAM initialization timeout code, initialization in bootloader
> will help that old kernel version function correctly.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx master, thanks.
