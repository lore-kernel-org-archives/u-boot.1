Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E512C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10FC87A68;
	Thu, 28 Dec 2023 16:24:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aE2UPADy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC3D87A7B; Thu, 28 Dec 2023 16:24:24 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D214879E5
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5bdb0be3591so4769308a12.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703777059; x=1704381859; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zfwJ0q9mPgFyO+AHaqO9zPkB/DXsTJTMoTyqVZwxYXI=;
 b=aE2UPADyReh9bm20Gh4eIxFd/l+JQJXnFjzNphJtFPLWPp6EQ4I7Z1VsnVszRc8/9F
 0+sXtnxUOUyb5B9nymhaFE5sGSJBrLu8yI01cglbMyfW+DSXNwcA89rwIeDmNMp68ozX
 8beTATu7Iu96O1+EAyw53S1E/wmDHDKsgCjNCZdE+BGGmr0DVpXLZsRK+kCto0oiaS4D
 d+PmlFmXuS/hzAhAtWd47OZ/pimSkQgIUpScw304IKaY4/sOkIAC9sRg3BT//6xxceQ3
 2JUSsci47d8UNSXRBfVnKQmBd2oxsfJZy+aMuPj2m7Ov3BTNdqNz1Nt3XhJi+jiCnjCf
 LloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703777059; x=1704381859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zfwJ0q9mPgFyO+AHaqO9zPkB/DXsTJTMoTyqVZwxYXI=;
 b=uxBPpu44ft1fIN8I632Y9dgHzCFC8UHeq6CJhN86gb2nNFBoO6rbeK/xqKWYpH0DAP
 x9wg1Od02JjCVPTuMNF2wl/Yi9D2Ai1xENpD+T7/S1rWD/MpyYbDh/d/p7Dv9ry4njAT
 qAVhihlxv0ggTdZvHYwNG4jV/0GyN75qewcHzeilYJS5YIK/pqWWCd7c6DQBFTx/X+pK
 YS/a/XpzRPNUAxPRDXCGtFmti9bpLWxdBb+cCpScOG3+HlgfgSPg65ioB+WdSdTJHWuc
 BXdRbZWZEuCm6J2ShdZVDz/uQNliug5RM6aS7giTZoT4dKKYmq6L7lsqZxat7HmRCEPP
 E/CQ==
X-Gm-Message-State: AOJu0YwXHzqVWRolt9M8T5N5YglMVi/WEe0t1bTZRRD7kzP4gdLIFjIU
 hZBlFx4L8natVhbN3SC9pfovOgGrZ9cnKJepcT9lxsyZRH91hA==
X-Google-Smtp-Source: AGHT+IHUmNT3VtP+saWQg1XLmiO3GI9ax8DKHSYnDsMx55JC4B44G51XXo2b23ufzE9EZRcX3tY4Qiw2iFk3gvrcjtU=
X-Received: by 2002:a17:90a:fa8b:b0:28c:1398:e360 with SMTP id
 cu11-20020a17090afa8b00b0028c1398e360mr4713135pjb.47.1703777058783; Thu, 28
 Dec 2023 07:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-5-raymond.mao@linaro.org>
 <CAFLszTgjj2+78qixAKQ5pK4PtLRTS4ckVLAptUZnV9+zFzaQ2A@mail.gmail.com>
 <CAEfUkUJdB7eSoQRn2q3_6LwibkDZVM0oeU5nC2HbYMx74=M0_Q@mail.gmail.com>
 <CAFLszTgwJqPMLGG1_fRYohuvLDmrrayiqfR92QD4zcXW_M_YBw@mail.gmail.com>
In-Reply-To: <CAFLszTgwJqPMLGG1_fRYohuvLDmrrayiqfR92QD4zcXW_M_YBw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 28 Dec 2023 10:24:07 -0500
Message-ID: <CAEfUkU+VMufHj1LpqSObCnUy1gEYs9FBbOuTNU8jDm+UBFbgrQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] arm: armv7: save boot arguments
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>, 
 Sean Anderson <sean.anderson@seco.com>
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

Hi Simon,

On Thu, 28 Dec 2023 at 08:37, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Wed, Dec 27, 2023 at 3:52=E2=80=AFPM Raymond Mao <raymond.mao@linaro.o=
rg>
> wrote:
> >
> > Hi Simon,
> >
> > On Tue, 26 Dec 2023 at 04:48, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Raymond,
> >>
> >> On Fri, Dec 22, 2023 at 9:31=E2=80=AFPM Raymond Mao <raymond.mao@linar=
o.org>
> wrote:
> >> >
> >> > Save boot arguments r[0-3] into an array for handover of bloblist fr=
om
> >> > previous boot stage.
> >> >
> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> > ---
> >> > Changes in v2
> >> > - New patch file created for v2.
> >> > Changes in v3
> >> > - Swap value of r0 with r2.
> >> >
> >> >  arch/arm/cpu/armv7/start.S | 13 +++++++++++++
> >> >  1 file changed, 13 insertions(+)
> >> >
> >> > diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
> >> > index 69e281b086..2ca63ca32c 100644
> >> > --- a/arch/arm/cpu/armv7/start.S
> >> > +++ b/arch/arm/cpu/armv7/start.S
> >> > @@ -152,9 +152,22 @@ ENDPROC(c_runtime_cpu_setup)
> >> >   *
> >> >
>  ************************************************************************=
*/
> >> >  WEAK(save_boot_params)
> >> > +#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
> >> > +       ldr r12, =3Dsaved_args
> >> > +       /* Intentionally swapping r0 with r2 */
> >> > +       stm r12, {r2, r1, r0, r3}
> >>
> >> I thought the instruction was a bitmap, so what does the 'swapping'
> >> actually change?
> >>
> > The swapping is due to different register conventions between aarch32
> and aarch64.
> > Actually swapping here is to avoid the complexity of swapping this in C
> code.
> > I will update the comments here.
> >
> > [...]
>
> But how does this work? stm does not support changing the
> ordering...what am I missing?
>

Ah, my bad. You are right. I have to use `str` to store one by one in this
case.

[...]

Thanks and regards,
Raymond
