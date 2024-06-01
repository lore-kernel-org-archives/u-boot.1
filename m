Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B42C25B76
	for <u-boot@archiver.kernel.org>; Sat,  1 Jun 2024 19:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE4E68811A;
	Sat,  1 Jun 2024 21:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="r+q+K1il";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AYrrR92T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11CE58815E; Sat,  1 Jun 2024 21:51:27 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15813880F1
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 21:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Vs9bc5Hznz9sd1;
 Sat,  1 Jun 2024 21:51:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717271484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lApvQRwu6zF/dBpL7QiawXOHB8oX9zeQGspzrAAUQfU=;
 b=r+q+K1ileRrdEtsplY2MLcwdxvpetihLcBCLTyKB1+929D1AbU9at0Mf6TmbFpko8ivE5a
 lmKKGFeChYnvKth97U+G1pjUu4HcBHcg5u81s55LVhZZdF6G49m043kWt3VxTvEoYmnImR
 +XJdJDWIfj+jCg8IFvxBXcJRgDfbEVJQntl4VQTkPNxcXpfT7FSNAkhBiVYQDrBxjO10Uq
 j4FT+o/mg/fXb5rKXanusi6nWK2E2H5cbSNlknJk1xbmvWXo0pKRlsQVLF7fewIGcS5Rwh
 b/D/KopWZYxwRY9fPfwJavGfkF0qnVXPKV9CwSrlGM+RWXb+Syx/npkZ33zUvw==
Message-ID: <a807ad0a-e2ff-4236-81f7-f0fc8afe48ff@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717271482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lApvQRwu6zF/dBpL7QiawXOHB8oX9zeQGspzrAAUQfU=;
 b=AYrrR92TcvOWSsLARYVfvuxWpyHJoce84cqW/9xCmFjWqOFMMWWKngDdut9l4/X3tQdpOC
 VlS7c7juFDwJerGlVA+1ho5KR7SH5lLMk8zOmFDeh37f6xQ3dlefgdTwmVcW32Pm35xdQV
 7CMj4GwieGvuFgzAXf0MkmlOwA6WtEeh0x03RrIm1AgEdFVZYui3Ahqrl9+um3gS7CUB3i
 VsosclmKie80czIzgj/ydviGKNC7C8GUYqjwzWJ6PiiSHrUpnnVPdorj/0Sz0lwMaFOjD9
 TwPwAl0e42ULmqg5vcsOv/dnlD5LuRKu4YBZvSBa2GQuUaBeZa1cvxKOaEDtpw==
Date: Sat, 1 Jun 2024 21:39:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] renesas: beacon-rzg2m: Add Marek to MAINTAINER file
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>
References: <20240601145521.200132-1-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240601145521.200132-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: x7i4ec5zch9qamkb9sz5i7tc9h3myo4k
X-MBO-RS-ID: c9cebe2d6dddeca6dfe
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

On 6/1/24 4:55 PM, Adam Ford wrote:
> Since any changes to the RZ/G2 family go through Marek's tree,
> update the MAINTAINER file to automatically show his name
> when running get_maintainer.pl.  Without this, he is not
> copied.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Thanks

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

I'll be preparing a PR in a few days too.
