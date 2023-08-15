Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99A7C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 17:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3D7386384;
	Tue, 15 Aug 2023 19:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OCT2vDAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7C48679B; Tue, 15 Aug 2023 19:45:01 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF19833BF
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 19:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-307d20548adso5050778f8f.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692121498; x=1692726298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NveF523gn6Ky1Ki4Nv1y+VtlNX/X+5m90EPtwolVibs=;
 b=OCT2vDArRTCNSkt7geXnXijfijXrogaTZirXL33gYbyVb70z0Xxd9MjYzYT5WgDPxU
 OysQBgMG/Xpgj++5UFJBfPw7dH5+ag8iPA795ia5Yk3DcwCB+VyFndbsB2MuyJonwdfW
 S68L1X/AbdnGnV3sNMimAYzphXoLrYci2DNm3/hnoDpAry0Vw/ASP9qqu25TEN7IJiHZ
 IjSr4gIdnh9v3N24piXubVRWK2Y8P6XJRBsQB9bhNMGjXHbbNU/UxxhZkMQ3XPxtLd6j
 Gf2g0IxWZeOl/poPw6eagxTgYMqlY6erNOOZpqmIIVr3t/IsNx4yQYJVQsUhlwF0tDAc
 sVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692121498; x=1692726298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NveF523gn6Ky1Ki4Nv1y+VtlNX/X+5m90EPtwolVibs=;
 b=KvjTB6wnnEgVXkSOPnM54otFMd3FoVqi6flQ9wKbDZ+IOYvLOZrtzSgASw9aQRyhrH
 bNHog8ZQREo20823rLhfA24/pN6L6YQvn2tEZG9cOQfqn+tRYp7lfjeTi+mNEImw0wau
 5h1F+7fgLjUIeXC3XLnYncIe2mVUHMMtCjtURp9bq5OUSAscXeE2f6vsjw3c9jmSEOb0
 zGQb81bZZD9EXJsqYxqgBAciYq/jaDuZu0r2szl95fHXqAMfnBJPlIYbn7N7iPxVHOs6
 zi2/2PS0mRbiiyT2Mgs/zBA+r6iQKwtrLD0rp5kuWki0eeyrXXGHcIiyG3cXAneSm9If
 VVnw==
X-Gm-Message-State: AOJu0Yz5f/xFFV/SyQRwxTmnGE+AORrwFlZXRQUeL3ou7jZwRxHiR6Eg
 K3I8wlVuQUpQcE6bONmlFA1xjkpm6RPd1LAPSXmKTw==
X-Google-Smtp-Source: AGHT+IFljMQ7H95cyF7q0SVR3ehAU1rzIZPYEfQ/FZqkBWG5hXfZNBaxm63dCzykXRjZyo9CaSceqF3oFOMWzSjD9jI=
X-Received: by 2002:a5d:5347:0:b0:317:6623:e33f with SMTP id
 t7-20020a5d5347000000b003176623e33fmr9330521wrv.14.1692121498241; Tue, 15 Aug
 2023 10:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
 <39a84296-93a8-92db-1c1e-964ed45f634a@mailbox.org>
In-Reply-To: <39a84296-93a8-92db-1c1e-964ed45f634a@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date: Tue, 15 Aug 2023 23:14:46 +0530
Message-ID: <CAH=2NtwFtPPmSeews+JcspgV4oHkMP7=D1yxP+p8-Or+XDrDyg@mail.gmail.com>
Subject: Re: [PATCH 00/17] Enable UFS on DragonBoard845c
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com, 
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org, 
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com, 
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 15 Aug 2023 at 04:03, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 8/14/23 23:54, Bhupesh Sharma wrote:
> > This patchset enables the UFS controller on DragonBoard845c
> > board which houses Qualcomm SDM845 Snapdragon SoC.
> >
> > In addition to enabling the UFS HC and UFS QMP PHY found
> > on this SoC this patchset also contains:
> >   * Patches to add 'reset' controller support for SDM845 SoC.
> >   * Minor UFS core framework fixes.
> >   * Patches to sync u-boot UFS driver flow with Linux UFS driver.
> >   * Patches which enable RESET, UFS and SCSI config options for
> >     DragonBoard845c.
>
> I submitted a couple of UFS related patches yesterday, they add handling
> for controllers which cannot handle 64bit memory and add support for
> cache management. Please rebase on top of those, otherwise there will be
> hard to resolve conflicts.
>
> [PATCH 1/6] ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
> [PATCH 1/2] blk: Add bounce buffer support to read/write operations

Ok, let me rebase, do a quick check and resend the patchset.

Thanks,
Bhupesh
