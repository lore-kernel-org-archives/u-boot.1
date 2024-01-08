Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5B4C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 12:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A61D387A78;
	Mon,  8 Jan 2024 13:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lJNp8Brc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3093487A60; Mon,  8 Jan 2024 11:59:23 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C7987A4F
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 11:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.othacehe@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33761e291c1so845419f8f.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 02:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704711560; x=1705316360; darn=lists.denx.de;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P1h+WYQfmOq794z2lbE/qySeX0UCLz3tlFUGqCAKGMY=;
 b=lJNp8Brcop7+RJ93a1Sq7jSyebdNI8I29EP08Yqwt50ZSfRtXwQcjazkTnc0zC70E5
 IpvOHPLGVOYE9lzPjkU61VDz2hdTM2VFkryY2c8x7T9xctpywwKs/lXbqxOMG3E6ebjH
 FxFAlBckkjPteqxzNa0C5zytXIIShIl0HLkOwiX51q3rClOyap9TrMy4yajadfwuqFaK
 zitN6jQy+j9VGr7bTZcsg+xSZtvXz+QiqUJ0KKTrKjouTdyRi8ngC3bTeyec3YsUBMdn
 SfWZTqSckKnXoD0M2SPh901KV4/h7GRElQiwPPd4GGUMNRzBaiFYzyJ/Mkhyery/r7h7
 IjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711560; x=1705316360;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1h+WYQfmOq794z2lbE/qySeX0UCLz3tlFUGqCAKGMY=;
 b=uwIXDRK8VUB930ESJuKFGKHr6dKO5peXJAepshfSAdid0iHCrlWw1p97HKiqHSF762
 wSo2ys/0BU9bSV4408tdpMfbd+7VviZWYOnc0bldh+dcvim99YccJbjybC3RaoVjOyZi
 yrtb5XWlTCpkhF/OIbuK+r7wsCLrhyTYA1G/o6WlltkWSTDUOZZWIqz+Ojjvdvh1wSHp
 OMblBew/agUCX5N/erBucHs0ca1i3hoSqMRJy78/2cHVrWe17/ZL3jfxRW6oaLci/fpm
 cVFAi/pdRCtSLaMnsj0EIkROp03oUrDRnrMLYFsXt5R+T9rTpW67cfVrDpB3O5AA05XR
 ajKQ==
X-Gm-Message-State: AOJu0Ywo7YQs16e/ZfFDIcKtYRjxJIDS/djFLcXd1wm7N8iK1zBSrf6h
 +hZUEqZA1FgsC6eXxfmrethAxDLuLao=
X-Google-Smtp-Source: AGHT+IEhe3Z2r+lAcWRmmZYK/T4wBqiAt8qh7j0qyo8f1NsvdFdUwC6SBdTcLvh7gNWXT91q7q9Rnw==
X-Received: by 2002:a05:600c:511e:b0:40e:4317:2312 with SMTP id
 o30-20020a05600c511e00b0040e43172312mr1258672wms.9.1704711560227; 
 Mon, 08 Jan 2024 02:59:20 -0800 (PST)
Received: from meije ([2a01:e0a:ab1:5c70:ddd3:fad7:e5a6:7e01])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a5d5948000000b00336898daceasm7501961wri.96.2024.01.08.02.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 02:59:19 -0800 (PST)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>,  Tom Rini <trini@konsulko.com>,  Stefano
 Babic <sbabic@denx.de>,  "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v5 0/3] Add imx93-var-som support
In-Reply-To: <CAOMZO5CyqnaqqWpcLQZXPYXiSYbtzLzR+7k10NC-LZ2WA7P4iA@mail.gmail.com>
 (Fabio Estevam's message of "Mon, 8 Jan 2024 07:30:26 -0300")
References: <20240104155357.21865-1-othacehe@gnu.org>
 <CAOMZO5Cw3WE5j02GmFpGB7z4-LBA7Tne7X2TG=riTxpYvJZRuA@mail.gmail.com>
 <87v88489b4.fsf@gmail.com>
 <CAOMZO5CyqnaqqWpcLQZXPYXiSYbtzLzR+7k10NC-LZ2WA7P4iA@mail.gmail.com>
Date: Mon, 08 Jan 2024 11:59:18 +0100
Message-ID: <87a5pg8515.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 08 Jan 2024 13:10:24 +0100
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


Hello,

> I will also wait for the Gitbug CI job to finish:
> https://github.com/u-boot/u-boot/pull/457
>
> Also, it seems you generated v6 against U-Boot master instead of U-Boot next?

Right, because I wasn't sure CI was working for pull requests on the
`next` branch of Github. It looks like it is so I also created a PR on
top of the `next` branch: https://github.com/u-boot/u-boot/pull/459.

I should have done that in the first place, sorry about that.

Thanks,

Mathieu
