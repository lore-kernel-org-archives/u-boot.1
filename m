Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6A0606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BwVRtKx/;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CdIsP3Fd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAB4280F36;
	Tue, 24 Nov 2026 07:02:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rn9o-mfC-Yki; Tue, 24 Nov 2026 07:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E9AA980EF4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795503767;
	b=psd9u5PxZU6YkYVODpyWhLFiV9yttjJPv0VajpdmlGyfpKOFF21AEGc/Gxp8uRl0NwcF
	 dNgBWyn4JVybojXvJYx99uflVY2mjdU0+tlCc+gLljHbiPDKl6ufXrW4JsZ9sv+/6cKZX
	 wpaxV6JJez6ofEpxV0axm/A2wBsE11WVthF6xvyLrLkY/yhIbcOmJth81SoR0oplllcJ7
	 eEzfYHw3jMMqvTrrdlDc0rz1RI11WBTte8hbxIPAfYV5Wfpno9KE5HrOmhXUyugzthS0J
	 lVcyVvXr7tY3Z2s46Hjk1/hsh7A9rJZMjNRFrKEkCKunzMvNVqpaKX7HnnZ2EDAuIOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795503767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f58Xa2LqEG/xZVu3zZRvMo1vJRkRG5YFt8s7Lt+iIdQ=;
	b=FvyyDbsLPn2u02dZIU682DWm5E08Il/QJx4Wq8NxnOJTgUXCz6QpzUreocf0mmZsD4Pg
	 V/sCAli8wlmO7VNN/hD+qHdkD6RVyiZIQyFdF/WCEoO5JyOs6zgIBcJD7vw6zNNfr9yH9
	 38lnyfJUNeFv611UGLeL2W8D4bNwqDOI8BxeaSd8wR3pCSecr0mxkfEIjj51w0+oiDyLD
	 9GDPsU0ba4vOWcJTYWxz4b1rkyutTyJdcUbdLE8pf+rmNzmh2VAMkJnAiZW1WRrgNuq1D
	 ufrOlJxvOF3724yHvWa0XMc4AUUSj1zM9bKbpv47Vqgc5PZCqtA231qYpYPtKfpZumQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CdIsP3Fd;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795503767;
	bh=f58Xa2LqEG/xZVu3zZRvMo1vJRkRG5YFt8s7Lt+iIdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BwVRtKx/qIxGDTd7gU5vMenCn92mcrpNAsuZK8PpO6ZKBGaQ9GpQZZMj2GW3nqZBl
	 64zRm+mkD/XMwogTzNO7y6mbJFg+kPsCLpocB4VI+y7L42I2ZNtfy7O0elhA0YVfHC
	 vLAcoZPHugogdBOccWI0bmqmBZHIjbZJIcWg52XinMVK4nxaEcH6/o4mWNax261/wl
	 YzOfIQxmhJcy5T6O7Tf4OMe9sEnagPsYA4YZh9Y8zJWQaquUTz1swHjMxlvmVkM28b
	 PQcEfT8WhbIrhUuJPMtCClc61My/d5vj+fKO0Gc2bp5UuwDbjJ7LCoR0od6Lh49YeY
	 W7XCOPFYf0HSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9AA980EF4;
	Tue, 24 Nov 2026 07:02:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1297322B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FE9080EF4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3wP2Qm4nAXPN for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 07:02:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1308980E5F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=CdIsP3Fd
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1308980E5F
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:02:44 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so6623851a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795503763; x=1796108563;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f58Xa2LqEG/xZVu3zZRvMo1vJRkRG5YFt8s7Lt+iIdQ=;
 b=CdIsP3FdS985wIvahkyFwDQIsE5Acdw4Qu+/XwjaOAG9xvwDElBwcmt/qiqirgtgz/
 IohaUxCS/7IbwmAo/GO4ODI1WdYLTOMrnKvQWChZEahIkhaZHSGaJ3dfqKeb5yhTuTyZ
 Jo++H7pZAiK51uHtoob2IR1tfQ76PxluqZ0F+LulDwtunOmCJbi4Dy2ZA4lXgbM5QEXS
 wLTYOKllKq2wzeR4vhkPlrHq9yLVFGL6Zn5f1u3H6tpHYEREzViEOblmLJHKRs9awDgk
 5DBpwJrniWSHc9bjoVhYEU+ALk8L1/ggsBD7o4NVjYHqrvb6WreW4vZcThltt48p3oJQ
 iqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795503763; x=1796108563;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f58Xa2LqEG/xZVu3zZRvMo1vJRkRG5YFt8s7Lt+iIdQ=;
 b=NbeWmfOp5JGSjwUIHonmqfWKglbj0MLWXUWo/jJKBnoEaOvuTZWCqIMtVKzJz86Mdt
 CD3xGFPxTovGyNQsg48cV5cYjsHgjKk/VImjPMM/6JvUX2Qu0H5StaInlaaz+7s9Vijn
 pMdOHcxXXeE/urYl95Dr55bXDO164XCzz5/8qNlqc3gmVjThSDbkE51clDdFrMQ0saRQ
 BmMqxtuJxgG9GoOYHCIOEulyc2C3yIgX2WIrP30+W6/SoXYXsTsOxiWkaJBK68X9P1A6
 H9nL1WERiuggNl7lBq8EDLMi2S/a6tcR2f11VI72+zeILTQ9FxPy2M54S4gZ4/f8AyE3
 pQ7Q==
