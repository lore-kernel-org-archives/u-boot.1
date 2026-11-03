Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B3606A327
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JHwVqmnk;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Vize+PxN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EC0B6084E;
	Tue,  3 Nov 2026 13:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HvKd832pGjyR; Tue,  3 Nov 2026 13:05:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D81C160816
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711132;
	b=nAu1jRUMBmaHdEV2TzrqCaHtxGIjWXvvWyyWROLZYDvx5CH/mrhx1gG4hHhoJ7CVPMql
	 H6OIxA46KxW9FqnfOsfCd9Jb2y1ffR+Lgpd8aOoGBWSG5a+ByZmhx6WYap5oOqdjDfa0P
	 wL8Xn0N7pMxp/JZ9wZPW5EpSgAzWwY6Te4s5T76X7HA/CVCenib6w54VtAhvR+5klDEqB
	 aJhU5X5unO+tKMjCDs6HZvx7uKAP7P9jc7tynJ7eMfF79i3RTaaBrh+lR1ikS7HMPjDZe
	 TAUYPP0EVRf5Hr25qFBbPcubzXzGUsJCflWPWSnHoUqhqXq8SmifVpW40WRjrz4zLNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711132;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LTnh9HC40oNoPttvrMasY3ri/3kN9t2ys9eV7BJIWvg=;
	b=s/QjJbcba87FwulvC5UEWhA2o09tqu2TVaBjAwpI+NbDhfiL6Ai/PvIYN8HTeVqoudB6
	 6AOBmMTmiotI2MvEO40YsQr9sK3bbDNx9mbk1U39NAgfK9Uu0ncd8LW+BcoyrtmOymajD
	 SnzrTILoF+BebCHqJVj7MnFdZ6g3PsuKRmnLFCq1uU4VFMLgvpio7UVfY9xFEpYBSHN+p
	 mUfe8CNIoyL6ofOgbxIOoYBEJ0NJRO6IGdK8cdf48VN0qNMu1BJ9JUS9YvdeSsXnTIeny
	 MvjadWhFzPKsmN/GGeoyyT4Gvf35/H9/daY9qDGZen5ulZElistar56x9BLC6v/hKKA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711132;
	bh=LTnh9HC40oNoPttvrMasY3ri/3kN9t2ys9eV7BJIWvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JHwVqmnksQ26zmYz8FB3GWSOFq5VDkok+WR20/ACsRL8rt0lHYulcQrRn4P6eod2z
	 XpqKTOfXe6yMt1o9j4xqIFTd30TwTqrxRDRKBg7orYrq1uu/OeKWlxkgecKkQ7gtqH
	 nBcCylu7nknT1+pGw5wNn1QptQJF2M4ywGLkgVd0u72EurZMD8BcBNgfUcWI5GXh+N
	 mtvK9L01eIL8JPCYyKqcQsmHB2IrxIgDZE7HIWB3/Ot4oGEZrPeuW5nvVLhoRePIIx
	 0CdxXyeHmqz3+/0lIuWJ5lsSTYanZ1Qb61cZz0MuBJ55Hdtvj4x23RbUAEN4wZUOhq
	 Q6Bm1TDwanDNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D81C160816;
	Tue,  3 Nov 2026 13:05:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2F0111CA
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 990D240080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ANaDBk83blh for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BC9FD4005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699938;
 b=AzBZ0Q3LcD8PmcXszvCneWG09TF3SnLsFMC5kgZa+tBvZDX6aKXHTrXw/8tUpmG7vk18
 bb+RPpH/Yo2dnUVTCLfod5BNn+Cbj5k0banpe4yUQgLQJ+O0JKgWPpt1T5GIG4tNgUNRf
 gmwNTJg2cwVa8WWjge/85TwB7OeatzO7ciNicEMddrI6nX/b74CmOSK2W8Lks+VGXD2E8
 9z+pyN/eVmoM5f66yMJgR1pFf/zCFOgnT0KjxrUQ58eito7RHiKy6Lo3xM+5Axz568NnW
 wlV8uL8ae4QRQOZJ3z+KceZ5TYjUK6s6Q1vRQuS5FHBdjGa3mVYFW7NB7r84WTxqkuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699938;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=LTnh9HC40oNoPttvrMasY3ri/3kN9t2ys9eV7BJIWvg=;
 b=pC5NIYNapZFCy3W60ZzXe/7T/ZdWhsgUpE+Pj9uRc0LGEWouwh8qDasQnncWrqKw4Zfr
 ROw1aDvmqVoSHEGiMrIL4yJk1Z84xiCWPqEdVSjhFmdRdCD//Dod6eTn7vg6kYFgv0rJt
 oyuKoKnBCkBhPlfbPGTNuZQtA6tL3z7/7YK6i71QcBEqv4LTSIAQWT69QLsfm/5IYStET
 E7AvEBjbukApS139/MmxquhjZauCKpK9jW0LncaUk5CJdfNhgNZsE/HVXE/xWojZsS1wW
 Elui88Ia6igsJr7tLWmspneEfCe2VGcyCML5EbkEob/hFxnzlwMuQNxU5hpynZDJ4pw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Vize+PxN; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Vize+PxN
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC9FD4005E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:57 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so3172378f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699935; x=1794304735;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LTnh9HC40oNoPttvrMasY3ri/3kN9t2ys9eV7BJIWvg=;
 b=Vize+PxNoLQMCCBmRuyZvhtw05Lg4O1qoeFbtCXzRdQuojA4RkSG2n5TTQE9wKA5mL
 g3kjUAMHF7AGErW+yc/yqBbpm9GZRrweXk2iia4EQX5T4z4/54o0xgGrLNeEPiCQvc4G
 LHswM7pXz4qhyczIgMOCF5iND0pH4QLkjfEIRpfcPpLRyPxif0nVIt5Ki6xYzFgezY9M
 RUceoG5dRicjgZxlTjto8JC2jHt4OC8C1aQI1mzem3GusmWHrSfCtGgdAx4SgqRsEpEY
 gwxVmhxrE0hTRw265InElrVYK7VtO9wEM9+5+ypwq0b31gDBo22iiF9L8hXgRufVHK7A
 db6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699935; x=1794304735;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LTnh9HC40oNoPttvrMasY3ri/3kN9t2ys9eV7BJIWvg=;
 b=uBR0jpnT+tMnk48ZjbizHFU8O2bhEL4ADKUA2zCu/yUw1Ci4ZVpc7cf3aEElkJF3uV
 hB8JFXnS31znMhJRi7NmwcQuuUGvNBNqFir5U0kJq/RxHOXfi0gx6N5NL5zCAE3mIo/5
 lCKG4mhqGCKLWLQktEDRI36HjbWcHNL7axG2oViHfADoFaIyxzR1QSnxjLnRgH1S/Vro
 UXs+opBX+6hhOVSTDrewfKIqYLlYzF5OPvYVdIz56yW1yy2UaYlSOVN0BzvjcSekF3KA
 eTYkCdiKK5C7IQi+eOO//NdujHHUcFhWYuz+mQe4V10HP+Whona0fsxLE0lemmyfjsaG
 ENrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzs7g9QPFeLEmgOQuADiXUl5R5NuJapsgl3vQVgl0gx28rih8q2vbS2SJv1SP8rVeqG0iQdyEU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+59o6XMI1qMHNIycW7J2dGOmXsB7MAGfYtw1sqHsZU/7SJ60Mx
 CYe598KWtGz7n7BwaaY0YaHD5MD30Q6gVADTdEMLGaXnYVej2JwoTSN0ia45A6/tjqs=
