Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBBCCF9C62
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 20:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F51B8891E;
	Fri, 20 Sep 2024 22:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CJ4hANq1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40EFD8919A; Fri, 20 Sep 2024 15:01:23 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 579838930A
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ysf.kya34@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5365c060f47so2661713e87.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 06:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726837280; x=1727442080; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mPYXqkZ8qqMW+TaLpTKm/FoeEQlX7sK/Jhm+MmGwMDg=;
 b=CJ4hANq1Psg9ODRGrtXJDVoy4NdnEcE4NNpWulRpu2HHxL2AsJNACV2efxdFZp/fAg
 Qd4euWjp/1ZwU28i567Zl0Bw1UAteZNvhwmcnW8sEji9EBt1O1eLiO4x27D2Egqb9GK3
 DXb8FIZ0/7ayWY5qRuqIaiZ3S1rKnAyji9MeYTXoXtnRAPC/D6/CmnNnxeqmoWpzmyzW
 lzbx+IFcymSqW11Ymk3iODAIUIqOjJ7bSkWA7SAKYuiHCSwLdhYGfXLso2nunudLZFto
 EjnOqMteXe0OwwnlE7vxCM30uOHt3UyqZ3V5Qg65wv7WyPrdEKAGBwa+ZCd5Wadd4XkQ
 GmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726837280; x=1727442080;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mPYXqkZ8qqMW+TaLpTKm/FoeEQlX7sK/Jhm+MmGwMDg=;
 b=m9H/LPJwKLT8Cs/wj1nkUTjQlqlMJIM2q7YH3K41TQq7TpFaUwZ2vSaL50q527nJ8u
 5Cgr6yqJl8gFr+awDm+CeLKXJJZxomY/3kIMm0naAtiMXn+FTFAJh3TEjroH8mBhsm3E
 9DAKzBOC2xtSpxZukIUfxY2SjOesyoDj1UxtwKiGSOtKujQoNSFQEt6KWOJAmIJ6neYm
 2hdavQeJGgZThhsSNzwtBZEKVGOVdrobGA4H5Y2laa54jMJQiGhSQRsD3Yaa36lEe7O+
 snqEDQ9HLJRK6vOyPTvAoZUekuPbmQ3jf0dqOESqjRZ2NuaoHhf096OF5tSbbZEE5F/b
 Ks1g==
X-Gm-Message-State: AOJu0YzHVzRsMuQq8txU/dX/PodOeHtFqtCz4GVkjPQHntILA5TjnNTp
 JpGW5UdPEo/JWpyDCdv5yWgIR1nrBV2aT8YWjYp6k0bF5QfAIGPsLsn8faigosAlKP8Xto7MhCj
 ltgzJpO1Iluz+/SWz4CV3meN4mpW5Eg==
X-Google-Smtp-Source: AGHT+IGnU+Y3nx54Bzs6UXlf4X4cRyy/7PvOXkOvj+wY5gHZlI1usi6VDODSIVoFDIynz7uxY0lateUJNoDnKnP8/40=
X-Received: by 2002:a05:6512:1088:b0:536:7c0d:e554 with SMTP id
 2adb3069b0e04-536ac32f16amr1632699e87.45.1726837279259; Fri, 20 Sep 2024
 06:01:19 -0700 (PDT)
MIME-Version: 1.0
From: Yusuf Kaya <ysf.kya34@gmail.com>
Date: Fri, 20 Sep 2024 16:01:08 +0300
Message-ID: <CAHd9c1pO1RYrkm=nzQ=EW5OpyxvRCmdbrB=TvL8fbaH-TBVSdQ@mail.gmail.com>
Subject: About fsl-espi driver
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 20 Sep 2024 22:04:43 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello,

Firstly thanks for your contribution to u-boot.

When i look at the driver(fsl_espi.c), it has some flaws ? Because when =C4=
=B1
want to receive 6-bytes from the slave device, spi master also sends
6-bytes to the spi slave. This is happening in espi_xfer functionality. I
just wonder it is a mistake or not ?

Thanks in advance.