X-Gm-Message-State: APuU4Z8JLzQsIBhFhre0lDCEcxlJm2JZ4BGXnEgOyv6PsqZ02DF+/Ygo
 Ir1tJUudLGKi70z3T1lBA/g10ofmtpDOecQfNduFh2+RPJxdlfVufd8qD3YKFKi1sSbP82eMe47
 FNdZmlO/gxT6WB6xec6bc2325knIJBV8=
X-Gm-Gg: AZFdTZfN+x5kK5mP9+CxeNFDWSipD9UwZIjsVPKsshTLSoHTv3SWBUJSm8Piy2S3Y0n
 RjWetgYAukjZHArLDFLwJBuQay/P2JDTbW79nE0iSzbtEvzISm811zi2gdRohOh3p4R1iSuwVcN
 mD01peDOxP10PK6fnj4Qq8DeMKll6Fn5+J0GYAeGk0aUVTuKfbv/iZ8zmBVixZMh2gj9GBmOJ7k
 0VmDERgE2A8Qk1dyldyVm5TPCey8/cRSMhe2FiSdJIaIzz7x52jE/NQaiNRE1KIkQJqss20NLza
 GcXVVmW3/4s51apzmlIAUEGxZpkiwqXYf7UfPskMRdj/UIaQ11c2EX7Ewo7Y6onMhBnuzUMmgXa
 u1dwiGgbZ97RO2gOf87PvkZmlQDIeuYjeqy/G
X-Received: by 2002:aa7:c1d9:0:b0:6b5:8c80:d12d with SMTP id
 4fb4d7f45d1cf-6ba37e87eefmr7094564a12.37.1795503762912; Mon, 23 Nov 2026
 23:02:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123193714.5096-1-linux.amoon@gmail.com>
 <20261123193714.5096-7-linux.amoon@gmail.com>
 <DN38CNP2NRX5.2FYONBA01NUVM@pigmoral.tech>
In-Reply-To: <DN38CNP2NRX5.2FYONBA01NUVM@pigmoral.tech>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 24 Nov 2026 12:32:30 +0530
X-Gm-Features: Aa3M54rTIEgco2GTjdxbKxWNuZP52nRgJfjJzP6T5uM3hCUhv8VWzIlqccHQ5jI
Message-ID: <CANAwSgT2HJK10Ow1UOt=BOsrw5r5WGOUrFWrD6-7n7YFEwx1Dg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] riscv: spacemit: k1: Enable GPIO and pinctrl
 support in SPL
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.u-boot-project.org, Dave Klotz <DaveWK225@protonmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 E Shattow <e@freeshell.de>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Junhui,

On Tue, 24 Nov 2026 at 12:04, Junhui Liu <junhui.liu@pigmoral.tech> wrote:
>
> Hi Anand,
>
> On Tue Nov 24, 2026 at 3:37 AM CST, Anand Moon wrote:
> > Enable GPIO and pinctrl support in SPL for the SpacemiT K1 SoC.
> >
> > Select the SPL driver model GPIO framework and the SpacemiT GPIO
> > driver, along with the pinctrl framework and K1 pinctrl driver.
> >
> > These drivers allow SPL to configure pin multiplexing and access
> > GPIOs required by early boot peripherals, including I2C, MMC and
> > other board-specific devices.
> >
> > Cc: Dave Klotz <DaveWK225@protonmail.com>
> > Cc: Eric Chung <eric.chung@riscstar.com>
> > Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> > Cc: E Shattow <e@freeshell.de>
> > Cc: Yixun Lan <dlan@kernel.org>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  configs/spacemit_k1_defconfig | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
> > index 0f6e9284259..6c60ca789a9 100644
> > --- a/configs/spacemit_k1_defconfig
> > +++ b/configs/spacemit_k1_defconfig
> > @@ -121,3 +121,8 @@ CONFIG_USB_DWC3_GENERIC=y
> >  CONFIG_USB_STORAGE=y
> >  CONFIG_USB_ONBOARD_HUB=y
> >  CONFIG_SPL_LIB_RATIONAL=y
> > +CONFIG_SPL_GPIO=y
> > +CONFIG_SPL_DM_GPIO=y
> > +CONFIG_SPL_PINCTRL=y
> > +CONFIG_SPL_SPACEMIT_GPIO=y
> > +CONFIG_SPL_PINCTRL_SPACEMIT_K1=y
>
> As I mentioned in your v1 series, CLK_AIB and CLK_AIB_BUS are still
> missing from the SPL clock driver, but this patch enables SPL pinctrl.
> Once the pinctrl controller and pin configuration nodes are retained
> in the SPL DT and used by a device, K1 hangs during boot.
>
Thanks for your feedback. I might have missed it. I will check this.
> --
> Best regards,
> Junhui Liu
>
Thanks
-Anand
