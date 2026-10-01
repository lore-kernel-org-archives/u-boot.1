Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B13DCA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 06:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E95CA81183;
	Fri,  2 Oct 2026 06:39:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z8C6PxQmyeg0; Fri,  2 Oct 2026 06:39:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4B0388113D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790923176;
	b=WpJicUk7Ek6nZJJGKJU0+c7PvM3FW8m/G5pyJqDLOhKKZRUyb2fQdvgNJqvxmF/oQVO1
	 00/nPtszVhjSJ4/iHVXOjiYeL3UR75y2pgzd6blaHk7SIsjQlKR4ubtd82YfSkxzHql+6
	 3P2qf+E9ktA7jCZQ6GhR11GZK6mrh8AG+ao4h8fRRbVpVDiqkGrrchQF7Z9gR5p+KG6zz
	 4nrFJl0YPRUhQjbVyGFjHrCk8odPs64B7xB9XXSxN3qK6FGCkPd0ki0ilcZ/RUzQnbl9/
	 LrNFr7PSulw7zOBKbfBrsXPnjuXbqPauOWacG0t68BnNbSe+xzevNHfv36SLN6aFcjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790923176;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XugmQ+bw1Kw83xNP5M9SNQZAHs0MPzCNWr3ljwdaquk=;
	b=r2lAwxsy+LDXnEK0D4DhSGEMufoUe8Yb0wApHmx+URqJPtobKxuhDvU78fA41l6CYdiD
	 cYKkrW+Xnj0MCyQYJqYa1woCBx+0Veyy+oHGJnlNHEIxDb6PYsyNHZMf6qR/ObMKfIKSB
	 0RfWlxanO/uVQ9LSftYwPdB83teLKyz2K2CaCtyA/l3kz3pdsiNeLS2gjHyipjeSyFvpE
	 OF1BzOwOZEDnbn25xxE2NbTqaGORqrfBZNuDTMLrpL3ZDKOO1m3kjtY8ZKJhEzaLZIXky
	 lq2Qr0lkNXnCrGcCV/xHGEU1y25ZGPOXkxbzeFouhAONZhHdM9vZScxZOnfE7F+vr+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790923176;
	bh=XugmQ+bw1Kw83xNP5M9SNQZAHs0MPzCNWr3ljwdaquk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hPxsuDGV+J31elgeSD/VLD8xH9u3B8YPg1Vht7QVgHCIpPnf+3ENqyf/l/1lJQNfh
	 9XP363+swX3Owu5MlnBmShTvhi/G0TFIcKzP63IvCIbCDPWcMuxft/eqTYRbea/FvX
	 6IyFGHGOHESYayiBPgkKXZFnpys3EReKdHs4fZAnnpwpYy8sq9oHiBOEr/4MX0+h4F
	 PWq/6XgAPrjBkucleYtn4tLr8SswYere/gblRqDU7EN9uCyyMQGjob2xg5KrRyfWX0
	 EsvY8eJdPAtwG4/ajx8dGyyE+OT90sly0v+AmuHP1gH+i4R/Ta8B5qYFdYeHJNl2/R
	 95xXhYaSlV6FQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B0388113D;
	Fri,  2 Oct 2026 06:39:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 392CF4D9F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 06:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36C0E40123
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 06:39:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h-7lEtFDFFvQ for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 06:39:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3EF8540057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790923174;
 b=Hv8jLZkuoRPnEB8STHxKgGYDht8D6JZwF0HlJbK0ZdqPSa+ajFJH/qncE3u0BYqOcMYR
 Nn5UoSKQa5njjFRmQkSqxWO5dD2/HjqCY1st+XO9Cq+mNdInWS808860CvPkmUbYDfMNU
 RgG9KIJAvHD8UcMWXlxujkklj5fZOLwCmp68mdGm4m66jILngWCcJACpgHPsmYhSNKWiB
 eY8CM9wygqaAfxAxvRE3Z/fpQSe0nsc0hkaEEc1hSxK8ixC8lruhkVZb5Sk+f5m3hROQE
 loYGJE9UC/ogAuPQT/LP0/VFSKcjtk82j0WMuRLeJ3LlDH/LjsHFGj8et6Wt7TZqBsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790923174;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:
 X-MBO-RS-META;
 bh=XugmQ+bw1Kw83xNP5M9SNQZAHs0MPzCNWr3ljwdaquk=;
 b=OzpxeTCSIwAwmvs3+enpMUD7HR8y2m3sXJShsO8nmWZMePFIYMyg9SJFvzQ91g744l9r
 BLIV9I1/PhYw4zx0n0HpK9e3cY05KI7dePXuTya32yifmaiLt3t61ouUh/2+uzqPsw27P
 hYU+zB03gKXTtaH7KF699xAlJQfTHBZoQuvBwSla1q3g+WCVS9sGIFrU4Rbb68yMo7Ky1
 hyY68Chw35hG4KiLKbuPvktAyxjIyxyLcdSmKEp2nfqBYP4vMPtZx8RuknIEoiH/0c72B
 fI6UIkBmWo97Wl4CaGhIi573rIimY4UCuswjx21+lZxj2PA3/TRzwbrxCdp4Z6s13Dg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=j0fSGKHs; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=vZDG1url; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=j0fSGKHs; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=vZDG1url
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3EF8540057
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 06:39:33 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hwzfB2Q8Nz8v2b;
 Fri, 02 Oct 2026 08:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790923170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XugmQ+bw1Kw83xNP5M9SNQZAHs0MPzCNWr3ljwdaquk=;
 b=j0fSGKHs7bBQ8iDY+/TPnyR/nouZUSE0mS1igMCY3DXxk/jZoTlalCET4FF6DMWQxpuT6J
 shBPm032y7Mv0zfNvXQlxokXitI7TWO5Nnn2zxWErho2zZj5ArtwbemaW1ewe2+BH8hpxE
 wojVUlNQ98OF6Yzp70JVdJWBN3l95q8XxvrXoVmInjt9ntxrZuXYboJKdXJBajoNFmK2Wf
 mrFQylOgUBSgUmjhKmyvYnWMFcAdME4OomafVyaMkb9BNpgckA48YhHzG1Yt92bj5Sxetx
 e6GJuzzLT5Ut7qdgeVbKerDfPejlLV6hGAq+1b41NM40zvtZKKteHmDqJqtsmQ==
