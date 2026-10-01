Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1276CA5FCE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 19:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BBB8809BB;
	Thu,  1 Oct 2026 19:27:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JH88pHoKEoGR; Thu,  1 Oct 2026 19:27:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8BCF880AA3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790882840;
	b=F/v5kIvW9dLneil/8FN0JE2bvVKe3gAQ9xoR8PwonefEuNC4Q9usw6JEGCI2+8IpRowE
	 ntesTG3jGoUT6pGMR++Py7g9IM8RHTQkxYjdpEM6Ywa5tJAXCIQw27fSZPfZZ8b4Ri8Bw
	 FTJ6Yu7WRkQlHVctsroQ9uPRmgXNEwiIJjFHFZt4jK2F64ATVYwOC0Dj1douyTJnstBjR
	 Hcp5Ivw+emq0Cd+X7TIYKiSySqfcR0M8P61GZu4ORh5TfxIrYRNTL1xmUZ8DzDxUOsL2a
	 8QQmjWialg5vtJPPg/FqP7QDnZqb+fKga5TFMKrxINZGKEvDAuaHoba4OUcGFu4xuFw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790882840;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=toDOqx1qYTkWgPYhwlEkN+QJP06nL1RfTvK0dj3cIxY=;
	b=D+u4LYrn4oZlTi+WxUDeolKqZs4zSEaZNFh1ZTXgZLK62hdO1yNTPfYUVjJeVmRuYBnf
	 S9devOcPNB97VqqknEIBJ8lCPGiGuWsv4TkvvCVfiEhOnhSIfT/MbC9tSOKkfVQWCY5ZJ
	 SpXEEWuaUDIP0xUH+lXptPuF7DsM6FSqpdBu4A+LkY2PXJQ1gMqe+AoBAPWewUzum4DNt
	 +mNTs7YgLYbtWZCbH73E9Ymh4EMNg5Ook/z5QsqEHhanltNCTKNxYx2hWDPd2R8488gfM
	 smCyUK9ibzjS7lfjYOlu4/ACKnd6S7lUiR2HvdQDdrGYbJJU2WQz5DQ9wobNlNCFxsA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790882840;
	bh=toDOqx1qYTkWgPYhwlEkN+QJP06nL1RfTvK0dj3cIxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t1w7x5qq01uHcdSXuOd80te/bQP4XFKT5+BvjK4hGdQ1G6MNFG+jFeFOINHNw6J0r
	 hiN2KlJc5MvegOYubn1YIxQeldrJJJVgzACRxRecbGcRUT3RNAcupZip9+8fZI0KwP
	 XH4UeZJwHeqMYk9aSygSn2DmevoiVlf7f4VeZGYG2jjGDfcaH7Us2sCaNud8RFTnJR
	 Dq4PxwY/Lzl44emtXOccoRLpi08KJWeyb6DefH6TwTbbzrpbeqpp4xsS2d8bhQPFrL
	 2b4Yfd+e94TqM4PjHNacXceE0CNLwmQn9oiWWBxSAyfOUsx67qn8H7/xBSE9UuLKkE
	 cK/EmU6WiCODQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BCF880AA3;
	Thu,  1 Oct 2026 19:27:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DE58282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 18:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B00540A36
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 18:59:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KiUyZjdv0QNX for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 18:59:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 246D640A1A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b131"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790881192;
 b=FimbKWdhQu6KQpQIe7xf6faioqku6/G8dwtxuyzQXPoXN1d4f8I27ASPe8arNmtpytJp
 LNh4gSosn7hctupouHeK3J+X56gbdmpNMxVZMqZHvGdfFQOxwdJDaYnjg2J0ZvnoMeb5o
 0VImBUQS9c2ODUxsxKzW2TM3Lz9Jynmg32eTxEykC6SIkeaKA8iENvAmEdvRPSAiJOCoO
 b1lGqLtPWnN7szd752s8uTpQgkiFZoKadBk5NP+WxJSmRpyZxEkaLv404FOf8m1azFPzK
 AAHZZsOv2U18vh4vtW2AT0Ot6y2K39LB5GyCZxRqzgGLCxGK7adxqWCB+KdbTjT0t2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790881192;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=toDOqx1qYTkWgPYhwlEkN+QJP06nL1RfTvK0dj3cIxY=;
 b=hO7FxXc3NQjDTV4/hJjsDAp15S1c0Xwa/4i85mRE14Irpu/ut1jMt9/DcMZDqUpVa0C5
 hpIUQGfNFClJlLiSfvHjhIgEgN1SmbaGuPm7k/k/yXhMlAE7WjvCzOc+T2IEdmCxVIS9G
 vWfU2aKm63NPOn+mYnBlOyudmvhvwOFYSLpb0QnmJIgCdOWYCq/CXxr8sVq9mnBHCCLow
 fj1/vcG0h3FhotIwpOtUqdfxoNw/PmWs7Zsi8kr+U3gozhgqhECONIMyvYYqCN0JzEqJb
 UQI9D0KlB7KJV67EzfHLb4r/NPwmoMy8aY1xwR1ymhu0Ktu9jvQgXIghIGFYCj/V2uQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DHJQCUnr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com;
 envelope-from=m.legenovic@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DHJQCUnr
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 246D640A1A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 18:59:51 +0000 (UTC)
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6714595153cso699539d50.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 11:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790881190; cv=none;
 d=google.com; s=arc-20260327;
 b=ni120VC63v2ipmA7spzKo/QaefsNWLkqCJVHM42mvPvOemNfZND7KI0UIbhP4gMXHW
 MwhYobwPx/ICChSLAL/B4vdysGew4n3DpLRtAtgVGb2l5qe3D2Gzubxe62gIydRmkS0R
 2/Uckx08X4M8GV0awXNIuh/lluJ0o8VMpL6cLyAWyxEk6CKcIqV6IxnnD9T7EISaYhF2
 g5Zr1V8fZODNMMlWkOJHd1f4DE+6i93O6VmItQRq/4oeF5DVt0hA79gmVD+WZgV9vh4C
 9U5BOdfoeHGIrSQ4QjJz5puZgJIFAfImsEE1UTEhsKDzxPjcpm71KA3oEF3v+S6gzuoh
 XR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=toDOqx1qYTkWgPYhwlEkN+QJP06nL1RfTvK0dj3cIxY=;
 fh=mpPB3DSsbuRQ8J6bhuqWHO1+dotwjP7/nN6AT1eMQ0I=;
 b=SiAgfdfIUwTDf0b2XfePS5tzou51/1HNP3k9NQcvKqvlBF8WbMBbaxvdGXGAlmFvGp
 XW3BQ3uLRK0uCBGB8CrlOcGZXSIfDNnHn36KaiptVzjSgIIg6hK7uLqTbeo1U2BahltF
 96EwroB+1ya4HVUxr4hW9o5O+45GGUr0tCDUsS2q9sGJxifsqt5ujeFAqSXI5Y+uNWlF
 Zi29jWaXV51tAwXLssvADC1UfpgzN6DX4tnvBtq61OAvyqn81kqeP07WypVvJX2uxQwA
 0bYcOFGy4Qao1dJXrCLfSWkUQZmIYr+3rOEgecboH4p5zHVtnuQjC/hYhXWpQTXA2Yo+
 xdJg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790881190; x=1791485990;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=toDOqx1qYTkWgPYhwlEkN+QJP06nL1RfTvK0dj3cIxY=;
 b=DHJQCUnrYuAoswbE6aBVTBtakP3iMjhOQw5a11lVKlxYV7OgsqHbS/HsnQQ3oAlNUc
 w8vqrdbpJs1P5YZQDxLJ8uRO1ShQZuWOrBXkHT8+7pvreLPTZkjyhAOUyxhbYpXybqpB
 zntYmNmPnwWFOesSqMtp7RJ2qU0bzF28c80wI48EcNfclZ4pfIDIptdDcyyHzAeFEn2z
 fnFfMYTh2YBY1cWypJhHperhZ+x1s/MoCn2jCScbknvtsGHSSJEgwR0HCpyCMrJW3McQ
 KL0GRGlrM3F0nXqhQReZsPS07fytLp0iiI9WBjEXnSDmk0v0hyTXcZU3xQOr1V8povy1
 fu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790881190; x=1791485990;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=toDOqx1qYTkWgPYhwlEkN+QJP06nL1RfTvK0dj3cIxY=;
 b=cHAvAmERUdtuLW7Xjc+wHWL0PAiqDVE2CVryFbbwm7GT7Y7gxtsTmYT/pKj2ok3gs2
 ryKJNcEry0vCPKHUjkB0HotzOd1UraXtkxZwMwPeBkqRuyy7MWLaTmOSWzueNwXgyXfh
 em3QZulC4AbTFdTLPcs5AXzOiyTPSbJsDDvlqk7RxSHouySD3j9gAHvg4477mk2iflHh
 X/a44srKAsbQQYwqNxbAqC85BfRya6E4uzyw49yceHq2UUju/U8oDasSKT+UYDcJ0kwe
 mUrP9nFhb/BxvlFQ4Fxuqg3mA456HzPOa4yu/rAh04hS0+AkqkL3vkF0jnwQTVfEpJ0/
 +a+g==
