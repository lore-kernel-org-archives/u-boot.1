Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8B606A32C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Nk+AZJtJ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQiEuSZ3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 928C7409A0;
	Fri, 27 Nov 2026 13:58:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rlTE17sMnNuA; Fri, 27 Nov 2026 13:58:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0227B409AE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795787897;
	b=rdVv0pYR68A+eystVidTY08qpHhmmBhi9XCEdJtYDVzuEhf0S6K8tfSEILDlAh7hIoQ+
	 g/SB28sCAqKJIN7UzXolhm7WdmxqUGnGVbw8vT5Xo7e4tL3vfc5YS4rBxtYnRlz593wSy
	 /ckG6/lZtE6Iwlt6hCrvng/U2im4OJMjSxNVz2DAUQ40OZ+s3IuUFeP29VY07Id/Su0xY
	 F0dtzcyEGbHxOcwuGrwu/hZujOEFO+6O2n5g8eJmKKFceaVY6tBetU5zqbJB2FHdGeb7h
	 vlrIdJTfWUc2I79V9FMQbOL1JkpI7it3WETduhOzzxfYzvJe/E4zmquJlxMknSHqcWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795787897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FHqq/9kl2BcgVF5IhUdxh8nt8b+TdhplIBGZbUpLcJE=;
	b=PK2HErFikPYtkc/KPQ/TpCxsCDqPcLoJe9nHEsii1GFe+vGxhWcWgeNvYcnOu4GhkTEK
	 TIEM9dHfC3lx2c86RjY5cDtDIGMLduuGjKsOq5vFYlvDtK12CmO8PbINb1F4LsgikfKMi
	 CagX3AWffiQNdBR9gDscTdsy+QljSu2m7se2sOHT9+FLVF68mRtvOiW35fYhIAlh1mBoI
	 7y/n4WofQN7nMriqJ/Vj8bGGFTLKP7QMYm0TF/w2WeLiYxiVdqEnEgiUHvH1tFxbTccB/
	 vjZZNy1iGtfiudK0SJE20fdZhlpPXDs6daULyrz06+DpsOsHJgNWg0Kj+1KuAhsJLmw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795787897;
	bh=FHqq/9kl2BcgVF5IhUdxh8nt8b+TdhplIBGZbUpLcJE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nk+AZJtJcbJ2FBJD5D0xahGXxL5sbY5NxTteUfMTb48CorDR+Phrd8PdMvUikqTSj
	 AGVES/5i69A8upQ5SCEIDQpDEEym4wdR7gT/wNiwvLJVNv50Egxx/JFaOSgkr29c/t
	 81J/rTMrX1YdYCGx8YNPSWET9xTb97WaegyHfdPuLwvCIZ9SE0Nq5iIX+fk4qSHYu/
	 PSHFgaMt0SXQ1CYOvMik4Nmh0zGlWYDqDrV7NjIcAGdlxxK+VruJ5S3VkeZAk+ZGpE
	 vFvOQxvFgDDMvH3lmXQQ5q6osDfLOtQq0lFjckEEuc7vXo4AZmJHxQ2hfvw4FoLi+S
	 MaJM27xRbTffg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0227B409AE;
	Fri, 27 Nov 2026 13:58:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17F6ED1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1BB0400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6OQGQ8COf3fB for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:58:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3FD564004D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UQiEuSZ3
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FD564004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C60261DCD;
 Fri, 27 Nov 2026 13:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A61D1F00899;
 Fri, 27 Nov 2026 13:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795787893;
 bh=FHqq/9kl2BcgVF5IhUdxh8nt8b+TdhplIBGZbUpLcJE=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=UQiEuSZ3iz8ytQJJ1/1MGgVe79QyRuvzHZfJ9z2MZJkvTekZS/1H3EOR5CHDDweKY
 g0NXe+re5LqyJ/zpcI5r5Os6TJ52HmksjdF+O8rZhFCaSnZ2piBiwzsDIypttYBOJ3
 3qtHVXUrFn9g/R89GrCO3xArD0siKGi+XjE0St4jaqb6Qxg5qiv4fLHhNz0p3RvQIX
 EzFTdtl9Eq85Z2DU5HU8t2ynt0Ea63gpSdqdK8u6KFvl0DzcHNYerFxY8GCOGuNeMP
 gavY5ThGaiPPVj01yRZXloyW8Qdi0J6whR+CpBv1e70vAzBfwVogjnsoLnDiS/9DJt
 yxpNSvTDIMl8Q==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/7] tee: sandbox: keep zero bytes in persistent values
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261124-upstream-avb_tests_b4-v2-1-ed7136c3767c@oss.qualcomm.com>
References: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
 <20261124-upstream-avb_tests_b4-v2-1-ed7136c3767c@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 14:58:04 +0100
Message-Id: <179578788421.2215474.6933636399302767469.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=487;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=dlUmHmM67WiZ5MBPcEFVH9EKT/jN/zc9arFZuWWXHy4=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCYxumBQGJA8sqfbhEHRSLZfJxuxWrkD8Xzb7m
 YA5u8lKenyJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawmMbgAKCRAZDR20Zk4Z
 NftUB/0b3tVdJLnNuo38sX+d6uWUK75NykGL3kir2l9JNcrgXtf9fU/9HckGC4Ah8tbCERzFJ9I
 RkyxJeQNPb2qK4rlqYMdEDn98SDwfSUAQ2pmrfX4aLtCl9DAZLH95HVCaxN0uU5DIdTEAiRHgBf
 7HY9HZQ/+TyF5Gtsjm6fhR094FV82NPFCBDHWNfpInDdOGNddp0/nWy4pF7udwQTeIPYAj3bkk8
 Lv+ujVD94FrZdS8Sx7lcssLR4lUlDkfCm9Gk4/VLCHN8wNwoG+D+mpzuwZBJ1+2L4Ww7bLHuCpW
 +BtTG7aXysZHnfYxoFCAuB+D2NwLFpqnXucjtEC9kxILsXb/
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

On Tue, 24 Nov 2026 17:24:58 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> The emulated AVB TA keeps persistent values in a table of strings, so a
> value is cut short at its first zero byte, unlike with the real TA.
> Binary values, such as the digest of a user-provisioned root key, then
> cannot be tested on sandbox. Store the values hex-encoded.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
