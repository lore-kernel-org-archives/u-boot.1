Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE98606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nxhp53xy;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ODn5Gyp/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD59E407D6;
	Mon,  2 Nov 2026 09:58:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9L6iOwIq5pac; Mon,  2 Nov 2026 09:58:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D4C6740730
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613537;
	b=jsKbILkfgMV/c6rIf5nBtgvllrnAg7I6GX3JtNo5Nlit6afuOy5sxvhwtZtm9y2rXsh0
	 N3giRUejEbHWDwnQZZkVIlI3WNoDTfb+c1PD1BWGCP/zobl99WJOfFjy8ycNQW6VFZuCW
	 ePs/FEY5GeL1T3Aeta0q3VY049ZS557MYctPinEaxVGYC6NvMCBXfo1SXiA+6s+/SEI77
	 8JinWsJJXW5qapM8m9z5EDoAEmh6ZzrBPKMORwrvO6v5cFG4wnVuhqfaxWTqepfm6WOb3
	 /GnGpeJvaNRHWk0N3ajVME7kw+ecefgpXw5k8M4fUifmoQPdnqmqayueMwqx75O8SPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613537;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4aS/VDhQnQGJHSjWrj0JbXx3Jo019hk8X8rcKgDUFqU=;
	b=U0xdSRUpy0slCQ586/xeIDQrVtAgx5KI9/BpAVnDsbJrlu+cGSQBwhFKfSiObd7ccvei
	 zHIeSPLZHrhHvqlmcM9VUjYGmuopNupBSlxd4g7ue3rzJbloHq/a8FRwTsmiS370sygla
	 l1aL2KLbuWwrCy1mVvbv7njF2QrPv4+S7xqqpD1bgUYfrN1KfThl/D81MPMmqn7C8gap4
	 WWYEtnCYA0jQy12qWt4Y4EzcAYF8U50z0cU9rFc2UuWdo+RroyDRR+HWViC5CnsmKpoNi
	 52fU/KkxTc3h8WhvNUM6K5CmwnGSp89xd1+9FtUEoadoCSFQyAXVInNeMSypkx4I1CQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793613537;
	bh=4aS/VDhQnQGJHSjWrj0JbXx3Jo019hk8X8rcKgDUFqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nxhp53xyCjZBzVdxQeysbbD7Feh2Cu2yGxpdwYEB+H0f+wCl3YllEEynZR9LaeX24
	 VplGTjfEk927uEJzckD3zjkh1QMTZTSrpJV3e9+FV0ecl88hQqjZoHSCR7SftQQQ6t
	 I0EhEnWyaWevxSBpqkVvifh0ZovuKv+GB86PwYOguXl9u3MPoPnN5VLQSF8sMg//7t
	 4mW01zYBr/PLvZRPAGmU7PL+TvIOpMMk6piyPNAJJ1uzjcumyr4Zgo4CW2AtVz3Otr
	 CwJk8kSQY10z9nfPq8K0OnPoqa3Kz7Hqrtxb6XuXBOnQT+9LnBK8ciDZtzoOyXOHHk
	 ciJootiMQPD7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4C6740730;
	Mon,  2 Nov 2026 09:58:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F20B362
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45012400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5w5xcpLV2ftI for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:58:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 602B3400A8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793613526;
 b=bJ4mjRoHZXqjH8EywnognkYUeDEY7C+0cW4BDTvWCrxGyd7RLnsM/IIDnuDD13csqBJg
 T2neJOKHwx2t7VDx0eMGwpHifihzDFD5/S75FEjP2ys4r0IfnfKDQS2MBc10bBrCJFq1v
 1L4eMUXI4MZVBz4d8V4w6IH4/FPdwSn4/A1H5Aex7psX1ubju7Oabq3myOmNAulKCoSqI
 wJpYKd0ydSt/f3cRIMBIs7tUmMZy+ctilhNpR4HstBulNQ4lwanTrJdqQ92LEyrz1feMq
 UGJrg8OcqS3GtewhPgY8YmaePIgYALfyB1f3b0Ja5EUP/wfMIRfPjMa4D/pd1EJvVnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793613526;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=4aS/VDhQnQGJHSjWrj0JbXx3Jo019hk8X8rcKgDUFqU=;
 b=kMuzwO7y0FZHqr8FaJ0y4PSykw/A/ScQCl9QvZ2/7zJSosRabg+SLw2r+UnPc1PDCwUp
 rapwSbYfV6yyLld6J293r7893qZvAHq8+sa9ssB3Ec46TJTLIQOeG+HMias6PZBRe2/06
 SQi7NUC2283iNjCuFu0uiYAoNQOW0u2OGyJYoJvjhebwq/Su90DT+H6/FPQXz5+cCwbrZ
 EwYDVG6sKuAd/Ea11NnzZyAEuXq13ngN3aQsl010Hfuy06hvFASGB7JMDqjlz+y/1v0eZ
 mZNJYFqMg+7vcrusQXqvDnYY6s1P6fEm13NV7pzLYmrN3n82qPw1Mttixl/ZzodwfDQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="ODn5Gyp/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ODn5Gyp/
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 602B3400A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:45 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so2090855f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 01:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793613524; x=1794218324;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4aS/VDhQnQGJHSjWrj0JbXx3Jo019hk8X8rcKgDUFqU=;
 b=ODn5Gyp/Mm7ClsA9oea0rnXW5bV4D+0LbqbOsTwBKoopBT6gHwIoOAhLHFxYZKWthe
 8VpF5W4eDzoUvAkKD4yqiHu7G7dZIqtIxXRLiu5LXg3Qouh/ixBx4sEUNauYNVCtMNxh
 +m5c7ULP/XrCfu09nDeeVCpQ3hjnfW6eXAPbE4nDRhqE8HvATkGPRdve6tj0z8NOg0vi
 Wja+gpwAkxnF3GnH8DrKTh4gcMtDHAYrXNkjQn0OMgPBhXAwcbusOaj9+uGo9bq2vcCB
 wMJNHmoBnNbDImX4xSZBuC9BGuWqhyqX0XTThW3tiMaB7PghioOzYBDuYWrcPfrH44uk
 QERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613524; x=1794218324;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4aS/VDhQnQGJHSjWrj0JbXx3Jo019hk8X8rcKgDUFqU=;
 b=uj7iBlnZ13OwyDTnfam8ZbchPjHanp4dGJEKWbbYYp3Qzu5/n+qFxmhgKhLgW2158B
 KUyniP+/ifKu2a/yWYXlJy+KQdH9LhBoCABQtP4J31p8wBeP/ksC3RNbEsgLvLJ7wj66
 dD19KgiTeHbgdqaH1zb+FsIQmK60mlFawPufIlZH+JFpbNQjBdVEtOCUwKXk3CfqU4rP
 zflB8SFD/veli1uWuy8/JP4MI1OQBtRYri1jgWAih9RUBvKbueOpZoYjZMengQhzSzWG
 acXMUlyH2AJh5W1SLJHC+uEjz3XQMbrDHjoKwE+XGuETuSb4/M4HWN0d6ZZjEbSXM9N9
 bklA==
