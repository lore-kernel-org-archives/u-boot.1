Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB80D7494F
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 00:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17ADE891B6;
	Wed, 30 Oct 2024 01:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aIf2dLWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCF31891B8; Wed, 30 Oct 2024 01:11:05 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B03FB890AE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 01:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb559b0b00so50641731fa.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730247058; x=1730851858; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3y9lOSpeIqvFb7xcrMJWsiK/F7K15/M27YbWeK0Dp1Y=;
 b=aIf2dLWUCL2r+EyGJrWtoJhuEGo0lCaKV0V36sKxO1gkPY6q6I8wbdQ0f/UPwZLcUA
 agaCfcNbBT3UhfWMezeaF2XM1EBN4GqgcAA7YpcwspVSx2+5BMDtUT4YCpdVzLnhp3t6
 +Gmt4UOCY6WWYxiH1NX6NFCrtfu/WB43KsrQmNNdoRDl11DGsQiggF7Sk5YZa0830Kic
 1c5bPLPEFP+kbY6qwM9R6x2nwO1Yomo+q1yn/6aZYFujoMcBwAhtoAWWyoB4HEmlpBaD
 5/vjEQxIJFeGJ3yfLyFI52Xl034fiU9I6gQepEgK1wb1TKlqYigXerjlAnZYDhAUxUIR
 YOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730247058; x=1730851858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3y9lOSpeIqvFb7xcrMJWsiK/F7K15/M27YbWeK0Dp1Y=;
 b=bkJpT8zAWdHaAkeXarMV9M41Eui+xF/9+dtHhb/mtMcG/C3IzzmM1E+1jXVLMvqoYS
 53vXJsfHIGDZ+YjJ8+Xwfp0X2ilbChByJzoeFDtYKGV6Bk24aeSfGtwMSPlDXRBXaKaM
 tnqbrGnSe+hKB+7vEFQuhWXqeF3/mTTiggvp4Y1oYJ01xI4hAPv8ShGG5cNFZttOANPM
 tEEAWF6u4fEihmWrku9nb7vD03YepciFEyIzK+4CTeEQZlVrZu5xKhpWLcl3ExX3TIz6
 8XM5HCixfUcHmXyPEi83a+2uaG+/Ic/03hKPkob48hrAa5yDoYlfjO3LtvpEwaaXSOAc
 XmqA==
X-Gm-Message-State: AOJu0Ywi2FGKBpsR/7ODIiYY6e2lHJRweN06TVuXD+nux81lSe5WpcFW
 WUkaeuqPc/wQLMNj/NFHI2QaK1o7/QrKeDT5XDqIa5RBOdAuJ1amQuBZUYGFYTBGN8MUC3C9wtl
 C5hurmbG7goDFsDVmvI2YWMv3CBg=
X-Google-Smtp-Source: AGHT+IGhbdVrAW+94IW+8DxF6iM4pD3fjEjgBaZS9cS0bGJsOvQKbe9/sgyz0CKcmOCthnGxDhQA8wQ+BuMvdPXVMME=
X-Received: by 2002:a05:651c:550:b0:2fa:c913:936 with SMTP id
 38308e7fff4ca-2fcbdf61bfcmr65957401fa.1.1730247057733; Tue, 29 Oct 2024
 17:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241026201455.171001-1-marex@denx.de>
In-Reply-To: <20241026201455.171001-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Oct 2024 21:10:46 -0300
Message-ID: <CAOMZO5CUedKJhKSaHina=7b8eqxmtXFr52Q3kLH5nn7VbWGOeQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: imx: Fix 0Xnn to 0xnn
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
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

On Sat, Oct 26, 2024 at 5:15=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Use lowercase 0x prefix for hexadecimal number to be consistent
> No functional change.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
