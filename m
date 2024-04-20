Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC327C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 18:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE4BA88793;
	Sat, 20 Apr 2024 20:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RPPL3vlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B5468879B; Sat, 20 Apr 2024 20:35:12 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F58F88791
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 20:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e825c89538so4219295ad.3
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713638108; x=1714242908; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIV7Pd3yymQ5bjiu4+H5kiOGfkl9ztSWbffB1b/TZ9g=;
 b=RPPL3vlfmROhxCEhuECZuPeoKKxS4201WsNwFsuridRABxPA+CnSNMdHFdec424X6A
 lW6mDGJ/O776BHbBdHpOx5YCS6rC2+n0YPBs99yvZRon84fsOm2C0G/ZJifWnp/9vLTI
 c3tQdHdSNCsJQGaBQOVPH5VDzcFr7yk04OVrLuWmMRgHgtqr7vhhjrlHEJ4USXOLijRb
 oipcQkzxhztp2WdOWdy73Wc6+pf//hQ0XUDYVmPq0zszUvCFrhhScYgs97spgOYmMYYX
 cc9JHKsXh4+j8xdUjj9wNvOmz21SyMnfiu3QwpTCB0rtLRVrEfWb7weWDrNcBw7Xy5Yz
 dBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713638108; x=1714242908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIV7Pd3yymQ5bjiu4+H5kiOGfkl9ztSWbffB1b/TZ9g=;
 b=xRUGc2c+A2A3wiedfmZDqWQS5l1jyUXUk7DVjSjPnfaef5yvJcgENxBC77xM0KThPx
 jrKiaPkHPeo8YCHlYQGDgwjRP6PYleDKukJ4MWXkNpAbGYOVcA5LEucK0Qy3FKzbjk69
 UmOX6o3EQC0Dlc7A2gwI5ex7es7eqSf5x3yl7TvV4MxY2kNBy8rJxTNaIotrI0ix8INW
 YYI2MQfHHrsuTVHfJyWjDEu/WxhqBniK/VN5h7ydvGOrFhoXnXzR8OLrH5VRzIhSr91L
 wSMGRKE6fVG9pgfsa9PIFVPpHYWAzB+IafBpDtfA0bOnjWbbMN4SmwtZIQlJFdmKDYJX
 OrUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcHoCen1wNp6noJHeWuXoDxLi2+t+QLs71MJ8mb8SQ2Pdgyw2U3iJNQDBjzb5AJ27U5WscYJ3gsOD50mRHVm4bYju1dQ==
X-Gm-Message-State: AOJu0Yz28lJtt91bvVteuvvd9Qv0f9AuKVVk89/sJNq/EXJ81nL6+FTC
 gzQFaWqF/fiKEji5LCOccfFNj7X0R2S7xp+CF1ddOQPtHilM1LaVhJ58MOMLpMZMRCrKW/sCIHU
 mv1bbOQlZ7nt48M7+tWBIopWpTAQ=
X-Google-Smtp-Source: AGHT+IEseXdSHXHJEu9VTqZpbdvnP3lyTkCc+WwvarXrKRN7oGHyixL+F2HJXrpSae7j0JtxmN6ftwJUeQd2Qj84fck=
X-Received: by 2002:a05:6a20:3202:b0:1ac:3efb:2889 with SMTP id
 hl2-20020a056a20320200b001ac3efb2889mr6036144pzc.0.1713638108586; Sat, 20 Apr
 2024 11:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240415215717.3732484-1-festevam@gmail.com>
In-Reply-To: <20240415215717.3732484-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 20 Apr 2024 15:34:58 -0300
Message-ID: <CAOMZO5D6q9yOAQxCptVM1hBr6e=h3gBc-Td2GVDVvun1Gg9W_Q@mail.gmail.com>
Subject: Re: [PATCH] imx93: Move SoC and lifeclycle information to debug level
To: festevam@gmail.com
Cc: ye.li@nxp.com, m.othacehe@gmail.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Mon, Apr 15, 2024 at 6:57=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> The following information printed on every boot is not very
> helpful for the users:
>
> SOC: 0xa0009300
> LC: 0x40040
>
> Move them to debug() level.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks.
