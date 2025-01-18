Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AC4C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 08:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CECE08063E;
	Sat, 18 Jan 2025 09:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="B6oc6odV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mhyQu7co";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 691B18070C; Sat, 18 Jan 2025 09:03:17 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7704780312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 09:03:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YZpxv0QvNz9scH;
 Sat, 18 Jan 2025 09:03:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737187395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9l1/FPxylk+A4zBDELXssJhV1irq2pkdsUPAWY7MIWk=;
 b=B6oc6odV2wcjFSxKKw0dayXzF2dOZLjIP+JfQOUmKuK9+HV7QolOCRcmmDpL0tv3MDzeos
 /S/hf3FJiS7132qqErojF7x/K5ttvWDf3OHxXL721f2tmMtsZUPbJWGszHlOIsttzF2LAM
 Edkm5TzN4PBIaGndl/ZSyqrmWSEK+dhcyFIoGQwF2Me8LzT4gMNSxOEAjSEriuSyiupPLe
 O+Mz8whaLK9+xSxdNFZ0JCF8Gf2Fr4FXPFI7FWTPxk18n/assKNiEeoe89ZyviDV7JycJZ
 y0clKaNzQqXtWOxzgZde8nS5RLIRxxUOJD263IaZ+O7F6OTRS8ELtvZHs5B9zg==
Message-ID: <6b49eda4-44ca-4c10-81ef-ed179b1cf76c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737187393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9l1/FPxylk+A4zBDELXssJhV1irq2pkdsUPAWY7MIWk=;
 b=mhyQu7cohcv1rdKn+1jeQuW6dYo42WlomG0WI0a52biTM09DfkFs8x9hC3G8wh1qVrq9Y/
 bhodjd05pImT+WN8uWVqmUUDChVXq+1jt3Grs2eMFWQBxD+lxPVvI4bBECBDFp/u3+xZLk
 wRIcLMt7TjUqeqZhex0hVn4tcRfEuDN0ixYejrFI8V7B31byQoMIUUZHBfTg+PABuEOqnr
 3/+JTV4mXzv35glP8Thpz9+w+PThLAymGuX/Ux+PuZ6v3ImdGfXNsiKdzjYynUBrFi4BUT
 PImtbxGl/TAq1n4T5hI+HV9TdrZAv8DMMg4hvplSvAtJ92Vt/pOtwUd4tQ/5rA==
Date: Sat, 18 Jan 2025 09:03:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] ARM: renesas: Rename common/common.c to
 common/rcar64-common.c
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
 <20250112223528.179828-3-marek.vasut+renesas@mailbox.org>
 <de1d81bd-caf4-4604-89ad-68f7c1f180c4@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <de1d81bd-caf4-4604-89ad-68f7c1f180c4@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: tw7bna5ujkabozex8xdfhsut3iabd5ty
X-MBO-RS-ID: 3f6a30b2e6390df6ada
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

On 1/15/25 11:27 AM, Quentin Schulz wrote:
> Hi Marek,

Hi,

> On 1/12/25 11:34 PM, Marek Vasut wrote:
>> The common.c content is specific to 64-bit R-Car SoCs, rename
>> the file to rcar64-common.c and remove R-Car 64-bit ifdeffery
>> in the file. No functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Since there are going to be significant changes to this series, I'll 
send a V2 later today, and please give it a once over.
