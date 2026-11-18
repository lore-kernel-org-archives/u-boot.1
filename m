Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC5606A33A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PZboZ+Xi;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCQ+5783
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20BD081148;
	Wed, 18 Nov 2026 12:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GYixOavqr9c2; Wed, 18 Nov 2026 12:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F2328113C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795003919;
	b=UC6HTjs7cFwgUUwwpLGY+McMfBkaa2PBFpbMF4L00dw3pnQEGZvYvGV96IO7OdzVPin+
	 fHr6ab4rg70Y1BZrwFX3RkXCDx5tp5O1GJSleankUkQVcODLHOCb9rc8jdoo1Oh7AIKvl
	 y2ZjnUffqZFQt9pl2RybdMlMMgeIDGYa35iCj0oewRCQR0JoU8Udskm5SBD+Vr86QVWPG
	 lyR67H42bmjkHa2x2R9fkztUQJihxvTIIEmcMSdYrLKsjeVSlKcleMKf5P25eG3chMHTW
	 rfljYyg/xVKINZKpZzT5nkWbtiQlGQIjzSKzlWSDjrsaPaQrFAAayMeNetmn4ez6DIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795003919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l53axR96sU3Q6Ev9HB3xzR/7Ni2AmNsSX80PB1Zv49M=;
	b=oubfsBEmHk/ThGNmqT37cwB1HmeSxqXwPJatlX0EUuxEYQzgarNl5JXlHmqGpaUb4rRl
	 e6GPxzAsVXrFHHActZwuDXYCCpwVrII/yh7nha9WI/bdfcz/ZUboEij45O+JcLvqTiq7p
	 tPmzrFMnCIV1dwBgkRWMrweaINhGkAfrNDMijG1RdsiJzfcX36idL7f2vFE7CW3dM/9ZB
	 1mLIDaWdoO7VZN5bpMLyw0FvfwxQbh+roE5zoLE/RJljFscJJxdc8f2rgLUVBfygefz92
	 v+R89uQo7gXpjB1cNmoEGbXHVY/cKEpgG/meKX+SaP8ibtxKq6Ckmh1u2aE7yO7Ch7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795003919;
	bh=l53axR96sU3Q6Ev9HB3xzR/7Ni2AmNsSX80PB1Zv49M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PZboZ+XiS1ef1LFrz/ziHj56jy6jqrRiMwuIxRMn1lHXJyFDKYVwMPZu1zsvVDfZ1
	 pE2bKDJvbQmZ/JfmldvOXnK11Ue/FNvgTmI2OoR2KdDMpnybI/fM92sRTElRkHJD3i
	 ME5813snJ9ExX2X5xiMDOZxW/0b3OABxSrqtULd9G/AcDoGYQ9ONG0fm27zo2padAF
	 LDyhX+MSS6oepMLniJxPG+sLGV9Nfd4Kb/0hHu3Hi19OJIfQ43mdiVaeiElnWnTiGm
	 D1MWGxG8I38k8FHY4le4taS0t+oBzLXxJ8ylvnRZREj6yMFbToE7VDXyN9Bgi2slln
	 BGJ90AHSYBXQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F2328113C;
	Wed, 18 Nov 2026 12:11:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B879D49B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D9406067D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:11:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IjqNu7oVklsC for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 12:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CCC05605F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=XCQ+5783
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CCC05605F7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:11:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0451E6216F;
 Wed, 18 Nov 2026 12:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C113D1F000C4;
 Wed, 18 Nov 2026 12:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795003914;
 bh=l53axR96sU3Q6Ev9HB3xzR/7Ni2AmNsSX80PB1Zv49M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XCQ+5783kBMecbw1hjcSvp9mEfi9NxOnM0Gccl4oe7uBkgrbbuM41lED5hj7lxB6p
 LJis/qv7nLk9aZ4ChuEqf2Jrp5bybapaS7TlnXdyzzUW5zWYQxAxFZlSTWG6pLaGbR
 B/T8+O7qWR5JnthlrIPUEl3HGh6JYYou+NvV+R1MQ393z28FQgL/jazQNDsyzGCH3q
 U1i5i2uDp8aZtYAZpIVN3gq9K+usIixo2WASoPkn2xyeDxQp37uTuC8wSBFeynWh7I
 cE1eAd1oVr98Ys7UerTQspbWoRa+IzZCQJUWYyILEANy6HUsGZTYzxdsuhPM5GLuap
 MSvkKPnGueDGQ==
From: Yixun Lan <dlan@kernel.org>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Subject: Re: [PATCH v3 0/4] Spacemit K3 enable Linux boot
Date: Wed, 18 Nov 2026 12:11:49 +0000
Message-ID: <179500382346.3537134.1583597730810690920.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116102653.36927-1-e@freeshell.de>
References: <20261116102653.36927-1-e@freeshell.de>
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


On Mon, 16 Nov 2026 02:26:26 -0800, E Shattow wrote:
> Adopt some fixes needed for Linux v7.2.10+ boot and enable
> BOOTSTD_FULL together with minimal env addr variable defaults.
> 
> Build and test only with vendor BSP k3-br-v1.0.10 having reduced [1]
> configuration to avoid a memory resource conflict. The vendor BSP SPL
> in its default configuration attempts to load opensbi separately from
> u-boot main app, and also attempts to load an embedded controller OS
> image, neither of which is useful for mainline opensbi, mainline
> Linux, and mainline U-Boot.
> 
> [...]

Applied, thanks! Queued in SpacemiT custodian tree, for-main branch

[1/4] riscv: dts: spacemit: k3: override reserved status of mimsic and maplic
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/04b254b7484006f5870ceacdb6c545a7c3b4d8b6
[2/4] riscv: dts: spacemit: k3: Drop guest properties from M-level IMSIC
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/b77730ecf6b0e977d857c38a397a48014e7c77ab
[3/4] configs: spacemit: k3: enable CONFIG_BOOTSTD_FULL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/6a8ea4096ab5973e5a4621580dfbc267f10c8cec
[4/4] riscv: dts: spacemit: k3: adopt com260/pico-itx 8gb memory override
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/ffdf122644c936510b74a26390b694ed4cdfa1c6

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
