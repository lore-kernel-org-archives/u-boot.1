Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487F7CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 13:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39140871D2;
	Thu, 19 Oct 2023 15:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iHRrSsjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D38978718C; Thu, 19 Oct 2023 15:56:16 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C3978718C
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53db1fbee70so13431075a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697723770; x=1698328570; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rBskVBcMJUGDB/NzoAqkV+QNsqJwLHwU1DZ2chc/Fjw=;
 b=iHRrSsjQ6C/gsaRDgk1BDL9PiECy2542JolPFyOGbCEfYMHz+3n9Y1cULMSgcHtzcK
 JcFK0Skux6TlscXz0JbtAZWfcfxgDQwP+YOBHkYfJtQ47nTVSzhmjNJ3aMd8c2ECNILN
 INKSYeHxxZDBL4htcdiRjt8/5m2PS/uBOXpUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697723770; x=1698328570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rBskVBcMJUGDB/NzoAqkV+QNsqJwLHwU1DZ2chc/Fjw=;
 b=a5j2MD4zdlAIOyU13z4Cw1rWYYzs86fN8zTIqRCW2LCqlhoyasZy0cGZ3w7NvS9qSL
 1F7jznvZJ+LnQX6qEvwl+rllUoMArpjaGXRVXZF6Vq4tL0tD/fE6qVwq+qKXytLmFRbn
 85XajMlLnjSWprhLUwd7HrCs6bs1M50YvjA68frKuUaIjESKnIlzWNyBYUNr/gqRmDa6
 /baCJJJuDVb+n/+yVCWUPprOIAGO1N70eZfFIsDAl8EJ/OyyfAVA9VNtTcaGlRxjyRrh
 p9uuAjV1niu44HbJeE/3y1nCbVHSQlT0QMe5+IkSGLUAUlTOaU27nKyIMLN3YISX5/Uo
 YB/A==
X-Gm-Message-State: AOJu0YzOKfeiY0lbNUv7BXW1KEv4dQBXPOLo4gnbDesTW8CNNOiLaAMb
 eT4kzFmPxk9m7+662SRxUY8AIg5Cc/w0k3Y0V3vBQQ==
X-Google-Smtp-Source: AGHT+IEOkTSYtBEZ1S/JEh6pP9a6xV7s6Vuu0pTZabmF82Cgh+vMeBeZQW+a5ySzgCmfMdK0WHEnY7bUdG0kphKaOcQ=
X-Received: by 2002:a05:6402:34d3:b0:53e:9387:40fc with SMTP id
 w19-20020a05640234d300b0053e938740fcmr1671377edc.26.1697723769829; Thu, 19
 Oct 2023 06:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231006100737.343745-1-n-francis@ti.com>
 <20231006100737.343745-2-n-francis@ti.com>
 <CAPnjgZ2RAwdZxZMccwcLL5QLs-HyBcx6B=LLKfVSjSb0qpjGxg@mail.gmail.com>
 <c052dc27-e919-4f62-a104-4412954e7032@ti.com>
 <CAPnjgZ2RvujUiVrhpb-v7Z94JTyP=1e6ptc=mC7A6rVF9NZxdQ@mail.gmail.com>
 <cf363bf1-68ed-4fa9-8ac5-24326f774cac@ti.com>
In-Reply-To: <cf363bf1-68ed-4fa9-8ac5-24326f774cac@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Oct 2023 07:55:57 -0600
Message-ID: <CAPnjgZ0X_DMjaPkxKLHigugPVdj4hnLpsOUuNL9MudJRd4a3_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binman: openssl: x509: ti_secure_rom: Add support
 for bootcore_opts
To: Neha Malcom Francis <n-francis@ti.com>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com, u-boot@lists.denx.de, 
 vigneshr@ti.com, u-kumar1@ti.com, a-nandan@ti.com
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

Hi Neha,

