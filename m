Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FF606A332
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V4jQFd9F;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QufhhiRq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 188FC40855;
	Wed, 18 Nov 2026 06:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Clv-u_QZw1RY; Wed, 18 Nov 2026 06:17:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 45F4E40821
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794982647;
	b=dBHuDLoyVcijTq02DCeFd/Hhoi7SSH0N5/pYKGZ6r1HTM5zdIkWbVYGtbhc4X8qd4jnW
	 RPKwy6IQva7TTPYkPx02E5wpIYwcKArA/7ZozjGR4K8uoyPCeKYHNeTosyA/S1C1YH/Xx
	 ja0la3uk3UILvX2ygHGTHiPfahCn3SDXaNyCvXE90M/9J9YUdYdeYL13lJLkQgvjRGnUO
	 7WJK0MXMN7GnuQU+U94herj5y+roa3yJwATQvTNBlM1BfwDo6A5QR2UOAe00/gDgplQCY
	 FgorhuJZAIL/wU1wcNKtocTkZs9FBxeoZ2ayfexNIQRq3c+1NcvG/+aVa10oKNbZjiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794982647;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b617K5sv2tylnKPY+NkCmyJnSjgoe9hvulpn2Mh6rfY=;
	b=sL5qrg0nhf2SXa/kZCu4r+tmy+sXlGMYeRxgoko7HIvj7MXUK8nIxnJ1qRCuEFH4+7Jo
	 Mtzqn8UN1aHWkdtxu04zuNSFrAvXY+uYZbxdMUgCKPZlvwv4NTje3yUjV3fJkC3qSA34Y
	 /QACAfASB7u9EfbjycGMEZVFAtTspLRwW435n6nDKXs1KZVy9hzmZ/8OTkpq6T7SetWIt
	 TsU2CoAsrD+2QMZungbjlHQd65h/+0DRh+rm3Y2MtOzm+bgTGRW3gioieOlIaiOLtVXXc
	 Wfd/Q/RNWh51t4gAJzav7+51OtIob3LlunQFCcGWXONPm4bdGJLlCCNbkwIP61S0RFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794982647;
	bh=b617K5sv2tylnKPY+NkCmyJnSjgoe9hvulpn2Mh6rfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V4jQFd9Fzb7/zcJJvcfJGeOwqJaBbpMjUYXrHobu1A0bv0WIPec+iNZvmQ5uXMcT3
	 SGF+Iy9ToMOGEgkvrV5PbU4djI2KiEaBw9AFMn+gtyctCdpoSDNsO/jOldnaQ2/AzC
	 SrwvePCegOsCi3rxZCyYXiDgLLYdsCKtwiRWG3naPSm3ru89h/3XXVVGbXcgz1Ljcg
	 tDRUytoidd04hCR9DalSMLebz/F9Np4wo+6oXdM1o2x0SQpwpCAgaFhLXegql/CgF6
	 /xqG+lCJshAuXHvGJ0ufBbCmTrocAficTMJpcyorzjps9n8G+PKEsyXXt4AEWEmu1r
	 C+TCYxBn2VC2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45F4E40821;
	Wed, 18 Nov 2026 06:17:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C5E41E7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 726EF6077B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1OuyvnmBH2kQ for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 06:17:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B2E90606BB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=QufhhiRq
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2E90606BB
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:17:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 865A76110C;
 Wed, 18 Nov 2026 06:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956BC1F000C4;
 Wed, 18 Nov 2026 06:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794982643;
 bh=b617K5sv2tylnKPY+NkCmyJnSjgoe9hvulpn2Mh6rfY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QufhhiRqImmudf8rdhLKKrJ5DBFLeIvZlg2F2bNen0URanBWnil0TCrJoKNPwd2S4
 7i6mDBiUQ5DMVQP3E1zng+8zaHUEmUjOs+u726D4lLLdWdpXNThXYTljWBUomh9Hza
 ix7xFUw1HvU9S0ApPSQ9GpEjINdT5MqYDRjPQGB6FpU/8qXh/U1WzC0uuTq6YM3l4o
 UYhDbbF1fIbu+fPQjFeqH9GAXwnW/dG7XTqfu4j2hU4vOcEtiU7B5dHYEZxpiy6RdV
 zMcmlUT+SB/lNIKE+DaMVv3+rQ86Yh21pF4u/hTxPmG7IPkPaa1is5t4dLVObLaimS
 u9DSBlVH6pSQA==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Yixun Lan <dlan@kernel.org>, u-boot-spacemit@groups.io,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH v2] MAINTAINERS: spacemit: k1: add Hung-Chun Tseng as
 reviewer
Date: Wed, 18 Nov 2026 06:17:18 +0000
Message-ID: <179498260991.3366449.3546701176270089055.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117231200.3699482-1-alan.tseng.cs@gmail.com>
References: <20261117231200.3699482-1-alan.tseng.cs@gmail.com>
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


On Wed, 18 Nov 2026 07:12:00 +0800, Hung-Chun Tseng wrote:
> Add Hung-Chun Tseng as reviewer for the SpacemiT K1 board support, to
> help review K1 patches and test them on a Milk-V Jupiter.

Applied, thanks! Queued in SpacemiT custodian tree, for-main branch

[1/1] MAINTAINERS: spacemit: k1: add Hung-Chun Tseng as reviewer
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/83b0cb0675f5a016ade619b735ed7b9f5f884a12

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
