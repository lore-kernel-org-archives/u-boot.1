Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC4606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k33d7qOH;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZMGif1Q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D54A8108E;
	Wed, 18 Nov 2026 06:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OrNx8_u1AmDp; Wed, 18 Nov 2026 06:16:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B25BD81083
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794982563;
	b=DrFQ+8XJherKdQ8/e0AlJBvYvkWhYfFtFw75UuD5BsIlW9axkBKE+FG5nnlX4YNroRKb
	 2hn7L7lO090Xd1lruadVhUbmR7gwK6cVwiz3VyIv+9jfqmK9pPjyh41n8xcwLf5O8hAv0
	 4VbekwXoOyn1+40g1bnKPww9F09hWuDsvoqO/CKNuQVEjCHEFpVjB4FxjJlPcKqwzudoE
	 Jt4EEidEVa+6F5M1ga+YVRv0L7E1ceo1i9Tt1WmEEAT3hsSqXmPe4zsOrzj/JNAP0FzVC
	 gfYBXA5/yiaZtaE5U++DpBidKYXkM5IVR7RrQvEo2j5B6hslfnC7L9nPVYdC9ZXG2YA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794982563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MDkO3NMJDCC9g3aJ1kHdd/lo8Rj5HRsMxFSAMApB18g=;
	b=VjAQaedI9TIzT4q0QgF04yriTlHUTg3DSaT03OI/YNGsb8Tc2WTLtwPaZfvpB/KAnIoS
	 Z094wHRbMTabARiLWkRWiM9NHAddLeSvcq6HBF+QmKk0e7LKANzNrMFunduqDx2Xd+l2v
	 g9SIqEzZ9S3a//tntsLF70/hrwC71XBiZkRfTZqlnLaEmpY/m21oXQNKSINVp0nVcbeIS
	 SADcktWKoxdZny5VbMn522xaMSngYVEgklN1bvoU21xWpoMWRJeel90ahi6ixs5v7Y8LJ
	 YOTmKsV0+7WeJZFv67V1qJ7StADJ5pT75RkPUTS3XUVqdPd5EpKZGvmZcMOpHoC+btQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZMGif1Q;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794982563;
	bh=MDkO3NMJDCC9g3aJ1kHdd/lo8Rj5HRsMxFSAMApB18g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k33d7qOHXJutsXfvfrksf+mdTk+dSczjjA8rAfOqCMQiDhfuBGRmc0xIcSTayxD6+
	 ijcslCJhWZO1dfABjZTRqFuYiMx+qgAUFjXb35EsfG+Igk/6gOt8c/MPAtZsV4eA8T
	 DyeiFpiUkC3ZgjhrmqKh3pAsEvyZjA9tqAHPCkOE5BQJDenLwZknJnVctgLxQehBQx
	 SSkuS1zaTzwOllcuDL3QBK4roaNMsFUw1vcAeEPb7QW5C6n6wfStsRSRd2FYEf6SRf
	 u1vtdrheyWL+1ONUm3ok/fOqrEweyn8X0TQFnmpVqwePravGE979tOw78AV1VvmWff
	 5OGNlW6R2Ccig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B25BD81083;
	Wed, 18 Nov 2026 06:16:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 455331E7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36E0181083
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:16:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fntxvT13zEbx for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 06:16:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6B59181080
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cZMGif1Q
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B59181080
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:16:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2DFC40BE1;
 Wed, 18 Nov 2026 06:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30C01F000C6;
 Wed, 18 Nov 2026 06:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794982560;
 bh=MDkO3NMJDCC9g3aJ1kHdd/lo8Rj5HRsMxFSAMApB18g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cZMGif1QZ0johBMU3npmI145LBNbME0DLcrhS7wFnJGhY4ns1FMANMr8n/bqRyM/d
 CBA7GXdQApNPz3c3/ncTJ83WUTDZZDvZIx9iRH8k4AjVYJppIYkiT/z3J4J9gg/zxr
 PhG6jDpO1S5/UiLx0YxOvIftyQLcW6rjea5p4gjuEWr3S/fePxEYfwPfge48kH2fH6
 abbSFLA+zfpMHr5U1GnVuTu2LsQG78PT7CIzvPyrAl7+bnFjQytyd4fZfJtTnU90cx
 3pQRhFYFl52qpBuHviTqYTuNj8Q8aDvYi9OX9shNsn3/6d2d/zySFPAD7U98J+zkFg
 04bwmm22mIOmQ==
From: Yixun Lan <dlan@kernel.org>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Yixun Lan <dlan@kernel.org>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH] MAINTAINERS: spacemit: k1: drop Huan Zhou
Date: Wed, 18 Nov 2026 06:15:55 +0000
Message-ID: <179498251455.3365423.15003325648096794841.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111-01-maintainer-spacemit-k1-v1-1-2b3de5f34954@kernel.org>
References: <20261111-01-maintainer-spacemit-k1-v1-1-2b3de5f34954@kernel.org>
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 11 Nov 2026 11:01:09 +0000, Yixun Lan wrote:
> Have talked to Huan Zhou offline, he was not active to review
> patches for K1 and wont contribute in the future, so adjust the
> entry to reflect the status.

Applied, thanks! Queued in SpacemiT custodian tree, for-main branch

[1/1] MAINTAINERS: spacemit: k1: drop Huan Zhou
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/c1565deaa907750bae4e44c23dbb28d0159ddefa

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
