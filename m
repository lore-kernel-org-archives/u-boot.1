Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37512C61DD3
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 22:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BC69606A0;
	Mon, 31 Aug 2026 22:46:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IMl4PDwykjmn; Mon, 31 Aug 2026 22:46:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788216378;
	bh=CeMrAVB3dDPA+WfmxnIM9GrtcNsol75gGuCEUL3U7TY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U6UWqtnEiK736aK1n8tmD7gFNdBysJh8ZFJbNHnm+A7bNVUL8Dhj7Du9qekKGWoMJ
	 pL9eRaAcun21mObxsziYnHfuqF81c+ri+Sg7OCijaLciZARmWDChP8BYhi6SgkTLHk
	 5LqM9KPP/W0iLhgwP11sV5vJHBzPy09Z0EWqxTYoLU7At93XUYvFPxmewMwsB9dbl5
	 svGStEW0Cyb/EuTXcFRy4F08fA7gv9KsR9wg1b5NTKe3qh5HKrUj6usvffbmsEVei7
	 X3KUZuokVTdZOFjeoHatjtkYR2j7BfbRZRcKwaV/4BITcdgcsgY3mupSl/rxKqmCTP
	 w/5tL2wTEE09Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40EF560645;
	Mon, 31 Aug 2026 22:46:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BE98C127
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 22:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5B89400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 22:46:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Pvdawky2gZE for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 22:46:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=fbtzwzmd
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFF0440056
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 22:46:13 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7f3f52143cdso219995a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788216372; x=1788821172;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CeMrAVB3dDPA+WfmxnIM9GrtcNsol75gGuCEUL3U7TY=;
 b=fbtzwzmd0a5ivDStV6TZhBCFiYsWJlPTawXffB/pV9zbfyvh5yzCJNBEfSMRRvdNZy
 8MoZPLIY/YeNwr//JiETgU6HUixfsur8g4KuHy27n7A7jLYa9168J1oU4t/PpUq/dvsJ
 K30JfqBehwE9ZhJIEFSgGyI5i8TD9sF8b0sLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788216372; x=1788821172;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CeMrAVB3dDPA+WfmxnIM9GrtcNsol75gGuCEUL3U7TY=;
 b=XYriPZxdbeQg/5hJqxzlZbVJB/iKxw6U391kSs8XQ+n8EIFEMsBJUx0uOmR3cpAEwm
 DXBkoyuFEYZB+EEE5DFvU5GyZjNaKLvn2+RwtQ6xKETlBEz7w5wtHe3x/U0boxfe3/El
 hy25wh5cVLW1mhCNTFXielZ3+HltYSdFN7c8gZp/gqLe7igWhy5iJnv8AbHmL8qRWwD7
 /ATVX4XbOZsTce5BTH03la4JZ88CaDciJooV3FMHVGMRM1zuajBkaEFWGwrTHT3nQgEV
 vydmVpyZPOx2BrOYRkNsMtQ1NocfR3KGlVOitPXvM+TLrkaEXZs5J9qYiH/1edne3s1k
 Twhg==
X-Gm-Message-State: AFuF++kr9fEf50zZYEQZS13QFePtErqZi4GmC/lSpS/xbnckhzl2H/FV
 uQGvb7FkmkApzkhUDQLEKrUXg0pm37fwg2LaoXvjE9doGcjxgToWp/c0j779ZwX4JK0=
X-Gm-Gg: AR+sD10mtr6iG2rqx1st7vdIHqY67WdZZfHBDXpVXetk//bjGYY4QB3VAc3n8FDaIZq
 K4G7WOqHt3iYHjBo4PhMNDw3S0ov/WkXu5rOyXi62rKiiWuyJ/qyHK47LW+xOkBeBqgShLDOD+b
 LKlXyxaqVFbU62b5hJjuee3zypfIKyx7tE+NjZfEngB5Vs35CqnVOY2U8tCPcf6xGtDfHQuHb1m
 o3tf9SXc6NZIAL36e9HTSKL66RD2AXlTCPKio+Q2QqtE/xxS0+bmPRnRtD4e6X15V782+/KkUBD
 WRtaEw0r0pK6L2iU2HEOKpbhjtr2dmz4bQdQSMDVMd1Jv0Ax+Ocf2Ynq9T1VoYGapilWFa7MNRz
 kktDiqg1jBPUqtX8D5twBO1C5X6t+9NTZosMWWAc6I4gklwgyNv+xrID6xTHk5QM9pVYCb7TLQY
 5pOzV8C8j/BCIkE0i5cdJ3nVYR0UHeGOJTCZjQa8cj7p+L0Bcdh8nETs1mDNo2u2zyldDmu1gTH
 2tQ86uchh7awmDxYgVoYQBerUIPR45VMItpsFUuO+cFXpXHd/hZEL7jOhaQ3JSV9JpDrUAC/3hC
 o9oOeN5Y
X-Received: by 2002:a05:6820:f010:b0:6b3:4e02:c417 with SMTP id
 006d021491bc7-6b34e02c479mr13327030eaf.10.1788216372536; 
 Mon, 31 Aug 2026 15:46:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a4ef784esm11009499fac.9.2026.08.31.15.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 15:46:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Cc: TsiChung Liew <Tsi-Chung.Liew@nxp.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>, 
 Jeremy Compostella <jeremy.compostella@intel.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Kostya Porotchkin <kostap@marvell.com>, Ben Schneider <ben@bens.haus>, 
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Mario Six <mario.six@gdsys.cc>, 
 George McCollister <george.mccollister@gmail.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, Daniel Golle <daniel@makrotopia.org>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Johan Jonker <jbx6244@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260827-drop-part-mac-v1-1-c81ede492be7@flipper.net>
References: <20260827-drop-part-mac-v1-1-c81ede492be7@flipper.net>
Subject: Re: [PATCH] disk: part_mac: Remove the Apple Partition Map driver
Message-Id: <178821636977.1229240.1464162692532575099.b4-ty@konsulko.com>
Date: Mon, 31 Aug 2026 16:46:09 -0600
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

On Thu, 27 Aug 2026 10:08:32 +0400, Alexey Charkov wrote:

> The Apple Partition Map predates Advanced Format media by two decades.
> Apple never extended the format to cover 4 Kn logical blocks, has since
> withdrawn its documentation, and has shipped GPT on its own systems for
> almost as long. There is therefore no specification left to follow for
> the one property that matters here: where a partition map entry lives
> when a block is not 512 bytes.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] disk: part_mac: Remove the Apple Partition Map driver
      commit: acb09f16da3322098e54dcc75fe6458ed2d5bc23
-- 
Tom


