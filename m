Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD652C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 07:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62B164091E;
	Fri, 21 Aug 2026 07:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P8C2LK6fLwxS; Fri, 21 Aug 2026 07:11:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787296263;
	bh=jjeGpMtxykM4DUxDZhumSSH6QQ5rYgxtq/BWDagkA94=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R9WXxuhE0BMVczc6r/mgFZ3W071j4R57sSTcGBz5xSJ9jUAPHAN4ebDy7A5mUuds2
	 A1a/Rrhr8Cfb+LMhq9tEmQSxaQ6kOCc9iZc7xyYvra+G3HmEhNpmHEQSibPJcU6cd8
	 MfPGzibHxMstkg0o8dka59MSUF45L2287olESw251n5C2u3ColBaFsKGvb8TiEuP/k
	 JIGK9Mb/tYreM0pWLerwfmGGeiNrn+vs5bOWtQvITcbqR5uiDkoW1blgGgYYZm810G
	 TQiNTVxrQTaX7gc0lpU9BuD+4toBD4ksyMoPBV4WGRCD6+trNU7UvZD4jua6z9fvM+
	 2Bj/XQ7kRn/4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBB5F408BE;
	Fri, 21 Aug 2026 07:11:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D4F51B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 07:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F33D860662
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 07:11:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8YLhLFWtsYB for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 07:11:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ifQKMAow
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B8D160640
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 07:10:59 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5b0117dda13so741282e87.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 00:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787296257; x=1787901057;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:cc:subject:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jjeGpMtxykM4DUxDZhumSSH6QQ5rYgxtq/BWDagkA94=;
 b=ifQKMAowJ0IgXx2JvVfyYY+wfnqsMKbRHFYmBugkP2JUAonlixz0glttjIFRH2/DTC
 kAkFRZ8YH551rys33jDIhFFHhUhl86jd9nsK03FP7zx2io/Dwr459LSKA7Dk2i6IYOYi
 24Rp7+6d5ROM9KmWJqAy4HGEVDrrY8oDzCoGG+cHUMXsqueaRC8aV4WqiI2+eHUpzKvU
 /sRp0cpu/Lo5DFuj2t5BcOhwtRyUyrxbpSPK6vAmZAq+p8cdEHLrdsz5eq9w2gVxM+S1
 IzJ++Br+/Rggkvq9Svk3SFG6JmH/IDXB/k0j+Smwzc+jkA84KiebI5zFjry5sS8Ax9qb
 b82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787296257; x=1787901057;
 h=in-reply-to:references:to:cc:subject:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jjeGpMtxykM4DUxDZhumSSH6QQ5rYgxtq/BWDagkA94=;
 b=TYxz+06xOxmOBqoV5TNPPxrRgJ6gms+URKrm+hQTTq11EspNsG+9pIHd9/DLKY+0Jk
 ffnkGUHmB6ZDlfKfkGA1KI67gAEysicXw8BlO7U5TZqZJ8nX2EvZNGRM/w0iZWsDzq7u
 mQbeHHzMyxG5Waf21EOZDPBMcR9GJ6eugcHPCwOn1YaFSAOUgMgRwyBYAe1UOp3Cz7WX
 Auxt3/0ZOAxBZm/3p+PY3qH+5RwyrWXfIXaU2akAnbWbGi48hBHFES/9tXwxuOPAI0yA
 8hZUpHZGm8xnLtQ/MLC3A6jIW2HpYHPA72nUKhSvbCyGjWYvv8M2jsDvjx4walggqmvD
 5MoA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1LqftseAlCl3IEZdTSPDu3Jlc+fHyirpE2PpxUxJGtBMJHHOhAHLyODN1txPHZ8ovyHycqps=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nW59WqX9OzObSAMzp3lPJtirH8hd9ey8jK1a7QB9v3b9zNq2cF
 owoTlO6WvETpH3SQceCiF0KHGFSEs8iIJ34+PF/yG2iGCd/3Mhnt9VLuBtutY8lzw9S5It5dUGA
 L+1oFBRc=