X-Gm-Message-State: AFq9FYKWUtz2bb2XwRGtaRlexPmHP8xMB335avv0aGpiUEVf4c1VFe6G
 JNjGKa66oc3oLNShgz35Xu3NkhmLquM27FLYdMXF+6RnyaT/SkW3a0Akv6KzLbGLCG3eK8GVXIc
 GwLdZjHzx0UE4tgNjnZpxqxn2Ahtpi3A=
X-Gm-Gg: AYBFou3swO1mJ6pBe7jbIP12OmEYe5MolpKepcaZ/wmMuO2XWCXMygIGiUNMBJSOcEu
 XmATIbcF7scW67p5lOC8cg6YUkasghTy0XBYfM150Y1tamVY5rrFk9ytvz0SjVqgZvUVawRvEgA
 IHBYAc99j1SlMYtAQE1sh2g7o4HI1Cb5+0PKnOMyWu38I//t8h4GjsClKLb3jN/iw+wfrbmMdvc
 EIlzA273VUdo2VnkZFzUdKKw9CNJn4snpzQSkLzlGV2ONvrC7xCk/YH5+AaplBfyGPkOACKgDEp
 AQj5/VXsofbUpjX8G4Ldml6PIiSrmFpi4S5UBa+7wVh0XMJ5hTGacQ==