On Tue, 17 Oct 2023 at 23:20, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Hi Simon
>
> On 18/10/23 09:03, Simon Glass wrote:
> > Hi Neha,
> >
> > On Tue, 17 Oct 2023 at 03:58, Neha Malcom Francis <n-francis@ti.com> wrote:
> >>
> >> Hi Simon
> >>
> >> On 08/10/23 04:39, Simon Glass wrote:
> >>> Hi Neha,
> >>>
> >>> On Fri, 6 Oct 2023 at 04:07, Neha Malcom Francis <n-francis@ti.com> wrote:
> >>>>
> >>>> According to the TRMs of K3 platform of devices, the ROM boot image
> >>>> format specifies a "Core Options Field" that provides the capability to
> >>>> set the boot core in lockstep when set to 0 or to split mode when set
> >>>> to 2. Add support for providing the same from the binman DTS. Also
> >>>> modify existing test case for ensuring future coverage.
> >>>>
> >>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> >>>> ---
> >>>> Link to J721E TRM: https://www.ti.com/lit/zip/spruil1
> >>>> Section 4.5.4.1 Boot Info
> >>>>
> >>>> Changes in v3:
> >>>>           - updated function comments
> >>>>           - removed inconsistency in setting bootcore_opts to 32
> >>>>
> >>>> Changes in v2:
> >>>>           - included TRM link in commit message
> >>>>
> >>>>    tools/binman/btool/openssl.py           |  6 ++++--
> >>>>    tools/binman/entries.rst                |  1 +
> >>>>    tools/binman/etype/ti_secure_rom.py     | 11 +++++++++--
> >>>>    tools/binman/etype/x509_cert.py         |  3 ++-
> >>>>    tools/binman/test/297_ti_secure_rom.dts |  1 +
> >>>>    5 files changed, 17 insertions(+), 5 deletions(-)
> >>>>
> >>
> >> [...]
> >>
> >>>> diff --git a/tools/binman/test/297_ti_secure_rom.dts b/tools/binman/test/297_ti_secure_rom.dts
> >>>> index d1313769f4..1a3eca9425 100644
> >>>> --- a/tools/binman/test/297_ti_secure_rom.dts
> >>>> +++ b/tools/binman/test/297_ti_secure_rom.dts
> >>>> @@ -9,6 +9,7 @@
> >>>>           binman {
> >>>>                   ti-secure-rom {
> >>>>                           content = <&unsecure_binary>;
> >>>> +                       core-opts = <2>;
> >>>
> >>> here ^
> >>>
> >>> Do you think there could be a binding file in dt-bindings/ for this value?
> >>>
> >>
> >> Sorry for getting back to this patch so late, but wanted to ask about this. I
> >> had seen a last version of getting the binman compatible in dt-bindings but I
> >> don't see it merged. Not sure where I would add this property in.
> >
> > Yes it is difficult to do anything genuinely new.
> >
> > I am anticipating something like compatible = "ti,secure-rom"
> >
> > so I suppose you could create a header file with suitable values for
> > this property.
> >
> > On the other hand, you could wait until there is progress with the bindings.
> >
> >
>
> I can try adding a header file for now, but follow up question; shouldn't it be
> added to arch/arm/dts rather than include/dt-bindings? There was traction by DT
> maintainers to move all such constants not directly used by the driver (in this
> case binman) to arch/arm/dts? [1] If you mean to use these constants in binman,
> will need to see how we can do that.

You can put the constant in the .dtsi and #include your binding file.
But if you hit problems, let's worry about it later.

>
> >>
> >>>>                   };
> >>>>                   unsecure_binary: blob-ext {
> >>>>                           filename = "ti_unsecure.bin";
> >>>> --
> >>>> 2.34.1
> >>>>
> > Regards,
> > Simon
>
> [1] https://lore.kernel.org/all/c4d53e9c-dac0-8ccc-dc86-faada324beba@linaro.org/
Regards,
Simon
