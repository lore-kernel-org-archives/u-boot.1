Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688FD606A333
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PAtrUq/P;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=cBg0YMZM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAAEE406EB;
	Sat,  7 Nov 2026 15:48:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bSOLViHM6g_X; Sat,  7 Nov 2026 15:48:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 45852406A0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794066494;
	b=eRe78Snuc8KYhv8ZXktJjtggUL86PNH4wUc/r8orx81ek264q77ROWxOAMjQOdbMNC6v
	 bykkDfgGYF7QTKLU0D5XVyn5Uosf/UfXAEuiw0TSVXSIPcFOAclFiArIYINk/C0+4MHRx
	 pChyYw02mAMvzRwmwYLgKTXlzuy50dOrABeTWHsygzIKyUlyUoNVukyOrLNBHfZs5h5Ip
	 YSPxX0k/p72Ggc2PL1TRM+rCtBh9QDAYBLKSgbu1awD/2C9ma8h3XfjagHnv2zC8YF/gO
	 LFxi8FyQmP+tIL+oO2SfyFLUQ2i/gkMQiktIDRXHHOeegnys3bv1rAo5TF1aD5nXXTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794066494;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=G5I0w57B9eAmRF2ZZxkZfTzqSb/Z3wRW7D9AV2aP5MM=;
	b=E7tq1JPQdFrzrz3ykT5M/yHO/LcSZaXrGLoG1drOoNgAo3z17qcZv4vOrqHFQuRX168I
	 JUVtoMCK5uJTGsFecO4sXjGG+d7i5dVhp3Lh//Qrurdp3op/BzTYMqjH3WKFCHwcOpoNq
	 G7c+Di/XXNfHxJKvNvJVA76IZcsaWc1lI1YOC/FzI/UpGLjH7pEo7hY30u4/J7a4Gr5pA
	 4ZIaWfc3wZvA5wIhc/PgjAEqot7hWKtHac3G74dhcUnNRuh82lBlCGF/sSN3yHrVOADYE
	 cPqVvAjqQD6Y+M93d9rYkXVNqZzPYUOesbbjYEN6b34fmy9zcH+25dRfpvF3S8a/Iqg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794066494;
	bh=G5I0w57B9eAmRF2ZZxkZfTzqSb/Z3wRW7D9AV2aP5MM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PAtrUq/P1jstrIv5Wp9hhdJ5RkoHEr+ZKlyd654Gr0+iuf0Hb+b3YRQb2m5OAQy4W
	 iUHh0Ba5XUHPpQCd1xodUvU0vA2DCLKYE+nllt2ymh26vNcD+Ha+wHVCLSp+yN21MG
	 /SrrjUXTqmakMTR4pDwpF/K/Jdv53hIlh9o1EF/tDgazpcHgD8yAb+7yDdusGSnuNN
	 5Z7dE6G2CDEXS+7yUJfki0a9XYlg5Nzary/ruPRUAuowV4zBin4rzne/2ye3QRa/dK
	 3MwXuOWMGykG2Bvr6i5iLwrFP/CXlosBMt2AYk8AsPHGz3jcuzrYyW8sr9/bO9rVf4
	 U84RGXyY/jpyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45852406A0;
	Sat,  7 Nov 2026 15:48:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0816C32A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 15:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EDD8860640
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 15:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkiI8yvD5-YA for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 15:48:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E92F6060C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cBg0YMZM
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E92F6060C
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 15:48:11 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4b28d9537bcso489668b6e.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 07:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794066491; x=1794671291;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G5I0w57B9eAmRF2ZZxkZfTzqSb/Z3wRW7D9AV2aP5MM=;
 b=cBg0YMZMjxfoiT9QPtXxA7mXDloKWz8kEVlXaCb+v0cZCjEa/3odHZV88YhXwTqYAp
 jgrOIUsuLIU7KqXu1h8R5jg1Pax1ZkINWAqsxA6VeulIiFcWIqfqyq7vEdiK30cgegfm
 fIxBw/q0i735bkHjztZ4fkSdt56Mmy/G40ZqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794066491; x=1794671291;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G5I0w57B9eAmRF2ZZxkZfTzqSb/Z3wRW7D9AV2aP5MM=;
 b=uBVURqtC3yCSJVqc80hfpo1pj8BYRN9WNQlFKEnS4hhf+4o18LJHUgr+l1/MqK7ETc
 OtJ5913uVJrR7kKeb9TntC6XZFx9sB+tCd1tg6SbLN5yvmKtODaZ7ZKGyMF9mik6VbBg
 /zKiiNIkNTvIUc9zLj/yfeK7M2M2JYYAh3xFdtpA02FHFIBgJ1WbY8S/wJfzIfiyo+yi
 Gk/oEs1gnBA0CUYsx+vGBlSgukjRMBaAB8MXaq5wlGAlt0mdB/xCGMxXdOiF57gRFCjX
 wRc9L1EPe8MbIA4gwxoXoEhh3mpeTYfDwIFX67A1Hf3Y+2cKB9rGwD1iJ8S7wyupXM76
 OZAQ==
