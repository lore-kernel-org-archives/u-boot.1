Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39CCC531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 09:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A212F605D2;
	Fri, 24 Jul 2026 09:48:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JT10sp4BcGTG; Fri, 24 Jul 2026 09:48:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B42EE60602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784886501;
	bh=iH4d87V2vLNfFxqLxgicjvcrvZeP2HTy7K2Lu+FZOQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W6mOcxiZCwVWYm7Uhwbzk6eevcPUI2+0bgBS+xo0wtmgf5d/eqcvUjko7KjgnC0Ag
	 thXHvo2u5CXVkY8luVWF0Fc3JjIBWtIW4U8HBRODXFZFKNx4isn1CklEXVGlL6xwLf
	 chuVlMFUka5a2VEamRN2G5LFkFB6bKvOBBbVImP5WLtebEL2+ZiLI+3LMwSIyGTEbQ
	 Lz5pKA9b3w0e/P4A8U9XEf02+id+abkUpB2hayyEwKTfVcZhyIZx+vQsDTeZhQ4le+
	 vmf/snaliTJskGi6Iqa8m5YZpAep2LT6TN00L1UVyL+s0XJRhIYJqbl6ffmo/IjBzG
	 R+jsH/Fnnvqkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B42EE60602;
	Fri, 24 Jul 2026 09:48:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A84942E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99E5B404AE
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4lG7_HeXdMjX for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 09:48:19 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3A01440064
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A01440064
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A01440064
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:48:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781AA803F6; Fri, 24 Jul 2026 11:48:17 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49403800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 11:48:15 +0200 (CEST)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69c1220bd51so328045a12.3
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 02:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784886495; cv=none;
 d=google.com; s=arc-20260327;
 b=cHcVRnxR2qKlXrjdPmydx1/9dHJYYVwDGpW+i1aaChON1XSiA4veyWYfv0CMdlFcku
 hbSHctt/4isADfm1pMapwvS4xx7QnKVGK2A+wDQIY1AzlyUGzmpv/Ab0BWYGAg6ymAuv
 x7seQk0HhjqfzWqgpDHTR54hlL6GqUIGw+ev3y1ljZwXAGPLnCAGBSd+TbF24O7yP0sa
 f2VJk0JMLHcHrgHcsxbJx7rbbvBwOzWw73qQwB9sYqN/POfRbpx56MeVxF4Y+Ayu0Geq
 vWaarMEDDhaMBRUZVEIL1WaDmlWe/XrmSdjx6a3kHfG5aioPYFEpl3feyEEDaalqrJ23
 zkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iH4d87V2vLNfFxqLxgicjvcrvZeP2HTy7K2Lu+FZOQg=;
 fh=2e0WOH0hwjn2iwz+Eu0MPcAlLPc6kLKk93lD71nuBnI=;
 b=k9ZkprPFlYR13Sr1OGh2S+MDzIhizj1kqHUq4/xbQP5yRGKS9xwsTRyhw/7h3ANAUx
 RvEXddALBMUrEu6V0375pcD3z3V9EBLcyFqVi1U1ief/Y5LcSkhNudmejbPkJTvTCPNG
 5JXGtnPHplP8O4Vo8rDDABJiWwOfS0L8FJie3ud01I+7TRc+33i7fNBa+gdje8LeB5fr
 3yOjk585YvkZtnSzowao605aUqG+l/Y6A3f3wMti2KzApRSQ6ifcGSfLFmv62/IDU4V5
 REkAAMKZTnKA6D82UfoABcbZt0ok+X+EEitToD8ef9hEazgmA/gVzgPAF6BU3yETaGxH
 /5HQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784886495; x=1785491295;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iH4d87V2vLNfFxqLxgicjvcrvZeP2HTy7K2Lu+FZOQg=;
 b=XP9jQgGIkRzdD8BmaqS0gbQAnBlfjz6xTTY08/BXVDcu49VrviZXyeNJnODrmK6yik
 TgFr9g8ZkAA7ek66vDhK7Wjh4Loz3QXgk1Kq+ZdkIV35cFeh23NY0699VZfQUSI9jEc4
 eMe+2mhu+3hm8GMs83Jwbxvvuwho5vCrZrFzJHs6ELVelXmBlFxLFsXKhf+4hsE1kM5n
 saZlj2r0z6zyIIEYY9/Qhs0i0knOUwCpGYztJZdq9lOiE+9RQ2EYXgYUrB+7TV2+bHAF
 QkBfds+/+SEenJwTMlgReb9r6ClAIBTqYgEtPWYS51x4MCZU6LMFfUDQi7V5RJeLHUbJ
 NOLw==
