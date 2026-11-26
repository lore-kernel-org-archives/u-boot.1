Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E4606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lIBpk56b;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfBiu584
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 231E9408EA;
	Thu, 26 Nov 2026 11:02:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8cX6ypQoX8-T; Thu, 26 Nov 2026 11:02:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 732E7408D1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690976;
	b=lge7gEQLlexgTk5CHlhyYAMhpQmD8EL6so9oHkFP1f+FCb3WHIH9LwsfVOmB4RYsBvzd
	 I72Op8R3vEDEcs6hm6GOta25cC7jlbYJeJhuI5lk75cEVRIVYNKo8oq3xJDTT7bxZzhgO
	 Da8BKCH7/74xsBUhlh/8YniTfF/mwre5C7Xlx2BlJY90REjK5IE+poidWGS4Qt2NMajx1
	 4zRbUgzhtFwJ+YwhUWH2qLw7GUV7pGxR0eT/4Y5+R774CBrQz39/Zk7y21/yBfMlifLKE
	 1x5Wocs97seWUVV6JSgew87qwQuycPslO2WuNiMHzAjWGz1vJR3y9xNvBT9bydv2ttw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2eyfT/aRfhbL10XCZG2uagDkykXnGsJO56WeVK51L0Q=;
	b=dLa99kUZlvVKs+y5i1p0kDuoUu7g43u2+FcRlZz8uOU7L9YYGihoe6zxpD2HGEfhTb7j
	 6yv3PNbgnL5MUg1MDN0bIt907okTgB7N3VHpf7Qd2EMXw5JWJhCgAbnCLZrVCymXO1QP9
	 TCtmC5OXY8ipVaSy7cGAZcK2cAKp2Y6UrcFQfLyEUw5SjhRFLCdirxnUnv7bsVk/JUeh0
	 XwTgCAVred+ZruFDB4UlZx9swoRZh5/FtloqMg3peHecmm/u5FgvB6CWZOIfjYzzF9zOU
	 ns7GnAQWabSlZu1bbdqTPvUU/PQnrrkCKxK5teXx5/IVrPYg4ur7BtiEzFYeEhLe/bQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690976;
	bh=2eyfT/aRfhbL10XCZG2uagDkykXnGsJO56WeVK51L0Q=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lIBpk56bU4dPW1LQWaGeB8m2MMPSgrOuPYAEB/ejhvRAKerB4Puzw5pjtFV3LHlle
	 uPddDh2eYJUVgWuXbEhXWEfgA4bEWfHChe8PxcrvJlnlqV+BU8FqhIZ9Y57FBrf53b
	 U4TMPnmQFubG+Chy8A5Gn/yEfvjJ01+ugQisg6DueJ96k9O/vG2mvz6HlgW1kvAw+j
	 pfLy398xaPT3pC2acG1uoEbjIK5Uot+XJHJahBKYQWuP5PxsYHZR9260QL/Vg4h5yJ
	 agxIP0as+jGdjMqFfPaYm261JTH8e//6aZOLtBd9SELn0B1anVWwFjC8pOc2O+gmQy
	 BVIYDeH76UdSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 732E7408D1;
	Thu, 26 Nov 2026 11:02:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 18704325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2EDF81108
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:02:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id guWc7f-HCLk6 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 11:02:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 275B080689
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=IfBiu584
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 275B080689
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:02:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B1E06020C;
 Thu, 26 Nov 2026 11:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8B81F000D2;
 Thu, 26 Nov 2026 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795690971;
 bh=2eyfT/aRfhbL10XCZG2uagDkykXnGsJO56WeVK51L0Q=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=IfBiu5842GXZPtQ0wgxbq8tujY8QIrpMSvj8ZBjB4feQFaZVtqpA9NM5dpCAVNa+E
 1660/VOKKv8yNHuqwUBoQs6tUMjmgAeB2IzOYHYxiNS1GVY2FUr2zAZsJQRfy6ZyTN
 dtH1nGnZPF2vgo6QAkiYYBhF554JXddlELwHpe++BWroJ5NtrWnpcK9dMr83CC33DC
 V4prAZK1dcLwW5f1XP0mRL3LgdbdQ0zVr7Xqja1Kv+jQU60Jm/MmjACtFIzEDUPN3O
 5sPlrdpjHYNidGJqf9Z7H8Oh2SsyrURqcoj94gHLqLaP/eE/aICw56opYt8+6lHehk
 HXH5IZTBEF1ig==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/3] fastboot: spi_flash: fix error handling
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
References: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
Date: Thu, 26 Nov 2026 12:02:47 +0100
Message-Id: <179569096703.2141121.7082789372965961756.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=423;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=Z0fIt5YVOXxotxSVWbqmvLAlbUOGL8JC9/V6Eh8sSQA=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCBHZEXbGKua9QnLX6o/egjpaCeh7F+4sj56oA
 Qv4dGVzKS6JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawgR2QAKCRAZDR20Zk4Z
 NQgFCACAX/oitJ7cgbdZhwvYWCzvXpnJ8jD6pmZQoo20rjLbNwxt9c8e9y5B3iztUuRBRmHo+fn
 T39iiUcXFbxmMQCB4bb+c/mgXe6yMvhrZkvGG9h1gZsQHgwQn8wCFjR9glSDzK3ZgIZf/ztohvP
 aX7FrohmbAx77xoj6u1LIyfEd4TDXQw/BPkv7FFeMBxdyy20RW3ndrIds+F57kjrxR+9kwEdVF3
 UlzAIGfSeZavkwkZhoIL7je+aMDl75eYRobiWK+zlU+wZaS7kfxvRyzxtna1FhfERXSPK3IYX+7
 UP7KMqa/DaaIhtky5YEpF1hWAwCU5ntE7zPAvhJr09FFet3U
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
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 11:33:09 -0600, David Lechner <dlechner@baylibre.com> wrote:
> fastboot: spi_flash: fix error handling
> 
> While working on fastboot SPI flash support on a MediaTek board, I
> managed to trigger some error paths that revealed some bugs. So here
> are some fixes.
> 
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
