Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA7AF436B7
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 15:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 320948431C;
	Fri, 17 Apr 2026 17:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S9bSRRaY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107898429E; Fri, 17 Apr 2026 17:52:35 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC555839D9
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4042fe53946so387667fac.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776441151; x=1777045951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoJJfn5cJDq1usWtAcsYaZSA3Al7Opqw2mP3YAcPqXg=;
 b=S9bSRRaYutx+nuSP4lFAmhnKFjjex5K5CA8N7SqQpFBRmBAlzloiQmC5YYdYJVXX7b
 d18vM+uqDHDfoINm0PJEgm+3LG6GeT+m4Qvp2WxzZQy/zKANfR9e98kXHbKa1n+ljq5y
 tmieZwLeSDpXoB82uhx1+3+Nj3UvjtnSXRFDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776441151; x=1777045951;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QoJJfn5cJDq1usWtAcsYaZSA3Al7Opqw2mP3YAcPqXg=;
 b=e583WdszxJIRv+lULWR0nSxHpLmFS52n2K4L1U0RjLDAhmpCy/Lhfon28ua0zZ2c2x
 Xt1pa7dDA4TgYFTjTNjI8oY1KyidHGQDhnFiYL5LOu9v+HPBfxK5pHfF6yAiJdH9723D
 6vjeaFsA+gaN8BMnTJVFNXZ3tgpSyshlJqsLIC5oKmoap2P075QngUkBZ2UiTyloudga
 wA7rUTMUimxBBoAuXhICrpfvxwwTQGo8GKh4dET4aXSuO4LbFM8rTmpcjz0cU07XP819
 ms3sY9e9AYh24bANE3+7pgfrcHcTBVn9N6+h5Yb7bDHvl52hoes5j5KiLwarn9/9rvLi
 x+2A==
X-Gm-Message-State: AOJu0YzojVKmaCHMWUkUX0BE/fhqsgNGmwBCYzVSRVXsKhhxbmgDPWo/
 8AnKdjW9gxLwVNJKbPCNilfV1SjGrJ4cRlyDYydXN//Lth6EtgE9Tn3xGJ5nsOSa1k4=
X-Gm-Gg: AeBDietmlSvCJijvpNFdc6Q60eM490DLZYa8xoD75SXRWf2Iw4IXI9nzkygeEdggiay
 XObS8pOQl+d+bKoJHhJH72r1ORq/EQE2PUzDbrXCgNcXqcDQj8lRD8kfXX75aJ2JyiX0kDL8Yji
 sOExU/CQvghuAK5rtKe5oO/sd95QlhysEWQCj8wQo8B7KxS+snGIK56xxu8BALsBoLIAACIEKoP
 /JU2XnXssMudpLfFZYI3JoTk/0hLvpySVw5YSCq6OpfFjMBDLhQPs8HFeMeyqx4NCDG9UTXjXsz
 7g3HTH+odO/xyzrdjN31r2d0nqgDeLKf9/A18Jkt9Uoa+3eaO46WEQRZrTEBfLYB/eFNDOFNo0W
 T24kVpP43vqcuBm1w3cSo5iWIMPnSdDmp1fUJdsdUKtREMVlyxYHRJ8vkwil2559oUXTh1tpsOX
 84mAjOtg9xqhkSOHPoTjZkNJV1cEclW/RYbT0K93ad2iC1Ph1OCm6QmDl4mXjaeFp6Id3RolGFV
 XWTlanQw9i76yQBf8in/5jGeOPbccAOaqXKW+9YYHto0r0ANtJ4KeN5ks1c
X-Received: by 2002:a05:6870:b61e:b0:417:1c8a:6ce7 with SMTP id
 586e51a60fabf-42abf213308mr1888386fac.3.1776441151638; 
 Fri, 17 Apr 2026 08:52:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a1a38sm1684214fac.11.2026.04.17.08.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:52:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Jeffrey Yu <jeyu@issi.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Christoph Reiter <christoph.reiter@evk.biz>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260309194410.23882-1-flaviu.nistor@gmail.com>
References: <20260309194410.23882-1-flaviu.nistor@gmail.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Add gd25lx128j chip
Message-Id: <177644115042.690930.10820909885481164362.b4-ty@konsulko.com>
Date: Fri, 17 Apr 2026 09:52:30 -0600
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

On Mon, 09 Mar 2026 21:44:10 +0200, Flaviu Nistor wrote:

> Add gd25lx128j GIGADEVICE chip to spi-nor id table.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mtd: spi-nor: Add gd25lx128j chip
      commit: 3009978976ecf0824d79783645363fa2412e1150
-- 
Tom


