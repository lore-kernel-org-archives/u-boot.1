Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6891CCA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 13:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D046783893;
	Fri,  5 Sep 2025 15:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TNq7nVBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA9D83893; Fri,  5 Sep 2025 15:32:54 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32ACE834D4
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 15:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-55f753ec672so2411385e87.2
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757079171; x=1757683971; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XioxfDw9UpgLT6hE3IFD7evMrpSs0BDPBN/8UIrnQXg=;
 b=TNq7nVBPEKLYl7WU9k6NGXG9KAlN3bT+pi8nzVTqp53XDLSD1vnetgcFhJAzGef+wZ
 UdQaxyw5T7Zaxc1XkptAYXVQBHHcFHT3RD0Ys+2XLqbdsno1ASkysQHHWs34k9K4QepC
 DcdXV34yJztE8UWw1J6gVcWenFmLi7yJFjQ6TAlI0clxAY0KK2wpJk97sLIoAJR41nWe
 QJlfOVPFbdon7kcd1QY02szy5IIZqUoONGwZUxFrskH9YcPIOvgz4+18ttE8ZlSTZBD+
 IpuTLFIGXEGAQ/h4EC5+cUblZsu9AGxs4+EQnIhXaZv+j3FhIQrJfTxX2a+pqqySb+cF
 /2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757079171; x=1757683971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XioxfDw9UpgLT6hE3IFD7evMrpSs0BDPBN/8UIrnQXg=;
 b=oMI+Os+jTMLmyR6v+eEr9WJnRFV6GFdUvXK26P592OGynDb7U+UcXK0cSlvDmjnGYq
 sWPTMDpAvcndUJNhjWmqK6NpwMYqueu23fqiCONCPH42JTNcb+I2BhsIrvXIwg0BACs7
 kTaUQqw6ePeStWnkk2Ad8NsYcGsOqvl9P8jrue5Lbl6kGoyqCZJrvk6YXkEQl7C0heiR
 xjrwdl6yIS/HPmV1qYxkOLdhnEI2FbVIzwro7nA8jsp7hsGi0xwfOIXZV87dB3CrPRmB
 0FbZMRS+e+y3Js1iVMu8wKwTcX5+jIUWm7N1xoNzB57zvjtAmCTg85kYig3lAgtoUqZK
 d0Yg==
X-Gm-Message-State: AOJu0YzVzOBivgj1MiCKzcLsGjpFZtXVq6c76WZkCIMeULRrnvwJJocj
 deccD0BD9y8mzXWBDC02rTWc9LxJS306gYGBuq6zF0hzq/yS2WLfatHGZx7h2XGVPybT8j3ZKBX
 NqSbJZ9BeC5XUNRFQw5cpaHWaYakbYJbAxg==
X-Gm-Gg: ASbGncusRHqLPe6LwQ5KocaW6Pk4w2dR0INUR3Ndb/qg+GuUQCURE4kqN+UhUAlEyTp
 Lz4JyUJ+znXR8lsUyTGLZL+mF7y1hGsndw2+UlmgjpTDduSMSE0sLjiP6vohHq2fG6vr09ZBcyu
 hnhXlSaLCppKciZ00XOGf+qTfxCyxur0/tjKeU/QbgYdhhSczNA6u6VLahljOWmkqzVHoT6Sk6M
 SBAN0PEFaXQEan7OBcsZynLdHT+JXehAKhiWNltlYJ9QdSmss2Voc6CO68n
X-Google-Smtp-Source: AGHT+IE6W7+M/RYg04Lop4Ngr2T0KqnxWLVTfIl9p7VW0NlrzwoPBbcynrBuCTFmmEzu1/VsFh+fQm/QORsbx+WWLa8=
X-Received: by 2002:a05:6512:2447:b0:55f:3f94:2400 with SMTP id
 2adb3069b0e04-55f7089b379mr6695591e87.1.1757079171298; Fri, 05 Sep 2025
 06:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250829192815.2309584-1-festevam@gmail.com>
In-Reply-To: <20250829192815.2309584-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Sep 2025 10:32:39 -0300
X-Gm-Features: Ac12FXwVX4u2da_I3b-XIPacqmSVGjMt93nEJtPuES45YTEYbyndLQiJBVJ0iVQ
Message-ID: <CAOMZO5BuE7h_qSDH10eKY7UsuE=RoU1KN3XUs8uOziMYTdOEMg@mail.gmail.com>
Subject: Re: [PATCH v2] imx8m[m,n,p]_evk: Add redundant environment support
To: peng.fan@nxp.com
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

On Fri, Aug 29, 2025 at 4:28=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> For reliable Over The Air update, it is recommended that redundant
> environment is used.
>
> Add redundant environment support for the i.MX8M EVK boards.
>
> While at it, increase the environment size and adjust the offset.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied for next, thanks.
