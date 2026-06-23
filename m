Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5BDCDB471
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 17:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D48E6849C5;
	Tue, 23 Jun 2026 19:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nJVwIRsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A985849F0; Tue, 23 Jun 2026 16:50:03 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0323849E5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so8981226a12.3
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226200; cv=none;
 d=google.com; s=arc-20240605;
 b=lY5Yg8Z8MxbAMF/4FoFmOxTXM1vqfqcMjr9qbR+ckmqJjkR/MCtEdKRtejWEq5kR0r
 fBgegamHqdOSIaD6rtV+9ENIt00a51eq0V3LTFiN1e3A3enqnKjgAM+vZ1GZRAJzeaxj
 784Y5ZQ5RB1p8JlQti1eTqnnV1EG+rzC+g7H85ct7PCHQiyZkIVaemJ3fU3aAmzLQ84i
 Ip8RdPsMAnMr8Zbj93Q9GSl2oU81QQpogCIPWfCf9Cn2U5UDx5HLsfPvzY5JX84C1ifu
 wrIkVqP4UECBrKb1ZH6oa2k0y7tUaHtzIYIoovXf0fzLe+F8JxsRLWxwtkdy/sC8heI3
 FSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NO3F3n9p/0o+F60JLE3tMFWZ6tz6fJjZOdWh8u0PeE0=;
 fh=lcAyxsZ9JwtEGqPTrhtQVLZl2EY6xbKqEJeupciMXR4=;
 b=kSca0gJ0V26DIxxLizhaoV2wJJ6mkjQh2F1BPMMoB82CVbCu3viWQhMZvnPXfBr7Tc
 9LhUj+SHqUW4lhqTeSMtzGCRSA3QYm992MGnIPzxvqxetcFkbMNeifMUU/tXxby9NLt9
 f+28cgRsYkUqobi7M4XhDXt+3wqN/5ejL5YyPhmiMPWv8sHd+8ohaxCWfPc0hti55IWJ
 fbfrXz4BlsGOFUwlupVTpPRAyCiclzLRd2gDRanYM2cacO6kXedu6XiEahbupGpWvjVO
 7F71aoftYto+SYs4tImKeuNK8UF0TwKFyndK42IZcU2Kn2Jc8Z6pVhTCltuYBsWjWlQU
 EntQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782226200; x=1782831000; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NO3F3n9p/0o+F60JLE3tMFWZ6tz6fJjZOdWh8u0PeE0=;
 b=nJVwIRsypg8o7jEFXSCTcauy+TRpfoaWR7QGBBjURbb7IaKLjBa2lrpbaZPxj38kKw
 HixaWfVPlavTfi5JmBOLReHenRfcYAkR+6bblQVH+AJyN96u+uXZqh6V5GwpcIKXzA8M
 dfCqUFcJHwOimZ1LUutAbymU17jzubJjp5hF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782226200; x=1782831000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NO3F3n9p/0o+F60JLE3tMFWZ6tz6fJjZOdWh8u0PeE0=;
 b=iwOkxKRuS+GXHzGmhweP/F8mUpxiUMyPbc706vnbCZLm5KUcigw4cFhDYR2oz1MshC
 AESW9NH8XCK12nv1yJZRziwmt7gc/0bVmHOkw/LHy5EYA2cawgGKzHNAzRsVSXVaebne
 zu6qnHtc7zWacJ6NpXYXXxGj51b9M6uMPgWSrqqbvrj5clzHwS+beLCviutRomStGLm6
 KIQftlxHNBKs4/yIe+lin/rrwHwjDRpOF7DNqvkbueqKoxjr0KyLCIIiRVe9wJQXFXnR
 epT3e4IltmxYgC5Pt80wLTi0Mt8GV8rCKYzKcGUe4nw5MSeKMWsyprykWi2FdiEeYUpO
 F3/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pmG/OLIZqcw9WH/jvWK6MWejd5TqxbO/mAQKQpJmTSXQzVKW70D+o8HLMViY+0kqiOs0bGN0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4PNjCHOSp9VUaAllBjECGW0VrMtmRx0dg6wla5fS7L1pzVtZI
 wupBdfAcd/XWUwuCa44EkSxAljqKGppCFVvihoyO5S0HGWTcZb9+HfJliBNgdL6jUBmhkkkVgsx
 JH4bJLhtg5+FAS7kgyZvpMnI7soQWBUotLYZBalAv
