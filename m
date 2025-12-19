Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE48D78770
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 17:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 283F3803F5;
	Fri, 19 Dec 2025 18:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="DxiXRUQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E6B803F5; Fri, 19 Dec 2025 16:51:27 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B72B080050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 16:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ofendt@googlemail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-37ba5af5951so16394611fa.1
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 07:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1766159484; x=1766764284; darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h7PDBY6GB8sKWvVBQxSPMWbPz9Bw1iPPmkVyTOYLBos=;
 b=DxiXRUQWXjAdHrBZyuw5O5iXnMTXWAs8Rnfbhdh3g8L8YqSBTZCGA8DendMPJTY0OB
 28ybrtqjtR9ACCUG3keGMVO+o0K8DCVLvwPi85UW+Q/ceexh0IHURPaHNTnKk115n5mH
 SRnK8WEiGWcCrEV85mX+3W57zYFF5sUbVqrOCnTqcrDMqhul9OsfbjU7ro9KN2Stdv8H
 rkG6CamqT5g3zf89xrEeXTPxq7QzdS6kxm8fAa9dXOOt2tNJFKqKJj+DQb1vTtq1Ks5r
 5P0f1YH3OCQM+upJBHiybMfpdD5MhPtGGaeMqSGjbmy80Dc+WnBUGzSZHaR8QYCykqDS
 4GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766159484; x=1766764284;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h7PDBY6GB8sKWvVBQxSPMWbPz9Bw1iPPmkVyTOYLBos=;
 b=lcBTlcmRCWqxX35Isaa8dUAekx6l1iBb2WKwsrLSGFui+Bh0ouMA34kR8DM949dCfz
 qa9wYsIE6yID2YPwnSHYt0wnN5tcCT20pp5f+hDV0SfvyvpBAWDQ6p/LEckZ7VQLYUhW
 yVC3K9dFJ4CfckahFb20Ln8UI5l8RAIO8Yx1oftA4jl77g/xCxuERrvjVK6VGEBtiyH6
 m/eO96ULiguWfAe6f4iXC16sMmpPMjxrgA+Zg+LdYa4Esq9F/3Uf4reRsAdgt/r94D1h
 tAytH/qlPka/IUHMta5wMyUsujEXfq0AF8lO3SgJlYaTWnpbrlYfiha10NH8gzwmghSh
 +YbQ==
X-Gm-Message-State: AOJu0Yw61Fvk32r+MbIqGP/+QL2HRnfDTiY3KICl+XGCD9yM2kUmGrjR
 BT/d5imHcq0AUMI8V9VLTkkjNI8Y331OAcYIdv5UOXpiWslJKKvoyTVcCKBlW60/Ud+D5sK+nSY
 R/YpWn0UjL1y1YLuMuXP6cftJWWmt05DKyL8q
X-Gm-Gg: AY/fxX5dJO4W4G+5AdUgv0LRo9Nl9nQlhROmyrC0GlFJqU2vVVVzSts47166c3hpC3E
 ffNzV1VzSbp4dNni2ZN+5wLi0ZiTM/l2EOsYhCCcIewiYxoBunb/bVRFd8U2kocYlGovXt7lZXz
 +L1qRg2TKZi3fUYVzLsJmbgoUAYDFp3ET56f5zxaQ4lI8dfp2sppwrGNkjdti+scuKr2z6O/zxe
 wIOIYJmr8E+OQYg8JKQ52VUZcXnYbhYBbTDNgFbZuqqDpLN9QRBBAJWLZHcVLZncb/GCtAOlQXV
 /n/oxUZHtWcVfEgFHLpubhL/4VMR
X-Google-Smtp-Source: AGHT+IET46XCx69lxXOP+lSkM7Tbhm/IXrhDykUebApRGlXS8KusvzxDxKoH3qLkFC+j+iecUl4ccPhyT3+ZLZalNHU=
X-Received: by 2002:a2e:be20:0:b0:37f:8332:6ae0 with SMTP id
 38308e7fff4ca-381216428e4mr11325161fa.33.1766159483763; Fri, 19 Dec 2025
 07:51:23 -0800 (PST)
MIME-Version: 1.0
From: oliver Fendt <ofendt@googlemail.com>
Date: Fri, 19 Dec 2025 16:51:12 +0100
X-Gm-Features: AQt7F2pT2fMZdUPpaidhiHOwoR9RUPe15DnoeHMIRyIwQrFc-Ub6DCMYZwpRBRQ
Message-ID: <CAFoF8fC4foffYJgYm9CkViET83gDu05noVRxLxgs+KWXN_-LBQ@mail.gmail.com>
Subject: unclear license identifiers
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 19 Dec 2025 18:58:59 +0100
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

Hi all,

I recently did a license analysis of u-boot an I came across some
unclear license information in files. I do not know whether this is
the right place to put my points, nevertheless I want to share my
findings.
1. the file https://github.com/u-boot/u-boot/blob/master/drivers/mmc/sdhci-cadence6.c
contains the following information SPDX-License-Identifier:
GPL-2.0-or-platform_driver which is not a valid license identifier, I
think GPL-2.0-or-later is meant here.

2. the file https://github.com/u-boot/u-boot/blob/master/dts/upstream/src/arm64/arm/juno-clocks.dtsi
contains the following information "This file is licensed under a dual
GPLv2 or BSD license." the BSD license term is vague is it
BSD-3-Clause or BSD-2-Clause or 0BSD or...

3. the file https://github.com/u-boot/u-boot/blob/master/lib/zstd/common/cpu.h
an others contain the following text:
 * Copyright (c) Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under both the BSD-style license (found in the
 * LICENSE file in the root directory of this source tree) and the GPLv2 (found
 * in the COPYING file in the root directory of this source tree).
 * You may select, at your option, one of the above-listed licenses.

when looking up the zstd repo on GitHub there is the same file
https://github.com/facebook/zstd/blob/dev/lib/common/cpu.h with the
same license information. The root directory contains a COPYING file
and a LICENSE file (both are not present in u-boot) the COPYING file
contains the text of the GPL-2.0 and the LICENSE file contains the
following text:
Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

 * Neither the name Facebook, nor Meta, nor the names of its contributors may
   be used to endorse or promote products derived from this software without
   specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Which is an individualized BSD-3-Clause license. Since the
BSD-3-Clause license is very clear in the wording " must reproduce the
above copyright notice, this list of conditions and the following
disclaimer in the documentation" the exact original license text of
the BSD-3-Clause license from Meta must be reproduced. Furthermore the
GPL-2.0 is acc. to the text GPL-2.0-only and not GPL-2.0-or-later like
it is mentioned in
https://github.com/u-boot/u-boot/blob/master/lib/zstd/decompress_sources.h:
/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
/*
 * Copyright (c) Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under both the BSD-style license (found in the
 * LICENSE file in the root directory of this source tree) and the GPLv2 (found
 * in the COPYING file in the root directory of this source tree).
 * You may select, at your option, one of the above-listed licenses.

I hope that helps a bit
Ciao
Oliver
