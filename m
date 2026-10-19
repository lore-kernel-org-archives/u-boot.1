Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EF1CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 316E040708;
	Mon, 19 Oct 2026 08:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dt7uH5tSG1en; Mon, 19 Oct 2026 08:57:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62CB84066D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792400264;
	b=K6SRRpk3CkoHeWCaSxHfNPV3qM8ymEKKtmWoH2gRWzO/pzGukEQYGwZyTtDO5+bCpfDs
	 l5/kf5XpwEpN57f866Lk+/qJsls2mZcZHvb1wTpscIoZ6XLAmeM6UhcWu2oT35NcHysTo
	 cb3ZUyGGhnTey2vcAgnzpFyjTQz4kOn+hCZf3+ubnNCy1H9MX8W8Gqd6Rz78IIOENf1Cu
	 5n0xy/kS/gTikO5bdiqZWM7JW3iuRrfUfPyNk/IAC2pOPovTUsUaVz6jxfD1mbCZ2WWqm
	 i+xg5Zhxj72Hky7lWaEh6dG2/Ud8gWioNtGhqkMNdfjum5jm12vcBYjhVKefyyQPACg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792400264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cH4NpXkj+/hVk+IIu7Mff29sosKDnxWb+yN1D88s1Wk=;
	b=RbQovlayktlMOpTrkpo9115yzrj6CLY8BuQcGy62jwA8wBGaY/6wm9L8tkHqjmleNSHT
	 qJBSrKYmrj7OH4RcLgyiF5Y8q6qiQxwExHSlSdteRQ58ueryx5WnI1pjgd7a9XFT3xkdB
	 advoQxaJ+WOFmmX6/3dgvcy6sIvJt45etUeLP4PdS6sPlTqvQ8rj5B9+B55pDF2Fz+Vyp
	 mVN4GpFDTuaBjEZLbHLyaQCyXmusvmuxYKSGgnx3AHo3NGhRjjiwldprZhlggSf8k2FN8
	 uIJJDxdIx+9iD0zQMzspIq3eFYx5sko2KM1b9ghKVj0A96xqKW6An2Quj2ME9G34Jug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792400264;
	bh=cH4NpXkj+/hVk+IIu7Mff29sosKDnxWb+yN1D88s1Wk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X2gNxWnO3aiALna2VPaRvCza69bSva13XMhdd0JOru16lgSHLHS1c8JEReXdwkbaV
	 SneneTI7psOQd4H5Sobo3qLMWMOZYretG4ga4lBgokUBQJ3io5MmUbHeemtnD8TAp0
	 gpFVK1R6J6hNELTg/YgdQTMgrxSv7Q0U7t4sNxkx8nFGh9KR+T1LHqIhqVZcjfGeZd
	 C9yeDBmPalPtWb0M6eLU1EANeoroMRWrNrdzz0Ft2eCkDXWzRUCaKIcx4dqb+iAjFO
	 UIFVB+TNlmuBqZF6kcoh1pG9aQ0YBv6J8S6FXmKBccY2xLnms2KCnZANjwhR5twtH5
	 EaejTXnlKJqqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62CB84066D;
	Mon, 19 Oct 2026 08:57:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 64B17465
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5601260739
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Vvs-ic42Kzx for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:57:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FD7E606CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792400262;
 b=TDaSiq8iwL1v26ncrVtDUDrkyYA3ARM6SifOKqElupUfd2iEPNodQbi2jY2vzeWpjGrm
 VI8tc38kmYlCRcaUrxbempH0hQHxI7Ahhv/zS1cGILwhyNcdkYBj/awmNfzNDKWZfXFt3
 VpD4t7+9K7k/AnNlH0DVrCYZP/hOpoKQlExuCqy8dcIR9FoUWsS/N5GmxblAkr1SL596o
 4iBtxQdyOoLVBcg7wEl8FGt6efO+gJU+bLx0rBwtNJMNO9C8bVc8xVXIWiFLENPKgf4dt
 +6MGCFd/tssLwtub2uvhd4ws1ospeko3UBYxZN2vlcCgzBx0ASkG5l+YDWWzjg/VjGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792400262;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=cH4NpXkj+/hVk+IIu7Mff29sosKDnxWb+yN1D88s1Wk=;
 b=NtwyMuJ/qO9luYH5QpvBU0rDKOZKZ8IY+/e/pwfZ0NeEN7ryxk+HDR3C8tmdh8cSq28G
 GuDTRyay/wjHR5uADgyOun91MCH0N0ePvm4+xCoo++ncG+O5bPXqZczaaixhBdLN5aJdg
 tfuImMs9627idzhcDC6bhN551esiNwMKN5Ttw08Fruyax2DiohzC5mwLKBfvjvwqdUUw4
 Sc6411UMB1VZhGWgINmSqllwzFloEIViAdc/TyL89V3JT+CKpAsevsGOA3femhYR3VnmP
 0gNAjBi8jajZCcR976Le0gfsqGUR9w5NuBHHIw6lO37869NgCaISY1xg3A5N5uYZA9g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Wh8HZmJU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Wh8HZmJU
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FD7E606CF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:41 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c411e139259so171467166b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792400259; x=1793005059;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cH4NpXkj+/hVk+IIu7Mff29sosKDnxWb+yN1D88s1Wk=;
 b=Wh8HZmJUroeaRl/xWoxkOadBk51PL7nZZNT1hMp8mPW9AyJcoMin85l++GjBPyZVyQ
 IHwZwYT4Y8w6rxtc/fE+MGTxwsQ1g/00wxh5oGaJTKS5EonI0o8PNlXiq9XiEizJZkRo
 oVLsbos0peYCqgOjOk+4/0p5k448tDLFi0pHHz03+DNP8MKByYXwMCkQcFBY5ZPQkNh8
 1+TtQdSiM9do+nJ5OQ8D/SZycBOgVRERglkCVwyF7GI6REW1uFEC8QjPz+ErxxKMPRdd
 DmXMQC3WkfG9mSsR2WJXTrdDiD3nYVr4Rx+i/a6EHagme+wKWqQuP2+BPljOeo6r7thK
 mMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400259; x=1793005059;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cH4NpXkj+/hVk+IIu7Mff29sosKDnxWb+yN1D88s1Wk=;
 b=McOIa12gUohdzegRLwLNV1NuVNFbA2+IWJwIq42g7FecAzw/X555X4CA/RievCxmLh
 pgAiUZzZMILo1YZplzIZcY7TveyPcEPG5jKR+21Js4XoeTtGwkVfLoAecp8JVfNCqeK0
 LpE760Fo6BnHBa8/wQQ34xwaExswYQRE70d8Nh3bSh20w2P7MiFSgeYNvcfvbO00cCml
 lN2A7dMiiJR5JNnmsx7HEzjTn5yi9vnW+ATd1GUlTydxoDZpCKDqd4+h0y1KQio6ncl3
 emMPkVoEBT8uGOLSlwlqMxG2fI3mO5c1TEcWQ8kmQEdvUfGMquo0845lgubHwKseoQ1g
 QG1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiLb2fFlkhx9jKxSKQf6jZgTElCAZNQI0qFeb2fU4VPQprnQkRJ428PaaK4+fiKCTt8d+debE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI/63LOJQnEH4JWUAl5j4ASeFHc8NKqPQgAesacAlUp/RCL6jvv
 y3LMzRFZcriJbEij94l7a/NOUlHyDXGmwnX243djjDwZ/Y7crGS3mPYcSdWa17Yu1Qk=
