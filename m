Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659E9C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 13:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3889C8130B;
	Fri,  7 Aug 2026 13:19:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqRlHE4VkEBW; Fri,  7 Aug 2026 13:19:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61E77812F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786108762;
	bh=FWLKkYvG5TDWlCUqKDJ8+i+RHa3oHr2PtGDKq4Powns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rZs6ycN0xNh3Gbr6hw1nbPvgFga2z7XKWIcP93kvTwAb0xtFCbhP3+SaKNsrR4V3q
	 MVItrosPMoE2W0+UdfIqrj3wvwuWaPIyW+6fEyBigTnsBOtqNwgCsHylSgJL11WRaQ
	 R8TfvFgOw4yQOnFA/Fz5SgZmu6rp+bqSQQ4qvJTIYcwnPdgP3H5fVxa2j6RE2XVO6k
	 JE81U5oJ9rZBqNC6Z/oxhmTbIeq7CGkaERh5iRMAVy7nv5GMIesM3jlXCEuRYSb/oy
	 LKgdGroeSfuy3YRU1vN9XwnrkNU2Q4EJZo4k+A+uxnTuJq/rPlVzEml8a9ZAgHS0Jp
	 ZeWx6I7TnB4ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61E77812F1;
	Fri,  7 Aug 2026 13:19:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 06BBA218
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ECF6D40207
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:19:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCTUT5tX-PV0 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 13:19:20 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=sergio.prado@e-labworks.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B5C4140074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5C4140074
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5C4140074
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:19:19 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6acc74fee76so1434451eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 06:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786108758; cv=none;
 d=google.com; s=arc-20260327;
 b=A/niIDOIHXZFO1/ILZyzY0Xen5o5bbtl2g9tZfchC4VqokCEd6G4IGorFHnIDe3I2Z
 h6aRsNUjFvOptACL8J5c8ct6Dzg60q8l5iSSYtN0chHfhRNXNImOt+stIny2/1A78m8W
 s0YkdKrsE+Sc41h3+aZ9bF392Vswcfgq27fX4ktnNbZEmzxGiLX5VzGLlY7LO5SjCaD5
 2EsXp4kae41r2uel40O1Y6+N97SmYC/ftJ8fRFGfzecQkBCfdHAignAXbKK5C1hod2Yw
 ckoNvl822TCOa4QK/MVuf4bBcdOooy4BoTkph+hnBJtrtQRxpz5NgjxBc2J/oGFJZkJe
 onxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FWLKkYvG5TDWlCUqKDJ8+i+RHa3oHr2PtGDKq4Powns=;
 fh=MQJv6+9AQ5JXrHIBPsVF2aKzR2LiiluIeFJhN4MJydI=;
 b=S2/W0sI90kIMHray9MZJ3X+j4xmv0pZOqLxrN9cqZeltb2lc4yWNdYsbg6yTK/pixO
 JDWZtTFD0vZWR1Kp2A6jTM5cBh4qMCfcnouGiAJ58kge+tdz0R1ei1TTQksJS5m0ukvd
 9Bp9C2MFnCsUd1pAgJzi7LB0eC0s3AYIfcLzFJqW7JEvSIKVxNrW7Fn1KB3ogIrxuWNJ
 F6WssC7BxRR2Y/OjJ1vwmCqSo0ccsuJY83sFVyUFy7hm5SXRzdxCieuOOWLm2JeS7tnQ
 Pu8aJuc7gihqzDm1wG/GrXmbyyqcnGiFPBFWevLJ/HaKSclS0oOBuL+gCC2rlVsqI5pv
 kcjQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786108758; x=1786713558;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FWLKkYvG5TDWlCUqKDJ8+i+RHa3oHr2PtGDKq4Powns=;
 b=EpU3vkgGnlhTEItOUxDjdZXpYYNyNhkXF3TN73IMtqZf1dIp2H6CM8AlnwqYFgCZ/M
 WQyTpfLNS+IQnTRYirgj9MUzj+Mz0anXeGb+VP9CxiMrtT7iDglrXIXapk4Z3EiKW8vv
 oNyVC1jHuHqWDTOwCD9/DifJqe+4yyGKIaWWii55dafm5qpnmtAZix8/DhIyO2uJWpAn
 e5BoBFSYAOz9s3OYRwTgRpAsVJfG26xu+NUg5YCP4afTi4ts0qqK/SFTVuyhFc7BSnVB
 q7hFfRKwk2njvGghgLJdVmuxKOIXxMRcH6ZuRb1nrtsqEuLMDwbS9tYnvzYkGWMwyniC
 rhQw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/qTZTsz6Q4zcoAa+5WEq+OuoNdlIc0J1uhjsyVi+s5wz62PDQ2HJIS8XtlSNkDm+/cJlBv2U=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx/8dh/6Kv7dcwJvtTFeOLh2N5mUSwBgqCsI+Mvqz+e175eGn8E
 d9EyxV6EO1XfzBCkKyX2rAwQ1ER1ClXxqYFGcLn7oXeRWDrFn5U5nqv+LoFrWjcKHmkonZDOQKw
 JUfJX4B02T9UAZ+nuPXVzGa+N0Z5wVEn2pVtHEfvMlw==
