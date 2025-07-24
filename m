Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058F6C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB2083844;
	Thu, 24 Jul 2025 23:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kNEjh7s4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B79D838EE; Thu, 24 Jul 2025 23:15:08 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3041F835B2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-555024588b1so1541401e87.1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753391705; x=1753996505; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwK8MrAzHvWkVEK9PD4qvKXKiY5LM3WS6woyLLh5kg8=;
 b=kNEjh7s4O5rS1qoQSYL7469JeNXpXKsASaPOYQDlxS41KoFsnTLRFGs+s+jGEksZtN
 J9JaRYF8SvybJu32u8ZoEu5p5uFCOk8H3xwLUeJQWgi+kQnNb7L9TKelIsiS3OvkM6+V
 vL8iORnoHpPsDaVWIdhhWCaebxoUqdZhaUwqDC7zSQBwliYYZBQHAso/C5coV4oql4a/
 II+7VqNEJYoO2wlb/1ZcVLHnC57tOX1wFQL4v4zSKOhIZ1Kb6qCCAISg/ieC+ShYOnXw
 kwVt+9IreoRvS7DW+g0iGIaL+LU485O6Npl96r3CCMqMVWZi/NpQ+UNxKVdNMSGLuh3X
 Qcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753391705; x=1753996505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwK8MrAzHvWkVEK9PD4qvKXKiY5LM3WS6woyLLh5kg8=;
 b=n8oNXnR/AKs4Yiuu3l5FrE0XFH8BtcSSKhirae2BSCITmMfhRlNR35MJbcu9rc8+jw
 QU1C6Qk7ZoftKnSXqGJI/Cc+6f5nsEywEZECf9zTNAXr47OJ2PkFyKWfttAK/7P5qbcH
 YMaL3LIptBelLXYx8DkMOa9/5YxvTofZmDULmz7tniMX5jgGVTgjQIf6pa3BxE4//Gqh
 b5WMx/r6pBEsME1CKxODk1pvWlo+ZiEdCIm9sqC/vshCJ5JS8eLrwL15Ru4UOeP2cAhH
 TglMUMBHJVwxZ7wbvGeUKPCPXZbh75cXVNM7+nq3fhlHYBRhq1NmhsUnMTar88ILj95T
 K24Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGZO6cXgzcf/kZgIAxseWB18VzY+2bsP1o2SRn/76qzInkkQbhUelsndqcSUD74T3yVkLLu+w=@lists.denx.de
X-Gm-Message-State: AOJu0YwTymbQnWOvDf7rCCmqhW1f/miTO06I3P02/z4PJ6WPVbZMjGiv
 BcpzRnSfGzNQO6JSjO36ktCnCoWhxWRRwOLGs79IGWEUxjFIhu8+3OkU3dVTczdCTT9ojgELT/l
 W5EMPYLp2/YhUsPuBPVGMJzBB/vQtq0s=
X-Gm-Gg: ASbGncuAqJ7m0vH36/7xwD7PNuidpowC/rN3Hbl4+zlEGIfNmZKE+lrhEZjPiF8thui
 TcbFPEAV/FxLq6R8NdNcMxeKHyHJ8Fcsv1LtCqdldY4pXniVeRQTzlTVgcf3wTJuxTYCrlR6/YB
 E55GMJ9DJCEwouLAozTfALWJIbgxiPmyoOwEElrXWPM9GXl9sybT6uQiDDCEEcYf3sAG6zLzEnb
 JahD+XNO+agRw0gyf7ibGScksH+PoouDr51r2I=
X-Google-Smtp-Source: AGHT+IFd7/shu5BtalNkAsgZBNvV/BSTM+1IOJ8hIfMW/vx179En7Fa/Y1t/8eokdpJGy2XRuiyaebqLoo7YGtgAL4Q=
X-Received: by 2002:a05:6512:15a0:b0:55b:2242:a9cb with SMTP id
 2adb3069b0e04-55b2242aafemr2005235e87.19.1753391705022; Thu, 24 Jul 2025
 14:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250716111851.1168897-1-primoz.fiser@norik.com>
In-Reply-To: <20250716111851.1168897-1-primoz.fiser@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Jul 2025 18:14:53 -0300
X-Gm-Features: Ac12FXxU4zfrdNyBRcQjp567dfjLbVGqwY5OFUfj4giB0shZui-0hsLsM0WjGcs
Message-ID: <CAOMZO5Dsn0Q4CFA7f8E_KaeiotCnaw_quk9jfroOKxmnB7iLXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] board: phytec: phycore-imx93: Drop unused PMIC define
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Wed, Jul 16, 2025 at 8:19=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.co=
m> wrote:
>
> Drop unused define for PCA9450 PMIC register which is already part of
> the header file <power/pca9450.h> since commit 1d0d25704345 ("imx93_evk:
> spl: update pmic settings").
>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied the series, thanks.