X-Received: by 2002:a05:690e:d5a:b0:676:924f:fc91 with SMTP id
 956f58d0204a3-6769250102fmr1426915d50.11.1790881190332; Thu, 01 Oct 2026
 11:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260926005853.1727-1-m.legenovic@gmail.com>
 <CAFLszTh=X272wjo4_7B54hYMz4gRZ78KhUuDCKBPzOR8L4RA3g@mail.gmail.com>
 <CAGuQyfUdhhFuW-DCgw8C5hA8mkgP9DGyUW6XnLdMZ0q+Ui0QzA@mail.gmail.com>
 <CAFLszThQZy=Sj7bRsbWOFn=Sn4mgzkeo=4Sj0Qyhu9cWotO1ZA@mail.gmail.com>
In-Reply-To: <CAFLszThQZy=Sj7bRsbWOFn=Sn4mgzkeo=4Sj0Qyhu9cWotO1ZA@mail.gmail.com>
From: Milivoje Legenovic <m.legenovic@gmail.com>
Date: Thu, 1 Oct 2026 20:59:39 +0200
X-Gm-Features: AclHuK8yvJonim4SiNc-VCtQbODE1Ys5gBHx_UJS0vwycEck0YGLC3nomYBJE_Q
Message-ID: <CAGuQyfVDA9cGRk-o9O2ha3GC5-U+7q3fwz3tJ08-DOxiQEMi=w@mail.gmail.com>
Subject: Re: [PATCH] Disable SMBIOS table creation for Odroid M2
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 01 Oct 2026 19:27:19 +0000
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

Hi Simon,

'dmesg | grep -i dmi' shows this:

[    1.107089] DMI not present or invalid.

and /sys/firmware/dmi/tables is not populated:

ls -l /sys/firmware/dmi/tables
ls: cannot access '/sys/firmware/dmi/tables': No such file or directory

Adding fdt_add_mem_rsv() does not change anything, it still hangs, and
"DMI not present or invalid" message remains. This is how I did it:

fdt_add_mem_rsv(fdt, smbiosaddr, 0x00001000);

As I=E2=80=99m not familiar with the code, I didn=E2=80=99t know how to cal=
culate or
determine the table size, so I simply used the SZ_4K constant (aligned
to 4KB). Let me know if that is wrong, and what the correct value
should be.