X-Gm-Gg: AYBFou3xS4ENpsbFifUDWzsWRpAdXB6hJNl4SSUWZu8kNESijtKDH0IuFUcY5NyFzm/
 kC4727kvYYBzSmo30ZVWT7s1NjhfTU+kO/rkwTUEC8BeUFl/EBJFarh3I2dMANSef+aWRYJ2X1f
 zRieLPS6VMZVeKA+oyRT11KT3uBQWkYSs4uwq819QEtYwfqLMVvbBF5DI5g7/wt0qN8jBhJMHUz
 1NBQWmK/v6iAtS7GwYr18DV6M+O2G9bVRRO4mF0i/zw8g2jyobP8UzbBKruyNxqvXYN/VkYWDCe
 hcrsBwmdD/ZzmZnW4aqexeTxRqTyOYli8PgBBVLhhf7sZy4dGVCMmUAzcU4VlGSXUbcRnB3Xoyd
 cIK9+e9pduRqgx6eIuKfls11EQHSrY6adsauzctTUbKhGbof9z7VNbVqcjqw4/slMIu8fQ5jR1c
 zKs351oRMtaZ5IryM7s75EjxxKtYFeTcQUh9+dkLutbtvGPVOJMIJlHcZ5KclNHNdPronBLISOE
 jvU3pgEyaMMYmcfhsXA7bC1Mdj2yt48vLERGMd6oDrQEtNtylfDt7USCYFIKIWslGp+Us43TkM8
 Rfh3fj8wY+ZUGSbp38Ql1EfUQg==
X-Received: by 2002:a05:6000:26c8:b0:48d:f014:63ee with SMTP id
 ffacd0b85a97d-48e6e3040a3mr27270321f8f.20.1793699935207; 
 Tue, 03 Nov 2026 01:58:55 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm25832731f8f.55.2026.11.03.01.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:54 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:56:04 +0100
Subject: [PATCH v10 18/24] arm: mach-k3: am62p5_init: Resume on LPM exit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-18-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=msp@baylibre.com;
 h=from:subject:message-id; bh=/uLEgZDd5FaGOrUY+nRZya1oMuLIiULLGbfbqaLSBw4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXG+T2Ht+n/cxg8379276dPo0Gjk5nn+yKmx2+p9lmZ
 d6CjpnHO0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiaYsY/krw/dK5tuB043qL
 5DsVc4QPxs64GqDh8uj37ut3txVGOUgwMjy51lTXkq+wRfPMtKW6E8zmP9y7kGuq5Zer9WLfdQw
 NCjgA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

Swap order of setup_qos() and spl_enable_cache(). setup_qos() is
required for LPM resume but spl_enable_cache() is not required. There is
no dependency between the two.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 2b7fc5f3315f..59a01cc1a244 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -216,9 +216,19 @@ void board_init_f(ulong dummy)
 		enable_mcu_esm_reset();
 	}
 
+	setup_qos();
+
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
+
 	spl_enable_cache();
 
-	setup_qos();
 	k3_fix_rproc_clock("/a53@0");
 }
 

-- 
2.55.0

