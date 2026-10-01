Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D94ECA5FC4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 125EB811FC;
	Thu,  1 Oct 2026 01:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 180o9Izg6UKz; Thu,  1 Oct 2026 01:28:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 362A981202
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790818080;
	b=TLbWMXX9jdM0pPLCPmKfBJCTTwLJBsd8T0jo774gST4F4ppbO4CeKniQCuu7jFYZJ+d6
	 e3SSWzXIBOKCE+2uGbRw9s4jgYtetLjNLjxaZJ01PCDLesn2syp22LUF7sLU6+DLnYDQP
	 xBOCN/UxDBkzkWM2tCNyr/MWpTdJXHXAPhH1VBpB72yH+QQMRUvyxHgtEqTPUEWZD6aNl
	 I+VuMTeUes+2rur7Q1TE7hZhGsWu1MpXFUB3+o/Co+DTvox+z8Ficx1POd3DphFIy9g26
	 eEuXkR7MbiiaKKoci+JElmEWDGy+/JG796emimGzjyksYPVjOUaNNYuneB33tW+LJKg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790818080;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+rRiDAXxVR7665VwN1hpuevRWSZ0hOBTw6F6J4ZLuWQ=;
	b=m0BUuksFv8UuYobRWjpLVDJCI4gDExryfu70/mkNWyPHRPjjhKuh95NzzkGoqt8GRLvp
	 nFCQL/j0uyUqqliC6UcR7DY5QXpTOrnUyo+ceEFqiAlfBeKZ2J/CUqx8d1jyIykeqqGsQ
	 ucOsveE8hYgB+5a0RMan2A8521fn0TPEbLK3gsM5XjFEMKgCRcO98OeuB1J5UUE8Xe5av
	 ilrMJwe0arBZt4JsBoMQ3EfgvlgR6Vu6l/+gXUJjmUJJ8KoehXOky/4S4Xk87IgXAvpST
	 LjjDsvFD6YPGFryOYcxQAlHUuVWBPFFvRdQhl2r/NUX70I7J4SxMaakgeQKFUTX9Lsg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790818080;
	bh=+rRiDAXxVR7665VwN1hpuevRWSZ0hOBTw6F6J4ZLuWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O9KiKnltMBN7LJWhAASjMEGJ8GeQO3Ol6cVsNKuQ9H/cgKbrF3BtMPxMgyqlV8V8p
	 Z0StUTB+IGMj7CMFMUV1pr9ll5FCOJKXdwQCo2t1MkSSBjSkLlXyfNiLIZ1Ar+KcG4
	 iqIPY0HBX8GM/FBCfmZGzJERrE7WDg/N6q1CigxVDvby8DvMuN6bzvwUexao+GYYma
	 peoY4IYz29+Arj4mb33QvXGQhvsIBSCgrWDHR+Dto2C6gAn5kO9pzrVaku/Gyzzcmb
	 0po1hcIbe9gNEmwt2kzr698jmBUUlO8QffhGwoCqXfl6a0ygZKsg2Rjbmnsjxp+82A
	 Xj+QloDmVmJJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 362A981202;
	Thu,  1 Oct 2026 01:28:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F03D116C
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C6AA60B5A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:27:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jH7NNJyMvj6S for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:27:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9902360868
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790818077;
 b=ex1conJYn0L+M+/lWDG6UrcmgGioO2ofXDejOp1/C8XJTG3dv70UP4iJs53NtKmzh5tU
 3VXexavBjerGS5MPC7oCwbP7je96gciqrbKOjyj2P5231SCoap2IjARuwI2dCI5uRtRYM
 UyIV2hCW98oeMEiaPHASifcVxlvIyjEztoZFDfxMGEgu2PFRAFOqBwGbI4Qa1Y3iDp1dL
 hFdCgf1VK4Vs3Dr1Szs2tB3pHbNAaOBTeBoNa64gXIRY+b2EhWyNMKbFXskEuxQd36yHR
 fBFDDoCrqlZbcQGNTFsCF14Te4kqa7fCmsPJFzQ4X1gZsSNIfWPFsOqBORtYgv4QcTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790818077;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=+rRiDAXxVR7665VwN1hpuevRWSZ0hOBTw6F6J4ZLuWQ=;
 b=m7ksHEU0iTO8O4OU0usK8JYPDU7vra7ZBS0z4kP5QU2aatsdEekNjYvNIKT8X7LMD7vo
 5ivK98JFWLO2jUG7bonmUXSNJqDVODce2FD7H+0BQ2NbyZOM7oX1QNRI9yE1NkzskcsgS
 rghE14YtXMhzHx05DCPfDH6+9brp0jv6mzmoW8wai6yHbN6FE1Y5JORVGHJJWjzG6WScG
 KGHntYhdvMUxX9jM+FVa3CqyHs3+ftvpNejaGOvHYXfOT7UYyH006H49mh+2cISkLUgEh
 q7aSyEJzSn4yWgNU5HUKQK8pKk7sIFUtSKm8Q6k3/HObdA/R3KjzocZQx/rW3JrM1Ag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PoGPweuG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::f;
 helo=mail-pj2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PoGPweuG
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com
 [IPv6:2607:f8b0:4864:39::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9902360868
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:27:57 +0000 (UTC)
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2e2e35ee682so5135955ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790818076; cv=none;
 d=google.com; s=arc-20260327;
 b=sGmm1NwxcxNNq9bLfeI02wqGVsrMYfKR9Dd/xe3jFNA+nI7b4OzREx2erz5N987ZdN
 yFnkjbEyX7Yp7fpL5dZjHTpFuHa352SuaOj80vs+49JkjC5J13UF4A203yajrq72I/Ft
 JzT8GSU/0D3li1SmILzfjo2tSBvX6pCQhZV2xQy89z/t5MJj/ghuq1lxlAcekjcIXKCc
 XBygSUJ0k8r102sfjHoIJTg8qB1fgvnlULKcSYqfIBdnvVfgmv56gn3cjNGB7aHlCHy/
 QlEOlbwEu88jMdOTV4gmDKbtAOrUWygtXQ8KQuItfv/7FdvsDNmDgNHfnvtoRZgvGZqO
 NrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+rRiDAXxVR7665VwN1hpuevRWSZ0hOBTw6F6J4ZLuWQ=;
 fh=hifdh5QWUWtgdU9JyegremFrLkchp+4Oh5S8KKqkvYA=;
 b=gQCW9t3AopHX8Dgj5aBOaADSSJNH1SFXPOSDjrI2paexIoCdZbb0jyCmChz2y33YHk
 3kfk54ECChLIi1ynLc1LUXR/41ZaBr88n+JcYafju+sJUbAk6YSR2jHOwM64aa7n6CbE
 NgsXuheTElgiL5AMfJLODgOBS2Uu/GBCnEBZafNZKmp7+fDzZBWGzMTNejrairj4i/At
 V0qbQ9B3jf4TzpA01oJZDxkmCcIHBhiOFxIpuWTNqUkcX3XPnB08jaUIDsDQ/HMKxDQo
 8wj/xMVEQzasPOx9jyXJrPPdRT8eR5rtfJMy8YDUqEqc/rAvRrrNj0RrSo9eUHvnRE45
 gWrA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790818076; x=1791422876;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+rRiDAXxVR7665VwN1hpuevRWSZ0hOBTw6F6J4ZLuWQ=;
 b=PoGPweuGvKNQ4cEJKMC0AbFRz6/EUnyerKOQ3aYdyl8mxwYeJSlLxt42crZWclKPKp
 KpmEZR46TaAiji7kdEwVe4lgiGWe8ZZLWoe7kWJVDmg+DwVBZvtTuJHk7SGfM2CjDUS6
 dPe/AgCmlON2PWYl7k0uqOjmiRlwI/NiGsTXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790818076; x=1791422876;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+rRiDAXxVR7665VwN1hpuevRWSZ0hOBTw6F6J4ZLuWQ=;
 b=s34ppcseqwveKa423P+FErgbN4t1eSsNNUcC4gBk5GMes5qwrx0E/Op+7ckrMrZbMx
 9V+Aasf6FL4Zt6JK86ZPQyQvgqB/8MKU9PHXRBck11n4KJ5tlVEnwWG02GwlElQx+y55
 uW/wmNPb4WPpAK5uTkfHNpx0wPDeCmbwy5XL+zpYK6WCoAJi5/k2aw8O5/ioAAje5bKU
 KnxPPIV/m1i5iGjCosSI1rKPe4JJ0iuwfdyWlgA+KZhmdshjhM/NiJhRgeVc7vE8yqxS
 fafZ8FFVetTYu0Y733naMhusid90cYhWfRc8l9gK+j8ds5um1g7LUU8Dtelpb5tIkr8S
 UODw==
X-Gm-Message-State: AFq9FYKYWh6Sl4p3F00Ve4lTHd3KVdz+UdiTPhYohQZXirSme/pu2MJ1
 NY7Pevajc5MAgpGX2v2WeqJqxa/KydN+b5nQFPiCy/pYM599y52S/Wu9NQifROdflUu38/+aAH/
 Qop2zprgjppjQCrG9OfunIALPWHX1uz6ge5tewN3JzpGDW76od1PYYwLo
X-Gm-Gg: AYBFou3dhB6uX8fMsmxmOkqwj9AJvalMRB9xPKKqYlaEkox+TBgnnwNMqpdUuvQbnQp
 bEnSPRKFvhWfx/j4LZEAu2lY0HrPkJntr4ECMYHJAofHq6diCeCkIoBMzDduYmWIS07i3MNzMGh
 7JOb8jK1JILdj6uf0Mzfy4W4FcMiPkUGDN3E/PCp6n5zdLdF8AlhRwxBl9dZ2dtzfEzXrj4B1nZ
 g5c4R9lvHdNnz5OAKMGQhDrKorhplG6XCfo+0vNH6I9Eo703X/+lgmOOZE3M0jwR1zhBvXG1eQl
 9JBpM4LSaO/EZ75y9HDkVrH+9QpWJfkbGWgP+x7CpY0J8+DZ/+NeXOUY
X-Received: by 2002:a17:903:8c6:b0:2dd:c100:4257 with SMTP id
 d9443c01a7336-2e2e4bc6a6dmr24289405ad.59.1790818076322; Wed, 30 Sep 2026
 18:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260926005853.1727-1-m.legenovic@gmail.com>
 <CAFLszTh=X272wjo4_7B54hYMz4gRZ78KhUuDCKBPzOR8L4RA3g@mail.gmail.com>
 <CAGuQyfUdhhFuW-DCgw8C5hA8mkgP9DGyUW6XnLdMZ0q+Ui0QzA@mail.gmail.com>
In-Reply-To: <CAGuQyfUdhhFuW-DCgw8C5hA8mkgP9DGyUW6XnLdMZ0q+Ui0QzA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:27:38 +0100
X-Gm-Features: AclHuK9sUlVPftEqaheerAo1Ql1TTT2mbjaw_LjHSnzD5iWTYjPdbV9H_9OaWAE
Message-ID: <CAFLszThQZy=Sj7bRsbWOFn=Sn4mgzkeo=4Sj0Qyhu9cWotO1ZA@mail.gmail.com>
Subject: Re: [PATCH] Disable SMBIOS table creation for Odroid M2
To: Milivoje Legenovic <m.legenovic@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Milivoje,

On Wed, 30 Sept 2026 at 23:29, Milivoje Legenovic <m.legenovic@gmail.com> w=
rote:
>
> Hello everyone,
>
> Here are the details of my analysis:
> The commit that introduced the change in behavior in version 2026.01
> is this one:
>
> commit 209bbc4e0032228c6ea17e2172a8a6b89756c4f5
> Author: Adriana Nicolae <adriana@arista.com>
> Date:   Thu Nov 27 08:28:34 2025 -0800
>
>     boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI boots
>
>     The Linux kernel can discover SMBIOS tables through two primary metho=
ds:
>     1. Via EFI tables, when using EFI boot;
>     2. Via the 'smbios3-entrypoint' property in the /chosen node of the
>     device tree.
> ...
>
> I found this out by comparing the device tree from a working version,
> decompiled using
>
> sudo dtc -I fs -O dts /sys/firmware/devicetree/base -o live_tree.dts
>
> and difference was in /chosen node:
>
> chosen {
>         u-boot,version =3D
> "2026.01_armbian-2026.01-S127a-P7283-Hee1c-V2928-B3a7f-R448a";
>         linux,initrd-end =3D <0x00 0xecbffca5>;
>         bootargs =3D ...
>         smbios3-entrypoint =3D <0x00 0xedf47000>;
>         kaslr-seed =3D <0x00 0x00>;
>         linux,initrd-start =3D <0x00 0xeb519000>;
>         stdout-path =3D "serial2:1500000n8";
> };
>
> In 2026.01 version smbios3-entrypoint was there, in 2025.10 not. I
> searched for this term in git history and found the commit mentioned
> above.
> With git show I saw what activates this, and made a patch in armbian
> build system to disable it and confirm it fixes the problem. And it
> fixed it.
>
> Here is also where kernel hangs for 60 seconds (always at the same place)=
:
>
> [   14.482048] calling  gpio_led_driver_init+0x0/0x38 @ 1
> [   78.137967] Freeing initrd memory: 23448K
> [   78.165027] probe of leds returned 0 after 63677665 usecs
> [   78.166792] initcall gpio_led_driver_init+0x0/0x38 returned 0 after
> 63684076 usecs
>
> As you can see, I was only able to find the cause, but that=E2=80=99s the
> extent of my expertise.
>
> At first, I wanted to sort out the problem with a patch in the Armbian
> build project, but then I thought: "Why not sort it out at source?"

Good idea!

Does 'dmesg | grep -i dmi' show a DMI line, and is
/sys/firmware/dmi/tables populated? That shows whether the kernel
reads the property.

Does the hang go away if the property stays but the region is
reserved? A quick hack is fdt_add_mem_rsv(fdt, smbiosaddr, TABLE_SIZE)
next to the setprop in fdt_chosen()

If so, you could add a fix for 209bbc4e003 - i.e. reserve the table.

Regards,
Simon

>
> Cheers,
> Milivoje
>
> On Mon, Sep 28, 2026 at 4:37=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > On Fri, 25 Sept 2026 at 18:59, Milivoje Legenovic <m.legenovic@gmail.co=
m> wrote:
> > >
> > > After upgrading u-boot in Armbian for the Odroid M2 board from
> > > version v2025.10 to a higher version (it doesn=E2=80=99t matter which=
 one),
> > > the board does boot, but the boot process halts for 60 seconds,
> > > and only continues once this time has elapsed. Debugging via a
> > > UART cable showed that u-boot hands control over to the kernel,
> > > and then freezes there. The only difference compared to v2025.10
> > > was the SMBIOS table. After disabling this configuration option
> > > everything worked perfectly.
> > >
> > > Signed-off-by: Milivoje Legenovic <m.legenovic@gmail.com>
> > > ---
> > >  configs/odroid-m2-rk3588s_defconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > But I agree it would be useful to know why the kernel can hang in this
> > way (I didn't even know it looked at SMBIOS tables!)
> >
> > - Simon
