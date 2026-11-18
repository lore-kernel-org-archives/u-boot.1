Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4C606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D0cgHl7Y;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1KuX+x5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A9CB409E5;
	Wed, 18 Nov 2026 12:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hYWJJUx0t5z0; Wed, 18 Nov 2026 12:15:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7B684409E3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795004116;
	b=Aj7tXQpIi8CX/2cjYuugqalUjVJAb0jQS9nja7o7Nt24eyoTAjzO3TtVL02Qsxp5r9fL
	 +HEmEI1hRMoNBlJDX4FNidtSQ21w6vch6egWeIbxhSGgq5jg5ALJww23xK0ay/C71NRBH
	 L0TJQ7KlJA6j/9UUDACuuNSIYSzdzaigowlStP90qWPMdCjbJvv0A0SRC/W2xyOS2vBa1
	 NCgrjE1KZejQUE6SmczOfqIl2AgJ6P4k63MymddyJgTCIQgajQsEmuWykZqAc9JQKTtw6
	 ELc8rQPB/X4j78nfVH0Tm3xwxT4mngCU08Lp2CEdlON0gurLWWN1O6mFW18QUnuBxeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795004116;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LOg+Ir3Bc48rWthaqNJDMJiBt6AyfZ4G+nDb5FdIFfU=;
	b=C8cjKvbT2Q2yoZwGTJjUXu8Lmmd4m9/ZJf8UZryYCOoAdCWCCtA15WhlLNv6YqrC1J6P
	 hvd7NMYgogowdi1ksrLmpxfVLTnrwEFx3LcqlWtjfAn1zBoYsTRxkKFY3DxEphggGfZJH
	 rBkQKwfwSiYnUK6Ntz8cyzQvdZ3+mojkKBhuappSrUVaa3BdbjzQzplLe77EeYO2oC+XE
	 5/FqCijn/CSKB3NWzIyfEaeZSValPeHozK/SEHa492+p5OXFNSA141FuVcEMefmsbHro1
	 oWkdYNgHakTWP11Je6VAr4IAFIWLim4doT2lTvx9v4OBJKzQ61dN8EHoyR6xexXb37g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795004116;
	bh=LOg+Ir3Bc48rWthaqNJDMJiBt6AyfZ4G+nDb5FdIFfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D0cgHl7YQSX27zIrdAil7jSzhniK3vDxDrFu2bqvB1evff/wke8JXZdmscsVKN5JQ
	 0StwvTzhj6LGZ2PrvZmy8P7TrgV7b88RInSrBEtlxJajz6bwKqbVqRtSb/IfP+Bwen
	 Zc3KkbcNAWfRB+63GVgrQVBEWYZPmiEDWjQvC2WIV1zeYoUU9HelUCTvcnP+d5GCJM
	 ufXwg4WYirZHTfnlt7cXjemM8TBx2Llj/8A7GlvoFJViQk7wugarekCu0vFndqV1xS
	 j6Uv37inJurh6j5QkYmnpxrtorb5cO1XJ/RqHFM1482Wy8L9bm/NGIDiSmC6jNTUi0
	 KDp6DdLBUmzFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B684409E3;
	Wed, 18 Nov 2026 12:15:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 77F1F9F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DE3160A60
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U2KW1E8TXI7I for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 12:15:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81FBB60A5A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=H1KuX+x5
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81FBB60A5A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:15:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 086E5405EA;
 Wed, 18 Nov 2026 12:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEE91F000C4;
 Wed, 18 Nov 2026 12:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795004112;
 bh=LOg+Ir3Bc48rWthaqNJDMJiBt6AyfZ4G+nDb5FdIFfU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H1KuX+x5X6mQyUGV8X+BzsWksqxeruBMyj68EPBCks1Kfo8Z2JNACKoTlTgTyFPq8
 H7HxT3eqKpFtE5Yob5lK5w84ccnj8cy5WS47biv9mLxm9cOJpqfsIBTB9gMoC4HXj5
 1HbBngR58ivD6NL7khmP6EQtzf0n+h9I9fwvFAWwigOJNl1/Y5Ajv3+tM/G8eWhsWR
 0Dx9IBCTWi438iRNO4TcKquiVOpD6wv4dJX5EDnQjob3CWZdiHMLKw39LVSBgsTQOV
 KDHs+H2QjzHRwSe8ZHShxUErnKMiMqefqtSY7fbeMUsEk5YisXw7OzBLpiStZSZz/A
 ivjyIMGkrLCGw==
From: Yixun Lan <dlan@kernel.org>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Alexey Charkov <alchark@flipper.net>, Guodong Xu <docular.xu@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: (subset) [PATCH v2 0/2] usb: onboard-hub: VL817 support for
 SpacemiT K1 boards
Date: Wed, 18 Nov 2026 12:15:06 +0000
Message-ID: <179500406519.3539164.15531516630279856785.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113031613.435429-1-alan.tseng.cs@gmail.com>
References: <20261113031613.435429-1-alan.tseng.cs@gmail.com>
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


On Fri, 13 Nov 2026 11:16:11 +0800, Hung-Chun Tseng wrote:
> The Milk-V Jupiter and the Banana Pi BPI-F3 put a VIA Labs VL817 hub in
> front of all their USB ports. Its supply and reset are GPIOs, so
> `usb start` only finds the root hub until someone powers the hub by
> hand.
> 
> This adds the VL817 to the onboard hub driver and enables it for K1.
> 
> [...]

Applied, thanks! Queued in SpacemiT custodian tree, for-main branch

[2/2] configs: spacemit_k1: Enable onboard USB hub support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/d28d5f8162865bf76d6fab677a926b3797a0ff8d

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