X-Gm-Message-State: APuU4Z82zKNgWDTnpK3J3bdqdVP4V+UF28QgGPRd07mDWI2Fu78mCX4Q
 I2BA1j9Tvr6ghjvqkb3sJCoskWunsujQsTrdQuGJNmV7fwiMjLraMPd7RkwsbwLZyzc=
X-Gm-Gg: AYBFou25yetjV42hSMMXR6qNVvKKhmVXZoxf5xMdTgM3+KLKU2oFCG2lpRqgKsYdiH9
 1PMD40rDSFWnXWmyQBpl6+ScepaiIWPikqHB1ZMGgnxo1IOrvaYunvTj++HhOVh9XJogTIkHZg8
 MMYjiunug9J2xStTyYmA9UGR1gMIgyeLyD7hP/JtsnFsJbJAlZmximw+A8a5txees2p/SBWUccC
 G99HnhNLQxFsY2xYZ4Ig211F/sWfQNCyGHFbrCClql3l16Nl8g3zBmX4vde03HZtWaO2td29UDD
 bW1Hws+7d2N/7xxwChVdM6asJ5yuTCMN1DNHV3uppmS88iQ9iGa0s81Qwk0i8Uv6M1aq1QEmoGJ
 iiBz9fZ7KSKLzcva8r3faBnNL37pC7fBK24YQu4YF/EFpDeEVfwSclxfvWvsRmVGNBr/OsN64/r
 1GWdMKSnxG1nAz/T4HtOux7pJTKTfbe4Xd3dnTQendLNJYc23IdrsAvAbtOMViDk5gGJXLjmMt3
 rPzl+6y35/jXa4BMCgdndaAlPCsisTgCy2qj7AYtLE6iG/e+d+3u9+XBLLaAAMsEMStYXqOiBlq
 NsgiwD8C3OrTV6YI5FiuiusT105j4yStB7PplN8Vv/tJn7j9
X-Received: by 2002:a05:6000:1449:b0:48e:6c28:6051 with SMTP id
 ffacd0b85a97d-48e6c28619emr24731466f8f.19.1793613523849; 
 Mon, 02 Nov 2026 01:58:43 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:d3e0:4b17:611f:beac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm20744682f8f.55.2026.11.02.01.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:58:43 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 02 Nov 2026 09:57:51 +0000
Subject: [PATCH 6/6] test: Disable running event_dump test for make check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-qcheck_fix-v1-6-f1f547c4a731@linaro.org>
References: <20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org>
In-Reply-To: <20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>, 
 Francesco Valla <francesco@valla.it>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.16.0
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

The event dump script does not work on more recent versions of binutils
so disable it from running for the moment.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 test/run | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/run b/test/run
index 17e78815fa7..d1654dffb5f 100755
--- a/test/run
+++ b/test/run
@@ -15,8 +15,9 @@ run_test() {
 
 # Select test attributes
 ut_mark_expr=test_ut
+mark_expr="not event_dump"
 if [ "$1" = "quick" ]; then
-	mark_expr="not slow"
+	mark_expr="not slow and not event_dump"
 	ut_mark_expr="test_ut and not slow"
 	skip=--skip-net-tests
 fi
@@ -32,7 +33,7 @@ if [ "$1" = "parallel" ]; then
 	para="-n${jobs} -q"
 	prompt="Building and..."
 	skip=--skip-net-tests
-	mark_expr="not slow and not bootstd and not spi_flash"
+	mark_expr="not slow and not bootstd and not spi_flash and not event_dump"
 	ut_mark_expr="test_ut and not slow and not bootstd and not spi_flash"
 	echo "Note: test log is garbled with parallel tests"
 fi

-- 
2.47.3

