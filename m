Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A099C531F8
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 03:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B5583946;
	Fri, 20 Feb 2026 04:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="INAFqSch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE8183AC5; Fri, 20 Feb 2026 04:15:09 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 748BB8366F
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 04:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59dea72099eso1629239e87.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 19:15:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771557307; cv=none;
 d=google.com; s=arc-20240605;
 b=dDp6RrSxyc9lE7TKZYF6Lz8wAunv1yGYwMYVYFU1AcQiFHlmAUVsfT6NLsX+b1AekL
 Il0nXqiLUsjuxb1qdaqnMukyYrcxIoThuL5jYjLuRPqGPqscRawhAPVf79p8uZ26hSvw
 Oefm9yBWXL4TiwlWs02FENKY1wO+hhJ2rY0clsd7ItS6p8RZlOHrcPSWNhRGhG3uqFGE
 VLB/fjeCSHaW7UmKfGEL3NVuI7YNo4+/U70nSb5nD8alvZKh5XEOzHuiZzUCZNgqChDI
 BdGQfbUX1Ikyv6jgbIX48nqJ2eEliea4PLMdZwAeu/VFgTOc7uLAJxEy83vApwPw5emU
 mL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O1NywlZ4Vjv6LK8DolF3xX7VQzGXxdldsYgeXeaj7rM=;
 fh=3lo4XIJHbuFO6397WLtMUrCPWkNe6KTY1id0xGS59H8=;
 b=OwYkLnr/MQqsUR+RGEWusUnmUHe2KGbSbwiq41RxQMf5KVdXi1MVQ38ETG0JW0uBSX
 ZyW2CeNKVME3tUoSjheWx7hPsyf5aatdYab8FSOHXN/+lGcVH0X/Xe+uxKxPTrYudKk1
 40oTGT0uFF7BhvbQWKyGlHBA/Ydta5KjuLcPtSIa0t2KlSK5bE/qEjqllvSmMWa+ATp3
 5yv4FVHeTZ3kvrV12BMZjuLTfcI341zRbhdsxjAuBaaj//Y2pdrHpRgEOStOSX6Pq0IF
 Gv3g/sv4aZRPMsdHvaZflZxG9n5qZ0j5EPCszBe+mK1sAe9lAaG8gJXzg9Hu24EQYVUu
 4J7w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771557307; x=1772162107; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1NywlZ4Vjv6LK8DolF3xX7VQzGXxdldsYgeXeaj7rM=;
 b=INAFqSchUaSd5ggOggm3zEiqUPybVRAtp56otfWcJXPo0p8pgW/GzGKTAe0QMpsUqM
 4t55XC4AO/sEacb93up/8aESyepNxWQY4trcxRHSvbh+3Lr/YYR+o2P0kmUWjnB1HAuO
 6VA1Sbf5xlpdm0MgI0W8Bes8b/8bDdpadBc7zqfElfYFKDY6qfvdspyKgzpBShVuojnP
 ELe/v8vCJOvP+msANFJHgCqDBoVRZtgfvn2kJ1jyrTn1uzmlLMA31S3tVD+nysvC8VAD
 gEzduRpLsSXtKm3sXzmj2dKmfnzUrhFvu/gpDfhUPV23MsAEvIFinAc3TFB0FLv/5Emj
 LArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771557307; x=1772162107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O1NywlZ4Vjv6LK8DolF3xX7VQzGXxdldsYgeXeaj7rM=;
 b=NYgU9DCOteR/hg5rHD7KNbsPTNRhwjnU7Tma3JD3a82BR/V96QqVP9/7uNor/n96V5
 A7tnoS4mlHairH3ZpcN0l39NzDStnkf59BM1wAAtbrWSW6WUKtJkwe1Cz7a3GrKIH7Am
 8mEvX8a5yPFWk3Nls4TplZ7xNIWDZVSlfnsTfwuFS6cVwI3d3k0dIhV8Ab8GeCOIoZbn
 Ola7IHSVgkhhH5BuzZzfqpPIq+O4d/v8TrXnVf44wUh+WFUSfOzmzIkTKFgOsm9hcq8P
 fm2LblFostPr0L8z6ntX2+X5/Nzbvg9I2dftZrI6hc2gJsB23HJXZtk/ajbXWrHh+i4F
 f7nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRrsN7XVU6DSnwSF4iVbaw7bn0nzBWz5SaKysEo3xygbXcwX5WSveY4nuKbzXcpWYHAUhteDs=@lists.denx.de
X-Gm-Message-State: AOJu0YyrL3is9C92U/JMOkdyGsc1G0Y9Ekt5im3uhehIpGZyG76l+lK3
 v+sa6CIkKWfl4GiD/QtTCMHpmNhaDQza6TyNv7vSNgbQPa/mkXwansWHDKtv05ZmaU4k66OSmKV
 9vqDMkBWqt0+l+rwk3rlld99llW6BrVA=
X-Gm-Gg: AZuq6aJx3S4CXBJJWGhfr2oRUiH4R/mqvi3wALly2T4MPu6sfmJpn09JkfDMFeBS7hV
 2TpYMYR3CqIHkb6IHN+LVfKiC7jt5exBZWfcLPns9LT+IDQfKzoOyZjNfk51XqmYTS+n1JC400D
 4eqNgZn5AzNUGabjhtZ8iQ+qVmwjc0pXCCCReCojIzMEirUxEaCWXGiBdtUxzJ4pAFqOA05YYE+
 Tigqqz/4ScjyZlbCo23fEDobxYpwChl0P/ZqvnCelWdghbHX/2YneGoV+4cxyFBetOWhD6RMMd8
 gc9vptJwaPmi6nujsWR7p8/7NguTG9XDU/m7chUoRi85XpblU0n7UabCTeAXgyNL+Dc0AEQ=
X-Received: by 2002:a05:6512:1318:b0:59f:851c:77be with SMTP id
 2adb3069b0e04-59f851c7948mr1753899e87.17.1771557306337; Thu, 19 Feb 2026
 19:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20260211222550.739727-1-festevam@gmail.com>
 <2b5ebaa9-76f1-e2b0-4e8c-fc8b6c197136@gmail.com>
In-Reply-To: <2b5ebaa9-76f1-e2b0-4e8c-fc8b6c197136@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 20 Feb 2026 00:14:54 -0300
X-Gm-Features: AaiRm53OX0Z3Q7bZv_Yt_wKxuFtTpLMOJN66f67Idkbi9oS9JAa5349ZCS1JMZM
Message-ID: <CAOMZO5C2ZUmA=CTQ8YamKS_9GTwHN5QUXwmX0xeAGciUJyhKDw@mail.gmail.com>
Subject: Re: [PATCH] spl: Add generic SPL MTD loader support
To: Sean Anderson <seanga2@gmail.com>
Cc: michael@amarulasolutions.com, dinesh.maniyam@altera.com, jonas@kwiboo.se, 
 trini@konsulko.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sean,

On Tue, Feb 17, 2026 at 12:11=E2=80=AFPM Sean Anderson <seanga2@gmail.com> =
wrote:

> Thanks for putting this together. For platforms that have the space this
> is definitely the way to go.

Thanks for your review.

I addressed your feedback in v2, except for adding the tests.

I'll try to get familiar with the test infrastructure.

Thanks
