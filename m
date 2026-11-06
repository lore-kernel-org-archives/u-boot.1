Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2A606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EPjYpp4w;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=NUAK01FR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6185D608E4;
	Fri,  6 Nov 2026 16:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S_MUEHQ_pCwO; Fri,  6 Nov 2026 16:27:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B2E7F608A5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793982438;
	b=EhpYDRsCVXDqaxkKIlfY1eiYfuwRUZAiMlLx7I2G7hF5akrUmpThle6ZB0NszeJV/uCt
	 L2gPPWuhFJG2MpBJhKIkqXz2o2SfEfqHcM9fVVkgWhAZ8WTcjvRUI/ihogkxb6vpHe6qN
	 cdNuh4haCmDZIipmN3AKJIarrT0/yOHr5GXdVyRGQzJbkzRZWoZyi8r6YNsNXKRaITYHy
	 L9EBX1HR5EPP41cWgxIfF8QW3bXCVDECYhRv05uxgmolp8jlfa9EJFnfF7JYHBM1r23eP
	 J2JOG8KvL9oFL0FQn/N84KFimgkY1aX3SUgr3LwIDqdqe+la6NXzJd65KXIFiT+x9XQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793982438;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g6Qe0VpvJnywDIQQZctD898OUutmOKFgWCKsmDs4hps=;
	b=gaXkaIbkBB5EAwG2NTWHGgsaR9XKooE7VvaOWdnKat+PkUxTnV3TKna+lZdSTSycMXkV
	 TrbPnc1IP9BRq8QfDId/ajRIuQ4AXdKznTnBniCz3PALn6M9f96kjAmowyO836izoHcjv
	 eGogS5rc8RBLeqVNgwfK542E+vti8HsMqDAqmqaNW+EOirzD3kvjK9Zfz3pRNG2spNtu0
	 AN3xkXskFpwig/IJN6FGWJ4cntsf/YWElf+3YNDbyDMoDC81pOflXTa26FkscSOHCJ6sP
	 AD7Kt63Xgqf4r8fP2VMpIeM12SpCtzKgiFAwXVOq5P3dFU6hBtXsS1Y3YTkiZiJHChw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793982438;
	bh=g6Qe0VpvJnywDIQQZctD898OUutmOKFgWCKsmDs4hps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EPjYpp4w2Qxb5tArkPIhdpg2z1XlAO2AfmL0kVcykCFqgUyCGb0LemxAX8FAqWx68
	 FQ/SKwxfOTeLccZiiN0M480zBmqtsu0DYoyjUn1sIHuoC/p0/lYymrEllqTrwTvko7
	 usQKcSM1hchChH1eYnZ1HKZ5bgsgnjPk4A/KdxDtDWwRWnipba6PExR6kZRwklWbxa
	 exANcnSUq6YDpNX+x9xI2BlzdOHbUN4HY5IDexk9OFgnfaywR6F71OMLqQa6qc4Ihh
	 fZpW7UzeGwtHGcbq2UqNZhDHdVxROnV3nlrMZvvLJJHw4JJqByXeOylJ7zPrDEsaQO
	 WO7V4EAs71i0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2E7F608A5;
	Fri,  6 Nov 2026 16:27:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E346E32A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9477403CB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:27:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y1OqaIWZoW08 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:27:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A1E8B400AF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=NUAK01FR
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1E8B400AF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:27:13 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jLl236WPtzKnDs;
 Fri, 06 Nov 2026 17:27:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793982427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6Qe0VpvJnywDIQQZctD898OUutmOKFgWCKsmDs4hps=;
 b=NUAK01FR35TzJmsfLUJef1OBcwNTN33h6ciWEq1iprqMuC9HJJWriLHFk+Lx7WjtWebWJ4
 A2dXcyPb2jngo47cK29O3jA2/Epjf4i/l+S1iJ+6MfptDKsv3mRpwZId7NJFJMaQ5YUP0P
 lNQmmVWs5z/blWcWoUcK8oW+l0vgviJ3jB5QE8x01h4pgVBqRJVLM76Htm7Xenxt9x7dfx
 GwGo/6fyaMxiKi0w2cXKreUxxPU1g5iIcilDwzUQ5ZkjM473EP8V8rBJs3MMLGA8ILhqEh
 NiTQPOS0ao0cIrbaBL8Ama3BZ1xiGms403g6WroZWP+FFZRgAiUdPwOFafrJ1Q==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: Re: [PATCH v4 2/3] watchdog: add support to call initr_watchdog
 multiple times
Date: Fri,  6 Nov 2026 17:27:03 +0100
Message-ID: <20261106162705.901372-2-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <174a18e4f6805299db40fa3504c24e19d79b7776.1792320756.git.jan.kiszka@siemens.com>
References: <cover.1792320756.git.jan.kiszka@siemens.com>
 <174a18e4f6805299db40fa3504c24e19d79b7776.1792320756.git.jan.kiszka@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ke6cndbtd66a4o7s8ho95n5z5qwjr4cj
X-MBO-RS-ID: 0290ef8f005966f4d6c
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

On 18.10.26 12:52, Jan Kiszka wrote:
> This allows to invoke it from board init code once more if probe
> ordering requires this. In that case, avoid to re-add already activated
> watchdog devices.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # qemu-riscv64 S-mode

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
