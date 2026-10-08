Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8135ECA6017
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 23:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 241F940887;
	Thu,  8 Oct 2026 23:28:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eKljeUie3vtr; Thu,  8 Oct 2026 23:27:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E611F4083C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791502079;
	b=W6N7kuxZcjQWfgZsjLubp/zuqQlUDp4NLHYLSBMRgO3WymDXmPUVxaZD+YOYvwvKu1lp
	 1ZqWbogDsdy1GluZynq1WHHO6emmpSw5wnKJuc1UqEYU2l9YtsZ2NlD6lz6i/g+d/lLw+
	 m9OGrTnEQyCjMm1dx9OfkOLsjv7LGnOAfXobdECo4fnH+kNcmmF8/YtpgMwEvO63q9Y2U
	 uwKVb9ZdWG90liPt3EiRnDkUXrS5jmMWxet2vN1JEb4Z490BZpsf85jGhe75wsYJjpf6F
	 ErgjE/LL+j0t6Muwm5WeK+e4d4T6vidzCeMO3lfADiqe3ouHoypnzsCdh8xAeRQ32Xw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791502079;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Xs/CxBGDBm696OnUSDm7BlSbCpcQjV9qktHkx6hi2AE=;
	b=W362ROiv5UGNd4dr0E/pLs49hZ5Ln1hSINDqtyy2nEYl4OhM0+9Rm7cGKsg8rc8RB9Lf
	 CCb3XwE/4RvgRe+Z1QPpSYvfDvhyHNZKan0+YHeh8MKVc1iXI3ET/9i1irP1u02S3Qo4A
	 +czbFba5VMGNi1jPwo9L1Q6xgxp0W3aI7HSspLzrL/TO61spSIlx0nzJotmOgKVK6Ivxt
	 +V4mhgmx3cbdFr7VtaGVs0v4qC+6iKXORr6xxdFonrrdFnrIVlTSUj9Fm9UBKMbapZ7vu
	 Ko86S9I7AkXcHpjGEt5Uk0eZirtDO9rXJhmu9SDG4+61wW8owBq1ModuIlzD9WAcEVQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791502079;
	bh=Xs/CxBGDBm696OnUSDm7BlSbCpcQjV9qktHkx6hi2AE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9KjWDnKCTROpIBLW67o5iVGD5F3KgzVPrGGlNRez3yKQYApD4vLcl1+55bGWJLP9
	 a4ak/zxxbhOCyPT8FC3h1LwZB6jgIdU10tQhf1e2zl0XmosO++Xl65c3wr6nPt+Hsm
	 DT7GWlmXezzRSYyTzfcuM5b7jaG1e09ikamAbd9ziGyNAXiq5VurFAbupxxjWwBPa0
	 wRHZCgVllQq9i9Y6VqSrm4fon3wvK0Nh/BcLczbqEcc/czmgSmlJdzP2sCg1h4Ru6a
	 9dBblInpRmALsz6ATb4fsQzrnrYsCWFv4Kb9JySy3ULXmYfjjX9RrdBf/Wkt35NJqM
	 W6LPGeQyI4EGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E611F4083C;
	Thu,  8 Oct 2026 23:27:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 32CEA1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 23:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24E5960672
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 23:27:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UA3j9tMar5jL for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 23:27:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 533A96084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791502076;
 b=ZiD7DLDZ8rpiNAqM/jWxdC0yYrEw8TUHRKI8bIgKeAdjerkOwcvCHgD8taPHUHt7NQxc
 vCk2FZVlUdLOpesz+SyOtRKVSP4Mm0HkwGBYuxbhNWt2uSW8QEW4oAbY5pWifbeMDv4M5
 uHZapkRVgdAY5SbBxioY+2PDmt/u+poeIm+m0Z5L1yOcYeSC6hy6riwDmWtl5WXVHuBLA
 btR5XleC/7xBOrJZtkaT3a7qqjnhP2G9jxMZjgpIYYq3fKv2w1E0x1mRtZeUfFKBQjfM9
 B1qZrAQCiE8Aa8wvKhD7C21QkaGsDjQsIFDEIJjn1tBwx3gdlF/B+Kum5+ZSAcoqJ5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791502076;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=Xs/CxBGDBm696OnUSDm7BlSbCpcQjV9qktHkx6hi2AE=;
 b=ZIcX/b/Ga2RXGndCb10LI7Hvt7ZNXF+BtOLdmOBqyPnXB49KiPa5U9MLVYimUK1o244T
 3mkUIjnJAM1f3hqkxTFO8IDFWczzFJHoPCqFmvUy0El/D182gOicgy6zbaVsVNoVkqr4x
 lSC4WYubq+PdewsGJJOj0jrLQyuaawR0KbyVtEmRovj8d+wacNQ9vFLxSjQ0ZuuKPi0SP
 ybCiaD9G2ArXfndPkNalh+ieYg3u7vYGPJZuRSU1dK2l5Zu71LTGfzs7gjwSSgFFk1UQ4
 7UMDGcYmSw2/JvJQuUtb9VlXVKSoGwzdpavObmAodWPRMtkWhJ4a1cGrpWvN1Hcr0GA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pTuAeZrU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pTuAeZrU
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 533A96084A
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 23:27:56 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ab3fd8adb1so60377347b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 16:27:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791502075; cv=none;
 d=google.com; s=arc-20260327;
 b=hyolnc+4nivyXj6TLfizTiHApWzyR9RCz9VxgAauOmOK2OfqcNzWZgiH65w2k+4JLb
 u5961x9zBJe2WVm3e5uTLEc5bYceleqKfEcLnVN5AOEURvibvxfn2MJ1qz8Cc4Zk8izP
 fo8keSBXvuDKBUCZoPmjojDHeEazIK4X2aasoJHZojZdu74FJz4e6n+Uv+VaFniksGq0
 8QN83s7UYk5ZeALm8ZXZQFKwyyGtdVJFocDW4Z4CTZOwO6HN1QM1+Bw5kmrn+ASjebgi
 JtNMS0vUzjT7IBzmefNpQSFRTgqJTOcSkqzUUgD6XgPwgus5HrxNWLgQMkQOmf0bB1vH
 g1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Xs/CxBGDBm696OnUSDm7BlSbCpcQjV9qktHkx6hi2AE=;
 fh=CtwYcTGz4uvkuqkoEIQDyubh6D47tgiXSw1azCP9ZsA=;
 b=mhTeCH7bBo1ptqtEmQUWqUB84Wuk15ivvcfQVaIsZ18IHPBJBpfQ9u/YLEbYma0j+t
 1r6vvM/E1ihDNqolielXt3iXuV/GzftceP3abTz2Eq+PhS4quUPbwn+R+6HIsJ86mzXH
 k7qS7xteMUD8OTeXN5y0LepFl2mP/faRvexVlcF5UAYbKShkTG0wXeYd5Snzy1c0U6zL
 B6fUalPASqZD2OhDafSUk6oeNSgiliC4mP44EL39OxIeh3qWkM/woDB0UiE2v6LMKvcz
 YKU8rcD/6P67Kh6bx78jM/JsGAqNU6iZ3QJdbM0UTjk54zC+ZLfMtxE4J/BWZHLTDuFm
 ZYqg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791502075; x=1792106875;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xs/CxBGDBm696OnUSDm7BlSbCpcQjV9qktHkx6hi2AE=;
 b=pTuAeZrU+XaC08DNAKxpUZXDcOjE96RZSgQt5IoXTXFvCrwIWg3GMpWHfXT169S3LM
 4oULEeLFlB30H9+r5aWT6soR/FXXRbmZb6Y/3JYq7pGrjLtq/DdSTxeY8hfYNjaQBwZo
 lxvVscmw3+hH1nYRuQHg3X1KP/rnH1EWuEgLC7E/lE1+1nKW4YjkDVTzBKsly9BaUqaE
 5y7Ppx8sJxDGYtDnaEA21MmATz9biW9MVxqDAklqZLWQyh3b5FvUJ9ikqmGnmylPURFf
 qDKLPj+fn6P8QFZ4SElgrur35urezqbAlrM/lGdC1uKcInjRRyCYbCwbYgQ27iifqrxn
 X03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502075; x=1792106875;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xs/CxBGDBm696OnUSDm7BlSbCpcQjV9qktHkx6hi2AE=;
 b=q4MgDzGtaPYA1kf+Hnl0kXBdD+RCQiA+Gx715GBO0OsOI1aw22V/hyRh5rQmr9r5On
 q28D0xfN1fZ1jvlbT5lg/AevMUwuva/IJVPWSVlriEVGXQnWWkBApwssOlhWmmkiD5hC
 3GgtKJL4qMVM6ufdoa0S0p3ZCqsljmglC/VrQJR+OOqoMyoUi4D5GmIMCu3PML4KDG9G
 1iwfNcO2i4TcXG6AKRv8yoQVcJKZhijk/bu+Rgd1N/Js9MUgGnnpeO88mHw7zir+W4d4
 B33i0OPqb5qOf/QgN89s8stLtjLBIQ33lxCS2fD08qReuBYe2r1hES5AdX8O0Xyon8YS
 7CEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8TOQr/7zmnhBauCJWrYLIfHXnCW33Zoha9j+1Gk30lP1Klx8VPwBpvOplRBV+slhH4jNJoMo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIeC+OBAhr760Om/+tQQ7SDNr3mOUJv0JITrzrcbeaEFeRqg0Mq
 sHUKL3uelFgPiU2eJHxeRfNcRml+DnvGGBZrjQCWdF5wfpl6jseA90dKj8HjNI5B43Jem8sfXxe
 3EGwDchdAXz3Jtq/Hf38CenQOhfL404c=
