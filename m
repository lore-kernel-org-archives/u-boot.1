Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4D0C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1203083721;
	Wed,  6 Aug 2025 16:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g3tZ0cHM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="P+CHjQIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E4683A37; Wed,  6 Aug 2025 16:37:21 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1444A836D3
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bxtDG6Rj6z9tFV;
 Wed,  6 Aug 2025 16:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754491038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6cCtoDqglqeAEnWeLI5D3N11sJ+P1vG9DWw5k1EaTE=;
 b=g3tZ0cHMaO0uWvJIUR+9VfadCA7meSINHqhDYJlgMVfU/5ramkxN1dBHQKuQz0Pgz7rW7P
 HJruy74zOVKTTNgXDFLXhhW9AgRwVm/xUuAdy7EkuywU6UEBAP+AdeWE+jDeV7o3JiwuKv
 nSW26P4BM/stZ9exoAm0ZkGh507JjDs1dv1Txchl2Haz57Q8JcbAYTDvYcQS9MKwSkcWBo
 9TugnHf48zHx76mdz/O7BHwKfapdfp2VwWoBYbAAF2vzV+vmsPxaS9Xyzne5mm3010GOh8
 2PpWXkkDCFe0IqUgDL7ocywYwmAS07xHPzrSZbOTNEIvr55Dvb5QteOLYKljDA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=P+CHjQIK;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <f4600cde-0385-47d8-af6b-1899bdd6208e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754491037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6cCtoDqglqeAEnWeLI5D3N11sJ+P1vG9DWw5k1EaTE=;
 b=P+CHjQIKqmQfmeKvaXcdd3cvroj7sxWYyUsgaDA00HMVCbdFR0szcpTIzzuerlU7djVj88
 KL28Dy3lykb8oKDGMAfqGDApU/e2Lza35zH8utkZPuMwqzqBpjqeYSOJl/92dHqZ3/TuOX
 6eYcATcZjeEIaDp2FXSxqgz6wAxAmtktXm+jtE12ekikyQfydeY1jJO/VdkTd3eZDw9Hea
 EmLQuuu2MEU3uleWr6PjVMFR2jZnFryizDLf8uq/BU1VlzLC8ca7hlkzgGfJce3EAkt7Dt
 glr+RR76d2yE2pdCh2/sV169wfP4JuGqkmNc+1eDctEtdks6bLDEDJ/YmV6j4w==
Date: Wed, 6 Aug 2025 16:37:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] net: rswitch: Fix error detection
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250806-net_rswitch-v1-1-5fb64805803d@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250806-net_rswitch-v1-1-5fb64805803d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: pyq69hc1cejx5qc4y7o5s5dsdoek9zju
X-MBO-RS-ID: d44620360bc3d85a661
X-Rspamd-Queue-Id: 4bxtDG6Rj6z9tFV
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

On 8/6/25 12:19 PM, Andrew Goodbody wrote:
> In rswitch_probe the error detection after the call to devm_clk_get is
> very wrong. It checks the value of ret which is uninitialised at that
> point. Instead it should be using the macros for including errors into
> pointers.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
