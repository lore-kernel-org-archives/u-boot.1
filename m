Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2CEC61DFD
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 22:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A027809C1;
	Mon, 31 Aug 2026 22:46:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vjve0wqHdkMN; Mon, 31 Aug 2026 22:46:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788216375;
	bh=aqsbbNqm0dBvDNQNri/1D1tT+tkYatQf6Q/s3pSXoQM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eEFLKZ8otWh6LgehBOvKWhQIM0LWbS3TsOPS2LI5FR6LR2u4gGEeXTyOm3apNVNau
	 dY+XR45vWSDGcS4rQOvWK4rtDOZfhtrFU7HOe2YiXcy9j7G33Xf/Oe4TCQOZE5KOWN
	 cUCPyv4sZCdL5ufxAZuh4nKewTNyGR6f997juWy3LyldtqIZakY/B03MHI6xM8bw2i
	 h2xxv+AMaGrkfI67+rZFFAtgo9HTWyZILRynBsvcuD7bHESbELioxzuQmdgl5E6ojz
	 5OLDK3CFT17VFpGlkr3q/fodx87FpxxTEYqVoBWVWEgCJDlk/DDlfsWC/2aWwGUDkv
	 6eLf2qgEC5g6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 243C580772;
	Mon, 31 Aug 2026 22:46:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A68C363
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 22:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 388AC400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 22:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8OKKFDAGiQp3 for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 22:46:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=rP+IFKBk
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 417B540056
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 22:46:10 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-469d76ce704so176888fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788216369; x=1788821169;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aqsbbNqm0dBvDNQNri/1D1tT+tkYatQf6Q/s3pSXoQM=;
 b=rP+IFKBkuv8t7AuHP67YA75JbU9hmMLt1SbKl7WXzVTHcOWs0FEwkmHOZgjpaBJoLG
 nlD6gOPqnciAD4nHOL5XmHsWKmA3XEDecZn8YYLSz61m0nMQsebQ87pHsvspqftAPBdA
 WROKgkzG3ob5c2Gli2B8EHp1NHQeXNvLopwr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788216369; x=1788821169;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aqsbbNqm0dBvDNQNri/1D1tT+tkYatQf6Q/s3pSXoQM=;
 b=erdyCSGP7VZZTOSb99iU9FcB88CtotFM+G4T6vK3yLHDtPC9vf7H7NQzDACazfIq/y
 a1UEBWCv0M8t/WGGG9yB/5+E3Mzo/c7Qhr+ObgUv8w2D7gK6u7bV+6urUoOh/DaEJxgY
 ACLSFuOjzAoLoRTwksAWuh+EgoK53Wsy3JTo59N/ZfD+oRbndEs2b2XKZwatqoxs2Q12
 VTbBEOgM3Kd+8nuFCX2Wf4SWoHL9uSYbPKo5TtnxWEcRb3kVgvDrlUlyYB5IGbAGglSr
 93MiAO9EjVEBQZ3sKB7O2xyzZPWfchhMmU6Pen+BD6jyKlLDzdblq1TlipyiZb74rdNz
 7Fag==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMIGlFulc3G9wlnet19RMdvIrw7G3jaNc4kuIT1Z4C7phOQFbPgv08oe4XSPp/HNigSz0Nebk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nZbmh+iDG54Me1vqEmsbDMF7mTLbFNygCCWFIGfXVlinHsZNF1
 9jdzuNd//HK/cFdAX5mwgnZFGP6uXlfndmQYTS0pn+gW9rV3lJUT5a4UAdm2z527iaI=
X-Gm-Gg: AR+sD11UxPHpPIxe7/9tkIgHkX2tekWvpYIMl9O/uOSzuYabvXIUrMqSklBVh4W1iSV
 HmrTfDPVIjcHVoOOZcOinQ2ATgugPu6SxzJnfl9wyJptG7fHSKysZctLcHgAyET+BdRL8FRJ6uv
 yxUVgY3/iNXSpWXC1XQpRpHLLObkeV53MHJJxbgjS/WHBu8RFc4YBArgyECcOPCCIZNAufnVH+g
 Dv1IqtVmOXgm827hDmUyxuzTrg7i3G25cUO2B2G9s357aY7pzIcKXaz8DXANwKglE5dS3132QFl
 QnFzdLjQPMzWdiQQ9mr4RHjsC2S0pI9g139LqzLgdMiOY4WKq28OfFMdoSBXqghz5nXeheYhN9t
 K0BTrZfyT01PCxNt/HfDatfDfn5Q4Or34EoA1xrzwmv360+L9uWR2/6zrV966dihqPKSUSNFAqT
 og9Eh2BGUi4Atdejehn5DzjanU0R/xaROBlaTQd8ZZJmRdzQDzmpJ/AfQ55OGYUEtlKL9IxHYaV
 IhBsPiNfDCSr/8F7Hbv+K0G5XK6/vAgMyZsUm0mgsHcE7CJjd6LzlpqO/bTt0sqgxek0zauzo/U
 qj3ZZU10pGrdwoxM8tA=
X-Received: by 2002:a05:6820:1890:b0:6b3:519e:dfdf with SMTP id
 006d021491bc7-6b3519ee517mr15112387eaf.28.1788216369545; 
 Mon, 31 Aug 2026 15:46:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a4ef784esm11009499fac.9.2026.08.31.15.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 15:46:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Aaron Williams <awilliams@marvell.com>, Simon Glass <sjg@chromium.org>, 
 Mario Six <mario.six@gdsys.cc>, Stefan Roese <sr@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260823101128.87329-1-xypron.glpk@gmx.de>
References: <20260823101128.87329-1-xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/1] disk: drop Amiga partition table support
Message-Id: <178821636750.1229240.15262653910031973943.b4-ty@konsulko.com>
Date: Mon, 31 Aug 2026 16:46:07 -0600
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

On Sun, 23 Aug 2026 12:11:28 +0200, Heinrich Schuchardt wrote:

> The AmigaOne is not supported anymore by U-Boot.
> There seems to be no need to keep support for Amiga partition tables
> anymore.
> 
> The usage in sandbox*defconfig has been for compile testing only.
> theodorable-x86-conga-qa3-e3845-pcie-x4_defconfig and
> octeon_ebb7304_defconfig support GPT partition tables.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] disk: drop Amiga partition table support
      commit: 654242ac45bfc9d3a3f3a3c4713ca24c0b4e21c4
-- 
Tom


