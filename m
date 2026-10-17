Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970B1CCF2C7
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C926606B9;
	Sat, 17 Oct 2026 13:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hwVKgDTwcneh; Sat, 17 Oct 2026 13:01:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D79B6064B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242081;
	b=k2UAngZCpY1erZivQqLmQ6xjZZMj6wWDr+HA41W9NNse27y8ZF9XdYqWgmfoIpSirGoX
	 ZT1WfVP3nP1OSQdKzFxE6MRpEjDqFrgQTkRUpZ+FMz6rqpxzLbAk6NhtMmsIxj15JA/VF
	 7MPFVHoQ43xgIQRZ7y89UBs3T8lF58HDfaxuVoP8FqlW0Gfz3aSrQjkE6VnDzis7Cf/1N
	 jsw6oYXPzNhWAGy5JWRan6/4JYiLId4P9gIjjhY8GzH9tedTlyw6Q0b9EvRQDTKHL44qt
	 Qr5Zk/NYeYM9QDYvjKJKT9NviUpCBYI2wYD3UZ7dGS/uwPwua2vh7g8ueheTO3N2BVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242081;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vS/FB4LqzKQSwbVHTheoF7AkWOy/4ISN7HKFfEncTXg=;
	b=rC0U/Eb6klhqn6/3iQ5kWiKfjAYAc76QdGS4hNaiPQRcQon5l9TOsVAnG1l2BVcK8eRD
	 nEQoziVKC6ie1MIMHBONH6Rw3YMmOlCQD5MnP2UssWeOEL5mqrZrweRF2/YqDdLREtPLt
	 HePe4IGTS/r+tCOH6k2MC61K1fJSB8zxNt5qt3h6k6Z3x6yregwG6KOCQnRVaqJMgM/Dh
	 YHSHXE2fnzhkO4/j5sjdFjc8CqTI4VigJuYmU3x8i9HtXWaZlcnwlHcX60mp5p8J3bvrB
	 yZxrrnzpKfGJEUSoC3xdd1VlPioQUj+9ewNW/6VyjEv82/l+RGTn6qBXuCQOvigCiGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242081;
	bh=vS/FB4LqzKQSwbVHTheoF7AkWOy/4ISN7HKFfEncTXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y71Noda+1rDjW1sVx6AawOLJ/UAw44aghs2g3Ltr1XQTl0qdwdyS4Hz6udBRLclxl
	 JTIMzNmo3Y/G4Wtvn0pTsP7WV4ySRRZnyGgMTOrWolHdFlOCL3EHct02CW+ukrcHC4
	 VE7mxVvds0YOncrb/nemzo5dVEn4RRAMCwVxc8MgULqDhUvvb25XsuJSgyKiDPT3+j
	 QVhawaTuTfQYz+zbQp7wyq0ebJufj3yzsJ1Sy1ikKzcHb1/GUk2qncjMn0jUtnYEV3
	 WRWB69hojdjIPWG3UiA/1gT1AEWVozZBgpTMFqSjMJLmeBZi+2ez97U/o5+Wc7lYsU
	 PSvH7lVS540/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D79B6064B;
	Sat, 17 Oct 2026 13:01:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7277D2A8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 59503812DD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ofgd63M_x9Rb for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 12:36:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 54BBC812D4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792240595;
 b=AE4l8OXdUCQU3ExovJT9+oAAjyGWlv1upG15n0kLr7jjU9IqAtkmWY0RLYoYcKbvnrUO
 9SY6hyr7CjdAvMApuDxqU+Gt22FFHQrO4EvYtb0IIWJCOjajbLYuR0IK3ChHtG50RrGWM
 CY/FGsSwSnB8CLAN6s2N4q4nqmRzTvtj72s2v1WFOUBT1ypi8aTVoK0djfvA7TFD4x3N2
 bx+4ZImY0V1GJp8XZmNPjY4PfYG3Np0kA/bknnxTOJiAFPjjTEi+7kP/sxWhf2OCahw90
 tad/qK7H2J6yc2nsZiHn0rwgv/R9NdbC/PES6LlnMDI1wz/Ng0JqZC77gr2BibifOIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792240595;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=vS/FB4LqzKQSwbVHTheoF7AkWOy/4ISN7HKFfEncTXg=;
 b=AGUK98GNP7Tq6f+vDGuWhc7CEBp8BU0dlzDMrRnMa7nuMk4sHK7JlBMEVH6InS6eHPKJ
 OwDpSUk1b8ySeeCyFeK4xWntAC7y8J3u2FevdejU5X/w+q7dlwvAX7KG4+ISRRvJvQV5B
 HyfZq/8Qn13WOsyRYI+ysHYCoyzs69Xp6sy+EdaSp3iiTrdu+qej6Cv0sMgvbDIczK2kF
 GUkEu+xG6BMllrREdlSP6VF2z7OBYp2fEjg4IDAnSu1yNaP0wxSYumA581gPcZj9iaQz/
 BVNRjatDVADGVuXJ5gCw9OruKwoihpKCIa+oQyjuaB8izg64NHBObNu8vqPnGBIxPIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=O3kXCcyJ; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=O3kXCcyJ
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54BBC812D4
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:34 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 522423F19A
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792240593;
 bh=vS/FB4LqzKQSwbVHTheoF7AkWOy/4ISN7HKFfEncTXg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=O3kXCcyJmPMvXPpyD9PWifKEwmA1yrUslNoTNJwngaY6ciNy5RdLc0xXKZr+gRzkG
 qGncwfJdrnObokVsLZvef1vt3LPrwOGzFhUMkULjBkpAPHO02uwKGzJt2m2kA8t0dC
 Tr0fKy3k+WmZW0jYBeU/VhV/juAikUe/vPHCsiIqPAYjBoN2ZI2osysuVg/48vKktR
 ckwQZ2BiTqwi9qATIAIaYynGpLpfCsP67flbGAlaxUVaddcf5m+87JsPsgbZRrjsbh
 7gDN1FMgjP5DV3T7tDz9wcIc5zjKMMxSiISG5YFSQ16zQb+voo5o563Fvh6JEr3Yrm
 FRzMpwxb9aLPsDRduF+2F3J1rxDiPomLXOhPrsrwD3mkSYA5bOXnL0sILq/W8wg7Bv
 NGUXAGEAIFeq2SJvAZBIzACNKCTvAnbyRe4WSj2K6BYBTil3Xt8R/1g/0mOtWvSYbp
 P5/lfkzRfqViNZ1iNBDAkGejlgAQRvRo6hwhvy/YrVmZoNuL87ti1D2LX+P45mXdXn
 FpETvxGxPvRph37G57XThaI3D1IkLrKX7uJXmcqfxDAssBk4ypafM1aZubyO0CrBkK
 064So4FilmEM4C91TsHzxqNExenshSpreJcnuKKeINLh8KXo8mt/7W7yTwCHi1n6aa
 dRBKklhevfvNoxw8lgNDVrhE=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e8ba4757baso7653315ad.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240591; x=1792845391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vS/FB4LqzKQSwbVHTheoF7AkWOy/4ISN7HKFfEncTXg=;
 b=C8JsZIRKx0Ys3jS8UcGm2L28hDftL+OYTeRnzGbj8NldgiEQwVToASE+9UHhVUxjDi
 yLM95v3KgL3tAjCcqEuNMm/BLACor8QVvQdx47/2Ig7HUr4CiHStAWT8tdGEEo3Dx1Fd
 aTF6Nef+DJ2UUeV0zXStH5ZJjCxJ0BNGOQVglVFNvcteMTsgQprk3AOtzum+33Hc670f
 7MZUEKw8A50Ka0DGiTmb1IaXsrF/mh3pkS6FFurPcgxvJYarAWO+A52jKkn06w+HAXvE
 Wh+iiuU1StrwNiHuh/FRf2MB0xZOu9VzJB8Fqu49ebXJ24KOZpPIDIeAUP0PSmNOjS/i
 dNzg==
