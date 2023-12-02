Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8E1C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 02:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7BC875CC;
	Sat,  2 Dec 2023 03:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WG2ptt7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD97887600; Sat,  2 Dec 2023 03:28:04 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F2A875CC
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 03:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2866b15b013so58211a91.0
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 18:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701484080; x=1702088880; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2XVcuKfVOKd5xmFMrbZ5JOPPdL1pDErg81BiDnKYH0=;
 b=WG2ptt7jzdYNKi7iPDnLgsh5rMM6a1w6P+Tas9hRjPqq0iJUcWJ44WmXppemS9HF89
 bJD/zvOGW55CLPLPKtyS+wury/y9XWRcZExHkCS/TKu6X5+CKtbVpAZTiFPchWs4ZWaf
 ZL9XbFJJeYkyU5kbJhrK2OrXMSoLxD8OLxPe0WFDVMFJVXS26N6I0XoOar6qL0HyqeEH
 Grxg2e/GPRvVhpfPpNeVMIHhZWF9BOBbmZxOyHsrVTdKhyfe3Eh+5aJyNq4r1bFra/K5
 1gQsZHOsQh9CLNcKNKE1dhbYB3nF+6aFDK2PtJQ6dWLiH5Pijg8XI+yohRNvq6BLs6Es
 yTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701484080; x=1702088880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2XVcuKfVOKd5xmFMrbZ5JOPPdL1pDErg81BiDnKYH0=;
 b=e9/3rmeUCl4NcPoJDamqGdC/2zrJWYyPE7SekEhQzRlbvw4wxwMpEbu+OhyY7KK6OO
 9urqArvghL3fOWn/edfNZ+BEVPcvZiwcD9XmT9WoqYuB6iiDDvHvh57eV/BQpo5B6dgK
 fYLjp6WK+7GUkmxUMn8pbsGXQOEr8Y/DIY9nrl9id5am6NusZg/Wa63UEwchP56Q1Oxp
 iNjNOtsEBQAXFnXLigQdaauAN3eD5lI+N87pwMttCgve0mkUkIoZzkf20eZBFuahmUZn
 Z4LS1Nb/Zvml985inFeljD+11UgTVfsyC5MVQeCiE7UmK8+6YXX4H726lS/qJ9d7RVSQ
 KYKA==
X-Gm-Message-State: AOJu0YzfcLhtU4igEkLG1//hzvLTsQS+OEkMnUoffs8NlWALa0LysbnS
 f0mCqsbdoWnRaW9iUvg/fz3eFhn7L9pyiadv274sRUVH3LA=
X-Google-Smtp-Source: AGHT+IE+Dki31sCYqGV7w6sef+GbenEpnHVw3qZR5rOf80lMmw1CJVg0iALU10pkvXUj/5AjwJT9GTyq3GJWDzMd2XA=
X-Received: by 2002:a17:90b:2b48:b0:283:2fc3:b8ad with SMTP id
 rr8-20020a17090b2b4800b002832fc3b8admr7074553pjb.2.1701484080697; Fri, 01 Dec
 2023 18:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20231202014906.212885-1-marex@denx.de>
In-Reply-To: <20231202014906.212885-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 1 Dec 2023 23:27:50 -0300
Message-ID: <CAOMZO5C1MoHfOPwJWjwY08PL2Us3tqGyroVpW-44YcoO9vw4XA@mail.gmail.com>
Subject: Re: [PATCH] ddr: imx: Add 3600 MTps rate support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic <sbabic@denx.de>,
 Ye Li <ye.li@nxp.com>
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

On Fri, Dec 1, 2023 at 10:49=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Add PLL settings for DDR 3600 MTps . This is very similar to 3200 MTps
> PLL setting, except the divider is not 9 but 8 .
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
