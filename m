Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C57BC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 20:28:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AC4F60896;
	Wed, 22 Jul 2026 20:28:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xgy55K1Xejkb; Wed, 22 Jul 2026 20:28:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A4F460878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784752081;
	bh=rUMM1qgsLTRhsB1CtbrgHi7JFRUTNNHa2DMxxZANaiU=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YVS4UOHpLMljvPnQmGenV+Drrtcyj6RZbnzhgx6vKZDwSPTAwvDyNcEwY9sDj2KhZ
	 /jxUSZkTKn0om84yudyQMPNqSsWIzARy5kVJppZdoh7GDyUMf8sSVpSjytmcfrxRZA
	 kSIs1EF53JU3Sr1OT6R7OuXpmHylIKEcW3XM6DIwlhZWWcz7Y2L8dcHI6hyfIvdLKP
	 nNXVWMfEz4cBE5Z8sjfGPgilo8RWeglW9UC4BRe8Sn9/fgEkqKdMRAU2ax3l1J7ytg
	 e9DkQKHLyZSr9Q0o1+lvXmLEQmeHacR1PJjuO/Xr5E2NM7xkN/DyC/OvjRJb7Nljhn
	 WyAmmjget7IDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A4F460878;
	Wed, 22 Jul 2026 20:28:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A7561B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C037400B5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:28:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u0nsbWouvR-6 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 20:27:59 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2BEB4400A6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BEB4400A6
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2BEB4400A6
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:27:58 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 893BF8493F; Wed, 22 Jul 2026 22:27:56 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EEDE83E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 22:27:54 +0200 (CEST)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4a43c2a126fso4968305b6e.3
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 13:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784752073; x=1785356873;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rUMM1qgsLTRhsB1CtbrgHi7JFRUTNNHa2DMxxZANaiU=;
 b=oL+k/a3wtEV+T2BR2BzMKwhZfd2jKYYwkluGAQSff1Q8lRQ9vytbhYFFpwOC0vM++i
 kuhHpn7YbOHq7pDQ2oOye6X+FfgeBWk8J5DxjdHjvfiTBznVCvJosMlPHxeMCIlZu61/
 rRnQySiABT32ezgo4WjxBbFUtGyUIbLak/iNkgrEszqMXUrc8MLDDCLtX24A1c+NbMpm
 fpvjYfj+NilfKCd8PFnPjuvOSMslDUuzRlojDCs0FW6A/XIsr3NRVNsWwg/RbntsBRtn
 9tUY+z97cPgl4mUf4PVRbhdc1OHG6I3AlF8oKgenKxJB0peb4KF2AqEknEJGcAL46qN7
 WXlg==
X-Gm-Message-State: AOJu0Yx3lvvDdZ5So1TcDybSrY5UJ165olOBrrDIiqTNnAr6IzmqyUZT
 qM6c5pbr4QiUA9dDYACJk15Zey4JK7F0fz5G0YxoLm9MbPwC0ayYW7aZv2LdD0EEUh4=
X-Gm-Gg: AR+sD126PZ+joft12Z89ox0j9nhIRtA3nT5XK2RoB8vVkqzvz/x6xAe84GK52wAu8B/
 8v3mkDyPzk9uap/j3N1sCD8VK248W40OYNd2edstTZeb5Ye2LfcbJvXF+KHyJi896MKz+SfBWSU
 KpqCd3dXjxy92fnQ37lqalTJGJH889y6tNlqEZ7KOJn8QXdkpVeT16zt7TT2BO7kTMnXByrryuu
 NYOmCZXuZVs9+NnbBhhibwIg8qkSvQhH5Y5JMwX2sXKeksctakS9UjX4Jp7M/7gkuU4IQ33+cew
 HxyCXXvNNJohl+Er6b6kTLEwcXH0Gw6H6MlJ8F7T1U8pZrugivYUU3cBFKSYUkUWNHce68c9cwq
 4fwXhJHmUkoUBbzxzClnFhZSF/U/FFoDdO8gckz1JAdeb68ZYX71rLOgP4Hbx/Bh7ZOspb3Fx/H
 4+5dIhZQDD5kmqPfTea6zByU9UBOb7gB/xCLUoA/2hkw7ujXAGzPBW+GD48gM/Yg7qR9VmNprbG
 ECP4bgVBhNhMxKikWtBlif6vpHdYQ+26R+Uw2zvUj3CxjA=
X-Received: by 2002:a05:6808:c3ea:b0:49b:dcb8:e2ce with SMTP id
 5614622812f47-4ab3560df92mr120897b6e.39.1784752073005; 
 Wed, 22 Jul 2026 13:27:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0eeb0748sm1706633b6e.13.2026.07.22.13.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:27:52 -0700 (PDT)
To: u-boot@lists.denx.de, michal.simek@amd.com, 
 Pranav Tilak <pranav.vinaytilak@amd.com>
Cc: git@amd.com, padmarao.begari@amd.com
In-Reply-To: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
References: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
Subject: Re: [PATCH v2 0/4] i3c: dw: fix slave device setup and probe
 issues
Message-Id: <178475207147.2947168.7385694645264353900.b4-ty@konsulko.com>
Date: Wed, 22 Jul 2026 14:27:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784752073; x=1785356873; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rUMM1qgsLTRhsB1CtbrgHi7JFRUTNNHa2DMxxZANaiU=;
 b=ejek9kqGMyAz3UiPjpH4ydYCyVzN4KOm1wzJ+OljRwhLLxiywFezDeWrxd/wrQPdYM
 5aSTjPAIoMNLf8jtxN3qyhLCQ9WVjMApqesikF7+optB7fcxZ9ktelfcxqP8oCCSfLFP
 apo/iRfVpAYIFK5XGw85wu0mRS7qtIbi9mto4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ejek9kqG
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ejek9kqG";
 dkim-atps=neutral
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
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 09 Jul 2026 14:42:51 +0530, Pranav Tilak wrote:

> This series fixes several issues in the DW I3C master driver and
> related infrastructure that prevented I3C read/write operations,
> and enables I3C support for Versal Gen 2.
> 
> Changes in v2:
> - Use -ENOTSUPP instead of -EOPNOTSUPP as the reset stub in
>   include/reset.h returns -ENOTSUPP when CONFIG_DM_RESET=n
> 
> [...]

Applied to u-boot/main, thanks!

[1/4] i3c: dw: make resets optional in probe
      commit: f077a6b07be1939eb5865fb6afe60ed3c545edb0
[2/4] cmd: i3c: fix list and current needing pre-selected controller
      commit: b2062131b430e2ff3ef69dea9d8fc19e2e268c03
[3/4] configs: versal2: enable I3C support
      commit: 331d9b8cf6345f4a041dd9f13e8565a1eb471d32
[4/4] i3c: dw: fix slave device setup after DAA
      commit: 57b60ccd79790399d92d46ac1cde1086e4def7bd
-- 
Tom


