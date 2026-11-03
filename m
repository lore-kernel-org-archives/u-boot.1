Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62796606A32C
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UCZW3ZQp;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Us/OGk3F
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A94E81113;
	Tue,  3 Nov 2026 13:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xf_48Iah4-6k; Tue,  3 Nov 2026 13:05:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C917810E6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711104;
	b=rFZGNppJgRQzdkh7/QNJe58TmUX+Cw4WhWEG0Qw/fAeWnrCz+mO3BSPfB2WJcdRu9RJc
	 8lBN7qQ9setFxGeN6JrQVqfDrwv/1qCmLEZ3JfW636XeADm+oMVG84qQ9zygW8eNhBSSL
	 VcXQnkHsdK1Ova56XfjBaPJD2LdNTYxbruSZ/GJu5OdgMN/KOrtdLwfJ3D2fL1+1h/4SC
	 e1fxNmQBCyFMNeghyVD1LdafwmW34gTZdxga8YKMooZUZur6ZE3+cXAzx8Mj2ShzqX5Qa
	 phzvQIvLmqiqgDPdjMOvBbxIvJcUmqYdnAq1qP980Qjdf1Ks8Lp4stb63FzNL5GyHtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711104;
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
	bh=NQFd0n84tmrm+fG9EWY146RfSud1FMqr/6uk9XAlTfg=;
	b=E8HT/8pnbFSEELqwswX9JwkoiPfxI3kICAdCshoi1LdIg3ojq8cqfW47UB+Pi3dEViel
	 TvDdHnOzcwyg0opt77aQqcMBtGxMBc3xQPYGR1iEpwM96dW25OEarA1031itDKwsG5kFg
	 OHWJt8SL/Ge7tpy+xYmho2poSsHVkEE8S4teh0zzDMmN/Bk7y49jnwyg8N6HvRd/u2x3Q
	 CtjvSRBNxTCYlJ30GQ/el3E6akPw5iT2+jgRwt/L/envfqcHV8KwCH9pawkCFcQka1DGQ
	 nPPpBbKLbQrKMdCR06EyZL+laSoluy6Kis0VjMPfMugwBICDjm5vHF7ce6ip018KKTA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711104;
	bh=NQFd0n84tmrm+fG9EWY146RfSud1FMqr/6uk9XAlTfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UCZW3ZQp3Yy6C229+w0H9gHrP1ME3/DREZ5h0yRWXVBDkBSSIqEkhgHwsAYxGGHiD
	 Chb7oayDpD3Ksbh6+9RSvJhkep5PJD9qc+j3Iuz9nykkTKUXhPVGWIj97ayXkmkxPq
	 bxJdtbBViT3RDZigCMTUQQ0hLcN1HDNDC4oQircoG292//IFsejTuIxyEZZd86loHt
	 wUQtDzOv03yPN47oIrKl+KtiQ6KBGTTn4wlCCqRd8I173UR4iFExvAt8Ddw1AA6tlY
	 xIYY8TwIm57aaGdPnpe+Hzim7iNHTaOYdxxUsqQg2lAj1Z8mI47Ez0gz0O6mn3EttQ
	 5t3BngOHyGFrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C917810E6;
	Tue,  3 Nov 2026 13:05:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9619AA15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C57F606A2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ExtbYD9asfof for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F34EB60670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699913;
 b=Bw7vA+Jhv4Kh4INFhOY1deOotxQYphosWj4DC6618kdTFLHiZRsWMGLGOBLrfsW14x6R
 pwxhFXF0jO6E1gkJVmjFcoVVM9uk+uGVvKV/XFY5TiDv2ITTsCDqWBdBMCHO3TTVvv3fK
 fnZaSC8yj6I1sUYnPoZqWBh5vlO5trOk/qNrbbWf42c44mEp4kuNPefuJJpg9V8wlb08m
 1kRR8+NTt0yG82Jt1UaatIa3D/zPG5SQkCdMo3Cxlzu87T4HP2bOVWOlCql7hWptcMWQJ
 lzA4jN+o57znzRdyIkKK2tMggTGocs83j+mWsvnAGcJvqiSTvZwaHt/9ppLEgQ5g81w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699913;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=NQFd0n84tmrm+fG9EWY146RfSud1FMqr/6uk9XAlTfg=;
 b=GayvSqralbJIBV8kKCyc7ssvk8PA/2OASbYrNJE2kUVXSrZv7Lekt/VurDIsKDbxPUhk
 FeMfPDosmP7OtVqyh6N4v5kD4EUK6+bBKqbjf/4EvcjbLwo1+4ekl7rzUbxqNU55iyzC8
 akc7qxzVrmVabyHGKTdp8+waVs3R/yiM+5eTO/EQvqbv05MHBfUVNMFpn7HqDByE2fEOV
 gvYkXm9y2n3e7Rrsw+Q3fWExOTQ1iUdcGFNOYXBQw+ttBFx1506juTObIZTiXufh7li//
 CadPWvM3GHdww+0TQr/8PwI69/1PmAe487YcMQRni9yqTPlc1wFlPJVCzCDrWqmcFKw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="Us/OGk3F"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Us/OGk3F
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F34EB60670
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:31 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so35452125e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699909; x=1794304709;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NQFd0n84tmrm+fG9EWY146RfSud1FMqr/6uk9XAlTfg=;
 b=Us/OGk3F49bFDYy98JVlF3IRDgSB5O4g9G2hwmzreE2V9ZF2drXq08nXNy0kJI+t3d
 NSSxCZjZJQEVzYpYzh9N3OnnCKiwW5MRylwRYiSWBDYZ4P5IiEWwzhFWxPofjVYe3MV5
 hu0h8XPjS38YlQtrHspn5dlLPsgkjRAzxjnOEN3YVsWFOsSncW0J9ffIcv4JjqxDsRfJ
 jOcLXUKmuckHHqJPmzoz9vTivhL0bXMGr7ORe0/lQuZXJ8gQGXocFkXrvI4musDMXp3t
 OhdV7Yl3Lq9NcFf9i7zBrjZNwMxaAzbyX+GDvGvtbisFzE1XC3NTLOcGGMIN3AdOuUPI
 7Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699909; x=1794304709;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NQFd0n84tmrm+fG9EWY146RfSud1FMqr/6uk9XAlTfg=;
 b=LLCQfhmk1kSwSVu5Fxq+qH7V9oEV92QhbbSE+ij0bMONexguscykT2Ingbe7Jhg6Gm
 RJExlKO8LrHjDMiDKxTAc22Mal4xXxXDlyZc0EQBUpSxcqOiZ3M3cXW8jJOqqqjJNlTi
 o8JVZ6+B6C/PhJkbE8x/oVeSaO4sdz2MQBQuGY9YNRcaSW7Fd2ho6IitMKSg3IJVfx0+
 U9A5DAp05S/bzFmMC4mOidn3ZWBv0yS0lgaKubF/dyl2eCy09QiUpr8c5sA8qHT3rW7R
 RfdS1G4ovOuc5dYHDhQjqywwawOcvcvR57qHagUcnoBUbptB4LhAd/7xWjM1qytqXFh3
 34wg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxIjErGZDo9o25FcOanCYFmK/jqFW/m4jgA8ODGkKxSEwarwy1FqtfZEfkUkOsL/h+oJOtREA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9lPt3XSYmP+BnhLunC27B9GKbTc7NpNaEQvoTnys600qj0jPtu
 Td3WtSft+1Lmxt4Z+MdKVKUdU0fP7feK6fCTgR7pxyiyc/rEd1AhJMb94yja66AVwms=
