Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB36CA5FCF
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 18:07:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D74BD40B9A;
	Thu,  1 Oct 2026 18:07:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nMkrefPSabQx; Thu,  1 Oct 2026 18:07:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 59F9A40B30
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790878071;
	b=EaMNFabP/gPDslHi8zfl8kBGShV4wREWpqksyArZpEei/8czDuEQ+tIzrKmYEaHjGzCs
	 wPoB9jXdQm/VWW2JNjZ9xLTn/OuQFOTSQfdO2G6rdsOw4t9vrHRRrwUNYpCSR5JwTbnzw
	 ajiQATzeWklrW3IcEkW0ysUEAuk6TCCGV3eFA/LyBq0DDGwe+Lg8zSAOHVgGd00oFLu78
	 EObx6Hjp2h+00QB+25l0mRJnX6fEcmRaZsYGYS0JDlE6rnYxnJLQ5WV07l2ElilxVIAa+
	 oaH4v2ET7SOftJkkyYNGHh3v0PNKJsQkef/znyEQobE0AxxiPNxAUGwIXOeSKJK5N/A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790878071;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AqmblDSbUFtm679dafvu5hfbRhHPn7R+BK54In0SrDw=;
	b=EhALZVZGqCkStlt6sdmBuXxlnIl9VuN698Lda/mTwHHcZHgVKz9wzlONGxTalO9cXgxl
	 BmzYCPZI2grmAdfSpZGpzTm3DUFgcrN/gTzkOFcvQ7DDvm6TElCxM2JoVMyKjKI8Q9eIc
	 R1EZ9WADJXKezIK0oCgDANMpV/YHssMYgwxuoBnIQC/gTu4ZfMLA/u9vVlwkrGh0fCEI3
	 FZTZcyUbtbZPOKlTNk53r6P1kckYBWr4BKojyTL8jn8e8+IMQ89k+ZUjtCsjygQx96onQ
	 NEU99RBKXptyMYvp9eaN7GvDFN1K9b7Met93vANHFmDpLRgNuzHNhTm0waVjyiVAvLw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790878071;
	bh=AqmblDSbUFtm679dafvu5hfbRhHPn7R+BK54In0SrDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y9svqBbdWYOiU0WfForoXGPyJGsiMnMdRdz9DBNWlUhKE2b0Ts76JA195yyyW2Z8n
	 FEGgiGD8xQOliaCBUcYp5slkthvZNfDJOuc5aHFmMjmlj/KfXOFjXkEu4xTLExrhYJ
	 RmI4pwt1JuX60vApYb1nki4tu7TZH6yiNRy1pImTMF5AE/3grbiBFRCfAHigTlQa+z
	 h6L4ixGjhUN2QYKjdjuQ/uOTVLXKughkFNRxWT/7phpmVKyzXkMgLKRhIEUsIHOci2
	 B1c2QFAvKu7VcV8nyb0TZPglAP7eG6iRcAVde1THeyXuFawQS1344eMbVeoy/WttIS
	 WAjnAJd20fJrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59F9A40B30;
	Thu,  1 Oct 2026 18:07:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 770AA282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 18:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68DA581089
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 18:07:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r8ndbQAFzujD for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 18:07:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 517FB81086
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::2a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790878069;
 b=jUPNrOjC++sskfUuwn4PsSpPL3ycPQve3CND44f5kS1MWAuR6yzBmlGgp057hW+hc5zT
 Ichck5HaHatRbPqZaTAnc8n68Vp2kbAJr2Ybzwr757/cITXp38H17y68kDuBNHuugCHxa
 rVh1zauRyaSAvdbTvPMsqnCDlKKZkdY7g8QZrocECjBkSv1lqdFCNtLIMty0U614gKHNk
 toIGN05JbRxoSYsxGP8rlAkTKxdKE5JySknODIwlVeQHtzdwmvBDVLdJlla9mXqotHnf4
 6YdTADYFljImnhSBfacyzX9PZDigBiNTz+tNI9qMsfeUDur1CVFqueISmimErv2KVRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790878069;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=AqmblDSbUFtm679dafvu5hfbRhHPn7R+BK54In0SrDw=;
 b=NBO2NGpDLy2KaO3Op8jAu/LQTuERykft3WtE18/20eugM5uDvPS2xqGhk+xfA5j3qoc/
 YVHW1UB656gzK5kr23lLrksvhbhO04XkiVk4fR6HH5ZOee5vhwyZcdz2yKfrp9Mf0WTTS
 uFrYZYZ1ys8PLpOd296gbDp50/88Ha/Kqyg3VvhsVs81gNCsG/L1e2GBjz95t7WD8TyvC
 e9pZc1MoIhHsyjsP6noP3rK9RHQp3MUsfB+lZcikGpx7KdTPXGdV8nuarfQHHrcgEwt7M
 7WGXkF+Ai229DCUm9fx+z9+G2zceWJFfe3H5391FF11h5U4HwmVXz0b5CF0iqpY5RYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xZT+lxzc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::2a; helo=mail-yx2-x2a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xZT+lxzc
