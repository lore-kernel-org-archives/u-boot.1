Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD16C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 18:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2827D87053;
	Tue, 19 Dec 2023 19:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nKQ+NpBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FAFE871B4; Tue, 19 Dec 2023 19:13:49 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BE3586F42
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 19:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregkh@linuxfoundation.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9F49D6145E;
 Tue, 19 Dec 2023 18:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB674C433C7;
 Tue, 19 Dec 2023 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1703009625;
 bh=rl0oGJRj24LNgiZU8UrAeIcpL4ZoLYNFcJBbQXFfYsk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nKQ+NpBhVhYf1S9GOtzOlJIgbXu1I0CRJH20nDeKl9+UdJsWedrb/cVqlF5Ld4onb
 YRJJoUgJR4kpS2qVJ4J/4oKQeK/yqmdzEtbpIdtWoo1Kbj7KUmWwapz3wZ5O5isUOz
 Ra49I0QD4ox7bS8G0zBg4I6buHPUKP3t46zHVYA4=
Date: Tue, 19 Dec 2023 19:13:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 u-boot@lists.denx.de, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 3/5] nvmem: u-boot-env: use more nvmem subsystem helpers
Message-ID: <2023121929-salami-pessimist-c943@gregkh>
References: <20231219174025.15228-1-zajec5@gmail.com>
 <20231219174025.15228-3-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231219174025.15228-3-zajec5@gmail.com>
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

On Tue, Dec 19, 2023 at 06:40:23PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Use nvmem_dev_size() and nvmem_device_read() to make this driver less
>    mtd dependent
> 2. Use nvmem_add_one_cell() to simplify adding NVMEM cells

Shouldn't this be 2 different patches?

thanks,

greg k-h
