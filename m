Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71D7C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 13:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F42180821;
	Sat,  8 Feb 2025 14:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GUvMqPA+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1729D807F1; Sat,  8 Feb 2025 02:08:19 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC6B880737
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 02:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-308dc0878dfso5227891fa.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 17:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738976896; x=1739581696; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uPMu7HGsBCGRvYRGV2dBZP4BNMOQ22p1dANGysS36gc=;
 b=GUvMqPA+cIpAa9qxSYNTJ9DzMI81l/po8+wET8r7cx+YX1t/XRoRJQ3e9wRC2Q948V
 WhB/++ICQrQWLMHqcGcKoEE9+T7TzGFPZ3bxCTi7IKDtyHOrDjVmWCpeF0pUJ77Y3cy/
 WsS7UhT65D/QXPlM8CF2Fcbo/7NXAUcrKBWWyVI3bR8I+1n5DiDSODHWJylDO3Eo8fId
 T2dB9LqOyjLpVOf0Mm8Ek4R4ft0H4A8d+l1QLOcuVaGjKOWaA0oAd5/9TT8N2zvvLwqF
 2+b6xcqKClQcsXs7HFxvCmPMsm23Y83ssfk/zWdlzlKwlsQQtAvgB63+V8po2yXo+FO9
 ADcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738976896; x=1739581696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uPMu7HGsBCGRvYRGV2dBZP4BNMOQ22p1dANGysS36gc=;
 b=hwhdsl+g3ABe2isTi9WubxZD8e6b/EL5kqlK/Sg1XXhdk5mEbSYv8hEH4bmq5FdWPw
 nZha96B8GDuLK6nSYjbCOFVmv2qaSCpW5PuHMZNJBqHTwAkDZRqdmjoL4shhBflSjeSz
 TOmhgBsGXiqqvgjkObF0ouYCauwvnrWnMjeSROGBYtzzLsu6NB5ewxrkezHQ9YVfdpj0
 gUDWbD3bi+4l3UcstM4TCqGsjboyiwby1wsBSoqlXQYuyb0XvXMGFDqQejVO9lp5UYeU
 J5KFzW/p0HYHJGKohL5aA2MqETLtx8fhi1hhyH4K9yJJMWd6IE+3gomvbehjC+aGOEh3
 JIcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIli+tA4gyLjfitN9MA6iQuNMULKAva3udeDAk2xnzO2V6sgYJbWGfymNcjrcupmbGTeuNsL4=@lists.denx.de
X-Gm-Message-State: AOJu0YxH9g2xU8zPtxQy5BUHCeWaNvmimCCD0Zcxp6WYAg0X86kDLTXW
 2AFjZhiuGVRbIVMxKD1ucVKQBEKJ8VDKKI9cTdX0bCYxcCk3Z2AxoUWCtcpRok4wqOpoUb6LKim
 0osoPOgsjBqeGJbUwu1/tTKeF1pFy5tH0
X-Gm-Gg: ASbGnctm5rxcwO2zK1xmODebLbt+4YqbDEvBlx/AlAFiK8YGLB4a0heh49cY7y5gNH3
 tnSpo1w66eVB29MJs95PlpLXsHYmDuWGFs0m+6jXcOxRMmm0Duy2tgg95Gulo+rG+Nfon2ndd
X-Google-Smtp-Source: AGHT+IHYkQa36r0ncyCXMKparAxVnMU2A7xmRjGF9rCXalh76MJuVKvgZqSd+nDeB+ch9db/l692VN5OU+KWT6Gj4Rw=
X-Received: by 2002:a2e:a808:0:b0:300:3307:389d with SMTP id
 38308e7fff4ca-307e57f2b02mr21088471fa.19.1738976895726; Fri, 07 Feb 2025
 17:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
 <20250207172116.117749-3-heinrich.schuchardt@canonical.com>
 <CANV2PTPnRpSdiK744_yFuDwOVUj4Vha_vQjtd8Zd1toYe_Ujng@mail.gmail.com>
 <CAM=mAO=TNkYaCFX-7T-VuLbM7coWpAR==ZnYfJ2zJFHLXT7eiw@mail.gmail.com>
