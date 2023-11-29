Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55771C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB0EE8773A;
	Wed, 29 Nov 2023 19:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k/RiFAdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35047875EE; Wed, 29 Nov 2023 19:17:29 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF80887550
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so7359a12.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701281845; x=1701886645; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIYk2XPpfsgI/s7QoRY1ahdYx/fFJMmevf0HzIZuyU8=;
 b=k/RiFAdutv2AeCwG6mHVTFrtRwXSEQAm/FR0knC52hfu3fJBWnwvkbAp68DxOKWien
 XBx70aFkND3MRQYkFFjjwVqi4JSkzUu60Koby7lgT8AfnK38bgJJ1YYDoF8FvzZ/Jwgd
 dAl5G2caqLHqIi/X53pDIVvaOybNjxMkAm/DYBiv/iHssQK0P+M5UXM+NjU0zF6b66dB
 fd28wGhEKHnfaacXO/GbbeNJbqf6yAWDOF85OXO1gzxFsXP95oYabNr/zcwuF55OYFOO
 Dozh0w4vpdpBTiPtheIsIqF/2kGNgugIr/tqL2x48PyiGCO+tLxHuOE9uNoDzfYMiWLD
 7drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281845; x=1701886645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIYk2XPpfsgI/s7QoRY1ahdYx/fFJMmevf0HzIZuyU8=;
 b=sLgmovjTl0w+UrvcOM+LUh3qW241MPGG9+L1ASbnv24cV42z3h37gjYWUSzVRZHUY/
 nmxmwBv6XMvkpcZh0iqrStqhijQ0z5ejzuFH4JOTb4Y9d9QDu7uMopUSAcSzwdM5nJdm
 HJLiiOqce1LETtHLwTiDmQMRbVOpOZIxiZghtpvZweUOvt6dRZURbRWH8ySG8Q8P8H7c
 oeDg94mS7Spba0g9DvVn2VSHz4RNP6X6bS9HrJkVzK03G4Bqjgd4MbX+AtlQXmr6zE0z
 2F5YemhLyBkppHJYlZmuegp3OUqVoEuzk1tNgF6jRLsHFPxroTEJBpn5IUUlShkSloaK
 H9Ng==
X-Gm-Message-State: AOJu0Ywt5A+EisaEErvjXGU1SaIopaikgjhbHAolvwq7p7AcCn6fJZlH
 pcROCzlwcvlq+LMFYcyn0tiFJpaogcd9VDrV6Po=
X-Google-Smtp-Source: AGHT+IEnH6eEz6qE9mphB5bQyZa8Mc+1ob5irerH9Tzy2BSS+zqK4xfGerJXukXcelpvLdcHGpBvvXrEk3522wshlbI=
X-Received: by 2002:a05:6a20:728c:b0:18c:19ac:d771 with SMTP id
 o12-20020a056a20728c00b0018c19acd771mr21527180pzk.4.1701281844895; Wed, 29
 Nov 2023 10:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20231109162401.38941-1-hiago.franco@toradex.com>
 <20231109162401.38941-2-hiago.franco@toradex.com>
In-Reply-To: <20231109162401.38941-2-hiago.franco@toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:17:14 -0300
Message-ID: <CAOMZO5AkYRB5PqiVKCK5PAiv=a+QfYwuFaHveJyTUiKsYSqk6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] apalis/colibri imx6/imx6ull/imx7: defconfig: Enable
 fastboot support
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de, 
 Hiago De Franco <hiago.franco@toradex.com>
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

On Thu, Nov 9, 2023 at 2:44=E2=80=AFPM Hiago De Franco <hiagofranco@gmail.c=
om> wrote:
>
> Add fastboot support for Apalis iMX6, Colibri iMX6, Colibri iMX6ULL and
> Colibri iMX7 boards. Remove CONFIG_FASTBOOT_BUF_SIZE from
> colibri_imx7_emmc_defconfig to get the default value of 0x7000000 instead
> of 0x10000000, to make it consistent with the other boards.
>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
