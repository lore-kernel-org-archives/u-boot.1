Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D8AEE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 15:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9E2A838FA;
	Fri,  6 Feb 2026 16:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gsMSPJXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCC848341A; Fri,  6 Feb 2026 16:09:41 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA9C7836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 16:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d1890f5cafso288895a34.1
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 07:09:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390578; cv=none;
 d=google.com; s=arc-20240605;
 b=NJ8sIXpbpEd4MS9ZINvXrhQCxL2KIAPs6WIfQE8LbAtjjhxV1BLOWJiK3sVF85wS5k
 eYORMc04r6FMCLbqZWaz9sHsfrg9k6GF8dxzavNAnTw3IwoBKmUp5VFLV9GVRcteQTg9
 zaEtC5CYYrld5JeVd5YiP/IFDu7U75jcV3QDt51ul1mkYk2aEmczsQC912JJk4/7m6T5
 eb+euKAWRc5bIBf6x6tqB1/XM6qcKXtgJPlnUlTihHsIOmTxSAJSBDlcfnj3iuWWJkPL
 3g7RC32af7ILTpvK3+NWGBgOW7DViUODIvmlNYTU16hRhDx/aNHdkKe2OybblAB7rL9T
 0GbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=sIYxIWujpF9oBTNbf2AASfX/CerUuRIksHVYe7YLETQ=;
 fh=xsQ4Sw+woWKHk48ZXoatQh+mnVbrx8AKhQZK9frnAKQ=;
 b=lsg2w0DzXW8HzAiUjfLl73L6E2Mxs3v4oYYFPQJWWCUXAzLcY7mFI2fOiqUccHPEPG
 PSRTZKdgm+rJmYyNeg9zZaEV76RU07NNjl05HEiWLP+9WwDeDJlDPaQCZfXBBgVb2D+v
 EBv2Aymepah9+tYrZBiVIsXUurSb/+RMy3ZAdx98YcNuoM3cVZcCPGtp2RYN30LUrQkU
 qGvlCfiuX4gIXena/fZ6DNk0hK4A5PmZ/TkvdqbDyNsyiRLmfrNC3ScF+ymmBteBR04f
 d9/BMW186Kedru13Nz/s8ITKlbGrorwiU3fpPTUg8PrrdBwLLSAPTsPtoporZhM8guXa
 yBVg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770390578; x=1770995378; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sIYxIWujpF9oBTNbf2AASfX/CerUuRIksHVYe7YLETQ=;
 b=gsMSPJXckNC7x2VWnnnKccm2QgqYTlaoNdtnDRMEbIyIWP0SXcX0uC4nGu9oiUhG65
 DnTCpvUhGZ6+FJ340Di/ZEjT6WxzA2fXx8uXNibbDmhZJdicQLjamIBsobGJHBtqDUoC
 HklUAElOaR7jONyaWKPfYpNrUrxicpHB8HgKZP+rRsK972TJT/7290RHMaS/YgQnO0vr
 HQhmPKx4pJT/d8WnKAiy8B/2HoZudOuD7rhoQieGmgTufTp0qnsUZwtrz26uk7fmz2Zn
 RWZDrMydNfRXsUZGDwMQtUhZ0D4CgnEgAFXaLfQ7+0HvJChoSEBrQx+xYNiGpyH7jnPC
 6Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770390578; x=1770995378;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sIYxIWujpF9oBTNbf2AASfX/CerUuRIksHVYe7YLETQ=;
 b=a0ueVi8DmVmjx2TV2c9aygNbZOPA6ZNnygTzfnJpWo6hR6+HAKHdCMZQBwPsUY0qDv
 5S510qIaByYxyCw4a8wOcC+JdN6UhJ2RBF8JoyC6GxJ8C7rWB3kCxB+o6EaR2X6HBPvC
 WHCe8DFluDqapjecOKjEs9+TnyQaXkZSuwgSKo7PZApcD8b/7G2v6yhyaYcnYA6EwfTX
 txYZzuDTv89b/CI7qJvgxb29v72mstHSjLE1AdvPZdwnCEwMBj7IoAvCij2GEle1Kjhz
 jSkyP9bvKKyNQq3PU3dLE6dB2Tsiu+O5Vzpai38nAQuUsl6kgxUWuKYFSkaHLZDF4f1p
 SIWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr7t2v8mUwXaERRxxdZ3bv7av4Cd1AY8fJg5a50+1VhAI1hG8ny/54chk3twB2i3EW57fNgJU=@lists.denx.de
X-Gm-Message-State: AOJu0YyQoizf5eiyJT/DWoCqo7vu5ZvgdjUiN8dnOmft/AvVh29Qb5ia
 +369jEebeHL1ntGgUrUivRCRlBht/LwAE/4AnZwovuiy3eg2EPesgnl8ypRviGPDPH16K7hxPsO
 wm6K32TRrnsXzarIVrXG8xjJaYD8YgSgyTJPQaHhZdA==
X-Gm-Gg: AZuq6aJYN4+Fb/idhPqJaswzEEp6b2S7RsCHbAr3bUl9fLMiDl5k4nW8qx6uhjQiVI2
 ugn7oQeT+fWAHTCuHpGTKcdSeFr13I8Fta8dpoRmPq64YByRcAIICOY/WkrtKB0H//w6SivOtt4
 2d9e3plhtnMdFGHBftImr7d2ZlwtGDyUXun3fDWvfjU3VPfPrWTMMsnhJL6YWPZX+7EAdt/QUS3
 MB5Ai8P82N+boS2E7psZ68RLiZV6Qog/WeC7WaP9g4C2FrJwUPKQcGMjZn3KhKdNCl6fgu0Jp5Q
 pWFL1yg=
X-Received: by 2002:a05:6830:6318:b0:7cf:d1b7:c319 with SMTP id
 46e09a7af769-7d4643e8110mr1266945a34.2.1770390578530; Fri, 06 Feb 2026
 07:09:38 -0800 (PST)
MIME-Version: 1.0
From: Sune Brian <briansune@gmail.com>
Date: Fri, 6 Feb 2026 23:09:24 +0800
X-Gm-Features: AZwV_QizruTx-d0ZaofVbthMmimB14N7kVmmxtgf6gnqvQEcUsaUGmXLToHJ9Ik
Message-ID: <CAN7C2SC4GTf004JyBeeVtnBPo=BvqorCy87ZFTNV4RkWFOJKbA@mail.gmail.com>
Subject: Re: [PATCH v1] arm: socfpga: Add call to
 socfpga_sdram_apply_static_cfg()
To: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
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

Hi Alif,

Since 2025.05 to the latest master.
I do not have any issue as you mentioned in this patch.
Both RD/WR are used on the FPGA2SDRAM SDRAM2FPGA.
I tested 256 AXI3 or split 128 AXI3 x2 which is the maximum
that GEN5 Cyclone can support.

Not too sure what is missing from first place?

Thanks,
Brian
