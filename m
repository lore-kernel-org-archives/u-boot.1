Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD3E606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 04:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EFQgmEGE;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ckR6kzvE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A13074050A;
	Tue,  3 Nov 2026 04:39:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1oIR2XCoER-j; Tue,  3 Nov 2026 04:39:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F105E4052D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793680758;
	b=WQOOOUpzhP59Oy/c8sv51yfzXfOdcATc1li9atbwmm03l8tUMJ4gAOcMvhNHqxov8dEh
	 YhTMCu+TgLqCHyrOXlwGLrmYkBGBhxp4i5JwVDh7RybY18ItKRE2qk15qD/bKYkbLv3m5
	 v5sGj+xE6nl2iD5a9Sc0jq47XF7ur0/Qqvq4I9WKPZBJ+grnHSIBtIMwuBZ/8Ov5wsJqD
	 NPwyhQ7HjdPX4eyRn893a5fpTMkeWD78rgHpYqiyf6lcdP16mfCzxVqT8buhcAVnR4zqs
	 i21huTwL0WW/rerT9G6bNdLv2+NacwFFz0bOxRr6O8OOPFJeKBQ86A+6WSXugPb9sxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793680758;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2q5yVBVn58RaOghVQ4+jm58hpMTkLKiwx/va0WC+8f0=;
	b=QBNJRhPrp4NH1YcLZU11pIphtIB7NkYQoFO+A7YERu7ieNz2we0ZHJHrRX7fTwP6WG35
	 UIkhBsaXA34A/reqkOzxLMM8k0jjTN3NsNNQQVEIHGcKqu0HfchduwTyxQ1jZ4UfcM+GO
	 7VxD51Ig+0eU+2o4TDomcaeBPeGNTnI0KvKJaj3nbNVE23MVJqijI1vP3CKl+lbjjRm+D
	 HZpxPp7Zw3d2rJFMOwR6yA8m6J4pzElMWnQDe4U2bCM2MY95WEBETfXaJIo+7kuKHnOC9
	 LPKLukqVuuW2U6sWElqQM1UCQzRJ7ob+wK+OgvMrgEs36iobNhWObmrUNjJJPD/tgGw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793680758;
	bh=2q5yVBVn58RaOghVQ4+jm58hpMTkLKiwx/va0WC+8f0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EFQgmEGEHnGaRK5rI62R62+OzMYNwNNLBHhi8c/UXWjP3OkpAV1YUkpFoILST154v
	 nBdS9XRdTgvCHAokPHtLwFe9Vjvlo0RPaSq/4hgvk0oQ4zAJ5eIGhi09/K/TFgKaPQ
	 IfgsDJgzYd17jsFQinaPV1abjRb2c/aTzUPNpw3/L66lQzvc/++6jZcYp0MTDJUL6l
	 8xVQJfeNA81iLkAYCbLfONEw4CAdxo7Ezx+INnt2oAt6nz7rX0iMdnlbNSr922EjN9
	 uXzTsx1t89wMJ+NhQKPK2BizeNz0Cwo3xX00ddSZm67SzxzfhwJSHZ+7TCBAuEz741
	 QW0Y0uR7X8wag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F105E4052D;
	Tue,  3 Nov 2026 04:39:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 846644BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 04:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A6D8400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 04:39:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qdF6geQra97x for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 04:39:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9927840249
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793680756;
 b=KbnwTktQGuzfLEKi8fzkPD3R7Ng7f79zti6BwWrGNP3DnkPZcPYRjxEbqJxBVct9gHE3
 KlirNKYk20g3OqoQ5F3DCMQKnCwChOexwLfC1qKK9Iah1c19ThFMTjBjsxxqEYAa8K8Sc
 nlsqRE3moTM8Bork5/K9JzBQCJ/wgbMe3SWgn467UFEjiIYbPj98Qsd3tRIVLGemruVQd
 PybW18kev/PTVq1CSwDRJMITGy9+pc1ZSBjytCHr729zvKuPf7mhZU5CG69wTpLzJcXGx
 Yu3oh8BHgxoQtW84dcXbemz2jltKEPv8G2AQYxpU8qELU4Zxb08ZVY7PBye5FBBmgzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793680756;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
 X-Virus-Scanned:X-Virus-Status;
 bh=2q5yVBVn58RaOghVQ4+jm58hpMTkLKiwx/va0WC+8f0=;
 b=qZcBSsfA5kBi9v3IIHnbIkhqG6n7bx76KGB9iMy43++0nWSKPo8drkzg8MqQQeQif1NM
 KwEFaDkGf1HkPAWs/ZtpEORxc7bM/P1NrGi1VGYDmUTF6vUlUfLtJ2eR+HAkuqByhWk/4
 x2hdH5khLE9R0LYt6nBMOQHLPUaNFMCog4lnuO57/Hi/7v7TXkLdD4Q4zS/GfdVlKDmXN
 PHzZm2Bd7dp5nfN00nbW7MMAQyFnu/7l4X2gU2NSr7jJe/axpOFYrSFn3DIc1+6evmP6S
 RYJCZSUe9KU56PkJn338sKX8n+RgDuwI5j8IZ0WvCYvJYlFBMBQVGo5QPm+IHu/eXQA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 spf=fail smtp.mailfrom=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ckR6kzvE; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ckR6kzvE
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9927840249
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 04:39:15 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC60483E76; Tue,  3 Nov 2026 05:39:10 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 606B583108
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 05:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 43A2E109A05; Tue, 03 Nov 2026 05:38:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793680738;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=2q5yVBVn58RaOghVQ4+jm58hpMTkLKiwx/va0WC+8f0=;
 b=ckR6kzvEreASZt3GjdlgZpD9IziBM83wcINAICh445m0SX7dCKnyHyAKA8luQ9wzHJXm5h
 4v1Yod7l1/aNoVDn7N9Hpn38Uq8QxDZ9URnysqkMcQMzDM/ox/bVGOtyrGX+CJnks/PQWX
 ATtkZLPXnrs7VuELGH0CUp7+5oXKrIsjw5rea8i5b6CQxXGu0zraprYr9pi22ppRlhXPjV
 ZwY5oqSB99XWoutb/yLIA4VCw9ru5cVmfAPRLp/wO8xXZokc7LXsV+EIclGvh0SJ2lv0ep
 bdGtcFzoWm9DtUDGoQRLkJChHmuAZd5eUnxz+AKUvjKJuzJq+1yk1xAdlsZwNQ==
