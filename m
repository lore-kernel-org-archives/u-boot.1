Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63911CA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 12:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA18A40656;
	Wed,  7 Oct 2026 12:15:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q30MR4dRlr8u; Wed,  7 Oct 2026 12:15:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 009C540632
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791375314;
	b=J7EUj8txVNDwk+aGp//Njy2KpM+itNS85fnEF+u/QssVj+TUK6myEuxRgK4BFt9kl3D2
	 G4v6hEedUQCYKiqx3+VQ/qYrlekFGAJyLOOm3y6gB3SO5kirfRrK1OpkGHluj5yzOUr0c
	 Exc/oBU+V1o7mMTHosjto6ZbQoVwrLM6l2jKy3AHUN9s9AY8oMRfP5yOl5iGw8Ts89nfa
	 zKp4EGxHo0YzdEckUB/RRy24A6FFG31g68m8O2AJrBl6cWLsQ4AT8yUmvzWthsNXrG4Ty
	 Rei0XvSMyZXpaHDTTkvMZ4uwYT4PPWp8BOWdxY8BrLkMTwRBqQOJrMsOq4TZnPDaQAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791375314;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EKEPnL+4ZXj4uRyNu5aqtXM/zhn6deLx9ncnY0C6VK4=;
	b=HmbvNFudK7O9F867ZgEwm/YkCvt7lefMnU5v37dKO+3CtSGMouUl8WlctyV0Z4GRMBFT
	 po5llIu9AVEd/V6via59Aj7jS7l9QmbE1Bi9e4UHEnQluUq0syZN0pvs++ou8oFNmLY28
	 iT6hLcWyPpOeq38lWwm6CBjSqQ7lRtYmLBZCDEbgTw8Yq3U9xfS0jFzzcF+oycNSow0mm
	 9BZobQi1IF63FUEchXkJ0PssHaTdn75xXrYUM7nJ4doVZO1nfV1SnGzl3z7wVV6K4InY0
	 6FKu40LBSb0tWLuI8DNc86E1HWxwV72dejRsS4Bt1rc0Cv8bD95LUisKkieDEYUWc5g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YO1EswS3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791375314;
	bh=EKEPnL+4ZXj4uRyNu5aqtXM/zhn6deLx9ncnY0C6VK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u306UG+jvsHukpsg/N+QFHx7c3fcj0/X9GY/h/5c0JvfapUAV9XHrpdKIaRAaGfPx
	 J6MSXItvWyExXMIwL2O3NO60gK9DAY11ixIod6EWlpNxwk0wW5ZoWOoqNq+e7yXcuD
	 B1flWFVNb9/HcnSUpk+pVkfuByLrkw27XjCXpF5Bvzh6gCjdlkxktbqB2Qdg6hG0w1
	 ups19Y/PBU5kJ5StBz1AaFUFE0NPb8LsUljJt9b3YAoulPI6XvAnEFM2dL5YIu4Kfs
	 Sx3yiKWQYJBzzqK2ITT0RVm8vBknLwyEYItZLyTYvoLCQav0vcd6wv7PJp6/xdYX4u
	 Vcurhdy7NJAjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 009C540632;
	Wed,  7 Oct 2026 12:15:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 019B9282
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 12:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E774F404F7
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 12:03:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7LEARzUfljkT for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 12:03:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 11F5D404E9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791374581;
 b=Kc55N77OiC6UUyXrEYL7UXqPlRoi6I1u8VtEibFrF/uNi5xu0frCVJBr+1VBLYSVlQyH
 Kp/1GEh8wGwhw5kKOHRB2WnZQzQ473wRWvbSSEgN1fREddphCOBW6d/PGXkcDzLlPO4X2
 75HNGRRESRmdU8ei51J6jFOBBhMFDc4kALZ+ak+hycrUYp6JR/UbdBccF7rsgFcs4NhiE
 3P9uwoZim2MpDGTEK/yMFVF+HlrYrcGZK4yR0Gz8m6vqT4AwrbMyXQ9IPbMssijvibQ8M
 esIpLQSDQsq4C8micUYGMlcYDqDl7DhiRwBT4Us/mZ3q3nb0rN4Zu1zfM4Wbnwi+rNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791374581;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=EKEPnL+4ZXj4uRyNu5aqtXM/zhn6deLx9ncnY0C6VK4=;
 b=QBdCBG+3fB8tw5M5pb4s8tJEM8/ogHJQgoVAnb7aH27TBhFff0/QhnBbl4d68gHXdm+K
 RLq/6t7mErlmgrAKxBQ1EpSiWVcJ0bU6Lb6wL3GN+J/A5OBgDL7Ie9bo5uHABrmxziKG1
 6ZQvHBWnluc/iVzFv2kN/v1ouKspareO7NXtwiKOTLFVUyRBuy8JGiwgWdx+gzj0HmTQ5
 o7YgrVSTL/YAIBkuUWUg/BuU1o9xP8pmO5Zo/Sdbl7rGnOyssjdluMCbrpncKJ3Kdn3WV
 TzTKNdc4RYw1aCak7Ic0rVc9xQpev9wLlqm9B/47fT2uSg59Q7m7SvIxuJ/Qzo/6iig==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=YO1EswS3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YO1EswS3
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11F5D404E9
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 12:02:59 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so15223155e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791374577; x=1791979377;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EKEPnL+4ZXj4uRyNu5aqtXM/zhn6deLx9ncnY0C6VK4=;
 b=YO1EswS3qUlMKp79RGNq+IVTxfOh4hLxxOl65tk7sgWlq7HofcZ/f+yhOxrbGkZqHo
 gxDQWPC+hUA0CjNFOEI0LZWb9N5sXO5rDzzNDXyHQqWgW62X3Rvv5kS+Cu1g9wE1MHDG
 Dl87Msl8SKZspHehTq81SRryPdSvFL4teaqB5cV+o1MBdaTXRD0EHhD0mFUepxipY0JJ
 +t6FK5HO2uBr9LgUjxVf9Gus4xZXJnD9Z3A9apQy0agiV56QFckYlp34wcqKzXSLLfLr
 thOgRbpBoA6hLXXbVLmx/yiGfnIssOK+u4v5OLrqACKmc07rIRNqeLAz09JREAdlE5Su
 000Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791374577; x=1791979377;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EKEPnL+4ZXj4uRyNu5aqtXM/zhn6deLx9ncnY0C6VK4=;
 b=L1RqtSp6Z9YsZLhymhwd6G4LoFGiqDVqStRXMnKMDYOujCf12Erv0mlE3c2jk+qYt9
 ZmMRTen06a7A81yuhblYMFAPMOXuTm92hkajACrQa0UQuTm2CIJgmAy3UctEjAhoC3vD
 q0SRR/M9QGMl0Tki80XAvmQWSR5AwAJqIfktUEO639EhIdIS5xdTV88j1zw81/ZV77bU
 BBV0jlkLLFC9qpGJY0H3PyFM0tqxTEiioodpOJURX0GTaE6rd9geyrKZ50TewTlB/ks1
 DyJXc4hte03VeslSaTmWhTEW9DR/n7rgm2FOJmBMPXT0CxfF6gbut1juRvncynawptyu
 a/Fg==