Received: from mail-yx2-x2a.google.com (mail-yx2-x2a.google.com
 [IPv6:2607:f8b0:4864:41::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 517FB81086
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 18:07:48 +0000 (UTC)
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ab408a38bdso16608697b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 11:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790878067; cv=none;
 d=google.com; s=arc-20260327;
 b=naTbgXg+gE1wTDMeqILgD7gdt1nK2A+8embhpC6D3bCUQAti8TULdsfqgYvfNXQqlv
 3mmkUi7AFFAmRHnxezYR6D0RpwgqDdxYYWI0tpX+IRrROKcx42UzYi+tfNo8fghi9PjB
 ScPvg7VIvJWuSY8fBsXD8vlXFea8lyNoC/914smClEqLqj4g8jCv2TasjNUL+I1gZmuw
 ttIiPhR2TC04N0J+g/IW4wHCtB8z1yi2q1kLSbQTRWHHnYqjI6ycRettg11U9pEeuX+3
 hbbxldM76AblE15vGVs3kxZFPegtyZmB1zCsprVAW6PE7dF4qCBf9YSdFkvTTptfMeMm
 pd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AqmblDSbUFtm679dafvu5hfbRhHPn7R+BK54In0SrDw=;
 fh=t4XXbWIBXSJ5nkLSW0fFOvWlYyMJMGKoT0o135yG9YE=;
 b=iZiljSN5xg5FhaGpzcgQ/isN/ZD+gjhxdAO6aiKE6idwuUnuaHEMGpDfSWmhr5renT
 VkE7bLwj4gpE0qfLwtmPwc33k4T66ILzixJTUEqB1/PhT2vIdJb1qdeVqUkHvDcsnOiA
 FZ8wg5qls5amVw69l/DEuFVs80OPVU32+Bullsdm9aFzFKNnEmN1wE4MyY+giwFzVxqd
 vyBYPAWMxhAkgRYv0ZFLzNnfmns0iJ6UJPiCwA7V3RV0FhD0lHLaTK4Ufw583aByxYHP
 NpKqoYGyxjgnn9X9rPQw8mE+BU2gYAAytAwWKbWC3kY7RGjtoduuTGA+0bVtg2xnp9Bs
 /izQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790878067; x=1791482867;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AqmblDSbUFtm679dafvu5hfbRhHPn7R+BK54In0SrDw=;
 b=xZT+lxzcs+VwyRNxJXWWFA46U0T/AYw2h9F+s26063na1r0eiJImc5Wi/G6jVSnceW
 NI/EtjVJjcWgJLk/X7OrQ1/UoC0p1gk/RsUmvJBEY0+GRGkRbEnAPbIvXsCjeP4UlNXg
 wDHVdfinFad3Iqg+Z1Cf/d1CkCeYFZIkp7s6MJksi0UHU2eFVIbMdOS6RowK6DdMYUKy
 JdaVXQRCsLw2uICLEnpyOTD00IecoyfOe1GiJII+CozHP0wO8JMyKBcPuotAxDf8yZVa
 9MkJmIs1bbsSa2jquGOV9uebYDGhywE/7TlqVFubUgLjZCfhpxDcvU9n/9t+ZNO22XC0
 k1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790878067; x=1791482867;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AqmblDSbUFtm679dafvu5hfbRhHPn7R+BK54In0SrDw=;
 b=lUoq/OE8fgwKKdoMrpVBfF7PlaUD/LgftNd1LDM66t/N8t+TfIL2sX2iKNjeWO3AhM
 +CAqh/Mpad1zgWYrYgFi9r04fIxwFfFMszWGSPVYPONe6k+iNz+injPIpnuyulselA/9
 8I5JFy7J7VAT+ePnBrH0lLK3duIo3qcn1sM1xUNf6roS1L3qh3qgb/9xjYhN/VeRx582
 xULJRz/oJazVB3lRorDs1gPWB079mCcVXNg9aNGmTEvOgpgASCaRXYE4be4G1KtEQPcq
 Bkh88tUtMKBq49QujTzqRd/zASxYOj/TiH7kUeL5o3WMRlK9PmJe4EkoS5OnmSoM9UFl
 yFtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+6Miv5sxhYSQRa8WevBvT6JCUhRQ0/C0w/TaG1R791j+mMaxHK4u0TI41YkwDtoJZz8IwGKg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJIGEx1k57r8zoT2IgW+MLU8NVTKaufvZtm3YEzsHK4T1NyBBWs
 L5QZ2o7V93Jj+u62Oy5UTemjDs/tA+j2cIDet2VoTuEGXQrELhuFKScqD0iX8Qi6QbnInK0dbe1
 Kou4/k6UCPGzLTFHfPD+8i+Ni0O8lhM8fgduKhJ/fCQ==
X-Gm-Gg: AYBFou17eggXE6KX/vXEzUULuRc2E3mZJqb5xg66ku6RhtPLp0DwPebkc3bqku48buG
 ZTz6EdN0dROi9UjalhfDJbYdgYSBJUduyO7y/k/KeK6Sy/UN58+PIqxFp4jeGY4kHF/9A4pEvZH
 Si0UrAQLjwEyWMCaqWw+BPbxfrzjz2uLlc958saDymm+d7hUy8SkgOwPEmUg/75Pkj8Guxhrema
 9E3hNmRwRMLFSc1yASlSFhpn3VAfuFm0JwtTSSgEnUJvq+PnF4fxLVMr1MSO/8O567APEV9RjQI
 7C/mupxp5vMQysx7mRl7xjelOTkRAZjmnqGPQtKdbyw97+s6bQ5jahlF4Aw4aWi8dlt69jQHsPp
 /PH/wxJloF8Xf9HLOwi58881NXkXajq3TtXvk2xyKxC01k12zo/5d+6CW8Z+ZsJGQFWdEhGhiMj
 I5ulk/N+P8DihcmslsyT14J/4jDm+lQ07wuQH5J/pXjWRh2xdc34yzRHiCBkacCo+Xwrz06mAf+
 DWqDN1+6N+4IHbJg4XvLGLEGemYv7zijH6rgrCqAOhoveq8CsXpsB6L9w0UpvVYuPd1+9fuO8Eb
 EG4kccaq5VTBTIka2iGxpvOZtxlMuPXGsA1GdacyycDIo9BmjRxDdCRc+wWQ10XZPx+oGkbkjx8
 W9494dWkHj7OfgcLpOb3H0eGMpdeN9dgQzEe+niXTwFWPcTKivllIaw==
X-Received: by 2002:a05:690c:5811:b0:87f:32fa:aa08 with SMTP id
 00721157ae682-8ae39c0cd92mr321017b3.14.1790878067072; Thu, 01 Oct 2026
 11:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260930090512.52342-1-michael.haener@siemens.com>
 <CAFLszThPOmn6Z3hA6H1r812kKdEWxtv_RV70BNW_w5U0M1TBDQ@mail.gmail.com>
 <CAC_iWjJqezM8j=5jcAA8w9ApNP5b+pqC=CkRxEA8mqdNCu1RFg@mail.gmail.com>
 <CAFLszTgXVSKxOhdmgGqUG=YEyekP=3jtz=AtHF4zD8Y_CKY50g@mail.gmail.com>
In-Reply-To: <CAFLszTgXVSKxOhdmgGqUG=YEyekP=3jtz=AtHF4zD8Y_CKY50g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 1 Oct 2026 21:07:10 +0300
X-Gm-Features: AclHuK8VdMGvfiIFJgNDilFbp16fc58-yKtnm_cD7UKXWUYXPG5CrS4VUuYs-9I
Message-ID: <CAC_iWjJ+4G_u6sCPcM6HMhVRcnkmGLSaAYHkOScy5CVSDrpS_A@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
To: Simon Glass <sjg@chromium.org>
Cc: michael.haener@siemens.com, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Simon

On Thu, 1 Oct 2026 at 19:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 1 Oct 2026 at 09:41, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi all,
> >
> > Any reason why we can't add this directly to the uclass probe instead?
> > According to our docs, the probe is supposed to 'make a device ready
> > for use'.
>
> IIRC we talked about that a few years ago. Probing a device is
> supposed to get ready for using the hardware, so we typically have a
> separate operation to actually talk to it and get it into a particular
> state - otherwise just probing the device would take quite a while (it
> also means that TPM cannot be used for certain things after init()
> unless the board is reset!). The same approach is used by the
> keyboard, for example.

I am not sure I follow this one. What do you mean after init? The TPM
is only supposed to reset with the CPU.

>
> But given that this keeps coming up, we could perhaps provide DM
> support for this sort of thing - it's not obvious the best way to do
> it in a generic way, though. We could have a DM flag and perhaps send
> an event that the TPM uclass picks up on?

What would we we gain from the event vs just initializing it on probe?

Thanks
/Ilias
>
> Regards,
> Simon
>
>
> >
> > Cheers
> > /Ilias
> >
> > On Thu, 1 Oct 2026 at 11:20, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Michael,
> > >
> > > On 2026-09-30T09:05:12, Michael Haener <michael.haener@siemens.com> wrote:
> > > > tpm: Add an option to start the TPM during init
> > > >
> > > > Add CONFIG_TPM_AUTOSTART, which runs the TPM startup and self-test
> > > > sequence from an EVT_LAST_STAGE_INIT handler. This is the same thing the
> > > > 'tpm autostart' command does, but it does not depend on a boot script or
> > > > on the environment, so it cannot be skipped by a stale or edited env.
> > > >
> > > > Today a TPM is only started automatically when either CONFIG_MEASURED_BOOT
> > > > is used (and then only from bootm) or when booting via EFI with
> > > > CONFIG_EFI_TCG2_PROTOCOL. A plain booti/bootm therefore leaves the chip
> > > > uninitialised and the OS has to start it itself, which Linux reports as
> > > > "A TPM error (256) occurred attempting the self test". Boards have worked
> > > > around this by putting 'tpm autostart' into their environment, see
> > > > board/xilinx/zynqmp/zynqmp_kria.env.
> > > >
> > > > Boards that share one binary between variants with and without a TPM
> > > > fitted can enable this safely: when no TPM device is found the startup is
> > > > skipped silently.
> > > >
> > > > Signed-off-by: Michael Haener <michael.haener@siemens.com>
> > > >
> > > > drivers/tpm/Kconfig         | 15 +++++++++++++++
> > > >  drivers/tpm/Makefile        |  1 +
> > > >  drivers/tpm/tpm_autostart.c | 33 +++++++++++++++++++++++++++++++++
> > > >  3 files changed, 49 insertions(+)
> > >
> > > This seems like a good way to enable the TPM for boards that want it.
> > > It would be good to document this somewhere, e.g. where we mention
> > > MEASURED_BOOT
> > >
> > > > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > > > @@ -0,0 +1,33 @@
> > > > +     /* A board may share one binary between variants without a TPM. */
> > > > +     ret = uclass_first_device_err(UCLASS_TPM, &dev);
> > > > +     if (ret) {
> > > > +             log_debug("No TPM found (err=%d)\n", ret);
> > > > +             return 0;
> > > > +     }
> > >
> > > It seems odd to ignore an error in this case - if the board maintainer
> > > says that a TPM must be present, then I would expect U-Boot to fail if
> > > it is not.
> > >
> > > In any case, uclass_first_device_err() also fails when the TPM is in
> > > the devicetree but fails to probe, e.g. because of a bus or GPIO-reset
> > > problem on a board that has the chip fitted. That is a real fault, but
> > > log_debug() hides it. Please can you stay silent only for -ENODEV and
> > > use log_warning() for anything else?
> > >
> > > > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > > > @@ -0,0 +1,33 @@
> > > > +     ret = tpm_auto_start(dev);
> > > > +     if (ret)
> > > > +             log_warning("TPM startup failed (err=%d)\n", ret);
> > >
> > > tpm_auto_start() returns a u32, which may be a negative errno or a TPM
> > > response code (e.g. TPM2_RC_INITIALIZE). A response code printed in
> > > decimal from an int is hard to match against the spec, so please use a
> > > u32 and %#x here, as report_return_code() does for the tpm command.
> > >
> > > > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > > > @@ -0,0 +1,33 @@
> > > > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, tpm_evt_autostart);
> > >
> > > This is not really a driver, so lib/ (next to tpm_api.c) may be a
> > > better home than drivers/tpm. What do you think?
> > >
> > > Please can you enable this on sandbox and it would be nice to have a
> > > test in test/dm/tpm.c, checking that the TPM is started after init and
> > > that a missing TPM is handled. Your test could send the event.
> > >
> > > A full self-test on a TPMv2 can take a noticeable time, so the help
> > > should mention that this adds to the boot time on every boot, even
> > > when the TPM is not used.
> > >
> > > BTW, since the commit message mentions
> > > board/xilinx/zynqmp/zynqmp_kria.env, you could convert that board in a
> > > follow-up patch to show how the option is used.
> > >
> > > Regards,
> > > Simon
