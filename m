Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53854606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yIKmMDnU;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=taek9J7B
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 177BE60D84;
	Fri, 27 Nov 2026 16:29:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uWiJB7yJCRku; Fri, 27 Nov 2026 16:29:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 390AC6061C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795796980;
	b=PHEIP0RtMv+0Ub4LC8L9uB6R3OPfIyqbPxFcrurX+OKb8ppriRiGw2yLd0DbYPKpUdwt
	 6MzXPTIwSpieraO7cAH9oBKE/5AmRNSAyKziy58f/vrHiVjoycRjcBFaKdSVy6oX8a1mS
	 FlpN9Q9q9RZ+3SGVS6zeA6sruaDdRG1xT0SZGQjPqPk1M/2TdYZPtlYl0EAQ/KuRpI0/i
	 c1JHEt/xYzgeNbwoVwl90yADZ6wro7fh5lf3KIdS+kQHqk5z0f398y4qYNomF/bS/BTEd
	 E0+Ha86n18dJmTeqbY6VMwJGhsLgIJqKViFa/q39ckX4c2MVDQI87brRyDyr013QNyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795796980;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=k4f7cKL857DWcouOPGtszgqcI8BFM0wHseamYGSgxUY=;
	b=iq6VG8KURDXjiN9uiLcRNYEVP202Zd6hmAl/kZagJ9bwPebmM2ZmaOT1ZXwDWob6zOGk
	 JLYQxui2HZ1qSlVPBagJ7nVAeC84XdQCZdU6gS68PpBVvToUeB7IL1f5Y1nGSHRUn9jhq
	 eqbfZfb4gytNT/xUd+VeGTvSZM006trjzzSagxyjc/vXAUROdkjDFIDqlmDn2uOpxqVgD
	 jTSQ7AwPaxAfeVbe6zmDeQpgkNT/oSfKU2l8diccZMAtfhHMMrQtiKv1oy4/LlLwpRCOm
	 R2dyjqsszGYTPRkdIkv2Zk4CVcn6R5e361RYkrwPBemhivp2cgl8a6wZCem4DR1UY4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=taek9J7B;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795796980;
	bh=k4f7cKL857DWcouOPGtszgqcI8BFM0wHseamYGSgxUY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yIKmMDnU2kE8s+raIMxZPP++yFEsVdfbEKOr82nYVxYBUL4RenOyJAIbjThgJZv9j
	 A/mWQcfYFo8I6kIn7fEnPdRRvz/9YzeumT31KVlIUIP2lReww3zeFXV0+8mCe+oZKS
	 9CSX2XQKxIWdxQL5tFXUSlK8+SrvkTPX59VH3p6XX/S01RanEu2S19nQmcBPlaCD2z
	 k/STbZEEgCsqkmq1Z1fehixyBv46+9xB58lRjWCLWjbOgRcnd28KBndqXHvhd2V2Hj
	 Pc+u1ohEHxwpaMROx+vdhkjHWLumyaGu1Kf+V5ajgFo45/HVNC2NcfiuDUoCPvmKgc
	 MaxvS24t3BHqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 390AC6061C;
	Fri, 27 Nov 2026 16:29:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 07E54311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E255560748
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXMqVItfPjgY for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:29:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3EE256061C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=taek9J7B
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EE256061C
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:34 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-703be215729so3618817eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795796974; x=1796401774;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k4f7cKL857DWcouOPGtszgqcI8BFM0wHseamYGSgxUY=;
 b=taek9J7BFmN+enQK/5WXe9v4LlBJp203QDyNZeFOf0oijfhIww3ZpB12I9+NOcLfnN
 Af4TqgyXIR6OUtT7srEp7yDYi03Lwn6tvSWOQLyc7d0pzawV29Pxshs4zhQXknEB0/PK
 3EU6zxvUWNJ7SiCtrXQAoSlgXXrphmllaS9g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795796974; x=1796401774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k4f7cKL857DWcouOPGtszgqcI8BFM0wHseamYGSgxUY=;
 b=gbj2IbYiTO0QcL8Sv7mLB1CbCoYJo7QPbWXRCt79PU6COwVm9zYKlUB3Iuhg22DEkd
 k6U/RRSZxNkg7Ji3VKgRWVvxxUmQRbfBJnoTNEej7DLWcOT78LAhFQMMxtrshePkehnl
 6ML5iZhHQ5PuhNRy7jSzZd1uncIABkFw8Gt+BNulVdj1m3ef6l1QeIwtyKSTG4t1J1bc
 cG4AlPNpBaTEVpsf5lE8Qq5Dq5FykB7aNJtbpqBO/yZJ6JcN/GTYwuoWE0PlaovtO/fJ
 j3mCSnRHayW/i0SlO0jhfwsEpJ+M9XGNLDwRH3bLHwrGrGd1ussn+HTq/uCLXUXSGUjY
 FUZw==
