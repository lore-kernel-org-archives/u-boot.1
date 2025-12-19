Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF63D78794
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 16:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B8E780077;
	Fri, 19 Dec 2025 17:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g5x3zIk8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NX1zajw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5D7980FA1; Fri, 19 Dec 2025 17:04:36 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1D780050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 17:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dXsmf545pz9tFB;
 Fri, 19 Dec 2025 17:04:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766160274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ExuCH3vLVGZ8mghaEiGtpr6f5wMOpQ6t2FFVHCCV+s=;
 b=g5x3zIk84w8eu+313CVZPZTPxCqhLjCZjdsM8euU88Km8gKgttM5ZdnxMjhZ0TRQMtnMcb
 TZwbOBPpSRl1WFiZZXo9mIyScboDpbuQ0sDTaXnV4YvRFXvG9ySV4a0qD9Tt5H++Xs4k/X
 SfMZH3b5QIkWaybkY3bCp7W23RgaPZ/Y9kodT0o9F+/Ke+cZybJfzasI4Ua24YHDGch5/C
 +IFigUQ9UqPF3LGb9xgx9ctQg3y1LDolprwMtW8+no3JM/EtsW3++yz/RTkuuFhTRfBVga
 JtH61U3VomGs28DR9WjNdf89Ve3JsXXRH/kJeBJ8dtnQNfa+8EC9AYEpuXFykA==
Message-ID: <f1cee217-9d40-40a4-844b-5c08ea847695@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766160272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ExuCH3vLVGZ8mghaEiGtpr6f5wMOpQ6t2FFVHCCV+s=;
 b=NX1zajw27hFk8nTCoDoIpoZOIc2PN9tsgDFNDzsnWKMVTkJ077P1T918p+BohAso0aMisB
 zXCGQe3bpEf8v73DOw+DA4sZFsKhoJCWzCwFu9NzCPOX4BIfVsMfWKEYrkg7NOePz4qG2N
 qunGn/5L3gd0hE10srUu3+d/rRYoKFpuuBCf4PHKIBOXIjGpj148lIJ6friu/k49oo7Qu+
 xRRKQ6DZznQu/DNwYr+8Zorh9ZKonWCzK/Rm1I10DdvlulHcNPoiZfVxMFBAdTxv6gUvsV
 SFCFQgT844oRKXc5BMGp8JwTbuhXwIvnf8tPxDksWq99nJW+Mszt3QmP+5jJyQ==
Date: Fri, 19 Dec 2025 17:04:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/3] clk: stm32: Update clock management for
 STM32MP13/25
To: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>
References: <20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-0-d055da246e55@foss.st.com>
 <20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-3-d055da246e55@foss.st.com>
 <f4cb1c18-fb8c-49f8-9cf6-8136918e7a30@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <f4cb1c18-fb8c-49f8-9cf6-8136918e7a30@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 09ee471e6d7404b63b7
X-MBO-RS-META: bkchiy88eqats8hhnn9utx4z4h1bqkbn
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

On 12/19/25 2:55 PM, Gabriel FERNANDEZ wrote:
> Hi Patrice,
> 
> You can add my : reviewed-by Gabriel FERNANDEZ 
> <gabriel.fernandez@foss.st.com>
The tag has to be on a new line, else PW won't pick it up.
Also, it is Reviewed-by: ...
