Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D705ECD37AC
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 23:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D85884CE4;
	Sat,  9 May 2026 01:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TydBSvPx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1278584CE4; Sat,  9 May 2026 01:47:08 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29FED84CC0
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 01:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bb962ce4dcfso383941166b.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 16:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778284026; cv=none;
 d=google.com; s=arc-20240605;
 b=d95dZsUik2wPJoURIKwQLlA8K7C1Mqqo2emO+/rACs5+8kTKs6y6wS+eVV88CiCOGd
 aJ+j3EZpes9OSFPNXhbDqyNY7+wv/bOCsbmbwCpADBhvIYB8K1rv5xs6ouIpjDpKTz6c
 QSfrfhke1hPVKNJcd5HaoeBUFqTrilS9B2bQXVN8aRsocrAalK3CM2gaRiaBKn3/EOVR
 hC2o19+btoTBU69vy9WPg1gRT7Nk3k0EYfBKmU+ux4Az4eWQ1bOkvmQvrQaIaEW1HyuJ
 xNf2OGdoUnDDhRNfrr/eY+Es00rJPIQg9C+E4ekdPdqYa10WpYNTFWgbAXef1069cnVu
 N3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SMGjEIlKZCI6lhmqQcgqzf3JJdXFxYf9CSa+XQe4VpM=;
 fh=hatAu/C+vqQCTMAAcYQZFwhxS7dGMK7Rdd5GOgZ2sNM=;
 b=cg4Gn6rAbqeC+jl47B2rD7AwMEGY1vb6P7SwC11+pPi9e+/cqqkCF6yu75mG+f7yKy
 8lIGsrJJe/yz1iio13q7dvZwU830Ej/GkRZTVz2GmZkPDsb62EAPFcdbgWUgeHNSyXbE
 sRJ9rC80NAH+oqJlqF46TEy4KJZUGRZYRMPi4cS+N133jQ0Otdd02tBHzmZZoYi9kHZN
 44H3kDEERVmLVVHXYoi8sz9iiWzicKTeFqttSF/6ZFA/aL1BWuGjvD7ItILc3Sjiw9GA
 fzcmsRrs2URvjXdpa/qPyBsoOPljmlydTKgoHZcLwd7xPz6d+ZGTCuXVfGWBOo3lN+No
 KW5Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778284025; x=1778888825; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SMGjEIlKZCI6lhmqQcgqzf3JJdXFxYf9CSa+XQe4VpM=;
 b=TydBSvPx39Hl+oUIDQDkIgdQm/9f14lib7+SDuXidIDM+4dSozTgaqL6uhNf5sxjVH
 AkzSpP2lh2xPEkZ3iRsHZ/9DoVJRIrhn08pgI5bKkBkWTl+OHfZgEH1tVWloAgixjSFq
 EnIr2LDLNYtjbT1FCQQy0zYv5sEZqaR9LgCKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778284025; x=1778888825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMGjEIlKZCI6lhmqQcgqzf3JJdXFxYf9CSa+XQe4VpM=;
 b=Ww0a5RQck3ZwQXVCji7ajJqftr5Tubs/laCCWNJ1l2g5gc3Zzl/zICDd2bXILpwNCL
 OQOU67m67JVPnE7zHFWSbYsxZawLPxMWLRMVN+5hqOj7S32hdr+KsET/P1r1d4bfM2gQ
 dcnTOGTDNCMKhWGDbX1pJtYyMMPK4ON+ioRU99a0gNY3i0g0el87ju8QAKNAthw82cnU
 ofkSIxXFhXGTE5Pe/8u9nnEkyPXMV7eRDJbhF6rLDGW8AVMoSSZwGBM3qPmK6M+fbEmp
 /+U6ZP2K92zsPLJCLoqFWp3TTjxFXg50WfBuaW/iYoy2UdPHJFnbV2eSEJhwoEqt1NyO
 zLIg==
X-Gm-Message-State: AOJu0Yyud80SmVS7WMqHs0KHbOi2YTw3twDSlEmR03h7ntgkK9PTlMaW
 lyJj2it9vfMqKy0VSpZ/1z2Dtv9DpmR2xwv4oCh/EFI+m19ieCaZahcd+zIw/+zDLuFMFP4dABH
 7AkUcgJqupXOAXPilfLjQWFAexb+jllHt/bIqjViZh64XnVtQQzk=
X-Gm-Gg: Acq92OHNlXE4fsvR+XeDbbfx+33oiiQ0O2szHUSBxroKLomxu/1l0/NWdfQhTo471il
 cgmK1RA031LMjVz6+TN3uwb8lZgnIE1hlIteX0iDZ+QYB7dLBATuQnM932wOu0DJDnNURoBKn6l
 X+s32iKsfgzPuZuFZh1ExCxl80lB4vN9aW8+iatWRSHqG0W7W9dpmoAVA+OpOQ+iYhfZKl+GVAf
 foHKQjYEGHJibq+eXJfywnNbw5KZ2ICUnAWbGgtPGjUqyc986IW1l/z9CyQoJrJO/fnfsMrklRX
 UuY2ww==
X-Received: by 2002:a17:907:930b:b0:bc1:1716:2e9c with SMTP id
 a640c23a62f3a-bc56b1272a7mr889871966b.16.1778284025573; Fri, 08 May 2026
 16:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 17:46:50 -0600
X-Gm-Features: AVHnY4Idf45w-BcCFXu2Nqr4sSfEHUoVwMXXTdxsuSp5FTcMD3XI_v7Zy0c-8gk
Message-ID: <CAFLszTgAwQP4LXbBq0Dwv7wSBL-BH3-kZc2yNGKEt7UefP3DTw@mail.gmail.com>
Subject: Re: [0/6] TQMa7 eeprom sysinfo driver
To: Alexander.Feilke@ew.tq-group.com
Cc: u-boot@lists.denx.de
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

Hi Alexander,

On 2026-05-08T08:48:28, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:

> This is the basis for additional patches that will be sent along with
> updates of the TQMa6 in the near future, including support for multiple
> indexed sysinfo devices and VARD (variant detection) data for newer TQ SOM's.

Please add a binding document under doc/device-tree-bindings/sysinfo/
for the new tq,eeprom-sysinfo compatible (the i2c-eeprom phandle in
particular needs documenting)

Also you could update MAINTAINERS

Regards,
Simon
