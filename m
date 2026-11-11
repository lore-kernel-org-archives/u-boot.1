Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FC606A327
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kjm8O2o3;
	dkim=pass (1024-bit key, unprotected) header.d=netbsd.org header.i=@netbsd.org header.a=rsa-sha256 header.s=20240131 header.b=oI5S/MnK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0DA860B0C;
	Wed, 11 Nov 2026 14:45:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x0tetzv1msCy; Wed, 11 Nov 2026 14:45:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 66CA2607B2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794408356;
	b=Yiwfyz8aTWDRilaTBgynSPMkowF/OSL+2gnZblGOSxxJ94IlYh+2uRR1mAUbj9DEK3s7
	 OKQhOaPiDy29FYQwvW3wn5wFMkezl50qs+pVoFSV9IX3B4RsxEo2j+ZUXt64gQzEamvX8
	 RudB/q5kTKEFaHQe8K5IrDnhGXLefaI150ThzzRmrnsYNIa3JZtij7MaM142PlEKENOf+
	 2IrhpAouqwQlfmYLeuOMnbLkF5leWKkvRrv40P5EHAuPrHAeSS3H7v+Q/kYXrS2eW0s9s
	 iQ0p8eUJO3zsSDHgUBy78XRP/6aN/75DLLdkfI7Tv/nUnfS78LPY4368Wtq0Fvhn5tA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794408356;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4flN0KEJqXkEWUXKe1wrUI57I6oDaXAmqDBW/K3TW9s=;
	b=mia/BllRHRDOYMpnNDZTdXvFfzUqx0tlnBNQVm0HuFNBbqDPxEi1A9WcxNhOkYKuls2k
	 0raorI+HG8rTrQ7LOx89AsoENyr4qQUIGVcn6JlvOjIMkc1KYLUn/9gzp50qEIEEV/V0/
	 AlddEC7P2NCFwt9Ox7YLuoX1OtBEiKbwRL7H9EXtR9jp3OD0Bn+SdRG8vUYSLBvmYRYUo
	 +BMZha2/o4q1uo19wuQp2kSY3Mp7yCKyYbx0DbYXBDs1u7tedSovNvpTGs+OXk1yI7yzm
	 jCNza9tnJhv7i58HjOCjDg2TNR4TvN8j+aQkyKtA/LrImurJWQBZanbyYMZZZZW4koQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794408356;
	bh=4flN0KEJqXkEWUXKe1wrUI57I6oDaXAmqDBW/K3TW9s=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Kjm8O2o3kfzb5pqOVo7x8Bn/N/9MrW8PepSHQDBI/5LAJ3f8rvFY3aqvU6Ujhma7X
	 FtQFCo25O3s39NOzrJdb/ZWjQenNmpZpF+rhWDBfQ/YGioNbhD1i/d4eNSedOGmwfI
	 uw4AvTLAWTFQgCIsBFFxeeFZ+bstOq7guhB0mRXjI8XSb4C1RqiUOQTus9kUlsDhWY
	 hnwNm98kf1AfMVPabtEohrUGXuCxzhwR+2wjNIc945KguN1jahIrSjxN/qS89wmf1r
	 6aMQW7l+k+BOX6XfLSZ0TCX6bMEsBUNfFV/3bpszVzmmsyiMvLCuTu+U27MbIo86Qh
	 NOtLx491yM/9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66CA2607B2;
	Wed, 11 Nov 2026 14:45:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC437E09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A23214096C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k7IUQuxYQ6ld for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:45:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4093D40967
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=199.233.217.200
X-Greylist: delayed 600 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 11 Nov 2026 14:45:53 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=NetBSD.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=netbsd.org header.i=@netbsd.org header.a=rsa-sha256
 header.s=20240131 header.b=oI5S/MnK
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=199.233.217.200;
 helo=mail.netbsd.org; envelope-from=martin@netbsd.org; receiver=<UNKNOWN> 
Received: from mail.netbsd.org (mail.netbsd.org [199.233.217.200])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4093D40967
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:45:52 +0000 (UTC)
Received: by mail.netbsd.org (Postfix, from userid 1214)
 id C552084EC5; Wed, 11 Nov 2026 14:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netbsd.org;
 s=20240131; t=1794407751;
 bh=4flN0KEJqXkEWUXKe1wrUI57I6oDaXAmqDBW/K3TW9s=;
 h=Date:From:To:Subject;
 b=oI5S/MnKrsCZmkJcCIGus7LNMUVG6+G6HAIUoInv2ZoyjbZauBOxnhlm2NAxp2qYL
 a1ZbeHxnpxoWATK5IvRz0hwQLEdoYg3KTieTZQ93ZGN36mBN8/+QWb4k/dGX7HgU2A
 M5bA7EsEppc3VTFTUn+y5CPTOXhgWHh61kkhpRGY=
Date: Wed, 11 Nov 2026 15:35:48 +0100
From: Martin Husemann <martin@NetBSD.org>
To: u-boot@lists.u-boot-project.org
Subject: RiscV SBI incompatibilities?
Message-ID: <avR9RCMQHL8TZIAR@big-apple.aprisoft.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi folks,

maybe I tried something stupid, but it felt like a good idea at first.

I am updating my VisionFive 2 board from an oldish installation with
U-Boot 2024.10.

To have as few moving parts as possible, I build 2026.10 with the same SBI
that I had lying around from the original 2024.10 build, which happend
to be OpenSBI 1.4.

This failed spectacularily: most sbc_* calls for HSM fail with 
-3 (SBI_ERR_INVALID_PARAM).

A few calls worked, like sbi_hart_start() and sbi_hart_get_status(),
which told me the hartids I was using were valid, but then doing
e.g. sbi_send_ipi() or sbi_remote_sfence_vma() failed.

Does this ring a bell? Is it expected? Did I overlook a "minimal SBI version
1.X" somewhere?

Martin
