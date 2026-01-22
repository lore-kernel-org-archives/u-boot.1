Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C94C44536
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 09:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA5B83AB0;
	Thu, 22 Jan 2026 10:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SQjJ8i1I";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r7kseJDz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137DD83AC5; Thu, 22 Jan 2026 10:08:05 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE50839DF
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 10:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dxZwK4YMJz9vN2;
 Thu, 22 Jan 2026 10:08:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769072881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6kXTEvHfmI6/ptGuay+oBRVNRTbOC+oTsuaFwgztOpM=;
 b=SQjJ8i1IgtINFi1Dx62YoeK5uNyFq3fDdfbU7JNTNFGO+AN0WtD9xXlkt9Kc6cSc4thpGm
 7mijHIRoPga3JT2oP5SKYMrdJJZGdWfN0DEsagP38rqe1S+CVh3SGYFDdHjlAwuuoD7xYQ
 /+3cZE0kw199Kk6nMJtfAtb9iaYZGKK3mmeQa/Ey5ptH26yvQVLeKHQNSgHkIFkNEhaLPt
 5l2+pzHxlum6EXFGP6ukyznvVw/IrAAmQN/xsL8zscIgrHg/CVq1DjoVbl3RrQ+3MMWOq7
 KofrSDs6mYkBr/AwVwBT09BZYcfwngOazgngRshWHumUWwoD6m7EK3ORXapTdg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=r7kseJDz;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <133ec847-0d52-413d-9d19-e62fe5987822@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769072879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6kXTEvHfmI6/ptGuay+oBRVNRTbOC+oTsuaFwgztOpM=;
 b=r7kseJDzBcIUAMCiEh1vHUHxH7EoA8bwA2OQH9W6DVKbbUZziBsSw2UN89DfVn8O4JTE09
 w1+rRn7KSOIGlmziaerYNcA8hon9bKZwDSMM+JrFjISImvJY1gVIy91SJdR9si/6SWuV4B
 yVFeulZgMI/nJNe0o/fK/7G5SAA5FGDx3NLeCseyk9JyBQ4+1mAMVx1OK8RLdKsyZDwoGC
 nrOJHm617lxpELJQUFztYA+t//c857+G1HQy0JYcx9czTo2xQ4stoxtmNWcO7MrmceDybM
 SfUw1rQuIZjpT6kHoPvWtAgGVh1X4I69MFGUn2UWUpNVY+eUZedUACGDmaCszw==
Date: Thu, 22 Jan 2026 10:07:56 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 01/10] Makefile: Have binary_size_check report only first
 match of _image_binary_end
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-2-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260115222828.3931345-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: m3xmwou1c3a1eqj4fn3w7gzds6iyxrqg
X-MBO-RS-ID: 4d5f06184937de3f148
X-Rspamd-Queue-Id: 4dxZwK4YMJz9vN2
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

On 1/15/26 11:19 PM, Tom Rini wrote:
> If we have ASSERT macros that validate the position of
> _image_binary_end, our awk expression will report a string that causes
> the rest of our check to fail with garbage values. Have it exit after
> the first match to fix this.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 50737f938503..37cebd4f8edd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1583,7 +1583,7 @@ binary_size_check: u-boot-nodtb.bin FORCE
>   	map_size=$(shell cat u-boot.map | \
>   		awk ' \
>   			/_image_copy_start/ { start = $$1 } \
> -			/_image_binary_end/ { end = $$1 } \
> +			/_image_binary_end/ { end = $$1;exit } \
Can this same check also confirm that _image_binary_end or __bss_end is 
at 8 byte aligned offset ? That would allow us to trap all the built-in 
DT alignment errors.
