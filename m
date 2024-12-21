Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F3AE7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 17:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A8F80562;
	Sat, 21 Dec 2024 18:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BIoeDOce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526128056A; Sat, 21 Dec 2024 18:30:31 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43956803CB
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 18:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54025432becso3083282e87.1
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 09:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734802228; x=1735407028; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjFvzUr/vfNrC/Mr9fyrd8CCMOeDma7eQ25Q0CNpCaE=;
 b=BIoeDOceIwPhPTPqyXu46rp3frtJFnwaRndc6wwRqmpuzwAXf/jwyMJu4W5Vt23Q9G
 PU8DlCMg/aFtHboi/N4DSRv5cmVU84aye+DjgpU3oYQuXJr5JveUjg7jBUXmqOfETN5H
 pwil8m8dVf0KycFIaWeRLrGNgxVc1d74CnsSvQzbJLtc+PqRARy8GhHFYGWHkMSG/PBU
 d2VWv4cq08WCrLvrySYgva77Smf7rofZxpaHKplF6NCQAAP89sNfHfapWgCZLu8QbxiE
 DoqCwDbVZp0bpJ+raGuX6ELAmh/zvjQ2p5Za5sd0O9ZSLPzmFkO4duuCP9toGbIaQ3fm
 RfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734802228; x=1735407028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjFvzUr/vfNrC/Mr9fyrd8CCMOeDma7eQ25Q0CNpCaE=;
 b=eC/eIYN4CV85ZdPHdv/L8Z3VNkwVWw7v49P0shCkZko+c01l7adcNx3OMkr08+Q5lM
 A9rN8J0qKwq0f62GA6TkJvXZw1QsFTiqZ2cZlbmveDY8mKkzNzR76j2vdQyExSj6CqFz
 Wgue7z+oO25nfG7fmtfGiu2LWdzC3eEeccl+pX//5IydBmxY1X3hTkG1cFxoGv3d2kj0
 gRSe6ZXsnB0AmSk7u39fMQw3gH14601zQjFRLEZO+3MgdQJQnqkILvlj/bm8dMaEiOVN
 8eEK+zCt8JTUJ35PjCd6V8/FFhdV/V0bg3qBaR4t8d/MbOizzeX4c41bFV0z/tiRGZ6w
 EjPA==
X-Gm-Message-State: AOJu0Yx1CeyTqWqXqw2Hw6lCAN+8OcRJ56KRxb/2oWFvB5MNsbHcLEo2
 cfhdWo9IXSbGaC/moXuPMB9UhzQDQpL9oEX/+Uvno4VJq+5zrpPPvhFYAcTXZcSBDn0eta7OyzW
 nOjggRZhyd08EwwU+n8XTM229Rmk=
X-Gm-Gg: ASbGnctrJXoOg7hiA0HMPH3qANrIpIfbTwcQfrHUE3JsLOh+7kgtG0x8jEahg13we1E
 aPvQ1OZr8tARckQLsFVruP1UNVaPwlsdDB6PYHke4Izsih4JRnKy5nUFCww+d8iJjBhUc
X-Google-Smtp-Source: AGHT+IEqgjUp3vB/PJjOaBbNtyvodMXVKhqpYPg1T1fdGxp1+yuI6pToRH3HHK6FeM/Va0NdP+a194WZfKq28W7xWEc=
X-Received: by 2002:a05:6512:282a:b0:540:22e0:1f63 with SMTP id
 2adb3069b0e04-54229533ae2mr2019857e87.19.1734802228201; Sat, 21 Dec 2024
 09:30:28 -0800 (PST)
MIME-Version: 1.0
References: <20241220090919.2186070-1-Meng.Li@windriver.com>
In-Reply-To: <20241220090919.2186070-1-Meng.Li@windriver.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 21 Dec 2024 14:30:17 -0300
Message-ID: <CAOMZO5CAubaRBmGEFP7RWiZ_RUSFfROxo4VCv4imTzr3M6B_Zg@mail.gmail.com>
Subject: Re: [PATCH] net: fec_mxc: add DM_FLAG_ACTIVE_DMA flag for FEC network
 driver
To: Meng Li <Meng.Li@windriver.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 trini@konsulko.com, ye.li@nxp.com, peng.fan@nxp.com, 
 ilias.apalodimas@linaro.org, jerome.forissier@linaro.org
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

On Fri, Dec 20, 2024 at 6:09=E2=80=AFAM Meng Li <Meng.Li@windriver.com> wro=
te:
>
> From: Meng Li <meng.li@windriver.com>
>
> When FEC network card works as the prime one in u-boot, and is in
> active status, kernel might crash during booting up stage, especially
> working with grub. Because the DMA of FEC is still in active status, and
> copy data into momey if there is network data received. In this case, if

There is a typo here at "momey".
