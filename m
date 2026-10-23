Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B001606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z8JIE30O;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZeAw7gH0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2706D811E5;
	Fri, 23 Oct 2026 10:59:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vaeM1pL_b4sf; Fri, 23 Oct 2026 10:59:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 759C1811C1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792753191;
	b=Zj4ggYiqnABC+riZUMVAsJ5pGkygb+xOpi3v3uKszjw4T5X4dm3FsJo5GURYj6VwlA/S
	 sQge718nstvn/J0jEzGIrA1rtURPKsl9asteFfdiirKERgwc1HztthHD60NqG4QOj+thN
	 b8WJtLpdushFTtr7ezS0lq5cyAPgaQy26td8tNSqiHu4PrZBNJct62WydsRJum0D6CFIN
	 4WL4JmxnMP4H/tZcMTQdodsK8UOfTAJLR8xv5yZgVW0H8cdtcW7VSoq3hPKhWHAFd7Ode
	 0n/lRB6TTctSIgOiHJcIOrEveWAUMpo261X7XNYfbwrpwvrQg0OxhqdKbtyo6VhdCig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792753191;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zmytaQUQTKXmhJFAKGnZZnI3UofD9AhN9DQrJ1g5iTc=;
	b=LRPE3qImjvSYALSoFG+124E+yYNBlOq2N83+wiCjgYDq8Je9ulCNv80N4RXSHXg4L5an
	 hhwvLkok5W8Q1dcp+mzpG8v/Ci+jB3vSdZsJdhePfxLcsuwWobqioiKRTuzyMy4moB7Jc
	 AtI36UDgvUyH8jfOJuPSTx8yxjej951x89+Y59LXuvpXZPmdE5np7lgwabaRtGWyzymlD
	 3tzEkRyXIFSBQ5pOuUb26Hn5UgBCqhyeUrj9BTohr3wwvCsJzxu9KJSHNZXnV+60HKEjc
	 LHBdjzEqFKauK1n15pIK8b0evBI2ZmI0YGvRgvj+YU/VG2l10ov8ry8qPP7x8ZQzcfQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792753191;
	bh=zmytaQUQTKXmhJFAKGnZZnI3UofD9AhN9DQrJ1g5iTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z8JIE30OnOV5Iv/UGGDfSOCnP2NoyhJpDlHe5050gJBf2B9EN/T4IHhlE+XV9FRhT
	 Gbq6WfictGzvIwEdfvUnTe8BX2tjVRMycTn80ffcuFt+QUf4GmAnqG2GN4kFXUPtDp
	 4VLH47AteOwZNzqH3TH2fAsJdeMESgKkzY+/7iRgthssBD4xO/TODipFQ9N3qN1zAx
	 CuQxZZUAcWv3e6rIUTAYBW0HoCl8ESjMPugoXYzkvVKIPC50pBfUCoWYmpgZcsnrLD
	 Rz4VvX0fOi7uZxuFN+T3EJvYxVyQWXwI2sJ0kyvVJhlHb+0y2rMNJpeptbGinirGmP
	 0BIngQqqP+ipw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 759C1811C1;
	Fri, 23 Oct 2026 10:59:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 63E30235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 48EE440660
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:59:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_A38hByEYn3 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 10:59:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B7C894064E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792753188;
 b=U7Ss05FqbLbQGPUOqKnjtOk1eKITcZV9cD/zALIZbq2XeF8IZuJ8ifv/u397en6oPQSg
 QwNjZaWc50NWnqQjjeNO1WHgaYTPhld6MKY2t5ssiXohqd2O9jU19FLY2TtE5CI4jasK0
 P/JOCz1fnUjhWL/RIQziihFZVcSy2tA9391nbKxWR0aXIdkqmPpHrqEFDCERCv0g8eCix
 7F2Jv65/wkLRi27I71YohkEatOccLX6Hz0dFWVJhR+qd46C6IpbH3GZN2V6C/j37M7HP/
 yVZXKP7UTk6ZktCgeZn/di3NT5AY54wCnR1/ynAXi0iQoqN1e+rlE21XjwdLXj5MJ0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792753188;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=zmytaQUQTKXmhJFAKGnZZnI3UofD9AhN9DQrJ1g5iTc=;
 b=etfgXTH46fc43MC8UMYdqCWIIH07TyD8xALX5/69LQW+uvzImV/tiJeXnUaeIpb4s4Fc
 P9sh1nYwcrfE+O2PWy7g8aH3MkOZDYLznGF2+k7a9AgclWL+fYebD88xjtrUNsVOo3sel
 zTyp2VHCO+YRyF9xkryB1lMnNzZZS4gaido1FJwufm3kNz9wneGco8ne05sPuTDzCzRX+
 fAq2VvFHV4IASC64ZNzHC237h9/qJg1Ae4BjlpoeYPArgS7aAAstYsDNOFx9qCfa63Hjq
 ttO9nMoCCCQmhUNeERUM9kr9eKq31zaD+lnqtopbkuvWGaxRjIFsWc7S/mqWbcTXmpQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZeAw7gH0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZeAw7gH0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7C894064E
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:59:48 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8a06b27bf9bso437688b3a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792753188; x=1793357988;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zmytaQUQTKXmhJFAKGnZZnI3UofD9AhN9DQrJ1g5iTc=;
 b=ZeAw7gH0Rpta8eOv6yS33idxzdzww9Fs+e81MBmHykCVK5xZoueLvYvkDWz4+GvZRb
 C7bJ+XF8SBhu+86zz0lFMGg4DQHd9+wLct6BoMS5j5ALtTsl+pec+g89aUBb2rJNnMUy
 exblPwQe0Gf0ehyPHkuFN+suN5/vOiFxme4y9BXVIB5swyTggjy4f3k3O/TaEK6CHqhG
 y/f51edD8LVmWndb2HYlgyRrQvXzax22hrnowJWaa0dxbtygyfQF0aPkeQrrgNOU0TRJ
 yfThALMnEwwdKum87ofvsaTwfCpC/1IKvUEhEPnA32cHLo1c5q4+zbsQ6h5nihSAPYcL
 H7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792753188; x=1793357988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zmytaQUQTKXmhJFAKGnZZnI3UofD9AhN9DQrJ1g5iTc=;
 b=pA6ZFEUBIW6cidSDw/H+87+IrXJFMkYkEdTk5UdNhtYAG1iyK8RpX3ri0NazO7xiZv
 k7bRxvw1xNHTwsnaM+lEKYGVb6zs0nuR+/8RO7srMnftkBUMqorS8CICFcFzboqrScZP
 WgWcHq1JuQlB+F3hWxDbb7KW9/ow0NVb2IakBQl8JKKyDPsRqryCqXeqH296ODHvW3eu
 z82UMT6Umtp4x7IEc7mQnPVvV7pPp5J6Yj6i5d7k89nbrsxhXYFeAvTFvq6VlrlrbsQq
 FAFAMU1uPIuM9cDgi6LvHvGzOHMwGRnCCXfR8LUQgRRrK175fGU/WB6XijdU3Fw5bXZP
 NbTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfuO2iK5L7CgllbWfINln8N5m8/yVIRB55ckbmcOjqXJI35/zZXG+fjE6nO2kMoBH7wUek4jw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKa4wQMfabIbDd4ZS1yYKv0EbWp7rV+5yC7RNb05iSSL8T4cUzt
 k01oOAum3wXc58PgiBGUVTSpdktE/fPIXf+3NCc9BGAo7ifcypvVXfaA
