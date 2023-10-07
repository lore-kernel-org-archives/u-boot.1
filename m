Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DDBE95A61
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 12:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA79386CDB;
	Sat,  7 Oct 2023 14:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gePjIH4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10401863C8; Sat,  7 Oct 2023 14:58:09 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66A3986406
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 14:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c76ef40e84so5777925ad.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696683484; x=1697288284; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lUXk5XDlDAIPkpZR9f4fitNdbfxemJ0TLMqVDFiD/rM=;
 b=gePjIH4LCkPHC6JEJq4H5bNbjjIbCXMte61R82h+oOm3+qQd4SpaBLEYdM76dfNQTy
 CyEjgqo8MEnUQ3HQPMF3d3wl79uXJWTkjE5zKCJyhP0iy0YmEHfSDTwsoWN6FlDt7w8U
 tDKc7Mtnhq7MxsTtEw0UVAF/VnMkQSarU8BRgYh5ecJyFaKsMpQJHLd7o+pvGuR+s2pe
 a9PLEwhZNrMZXEKpXN/2BJiMK3by3y61cyERfZq3VZtq1/vWPhltqBvdAWcBoXh4xUMx
 8sNNVv518BipcPPEmFkIPDvD2GpVrK9+hjdxGf9wrKhrx+stqly7dsqZTVlz3CqeUBuJ
 hEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696683484; x=1697288284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lUXk5XDlDAIPkpZR9f4fitNdbfxemJ0TLMqVDFiD/rM=;
 b=PpEait4M/wUOTChHdCV2KEoa+gD/CNM2N9UdrAOo/XaSdhtAtNsmma/yqESWQrXvU9
 r73sZtuH/TBgbfg1rs18JdLWu/JNaVFUk08ScUfN2rzvNTZkeuxfw/ws1bNP2SxpxTLM
 usuosz26Z+qQKt+3ePHDny4KcK1JEHfw7hd2fyLdLCFOYBSByahpDu0qX/KtVPWr+IId
 QPtoIoyqaGn3weupy+AhDyv8j4i2Zg/ylAvJz6MHqRDUHP+qFcXew+JzqY4ihwfd9Bxt
 rU1+kZfkrKUQlJLoXJCo3DClccW1GWPyjQAa9eFEIOdtXpjIVfycH9i8OUgXQ4xQ/zti
 g1rQ==
X-Gm-Message-State: AOJu0YziAG1QYMi6jxUlZMJmX+xuRJGKudWz7HpQOtAFA4J6kh9XnfWT
 G79K88+o2DIDOvVZ4lM1akQsNGfVn/KpXFxpyFY=
X-Google-Smtp-Source: AGHT+IG+Y6CoFuZexHCG6NRuSePLoca0ubytL+0XR8uydxUrmLMam6jcJ7gqnbh8vM2m1t7wri9GfCDigGn7Z9EJLA0=
X-Received: by 2002:a05:6a20:c18f:b0:16e:26fd:7c02 with SMTP id
 bg15-20020a056a20c18f00b0016e26fd7c02mr61843pzb.2.1696683483759; Sat, 07 Oct
 2023 05:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230921082955.28951-1-andrej.rosano@withsecure.com>
In-Reply-To: <20230921082955.28951-1-andrej.rosano@withsecure.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Oct 2023 09:57:51 -0300
Message-ID: <CAOMZO5CjTEy_18g7Nq4z1NO1mz3+4BeL_4yBRjLXS4ea99nPKA@mail.gmail.com>
Subject: Re: [PATCH] usbarmory: Add DM_I2C and DM_SERIAL support
To: Andrej Rosano <andrej.rosano@withsecure.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
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

On Thu, Sep 21, 2023 at 8:27=E2=80=AFAM Andrej Rosano
<andrej.rosano@withsecure.com> wrote:
>
> From: Andrej Rosano <andrej.rosano@withsecure.com>
>
> Use DM_I2C and DM_SERIAL as it is now mandatory.
>
> Signed-off-by: Andrej Rosano <andrej.rosano@withsecure.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
