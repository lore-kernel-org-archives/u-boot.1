Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE35BC4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 14:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3245186F23;
	Sun,  5 Nov 2023 15:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g2g68TYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C286886EEE; Sun,  5 Nov 2023 15:07:22 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C30E86F1C
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 15:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso5877249a12.0
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 06:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699193211; x=1699798011; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNimV0pxiND1l+DJCiLTbaFSb12s73HBDj3fw9Su7Y4=;
 b=g2g68TYbjSQkBdRfbDBalA1vjz4BITmvZyi+LG+DGZ81TbRabbZhOn0HHYroMkFQTy
 Uj/L9vthgTfaNSASbZ3CHsWXKjHC97jg9hW0nm+1eu0/stjLy3GGnd9fgovEM3Cam1UB
 oQtH0ZHSULI0PzTaKcZNk8wsWxXpB+dWtyv8wHxP3GdRmhQ60UuXrhoxzc61A7sQt2Eo
 US/5YL0nwHRCd+L7L18cks6VRzAEANuSLsF4oaL1Aus8Uv8RjQS+4uMhiRyOwGOE7KGP
 3m6fzQTv/EfoCs/5NAh0V/v6yTh+zxdStiEc8U0tr45VgjYaEBk1xqI+xTAitVzF+8KB
 SwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699193211; x=1699798011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNimV0pxiND1l+DJCiLTbaFSb12s73HBDj3fw9Su7Y4=;
 b=I+UtoDkWT0KeWEjKvUz+FoBh4Nu6DeN+AIh3cTrux7bDjrGra2P/n++R/t0jNvSAcg
 SaSYUbfxp77Xov1yHxqCI0s9c5g7jweV3xgWf6PvCUPB3fMeXmL4e7ZKYI16XqPJTmbb
 h5b4aIvsKD6KPXVJdr3lnys7L92TbXb5dy0v41xblWKdBWnYzQ4J/x/ejTeZYQCWHXWC
 SpqVOHk8A+vkBToN1Mcmwg1FF3+Pf/R3BRX+iTJle/ulabNCPt4ZnIY+Osfw76jK55UQ
 rcROILs05JtmVzj90/7wJ5MweNu6DBtIlZQtUksW/yRbJtlN3N92z+Qnp3fqgPmHtpSP
 qR+g==
X-Gm-Message-State: AOJu0Yzgt8TP3K44j7YYCP2Xoh1Tq9z6EmYKlf++Koqsxs3+xtYtwdHK
 mpJro/pJkUYT4XjWjtT/+zals0xGX+hpeVLMMzY=
X-Google-Smtp-Source: AGHT+IHMhbGe/0iKpPmqXkwOs7BT5weh7PjUxuJOSoq1/Ul+9L8p0OTGnjx+uSOGLgIud2TzaU0lGTb69VWfr5ygMto=
X-Received: by 2002:a50:9b48:0:b0:544:5b1d:ff87 with SMTP id
 a8-20020a509b48000000b005445b1dff87mr2939720edj.38.1699193211347; Sun, 05 Nov
 2023 06:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-4-sjg@chromium.org>
In-Reply-To: <20231002011450.462468-4-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 5 Nov 2023 22:06:40 +0800
Message-ID: <CAEUhbmWzREZNRim4qAoMmonjwMNE4hyXcUzVDV+_HdtNS3Z2Hg@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] video: Drop unnecessary truetype operations from
 SPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
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

On Mon, Oct 2, 2023 at 11:32=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Saving and restoring entries is used for expo and for the command line,
> which we don't use in SPL. Drop these methods.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Add new patch to drop unnecessary truetype operations from SPL
>
>  drivers/video/console_truetype.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