X-Gm-Message-State: APuU4Z/6LTX2LBtshc0pVTY39kIQN1Aj1H9uKldZECAr3cXdG00xslJp
 BIQAZb/TTgWBXOKpL0hBwPuBDAzcFF10tIhl0Vz6ivS85jMI9Gm0jDwhZFu+mhFcSa4KqBNcoid
 M9bWbwx7aX+zu
X-Gm-Gg: AZFdTZfR7z+8RwF0zg8bWzmkz/fzOAq8Jy2VJQ62QbO7mFCCwdHfzC3DfB/3Oj6cfu6
 YBdKVcu3KcBltXzeNgv2YcgTTexKlFO3uBt64Lw9K3HZwCAsfey6dWdHwMvrko5qIkdMHtmWwwi
 TM2pFmR5xBfaEaGQj4RkKlaWcAiorEW5B0yyJMAW8+wNIbP9grEpQbvBsT/HLCT42sydQB2lRzK
 sl7mGERNcYz8Mk2ydjj9KPNG7gxwbVRQejyuPJsyyOyYr7scJyyRdX266iCYCDwoBvPRdf3JTfF
 qwBFGF62j3jLzdgPvU1xQnvyep5Uoe7VrjpmL/7VN0VEzIPSxSpbELCKAhCoBYQcefWM7kOx9hr
 X55cWZcwSMSjT3h/XUPGGgS98g6vnz17KIIn4O9Oc/Kuuzw7I9MwzuA1L0sNQIiPN6xor/fiouA
 Ld5W4fGbP5xWwCQ5tGVk+fbAhWcrgJv9JakIywkAesEEhBlVkPJpoHbGs/UVx8w0xtNbWnAoQez
 NCu9uijRlo1/dN50GCtEwMJxmZyAdA1bXS6q0/SaHW/mw0bfKEpgr0Iq/vicURlCYuHQVlNMLqa
 1NNmC7Shyykw00qde+a83mIqIwqjI++v6HaoM6xUAKclMT+nY5vUzWvzMjyOvOdnwfcsRy9P+nw
 9EICYiLqWPyyeIqmw/hj0mIfpYsXWZxUoIeEDICOUh6p3sDHGRLbJUj+6IBsfVtpDmFf0C67YiC
 LZAVnJoFNPKU0rZyvFHwn2hHcwQRyNnJvO9D/urg/i5ZgpYy25E/xrpqc=
X-Received: by 2002:a05:6820:1c93:b0:71b:7e60:c33c with SMTP id
 006d021491bc7-71b7e60c893mr6786528eaf.82.1795796973726; 
 Fri, 27 Nov 2026 08:29:33 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b865900ccsm4746056eaf.6.2026.11.27.08.29.32
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 08:29:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 2/4] Dockerfile: Make downloading toolchains more robust
Date: Fri, 27 Nov 2026 10:26:27 -0600
Message-ID: <20261127162927.3545062-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127162927.3545062-1-trini@konsulko.com>
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261127162927.3545062-1-trini@konsulko.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that we catch download failures (as the pipe to tar will fail), we
need to add a retry. Pass --retry-connrefused to wget so that it will
retry most failures.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Reword the commit now that we set pipefail, and don't add the exit 1
  part, suggested by Quentin Schulz
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 48d9de7ab4a6..4ec68eba785a 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -47,7 +47,7 @@ RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then HOSTARCH=x86_64; else HOSTARC
 	\
 	) | while read url; do \
 		# Read the URL and unpack it into /opt
-		wget -O - $url | tar -C /opt -xJ; \
+		wget --retry-connrefused -O - $url | tar -C /opt -xJ; \
 	done
 
 # Manually install other toolchains
-- 
2.43.0

