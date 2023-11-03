Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFE6C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 22:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 873B186E02;
	Fri,  3 Nov 2023 23:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HouQ7G8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE7886DAF; Fri,  3 Nov 2023 23:52:09 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E15E8703A
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 23:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc2b8deb23so4693165ad.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699051917; x=1699656717; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvgUiO+7itevWSakiHAyVR/E9VhFTno/fCCZsjpX1wk=;
 b=HouQ7G8Yv6CEiRDceu0n42EKOWNyjkQtfMX0Fdig5I4cwNmejy9+/mtz2372hgecp+
 r6RhmDycsVj5PVONqIF62TxXRiADz2Lk6TTgV5QDEM3OQdmp5egHUyEk717pgBI0uymW
 zUI9ReZynnWx0dc/tUwKs0to+hUwHHD1PIlKJmxmuRvnh92xHlkzcDAqC8cdQfVOCdf4
 Zz1WAI6RzfC7aeNAvpsQMW4OYhFM/+qDhJmZtBZVza8V7+M1ZiiCFaQ81F82XmQQEum9
 3Osbeh8rlLW8ej/O27SBxRkBRrky0FPTuPgioO2cVxwRZvKisGvYi011El80Af+xMy17
 g1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699051917; x=1699656717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvgUiO+7itevWSakiHAyVR/E9VhFTno/fCCZsjpX1wk=;
 b=QpMnBz4MQy/5QU7150rc/hW+bh0MHeGyRWHts9hEpQrhxwy2kME8dk+7IUS7KTdwh9
 2BC8eTn4m5BvbowElJbxmVjAV587/jGH0kMSMt3g5f/TaaIJovBFfsmHhQs+/eNe1rTO
 IzeMMHmzpdQvPoIT7ScGOfidfxy1jB4mnlScAh8WdX3MGeECBxfH9NyflUtRzfyWIeW0
 6DI3wtQvyFAW9NCchykVnNWctmLWnau7Jh5ZZTEekYb2d74XXqjzD+54e9aJwqS8Zu6k
 GBWIdTxH/0sYcAQMFAAQt4MC75l4O/bNpdF0uCAyL6EYrDo6L6nv4nJ3rQuKkRXCN9rm
 qU4A==
X-Gm-Message-State: AOJu0Yx7kup92ZiUw/bQNAIOQenLwKTUzI6xZBZqDttFz9om7UvGli2F
 iuIVStBvv4pkocSfgHCcJWLoxUAFs4NKVaDr978=
X-Google-Smtp-Source: AGHT+IEkSTcSnh7qeLpCsZyemHnAfgmXWCKHpgcQSQSVJ+l7SmmaKy/IVQVC1iej5tnYz5VeJ9NKynfAJoKUGN6tBdg=
X-Received: by 2002:a17:90a:fe10:b0:280:a26f:5860 with SMTP id
 ck16-20020a17090afe1000b00280a26f5860mr10823759pjb.1.1699051916868; Fri, 03
 Nov 2023 15:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231103211640.423-1-egyszeregy@freemail.hu>
In-Reply-To: <20231103211640.423-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 3 Nov 2023 19:51:45 -0300
Message-ID: <CAOMZO5CDvCqjC_0Ka_-k39jpWW=0BXZjpgnMbcNeSZhFBdWYAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: fix typo in AR8035 comment
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br
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

Hi Benjamin,

On Fri, Nov 3, 2023 at 6:16=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> ---
>  board/technexion/pico-imx7d/pico-imx7d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/technexion/pico-imx7d/pico-imx7d.c b/board/technexion/=
pico-imx7d/pico-imx7d.c
> index 6e98b85b28..7f5a092457 100644
> --- a/board/technexion/pico-imx7d/pico-imx7d.c
> +++ b/board/technexion/pico-imx7d/pico-imx7d.c
> @@ -106,7 +106,7 @@ int board_phy_config(struct phy_device *phydev)
>  {
>         unsigned short val;
>
> -       /* To enable AR8035 ouput a 125MHz clk from CLK_25M */
> +       /* To enable AR8035 output a 125MHz clk from CLK_25M */

After looking closer to this code, now that we have Ethernet DM in
place, this whole board_phy_config()
can be removed completely. This also causes the typo to be removed :-)

Here is the patch I sent:
https://lore.kernel.org/u-boot/20231103224733.59410-1-festevam@gmail.com/
