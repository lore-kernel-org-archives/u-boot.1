Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11145C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 06:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6826B832F0;
	Thu, 17 Jul 2025 08:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1752732088;
	bh=FmNpPmZQxlz3dNTmGt5oIqdftFczox14YWMpoLGTftk=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=qslOySGFJtsUUZKWyKUqXJGdGkFghvdfRUMUK1U/49FaTwDxa7XSQ0D91ZxKrWSIW
	 xNKReXmaLgcjZCo/C7vk+fH1kJ/16U7Uwe8xuAmWo+WfFloOhpNRSBu46RTHLUZt1E
	 zwATGKEy9ge/PU01F6VBlXOXvELENltWzHtZy3+Nc4fMNDXAz1GIRrZIYnVYZKpsEF
	 ZqXskjKbKWWM6pnCx73SQzg5JLPtb6XXJikU46rgNUqTyJYS5Z7JY1+sFdGoOVimNd
	 yvV1GL01D9Fh7jCsHOkkH//C2OwzhN7jSF4Ap9skZvrK5QRCNWjG+DeGVvu9NMnkXH
	 tPhvbftEHPrrw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4618A82B0F; Thu, 17 Jul 2025 08:01:27 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31BE482B0F
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 08:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="DOjjMVXV"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 39F2110272379; 
 Thu, 17 Jul 2025 08:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1752732084;
 h=from:reply-to:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=FmNpPmZQxlz3dNTmGt5oIqdftFczox14YWMpoLGTftk=;
 b=DOjjMVXVoIPf5dFZQ70SAkrr1gXxCBRQhtnGMw9aNfzJ70Y3O/X25XUbVKYqTiXIxEGSJp
 DhUfuX+eJ1Bfy7xxLNR+2G6ZqeNTS3qq64+2FfNZEbxK8wLJ5I2tssVZsh0E5CcDAwJjnd
 LOIqNo+kv/lMucRpmJ27VE6Lq8AhRP//z1tjFvMkLxt777T4+NHRkCNtNQO1TUN3McgI2g
 PFBzMyIR9scLCA0CQ6tcVoXHnqhnWrlCxq21+spX4QfwB5/MuON8/sD48DajUdzmluXhv3
 08kZDWY+vpMsFbuWALElESGlzLaHSVocGtg+vrF2cmR22lEYhtvQgj2YIXIBWQ==
Message-ID: <8e2da406-c015-f3d0-4445-aabd19dbcacf@denx.de>
Date: Thu, 17 Jul 2025 08:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: Kconfig: Tighten some i2c driver dependencies
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250702010359.18747-1-trini@konsulko.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250702010359.18747-1-trini@konsulko.com>
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

Hello Tom,

On 02.07.25 03:03, Tom Rini wrote:
> A few i2c drivers cannot build without access to some platform specific
> header files. Express those requirements in Kconfig as well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heiko Schocher <hs@denx.de>
> ---
>   drivers/i2c/Kconfig | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)

applied to u-boot-i2c.git master, thanks!

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
