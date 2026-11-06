Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C25606A336
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CKaaY3hH;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=e4NXTB6T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD32680FBA;
	Fri,  6 Nov 2026 16:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KAwLjUcrDKyy; Fri,  6 Nov 2026 16:02:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1ECD18107C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793980965;
	b=lySrySQYMUwFJ1uLfHH97dJxSlL5NZgb9rplxbMOhA8RN05eiePuc+ZpQgsfmMytCfoY
	 ooIC0+g8HFwXNHHkYK5uvfNpwDdIDPgdc3FYyMbwXM9kL+IBsVbB/f65p+Q2NF1uSR8cp
	 Nk3bzPzqsmH1V41BbrPjZBnZLt0lxEb8P9mJGdw6Wmtxt15IQTZkxWT7HmlbwrPyar5iC
	 7byHrrPwIoNcKFQMsnRYEhO0hACjm3yPWIXusjFv2JbNisL+AkqBMiEewg0dq6GmkXYOk
	 pZelDEsRFfZzO1T6I3BFrab5mMp3+cPAE+73hA53jKR4vFCyNiO5C8JHLFioJEZidVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793980965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fvLLMkw9oFIBvGhaa5BdbifUZMm+pfh9w2rZmBT9F2o=;
	b=pULBN9OepiWXC5Mhm4kpPEg2vXp6xyCf8hdmoZnesyrWtFxFCGcm7spIB5U81BFh/kR8
	 3ceJ4KbwdPaSCDQSZRXypf6vHYZgzQUX+M07GMSa9TJx2mtH5E0OUIbF2NS0ei8TJIOXI
	 7Zf/GEVT/whjZtfAg1aI1xoPoxpvSIFLiXLY4Pjxz5qoYOkyEl8AzhACLChe1PzGndfC0
	 py29j8eJ7JTks2q8TeykHT9F55oX5Gwqw4kWvL1yYvgyPgBk10Y+OGl9TykO4Wdm758qV
	 Q9cx0tfXqxAc06v4YQ5Rcu+QAFy7up+hVAXrdZZVkf3NUXkX6UT4mCUFXOMPqjymcDA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=e4NXTB6T;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793980965;
	bh=fvLLMkw9oFIBvGhaa5BdbifUZMm+pfh9w2rZmBT9F2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CKaaY3hHb/1VmDd3ZNlki4NrTfRppb5GXK/I0Fd0Ha5CwVeiRIRCKnI6M7+4Weep7
	 qyJDQj7re6Px/BXIq17CGny/j/GgwV0YcbGtUilIXzMfJ0RBFZBBEvwQRKxQcVu6Vu
	 OmnIEvBhyV+eqyI26MXfkG+rOaBUNGa2+Vf5YF9F5tBfeY3K1NWcrez+vz0IXO1OHz
	 9RLLc4YObrfjBo44QRgHBjbDm0pAA4wwmH7x/PcBg8fuXMkQaXk1RTUZrkh64whTpJ
	 9jzUeXUl1S9z2Kcy+7su2P4ZLflGPkzt0Wtznt4OQZTpUUsDNraOc5tTWaS/2vU4+Z
	 AziviL6AgnZ0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1ECD18107C;
	Fri,  6 Nov 2026 16:02:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB06932A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A78480F86
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o3nJygTeIp-e for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:02:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 601B780D66
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=e4NXTB6T
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 601B780D66
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:41 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jLkTp5TTjzMldw;
 Fri, 06 Nov 2026 17:02:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793980958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvLLMkw9oFIBvGhaa5BdbifUZMm+pfh9w2rZmBT9F2o=;
 b=e4NXTB6THd7QF35txrG/J6vsaTtUgaliuThGxLUaV7Plz0SqlYQmJPbW7F/bkXgOMo0pta
 gs3fdYhqF3UWbKmAci5E/PzOmY2cRN5VjYB3oTqmFXqomBZS1SAbWgZsvdIoxNEx3visw8
 g6N6Z3cCX4mhOoFlXoH/5i0NEXt2/fm20oNfftL2Na8RKeX7gRxyJLpqLZWi99ru7Oprhf
 B+Bcd9jq2M48x6JWnrdfnWlGKo3FAWandY4fxhEI8nzVe4oRc/FZkDsV7hlSqhhCZVz/hG
 VwCpkd8iNdi/t9sZ96jW8iVANZwXopE37ySLKZVU69stESEle0vAg9/VNluq0A==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 1/9] watchdog: wdt-uclass: add get_timeout operation
 and helper
Date: Fri,  6 Nov 2026 17:02:27 +0100
Message-ID: <20261106160236.749429-1-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-1-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-1-07de25b6312a@nokia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kqwd4ddp784t7xmn5ic1ebe3je41tiwi
X-MBO-RS-ID: 8adb2e00a6e28269b9f
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06.11.26 10:34, Juuso Rinta wrote:
> Currently the wdt_start() function uses the plat data to
> check if a driver has reported a max_timeout_ms value and
> clamps the requested timeout to that value. This is not enough
> on devices where the effective value is not always static.
>
> Add a uclass get_timeout operation and helper so drivers can
> report the effective timeout. The helper returns -ENOSYS if the
> driver does not implement the operation. If wdt_get_timeout() is
> called while the watchdog is not running, drivers should return
> -ENODATA. wdt_start() uses the helper to report the effective
> timeout when the driver supports the operation.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
