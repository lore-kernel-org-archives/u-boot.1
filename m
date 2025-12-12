Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A8ED59D77
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 16:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 957BB8367F;
	Fri, 12 Dec 2025 17:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dmG3MoRQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CqsvALyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B30835B3; Fri, 12 Dec 2025 17:12:14 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6793883837
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 17:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dSZGY6fnQz9tK9;
 Fri, 12 Dec 2025 17:12:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765555927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obyaTAvvPO1haurkxUOFnf6H9yODeHdiSqZT//TShPw=;
 b=dmG3MoRQ6iKZmfEDV28a7Zr2zFq8tukd592Y6Nmy1hH7J0kaRsg6dD6wZyvPOofAXiD3lI
 8JtFtbupPWsvUasyh20EdLt9qpxF6r+AnsvjtG5GxAo5Cn6fRxEiC14qQriXZHJ3s5LF2Z
 o/ViGHlrbjd/dqYBuSDLcOqajrJQg19p2T8JziZxLt7+ocAFXhbkFzm7XbOBpC7epFuPC7
 izune+eI0kdFWhLCslcrUIoiLNREz9FBuKiTIIvleAVzTB3SdeQVGI1rw9AML/bmnKyC95
 JkQwSs0lM5okENtBt+yFk52mr+LljogaybYgOZtOOAufdHhgNMlj+OwWkPcLcg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=CqsvALyT;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <805bf097-3d1c-4ada-b3a9-1a541068f161@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765555924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obyaTAvvPO1haurkxUOFnf6H9yODeHdiSqZT//TShPw=;
 b=CqsvALyTy66csQ92thMbQmO/9VhXD+aZqr5Ztdqry1A2x7dSO6nH78BkZecM81ZlPNGD7g
 VFmtEbjvxxyWs4VtmoiQ5onDqEGE4EsafDddt/vf0vVu9QbQf83KpA+WAkeoHguKnD8ckC
 UZmwEoLmpCJWr18jkZ1EznKc7L6Yeru85MaWSd8hccBgp/dn9znuDWIM3PBP4reb9Zo/1L
 EMVggW6fZ/R6kEPsJAvgOiEUv5v7i0NrWq3NqDWv+6T+jAcytQ4ueWbK0pFcO5xF30w+Jb
 0YeJD6pyeVR5HWD5avcXnk2aWYOdUe2BXgiDvUAK0/8E2DuIERC1amzigLihHQ==
Date: Fri, 12 Dec 2025 16:32:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] firmware: scmi: sandbox: Use scmi_clk_state_in_v2
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
References: <20251211-scmi-sandbox-v1-1-97a0401f8991@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251211-scmi-sandbox-v1-1-97a0401f8991@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f8a13180a3196b957e3
X-MBO-RS-META: upeqtjhzyuwcce444c1c7x9pdxc6xegi
X-Rspamd-Queue-Id: 4dSZGY6fnQz9tK9
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

On 12/10/25 6:09 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The sandbox scmi clock protocol use version 3.0, so need to use
> scmi_clk_state_in_v2.
> 
> Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/firmware/scmi/sandbox-scmi_agent.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
> index 5b242a039c2..010bf99fbc6 100644
> --- a/drivers/firmware/scmi/sandbox-scmi_agent.c
> +++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
> @@ -828,7 +828,7 @@ static int sandbox_scmi_clock_rate_get(struct udevice *dev,
>   
>   static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
>   {
> -	struct scmi_clk_state_in_v1 *in = NULL;
> +	struct scmi_clk_state_in_v2 *in = NULL;
>   	struct scmi_clk_state_out *out = NULL;
>   	struct sandbox_scmi_clk *clk_state = NULL;
>   
> @@ -836,7 +836,7 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
>   	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
>   		return -EINVAL;
>   
> -	in = (struct scmi_clk_state_in_v1 *)msg->in_msg;
> +	in = (struct scmi_clk_state_in_v2 *)msg->in_msg;
How did this ever work before "0619cb32030b ("firmware: scmi: Add clock 
v3.2 CONFIG_SET support")" ? The "0619cb32030b ("firmware: scmi: Add 
clock v3.2 CONFIG_SET support")" did not change the behavior, so I think 
this is not a fix.