X-Gm-Message-State: AFuF++m3HleZQAGxJlurdZTFFwPQHGS4B1n5CkheAdZtebtx+z34z/yB
 ePWwUHLv8ateIxyZQ/Reo4vUUS0EecLyUQdEH0bSA85lzgDFYyfdQG92oiUU7JdGR4o=
X-Gm-Gg: AYBFou3JIErDw/K/CY/hxfXQVdrkrmXkSrADa5mi+oyNFEiuPAP1N9fmf2PNbPDEM0N
 LarOa/zhr9eGzxZ7S6CeRheCNoFEl2Pc+lsekXpVB3oE160WNIEh4NUd2SnZ5bLA6RXVh0Cjgpk
 YjnbVwqm5v9VHx3b9THYS7HInugVMRxM3kOhZmVNO2+VOFbwj6zhcFurcDD3eWoI2Iz1zoTk1SS
 2pc6VjHF7I3RZbGAJpnrKFwFH26T8YBn+TFzn8opFyIYz5FuHsQmu8HoHL+/kNc/+/X8yMP+w14
 r5TNRcNlXR2Mvbp/aJTR9xShEK68myFyXgF06sxH9DBOHY70zW8P028Y7pz9qnb/JwNPQ4GQheD
 5TiU4cb758srCSu51VszyyQMDfcScivghI/r+vVCxO1C9ldrV/nhc798RwEbzX2w4m7wU2zHsaC
 m/npmk12sNXGOtSim/eThAy6lIea9FX08+OqP/FdW/1pORnQduWHOeTYIwr91moGIQ+ROXvcndq
 85bUQrMfgke9ExVUb+WPenp+T2S7hPiGhVgvO4JSn8BlGWVFAWmqzPAqLELIkdzpL2SnR3/hzGo
 sYM=
