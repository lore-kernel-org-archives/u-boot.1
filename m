Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EAACA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 08:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1D7C40642;
	Mon,  5 Oct 2026 08:01:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3HgIiSgdo5cp; Mon,  5 Oct 2026 08:01:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6E1C24062C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791187307;
	b=nPeMZ3xc3CScTSLcjrHCtx9C4V37dmh3U3AarKGzCQQq65BicCIiJcJ1gNwTDBo9lBxr
	 h3S6GFbqliRyzwGbciKh/qHHY/jvQV2tVhM5QhXDFtcrj4muhfBFozSe8NpjXFfZCHjHg
	 w6f01gLPwaYsd6cKRNYuRJ5VubQ7Hton5hED5YSefMSvjBaObPKiyEiSZUxIqPj7WgTAU
	 t3Mr84+OqpawQxyUERmPSjbOFGWj5JWq4ikCGrNEyULvicxsqMXrix5IpVGKbsxhUHW4N
	 8N/nangBJIf6gTea+WaML/U1rM62XmkVdY7WWMoJaGIv7YNxuzcXeOOXx2dUw4xELvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791187307;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kLV8t7snWiyYvEwws7JA70i3OJJHLMq79wXuUrbqc1o=;
	b=fHHTfoMlz7KioaM2x8W0p9u/1LYienmjzHvXV/D3sNxJUxiZ9NWTnAQPi4RtMrYTUxjx
	 QPoAyNZuGIlgYy7gm1JYu1Nsae6JmNvMhHk1qUs4YIIBLhr3sQkpcwoIu54IVu5M93qu5
	 hHGMruy5hMc3OAjLVKRmX4t0Him3QfjtAcqaLeUbWOdl5sIA8G4pP+HDh1Y/QtHggodmi
	 rUKEe/10J+IwDyayNJbQC90chODGNjw6R40iloPuXM/5R0SijBQO+JJAy84N9XvCHYF71
	 zdP4azlIgyQb4PCULWZYUoyIpWlAXBiC0B1MDQsfkqyF+POFGnJrhn/ZVQES+v9XOMA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791187307;
	bh=kLV8t7snWiyYvEwws7JA70i3OJJHLMq79wXuUrbqc1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hRs1ORC/u1k9Uf8411U8JL9KiJ0NySdjuXh1oM1yA0JvQsbfJT63eBav+S/0GVq86
	 kxNrmQkQPYki0mSaFjR+Fcl1Uyehj3bMwdPihpQT/VkZWOWW0jxYdhFsUDS60rhE5N
	 EJh80rt/8gJuvMjBQGOm3/Mpda5hgFnLjxI3kygLN4xePwOXHEDKgEnEz8PtMi5iYO
	 rz9ajnhjzAMMKt+WrQw7IRxwQ+RUC3kydiWx1frd6xQUpUb3Ka5y+KmNK4IEP6+d+I
	 lKMJBc5Aq8PUIn64Yay/lzxUKmPGr+fwWa71e/w60FomD9wocDgpnvyrkQV6DBoaCG
	 fHXhx85+888ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E1C24062C;
	Mon,  5 Oct 2026 08:01:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B18BD34E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97AE9605F9
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I0iD8RLCuyus for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CBC07605F3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791187102;
 b=raFVnbRIV+s8JjtMZDuN90yxu2l95uPO4WaZKLrb4TwyFFe+N/0QQ/UH5hnGaoIHwoFw
 tVvG1eY0V5y4UK7irpk4lgd1ML5PX5ctopvxb0wwePGksyIU0uPhNqdQQRQnnSeMDVS6U
 Nxd/SYenA6Y7TbZGoE08jn/j9vbtAJRfuz6GyB1uv01zCQBjCcqSvO31CWMRW3xOjhE8Q
 tTgC+EmvYbqEpAPivJmOk7JsNIxAAqQdS5THd1B+TckT5eZ7cSMCUI8bq7mkeYRaMd0By
 8M6IFmFS3i5qIvT+Pg4OUjJHTU6OhCpqAJbRM3X+NZmdkd3M6vhhijB5YAFFCWNFeHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791187102;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=kLV8t7snWiyYvEwws7JA70i3OJJHLMq79wXuUrbqc1o=;
 b=SU/ACSfQxbn2boNd5gx027g76sal0cYWMaiZTNyf2o4mqbehr9u8YWY8Trr3nh/mZ+bS
 QpPjSuWENcttapjsRGIdtDrrEf4JQXd0ETvEeJwAvt5pp+BWKFcdr0InCHkpiFRO72x27
 AO34bSl8riCXQ8ByFZwuEE4MmTBJ5fAHQAcvlBUCBDEUyHNW1HfAgdExnWx2aSDZ2IR8B
 uN8mVt+csR9ndthlyE/zumcEVPeaUPEHT1R4cD0GqQS9yUmCj47AltkAJnSzNervcJ/Eo
 mxgh0l4a0C4+1N/Nqf0WFugWICHPQ4QKbNJHOqWZHJqh14/B/ZdO7oFaEg1Zlkm7gKA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=UjfRFIOp; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=UjfRFIOp
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBC07605F3
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:21 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hysFk1qNDzKnP7;
 Mon, 05 Oct 2026 09:58:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791187098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLV8t7snWiyYvEwws7JA70i3OJJHLMq79wXuUrbqc1o=;
 b=UjfRFIOpASxByySbbsoRz8/wu+jppBC2O+yX4Oc5qIfo1N+bj24RXVHm7VWRLPIFaVRwcc
 waOzxefuyr9hzE4e3+sakHYjWISF49jP8HTMz+uJt9YOK1TPdeHxcqzwQLHL6ilXf+aV4/
 1zujzMtB7lq8thXDNoWI0LUeI2yS9NWcfw3/el9tkQimqdGqr0bna85ekWmOdAKqOdJxU8
 5PRcENvybUPyrA4D8P1VfooShPWy0ce/hVr1w+aVFk7j6F3c5mZ/EiCEwIWhqYAkZcn2d3
 BfRK9fZWwyOMuRkqqyJ5TcDBS7oIuw9NmybMMsG+zLGorZDcb2mBfnicGvqtbQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH mvebu] arm: mvebu: turris_omnia: Enable the `mmc reg`
 subcommand
Date: Mon,  5 Oct 2026 09:58:07 +0200
Message-ID: <20261005075813.601288-3-stefan.roese@mailbox.org>
In-Reply-To: <20260921075925.325869-1-kabel@kernel.org>
References: <20260921075925.325869-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: axesoqi1fmzkyk9d89zbs9bwsdru7wni
X-MBO-RS-ID: 32f56cf5513084bd834
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 21.09.26 09:59, Marek Behún wrote:
> Enable the `mmc reg` subcommand. This can be useful for determining
> eMMC health.
>
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