X-Gm-Gg: AYBFou0djUjoOdFJNqKUnegIGGJ1IbK9QsZololD+uVd2DyObpO4WNz7fBR0mzf4TL0
 rmlT8xVkQY5F7W+F6bNVhdAqLARWJm6/kMeoj7pSc5wOHvw/ZOV62AZP5CXF7/J4T7Ba5mhaDn7
 6NY+ihhB3h/lbZIGhxWao/bwnCSE5eSMRs7LPv3vhCN7AjUElIuWEC4MZmE8ODWwynxcIXODp0D
 iIhIHaeeo4bBrvIL44rdfZKpNs+N/eCOpGWNWavDaUN8vDQ7or8XWkCbttmAU2ilI4OvG0T0VtO
 N9eNWS45uU+tQursb2ryhdp7//EDt9I6uKGtudvxjtPl9jV/tvrOd7KSTNVeOAwoVtA2INWz5el
 jpUIqv9KhDHhixEFqlKs5QhyGbezBRrLvpR+xswKdJay9gFBcznOdXnLI+cXtkKcZYSyyS8n2qq
 jCYIuSefKmXkJZociIWYpCf+w+/1vaHrXGBbw5G3OSFlaNjgdpdMmuyA/PeUmob35fliBh/Q0VU
 SA9hh5OmiTI9T21lB4KnHHFyIO67wUIhfnilFr9KDe/ITll0gmrdq2GNNhHWRw1Ia5aiQYvDvWy
 PJOXbdaULrE+JvM5ZMsBv3k09g==
