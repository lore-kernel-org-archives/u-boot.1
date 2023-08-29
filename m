Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FCEC6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B5DB864F0;
	Tue, 29 Aug 2023 16:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SI3nRyI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0AF486517; Tue, 29 Aug 2023 16:34:08 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37330803AB
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BB98665341;
 Tue, 29 Aug 2023 14:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A22C433C8;
 Tue, 29 Aug 2023 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693319643;
 bh=7Ov9Vkt+r9b703KHfq44Y2nAKp8xyWbWXPThX61E/uM=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
 b=SI3nRyI8HEaaQSTXLX3PBizl7LvYFGn9znLgybPaY2l4p37uOdZeH/m8sg0mwigDT
 0njMT4VZN4qYtjedpmOdQaLRE8qHnBgSioqRdKoRBAxy5Hu9rZgCgnqDPvWMNVlxfW
 jRVhWTdjV5Vt0UqghKD1USoNkU0fZyzjIk/1q+PPH9zGzSfoGfWFzIgrJ1Xv32NBKW
 voA+jOiO2wCM3ccWXNqgDM6Q0fMHLvDJBxknZMKuRIVbZUkmvmX+3UC5BfftlZ+cCx
 TquAk9HJkCKdasVPfC+OtPQNvrqgEbvCm9qx+DRValifO5YEEN6nLxa8uw5FgMDyh1
 ogr5vt99kIYdQ==
Received: by wens.tw (Postfix, from userid 1000)
 id 7C56F5FA0F; Tue, 29 Aug 2023 22:34:00 +0800 (CST)
Date: Tue, 29 Aug 2023 22:34:00 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH] sunxi: psci: remove redundant initialization from
 psci_arch_init
Message-ID: <ZO4B2G8zzsLm+YZL@wens.tw>
References: <20230531201520.15479-1-CFSworks@gmail.com>
 <20230814213854.408962d5@slackpad.lan>
 <CAGb2v645V85s49DRrKw8-TcR5e697D4nVp3QnPGDET46H49dZQ@mail.gmail.com>
 <69909b61-f57e-fc91-43a5-0f4bd23609c9@gmail.com>
 <86cyzaf6ie.wl-maz@kernel.org>
 <297192f6-3635-e75c-98c6-43a04631ce2d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <297192f6-3635-e75c-98c6-43a04631ce2d@gmail.com>
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

(resent from kernel.org address)

On Tue, Aug 29, 2023 at 5:49 AM Sam Edwards <cfsworks@gmail.com> wrote:
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
> NS=0" and "secure, NS=1" accesses, which is why I asked if such a thing
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
> the CPU's security state, which aligns with the viewpoint you've reiterated.
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

[1] https://developer.arm.com/documentation/ddi0406/b/System-Level-Architecture/Virtual-Memory-System-Architecture--VMSA-/CP15-registers-for-a-VMSA-implementation/Effect-of-the-Security-Extensions-on-the-CP15-registers?lang=en#Cbbdffad

> > Well, history is unfortunately against you on that front. Running on
> > the secure side definitely was a requirement when this code was
> > initially written, as the AW BSP *required* to run on the secure side.
> >
> > If that requirement is no more, great. But I don't think you can
> > decide that unilaterally.
>
> I have no idea when/if this requirement was changed. It might have never
> happened "formally": perhaps at some point, the SCR.NS=1 code got added
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