X-Gm-Message-State: APuU4Z/fBzb5crB9JGormvK38KURIzWMzNZ49ZipujmGcD3HaKAt1aM4
 A9VKbGUM/O/KMo91Ncld+LaELQXdZdCbSXMWCxclyoQu/WshigfTrYz3ZOlElSuf09SRsuU3MlD
 YvKWJDXF4rxwz
X-Gm-Gg: AYBFou2zwVfqmxI+2CCjS4RgetLisay58fSMPYd3IVH+z5klYYcpP5ClNbYSMD06zmI
 63bZWJQVH0j1B+56k5SCgr6m6utui6uXyIbVhZEKbUmSvU6ExiywafAZe08SvGtZxG1r8ieaQKa
 hwFoisEcFwglumTa/ZymFfqtRLpvFJI6rZudWIUJ3nyI8PENVlSTkuLOkPEdHcZOMK/cWh7bVec
 i0hoq36jGZTn9ngTvjBH6isjbiug5MU5aGvbNZgJzBnznMGikA1qXkwjK6+Zz+leGPEF/bqLEZo
 RclePQrqaV1X0w5LbzkAak0in4iSPhG3xMy2+ZDvz1qZCjNAvJP7umtuympsyut9eTK9J1/Ocun
 UZNSFjF4Jnu6QuJFW10719QGy6yWWPKRCDXyKGuMTSqYW5uMdbRXmt6RJxAN/ae0JEQGSxcfxu4
 KdJn5vjAlpwCDJL3XM63KiAOUrB2+0LbPh59IhsiUTPNIWM1irfdgR3ccQ8YgZOdgyq1qPX4LA7
 sgGmsmXDTJIFVjMBcJ5xErLgPuIOFhuN+N8BYsLwvHrdq/Z52flqgmozO8nbsGWypwhFkrpX8lo
 GcX9MSTSoHs425FifInjWKmeyLsSoWpHGL1rG9P1repvjM7YdA0uiRNgGSUVntpFxTC36rRaCbS
 Zqc6ZCm55ONgrmlJaR4N2hBKffUPpyOD3Z/mrhKOLEyXlsKj9ifnV3y86HhPyCHRtFXPdPkRYSZ
 OBaHM4DgK21LKhYBmvzkYsxyLWgUOjkg==
X-Received: by 2002:a05:6808:67c3:b0:4a4:64b0:bf5e with SMTP id
 5614622812f47-567fd21fd92mr1006012b6e.2.1794066490731; 
 Sat, 07 Nov 2026 07:48:10 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7f010e4sm4064106b6e.14.2026.11.07.07.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 07:48:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261107085626.2007788-1-stefan.roese@mailbox.org>
References: <20261107085626.2007788-1-stefan.roese@mailbox.org>
Subject: Re: Please pull u-boot-watchdog/main
Message-Id: <179406648957.4067238.2810889934485067541.b4-ty@konsulko.com>
Date: Sat, 07 Nov 2026 09:48:09 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 7 Nov 2026 09:56:24 +0100, Stefan Roese wrote:

> please pull the following watchdog changes for the main branch:
> 
> - watchdog: wdt-uclass: add get_timeout operation and helper (Juuso)
> - watchdog: warn if timeout not longer than servicing interval (Juuso)
> - cmd: wdt: store the device sequence number instead of a pointer (Juuso)
> - cmd: wdt: add gettimeout command (Juuso)
> - watchdog: designware_wdt: add get_timeout operation (Juuso)
> - watchdog: max6370_wdt: use a lookup table for timeout selection (Juuso)
> - watchdog: max6370_wdt: add get_timeout operation (Juuso)
> - watchdog: sandbox_wdt: add get_timeout operation (Juuso)
> - test: wdt: add tests for get_timeout support (Juuso)
> - watchdog: Add support for i6300esb (Jan)
> - watchdog: add support to call initr_watchdog multiple times (Jan)
> - board: qemu: arm/riscv: Probe watchdogs late (Jan)
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


