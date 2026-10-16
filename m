Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014ECCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 14:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A63AF60AD8;
	Fri, 16 Oct 2026 14:11:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fKuF0CH_jxoc; Fri, 16 Oct 2026 14:11:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F249160B0C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792159866;
	b=j3kriyMKUdPWr4094azzpedORiek3XlF4sEYPG/sIF94j6r7pl5dn+++oaRrHKamSA6S
	 y4OK1Dm+nhbVkgsDxkeV8KmxI77A6GTpk3xF+kW+RL+fsgf9Q5qbeTpJ+m2js1E0pv/Se
	 qauoyxZv0R/wR9sy2fVkp03qsH5lGsS0KV5pWJ7FD5l8dHEfXFy1ScP4Si6uH+CEuHUeH
	 yLkq+bbvyaISWPBG1apyuNjyKkRlmfZlODvMOYTgqO5DYVc7JbdLK3DBs5ftdQUgyU8wK
	 QOx9WObus5vC/n6vSdPX6hm16DKS2akV/WwQ93vIUaB1l1ByMbdhkHq91LV+SiuCn5Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792159866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oaKYpLNLok63MWEhvNM3AO/w16Tl/9932RX3S+NcefU=;
	b=WOxQIdL+voTlhHpD8a40MP+TPWvK9oFJVRqyqvYH98xNFmWRgfaxHT4LopR5xbT1nXnZ
	 SBOtt3d5GWCVY9PHiArmXFNw5+n8PZXd4r6j35FYsvYFMdrGl1mSyfk14Yp1bhJ+I5mC6
	 Bii/in9Vglzm0A2HAu2RQfh6y4V6Yz8iKfM4W3c1ZAYnHwEsSF6UZsxMKF5IJWN2elOI5
	 JSsKBR9+/re2XVdyInPl4a05opqG32/aYBS9e72/LgymvPcQP3rHvgs0Z4Z0K6WltbDVr
	 yUfR78hix5Le9aan1hTCqFsWULel6JsZJGGtJ7gFp27UoIKeQHbHHpW5kS8otIF4rAA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792159866;
	bh=oaKYpLNLok63MWEhvNM3AO/w16Tl/9932RX3S+NcefU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fJYTieTDwCNOJHowEpAnZo5NPi3y4nbb1MGs24MANy9Pz6zFeYcMxzG+TiFADY86n
	 F6I/pArV7kZkHkfFK+l1WbJqfeRRpadk2xaHoFhQgPsaLThE1iM1rGTR5aJzIhD27r
	 80t7J8S7CkOLtJPROaEeYi0uAuMDexr4DQmxmqKeqTapDCQ58vXbv7ZLMUPwIwabvk
	 jlAh7PUvs+dKN25bv/DPcYrvp2MQMMkMaemvuqL5JeaGN6HFw5RLYcLdqU87ZpKVHN
	 j3MChTZpFVwZ0TzLCPpCK2bmOOQtKt1HzhLyYJ5xEgfRuaw8NoUUIned1aO7MuKhUo
	 sJrP66ikfkvDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F249160B0C;
	Fri, 16 Oct 2026 14:11:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 778E479D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DACB409F4
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3st71_SB_OFK for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 14:11:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F19F409E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792159863;
 b=CpWUOZGMZZPzttaGsve5CvsfsYhfh7fevVh/Y7GePBvgIXIMHyJIe/7Gifn4cAj3QIki
 5JvlrbB1xdo4i8mevyAexqnFieixJ/IwehBZM9F5rWQuvdSvI8BFRDvP58f8ZaWb5AjKR
 Y/l0bsDDd5YlOlP1bOl000YynP+tQ4esjYqYGLQRQk4Q66ueDkC0QlR2aS4GkN0IfygrQ
 tOoJ3hslLFiFVM+fX1t/NuNoHJ7u6HyuPQn2yHwaqxoLKxFR8h9wajUwEhHgdugu8lLT0
 YROGEdGDz28cbiP3widjuPnaKqf3Hwt6GdRBgn3cZw7gLabLwYrbjXUPayCkFaMeOTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792159863;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=oaKYpLNLok63MWEhvNM3AO/w16Tl/9932RX3S+NcefU=;
 b=Qs/fX2tnm8YTt1NONoLRcshOgG3K4h/r3dPrtVkxxwCZayjBliee9mgbvPyHPkMQJg9x
 VmwMsZuVbikf9JPHmkD38ywDU8YIBhlHjcEQtW2f+cMFlu+1SML9nWWUQzZtyypy389H8
 Tl8T2U6bW8ENoFC+xlsUtQFljzRNfbBrcqLAxaqJL83cdUcfMWH7Dq+6xAuj3hV46c2d6
 z3VF8DJLBhWNComhEakZ0ZZykn0ZDyejL1iocDNeYOf5B7akDDqxn5aVA39PSXXcbHH51
 mTt8SwByWVP/eTFD7iJ0uZtzifGXAfXp+4FYek3q+rlWk9QGfDXUPni9W2KOZy2op6w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Z5ykVS2E; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1034"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Z5ykVS2E
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F19F409E0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:11:03 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-398a4dcf289so9181a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792159862; cv=none;
 d=google.com; s=arc-20260327;
 b=RZn8gNpuYRW3RbMZaOPtu7EPu1VxI1H997KS5GCBXilSc5WmRVdv7OxpzfpH9S0eiN
 Lckf4DE0nfll6MsujmeEzfKVRAMlxKJ9QadBiIujqS6IoNTrqvdfsQs9Ceu5h1/jKIQZ
 3Kv/DiFMJW3FXm4C71vxgkPGPT1t4IIBdfZu4F25ZlxlwGBAmOvvQ642q5e/4OsW7/nx
 SAXbmFpJbAXNs4NmwOgGBCmgojbtJOOZnzdwqR1wEhze7p5gS6NIt6R2EU2g0qTn3Ak6
 CynK2nvHfU17GI5Q9+6aFMGfh+dmxJ9Zrj9QFug9KG1XzTm5EfLjEOqYWALLyhD7pHBx
 GxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=oaKYpLNLok63MWEhvNM3AO/w16Tl/9932RX3S+NcefU=;
 fh=D9D4FuZH1ZMN3HZDMX41+WflgZFiofKLfzCPJZBDw9E=;
 b=rDKc2ZtnAu2VCY+MyHSXZw+tMVk6vKeofk92vsbtJ5Rp277EDfeFX5X3m1C9SGmR9t
 XO566r9Kfz7R+E9T5FNCc59hN5Co0em1ymGulDaOMqB9q9K4utncUTto8sBweSz4dCBS
 dpSunAC2xJIG6zIDDivkq6BA+b7Z2+cRtvgGI7ljq0SiF8SmHBG0eaMtVA/H6eBE+IA9
 Ggq4zNB5Vb1AUGFE3b9aB6yJle2gt/eXPebBm085D+ocE/yyCORnyQN1CzMpSbWMCVjk
 9NZ8nRG55HBgdwyprejICaVeUamLAfKpD84m6M/xQVMyF9XZTvAglq/cBXoLB5mjwkP0
 6QrA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792159862; x=1792764662;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oaKYpLNLok63MWEhvNM3AO/w16Tl/9932RX3S+NcefU=;
 b=Z5ykVS2EejGhbTjUqFwTfrRGxEDuK5AXk6eu/DONh3m/RkDhJlygEREQC7wRl8I6pc
 oAyMFEN5feK3pVenvOg1FSiaox5U3iO4Fvo0FLPHwB1LAP88ifjkepfghjHbKKuEJGJ+
 wCpqcMvxq3ah3y6bhV5FBt/HWwxUBkR2gONTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792159862; x=1792764662;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oaKYpLNLok63MWEhvNM3AO/w16Tl/9932RX3S+NcefU=;
 b=n7m994Wnh97pwMMSZVjkGsZO+l7YHcZwYKHN9jQ+CeQt4+w9gtg9PMJ/AbnYAH7Idp
 RbPDgHDdC3PiGAyLrRAwoM+P7YS1w1vjZLg9woC3ROa76DMvyyuEyit4Nt3DbtSbcp6q
 ZGQDdQU2vF9L/gB09XzFpxwhhxdHcsqG6tR5J8YeiPracVVeE3tio1egr1JgJeAfgW9q
 IjJ4cO22T7oH6Pi5XbgUvQPy+vWEHAEnqa8M+CdksZaa96eHL/Kjv3czIt4oe5hUFZC7
 7xOm4EmX0t4gaJJILZ9V1TINA/ydyzqgouaNUA1NTaZR9ZHW9agwTyAwpgd/wIxeKr1J
 7rQw==
