Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376D2EF99DB
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FEC883C4B;
	Fri, 13 Feb 2026 21:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q3LzY3ts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B0FB83D5D; Fri, 13 Feb 2026 21:16:30 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DFF480B98
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4638fe85a7eso381130b6e.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771013787; x=1771618587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FJjpKid2oDEkvOv4Y3e37H9wJp1I8M55sWrYYixJmc=;
 b=Q3LzY3tsR/AlBYvBfpfJsODIPW7a7uTa42FgcO0YFXJEGIeSTgZ6XH5CKaJ/vd+aAc
 HW010e+9u6bFTxMA6vvFVg/qY32plL4d6Sl4yOwD7770Jz+pG1hv06kq3u5McF1sb1Cf
 PxuGgAvhBvRFVpdSjKYH+uOYZAzzyuqf8+WGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771013787; x=1771618587;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0FJjpKid2oDEkvOv4Y3e37H9wJp1I8M55sWrYYixJmc=;
 b=giM+lL4+QvomiZyYEj/PEzQzFvswjM3Q9i+9FzczpcFkMQjrwosOmjARweOQMn6wb+
 oYoi9CpWmfl71Un8/2+eHv6dpidRQKqJ+OhtLjfoEx04d2L5lpdCQrAKxgDeJO5XBjsK
 mZ3BUu4sk2pF0ALwI0rg1yTh0mAg3FFbITleBrXLFzR975ruNbJF6dyK6Tjx8j02rIet
 3WXhxiOmfO1p3l1ZK0eKHTqmeJxmQtBGjXt354nom4x8PGWFv6FLw9BytVAfAQSTbuZd
 IqsojTY8u+skFK/Iy7SM0kLsRJNMc7mZWWSfLtdnZUIoHml2i9CEQ+1uhUWEYaoyrrnM
 HF5A==
X-Gm-Message-State: AOJu0YwseCrZnumMv5mWGvYTit9cD4Gnn3KzlnvDi2NNaakDkyecC+0Y
 6aQSByVQBEamFtgzRqB142EMtuwRxaXEV+HJNEJuls4GoV5Xg3NBZg87Atu4GKVNu8I=
X-Gm-Gg: AZuq6aJFunvosYTLVf4pxQ2GgBMQnzHxKYsCHnEg+Dry1EP3nm0EVcv4MEps5XxpWGi
 2XsZ5bcSmlh6o9uyidWIVwwYbm8eSFH0sIcksp9lYT2k2cjsZIVMbnHMyeNftboGobuzAb3LXSn
 AUfkt+TcxpOASbKOv+k48wwGNWsOngCv9yGuZl0Sp29xHqS4Zvi73hG8raphVrLY89AdCWNE2D/
 Q2t7bq/EcN499HjWzHGrlvvxG+40+hsAxmKfyyxiCubIJNz+J0ZJgwM0CPWoSdBMjFFd4X3Ukjt
 3b4UFeP391nmcTFEViecBrLxoElTkcKC5yT5NWAu/ULRVwjxx7m7DSVwerjeTA0Wsj1nxSaeYv7
 LU+yle5uHz/XuxbSs2kz+YR26iaDA/KGn+gTuJzM7YB3vali5j38rcbkiYgqrLGyn3NdUYNZi1v
 Gm5SG+UN1yaXxkpKvBh50wAgoEUB+7TBkbNFsJ4LVdonvLFx0W14FJkjvzdV1YEossU2YYMSkEd
 OWE/ebOw7S8DYsVmHkiGMEpgkYsWbubkt9xynCpuLuZ6gxQWw==
X-Received: by 2002:a05:6808:c2be:b0:45f:1252:b717 with SMTP id
 5614622812f47-4639f06669emr1655495b6e.28.1771013786885; 
 Fri, 13 Feb 2026 12:16:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm5152025b6e.3.2026.02.13.12.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 12:16:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shiji Yang <yangshiji66@outlook.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
In-Reply-To: <TYRPR01MB155526AD71D445F89066AA77FBCDEA@TYRPR01MB15552.jpnprd01.prod.outlook.com>
References: <TYRPR01MB155526AD71D445F89066AA77FBCDEA@TYRPR01MB15552.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: remove duplicate IDs for w25q32 and
 w25q512 series
Message-Id: <177101378601.2522051.1463410732442722722.b4-ty@konsulko.com>
Date: Fri, 13 Feb 2026 14:16:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 26 Nov 2025 10:04:09 +0800, Shiji Yang wrote:

> Some Winbond Flash chips share the same device ID. Names are not that
> important for the SPI Flash, hence we don't need these duplicate ID
> definitions. And the Flash size of w25q512jv is actually wrong. Clean
> them up to keep the source file tidy.
> 
> 

Applied to u-boot/next, thanks!

[1/1] mtd: spi-nor-ids: remove duplicate IDs for w25q32 and w25q512 series
      commit: df5dd0bff4459e32bc574c7c9e30929b16544792
-- 
Tom


