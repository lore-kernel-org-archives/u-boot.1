Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C43CA1002
	for <u-boot@archiver.kernel.org>; Sat,  6 Sep 2025 12:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9D683771;
	Sat,  6 Sep 2025 14:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OvkFrHQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 149A283106; Sat,  6 Sep 2025 09:30:17 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D799E809A5
 for <u-boot@lists.denx.de>; Sat,  6 Sep 2025 09:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duttaditya18@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7723bf02181so2299705b3a.1
 for <u-boot@lists.denx.de>; Sat, 06 Sep 2025 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757143813; x=1757748613; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yoPcwkEsOP1N+UNqvn/src1Sjc0cTqDc9Lpbj/BwMcw=;
 b=OvkFrHQ9TtrU3WETnjV+2qTj5zfcHxmYxJbPkMaG99xoRMn1hA9WujL8kGjlOTFLlf
 xemCfeuNDf+xPVWiv3UQpS0nMv8BxGz93W6HRAKTXCFnofkb+Z8e4yY6HG909plnyRj7
 1uwLFzrWetzPCla6SjtbkphrpRHEFhXmVs7j0WEJSmVS0lHqSWnxSOeczTQF1Vo64+xH
 +/ZOPDbQp5lNdGqsUIm/tLsHpTOGOEblbd4LUzmrJZtX6dAfIWa3Wub+TiI2U3Xywrav
 UA6eINFAV2rAhLCjJO/wEckjz63xlGkYSbR75MZBftdYvCTo44D7fXA1tdYEal5dE/hk
 +7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757143813; x=1757748613;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yoPcwkEsOP1N+UNqvn/src1Sjc0cTqDc9Lpbj/BwMcw=;
 b=lGEemqKRApU3RALYtvZNXSpu+YQueevNlBXhKNWab/rCR0Cg4W4XV4/2hGCZkoV8ck
 ABy1zGQDC3uR+pFlOWB55ADDEI4cgdMnN/q7TCBM1BDInD6hSOYrnIIhOMYk2in2mRw/
 Lc3v7rJt5gq//xIdRufALvjykKWpYzi/IVCTHNNZjrZBZ3r6JR/QRy/cxeBg5k2R0iVd
 zJdazxLuy65lVZ0P8sPSuLFSprZKq+fLbSiNINXG7LVUaWtmf3RRUPgRUNMTy1I6dx6W
 LXps4Qck4MwC5aa8P9Xpz2eB4+ASy4+6CYObbWnOPTlM2tFGjumCylNHTWBpwqUtfLaO
 YfAA==
X-Gm-Message-State: AOJu0YyHqqeZihcsVSyd8vbFzELmMae3Dh+sa4KH9joZnvckrcsf4f/3
 XlgI2Xb7voyS02GXABZHSpAByQaN8dXTKpd1VII2TTE4EWTsS5ijoxxA6H6jsdIE
X-Gm-Gg: ASbGncsjz3WWJIJnSEZiGtOoVo73Q5LkOqQ4gkrw/BGNa0LcC8YXjMrhXUDjSPtT00K
 FZ2c+eAYjmy8RlN4h+STbjWbDi/EJwe+7JlfLj2MhJn6RRX2Cov8fC7S8nLaTtRWPqVinHNbtIz
 fbAl6P+jKrolmp3N/RxJlCDlNRF49ITUjnkAPubIo7MEk+GfWtz0q+Q+UVkMygqD6A+vbUXAxhj
 MRw5lcDlWQQg2iPoyYCEceT7JjwV4v6fxlX8TnM5hzcnlwA759h+/JyKUjFskDg6QN47b4nvhZ9
 tUnVDIPjn6lKIDjER4v4vTgkTJdNKS20Zb1MvEyAykJorQe2tc5VIa5OLSCiQ0vFnjB9QfHJ1w6
 mXiusLxhreyN3jOTl3fxM6ZPYHoxdyQ==
X-Google-Smtp-Source: AGHT+IHSlYkfpUcGw/pap2OdvdC+Sd+gRPsHO948W7t1VyPpXfzYWRmfpeqGxDdEjQRSTZAseC7N9A==
X-Received: by 2002:a05:6a21:6d9f:b0:248:4d59:93dd with SMTP id
 adf61e73a8af0-2534640cda7mr1831814637.52.1757143813091; 
 Sat, 06 Sep 2025 00:30:13 -0700 (PDT)
Received: from [192.168.1.20] ([106.222.200.18])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a26bc9csm24097084b3a.18.2025.09.06.00.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Sep 2025 00:30:12 -0700 (PDT)
Message-ID: <ed4639d9d67fc676ae7975ee59d19ddbfcbe3cb5.camel@gmail.com>
Subject: Re: [PATCH] cmd: terminal: avoid serial_reinit_all() with DM_SERIAL
 enabled
From: Aditya Dutt <duttaditya18@gmail.com>
To: u-boot@lists.denx.de
Cc: Harald Welte <laforge@openmoko.org>, Asherah Connor <ashe@kivikakk.ee>, 
 Simon Glass <sjg@chromium.org>
Date: Sat, 06 Sep 2025 13:00:07 +0530
In-Reply-To: <20250905140611.238951-1-duttaditya18@gmail.com>
References: <20250905140611.238951-1-duttaditya18@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 06 Sep 2025 14:42:24 +0200
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

On Fri, 2025-09-05 at 19:36 +0530, Aditya Dutt wrote:
> Running the following:
>=20
> =C2=A0 make am335x_evm_config
> =C2=A0 scripts/config --enable CONFIG_DM_SERIAL
> =C2=A0 make
>=20

Sorry, there is a typo here.
Running the following:

  make am335x_evm_config
  scripts/config --enable CONFIG_CMD_TERMINAL
  make

gives the linker error.

---
Aditya Dutt <duttaditya18@gmail.com>
