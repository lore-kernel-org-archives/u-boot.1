Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E5C606A325
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OVA91H4P;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ThTfUvX7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1499380DF5;
	Mon,  9 Nov 2026 19:40:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wC0TelymbJEq; Mon,  9 Nov 2026 19:40:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C58F80DFA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794253255;
	b=po0RiJC2dUsHKxuiJEndwi1c+MXLIUi+81qbfni4LAqVmMfqrv0QHpTDtOAWp5svyodS
	 ZC4mjT1NQhUdqgbnnLVu2Uorx6w31sPor6oW9s8TM7u/ijLXrYF3qBgxYew+ucVFr+Ou5
	 Ll/FOv7SsTq91IRoO1cdil6WDXLYmLrHprmanTSUiqEGKTnU4iAFLCGq5BMzH4bugnMhC
	 PC6iz91HtAN3B1zXmPMo3gp7MxXv09j0rl6+LPrHHKyrNOApcwz8NRlNc2wsRWpULpt1/
	 Cg9hMNTQD7DIH6TI1CMMToLdKoVVMXyfe0/mCrlt/uZMJj7OGqjAo+8XgGGbuSniDjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794253255;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YJ9pC+qMIeZFPO8MRIeqLKMDZ3Jnlc/1pi7CufMZE88=;
	b=RIBk9cFhGeGI6BJxUcW46wXpwIgeMnVKoskzM+Xc4uI7N8JAfDoSrMgJ+AhzQHXnOs+Z
	 Y9FcDEeqv7Uocs+ZYZ8lb660tGxiz4iH5ztDHu5fIOW0XYHDQpKMM53hHuhex4+sGYoby
	 WvV58vO068pfaKX1fmBU2EjDz1N0Zr34Wl/PS3kaqmo44cgNy2xh6pKUPju+f8puJk93a
	 ln0Z3vZxCY/tyCvAHhqkMmlvnjdlD6ThrleJ11o4OdkXFN9XrvT2nKGI0bK5Il84Z7W4G
	 p3kVb5vRU0n7degddZ4icR4kiSxYRCV53KvXt8P+MudHYxPxQZa8wVZrvWw9am+JUgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ThTfUvX7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794253255;
	bh=YJ9pC+qMIeZFPO8MRIeqLKMDZ3Jnlc/1pi7CufMZE88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVA91H4Pdro5a18SR+WgTX8YKuZv6nn+dxwnaXrn6zXFlv19iSqO+kzv34kTJCLfB
	 FamPpcuDd6mwAhTDmXcYOYf7h1CXppq/GSeNKr37g3xQmJVTSaXFblnUfVKWUU3E7B
	 HqP8V3rYhYyGOzHP65NhyzpnJ010y35jM0n2+W20/qx3KgOFpU+VjIRK1XJfenzqSb
	 9/gsjLBEMXycLnfgOPC/pYdBmP7Og6cM6Ldj+5qrHyzNp5eXDBqAChz2x8BnSwcYZT
	 6jOtVrh8TzmIm5bAhUX5vQk1JJSCHLdfUrizjUf06pwMwmsNcvZs7s+402aY6jKZAe
	 j80t2omqdHDgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C58F80DFA;
	Mon,  9 Nov 2026 19:40:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AD013235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92FD080DFD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zCT4ReWRKAc7 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 19:40:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9A8A180DF5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=95.215.58.125
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.125;
 helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=ThTfUvX7
Received: from mta1.migadu.com (out-125.mta1.migadu.com [95.215.58.125])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A8A180DF5
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:40:36 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=Xnm19dgxV9vlnHYfdbvUNLsGfKY7zxyO775RZBPtRKo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794253235; v=1; x=1794858035;
 b=ThTfUvX7av3+lom6AQnVhin4xIyBHItoUY/vBgrI5kDRYUkJYp1vv/5vWvD/eUNu9L5DWdES
 6PqhKHc4hI8hySa6k3KlGd92rAUV2ykjZiGmUvEYR0vzjHj+M51DtwjcOlFmEgL+CxmSEm6JVg4
 Zis9tY6O4BPwRj8GtS4gQwKk=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by mta10.migadu.com with ESMTPS id 39566d6718052ce1;
 Mon, 09 Nov 2026 19:40:28 +0000
X-Mizu-Trace-ID: 39566d6718052ce1
X-Migadu-Flow: FLOW_OUT
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Tom Rini <trini@konsulko.com>,
	Bradley Morgan <bradley.morgan@linux.dev>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: update email address for Bradley Morgan
Date: Mon,  9 Nov 2026 19:40:25 +0000
Message-ID: <179425318470.3226633.5085653902848018744.b4-ty@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109193434.3225755-1-bradley.morgan@linux.dev>
References: <20261109193434.3225755-1-bradley.morgan@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 19:40:53 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 9 Nov 2026 19:34:34 +0000, Bradley Morgan wrote:
> Update my email address in the POWERPC entry to bradley.morgan@linux.dev,
> and add .mailmap entries to map previous addresses.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: update email address for Bradley Morgan
      commit: 439fb4b1e84baa551e006459d9e4a24ea763a8f4

Best regards,
-- 
Bradley Morgan <bradley.morgan@linux.dev>