Cheers,
Milivoje

On Thu, Oct 1, 2026 at 3:27=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Milivoje,
>
> On Wed, 30 Sept 2026 at 23:29, Milivoje Legenovic <m.legenovic@gmail.com>=
 wrote:
> >
> > Hello everyone,
> >
> > Here are the details of my analysis:
> > The commit that introduced the change in behavior in version 2026.01
> > is this one:
> >
> > commit 209bbc4e0032228c6ea17e2172a8a6b89756c4f5
> > Author: Adriana Nicolae <adriana@arista.com>
> > Date:   Thu Nov 27 08:28:34 2025 -0800
> >
> >     boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI boots
> >
> >     The Linux kernel can discover SMBIOS tables through two primary met=
hods:
> >     1. Via EFI tables, when using EFI boot;
> >     2. Via the 'smbios3-entrypoint' property in the /chosen node of the
> >     device tree.
> > ...
> >
> > I found this out by comparing the device tree from a working version,
> > decompiled using
> >
> > sudo dtc -I fs -O dts /sys/firmware/devicetree/base -o live_tree.dts
> >
> > and difference was in /chosen node:
> >
> > chosen {
> >         u-boot,version =3D
> > "2026.01_armbian-2026.01-S127a-P7283-Hee1c-V2928-B3a7f-R448a";
> >         linux,initrd-end =3D <0x00 0xecbffca5>;
> >         bootargs =3D ...
> >         smbios3-entrypoint =3D <0x00 0xedf47000>;
> >         kaslr-seed =3D <0x00 0x00>;
> >         linux,initrd-start =3D <0x00 0xeb519000>;
> >         stdout-path =3D "serial2:1500000n8";
> > };
> >
> > In 2026.01 version smbios3-entrypoint was there, in 2025.10 not. I
> > searched for this term in git history and found the commit mentioned
> > above.
> > With git show I saw what activates this, and made a patch in armbian
> > build system to disable it and confirm it fixes the problem. And it
> > fixed it.
> >
> > Here is also where kernel hangs for 60 seconds (always at the same plac=
e):
> >
> > [   14.482048] calling  gpio_led_driver_init+0x0/0x38 @ 1
> > [   78.137967] Freeing initrd memory: 23448K
> > [   78.165027] probe of leds returned 0 after 63677665 usecs
> > [   78.166792] initcall gpio_led_driver_init+0x0/0x38 returned 0 after
> > 63684076 usecs
> >
> > As you can see, I was only able to find the cause, but that=E2=80=99s t=
he
> > extent of my expertise.
> >
> > At first, I wanted to sort out the problem with a patch in the Armbian
> > build project, but then I thought: "Why not sort it out at source?"
>
> Good idea!
>
> Does 'dmesg | grep -i dmi' show a DMI line, and is
> /sys/firmware/dmi/tables populated? That shows whether the kernel
> reads the property.
>
> Does the hang go away if the property stays but the region is
> reserved? A quick hack is fdt_add_mem_rsv(fdt, smbiosaddr, TABLE_SIZE)
> next to the setprop in fdt_chosen()
>
> If so, you could add a fix for 209bbc4e003 - i.e. reserve the table.
>
> Regards,
> Simon
>
> >
> > Cheers,
> > Milivoje
> >
> > On Mon, Sep 28, 2026 at 4:37=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > On Fri, 25 Sept 2026 at 18:59, Milivoje Legenovic <m.legenovic@gmail.=
com> wrote:
> > > >
> > > > After upgrading u-boot in Armbian for the Odroid M2 board from
> > > > version v2025.10 to a higher version (it doesn=E2=80=99t matter whi=
ch one),
> > > > the board does boot, but the boot process halts for 60 seconds,
> > > > and only continues once this time has elapsed. Debugging via a
> > > > UART cable showed that u-boot hands control over to the kernel,
> > > > and then freezes there. The only difference compared to v2025.10
> > > > was the SMBIOS table. After disabling this configuration option
> > > > everything worked perfectly.
> > > >
> > > > Signed-off-by: Milivoje Legenovic <m.legenovic@gmail.com>
> > > > ---
> > > >  configs/odroid-m2-rk3588s_defconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > But I agree it would be useful to know why the kernel can hang in thi=
s
> > > way (I didn't even know it looked at SMBIOS tables!)
> > >
> > > - Simon
