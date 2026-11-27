Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14C606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NO4xf9WT;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBVO+pQh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AA1040A53;
	Fri, 27 Nov 2026 13:58:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gZoNanWjX220; Fri, 27 Nov 2026 13:58:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9677D40A71
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795787905;
	b=TEl7zoJ2RDLTy/ONFvRdtRxyiAQu0F3ERNBDNgq1xQyl+2IyP4cOAb07MenXUvHcorPu
	 c+0xLw2kE2YLZWiRISEuJ8KJs/iqSzD8nYwTW3c6G9MZgQ4vDYSdUiutDIjx7eL5IY9ri
	 hbKGkY5NaIn6NefKgeG3+3BVZ7j6VQ+scVStYwsEWwWS9GXJCCW1Mzb+SlYDQh/utaWWf
	 pvn5naUwKtFYQeBY7F9isJ6wjocWNGwlOU0nVIlLDUXLfPzHGCm7oBsi0p/rE5am/Uf0L
	 /hnVqByGOoXDe5MQvbAstDIK9akUoaK5eLNrrWjp7JhXBl8FA2tWP2IDXEg4nsmr7zg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795787905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ynpwj+8q7tPHJpp6MmPxNEtWu7UCcN0072jPPE0ohWY=;
	b=rjLkE+hZiOKPdAftlK6V8FKmImcpPmFq5tpkgF01vchvCompDvUgJPuxdEAk0Z7IIY7I
	 w5eWMLmxAcL+XEcWCiYZFZa6rogpzvI8J4umPiUWd6PXR92WQRW9Wyc8dtyqFmxO7ndxY
	 kMNUAxg+fJK6RpgJdntzReSz8beXdhetPMouaJpcWMJ/CMIZ5tvjRaBMUvV8p4kJhU+ta
	 mwEHQzR5jZnX7qyLGPLFtuNr5S4mF08G07IOePFa2Z7Ft7tt3ypQhwUdTPVb7BMCjj9bu
	 gGegTEMQckCTQMY7YuhcnpJiWk7X6dsX9ISOo3Bxu0LV6VO2PPXdOBolZmf+/Z8skOg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795787905;
	bh=ynpwj+8q7tPHJpp6MmPxNEtWu7UCcN0072jPPE0ohWY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NO4xf9WTjGgDhoTO2YSJDTTAioMo8kFNquubplK6ve3fYyHn5/etEFeX0tvL6EyoO
	 hgRK6z6qVRLNWnNiSUR+lvQa8aml5DxLhcI0ydgNB71ZbQXU5r8iVvpJMn1/3y4Yxp
	 xYRDMca2xxvbUcbbE1TauFzV8Z+O8h6IBJ9AOLLfHjrQjklKMn0WwBt94QWrKffKOw
	 vnEcuxgdiOzlKc00H0pj2gn+J8XPON4uL6yNRFRpiCmO9t6cZzqdcRWobo2Jbj9gW8
	 0elQ/EBR3h/hvbV9VIHzSkWNcFQQazNoiNQtiYo8l6/uKaPLhDLHzitbiJDO3TVvpV
	 4JPA1Y43g6VDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9677D40A71;
	Fri, 27 Nov 2026 13:58:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DC302311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C29B180CAF
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hp49BSAV8NIS for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1AA5280CCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QBVO+pQh
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1AA5280CCA
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 11E1943457;
 Fri, 27 Nov 2026 13:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C55E1F0089F;
 Fri, 27 Nov 2026 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795787900;
 bh=ynpwj+8q7tPHJpp6MmPxNEtWu7UCcN0072jPPE0ohWY=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=QBVO+pQhFw9wcnN9cga8Ko2YCTTyvdSnGA0oU83orkZ5wKeaqDCBusE0J/3NeJ08n
 U8c0cTOMO+LtxDcq1wBz9w1MI92JijRKIdxgCevvj8O/CJkP1LNRwh6db8knZn4sU/
 jvsBkz7ymbEEdHH0mo4MicsQ53Jm7p9Yf9lobDMhAwVnUjCE0wcnR2EEhLahwTmiky
 ZcwxNGAiTjTJjz3bETBShpX2pxPBOKws00lvEubGQAtIqi5MKST4uB6qEPCoZMF6XS
 nz5y2ZrxHgJNDQc9s0X0Y6ch2ERIr31KAeEbJfUNfr3VdkN00NpqtY/MNJOcGMHCpg
 JCuwQOPBdAITg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 6/7] test: avb: test verification of preloaded
 partitions
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261124-upstream-avb_tests_b4-v2-6-ed7136c3767c@oss.qualcomm.com>
References: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
 <20261124-upstream-avb_tests_b4-v2-6-ed7136c3767c@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 14:58:04 +0100
Message-Id: <179578788423.2215474.18150388947020805825.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=594;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=agC5jOmao2FhmU2RdqlyHYUMvLvpVA2WjQqOSK7m57g=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCYxy1FaR56Nw6MHF3ZKUWU1WFo80Z+WFYobM2
 6UoYiVirSaJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawmMcgAKCRAZDR20Zk4Z
 NYQhCACUwF3HOj3FKkfhuc5o8FseGZGoq9V+2jj0zPCmOcrRSeqUzHp1emx532p8lWmQX+wlsPA
 hDOtH0DDlcUwuBf40o1Y+MgprXQfP/IrBZ4obvukT9VkORpcf5s+tq4OPEWy0Cy47sSVNJtZGEu
 Pj4SR4iekn2z3+oeMFd7MP68wGsVswqVt+zkAPneY5Yw9Dk4tlcXnL0vjuskqHw9ktNsDtWrsdq
 RIsdu9Jbz7P/daPqL/mcT+QQOOLp3VsvMkzfjM1ifGeESQFKj3rITySaMBXccxL3ynwgsfdhLQJ
 lC4OPUBvb0d+EDoc93wvpTFbb2xePVdzSd8ZIsxfvc9giLWc
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 17:25:03 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> The Android bootmeth hands libavb the buffers it boots from, so that the
> bytes it verifies are the bytes it boots. Check that libavb hashes the
> buffer rather than a fresh read of the partition, that a tail the boot
> image header did not announce is read into the same buffer, and that a
> buffer too small for the hash descriptor fails instead of overflowing.
> 
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
