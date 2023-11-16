Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AB9C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 09:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5A3387465;
	Thu, 16 Nov 2023 10:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JGGGEcYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6252086A0A; Thu, 16 Nov 2023 10:42:09 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3113C86F32
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5bdc185c449so467063a12.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 01:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700127716; x=1700732516; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LuXfMlHjCf4lOVRMkBO+wjq7XvkVpUDyZj6tiUhjlJc=;
 b=JGGGEcYodPAHyybonh4kr5cRoQV8quUoQQWWxVhx2sPcD/bHP97zn6JAcuzR+d5XHT
 cVkKGayfbLPrR5xJAGhoZMCnaIltSdpOFNnQk3YabwAfTi0yiUMEnSjNUmxKgnfiTUo/
 aYbiYbqC42NLw86v9dXefo3jSmFi/WXPYfHE5YcfgJqRx/nsV66MRLb42pBzUEwvJEq4
 Aoss/Gta597LFd3hY8i9RfZU4cWJBOrwBaJVSyrecuCfrUK1uWP1dK0cHvkgrVAR29fr
 Vbc+ZbnRLIoso5SrzEbijhzq09b3SEGY4XGBgKTov1o7+PJdHGVKKI6fWaS7l3ZehmOQ
 isSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700127716; x=1700732516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LuXfMlHjCf4lOVRMkBO+wjq7XvkVpUDyZj6tiUhjlJc=;
 b=rniVmMSBPHPbto/K2WBN59dNwE48n75harHl3xbXr9RpwdEqZBhKsvWEky4j3CVzAK
 uC11MwUCFdqjPmUkMz+cTi0XB3WjqPBCQ35ycXRPSHwwQkiZpAmix+lyzbDg9+an86uA
 XqIo762D/ESXh9aaL338OxrhsShosHn0OOJ784MdnS/Wx5e/qM8iA2LM7Rgav94c0n7J
 DP34WxjpwsqYvcRqv7VEjsrGl0qqP/AJuJqLxpShWOqnY19tC/zJPvPi8vhkl1LsEDy+
 7BLNytbhVXgmlEqInWkvw47E1FHf9/A9tHriyjTJsoKK0E+2pvziHglTYvKjP63Eik+1
 2Jpg==
X-Gm-Message-State: AOJu0YzheuQlceYxdJVLwp79aHqnXaewAj5xi9OOXKQ79AAJhG+/v7jl
 iov+sdLLhX1rU9HWXkCLCzN+Njo82tRiOfwuuOrELA==
X-Google-Smtp-Source: AGHT+IEefi8aH1G8h0HKSIN1aTi5LVmTx/SvicHaUY6Y3xn/2BhP7yl6M6OkJIuuxJjKi88fgzVyBR2IOexRzUbuxAs=
X-Received: by 2002:a17:90a:1a11:b0:280:6d53:f5d2 with SMTP id
 17-20020a17090a1a1100b002806d53f5d2mr12369274pjk.11.1700127716414; Thu, 16
 Nov 2023 01:41:56 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
In-Reply-To: <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
From: Paul Liu <paul.liu@linaro.org>
Date: Thu, 16 Nov 2023 17:41:45 +0800
Message-ID: <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Marek Vasut <marex@denx.de>, u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Fabio,

Yes. I'll look into this problem.

Yours,
Paul


On Thu, 16 Nov 2023 at 08:34, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Paul,
>
> On Wed, Nov 8, 2023 at 10:24=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
>
> > I was not able to see a failure when using "tftp" to transfer the same
> > 420MB file.
> >
> > The number of bytes transferred and md5sum always match, so this is a
> wget bug.
>
> There was another user who confirmed the same issue:
>
>
> https://lore.kernel.org/u-boot/CADQ0-X_cj1ECn67U3sefcZ-Jm4OBSYmZkA+JaZRCa=
3ekq84RaA@mail.gmail.com/
>
> Could you please take a look at this bug?
>
> wget is not reliable at the moment.
>
> Thanks
>
