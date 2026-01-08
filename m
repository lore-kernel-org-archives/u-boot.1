Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435F7D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B262C842CE;
	Thu,  8 Jan 2026 20:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nRTNiz5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D0A842CD; Thu,  8 Jan 2026 20:59:45 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79AB6842C7
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64daeb28c56so5486711a12.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 11:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767902383; x=1768507183; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2RFcjUL6AQN46cFSNlXRRS6afkG0aURY+KEu7Ba/ruA=;
 b=nRTNiz5RP9gZnbAhe6vMMn/Pfut16YZ6fr3Wgm/Ybmtw81bxSclaKKFVU+zw1Iej6N
 sOLnpH6UVYEQEPbZ2DJszfbtp/otCE//PfmUtpH50kbXGQXNJh0LfzMY9mpXKYVt3E4m
 V627QW3NX5YJx2XVl6kf6lhIwJ77leVEFWXo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902383; x=1768507183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2RFcjUL6AQN46cFSNlXRRS6afkG0aURY+KEu7Ba/ruA=;
 b=GZC+Uk3fg1h8ra3INLg08/o0orvP1qBXUkbWxrY70Jz6nyZDDwLzekiX3WAPlZZP8S
 xJcsGcCv6cktBw+exY4pMUqF94E52eJPTP4nhm/TKWaW8BDlMgRvs07+DYu8yJc7akaG
 neI257nHQUtCYTo1XVQRTuZrUMXd2c7li5mmM/747W29V7HZyx0lXao9CS/EUxQ6HXtT
 7eY81JlMaf5o1XLsvIGGoiUzhAoqE+SWXXloPT8vb1/pnM+ZzEx3Rd8+e0zgHa9no8zT
 Rx0VPDy5eBMF5yq2LIJvh8xE/RHJHoIbrl2okHerhUpucvBXJ9S9cW2u2vmlWLqKkr2+
 UUzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWM/YWr9q7FszWnPldMw/zqUYXbowFQXjrH70AyxgBXWoYEBMD5PTGnRsw/kEYEj8MvYt05OY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxjlf8oXTkleuWdaP3E4pnOIY+K2+U7F+nD7qWmelpVW1eWsJi4
 pVLvITUrXh4erXpUTTpP3KJISDzLR/lzho3wefAArGO7skacb6VGFR5Hp2ec1Fl+G58hNVS+NwN
 dm1jXISfNCAXRXbxGFlcQj4P4xk6EkjkyBCTOMDCz
X-Gm-Gg: AY/fxX6ESK7ODFNBg7wf/pecOetuPwlGBi/XXa7mwKO37k8oBrW6iff95ZuLK/IdYkR
 bXjCm4jeY04fduWHjKSGIOzXLPVS9DHnp8GVhtH3pXCMiVGUuVfNx2XLoJvnxvL6qwY3K57ezfH
 YXMpnkJRjL3DLPhJY9yvnymcKAI7bFeHCohCjxFAVeTJSp5y8SZI/jnSCi3pyoZvDOK/Riz4j56
 hq74yB9h1sLp/G4qTR+o0n7OWiOtm/AGygsxVpPRVm0/w9zEeElvRf4ozJuKBBDGJP9wA==
X-Google-Smtp-Source: AGHT+IFZ6yyY/vfTpdSHEO3t+pXVNKijv1jUHHB23XElEcblM4slA6S43/DhSJTLbmpKWtnAG0mS4ELxs6x3WmAHE5k=
X-Received: by 2002:a17:907:6d20:b0:b73:5a2f:2f0e with SMTP id
 a640c23a62f3a-b8445179e76mr651450366b.3.1767902382847; Thu, 08 Jan 2026
 11:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20251228164500.313817-1-t.preissl@proton.me>
 <20251229144813.GP710860@bill-the-cat>
 <CAFLszTjFP4N1v-=Uob+DRpG_Fc3szkt+yziG+cbLQ7nxaM5mvQ@mail.gmail.com>
 <20251231015450.GW710860@bill-the-cat>
 <20260108150025.50206-1-t.preissl@proton.me>
 <CAOf5uwnmzGeKjm0LqiRTokQWDxnXUGp71OK131kn+O9hmamV=g@mail.gmail.com>
In-Reply-To: <CAOf5uwnmzGeKjm0LqiRTokQWDxnXUGp71OK131kn+O9hmamV=g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 12:59:19 -0700
X-Gm-Features: AQt7F2r-nzvxLUBrwU-VtfSZie2qT3v1xhpIr0e0sOaQ7wbu_RSSBjFU3rY0zHU
Message-ID: <CAFLszTjxr6Wx9m8oD5skysJGh5UfrgEgwBZEqsNFqFD3LkQhBg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fix integer overflows in filesystem code
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 u-boot@lists.denx.de, trini@konsulko.com
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

On Thu, 8 Jan 2026 at 11:27, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Simon
>
> On Thu, Jan 8, 2026 at 4:58=E2=80=AFPM Timo tp Prei=C3=9Fl <t.preissl@pro=
ton.me> wrote:
> >
> > Hi,
> >
> > this is a gentle reminder for the v2 patch series fixing integer
> > overflows in filesystem code, sent on Dec 31.
> >
> > Any feedback would be appreciated.
> >
>
> Because you made a similar contribution , do you have time to review
> them, and maybe rebase your series on top of this one?

Yes, OK I took a look. These things are not easy to review!

Regards,
Simon



>
> Michael
>
> > Thanks,
> > Timo
> >
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com
