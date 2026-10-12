Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695F6CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51D6A80DC5;
	Mon, 12 Oct 2026 14:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4BX-uzCkIP1c; Mon, 12 Oct 2026 14:01:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9C06880DB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813683;
	b=KrbVk/Oke9s6XOq9rV68HLXRo5fLdF5snxPQxM6cAv/Ff6w9Ft0ZI7RgrawomMJdLukZ
	 O9QvJH6FT0lUUa7HZy+U3IjIPAYscN3hNj5exm0v8qBqe46oHUP9ByDiXDYsTkrLrlc2o
	 XART4jWWYtIBE5ASeQYUXCel2zWm7gJ6f9rXSYZSlwAAXygCcdwP7by6+HSb2XJyRDPAx
	 LPzWN8I0KZc5i4I9MjqGIkAcgTh6GsQTnPNfzXm3ZO6gdPxT8aeDoTEuYQT58xZcwCi8h
	 TxNZozdmmtSp8R8wTNbf/pFR6tjgqsK07PgSlRhfKemzVPAbPVNwCcbpkSAkL99wweQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813683;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O+2iEn2wJh10qhSoM1uM1UcZeaD/tRv048GX9axQpuE=;
	b=CEzlg0aJ5LormqOXKy7jELkXLptaKhaItcDv8AqFGLUIN0xj3hv7YDFwxNy/oaQd+C3v
	 D4KarCneUVaOGAKTcCuvJ7kMNR7n665Dm/3P3k57Xz7fMSn4k7+Xy+F6C8ErfZuhKoCS0
	 PAvNu+iL+0HJLqcmiUYpKgbq1Ttb0PX52LsULK3+0Hf0ibkJtwmBQfZEW/IXMqGBdJoeZ
	 OwhwUjx7wNfIxvqLV/k085e74B6XyIWuFIOKS9xETDYeWEVqOgXQKXbRRf7ylc/EH9Qvk
	 +v0YIhhkZs1lm+5QJ/i9U8RUVwQUgpAKRNACtleF1qjv/vk29IFzFK0ttfwczEvu9ww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813683;
	bh=O+2iEn2wJh10qhSoM1uM1UcZeaD/tRv048GX9axQpuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jqunLgRmyJW83q/Sc9hcnK2t2zxzykRle0mxnF+59rcvw8Fxa6pA5wPtGYEaQEkVY
	 RhNt/jjkZweXrcrbMI/VsA6FxURHti5rDhIg3tasyHy7Q7aZnI3cgYH4MlExhTbkIy
	 Fer1Tp9SYVOqclT9/SP3vlLn193QdJ5c85PinfUqVqf2zJ68nkhh1GfD/7iPEBYzQr
	 RWV/giP4tKAPb8vr3UtrD7T345fKXruRrqJON9y37C3cLZWYKMEkG8Pd3J7pM0mL7A
	 4kA6hitZchwDES12CZnpFbD5n2HjWPmQ1pW7tBr8C1fH8YyMXXO1AfT0ZwdHJe1S0t
	 +uxj6uYbAKDOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C06880DB2;
	Mon, 12 Oct 2026 14:01:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 519832E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 436CB401D5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lxBlNSHKE-99 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:01:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 449074004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791813680;
 b=pcRVZ+x9DxGBKk6lXteV/4aoVad7lI0ijvqgTQf5y6CMRDEqFS9ivIZJ5CMYJvDzhMyb
 O571OUjucMxuoJfQMyRIV7IDlEU1RV3u9JbEFp0ZVoCnxTsK73+CfHfHuKBIgIXLTnmJj
 G7KHHZNWHEg8m7N/lXC9wOkExgWPq70YsqFQG+n5oO0hMN110ZvfKJFn3iVuIHoUX/4Cm
 O2U3OCGFTo1ZFjwvyVXeFeXMdxvDXhjpLWA6Fw5BeT+ZBh85AbHTzZYCDsZK713bj88YB
 PhuQfdnsJAkpboSr+VkQbHvV12fVakYYz3X5LgHGEDUpbwMQFzX1y1XFcXXCa95w8EA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813680;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=O+2iEn2wJh10qhSoM1uM1UcZeaD/tRv048GX9axQpuE=;
 b=aoc+obHax9U3ATPOK+iBATwAkiCXp3mJTJmARTGgt3Wbx8gm4dVIFlu5+dUHcT9YFK04
 c+5bdLT2NHaJXNxEJFkEm+tHH4wHKpdyWsPGMUpHr0SsdeFCOXJ07fVMW9eBch/h7cV6q
 BLJb9F5MabXnA0vkZypSYMGQIvDjFGwCjyG/tXZLUjRCogUV0QLpZxxoASDC3eBuezd3M
 MFWsIXapv57w6fp7DaH0HXA/5BcOGPVFsTewVCJDi2rHdHPOqwR9m6fC81kGIx9kyVdb+
 Ezgzw8mV28o8mJtk+/KRgWDuNPsoHGDxPY4TxYKFYW+ND8Zg5/pavFrSdSujjJacZpA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=BIn14RBT; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=BIn14RBT
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 449074004D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:19 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A4A73F32D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791813677;
 bh=O+2iEn2wJh10qhSoM1uM1UcZeaD/tRv048GX9axQpuE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BIn14RBTnyREQqb5/dDcnkrJXJXYwlIzO6lSbARnAcQfQ+6ZUwtTjr1hC9L9ISqwS
 TMto3gdP33dal+CLehkSeTCkQhw/qY6pCt7wNHqtHajDOW94T52IVg8qzVYG+qyWSI
 ZHbetuao0PDQc3ngb684Iysb804nq051jmsdWZox7iiQHT0q/TI5cYhH9kkCGg0OG9
 WBj01egwJUffGMAqpqvFKF65+eXmnfj5TFdp+tflEqnH5kZ4vI3nM1lsXurWwIKV8x
 iv1MOaXDNSkv48AIF+XoxZ1mewk1G8ECBtLsHHrZ35kLLI9A01aX+7AAAIJPaOByHC
 0owwZMXwq5YDhuWXB72ZP4cyoXYLexCJQ0wk6s8qxWHUausARKBhD3J0CCZ8QETtAI
 Hqr63sN8n5p25iv12xmUjkHor0YGbGESRL2NDKjMToP67X3upXVqyGTQwGjCI2dVsq
 3XIdNn3tGrjV+1n50mE0ltHkC0CGAzK3bHCW+/jbL1JDBbFndwslsgelpJupNunWF+
 lv9pAxzlNnUc7gvatbert8Kl4fZ66y+FyqtepJkKSEpKQICOOg9rwL9ulLDkxfYnDI
 9qXV7sPTFKsg1MebjAvxVrauaeD2l4stf5gmmblyvd+08UcZqXPzHJvtmdrmbRV9rX
 w1tP5bsBFuAqZoN1AYcGwrdA=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e6b5c5f44so32244885e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813676; x=1792418476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O+2iEn2wJh10qhSoM1uM1UcZeaD/tRv048GX9axQpuE=;
 b=pDOINSWfIyQ+C+0+0r5BVzf9tVuW5I3i7MBUIPIlnpaYiE4auptCohZUuNTzIMiPap
 uR1pt8uhbotrDHESJ6Nm6RvWZGV7dgAMeUiloOyZMbUchg0DS8AbpBzpTexaecsYN8n2
 j1YGtYNJ2FpJ9I4AyuOcOIqA5PlGub8DktB7RmDQ0S4eNmClYrYLrjjiHT8VmYPzh58U
 Kta4/nIxCp3wP9S0k2ysZAPcvB1KO68yqK4spJ+7dOuVIGmjaupK0QUM5xPIBRVGWD5z
 cJIBPj+gFapQLTUrui6FS93+z68SjLVbZ277LNbv72lW2nZzglJHIF8vNMEqdc3C1C4r
 ZxCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0vri53CMjkgNnLV93LwyqTygjm7+UQ4M9oSFO9nAw5H8gOLoRI+BgyrgjuC+so1R1ZVbkyz8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIQhqjIUSglgIHyIsvRaLAiuUJlnA/7ge69Br7DMZVgBGmVBVx5
 ParfWMARCRE9qZMSVxG6tJxk4Li1qT2S60gEAp2koNoVUgT2wT+J2tPnVuPZW/MggifEdDRKJh0
 hdX5snfaoWEqkxOtJG2EoJji0i5e1QjrlpxS0oeVWQ+9MOI7HFimBnXn+2kIuRn9grVMaoD3HjU
 sdvjsNB2qDkA==
