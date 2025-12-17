Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56EED66BA1
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 20:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D6FB83C28;
	Wed, 17 Dec 2025 21:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="glyODhOv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ay+D2jC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD1683C2B; Wed, 17 Dec 2025 21:26:30 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0816183B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 21:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dWlgm5WHyz9tWx;
 Wed, 17 Dec 2025 21:26:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766003188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wwGsG/gWoSnB3rIjTM0X2r49+4DSBq1zK6ro598a0/E=;
 b=glyODhOvZ+NQzolYvoBeaye//f7PGp8WN2wXhMYZ7TIf6pe4dLy1NTb3fzCziQOe45PP9b
 ksu24TrsLvWx+KpbwFg6XlIfjXiLtyfhwJAMr1VgNMRqqkgQSW4blfFnJE9SSDxigpl0oB
 5JMtHfUPx8lvKl15fEsVPM4j6Fdj+I+zhmDmf/x0n8xeA5Z50mXeefjNcfu1DZRZvisqSO
 92h2/PGq+9nNVRrClkOoFHNYXQwRjrU8A8JNB8UHwE4rlveFn/A28cJ5PqhdBS0nIPJDY5
 5bk5o/uouL30VQk/yuRhgpKcJUGoUDghl8Ye9YVfumY9n1dOui5UzrJaBNl4dg==
Message-ID: <7de21f80-7059-4bea-9697-8b937d689514@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766003186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wwGsG/gWoSnB3rIjTM0X2r49+4DSBq1zK6ro598a0/E=;
 b=Ay+D2jC0O13MO5nBReZjBNJhC3MMXljfTKBdhQlqNetrM0k9zBr0OMKJXc02tgAVqQe59+
 5gmro7j5qGR0wbbcGlovbogS/9hOA+G03kwfIfF7dvwRhZbyeT+sMxRBfHfUWHPWyCik8n
 6/9HIdbUW9raqDKdRA51tjC2pVJWN0QZgkWBK4RZaXAkQwGMpjiSQB/PiNQ7XBPJZQpv1p
 kqTsvIF2bQAfdozxMe2gKLk95cRh/b3B/+SEJorp1GOCeSdUZ7Ysijj6yexjBF0xGNZV1o
 g6CbmoDNQH8ing6/6m9vYbfZzvCfzzS3ct1QlcOgbkXVtaFYTsj3yrmqc74I8g==
Date: Wed, 17 Dec 2025 21:26:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/3] clk: scmi: Remove duplicated
 scmi_generic_protocol_version() request
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
References: <20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com>
 <20251217-sqqs-v3-3-f3405fb2ad1f@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251217-sqqs-v3-3-f3405fb2ad1f@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a77103704b9f817bd81
X-MBO-RS-META: ucgc11iw5puo3uq3w7k785kecs1g7qf3
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

On 12/17/25 5:45 PM, Patrice Chotard wrote:
> scmi_generic_protocol_version() request is done twice in scmi_clk_probe().
> Remove first call which is useless.
> 
> Fixes: ae7e0330ce22 ("clk: scmi: add compatibility with clock protocol 2.0")
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Valentin Caron <valentin.caron@foss.st.com>
> Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
> Cc: u-boot@lists.denx.de
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
Same comment on CC list as 1/3 , please fix.

Otherwise

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
