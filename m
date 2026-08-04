Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3012C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 18:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1B0A80D02;
	Tue,  4 Aug 2026 18:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5NF3VWYoJmgB; Tue,  4 Aug 2026 18:13:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E044B80CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785867211;
	bh=MZj2uhYgJMI8kYbKxkmz3B+jQfekPEXdYi9MsiZ68dE=;
	h=To:From:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=brULcQ9Rb+f3++vlWOGILCZRQzSUw60WWLygbVc74pNtbcUGsbJpzr/wtTyEzY89e
	 Ljy+Nr3P1WH+mHMFWKjTf8FSYpnfQT641jjcGNZCb7Omu9tOrL2YEJeMUgqWkyyKbn
	 DJAJLPFFD2pIYAvnbthsFyIGSq52P69tShMtOk8AOGAsR/CNQB5ApGS/EYVPnS/Kuj
	 NUHCZ1Z90pQlTqFzFtAO6CfVHOD4+8ME5JNM6EZNql4fOiS+fOdXvnZuXdNyJd4K8D
	 BqSLR/0FtwawXwM9Bwuv9CAIgwHhrF8g4uxo4QMWTetqrtIusDF6GsZFYH2vT5Wzrf
	 Yw6QpA1K1f67w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E044B80CF2;
	Tue,  4 Aug 2026 18:13:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E5D52BF
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 15:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5426A40071;
 Tue,  4 Aug 2026 15:39:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id llli8Gl8kiiF; Tue,  4 Aug 2026 15:39:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=gcbu-u-boot-users@m.gmane-mx.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5242140064
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5242140064
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5242140064
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 15:39:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB6B82991; Tue,  4 Aug 2026 17:38:56 +0200 (CEST)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903FE80087
 for <u-boot@lists.denx.de>; Tue,  4 Aug 2026 17:38:54 +0200 (CEST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
 (envelope-from <gcbu-u-boot-users@m.gmane-mx.org>)
 id 1wrHED-0007As-8P
 for u-boot@lists.denx.de; Tue, 04 Aug 2026 17:38:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: u-boot@lists.denx.de
From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [PATCH 1/9] ram: rockchip: rk3568: Simplify get_info() ops
Date: Tue, 04 Aug 2026 11:38:42 -0400
Message-ID: <jwvcxvxuces.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-2-jonas@kwiboo.se>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:piOivmGlR5KV4HPW4Vy05DSnSrQ=
In-Reply-To: <20260804105721.2402406-2-jonas@kwiboo.se> (message from Jonas
 Karlman <jonas@kwiboo.se> on Tue, 4 Aug 2026 10:57:10 +0000)
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 04 Aug 2026 18:13:27 +0000
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org; spf=fail
 smtp.mailfrom=m.gmane-mx.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gcbu-u-boot-users@m.gmane-mx.org
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

> +#define PMUGRF_BASE			0xfdc20000

Could we get some comment here (or in the file header) hinting at where
the magic number comes from?


=== Stefan