X-Gm-Message-State: AOJu0YxNQNqCwE/41kG59CPTnXkIfh+5qA4JliWcrF53OZ3ylM+PC3sk
 NMMOyoN70BxKOsfliC3iOZDPWKH954OF81hYWXoFF88FIIQwtppQpkFR/R57LaYa24w3ijSroL2
 Cp2DwoxmWJ6c0qkBJcp9PyhQpPm2JqpwvhIlCzsI1Hg==
X-Gm-Gg: AR+sD10KQmsR9AU8wl0ZRQxqwJd6YWNpzzYtSJIR9ZG/gYivkfho/wTzgChi0nK0lEu
 nZ5BscM1rnAkbcI5LGbFuJS5mJYTLoRrvJkihXJc/O93VXZg5Qvy1QDnTtAPUIW/KXXlm+1hhVa
 kPcQc4IhX3g64a3dEP1XpVUcp/mPtreqN5z0z9Ufwi8R0IndC1HkvOxXs/K5a9SZ0M+dlQzmf6S
 vPZd87HImxRAYxaFvuQu6HLvEDr/ag/Icg/oGGoDWPwAH5QKs6VymdUjb+sIntlmlKnmAOm
X-Received: by 2002:a17:907:25c3:b0:bed:9a7:5ed1 with SMTP id
 a640c23a62f3a-c1c506e8a62mr288238666b.5.1784886494449; Fri, 24 Jul 2026
 02:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
 <20260609-atf-falcon-v1-4-2b20c5e83615@flipper.net>
 <baf04b5d-ef0a-4c58-a796-d09edd6c84b7@kwiboo.se>
 <CAKTNdwEQx6SfKgD=RbbznVgLuMLA5P1UbJ3b+KR4j4L4GyCfoA@mail.gmail.com>
 <b8908639-94e7-4538-8a40-d40d00dc57e6@kwiboo.se>