X-Gm-Message-State: AFq9FYIaW2vQWFj/nTZ2CVy+wcDQ0jC38whoX+DzQVAV7lDWqoGtuVO/
 hbSZh+QzQoW9pNDtUK62CvLmOLdM/WhR3XkzvXWKipHu+XKv40+khBYwYMgpgYvUrUcxCeqqpIg
 OQCO2Wu14VoEJDaGPBWQvoifzewWNjH2r+mhiRgIt
X-Gm-Gg: AYBFou20G0bUaqT9rZ3QdhNL3/ZcUBfpKM3e6MsjN4etCCpMk5sfHmG0uf4srWYUcp7
 1+0jyLIExnGk/T9QFVI0zKQM2Wgm9updNrCWLW7Jy9ZGajJzPdfM00lWUi/0a4ccYJH+4OPzI75
 33t7RwP7Plgq0pLy/98/ph/Fs1Upx1NezeVHc2izXU0OhQbB2opZL3I6aEEERBCkCiWXLR25Z2j
 4aSUC1L+pgJBGVpvNFagiX1XewPVwhgKAHf89iV9MROLugTUrVZsYq0OaRc5yJXFfzbnFCF1BAJ
 hTXUiOFaPUorwwaky9mL1o0RD9zblIUNBO8QrQcblAR3YJ7JKQ9Yvw==