X-Gm-Gg: AYBFou0r0tJO/Pk0asicEnhPHEFsKUVExQ2Evei/uaJZ70oZ6G7KylLkN7oci7GOOmu
 BMBGRwcj9YGt8Zys28tqnxvmtV5642NRgOobNWJKAhT0IvL7OAx2DQVKPT2SGHH7pW0t1r8JX2H
 5k9ZXjo1FfAQWj8l5QfTE6rINYCdde/zApo3EHkYIkys+uLix11cF1t0iTW5RpVPJpmFsHDlaW1
 3OcmPWFpKUeTszpqfVPa61Y/lACQaxDfY9n8OHirVIlDAEUnVOOBy0UIIfl99oYNEroo0UijhOX
 zscMlLoptWc6QTSfmGOH4wsJJb8gnPUrrTRnJxyLetsdkY0vAixaF7kPE05+oqPttMRDI+pXzRE
 D4alFNG8RiixtPEYz779cPBASI4gW3R+pOWiOiJTE+r6Lv5gYpuInf7k=
X-Received: by 2002:a05:600c:a00f:b0:4a1:6c0c:ab93 with SMTP id
 5b1f17b1804b1-4a18e4e24c7mr185215095e9.28.1791813676279; 
 Mon, 12 Oct 2026 07:01:16 -0700 (PDT)
X-Received: by 2002:a05:600c:a00f:b0:4a1:6c0c:ab93 with SMTP id
 5b1f17b1804b1-4a18e4e24c7mr185214515e9.28.1791813675606; 
 Mon, 12 Oct 2026 07:01:15 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:468d:767c:32e6:22fa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm284551015e9.6.2026.10.12.07.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:01:15 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>, Tony Dinh <mibodhi@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 joaomarcos.costa@bootlin.com, Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/9] fs: ext4: print change date in directory listing
Date: Mon, 12 Oct 2026 16:00:42 +0200
Message-ID: <20261012140048.214059-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
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

Declare FS_CAP_DATE in the ext4 fstype_info entry so that fs_ls_generic()
displays the modification date alongside the file size:

 4096 2024-03-15 09:30 filename.txt

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs.c b/fs/fs.c
index ad577c475f5..c2a893f6ff3 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -262,6 +262,9 @@ static struct fstype_info fstypes[] = {
 		.fstype = FS_TYPE_EXT,
 		.name = "ext4",
 		.null_dev_desc_ok = false,
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+		.caps = FS_CAP_DATE,
+#endif
 		.probe = ext4fs_probe,
 		.close = ext4fs_close,
 		.ls = fs_ls_generic,
-- 
2.55.0