X-Gm-Gg: AfdE7clZo52ireL4fAsb2+EeFE1VL3QHtJa68yiQTP+QikbMci8vxQoNCvyEOBsXEi2
 1MNFea6uRSmoJVmsZ0WzF5u8rrjEY0LH902DlPpTzSOKTJkQpDEnNDuLAuiHjqgkFKGbZYdr0HX
 u66zDghEcmOq5kT2sbTtrpCUzm0a76wgL+CoWoJygrKNixVlqXubDr5ygwaO2rOR5ezkWDtJPNN
 M4I1dhY0J2k7I+8QkwL1CnGeAlWoHG+PkLD5c7vAz0jIbAPRDAerOBzOT6EE3TSQSI97FkH2gcT
 nv50sJvg
X-Received: by 2002:a05:6402:5413:b0:695:bb9d:62ec with SMTP id
 4fb4d7f45d1cf-697dbad391amr1777932a12.18.1782226200139; Tue, 23 Jun 2026
 07:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260604093132.757583-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszTivKopo8v0v3yad5HCvSSaDygkQ-u7QJ5QR0WkKsTi-4A@mail.gmail.com>
 <aipOsPHycEvZLuV6@hu-varada-blr.qualcomm.com>
In-Reply-To: <aipOsPHycEvZLuV6@hu-varada-blr.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Jun 2026 15:49:48 +0100
X-Gm-Features: AVVi8Cdzh7qvZn04HtjTBsHBQZwN_Wn44rgqmd_I4Xz4UjNjtti6L-btpRZ3oY4
Message-ID: <CAFLszTjOUPXM6APT3W1XQF9YxbSKUwxz4E6NPqHjpZ7fCDPdUQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] binman: qcom: Add type definitions for Qualcomm
 binaries
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 alpernebiyasak@gmail.com, tien.fong.chee@altera.com, anshuld@ti.com, 
 alif.zakuan.yuslaimi@altera.com, afd@ti.com, marek.vasut+renesas@mailbox.org, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org, 
 andre.przywara@arm.com, h-salunke@ti.com, alchark@gmail.com, 
 dinesh.maniyam@altera.com, luca.weiss@fairphone.com, 
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com, 
 danila@jiaxyga.com, n-francis@ti.com, ycliang@andestech.com, 
 mateuslima.ti@gmail.com, justin@tidylabs.net, jamie.gibbons@microchip.com, 
 david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 bdklingerman@gmail.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 23 Jun 2026 19:44:54 +0200
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

Hi Varadarajan,

On Thu, 11 Jun 2026 at 06:59, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
>
> Simon,
>
> [...]
>
> > > +    Properties / Entry arguments:
> > > +        - filename: Filename of u-boot MBN (default 'u-boot.mbn')
> >
> > U-Boot (not u-boot)
>
> Ok.
>
> > > +    This is the U-Boot MBN image.
> >
> > It is good to have this etype, but please document it properly. We
> > need to know what MBN stands for, along with a link to the spec, etc.
> > Also please describe its role in booting.
> >
> > Please do the same for the others below too.
>
> MBN is a Qualcomm=E2=80=91specific signed firmware container that package=
s
> executable images (typically ELF) along with metadata such as hash,
> signature, and certificate chain, enabling the secure boot chain and Root
> of Trust (RoT) to load and authenticate images.

OK, please add this information to the etype...you should point to the
file format too.

>
> [...]
>
> > > +class Entry_qcom_config(Entry_blob_named_by_arg):
> > > +    """QC Config ELF
> >
> > Does QC Config mean Qualcomm Config? Is this a configuration file? If
> > so, why is it in elf format?
>
> Although the QC Config image primarily contains configuration data that
> could be represented as a raw binary, it is maintained in ELF format to
> ensure compatibility with Root of Trust (RoT)=E2=80=93based image authent=
ication
> during the secure boot process.
>
> The current implementation aligns with standard verified boot requirement=
s,
> however, support for full secure boot is planned for future enablement. I=
n
> that context, retaining the ELF format allows the image to be processed a=
nd
> signed using the standard Qualcomm image signing infrastructure, ensuring
> seamless integration with the trusted boot chain.

Hmmm, well probably we just need more docs and pointers to docs.

Regards,
Simon
