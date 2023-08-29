Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEE7C6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 17:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90855864C3;
	Tue, 29 Aug 2023 19:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5B286519; Tue, 29 Aug 2023 16:30:23 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57CB86517
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wens213@gmail.com
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-1bc83a96067so27138675ad.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693319417; x=1693924217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VUmC48c945AIpIrPGbtqPGrM+3nobIui92FEVylddOc=;
 b=MviwfCagj5DymYdCUN2XTrtJMkjRwHKuiNd6YpXSkFEEqvVKVTZR8jhB359N2DUidu
 uTfK+Su+U/nSl5A+8DiLs3bVM0bQBTgT+sAX/i9ncwquZgi+DajCHIrp5yuAfOrbXIk9
 YbyfRfXi2UbK6LiZpp2hQF5Vk6tY3DL+rpQkVGHzeCy84LAvEA6f1V87euV3QWc98cZ/
 r8IDdln2UCybMtc/X9l75+uPHgpuXmy9F+8ijuZdKRIb50ds7EqGOm+oWnWYwIpZMxGz
 0FCax7MJh0IOkTXpMqi/0rTTFyb4JU8rejzGpmyl8280AITyDeSFleAVrzrQfFSCmN66
 9u8Q==
X-Gm-Message-State: AOJu0YxuugSK04zucSF9XHRHfyRqjJZRgVE03AKir/Mn6LIlewAEJduH
 IDLkjwEGTVyKf0sjhyLopbP7i+3+PpOFJA==
X-Google-Smtp-Source: AGHT+IHMS/K6iQbKD4oD43vwUyuEhMcZP7nvGx/tDNzsj8qTZ8h59PdecNqDNTeENYeLRhCeA5qZdQ==
X-Received: by 2002:a17:903:234e:b0:1b5:64a4:bea0 with SMTP id
 c14-20020a170903234e00b001b564a4bea0mr24958037plh.10.1693319416620; 
 Tue, 29 Aug 2023 07:30:16 -0700 (PDT)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com.
 [209.85.210.169]) by smtp.gmail.com with ESMTPSA id
 i10-20020a17090332ca00b001bc6e6069a6sm9511885plr.122.2023.08.29.07.30.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:30:16 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-68a3e271491so2845145b3a.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:30:16 -0700 (PDT)
X-Received: by 2002:a17:90a:d903:b0:268:314f:8f35 with SMTP id
 c3-20020a17090ad90300b00268314f8f35mr20869745pjv.6.1693319415738; Tue, 29 Aug
 2023 07:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230531201520.15479-1-CFSworks@gmail.com>
 <20230814213854.408962d5@slackpad.lan>
 <CAGb2v645V85s49DRrKw8-TcR5e697D4nVp3QnPGDET46H49dZQ@mail.gmail.com>
 <69909b61-f57e-fc91-43a5-0f4bd23609c9@gmail.com>
 <86cyzaf6ie.wl-maz@kernel.org>
 <297192f6-3635-e75c-98c6-43a04631ce2d@gmail.com>
In-Reply-To: <297192f6-3635-e75c-98c6-43a04631ce2d@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 29 Aug 2023 22:30:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v658mwSdCYkPFrtJ8yvfNnkHLspxWsGpMVa_6ReEzqabpA@mail.gmail.com>
Message-ID: <CAGb2v658mwSdCYkPFrtJ8yvfNnkHLspxWsGpMVa_6ReEzqabpA@mail.gmail.com>
Subject: Re: [PATCH] sunxi: psci: remove redundant initialization from
 psci_arch_init
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 29 Aug 2023 19:34:49 +0200
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
Reply-To: wens@csie.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, Aug 29, 2023 at 5:49=E2=80=AFAM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> On 8/26/23 04:22, Marc Zyngier wrote:
>
> Hi Marc!
>
> > The GIC definitely has the NS bit routed to it. Otherwise, the secure
> > configuration would just be an utter joke. Just try it.
>
> Thank you for your response. I'd like to revisit my prior point about
> the distinction between the NS bit and AxPROT[1] bits in the context of
> monitor mode: in monitor mode, the NS bit does not determine the
> security state of the CPU core (monitor mode is always secure). But even
> then, the NS bit is still significant for other purposes, such as to
> bank accesses to certain CP15 registers -- and if I understand Chen-Yu
> correctly, some GIC registers also. That would require a special NS bit
> signal routed to the GIC so that it can distinguish between "secure,
> NS=3D0" and "secure, NS=3D1" accesses, which is why I asked if such a thi=
ng
> exists.
>
> I understand that the GIC is designed to be aware of the security state
> (using the existing AxPROT[1] signals) so that it can protect the
> sensitive registers. And unless I misunderstand, this seems to be the
> point that you made here (my interpretation -- correct me if I'm wrong
> -- is that you are using "NS bit" as a metonym for "security state").
> However I must clarify that my question was to seek further information
> from Chen-Yu about the possibility that NS is significant when accessing
> the GIC, even in monitor mode. Alternatively, his point might be merely
> highlighting that the GIC permits different types of access depending on
> the CPU's security state, which aligns with the viewpoint you've reiterat=
ed.
>
> I apologize if my previous message didn't convey this context clearly
> enough. My goal was to unravel this nuanced aspect of the NS bit when in
> monitor mode, and to determine if NS needs to be getting set/cleared
> during GIC setup to maneuver around the banking, or if the value of the
> NS bit when in psci_arch_init() is truly of no consequence due to
> monitor mode.

Sorry for my previous misleading comment. The banked registers refer to
the CP15 registers. From ARM's documentation [1]:

When the processor is in Monitor mode, the processor is in Secure state
regardless of the value of the SCR.NS bit. In Monitor mode, the SCR.NS
bit determines whether the Secure Banked CP15 registers or Non-secure
Banked CP15 registers are read or written using MRC or MCR instructions.

[1] https://developer.arm.com/documentation/ddi0406/b/System-Level-Architec=
ture/Virtual-Memory-System-Architecture--VMSA-/CP15-registers-for-a-VMSA-im=
plementation/Effect-of-the-Security-Extensions-on-the-CP15-registers?lang=
=3Den#Cbbdffad

> > Well, history is unfortunately against you on that front. Running on
> > the secure side definitely was a requirement when this code was
> > initially written, as the AW BSP *required* to run on the secure side.
> >
> > If that requirement is no more, great. But I don't think you can
> > decide that unilaterally.
>
> I have no idea when/if this requirement was changed. It might have never
> happened "formally": perhaps at some point, the SCR.NS=3D1 code got added
> after the call to psci_arch_init(), breaking (that version of) the AW
> BSP, and nobody ever complained or changed it back... so it stayed.

There was never any BSP code for PSCI before this. This code was written
by Marc in ARM assembly. I merely translated most of it to C code.
The snippet to clear SCR.NS is there in the first commit,

    d5db7024aafc sunxi: HYP/non-sec: add sun7i PSCI backend

ChenYu

> But we're starting to digress from what _this_ patch does. The intent
> here is only to remove two lines of code that (we're discussing to
> confirm) have no effect. I'm not touching the code that *actually*
> determines the world into which monitor mode exits.
>
> Cheers,
> Sam
