Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0D9D3EE63
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 13:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10124839DF;
	Thu, 22 Jan 2026 14:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GmB2Dfpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4626683A1E; Thu, 22 Jan 2026 14:29:21 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3402A8397D
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 14:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dxhjm6XSSz9srJ;
 Thu, 22 Jan 2026 14:29:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769088557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=irEQpLlj1DmCXGWzowvjyRcJaxHxwZQZPp36xmRg/Tk=;
 b=GmB2Dfpv5Bnp6fVwRONDrDAWOOM2ah76g1QbSqZTBZkIPFoCV921TS8jnrol3sewyZybrm
 Fk4L3/L+ViTwG2cWN6ysFAzgPUGsCIT0iLsmT3B08rN0D4x72Opqd7ZuQQ6w78vRqrTf4R
 pclOs8kL2j78okS8fOkp/iSChpQIhD7GPxhQ8MWtm28EMxfcayi/I6Te7GfMqdhcP/pQHR
 NWH2UGLs4xS+bmmCVbRYQ76XQoZFyfoLGEnimkZfrsbe6LsZ6xq2iFDK0CGNZ1/yneQ9my
 5d1RcsQzy53O+0XIfIlCodQ1tLP0zzIgP7NJpdgx5ZQSeH8fQki9Fc9J23ka0A==
Message-ID: <f3dd965a-3610-48f9-86e0-d240f8e0a64f@mailbox.org>
Date: Thu, 22 Jan 2026 12:16:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4] usb: xhci: fix DMA address corruption in abort_td
To: ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>,
 u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, marex@denx.de, trini@konsulko.com,
 mkorpershoek@kernel.org, ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
References: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
 <20260122052754.573814-1-anandhakrishnan.s@dicortech.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260122052754.573814-1-anandhakrishnan.s@dicortech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 61jnuz8ukesjwq6gez5mfzftw1htswut
X-MBO-RS-ID: 57ba1d83483e88ed9c7
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

On 1/22/26 6:27 AM, ANANDHAKRISHNAN S wrote:
> When aborting a Transfer Descriptor (TD), the xHCI driver updates the
> device dequeue pointer by converting the virtual enqueue TRB pointer
> into a DMA address.
> 
> Previously, the code OR-ed the ring's Dequeue Cycle State (DCS) bit into
> the virtual TRB pointer before passing it to xhci_trb_virt_to_dma().
> This produced an unaligned virtual address (e.g. ending in 0x...1).
> 
> Inside xhci_trb_virt_to_dma(), the offset calculation:
> 
> segment_offset = trb - seg->trbs;
> 
> operated on this unaligned pointer, resulting in an incorrect TRB index.
> In wraparound cases, this caused the bounds check to fail and the
> function to return 0.
> 
> As a result, a SET_DEQ_PTR command was issued with a DMA address of 0x0,
> leading to controller hangs and transfer timeouts, most commonly when
> aborting TDs near the end of a ring segment (e.g. index 63).
> 
> Fix this by translating the aligned virtual TRB pointer to a DMA address
> first, and only then applying the DCS bit to the resulting physical
> address.
> 
> 
> Signed-off-by: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
> ---
> Changes in v4:
> - Moved the changelog below the '---' marker to prevent it from
>    being included in the permanent git history.
Please keep the RB tag next time.

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Applied, thanks.
