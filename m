Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE36083624
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GIOKYOAO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQBXyL+u
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 741FD4061E;
	Tue,  3 Nov 2026 10:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7pImET4Zk27F; Tue,  3 Nov 2026 10:09:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A96514060F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700596;
	b=HKmGNhM6wZqSKqUV0Oq/ZAOZVBEMuwsn3oKhfeySvdVUuS7MV7om3cQoAnO8s3At5k4k
	 uDq+wN3bJWEsKzQV2TxsZQ2T1vi3SijdcLzGX2m1XjsKlkgAxqOyM5ug2EM4pmkb2Az9t
	 D9g/qShlIVFl0WnQMt/8tIiplLzjTqwFtwLfvmUugESeS/kbsOR8b72DpwYSOxrWG8WTn
	 CeGQULBG+NLVj3/A0IVfcQkih9Fj5Ja3NKp8aROloNmqn7VrH4iJXoODHoGU2ZWDi0HY/
	 YMK8r65vQRxhNDdhMVj+C50Dz9r7p1zCn67ueeg5h2VKCha7w+Vv9IGyOHJmGfIG6gA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700596;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7AYc6b65bOz0iBD+zgMMuZzwJcH6xXPS6mJsgVtcXss=;
	b=SNDSenMiIuKt8OezUSyAdx3ScXYkWLWWR98eHDHpkHfXHa7EV8a5wtHic6hLskGk2Ger
	 a6u4JOklKHZD0m3jpvmo5wEbeSJKkid+Fm4sJJ7iMHQiC2E41JiBJ2KFzCqBxXb/+EqlO
	 TETqcd8QICAHpZk3hTYVJZg7bNhhDy6Yft0lGSppiaJK//Jef6nW865IpF8mRNBEwqGKp
	 VETWEADCBRWayJOqaxhrHGX1T/rwn6pN73xZ6nZiqU1GSej4vRl8bMvztNO2IfqxeY8QN
	 KU1kjhJKuvSaKEoOBWJQyFWlci8nBXFVFb8whWWbHr+u2UZ3JNxI+g7EAx1Sm0SX54w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793700596;
	bh=7AYc6b65bOz0iBD+zgMMuZzwJcH6xXPS6mJsgVtcXss=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GIOKYOAODM/9H9sDHRF4goa9ihX2MiXJkohsRq0FA8lz8H5CsUsHZi5KadQRxEiIZ
	 OcDBKaBvmFH5GGV/6cHdQLGvh1juCS/uEGjIcXMo5ac95z5K/FtmvrbANHXStMgRfj
	 c9E69Cxde4Kzf43h6dM6QNVHQTsR46j52LoQMNi6+zXtRhXiLIGC3XBZ3+XtTjpMBm
	 uOY1nmWLvQAeY8c9lDDwM8TDWjGaReip6Dh+YNMU26JSMHf2OSDfJJvpFbhBhBtb6y
	 GJqpAFxmgDVypnkYFDj5OqMDWYoRU7jqXGen3VXu+1aVaj1/0d7FzerzbLh/hqaCls
	 I5ZmT2uvcle9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A96514060F;
	Tue,  3 Nov 2026 10:09:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 708D4D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E26660778
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lPTpshfazdif for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:09:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B297D606E6
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700594;
 b=NFRJwvNF6/dIEICr/3eAWhQKZn2TcqVOGekVMCb1iJYqEs/SbVp3preFbkHSZUUWoqw8
 5XkkIcnTW5mURVHIKqJCRRe5wNrR3H02GdiJVRT/4d+WksiNzIJYRwuPMKkkpubMyw3ru
 hQl92+bbO9BF8wAVCywZ9LPR9SbeqI9jzlPCNaamgd19PlUeX4UiRf/sfLmxHEzjNI+6Q
 S0Z4xhyFprHIqU+Xw/2pz/PwdNi5hR9Q5wghNcELlI9zyJVpJFktUU9GBhQQVu6XQCJwT
 R2mny/JrqLBJoCtoGkCT+gyHx1x311BoggpEm08i+0jqz6v2W4u3PXoYh5ug1ugaZag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700594;
 h=Received-SPF:Received:Received:DKIM-Signature:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=7AYc6b65bOz0iBD+zgMMuZzwJcH6xXPS6mJsgVtcXss=;
 b=saVrY7VpNx8hHEmM0OYmOyQaJPEIGT8ZKz5g5jIkU7XTls3dE+SCASXsBAG/hI8DAKLG
 Q6po4WOp009PcbTSlWOxfpjKOQh8XtLeuGfeO6Z71Loy4VsdvR76h7IgemZdH3tqcuVjQ
 CipJTv2ArBy2hVxN85G2zgRmwS0KvAWt4CUAZbPCj4cpohZPHYXe2x9liogEKK6xqJh+O
 S8v1/2gT0WokgA8LvEowmq3jNTRqOR+zBv8iRFpr8WpQlshQ2jnNeqXcJZQKaUZaa4TMY
 ZGvXiuSxww8mpu2IM60KYvRy7WJA6nPOH9ntLV0SZ4t7KRERtfSjQxxGqbJiosLJ3ow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bQBXyL+u; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bQBXyL+u
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B297D606E6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61FC8608F7;
 Tue,  3 Nov 2026 10:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92ECC1F00919;
 Tue,  3 Nov 2026 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793700593;
 bh=7AYc6b65bOz0iBD+zgMMuZzwJcH6xXPS6mJsgVtcXss=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=bQBXyL+uAdQ1ZJGZ6/nplJWMJ4kpQxMbTK4xie9RvwbA+rzVfhZ8xQtsDPTV77Nbn
 C4DNsax2RKvpO7qR+V0risdWVod1fLbns2cgziyDcZUPubuBHcr7q1GWE7PhAYzwdB
 IKqAnxBIMiS5aQHa6RmUih4/L02FZiDm8FE6ayYRq5pDZ+DwIQQNGXO3z1jbwXsXUC
 vDn3iCe5im8aNxFnHTZxqsxX7mGknWJxixzJBQ2vNzxVntqO6HeCJ2GQ/BhE1kCpfz
 W/Nj7aO3RAzR5hM4P3KMD/mUp3G9RMJmj1P4+p0Ty+nemvHB9WvEyp3oLxTVBOUfAS
 KS65NGB7l8vzA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6/6] spl: fastboot: support raw U-Boot images
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-6-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-6-d29df15fb9b8@baylibre.com>
Date: Tue, 03 Nov 2026 11:09:31 +0100
Message-Id: <179370057188.349126.17623469576360846592.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=604;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=jUWKAE2/k+zMtTQVYmNLuyV0lkO+GfP5zeLhXeMrn9Y=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq6bLia5oz2o1MP8BIvuCwa3MaJI+NCnFGS0k76
 VbU5L/ho/uJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCaumy4gAKCRAZDR20Zk4Z
 NRknB/4lj6yRSW6EgNmwIJl5dbvMSbOgRlDncKv5BznH+RGEvgXH7PPFb4s0N+APSWXW/Om13qH
 WdqwW4v2dHubfU5j3WVOxn6UT0DIqq0MfOu91FJtcbSaEKlfHtyGNc5rLUDhkLUj9TK5SsYwgT0
 2yO0xH9hTYxI1iVxmxMk+hzFK7S65w6dEB3zKskJ4GtbP1G/SqJQZZfZcyH1dQzsfzSMKBHS8wA
 w/WahkHIxzCIBTOzKsnxbjZsX/bM/x07eNocFXtQmNSyK7WUhBvE29+G6/UZUVnbMuzBPmKKgEM
 2dphy+GxDEUwaDwuj5qTxrWCcUiAs5vfMF+yh81FZbnq62eF
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 14 Oct 2026 14:24:34 +0200, Carlo Caione <ccaione@baylibre.com> wrote:
> Boards with fixed U-Boot load and entry addresses do not need an image
> container for RAM boot. Allow raw downloads when SPL_RAW_IMAGE_SUPPORT
> is enabled, using the board's existing address configuration and the
> completed download length.
> 
> Keep recognized FIT and legacy images on their respective validation
> paths, so an invalid container cannot fall back to raw execution.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
