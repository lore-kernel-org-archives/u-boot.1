Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD13606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tvBboOua;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m7BwpgTu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74F5A8121F;
	Thu, 22 Oct 2026 18:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NKHQs6TUcJVA; Thu, 22 Oct 2026 18:40:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 50E84811F3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792694434;
	b=beainfcyoKRsauPm6cDevcgAxCHkwGik9gHCg4SoCIM1BvJ+cv4JmSqpCCn0iQow02Kj
	 ra/2IwP3KgCg50f5vBTHsFP2qldGjPHd74w1loYBeVybieKOKqzTkxbIprqs29XiTxuGz
	 kfRsK/+8FUES9PkR8ocf136N5QEN1QhUhGrG6HfpVAr4FR6FN4wRSbWQXNvCBh7iN5PlW
	 U7xpzkhND2nurhFCqD3rn5tKKmAYFiJe/u9S4OeTk/yKX7XWNuDKw8Xjnl5IRe7JKLvmV
	 gdZL+x189vCzxg3xjwP1RtL9yJ63SzHiE8bRcntWCnjfhqA56u/ZLLLCakiga2SSIRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792694434;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BuWdhy1jsc0HW4TV482GO3U/mHQSdFTcQDmPVTW44tM=;
	b=ljVp8uBcrCOIKqCo0UcEw7dJ8Rzd/1LRsorDoD7ot2Tn1TzRk5m0MzRbWpMEJooC+z1Q
	 n6SPGMNzbZznY/lsJld5XDjhw6k9dxZEHdOD5UjcjO5rUfTrdY3oAHyijQLgkQnk9COy2
	 DxL4czv5XJ5RQvCompsoW2MJsR8DdSqUAaV+OVABLTycTApKhEDwCCCOwDtVGT564pvX1
	 1o6rW8epwjrg5hVwD9N3RQpIghYUv+gi67Q3Wk+04Ca/absSjpUg3hgFRD3tUVZsFEZHt
	 ++Thksyyssn7Ui2QYARRvPOTo/wGD5KpugUxFWWwCjBDC39qd443oNYkbXN8yckofiw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m7BwpgTu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792694434;
	bh=BuWdhy1jsc0HW4TV482GO3U/mHQSdFTcQDmPVTW44tM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tvBboOuazVdWHxmRy7ojOFqL+Dle+UGKR+j2/+X86hIBq5yu5ERd2SGadJ06E7dv+
	 nn7kDnpM6Sg+7N1jrH+zJQZI2V7UEyGqpoAzxuWOdcU4/LOJikuXakksyIVfjwuZsf
	 7hcIbbdg/U88y4wnqRXnuO+pB+IFXKeqGrKSIoJeCCBfFVuvELNaP9lN2bjPWhRCtL
	 VMRFlDagTYPQTCncAu6E50T3q0HMakcdUMlRezsH5ssu7lEd9HuCZwR5vBoQLc6Sal
	 iTsxmA3Qdz2NBEUmk0cVYIILcJLM7LssvHl5ZvbgKtC7icp4sluLjF9EinCom5aRdK
	 RyAIsWev8K8FA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50E84811F3;
	Thu, 22 Oct 2026 18:40:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EEA43C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D84981217
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mJiM_v7AOOHX for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 18:40:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F05F9810F5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792694417;
 b=kmrCN1FNfD+BSzEAr682P1BxSvtDqWv+LVOEAIEJM0rJOm7zAgG09liqJiw1G+NVcQa2
 OeGH27NCRnKEhVgwV2aSDPqAzagBMnngbxJDK6IFgIxhw+DgolA8JzVddarmOyAqKD1kw
 XDivEe9Fwxm5/vvzfnacR9xG6lyvgO5owhGsipY/YhGCHdbWEAu5swofHw9g6kLicm5Qo
 XuYc/lBYRq8AHlrSxTxXxbKh6kh7ALFGjychCXpDlP2/X92IpELm5PdwUPnZnSShyhrJj
 T7z1pNpXnbCYkTFBdNBijayAbx0Lp8FojSSaPHy68gZGPqIVmllDj1RLlY3lFUPxYIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792694417;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=BuWdhy1jsc0HW4TV482GO3U/mHQSdFTcQDmPVTW44tM=;
 b=hlGfuttTlIAt6ciH4nPCz0Mf/BO9HTwTUXrRAfwTb/zAWSRAlQNsFY2GvEfHD8v9bzXi
 SyIxfum3I7ZxEVQi64rqVwC7OxkcItyivtvujNKdN/xGNJbxyFuGMHv7nJdQBrtJnEdYs
 kWa68mUjJQ4xeIxF0/UpZULL4cML91C1E0El5dFC5eyvwIyLp/IHhjjvaudtzYl+Qy3RC
 QQJjcTMX4J6zzZ63uH5JJQVv94xrmq4gwx9EnZ9tq6dr+UPOwuRvvd8sW2hyRj9hIdnDS
 th4q9T5ryNkrHHlvHiwGugzHIdhAqCHSWcs+Wx3y2doRm7qf1RWIuFWImYmBCdsw4iw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=m7BwpgTu; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=anon87111@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=m7BwpgTu
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F05F9810F5
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:40:16 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so67526f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792694415; x=1793299215;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BuWdhy1jsc0HW4TV482GO3U/mHQSdFTcQDmPVTW44tM=;
 b=m7BwpgTukODO7syVQwvaDT9EtPQ/ve6S5oKbiiG3WOanChI11zmTKQFeuoYudmmXXl
 g9w2/WG3ka7PGpbldPsHs9rSeJWNm8hOnt7sZt5gq0V9ccsMLW6cABhhsN/7mX7+gWV7
 QEL1A1ErKD80RbL7RoXfzZLt1wkivFb9LDhR8KWH6GiUETYtfzWWUbAjKmwbk1DiuJKa
 PCdNHoD9wBIm/Z2HLYSXjW2wPm4Ss4rA79fq3cnKADiYx1awmT2SWiaC9pq3IxMsxHEO
 qHcuoffHgBVEXcCwfdowPnS4rfej9EnvSa1AZyzttTgKAHWKKX5iMt5lRI+W8nesxTbk
 Qy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792694415; x=1793299215;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BuWdhy1jsc0HW4TV482GO3U/mHQSdFTcQDmPVTW44tM=;
 b=D+3sz3Tu+eFVSR1afiSm7wtmpG4AoRWp8I3QIPZm8tSTy4bB1sUaO4DC01eCgDCV0i
 9H88C656YPb2+QA1pA+5QkmCRcTFRMhnWllCoPgsQf81joKD2PFWmDLapxxkCAz0ClpI
 SYJHwt6YOD7+X6xsI8MgqfvODVA3I24CagprcEPKVuFzP+/jEleRYgNHuHmw5GrPgTG9
 1OaHWGbVJ08xco8pTIe6y8Na4YY0Fr8DLzlYKG00P+WJapD7OpL3L40prMNXvyXrc4fk
 Z3nWfLw/+qjGWAfl0PhnE2sFVvrCjEtCKgNtijX6OV8tt4J/VH4EQgQ/WSKmsUyBlSc0
 UFoQ==
