Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F090CA6004
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 05:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7A04813B7;
	Sat, 10 Oct 2026 05:26:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7p8sCb_ildU3; Sat, 10 Oct 2026 05:26:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D9536813A9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791609981;
	b=osqv+1tRl44/nWHQ8jC8xz+2h2LHbRmfV6mOEQZg7cDg4RP62njPpA+2ofPWuVtDezEN
	 G3emsg8srhpCgsH6gaf301IDdnAr7mmTuTeV3AE6QhWq0eja2ZOwFz1BJan2rMr2PpyXH
	 +Pkj9Fy9pTbLmLOURmMJ7pvtZq4q6gBE9Xwx1HsX4acZxL+zzBsUOGZjcJSF/VruEqsHx
	 LdwZJDq6QFffsyomdZ88WEHXS/NPcf79wrsm5iyKZYXSGsVOdELOlW9lGWK1xk00f23PN
	 c+XHV0idFpQvaKS2Lt4Rx8ucnPZF8uq3mS+uLcbuso0wcuTMSQex7+clc+//aO1i2Aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791609981;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Kg5cEZVKX7ZgSie7m0EzuL+iTHRffVAO+nyHAR63UKM=;
	b=n9ZJUR/LiP4Ql0wONFDKxS8oSDSIHjd/pcTITplB6UR8Kob1FVOeEFXtoZht54Uytg6o
	 0lfsfkf2vkP+Zn2CKAuIjgoeUcEljVJub4+5sTm644763quDkM3tma9xf+XeTDCwppteV
	 Om3JGRF3UqAtONxC4kGc9VvBVNknwhNmALT80hN/9CR1it2sQOvNXZdSPIsJEDmDL+xPJ
	 6Z/Hw58srDmxdSuAhKJ3vnyWXNQvXRSkw3xKUQMETxp5JZemZ34+OAVdLK9sqCLCDCIxK
	 eEn8pM+jDAZehbXYD2OE0BEbWmIKaYDjL6vuaT4DWx/s5H9IY8AoYmra8ddi2aR6Zqg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791609981;
	bh=Kg5cEZVKX7ZgSie7m0EzuL+iTHRffVAO+nyHAR63UKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tXWV2jKGm2aHLd0fQHrd62BESFppOxGnXWHnXRiOg84qPemDNvlLgng6r/4njiB/w
	 Wl3U/Q12N6fUVLlLhwW3XK6HEHe28BJ6qs67O0W8INmNwoun2miPjWhddse+W880U8
	 0hLhHHl65vD+ax6X/+3g0eEphnFU5kACOFfCWVJtLgp6Lh2ZEdzkA2IF8ZlrJigDoz
	 8D0lHgPLDYLVzaAo9vQCAqbvJ6vo+PXsqqGKUCooGEM6MiGDyWL/D+A6QW9TjS1jtE
	 Z/cozr5Go+Rs0M611q0b1gp05CFuDUifBZLaiEjB1gZqH8J9ingKwBAXfWqkuq2P9a
	 ceJ6jigp6NG/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9536813A9;
	Sat, 10 Oct 2026 05:26:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B71F2111
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 05:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8AAC400CC
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 05:26:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VatLEYQtu0P0 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 05:26:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 30EC240004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791609978;
 b=f3d4cKx6rqUoZTG5HG1WNs2p3P2n2bs8FG3sRAtdxBGiACtH2dKuqa03MZ50Le2zzKdC
 ZxtNfEWl/Zf0O6R9Ym1mtg3LOFXjfxTyI8uB91zdDcCYCpRB+FdifI5GStZ4H8OvcsCMq
 FF5rAJGGQkwE4CD7jmY3EOu2+rM/+pkoUk8FyXf0xnb/V/PpCY22gHjtagzkGtcDUb7QB
 SvnbsUJvKlmH6kk7x0rTeJNrx1firGNX743BKOZYae47rC41Rk6/R2V+hBolh1DGUoInF
 vnozM/p+778WgU2CEOKrpTBYj0sy5XxJ72psA36p/FMwMbhw8cq9h/z81oMUHR0PGQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791609978;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=Kg5cEZVKX7ZgSie7m0EzuL+iTHRffVAO+nyHAR63UKM=;
 b=mP2CPD7WJeFR1Ay/XrEx7gx0Gn0f8QwzzsaKwqCjMcBcZuuh54qmJEKIlDWkjsCdacvY
 oifpRV7VgafEPyFDASJkaLRKX3Bq8/RpL8v0O4N9pIcZjiYBlsYrtZfp6hLQ5RlygIRiP
 9Fyk2BJ95uKDZW/2fTzVLbTPmzsxORVL929Xlc7dStJvHxYnE13F2jZ6nYdJpa+3WRWmG
 R5CtVShanSMAcyn8o82xlc0QSE6cS+iHAw11lj3Lkh+6e7338iz60qjcaSMJhpmQKlwaF
 VkCz4PwvRpc1gYngylP7BKIgMbHDXzct8nDzHs6xi/S1aalIbjtFIP9xfIvlJKOzCmA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=UVzJpNr8; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=UVzJpNr8
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30EC240004
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 05:26:17 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C3E0A3F996
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 05:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791609974;
 bh=Kg5cEZVKX7ZgSie7m0EzuL+iTHRffVAO+nyHAR63UKM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=UVzJpNr86p9R8BRiItxGk/3LAM9sd47RATFVzvh3wIG1O0n6X4w35QSg9XR8kNwva
 Yj9GSdTp+gir6Ye/FO4cQTSmxwIe+DsFcgFBCp5dKNC6Vzb2iySjk4/oiXI3nAMKTm
 EULyqc+ddOnlbLuYuwbiUZgz1csYHOnb2G34qH9N2WgQOkqeLzqO5ODpFLQ+x6GFhP
 aZelqPe4M5QxLxnxEtUeRAXz8nkZX74o2s5Vq2LrBMJhBFICJKC6swpgI4dbmR/AJF
 XLkTSkYzVlbRkUjDgYwUx51BeO9UbfnWsLVw9EMklt5MhFL0NV5/TRDsQsYMp0GlYE
 liKoUiKqR4IVXZjlHPR/y2TWdF698EekyZRI7XRg+2ZTS0+4myvA2Qi8YCOe8oHr9X
 a86gRpUytG2jy9kOhC6KipGVYogKdjIZ/Und/HmBACSi3zEKalKrAFxMMYlM3ZZEEI
 aJbiIGAHo0W1xSJW6F9jK6KfoKAPKzUSYleDvfjHAqaVTCAo6PSN1+lENO9uQggg9c
 QXsdeMMVJ2L54yA1KVnpr1SBwvlNtjr1vzMOcxsBBkUeY4TkF30ZelebjnLTPkHljl
 OO1UQI2GzabeQUM8S1LCEuw3VG+f6oYLfSnXkRCj3j2qFuK2yQaGUs+ZDf2xrKtWO3
 YwrDoQObmF6sWfiItNUMQGJU=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48b00febba3so284360f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 22:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791609974; x=1792214774;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kg5cEZVKX7ZgSie7m0EzuL+iTHRffVAO+nyHAR63UKM=;
 b=JyQPXg1zoITlqbDiH5SR9GqYxaZYcl9lXs7z5qakduIRbNkZE9NzVYy5AwMV5q06tL
 ey3yBsGwOMyJ9PEy3oXIoIYaflceEDB1LwKTQZGwTc7s8yBv8BxI+jCTYEwDtY1DRiVo
 nLhANoVDooCYh1hTgLaPdf4tGiMUVqxUFo/AIeh/Bay8EJUZfXEIyybxcWsOWoCzL1YV
 QfEZiPuxSaFWTZPK4I85xCraQSDSqlTMW+CqZSF3qd6ezbtqUSYlLenL7y20IuYLMzJ1
 ESxvnx1s/nuX1NFdrPCZHw7M33fM7I5O7OV2h1ACw7s1IU6o+FBremL926gGEHkyDNCc
 YJ+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrkU+Ax4Y6pbKVzTceduguwezM+rafnEoN16dKe70xtX9DpFOe4vBEiwb/l/HlmOzmoUfGLqU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLd+AqONAsAw7g7CFYrpV0Rh47tuj0Q++HkgZoTKHDDMc8TcxPq
 P6g/U5hGswBn/Bc24bdA0F8FsFoewU6Th5J+rI/ad/RoEWJHMMCsY0L3WYpJhJwcDQHJIziefk7
 z9hRXob6fUu/hT1Q+qC7SnQqzxAck9frhleZTeeXl78mspTOBuH5n9R6YSanez4yiQyM2g5osgU
 nWb0Df8EkZqQ==
