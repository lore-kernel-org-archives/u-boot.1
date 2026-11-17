Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FC606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lomeEMPh;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=A7SSYVsg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C71C80FBA;
	Tue, 17 Nov 2026 09:26:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MY6vW3GwWB_l; Tue, 17 Nov 2026 09:26:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0EEEB80FA9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794907581;
	b=gbIT13ugPurSvEOJ0wnp6j/vfhZ3UnslWLBo1/jGCjN+JBp5ZMdUKlwgS1dwAFx/fl6F
	 QrApmIfK1YXFrRMDLCU0186NgS2vyyd8hLXZGU/sriXQaM0/nmcojFGEe2wT9S2VzKzVS
	 5kTq7Az9vqqTQGfSrPKaOQ22Tc7aBn5URTTDiWMadtwSskKqvMCgSi5y7kvNgWhXAGP7b
	 yvA+IFt2bWpMB7PfKAC7nt6BALlunHwWEPLo3RcCvK61lbLSYCpjO5fY+hmPqisLfYVkh
	 hS4tl/Shh03oyRQvV1/sQ6r06CJ5YhqiltNfPdiPV6jBRbIJlYJicc9pigHOI5kbwKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794907581;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+aqQtoGx6Ac8rnIWCjAdwW5CxEPWVtJS8cqI8pELnGA=;
	b=k7gku1u5jrfQ8jUz4rJyJHgoFFZGbRyse6BXCTIsgFsI/xEqRy+e7uimojDcNvoncLqo
	 HZkzinFRcAJKtZqfun9AM3bmgXUpv7CUYxzhvDblZxkHpM4YVT598DHN3Dkw8WIBoTo9H
	 hRd4OBWX/+oY27RIM/oBvyOE6RIEh+ahvTnNMj9l1R11R2UowVm47QZ6yUX2nYZNIOD9W
	 2IHQBuHU2FeZE4Z66Vda8ROysmEBkiviOwghgXIL55f6fNo7t+zAoQw2+vtjMbpV8Bopc
	 H837jCmfBKjYmeFuDqCCAO3WGxu8gZOvfxfM0QAlykEnyVhIgswqTI1/g9SmC7R5CQQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794907581;
	bh=+aqQtoGx6Ac8rnIWCjAdwW5CxEPWVtJS8cqI8pELnGA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lomeEMPhI2WubOVcgXjkPdnCgvbbwCYxbP6DoJP6w9FthMmke3Zlui7mh/1fvgVXk
	 nRV1liV/ZhPd7bzvJJJEtc9QASGXHouKLcBA0Or66JFm1rcACEa4HrWceYLUYSONAT
	 WhoQJ3NP9hZgI0khDMbskKIErAfly7mPDWMNhzi3Y7BzvIksnAfwXkze94FLRO2p0a
	 QW3UtE7KVgmvTT0o7FiDjgegqqp9/zexlgj8Uo80OtXOa9Iwm0kdVOjXJ8JIfW6Y7q
	 lZcbb8A6hBIe+lkc0ZrxRQ5kaxqC9UubzIxTlm/dAkJBl70uURizrKY8s3dEmJsFHc
	 tFYyOEZ7jRh8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EEEB80FA9;
	Tue, 17 Nov 2026 09:26:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 638F11E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 467836083A
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:26:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mnsKTrUePrf8 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:26:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 37F6E60838
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:5550::bc0c"
X-Greylist: delayed 393 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 17 Nov 2026 09:26:16 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=A7SSYVsg
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::bc0c; helo=smtp-bc0c.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::bc0c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37F6E60838
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:26:16 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTK1l3XJbzwkn;
 Tue, 17 Nov 2026 10:19:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794907179;
 bh=+aqQtoGx6Ac8rnIWCjAdwW5CxEPWVtJS8cqI8pELnGA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=A7SSYVsgXySPf9gifUnANi0LDmDM/UTT/mp62bCacAFOLcXvKBWf1ike6xLLbeBeB
 yKHSjq1eLyO9p4NZ/nNsYjCnfHGrj0CsOimEkJ//zM6OjMVPyns0UFQll4+vhPnssU
 NUEhAhvT5POxVt9OwsivHkIfbP4+weLR308+f38Nqf761+hJAUu4UQ/xda/D3+j+71
 sopeUcKn0LGKue3sZUxhCuoDEZHT3aE3UlUJsZClurTwpvVhKQuCBqgFpBhpt8maNL
 TCDYAvBM6MFO0rxXVrKCpQlQLJdmV1WkZb8J7JEQEK35CbX6z5U8LuEXsyNnOXivWl
 mN62z3r14cPWw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTK1k1gM7zjhD; Tue, 17 Nov 2026 10:19:38 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 10:19:07 +0100
Subject: [PATCH next 05/10] doc: rockchip: document BootROM term
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-doc-follow-up-v1-5-2cc0910f9455@cherry.de>
References: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
In-Reply-To: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Eddie Cai <eddie.cai.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>, 
 Shuqiao Zhang <stevenjoezhang@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

There are a few terms that people working with Rockchip boards could
encounter and BootROM is one of those so let's document it.

Based on wording from Jonas[1].

[1] https://lore.kernel.org/u-boot/1e47521b-c3f2-4c62-86eb-51866b911968@kwiboo.se/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/rockchip/rockchip.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 60b190c198e1..d9029715da5b 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -336,6 +336,13 @@ Notes
 * rk3066: eMMC and NAND share the same iomux, so if in MaskROM mode
   and a NAND is the boot medium, clear the emmc_flash_sel bit in GRF_SOC_CON0.
 
+BootROM
+-------
+
+BootROM, or BROM for short, is the code part of the SoC. It is the first code
+run by the SoC when it is powered up. This code is part of the silicon and is
+not modifiable by the user.
+
 MaskROM mode
 -------------
 

-- 
2.56.1

