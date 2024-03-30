Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC49CD1288
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21CF4882A9;
	Sat, 30 Mar 2024 20:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ktG4RKPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2159E882B0; Sat, 30 Mar 2024 20:43:51 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D8C882A1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29f8ae4eae5so953418a91.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711827827; x=1712432627; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCtm4bGCtWYQFLRUh5Zbee7MmI6LUR9CTuQtMGrIyx8=;
 b=ktG4RKPONu+8V+l57w70r5jXQmKjxuKeIxFj+sOfduc/sViCdh5BHi0QTh9nBkL3eG
 86IQt3NtMImALtp4+TWCZ9R6JjUYJUeni0+8h2SYqdm1RQo/IrI5UD4MNIL+EXIta9qK
 R9sAW6GjJWQDamJ2zTchAG4CRn9wSTZoBLYoetAitGWFaFRLqByCXzeEhSs6PuwkWRbY
 uB96kJ4VKdGwf4AIqgtkwXmUC3BpJXYTqmy38hdLjWBfNyNrhz211P/6E1H7rHnHDMf2
 kBCbaPLnp9wCdTpgfP4KdxpaH7zm4h5ypAwZzPJ7aQQmXjny9+yLoEkx4jq7Q0tUvkmm
 nwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711827827; x=1712432627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCtm4bGCtWYQFLRUh5Zbee7MmI6LUR9CTuQtMGrIyx8=;
 b=T46puoeDO85WfaFHcZ7UFIZCvGQW27mWbGKj5Ck2YYIH/d9YIxJDLFgx54RFa/u28A
 f4IGaHohCh22BEFKl5oxh5lgw/IXZtrwcIkXaWD97/n96CDLUEYp88efS9MKF9J4iztS
 3qtspGdzSvpOrOF9Mn5wpcsDNFnyBWkXZXr06sha+6V7UIEx199jRyPDLEVbQNwxNOBB
 4MOeU/Yet7HxdnpblZZCR0eZeqt0YZ5zzfTcc8yZBC0JuxKHZRsy4zRPnuANrra8Lr0l
 /yhPOpaBaUEcb5EYYgQYywoWLPedITAn8fw6nPzknfjcOivf8oHRih5srXEPTtdi+aG+
 /k4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWifAbTP2p20ZSFS9pvV9Q33nDns4trFqc98h6evsxelDE8eu55usUisNUpF8akxuHHiVbn/VzS5aPrsM7Ek3Yqzx8ag==
X-Gm-Message-State: AOJu0Yw3xO/couVywtCmzU2Mwju/IllbGwntdVhGQ68CsSJSVSFH0gKe
 FqhQfeE++In0eR/Cs5GH0rcy3ssit0+UrY9YYRLAViyiK0sF0vgdpkDKoASJIkxh3wF0DmvuJHN
 O+BAjMnwTsZeQkpTlonXyrOQhOAR9Z6XB
X-Google-Smtp-Source: AGHT+IFe8dxEeQq8Z2C0qjunEQn9prqy7gWvdnvM/9Nnw2ssEs+JC2yPRo1JJyAmjhlmKplglkw9I+rvqOqIAEzhbi8=
X-Received: by 2002:a17:90b:1bc5:b0:2a2:e20:f9e2 with SMTP id
 oa5-20020a17090b1bc500b002a20e20f9e2mr5426259pjb.2.1711827827618; Sat, 30 Mar
 2024 12:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240328184319.2572139-1-festevam@gmail.com>
In-Reply-To: <20240328184319.2572139-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:43:37 -0300
Message-ID: <CAOMZO5DW_qVfT8kKuxxDAduGowUW5smnO4AofTws=oD1QCOKhw@mail.gmail.com>
Subject: Re: [PATCH] imx8mq_evk: Remove FEC and Ethernet PHY board code
To: festevam@gmail.com
Cc: peng.fan@nxp.com, u-boot@lists.denx.de
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

On Thu, Mar 28, 2024 at 3:43=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> With Ethernet DM in place, there is no longer the need for having
> the board_phy_config() and setup_fec() functions anymore.
>
> Remove them.
>
> Successfully tested a TFTP transfer after these changes.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied to u-boot-imx/next, thanks.