In-Reply-To: <b8908639-94e7-4538-8a40-d40d00dc57e6@kwiboo.se>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 24 Jul 2026 13:48:06 +0400
X-Gm-Features: AUfX_myAkNX_JrvZ79zQa8cHekBpVo01HdjWKQORKDxKA0GNfIrgjqXR6V2ykgA
Message-ID: <CAKTNdwF68AZT6FHSzPCXKy9QBE16eO-AB+0Ggs9oZXicOSp4_Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] rockchip: binman: Add support for Falcon mode FIT
 images with ATF+Linux
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784886495; x=1785491295; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iH4d87V2vLNfFxqLxgicjvcrvZeP2HTy7K2Lu+FZOQg=;
 b=yLR+F5ZU+QH+v2jQnmZECYhzCmyFt3msNH7kaWIW9xhwUTPxyDLw0CpKEnx2fbelAn
 MbeyW1nBDjLgKMRczKz3MKHTvNQs1TeW6n97qeDvSSTm/JCzVEnryQNpMkrumNP4wsEC
 +9F2PDph3zPN+MFGHg2U4xgwqhQer6EDqMEfvWj5HqYYFlYohUOiCEVn/cXrKynxxP5o
 bpaSajMvsjPp1DQT48m2/eg74TI4a+8s2dHgZ8IO5VGg8u/2SDhuyC46WmUHPa3i/PON
 wN4N0Lr+zvOvXM41eCNIw5NfrA31OwI9FZmrlywfqLJ1XnHZtwTwQ3QQ3cwDtXMrkAi1
 HmyA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=yLR+F5ZU
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="yLR+F5ZU"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, Jun 10, 2026 at 2:06=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Alexey,
>
> On 6/9/2026 8:26 PM, Alexey Charkov wrote:
> > Hi Jonas,
> >
> > On Tue, Jun 9, 2026 at 9:54=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> =
wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 6/9/2026 6:52 PM, Alexey Charkov wrote:
> >>> Modern Rockchip SoCs such as RK3576 require ATF to be running to prov=
ide
> >>> firmware services to the OS. To enable booting Linux in Falcon mode o=
n
> >>> such SoCs, add binman support for generation of FIT images containing
> >>> appropriately split ATF raw binaries (as is currently done by binman =
for
> >>> U-boot proper images), externally preprocessed DTB and a Linux kernel=
.
> >>>
> >>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>> ---
> >>>  Makefile                           |   2 +
> >>>  arch/arm/dts/rockchip-u-boot.dtsi  | 109 +++++++++++++++++++++++++++=
++++++++++
> >>>  tools/binman/etype/falcon_fdt.py   |  26 +++++++++
> >>>  tools/binman/etype/linux_kernel.py |  22 ++++++++
> >>>  4 files changed, 159 insertions(+)
> >>>
> >>> diff --git a/Makefile b/Makefile
> >>> index 4e5c1dd6a1c4..844e5adb7b31 100644
> >>> --- a/Makefile
> >>> +++ b/Makefile
> >>> @@ -1690,6 +1690,8 @@ cmd_binman =3D $(srctree)/tools/binman/binman $=
(if $(BINMAN_DEBUG),-D) \
> >>>               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> >>>               -a atf-bl1-path=3D${BL1} \
> >>>               -a atf-bl31-path=3D${BL31} \
> >>> +             -a linux-kernel-path=3D${LINUX_KERNEL} \
> >>> +             -a falcon-fdt-path=3D${FALCON_FDT} \
> >>>               -a tee-os-path=3D${TEE} \
> >>>               -a ti-dm-path=3D${TI_DM} \
> >>>               -a opensbi-path=3D${OPENSBI} \
> >>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchi=
p-u-boot.dtsi
> >>> index 4ba6a87e78ab..866a6ab654ca 100644
> >>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> >>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> >>> @@ -161,6 +161,96 @@
> >>>                       };
> >>>               };
> >>>       };
> >>> +
> >>> +#ifdef CONFIG_SPL_OS_BOOT
> >>> +     fit_falcon_template: template-falcon {
> >>
> >> Not sure it is possible, but this looks to add lots of duplicated
> >> content. Could we try to re-use more, e.g. is it possible to extract
> >> @atf-SEQ, and I also think we may want to support loading of TEE-OS?
> >
> > Makes sense, will try to refactor a bit to reduce duplication.
> >
> >>> +             type =3D "fit";
> >>> +             description =3D "FIT image for Falcon Linux with bl31 (=
TF-A)";
> >>> +             #address-cells =3D <1>;
> >>> +             fit,fdt-list-val =3D "u-boot";
> >>> +             fit,external-offset =3D <CONFIG_FIT_EXTERNAL_OFFSET>;
> >>> +             fit,align =3D <512>;
> >>> +
> >>> +             images {
> >>> +                     @atf-SEQ {
> >>> +                             fit,operation =3D "split-elf";
> >>> +                             description =3D "ARM Trusted Firmware";
> >>> +                             type =3D "firmware";
> >>> +                             arch =3D FIT_ARCH;
> >>> +                             os =3D "arm-trusted-firmware";
> >>> +                             compression =3D "none";
> >>> +                             fit,load;
> >>> +                             fit,entry;
> >>> +                             fit,data;
> >>> +
> >>> +                             atf-bl31 {
> >>> +                             };
> >>> +#ifdef FIT_HASH_ALGO
> >>> +                             hash {
> >>> +                                     algo =3D FIT_HASH_ALGO;
> >>> +                             };
> >>> +#endif
> >>> +                     };
> >>> +
> >>> +                     kernel {
> >>> +                             description =3D "Linux kernel";
> >>> +                             type =3D "kernel";
> >>> +                             arch =3D FIT_ARCH;
> >>> +                             os =3D "linux";
> >>> +                             compression =3D "none";
> >>> +                             load =3D <0x48000000>;
> >>> +                             entry =3D <0x48000000>;
> >>
> >> We should not hard-code these here, they seem to be RK3576 specific.
> >
> > Fair enough. Should probably come from configs.
> >
> >>> +
> >>> +                             linux-kernel {
> >>> +                             };
> >>> +#ifdef FIT_HASH_ALGO
> >>> +                             hash {
> >>> +                                     algo =3D FIT_HASH_ALGO;
> >>> +                             };
> >>> +#endif
> >>> +                     };
> >>> +
> >>> +                     fdt-1 {
> >>> +                             description =3D "falcon-fdt";
> >>> +                             type =3D "flat_dt";
> >>> +                             arch =3D FIT_ARCH;
> >>> +                             compression =3D "none";
> >>> +                             load =3D <0x52000000>;
> >>
> >> Same here.
> >
> > Ack
> >
> >>> +
> >>> +                             falcon-fdt {
> >>> +                             };
> >>
> >> If I am not mistaken we can already inject an external DT to be used a=
s
> >> control fdt during U-Boot build using EXT_DTB env, maybe it is better =
to
> >> use that instead of passing in a new FDT?
> >>
> >> We probably also want to use @fdt-SEQ and @config-SEQ to be able to
> >> dynamically load a config based on e.g. board_fit_config_name_match()
> >> that some boards already use to select config/fdt for U-Boot proper.
> >
> > Indeed, that would be quite interesting to have to make it all less
> > hardcoded. Does board_fit_config_name_match() also work in SPL?
>
> Yes, that is where I know it is currently being used for Rockchip on
> such boards, e.g. rk3566-zero3 and similar.
>
> spl_load_simple_fit()
> - spl_simple_fit_parse()
>    - fit_find_config_node()
>       - board_fit_config_name_match()
>
> And in U-Boot proper the board model/variant is mostly used to set
> correct fdtfile env var so that correct FDT can be loaded from e.g.
> fdtdir when doing pxe_utils booting.
>
> >
> >>> +#ifdef FIT_HASH_ALGO
> >>> +                             hash {
> >>> +                                     algo =3D FIT_HASH_ALGO;
> >>> +                             };
> >>> +#endif
> >>> +                     };
> >>> +             };
> >>> +
> >>> +             configurations {
> >>> +                     default =3D "config-1";
> >>> +                     @config-SEQ {
> >>> +                             description =3D "RK3576 Falcon Linux vi=
a ATF";
> >>
> >> This is rockchip-u-boot.dtsi, drop RK3576 specific parts :-)
> >
> > RK3576 is the whole world to me! :-D
> >
> > Will do, thanks for pointing out
> >
> >>> +                             fit,firmware =3D "atf-1", "kernel";
> >>> +                             fit,loadables;
> >>> +                             fdt =3D "fdt-SEQ";
> >>> +#ifdef FIT_HASH_ALGO
> >>> +                             hash {
> >>> +                                     algo =3D FIT_HASH_ALGO;
> >>> +                             };
> >>> +#endif
> >>> +                     };
> >>> +             };
> >>> +     };
> >>> +
> >>> +     falcon-fit {
> >>> +             filename =3D "u-boot-rockchip-falcon.itb";
> >>
> >> Do we need to export this file? the old .itb-file is exported because
> >> some distro build scripts or flash instructions still use the older
> >> files instead of the preferred u-boot-rockchip.bin.
> >
> > Yes, this is the file you would actually flash onto, say, dedicated
> > UFS LUN to preserve Linux-to-U-boot fallback path.
> >
> > I'm currently overwriting my main U-boot by `rockusb write-file 16384
> > u-boot-rockchip-falcon.itb` but in a normally working setup one
> > wouldn't want to do that, so a pre-packed image with the SPL and the
> > rest is less helpful in Falcon mode. The combo of
> > `idbloader.img`+`u-boot-rockchip-falcon.itb` is what I believe should
> > be used, with the former going to W-LU-A and the latter going wherever
> > there's enough space for a Linux image.
> >
> >>> +
> >>> +             fit {
> >>> +                     insert-template =3D <&fit_falcon_template>;
> >>> +             };
> >>> +     };
> >>> +#endif
> >>>  #endif /* HAS_FIT */
> >>>
> >>>       simple-bin {
> >>> @@ -260,6 +350,25 @@
> >>>               };
> >>>               };
> >>>       };
> >>> +
> >>> +#ifdef CONFIG_SPL_OS_BOOT
> >>> +     simple-bin-usb472-falcon {
> >>
> >> Do we really need this? As you notice the BootROM loader is not really
> >> optimized for large payloads, I thought using a 1-2 MiB payload with
> >> TF-A + U-Boot proper was stretching it, sending a full Linux kernel se=
em
> >> like a big stretch, as evidenced by the 6 minute load time?
> >
> > It's neat for CI workloads and quick testing to jump straight to Linux
> > without persistent storage or TFTP servers. I'm hoping to resolve the
> > slow boot ROM execution one way or another, maybe by poking some CRU
> > registers from boost.bin.
>
> On RK3576 the extra long load time could likely be improved by adjusting
> core clocks before/after DRAM init runs. I have not tried to figure out
> what boost.bin v1.03 does to improve UFS boot speeds but likely some
> clock tuning is going on.
>
> >
> > There have also been attempts at enabling opensource TPL on RK3576 and
> > RK356x, so if/when they land we would be free to adjust clocks much
> > earlier, hopefully making the boot faster. After all, it works
> > brilliantly when booting from fixed storage, so there isn't much
> > reason for it not to work from Maskrom, apart from the particular boot
> > ROM on RK3576 being capricious (not sure if it applies to other RK
> > SoCs).
>
> Based on testing on quite a few RK SoCs there seem to be a mix of fast
> and slow crc16 implementations, possible some can be due to slow clock
> speed, but I also fear a few are using a very basic implementation that
> starves even cores running at full rates.
>
> E.g. on my decent x86 labgrid exporter using similar basic crc16
> implementation loading 472 image of about 2-3 MiB could take 30-60
> seconds, and using table lookup, it went down to a few seconds.
> I can only imagine load times on some of the weaker SoCs :-)
>
> This is the main reason behind commit 9d3d4d619252 ("rockchip: Reduce
> size of ramboot usb472 payload"), removing 1-2 MiB zero-padding could
> help load time by several seconds, even on faster SoCs that normally
> does not have core clocks adjusted in SPL/proper.

Hi Jonas,

I've done some further investigation into why usb472 takes so long
(with my trusty SWD probe). Turns out the boot ROM runs a bit-by-bit
CRC calculation on the usb472 payload, which is not done for any other
boot mode. Since the sole core runs with the MMU and caches off, it
effectively hits full DRAM latency on every byte, and then it spends
dozens of instructions on every byte performing unoptimized bit-by-bit
arithmetic for the checksum.

The throughput I measured for this calculation is around 124 kB/s on
my RK3576 based Flipper One dev prototype. That's 5.47 min for my 39
MB Falcon Linux + initrd payload.

On a bright side: if the checksum (last two bytes) in the uploaded
image is set to zero, it skips the whole CRC routine and jumps right
into the uploaded image with no delay.

Thought this is worth sharing in case more people want to take the shortcut=
.

Best regards,
Alexey
