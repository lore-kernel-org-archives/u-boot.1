Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC74C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 08:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F76540E25;
	Thu, 24 Sep 2026 08:59:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lYQrpIzZHISm; Thu, 24 Sep 2026 08:59:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5947640E1F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790240351;
	b=cddUg2rMK1KYPJopR2rb46vag2JHZu1X4FU0hXi2SGXDLsnQHr+K7ulUdeG3jk0KLQLG
	 LNibMG9DP7iN0l+/PIbBmg0+qRiFXX1C+PONPBcjSlLDPhJBd/w3hSEaUQOymp/amt7Nh
	 1H64XODbHg8hbqBfov4zLCAuf0eqlcLU2ViD3cXOFpTvlDDnYdRqFjU6ZzylLKi/aFDip
	 pLHC2uzP7PCDhAmPje0106Vl3sCkeBpCEZGuSVxj5VpYHiH4WNdDOkW4rcPhbRUw3ETGQ
	 plXIoiSxS/kpjY9e/sc9oyo3Lhg+U6f9ynngc6Ox0qX2WRgxaQHaZ7/cISa/I4R3lLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790240351;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=v6RrUJrvU+eZ40nqtHqq5UioMOnJu4PJER1uzFXBDrk=;
	b=XgOdEV4/HpsDIUNCJTzGw8TjZM/s+civw7tri0WbhyEOR/xDUzvKrMNCh9SiuMjLVZtK
	 wScoqigdIq/e6xXLEDY5bDvz3RKkUiZHJy4Xc5g7K9nhxJ7U7xStat/Fcg4jBxap2LdOa
	 h96I5AZqzOh4kTZBYQiDOIPyd54pbc94ONK+Hes2zmQAi7whglZdNplna7bJ1MbQ9Bnt3
	 UxIQQUSBWxfw3tctQRoykVKt1hMO+wUJJQXR4gGdX6srqsZjXzPHyOfxXGLrzUd8ZC+eL
	 ZtIkg5Kif61SdvSMngqbwTVL3IlUBcjgjWYI2IS3OseG06Qv/s/MakJnngHpQxcjQNA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790240351;
	bh=v6RrUJrvU+eZ40nqtHqq5UioMOnJu4PJER1uzFXBDrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ORpVo/4BEIn+vLdQ6ddt6haykB6lWOC2MDqs00orAy68Iz95fK82odSXFcrPGyOlb
	 ib3FGUURbGTvYpG95IZK/Mm8yw5V/VAMRv3TIeh+yn8XBD++R9VIHPLxiY1L+2CPPs
	 CsjPo/5UoxrmXQBdQ+EmXR97Y7rQrRBfHz1jZ5oWHzLmVL3xGdAGLDaVnEmQXbdh8K
	 aKOoA3nTDnMyNzIeyQ7w1QL/x3/Kbq7ahTJIHzVUFqT+VFEfmQ3YzEhFfLKIad/3fW
	 Z7Ae0lk1Xhj57hytFar929VwtXQxzbL2e5uEvUWyTgVW9Q+gus6e2Bx+TfRqrp7hnK
	 DP2t+jxu6Dkug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5947640E1F;
	Thu, 24 Sep 2026 08:59:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 857892F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7755E40390
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FwqUM89raxb8 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 05:55:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1B36440079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790229328;
 b=EQlhfcbgx1ZJVxPIV70La8Sn6hN+5PqrCpjL92Dtdt3PQx2+kOqfgOwgqxsETXPGFuXl
 qtrywozhSkdkxcE0fHCmVgFBTJf9GCmDEQiPsmnSLu1YZNqeVwBS4AGkUJum15TtNanpJ
 BAeYj/IYut67Qqf/JXLIpZX4pILuxjD1X9Cl/FCFk6kD8NgQFyfVa+lF2C0Db6khHUWgR
 49tzX9T8WLq50T+m8b9NiwnHNjp6XjJB8hjXzH8ei3poOyxMeZJUW5es7HVF/UClWntzu
 Iv8/e8HPMD0dgbxqb4ph/YHQezOIZjpPLY/B8B37jUCj5GpunEp2vP8Xwf/I7dLm9GQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790229328;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=v6RrUJrvU+eZ40nqtHqq5UioMOnJu4PJER1uzFXBDrk=;
 b=OaTK0NTVTROopvX37YznqZYP2CNF9X+VRcfZJ4g1Fuz/Lwxr0Tnw5XoySRMH+YlQxJ0Q
 9azOail00PSy/l/2si30hjVopUJvYMojSXdmtniOAPeqR6aDPeIFNcK1k7gmHbjwS9IDF
 ZqSwTIp+gNlRtZSj3/OC/uFMu5sMHklktdC3vxMwIsP1pDLPNuLUXmiPexK3atM0n8fgA
 WFVNOx4K44uIOrcUVJxJEpLt9P5z1yn8AY3BSkeWtOSSuKCh0h1xlqYoccGKMpd2+DieT
 ouCLIfRhWHS1CgDGyxSly7Uz21GK8aEA0Gkvo2d/0qx1lAOXHdPrzdcS9NfhnQ5+XYA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=LS04xdQo; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=LS04xdQo
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B36440079
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:27 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 993CA3F323
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790229325;
 bh=v6RrUJrvU+eZ40nqtHqq5UioMOnJu4PJER1uzFXBDrk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=LS04xdQoFmQQY2E4ZBsKhpQGxriQZN6pHfp+Nl07ZMNIVKxwL3oW4TOTimuBbYWDw
 /hrUIFMMww1SN64AsZ6+xhvMayk/H/TD8boXzDft1WCHFKQ1Cn3zaJdU5zRgIJdHbw
 FQ4hCo5w1HIJA6/ZOfnvfLaJ/4SpaNMC9sfXZtk1i+3Ir/JNTm0dpwu5rbi4931zkd
 kGHQtLfuGnQ52sJWl8e7e3xPXD83Jb/UP0HYqmPeW1ZJ2wl6O79oP+/YMDgquq6CN3
 cn6Rc7oykF1iKhQcUjtFn5CqHIG3oNPECCwFeHEs9yHDClTW0Ua6hKxHgmh2oek8n5
 EmELpKIVggJOPo+acPd5Il34oyKZyKZMisvRFiI9THedyhp1CUd5KXtLGqkU6Ljhmg
 Nm6J1PGdKikYtKZ1Be3Qynux/bqwehVcklYRuC0SmHzHtIwncj5bGk3HrKEd0x0itH
 NwaOGSe6er+d6+h2gg7ko9Fru/Rg/xCafMoI5yADkUEMlS5Ap/NULS8JpwbhV9it0j
 RcoBHuvQzH5wITmmQU74BPAAH7ig9aRSnOxBBzy4sMMmTMS9lh4xy5vvpCPzV4IiRV
 mYOJcbVz81BOOnpjq1vmyVTpuSaZ87TPaQ65zRw7MVUYJt3CWOBKCiUQ0krjbBMkT1
 ST/fhT3dMTMC6LH3iMiSRlU0=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so1703149a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 22:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790229324; x=1790834124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v6RrUJrvU+eZ40nqtHqq5UioMOnJu4PJER1uzFXBDrk=;
 b=M2FlLw4j+RH9beSwweAcgI2xl4oXM+hBR77RAD286YFHvhZ2j/TfedzLyDFyTdcoOu
 /rVX8GMb1kEGRuMaU/+v9iQsfAVDRzw5SeOgkcUsVPC9XEXinrESltn2zBiiAd9MO6zQ
 TEYR5qlCmloALwjoE8qpj31ayl8TBuVO5KKYroKKRt+KoMv5nJ9CXQS5nu8RDdLgQ8r2
 aewYkh1CDnVG+v/9OGpquH32yClNQBp1E1VchG6cJ67+dpycpLLL8A6kGUKqPDPkt2u+
 qKmnhsx/o96A5+C61xc+omanuDcPrGllf8MzFCUALZeFBBzz0vkwDHPHzS5MubJmeLWN
 DaFw==
