Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C365C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD95D877A1;
	Wed, 29 Nov 2023 19:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="axCOZ0tc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 043C9877AB; Wed, 29 Nov 2023 19:09:58 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA58D86BA8
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-285e54f32d3so6488a91.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701281394; x=1701886194; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TexD1LtTKttYfZ5NmyMLijQ5By5yox2uc5RIKO/fcdE=;
 b=axCOZ0tc5IRHSWV6sF+U6lHULARmH9ra6iBik4xYuKoFhYdHRaR5hX/LIf0YIhPQK0
 SRdUihqYrT/6bxfcRPXx3PTFqqX9gaWXvX9BdXtQzkE8e9HwnX2p8tdfMgbI8rAsKeCO
 1uZIm0EoWnvQZeu1GbGxZLI1K7JHyxbGzHYvVRQ5VKoxDNKK+OwJ7oCDJWeIVtBW4+cQ
 YMKwOw3hEjNLXUOCxtwN9Bo5tO0ZHKDeBov0kiXfqTtVbl7i39RGS8I/YD/wIFjnOAxE
 BnCFp4vL+IyxLm66zHU6nSZ2yYr+oY/MrjGXVqKS1Ku7FttJ7swmHCOIViLlfqOTDxb6
 mNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281394; x=1701886194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TexD1LtTKttYfZ5NmyMLijQ5By5yox2uc5RIKO/fcdE=;
 b=qXKca2S6TKArN+ul0RbhLEjpHM2VfzA2RFJ3mqua9kPOL+mcQraG1Hm5alhNGfsBoN
 eS8DoAXo9GAn8qA5l6AVPZGAaAfo3xc1IcX6iTHRIC21jGa7kDWiFqRxd1ni/ebSKPi4
 FUZxhqlgt97qlTQHzkBFcG6GAztzMFOROW4PdZ3Ax5H1vqealwU9XSzzywSoSN0orWBR
 YaObHRnUyLRYNUqS7I3Ptfp0s0kX2DkAHT+MCYX5YIyQpFOtY8JJ1py2OrcRbQ4ZrWeC
 D4QKqqg0Mkvv8aFsly2YEwjOOu+7lX0Yo0xbWbQfjDcMe1Z04OXm6yLx+MdUGCIsDyNE
 FzMg==
X-Gm-Message-State: AOJu0YwiE7ZP9YnB/lvdigRrgcdbimHqcBHkBFZ1jWjqQ/KcqrDRNd/5
 LSPRAI0Yo2Czqca/Ekur6A05pymTk0lRrFLx4sk+gzeLNYw=
X-Google-Smtp-Source: AGHT+IH2JDfbs4Di+oZcMDWRm0BmgXRhNDUY7/Nfyeue/Ab7V5mB+J7TfXi053lz0y/TWVy7lvkRa0y225TvAaapxRM=
X-Received: by 2002:a17:90b:4f8e:b0:27c:fbf8:6c43 with SMTP id
 qe14-20020a17090b4f8e00b0027cfbf86c43mr19623007pjb.1.1701281394179; Wed, 29
 Nov 2023 10:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20231018185212.128405-1-marex@denx.de>
In-Reply-To: <20231018185212.128405-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:09:44 -0300
Message-ID: <CAOMZO5AqRLgJK3JqkzZaXZW6-NEoCFT3B1Cu8Xkn6SGMaPVrjw@mail.gmail.com>
Subject: Re: [PATCH v2] arm: mxs: Clear CPSR V bit to activate low vectors
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, Stefano Babic <sbabic@denx.de>
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

On Wed, Oct 18, 2023 at 3:52=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The MXS starts with CPSR V bit set, which makes the CPU jump to high vect=
ors
> in case of an exception. Those high vectors are located at 0xffff0000, wh=
ich
> is where the BootROM exception table is located as well. U-Boot should ha=
ndle
> exceptions on its own using its own exception handling code, which is loc=
ated
> at 0x0, i.e. at low vectors. Clear the CPSR V bit, so that the CPU would =
jump
> to low vectors on exception instead, and therefore run the U-Boot excepti=
on
> handling code.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
