Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA21C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 05:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06B6B86EF3;
	Wed, 15 Nov 2023 06:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700025850;
	bh=7F7nIgyTnZGAsOYV5xbF539CndYNB+UGV1JGSjtswAM=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YcRn+3BwJOQd9audwRku65WVBRu2Gyqq36vVJQZ0yoQ6XBcWk6Bq6CGnPHFTSZYfC
	 laEP6XMDQVlvvbKdtpsckHKsCQrjXgNfHc5nyzbYMaVAMLMbBCg3VNRCsHptcfSd+9
	 ryie+giFSNrLox3d0rs93AFlqw0xQzA3zTfU3/jf90YGrp5FIVkis1IwsbQuCWLtWL
	 FBTP84Y67IHsSEVaCENmbXfeaiTuHrA5/iwXGM3Z2ZDvQluquusHu51+GZVkESDgHp
	 a7g8wOJxg7L9Pw39CGmLarzUyUsBAC5QJyUxo+XuoyFcZnfM6DQrC2PavHsOwGJE7Y
	 fOQoz4152+4gw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7671586538;
 Wed, 15 Nov 2023 06:24:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700025847;
 bh=7F7nIgyTnZGAsOYV5xbF539CndYNB+UGV1JGSjtswAM=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=tnCScdt1PkPYy1ZfsUHAhzMJuNW2LbP4Ri1G99+R/2QkB3T6A83FXTaUdtEY5Q/OW
 ZagAbrWY0/Aq0s0v/fTdcy0mTqI+BMILq7oT3UTpmEyPbR0VHl/oF5WzhxW8z3+Ktr
 /i1+jcFzeENc6lYyRsTu34wHMExk7qtEatkxQyYPvrKf/f8N9jfX5nuQyaSKQ8zKi+
 VEg46EGFj2qxF+0X688ZRu+vF5FVEJTJ8mmpSuShlw/5E4sCFRyww6zHj8s7cRCn8L
 Y0ubtQ7a725IicRnGB9zSm5CFty+AcOZ45c4t4Wt9Ee6estLprYKGgqOjhd4DA3FHy
 xpLtMeEW9aTAw==
Message-ID: <77937c9c-4f00-4721-adb1-5bc8b570c6eb@denx.de>
Date: Wed, 15 Nov 2023 06:24:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: usb-hub: Reset hub port before scanning
To: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, trini@konsulko.com,
 patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com
References: <20231110141311.512334-1-i@shantur.com>
 <CABEcMwUxM9hPh1c=Q8THxkJUqzw7fT-bWsdeuJoyZ8vN6BaCkQ@mail.gmail.com>
 <CABEcMwWjHxNTE5wVkgaQXRBwt2WP-uE3qgRpNrqiXFCjHD2iZA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CABEcMwWjHxNTE5wVkgaQXRBwt2WP-uE3qgRpNrqiXFCjHD2iZA@mail.gmail.com>
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

On 11/14/23 21:49, Shantur Rathore wrote:
> +Patrice +Patrick from get_maintainer script

What is the point of this growing CC list ?
