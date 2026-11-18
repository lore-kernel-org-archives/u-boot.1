Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED0606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=he95/MKy;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YiN3T1Tr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E70F560829;
	Wed, 18 Nov 2026 06:17:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BUF6Zk0RRaRY; Wed, 18 Nov 2026 06:17:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D1266077B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794982675;
	b=rpBHlKPBeqFMS565jis98e7t1I3l0I8k4HX/nBavjnyedWZgt8ET6mTYQ52pYIPVp0u7
	 +l78tZ10re6DXiN5lTT+t5sroO89djU2bcdfXeQBcyoLtXwwkQkQauQ3it7vQSZwj2Ewg
	 D6w2ZC3WO5mXT/JLSERw/x3qIuHtIP1ZiNw7DSpsVcsZveQPaiY3EPH9B5sxyt2NNp64P
	 6JT+BcrcGm4+LGdlns0tXQLTgPnfRPLCTDc929P4TR9HfPjoCml1gJ5zfk7HHpbxL2a0k
	 qIXrVUsgtDeTQDV3fuyPCT3sf9SZ7CiRn/kHQe/7Ovp/Fw0aDA+WcRftueSfDdZovBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794982675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tkHk16XwMXGWO3zBWkK8k6z42H34+NJUj1jnr+gdlDs=;
	b=J0wzF8XzoPs/xxbhyJqgl1xFufO0c47sKZmX+bbKjO7gRtx5jAaA9tWkVGm6DiecCQVU
	 Kx0X9vKdDFliLy+NWOKNp5m2nGXffhG+1z2s3xxNNhgYBMhlasJXxPHFMKOxUc/REwafN
	 XprnXkRCLFZgFyL7IxXEn4Ni5/O2HoFOOAsKlzyy6xukNirDGOiTLyp7v5/yPuE+C3x/S
	 LGt46mNWnwC6aicshRmqprZQlYLfYXSaYGKLnp8OD6gcMVATc2TZUDc4dWzEpuSuW/7SI
	 Nk7ipxOJI94+6hmif5U0oLf9Nf+tc230cMjbe6fNSwNUYA+NUM910P0vRvpYyua6VAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794982675;
	bh=tkHk16XwMXGWO3zBWkK8k6z42H34+NJUj1jnr+gdlDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=he95/MKyyEqqefJ89uHzOjMPOdVG9IzoS+L7/sBMKCQeWHaCejVtfs4JLOPA5PsUr
	 28rc+w5Iaj2uVgcuVl0rkHPNsRCaNIbg6H8xaNA2YKK+5xjNVxNmx0TqOjZpLqof9J
	 pEBvgD4keUFF5LUJZdYSOXt/q4p2lW3P2aE3EePqBIiPZ3akiERHV9U1WSioE+QUWw
	 8/DEgajbHiAJGyv7sv0IPlpxqxZjCRNsS6NuUpHgZhtpG7zwjQd5s8jw8FvqsXguGE
	 c57hSpdooS9gP3n4q+R2T0/GLkny2Cn1x08d+JIhEhYlD3PElbqk5hnO1oZ6VwesFI
	 ky5M58HcSCNhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D1266077B;
	Wed, 18 Nov 2026 06:17:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB0111E7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:17:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B12D381046
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:17:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WGF6KTixZItZ for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 06:17:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA69F80E25
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=YiN3T1Tr
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA69F80E25
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:17:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C6C0161275;
 Wed, 18 Nov 2026 06:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5196B1F000C9;
 Wed, 18 Nov 2026 06:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794982671;
 bh=tkHk16XwMXGWO3zBWkK8k6z42H34+NJUj1jnr+gdlDs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YiN3T1TrmcRxEx09iH7AQEJUxkhbT+Mldq64Y2ezcZkOYNuCaqiENyHt4vyJWsHeU
 pMpR6M2XaMluoDUdZXtfNCYBHFw+lDQC791to348DAe1s+9gHgisl+veqp2z4bYWv3
 7sxWLJDWMkKl7CyXDjgo+/dA6LhLr87mqlHfMqNe6Z5aR/YS1YxDTzmyHRkTCnDHjq
 LDPTBZF3HViv3MIpsQ7+qAk3OhoZSpdY/bUFqnwh8lfhtTXmJRssYhnq+dke6Fvxie
 I7s61EYf9FfgtmatbwZce0qm4zoBbKnzD4ocXHZ1H74ZEe1b/7CK7o0ywk+zXXalxK
 hESmNIJvUNqgQ==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org,
	Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] MAINTAINERS: update email for Yixun Lan
Date: Wed, 18 Nov 2026 06:17:47 +0000
Message-ID: <179498265496.3366689.985909746139041069.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113-01-maintainer-dlan-mailmap-v1-1-60888ee6b978@kernel.org>
References: <20261113-01-maintainer-dlan-mailmap-v1-1-60888ee6b978@kernel.org>
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 13 Nov 2026 22:57:40 +0000, Yixun Lan wrote:
> Prefer to use kernel.org mail address.

Applied, thanks! Queued in SpacemiT custodian tree, for-main branch

[1/1] MAINTAINERS: update email for Yixun Lan
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/7ab69cf0773295788d09e14b18162ea7e2a5ee0e

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
