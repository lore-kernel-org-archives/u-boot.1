Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B548DC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B80F88646;
	Fri, 24 May 2024 18:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jKWRIpcj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F75588640; Fri, 24 May 2024 18:30:33 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A50888646
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f4528d63d5so571085ad.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716568229; x=1717173029; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJ8+bRiqo7o2aCU196bpBf+ra+jnqexRyNFRtC9wuIk=;
 b=jKWRIpcjglJjfC92lKPmsRtPvYqCFU1CyqV+U2XcI1toJ8QvrzyTBE6eLKWhfMyIjh
 pXL8jAPxeXOg7e029aiX2hYTl2DetnJt/RoRgEccXp5gOYAstNZdep5GT5UXcGZZHpdd
 aYi8GiIdJ0WRwXH+oOQa9Pyog2XMaq3PXZU+a0xK6q+J/aD/XYhqChzSjCo5L+5G8xPG
 VehM3GkDM6AYg+hgjBE0kvHY/BCrYqAfYAtvRAmTGKZYH6t0rM3OjCmY4+RKu5tgRdw5
 VtDgGaetLzUBFjV6nuqPinf4PI6UspExD9samNOYLv7pqald9j+SALUF9bBn1bj+5wlj
 bBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716568229; x=1717173029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJ8+bRiqo7o2aCU196bpBf+ra+jnqexRyNFRtC9wuIk=;
 b=ZeWe6lNc05rWkd6CtyicWbRav3T3ss8wJcFzBJPeIUbi3DXuz+ugsHNHSTf9KYsGvQ
 ql64dMKI4SHOrOv/unISZbxvHr+KPJHa+65XW11AH6cCFdNnDlq+OqoBWRl5TtfUz1OL
 TbYph2iMHnI6VtY+Iddxy3m8mhWU4tkPn0ObAaF0uZen3cUNaBAoaJQeu2ZJCj9LaOGv
 jWRg7zYfmNFA4DyJ16Z7c17U0etZymYWlAbzP284aUE1KoyjO0MXrfQV1DoN9/qt5sL9
 xmq2JZWI2Jz/hI8wBfEMdPpjOUqr3xgghFjvVC9d1afegWfFFMaFIX1OW8k/N3vJ+YjF
 XrIA==
X-Gm-Message-State: AOJu0YzjN0BzjalOTtogRzBA0BW+CHXZtRyouq8kPvdPkTFGVGYE17/h
 nLt52emHHB0+wti11WKIvJi8VH3ELucHkjN/yo/rfR+67RSuwZNl5ZkQdQi0VaCM1ZeuMElbhTd
 vji9rnNEoOXwQLPDJ5KY65pws1Zk=
X-Google-Smtp-Source: AGHT+IF43Mw540qHnbVqXvY6MOn5WrKVkYgbMJZTrEmo56elI2k+48JSM4oHTSLblqDG85ALr5OSqaAmgZBm84wt/yc=
X-Received: by 2002:a05:6a21:33a7:b0:1af:dbc6:6fe7 with SMTP id
 adf61e73a8af0-1b212eac1e4mr3759836637.5.1716568229027; Fri, 24 May 2024
 09:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240521105000.11376-1-marex@denx.de>
In-Reply-To: <20240521105000.11376-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 24 May 2024 13:30:17 -0300
Message-ID: <CAOMZO5DLeNuFy2e9rdQ70GaYQJYinhN9vQECFkAXavYv4H-cQA@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: mx5: Simplify TFTP server layout on MX53 Menlo
 board
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Olaf Mandel <o.mandel@menlosystems.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>
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

On Tue, May 21, 2024 at 7:50=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> From: Olaf Mandel <o.mandel@menlosystems.com>
>
> By removing the "boot" directory in the "m53menlo/boot/fitImage" path,
> we simplify the TFTP server directory layout a bit. This also requires a
> change to the mmcload command as it (mis-)uses the same variable as the
> TFTP boot.
>
> Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
