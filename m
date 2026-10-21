Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C786606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XwcJCq5Y;
	dkim=temperror header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=aa6i7nHh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF53140801;
	Wed, 21 Oct 2026 15:43:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vrqs6U8kzxMu; Wed, 21 Oct 2026 15:43:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C59E1406F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792597384;
	b=UcAQDi0Qb8L9IqV5LMai2LoYINSGsCuDp8p9pl6v+WhI4IyxKNkKDxGEpD8mHeqxqg5b
	 ool55ATB+aNC2NR8syvmjgYDecXS/+h7w/SbZoitnRLUNao8G2mueGzaKUWQMHGDJhZdb
	 x9SWSGmQW+Ur1zdxGaYfczR8obn2NUX8vbSy+S5W+4/7omCNZp81WSYos8tudwI0/Xfe3
	 cStk+P+KlzsGCLrYZXiZ23a3MeXXCxL32YGJivVhNGibvR9NhFlvVEfulZEH5J8aUcKCA
	 fEsRSR9NhsdNbuLe9QUnsWcycoZY/4vEn8HJGhWTsEBszgw23et87uKXuXvT7/TvPtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792597384;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5nj75TgFEeYKUbgN4OnvkBTNIxYw++iplFEpl810Upc=;
	b=duYbyWb6LcTpsga3tRHqXS6rdxtqHCix39klaMNSj3M01n9Y0esDsjIgBASjDWl+spc+
	 C/x+cfgVYZ8FkDtNxgODq5qdvkpoHRFHeHU8EZ+dp5gWNGE9IU/8zrzXUy7imbD1oesRp
	 Fyj+QxZJ1uADpkqCUzAcJehXoS2p8fVAbs0wkz8tSE1K5pFWbj6MHS+6ZYsKd8gsKNggy
	 +gEm53fIC3YIY5lrQgiMakeOZNw8E6fe4M6PX5BLqwxRx25EgBbkPpz04zegNQAmITQpa
	 P05ZDvY+P8xP8bSmyAOSCnsz2IK5rW3a64OtmCNuHAqV51tXnhxCcVsZAlYpIwOHShw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792597384;
	bh=5nj75TgFEeYKUbgN4OnvkBTNIxYw++iplFEpl810Upc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XwcJCq5Y/EBLO3s/8x0AkQRrn3WcLPcQYlmdEnGrbMnTy1KITyjPNJahzYfeIe2m/
	 r7azBvnUGg1PCDcNANXFpSbEapEh+XBEXz/wy/HUb2sxCjzUdSt9c+uYkaeeq03skV
	 whPXL//OTlxnNMfoaSclw/oUu0ANFigNR++9k9RQMkpHTiuhJfKaxiigDsYxKIqFi/
	 vtpGqz7DIJKucmzkyq4tnxLZLXLgl7o6RVi1PYxkkgwt8yIXiGiS+WMvD9Vy9TmQGR
	 dcPondi/+1WAYXY8pBNtpt7WtczWel141ZfN8b3GZl56phWCAnj0+4QOMX/nbtM0Ws
	 /oAlKgRM8bkcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C59E1406F9;
	Wed, 21 Oct 2026 15:43:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E791769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7FE4F4016B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:43:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 34cWKmdVMIoC for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 15:43:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 20A1B40077
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792597382;
 b=U/k1LylG8+Wb4df1Zn4eM9qya/R0pEVDKRDvVIYUtlfAtT/MTXqzcdTJJ629qP815mPZ
 N7wsWCGTc7ZK2R5/uPswyrvv9/rGwtVqHsNodmnC4W00d9j1mRm2FEUKEUejpoQNFB9uR
 k5VBAF2ZrVJA1p2s6VviybXe3nKi5UnVqmFD7QGYlpMdrvNpXDuNY/4oR/JOYFUCuP3GY
 Tl1P9ONIugb05KIBXvx/jgbeQDCfNR7sCuGQgmo5eS4oUh1P6rR2klZlVT1ExVwllkue1
 cmmqgRTSs0SDTKTZBOcAD8IFXgBu+NjfdagEQiKsCLHrurveTbk63PDzDlc9uMDxtfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792597382;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=5nj75TgFEeYKUbgN4OnvkBTNIxYw++iplFEpl810Upc=;
 b=bReU8SxlwSL5y3n4NoQeo44mzqykx99ZlWLP9eKpo1+f1xrnokGb83AzHOZzST2iyNd+
 cSry/JDwFGe++pa2OFVzrSys6+jyTtA+aY7/fiyObVA0GxMcqXb+YEIPvF8bYMrVrJwDr
 LbQLA0Ts85rcwIye7xMiSgXnSL8YHYFJtP7gkxMtQTnOtRVqV+y8eR5NayUECcZpdmPLH
 LJXTG8F6JTM8yVWtB++Kz/rT18heAMpYGIe2KR2RIbi7m97s/aZorhEMG7nnsZTnbgXZJ
 RPRRxuAxAX1t4Ji9Sgk8c/wNeiS57ll4MyG9IKdfJ2rCTN0FHCykTluaycOh5IHYehw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=aa6i7nHh; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=aa6i7nHh
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20A1B40077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792597369;
 bh=5nj75TgFEeYKUbgN4OnvkBTNIxYw++iplFEpl810Upc=;
 h=From:To:Cc:Subject:Date:From;
 b=aa6i7nHhOQIddiz2no92XW1ieoWTIhO/Sw3AUPtSgCBjVIYong0rM6M+66dRfBcyr
 LOaMi734vvZYQM5ROh9SVRaIi6gnn0JWbW/0c03Wu4tm2DhSbsZgAiefw6rw6Mypxn
 5AUQmXlgn5nJaTi6smprxxY2Bnaly6eLTOXF+dM2/tkE/mOuA+Vxzam+i9AfrjrvUN
 DvFKptkp0qtkYWqNwXRhVrs3dracNXZQU/ZcKPGGr86zwlGCaVmURNDi+ecmk/ihC9
 EzYU2+JDxCm97G40jO4cMO6LxAe21snMUO7UykAVel0Ecdf5owv+lGxfVvN2efVt2T
 DxWXTsClT5I3A==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id DF3E5B2202AB;
 Wed, 21 Oct 2026 17:42:48 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org,
	Yixun Lan <dlan@kernel.org>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v2 0/1] Enable eeprom tlv command for SpacemiT K3 in main app
Date: Wed, 21 Oct 2026 08:42:14 -0700
Message-ID: <20261021154226.1391944-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A few commits that have the required eeprom nodes landed recently with
the import of Linux v7.3 devicetree-rebasing to U-Boot dts subtree, so
let's enable the eeprom tlv command in SpacemiT K3 config. There's not
any SPL in-tree so don't worry yet about implementing such hooks or
config options.

Changes since v1:

- Drop cherry-picked dts subtree patches 1,2,3 now redundant 
- Patch 4 => 1 and apply tags

E Shattow (1):
  configs: spacemit: k3: enable eeprom tlv command in main app

 configs/spacemit_k3_defconfig | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
-- 
2.53.0