X-Gm-Gg: AR+sD10yJdlA3gUzy36THmF+groW4DFszW6j5Tr04bzssl1kkSJ/BBKZ3umxm68CxPa
 t9bK8ABRPvc8vcm3uQ0YYytG4wi0KDFf2ERBnARqkJqs3KfUb5ST4Ra4Kpn/+e0AOeWMGwRScCG
 1wgUlQDmFkN30k8LeTRZPNFsip9uaNAUxNm9CZ4dAeJJ8Sjar2aI41oZZLyyK5UKow958MaOiTh
 CyNsToEpZVHPBbELXDY84AY1CzOAPxhpZcSu4UL36LnU9jVw9UFsNWqSdgUVWb0nzUDVzTfFH8b
 +7So9eH3ddZJDOvZNFVmvY/GSECYUdg5eWQBcKAKd4+BXyoegrPBNO+9ybVMey9SvUAi5ahVVeD
 l80QjBDQO7mls2rZ1SKO71AO66vxfO+pFoDgZGbMPsZST4qAz/CtacLK7bQdo71AdrQcJMGCNOl
 8S/++F0apD5v/mZy4qxu+6RKXSLTnFKHOowWZXKK2uspMfaaQtGQTELQarYwyiSxSmI9z3ZE9oJ
 cCvhDfdzYIWQjTK83cVN8FB0jvKs9zVdFEMmGCWRxdiwOEys4m8Zpmx
X-Received: by 2002:a17:906:ee89:b0:c20:f95c:9088 with SMTP id
 a640c23a62f3a-c246a30c3b5mr448785966b.4.1787295939421; 
 Fri, 21 Aug 2026 00:05:39 -0700 (PDT)
Received: from localhost (host-212-171-227-71.retail.telecomitalia.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c245921e461sm349759266b.54.2026.08.21.00.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 00:05:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 09:05:37 +0200
Message-Id: <DKUFJ6TTK7AW.2VKPRV8CRQ70V@baylibre.com>
From: "Carlo Caione" <ccaione@baylibre.com>
Subject: Re: [PATCH v4 0/5] Add fastboot to SPL
Cc: "E Shattow" <e@freeshell.de>
To: "Stefan Monnier" <monnier@iro.umontreal.ca>,
 <u-boot@lists.u-boot-project.org>, "Carlo Caione" <ccaione@baylibre.com>,
 "Jonas Karlman" <jonas@kwiboo.se>
X-Mailer: aerc 0.22.0
References: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d__17726.0234997206$1787249364$gmane$org@baylibre.com>
 <jwv8q60y6nj.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
In-Reply-To: <jwv8q60y6nj.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
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

On Thu Aug 20, 2026 at 8:50 PM CEST, Stefan Monnier wrote:
> Carlo Caione [2026-08-20 20:08:24] wrote:
>> Some recovery and initial-provisioning flows need a standard host protoc=
ol
>> before usable firmware is available in persistent storage. U-Boot alread=
y
>> provides fastboot, but the implementation can currently be started only
>> from the U-Boot-proper command line.
>
> I'm curious.  In my limited exposure to U-Boot, I got the impression that
> the split between SPL and U-Boot proper is mostly a "technical detail",
> usually mostly hidden from those who install it onto a device: you just
> take the combined U-Boot + SPL image and write it at the appropriate
> offset on the relevant device.  And usually if SPL works, U-Boot
> also works.
>
> So a bit like Jonas in the recent "hotkey in SPL" patch for rockchip
> SoCs, I'm curious why/when we'd want to add to SPL functionality already
> supported from U-Boot.

Hi Stefan,

Thanks for the question. E Shattow's reply describes the general SPL
constraints well. The detail specific to this series is that "if SPL
works, U-Boot proper also works" assumes that U-Boot proper is already
available from storage that SPL can read and this is not always true.

More specifically the use case we are trying to tackle here is initial
provisioning or recovery of blank or corrupted persistent storage:

Boot ROM -> host-loaded bootstrap -> fastboot -> provision storage

At that point U-Boot proper may not exist on the device yet; it may be
one of the images that fastboot is expected to write on the storage
(through SPL indeed).

It is possible to include U-Boot proper in the host-loaded bootstrap and
use its existing fastboot implementation. That is a valid approach and
is preferable where the Boot ROM download limit and memory budget allow
it. But it is not always possible: some platforms (like the one we
are enabling) impose a strict size limit on the bootstrap, or only
provide enough early memory for the DDR initialization code and (small)
SPL-sized payload.

Fastboot in SPL provides the smaller alternative for those platforms.
It is intended as a provisioning endpoint, not as part of the normal
installed boot path. Once storage has been provisioned, the usual SPL-
to-U-Boot-proper flow remains unchanged.

Hope this clarify the background of this work,

Cheers!

--
Carlo Caione
