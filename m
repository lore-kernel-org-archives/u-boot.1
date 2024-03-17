Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57698C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 23:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB16B87F5E;
	Mon, 18 Mar 2024 00:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mN+/fIMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 265A887F6F; Mon, 18 Mar 2024 00:52:51 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E819F87F3F
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 00:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e694337fffso945910b3a.1
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 16:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710719567; x=1711324367; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d76F1vHi1KDdeiNC491nbLKmybZB3e56NIUhw26qZsY=;
 b=mN+/fIMDOY0ZCkqKQ4tEzcOEvLYsevf7ekOUj9xeCCzdkf5BgIsXduma9mqhlIntuw
 hTzg9N+PtJKStqToHHFwABL92HNdmiVrAoKGlJc8Pq6qIE4rKh+OjdhlKBHHv0iRD0h/
 KcRAgocVMPa9ulvYiWNFDdJM68TLAj+8FsLZbKReNctLwZ/jlViK+kdVTiwHWlL6+i5L
 BtBgDXsInp4+B5ljfMlLdWRPEyGIHASqXjbzs/d/oiv53N192skivf4WgrjWz4yu1Zvm
 /bw8tYt7AzwaTBtmNLgYBN6/JvOTnUGTVThPovsT6A0sWx58cM3eExo/ExE3ycTQbCvu
 +NCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710719567; x=1711324367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d76F1vHi1KDdeiNC491nbLKmybZB3e56NIUhw26qZsY=;
 b=ZN6uOGzwZYtb71EP6Y0s26pXUxLJvFRpj4eIfKeKwov0rz+ZI056jKwaNrUoIdB9Rp
 nXfWgJ4pHRj3FOxfnjtAZlfO0kPHSp/agO50Cn+20X5QwG4RUA9q77HvHuGBQH0/xGLv
 wsEbm0A4BYVGl0InzWNP2eMFoqFLDekcnNVpS/y4rlQT/QofCSU1mFhNw0agpUz3zsBx
 mD7f4lKDsSrqWP2a/han1QNlfFrwqBmrmJOtUBMoSJlsdH5Bw86EVrnUju/j4QkjtqGO
 E0Cue6UjfDKuYD1MGNZAejUjSgVTdKb6ac82ng16g4g58sLldF9zMjp/nY5c3FAeQl5C
 whwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9T5v9eLBTGqsEKiAkwIj51Rcesx1iX4GF9Zm4jcIQo274TsVchxv+BKBNJJ8T+yvYcXk8zdYuFUj+ZHodmYlnZj0t6Q==
X-Gm-Message-State: AOJu0YyNB1jCAI82XbPSzp8kIei1rJMTrN9imWq0dXOVGbrrZUR+OrjT
 4vbLX8oZa6oNqUTMHEVtKuJxkhqtqY/BVAo+Yipvt6iR1uu4Vpd/tuPo261+bf8f+4q/P3Hf86G
 8FKVgSN0lblV/P8+HaRZ0d+e+5sEL8iNVWAo=
X-Google-Smtp-Source: AGHT+IEx0HdiJhO5FeaQGoke6ZGQEqYTn5+gGD7RSiKhB+hNZ8agtdAqZQoQzPEHNiww045sPdoKcUQeQ2C4ONRl2Rs=
X-Received: by 2002:a17:90a:bf13:b0:29b:9d97:b98c with SMTP id
 c19-20020a17090abf1300b0029b9d97b98cmr7530206pjs.2.1710719567508; Sun, 17 Mar
 2024 16:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240312-pcl-070-fix-v1-1-38b5b73e137d@phytec.de>
In-Reply-To: <20240312-pcl-070-fix-v1-1-38b5b73e137d@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 17 Mar 2024 20:52:35 -0300
Message-ID: <CAOMZO5Cyh=T8CBBWp0g-oxVQ5GgMFN3a_5E0BBLjJQ0vr4xHnw@mail.gmail.com>
Subject: Re: [PATCH] board: phytec: define get_som_type also when SoM
 detection is disabled
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Tue, Mar 12, 2024 at 6:39=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wr=
ote:
>
> define the phytec_get_som_type function also when the SoM detection is
> disabled.
>
> Fixes:
> commit 110d321a56c3 ("board: phytec: common: phytec_som_detection: Add ph=
ytec_get_som_type")
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Applied for u-boot-imx/master, thanks.
