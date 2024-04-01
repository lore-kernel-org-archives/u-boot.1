Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EB7CD1284
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 01:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DCEE87DF1;
	Mon,  1 Apr 2024 03:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vk/vL2fP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07EB880A5; Mon,  1 Apr 2024 03:37:49 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C35E58780A
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 03:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso503684a12.1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 18:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711935466; x=1712540266; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbcC/UOFStqbl08PKuatBnSu2lL6fIkOBg9xponFn+8=;
 b=Vk/vL2fPMEbIqml0J0s/Vj7LCjn06ifAlzUiKZl3siIgqIsV3s+HBr9movaalFSpwd
 NdvoQgoaEUujzhfHhbm0NNI9FzFs5k/TWn1CKE62Mr0fTiaHnDfHJsISF0o1jcHQwMX5
 J5McRVbOa2aZOoaC/P6E9DNRXCZ32PJq3qK6xLBtRPyO+5F+v90g0LaarUHy6MXcP36w
 7Jj/olMUWgbDrn20+v2tH3QCVIBD5tn4T/LoAHyD9MWEUVdw81a2EKQge5YR/aqGdI5P
 7OZKAf+XG6LU9OnqCMmDMB+CpNfksDm2G8MOtV7Qf54H6+C7s0q6p4T1jT+SYoy44tNv
 +Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711935466; x=1712540266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbcC/UOFStqbl08PKuatBnSu2lL6fIkOBg9xponFn+8=;
 b=BWrN4WYyf2HHnLd1IVH6RNav5EpEYaNbvp1hJryhT8GZTHp7r9+qYhouHZ+bi7rZhM
 /eUjt7yFt9YhYgK72VjKS+VEmX/Jg4ClCk7Pm7gJDrWpHfgVGcHqT0myI2YT6HMx0niw
 0I1UR602+QUTlFSHbAlWw71yuEoaknTqOB9uNUMjBrsw0oQfjBYlUHSk/AyO8so9s1ZS
 ajkvWNUygOnmW8Qu+eNDBRC387p0+trGNwybNmaZtV4KB1QvXOYG+6Is+ps8tHPVQE4S
 ISXNXOCCdKioPoWquLy5MlhiuDVOPNGzB0RB+Xj3rGbOvxsno+/ktVAbdI92DgQtGIVT
 L+Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMHuQIMoHr/7a9afAqbvMSFwRKRTB8IbuD7L9W7hIo1q3lPOPIMvhtbfelsjr2TkcY1ogc5nsQ1TNr8LHKwOg0ePsyHg==
X-Gm-Message-State: AOJu0YzE5VGDx71nQkWvK4rH98Gg9KiQ+iPKmDPhwIb04Bwri0t+XD/j
 lqZQoJOXlIjI+dSPspzkTQrpnW3yIKo5H0uil4y35/0efLtB/NFjEl59AlFc9QawMW4/A0AIvbw
 qvLKDaeV0wRzzDJ/eeUCcE8Fm/LqBtObSMr4=
X-Google-Smtp-Source: AGHT+IGX9Mp4JwbRCzJN59OTN/TtioZc66oxKr+K4b/jorbzq71kqa0czWmuzMGhEmm9OJoL/7WD01eTdPLLXZXGPBQ=
X-Received: by 2002:a17:90b:3a4c:b0:2a2:2dda:6802 with SMTP id
 oh12-20020a17090b3a4c00b002a22dda6802mr3906633pjb.0.1711935466247; Sun, 31
 Mar 2024 18:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <1711935169-26267-1-git-send-email-ye.li@nxp.com>
In-Reply-To: <1711935169-26267-1-git-send-email-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 31 Mar 2024 22:37:35 -0300
Message-ID: <CAOMZO5C8C6hfoQT106y_iFaT7Ewfj9+nnubUWfUUbEvaO3D5DQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm: imx9: Correct imx9_probe_mu prototype
To: Ye Li <ye.li@nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 ye.li@oss.nxp.com
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

Hi Ye Li,

On Sun, Mar 31, 2024 at 10:33=E2=80=AFPM Ye Li <ye.li@nxp.com> wrote:
>
> Since the event callback imx9_probe_mu is re-defined, update
> its prototype.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> ---
> Changes in v2:
>  Fix imx93_var_som and phycore_imx93 as well

Thanks for the fix, but please submit it as part of a series along with
[PATCH 2/2] arm: imx9: Call imx9_probe_mu for DM post in board_r
that you have sent previously.
