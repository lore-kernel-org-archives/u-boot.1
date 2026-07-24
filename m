Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BC9C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 12:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D871940B29;
	Fri, 24 Jul 2026 12:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c0eb-Yhg5WHU; Fri, 24 Jul 2026 12:36:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F89840B10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784896562;
	bh=+WCnvjGmA4o6aieqSzPy59CNQL8tspPGHT3nCNwLftQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vZnZOnLIZwFWHmKA3xTmrWfs8OjCctK8UGsVkAmuGEvwf9lyufHlrdmkgAHvlYFvV
	 St4bMW7UkXQkO5TLZC7EcvdTP09aCDCKuMieLXydksZRVyZJr+OGiDtzrKpoxxw6Ar
	 kW1PzPJX+f9XxMPhR4umgxlEqk4GWbzLOYTSW9j/Q+BI2kDwWe7eJyFhANMXvi3+Dm
	 aipoMhGjV7KudbSk+blUyjGkd2850LlmoIgGEYe3c1L/QiYU/4EeqIajSVGPfBG0hK
	 gUFLDLc73EbalfIRA23zu4ojJIdFlJw3hstHRgXh86FDToK9MARkKuV8UaMFaB4QxC
	 E4QB5RTmJEIfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F89840B10;
	Fri, 24 Jul 2026 12:36:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F803429
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 557C5404CE
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id APOWV41Tkyo7 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 12:36:00 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 391DB404C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 391DB404C9
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 391DB404C9
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:36:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABE8383E76; Fri, 24 Jul 2026 14:35:57 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7210800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 14:35:55 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4882D40439;
 Fri, 24 Jul 2026 12:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A1B1F000E9;
 Fri, 24 Jul 2026 12:35:53 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH 2/2] doc: android: refresh AVB provenance and pin libavb
 reference
In-Reply-To: <20260712-avb-libavb-1-3-v1-2-44a50dfe2f23@gmail.com>
References: <20260712-avb-libavb-1-3-v1-0-44a50dfe2f23@gmail.com>
 <20260712-avb-libavb-1-3-v1-2-44a50dfe2f23@gmail.com>
Date: Fri, 24 Jul 2026 14:35:51 +0200
Message-ID: <87tspo7efs.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784896554;
 bh=+WCnvjGmA4o6aieqSzPy59CNQL8tspPGHT3nCNwLftQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=O8aVzLsrj55Q2LrVFdLqj949cGU4C3O4+GN56KkJlQHH0p8+wD8w6419UoK6/qK52
 bqr6vl4+QyUZcXaEk7N4iqB3b+6VXfSaAi4crsV3HG5UF7JfXIReptBoHgK6HOAvN2
 a5plwYUdgjrDFlVPr6QtJjsBmJI/djHKZ6+AmQZQOo2EpRXX8LgWXgTuvG0GxKpE3I
 F4gvJSRJmoDdqkEAdyhpXyVdCHgBzlXwZRvRC4cTCkmqNBW/bLHaCybJQxO1fvXQfT
 R1aoT7QOjwx2KcfCeNSMMJyYmL6fps7i2CZrmYQ/EC/V+mF1zYOawUBVOwDEtIuzrG
 FlDxVkp5P3Now==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=O8aVzLsr
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="O8aVzLsr"; 
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

Hi Igor,

Thank you for the patch.

On Sun, Jul 12, 2026 at 16:07, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> Note that verification is performed by the libavb copy vendored under
> lib/libavb/ (AVB version 1.3.0) and which parts are U-Boot-specific, and
> pin the README reference to the exact upstream commit the vendored copy
> corresponds to instead of a moving master branch.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Looks good, thanks!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