X-Gm-Gg: AR+sD11GPmm48y126WAPsMCv8k/Wf9+LWudTdzswobtf0e2eAqUmRZbpeOMfY3vt3GB
 EbitDh+62rCJs7EAPF1+m8iXhTR86x0/k6zFZjqLtcv4MNlZelkRx1+W82D2/2iWbVJgC47Y5+Z
 ykS6X4K7ledW3M9cf/BJm8tG4ZtN8D0iKo+Qa5KfzxgJKNV2vUgrdejOtDJatydKs4m7eG4syVe
 MzAptmcLGnSBWsU4AZi8SOSV3zszwf4oYi4Q7IOA10t+cBZS6+RzM2vaZg2fxN3FhA9tYolQd9V
 spzHkgySKHYbQ5agyQqZ0SQwt1lrzD05sbvVc05o5KNBhQ==
X-Received: by 2002:a05:6820:188d:b0:6ae:aa38:a0aa with SMTP id
 006d021491bc7-6b0421b66damr6862eaf.32.1786108758578; Fri, 07 Aug 2026
 06:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
 <20260728113535.128601-4-sergio.prado@e-labworks.com>
 <CAFLszTiUeMSM1iJUWObYjh2wCOVV9+LYuUzPZQd7Q-D9o8cjog@mail.gmail.com>
In-Reply-To: <CAFLszTiUeMSM1iJUWObYjh2wCOVV9+LYuUzPZQd7Q-D9o8cjog@mail.gmail.com>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Fri, 7 Aug 2026 10:19:01 -0300
X-Gm-Features: AUfX_mw9vO5IINZF3cNiG-vkZvlMF9KCuea00bP1NiUkdkYNT46EBm6FfM7nRo8
Message-ID: <CANu7NGvxhMyMLC3pss-2NO6XibmxKGTB6fAZCsS9N4+xGLv3BQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] binman: ti_secure: drop the redundant keyfile
 re-read
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, alpernebiyasak@gmail.com, 
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org, 
 pbrobinson@gmail.com, sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, 
 xypron.glpk@gmx.de, quentin.schulz@cherry.de, jj251510319013@gmail.com, 
 Wojciech.Dubowik@mt.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1786108758; x=1786713558;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FWLKkYvG5TDWlCUqKDJ8+i+RHa3oHr2PtGDKq4Powns=;
 b=uoyGc63o9AOM/XaIEoT9WrSEK3ijsitjbVplVD+ESG7QYzxH2bZMZtKF4azAXmGU+f
 CXN/jooLf+TIZ6O1eB3MF6itIEFZgeml7OmmAPIW70Y+JVowcVIWcC5pZyjJtoCQa7+M
 x6SnLmmzMe5BW+7k2s31DJafSqt6fBYimS51LTGLu0WIVPfBiT7XCExqapqE3TO9GyIF
 sHIH0CgNVf5PwVqNnmtU3msnJwUzakWHtKNKr9ikipmI8oh4Tt3F3/mFp0J7vQno7FDg
 OzwIJ6Ux9JNGqbYYQrHYP/CQfMGx8p9RBQ4IYFEoKzgJUNwcCLxpQrJymi+ppynrr/vU
 7sVw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=e-labworks-com.20251104.gappssmtp.com
 header.i=@e-labworks-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=uoyGc63o
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

Hi Simon,

Thanks for reviewing.

Em qua., 5 de ago. de 2026 =C3=A0s 15:58, Simon Glass <sjg@chromium.org> es=
creveu:
>
> Hi Sergio,
...
> > diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/t=
i_secure_rom.py
> > @@ -71,8 +70,6 @@ class Entry_ti_secure_rom(Entry_x509_cert):
> >          self.sha =3D fdt_util.GetInt(self._node, 'sha', 512)
> >          self.core =3D fdt_util.GetString(self._node, 'core', 'secure')
> >          self.bootcore_opts =3D fdt_util.GetInt(self._node, 'core-opts'=
)
> > -        self.key_fname =3D self.GetEntryArgsOrProps([
> > -            EntryArg('keyfile', str)], required=3DTrue)[0]
>
> BTW Entry_ti_secure_rom.ReadNode() also re-reads 'sw-rev' with the
> parent's default (line 70) - same pattern. Folding it in would leave
> no redundant re-reads at all. Could be a follow-up perhaps?

Makes sense. I will send a follow-up.

Best regards,

Sergio Prado
