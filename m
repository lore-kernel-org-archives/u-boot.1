Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDEDCA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 10:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 775C460776;
	Tue, 29 Sep 2026 10:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SS8IbHTvXO2Y; Tue, 29 Sep 2026 10:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9025F60729
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790676775;
	b=rOELriER/U+blr0W7iaK3csednFRphF+VtS3LT6rEKnixhi6IBLq9G/4yq7oEv7osO8M
	 7oGg1WJ3JH6KlkVaI3EfA0Hcd+NhMICBCm/CkcTrQKVpV4ZRO101XMeakWULRaXf15cz6
	 SVhRPCXbUk5gygRxB7Cnrxmi4Y9eFC1IUWZJ7zjOlYONmFmLbUQ//mJlZxW5urinGL5fV
	 FgPE0h+VBLXxPmlYWTFcdKzGzdKGsvU3BOvjphjccqjFApEBJ3joF/iA+e54yATaeNq4O
	 u89vF7BIf5AlaYYenepbkK8DedQlqFNnz7wc54fvMvuHJpozHINSIxNze4xL9U9cbRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790676775;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CtErv9/U9NYv3hO2C9u8PbdSCriAKL+wz3W3B80YBVU=;
	b=hUoZLAKB1XtLvWOm3ad+DzF8vV8ZxgPW63A5aVr8U2D/hiEbG8EXM+BxxiqWtIy5TG6o
	 jkhyPYJeuy6TjcCaTQ2ePIOZ+MpqGAQLhtAb0XErFUV1I6rrkN+odAhuEVZH7i4Thh6ti
	 7T1bOCHFAc43cqMiS0akycS/jRCdBZkAl3ZQXY8Hq9xXVRCFVw/FOPJoGv3e156Ra5Frt
	 Njbahmr0TjYtjEFRyj+DThliOidTLpQ1nxpEsJx28bvon94U1D+OxGMpStsFuCItdmAyC
	 T65OhQy4MXrN+BdcW8pGedsj5MzQJfkwak6nDnWaNae7jI4QlOph2bpzUV7M73XHGpg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNhkOki4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790676775;
	bh=CtErv9/U9NYv3hO2C9u8PbdSCriAKL+wz3W3B80YBVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u5Sk5Meg2kfSO93mG9oGCRciEpfjLHeHTAXw3mUDq8m+/O9bzUWpBQEmCHT74LnIo
	 j4HgLdP2H0Zex69WseNnegFbJnrf4SsJupiF+4cH+eaW69nMFy7X+hOOW7Pc4O3Tdi
	 YXMRSp7jvAqJ0ixA7oGcPqCpOYvVo0E/m/j09T80AlGWnkbilQiRb/DSxJAnACicQS
	 beN68M7EpdI4PyuBPHDPTrN4GjnCMqL2SPAkOQ2EJXgWoQsX01uj+cEa6XCD/ivmbb
	 gmiJ8quYzERhbJZdOWGLVhxEKWKbuC2Ph8kg90XoHteVqdFFzswzaslNbWFrC1b9Bf
	 QcrsVRAr2RN/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9025F60729;
	Tue, 29 Sep 2026 10:12:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 595A761
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B57660729
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fUlbk77gzz1e for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 10:12:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 876B1605E5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790676773;
 b=oZZC3YMKtED3OycURoDgsU8W3mw3eucEnaUu9RL2FTl7LkFqiPAV15aVXEu/6ruA+lR7
 YH8KoVrE8wis8NtrlwfEODY4/2P0ekosPZa0ELO+aO7lEow2/GsxXE3vcIfdkXCzxa3Tx
 L3kRb8Kb8CKUsmjb2xzt4HeU3P7lXykreHpGnYEXhkZuhxTqUH7wxjkUMQr305TriGFo1
 tY7vmRwEghFbmfAsF73mNrOfpqLxwE3HLeQelteMRaMMGhHrTU4iJhtUVN6DUTdxYDekR
 gugyjthD/OouY0lzSFYmeSCAhR6EBGrCbNS8uhU8BuxCaXzt5AKgzzScyWU5Fo/aJEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790676773;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=CtErv9/U9NYv3hO2C9u8PbdSCriAKL+wz3W3B80YBVU=;
 b=emMzPCDEWFtXUxJRLHaL3gCzWgR68VA8givuNSkF49mrY2GkguCKV7WwruX27S3Vgf9C
 5AtKG5kn3IDSnOnAEd09Efiuq7ZAU0lH+AwVtAbVELKM4sd3+fnRrjpO6MlIB+R3SGOaI
 WUio7FG9nKvexnUBpgOWu1NFgUYEF7Q6owUL7rs2Er+dfFpyEPxTAUemGdcTUuS4iKziy
 dtRxm7aUw30B55//bipg6Q5zHSQ2zC2TZilZv/UmJibogKu/cbpE6reOex2j4svfLi3ET
 0VTl/y5xoVueMfXc/w3EOZozv7hHL82JzpI9Afuo8AEPvR3sHR1UVHL22/CEdekCIXQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QNhkOki4; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=QNhkOki4
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 876B1605E5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:12:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C71EB60008;
 Tue, 29 Sep 2026 10:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE451F00893;
 Tue, 29 Sep 2026 10:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790676771;
 bh=CtErv9/U9NYv3hO2C9u8PbdSCriAKL+wz3W3B80YBVU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QNhkOki4NO9UgY9kHZiNPe5JlNp78Gp4ZsbAJAc7I766j33eDicHp4abbUrKJsqE9
 K86eK0sdxUj2cBTLjsIwsOpawup7aC6fDkAdK0zbu/33Txfdns784FKytaPMJ2lUyG
 qnpTseyvl79zdcSS4SEn3vLQQ+Cl0bca7NYhIhrdtvL/mccitaxgQLxK8a3rByBqI/
 gA9Au3T1Ow23y5vtAT/aFjRV5uVAf/eaORnn2AFTVgQYimjdPEVXjbKw8cGAhJg5FS
 crB20IG9uoGTxFESBGFEesacAHnCHBuNRxHl1Ghm6sGV+DknC8ECD88fQMULZUg5hq
 dSZ4+C5BHAxKQ==
From: Yixun Lan <dlan@kernel.org>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Yixun Lan <dlan@kernel.org>
Cc: Eric Chung <eric.chung@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>
Subject: Re: (subset) [PATCH v2 0/2] riscv: spacemit: add pinctrl support for
 K3 SoC
Date: Tue, 29 Sep 2026 10:12:47 +0000
Message-ID: <179067671693.1558921.13077478132543076365.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org>
References: <20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


On Wed, 23 Sep 2026 13:06:51 +0000, Yixun Lan wrote:
> The pinctrl controller of SpacemiT K3 SoC changed its register BIT
> layout definition comparing to old K1 SoC, has different IO
> power-domain tables, and extend drive strength bits to 4.
> 
> First patch fix drive strength configuration for external-voltage
> IO pins.
> 
> [...]

Applied, thanks!

[1/2] pinctrl: spacemit: configure drive strength based on power source
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/d6a1d4c0723b5ba83dc64c416a9f84b471f41fbd

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
