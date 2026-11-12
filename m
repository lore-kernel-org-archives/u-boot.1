Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FC606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oyhQld5+;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=UkfwPqrs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51E8040AC0;
	Thu, 12 Nov 2026 11:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4lU6FwJsvFhT; Thu, 12 Nov 2026 11:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C9E240B4C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794483493;
	b=Ryybcy+d9mNkHzHro1a563EP5NWAtHsT2wh95hO1+RaxmIoAp3tWICERs7z+Zgtud0mP
	 jzWVw8KKHmEzGca/P9Fp0vPBLY1hk0/053e07O2MpFizr9d1CzX4qTgabQJ84wPyWuZma
	 43Gu8XtfUo12SF2bzoID85jo/EbjHEDhe3UN5eGsZb+gEsnvC0RlrQb20gSoXzqBdcJQb
	 LZvzWrG2UKozw7d8UpZ0qNowLui1QdDFDxfy+zoKMQN3CZxnrM/A1UZ+M2X5OkpqL52EK
	 TsnuEYnJattCPNArwKqWt8tle76m4BQw3c+nkAwMHkQec0kt17kLzybp/ObjgdpmQ6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794483493;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FrIOq3frB0+7WYp9MXHve8kNHkkz4XzVkW+9MdiGiWg=;
	b=SS5cexljbpP5Or6SpwdUTVhLAi+NCGloC9LVDL3zJUy0GVwn5ScLqEgOUXt2HId97WZu
	 W7Rl1ctRP2nVdeTmf4i0SIcElN7ihgdLiTfVhSKFdzZFjv+QYQZ80q5U5UjBmL816pmYf
	 TIv3P3PNq6fq0lNrCg3gXjfmU7XJAgKp93ce9+/pI1KVW84cLDlvJ+9prK2/XcYxb0Tdx
	 QBYmZee4gHT9o04QVpSBQ6dscvdhZRQabH6OJ2TS+Ni/uYE6Ot4iJH5PYqlhqBVx2x425
	 nyYhnoPxLV2G/5m/El15lFdJCIKAFpFPcJjAS8qFFAwIuqRTS0HPIZdMWqPgwO2UuXw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794483493;
	bh=FrIOq3frB0+7WYp9MXHve8kNHkkz4XzVkW+9MdiGiWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oyhQld5+ZJoVDFp7rrkhlI24I7YMCZBXaWXNIMo4r5NlxT2Ii6wrXOEuohfm4qhOY
	 uvIru5Bi8pveq4fS9udyFr3FRNQRoO3I8cF3pmjOJr9d0MfNtOhw/86au87LYrdKha
	 1rksGrNOvSgWfmY/SNwn/PiEnVqyy6Tgjizw4m4Bk+Xj1e3nAc+TiTpXsklDPRXBol
	 tIKKDK+GQzzRiX0gPUNS7gMGajzdw5oy0Fsi6N+PmUEHpz5HkkIufEmJLqsmUV+WQc
	 uYGuky8ikRcBMcAb3MyC/GstxTxuhM+MUn928JHp9ImLYVRIFLrRSwqzgb6m+XGz0e
	 4xJquxbuTIF9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C9E240B4C;
	Thu, 12 Nov 2026 11:38:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C5A8128C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:38:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B72DA607FF
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:38:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2UYvhsYQ98QI for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:38:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7496660784
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
X-Greylist: delayed 367 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 12 Nov 2026 11:38:11 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=UkfwPqrs
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=lukma@nabladev.com; receiver=<UNKNOWN> 
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7496660784
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:38:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7D1C51001EA; Thu, 12 Nov 2026 12:31:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794483116;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=FrIOq3frB0+7WYp9MXHve8kNHkkz4XzVkW+9MdiGiWg=;
 b=UkfwPqrshKX9PfoFEgGbTWEDWnSvrf+aP0VW91qka2q4O8NfbnESV6g/35jhX6DsjJ6RRy
 SmVl0nsQA5yyrEeSoRHhquVZn6xR81VbTT4oA84OfDghO2BP82MBvEkI9ohBBNQWAL6PVb
 bv37q3tlcZu+4E/vFzlPnJ9GqfUXVPKogj0291i6k5aUp8YKlIU1JFHIhvTEcWE4nDEFJs
 9KXvhMc0mDeCsms6E9AzJL/9s27O/fYfI8Qzc+gBt/R5OVvIzq8uWH/aR+U/iC8YIaWsak
 QZgLSpVDgOXA1miHPVIV3GpOgOJReabqNgtG6srGjEwiGTbnPlK7jjgFKIEYzA==
Date: Thu, 12 Nov 2026 12:31:54 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Tom Rini <trini@konsulko.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: Enabling LTO for the imx28 platforms?
Message-ID: <20261112123154.19bc3a46@wsk>
In-Reply-To: <20261111184700.GA554944@bill-the-cat>
References: <20261111184700.GA554944@bill-the-cat>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

> Hey,
> 
> Can you please test and then enable support for LTO on these
> platforms? They're very close to their binary size limit and while I
> have been pushing for people to look to reduce the size of new
> features when added, and tripping the limit here, I'm now looking at
> https://lore.kernel.org/r/20261027-spi-probe-speed-v3-1-33e056720925@iav.lv
> being a fix that pushes them over-limit. Thanks!
> 

I will look on that in the following days.

And indeed - for imx28 the binary (especially SPL) size is critical.
When exceeded, due to ROM code design, the boot is broken and board
gets bricked.

-- 
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Managing Director : Stefano Babic
