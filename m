Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A726606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oi1Qs8pn;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tq48aL9k
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 668DD405D2;
	Sun,  1 Nov 2026 21:05:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O4rgHtG2n3wY; Sun,  1 Nov 2026 21:05:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 941BB405E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567153;
	b=RI6RtVTLAjIs08cEGL1tTSgXofUW169PtoO3nRvPYw5Mv1axQcpWv6O6w6oJzMYOfrJ8
	 IPwu5H7c0h9azs/LdUSdpIc/HRsnONLUAHMDHab4fYQ+n+O+sWHDtGSq4gUvumz5mK3rf
	 iqy8MlicafNDvthaRhprbXXSbaf2iPOjkxKcKwS0d8KT6/EtGF3zCxNAmd2mEylzWoGVM
	 5KqMP8g+vwHa4M5hISO1nHT2fGsGQrySwb0SR/g8roPCfKSn6N591cESTOwzZNtTBNeUS
	 nNfAJMR7SHE6tOlYA+Tgz97kc06CLF4pywQog0B7fZjqFn/S8Z/X9fzhlgxaSbSotjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567153;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FdJjJFkz99uNZVfZbCmy/qjvpPPfHtj7Cwiv55QDsgU=;
	b=dx6w2FvF2EkefO9GjVz0eWSKWLdemdgokr6KFMIncl1K43UkIG6DedwAjGK60ZLjnN57
	 sdUGw9sswZcDShITu7SIvN3K8Z4TotaV9Lf0fwJb5OLQFhcdQIjjr2QcSsELbvWirfWwC
	 0FUQLjGY/lkwmlBbsvAEY6MjX4Nd3p/rAS2QnWpxQAGuCQtNFyfbVS9FcxNWTbhW6nTJD
	 n4J4pLfji9WmtX6RLhktoavmUsFZZDSvUh5JZEfB0VsTow5h5WK+0BcoPZ7O2xp12cGiJ
	 eagQO5f2uUpzk0nTuHnA/m6L5hWGaIHfqQNsJU9TcFLD4mhPe24eoxu+UgZON+IgP6w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567153;
	bh=FdJjJFkz99uNZVfZbCmy/qjvpPPfHtj7Cwiv55QDsgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oi1Qs8pnmqKG+5ubl1sHyCUvw6rOawQ8Z9AlU4VFvUUiHukUUJMxkX8JnNxzEnBKb
	 KFXOQJqSqfFFliZyKCfgprVbEHVrEEfTwOHq9kNBREtJbULOoWKRa9UP2dprJ3pkar
	 MrD+PlRDIfiaPbsZeTXEAmDCIH1hZEmNPK6xDED6iJ/U+G4gWIOB2zL0L0SrYMSzBj
	 o0uSoCIbzYwkvDkRrsefmB85OdGAKeSLYuGeRdruYp+U1wkZTkmGcnX3dFD0sd7AsD
	 5AxjrCEuORE7DKI6BqKEhdkIhgTw1kjlyXEh9LvzJpRqZGeK8ogxLYy4RWI1IPZbBB
	 fzOlgWfRBEnyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 941BB405E2;
	Sun,  1 Nov 2026 21:05:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9213F323
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 778614004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mb3xBj3_IvZX for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:05:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9A5A840042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793567152;
 b=Y/S3O6qwKynPNunw1KTH4F3cjVxqmTkOll3vniJxDZqA0jHc+nU0hrhUAR448t+9kfMf
 OLGifxCdYcaDYF1YDez/bi2HBZxP0/IAdFbbUKIPMHMMOhFACP8hBA2pD+oFsrThIya4m
 hsgPtxoVWAowq4WDhnKBm38CWzsXmD+b9ZtinK1hXPnpBp/lA+zLK9uVLefsfuHOJwoCU
 5q828nhuEPzsMW9hIPpF5dY4RA9InI0bstEMcyFk98/qxZAKtIXEqdlFWveioVZFF4XhB
 Ln0kGqzw27kUJdz5zIaZ4ZTjIc8y+yPiKAI/kCkIOmXomero55cCHEb2HNtMXnMd1nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793567152;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=FdJjJFkz99uNZVfZbCmy/qjvpPPfHtj7Cwiv55QDsgU=;
 b=ssE95+Nmfl2VIkIjx6buqSNn6BBSEk2ZtAynODMhIfnJFeBNVAtibwXjobG+6jjGJsx4
 KdNH8lw+jL9PeOh9PkQmXjhdyvqHIP6pvwxxZh3sqgksFfljLbWOJW5hdDJRB8+2pHz4T
 ByCHD1LnCYUJFy3LrVIKYnJRF4SZuISMY/Z56hwNLQdaBeK1od0MUzZkeiF7QV8zLiBXB
 avfDaeMHqOStftUV+H3OHW5qFm9R8AglKqsx1tmCECm3Wc7nBuYry4ItS+3yS2a89MN7C
 2at2H5VT/cGTrxfriZWG7GOj/vsCA9eEvbrB6zWkhsgHyloierG1Se+euICOnUcyMRw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Tq48aL9k; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22b; helo=mail-lj1-x22b.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Tq48aL9k
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A5A840042
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:51 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-3ac91f5aa89so22217641fa.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793567149; x=1794171949;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FdJjJFkz99uNZVfZbCmy/qjvpPPfHtj7Cwiv55QDsgU=;
 b=Tq48aL9ke0jhr9AvYIzpWwIEqhhrmOcmmpqC9XnlDiSLqOYulEWiwv1llXe2AAb4yx
 4glJcpXX0oCFcjA7RCKsDoffIddJKGOvI/CHb6TERFVmhyWjjd2ETZrVVR5YOEqe0pqV
 Uaum4Eqbqlua5HbRkw4ApDh6VTftqe7x19H+rjWTTyifkHTqDZc7m3Gu4eDcmtBJoAGv
 T0JgM1iekxJ2/Z/FbrxJjWfG+WV32z4g5xAD4bg1DcnMpb6YwZd8nseAc1zPHn+whRd/
 nGCGsMDW4FFQhLK77B33DsxQDbNDXSgqtdXFnMt0N8HBX8eQGCSO2GvYtlL1dlski9Iz
 XBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793567149; x=1794171949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FdJjJFkz99uNZVfZbCmy/qjvpPPfHtj7Cwiv55QDsgU=;
 b=oGewf0RK0ZISyXLs/1BYgYFon5tvQcSnf0qAs9TpJabHVDB5yiQ9z+SwHLUiE/Xct9
 o6Kf9ShQer3cdO4OWdE8v5uoIppyAoH4RBAWdqrIgxY05Lq73RyJWVXAEjvDDAZUcWzo
 ddjDiVcXyhaWBmFRSxPYLPtuafi769gTMHwwMthsK6Kk2uZlhV1PzNTlr8G+EM3drwUP
 I+RR4pWXsoBIZzIeia1F2+trZpKJBYT88UV4pC1tyFhB8ZszMlywrapAJEl3NVGcMwl1
 QWovbo8fLVvT3NqwXPsCy9X3ZRGX0NvMkZOeezICcoO82zQM7LMFoPBEZncts3H+b1++
 7E9w==
