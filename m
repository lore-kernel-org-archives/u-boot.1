Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A7606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G/sqqYRO;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NtHS1OTz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90EDF4070D;
	Sat, 24 Oct 2026 18:52:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T8VK41HBlJZU; Sat, 24 Oct 2026 18:52:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE7AD40706
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792867977;
	b=jYoK4K4caQt4dsp/Lkb57cohpp0PnK0jpdQD0wpQhr5m9rvGj/a+r9jqMkoDGs+shlRg
	 oBfM0w1Xvblq9dKdSZpTZKTF6QO6kGBaaYBuvXOOYWhctHKP0X7QEZhSlYvYBWKJl8Pm6
	 TNxodX3yAM8jt+8U2XJY2jSsr5mQsnnEa8AVXvHtg8uoZwZkIsAmd5scStzFSfmcuIbXY
	 eYV82SkyHTlWU7qjKBH02f0IJ+uRNa/DJhh9HjHX+ZO+knVJEoPopqa1um3wLI7e11Tnj
	 0zw2z8Vc63Sr+pTnDqjWz3iQq+A5p8LO+34zVgWOpsoQ3kDoCRK2mrDO+smoMUWsE1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792867977;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IT4zwU9ftAV0xVycCaHtcfZPUq0lNugJo1yhAkE2kvA=;
	b=Sac+1AeUzOwN075Zsyba3xIxi27qAMAkKgyBUeXH6g4bJCyPoT0U4viOzzegdCQtgxYZ
	 PaDDkeeeDGj6F0D+sU/Gik7ABOCRZfhTOULmAhdhAmfl6r/CIrPGnJUkC7I+j2pyNEVDO
	 cd9VGVhBmkH0/nu2S9GSnGCIB3hjmIEUZR4bxWWhhEBV65XmbP4sSL20CN4SkhvkUVGeX
	 net+Lgysg1lqu9gFdCRh5bSb5IL4UImjK8UYn8U2o1bEIL9Giwf7KZkFkaqGbAjT7DjhL
	 zQVJRuFZJqeU78p9QsxlkUT42usIQKqh7u9KyYXeFBd6V+9gizJWBqFMU6QGA2EHO7Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792867977;
	bh=IT4zwU9ftAV0xVycCaHtcfZPUq0lNugJo1yhAkE2kvA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G/sqqYROMONInQFRpzM4/RJc3m4Bud3cKbg9wi2rQS2TfXnEutFVvYIv80eStA3nr
	 t0kObWQ/oQcSTxr84PExQHBrQMqRGwdJpssvWHxjVN457U7ftdgy036YBuqOocL5gh
	 eioT6dDi4YpTjvS5ovvdAwGRtgTUskGrpRXQgvG7EgtFOj7RBSs/abegKZhNIclRm5
	 3an02dTjK7ecNjFWB0LmQVyLrr7BQFx7vVz2tWepoCuaHuZjHW9/yFSNuVkAF0enLT
	 vbyAHWcIDVS/xJ4Se0jageYIOGj+vMO1pZJN8PiiQ+S9tv4pSMQjbxWrWwrK9Iw8Th
	 cYRW9HVhctkGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE7AD40706;
	Sat, 24 Oct 2026 18:52:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 02DB5356
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8F6B4009F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:52:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vGc2saKU27pY for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 18:52:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2468D40049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792867974;
 b=QgDP8V0aAi9JA48RAyZZ+h7aVcDm5OEzq4R8iJ2NIKcXkAKJsbGJyf8q2zo7wFiB9v8F
 XGpJn0uJUJ/2mog34asxm6AYjda4pNHf9gavDrkfOyc53wc+cPZ3/RhWLR6tW07BNciO8
 3JicbV7YfUH9y5r6/Kgx5AnCyhM39RB2AXVRL3TBS4RYZzEfAkfm+3mhyWOFns6D0+abr
 6x4XjRGzjNzqKQUkQHpqWVBUweZcPr4CpCqPegvLuJJIjIsps1bcVMTlpkymcMUsjGzcT
 IS4jalFeFE0ef+O0Ij8FUPRsi2oIaYAqnkFzfMUOONMshv73bsc8UYNC0eHjrkg8/Hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792867974;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=IT4zwU9ftAV0xVycCaHtcfZPUq0lNugJo1yhAkE2kvA=;
 b=Dt79dT8Ku+NFCEo5u74u8JgP6amFz8pZy5KcZ0VRo04bOK8lw0TVoPbHLPTdfbTVSrYT
 TJ+8S5gtC6FwcJ22Z159cu/co26XdTH4M5r4Qks/SSjTxppBNmTuOieKrGy0XNpB5TBox
 0qygFG/72ov9qWJB/cox0spaNsbdMB3HaQJBzG7QTLoRHQ8WAPTgZrOtLEvq/DR7EoB7R
 NSl4VXFdJwXz0lb7N5Wsa5IqG7Z0bOY926nYWCFLjbGgr9ZV0pR+rVcuvAjgPczAy23G8
 O5PEp69DgHZLXtyoWyPjadhZeot/FR+zgYac/Lmq1KTAI7Ma5qbeuJL21d4oet5RUNA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NtHS1OTz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NtHS1OTz
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2468D40049
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:52:52 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-843a4ca671eso958488a34.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792867971; x=1793472771;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IT4zwU9ftAV0xVycCaHtcfZPUq0lNugJo1yhAkE2kvA=;
 b=NtHS1OTzda/MD0wnwjnBs93H+2r8j+PbEyvNgtJfCa08j9YJi9xOdDXoFV1Ae41bmp
 6WqZ9MIx7aJD1MPQDRZoRUllAc0pDN2jDD4X7y/FRq1W4iez+FrTPrFlfqk1tvjiTN+v
 B6scj3VcQQheR8iO3r3Ye6eeSBqhqMWuhKzMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792867971; x=1793472771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IT4zwU9ftAV0xVycCaHtcfZPUq0lNugJo1yhAkE2kvA=;
 b=JARinwxmoiD5nzCX3cdApFe45KVV0hWEzMNu95FIy18W4lpU/XatCj6diVjJ3ALFbC
 Iz4jwjvOmOaAchwwIOYtBrNXXWGeceiACaA6i8F8vWnnjE0bMuo8+ulEqTKFwOo0TSm5
 TeJhLbh/2PRScCX1yHnAQvu35WJ9baeVAwZp3anwEc96hu0c86jHEWbuv5bHNRn4IeOY
 U0QoeksS/gzhVx5UJts8O7ksL0k+gB4w/rP5zWqTlgkr6YlmQmUsAztfq8lBl+wbZt0o
 taZIbVy2gEOZKj8afHRHIDLf81WBUeetd4IZIdJ6G6yR8XDKn6knZAWn8pUtAAAQyrkR
 z0Yw==
