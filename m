Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410960A2619
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bMHwcMUH;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bNOiflpZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 094A560D7C;
	Thu, 19 Nov 2026 13:24:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fdz0tL9XFq_x; Thu, 19 Nov 2026 13:24:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3F59860D53
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795094644;
	b=Dh5bFayofkK+YYB8bxFAlV8pSbhFe8URTw4mEkNmkdbjS1z1imjwdEMFBCbXyAEJDsNa
	 vXlV7ztkljJuPzmYfAukqOJbmC7uyc4i4ymOGCzcUyjYQyXFOKURL2HItPzee7ap1lGQJ
	 9bGhSTMj6D1Syi7Ehok0XFGoZjxPqYPS/sgeWfo4USgFyYtdO1IDuyRlHm7mzGYe7FanY
	 E0SFIBMxnljuR7oOi41md7vKRN7qU09UtY89aS3C4e/iXwpj7SjfAcVxZ/8oKXtLTySsK
	 B6BVR4IUnLa9BJSOBrRAxGZiqhjB6Vn9DJbc9Eebaw6+R1Xrpob2qp7pQ6+W8O4/Vsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795094644;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wfAgPckTkmRQun3keELviy2uyzzYSPut6WsO+ox3SmA=;
	b=RohH4SPhP8plA5o1RyrRlp6sGfjmel2qyFMMJeoq+4iya6Bb2S30g95ryoTJ5Bd7Etxb
	 yyZ/jB6JMuE09l/Yn0UBMpLm8pmt7g15vYjmN2bvwlF8kJiduoGWzfnhlOT3vfS+65Znt
	 0Medkg+UOldmMOk8pA75vVk589BcCvAfldOj80m18JcUYXMxuji7LA6aU576VQT1vouJZ
	 RbIulyNXyj6LZoT+eXvUP5iCf5WQNDXJXBpfPtsho8Quz4kxUtw/LSGSWbiXwibaakdCI
	 LrwagtQeyYXr13mprhkWOa6J8xBaNriQIPMyAo9c/M16cWAQXe0JMsvy6EWK1WJBuig==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795094644;
	bh=wfAgPckTkmRQun3keELviy2uyzzYSPut6WsO+ox3SmA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bMHwcMUHw4V4SMs86D9hzmyd4hKP7B6sYoswYw1Vcr7EtIbJvAPRGr4uUFc+pujmN
	 AerAshIxPoDlClpcTNRcUKE94dTgMRwM77lWKJWwHYBFZDc1UJw9Y+B+b3Iy7zfh4z
	 xMJEumDvD67C2pv3d/MB6w7ADxkkeMiKvaSjNa6mNtukdadTPI/4rDSNdaQZ6NmUj1
	 qKI6o3k76FOZyZT3EU8Mg6ZUxTn1paBdBv2U5zEv8fNxj1nM+iRF58Q0jUuyRMQnxq
	 /HuoLrZ73dvPK9XFzNsxV4+Il2a2da7Y7tVcOjy+tDztMVO2XovjOGU3lo4UNsktSp
	 DmTzzj7TNPIUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F59860D53;
	Thu, 19 Nov 2026 13:24:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A6DCE4D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0A2040AAE
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:24:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Up2OwyP4EOwH for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:24:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D5FA040AAC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=bNOiflpZ
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D5FA040AAC
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:24:00 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c50aaad19fbso252987166b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795094638; x=1795699438;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wfAgPckTkmRQun3keELviy2uyzzYSPut6WsO+ox3SmA=;
 b=bNOiflpZBCV+vTkeozacxysVwJFiMe4gA68QkSsr1Nqweufa71fkRknKtSApHA9Eq4
 BsWwo+v6orlCeoACUJP+ujKZjD/Sp4yOXZcYdd8Z6xF9FX6Hp9CemqS+nYI/sexCUmz+
 Z+9vAXU9awrHgCdBm3Qe2GvQdKIO4e4djAgW1jR22GGJUfx13w359gDVYWHHcC4V/azZ
 XBpD7AFGYrIPP4McQcZ2zOQ7DSZ2kmr6V+o6VP6ZWUDyqQGbOFF+9ceZdc/9+CGm+N3m
 M85L8uVcQZl9N3FLW1BecPQ8HJldFK0xQ3tkN9+FclognBqDbf31CkCqcVlLoPRAkkXU
 cksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795094638; x=1795699438;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wfAgPckTkmRQun3keELviy2uyzzYSPut6WsO+ox3SmA=;
 b=c4gVyBXoQOHn81BdGx7fG+MsWFFolzje1R42UGSWdX9gRxJ2dODn40mpb/vzsn6pYs
 K5LNzpbagdfAZLn253GK+Zn0KT2LeOmKIbG1ZpCP34xEajKcHMN3z/bBDSh0uas9l3Hj
 8k1VWRJ8t03dmj+ESNDxs9ejBtBCGJrAEEzNuhe0dGkWSd1ob+2WEYLc0QXSYZJsFgJ0
 PN1JHFmJoBquQ/OtyYHLTIDup2+FbIjDsP48pGlKql3LX0FcOz3YP91RKIocmpgLJm2V
 gTTie8l5hlJwYxazZz7O/p2w4lP/VCoYM8t5bX5IHg56L744hqmUuim03CKqKpaQ6aLD
 TqPw==
