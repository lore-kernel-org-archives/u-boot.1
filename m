Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC66C369C2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 16:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F2682045;
	Sun, 20 Apr 2025 18:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qH7vv0Ab";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QFJ7k8WI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C22D882027; Sun, 20 Apr 2025 18:36:49 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFDC782045
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 18:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZgYzz4LCSz9tFL;
 Sun, 20 Apr 2025 18:36:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1745167007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hOkMiVQrmoZ1oMM3soaA/xb0EJQK0ywkeEAaZkaUzSs=;
 b=qH7vv0AbiweuGCraiLMLQh1DvM95nFc1RrwYGx7cOiI6ezLEVOkIHXitHnCaKaOqjXURQD
 yV6RrPS+HfRZyz1rQN4N43cNtx16cAouWR9+6fDIpl4+2kkyj2wo4HKjf+6IJShaSQkPtg
 hYV1NgEafRIp62PY92Lvi2WJziCaaxCJNvgC0dutSwaYbkQRU/xVVXTUMJcmK4GpC4VVdc
 38P2MmyyTT6gdhFi60S3l+kVjY6Thf1Tkuy87z6lddrGq49vEKUbqHZbGB9InbK5VQwdzS
 O8pOcSr+PesOyK3fWGhvaL0Aokxt5oOwFcIHVOtQ3AUzcUZ8yAYHdrKDsdeRvA==
Message-ID: <f213bbeb-37df-48e6-a633-5dd1ca5a2f41@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1745167005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hOkMiVQrmoZ1oMM3soaA/xb0EJQK0ywkeEAaZkaUzSs=;
 b=QFJ7k8WIPflnzz4c7wfKSg869LipBDqf9mYTsWOs2912XUzgzELmjpy9ZuwuGVxzXB0wel
 vRG0VUOLxeMJqd23K7pf0BwNymCfPYPHOtcVTaKR4pFWEh146YZQuq2JcW4aMVejQ0STGP
 rI4sHtjUnYsAQslReLSdwp21p7mwaH/5wyJrUgl+v3Rjerx6n6/AKR9Lamalz9iq3RFctM
 K11F5kKKj06TWEeYuxq3FVWOFonEi21bgGJULJj/2XYELhi7oVgC1zMO676cuTu+fJaenQ
 cFtUBx7u7EmDFLD8U8jdiofsHBR5N6wmglHGu8w7OZN1AC0O22WxFMiLbjYsiQ==
Date: Sun, 20 Apr 2025 18:36:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] net: ravb: Fix RX error handling
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250413131129.68990-1-marek.vasut+renesas@mailbox.org>
 <b874c3e3-b0f0-4e6e-bb90-5fa9c6ed6d52@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b874c3e3-b0f0-4e6e-bb90-5fa9c6ed6d52@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 412ea79b4ed268e8f14
X-MBO-RS-META: sbcuhck9y1ddn7tkx16n65m4o7x58prm
X-Rspamd-Queue-Id: 4ZgYzz4LCSz9tFL
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

On 4/15/25 12:02 PM, Paul Barker wrote:
> On 13/04/2025 14:11, Marek Vasut wrote:
>> Correctly handle RX errors in ravb_recv() by returning 0 instead
>> of -EAGAIN on RX error.
>>
>> In case the RAVB driver detects an RX error in ravb_recv(), it must
>> not return the -EAGAIN, but instead must return 0. Both error codes
>> are handled in eth-uclass.c eth_rx() and -EAGAIN is rewritten to 0
>> at the end of eth_rx(), but negative return code from the .recv()
>> callback does not trigger .free_pkt() callback, which would clean
>> up and re-enqueue the descriptor which holds the currently received
>> corrupted packet. The .free_pkt() must be called for this descriptor,
>> otherwise the follow up received data become corrupted too, even if
>> those packets are correctly received. Returning 0 from the .recv()
>> callback assures the corrupted packet is not processed by the network
>> stack, but is skipped instead.
>>
>> For TFTP loading, an RX error produces the timeout "T" output and
>> resumes the TFTP loading operation shortly afterward, without any
>> data corruption.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Cc: Ramon Fried <rfried.dev@gmail.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/net/ravb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
>> index 539fd37ee59..da3e9dbeacd 100644
>> --- a/drivers/net/ravb.c
>> +++ b/drivers/net/ravb.c
>> @@ -192,7 +192,7 @@ static int ravb_recv(struct udevice *dev, int flags, uchar **packetp)
>>   	/* Check for errors */
>>   	if (desc->data.ctrl & RAVB_RX_DESC_MSC_RX_ERR_MASK) {
>>   		desc->data.ctrl &= ~RAVB_RX_DESC_MSC_MASK;
>> -		return -EAGAIN;
>> +		return 0;
> 
> Hi Marek,
> 
> At this point in the function we haven't stored anything to *packetp.
> 
> Looking at the relevant bit of eth_rx():
> 
>          for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++) {
>                  ret = eth_get_ops(current)->recv(current, flags, &packet);
>                  flags = 0;
>                  if (ret > 0)
>                          net_process_received_packet(packet, ret);
>                  if (ret >= 0 && eth_get_ops(current)->free_pkt)
>                          eth_get_ops(current)->free_pkt(current, packet, ret);
>                  if (ret <= 0)
>                          break;
>          }
> 
> So if ->recv() returns zero without storing to *packetp, we will call
> ->free_pkt() with a packet argument that is either uninitialized or
> points to the packet from the last iteration through the loop.
Fixed in V2, thanks !
