Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48541CFA76B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987DC80433;
	Fri, 21 Nov 2025 11:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E63CfQR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 348278051F; Fri, 21 Nov 2025 11:41:59 +0100 (CET)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C0E802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-640d8b78608so1381356d50.1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 02:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763721716; x=1764326516; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5SqnnZLQkHdbJqx7fDIEBivt8XlVw5M61bMSrzycdc=;
 b=E63CfQR5+z0glkQkuU4ooDqjjF4Ar1HTOymgGTxuvveWFW928xGf+/FH3W0qnEicZu
 FabA48heo6YKOzaKlI+F+hdV+jyzm4KPbmHMB1K7/6i+7PMl0yMJ3KL/+3I2qCrUXA2J
 F0lQaf5kvm16d8vTtluAG2+5Z8R/m8tq/EUXwUw6UHbTDzFMkORmxnCMyhlZgTngiNFV
 xDr8qxJ90U97L2u32v27YaDnm0/FshJSK3HUOZMYTAfapaaG0XOGyd1a4Z9ykTDRHbl1
 Id6WnMt5QrUOmMVq1CuR4wZVcKJNhrstr+VZBo/fj2b9yNVZsaWjCHTr1934I31AC8U9
 4K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763721716; x=1764326516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G5SqnnZLQkHdbJqx7fDIEBivt8XlVw5M61bMSrzycdc=;
 b=Y7iK1iXSZJxLdkYf4fwCsLhoqEqA/D2MIeDqn9DYt607Vlv3pK5nr65lQ6IxXvJdUM
 QxP8RkjTiQ7A6uuRqOxgOQ5gwtQt7zzUTyJa7eFFSnduUzEXwQUIlXPK50oGDE52qlbM
 ngKv4U+05YhH75+I+XO2ocJZVhn2p/kL3cFAw+PuJjYKKYFr+5lhC81YlZipOhPfUakr
 sbjtTCe9MpGpE8fne5IxZdpd/ne1ycJm402qiPXlUbcrNEq9hOVC6Bcal+5KNv/Hq8/w
 ouiuhCJA4nXroynUOUN2/b/yM2KNLwVkCIf8ZRna3sp0WrVbZ7O7fIk7mRXxxL1llQgJ
 gEvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0f/PVLQ3SIuIBXR+KFppHAdTQZLXdN3xcX34NNjxRiEuRciYiFRfYPRSFh6BUSJxMBTYxJak=@lists.denx.de
X-Gm-Message-State: AOJu0YwyHP7BQ9H60ldYaJCVcUKXSsJfP8nsyx4UOXc8H0XOs1yS/TBy
 05fflOyI4PVtmnBdvSVK5WCB1BmjmlRsdgUNuS07o8LYxJHTt2uy5KF1yPsx0jAF+11iziMiYxf
 74qkxIDf2Ti5Ae3cFNmXWTFlCct8nY88Z/Tb7ZVATcg==
X-Gm-Gg: ASbGncsQoSIEf8D2sEjKYTg/78gTt+7+VKGNP2wICxAq5BE+CHUUoCmsZCjEHsMZ5ds
 8BvRRjMqxHcmhqDxTG9PZ/+9L5mJRxWqeReo7xjrZPImcptBy1uKO1BRqvUVBh5ZE5/OoDNzKtB
 B8hYh2IJBpaKpSktApacVDOocJOOvEhAl6fHOPQiLUwYnOHY6Wj1fdTGzVRetu8CBejhtTFvPi5
 agw2EobWBwPUo0hApNk+VeNKD/qIF/fSDLQzvNm4cfdkubJRD3zqTGdGjoxYjTBSY7AE9dXsUL5
 e/mCzdClDaEWwBWaOlCkkbd1ilDbo3sIQZpVoePwi0tCD0snxNk=
X-Google-Smtp-Source: AGHT+IG2ssYEGGurhvewdqLJ4laDv1VzRYZpJY9j3KIl26N0HtwQG88WDnZrgNxsyBiIOZUysy5kQT1zl6e/9mPEbxU=
X-Received: by 2002:a53:5a07:0:b0:641:f5bc:694c with SMTP id
 956f58d0204a3-64302aeade0mr801842d50.80.1763721715827; Fri, 21 Nov 2025
 02:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
 <CAC_iWjK5d7z-J=rbXa-_+2zjejWOuTJco87-yqJVXtuXmVjdNw@mail.gmail.com>
 <8730e084-5541-4df5-b067-c97e540b5f37@oss.qualcomm.com>
 <CAC_iWjKTeNTwyQE0KoAApF_qbd1c6ftTnU8jx85sVNBTnYJoRg@mail.gmail.com>
 <21d94821-a339-49a6-af50-6a93788a4f2d@oss.qualcomm.com>
In-Reply-To: <21d94821-a339-49a6-af50-6a93788a4f2d@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Nov 2025 12:41:20 +0200
X-Gm-Features: AWmQ_bmjFfZKG7c0P362M7ROXnKbDVPD3SJI__4Fj-zSfyDaJfA0mJwiDMRspHk
Message-ID: <CAC_iWjKZB41YNC4p3HRz=UXeyfod0hxyFZp-1Tr1n75P9h=g2A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] efi_loader: improve device path matching for
 partition lookup
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, adrianox@gmail.com, 
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com, 
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Balaji,

On Fri, 21 Nov 2025 at 11:24, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Hi Ilias,
> Sorry for the late reply.
>
> If the boot option generation logic skips partitions, then the boot
> option points to whole disk.
>
> But when capsule update calls device_is_present_and_system_part() =E2=86=
=92
> efi_dp_find_obj() =E2=86=92 find_handle(), it tries to match this boot de=
vice
> path against the ESP partition handle which has path longer than boot
> device path.
>
> The find_handle() logic at line 142 rejects the ESP handle because:
> if (len_current > len)  // ESP path is longer than boot device path
>      continue;           // Skip it!
>
> So capsule update fails to find the ESP partition.
> Based on this analysis, I believe the fix I proposed would help address
> this issue, but I'd appreciate your thoughts on whether this approach
> makes sense or if there's a better way to handle it.

It would and and what you point at is an actual problem. The reason it
happens is that doing what is suggested would violate the EFI spec.
OTOH I don't mind because being able to update the device without
having to manually add a boot option is a nice feature.
Heinirch any opinions?

Cheers
/Ilias
> Thanks for your guidance!
>
> On 8/28/2025 5:53 PM, Ilias Apalodimas wrote:
> > Yes it was. In fact the original patches were adding the file instead
> > of the disk [1], but we had concerns on scanning all partitions wrt to
> > boot time. I don't remember if anyone tested the boot time though.