X-Gm-Gg: AYBFou3af7VynDdQgmanQo92Izbf4uzQQWRgzpNaod6WXt3VZL5dZ2aBbR+252VvUpL
 R/A+i0DsxIWaeS75BSjCJmzD4hKlDCMgTNyedEEjpdmxJJm9NVZLQ1Z8f/HFHQewyypteGyst7u
 34p7M3n3aSlLQrn5PkNOq8gBo3MMLs9Y+Gdlgz3Zn84YFPqUpQq7DoABOmhNMOe4mqG/dnUzUxi
 H8SB+JrstCpoDTxqOh+uwylmOReJW8jJhDdlirhwmbe7kTB4PNSQVxRo/MsjXqZAy4q7iqi1Dy0
 nM9fRDJEC0jIJakL2IM5OWaISUwknLSsNG2C0krbmieP/q+HfU1/K70C21TPjvIbi1MPGGguodu
 zB1GUa6sIkpBJHUyuEYT0L6XVAC/ILRiyj3QkSOXXNR+xPCm46spQOGT2nub+fbt+i+rE7guoxk
 udiFZeHLQE2XtqLMMU8zydMFzZ6zpg2myEYYpO/vJpaZKntOs5VAnI9JXRLtYdgW6ws1DSZjwOI
 GBo3POxqC99zpS53pZybceWVeioinMvFgZ9QE/Jcr6EfrVegw0KJKRLrycHRxazYngVdgTWhLyD
 AyVr2oWwb3O3L7FTJa9gTTD24VssxhUQPMfzw1hbrh1pNZYojL3dMw6DXfv7zIO5lOq5FHrZOF7
 nsl74ohuaflzdMkLUDHQ1Hegn8qq6k9Zz8Vk=
X-Received: by 2002:a05:6a00:218f:b0:88d:3f61:20e9 with SMTP id
 d2e1a72fcca58-8a2c665d043mr1571783b3a.48.1792753187528; 
 Fri, 23 Oct 2026 03:59:47 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a2c8df56b4sm614727b3a.33.2026.10.23.03.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 03:59:47 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: Yixun Lan <dlan@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Eric Chung <eric.chung@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH v3 0/3] usb: add K1 USB2 PHY and generic DWC3 support
Date: Fri, 23 Oct 2026 18:59:42 +0800
Message-ID: <20261023105942.3896164-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792007916.git.DaveWK225@protonmail.com>
References: <cover.1792007916.git.DaveWK225@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave,

I tested v3 on a Milk-V Jupiter, on top of main 903c9578e plus a local
patch that adds the Jupiter DT to the FIT.

USB 3 works without your combo PHY series. A SanDisk stick shows up at
5 Gb/s, and fatls and a 32 MiB usb read work.

But it only works after I power the onboard hub by hand. The Jupiter
ports sit behind a VIA VL817 hub (usb2109,2817 and usb2109,817). Its
vdd-supply (GPIO123) is not always-on and its reset is GPIO124. U-Boot
has no onboard hub support for the VL817, so "usb start" finds only the
root hub. After "gpio set GPIO123; gpio set GPIO124; usb reset" the hub
and the stick show up. The BPI-F3 DT has the same hub, so it probably
needs this too.

I don't think this should block the series. I can send a follow-up that
adds the VL817 to usb_onboard_hub.c and enables USB_ONBOARD_HUB for K1.

Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # Milk-V Jupiter

Thanks,
Hung-Chun