X-Received: by 2002:a05:600c:8b5c:b0:4a1:fe55:88ef with SMTP id
 5b1f17b1804b1-4ac1889c4b9mr299187505e9.20.1793699909413; 
 Tue, 03 Nov 2026 01:58:29 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a82cf248sm69049745e9.2.2026.11.03.01.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:28 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:48 +0100
Subject: [PATCH v10 02/24] arm64: dts: ti: k3-am62d2-evm: Fix wkup R5F
 memory region size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-2-0b24ff0a4d6e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2016; i=msp@baylibre.com;
 h=from:subject:message-id; bh=SdV/XgDc9V1T+ZZt280rN8sWzpFaEfORyDvY06a2IRo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX6zcGPc3ZXsz99UnMPtVVXSf3TTaqf+9cLp4svGHKr
 hnfKnjedZSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEOpgZGT5c3Lx6Ap/7AmnR
 b5+0NW+1ie3etbKuZXfpxjU/8/r3a6oyMkwIkGJqnhSZxHBkudXOTy0WjSFx+ovFm8sFb9dPEHp
 ZyQ8A
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The wkup_r5fss0_core0_memory_region was reserved with only
0x0f00000 but the MCU SDK linker for the wkup R5F firmware on
AM62A defines the DM code/data DDR footprint differently:

    /* DDR for DM R5F code/data [ size 27 MiB + 364 KB ] */
    DDR                         : ORIGIN = 0x9CAA5000 LENGTH = 0x1B5B000

which results in an end at 0x9e600000. For this memory region which
starts at 0x9c900000 this means a length of:

    0x9e600000 - 0x9c900000 = 0x1d00000

AM62A additionally has a second DM firmware for edgeai whose highest
section end address reaches 0x9e700000, so the region should end there:

    0x9e700000 - 0x9c900000 = 0x1e00000

Link: https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd
Fixes: 1544bca2f188 ("arm64: dts: ti: Add support for AM62D2-EVM")
Reviewed-by: Bryan Brattlof <bb@ti.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Link: https://patch.msgid.link/20260918-topic-am62a-ioddr-dt-v6-19-v9-2-40972ef1f663@baylibre.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 5dd0e5b9d5f67276ff291f30da9bf5a17a46c48e ]

(cherry picked from commit bc651128a95d82a22b3641f281c8bae0856d3786)
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62d2-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts b/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts
index f5ceb6a1b5de..a8c794d07343 100644
--- a/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts
@@ -67,7 +67,7 @@
 
 		wkup_r5fss0_core0_memory_region: memory@9c900000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0xf00000>;
+			reg = <0x00 0x9c900000 0x00 0x1e00000>;
 			no-map;
 			bootph-pre-ram;
 		};

-- 
2.55.0

