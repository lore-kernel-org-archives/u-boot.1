Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29917C54E6A
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 00:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F6A8804B;
	Tue, 19 Mar 2024 01:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KLjmC4H9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qcUy0MQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F638804B; Tue, 19 Mar 2024 01:31:46 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FA1E87CB1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 01:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TzCMh0wcCz9slS;
 Tue, 19 Mar 2024 01:31:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710808304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/wvhOKt7k/8iAzbGBWpOK3gMVHWSBhNFiQd6a+qfJU=;
 b=KLjmC4H9KU0E+tTjcDZIVAVeyR3emhAAF+f/KjLLqeSlSJQRVLgUGzjCKgPOucmfH6fO8H
 q4MXo7LgZ75nQPgwyIGptqTON6azx/1pGY1w67dG4fxo0kmA0GBQ17guOjA00A5cJVXQEl
 xLry0kLKmQum4jQYBs90pw5MNszvROQGl33IuAEvf+jUb0381cD0z9lzB41jhRSJawyaaS
 ZolOZaXYiz0pCKwctzh1LnSRHrXryLyC/Lq6Q7i0dAlI2giirDOj3qu/8mRMcFeBCx5tdO
 5L/7kfranP2Ejng5zIYYrPAQ9khWfc81nU7LlnSkQcu/cS3e6HiysjRReSqO4A==
Message-ID: <d368f689-08a4-4f8b-8bf4-07db7dd27858@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710808302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/wvhOKt7k/8iAzbGBWpOK3gMVHWSBhNFiQd6a+qfJU=;
 b=qcUy0MQasnEsI6Ds/s/su69tCkKWRDJ0ZEM8mHyCnRD1mWdMqp19y8zG69xX3PBPYd9IOl
 juU88OlXmZFeWUR1KPcv3YlLiXLmpzLVi+7STn09tsjKVUhsFTyZOWuFJTD/0+c5FiWKnG
 /VrIfBs3zC5nDc+Nz1VUJdS4M7egxkwsxZaJVkiJKpMq5meMuc2ItyK0EAuSoIhmreaivV
 81VGY6cOn/cUAgfyTGBrvEwQI5IMgG3wq7+tslS4IXwdyv0avdf0rRgp1RcRJId3v5ghO0
 B0kxsX74nXsiw789M7T1FN3t1flDgEeYwFacVhTqYIS6vtzNnLFSdGmv6ktPFQ==
Date: Tue, 19 Mar 2024 01:31:40 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] boot: fdt: Change type of env_get_bootm_low() to
 phys_addr_t
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
 <680c7c9d-5f34-4646-b624-490f934f4a1f@gmx.de>
 <f60355b8-e18c-42b3-a76d-b9a2530a186d@mailbox.org>
 <132c9613-1c58-48de-99bd-4a42178eeba6@gmx.de>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <132c9613-1c58-48de-99bd-4a42178eeba6@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 94062d5d49813766ada
X-MBO-RS-META: 37rhtnctatyhz8nrjzae8zdrzm9ij5tk
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

On 3/17/24 6:18 PM, Heinrich Schuchardt wrote:

[...]

>>> Shouldn't we convert to unsigned long long for printing.
>>
>> Printing phys_addr_t always confuses me. I was under the impression that
>> turning the value into uintptr_t (platform pointer type represented as
>> integer) and then actually using that as a pointer for printing should
>> not suffer from any type width problems. Does it ?
> 
> As you already remarked on LPAE this may happen.
> 
> Though you may not be able load initrd outside the address range of
> void* the variables might exceed it.

ACK, thanks for the confirmation.
