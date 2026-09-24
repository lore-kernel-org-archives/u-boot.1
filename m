Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA3AC98311
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 08:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2D0E40E2D;
	Thu, 24 Sep 2026 08:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hIZegjsMgTn5; Thu, 24 Sep 2026 08:59:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8ECF040E02
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790240354;
	b=Zc23w0WOpHb/3DlN5lMSOh3TTPqAsltMDvHs8pznStJ7gSzAuJ4ru7FRu5hMkVSjNXqr
	 F04iaAigw4XDxOUwYOm/pSOmX1XuzkROQRJjwyt99RibY7f0ifJ4tBL3vLq45LTCVzE1k
	 zJvDgSdvURmkoGiAsgzaEwa/LM02l2cHAKpAFf6wD8qBrTCv7/Iik0GW3N/OPuTt8STGc
	 rRkVVxXS3K5l/PPF3CL20mn7Bth1lLTaIHf5d+usmrDS6ThEdKVaA0tYSClhcoAVBDqhJ
	 gNeih+EPWcpDZksALlViwhNYyXPvnz4jAdOVN9XDscFziW2GQjsYQy9m9etklC4ClGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790240354;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aFc2Zgu7CnSUztB+bMxex+ZUiN+qmjVhEedSz2FvTco=;
	b=raWMrdQMmSeotO1cyO8oYJ1K1GYkAtfHQB3QCucQMd6A8j8+5z2yL0vcpKicu4puCehZ
	 ndxGF+XHybnWHW4yBuuzIxTqFGbaMc21iRgQuWA283Yfg1bnSd/Ap805FwvOoZUV86ZiN
	 k80hCPP75lhSpAA/hE533YJjqf3/6P+Amkm95jgNZNIe/+/igouArO8ALUu3zdIHxvsXj
	 spUHUuLKJoPdvg4l4d6qR2Co2JfeqV/DsYvVzobhtwQOe1NxTV/RLvof5Z4hWf9MEr9Il
	 Cx3z3EGxwM+SVzPME00Iiw+5WwV0ei8Zrnw0a8REHfhBlvslvX7GgTLOGRhXvf3oGYw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790240353;
	bh=aFc2Zgu7CnSUztB+bMxex+ZUiN+qmjVhEedSz2FvTco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xjRkF9crXWfbtWUxx2Vm3W4CM496mFttIJxsBZC/hEJs/Fe45dz/RiBV4fkLH46ol
	 wvBEnINGGovlqsS6fB/0fVmLtd8kJibdxdkLk/RoGrAjCNxNPeR8ADWlV+9N7HLyxI
	 YtU3NAfOBVeih0yHF+qb8zSkDI1CRX0EANLRUfcQSLTRANHimPQM6M10E2UJe6fhQ3
	 K4ShOTDquScmc3bnaw0eN9Yt4037aGXjDphBcCTwgHuGdPhV8WtRN6D6nk/c5fXCDP
	 lrUSCIbupzeTrj5XQSIx2+De1DdSQnrqCexzvsnNgwV3wqpVuvJbilJ61aO1GcwDv5
	 UmBWnWQHChovw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8ECF040E02;
	Thu, 24 Sep 2026 08:59:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D1F371344
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B558860B2D
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B4pLxCqjwK5v for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 05:55:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4F6E660B0D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790229330;
 b=BCGf+s8YYa9ywAMmF+Fh3UawLldGzAvJvkbEEtvVpXQFgq+NiWzT1pyayMn3XkMCxBTE
 A4B7TLDbXUOhbyFdM/VL0QiNUdS1WHLLq2+Zl0GjbgoUqMoRV89wTAPGBCcXBHgZ6ZVfq
 fDSJo56H4caUipj5yUoHkU4GdJ1TsnjJ1mXs0+ZZAV2SNl+gcxpNMM2nz/LVbJmIm6Fef
 /0HyXvjFN2B6q4jA2MJAqhE+vndvQ5Evp55AzDLoWJs06XGOEJlCx4e1ADA4gplh2WN07
 SjxTMrt4UgopAuTTa4crMwMWFXwQVYzf5UnbbAtcO8xMkS5Cwc/e8sT6pddq9vqbOHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790229330;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=aFc2Zgu7CnSUztB+bMxex+ZUiN+qmjVhEedSz2FvTco=;
 b=g+D/1q+cyzrE9AAdb12ba/MG3InXPMgq0A+QUk6rr3dBMGJyp1fAmtwEylJQ5btHVrAX
 jhRmsCkYNFQdgjfIhoY9b0foX1flT9cJYQp8k7DTjlqp4bS9lUM/EZl/ZxHQ+h9nMBIF3
 wAYrzqlCuA9d6k5HQpcduHldTy/gl2oh1OpohrAImYSUvlBvYifAQFtyzTtqOIPawg3G7
 eGVhgAnmPGoh9vrs6eZ0xgzONXsKODGPzIkYlNIbyoxV6pAFsAc9t0hLqT8To48y2snn3
 /mJFOpHOHHkdHTIq9ZjeXYUT1y9AoCpqo6C64Ujy3qwIOPNx5XSWM+Qs0JnO6T+aTsA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b="c8xn7/P+"; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=c8xn7/P+
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F6E660B0D
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:29 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D6C1B3F51A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790229327;
 bh=aFc2Zgu7CnSUztB+bMxex+ZUiN+qmjVhEedSz2FvTco=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=c8xn7/P+t17hHKPLQmHHRh/dGuux12lQOADWHQXAKN8mVGIVSg3g/kZGihHyqUqaM
 BITSkHShzWEokYrM5EcgfrAgwJeevQUyrNsQO9o52+HZorsmPZPkArvf0RfMn2UYxf
 tZEXlIlARbi2ozFZOj/CGZ/JpUJgs/lROAnb7AFVvyq+w0HSpTLQ3lrAXQ9rlN0QdJ
 2XD6G8oueU+6/DwqWN9+vCcKGKAdEDiss59PJOzCmkbLM2qANBrP9ruMICQAvWQTCq
 SQcppjtBTV/B0wjC1l+VeyznBD8xkoXgYSzhtOPbCVrutYHD/J/Ebqfev4wMfN11ut
 T1b5RCaayHb7AAQzkU0ie6FYnCTSDJHGn4B56lF/El31oMGUz8Vdc0tJIUfbyDBFY7
 +7XkgBmudRA3LRuENX87hQLzSp/Iw+kS9f7QhdsLYpfq2WdAwXyfeqRdym2b6PWBDX
 x+VxLsJ69Wbj96UmVeWRjSVkG2B82D6ihZh2v69e77yVAS4KfGy5iCorpc0aJE4Ojf
 TSpXlxaGYJV7oe4n4kXCn/HEt18+RhAPlmifdZe9AGELmD5O6noGrKBeCzjVb78n8c
 XB3XNFFg8MfeuGLN8mQiUu4dpnprJOsnAgVDe/UMyB8aMK/wJvSzvP9I0sHTE4yZNa
 9RWhpThG9BrtunqKh3387UlU=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d9336581a2so23607325ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 22:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790229326; x=1790834126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aFc2Zgu7CnSUztB+bMxex+ZUiN+qmjVhEedSz2FvTco=;
 b=yvzdNS7QnjVcfaNgBVVuh2vVug1fwb2oDdw4dR+vVahDQYq3+thfe84W1Sij7yTSeI
 4ZpLFjAHeuF2m3xdWs72fVxug6dFXPXAOhuyioAVk2abcNm5WkezXAAftt1I4syZ3IJC
 0G+OhSK/GM7xJzEtSczkYNDAWCo7TvVjNHJPWbicS3XBdS961eLwaZwB3IsqkeuHmxbg
 pvruBsSjRzPG22jEhHB6Q4QUz2LeW2l8tot+skL5BnSKCY/E/g2fvmE/+E5+rWVpEUjM
 SRwU9VlMR5Igjg8qbo1VmVr+Qn1quA5JvHDMMmBFW0ObrdbDi/tjrpPqlcgwut3FjA5E
 +vlA==
