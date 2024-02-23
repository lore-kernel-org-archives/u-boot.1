Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCC8C54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 13:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF6BA87BAF;
	Fri, 23 Feb 2024 14:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q/9aM0+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2970787B84; Fri, 23 Feb 2024 14:40:55 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9696879DF
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 14:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29a5ed64502so62040a91.0
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 05:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708695639; x=1709300439; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUw6ChargoMs9kN666h+7LjFL0e4e2L9iDE/NjzvXPs=;
 b=Q/9aM0+XDyoEDYlFmv3OXTCM69n+PV61p75hPxJtKrtoZ9cNGGLzOwLwOBPgd1rPQp
 KOcmnyF9T/IvNZzF99lKrXJuhryg35l2VnCbj5gRLBLObEMdXx7rn/Rt/Lwyxhj+4oPs
 1FjJjv2/pKDqVAkKLfCQPSP8GshBeR7jV3CSCQ+Qu0nYVJyhbskI5rz0GSxPd2vsrTMj
 p6WvuPg/PpjxXbbKXYJXG6beyo9yeKdp8oDQvGPT37js8IfWjHuXj6j7S/HPqFeW4fVj
 TL0ggYWJ3ZqYbHGPZrRNyAdHyBpn2nA7Thg3mNdQTAgLxd6SqTQKb4uuMOXO8zb3J7pX
 M7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708695639; x=1709300439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUw6ChargoMs9kN666h+7LjFL0e4e2L9iDE/NjzvXPs=;
 b=fyN+Tw71a/3G685Jrjt9cCEfFpFlWkhq7gQt5HxSLPKmtqc0jT4Rxll8tjH3DhWb/3
 xTF4bGBIITSrkxYfzRB0eBHs1IROqzS2jq+cYzpXxPFHN4gXP1xtpXMxNZADSDAGKRSP
 kwOAqqtnrQMPYEEPks7JcxSrXEDnnJ7qSYemwUBoI18ju6z4/G6yzFnnvTOdK79aCcCe
 8wTb4PipZsxlbhc3+SxCi+AAmeJtbszctKojVdyN94a3DbrNoyFECqDikBRpgRIoCbLf
 Bm0Aj5qrAeYzRobWH9T1QT9yea2+ydhZXcRCt2khkRopJSuzG+D2zZie42myfGYSwtvC
 Y/3Q==
X-Gm-Message-State: AOJu0YwzVxJMQGre5rcIfTQgxkc/amZ/1Piw0TekbqTdlrB4Cbi28Oyq
 cueNpoYAukVqV+jq/XCcMJClsMdffwITjg2t0kdL3sszJHqVdLxtobE+IgkAPgS+4EEKVEE/yP6
 ghxPYzPN3SvLppN31cB58ab2/Lus=
X-Google-Smtp-Source: AGHT+IGxsRklsbQ8Ug8GMnQfab4jinUR8Td4D832g0+wgidOBPvyMJyA+T3yRzk6Pc8xuLJN9PzwKrF7QIxho5nRHFM=
X-Received: by 2002:a17:90a:154c:b0:299:2c43:cd96 with SMTP id
 y12-20020a17090a154c00b002992c43cd96mr1598885pja.0.1708695638968; Fri, 23 Feb
 2024 05:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20240223112804.15559-1-sebastien.szymanski@armadeus.com>
In-Reply-To: <20240223112804.15559-1-sebastien.szymanski@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Feb 2024 10:40:29 -0300
Message-ID: <CAOMZO5DvsLsFHdAb40VT_af+eT1=W6HYAZyDKKyrF2Gixg+3qQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] opos6uldev: Convert to watchdog driver model
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Fri, Feb 23, 2024 at 8:28=E2=80=AFAM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
>
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
>
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset.
>
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com=
>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
