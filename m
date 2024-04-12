Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E39FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 09:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 785A788080;
	Fri, 12 Apr 2024 11:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ceSZ6eIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F4388005; Fri, 12 Apr 2024 11:56:09 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C327881C9
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-516d04fc04bso1157330e87.2
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712915767; x=1713520567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5d3Z2FjGRBRBFfYdTOWE8kZvXkDkhvEA+KgWl8gtVAI=;
 b=ceSZ6eIWiUFAGVErqj3pa/2p9piT+vGxx6a8tf7rAgJs6c7eDKyZla2Y69NcYQ1krB
 fz0vyyjllOCUqa3QTyrPCyvv6iXmA89EdxdSaZ+LH8KPVs1s/rlMxaT/q2TLODjlwFNz
 slN47o6uzcIMSF97w3Y2bG1eQ9bQwc/NK0eOy+stvEfpj+UyAlQ84+npFCga4SZfSw10
 XRrlxGJPUOHftEsw+9f7FDzAd4JnGb4NdGmYSbRepGccrHoiBSWYE6SlfdgQhM6SVe74
 RaqHotMcETY3n3QQXpNyZTTgCPMNTFQ6LejbKLs1y6+OUj6fPP+K+A8mQ55YnwsjIqgZ
 SeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712915767; x=1713520567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5d3Z2FjGRBRBFfYdTOWE8kZvXkDkhvEA+KgWl8gtVAI=;
 b=BOwF8lK/zJ+Aaaqza7VxQNxu3IE0zAx8FQjC6br6oIB/QXpu6Mcn56pUaTBPe21QBb
 sTThnu5AOfuKfw7IvjIIfYI2H68xiGDN/XBHpysbfXn15Xya66DeqEyyz9of8hxGpVUW
 PpJwtHhh9fww2nslHu9uidyo2YekbbU0VDhs6Jzxi8Xk49USxVz6rpmzA0M9thDU+B0c
 fBxuc+eIiOpy7pKIbUPLla0bAMcwaM8hQ1/YgXCNCCuu9geUsGD1RbD8Du91y2S18kkN
 0lzDILLP/YfLYdayrWurehI+n42GQvnxzQSt6DkStFO8kxGYGlKmEZp76I30/i/HBoys
 bk/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvxoogDe9994OXc3kUsQQk2SOeFpM9kuKaqofdf7v8DVvljWdmMxdrkOeJ1xsBP/0K9Od4bXlMhyV4rRsF1ld+4Th2IQ==
X-Gm-Message-State: AOJu0YzFCx5HxT/pXD7uNN2glkV/s5L13hczs/BaNnwKe/K4Q2mK103F
 DG6JlGaTKxXhcdVxQqLk+UTYo27oQgwuGRPzDSRfmIZiiAR+ist4cWaVK27LbzslfYRGYpKvcwb
 nvEVDn7QE/j/P4CifLNvS9mQn3XqwBUjmE1k88Q==
X-Google-Smtp-Source: AGHT+IEfiIYpGY1EMleNIBEDyMQ97JkgMbSD1OccBUDbD2qIUtnk5o6lnkKqo+yNR3O/hmowiBmjuLErsjJrg30ORBE=
X-Received: by 2002:ac2:5f87:0:b0:516:cdfa:1802 with SMTP id
 r7-20020ac25f87000000b00516cdfa1802mr1779947lfe.63.1712915766634; Fri, 12 Apr
 2024 02:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240408213349.96610-1-j-humphreys@ti.com>
 <20240408213349.96610-2-j-humphreys@ti.com>
 <ee9a13b7-6b52-4bc8-8876-e194e1a66f92@gmx.de>
 <ec241b23-5523-45d6-aa05-5d1667c34773@ti.com>
 <2a818e83-9971-4626-9695-24e7d9c2fdd5@gmx.de>
 <44af30a5-c9c4-47d6-b2e6-7226e01a60ae@ti.com>
 <CAC_iWjJgAmCpxqk_Tty9jxfjauo_jVyVH9a4fxhiyjqg2UVPAw@mail.gmail.com>
 <86r0fdysku.fsf@udb0321960.dhcp.ti.com>
In-Reply-To: <86r0fdysku.fsf@udb0321960.dhcp.ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 12 Apr 2024 11:55:30 +0200
Message-ID: <CAC_iWjKhj8OJmAYBDxa8nx0pY+gaYCv+2hXecnVZmOCGGw0gBg@mail.gmail.com>
Subject: Re: [PATCH 01/13] ti:keys Add EFI signature list
To: Jon Humphreys <j-humphreys@ti.com>
Cc: Andrew Davis <afd@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Neha Malcom Francis <n-francis@ti.com>,
 Roger Quadros <rogerq@kernel.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jon,


