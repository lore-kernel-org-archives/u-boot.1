Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9F9FEFB43
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 12:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6FE883BB1;
	Fri, 27 Feb 2026 13:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ecSXnE+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC21D83D1A; Fri, 27 Feb 2026 13:11:29 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BF683AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 13:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fMnHK6MMjz9vGN;
 Fri, 27 Feb 2026 13:11:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772194285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HsV07iQ1VawuKs0RVpW18sQwa8F/2c9kOI6KykjmayA=;
 b=ecSXnE+CIWUDSyh5q/nao8aUpupaxNUJkYCBUVn+w2mOTHwWY5K9XwjdzLBGCtAJEsBXYn
 gktYV1qC2WdSq6Sm/D/ban8arv1eOqiZHYNnV53vJqUQvh7Aq9aWcmojRaRYogXpTT2W0X
 AiTtN9BfE0WO87WZTwmdYHxdMSkpyxKo16hEfRDb21OE5F5UfC1clYZGJXiBiWK4zzsYC2
 zL7yl6uspX/g9W8cZJXaLrHxsYMKcD4weMfOfKlA21mhzXTEjqzfayplyv2t5jeJb96q6E
 tPWeM//o6CbTs3u0XYrNwbykIymRgcmQSy+kpPzPKW9YcAru4ZuUHXUxT0wQ8A==
Message-ID: <b131c7fd-dde7-41ec-8012-1bc829e2ba1a@mailbox.org>
Date: Fri, 27 Feb 2026 13:11:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] clk: scmi: Fix protocol version fetch for non-CCF
 platforms
To: Kamlesh Gurudasani <kamlesh@ti.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Alice Guo <alice.guo@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>, anshuld@ti.com, vigneshr@ti.com
References: <20260227-ccf-v1-1-a22c19460b74@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260227-ccf-v1-1-a22c19460b74@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 89a7a89b738960b7e8a
X-MBO-RS-META: jfe4ujzx4zs8frcxjqth1kbekm3ip35q
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

On 2/27/26 1:07 PM, Kamlesh Gurudasani wrote:
> The SCMI clock protocol version was only being fetched when CLK_CCF
> was enabled. On non-CCF platforms, the probe function returned early
> without fetching the version, leaving priv->version as 0.
> 
> This caused issues because code paths like scmi_clk_gate() and
> scmi_clk_get_permissions() depend on priv->version to determine
> which protocol message format to use, even in non-CCF mode.
> 
> Fix this by moving the scmi_generic_protocol_version() call before
> the CLK_CCF check, ensuring the version is fetched for both CCF and
> non-CCF platforms.
Which platforms are these non-CCF platforms you refer to ? Which 
platforms are broken right now ? Those details should be included in the 
CM .
