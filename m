Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A4B606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=coc38igI;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AN5KN3NO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3CEB60657;
	Mon, 26 Oct 2026 14:44:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nZYxG2wHm64P; Mon, 26 Oct 2026 14:44:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 12C0160607
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793025893;
	b=GNLFh+46hqNrNA5FPeiv057EhKW8xq1c8wdK8Is8pg4L58Wwrj0uGfbfpHtgXjlShTSX
	 lcGtGUBRfmqLTYSpzyg1WpNbupY3tcdXQgiMnZWmUTCPQaMddWjEiSYQ+/U3C1e9gPB+c
	 +oeCQHCB2UGgjKEHgd6UlEe1JX8jYjGOCxjXWFFCPovdKotL+icYhNnyuU5qvjdhtmptb
	 FSZEUX7Pmj/K0LRl5+S+0H/c8vkcAuNKMqQ+t4SXN0iV35fmR/VMhJ9kgkZUu3OWa8bUf
	 jdHLWeiwea1NtrL8sJqV7GmReftqlWDLfuA1IipTE5y3BCH2WD4GAguZBrp4ohVlN3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793025893;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4WgrgTLHFVt/P9N3LaXR8r5rF7BG7Grm/AtvtTCTpso=;
	b=ska7UlVWIhv0f4a0i5qG3LE3UPJq3otrFxwLrZVe7gJG75rTbRa9t3mzMNx/El/E88jn
	 +TwEOnAFHU84PHgnzgAq8Crwtcgvffg+xjOVEXcfYz2LJ78RQGWJBG2OKQ0OGMPaDEjM6
	 OOx0jT7dLTrPTlOr2V43CcMLUxHirgFvS+dll8z96/A6N1ZYuT5sNpvyIeM/GW7C4k2tK
	 zHHJZ9FsRfHmBD5rspV+gFqKnAXJBxCXnDKdfrlLoU7AmqFOr1i1Sci+4eYCDSPSJBkfp
	 jdCy3eodcWg3opXKj7drBODfAaBTwiE4e6YrVLj1kIYGK8HOEvNUCeQxQ/ot88kv38Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793025893;
	bh=4WgrgTLHFVt/P9N3LaXR8r5rF7BG7Grm/AtvtTCTpso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=coc38igIk4E6KpnfgW4rNzQ6jPfioEWJLfTmSZ31lDXYK1DPDTcEMCSmSNUa8wXGR
	 rO2cU8NiXOQSYfBeOFnriypJ23H+vCmL+eV3FSnqk67o+UqoAjUXlOO0P+/pkBNrdw
	 dmBXCvztMbRC02YQi4th6FybMseyNCVFKml7zeBf7wHgCzSvHSvedxk8wF1xPZFqSm
	 CQ35ClzYdacKqLLw90nCNwlRh/kILepif4X56SjxBVt9onzQjCtsAH4VvFzi3N6Rf1
	 WIXZTiYDwjnXuwQPXZx+qNENY2LwC6sejyG+O+h3e1olBX+IJlPsb0m3z6Yopz0yX1
	 GWHogW5G+qgsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12C0160607;
	Mon, 26 Oct 2026 14:44:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 467CB279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 386354068D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:41:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DWtDevKYN2TD for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:41:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5FE7C40689
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793025671;
 b=RlAbhXPKgBBy9rgQjMCHpgdTOnF9afuTk0hVKr4zVg3Op7QGJDZjGnFcZdDF+Xri7g32
 ev88zap9KuerB5eXllxMBUcfCiwYZT996tWcWz1snvxfSlAqdzuLCgH2E/ei0e4sO/NP2
 5IA4Cz541eilba6oQ0xOXgrbThvc/Pt2o8ZhsY3m6KOUyRByAk9QLyqN1kilGZrhTgT09
 DJqSpm2NXNj/u+oea7f4wa0oGSDT1dLJ9/d2E/WZlUIDV3+QmwdWp6PtZEVKNqJmqah1X
 IqspPsebRnKj+aOpmEdpozUuZBg5PEB9C999E7sV3IaCHGDyNrSiFNEmqljdvjy+M8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793025671;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=4WgrgTLHFVt/P9N3LaXR8r5rF7BG7Grm/AtvtTCTpso=;
 b=by+C/Dw7mr2hyuwNlgNOA34C5O9myBgWTvAEqhu6KrQCJfPvp94fc0jtUW8fttJPagmQ
 uOu3phbbFcepVxkncGzdeu6QsraRX79tv7QoEPufbFO4K/7W6ZawftpZ5GjW9HDyHogv7
 1X1tRm2DDGhqPTrvlu4RQSSObPFCkKWeiPyFv5F+ik9SyDTAs7et0SNSOR5RKNVu25dlU
 dD9K4JDKKoPrgp/jctcgi9qwm1ji8WYv6WQW/AlV+TOt0E1pPmo9E2BSt66dw/TSsM9z6
 l5bSCnzfC1G7aI3AKFzUyJ6TLZDbL/uQjF91upyfYvDagtaNZcQYPGkDnj/re0bkmWQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AN5KN3NO; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AN5KN3NO
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FE7C40689
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:41:10 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so9613265e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793025669; x=1793630469;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4WgrgTLHFVt/P9N3LaXR8r5rF7BG7Grm/AtvtTCTpso=;
 b=AN5KN3NOvRT2+4z8bhkzUEsRj/bf4oaf/E0KtUTE5OgDs5uCktqLY2ST8X19BsH/bN
 6sFPotqmpr/UlokeqoGOY4tFY1Ca9hfafo3p2znBEvasZ/DeIbwcQ5nBtyyMe/lyPlZw
 UobA5eBzzpbdYPT0n6Mf2bCYAXSmKrPaeXSBJ2QUmxyMD/mgGvZt8/eipvxLfgEENfGb
 cixwVYzmx8yAnc3oV+x5/47f7iPD0gvePbHTTIxeMDflpkMAzJuvB7BtVupXPD3F294K
 4e0rIX2XRO28g6p3BqKmgIGF8sgMI4/08rHklZl0ToIwGGsW+VMaoXtEJJk3Bxf/gzda
 f1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793025669; x=1793630469;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4WgrgTLHFVt/P9N3LaXR8r5rF7BG7Grm/AtvtTCTpso=;
 b=D7CGVCLERyokYCfh26sEqlJ9aN/mv3KEqoObVXlZivH8RQnGbN1dFUGydkevvX8jiO
 lX4TQgsGSLHiJwe+YlR6C/cqSaUs2MrE9i9ZJMD5sbpE0ganRQYVsccG1vJPq8q4QkYt
 i6vTotnj2ZL9woIQ+4ZUcsRoH69X7Wjv3KxOpi5uQMa4PdpLkYvs43uHmRmqAC9aaEFq
 hvd1nrZFnzZuLrt8iebC+RkkUUeHkc+HnwhpoNfZwtUwCxYu/vmRUClvocpbD+FXK3HV
 p0VLiLsC/qIBvZm7o7/q/8apeZXSndWnImyREuiExap2B1sqNBGOxJtO4SeNp9kfaVhq
 GrOg==
