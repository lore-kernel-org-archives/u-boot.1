Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B7C606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=inTP7L6T;
	dkim=pass (1024-bit key, unprotected) header.d=netbsd.org header.i=@netbsd.org header.a=rsa-sha256 header.s=20240131 header.b=L4sbdrHp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9D1A816DD;
	Thu, 12 Nov 2026 11:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0y9c-_H3CG9t; Thu, 12 Nov 2026 11:09:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 271498168D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794481787;
	b=CYXP3KvMj1SM6h44QaVNO6BqgfBBQu+bbUkTZIzBrVTWDQdESeJQ+T1lnB+tJvCkDkZo
	 +vLLUvElbJLe93gZvHjRBi8Dh/dvYnYj22jDsZn7517ELti5+zQzaTwbWUNM+KB+6Py1R
	 3QPAX/OytQju/D/XRpMd3089HmQj7btzhlMVOwmhZr6GJdsJ0K77NxA97EkmyO2welmCJ
	 OM6ZTBhsDyzj8lJvHVt2eGcMuiV9b3xMfO16IWEUsLUSdtWh/rXkXrp9Nj1pr2krCJKi5
	 pnrYy2BHXYDNP/eQKEeiBheFLTBnzXv7D0ASWhbk/lr0eiNiBXr2N+N1ich0MHuGqmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794481787;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0iD+7HeF4R8uRgC0AtzeIMzgjzTsf2aMtvwYWXr88z4=;
	b=fzT6r7yUz4yDCiKhNNAwQbBjpBAzmx9BTAg+NPxYMzTfPXYDIfu1n8z49LcGmYt8zCZ4
	 z24kAjX32vUp33Xsq9YSkti8mXDahjaIsBOZreWaAYdqIav2WWFpOAb1JHIgAQWN6Pu4z
	 6M/4pG9EGf0JshSVWKWDAluhAANLAfuXvDCT8uEc+pJkzLjb/Aa+WRoT49s50QFd/ra43
	 3Ygvmz6JF51w7r8ELgsRslWJwKIRMQvrNyIeRncEHtEhvXrjLFBeZlUFo/7WrUFTzli9R
	 SR/EavKNzBzMEZ5HxGHWya0Yi2hs6ZmK/7/poQFz5Pmk4A7CQJXliHlts8ene3Y1czQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794481787;
	bh=0iD+7HeF4R8uRgC0AtzeIMzgjzTsf2aMtvwYWXr88z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=inTP7L6TdnN4VOFdwjKpnAix3B0RXQZHtrcYQ+yhCWfQj5wgII80GmRNgYtapc7UB
	 KIwYbZ0FyoQoSrRO0AI2UAOe93fgODj0SSparGrqhEaj32SYzjU/YggeDZi05iesVv
	 DEEd30RguFG6rp73PTdJQpel7nTK6Q10rTDyEaVq/FO3/f1OaIoHmN0QG6MJF4Kaxk
	 ia0588tHHlJeWvXGb2YyOTKHmLQwj/yNyKfB7ltMcsAVN/WkG827HHZkrW1GJFkk4Q
	 Z2LWYBwXW7IufdK8NVo3Pg80X7UdaRWeD2dzSOucK9RqKyvluGexQ6z+bQHBNsznrY
	 kRBe6RipawcIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 271498168D;
	Thu, 12 Nov 2026 11:09:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 123412E5
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03EF14016D
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCJiPh8ygM0b for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:09:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 34AE440042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:470:a085:999::25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:470:a085:999::25; helo=mail.netbsd.org;
 envelope-from=martin@netbsd.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=NetBSD.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=netbsd.org header.i=@netbsd.org header.a=rsa-sha256
 header.s=20240131 header.b=L4sbdrHp
Received: from mail.netbsd.org (mail.NetBSD.org [IPv6:2001:470:a085:999::25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34AE440042
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:09:41 +0000 (UTC)
Received: by mail.netbsd.org (Postfix, from userid 1214)
 id EAE7984D39; Thu, 12 Nov 2026 11:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netbsd.org;
 s=20240131; t=1794481779;
 bh=0iD+7HeF4R8uRgC0AtzeIMzgjzTsf2aMtvwYWXr88z4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=L4sbdrHpHmzpFaEf1emBTFoiuVY5vEjguSltLTMWW9KdXRfOpbTF++I/tOmwB6x1+
 VKozKZPeBTFAuK5pdOMC+odSCyXUBkn/IlkqFGpYVm/aa+IvJp/hXWX8C0ZUM1l1JB
 eL2r+9NbqfQp9ZkzwbUSCM/gEc8KB07p74R4sWkc=
Date: Thu, 12 Nov 2026 12:09:36 +0100
From: Martin Husemann <martin@NetBSD.org>
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: RiscV SBI incompatibilities?
Message-ID: <avWecN7K-dDtccPN@big-apple.aprisoft.de>
References: <avR9RCMQHL8TZIAR@big-apple.aprisoft.de> <avSOoJFxsR6hDuUd@pie>
 <avWcJkgU6xFCZS0Q@pie>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avWcJkgU6xFCZS0Q@pie>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 10:59:50AM +0000, Yao Zi wrote:
> Totally unnecessary, just out of curiosity, could you please send a list
> of failed sbi calls and their corresponding error codes? From this I
> could probably find out whether it's related to the OpenSBI commit :)

I didn't create a full list, but verified two that did fail:

sbi_send_ipi()
sbi_remote_sfence_vma()


Unrelated:
I still have a strange problem (identical in 2024.10 and 2026.10) that
sometimes the NVMe is not readable after reboot; I initially thought it
would be related to a USB storage device being present, but it seems to
be mostly random. Maybe the USB device enhances the chance for failure,
wich might point at a power supply problem - I should replace the cable.

Martin
