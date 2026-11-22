Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B11606A336
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FmY4nGiV;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D2Iu5TO3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FD7A405E7;
	Sun, 22 Nov 2026 20:52:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mr62ESb1kM0M; Sun, 22 Nov 2026 20:52:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E21AB405E9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795380737;
	b=cdgKv8bD8rtEzJM0m9O9KPkt5rSieZd23WU6NIbDzKOqiLBOYNBorOVAPygyyArSj/dp
	 RjoAmu7ZZs/NRh+vwdH+Ve/t0qF78ErJ43bD+Gt3fQgYzbCYOngXwYNY6uF2WBkcWkuTV
	 PGU0mERs2ZiVrIjBG1DAPW8YNzDG4tpLlV5Q74xhHBl5jcv8fk6o5uMobNNJ52BKExYV6
	 ASDYQQNlpE40hsk9HNErXzbtgg++B4b0P7O4F4yhsoL4FRqNm9MBdk5eLKNphUkgRntdC
	 lNDP1sa5jDHO1bw1IkXqLkwmZGMFVkUIw1thknAZVLfDhDju++bsxsW+lgPPW11Hmrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795380737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Pu5L1lKt/X7s9hU6EjKBxr8X1GFycCc02arlx+E21ro=;
	b=H1Z/Oef3ymiPgtzXiyrfj/bCLpqLYNTLsNGOdk0X7NkHhAYhZi7EY7/mprtkCrT4z0MI
	 HhbGQA+rA9Pcs/26VSvz/zxYb0sQ++dfUa4PiFxUjlRf1QtzOnZMZnUgST1FhvfE/FUWJ
	 /+69KmfxC+0WVklXIYNzF2Yt8Lpg9PPVs7O+NcPzzwnNFHmv2L0bYZduHXllZOt2EEO79
	 251JYaTlGXQY5nZlKJXi6nxvyRR64VeS553SFQv+RwlZufgjj/EgOFChPj0nDLUv58giM
	 3w7v7Wi3MtviTamiA7RmJMgqfSyCKoSIE6NxWP3HzECLUDLf/OZBqJVIVHD9tuxAn0A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D2Iu5TO3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795380737;
	bh=Pu5L1lKt/X7s9hU6EjKBxr8X1GFycCc02arlx+E21ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FmY4nGiV3JBrvx2wPeP7UdWhzmNcltaHMhdTYdXVEySQ+vD8ttwFAaAMLgaKZs03s
	 vJVeKphv/DQ9BrI7Sby1TCToWnFMHwVfHhJ0VqVAGsApuDW0yql0mhRHddK8NIGRMX
	 0eck66fjQGfd0asrRtP52k4tmrMY2ggYFpVIwERMC/+JMlJIMkxEXWQWMeNFL5NonO
	 gSTNJyQdzrD4j+Q8LewzoRlyGd7PK4KbSE1GlVba6Qw6R1b/fD1IZHPlfjdmod8QII
	 3cmy2ON3xrsPDd8EM3B15oxqiLrFDT3X+ADYnfGoqZaDAjz9uCkS0iqYfXIRFWaXjU
	 2AgykvmhV989Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E21AB405E9;
	Sun, 22 Nov 2026 20:52:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AFEBC499
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 20:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 967F7405E9
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 20:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8fUDk7WsObyU for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 20:52:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C52B1405E7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=D2Iu5TO3
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C52B1405E7
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 20:52:14 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so2580813f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 12:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795380732; x=1795985532;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pu5L1lKt/X7s9hU6EjKBxr8X1GFycCc02arlx+E21ro=;
 b=D2Iu5TO3jJefzc5Qfm/vT+DOW1fr+hZnzTIevHZGFaRr/7Brik8AYseW0olNBcrT3w
 d6bzEJWhhpFh69PhJ53ji+BMW1+8m7n8DhdxkYd/O2tznD+FPtQfZewe9lwgVosVugEU
 BQ7iKHt88uTRVwtctyFl2fyto0kLYoNqk7e/ygJ3tzIjqhqde2lfPp6YM5XNrJWsOT+6
 /x3WAgQ+o0QSANT/0W7dZmBBtGtt8ffGj0eKj/Kq6UwZfYTTQ5IwMG/+CzuekUieKjm5
 5uI8wCEIoTVtUiRYEZoHrBxWSXrT1gIt2nLWNo//sn6FrPNmTxolyfDmRiOh+vDUGbOl
 vI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795380732; x=1795985532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pu5L1lKt/X7s9hU6EjKBxr8X1GFycCc02arlx+E21ro=;
 b=mrQS/49fCJz1UJWloBqSwjZ5N1waMyrm1gaF/2W4kfuNhMgzFfaqFI3ayM8CTu2AXe
 yI83oqzFJffXAlAU/dZXHnGilacNfJznXJouFu8CuwDQ05b/wUZLQMsFwCrNuITT70vt
 U7TRQ54m4ESKFTT4365rdXi+lL8TPXjmBKPcAC1BnaTlHTSQvyZGT2QgbxpMWC5kKleP
 KLsuiUUhYJ1Q1ZFGLvlYGqPWCDiJ0YuQ38JoH4YrM5x+JU7K3lypUHfw/SE/PHsrz5CU
 4UDGYeuIiv+cEJe0Zk839SXYRpJaEZ0zsYGVnKVKbE2m3DCimXf7sJIJ7KjyJmeUwlk1
 5xag==
