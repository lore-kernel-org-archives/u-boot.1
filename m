Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E348DC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 12:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE65A40B21;
	Fri, 24 Jul 2026 12:44:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zs30Q3D-tBDq; Fri, 24 Jul 2026 12:44:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF88640B04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784897050;
	bh=eEg0BIPjuTX2k5OetiKowwJwBDFJzRflJWfNjIsekbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PTCe92DAI8ae1jkD6WwN0dbVEFmUeSoqWVFGTcUmAcxjLK0p+ARfUS8PyZh2f9cVa
	 wlSIvabuWYwoC7rd6326c2Ta4QYN/g+u8pdn54DFSt+Xncm9P+khG3Y13Cwyd62W4Y
	 z8Z03EHrF4gQPQPOMqbBdK6W5njCHpUKMWKDQf8nLMgN/wAc9+VJoViMIzjkp9StBU
	 7BZTz+aSQmivNLfLhsf6wJGwUA4Rhd3KYMUFFjWDIkgZDNFNMRq3XDSlrkdsPdM6Ea
	 RpmaLnHEV/ZKhl1bGJMzqpLzHuZX50SvNjM6wCkrNSW6KM2W2jm+m9e3BUdEsB0Sxg
	 Ju/e1xYOv1nUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF88640B04;
	Fri, 24 Jul 2026 12:44:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C6B04EB
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACC0960B56
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nUdUsUy5lrvo for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 12:44:07 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 99E676075B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99E676075B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99E676075B
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:44:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0A5D83E76; Fri, 24 Jul 2026 14:44:04 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41FF7800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 14:44:02 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8AF7C600AA;
 Fri, 24 Jul 2026 12:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906E31F000E9;
 Fri, 24 Jul 2026 12:43:59 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, 
 "Nicolas Belin (TI.com)" <nbelin@baylibre.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <20260712-avb-fix-memory-leaks-v1-0-51d6d5a42631@gmail.com>
References: <20260712-avb-fix-memory-leaks-v1-0-51d6d5a42631@gmail.com>
Subject: Re: [PATCH 0/2] avb: fix memory leaks in AVB 2.0 verification path
Message-Id: <178489703702.182182.14630833461060770142.b4-ty@b4>
Date: Fri, 24 Jul 2026 14:43:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784897040;
 bh=eEg0BIPjuTX2k5OetiKowwJwBDFJzRflJWfNjIsekbo=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=ZHZLEmk8irDKb4AroLbWN1C9uER++/W8iIVAWTONVfLcmV+0kO7h5mEywreo94l3e
 O2nhedh3MndQJEdD9ajSmb4o0FwiuDmvpstp35AETAvOqE3ckrLby4euo+m3qoC0yV
 sCXZp5Cc2XTLEO7/JbO84dkfMXe+KDG6yPNmRPYNlZ6gLDp0BeuThGJimhcy+4Frre
 XjtFR5EOa4TvUXcTt50ZZUM6Xn1WM7gxFhV29LYTutfKmiy6jcT9wQ6yKQqDOApSZ0
 peIy9Gn9X2Pc4ywkifdiMghCLKfsgqZvQZdY08YlenjvGe0efGvgLdgO94KSKyZjg2
 1FH0ZgP6Nz1Mg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ZHZLEmk8
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZHZLEmk8"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On Sun, 12 Jul 2026 10:50:19 +0200, Igor Opaniuk wrote:
> While reviewing the AVB 2.0 integration I noticed several memory leaks in
> the verification path that accumulate on every boot.
> 
> In the Android bootmethod, run_avb_verification() allocates an AvbOps via
> avb_ops_alloc() and receives an AvbSlotVerifyData from avb_slot_verify(),
> but frees neither on the successful return paths. Every boot therefore
> leaks the AvbOpsData structure, and with CONFIG_OPTEE_TA_AVB the leaked
> AvbOps also leaves the OP-TEE session open (it is only closed inside
> avb_ops_free()). The AvbSlotVerifyData - holding the kernel cmdline and
> loaded-partition metadata - is leaked on both the locked GREEN/OK and the
> unlocked ORANGE/ERROR_VERIFICATION success paths.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] boot: android: fix AvbOps and verify-data leaks in AVB path
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/a7f65a6b6abc7119394e1ae7f16e3c60d39166c8
[2/2] avb: free mmc_part allocated by get_partition()
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/f9c750ea306877432a525de1ebd9740ec815e5da

--
Mattijs