X-Received: by 2002:a05:600c:8b51:b0:49e:6050:9fbe with SMTP id
 5b1f17b1804b1-4a18042465emr29987185e9.15.1791374577313; 
 Wed, 07 Oct 2026 05:02:57 -0700 (PDT)
Received: from macbook.tail959722.ts.net
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1822af9d5sm34543035e9.15.2026.10.07.05.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 05:02:56 -0700 (PDT)
Date: Wed, 7 Oct 2026 14:02:54 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 0/5] firmware-owned devicetree for EBBR / SystemReady
 DeviceTree
Message-ID: <asYS8s5V6QZAkELN@macbook.tail959722.ts.net>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <CF9CE178-91B3-4F7E-AC97-DE37B8D63CDF@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF9CE178-91B3-4F7E-AC97-DE37B8D63CDF@gmx.de>
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

On Tue, Sep 29, 2026 at 00:10:05 +0100, Heinrich Schuchardt wrote:

Hi Heinrich,
 
> Why should a "firmware-owned" device-tree live on an OS owned block
> device?
> 
> This lack of separation of duties is bound to lead to total failure
> once I reinstall my OS which typically starts with repartitioning the
> block device.
> 
> Please, put anything that is firmware owned on a storage device that
> is firmware owned and not OS owned.

I mean, we are really not enforcing anything here. The block backend
does not require the firmware DT to reside on the OS device: the source
explicitly references its backing device, independently of where the OS
boots from.

That said, you are right that sharing an OS-repartitionable disk leaves
the firmware partitions vulnerable, but my idea is that the platform
must arrange storage ownership/protection so that replacing the OS does
not destroy firmware data.

As I said in my previous reply to E, think about booting an OS image
from SD while the DT is shipped at provision time on the eMMC.

> The topic of constructing a firmware device-tree seems to be
> completely independent of the way the boot binary is invoked.
> 
> The easiest way to make such a device-tree available for other boot
> methods would be providing an environment variable that can be used
> instead of $fdtcontroladdr.
> 
> The construction should only occur once and not repeatedly for each of
> the EFI binaries that is executed.

ok, not in order: DT construction is already independent of EFI through
firmware_fdt_load(), the EFI paths are its first consumers. Successful
loading, verification and assembly are cached, so they repeat only when
the partition/configuration selectors change.

Now about the new environment variable, that is something I thought
about and I'm open to it if the general consensus is that it is a better
way forward for this problem.

The idea would be that we introduce a preparation step that loads
`fdt.itb`, verifies it, applies overlays, and publishes the resulting
address in an environment variable. The preparation step would also
return a status, so callers can distinguish an absent source from a
configured source that failed to load or verify. I'm probably missing
100 complications but this is the basic idea, just to check if we are on
the same page about this.

Thanks,

--
Carlo Caione
