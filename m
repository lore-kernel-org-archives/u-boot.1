Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00277C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 17:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56490871AF;
	Wed,  8 Nov 2023 18:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="0D6anMod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D12687254; Wed,  8 Nov 2023 18:38:48 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BAA0871A2
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 18:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=palmer@dabbelt.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b2e73a17a0so4424229b6e.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 09:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1699465123; x=1700069923;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=H/8Wl3VTM+/pWShRUtnnlnKq3nN4vXkPGC8bNEaFnbI=;
 b=0D6anMod2JdYecgHKU7SbxoqrNEF+mf3vzwDgamcfzA4IrXLDmsc4+G6mxELavTRaq
 nzcy8QVbYmNueYvayIJhc3AduqNs85MupQ5txn/tkLbs3XHqqu2anhEJSZNZkt/J8+25
 ARnd6SaSwt0zdtBLevvIOOzCs0AcYh+HClgH/iJ46jUPHxKC6ywgByJPQRomCcCjg++a
 J8dINOKfLEBPaUZ1G7gNm8GYpOJqM5QRuOx7ReXw1h4ZhW1iRgLg781B3N9uK3/g8F5m
 m/obemflO+iVwbL2HPcDtvWjVdbbPSQKaDZnTOp+g1Y0FPTFVnRnNNL5KqoDBVR3QcIo
 D7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699465123; x=1700069923;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/8Wl3VTM+/pWShRUtnnlnKq3nN4vXkPGC8bNEaFnbI=;
 b=v1MA1T0OOSO8V9eGIU0/RBBqzOiX1mEo6ys09l4x8NhNn4ijiIBppUIdQgPEfXgwSM
 uR1N/Ngo1MlJLfLdcbNM3huJyWdcJyRToq04XpaAK1838PO0aP0XmzNAQMm0JvNP288U
 tOTKXWliJPVYGe/u33uFjVml3JXS7QPh94C0190aHuFWvYSPJ82mVbHJj5Wa2sgtVSoN
 yvJCxT8aDiNvYbpTSTwziua9+6lnSi2muFgYlpB6wkzpacvSQEiTM2/yumTrzi4QomJQ
 K2s8o8xGBC7TtvfBcOUpCOXRPK5PGBlp47qKdmiVWW+44g1DiuYAH/c794qf8bZ6vSDl
 cAUQ==
X-Gm-Message-State: AOJu0YxTKW6NFlKIrXlOfoapwSXp00bscw7TNgL7R8oRil48eSr5lQw7
 ONsU1dXIS7fH1O9PCqdE1dvrpQ==
X-Google-Smtp-Source: AGHT+IEgfON8dsrVtEIPKobBL6FUVTMY0WIm94uT1mw7jJXu5CCPe5PLdO0dY3gxuKq6UNFSpYvRTQ==
X-Received: by 2002:a54:4004:0:b0:3ae:2024:837b with SMTP id
 x4-20020a544004000000b003ae2024837bmr2682393oie.34.1699465122634; 
 Wed, 08 Nov 2023 09:38:42 -0800 (PST)
Received: from localhost ([192.184.165.199]) by smtp.gmail.com with ESMTPSA id
 u5-20020a056808000500b003ae51628725sm1972215oic.13.2023.11.08.09.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 09:38:41 -0800 (PST)
Date: Wed, 08 Nov 2023 09:38:41 -0800 (PST)
X-Google-Original-Date: Wed, 08 Nov 2023 09:38:39 PST (-0800)
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
In-Reply-To: <20231107-audible-undoing-293506af3890@spud>
CC: trini@konsulko.com, robh@kernel.org, sjg@chromium.org,
 andre.przywara@arm.com, 
 heinrich.schuchardt@canonical.com, rick@andestech.com, ycliang@andestech.com,
 apatel@ventanamicro.com, 
 merlew4n6@gmail.com, chanho61.park@samsung.com, sughosh.ganu@linaro.org,
 u-boot@lists.denx.de, 
 Peter.Hoyes@arm.com, avromanov@salutedevices.com, ilias.apalodimas@linaro.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-6682c062-a0e0-4811-8315-54a653c0e540@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On Tue, 07 Nov 2023 15:12:16 PST (-0800), Conor Dooley wrote:
