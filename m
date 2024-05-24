Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE45C25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9513688640;
	Fri, 24 May 2024 18:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eYWwIoBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5444888D3; Fri, 24 May 2024 18:30:00 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4724C88278
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-67628045856so179664a12.2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716568197; x=1717172997; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6u8kf4hKo0RL486jvdvMWcT+hooe4Of+uVQevmDSyQM=;
 b=eYWwIoBvJBgUQxWY48/LpQVPKDaiS3cYqhs3nDdOID30UE3fzW1IhPQK6vEWd8gBG2
 9vUXDmW+Nso69ywJYIs+lUVV11NdRxjTRASLyiosSBKUTkrBFQKxVlPLNWa1Ihec0xnJ
 TEtgyEQNHr5z4h8o2+36GqlnEbfL15AWJ0RJKbfZSma79jMahusln0cJN927E4lUht3W
 SYl0LGSiTHGlYGAVCF6c8R+xBtfndcd3VVfvCw+eWDe4xDuT8gYd/J6NZAQcH1wXb6wq
 6yF+ksxe3YJIpeMPRIkD0sNW5B3w0FY+D5xEzpBBb76OaBNo12+pFHMEDsFj6S4CRJ7c
 i1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716568197; x=1717172997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6u8kf4hKo0RL486jvdvMWcT+hooe4Of+uVQevmDSyQM=;
 b=jKPOyKnrhL/7/JXKIno+bnFP301WFbimi380SoScLNOwsekw4yov0S2gUmfMPu5rnt
 03l7ct/SJj7fx75xIeupZi55xX5ZRFpltC2cdY7ip4gs3rTXhJIJt/AHra/bgMpa3Hjf
 DcwzpP6RmJH/jAC5l8fnyIA+UFfFxAu+Cq5CwvbXjviVmIq4nBtEgLptNNXHi46cQrOl
 246OQ/H0U5pv1knfSOQ+qUqBbcdLGZwRfU/ugw7Rla5A+/OmKYgVS5cWTRdXhMI/+LsG
 j3AuXgS9zDWjH4ikaZEwh1kUO68O/kPNlcg58swDioImt95Ue0glNbsipYeU3b3w4UrT
 oGgg==
X-Gm-Message-State: AOJu0Yw02XP6ChA3LjKgYRWnqwdT+jdh1D9+//kqEcUgICNVR73IMRzZ
 r7QEHLf0zVZoiW+gkr3S41BMjKFTYiqvrv2x3iUflUn6hFm8SKUgl88B0In13qgIudMTfix9g40
 6LpMryYq2XT63M0fzlJRfHdL0hVI=
X-Google-Smtp-Source: AGHT+IFuSJOCivNDVIbcm3gIfC+WVfGsAMo/+FXWQzilUz703ZewzGgvIHUuRgvfuZAL1nwNpNunrM3VtD2MwpQ+OrQ=
X-Received: by 2002:a17:90a:6d22:b0:2bd:df8b:4ad7 with SMTP id
 98e67ed59e1d1-2bf5f407f12mr2573766a91.4.1716568196616; Fri, 24 May 2024
 09:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240521094216.8919-1-marex@denx.de>
In-Reply-To: <20240521094216.8919-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 24 May 2024 13:29:45 -0300
Message-ID: <CAOMZO5Dx3RLhPQkfJSjBvFrjy9p4SBQSsZTyu8GjDYwsMRKykA@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: mx5: Enable BMODE command on MX53 Menlo board
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>
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

On Tue, May 21, 2024 at 6:42=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> The board can do primary/secondary boot switching, enable the bmode comma=
nd.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
