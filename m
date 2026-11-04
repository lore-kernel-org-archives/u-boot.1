Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87442606AAD1
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N/NfbYVC;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=KV63OF2x;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=5O4bS3xO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5719340694;
	Wed,  4 Nov 2026 16:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ezw9ix22DOeO; Wed,  4 Nov 2026 16:23:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62C3A40509
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793809423;
	b=Nr9q4IbN486qmcCJ0in6hgUAcEe5n7LWBWlab4zXpC/L9jZfyOi095gfsGYWEq9cSQms
	 FDLxRiyNlgstUo7hAFUYWo1NqLasjQjclRJQMWogSgiTSk96otnHyTGJLdzf4251ZjJTr
	 2PmF68GeW0k6g7PyAbUl3YBMNfPEg2OnGitVv+BmTMv5KydlU8Cfo4hKH9c1IHh53sxqB
	 /AkGB6UCADlIb6P7/3FqdRylT1qj7/P9zwZSxohnJrMj0VLKQR2YtpJv39upyEjG7AQP4
	 u2oNzrE90xlLH/GAlUQxOfCr9dYe+4TbyPLDkTdjmkBAB3HstAMdeaUiJMZ8VPubjOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793809423;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5C2p3dj8+aqFQfKgYHc1s5E0WU7FmKvVuzTZUQi7M9s=;
	b=kxpWAznHt14/nrrjlXEy4StIZZuuRvyyegRMh7Bqr5cfpj8KGVIqj9NBg2+jmxsZTDiC
	 wziduqwSDp+LXNnCAVURCQiH2d4OmdlXWzw0G6NqunMa6YWa6SOKr1sayR1e0cTkQGqbM
	 vLKAflaSRUvxUlpdsJbtvRpqkiw/T9+8BxCBvMor5ZKYc0P0Li41GGe+1fgL9tOh60YGh
	 e/xPejYodxP9g3haSGk4NyXWcf7nhe6alTOFMV95oWH0KnCxXIn7NzVkEQqwFFFqSsUrj
	 eJ4aCKw6DyZfHUOHlmkQadcDdK3HPKA0yUgWI3175JYx8fTRMERGbWZMmU1OMr0+/6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793809423;
	bh=5C2p3dj8+aqFQfKgYHc1s5E0WU7FmKvVuzTZUQi7M9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N/NfbYVC70MZAA6cmqsDY66NxPT3caiZZUw6ccR6gzIUWLU4SwmQblt+KQ6WNDj4k
	 g+VM1TaxKrqUdLT0WGkJmBOXsWYftgydeX+AxCFGACgSYjvodfNbkczoLaC3BPzecW
	 UAnuMaZ84MvGQ6Pxgu6bEhxvTamasyNkvhIHKqk/jQGQcZGBc4ABIx0i+5PZNHYbXK
	 e7qLE6RKFzTBPTEp6f2RwswwgQcI75KiaEhQ4eVXOMBFjql27mH0q9dsh+xwCtkisX
	 hAMa72AUpwzy6bfBpoJCM4lX7pMlvC7t71R/b8aYGkOVQOyVr2g3ecqOGAMgU8Y2e0
	 V7Q0V1KlD39Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62C3A40509;
	Wed,  4 Nov 2026 16:23:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 34F83A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 1AF9B80849
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:23:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id 2lvBwgfTltP9 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:23:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C29DF8082B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793809420;
 b=fa7MJ1T2qmqANLNE9CEVUqDCADkOGbW+gcZKNU5XCdvtPUDfNzga4ZehrMd1nnkpLWZc
 ZrFW2Z1q6XihROPqEA3mb6nSX2fkRcYfVZJ+rKMERJpYkAwjTtylsqZaeZkR4rEESO0na
 hQu6gnh5Yho3k0/mV1CYMBkdK3bXGrGvQyFpU1v4uJgTXa7S735bls1fvqpkNvCZqTZvb
 TxSVZmJeWSAzLLtHqT4vQ0bPAZceY1wUwRIyNc4Q01tM9iYSXzzUfxPswZtfX0xLVDDxq
 20ig9zOb2wmAhJjYm3kcM7G9U+nnm8JGSadoMDlmKnFN+hGPz+cPAJ++sLf+9D4uXEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793809420;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=5C2p3dj8+aqFQfKgYHc1s5E0WU7FmKvVuzTZUQi7M9s=;
 b=AkHYzyoSX5aJdNtMYTU1bYqftSFMDdpot9EU0VGFbboUg1kLWoGop6HjlEiECC66rv/Y
 qiTf1jtfE2hxWGv9JtXhhAV8wtOn8DZoP42d9bL+ubC8l7m0F23dgXhJwSHEgO0tTAqIr
 iIujfdnl3PKoWHK2pK3AlnuIG5AwnccWSTjM/YBmy5x4+Bnrcvq31iDddt2MYpqyU6kEq
 WicCqhOZnVrDTn0iR2hcx4sLoi1QaHtwGo5V3L9gqsT1YZ2oKQJChED+uCTLkzvIeFLLp
 7ldNLoVgL6C+o4yDHMn/wUnooBbYLMkDxscDAQUlt7Zz+yGQI6NGcY3GfpE5sVPLqwg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=KV63OF2x; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=5O4bS3xO; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=KV63OF2x; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=5O4bS3xO
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id C29DF8082B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793809407; bh=5C2p3dj8+aqFQfKgYHc1s5E
 0WU7FmKvVuzTZUQi7M9s=; b=KV63OF2xgfMdqrVyqqqR1bUw1WQQP5A0jmW++7HfRwQl1mlE9V
 SwaomFCNQoSMwIFjGPtvkB1X/WwIH3p2ecSEt3kkMp9Y4LTrWoebyOfug+/HxWULFOYIXVCJFnr
 cGR/7q3aIvfFYy5DIuKa/s2hqxwXYqFB0UDAAg2m4fihkc2Y630CqQLcNs5tyCmlpC25ifPnYcu
 H92gUMSwxvOXDjkj4i9w/luF/mswEyqNE2PvX78/9vW7anD1TL9r9qhXblNw/Iw0lhLGIcfRdEN
 N6xraNOY+8N2ajrVfcDWoR+h6eRnPHg2ffQAm4wg6mkWjX77Fi2yTuvhIQ8gGqnadfw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793809407; bh=5C2p3dj8+aqFQfKgYHc1s5E
 0WU7FmKvVuzTZUQi7M9s=; b=5O4bS3xOyeJ1ywz8O9e90zuq1VIB4S8rj1Mv1KJWnN5H4w9gsQ
 6MirETBdEBp9vW1OBxrcEdwBjNExAA4szTCw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>,
	u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: Update my email address
Date: Wed,  4 Nov 2026 16:23:06 +0000
Message-ID: <179380922199.29991.11743513763065873100.b4-ty@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
References: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 03 Nov 2026 15:03:07 +0100, Christophe Leroy (CS GROUP) wrote:
> Some people have reported christophe.leroy@csgroup.eu being stale
> from time to time.
> 
> Change to use my Linux Kernel address chleroy@kernel.org
> 
> 

Applied to main at u-boot-ppc, Thanks!

[1/1] MAINTAINERS: Update my email address
      https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/be7b24b50d13

NOTE: This patch did not apply directly, I fixed the conflict:

--- a/.mailmap
+++ b/.mailmap
@@ -41,6 +41,8 @@ Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
 Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
+Christophe Leroy (CS GROUP) <chleroy@kernel.org> <christophe.leroy@csgroup.eu>
+Christophe Leroy (CS GROUP) <chleroy@kernel.org> <christophe.leroy@c-s.fr>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
 Christopher Obbard <chris.obbard@oss.qualcomm.com> <chris.obbard@collabora.com>
 Christopher Obbard <chris.obbard@oss.qualcomm.com> <christopher.obbard@linaro.org>

--- Thanks!