X-Gm-Message-State: AFq9FYIrPYY6BfCyMaxb8VHfRFrjidYxg+R6zKUNSorkA8DEs9tG2LSa
 DtSd9FUUvTydCfglJ7QX55WIDkfWe62BWTosuQOj2H0GlCCKs+AYZYAxSIk9/ii4
X-Gm-Gg: AYBFou38rOF13sqn6QP0m3VNCKlEHhJsdq+Hq0O6yhKupKG5eKvMLnEvS6KiybXYKcj
 DamNWz6ePsFgkiFsnLr+/Q0Ub+42diDKCWA4Now6rme7eijLVkbgPW190HH4UiJ+lNYNo5y8Qty
 qaBymVVFGtFHAiZxRpf8UVnh/lW+xUom03IusGF8RLJkqITZGBYRH85D6lt8JGleJJ9TwRK6I1V
 WimXTk45yebNtGTfwJkiYgcGLWtK6kYr4IZzNPvXdHWpNfvWxO8Ex4tcDcCs5JTmeBQ6TS2fmk0
 flWtnILwfE0D2m4XwICILXk0txTbh4Kku/OvWOwipU2iHivuw/K2JqUrA1XwqPuGoTi7AOVRWkN
 35TnMhSa9wmPmUyk4FU3rQinsGXlpfGZNX9emOluz7V+bqMvEJ1nYcw4XVfrXS/2DcMAOS/YNFs
 +mGs9q6V0J2ufHpRRSPClhXjiFTK3EvDaL0FJSBFnZYYGYZfylpyUvBp+Xxe/SWa9UjmQPEXZTk
 CAYIowZ03UCMGAmjeLotDlyuLarbhJ7/Hm3dTPS9PWIjbuEStKMPi1zPXWqq+poyMq3asGLrQAV
 pS3OCmkqiVWG6IKcxqTcZ8THx2M=
