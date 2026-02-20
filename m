Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462EFC5B561
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 20:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FAD283D8A;
	Fri, 20 Feb 2026 21:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QqoejBBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A7983C39; Fri, 20 Feb 2026 21:51:24 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9173583CEE
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 21:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d4cb7e10efso2114987a34.0
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771620681; x=1772225481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7gOBR8Dgd54qPoZzmZSCOxvnvV3V1GFtxqqNSfF7SM=;
 b=QqoejBBhhYbP//xHh+ad/roKgM7EkZJm5pbChqENcQLKBv/h5FZuzJIgZVzeIHnNBZ
 pp1oxPBzse0g5Gn1zn7Supg+tQW6cp/saU1t2xtMcxt8aO3odyl/hxKYZM7eZMtPG4T4
 Svx24XMi8b+Qs/KS8tbREd3xryDe6CJvB0Ugo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771620681; x=1772225481;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m7gOBR8Dgd54qPoZzmZSCOxvnvV3V1GFtxqqNSfF7SM=;
 b=KyS70CSeqCBGP/iTSfiD2asIVW8mD/UUcAB48Z8FWnxQvABk7mMTWZNZsWdq4WrNpI
 R6cWkKEO4Iq13ZKgFX5K84wgCfovweHhHpS0uaxT9f/thMeUjivC6rhZaVTznFrPzhPR
 zlH04jNmK82NxmQolTVAQi5MNTDVXSScNxIcK43pHR2d9Oi/Bg1ihJtRWfTlzOvkRi5y
 7HSFteNvkO6zCSlOWtMimLIs/rAKYHCeVGWxVFIcF9GxW7pvBkRXWUPCxHMeNAQI9MDD
 cwIpzMc+3AfOwtUzNwTAc9KFjp3SDdK9m5n9Mjrx3yR/22qbPEXxKgRJV2U7lbsNaNcZ
 +T4w==
X-Gm-Message-State: AOJu0Yy5nnuQaFSsC2ae5n+5vDIth1GD0/TrvRQ8dirVd/o18BCAmV7B
 Cir7O4EqxvEGpA+ML0BIH6PruuQkvByiC484CHj5GrsUBC34lyNWeTe7KWDPBX5hPKyvWYFqbV5
 H3SNe7EI=
X-Gm-Gg: AZuq6aL9oBzNTmSVCUlfesTZd7y7PakXE4LMVKhj2mXlaBb08BJVoP8dKGI/5Bk5c9O
 Le8SXhSThbb27NnTGlrn9P1JJk1OD+eJFaNSkDD4heCyV2+g5zB3/yvr4xZ4MN8aIK5exwPc3UB
 lmdTexiEu1YCJsjazAEpDw3S9azSiUu0/NOYAdwPMUAzYTTbi6ywwRdg+xLKVIWY1sw4Q3PD49b
 p2yN5C0wjBtICRUmva6xxh9WU1JTQwIUSPSQs/vpQmVYHEs4px4WVuShV1cYLIeYHnMZ8Vw5mgw
 YazcbK/Unv8lyXaF6mE5BwT1d5aqxGb0z1jQm5/BxP5grbM20f5tnB1MYNG5MKVuKOKhoIPwRSR
 4Z72zCw2xXzCKDMs610hMVugJ6CIeLr7NG/Gy7juhpcApAPDn9NRk13ml/3LBLByX5+KbW8TdB+
 qHuUP2ZhhrMqlrk1xKnQtVPBMPET0Yg2RpO7aGay4fXsH0KK9lQ4NyBfDsjIaY9VpUwy+NUGDO3
 ooH15vcQebLWcoHlKGOZXZx6C0m7zFekhQM4SPxiILeeVUfaQ==
X-Received: by 2002:a05:6808:c227:b0:45c:75ec:b9b3 with SMTP id
 5614622812f47-46446181296mr884326b6e.9.1771620681173; 
 Fri, 20 Feb 2026 12:51:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cfed28esm525818fac.9.2026.02.20.12.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 12:51:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Christoph Reiter <christoph.reiter@evk.biz>
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org
In-Reply-To: <DU2PR09MB5294504C1221EF029607D88C8E3EA@DU2PR09MB5294.eurprd09.prod.outlook.com>
References: <DU2PR09MB5294504C1221EF029607D88C8E3EA@DU2PR09MB5294.eurprd09.prod.outlook.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: Add Fujitsu MB85RS256TY FRAM
Message-Id: <177162068021.148229.18432942989354958228.b4-ty@konsulko.com>
Date: Fri, 20 Feb 2026 14:51:20 -0600
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

On Mon, 25 Aug 2025 05:53:58 +0000, Christoph Reiter wrote:

> This part is an FRAM, but can be used through the spi-nor generic code.
> 
> 

Applied to u-boot/next, thanks!

[1/1] mtd: spi-nor-ids: Add Fujitsu MB85RS256TY FRAM
      commit: 311f9237613d71ac1807db59c16c2250076e9957
-- 
Tom