X-Forwarded-Encrypted: i=1;
 AL+hErEL6hWjCU8vCsCOxQ+8kia825KB88yhndnn6WnoOcExUTj5yfDhMiBPMrWfBIOOqKtSUv6JsO4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/8gHHnWXe4APOsR/y5o+3WLuqV2+95bUoxmuvmYeVvMGo8CPhe
 9j+MbqmzQwWBPk7esOPFUtYKP5ryj6p2xcwjJIajyay9SgWNgJcE7p0Q
X-Gm-Gg: AZFdTZdJyB3Tv1q9AutoY0vtPRMoqVXAPHnBY+B1PkTaD2xFlvFp8MnV9y2exO8B7V3
 Nrg2OvHlDr3XytTnpoSlz+5W8AHozotmZOzVaQ9Avpl+TGQXXLRY9Nv/x7RYCkzz6BUj0aH42Qw
 afvVygPRFXeNspEqj/I5RlReSX6t5IO9hNvRej3hEocK2N00e6+uCuaaG808VEOiTgDLmxZtLyE
 SQ1YJo/AQ47lUUxPn1c9CTETmEPTPDXa9NxUiAobIUPyQmIDgs9C503/WqFSyKXxgI0GBiQWuf/
 kQ4Am3HtEnfMxpcd0ot0JWDhRtXN5R4so34GCkQP+7yf6TIAQLXYAUBsjHYITzROV460R6H5dG0
 /YBYkfqFr+4XfkIu3/JNMSrf4GMP+PdfN6jmb5/kfiywvxCSMa92airvfRqkTQfu+hFECoE6809
 zqNoyIn43PEB3GDiUNIqWE+BJivYtCAMyvFZd8+SPp3lfarONxcfPx2M4u6eiSVY468DjkB9oKu
 jDse+nXMtNxxXHc27YfGACkA5M4NkjfJ9MEb2eBjjDtJvZ+90ESHgRrXP6icDtk5wEFTV/BpTaA
 6Wcht188/zYUkScY0tMyRUcHJnGVXG726hw=
X-Received: by 2002:a5d:5d0e:0:b0:48d:f831:2681 with SMTP id
 ffacd0b85a97d-4abb7d465a9mr19263596f8f.38.1795380732535; 
 Sun, 22 Nov 2026 12:52:12 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d60sm18547573f8f.3.2026.11.22.12.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 12:52:12 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: Re: [REGRESSION] [PATCH v9 1/9] fdtdec: match an alias to its stem
 only when the number follows it
Date: Sun, 22 Nov 2026 21:52:10 +0100
Message-ID: <20261122205210.748822-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122195302.GA432275@francesco-nb>
References: <20261122195302.GA432275@francesco-nb>
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
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Francesco,

On Sun, Nov 22, 2026 at 08:53:02PM +0100, Francesco Dolcini wrote:
> ehci-mx6 takes the port number from the alias of the USB PHY node, but
> looks it up with the "usb" stem:
>
> 	ret = fdtdec_get_alias_seq(blob, dev->uclass->uc_drv->name,
> 				   phy_off, &devnump);
>
> The only aliases pointing to the PHY nodes are usbphy0/usbphy1, so this
> worked only thanks to the prefix match you removed. Now it returns
> -ENOENT and the EHCI probe fails.

Right, I missed this caller. It is the only one that looks up the alias
of another node by the uclass name. I sent your diff as a patch in reply
to your mail, built for seven i.MX6 configurations. I have no i.MX6
board to run it on; could you test it on yours?

Our CI has test rigs with a Verdin iMX8M Plus, a Verdin AM62 Solo, a
Verdin AM62 Dual, a Colibri VF50 and a Colibri VF61. If you can send us
a Colibri iMX6ULL with raw NAND and an Iris, I will add it to the CI, so
that changes like this one are tested on i.MX6ULL too.

Mehmet
