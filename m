Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C87C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 23:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 696FE40849;
	Thu, 27 Aug 2026 23:54:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XeZtYtO6Odii; Thu, 27 Aug 2026 23:54:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787874840;
	bh=EZZ2pMXeItzlMsGVmOd4qDV8At3QdvEzGufZepO0tP0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fK3fHvw8PFtlaB/5gZxS8lLdjOj4wUICm2gZ3ufmCRov46FZhZLz60SDim9JEYwHb
	 LluxWQ6buCw5QDhK8JWZkiROnz7DXOWeUPyOb0RBpUZKROQqkbmtPNRlfLbXEtFY9M
	 K9DPavexCe/LWUVo9sm3U4eEG+V3a+kZC4ETG+i0alFSg3u0uwPIGiWJNUmTHcnrYx
	 nJ+1vGEM+quqoqfQW2uP/bX9e59JGMN4ifK7tn0DSneAD+xAF+2rc/HjqOYwsq6l3W
	 bCW3VFu5cqo+KbjXm5PXuV6qKKXQwqxPXPdHILznBLMnYqXHX9KOjYxdunwYgtlJvA
	 AJz7ElXcrQmiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A9B640816;
	Thu, 27 Aug 2026 23:54:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 93B35CBC
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 23:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8659440816
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 23:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gsg_gH1YfRhR for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 23:53:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=dcYdhyXz
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CBC0C40792
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 23:53:54 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-85dbc24d398so2898497b3.2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 16:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787874833; x=1788479633;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EZZ2pMXeItzlMsGVmOd4qDV8At3QdvEzGufZepO0tP0=;
 b=dcYdhyXzO14YtMp8Sz6UAyICqO6nydEZjan/smBPGgD3jg6T3+6v+C/tVxpNajZ5+f
 XZey6zg9oDB4k+Pq75SWK1zBV6w8YdgvQR6aJa5SEH3eKyov6De/XDDGLkgYaW6Vw+Ty
 MU+LC07Lqhlggs/WJ6ZopVGV0P6RtlBf357bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787874833; x=1788479633;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EZZ2pMXeItzlMsGVmOd4qDV8At3QdvEzGufZepO0tP0=;
 b=QbHonIN+aWwvFyQw1nHJmKp98jD8xRfeDQk2s4oc0fcBQbbJ/0Ygz/2YTbPvxkZ2In
 x7LZOAvuAz4OUmOcNes203u4xUrnNxGIf+Bq74sZYrkmND4QocjcsrXGr4jPa/1D5myG
 R4pxfVin7P0nkG63qtROz03tegyRFC6TKPKN+qc310fZzcrZkRIxrLLI2Ez0NtTWGLsX
 IRtE7cTItcGKz/FEv6wjQyYsGSSn5Z2lsA5yh8tQQdcTtY7VHt7QSuyNXkQ7JqiZZMUQ
 vKW/htzqAMEjcV2k7AEo0WXZja88LAs0P4pHWoJhVoKcZ3Uk2R1eOG1q/3mD0XRtxnlt
 7y7Q==
X-Gm-Message-State: AFuF++mPQCig3gs5MKsUX+9loVJA3trPQanWJA9Wbu8/fqAfaaTLDMWL
 gPgeq4H/a0ZttHk7gh+uvu3jGQJmBxT91ZKrV1qz9myluzfo54PVo+sSqEbnBa+vWJ8=
X-Gm-Gg: AR+sD11z1IJGs0pUldaiiXbfC7KWLafRbC7JJCsDkngQl7Kuj584Zn897kiv5a64fXM
 Ffybgn/dCTnOyCRj+V7aDaoHDmkO3vk1crkbBZm52g9k9RDDdEId7ka6B4hU7/GwMd6mhBSU2wm
 mVhX3+OaTmE1/9CLBlzYlOI6ZESfJNV4B4RDBYu142WxNnFHagG9FE4GmSZIIh02+uxBc+FgJij
 /Tocw6IGk5VgQhSovp373vf8MxplzwAEoVXQeMmGX3HJCRNr7Pals6bVYgShZ43mNOHixjTTFcN
 0sjwg9eRlolu+v3s1IAzaSfA9nmoAxV3KtxeeWy/eJtInHt7gr4M442ngEv6e8ZmQF7vKPgbdhs
 DMJ+UxJv+pYTNtB3MzwuHGaZIfHOA0BguN3S2Ze2wHWkOiiUOa18g6uwSSzGBSfCz2gSvt2Dp7f
 BMNc51qx0wBPs7NTzawzEdYP/d7E5ojeEscwLLIc9ttveUH3KpqVo9spWUQadD5FzIwan8pYqd+
 xf/1q74w09fuHt+mZrBkmAx5b3i0Kn38MA4U9InWhxedDn2j2jLNcE++3hvZyXaayHYbMwE6Rzy
 XFfamDGG
X-Received: by 2002:a05:690c:a6c7:b0:830:7633:a1aa with SMTP id
 00721157ae682-85d6d889bf2mr13382217b3.21.1787874832958; 
 Thu, 27 Aug 2026 16:53:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-85b5c603753sm18626277b3.12.2026.08.27.16.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 16:53:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>, 
 u-boot@lists.u-boot-project.org, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Zimmermann <sigmaepsilon92@gmail.com>, 
 Eric Kilmer <eric.kilmer@trailofbits.com>, Argus <argus@byteray.co.uk>
In-Reply-To: <20260728-sqfs-oob-fix-v2-0-077d9f0e01c4@byteray.co.uk>
References: <20260728-sqfs-oob-fix-v2-0-077d9f0e01c4@byteray.co.uk>
Subject: Re: [PATCH v2 0/2] fs/squashfs: fix directory table integer overflow
Message-Id: <178787483181.52175.617457714412656629.b4-ty@konsulko.com>
Date: Thu, 27 Aug 2026 17:53:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 28 Jul 2026 08:55:38 +0200, Shahriyar Jalayeri wrote:

> This fixes an integer overflow in the SquashFS directory-table reader
> that leads to a heap out-of-bounds write, and adds a regression test.
> 
> sqfs_read_directory_table() sizes the directory table with an int
> multiply (metablks_count * SQFS_METADATA_BLOCK_SIZE) that wraps for a
> crafted image, under-allocating the buffer that the fill loop then
> overruns. It is reached by listing or reading the image (sqfsls /
> sqfsload). Patch 1 guards the allocation with __builtin_mul_overflow();
> patch 2 adds a test that a crafted image is rejected.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] fs/squashfs: fix integer overflow in directory table allocation
      commit: 561ae28cb56a082cfa90c1c421c4955bc215470b
[2/2] test: squashfs: add directory table overflow regression test
      commit: 4750bcfe857c5a0feda86b54f260a11a4e3222cd
-- 
Tom


