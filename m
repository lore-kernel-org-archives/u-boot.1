Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87B3EC1454
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 14:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E637483F7D;
	Tue,  3 Mar 2026 15:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="TT7Eh4/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F7D883F69; Tue,  3 Mar 2026 14:38:32 +0100 (CET)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1304C83E7F
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ariel.dalessandro@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1772545107; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SOnsT5elbIjh4UbXn4DKtnDqDVEQFhxjgpPv04rUW7nNRM2KlsfTPlQTJRHjEKa4WCLo0oeuNAPHBH4MHyGoPOIG9wnK6eaZfE0M1R0McTWQ6ug7Q955yloM0lL8i7zYhY7mg8LUTXhUm+aPTtVZMQzKmjHJRgXCUm+TvEAUyCc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772545107;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fVcCKyetMoIXetz/Wz7Kh76cV//VBuxiDxO5vJrtgBA=; 
 b=hjshRxgKl7KD3ZEaD7XYqdYhed04HQ4mxC0UiE3DYqeJ4FFl1cNxixCoNR3+nhdkaMLK5t8swR7J3qmSu65EZUt/aju77DAWtpwlrrcnpNpQnavuVp5e31jShQEYFmkDIV8Cvjt9GSpBJY0NHwqxUGSmzw3HP+1FkIyC/D/XJdg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
 dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772545107; 
 s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=fVcCKyetMoIXetz/Wz7Kh76cV//VBuxiDxO5vJrtgBA=;
 b=TT7Eh4/Ai2V3fOXXEgWCf3i76omAPGuapQSgVTKMOfqSNfDtbZm+OtwDZAvbvebk
 xkBmZg1p+INDGPSL2P5w0jX8OLnFMrGNQ2o1MfIPzEX6TVz6w1dNnEnts7gisS8LNvR
 jrQdGFYSWImHpb/E59XGV4JEG5wXOYymmGvkOXCI=
Received: by mx.zohomail.com with SMTPS id 17725451044931009.4169641272579;
 Tue, 3 Mar 2026 05:38:24 -0800 (PST)
Message-ID: <d29b8c13-4eba-49b9-bd4e-5fb78043c975@collabora.com>
Date: Tue, 3 Mar 2026 10:38:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] iopoll: Improve handling of timeout_us param in
 read_poll_timeout macro
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
References: <20260303062503.3392544-2-ronan.dalton@alliedtelesis.co.nz>
 <20260303062503.3392544-4-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20260303062503.3392544-4-ronan.dalton@alliedtelesis.co.nz>
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

Ronan,

On 3/3/26 3:25 AM, Ronan Dalton wrote:
> The read_poll_timeout macro definition is missing parenthesis around the
> usages of timeout_us. Also, the local timeout variable should be named
> __timeout to distinguish it from any variable named timeout in the
> surrounding scope.
> 
> Wrap the timeout_us parameter in brackets and rename timeout to
> __timeout to follow macro definition best-practices.
> 
> This change brings the macro definition more in line with what Linux
> does.

Reviewed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Thanks for the detailed description!

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718

