Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52421C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 21:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B74A833D0;
	Tue,  8 Jul 2025 23:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k1H0qHVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C683D832BC; Tue,  8 Jul 2025 23:35:30 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B082E83390
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 23:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-611998766c0so2482299eaf.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752010527; x=1752615327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vu7DdXUj1RdnPdn+TSzmf9uFPttRbhAqpGHvK63XdVw=;
 b=k1H0qHVnXPUn/Fe9VLe++7bgfuRWQe1ksnZyQ4P/nmTcFUhD6TzDOQ9nhhyUSg9CMI
 QLxH2lMcA3M2RA6FjD5epm9LbANbnqCkpm68TukQP+VzPNJt03MsHUCaJu5780SAspAp
 8TNblGZxu0YCo5hDzPFYDNGdD0rR4Er9a6wsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752010527; x=1752615327;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vu7DdXUj1RdnPdn+TSzmf9uFPttRbhAqpGHvK63XdVw=;
 b=GJVnB1odUXYMikSocSaRAqh/IT1joxx63R2hPDdMJxaxKLLmHJ4RYseqJItv6WhYPL
 9PurIqilmcbvbJNaQJg7HWDcJEBdn6o0QXAG1rhrL+jiNq8P/orCGm6ZcPn4C7HjKxS2
 UjkGlc1obzfjz68swsuSsfRJ/GtedulkbrFf71RiFM3mUjnXh+PvTt5gArpZ0eaM0MyS
 kxxeaQtaS9CdW+4sxYMYY2zKs/qOBgGJiXE+SR2MKgyo6NXNwAagGMRcsmyqKMDWXnRa
 MaP4Xv6QKinINKsWOCzSspV0sJ+Lv0rEzKjDDjsLYJcVRqMnYBEjOdZxtQqbpRp+UQS8
 a69w==
X-Gm-Message-State: AOJu0Yx2vZ9NYQ4bnKJHLifBQpBf7Rn1Wg+O8KnkwBMDqbEgofqpWsM+
 WblVuaLBDoU6veEvbQqrClRnIF64mllI2P8wa9s/S6weUt9TN3jZdCee/VBdcEf3eSIJSQNO1Fw
 KH/VjzjI=
X-Gm-Gg: ASbGncu3SHmq4PeVDUjYa4nZsY2jpFY70LzP44nsE1qKvCWt1XqNXzYGoXvFUm+Q97u
 1KeWqhIt6ZThgq27yKw7ej9bDdnJOQnxoaMKeDfIlrkrockMRPDYiCJuwePjCpiPqxclSkx7z3a
 mcvaIzjoHPo+tqEpkCNk08s/h9SWKewFdiH/1XKw2RR1eo0zYwZRqRcYZ2BditZd2LzZ0I/1ib2
 Ka7hiVwQYY6RP/gtTx8MV9mcU1+WMgdE43TxPjijj8JFOkfXep0GwsKFYOpIWRLE8XhDTevFrLl
 vb+PAi6WOAhkH+5S3DGETRZI+0PiQ264dHqwP4gVWtjYIaNrzpX/V0/ecbaUOemiOBX+43afN1H
 HrtzHRbXQfEqPAejjG1g=
X-Google-Smtp-Source: AGHT+IGlxZycONsy/ctlXTTC8dRNKmxp/kI2JetiC8T2kT7k74LZHuNNCT/rsQzYc9HSUsF22ybdYA==
X-Received: by 2002:a05:6820:3090:b0:611:f241:b8f5 with SMTP id
 006d021491bc7-613cceb191emr7183eaf.5.1752010527460; 
 Tue, 08 Jul 2025 14:35:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ad1d5sm1680604eaf.32.2025.07.08.14.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 14:35:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250628224352.85694-1-trini@konsulko.com>
References: <20250628224352.85694-1-trini@konsulko.com>
Subject: Re: [PATCH 1/5] include/ndisc.h: Audit include list
Message-Id: <175201052669.1302793.2170243861535500760.b4-ty@konsulko.com>
Date: Tue, 08 Jul 2025 15:35:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 28 Jun 2025 16:43:48 -0600, Tom Rini wrote:

> This file should not include itself, drop that.
> 
> 

Applied to u-boot/master, thanks!

[1/5] include/ndisc.h: Audit include list
      commit: 01feea9ab07c77195de7ab1f8d896b79e00a1985
[2/5] include/part.h: Audit include list
      commit: 643607b3f8ef8d9804f55f110832e17fc1f6c72d
[3/5] include/sata.h: Audit include list
      commit: 7788df3e926186093bdd7710fea2062899cae9c1
[4/5] include/spl_gpio.h: Audit include list
      commit: a591af1123ab280d480ce92cd15871de1e222a51
[5/5] include/vsc9953.h: Audit include list
      commit: e3574b27140973868319a61aa39633fee29d3a7c
-- 
Tom


