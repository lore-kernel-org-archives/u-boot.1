Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67D606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vVJLADld;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ov36157n
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 788624069D;
	Sun,  8 Nov 2026 20:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d4SOvGaFLqQZ; Sun,  8 Nov 2026 20:29:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD0694068B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794169790;
	b=KLyVg4GrWO/Eej3Sm28CMJuIJtZeTandat4Zl2yNdXymG6U62rwRUj0KpXkpu0f7o1zO
	 Q654WsjAFBheFpf03PI61xp59Ouf1j1jhDLA10Wg0/TXGmwMzRs+wS7d3pF8JJPvEy+DL
	 qFZA+hBYpEezExckObNLOKJQT24sqJeqazE1v74TTD1r7j9gVuPdjxyioCtl2ADF2jN4q
	 Hiu2kdo7hGz0zq0b8x+1EregtzPtPXb7cl32GBG0BqTgQWm+6uNI9dVyJVCwekPGjD5jp
	 jxbnuFZtU1JKmT5y9j4U9sYHxkkbL/V25oI/VK1oqc+X1ohARmtIFuiSxE5ama1tdvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794169790;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=W31l1aUyfWTdUluTzs9gEPVbC4BSR44MXzAY7tvXALg=;
	b=P5yAIWFqY1TBdDzs5t4w645h5eaEDPUc+RTi7nj5y6+9C3imcUmNyafBiVeRiwreL+Zl
	 VCfki+HcWEgGqJP2ntyAJrwFmQ214SdJPeUR83pk1LieDYuAujvICE1y3nlMGd8DDRXhk
	 xst0TIsBP94GGSSx7+yPXHZ2k1Azh9zb4useE9RWuLMZNww7Qvv+drnMNcB/WiybaMSro
	 IAnP9ZtySa6/k0NDz7TkCz6z3j8RU4Z3PwGv4GxoomIA7ta5S1ts4Z+7kgmZFgT5rDSPd
	 i0rsvCc6kXx4U4Lv21NPOb2unRiwc/n5S6U17zRhck9GyklXguopyGVk0zHQIsRVbdA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794169789;
	bh=W31l1aUyfWTdUluTzs9gEPVbC4BSR44MXzAY7tvXALg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vVJLADldL7QKM1HlADHN4Au0EV0N11HjshMUHJlOLYaf06ShU8hHvN/5oNz2bJbSu
	 l8hvUmBh1Azvqj4ux1qgQEL5RIwlBluLSLA+rz/wefd9K63eg3P2O1XZld7OTYG6Mk
	 U7vGhGZkB+Pme99BrL5SsLzXhFCUAEDpUIFkmLAAvKteDzEMEQPp2E6xxgTM79sQ+c
	 nHx5dH7LY4T5+o8WTTeNkUaiDk7fi7ZUckWFSVXy2QuGJueTvIkRiKn36nl4fBPn8G
	 +GzpRALaZMkBpjalwDZvacgxhDz3n4L8xRUVLSvO42NIzNfn1qNi/9X1zEa+3qbjin
	 lFk1tBVOPsiAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD0694068B;
	Sun,  8 Nov 2026 20:29:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AE3FB31F
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 20:29:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9FFD940111
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 20:29:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yl7BdiGPR9Us for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 20:29:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 005A4400FB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Ov36157n
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 005A4400FB
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 20:29:46 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4161683E76; Sun,  8 Nov 2026 21:29:44 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2C9683108
 for <u-boot@lists.denx.de>; Sun,  8 Nov 2026 21:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so138818f8f.2
 for <u-boot@lists.denx.de>; Sun, 08 Nov 2026 12:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794169776; x=1794774576; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W31l1aUyfWTdUluTzs9gEPVbC4BSR44MXzAY7tvXALg=;
 b=Ov36157n89WcRh43bQUM2420FqvrsM9T+MzNU78YX4x1iSqR9VxRLDJIoS7XeN1MpU
 HAxkxSU9NoagME2W79kVF7L23wucdKw7as7yh3hJhWjvvJGrkPTI8Zzda7kyP5K6PVmY
 7uncXTolJ+6hwybCsCpzNs44QvpsSwsa6btQsOguBbTqvZsCyWOTjB8Ea8C0tO4pZ5GY
 x4T0leF73ahkGPK9ACpH8hIu/uRaiI6V6FZ0moxPuE7Qv3Hx7kkx7wMLM75GYECPbtar
 8J8Wq7Qmi0X48t7BfrcHVXptKsGfbxGFF0gfQpdvkwjTqK3q+saUFXo9c7ku3QVQmJ2v
 pvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794169776; x=1794774576;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W31l1aUyfWTdUluTzs9gEPVbC4BSR44MXzAY7tvXALg=;
 b=ww0WBGv9C14Q6or+YRjiQK8Y/H/UnvvATMtOhexF9IZ6D9VanhD0YJ4fsztyQFIlHb
 hgj3pscDLNxHXWno9RRiczrrnPFBsapmpgFnXeKX7RqBVtJuM3Wi8ne1dHfJDGmSiMB/
 cQL/8IGd7sTvYzfsucobz/whGGF7rwBj7+rfUPF2JI0j5XHCDkjKbfldCL9B1lfacd/F
 8Tyl07zowQQmXmPcA0RCvrkjlLxarR5KsOAsR0vigOk1OuwIcmK3csdYCp7ndGz5EP7t
 67cRc1NHws+et/3EIwLYQYcj00jzDaaZNvMbzkw8IVcfVhFXEN+VskqSd4TYKxZhnyWx
 4FtA==
