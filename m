Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2FFC43327
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 12:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64C02841C2;
	Sat, 27 Jun 2026 14:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="CRqeiE1o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CACC841F2; Sat, 27 Jun 2026 14:18:32 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43298805D7
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 14:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BBE77118250; Sat, 27 Jun 2026 14:18:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782562709;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=SgcTFTs4BRwrzDdHu7vQ2/aPX4lgcaJ4bu05bbccXnE=;
 b=CRqeiE1oK66ts8DtlUIbyvYW82GRS9nIZKybMbFkZfzWG6FivUOJJYf7Vzd1kf6FLAY8jx
 WthVD1s86uPI7F0vOhWuwRIrjcqsKvaHx/R8nSM9YTgJGI6f4TCBghS5cFtOKsn9gN37UP
 lC+XQ2DGhU4oUk2xUyZ8wZ0Pf3g+W/yv1IwIw0qKjpmNCoOEDxZbKKr8zkITMCvCNjE4L2
 Foab2SNtbyx0zqD7X+af5VyXTcqi1A2FI9z2Fyd9svZ8lfMXPXEaCvNlYRMWXwMsEug/Uy
 hxgDMlq1gRf4x4RP6jFIG5D+8npVRkm9Jyp8gnNfj+k1nOY8DS1YCHp/QxGFJg==
Message-ID: <ddacbcce-17de-4ee3-a5d2-fdb5cb4ee777@nabladev.com>
Date: Sat, 27 Jun 2026 14:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20260626
To: Fabio Estevam <festevam@gmail.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de, alice.guo@nxp.com, ye.li@oss.nxp.com,
 peng.fan@oss.nxp.com
References: <20260627013852.3002838-1-festevam@gmail.com>
 <20260627013852.3002838-2-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260627013852.3002838-2-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/27/26 3:38 AM, Fabio Estevam wrote:

Hello all,

>        mx6: ddr: Subtract half a cycle instead of three quarters of a cycle after DQS gating calibration
I am not sure whether this one should be really in master, I would like 
to give people time to really look at it.