X-Gm-Gg: AYBFou178ecgQJxQys0nJiqRFAfnf9w2pdLO1+nn7vus65DQDjZjb5A+EgdF+E7tftO
 ZB8FwAGGT83q4DiJEtOh1c33ddNiywMqIN6hEgwsw6Ts0PqdPgv7O7AbWUtd4JDm4DzaNhy/UuR
 CfDExbexQcOrmlneOe3qhymESedGO4/r8gdVKpM2Ce43bVGUqOSXIdumzxTv4khl65351Z7MyKr
 4BBIw90a4HOtQzsOIb8j+YkNpcomUt3UdDV8Cd6z/IEg4nTWR+P0x9efxredEJtSUvgzsdGkLZe
 XIifEEfgyKwJPSDW1Oo3Db28IP4Rq3JiUixnzKN2i1NvOxotG3JRtpLbSRgaKN6QesQZy/poO9a
 mnDhHRMZh6U2e63oRW9D6kDqWWCP8ohHjxbZRkTGs7/h/LagetCynHjYS31ymdC6hxak3SlPGE/
 9AgzXHbg5jvEIXlNKrsJLi6Q==
X-Received: by 2002:a05:6000:230b:b0:488:8882:d514 with SMTP id
 ffacd0b85a97d-48dbad48a12mr6804436f8f.49.1791609974363; 
 Fri, 09 Oct 2026 22:26:14 -0700 (PDT)
