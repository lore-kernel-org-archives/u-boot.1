Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA06606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zulfTrKk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDI5VMkT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A964240556;
	Wed, 18 Nov 2026 06:14:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eMNuCnFUcMM6; Wed, 18 Nov 2026 06:14:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DEB734055C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794982488;
	b=FkoDR5+XnWurTzwYYYac+jpkTsNLiFggiRas6zEYxKuGjx1j163NnjYB/1/TMYSuOj74
	 TAdzOWLRNxvpgG5YwmvFVjTVNQVM/FtP1MRfxkvVE+9AHvoFlOWd1eML8w20bEwdS5BZJ
	 FXs2/XhKgG2aOhcp7Hjk6+7MWZACjMyNhRMvPHm5+4sP17m5/4Ob+PLOvo+Nhk8VLZTmx
	 Zl6/4/tHIPw31WYx90a8lzamApjBi59ZMiOtBvBfRLoFzxnh1yzD/D5ktBdakyPNYKGI0
	 atAaLR0bnLQX4+k1lQIWkf61JWLPkVlwc8raOie6gi91erRXXqh646kiOjcG6+BYevA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794982488;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7Ag6BJHUpOQ+4kPjAGynrEjVng3oQ1mzGwldOmk08Bs=;
	b=nNwjz06WMLEDRCS6lzkLs++ApGKTDSgqEo4t2HK30e91+hoiruP9U8DEzZGVd+1YOQxZ
	 DQRFtMSkNGzbYva34xMn4W66CdKSyeD3t5LCKAdWNIvL+8HKEAeeExabr0WBHy54KTpnU
	 Oii+vfolZjJRmBZDXJch0GEIa+I6tCCvVW6siL6zayRwtySSUAxLCoZshol3Ao2p4BmLZ
	 P33pV3ZxPXncXx6c9tt1G9xqyo1zQF2tQk+y7L7n1/+iXmf9Ummg6Dfh4Jy9g2Ms16C9b
	 dX0SEsM7uX4cPOkOfsrzKBLVGAH7/Oo7xsbYi7ECZMKyV+sTKOhhlXfoUNqeJdEuD0Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794982488;
	bh=7Ag6BJHUpOQ+4kPjAGynrEjVng3oQ1mzGwldOmk08Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zulfTrKkX0T67Wm89I0LhMA88ygnbgIxg6Vo2voqZ9QHMu94Q2xTkxLY25qk96NIH
	 6/WCzf4CExMm8RxSODi4sxcQkZdx968DK3loBo7aMA/senZzwPh01ZgpweVzD5FFx4
	 /i7baG61cZlntbomf6jslrUk2NV6MiXznMCz5DTUK5T8XKAfu4F/4ViCorHDzoKxfW
	 UI9ssnhwx931swwuBXZ1WsI/GbFZKlT4JeGM9PxBTKHsMdgiF6/z4HJDuzIVDS667F
	 QDWE9Kqie4poO/DG8enBASEveimhQxry/AH/MhvNreIXul0+j7zyDDga472I1dBFNg
	 uOBaUkJ9815MQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEB734055C;
	Wed, 18 Nov 2026 06:14:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E818A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:14:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30F406081D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:14:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wYlXkEHb5bnn for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 06:14:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4826E6077B
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DDI5VMkT
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4826E6077B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:14:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3BCB60D18;
 Wed, 18 Nov 2026 06:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8461F000C5;
 Wed, 18 Nov 2026 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794982483;
 bh=7Ag6BJHUpOQ+4kPjAGynrEjVng3oQ1mzGwldOmk08Bs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DDI5VMkTf5MTtUZbpLel8C/V+Kkmcm6ORqK++qy6/2I+cWJ93Wvud5ae5UP3c2V+j
 94iD9mZ9GVj2KgDB3VMq1IIKJb2UIRByTHLLZS2WAhhvoDC5wzq6dQzmBxp9HdgZsD
 JJxMhgcJ+mlpDlCNj+81Yha2l82rDLw/+MSHOqc4VzyaVJCnBrqcgvG98Zy9UJq8va
 /ZcTXIABzizp0FrNJ/QdTw5qT0l1TjgPpNMWm2rMsdnxIv9v/dT7LjT52Yz/OxF+vQ
 jBEXXxE1zBRe7PkngFnlTefUIksN7CRYaDraaq+TNdL0NT5Mt9jYqWk55Zy2bQhVG0
 KPbnDdmBi/9WA==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Yixun Lan <dlan@kernel.org>
Cc: Bruno Banelli <bbanelli@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Tom Rini <trini@konsulko.com>, Guodong Xu <docular.xu@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: Re: [PATCH v3] board: spacemit: k1: Add the M1 Jupiter's product name
Date: Wed, 18 Nov 2026 06:14:30 +0000
Message-ID: <179498227045.3363424.1268020469660595506.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117-04-k1-milkv-m1-prefix-v3-1-18e3bcdda11f@kernel.org>
References: <20261117-04-k1-milkv-m1-prefix-v3-1-18e3bcdda11f@kernel.org>
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


On Tue, 17 Nov 2026 02:53:39 +0000, Yixun Lan wrote:
> With K1 board map, it will derive the device tree name from the TLV
> product name held in the board EEPROM, and problem here is that it
> only recognises boards whose product name starts with "k1-x_".
> 
> Boards fitted with the higher-binned M1 part report an "m1-x_" prefix
> instead. On those, fdt_name is left empty and the function silently
> falls back to default device tree which defined in the config option
> of CONFIG_DEFAULT_DEVICE_TREE ("k1-musepi-pro"), so an M1 board selects
> the wrong device tree with no error or warning.
> 
> [...]

Applied, thanks! Queued in SpacemiT custodian tree, for-main branch

[1/1] board: spacemit: k1: Add the M1 Jupiter's product name
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/76e0d868ef47bf731ba62115de24fad91a5f81d0

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