X-Gm-Message-State: APuU4Z9iT5pbwL9ypMPrMTytJDaootPHthd2L2U7bT6iTa9NaMG3Jvm2
 5otPH45h6v3HDQEw9xwnXCKNqJEfCzVnMl9E47NBiU7mkD20vuGxpjxdG6adqmvd0hAazJK4+5c
 Au21WHJlQzkn+iaVFi1SCr1bXMyhwTRSXiVfB
X-Gm-Gg: AYBFou2cLzxMrDRdQR3ZUzJSqq5k0ZpLFuRkoPh+YRVqoXrTS811Bajn7LXr/3E+a9C
 myZ1Wr6QkSS98Y0O5Ttqi8nMXaILJzaocttx4KkR9k2rFkJZR+0bFiKyUvP1z+wzqXroetRfRg8
 wgV4aTMmuIAyve5CKU/LmXp5DUGdFTFjQ3NMIoOwKbWgb1bJWJAPwN3KmfsjuqjLrcpMANf2Kl3
 ABBmC5glh7U+Vc5dmpF2PuHF0Do3URS8xZ8/JQfLxYusy72RyeJm7oYLtEakeGb96fa0lyc3rN3
 4dY7toFcahEanKg55zfL4kOVF2q5T0e4crBaEDdI6FeY7Xs8JY2htzbBP4acGVfj0GX45vbMRGi
 YhkE57GnXzI88kiGnaUinTgUbmgF2Q2DkS3Jp3w==
X-Received: by 2002:a17:907:3e1a:b0:c40:80eb:c541 with SMTP id
 a640c23a62f3a-c510deba888mr553267966b.2.1795094637981; Thu, 19 Nov 2026
 05:23:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
 <20261116-ddr-multi-v3-3-fe9fb30a3169@gmail.com>
 <4b4b6b1d-9676-4b02-a10b-506d3169800f@cherry.de>
In-Reply-To: <4b4b6b1d-9676-4b02-a10b-506d3169800f@cherry.de>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Thu, 19 Nov 2026 14:23:45 +0100
X-Gm-Features: AclHuK-QvJfbgsOO1xi1JZk8t6rkwnn_dqAfL86XvZgDH2DEtU2WnFNKSUnDv0w
Message-ID: <CAC928Haq+ic8E622GsxdoOxFyXn9BHvNKxWTkV2ZsYFvA4HC+w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ram: rockchip: raise error when configuration is
 unsupported
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno mar 17 nov 2026 alle ore 17:40 Quentin Schulz
<quentin.schulz@cherry.de> ha scritto:
>
> Hi Massimo,
>
> On 11/16/26 7:39 PM, Massimo Pegorer wrote:
> > The PX30 and RV1126 sdram drivers support more sdram types but only
> > one type at a time, really. The type to support is selected through
> > RAM_ROCKCHIP_XXX configuration options: raise a compile-time error if
> > more than one of these options is selected, instead of relying on a
> > debatable and embedded priority order to choose the one to support
> > among the selected.
> >
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> If we add ROCKCHIP_RK3399 to the depends of
> RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR4, I think
> we should add a similar check in the rk3399 driver to refuse to build if
> there's LPDDR4 and either of RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3
> enabled. What do you think?

Unfortunately I did not come to a clean solution for the RK3399 sdram driver
"singularity". At least, not enough clear for my taste. So I left untouched,
open to discussion.

Let's suppose we also have ROCKCHIP_RK3399 in the dependencies of
RAM_ROCKCHIP_LPDDR3 and RAM_ROCKCHIP_DDR3, something like:

config RAM_ROCKCHIP_DDR3
        depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399 || ROCKCHIP_RV1126

config RAM_ROCKCHIP_LPDDR3
        depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399

Some compile-time checks in the source code can easily be added to raise an
error if LPDDR4 is selected but it is not the only one, or if none is selected.

The point that annoys me is that, in RK3399's case, the two options
RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR3 are the same thing, in the end.
If it would be possible to have their values coordinated, I would be happy,
but I do not think it is. Using the Kconfig 'select' statement will force
one to be true when the other is selected. But unfortunately, this does not
work when unselecting options. So, if one is selected but the other is not,
what should we do in this case: raise an error, or silently ignore it since
it does not affect the build?

An alternative could be to use an RK3399-specific config option, something
like RAM_ROCKCHIP_DDR3_LPDDR3 but... ...it's quite disgusting.

Let me know what do you think.

Regards,
Massimo

>
> Thanks!
> Quentin