X-Gm-Message-State: AFuF++nLD7qhcJ0W0hSRG2gbNpzKjxdXjFskqoVewUOSMmxxIFoItPXb
 YhgVDimF5V6+j96Vm5QtWnUjUn/qw9++9cNAiMLG7xy/xHGOg33aVBkOResIStpNkHk8kE1ONYV
 aHXCnEL5GA4LVYbijlkU0W2jrqUWnN8J8CwK3M8AhAbCOUzqofgZ7Phti7zGMbrS8rDN60XTLwg
 1DV8LCCLByiTXWPF+NIw==
X-Gm-Gg: AYBFou3W6MswqMNlcCVN2hKAT7f808PfZ5c2VCe+hcBTnxgpTpgA6RTUMjNmvtEqXN8
 QKA6o5qgb/uqItC4pc17SJ35J70cpfLRq3n8MRsjmkMZgqq2R57SBHJk3IhSdORmEoPJ60thCtE
 pJNHvyJ5PF+nD4JlQqHdrPXezwDTBlYiQJSDgWRur+sG+y+ZViF1uBVad9yltyxBOQ2yGslw8qK
 chIl4FCAZmtLdDu8Rt9LAznmDR/4KVItt4kdBsdN5zQEbLSBaLd3BcS/vBbn187qS1UxrWY0CUU
 ur8lhetnGUElsGdqP4wzWZEe1PFRWKFOE/84RlBFCjoCpP3MwiYqu7Z7VH/8VwmNiJ4E5N0wNOi
 wc0aTGkjAj5d1SlgQR/cv2PH/WmnSNUDeuWGjKM0rQW3HaCEYacB4RgJA+xaCdO7QA8uFJw==
X-Received: by 2002:a17:90b:4a47:b0:3a0:8050:2ed1 with SMTP id
 98e67ed59e1d1-3a098abd820mr1411383a91.63.1790229326300; 
 Wed, 23 Sep 2026 22:55:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4a47:b0:3a0:8050:2ed1 with SMTP id
 98e67ed59e1d1-3a098abd820mr1411365a91.63.1790229325833; 
 Wed, 23 Sep 2026 22:55:25 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09733f48fsm2825829a91.11.2026.09.23.22.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 22:55:25 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 2/4] tools: mkimage: use the name argument in
 fdt_property_file()
Date: Thu, 24 Sep 2026 05:54:50 +0000
Message-ID: <20260924055459.125648-3-aristo.chen@canonical.com>
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

fdt_property_file() takes the property name as an argument but ignores
it and always writes a literal "data" property. Every caller passes
FIT_DATA_PROP, so use the argument.

No functional change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
v2: new patch, split out of v1 patch 1 as suggested by Quentin, no
code changes, Reviewed-by from v1 patch 1 kept

 tools/fit_image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index f7d11904472..077906889ca 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -250,7 +250,7 @@ static int fdt_property_file(struct image_tool_params *params,
 		goto err;
 	}
 
-	ret = fdt_property_placeholder(fdt, "data", sbuf.st_size, &ptr);
+	ret = fdt_property_placeholder(fdt, name, sbuf.st_size, &ptr);
 	if (ret)
 		goto err;
 	ret = read(fd, ptr, sbuf.st_size);
-- 
2.43.0