X-Gm-Gg: AYBFou2C5QnZvNJ8gfQePcIYFciJYxoESn7NW33a5GvHmjz/EgwAoIQjWR0lQKnZ+YX
 LZOENMb5pUjK6QE5MuV+ZgJYuzz2JNsB3MP0C9BD1tu/7g4BJiWYkUtA4fm3csK8Yho6hAyu3eS
 QyPms12/bLQviAHFMtGd82bSCNfy6pdxLzoZ4P7cxK52866z9acPZv8oyj8+vQPZ3mmcs6y2Pco
 EdGBBmxpbl2jLb2PlquJJeYsMtTynTV/2fRXcvRqixg9TexHNSgqHk+uSQl5c4cLgu1kjwnq5pz
 zBZ36Kbd4qz4vfi0MsNyqQjUgMg43ZApyrhiXgZMScdd7GJ/5BF8IroWC4JtXCqjC6NyMa8XbVy
 eHb1rL21FITPrYXU=
X-Received: by 2002:a05:690c:82f:b0:8ab:56b2:8101 with SMTP id
 00721157ae682-8b07ed13524mr629517b3.17.1791502074736; Thu, 08 Oct 2026
 16:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
 <CAEUhbmXm6UW+SGEyadyeH09m70X2xVsLSPe_6iTTUmptjKKt0g@mail.gmail.com>
 <5bb7fb09-2f7a-4012-a2cc-fc4598402d75@canonical.com>
