Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02960C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 06:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1475C87868;
	Tue, 26 Dec 2023 07:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ztvl3BZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2796387863; Tue, 26 Dec 2023 07:18:25 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFEDE8771E
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a2358a75b69so720206066b.1
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 22:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703571500; x=1704176300; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Oy3BqLBXUE47jtWy8QC+hrav0nilmoQkCVpcWC/5UeY=;
 b=ztvl3BZd0mj7Ho7c6NfuTAcY7YEzsucjVLsQm8fysp+cdULdmOkuIT2DFn7HI4EEC8
 Gsj+/AbcHRikHZVkehdiP3TS8EJgWIhr6ZXXOyaChXm1qczIJau9dJRS7rlXuFR8GRg1
 MvBDtOBibWJGKxCfGnp0BoxNF7xlr/ycXfsb/upS0NON8g5jH3v0IMjiNc9eDW+apB7j
 7WUJgl/GrYE6QZY6HMBBGWVvP5HVI84bjd1iX/wYejkNo8LnX5KsqD0HtSXc5AUKk8Vt
 EFobjA26ecXJjj5moxktZOW7vawG851+5JeUO2KN/ZuRKzSB+0/h+1va3TPxP/CCRP/Y
 ji0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703571500; x=1704176300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oy3BqLBXUE47jtWy8QC+hrav0nilmoQkCVpcWC/5UeY=;
 b=D5zPlkehbCEbK4PdQz7g2TqXgwgFOwBXJ5mLUQZrvE1ZFRHAKinkEbNcBIt9iv8PtE
 TxqyeLmGa+KI4gefWtTr9MtbgSOfc23y8P+0Z90Vd79Jb9N2wpE4t316TKJM/OVKtNeQ
 mGSjlWXWRgbYzrxsx5ODI8teWGRrgL7gTrb99YJLjgoP3D3lcHwWLcdJrvZD1d/Ie3ey
 M1j1MsE1URMxpXmilKeN5WDxoAWt+Z1IPGwvylnwUzP9TFYyB/QNJnc8/+lukssXtLjt
 Mcp18mCu/6Oxq2d1FDyDd2ImQwLDdQgLPsTveAJRJJubVkVDL4JQP/k/racD/UttMCl2
 Vf1A==
X-Gm-Message-State: AOJu0YyXCXsSM+XFVd08q2KFYZWDg6QH6tt46U51+oVEX9hL/yd8PHKy
 scG7/3LyVRq1hoAO5h+Z1f//9anF0GCYXgfpfCXox4AUM3IQHA==
X-Google-Smtp-Source: AGHT+IGL9cnax5UkYdg7BcF7he+gBc2L1eqVSELzjngrsRoCDkMEGkkDCt+R+8dFZcTOsxXzNMuJ5mkT4BczRuRHUv0=
X-Received: by 2002:a17:906:10d6:b0:a26:997e:fc9e with SMTP id
 v22-20020a17090610d600b00a26997efc9emr5699480ejv.3.1703571500394; Mon, 25 Dec
 2023 22:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-3-maxim.uvarov@linaro.org>
 <a45cbd9a-cfa2-7728-3c5f-1a21ebbcb068@gmail.com>
In-Reply-To: <a45cbd9a-cfa2-7728-3c5f-1a21ebbcb068@gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Tue, 26 Dec 2023 12:18:07 +0600
Message-ID: <CAD8XO3Z5Ff5u=PS5H6jaxRcdnZGh28+m6wC48A3P_H=bd5GBKQ@mail.gmail.com>
Subject: Re: [PATHv2 2/9] net: sandbox: fix NULL pointer derefences
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, sjg@chromium.org, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, bharat.gooty@broadcom.com, 
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 26 Dec 2023 at 04:43, Sean Anderson <seanga2@gmail.com> wrote:

> On 12/25/23 10:39, Maxim Uvarov wrote:
> > Add additional checks for NULL pointers.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > ---
> >   drivers/net/sandbox.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
> > index 13022addb6..d91935e032 100644
> > --- a/drivers/net/sandbox.c
> > +++ b/drivers/net/sandbox.c
> > @@ -65,6 +65,9 @@ int sandbox_eth_arp_req_to_reply(struct udevice *dev,
> void *packet,
> >       struct ethernet_hdr *eth_recv;
> >       struct arp_hdr *arp_recv;
> >
> > +     if (!priv)
> > +             return -EAGAIN;
> > +
>
> When can priv be NULL?
>
> --Sean
>
>
Function
struct eth_sandbox_priv *priv = dev_get_priv(dev)
can return NULL. If you ask why it doesn't return NULL without lwip patches
and can return NULL with lwip patch while there is no clear code
dependency..
Then I can not say right now and need additional investigation. But anyway
the return code of dev_dev_priv() has to be checked I think.

BR,
Maxim.



> >       if (ntohs(eth->et_protlen) != PROT_ARP)
> >               return -EAGAIN;
> >
>
>