In-Reply-To: <CAM=mAO=TNkYaCFX-7T-VuLbM7coWpAR==ZnYfJ2zJFHLXT7eiw@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 7 Feb 2025 17:08:03 -0800
X-Gm-Features: AWEUYZncKY3Z88ptsUYfyjQX5nhB-X_7TUJACo4suTUtnDg-z9KtV1WJEKddT9c
Message-ID: <CANV2PTP4Fb2w0S1=j_Do3T3s+5gNZDw9K+t4SeO7vmeUWPNukw@mail.gmail.com>
Subject: Re: [PATCH 2/6] riscv: dts: starfive: DeepComputing FML13V01 binman
 config
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>, 
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>, 
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 Nam Cao <namcao@linutronix.de>, U-Boot Mailing List <u-boot@lists.denx.de>
X-Mailman-Approved-At: Sat, 08 Feb 2025 14:32:37 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, Feb 7, 2025, 10:33 Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

>
>
> E Shattow <lucent@gmail.com> schrieb am Fr., 7. Feb. 2025, 19:12:
>
>> Is this use of filename preferable compared to a cherry-pick commit
>> of/from dt-rebasing?
>>
> The upstream device-tree is already meged into U-Boot. The entries for the
> new board matches how the other boards are implemented.
>
> I do not understand how cherry picking of patches  might be related to my
> patch series. I would not even know if you relate to commits in U-Boot or
> in Linux.
>
> Best regards
>
> Heinrich
>
>
>
>> On Fri, Feb 7, 2025, 09:22 Heinrich Schuchardt <
>> heinrich.schuchardt@canonical.com> wrote:
>>
>>> Add the DeepComputing Framework motherboard (FML13V01) to the binman
>>> include for the starfive_visionfive2_defconfig.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>  arch/riscv/dts/starfive-visionfive2-binman.dtsi | 17 +++++++++++++++++
>>>  1 file changed, 17 insertions(+)
>>>
>>> diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>>> b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>>> index 4cce001e80d..63289405fbb 100644
>>> --- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>>> +++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>>> @@ -16,6 +16,16 @@
>>>         itb {
>>>                 fit {
>>>                         images {
>>> +                               fdt-jh7110-deepcomputing-fml13v01 {
>>> +                                       description =
>>> "jh7110-deepcomputing-fml13v01";
>>> +                                       load = <0x40400000>;
>>> +                                       compression = "none";
>>> +
>>> +                                       blob-ext {
>>> +                                               filename =
>>> "dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dtb";
>>> +                                       };
>>> +                               };
>>> +
>>>                                 fdt-jh7110-milkv-mars {
>>>                                         description =
>>> "jh7110-milkv-mars";
>>>                                         load = <0x40400000>;
>>> @@ -58,6 +68,13 @@
>>>                         };
>>>
>>>                         configurations {
>>> +                               conf-jh7110-deepcomputing-fml13v01 {
>>> +                                       description =
>>> "jh7110-deepcomputing-fml13v01";
>>> +                                       firmware = "opensbi";
>>> +                                       loadables = "uboot";
>>> +                                       fdt =
>>> "fdt-jh7110-deepcomputing-fml13v01";
>>> +                               };
>>> +
>>>                                 conf-jh7110-milkv-mars {
>>>                                         description =
>>> "jh7110-milkv-mars";
>>>                                         firmware = "opensbi";
>>> --
>>> 2.47.1
>>
>>
>>>

Yes you're correct disregard my comment then. I was confused for a moment
since I'm doing something else locally. Looks good! -E

Reviewed-by: E Shattow <lucent@gmail.com>