X-Gm-Message-State: AFq9FYLXgwvgTrg/l2nvn6BgWywif7rxtO1TKDUm/durJ+bINTzyYjhz
 V/UmaAiRhfVT5+74UUIMwa53xYD9Pb3nBf2+t8cjTOB6WN6YFhfymIOJIRSQ9XJeaIMPT5aVnQA
 TN72x/PJEunz3vhFG1fMr9GFd/Yq5wBBFd7WjoOZskV/4gMU+pnxZHWmP2picY4G/I/4v+h393l
 6lPDRcvBK1N2tfnxDcRw==
X-Gm-Gg: AYBFou1EHHYZubCRaxMIc/ulaecYkSU8K6xRcZlQ3T40nTXkOT8SyftptomX+sgBZ5V
 jo6fhwraKFq9gYCawb4DEjIq+H7ABVodNPKD/kEd4kwBzcLV3pBIKKWDAD4t3N2lYXSRJG7aVQG
 0e81EF/Al5J/eoTrvVhrVjrzvmMCaDPv57T8IVqqWLduNS7pKrDCDI7jghNnsdQZcuJqg23buF7
 7QeMyy7/URAqY/7ht6NrUxw7R3A/tOJGhr6H+cccSa5BRMYNmewL1Wnjit+TWuuWUSGR133PMqV
 bgEPLg7umxQu9Wyg4HRGTR2+6g/7mcOyln9qSY7MuUGY+RGiqmzL4sZx80RiXMJcg6+aAafK+0F
 H3kS42pIbtkz8YW11yTvFv178oucHOqLs1LCaNA5l8YreNcM=
