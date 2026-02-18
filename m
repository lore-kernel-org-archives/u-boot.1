Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34161E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 22:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6460083AC5;
	Wed, 18 Feb 2026 23:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i6FryRDn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB35D83CE3; Wed, 18 Feb 2026 23:33:56 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D8D783AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 23:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-463b3697846so878458b6e.0
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 14:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771454033; x=1772058833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODldkqO6Lff4rZN+qQOVWmJ2YWuRexTJ3eiL0aekoy0=;
 b=i6FryRDnnH1tarSxx/LHDigFVL0av0KcjL/ai6kmCfwXpOZywX9koquNujpPQum/mG
 tOCGJWkS6HjgxRD2jve/KnGXvlTOw4D80MtXo3h+mQXV2zyQIvDRtmYl0m9kADH7G1w1
 g1Dh79tcwULWRDOf5gVVMM76NFyyUGeGxfLoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771454033; x=1772058833;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ODldkqO6Lff4rZN+qQOVWmJ2YWuRexTJ3eiL0aekoy0=;
 b=fm3KE16me9K9RGtadtv2k+XXLm9+Ls13qkIN5qw3rY3vERbZtS+3fDTBAeDwuxFxoD
 L0r/QMQzf+DCbMbXLYHqY6CNbp9uUZWcELHoQZuq1/F011oGwbD4jTWOIMEgaogJeM2N
 rX3HhgXZnnOxJYB0XpDF0KyHIFcBfyS+M5qehgwxiFCu395jAhGZD/LyT+QYgVuQdVx8
 bQjgeE8qqTfVA/n4LJyzMAYtZ3iBJhyL8iLWAjPWKE+rOvqz+3KIb/y6VWKPrnBuF2+x
 hcfsxoHjR8jCYWB/H+t3f27EOPlYD7M+oaedhPyZhNyTGVyBDgLA+vt+f0hxGb6WnVJg
 iGSQ==
X-Gm-Message-State: AOJu0YxvqlIrbuKehE+x3BCJs/1JtbUCe9MQvwVujoo0YV1aFUTg671G
 n49KenEdVCZS8rs5+rQA3dS/9SOAT0f7+KW5w96Q6+PGEWIhbRLzXaultxERvvLk7S3va7O+T/n
 F6kLXtPk=
X-Gm-Gg: AZuq6aLHAemRIk2pNgIF9q6uXjaDqFkxe33haYIYQd6+pNhKHEJHgjF02y+SjiihXGF
 Yz4uG0kCHW0tjmU6KnPMEMvL66j1r84EQtGYO2Z0ABOoQXAwWJWPrl8zmx5htyh/lJQRiu88W0o
 bHPEHQIo11Yy7kkcBHs1NSDoNiB5zmBTDplbDbC+cevnONNT3H2zco+hTYxJNn9qsxvB02ox7kL
 tgkrwRW7E5x6QKyFoyCOktz1791MbYk37ue8oFdtq+kzq6o4UWvFGjHmA/egDU1O51wR3wsjIf7
 Kz6rrnhA9GJwZyhKJ+SUX8gLTCPkfSOouSe1yegI6lWWZLl2BRPdyv5/uXzN7I0C4M6q7yhIZGn
 FHAYmcAUA01a+BDMRyEED05RhWAET6kXdSZU1cKKB8UzsqzJEJ1ybEog7O4lTILsKuW43BZER5q
 2qpGXi7RbzbrgeTDCUdFn951SOA5li1hBYDUdhFHDkcRUVll7nkG4HbAHujBxS25RRVrhFSWckN
 Ph0yXFR6G4Zyjewi8repfwVpPA2o6TBKBotpCZguFHwy3QsUSmY1l6muWJR
X-Received: by 2002:a05:6808:13c9:b0:463:a42c:503a with SMTP id
 5614622812f47-46410b3ed9bmr2373968b6e.14.1771454033257; 
 Wed, 18 Feb 2026 14:33:53 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-463a20598b8sm11601438b6e.8.2026.02.18.14.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 14:33:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: d.schultz@phytec.de, Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20260203055444.202307-1-w.egorov@phytec.de>
References: <20260203055444.202307-1-w.egorov@phytec.de>
Subject: Re: [PATCH] arm: dts: k3-am64-phycore-som-ddr4: Update DDR timings
Message-Id: <177145403245.3679933.5617657489785696289.b4-ty@konsulko.com>
Date: Wed, 18 Feb 2026 16:33:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 03 Feb 2026 06:54:43 +0100, Wadim Egorov wrote:

> Update DDR timings to increase stability in higher temperature ranges.
> 
> Update DDR settings:
>   - SysConfig DDR tool v0.09.05
>   - Package: ALV
>   - Extended temperature range -40C to 105C
>   - Lower tREFI (ns) to 3900
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: dts: k3-am64-phycore-som-ddr4: Update DDR timings
      commit: 73823d1c581617a9adbecae1f4aa06c313e0a2f6
-- 
Tom