In-Reply-To: <5bb7fb09-2f7a-4012-a2cc-fc4598402d75@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 9 Oct 2026 07:27:43 +0800
X-Gm-Features: AclHuK_pansn9XsEe_pV3NiSElANKEXD-IHtVgUYKLmyz5KkWSD0MB_gjoI4R3c
Message-ID: <CAEUhbmVyutOVKvJyboA6WU=r82VNbEHGUxQnzBD_zXMKOhfkQg@mail.gmail.com>
Subject: Re: [PATCH 0/3] sysreset: provide sysreset driver for qemu-x86(_64)
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Alexey Charkov <alchark@flipper.net>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich,

On Thu, Oct 8, 2026 at 3:49=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 10/8/26 07:43, Bin Meng wrote:
> > Hi Heinrich,
> >
> > On Thu, Oct 8, 2026 at 3:09=E2=80=AFAM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Currently we only support reset but not poweroff on x86 QEMU.
> >
> > Could we just add the poweroff functionality to the existing sysreset d=
river?
>
> Hello Bin,
>
> On x86 the implementation of shutdonwl seems to be chipset specific. In
> EDK II in OvmfPackage alone there are 3 drivers implementing
> ResetShutdown().
>
> On real hardware this is abstracted away via ACPI.
>
> To have a generic driver we would have to implement parsing the ACPI tabl=
es.
>
> >
> > The new driver is missing EFI efi_reset_system() implementation,
> > causing EFI reboot failure.
>
> Maybe we should just keep the poweroff part and keep the preexisting
> sysreset driver on QEMU? Which would match the
> PcAtChipsetPkg/Library/ResetSystemLib/ResetSystemLib.c driver in EDK II.

Sounds good to me.

Regards,
Bin