X-Received: by 2002:a17:90b:5610:b0:3ac:8897:7b88 with SMTP id
 98e67ed59e1d1-3acef5f43f0mr2041795a91.58.1792240591475; 
 Sat, 17 Oct 2026 05:36:31 -0700 (PDT)
X-Received: by 2002:a17:90b:5610:b0:3ac:8897:7b88 with SMTP id
 98e67ed59e1d1-3acef5f43f0mr2041783a91.58.1792240591097; 
 Sat, 17 Oct 2026 05:36:31 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48f4cadsm7909410a91.12.2026.10.17.05.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 05:36:29 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
Subject: [PATCH v1 3/6] cmd: pstore: size the buffer again after pstore set
Date: Sat, 17 Oct 2026 12:34:18 +0000
Message-ID: <20261017123554.211799-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017123554.211799-1-aristo.chen@canonical.com>
References: <20261017123554.211799-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:14 +0000
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

pstore display and pstore save copy each record into a buffer of
buffer_size bytes, the largest record size, but compute buffer_size
only while it is 0, so only on their first run. pstore set changes the
record sizes without resetting it. After a first display or save, a
pstore set with a larger record, console, ftrace or pmsg size makes the
next display or save copy a record past the end of the buffer, which
corrupts the heap.

Reset buffer_size in pstore set, so that it is computed again for the
new sizes.

Fixes: 9744d1a54784 ("cmd: Add command to display or save Linux PStore dumps")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 cmd/pstore.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cmd/pstore.c b/cmd/pstore.c
index 6a98a5c006b..77dc925e398 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -197,6 +197,9 @@ static int pstore_set(struct cmd_tbl *cmdtp, int flag,  int argc,
 	if (argc > 7)
 		pstore_ecc_size = hextoul(argv[7], NULL);
 
+	/* Size the buffer again for the new record sizes on next use */
+	buffer_size = 0;
+
 	if (pstore_length < (pstore_record_size + pstore_console_size
 			     + pstore_ftrace_size + pstore_pmsg_size)) {
 		printf("pstore <len> should be larger than the sum of all records sizes\n");
-- 
2.43.0