Message-ID: <c28b0507-8bdc-e8ee-f4dc-e744cc7eced2@nabladev.com>
Date: Tue, 3 Nov 2026 05:38:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/2] i3c: harden device index and detach handling
Content-Language: en-US
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Tom Rini
 <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>
References: <20261103021743.27111-1-alif.zakuan.yuslaimi@altera.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20261103021743.27111-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_FAIL,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Alif,

could you please resend this seris to new u-boot mailinglist:

U-Boot Mailing List <u-boot@lists.u-boot-project.org>

and drop the old denx one, Thanks!

bye,
Heiko

On 03.11.26 03:17, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> 
> The DesignWare I3C master indexes master->i3cdev[] for transfers and
> listing without checking for an out-of-range or empty slot. A bad
> device number or a detached DAT entry can therefore NULL-dereference.
> 
> This series rejects invalid indices on read/write, clears the i3cdev[]
> slot on detach (leaving num_i3cdevs unchanged), and skips NULL slots
> when the i3c command lists devices. Also drop unused includes from
> cmd/i3c.c.
> 
> Alif Zakuan Yuslaimi (2):
>    i3c: dw: validate device index and clear slot on detach
>    cmd: i3c: drop unused includes and skip empty device slots
> 
>   cmd/i3c.c                          | 18 +++++++-----------
>   drivers/i3c/master/dw-i3c-master.c | 15 +++++++++++++--
>   2 files changed, 20 insertions(+), 13 deletions(-)
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
