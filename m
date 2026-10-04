Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53604CA5FEC
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 21:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFA97406BF;
	Sun,  4 Oct 2026 21:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YHUp5p6uZi7N; Sun,  4 Oct 2026 21:14:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4499E40607
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791148442;
	b=njrJSIkTVllRbbXphpAbojiB057HdGCd/Nifme5FQFuPFtzqKgiJJSWNZWxr1iB+pDBk
	 PSqxg2WdOAwoF7kWawOw1YXnOTQzC3NeWGWC0MfjfiHmSyEAKLj3sTY2sLTyKpe6E8kwf
	 DKIqjd39POQxNpbBeLGmfWpnLw9jnKM2h9TLoysd5/spC44QuQItKR6jz55fdUzYV4UOu
	 /joc7q0wr2Y3EoH1ivTAxg3vSV7XdNL3ZljVjcux2gXPsW06qMM2FAIq0TlmT/hUzDLy3
	 kIpcNzObFHm+LAHWIRmm9lMwMjA4xD2xSk4tbwkB2Cf9JpQt52fJcLSSZqv59fOg+Zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791148442;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3+eLQc/a5VoJElO/G6o0B8fy6fDmIogHir7DrMqcxPI=;
	b=iG4VWg5vXNz8ddaLWstv+mxDxpPATD/VYR/DOKp7j6tuiU29OpANtuwA/EBD9rRpky1k
	 wsbwJmLvqvDHz/MLk0v6QBGvl3Nchvi8CfSkd1h9BS4lfaixgF0NBTajtg20x6UY3PBYL
	 UP4D78c8QtC5TenN4A2losP62JZCvJIBDqD3kFbjwYl++kA50oQKaTZR9xQMEHajkmpsb
	 U23gzChuMegaBM3OSsbkysJ+kEJ3nll4qREKW7q0vEdnSIEbezicICo8utQFGQKkhwQOI
	 i43oeAUJxh3+h+ZU39CiF4cs/h3OX6Rlhp//3x9iNaQsZ/2GG8H9iqDv/m6K6Eqx/AA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791148442;
	bh=3+eLQc/a5VoJElO/G6o0B8fy6fDmIogHir7DrMqcxPI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MH0NqwLUbY8nmaNG/VypPXUQoQ66I/FNffRPMLuxljf6jLvznm5tZ2H7Bmqr6s33p
	 +sDr75/aYsYwQVRybGcplQlZ9bAE+fL3btGSsRlb3GNYZAEE/XVTRSFcUrQA+d8qqK
	 mpmsF0IlGBiaPsVM6jIkOwTwYDMwAFo7S9fzeqHA/qvqP1kwxv6+A0MZ2KNDUuVaNH
	 qHEG6/q8xQNRVfBPMvFLyFiJBeUQIXnHO1/DiOV2TtHy/dqRcdogfQ6VQqTqv+wRNU
	 ++ooT+mTleAtb9MdHVf1J+1XfkmPdWHPyipsetpv8Av/aEucyLF7mXG+UTbkyhexSb
	 P9eibTcs3/n/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4499E40607;
	Sun,  4 Oct 2026 21:14:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EA512E0
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C35A40049
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zGcSCqRuNtKj for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 21:13:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C97A540004
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791148439;
 b=d50grtA3rAyNEQ2gQ6vxqMGEinEflaz0poMU2jqWkVuJAz/x+crWsfC1MCyYmJdKGqLc
 kjG8j9m7Z2dtafECMZcGqM9XqWSyDA17iG5+GYSKL6hLgogFC11sD0oci7QAGXXWBbb+M
 5QA7B0iVu/jQx88eOJ0bbasFH+/liZcOlQ+Qf4XZO2GBo7VoV+gTqVB90nfsktLEUUf7l
 4Rq4sUBqiFKTs9Cqbx1+gXc7F5Dyl81EYYXc4ecL7A2p570aaWgV9VkujPw5j+nSXg+9f
 W2aL/b97upj9ee9XJrQpKYuiTINOpoTKj09sa3CXWwBVfVnf5nIcvQumCRpiNSr1RJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791148439;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=3+eLQc/a5VoJElO/G6o0B8fy6fDmIogHir7DrMqcxPI=;
 b=I52fffQZUZvsYuC6mjeKD84XcaJYoGxT/HaL7VTbRWxl2tSs6hI/fZ8nUjsvgsGFl4Ij
 s3oEmHfKza37eFlFf+QeulcrFFBbWb+nMVgSpQy96nvR9+l8LpvBI3oUhwi+d35AKC6+t
 sri3LGbD6Qg1FQwS6qUtkqFNfoYlkuJY7/jqNw9b3+HiXuN7zlsYw2nYnc9QDk8A7CMuw
 aM4KPdGUx93lAXdAuKaKLWgitC+95dfKq3wsCWJFpmofZEVK1+sHWVn4uC4Ss8BzqHAhW
 d2HnL/oTrltjm+Yn+s43+8b1HaXfuthr2a0hHxyQlg0ILjC47V8L7szdS3FNyOAFTBQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=k+I+NcAy; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=k+I+NcAy
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C97A540004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1791148437;
 bh=3+eLQc/a5VoJElO/G6o0B8fy6fDmIogHir7DrMqcxPI=;
 b=k+I+NcAyIv5tTHNIxGVfx/bvqhZTWtT/gt8AqhtLiLLUk0BXYPHWC6qcqQuHgT7gyYMquYSJd
 RslTZCxexjlRFu6gtjVnI6refr5Z7vHYMwiyd415QGdq7gsSiR9LBpZtlDBDCJ7IaQF/FTnZCIs
 jhObWPNdSvM+z968li0GpX95AJp+7N742Ht0Pi+eZAX2ld+4DCeWJzJvzYkDPqT46KlLojoxMqf
 DV2EH6N4X9dmhmKntvB35BhNPC49buMbCMhkkHKE6Hsmzsg7qBfQfv6mcF0/h1RSAdt2rbHMatk
 LwjfRxDEX10iKYmoQ2wy5lNpRT4Yha4IxFLUqq7KTKkA==
X-Forward-Email-ID: 6ac2c191341e63db0e52ac4a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] rockchip: Keep clocks enabled when reading rng data
Date: Sun,  4 Oct 2026 21:13:46 +0000
Message-ID: <20261004211349.62883-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
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

This series fixes an issue reading random data on currently unsupported
RK3562, where vendor TF-A blob leave rng related clocks gated
preventing the U-Boot rng driver from accessing the rng block.

Uses bulk clock API to enable/disable clocks and is forgiving when
enable/disable ops is unimplemented (-ENOSYS) or when clocks is missing
from device tree (-ENOENT).

Jonas Karlman (2):
  rng: rockchip_rng: Fix wrong TRNG version error message
  rng: rockchip_rng: Enable clocks when reading data

 drivers/rng/rockchip_rng.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

-- 
2.55.0

