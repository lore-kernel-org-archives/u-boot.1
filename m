Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14475EE49A3
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 723D986F9B;
	Sat, 19 Aug 2023 16:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uH3rqsqA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ePTGIDQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 076FF86FCA; Sat, 19 Aug 2023 16:32:29 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C4B086C55
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 16:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RSh621HzZz9sq9;
 Sat, 19 Aug 2023 16:32:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692455546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VdjnZQwiEEQ9PFYTlmiF6x2lMDBqYrUaB/6QGG7qRA=;
 b=uH3rqsqAOw0wTsrIwIA4bsz9Fm/24ujfW3tn3wOdgx1zdr4I848gRdpQB+g22zs8+nNg4I
 nn2gmrOaBFJCsuP3hbGz6M0idIJxCbcjuxt1DAqmuuIhHBcHRsUrBAQcHrJbjtQHhNwrLb
 Dp4F6bqnA02kgg3GKQeJ11qUMycgaujdOLyI12aM2JDPlaQOOuxSN1ZQIxPiaSLvGg4buB
 +je5i3IMj8b/wQbAbRMig2L2lRjsMTn2Jpy3v4NGwJyEvcK8SB7L+5/foRgtvNQtw1LdcP
 GGIb86wA1MmJxm0MqNUqdqIv3z+mezXx1W0ZDd4jM92SyTrULgFD74fdAAlBew==
Message-ID: <f109e868-48cc-72df-f9f1-02e24a6d1627@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692455543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VdjnZQwiEEQ9PFYTlmiF6x2lMDBqYrUaB/6QGG7qRA=;
 b=ePTGIDQW593TjEo0wnNBGtMm/rnXrIhYhEKxZWAqHdepnI3XyVjJyAPy4J9Q+AEfZyUm39
 SuHo+U7mFz++D2HBEw86g1Iv9iw5yEggFj0rNvjzIBIA7whw8afMd9wTkaO4AfzOw9/8NW
 b46HQjTyeaBqetBi3TZkHrwpIubQqnGgI5PevxzmoDhI00emdESLWNL7Qli/+0eJa/f8ER
 Po3MxTyzdzVbhr8H/7GB9lfD+Ugwt8T1/5Xzc6r+PixtsPNBXS6C05nqaVf6l16qqowja5
 e3hlTX8V7ceGuZMRMh4IlXs9AVU/FLqlrskTIBqPQT9by32W0gto+RCRm2jNeA==
Date: Sat, 19 Aug 2023 16:32:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: rmobile: Fix off-by-one error in cpuinfo
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
References: <20230818131721.25262-1-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230818131721.25262-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f306438056b787a5b6a
X-MBO-RS-META: 7so8zw344tics71ytdhuwiy94pae8ujr
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/18/23 15:17, Paul Barker wrote:
> In rmobile_cpuinfo_idx() there is an off-by-one error in accessing the
> rmobile_cpuinfo array.
> 
> At the end of the loop, i is equal to the array size, i.e.
> rmobile_cpuinfo[i] accesses one entry past the end of the array. The
> last entry in the array is a fallback value so the loop should count to
> ARRAY_SIZE(rmobile_cpuinfo) - 1 instead, this will leave i equal to the
> index of the fallback value if no match is found.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
