Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7F606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tsCCSbbf;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bGK75l45
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5CFC608DC;
	Sat,  7 Nov 2026 09:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 70ycKtTajwRH; Sat,  7 Nov 2026 09:02:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E36C56075E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042155;
	b=JyaX19j6uoaUwHfy4MhSicpUzTEo4ooAOYWWDj6zIuZZPoWaH64s6PsRVnZEkhkvfdKq
	 BugucVgZ9VkkH7gu65DMt8Bp5UXXubrzLhG7k7K1WznC18AltnwjRhgFzivylawjObs7C
	 w+MEek84p9qJVdnN/D3sNBW1V0Myb9rBIAzOEWYPa64ota7RwTugeSrcWSQqOjCTSEv/3
	 TlvF/71VcYQPGLViT664kYj1sMdQ188xHamdg5XtqIkokwEz20BYHGDGQ1jEAlDPXnsKS
	 +tolh24bN90LTNH5G+bki++uGkT5eaH47w3d5wBDUbbcVlP69avdUktI8aDzf7bvR5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042155;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SuPIIjOOoOvVKqyW75uC6g2WQPzPLwaNTs3ZP/i8JmY=;
	b=OFZQ8w+fRBMFQNpTtm+z2XZfn2yUW3ZYrryaFgmFKaGlFdmysYyeFvzZn1syDJtxBWkC
	 m52gN/CAOzELw9Rp952kVDQGg3kgHUFX0RLndKkCGLYljxFzB2v8AmnJHpz3JInr1/Yxd
	 NWnYec0huaWrS23NEfv9wpBEJrs4k0CExkGDLdDHE5J+djjYrQFTYCuNtDTzJUgouX1oG
	 8ufqUDZJUsF55ocjS2tV7fcIGZNTTGTFXjPr3LAYQWOqOaIjX7aIv0FoJzdaQSg3xM+UT
	 /LfOZjA0K/qrodTK87qULVYnB/JmldIjGWgPKkf0gCdYXgewsAmqHJMEhwb01MGGqYA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bGK75l45;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042155;
	bh=SuPIIjOOoOvVKqyW75uC6g2WQPzPLwaNTs3ZP/i8JmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tsCCSbbfLsU2icVuU82ZTjzMhtxkU0UgnScqs3R9ESDbK2yozeAQ7O2kvCExl9+6Y
	 IHMxUZHB9gGkUYuayF+V1TJKcMJNJAvPkI60UX8nMKNRCH5NE2BiPFtf5kwE4g1PmV
	 qZp9+NJM+qpIEb4I/HIM2UYCpuIu0iYf+3kvfaR70etJpxpCB6WrhUi19IljCMiR4Y
	 PrTjgoV2wEUfqfsTejNbeCD+1q5tvQlTh+FgRWIc/Y+yHANZMQVyqfu3QvXDSPSMff
	 7WoSUsVZ7Y6jn/wsGNMs2omFNhYsy8VxV0cDGNzKO0LNZkUPUnWP4u1ZdJFJ5AcQuP
	 +0eJI08SttoWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E36C56075E;
	Sat,  7 Nov 2026 09:02:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B2962FE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A3C660824
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E-Kc4LSz1UmD for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:02:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6ED6260737
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=bGK75l45
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6ED6260737
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:23 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jM96M6d0JzKmTr;
 Sat, 07 Nov 2026 10:02:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794042139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuPIIjOOoOvVKqyW75uC6g2WQPzPLwaNTs3ZP/i8JmY=;
 b=bGK75l45BwNUXv8I0Fr7zGjF4+ON91A2BOUeGd154jAFyj+lmpILBIacGj0/WRslgaNO+N
 qwDt2LxrUEMW39DOVhy7AfbnOCueyQKKGrycNMZvn+L5DLUFP6VQJ3EhqC2x+4iosSaIqT
 lyNrbWwtzGCjoTWDpZip0No0DsnMZVI+gA+kOPqZW/rfro+uLk41bHIY1RG9nxEg4nnl7T
 MIf9Jbzbuq4RTjZ/BjCuZU3R/Lm4UtRlcW6XgmJN/9OZDmTQ1CpPSI0eA6F6j/vjXGmLko
 IjFlAwvSGk9GE2lobC71yHvxwSfosZK+fpesLH6mhpHqHD45tDLexucAZsv5/g==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: Re: [PATCH v4 2/3] watchdog: add support to call initr_watchdog
 multiple times
Date: Sat,  7 Nov 2026 10:02:05 +0100
Message-ID: <20261107090206.2015512-11-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <174a18e4f6805299db40fa3504c24e19d79b7776.1792320756.git.jan.kiszka@siemens.com>
References: <cover.1792320756.git.jan.kiszka@siemens.com>
 <174a18e4f6805299db40fa3504c24e19d79b7776.1792320756.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 96wbrcomuonjj5naw7cz466ugckyyyty
X-MBO-RS-ID: c79ee3fb7af4da78e1b
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/18/26 12:52, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This allows to invoke it from board init code once more if probe
> ordering requires this. In that case, avoid to re-add already activated
> watchdog devices.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # qemu-riscv64 S-mode

Applied to u-boot-watchdog/main

Thanks,
Stefan