On Wed, 10 Apr 2024 at 20:35, Jon Humphreys <j-humphreys@ti.com> wrote:
>
> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
>
> > On Tue, 9 Apr 2024 at 23:14, Andrew Davis <afd@ti.com> wrote:
> >>
> >> On 4/9/24 2:26 PM, Heinrich Schuchardt wrote:
> >> > On 4/9/24 14:14, Andrew Davis wrote:
> >> >> On 4/8/24 10:34 PM, Heinrich Schuchardt wrote:
> >> >>> On 4/8/24 23:33, Jonathan Humphreys wrote:
> >> >>>> EFI signature list using TI dummy keys.
> >> >>>
> >> >>> Adding vendor public keys into the code base to lock down generated
> >> >>> binaries to the vendors unpublished private key does not match well with
> >> >>> the intent of the GNU public license.
> >> >>>
> >> >>
> >> >> The matching private keys are already published in this same
> >> >> repo/directory (arch/arm/mach-k3/keys).
> >> >>
> >> >> Andrew
> >> >
> >> > Why should we create signed capsules which are already compromised by
> >> > publishing the private key?
> >> >
> >>
> >> If you buy these devices you have two options, you can burn real
> >> keys, or you can burn these dummy keys. If you burn dummy keys
> >> then these images will boot and so will any image you or anyone
> >> else wants to boot on the device. (since the keys are published
> >> anyone can make images for them, that is how we do GP (general
> >> purpose) devices these days)
> >>
> >> If you burn your own keys, then you switch out these keys here
> >> and your device will only boot images that you permit by signing
> >> with your keys.
> >
> > I am not sure I am following you here.  We don't burn anything in the
> > case of EFI keys. They are placed in an elf section and we assume the
> > device will have a chain of trust enabled, naturally verifying those
> > keys along with the u-boot binary.
> >
> >>
> >> You'll find plenty of open source projects do the same and
> >> give out example keys to show how to use real keys, even
> >> official GNU projects.
> >
> > Yes, but the keys defined here are useless unless you have a default
> > defconfig that uses them and embeds them in the binary. I am not cc'ed
> > in all the patches of the series, is that added somewhere? And if you
>
> Yes, they are part of this series
> https://lore.kernel.org/r/20240408213349.96610-1-j-humphreys@ti.com.
> Thanks for the reviews.
>
> > unconditionally enable secure boot It would be far more interesting to
> > embed the MS SHIM key along with that special key you are trying to
> > define, so that firmware can boot COTS distros as well
>
> Yes, we should consider.  But since that is outside of the EFI capsule
> use case, I would rather take it up in a separate patch.

Ok, the commit message wasn't clear, and based on Andrews's initial
response I thought you wanted to use those for UEFI secure boot, not
capsule updates.
Those are your boards so I won't NAK this, but I'd strongly advise
*not* to add this.  I assume you want capsule auth by default because
SystemReady-IR >=2.0 mandates it?

In that case, it would be a far better idea to document the process of
creating signed capsules clearly either in U-Boots EFI docs and/or
your board docs.
I am pretty confident that if we merge this now we will have future
products using the keys above

