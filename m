Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB30C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 19:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5796A87967;
	Fri,  5 Jan 2024 20:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NgK7+V3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ADDC8796F; Fri,  5 Jan 2024 20:32:13 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9293687756
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 20:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2866b15b013so372470a91.0
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 11:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704483128; x=1705087928; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9ytFEzQdO+npSw6FQI1EDoxUtdvL3RzDcRNPnwF9yU=;
 b=NgK7+V3LZgcPuhBjv9pimgfxmEAGOXE0vt5UblXbF/xtG9o6SQ60w7ZnHFqxokiqVO
 LJRASZ9AY3r3DaCJz2xnuVWdA1aT7el+Ix2oNqukacldDxXoDqvPijX/POd5DMrVlwHQ
 R+66z2MRhdZhEWxzgenLXGtixXnChNC8i3PGLfCdq0qbYkZwbNPkl0zpdkco8srUWd9c
 /lZPPvvF+du5u3BmNSdAVzjC/wCKak2sAw6IywXChbNKjo5VNV8I53/vhx4vk+MyABAl
 mDz9i7cDj6w0wL/cPp29Z5JSO/ctNEfV/jE0gDzGzj2eVvqlyP0fwAk8xg56ib5fGrqt
 Jo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704483128; x=1705087928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S9ytFEzQdO+npSw6FQI1EDoxUtdvL3RzDcRNPnwF9yU=;
 b=t+wMncESvUotyTtrbpnK+yAPDizcLlMuEG9cjmj6/3XdJfFydluo5Zztm41ODEBshy
 fa/JJZvmFdcCjxz4qj2Z2zJ1VONUkkv6E+/JoJlHKvw/mEgTtozbeNEZxGgmOBdNK0AF
 W7Gyvl4aQyBJafeMfmDcTPpV0R1qewwr37qWOqWHLTWa21rOOeAPuWn+IeS8ujGFH1yj
 qIKW+BZ/zvfe9pSSYe7YSfDLG2XArDoGI6NsO4Vn5/lC0vIn3SXX+zG8kMu7pegRtDPs
 fxUmCOgsCkypSmHerLo1DsfIKIVYZGeLQ5DyKrKMCUihggyCH7bLb0yEul44blQGYHqb
 3nZw==
X-Gm-Message-State: AOJu0YzPZlDIwlnscZ8IOAPCifR+xsIhRjK94Yj7XwrCbsERKZXsgiu/
 vTCGvrgjdFPqufqgqIoB4Muk6YoBdfLJp3yZIgs=
X-Google-Smtp-Source: AGHT+IGwXZF9GBYcaKktwPZftwxo73AJIKSsTFnjmqqUS16Jh/nyLd1x2cz46wqMHRVhzkOuoC+hdsHCpeKhnpqgvyU=
X-Received: by 2002:a17:90a:b007:b0:28c:fe8c:aa93 with SMTP id
 x7-20020a17090ab00700b0028cfe8caa93mr3654844pjq.1.1704483128367; Fri, 05 Jan
 2024 11:32:08 -0800 (PST)
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
In-Reply-To: <CAOf5uwmDZ5DtAhe-GauhuyYwSSXQnavVNfzaJkdSG3TWE1N2FA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Jan 2024 16:31:56 -0300
Message-ID: <CAOMZO5DtCDe-VzY1yx2f+LTz0tCqmtiLemrH=xTnPQs7=07aSw@mail.gmail.com>
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

Hi Michael,

On Fri, Jan 5, 2024 at 4:12=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> Can you reproduce with dcache off?

I haven't tried it.

> Where are the patches to test?

The wget issue can be reproduced with U-Boot master.

No need for extra patches. Please see the first message of this thread
where Tim explains how to reproduce it.
