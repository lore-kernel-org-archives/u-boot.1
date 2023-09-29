Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6109E71D3D
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A7D386EE1;
	Fri, 29 Sep 2023 15:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OvWZgS40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4048386EE0; Fri, 29 Sep 2023 15:56:11 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B86D86EE1
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.125] (unknown [82.76.24.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id BF29066071B8;
 Fri, 29 Sep 2023 14:56:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1695995767;
 bh=CPKp9Gl1EOQC30G7sj/8nMXtC5jQJ2O7TbttzWR37fs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OvWZgS40bY12UGfHu29tk9UM0IoWKhGAS1qllYVOh0IeVkkowPglBecahSynfBbDv
 PvulWvZZkttSpnLqQ91kn2i6NMw/kJvXTMWT6CwMR964DYZzxqTJykXJcxEHauhqNN
 HUe4oigzlrFDDxIAMfwanX32/r6fczF70KMvobO/X8cMvH4InLDoHA1PF/YQBLYFVE
 ea2mZUgTHjbkl6zKTiMykb4z4tPq2FZ2o2IKmuHp2vYwxQvzA1qzs6aLDC8X22IYRR
 XaBrrd3yfG3Zh+3jGrTIVEnw1QczukoqnGOUuA1HZ3ySXnkQqE8d+7CDtUlDr4QtbM
 bUTCei0UjALYw==
Message-ID: <85119667-0e1f-78fd-6439-d7f41cbd2a56@collabora.com>
Date: Fri, 29 Sep 2023 16:56:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] clk: at91: Fix initializing arrays
Content-Language: en-US
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: lukma@denx.de, seanga2@gmail.com
References: <AM0P191MB0689B51E17C13F50F658C4D5DAFDA@AM0P191MB0689.EURP191.PROD.OUTLOOK.COM>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <AM0P191MB0689B51E17C13F50F658C4D5DAFDA@AM0P191MB0689.EURP191.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/24/23 12:58, Francois Berder wrote:
> Arrays are not cleared entirely because ARRAY_SIZE
> returns the number of elements in an array, not the size
> in bytes.
> This commit fixes the calls to memset by providing the
> array size in bytes instead of the number of elements
> in the array.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---

Applied to u-boot-at91/ master, thanks !

