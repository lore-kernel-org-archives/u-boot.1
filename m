Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCCAC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C881810F4;
	Thu, 27 Feb 2025 15:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TrEOTyf0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F71B810F5; Thu, 27 Feb 2025 15:19:28 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44B9580F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-54527a7270eso962402e87.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740665965; x=1741270765; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNTFieuEfpID+7ovTzHmFkv3PUhgaO8hHB0i5JtsMeY=;
 b=TrEOTyf0Y3vfO2PViSUn9LlMHyYo06PeaYA7E7iGM2oUzhda79++EEaiCUAjNkTAZ1
 4c5DpmBymNAJtzBp6bkXpHu2NjmpFy3UvK9ETMhJHvyy8mDVcFn4S0ZkbpteKQb1Z/f9
 0QoKUpS+hlu3PKiPrj3ojIhM/ovjtWxNCMTK87o1Rjj3QBVvGawQP7uU6Z5xXbiqrEmh
 yen5Hs7uv12z15isuNgK1yGiKNLsQ4LgYd8eluJ5Zdv6aS0gSFdzzBCnlp46RvBWQlll
 MxlpHYdKqPih4tJ2k/Ot0Dfi/URmfwLlB8BcD0zaHVLuFNJPDFnbzepL4wubfY3ANr9p
 AdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740665965; x=1741270765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNTFieuEfpID+7ovTzHmFkv3PUhgaO8hHB0i5JtsMeY=;
 b=Ypg0JtYOEjLpjCDQTgf9A4gmfz9rEpV6PDdKeDJCjadfSTwf27XubdsmjRUSEU1GXF
 U4iDsbwWZQsfTN2gZ2SUXuKL/jktWGHj4hFCmP3xZS/JBBTeKQTQewuvG76UWnxrMcTQ
 aojnQsxkZCGVVwrYcQUu9ZDSOvOcKuQZMV7A0bcwMK7wu9QC1app3CG/FdgK1Br9oRfZ
 S1pHDhfltjrjN4Slj1xxo9xnoozh6kZfIgKyBnPtxNrzRnwmbQuqfhACwk692Mf/hHiF
 EgHGUr26AWKDwEP7QHOIF3QecQPr8FLmkn08t6MiFwX5OvjcEGz3fF1TpFjRgUPM4pra
 pDgg==
X-Gm-Message-State: AOJu0Yx1RIlglhmK4bcFK4eW5YQMpnbpOzxeXXlknZHA62Y8K2OlJOJe
 q2Pdn2CctsmJerPVm5AKynRJfKNkU/+uaHfjWyQbQneewCuf5RojDw/eUUQ3Rkj6wGoh8Lfj6zR
 hln7Osv3cbZ1i8pmXUK1F6k2telc=
X-Gm-Gg: ASbGnct9CUc2DNqIm63tWuW8DhIfduFpwFgkEqlz0FhoJI3F7EE1robeOYBgczBIUHQ
 FfLwLWQsk8MWs4pHe21Ncsor4QrOD9yiNJueC2iudESUblQ4lpMYklwA/JZOuVq4cyLPLygy4PC
 Zf0NmSvYWMFHc/4nYUqCsPQJ8AiugR3aMVTfzDyjY=
X-Google-Smtp-Source: AGHT+IFJVoBBS5kKZgc2CKWpXvvqE4WIhhV8DY++T1yOLEH9wQVwPaFdqHVjxiA6P1QgKRXVVW0QvSwL0kbPoNU6fm0=
X-Received: by 2002:a05:6512:b05:b0:545:2efc:7458 with SMTP id
 2adb3069b0e04-54839259c52mr12483747e87.39.1740665964690; Thu, 27 Feb 2025
 06:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20250202171039.2073407-1-maks.mishinFZ@gmail.com>
In-Reply-To: <20250202171039.2073407-1-maks.mishinFZ@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 11:19:13 -0300
X-Gm-Features: AQ5f1Jpp8iElrDAWJygJ78dcBNydo_fpkOUkYUzjEpaoK4_nzv0xlziLN4vSXcw
Message-ID: <CAOMZO5B1SrjHb7ekf9F5QyjRenhg4fRuatRz-4dVreDCniFugA@mail.gmail.com>
Subject: Re: [PATCH] tools: imx8mimage: Fix potential memory leak
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: u-boot@lists.denx.de
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

On Sun, Feb 2, 2025 at 2:16=E2=80=AFPM Maks Mishin <maks.mishinfz@gmail.com=
> wrote:
>
> Dynamic memory, referenced by 'line', is allocated at imx8mimage.c:187
> by calling function 'getline' and lost at imx8mimage.c:210.
>
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

Applied, thanks.
