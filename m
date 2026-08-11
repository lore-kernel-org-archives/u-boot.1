Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAD7C5AD55
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 05:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB02680E9B;
	Tue, 11 Aug 2026 05:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EN0Ck7kyfYzY; Tue, 11 Aug 2026 05:18:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5489B80EA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786425486;
	bh=rJCWSzK2chBY6ljE0rUhjxUUZ93etQQYhAGTgAC5sxk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=K5UEpvH1gIAm+ETkJY8bdP3WoD/X+fz0n+xF/1bQEuPm/MIh4V8IZyZ94I2gl7CWb
	 UUZzQC2QFb8vXWmrAb34JNqhNrae/b/zsjIPvHcwY+o36kSnCcwewiqDCmYrbFpObq
	 MV7aDIQuw9Hih7o1SZmDaVuosszngx549lpWxJL9W4BWOPJoB/GGjUGLmEIigq1oJs
	 XKlItZAfHwKSl4W81UsKb8ZYAdTbNQU3sb+uSYgmFVb1ySdLsodkr7sdkFX7LIVT1h
	 Bj8Bf/+JF0WtIAhDsuFJC3HeijGizpnpcPPYiIp4BcborEHmTFgQA1CBRxbCpq0kE9
	 2amPDPfJj/8+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5489B80EA7;
	Tue, 11 Aug 2026 05:18:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B6AA40A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 994004005F
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:18:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vwtoDfWMfkPD for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 05:18:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E80BF40050
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E80BF40050
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E80BF40050
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:18:03 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6acc74fee76so1176199eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786425482; x=1787030282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rJCWSzK2chBY6ljE0rUhjxUUZ93etQQYhAGTgAC5sxk=;
 b=a7VivH2F3r8ZTctOxCvRxtbBnkYLFEALQjBV17Ji6G1tZjeIm4WIitAB264oHSxwJg
 Becw5yjQkjOh2ozH6B2RojjmpQeCn0nrWZfz6gZ/8qFJqdCtVSJTvTdxrRW2m8BhgB5s
 O/FoLKcuos1HYQPSFx563qU9wk0m5QpM2WRzxqtPXpdcrtyy6hMslpw+XvHXwp6c5nzL
 Q4Ak7pKVw17ZLcBohPISRemAc1kaaFv49M0gcKVNm0QROyN9Oc1BV33kjNC98XhhnDx4
 PBpkJmE3yn/Qs9PbKymZBbiArmgELwqs3Eg1j9SQ/bCLwngFinM5WtG3BjY/0AZuo+Kf
 HQIA==
X-Gm-Message-State: AOJu0YzZ2CgrfDKanQHn8bgXa9C1B4p4+jhP5croWguSdsu7zeuNrEvg
 PLNGmQmCoqBZjQ99ArwR3MmxP49P5h+BDzTnmhzcZR3Pii+rb+q1gfl3MHCnkQ==
X-Gm-Gg: AR+sD12FIvmP7w1IQRaClP7IZx/7oXYaNoFJ5H2bYi8Db6qqDP/08u6hVi2vLzb1aa3
 35/MDSdGbhc8LtSAZ892BmDMdUwVa7nSF6NFvhzGD71QMXL7q7klomJoRSeDNj7iv7OCS7xE0xN
 yDNTHrso1n37SLKbj/lOc52hjLVGJazCCm74vdvOOU7v3gvR2QmnXJdNW9wphmyFm8qLr7WIMMY
 meSndaLNrDcT92uzIrqpPmfZ+wX8iY9/fuc3NYJx1vI8b48a/qdVwQkRGrlDk0rmcWcyZrzUmDl
 wx/R8hpKeWhYQPIcsC/7qrRLrXyV7gOEU0i1CNqXHEAq9ssb4uF4YAB1f1Lem7Bi+TxyBdAuNGt
 dgv97CEQfkjy3n6/wSSTQaYSuwItb4a0X4jgpSzE4CQsAssEWVSOjVBejAQ5HquKN+be13vLQto
 dOgzpCAEgbXiOa+MXqXzzV69SlPlmfrghfBBIHBE70uw4pNL3PPy+iys8h2sL/09W2g8bt482IN
 saKZXRFEIv3YnyjIGoUmmJlU4j6mbAZWZzvWdR3OJ5dx4cthhK/KLt1aOECph+lVu54Ur84RH/3
 eZsrm4vw3GBbXhcmfJirj0l3QNEaFsNDGACAPS2qB49C6tn+A4dsD6uAOy1pyKYjAQuMs4VeJT8
 /JlUKx11rbreYfPGxapvfLm0+7X1Dw8Np/D+AtluIv7xvIGWJ