Message-ID: <17bd0e9e-2ada-423a-99d7-4d32eafb8dc0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790923168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XugmQ+bw1Kw83xNP5M9SNQZAHs0MPzCNWr3ljwdaquk=;
 b=vZDG1urlNEXY0jrC9aMgoCtVt6ceCGgRbSKNglvteMc+JdtpzHfe7CJSkqxuZlggwout4w
 LEaUv7mDIBYafb1vNcYPtSGdS7r2QgYprh4Th/WmFp5iEzjHDjsw5xqBHK3SaHs7WjUmj0
 jxzP6RAcezsprmA60RjxiQBec6PMb1oN3bdbIA6Uwy/CeEmO3TjbiFJpY54tD31EW0O0B8
 hqx2Zrkxp/GBxWMIXRRvEgBUzAW4gUgcjfFz/+r59I9Lb0hRD8I35NLOCrCMX9eTDfN+aN
 Ga5jgtPrUqhzYEfhtp/lVkbabrrP5Kh4hDuaWVR1e6f5YuiX647N0wdzgvjrUg==
Date: Thu, 1 Oct 2026 23:43:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] usb: gadget: f_acm: do not gate TX on DTR
To: Qing Li <lqing2013@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <cover.1790887323.git.lqing2013@gmail.com>
 <e54e1ea64d7e9b57e9c4c9b134ac4a166f2ba287.1790887323.git.lqing2013@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <e54e1ea64d7e9b57e9c4c9b134ac4a166f2ba287.1790887323.git.lqing2013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: bd56d239a03d376645d
X-MBO-RS-META: y55cru3rb836kk1w5xsguyosip4m7fsf
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 10/1/26 10:44 PM, Qing Li wrote:
> The macOS AppleUSBCDC driver never sends the CDC
> SET_CONTROL_LINE_STATE request for this gadget, which made the U-Boot
> console input-only: __acm_tx() bailed out before queueing any data.
> 
> Drop the DTR check so the console also works on hosts that never
> assert DTR.
Is there a matching Linux kernel side fix ?

What impact does this have on Linux CDC ACM driver ?