X-Received: by 2002:a05:6000:481b:b0:48e:37e:470f with SMTP id
 ffacd0b85a97d-48e264e6054mr11946210f8f.51.1792694414602; 
 Thu, 22 Oct 2026 11:40:14 -0700 (PDT)
Received: from ?IPV6:2001:7e8:c647:4001:7656:3cff:fedb:3af7?
 ([2001:7e8:c647:4001:7656:3cff:fedb:3af7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0f66dsm67644f8f.53.2026.10.22.11.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 11:40:12 -0700 (PDT)
Message-ID: <b710a08f-e050-4543-8c5c-291d73d56050@gmail.com>
Date: Thu, 22 Oct 2026 20:40:12 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: anon87111 <anon87111@gmail.com>
Subject: [PATCH v3 3/3] test: vboot: cover required image keys
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, 0xiviel@gmail.com, me@ziyao.cc
References: <20261022180000.1792693930-0-anon87111@gmail.com>
Content-Language: en-US
In-Reply-To: <20261022180000.1792693930-0-anon87111@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 18:40:31 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test for two keys marked required = "image" where the FIT carries a
signature from only one of them. Without the binding fix the single
signature satisfies both required keys and the image boots.

The default policy refuses it, required-mode "any" accepts it, and
required-mode "all" refuses it again.

All nine in tree sign-images-*.its hint "dev", and mkimage -g does not
redirect a hint the node already carries, so a prod hinted fixture is
needed to get two keys marked required on the image gate.
sign-images-sha256-rsa2048-prod.its is the in tree
sign-images-sha256-rsa2048.its with its two key-name-hint values changed.

Signed-off-by: anon87111 <anon87111@gmail.com>
---
 test/py/tests/test_vboot.py                   | 98 ++++++++++++++-----
 .../vboot/sign-images-sha256-rsa2048-prod.its | 42 ++++++++
 2 files changed, 117 insertions(+), 23 deletions(-)
 create mode 100644 test/py/tests/vboot/sign-images-sha256-rsa2048-prod.its

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index d02fa5b16f..db488159ca 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -84,27 +84,28 @@ def make_fit(its, ubman, mkimage, dtc_args, datadir, fit):
 # Only run the full suite on a few combinations, since it doesn't add any more
 # test coverage.
 TESTDATA_IN = [
-    ['sha1-basic', 'sha1', '-rsa2048', '', None, False, True, False, False],
-    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False, False, False, False],
-    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False, False, False, False],
-    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
-    ['sha256-basic', 'sha256', '-rsa2048', '', None, False, False, False, False],
-    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False, False, False, False],
-    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False, False, False, False],
-    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
-    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, False, False, False],
-    ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', True, True, False, False],
-    ['sha256-basic-ecdsa256', 'sha256', '-ecdsa256', '', None, False, False, False, False],
-    ['sha256-basic-ecdsa384', 'sha256', '-ecdsa384', '', None, False, False, False, False],
-    ['sha256-basic-ecdsa521', 'sha256', '-ecdsa521', '', None, False, False, False, False],
-    ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False, False],
-    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, False, False, False],
-    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, True, False],
-    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False, False, False, True],
-    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False, False, False, True],
-    ['sha256-global-sign-ecdsa256', 'sha256', '-ecdsa256', '', '', False, False, False, True],
-    ['sha256-global-sign-ecdsa384', 'sha256', '-ecdsa384', '', '', False, False, False, True],
-    ['sha256-global-sign-ecdsa521', 'sha256', '-ecdsa521', '', '', False, False, False, True],
+    ['sha1-basic', 'sha1', '-rsa2048', '', None, False, True, False, False, False],
+    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False, False, False, False, False],
+    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False, False, False, False, False],
+    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False, False],
+    ['sha256-basic', 'sha256', '-rsa2048', '', None, False, False, False, False, False],
+    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False, False, False, False, False],
+    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False, False, False, False, False],
+    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False, False],
+    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, False, False, False, False],
+    ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', True, True, False, False, False],
+    ['sha256-basic-ecdsa256', 'sha256', '-ecdsa256', '', None, False, False, False, False, False],
+    ['sha256-basic-ecdsa384', 'sha256', '-ecdsa384', '', None, False, False, False, False, False],
+    ['sha256-basic-ecdsa521', 'sha256', '-ecdsa521', '', None, False, False, False, False, False],
+    ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False, False, False],
+    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, False, False, False, False],
+    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, True, False, False],
+    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False, False, False, True, False],
+    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False, False, False, True, False],
+    ['sha256-global-sign-ecdsa256', 'sha256', '-ecdsa256', '', '', False, False, False, True, False],
+    ['sha256-global-sign-ecdsa384', 'sha256', '-ecdsa384', '', '', False, False, False, True, False],
+    ['sha256-global-sign-ecdsa521', 'sha256', '-ecdsa521', '', '', False, False, False, True, False],
+    ['sha256-required-image', 'sha256', '-rsa2048', '', None, False, False, False, False, True],
 ]
 
 # Mark all but the first test as slow, so they are not run with '-k not slow'