X-Gm-Message-State: AFq9FYLPK8A8fB2v0McbN1ES6sX4UfKKPThEKNJo1CRi8Os8WFRQvlM3
 oJ0gHE+TTlbWvgwGkOaZX3nJg4xVo2sYY3B1GCVS3VyYDSUzLAmtLAV5dD9E455t86b3M8zyzoT
 /nZdofq4m4sG1
X-Gm-Gg: AYBFou1qNc1DdujRBdytNO6Voem+Bt4i7LMbpaXfvU7072VJYuH2kQYoMEU+RfcUGwg
 rpLdSwQT6dY96PvozzmZtWmMkiRLW6xqbBu0XJYtfOFAwXAUWSS3AxiZdxPs1+FXnw9HvC1MgcE
 312Bu8KXYIiXWktxLtH7h36Bvt8xRQGT/+9+MN9duqw8eDoY7jb2spcgwj784EA41Xg+khmS3Nj
 MW5Tio2uHf1x/ABK9VyNwyH6QYGBVuERPwGEbVrCPYFx6XcN14ghb/embTsRKWt3EdK7o8AwKb8
 hyDNRf9zEHVkZx0X6T25b1Qml2u9K7WOiQh6dVecjNZUi/+cmNGm8rxon6Mcxl3cs1wV9R5H3tK
 az1OT4micdRcOz6Y6HyjNUT6t9dXfMumw0ISgyqLXoJNjGy0uBTrEG1xS9tKdf1M0JYF/YzRYMZ
 d8e3IrdDJJE0mCqMZ4dAvlz0MoqEvO1zrPXiZbFA2STsy5M2OyQZCIxtkYYpyx1Ds4EFjtgwhBL
 3DL0podiCeJWslfIssOVX+ezoTrxzmZQjrNOaqhOvztFiwtnKHpMctmczfetZhJFsSS2TV3wcpo
 Z/BDcVAb9F2R84lVntqNcORm8vGwZUVbty9R/17OLIkGOf79VYH/Q5Mn/PUAhT/bIw3rFDhEOSB
 6xXW3Kgz15Wveav5OFTmhSLUNrZTIbUjlJQM4qpbboAIezBw6gDXksLi6uPd6ulN/Hjs5Q9Swcr
 oZ7geIXbYnALho8z4UAk2RFBLiHxU=
X-Received: by 2002:a05:6830:44a0:b0:846:5d82:8b5f with SMTP id
 46e09a7af769-850fdc386fcmr2215629a34.10.1792867971637; 
 Sat, 24 Oct 2026 11:52:51 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850f8458d7fsm2826317a34.2.2026.10.24.11.52.50
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 11:52:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] doc: Update certifi version for building
Date: Sat, 24 Oct 2026 12:52:49 -0600
Message-ID: <20261024185249.86040-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The GitHub dependabot tool has reported a "critical" bug with this
package. Update to the patched version.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This is to fix the emSign certificate issue.
---
 doc/sphinx/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 71adb117e339..5b8d0143eeda 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -1,6 +1,6 @@
 alabaster==1.0.0
 babel==2.16.0
-certifi==2024.8.30
+certifi==2026.10.19
 charset-normalizer==3.4.0
 docutils==0.21.2
 idna==3.10
-- 
2.43.0

