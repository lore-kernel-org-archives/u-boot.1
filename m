Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60EEC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C31298648B;
	Tue, 29 Aug 2023 00:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jw6VG4ss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B574863E8; Tue, 29 Aug 2023 00:24:29 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4C78648B
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2690803a368so845665a91.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693261464; x=1693866264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ML5zM84+n/p2T7LJjYp+Bbs0zl5oEAgiEebb629qnjA=;
 b=jw6VG4ssb+RRenvKqHV7jYAJxQNHJg+JP5dYL2N/9xe2qxF2V6GLaUXdixSROLhLCc
 /DrjYgQ0d58byGCFz6kc9rLSy2qdj1Vg6FrOD16jCRIJRIuyf+zNoC0X1gNGEf5+jxKu
 ZEkI61K1qIgaMy4ZguVW4im04rR8+ghZt4FKPS8DJ0+7dvTngUwAXWt/605Z2U6Qekvc
 atN7EXD8KitBrC1CHVsvubHMsOx18n3Y8cSmsV/V6zmc+Sacw5d2ltbf/htkodBDpVWa
 XYTY2HIiWYJ77eA0mm4VZoM7zjUqaWT2OzTeOFWQ7TVNTc7tRLfNRTA6x1QgyB/r5Jom
 CVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693261464; x=1693866264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ML5zM84+n/p2T7LJjYp+Bbs0zl5oEAgiEebb629qnjA=;
 b=hHujCcQoaAsArbWeg+TQ3sv4IUoZ0UJdPMwMFWQ3ci+IMzU6Ozrq166Ur3Dc0QUFAN
 35a0vpZRIDeA8GgkWaAfsCAM+TP6RSTOoFPTF5vOXpzg/WVx0pYqnc/7tVF9/M39HZF6
 h1/QL/WI2M5IO7vpwDXG1RZ2rvk046mFaEgx1Ybgzb2NdV+x7PRUmF5rjJJNgiF12c0C
 EMmTgwINcmx8OByWTG3DJ17fMOax9iyXa4edUuH20sUkIAI/3fwYOstLmfXFTBTeBtlG
 d8CrPeoWSR4r7LvXeimw+hNV0EaSY+5wAGZjcR2hRe278k6lzN0B3t2BDkqay3ChlCKP
 lymw==
X-Gm-Message-State: AOJu0YyBRRL/12xX4Ak31xLhYZrh4JCOSuuFcspk//tsIiWqRJmI4NBh
 edIaDTxloO+uWmafW0HTAnferT7EHNbsWj7EBzg=
X-Google-Smtp-Source: AGHT+IEZbyFS0z+jZdVpwwlO5N5PJnIRV6YHXKv+bHj+Gy4txACNslfBOyjQ0ai05vXaes1dTAGc8hn4GpQ1s0hOtDc=
X-Received: by 2002:a17:90a:4f4b:b0:268:126c:8a8b with SMTP id
 w11-20020a17090a4f4b00b00268126c8a8bmr24853197pjl.3.1693261464601; Mon, 28
 Aug 2023 15:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230828213803.454303-1-marcel@ziswiler.com>
In-Reply-To: <20230828213803.454303-1-marcel@ziswiler.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Aug 2023 19:24:13 -0300
Message-ID: <CAOMZO5BF7Couci7E79=c5+4pryt1QNVh=YULvdW3ok0+TOo1Aw@mail.gmail.com>
Subject: Re: [PATCH v1] board: toradex: verdin-imx8mp: enable usb device and
 fastboot support
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
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

Hi Marcel,

On Mon, Aug 28, 2023 at 6:38=E2=80=AFPM Marcel Ziswiler <marcel@ziswiler.co=
m> wrote:
>
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Enable USB device and fastboot support which may be used to load the
> Toradex Easy Installer FIT image.
>
> While at it also enable USB mass storage aka UMS support.
>
> Note that the i.MX 8M Plus recovery mode support is based on the USB
> boot stage of the BOOTROM and does NOT require USB SDP SPL aka serial
> downloader support.
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Fabio Estevam <festevam@denx.de>