X-Gm-Gg: AYBFou3mRBmhek1PI0PKaT1rZymgR9H+gSbeAmZD+0EOn9BwZbwSeV/J/jXY5DSt1CE
 TM47ej6Mx7YDNW3KAvWwrY+B/DTsSQrWdWsBxpuApw+J41yGZHm/9gonsRPsX4KTVQ1dX5FdVh/
 SQqthwvLraaq0XjdWCbH5NkjBOuwAYvo8CDrsmgsjxSqcWxCPTk8zkPwUaUCBN27iRJ/IkMqOiQ
 f8Lq+zNvm/qnOXZqrEWNj0GdscU8FpU4VQRMta+Nb6yFWtqzlamdwIGIeK2jzJliNMult5wDJck
 UFeuziNt05BLbKdO6GFD+E7P3Pb/bUgm/WTvdnRyCG9Wo4g98A7mbaMP+5J90pfeKGYw8uKiKqR
 DR0MGJYBJ9xmk3vlKnya5Ca6QOdnsTj1zbhzKuiN1rifu2oF+QnHTw9uTLbAtYLTFFs2k5pnjIa
 +vM0clOvZVze7BpmXTdQd1nk/jkOC8gSWBiqbhfRGKL4uFQeVmDSLXegYxmfBld6H6EAE6XA08w
 VeWYIYDjfIje5sUH3XGxlZYPHLXt2s=
X-Received: by 2002:a17:906:f5a8:b0:c38:ee33:2931 with SMTP id
 a640c23a62f3a-c419f709659mr458990466b.37.1792400259292; 
 Mon, 19 Oct 2026 01:57:39 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c408e328527sm338958366b.1.2026.10.19.01.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 01:57:38 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/10] avb: Use map_to_sysmem() for flush_cache() address
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015-test-avb-fixes-v1-1-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-1-9e5b82644359@kernel.org>
Date: Mon, 19 Oct 2026 10:57:27 +0200
Message-Id: <179240024782.806974.11320348374409784564.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792400257; l=609;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=aB+sdi5UlehWDhhXnTYG60NE8PzaSeM3D3vCKaBZzHg=;
 b=QdikJz+cW/zib7F56AWwzj3YuFA7if8kwvDa08vz3h4aozm4MY3iY1COCfEvihn5c+gAdtEn0
 DZGBWCPeVZlBe4XoGn2cbPeJb13NSP2NpgRZ2DKLEDsab+7EVMJG9NZ
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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

On Thu, 15 Oct 2026 15:54:51 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> flush_cache() expects a U-Boot physical address, but avb_verify's
> mmc_read_and_flush() passes a raw pointer cast to ulong.
> On sandbox, host heap pointers (e.g. 0x1a27ee70) can be outside the
> emulated SDRAM region (0x0 to gd->ram_size), causing map_sysmem()
> inside flush_cache() to crash:
> 
>   phys_to_virt: Cannot map sandbox address 1a27ee70
>     (SDRAM from 0 to 10000000)
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
