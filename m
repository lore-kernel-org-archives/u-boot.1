Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7992C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 10:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5C1E82C8A;
	Thu, 17 Apr 2025 12:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GMbII6G7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ACF182CD2; Thu, 17 Apr 2025 12:52:02 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C80AE82A96
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 12:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-308702998fbso536556a91.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744887118; x=1745491918; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tj8ryDEvTSEPGIHR+bO6Yb/X7SetxJbUVs4oyzVtvuY=;
 b=GMbII6G7hNp0vmDVV/UYTqDp1DowPSCv/9TEof3E6hs+9YF8fv9PqTLMpJ5OnMmuY6
 PmUIWmzCBPjxdBQRnZQeCnrljhVQ/rdnW0ciwNIJgEtpCCFP0xqRGm2pjEUb1sMUCSSc
 T8JzMM0oCM2g77WZmscKyAaxsmetuNVdKNnhzuH32mhgYtDpIXzrKIc0g6dC+UtjZHD7
 XbUhPUiOK/UxM3RmkLk1J83ppe1Zd+4HHSlAG2Hd6+1NVB5YnmXwvaYz+/xhuHRouWM+
 6UEU9cZc5WI1doeFbswvXgK8tunXo1+u7EDV2lrFZU2RKSSkon9ZltYGB7m7Jtgytk6D
 T/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887118; x=1745491918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tj8ryDEvTSEPGIHR+bO6Yb/X7SetxJbUVs4oyzVtvuY=;
 b=mFlKVrQLE8aum+sFCHyqZcB0CmLnBaNSjivJYSd376CzflWhKBYfAnNef4CV+uGskl
 tvH8pwcQxFpu5ikUiKZA5sj+OYTHDC0MX3CMubnd1KpZ7P2qYa8Wc8pnGrlHwVlRY0q8
 iFqPG7ZMQO8TGOJVvdj0fHqMDMO1uUWJUARhwiP7pOetuFAy2pEK7XKgHgAMeORstQnS
 UL4/solnsTWNWaSQvnaEEgt1hIORX4FlVP90ZCFOcxuIGQBuCrhKbLHbT9c/L96GjEne
 euuTinfT5RtL4sbmcDdanYs8roWWNSTwjmCRe979oZI5zc7HV9c2CWDvB98H8k2T2MG9
 2ZAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcdQ4M3DSbQV9Ov8/+jIb//dw51sm+ytrFkNmX7mc2mKS/7liVe+v39zSEyGbRL+hPXST8eFk=@lists.denx.de
X-Gm-Message-State: AOJu0YwWW9MjdFDBsxbgYvJtYWv5T6tFocZJfGr8xAJA6LfOR/Uu1oCD
 4HoXa55vzn6cXf8w3EnBjlFwIYDYcyMQYaOFTP/8JixDCprJQDxSqDG7ZqOP1KFl4lQHwHZL6YI
 fhZuUYv4EHbk8UPVwn18qgbfOLP4=
X-Gm-Gg: ASbGncuLcQCmGxh7Kd9Xz5pdvS+7D/NTDp7TOo6v/kb09zG4yElzPwHUADv3XJUc3hV
 G++s/mtdzIN0FolRi7xOLjgoCKBqSdLZBfwJtHq69sFV3SSqzQWSBYOWOMysdrqCTI6MdEzMH42
 8zc55FyVDZCZQpfi85k75Tbg==
X-Google-Smtp-Source: AGHT+IGfoox65eScwxlpHsvqNIWfcZ7G4Fpvn+jWHnmTNVL9WwnVFvhexBxicACdU7kgrxoDJknsBohZKN4rvfkR8E8=
X-Received: by 2002:a17:90b:498b:b0:2fe:a336:fe63 with SMTP id
 98e67ed59e1d1-3086415ea28mr8259781a91.24.1744887118106; Thu, 17 Apr 2025
 03:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
 <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
 <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
 <20250416092639.GA24345@francesco-nb>
 <db2d623afd944df2bca6d1e4657d4031@dh-electronics.com>
 <CAHCN7xKyoBQPeXDA90-kcBTw7BhObvn6PVzreoUQ5+GjiCewyg@mail.gmail.com>
 <CAHCN7xLgS7FZ4ajbBa+p-_w_s6oHnfMYcZEMsNBNkqkgAG-7Jw@mail.gmail.com>
 <b35218ca-df17-4423-9932-a2ad0ba14e50@denx.de>
 <CAOMZO5CA0_GUr2uQtQgFHe-9wVDCOQwo5HZzZ4sibXEPMpe8cA@mail.gmail.com>
 <580024ad-b22e-424c-a1a2-84dcdc6d24ff@denx.de>
In-Reply-To: <580024ad-b22e-424c-a1a2-84dcdc6d24ff@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 17 Apr 2025 05:51:46 -0500
X-Gm-Features: ATxdqUGQrG_7Bqt4nkH-YlRo8oGk-jN-0zvEmCReoPWg2bx8GsEeRsa_6BhOLVA
Message-ID: <CAHCN7xKvdKCnU-PRuGiNuDG9hGuk1Ea=jGtsuGaHd4CCxQximA@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Francesco Dolcini <francesco@dolcini.it>, 
 Fabio Estevam <festevam@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>
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

On Thu, Apr 17, 2025 at 2:24=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 4/17/25 1:58 AM, Fabio Estevam wrote:
> > On Wed, Apr 16, 2025 at 8:47=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >
> >> You are not supposed to use "clock-output-names" for clock look up.
> >> You are supposed to use "clocks"/"clock-names" DT properties and then
> >> resolve the remote clock from information in those.
> >
> > What do you think about registering the osc clocks like this?
> >
> > https://paste.debian.net/1369857/
>
> It would be good to include the patch inline in this email, not in a
> link to some paste site which will go away.
>
> This also does not work in case 24 MHz or 32 kHz clock are provided by
> something else than an xtal , and it will also lead to instantiation of
> the same clock twice. The clock are already described in DT as
> fixed-clock , there is fixed clock driver which binds to those clock
> based on their DT description , the problem here seems to be related to
> the look up of those 24 MHz or 32 kHz clock, not their (re)registration.


Since that patch changed the lookup of the clock name broke USB on
multiple boards, I would like to recommend we revert it until a proper
solution is found.

adam
