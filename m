Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011F0C5AD4E
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 09:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FDC2405B3;
	Mon, 10 Aug 2026 09:46:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZPQeMSmnS-Db; Mon, 10 Aug 2026 09:46:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8E6B4059E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786355212;
	bh=iE4b6/iT62SPqUNTq0QiiCNONJZ6ik3t0PVKoWhJy5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=El3WwJTu89bnatFN+MArF8ruslVaEGOhYp4u7c/6of2r1j2Ll689GTCi5re/T3VQV
	 HIk4fnxOCiC6MQqQL7lahpVmn0FesLoCjezbAUom8kkBKETYdIqi9M0ykhQ75rpAqq
	 L2CGwHxZg698Ujxwuy6Ttoe7dFJj7+ScVIuSIgUIpcyPTZkJkTze98s3JgyzoEroZk
	 xOkbb+/xOx+mrw+S6Mxvu6LgnjSNAR3OfE+n8jJ+ybKGMwYo4Ernysys2DEaVm+H8u
	 w4kpgMB0sdbXtePflJDKs9Z3PuTMmzggr49El/5p6NQjKDAVQwlHgRyWmvcWyveMw3
	 FagF8PCZQ/tow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8E6B4059E;
	Mon, 10 Aug 2026 09:46:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 28FAD198
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A7D980CBD
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YiBW7j6Q9J20 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 09:46:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1D72B80C8A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D72B80C8A
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D72B80C8A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:46:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 116D5600AB;
 Mon, 10 Aug 2026 09:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DEE1F000E9;
 Mon, 10 Aug 2026 09:46:47 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, Igor
 Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH 4/4] doc: android: document the AVB root key source
In-Reply-To: <20260727-avb-root-key-pluggable-v1-4-7e27b2b92cc0@gmail.com>
References: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
 <20260727-avb-root-key-pluggable-v1-4-7e27b2b92cc0@gmail.com>
Date: Mon, 10 Aug 2026 11:46:45 +0200
Message-ID: <87cxvq2tq2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786355208;
 bh=iE4b6/iT62SPqUNTq0QiiCNONJZ6ik3t0PVKoWhJy5I=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Zd1BIOBJLku49QH9SXogPbDqW3E7hLDwHWWnPLw6r9moL75AKquxrkiWfkwAOTdOn
 BSNgxE0pE/bDgpw9rcEUAN2CJoEt56Dcy5Ekx86urfnjMJzsQ+odfl8K3QlJDbm1kq
 C/izAPPJmhX+avGwmXgUNC4Y5yjAIeOJB1+PoZf+K5zLykNZQIgMK1hj38FqUlrQzP
 uw/IG6EPKo6ksVFUc+MVKPjj06eHYOhGGIb376X2cF/Xvn+uJPZ/HYVBwd0Is4jF1c
 OTbIkLC4puvuYM9XFRijOZxWch57Ycylni5KvGr9jeMKroI92mwnnxSNCn4hppjv5z
 SHMvBWEGSykXg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Zd1BIOBJ
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

On Mon, Jul 27, 2026 at 19:14, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> The root-key choice carries security pitfalls that are not obvious from the
> Kconfig prompts alone: the built-in key is only a test key, a digest stored
> as a TEE persistent value is worthless unless the TA refuses to overwrite
> it while the device is unlocked, and the board provider must fail closed.
> Spell these out so an integrator does not ship an insecure default by
> accident.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
