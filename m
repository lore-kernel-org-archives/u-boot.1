Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66167606A32D
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rC1B6Ucx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=C9DBiw4v
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EA588169F;
	Thu, 12 Nov 2026 11:00:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mIyeJ_NZrp0k; Thu, 12 Nov 2026 11:00:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3390F81681
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794481212;
	b=iaq0MRepWBsiAv4ODCHmUsDubiTAyP2HQ4NLu1KI/HzeHTrispUEjCqchWrSzZpzpuF/
	 J3kgWxBf7RjS3k7BKHaZW35lVQsuTUr/lC/gaUxA9wXkOi3hgBgII9RyfAdbNZIvsSu4h
	 SSeU3oT8GCk85nRmPz8P84NqDP++gn9m9cWWy2jN7QYiALToSPLHp93nintZ7etBeFkXP
	 qCJSbMW3/zbLtSmjSr1UvuK6xxd61yFhzWKXLVzNCbReUhkpy5FIlRXu74yUayJSXlK3w
	 ys1jFWDGb53puvHih1OWK+j2AU2J4cQG0HdjN88iDVOVnA1jae2NE39ai2Nw4Tk9sBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794481212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cl04lREpCg9Q4Eb0weDufwctXpFTYgHYIqBp3J/xSk4=;
	b=Z36KTWazpZ3J0+Vj8uKY2C1UcfawETobmkdeUOfngGPt/ZGDuHyRJVTWC7sA5BBBfGV8
	 MhM+rt1+3E0LCbeU9jbIaLkdxp9LzznxEK13WM047wBn/L/l3/KsKfqRKUMGsM24BQsrh
	 1s0a+0mRFAGv6UQNc/KzWe8W5a5RjpLUNJztb/fkEebwAmdaKyE4Yc27z0+F9yHhvIINI
	 3xW9XR2gQG23NiFQOcCIXWZz++ljU5N9KnW1LrD50eB4DqHe/5scyWvUUmTut7n0QaKEK
	 4+BzoK7x7MbCEMOfubJOlq7qguhNC8kILD0DAAFfjThv/rJKb7hiueZLjn/H+v/4T6Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794481212;
	bh=cl04lREpCg9Q4Eb0weDufwctXpFTYgHYIqBp3J/xSk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rC1B6Ucx7hjXVY9+Xn4ZjiA6LxY/7WYh1vpp/OEHKXrG8zPNm98FtPlskkgLssUv9
	 ZBBM5ov4HfAAVubA/d/Thi5tu19UKd5d/rS3hhCsdDXkgRg6cxqdEMsmu4gaZZ/kA1
	 EIYerF0BT/2YKzgWIDG9dJNXKETBWsFSw2Xn3S331zfwcfRXFVc7YM1I9Cx9hODMFR
	 0ApqmGxfaTPAMc2nF1d6ap4XGYh6nx5F6ES6N+BCi7RbONW9gj90SUJgaTZ4zWj9yS
	 fhDLYrBbpn3WBbBMaTigI8vU1PYbYF9uZkhP6UGCy3I9WdrQN7v/qvxH3xb2xJoovB
	 ikv6qrrOg0hdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3390F81681;
	Thu, 12 Nov 2026 11:00:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3FA228C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C168340086
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6YwcCCVFuhHU for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:00:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 596F440042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=C9DBiw4v
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 596F440042
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:00:08 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=C9DBiw4vmAkMN5LPAccJgsMtVv6dh/GFCNgCWYBEcbhc1B/zsWMdmiWdPDAIqDAs8AKRbkdSFTnjk8L6sKUjrUWTf9v0/1Pcr+vOB896qxduI8UlZH5B7YhDg/PM92UKhBQApFaSs8AtQhzFK7iYSs3wWa5m2qUXTe0T6qguLhc=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=cl04lREpCg9Q4Eb0weDufwctXpFTYgHYIqBp3J/xSk4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794481194525901.452378707867;
 Thu, 12 Nov 2026 02:59:54 -0800 (PST)
Date: Thu, 12 Nov 2026 10:59:50 +0000
From: Yao Zi <me@ziyao.cc>
To: Martin Husemann <martin@NetBSD.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: Re: RiscV SBI incompatibilities?
Message-ID: <avWcJkgU6xFCZS0Q@pie>
References: <avR9RCMQHL8TZIAR@big-apple.aprisoft.de>
 <avSOoJFxsR6hDuUd@pie>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avSOoJFxsR6hDuUd@pie>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.473.96
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 03:49:52PM +0000, Yao Zi wrote:
> On Wed, Nov 11, 2026 at 03:35:48PM +0100, Martin Husemann wrote:
> > Hi folks,
> > 
> > maybe I tried something stupid, but it felt like a good idea at first.
> > 
> > I am updating my VisionFive 2 board from an oldish installation with
> > U-Boot 2024.10.
> > 
> > To have as few moving parts as possible, I build 2026.10 with the same SBI
> > that I had lying around from the original 2024.10 build, which happend
> > to be OpenSBI 1.4.
> > 
> > This failed spectacularily: most sbc_* calls for HSM fail with 
> > -3 (SBI_ERR_INVALID_PARAM).
> > 
> > A few calls worked, like sbi_hart_start() and sbi_hart_get_status(),
> > which told me the hartids I was using were valid, but then doing
> > e.g. sbi_send_ipi() or sbi_remote_sfence_vma() failed.
> > 
> > Does this ring a bell? Is it expected? Did I overlook a "minimal SBI version
> > 1.X" somewhere?
> 
> doc/board/starfive/jh7110_common.rst says,
> 
> > 3.  U-Boot for JH-7110 requires OpenSBI v1.5+ generic platform object
> >     fw_dynamic.bin to be included in the Flattened Image Tree blob. OpenSBI may
> >     first be built as below:
> 
> I had a brief look through the changes from v1.4 to v1.5, and suspect it
> has something to do with OpenSBI commit c5be0e1ed1fa ("lib: utils/ipi:
> Skip initialize ipi when dt is not enabled")[1], but don't confirm it :)

Totally unnecessary, just out of curiosity, could you please send a list
of failed sbi calls and their corresponding error codes? From this I
could probably find out whether it's related to the OpenSBI commit :)

Feel free to ignore this message if you don't want to :)

> > Martin
> 
> -- 
> Thanks,
> Yao Zi
> 
> Meow-mrrp-mrow, I'm a cat.
> 
> [1]: https://github.com/riscv-software-src/opensbi/commit/c5be0e1ed1fa17b9f9abb49e80db014e067523e4

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
