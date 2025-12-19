Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B39D78794
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 16:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B46980077;
	Fri, 19 Dec 2025 17:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Fw0vlhHH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="N+pEdwpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C73803F5; Fri, 19 Dec 2025 17:03:47 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF7C080050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 17:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dXslh4yrnz9tZT;
 Fri, 19 Dec 2025 17:03:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766160224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEx4bb+ld2jJmAuAjG2IzDeYRLThSkGR1P1Fr2lMHSg=;
 b=Fw0vlhHHt6aGISwMqnUK5hc/0UToaH1MJQOOTSo/HWSh5HfE408Z8tYHLnylRbFbXoNKXX
 ETaEeNExvYpETsGk5MNnZQjuSqnXI2N4ILGqPGb3zov9VtFL6fIncKtftua/t+WLc0AX0S
 hCWBF/KNjDhBiGEZbbV0nL7VBTUT0k1npkLqhoauQ91vwv8YzRmlskATH7cedwXSHRxxij
 jFDbuE1Vpi0Criq2jvKy8mRKh+s+Ng/GDUpnMdGrWFssKnuOEA/bb+CR/Gw9v1JUYCK/dg
 8OK/YrIDZQHN9OquNucnnGIKgOsl006ldvh0az3sMJKR4BWy/r0e1VgHAbfADA==
Message-ID: <7f8eb7fd-c503-41ce-9beb-9b247e91671b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766160222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEx4bb+ld2jJmAuAjG2IzDeYRLThSkGR1P1Fr2lMHSg=;
 b=N+pEdwpZUdBTkjRpmbdOYWRjPxc0Y8CJEAs/NXTUs0IaLfnaUg8M8imYdRLwfBXWhQJtEk
 0SGZiCFZyc1InRCKan4L57euJXlPFWsUBLVgJWYwILCOSAqrVM11GokvLNvOEcTOzOA/xH
 5Dm+XlbtNf2L8HhISenfRgAKzYaImsBeA7IhS7A6qKbM2oKpXE5mxpV2Rm00St/1mnhIIc
 k5wvxOiUZ10rHyKpfo945ylEcncKKzNhas7jyN7OqCnRX1UZuGaNsfE37S5kE6aCrHm1M+
 /SVF2LsVUuiPscZE0VZ+sUaFNHXXUfW+iQVGlb53NcH6eXhDXEIBEW2hST3H1g==
Date: Fri, 19 Dec 2025 17:03:37 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/3] Restore boot for STM32MP13/STM32MP2 board family
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>
References: <20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-0-d055da246e55@foss.st.com>
 <1cbe447d-dac1-4dcb-9a96-51c4ee0bcf3e@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <1cbe447d-dac1-4dcb-9a96-51c4ee0bcf3e@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6e5cd7a2ebb6b31dfda
X-MBO-RS-META: sznu8ijuuesixn5ip8f9d9mwqj5jxofi
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

On 12/19/25 2:42 PM, Patrice CHOTARD wrote:
> Hi Marek

Hello Patrice,

> Can you give this patchset a try on STM32MP13 DHCOR board in SPL ?
I have it on my list of things to do.