@@ -117,10 +118,10 @@ TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 @pytest.mark.requiredtool('fdtget')
 @pytest.mark.requiredtool('fdtput')
 @pytest.mark.requiredtool('openssl')
-@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,required,full_test,algo_arg,global_sign",
+@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,required,full_test,algo_arg,global_sign,required_image",
                          TESTDATA)
 def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
-               full_test, algo_arg, global_sign):
+               full_test, algo_arg, global_sign, required_image):
     """Test verified boot signing with mkimage and verification with 'bootm'.
 
     This works using sandbox only as it needs to update the device tree used
@@ -477,6 +478,55 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
                   'Bad Data Hash', False)
         ubman.log.action('%s: Check in-bounds hashed-strings size' % sha_algo)
 
+    def test_required_image_key(sha_algo, sig_algo, padding, sign_options):
+        """Test that a required image key must verify its own signature.
+
+        Two keys are marked required = "image" and the FIT carries a signature
+        from only one of them. Under the default policy the image must be
+        refused. Under required-mode "any" it must boot.
+
+        Args:
+            sha_algo: Either 'sha1' or 'sha256', to select the algorithm to use
+            sig_algo: Signature algorithm to use, e.g. '-rsa2048'.
+            padding: Either '' or '-pss', to select the padding to use for the
+                    rsa signature algorithm.
+            sign_options: Options to mkimage when signing a fit image.
+        """
+        # Compile our device tree files for kernel and U-Boot. These are
+        # regenerated here since mkimage will modify them (by adding a
+        # public key) below.
+        dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+
+        ubman.log.action('%s: Test FIT with required images' % sha_algo)
+
+        # Sign the images with the prod key and mark it required. This puts the
+        # prod public key into sandbox-u-boot.dtb marked required = "image".
+        make_fit('sign-images-%s%s%s-prod.its' % (sha_algo, sig_algo, padding),
+                 ubman, mkimage, dtc_args, datadir, fit)
+        sign_fit(sha_algo, sign_options)
+
+        # Sign the images with the dev key and mark it required too. This adds
+        # the dev key to the control dtb and overwrites the FIT, which now
+        # carries a dev signature only.
+        make_fit('sign-images-%s%s%s.its' % (sha_algo, sig_algo, padding),
+                 ubman, mkimage, dtc_args, datadir, fit)
+        sign_fit(sha_algo, sign_options)
+
+        # Both keys are now marked required = "image" and the FIT has no prod
+        # signature. The default policy is "all", so this must be refused.
+        run_bootm(sha_algo, 'required image key', '', False)
+
+        # With required-mode "any" the dev signature alone is enough.
+        utils.run_and_log(ubman, 'fdtput -t s %s /signature required-mode any' %
+                          dtb)
+        run_bootm(sha_algo, 'required image key any', 'dev+', True)
+
+        # Back to "all" and the missing prod signature must fail again.
+        utils.run_and_log(ubman, 'fdtput -t s %s /signature required-mode all' %
+                          dtb)
+        run_bootm(sha_algo, 'required image key all', '', False)
+
     def test_required_key(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
@@ -619,6 +669,8 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
         ubman.config.dtb = dtb
         if global_sign:
             test_global_sign(sha_algo, sig_algo, padding, sign_options)
+        elif required_image:
+            test_required_image_key(sha_algo, sig_algo, padding, sign_options)
         elif required:
             test_required_key(sha_algo, sig_algo, padding, sign_options)
         else:
diff --git a/test/py/tests/vboot/sign-images-sha256-rsa2048-prod.its b/test/py/tests/vboot/sign-images-sha256-rsa2048-prod.its
new file mode 100644
index 0000000000..58e3232de5
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-rsa2048-prod.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,rsa2048";
+				key-name-hint = "prod";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,rsa2048";
+				key-name-hint = "prod";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
-- 
2.53.0