X-Received: by 2002:a05:6820:1a0b:b0:6aa:e176:bcb5 with SMTP id
 006d021491bc7-6b0a2fe9ef4mr268501eaf.14.1786425482549; 
 Mon, 10 Aug 2026 22:18:02 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (184-96-154-59.hlrn.qwest.net.
 [184.96.154.59]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b09ffc3d6csm568441eaf.15.2026.08.10.22.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 22:18:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] test: dm: hash: check digest size before memset
Date: Mon, 10 Aug 2026 23:17:41 -0600
Message-ID: <20260811051750.164470-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786425482; x=1787030282;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rJCWSzK2chBY6ljE0rUhjxUUZ93etQQYhAGTgAC5sxk=;
 b=EmiJfxJh7IxAO+6oZs4k4Mp+0D2GcvTHlQ2fcqXrWlZT1oo1Y0iO9iZ7RQi8ZaJ3yX
 TD1i/Th2qIVlLhk/PQRnGzDkJYf3ZLmZaCQUXF1yJ0lZpBqgTKnaUsKjOwEK6k2q083g
 QkhpjTjxAVoOSyQL9wfxzCIGmPEDCh+0jM+yQvP0jH9vwNkeSchvDwY1o3OCu+X1Zf2J
 EUcYs/qm/btbVlcWBCMfOzxo+bjvOlCmPj2JLrBCOvLRdWXhTZImbDoGc1qHWtrDoobv
 /eryQhLPNbh3za9qGerbk+oL1vi2CqJjxCaf4Qjdo+H58MtEgqUv/Rj9ab8SyTuHINPL
 wgsQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EmiJfxJh
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

hash_algo_digest_size() returns -EINVAL for an invalid algorithm. The
test success provider passes that result directly to memset(), where it
is converted to a large size_t.

Return the error before touching the output buffer, and exercise the
invalid-algorithm path in the provider-selection test. This addresses
Coverity CIDs 652907 and 652908.

Fixes: 94b349bd902d ("crypto: hash: use DM providers from hash command")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 test/dm/hash.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/test/dm/hash.c b/test/dm/hash.c
index fe949e33de5..6adf916dc77 100644
--- a/test/dm/hash.c
+++ b/test/dm/hash.c
@@ -31,8 +31,14 @@ static int hash_test_success(struct udevice *dev, enum HASH_ALGO algo,
 			     const void *ibuf, const uint32_t ilen,
 			     void *obuf, uint32_t chunk_sz)
 {
+	ssize_t digest_size;
+
 	success_calls++;
-	memset(obuf, 0x5a, hash_algo_digest_size(algo));
+	digest_size = hash_algo_digest_size(algo);
+	if (digest_size < 0)
+		return digest_size;
+
+	memset(obuf, 0x5a, digest_size);
 
 	return 0;
 }
@@ -124,6 +130,14 @@ static int dm_test_hash_provider_selection(struct unit_test_state *uts)
 	for (int i = 0; i < sizeof(digest); i++)
 		ut_asserteq(0x5a, digest[i]);
 
+	memset(digest, 0, sizeof(digest));
+	ret = hash_digest_wd_lookup(HASH_ALGO_INVALID, "test", 4, digest, 4);
+	ut_asserteq(-EINVAL, ret);
+	ut_asserteq(2, unsupported_calls);
+	ut_asserteq(2, success_calls);
+	for (int i = 0; i < sizeof(digest); i++)
+		ut_asserteq(0, digest[i]);
+
 	ut_assertok(hash_test_unbind_all());
 	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_hard_error_drv),
 				   "hash-hard-error"));
-- 
2.53.0

