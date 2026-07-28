Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F007CC54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 17:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F3CC81377;
	Tue, 28 Jul 2026 17:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y5WWSFe1m3Bb; Tue, 28 Jul 2026 17:13:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D62D08133B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785258803;
	bh=H0uuw1A7dBk68Rr6mjw2gFcUwi6bPlEk2WQF2yYpm7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hQKEI5ybrgMbMYZWjjvPg12XTWaSNRo/rfMhf1ipb+TQScV5CcdIUpT5ac47q59AG
	 N1AyKF5JD5YOGwZHTXXoJaEfjH7hJ8NOzBhQFV1064uO6R+NfPnjJHoUZR42JiI4w0
	 Iw24HHQ+RCK0qYyQZQEDpnsbO4rOvL8FTksupNZzWpOHUBvZ+8K0eyindveOLEgf56
	 Q938IlGNJrv6yNo8fBeXQGdG0NWgHjfTeG66i9E8FiDSDsTmEFkpBqbh1IhuLg3b0l
	 v5v+StUSxVLYdKG7+Z0fwSwdCthLmhe5tamYmLACwmYRCdL72RhiO9B9nDBGpGk+H5
	 NMv0BVQYgkCbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D62D08133B;
	Tue, 28 Jul 2026 17:13:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B68AF788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A86AA606FD
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VC4fGrMovvrL for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:13:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F3782606C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3782606C9
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3782606C9
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:13:20 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6a168dc590cso84124eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785258799; x=1785863599;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H0uuw1A7dBk68Rr6mjw2gFcUwi6bPlEk2WQF2yYpm7c=;
 b=NuzIJL4zGLHpsrQOLlepeZ8l88yp4KpD+05fzi8SBLwJ8QYdO4TQqwL3rvUQjrneoE
 zL1h4QCBMwzrHPMZaSs01CNutotota+1b2NxHQ9p9SfgRrytc0+zwYyGLbdh+yAMUh/M
 qXkWhFk/2qA7R9KxjINZfydi95zUsVsCXax+/pBKJxgwcAekHP0ALAljBXNXdjLYLOPj
 vPr0QgFgXh8yTUR2+sJsA4O+fVbtmqtYcMchsX/ZOqryZmaeGRTLxNNVHC8YjQTo36WP
 w+5CjC2YttSOGYifzpTXptXdjz/ddjZOrGzHkTnfW1oKjiQmKprrANvF1+zR0x6P+Zfr
 OUgw==
X-Gm-Message-State: AOJu0Ywk2Gy3k+8v+pkIwWJsUI46Grf73Y/3+xSfR+KQKevcO2Br5yAw
 V8zBYkaemSZL52GLR7OjASALcoZkbAfFvlDowNq398CJIaVq0qjdKqhJIpTvEbmp5NA=
X-Gm-Gg: AR+sD12hmvDpybbEo4eSNDLov5NWVUNa2WmZUVkabvEco0qIGnlSMfGBrVbwigdl+kj
 Oz+Z043Uy40PdPFY063xmyaAOz7gTSFHTan+3sU/OAph7L10bZCeezLHbiSEBAV5fwptZ6xCIAz
 U/HE/sKLit/rs0rYHR/UCNzefZyPYdfxxOplnIXX8OYbsAgCALkWch6bR7O8ziTjJjW/zk45gIg
 3rwXRRy/OJnTRl+IRy7+0FK9MoQNNHoYhoxnLp+1ouoiZuSWASfPivYElo6j/LkzLftV/qImTdF
 vpSULeUo5A7viDhHk3DCO6H81cUnWiAY/vYOJvkDIhCZqKoaKNh/OnP5RIg4vbWXn0oHg1AfmdW
 0YfOlIhR+zJ0zQ+fWyb8k4EYOAidCVlL1VN2hmlzRZUqU0pliYSvKMH/eMhs1Fu6Vd+J5y7vkQB
 2ti33cLu/+1wTH1hPsl3ifnaqbK4GcdlAeVOB07XCk2YTxJGqtT1Xqx5kx9MzcnLSNVKjniIjCa
 rgkYG42uz4I/36CzuHV2kbMKw==
X-Received: by 2002:a05:6820:4c14:b0:6a3:7b7e:ee63 with SMTP id
 006d021491bc7-6ac96cef8bcmr1732603eaf.69.1785258799673; 
 Tue, 28 Jul 2026 10:13:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6aca528b2b7sm2579eaf.7.2026.07.28.10.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:13:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Alexey Charkov <alchark@flipper.net>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Jason He <jason.he_1@nxp.com>, 
 Marek Vasut <marex@nabladev.com>, Xu Yang <xu.yang_2@nxp.com>, 
 Ye Li <ye.li@nxp.com>
In-Reply-To: <87wlufz1kq.fsf@kernel.org>
References: <87wlufz1kq.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20260728 into main
Message-Id: <178525879860.1614251.12643362068884137960.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 11:13:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785258799; x=1785863599;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H0uuw1A7dBk68Rr6mjw2gFcUwi6bPlEk2WQF2yYpm7c=;
 b=W8UWhESUrkXjOoh+/syKu8SgaTMOd8/tuPrW7lyartB790W7DMUVWiQappgizoFD6L
 qPlhldB/ubD3CRnGf17+dBQBTYDqI689XlWUExclSsDdp/lKDfXJHkOpff2ShVD1ftzN
 Tu+S6zJkohisOt/5Nz69rzAeU3pORGF6t/I7s=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=W8UWhESU
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

On Tue, 28 Jul 2026 15:27:33 +0200, Mattijs Korpershoek wrote:

> Here is a PR for main with the following:
> 
> Android:
> * avb: Update libavb to AOSP 1.3.0
> * avb: Fix memory leak on mmc_part
> * bootmeth_android: Fix memory leaks for AvbOps and verify-data
> * bootmeth_android: Fix out-of-bounds access in bootconfig parsing
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


