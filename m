Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FCAC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4B2687A52;
	Thu, 28 Dec 2023 14:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VvU+0pH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A43187A01; Thu, 28 Dec 2023 14:37:33 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3553A87A34
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28b9e9e83b0so2920557a91.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770649; x=1704375449; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lID7MR4ZVBV8J7kIHcMSJVkU7gdSveJYtSHTiBwpRtE=;
 b=VvU+0pH94rli3yCzo2cuTs1h6TX8HbBbN7dWYjXl5pEq1cfdMtHo+iVoxKK0d7Lylo
 3HmkQcoi18m/OsMWm/mzvHpwvrjVwmodJhfVMDHudZoeK3lRKmMmTfGmeo5OQId0bL6P
 +PiXMy/zshqAcLlZS1bADLVWmxkiMvmQXQFho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770649; x=1704375449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lID7MR4ZVBV8J7kIHcMSJVkU7gdSveJYtSHTiBwpRtE=;
 b=YC9LvSxFG5AEtM27zZz0wXKe0ChjapHypFH8NHZ95G/DEwSiV8LqyAseJczD3KcivQ
 4aZB6ioO02KLfbAC8CsZqPOEyU60Lmz7Yy+Fbi1j8FKLFmSQdsTDU2LBb+7YQTP/oXvT
 qTFk6hcauJMnefQKeteWdAQF42RzCK9MqCAtcO/JaDZtSG3TOFrtY5tyFen2//dkdcgc
 wUcqRaNvM80CI7PcIWR+lBO4UlGKVBJ2HtKo+MKt/gyqzbML8Ev0hb3OUDqebxUFVPQO
 B9mDSN4nXIgxuBmc2xtmROCrr/EAsM/TrMLVGCCAzcyIE3enSz6Jtt1VQvnI06RgTk4h
 n4Eg==
X-Gm-Message-State: AOJu0Yy316oknaKhs+PgUbkONLxhRWqjHywMmcEHwKv5NiMPetmWm1gV
 Jkd3e371gHQrjfNclKINvLMM0F/EMQ4uvv98vET9HfO9Hf4g
X-Google-Smtp-Source: AGHT+IHGiFwVz9tGJzbqJl3vM2ZDsHAfGOFK4+2kHwuNCyYxLofO1xy7VYwJAfxcYkDDdIeVENOXAnJhxruQNJ/hi5w=
X-Received: by 2002:a17:90a:ea8e:b0:28c:9c0:193c with SMTP id
 h14-20020a17090aea8e00b0028c09c0193cmr2892006pjz.89.1703770649669; Thu, 28
 Dec 2023 05:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-5-raymond.mao@linaro.org>
 <CAFLszTgjj2+78qixAKQ5pK4PtLRTS4ckVLAptUZnV9+zFzaQ2A@mail.gmail.com>
 <CAEfUkUJdB7eSoQRn2q3_6LwibkDZVM0oeU5nC2HbYMx74=M0_Q@mail.gmail.com>
In-Reply-To: <CAEfUkUJdB7eSoQRn2q3_6LwibkDZVM0oeU5nC2HbYMx74=M0_Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:15 +0000
Message-ID: <CAFLszTgwJqPMLGG1_fRYohuvLDmrrayiqfR92QD4zcXW_M_YBw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] arm: armv7: save boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
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

Hi Raymond,

On Wed, Dec 27, 2023 at 3:52=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Hi Simon,
>
> On Tue, 26 Dec 2023 at 04:48, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Fri, Dec 22, 2023 at 9:31=E2=80=AFPM Raymond Mao <raymond.mao@linaro.=
org> wrote:
>> >
>> > Save boot arguments r[0-3] into an array for handover of bloblist from
>> > previous boot stage.
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> > Changes in v2
>> > - New patch file created for v2.
>> > Changes in v3
>> > - Swap value of r0 with r2.
>> >
>> >  arch/arm/cpu/armv7/start.S | 13 +++++++++++++
>> >  1 file changed, 13 insertions(+)
>> >
>> > diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
>> > index 69e281b086..2ca63ca32c 100644
>> > --- a/arch/arm/cpu/armv7/start.S
>> > +++ b/arch/arm/cpu/armv7/start.S
>> > @@ -152,9 +152,22 @@ ENDPROC(c_runtime_cpu_setup)
>> >   *
>> >   ********************************************************************=
*****/
>> >  WEAK(save_boot_params)
>> > +#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
>> > +       ldr r12, =3Dsaved_args
>> > +       /* Intentionally swapping r0 with r2 */
>> > +       stm r12, {r2, r1, r0, r3}
>>
>> I thought the instruction was a bitmap, so what does the 'swapping'
>> actually change?
>>
> The swapping is due to different register conventions between aarch32 and=
 aarch64.
> Actually swapping here is to avoid the complexity of swapping this in C c=
ode.
> I will update the comments here.
>
> [...]

But how does this work? stm does not support changing the
ordering...what am I missing?

Regards,
Simon
