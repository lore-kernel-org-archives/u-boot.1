Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1D3FA3727
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 00:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 269EC842CC;
	Sat,  3 Jan 2026 01:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nkQQp2PY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51EB583BDD; Sat,  3 Jan 2026 01:44:21 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B20083C0E
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 01:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4djhds2q45z9t1n;
 Sat,  3 Jan 2026 01:44:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767401057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tM2re7z3HpUIY1rc7g0gNNWD5Ijib7RUbEMgjY07UfQ=;
 b=nkQQp2PYLvYYP+9Jl/L6AULpm4fn5oxh3eQ8K6aiB3RwzJy9nnW9BUVzOMAPDLCmUXxjEq
 xJRXByTPTNfMACYOHc957vHWChkGmXh9kyvepb4kjP82BBZKy0w13ckabyB1qF+wAL5906
 Fv6RPU4doUba2wr6N6FFnj9XumTm8lKmwgX9sPc78gqNfjaIskVje4jeHMTvIdkH2BtieH
 vt/F2uiSr4YMYmhJSWB33matUmlDHrjQOuqMR6koUzptJVC/m26kPQgrmQmmKTcEYYIpCT
 Pm0ckHGZFmXM5VbrtvYif1aBVosI2EsykOGOiHamwcOJ28gul7iGKL+wVHZfUQ==
Message-ID: <023a13d8-e8b1-44c1-9b4d-37067585b98e@mailbox.org>
Date: Fri, 2 Jan 2026 20:33:45 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] usb: fix typos in include/usbdescriptors.h
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20260102191956.266773-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260102191956.266773-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 098d1a85cc4511cc646
X-MBO-RS-META: sms5hh1qdb7dq7ksm9uk4ec8z4i6r9x7
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

On 1/2/26 8:19 PM, Heinrich Schuchardt wrote:
> %s/heirarchy/hierarchy/
> %s/usb/USB/
> %s/configuratin/configuration/

An actual commit message, which states what this patch does, would help.
This above is sloppy, sorry.
