Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8811C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 07:39:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24A38809C4;
	Thu, 13 Aug 2026 07:39:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1gtu7t7SJiWH; Thu, 13 Aug 2026 07:39:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4169E8095E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786606754;
	bh=ro9sU+/jBX5tAFlDWHxem8Si69JYJQ5OKpqwA8fLwDQ=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gKy1M4Hp1uhyuNUfQO9+KS2MITP1kd8ewjaYY7d8k5KoMu+SWUa0rgxcCqknGuLc0
	 PKPqjTNcCBfomUVcbtXvf4iB1fZUm+izWR7agC7f9yphXhs6vtbE66+MVDXhgUNZP4
	 9YnGyVMFITsgm8RcskYGyHoVfSC9Dv199S1kz06TNwRYBZTySy3Wyv+RdOmFvPbKgF
	 WW2HXvLcIQMnUh3ZEhi/4b25JToziKBubwbBwllhOsbIuN80RIKNsyAfKwTWXow2/5
	 d2lnXsKc6rQRDKkpMj2IsZgOnwarmSYMl48OlZICa5IuiaVREqN6hbM3XMnjpwSvTn
	 NesumrpfVuXSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4169E8095E;
	Thu, 13 Aug 2026 07:39:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D0DE2B2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66632608BD
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:39:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IAHIjTUDznhp for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 07:39:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 86B96608A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86B96608A1
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86B96608A1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:39:11 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hLHL45GZQzKw2C;
 Thu, 13 Aug 2026 09:39:08 +0200 (CEST)
Message-ID: <17e29b61-b6fc-43f4-abe7-cd1df6f8a8bc@mailbox.org>
Date: Thu, 13 Aug 2026 09:39:04 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] MAINTAINERS: Put together AMD/XILINX platforms to one
 fragment
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 git@amd.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <cover.1786605799.git.michal.simek@amd.com>
 <7aa39a1a4f0394179b91efd6cc1c5d395b725f0f.1786605799.git.michal.simek@amd.com>
Content-Language: en-US
In-Reply-To: <7aa39a1a4f0394179b91efd6cc1c5d395b725f0f.1786605799.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: eeeyif51jqm1y78zp9fbqfskg7i6ap1f
X-MBO-RS-ID: 256dda70a7ee9123a75
X-Rspamd-Queue-Id: 4hLHL45GZQzKw2C
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786606748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ro9sU+/jBX5tAFlDWHxem8Si69JYJQ5OKpqwA8fLwDQ=;
 b=CAvNEDvw+xyLbQjuHjlHBIdmu9UzCvqcKwPu3SyjhRY4PLEVeMWQR8e71OqWoWyVRXRrR7
 WAwVTVQG47ksHmqDWChYsy5TJDGzVF9v9FQQfz83ob9Ki5XcsSTkTYrUlTvw92y5Tkxx4U
 Dp4KSkgK68OFiURvFUSsO9jNwTbiUA05Fudwn77HPzdG+dbpRIOuZ3m+DVxQpgwS2zkJiK
 ErnOC73D4OMe9rweenUn/R4rTmF7/HeFC4wC3T1uujgJfnPAgIJJvDEB+V0rTQNPDEfNxG
 aPMStEFwGwigBIW4xi/DxvocL7fGhpzm5C5BAduB9tEWV0BreV9dONFNxBNBRA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786606747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ro9sU+/jBX5tAFlDWHxem8Si69JYJQ5OKpqwA8fLwDQ=;
 b=lO4GTBXJfO0K40VRIBuq898rS0Tnfg22gZXct/Cr7n0fDplFB05/3/4tdLGVxWl2mchpW2
 GZqOQVI8ac4JfUIX/tMbydUvHcX5XbYqxmvw3EmNOaWLqg7tvHsDFb7J+L8cP6mVRmwkax
 fqtq2xK3JhlSRXR2w79llCT0td2W13rOdlrI/56rJHlO6RPGtr6bhBZyy4HlU7JnlbtEDS
 /1+DrmnukQ6zr9iUgaNaVp0SaXpF7zOQ/I8vUDy8txWqvWMbTfu4lZpUoD9bUj5obN6TXJ
 L3BG/9YandxMNr7AoWISIMKV7hISoBZCUjg2GU74rgvfg2GdwoUq7qQOnn4RCg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=CAvNEDvw; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=lO4GTBXJ
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=lO4GTBXJ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/13/26 9:23 AM, Michal Simek wrote:
> Put together multiple SOCs fragment under the same umbrella to cover all
> ARM based AMD/Xilinx platforms. Also use this oportunity to simplify
> description and remove files are already covered by N:.
> Also move N: xilinx from Microblaze because multiple files have been added
> over years which belong to ARM SOCs instead of Microblaze.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   MAINTAINERS | 70 +++++++++++++++--------------------------------------
>   1 file changed, 19 insertions(+), 51 deletions(-)
This is nice        ^^                ^^

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