X-Gm-Message-State: AFq9FYLLK1pvGHLOd+34ssQ52H/MIlf/DsXDRDXqdTpaOa5fMGGymMMt
 T/mHRND2Ef5H3W0CHKXqZi5C58KvFYOH1gEkF31jT+1sZYFhTlDNJzNA+Zuemg7QO7c8on99GpD
 D7cUg
X-Gm-Gg: AYBFou2EomJn8zp8OqFukSsnMoASEOzeUe3HLkQjR8XyPTQbegqO59DhBfwnguCidp/
 uxRiS/WWos3DJ55Y4HORd+DqQij1gChWXoxHtqaqRvXCYYmoTl5MKtIZSSTvN1jp9KLCGfhGki2
 quBlHmEngdojDLB3oEUshGEBVWGiOhJ0Ocl5Bwdqym/wYaIB2jt7E+TLIKVw4a2JYhrtEk3+5FN
 y6w+eeYltQ9pugGqYbz2s0TnrNRiwIWy7+0AWYkXfqgzvMeS8Kz2f0LbM+g2wbGC3g3Pcbsgjdj
 Q7CiV5nq43j0U0ZO26hbC7VsZBs+E/s0F63Hz0kIkvgwECMIWQjPqlC1nxhE0Y17lnljeXuB8N/
 RvcFTp1yeTCnIH89SGGLJxUk45ZJ8SU+ttn609sJFUBzE7cd8lHaW3I3XMlFbvTQ9TXwGDMdQj1
 eynIz9YuxABKT5Nl7SQvm+uY2P3PIOWJDn8sP4wOnHTgb4l3lth3OVY52hmc+F53JaSF4CnlMwJ
 xRQ7Avcs6o2gpjvwp4KR/gxUbyJ9CKsqXPvy6FcpqD+pM1QzoGoGu4jxty95SipCg/18E1Salr+
 L1JPRiUQ0EHcpOMkQPyFrrwROejw+7vshiecsZ+CvFOAhBEPU+6yF5gSRzbtou3X
X-Received: by 2002:a05:600c:3b02:b0:4a2:180b:3153 with SMTP id
 5b1f17b1804b1-4a35ac8e71emr131837195e9.14.1793025668939; 
 Mon, 26 Oct 2026 07:41:08 -0700 (PDT)
Received: from localhost (2a02-842a-9b20-0d01-a06b-e180-2ea9-f6eb.rev.sfr.net.
 [2a02:842a:9b20:d01:a06b:e180:2ea9:f6eb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a029332sm176253885e9.4.2026.10.26.07.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:41:08 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Mon, 26 Oct 2026 15:41:04 +0100
Subject: [PATCH 3/3] configs: rcar-gen5: Enable env erase on the Ironhide
 Cortex-A U-Boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261026-clegoffic-env-flash-erase-v1-3-18777abd1bde@baylibre.com>
References: <20261026-clegoffic-env-flash-erase-v1-0-18777abd1bde@baylibre.com>
In-Reply-To: <20261026-clegoffic-env-flash-erase-v1-0-18777abd1bde@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Aristo Chen <aristo.chen@canonical.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Mon, 26 Oct 2026 14:44:43 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable CONFIG_CMD_ERASEENV so that env erase drops the environment saved
in the eMMC boot partition.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 configs/r8a78000_ironhide_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
index 527d338a663a..bb11166092e1 100644
--- a/configs/r8a78000_ironhide_defconfig
+++ b/configs/r8a78000_ironhide_defconfig
@@ -16,6 +16,7 @@ CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_ARMFFA=y
+CONFIG_CMD_ERASEENV=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_SCMI=y
 CONFIG_CMD_UFS=y

-- 
2.56.0

