Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3642FCAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 13:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B0DC83071;
	Mon, 29 Sep 2025 15:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vqrE9LZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31E683189; Mon, 29 Sep 2025 15:27:25 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B310782A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 15:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cb26d3k6lz9sv4;
 Mon, 29 Sep 2025 15:27:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759152441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8/oi0Fvh36YgkFMoZh4eMMWSF94PWpHp6CNdbgFmyM=;
 b=vqrE9LZKD16aIGjrtmSejefyLXIC24/+g/RsEtVaYAtccyT/K9cUM4fyyx2dCc6ihGucdr
 au+hOQLkSOcJYV8tn6H5KMEvgA2VIr18Q0cx8AkM4u9JOUPXaxxa/OIhgeJy+JHFhgT9UG
 8VZbePZ6GOmrN9qzo0YD/N1H3Dlp26OCxzY2pH2bd4Gf4HBBN03Hb+eb/X2Cfx75jZ7pCc
 dmd2QeL5nv0p6v0KBxmC0sT6EallzlNGNPh28gCyGTOoDqoqs9c0ZHuZJCDiFODa2q6elH
 7G8DpjYrlBVcLYPZjI0NQkKK43adCObLs4EZon7VJUtYsmaxZ4nH0mU81qeoDw==
Message-ID: <c65b682c-5520-4814-a6e3-42a8d39e2060@mailbox.org>
Date: Mon, 29 Sep 2025 15:27:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH RESEND] usb: dwc3: Remove redundant test
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>
References: <20250929-dwc3_ep0-v1-1-1d5c58933bde@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250929-dwc3_ep0-v1-1-1d5c58933bde@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8061a38642208e8ad64
X-MBO-RS-META: pdow9e618y31sgo7d77q4gdhs1grukg3
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

On 9/29/25 11:11 AM, Andrew Goodbody wrote:
> In dwc3_ep0_complete_data there is a test for 'r' being null and the
> code will return at that point if so. After that point 'r' is guaranteed
> to not be null and testing for that is redundant. Remove the test for
> 'r' being non-null.

If you really want to make this obvious, use git send-email -U20 or some 
such, this will add more context into the diff and include the relevant 
part:

  793         r = next_request(&ep0->request_list);
  794         if (!r)
  795                 return;
              ^^^^^^^^^^^^^^^
  796
  797         dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
  798
  799         status = DWC3_TRB_SIZE_TRBSTS(trb->size);
  800         if (status == DWC3_TRBSTS_SETUP_PENDING) {
  801                 dev_dbg(dwc->dev, "Setup Pending received");
  802
  803                 if (r)
  804                         dwc3_gadget_giveback(ep0, r, -ECONNRESET);

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks !
