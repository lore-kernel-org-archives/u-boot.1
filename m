Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E423606A32D
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gSlw55Ev;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VK2dx4R2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 764FC81A5C;
	Fri, 13 Nov 2026 21:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kav1YkjZbKa3; Fri, 13 Nov 2026 21:04:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D119E81A64
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794603842;
	b=FvckSLIE0XOxFfbidxInzPwaJrK5+eGRJPQYWfXNxwML3w3xOTlk8GQDdhQ93ZjOsKL3
	 +je+UXbxQ8rxbErdcmoZBJY8DfUFsXfBCawFubXdJI/h822lN0fS62YMqWKoYbspTvJF9
	 qzkWh7fl4y/4r2pFeTdSAEdC05j8a4x2MUIlmyPrR1TIRPZdy+/TuM54YIgfUaPNx22i7
	 CswZd9KFrSb6zho0glCqClJOwV/v6P9lbnqM+nh3NMVpeGJh2GMWudsy7hGJ2U8pa4uwj
	 0VeKNu41jl55Le0EGhT0a95MDIuS52xeRk8gFPW/vkL/yDtfP/pjAByUk1eXfQR+AMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794603842;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rDvro9MaEMEV5zYNCOHe3ezXOoeDvuyEn83k5v/zD9Y=;
	b=DjuJOQI5JQUU6YuaoCxcWN72MU2/jF9W+LaL6gVEcgE+sTCYJhwGw/ZVOzCs/OdTnnQQ
	 cj49AyiLA6iQC6uM8xXIbK5co/veG2ZBIE8QuN78ti1SHZ4j2AXN/iEB/uF9d1CHNA2sS
	 yfomEaNZ0LyCFyXvC1soO4/twLwsfwbj3z3G19i9mGA6eJHB1LaM/d2TSDFL9jhjqnIb8
	 RP+sO4sx8J2AcVl3e8mEmALNErtiVaMgMMGhtlDQpYztq5t2Js6cn8vt2xMlWuHiQ7W9e
	 l8gGJhHqoCYTPPUv1L2Nsr71tCAKVgEZdcfmR1u3OQn4sltUC7R9nQGMWpSXodwEnOw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794603842;
	bh=rDvro9MaEMEV5zYNCOHe3ezXOoeDvuyEn83k5v/zD9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gSlw55EvjlFewExahZX2D0GSlso22RnNu4hGN705ks2+6fjRwCcmUMemQHeJrJq8d
	 A1NYLyJUAxoUSKsnS8WsabrVw8QzJi4BQMELjtcA9vY4syYasc6rMxSJ+G5kEDu6Fv
	 IpBKLerCO/nb++WBo8TuCh4FL8vZ2PX6msjz7mIc8pCM+vFChJi+uHgJSg29hSVSxm
	 yIkFnrGokD97Bcnoqfg/FHyWGxJ+AFXyx+ouupOBgIcIELZLpkAHoY1VCi4mwrE7UK
	 SfQqYlmf6SBFuhyhG+/D0NVmifLrR4PtdLLnqA0mJfk/D/TnEnXw6GLng64Qx/rP9F
	 DmlCXFGyrBu9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D119E81A64;
	Fri, 13 Nov 2026 21:04:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8184C150
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 20:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 736904067A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 20:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OWroGpNQnrbT for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 20:33:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 874AE40A79
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=aiyengar1990@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=VK2dx4R2
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 874AE40A79
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 20:33:49 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ed0f842b02so2528385ad.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794602028; x=1795206828;
 darn=lists.u-boot-project.org; 
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rDvro9MaEMEV5zYNCOHe3ezXOoeDvuyEn83k5v/zD9Y=;
 b=VK2dx4R2uawJ2cov4biO/rSZx7TrEo23E3916OkSf8WB6WbK5zs/lMgJNkW0qY3vsA
 n93a5MUhjcXzesUBOLZli2XTSjzsyPWu3d32V1LOSTZ+gwr+q1i2EIS+l02GGtkyac1d
 +866A1x9yWsDtjDQXaQnh7RimAy6caV8tIxst8i0b8V4k7gJ9Ux9XvNEZxF/MWfHVQ/7
 WN8uwXAO1CRmspq08amCgQCB38qNQmPaKfLjf8r2aIKHvV2i4Xbkr/ulLDPQIc/biPOb
 CpNIs9E0OrvDhvV/EjZ+xjlUF1LXlcRcIBDzfoXEQRJXzP1BYEA99koUTweZWPrX+7d+
 fPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794602028; x=1795206828;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rDvro9MaEMEV5zYNCOHe3ezXOoeDvuyEn83k5v/zD9Y=;
 b=g/q4mx2B8ehQKlDoxJ3hax6yBBdYB+OzyzGRlqfpRbKe4C7oqXPBGP0Hm425MQpXSW
 KF7GUkePVUp/BgLQl6cBajh4h9Dl2b5g5VmwUrCnVra9W29b/+pglKdwWnJ851TaxxU0
 0IGrz9XlyptjIqEMGOCsg3bNxehY8lhtdV9PQ2h+2Y90Kf6H0Z/MZzvUrjBgEYBz9h9K
 4TlDt1y1+ZHDrEIp8fE99ad5I1aJO3X6TosUTSimbCgQdM2C+zLXHN5w3doaxY9EyHvd
 NBxdkGjnN/GdrQsHien88y5UIyIGNosXAcL1jVecFiRtdAPE8FCqVeANGKeAYrYLQ26J
 WG6A==