X-Gm-Message-State: AFuF++mhKDIX1BMXOvg3Q4yFv8Manmkm+149fwtALVTk9xvsIwWsv7r8
 dlYDuiNdAGGLkGEXsTIVPratL4qa2EXmgTxqGfJEYmXQx141hFrUDJRU5Z9OScoMH9bXn7Ycced
 J60PUeLZnXWOlmZL4pm7EHMkb09guyluERIbJnP8eC4ep+rHEZ6F4KLc7NLZpvicXiQ5LQjMxaJ
 Zrs9Mv3NUNya465d29mg==
X-Gm-Gg: AYBFou3gEiO4Gc9KzxCeof9zrxiz7pfXGz2xvVjY39CaWg0iZzghsKcs3kfvN5xOxOV
 9/vkNl2xAT7qGdcW/E9I9FuTcg87PqlsU8sfZoPbrsejKx4MZ7nsKuThcyQxgEAqW86ls4O09U4
 nOlnVKgtiyi4wT0du5eNy/J7L9vqIoB3KofpeOrNYZsVLcVcECYztaMsqH4orqAISqlH0Fj3506
 3jagd87rHrBDMYUri3t7lqreWTFAQMkkD8QzDBgkXxj4O5Duu/JQvCBa+sNvl2udzOpMPI01b0r
 Uoq/N/YBo7H32/zIXXsZ6xtpHUuPrrX9KoUc/aV0vzK8nebpXQaJPrBqPXBJJsG4yk/9D8PfY+O
 vg38xSzBFFIC6KjHgdr319/KbQHLWa++aCCW4bF012H/Fju8nyS4kAUe5jAyKjP2I+av9Ew==
X-Received: by 2002:a17:90b:4407:b0:39e:4c80:f681 with SMTP id
 98e67ed59e1d1-3a098bb63f1mr1109953a91.32.1790229324031; 
 Wed, 23 Sep 2026 22:55:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4407:b0:39e:4c80:f681 with SMTP id
 98e67ed59e1d1-3a098bb63f1mr1109945a91.32.1790229323583; 
 Wed, 23 Sep 2026 22:55:23 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09733f48fsm2825829a91.11.2026.09.23.22.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 22:55:23 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 1/4] tools: mkimage: use FIT_ALGO_PROP for the signature
 algo property
Date: Thu, 24 Sep 2026 05:54:49 +0000
Message-ID: <20260924055459.125648-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924055459.125648-1-aristo.chen@canonical.com>
References: <20260923154610.339153-1-aristo.chen@canonical.com>
 <20260924055459.125648-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 08:59:03 +0000
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

When the signing algorithm is given with -o, fit_image_write_sig()
records it in the "algo" property of the signature node using a string
literal, while fit_image_hash_get_algo(), which mkimage and the
verification code use to read that property, uses FIT_ALGO_PROP. Use
the constant for the write as well.

No functional change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
v2: split out of v1 patch 1, no code changes, Reviewed-by from v1
patch 1 kept

 tools/image-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 46036673050..3974ee3d389 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -167,7 +167,8 @@ static int fit_image_write_sig(void *fit, int noffset, uint8_t *value,
 		}
 	}
 	if (algo_name && !ret)
-		ret = fdt_setprop_string(fit, noffset, "algo", algo_name);
+		ret = fdt_setprop_string(fit, noffset, FIT_ALGO_PROP,
+					 algo_name);
 
 	return ret;
 }
-- 
2.43.0

