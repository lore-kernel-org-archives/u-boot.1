Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0D0C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 04:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6060C80BA8;
	Wed, 23 Apr 2025 06:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745382794;
	bh=CZz6tsEzR40OpgmqSKxkdXTDRYVYHLRvLGjatiYvT+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=sQcNrTTEsOg0kpPkprBcO0NhYZKzcW82CL0KzTI7Rt7b0HBpZLp7+MP0Q1u0dmPjg
	 9e2IjHF6zQ/zqG/waYIRdgSOAcSVZpSXj4UM4kaKhWKCM53zuX6EPXWkhzA+cFSoKp
	 DsR917lcK9eAvrUKrEY/zLpDpvCK+RACT76Y//d59xEWCQlldk0MK9+WsVEv06oHru
	 v410ri6jfGQPul+60IYPIeugktwitf8XlVnpBgNzSQ0ll+xkfcix55wFxvtLX3HUjm
	 zPwmsO8V6Zihs6qjWz3xYUzirBdMBZyfkpKk7MDBnmNM4kYF9L7utNztF4XXyRmFo1
	 JvPMiFx425/qQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3426F80194; Wed, 23 Apr 2025 06:33:13 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B3180194
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 06:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="YrTvQ+9Z"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 66ECE1039EF2C; 
 Wed, 23 Apr 2025 06:33:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745382789;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=CZz6tsEzR40OpgmqSKxkdXTDRYVYHLRvLGjatiYvT+o=;
 b=YrTvQ+9Z6C4PlW5UIgrzhw5Z7JK/GbSPomWRlKEkiOVs4rNJMWTRwznTIuC16wSCrgVFMC
 a5u/LhdR5yjRUCvXvNhPCdpOVihsPTqUQcG1AIPGEStaeE+ERMAGWMPxEhUKKkJBSvbolu
 +g7vJlIx0Dl+2yJd1f27i51B5KuUlxT9pn8GDEFXhyCOtvZesNNh9pIof9qtAla5PUzLpV
 p3qnSNhYi/nIhraBhzBFSsX3tim8QPXYFhrIuiJeETOJTSejmVgR9uzPtGX4Q/wEKqdbJ7
 fYTdno8vNvkPVIv5QbfV7MM906ebnocMlf5ItUcoRJtKBsNdvZujCyd6OhuBXQ==
Message-ID: <ed83dfe9-61c7-82fe-b2b0-9e5a9cbf85bc@denx.de>
Date: Wed, 23 Apr 2025 06:33:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/1] configs: add UNIT_TESTS to big-endian Malta boards
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Paul Burton <paul.burton@mips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250422185510.11561-1-heinrich.schuchardt@canonical.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250422185510.11561-1-heinrich.schuchardt@canonical.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Heinrich,

On 22.04.25 20:55, Heinrich Schuchardt wrote:
> We currently only run the unit tests on low-endian boards.
> We should run them on big-endian, too.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   configs/malta64_defconfig | 1 +
>   configs/malta_defconfig   | 1 +
>   2 files changed, 2 insertions(+)

Looks like a good idea to me! Good catch!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
