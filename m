Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8908FC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 00:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F9087282;
	Mon, 27 Nov 2023 01:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NJlUVxst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0364A874BB; Mon, 27 Nov 2023 01:44:18 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9296087282
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 01:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6cbccd8e35eso987652b3a.1
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 16:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701045854; x=1701650654; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Wbycj6BZhJyxk8ckCqEd/CPNUUDDzPMrKbHvXDZF7U=;
 b=NJlUVxstiZv4tWm9+CkL/Ob4fW0+VTEwYm6dE1N4Ze1dhjRUzfO6a/F2b7D9yxHLfT
 DskxvqMjm45LeAgPxCHvNIUQIupLaUT0jAXY86vZRk/DQ+euipLyQH5fIahBwoRN1B2N
 YSwQeB5laImbr6i+Mjw2zJCIhKGKIcCeyZnlnmJr/JnlpxsDvT5qcnR2fzEgyoAlO/Ax
 DO2vWHyvPJ7n7f5p6CSaNCBhy/hp7YBWPf0vaXH/szIMOwKmCYXXr24hwbMtbuHscGCu
 /9JnkQAwhrsR9K+p76LBER43oNT21svzpBYKBDuPJNYpKBLc78VcLQ2ZGUVK+jY7Bfwi
 PxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701045854; x=1701650654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Wbycj6BZhJyxk8ckCqEd/CPNUUDDzPMrKbHvXDZF7U=;
 b=gubf3fM8eqsiGNU2gzmAw/iZDTw981SyCaJkE+TI3u7oyMmIs5GeGAWaVTPxcz7N0E
 lNwYixD5DjDn7w1Gkcx6niGx5tabW7DeWGpYh3WdgGyXSgA7lCerCtWIa59cKFxt4h4J
 aXzd/cZKzLQc/+Ib/lcRqHSH0Ql7RlX/vF2J0i05A8dlFntL0ZFIYIVMtIEicfe7dhZ5
 0ddvZA+yZPPry8GK7pR9my40va9R5sKftmyPl4dOwwi4UckEjggUFSHcii53PHZhO6IE
 Gbfb54K/9UnN+sj/cnWo8eoTFoP/FCbzoWNT9WgPZH5jlY9233/IQbpiytSRyvndtV75
 Phww==
X-Gm-Message-State: AOJu0YzUJackgGEgdRDoQjZm/qpidQMlLAgKSM3+xNSaVkU/kaywRU0G
 bnNUx1Lm+G26qKt7+4ItrWCPoa7J2S28JpH3wfpdvHxvTI8=
X-Google-Smtp-Source: AGHT+IEnUyUm7WnEklafps5tQOzTptE93KxEKkmhDvl1GexJ5BPtpkdbP/gLCuZDSkHLDdxXpdi7KhsSSoIqA0dc9Vg=
X-Received: by 2002:a05:6a21:a585:b0:187:df59:5c3c with SMTP id
 gd5-20020a056a21a58500b00187df595c3cmr12083529pzc.3.1701045853817; Sun, 26
 Nov 2023 16:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20231107221617.470-1-egyszeregy@freemail.hu>
 <CAOMZO5CkU7onGbWrMxHZGG66pqrnH+VZC1qJofm_kvJkkVHaeA@mail.gmail.com>
 <A2DhwQ.Xeo2UIDvnEkI.pVoDCCvBPts07YOet4CT@freemail.hu>
 <CAOMZO5Aret8v0cEVcgSwLfPgsDzrLgXjiWXj5ue+SRPmJsTieg@mail.gmail.com>
 <A2DjDg.wGjnlX0ebNwK.yufbtwx5fVnuqjyPJYK@freemail.hu>
 <CAOMZO5BHkjOC54dc7ciL7y-tYPux2KKXQ8mOv+uObZsin1fmNQ@mail.gmail.com>
 <A2Exnw.dlngtJ5tNi9C.BApoDl5aKB1m6k9BCYZC@freemail.hu>
In-Reply-To: <A2Exnw.dlngtJ5tNi9C.BApoDl5aKB1m6k9BCYZC@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 26 Nov 2023 21:44:01 -0300
Message-ID: <CAOMZO5ApoA7+o_XOz04OLWpW-+hwhW-M9cROSbV1vADmDnydJw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
To: =?UTF-8?B?U3rFkWtlIEvDoWxtw6FuIEJlbmphbWlu?= <egyszeregy@freemail.hu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
 "sbabic@denx.de" <sbabic@denx.de>
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

Hi Benjamin,

On Sun, Nov 26, 2023 at 8:17=E2=80=AFPM Sz=C5=91ke K=C3=A1lm=C3=A1n Benjami=
n
<egyszeregy@freemail.hu> wrote:
>
> It can happen when will -Wall be enabled as in others SW projects. My pat=
ches are final, ready and works. I will not remove this "supression", it mu=
st be a part of it if the target is to provide code in good quality. If you=
 have any further whishes you can edit my patch and you can be a co-author.

Sorry, but this makes no sense.

You are going in the opposite direction of good code quality.

Both U-Boot and kernel pass -Wno-unused-parameter.

It is common to write codes for stub functions like this:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/inclu=
de/linux/regulator/of_regulator.h?h=3Dv6.6.2#n29

No (void)parameter is passed as you did in your patch. Like I said, it
is unnecessary.