X-Gm-Message-State: APuU4Z+qf0USh0ikCtBqXQz+ASl39VSGsSiiQ/nhCbnaJbAlmsz14kUG
 EBWIYnE2yd8IFiaW6wuvPzjzXCoSMmtDlvDiTm1Fe1uGYk5jCCgVgh1uaQ4/Op1tjaU=
X-Gm-Gg: AYBFou1A2W5mcrI7Os5XKTGTHontgGUqCXfXi75OLUSII6LvNUPbNf4wF8Q5Ms69pH/
 4utkHEed+Ex/BIINjUiHvohbs6zCHYb9/pAnVRDqJL3iIea79DcUnW9DdLynKawnyIwPIFg4YCT
 AJN1AAcRzOxq8s1ofysaismGPDB5mZC3uchccKFzkvTQnZrFZ/a7ZmZr7cNLPu/USeZI4EmtDv2
 mGGDicg6dlOVO+ShGLua7XiZfMT9bGch4RgaRzvbSer6lD5ehaW9PWdlxLCd6PcUTwp2W7yOfT2
 gmbDjrFt1oVz/4M+ZJxZ+Lcg01Bn2Lj16I2k58eOPNLleieiwslgrKv4z6GWC0Aibc6G4bRsZ43
 yitZOptNnDfgbmQAzauGgoW+/fh1ltVmCHEFo/Ndi0wB7rhVubWMu8ixNzcBoWTkNVuFHOvKqwa
 wv1eCDII6+D7NaC8w5LWhOSXzKR7eqh4xk7bD5buR9RzrO7gXfloeIzLx/+PVrAoyGkglkpxInL
 e93SHJLUJ4JAddceosxnXr3Gztxl8OSa+Lusmy7cs2rKFzDPZ8NtUWK+opNNZo/5MBJE8sqe2yL
 5b8hqHfODWSGrX6zrgugO83SrbZqLLa0emHdGj8jp7I3fAHyKLGJ9/ucQCibqJDNsEkZa+DI0It
 dOrhelA==
X-Received: by 2002:a05:6a21:7986:b0:3eb:65fc:1a5d with SMTP id
 adf61e73a8af0-3f7a6cadaa3mr4350860637.1.1794602028459; 
 Fri, 13 Nov 2026 12:33:48 -0800 (PST)
Received: from claudebox.iyengar.cloud ([50.39.139.68])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bececce02asm1529657b3a.2.2026.11.13.12.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:33:48 -0800 (PST)
From: Arun Iyengar <aiyengar1990@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 2/2] sunxi: dram: retry transient DRAM training failures
In-Reply-To: <20261110-h616-dram-retry-v1-2-ccaa6d7a6ef1@gmail.com>
References: <20261110-h616-dram-retry-v1-2-ccaa6d7a6ef1@gmail.com>
Date: Fri, 13 Nov 2026 20:33:47 -0000
Message-ID: <179460202745.190218.1546334093511047720@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 13 Nov 2026 21:04:00 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Before anyone spends time on this patch: I have not found why training
fails after a hot watchdog reset, only that it recovers within about
3 s. I will log the failing training step and test power cycles at the
same temperature, then send a v2 with the "keep the best geometry that
trained" fix split from the retry delay.

Patch 1 does not depend on this.

Arun
