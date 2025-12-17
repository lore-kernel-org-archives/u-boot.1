Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65F3D65C44
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 13:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 651ED83B4F;
	Wed, 17 Dec 2025 14:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vhHh7tm5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X8YC93eN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C50A483B7F; Wed, 17 Dec 2025 14:03:45 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C9E83B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 14:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dWYrv5752z9tcZ;
 Wed, 17 Dec 2025 14:03:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765976623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKIj/O3gGqxd9DzLHx42AUWdSJDjYYbdEQ9lPVhDwe4=;
 b=vhHh7tm5sIfEQ0ugFrjlw0khCa5KpZycAFPQnAiZsZS0FXt8j8C6/0wnPcWGu91198RUF7
 90JaZRdbtqw5CWrSnliC8Oz+O9cTEoTxNt147qCfxjn9yNZaYOifjcBlmqM65fyBU9AIfP
 dbDrm//OB2ZK7wAalfaiRjyGxGK6hxzmZ9fmd9jRGUKDgP9qyYBQpT/TyeUpjwFEp2Xal4
 svAkFgHonExqoxl5vE+OMfnodhuMpB+MbiPKoJVjfNoj/ETZrELSYvGN/I7qASKFpSO4Ti
 +fJBPQxZIp/bTrmqgI60casezxpNi+mhGVGdyRIA0Qf1snBr4/+tDg4MQx+p+w==
Message-ID: <f82fa5fb-ef56-4581-9e06-735e3dc062ea@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765976621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKIj/O3gGqxd9DzLHx42AUWdSJDjYYbdEQ9lPVhDwe4=;
 b=X8YC93eNKl8ACQyyxzmqxoNsri2+4T7kR0+xdPGMm9trrGZ06et5NPJQjiFD8XEzTb5m9R
 jMmhSZYIWhNj2wZfDPEiQhx5yUYOuCtrnbT7sWZCPlv6QbqNGg2opCfc1zlMjimSvwEXvm
 F8SHUmGc7FQ8DWnur9rpuJsVhvYViYrGqtO/7L+e7EoFaah3/S0ohjeAyRCbo9nQAF02wr
 YCTIBFXgysUpWxE1PiB99rvpOYVxeJYdVQxjz+TaU/WN+PVr4D6nkZbCS+lP750402bLmB
 VVg8zKOMVqIAe9Ngzc9kIZcs7hqXEgZ0iKXLCexLG/6xC3dHOYM42b8cVcpp2Q==
Date: Wed, 17 Dec 2025 14:03:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V2] imx9: scmi: clock: Correct imx_clk_scmi_enable
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sbabic@nabladev.com,
 festevam@gmail.com
Cc: marek.vasut+renesas@mailbox.org, uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
References: <20251217082059.21761-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251217082059.21761-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 67b9fb6bc222ad71309
X-MBO-RS-META: mzfe68xeuq7p7zpbddwyitw4q7q6jsaw
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

On 12/17/25 9:20 AM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX9 SCMI Supports CLK SCMI version 3.0, so need to use
> "scmi_clk_state_in_v2".
> 
> Per Spec about extended_config_val: "This field is used to set extended
> configuration of the clock device. It can be ignored if extended config
> type specified by Bits[23:16] of the attributes field is set to 0."
Please include information which spec this refers to and its version.