X-Gm-Message-State: APuU4Z8ZXRXkIhqkdZhHiht4Xoi9ELbIOeFg7pijs93vdNMZT6FkjtQP
 PNCWKbQC7ZbwkNZnJ2oWJmZAn0kk90YAcqyWrcJmkteqz1xrhIndmYczrCCGg50y
X-Gm-Gg: AYBFou1kh8TKHl7ujqU+h1dZ8C6Te/snP6DNQWiGg7d3RqNhPxkr7ngZHIJH5wjmzDA
 zjQC0fnD6DaKYRf4lUTqwx3KF94ySsdrX0lr+OMy1wJKaKJfAnZI8HtEYhTiN3md1tmx7FN8O31
 d7ZcUbveHfKICkZ8d8+TG8TZzUPJlYGoDIdnM1A4+KE47KUTAGwRRjV6UOhhAbJSLTV249wyHAh
 AZXU8DfcNKy4fosb8T1NI0lbrbH//QNorw8emtDMxrtMhQsu/jzW1Cg7NvltKTM0L6kgWhccGKB
 SMb7C7qrRwVFTQtpJxS3OfAarwDHcPM6NRZI8Fsc+xcFZoUTTsBb1SCtsjuABiQ0fq0ldR05foa
 D6m7qxihi5PF2OfDgccaRTHf4al6or6yoUSRKDchxWVPtmO/dCSTcp2xd16FJjmc56jV0iYGKBf
 m14AKscSAUR1+5Urk1qHp8ik7eRnykdnDsPvDlxrmKBOjbZjogredwkjly8WNTM8WeI26WIP0yW
 XLkyKBrl76CaDwL4suWbIhWLPx9WfKypd/8zljbr7w8nlulThh1wHiI6aPET1eLOpNxrm6duVYb
 QmCgvsWA+dfms9cuWN0XwCvrlDGDcxRe3bgXPzy0W+De6IBxGSBeF4oLIDRffSiL6B4=
X-Received: by 2002:a05:651c:1602:b0:3aa:f42a:b78 with SMTP id
 38308e7fff4ca-3acb7b378e8mr20171281fa.20.1793567148921; 
 Sun, 01 Nov 2026 13:05:48 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3acbbee0094sm19882441fa.20.2026.11.01.13.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:05:45 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 06/10] sunxi: dram: no AC remapping on the co-packaged DRAM
 parts
Date: Sun,  1 Nov 2026 23:04:45 +0200
Message-ID: <20261101210449.1235102-7-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PHY AC remapping tables compensate for the drive strength of the
DRAM chips connected to the SoC. This compensation must be skipped
when the DRAM is integrated on-die.

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 drivers/ram/sunxi/dram_sun20i_d1.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
index f098329e891..2d81e58071c 100644
--- a/drivers/ram/sunxi/dram_sun20i_d1.c
+++ b/drivers/ram/sunxi/dram_sun20i_d1.c
@@ -690,8 +690,13 @@ static void mctl_phy_ac_remapping(const dram_para_t *para,
 	debug("DDR efuse: 0x%x\n", fuse);
 	debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());
 
-	/* No remapping needed on T113-s4 with 256MB co-packaged DRAM */
-	if (sid_read_soc_chipid() == SUNXI_CHIPID_T113M4020DC0)
+	/*
+	 * No remapping needed on the chips with the DRAM die in the package:
+	 * the T113-s4 with 256MB, and the D1s and F133-A.
+	 */
+	if (sid_read_soc_chipid() == SUNXI_CHIPID_T113M4020DC0 ||
+	    sid_read_soc_chipid() == SUNXI_CHIPID_D1S ||
+	    sid_read_soc_chipid() == SUNXI_CHIPID_F133A)
 		return;
 
 	if (para->dram_type == SUNXI_DRAM_TYPE_DDR2) {
-- 
2.43.0

