Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88ADCEC1454
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 14:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41CA83E7F;
	Tue,  3 Mar 2026 15:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="LLDUAJOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FDF383F69; Tue,  3 Mar 2026 14:35:04 +0100 (CET)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3CAB83E7F
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:35:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ariel.dalessandro@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1772544897; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cBJGfSjK/xvFdWwFc5hRlepAwGRpxO5+XNdT/LzG//kkoaPE3pRnW+lp0mXF3A/qroB5uuJFWDuBkvNbrIC9OjaRfDpd00lkS1T5fUhgcqnesltHwVg8Zxf4gaxp+xWObdnnHw/LFO7BmwOxKCwF0U6i6+rebvC9TwfdtUbRgfM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772544897;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=O5BnANHniVBkouWXMg6uHnPbS6r0jFEHZBT6RkZN0e8=; 
 b=iqgU+M4jZts46d18xs+TJQ/mnrfhDqVHRDVsyUAbfRZRTdY/hu5+0lk8haJjNevvGqXRI9loG+i3RlHXaAIdFlVDPGR2qhFZR97uo4f05izEwKjcEhPhyWbUm5f87Sw7yuaTw+gwvs/VUN4/0TnW1JdtEAs7adTynhu0OL2O/R4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
 dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772544897; 
 s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=O5BnANHniVBkouWXMg6uHnPbS6r0jFEHZBT6RkZN0e8=;
 b=LLDUAJOQRVfRLnfWSkuqz+W1oL6PRGmcjcEou0B/+fPYvLlHToJFpZMpgBPs4LG0
 LvdPP+Zc1SotdEVaVCGQRswFDV0YkA7rW/pKP98fagBJHJ9UiaxaAiL25USnd7PKYdr
 4Mp705txarm24cYf0k2x5MZ5vUI0raqYba/vgX/I=
Received: by mx.zohomail.com with SMTPS id 1772544896040604.5474678436175;
 Tue, 3 Mar 2026 05:34:56 -0800 (PST)
Message-ID: <acfce263-4129-4ab7-a605-52df9123ac91@collabora.com>
Date: Tue, 3 Mar 2026 10:34:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] iopoll: Fix read_poll_timeout macro documentation
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
References: <20260303062503.3392544-2-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20260303062503.3392544-2-ronan.dalton@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 03 Mar 2026 15:04:49 +0100
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

Hi Ronan,

On 3/3/26 3:25 AM, Ronan Dalton wrote:
> The read_poll_timeout macro has some incorrect documentation. @addr is
> referred to but that is now replaced with @args.
> 
> Update the macro documentation to make it more similar to the equivalent
> Linux documentation, which doesn't have this issue.

Reviewed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Thanks!

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718

