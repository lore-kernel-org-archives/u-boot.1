Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6338C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 19:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D5A287142;
	Fri,  5 Jan 2024 20:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CgeQzLXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1561C8749F; Fri,  5 Jan 2024 20:53:46 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B73E8795E
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 20:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so342469a12.0
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 11:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704484420; x=1705089220; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arnH2TfOBTrALyRjBpFwbrDhQIwvciOQ2cDF4K5CeHo=;
 b=CgeQzLXWi+3WAt5xAWpeYiX5LTLioi8enBzzHzh4Yie9x/zFrQZXAq68Qf6N1PaI+j
 nzNBjhvxMZk+4cX2dSQTzwZD/lnFZhQiB6DNDZHsnmFlHEWhSCnYD5IOymUNe2AwXf6V
 b+99z4u2KNjbOKO9XNB87yR7vPfsmbzDDo2HBwZuud+5Z36y6blhuJZdOTrJ159vWQzA
 LUsBvV0h7H1IkjPb6Oos9C92Osk7kNT/xxvvkYpv1RcanzZMEcsZSuLwF1h4eDJLYMtq
 K6wGwngEisnGyKWpF4gthf50eMLQokUoLiHiWg+Dx935FqSj2YwlOXV1jfNCLG9i8ajG
 PiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704484420; x=1705089220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arnH2TfOBTrALyRjBpFwbrDhQIwvciOQ2cDF4K5CeHo=;
 b=rRNmPXiV9K4ZaC/61o3Iwagx7b6rcZD/PlyvkuVPHYmXVb1fjdWP0xV3JfchrwwPBQ
 /3O6Sf8znaPjHTH78h96UjPohIUde7JVjCtFt2qGtJByTQROBZOVe0u+j5w6x22b1MJr
 /Uz6NZbki64Zl/u+Z700gsjPQM4M3lLMGico+lb2HV8eAG2WUtS4lRkS6wsr3DgHWcdK
 mIzveQ+yOHJt5HfRQn5Azm1FOLimXmPsUfkE7JsEHA2pRfYKjf4So2IHIPzt6Z6MTQbj
 sAW9EOb3PvJn6DBU1UWjyCtdIa1p7251jJonTaAtn6rUfJ7CgKyu8MAv+sFKBr7f4H8y
 q5QQ==
X-Gm-Message-State: AOJu0YyyAdKEs2Q9HOBYi33RebdNPVwbxZxvIjcsHUJ737W3IEOHgt6M
 1zGIMSGPGVd+dUYh3t2LZrG5hHs7/CApwVFXPSU=
X-Google-Smtp-Source: AGHT+IF/SJ01OUygWDDK7JkMFGFMCoVWnHLx4nfXhY1YDzInHb+gkYuOkdwWZfEHYl9YKdxXiFQ82/gO1YaygHPe2GE=
X-Received: by 2002:a05:6a20:96d6:b0:199:428f:9a61 with SMTP id
 hq22-20020a056a2096d600b00199428f9a61mr2067640pzc.0.1704484420569; Fri, 05
 Jan 2024 11:53:40 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
 <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
 <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
 <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
 <CAOf5uwmDZ5DtAhe-GauhuyYwSSXQnavVNfzaJkdSG3TWE1N2FA@mail.gmail.com>
 <CAOMZO5DtCDe-VzY1yx2f+LTz0tCqmtiLemrH=xTnPQs7=07aSw@mail.gmail.com>
 <CAOf5uwn1LuN6uFQe9d7zXWDFnvOAqwb-etQow96fzAR0qim5Hg@mail.gmail.com>
In-Reply-To: <CAOf5uwn1LuN6uFQe9d7zXWDFnvOAqwb-etQow96fzAR0qim5Hg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Jan 2024 16:53:28 -0300
Message-ID: <CAOMZO5AqatVOGsJGwxXJCoF+tBemrfM8+pgrRCvDwHNHv1caFw@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Paul Liu <paul.liu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
 u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
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

On Fri, Jan 5, 2024 at 4:49=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> I was thinking that was lwip integration

That's a different issue.

If you want to test lwip integration, you can try it from:
https://github.com/muvarov/u-boot/tree/master_lwip_test_v10