X-Received: by 2002:a05:6000:230b:b0:488:8882:d514 with SMTP id
 ffacd0b85a97d-48dbad48a12mr6804414f8f.49.1791609974042; 
 Fri, 09 Oct 2026 22:26:14 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:4e2:e83d:ede1:510a?
 ([2a02:908:1242:30e0:4e2:e83d:ede1:510a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dbae37509sm6544030f8f.7.2026.10.09.22.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 22:26:13 -0700 (PDT)
Message-ID: <05f0e99c-591f-432d-80a8-0ef30d06dbd0@canonical.com>
Date: Sat, 10 Oct 2026 07:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] sysreset: provide sysreset driver for qemu-x86(_64)
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly
 <casey.connolly@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
References: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgA9u0EYDMqKR0C49jY8e2RcL4BKOg+dqh=V_Dp3LAnDQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgA9u0EYDMqKR0C49jY8e2RcL4BKOg+dqh=V_Dp3LAnDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/9/26 09:26, Simon Glass wrote:
> Hi Heinrich,
> 
> On 2026-10-07T19:09:05, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> 
>> Currently we only support reset but not poweroff on x86 QEMU.
> 
> I agree with where you and Bin ended up: keep the existing x86_reset
> driver so efi_reset_system() keeps working. But I think we can go
> further and avoid a new driver entirely. The existing driver already
> handles SYSRESET_POWER_OFF: pch_sysreset_power_off() asks the PCH for
> its PM-block layout with PCH_REQ_PMBASE_INFO and writes SLP_TYP_S5 /
> SLP_EN itself. The QEMU devicetrees already have PCH nodes
> ('intel,pch7' on i440fx, 'intel,pch9' on q35), but neither pch7.c nor
> pch9.c implements that ioctl, so the request fails today. If those
> drivers (or QEMU-specific variants) returned the PM base and offsets,
> poweroff would work through the existing path. That needs no new
> driver, compatible strings, undocumented 'intel,*' properties, DT
> nodes or 'imply SYSRESET_X86 if !QEMU' change, and the EFI reset path
> stays as it is.
> 
> What do you think?
> 
> Since this is a user-visible feature, please can you also update
> doc/board/emulation/qemu-x86.rst to say that poweroff is supported?
> Please also add a test if possible, e.g. a pytest that runs poweroff
> on qemu-x86 in CI.
> 
> Regards,
> Simon

Using the pch7 or pch9 drivers would make sense.

Where would the following have to be done?

/* Map the target ACPI base window using DM PCI config write */
dm_pci_write_config32(pci_bridge_dev, plat->pmbase_reg,
                       plat->pmbase_val);

/* Enable the hardware bridge routing decoder switch via DM */
dm_pci_write_config8(pci_bridge_dev, plat->pcicnt_reg,
                      plat->pcicnt_val);

In misc_init_r()?
This function is implemented in arch/x86/cpu/x86_64/misc.c and does nothing.
But shouldn't it be board specific?

Best regards

Heinrich
