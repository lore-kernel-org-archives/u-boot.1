Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6A5D6CFA3
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 19:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 898C7839DF;
	Thu, 22 Jan 2026 20:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g8pudGYO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QMKsMBjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11FAA83A6A; Thu, 22 Jan 2026 20:03:46 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D75838FA
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 20:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dxr7f6sfbz9vCg;
 Thu, 22 Jan 2026 20:03:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769108623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMg0zjJBKG6oMOL117UGNTBloNQNtmWH/8Um1KQ+XcM=;
 b=g8pudGYOM97LknWe2yS+7kK85mkVbxW3VTDx2FxRVARMjqAsflnrHQRX2FVOFNmyJ7/sLE
 7FNONHCgJEGc4pEpxbgQxzu2jOWtl3ziB2cAeXafBd3V1AHCpvHZWlH38BFNTCtYbmkfja
 toujg+QF+tgJbJB0Q0Q3RLs7Z2D7yNbdacsg/+hefQLggcJHHZyRA5/cnhyjdu9cWHXOxn
 VME7d4GobvU7jkeoIoT2tuJ5/OZC8A5NA8szaoRO6tSt8X37fuXzUjBizS+pzoOy/CjHqG
 59tNH+Ecr4sVKAaEl6gw2cvFf6wmRD0AtsiUfDbX0dnjw76edj0mmJS3pKRu/Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=QMKsMBjz;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769108620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMg0zjJBKG6oMOL117UGNTBloNQNtmWH/8Um1KQ+XcM=;
 b=QMKsMBjzYOuSkXO925ExMQa8dueczR4jSBxZr5qi8sSWMEj/bk5amLYJx2pvzLHlexikBA
 kRiCbXYUptJnJ8DD5B7Jyd4SJdbqEdOp02SH3jEtr8wCkevYSKHoaVXL60fNm6/ZpDAC6v
 kgO5iS34kOZhmElGZB4BK3oGNrrLKsHe2BddDVRGBnrNtvtFfpFL03vXGVLU5nloB6JHNU
 9i85Fl4m4tq/xyUB+Zk4pg9rpAUr6xko1N2MhWUNBAQAY9abYvbBsSr9q8HQNxGHNLgu9U
 kZ4A4DxZlAmtZc/+DQBgmwzhyPT9S9QIIQ4cCOH7ZF78UihPdnDXoXVNt2t41A==
Date: Thu, 22 Jan 2026 20:03:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, anshuld@ti.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260122174546.GB3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1rhxwe1ykwhsk9o8epyz44pui9k11g5a
X-MBO-RS-ID: 8bf41dfa628722107a5
X-Rspamd-Queue-Id: 4dxr7f6sfbz9vCg
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

On 1/22/26 6:45 PM, Tom Rini wrote:
> On Thu, Jan 22, 2026 at 10:52:47PM +0530, Beleswar Padhi wrote:
> 
>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>> packed inside the multidtb.fit FIT image. While the individual DTBs
>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>>
>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>> setup_multi_dtb_fit() when locating the next available DTB within the
>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
>> version v1.7.2-35-g52f07dcca47c")
>>
>> The mkimage tool already supports enforcing this alignment via the -B
>> option, but users would have to specify it explicitly. This change
>> makes 8-byte alignment the default when using -b.
>>
>> Reported-by: Anshul Dalal <anshuld@ti.com>
>> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> 
> Tested-by: Tom Rini <trini@konsulko.com>
Doesn't this enable 8-byte alignment for everything in case a DT is 
specified on mkimage command line ? That doesn't seem right ?

If I do mkimage -f auto -b ...dtb ... , then I only want the DTB to be 
8-byte aligned, all the other blobs can be 4 byte aligned just fine .