Thanks
/Ilias
>
> >
> > Thanks
> > /Ilias
> >
> >
> >>
> >> https://github.com/gpg/gnupg/tree/master/tests/openpgp/samplekeys
> >>
> >> Andrew
> >>
> >> > Best regards
> >> >
> >> > Heinrich
> >> >
> >> >>
> >> >>> Best regards
> >> >>>
> >> >>> Heinrich
> >> >>>
> >> >>>>
> >> >>>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> >> >>>> ---
> >> >>>>   arch/arm/mach-k3/keys/custMpk.esl | Bin 0 -> 1523 bytes
> >> >>>>   1 file changed, 0 insertions(+), 0 deletions(-)
> >> >>>>   create mode 100644 arch/arm/mach-k3/keys/custMpk.esl
> >> >>>>
> >> >>>> diff --git a/arch/arm/mach-k3/keys/custMpk.esl
> >> >>>> b/arch/arm/mach-k3/keys/custMpk.esl
> >> >>>> new file mode 100644
> >> >>>> index
> >> >>>> 0000000000000000000000000000000000000000..2feb704e0a5fd126410de451d3c0fa4d3edccc52
> >> >>>> GIT binary patch
> >> >>>> literal 1523
> >> >>>> zcmZ1&d0^?2Da*aux2_hA(f&~MnUw(yu0v@E4?-F=u^u*PVqVQ8QZ((-^A*$m*Kg7c
> >> >>>> z&78AJODc2mtxpELY@Awc9&O)w85y}*84Mcd8gd(OvN4CUun9AT2E#ZUJWL@GhWtR)
> >> >>>> zKpA!(HkZVloWx>7bput902hy3NNPo5v4Uq_aY<2WZfaf$h@G5YRFGekSdyAzC~P1I
> >> >>>> zQpnB26;PC)oLXF*UsMbeWai-t@l*&dEdVMmF_blshP#N9QH-w`BJNO<sh6CeYal1i
> >> >>>> zYh-L-W?*PwYGi0=7A4MWYz$;tLb-$9{Y^|t$U)A?%D~*j#Lr;R#Kgta#Kg$3Uu2!<
> >> >>>> zjryX?*~({Md+?>+QS$x7=il`0?bc6sZ`Vxxl^6N{>i2E;SY*4-T$+0G;)5dxe+2CR
> >> >>>> z@4+)sDPWdQb@%6KTpDVdm)v}?GSpG(w_UV)&i+#e3fJowDZO)JR83lIcbw(hMu}}Y
> >> >>>> z2ZZwYAI-LVx@^G;HdkgxaX&Hnl_l3&{H|3l7uX@Vl5di{>fQQ{pDynFlySp2(z~g)
> >> >>>> z{LIBUzm&K9j_CMw_SIFfPdcT#zmg6g<ji}(R`6geJLk-#o7bK^&&fT}#2zsD`=c9g
> >> >>>> zFUCK<Fz@{2kel&$W6zl<d|WNk#ZsNRd{_N_SJxWvh0*K$j!m)c@oT>{#b(Lp`M3Uj
> >> >>>> zGOKycyEe+n{G(Rmg}jB!)0ySk-!kkj_R7#OT+}pcG0VXh?f+ftRvnyw#hUea^Iyfn
> >> >>>> ze|zgKPKrqe@jYWU?v<50X(n^lZ*G%j$JyCh`*Px|H*K=2WXP)hx>jng+}Q}N^KoDN
> >> >>>> z8dh8T-~Dmrp2?yk3O6Gqbz7O@<TEz<^zIa7d#PKtHKHeAg?V0DMSin^o3F|IEfQWk
> >> >>>> zcmJwBy6&2hKub%G{j3IK(?7m@uI43#1e~wSZJ5sTtDjrp@7@{O3(faN{`Gp}x{$M5
> >> >>>> z{A7`c@pjfYq1Z=JvgZ^-zCC<(HFTBwYhTX$k`7IJX`SM!H}f`Mv+(Op6uVY(<(^o4
> >> >>>> zpyXAj9nF_c-1A<UIel9%6Eh<NBXSA>W=dcRVPvS;*B%(4`P|iK>Vg$XDgN9sr}Df{
> >> >>>> z7X0es=RPHr8RB+*)}q}h%gn?x9PO4y*Qog};x<<LS+lxk$@$kYlG_hXu6p%jvB<%l
> >> >>>> zmcsdI9w!^rFPt^&c~{1?L~DJ4TRPv>t%rn8xi;KBE9A!Dppb9yru|>RCb9PcXWpE>
> >> >>>> zKlQ}fzw*izXI|}|r!O*nb&cP9#VhHRn;B<SRflN2Jl(*;W4e0LD$ORRIdjjhURZH+
> >> >>>> zXWR0Vllb2@>`1LC^xvIctvLCYhRA_6yCS~2&!0SH1xwv(O~<l(HQxHJxzF!T_>+5t
> >> >>>> z^|E$S{MM^8j9J5`sQ6pud{2Lz?k`zncbjvHj%eutjusUol}8;%cbPLCO|e;ZJ^tXe
> >> >>>> z_N{pmM}uCi3UWO3=hMc<s}m1Jx4GS4F(<_N`R|o+)eAK3Yx{o$ygRe!;<_EoF&UhP
> >> >>>> zrslJ=2XA9^$j#UDYwo;ZvZwb!|L%YP%v|ie|7-1PP+q3DZ&vEWgHHrjHv|NzEVjO?
> >> >>>> zKFeRbXv>iTPl?N16Xv@buq_d@TU<MB;uD_jX^$J`&*C>`uX0_s&g9M2C6cKx4E;{?
> >> >>>> zt`1&)Tk-yb?sKMPI~!}xt*d*!tMat!r1`}jul#i@lDB8rnu>ba_-^4!iQ5{|tb3TX
> >> >>>> z>fTMIw2!Me3{Dw*WZotC<4@h<H`zaL+~Es<{Ccj5yS7zyNU!YsTG`^JqA6NkU%vnV
> >> >>>> D66<<J
> >> >>>>
> >> >>>> literal 0
> >> >>>> HcmV?d00001
> >> >>>>
> >> >>>
> >> >