X-Forwarded-Encrypted: i=1;
 AL+hErFZ2oRLoztAkqTm9fm5kWNf188fPs+/E7984ExRZK4PgPatXEkgx81AphFp0vQFiOkqhpPEhao=@lists.denx.de
X-Gm-Message-State: APuU4Z9gukqB4r6tZxZBV/Zy28+yiOACYsRF87LtyibR+0PgHfNUUPaI
 fZhz5nemjS9u54BxG6UNoTQImpW6mqXXPv5G58SDi3MDEt3n22AD0mFhHWv9JsNdj0o=
X-Gm-Gg: AYBFou0k2LBw+Im78ncEgQMBnbkzHLIQQzmlK+A3bcmYuVTmMldBItaAM54xcaOddJX
 WPKlr2DGMCEakSDNbWGFHea+QcS8Ufiecb/JvCVW+seiF5FRDF43i2RpnxmQqvBt7Ya8ggYiYGh
 fiN6maR93c8u5rUzUmkhZ8CXrrfd0wVd64LLQw5ygOIeUVn31XtZ9AYikdsow1ZaG0NKVl0KZj4
 iaHasE6HTAA8dasTOEIn4lfGHb5i+g+RSd9pwVH7IaWTxBHREHfOKTf3e4x0Z67pz4CkleFYu0b
 OtBKhBr6zRRAw1tAe3GFoQTPwknVkLTrHhis0Y9z6k2u5ZYjR1sVLG5krbUHkiZNso9ujGdtUYO
 mBLuJ0R4TCoP9QTJE/Vk9/VQt1m3Mj5BOs12xSnsfxa3fLFwvJ2fyuhH118RgNszS1BvsNyW960
 cQisd5UnKCtC+anILmEjqV1+R2UeOByW8hLgmYLtqacmmkndiBtSo4dijs4/JhxDX1oWu/I7upI
 VpXvoFVtNy+e5v11rga1/QpGyoKFeCZhDXNlnU6pK5ZhBK5qV2ZM5Klq+j+ZDMJHI3SvBPQQjia
 9P0pjmDpTh6S7d7at7+dTRxv2iD2ZeTTf3X0uDORODyhjQxvAag/Z1UB2Yk=
X-Received: by 2002:a05:600c:34d6:b0:4a1:80d8:aed5 with SMTP id
 5b1f17b1804b1-4b963c6c2d3mr41799215e9.6.1794169776034; 
 Sun, 08 Nov 2026 12:29:36 -0800 (PST)
Received: from cheetah (p549d4ba8.dip0.t-ipconnect.de. [84.157.75.168])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4959011c995sm5766404f8f.0.2026.11.08.12.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 12:29:34 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, neil.armstrong@linaro.org,
 trini@konsulko.com, Sumit Garg <sumit.garg@oss.qualcomm.com>, Dmitry
 Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH] qcom_defconfig: Enable AUTOBOOT_KEYED support
Date: Sun, 8 Nov 2026 20:28:55 +0000
Message-ID: <20261108202855.aa1d9bee0b72adc8@pwishid>
In-Reply-To: <20250508103238.230608-1-sumit.garg@kernel.org>
References: <20250508103238.230608-1-sumit.garg@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied to u-boot-snapdragon/qcom-main, thanks!

[1/1] qcom_defconfig: Enable AUTOBOOT_KEYED support