X-Received: by 2002:a17:90b:2ccb:b0:3ab:1af3:a0d with SMTP id
 98e67ed59e1d1-3ab3ac63ba3mr17777806a91.33.1792159862415; Fri, 16 Oct 2026
 07:11:02 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 07:10:57 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 05:59:23 -0700
MIME-Version: 1.0
In-Reply-To: <20261015111328.1269775-2-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-2-bin.meng@processmission.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Oct 2026 07:10:57 -0700
X-Gm-Features: AclHuK8wxIqySiTV3qt_XVSq-h_cVP4raMUpMa7tzLwfsNjxDNNyh2gqZRZ4ga0
Message-ID: <CAFLszThFyNDG8G24oEW+j9E4sZTo21Z7ryQjgQKfoAicC_GaPg@mail.gmail.com>
Subject: Re: [PATCH 1/8] virtio: mmio: Fix private data lookup when deleting
 queues
To: bin.meng@processmission.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Daniel Palmer <daniel@thingy.jp>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On 2026-10-15T11:13:15, Bin Meng <bin.meng@processmission.com> wrote:
> virtio: mmio: Fix private data lookup when deleting queues
>
> The virtqueue's vdev points to the functional device, while the MMIO
> register base and version are stored in its parent transport device.
> Using the child's private data can make queue deletion write to queue
> memory instead of MMIO registers.
>
> Get the parent device's private data in virtio_mmio_del_vq().
>
> Fixes: fdc4aca89ecb ("virtio: Add virtio over mmio transport driver")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> drivers/virtio/virtio_mmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