> +CC Palmer
>
> On Tue, Nov 07, 2023 at 05:38:37PM -0500, Tom Rini wrote:
>> On Tue, Nov 07, 2023 at 10:27:50PM +0000, Conor Dooley wrote:
>> > On Tue, Nov 07, 2023 at 05:10:23PM -0500, Tom Rini wrote:
>> > 
>> > 
>> > > further clarify or not
>> > > the RISC-V ISA thing that's elsewhere in this thread (and part of the
>> > > kernel, not a U-Boot thing).
>> > 
>> > TBH, this a bit fragmented across threads, and as someone that hasn't
>> > been following it it's a bit difficult to tell exactly what is being

Also just kind of jumping in: I don't usually follow u-boot stuff, but a 
few of us ended up talking abot this.

>> > asked for. Would someone be able to ask it as a direct question?
>> 
>> Sorry for being unclear, and thanks for asking. What I think the U-Boot
>> community would like to know is, what is the device-tree based way to
>> know if a RISC-V platform has the Zbb extensions
>
> For this one, it's pretty straightforward IMO - if riscv,isa-extensions
> contains "zbb", then you are safe to use those instructions. My
> understanding is that relying on getting illegal instruction traps is
> not a sufficient test for usability of standard extensions, as a vendor
> extension could be using the same opcodes as a standard extension.

Not just could, but we've got systems that actually overlay 
vendor-specific behavior onto the standard encoding space.  There's a 
lot of small offenders for things like errata, but there's also stuff 
like T-Head where huge chunks of space reserved by the ISA for standard 
stuff gets reused.

>> so the RNG opcodes,
>> similar (in concept at least?) to the ARMv8.5 RNG feature.
>
> The ordinary extensions that are instructions - like Zbkb that provides
> bit manipulation instructions for cryptography you will be able to rely
> on riscv,isa-extensions also. Zkr is actually a CSR acting as an entropy
> source and is a bit more complicated. RISC-V Cryptography Extensions
> Volume I, Chapter Four [0] is the relevant thing for use of the CSR
> provided by Zkr, and it says "The seed CSR is also access controlled by
> execution mode, and attempted read or write access will raise an illegal
> instruction exception outside M mode unless access is explicitly granted."
> My take is that either the SBI implementation needs to provide S-Mode
> U-Boot with an accurate devicetree (including what extensions are valid
> for use in S-mode) or if the devicetree is provided as part of the U-Boot
> binary then it needs to match what is available at that privilege level
> on the platform. In this case, you would also be able to rely on
> riscv,isa-extensions for that detection. There is an existing dt-binding
> patch
> <https://lore.kernel.org/linux-riscv/20231107105556.517187-6-cleger@rivosinc.com/>
> that adds Zkr, and my proposal would be to document that the presence of Zkr
> explicitly in riscv,isa-extensions means that the bit in mseccfg.[s,u]seed
> has been set so it can be used at the current privilege level.

FWIW, that seems generally viable to me.

> If that's not acceptable, and people think that having Zkr in the
> devicetree means that the hardware has the extension, regardless of
> usability at the present privilege level, then IMO we need an SBI ecall
> defined to request entablement of the CSR & report as to whether or not
> that was possible.

I think we can start without the SBI interface, but I'm not 100% sure.  
I was worried about writes to "seed" somehow resulting in an information 
leak, but the spec says "The write value (in rs1 or uimm) must be 
ignored by implementations." so I think we're safe.

> I'm not sure how any of the above lines up with the ARMv8.5 RNG feature
> unfortunately.

All I know is what's in this patch set 
<https://patchwork.kernel.org/project/linux-arm-kernel/patch/20191019022048.28065-2-richard.henderson@linaro.org/>.  
It looks generalyl to me like the RNDR bits in 
"cpu-features-registers.rst" would coorespond to "Zkr" being set in 
"riscv,isa-extensions" -- we don't have ISA-defined feature registers, 
hence why all this ends up shimed in via DT.

>
> Cheers,
> Conor.
>
> 0 - https://github.com/riscv/riscv-crypto/releases/tag/v1.0.1-scalar
