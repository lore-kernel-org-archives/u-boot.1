Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F99606A331
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tdGMnSQ4;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=szv8G2Ch
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71E28405C6;
	Mon, 23 Nov 2026 15:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cx4RwUW0dLaH; Mon, 23 Nov 2026 15:19:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9A58C40573
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795447165;
	b=qlkGrJEoBZH6QBgoXpPdbKTGhZ/WaIsAet2sx0yBm0bLEi1H/7edheqgkXKEv0p5oEYm
	 it8lCztpH8D3/87YtH8scCelM+WbSkW76NlfaLob6OkuzPLGUqsX8mtsbQTQct8tFSsib
	 lXnck7ibut5lHoOo/+iXLfFWtKlwSkl9khZLE6V8jGCyQh+9qBynt8a6k0J5Ba+0gLAaq
	 R+1IiU7LOYHhW0R94qe1La+UqfDY1k0XoyNcafDJxRf8sGl12QivyZ49NITnX3dUaLlUe
	 h7UABTywO+5ATFdAdvXSBuT2z9TNoGVYkNNOu8Ay+veI9SDVxuYaKai6Hn9PNWwrNpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795447165;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dm8s0qDgPa7pUdycMtT3zoCfER9kJxJ23n2HE3AC5tU=;
	b=gnQs1S8rdiov5AMTIQZ+18opDpP5I6Rxu3NKszJPPaluowWVWW1kAdLnY7c5V2RNUcSS
	 1ZNsGVE/E5D5POLXtQPWU5q4andXMYWUP9AwoICw/XLPTt80Mksf5sp37DKhXgLcKvcCd
	 dXezWgobX7n9fdHv6BYkUm5mJcgAhg7kEShYe6ol/VcUsW9518IVPhf4fWd9sdOpp6RtD
	 jkKvX6BFlhnlENZO7oi8vFh8X2KDlS0uc1yY0IEqwXcTAp4C9xpxZjoAZFugGdt3mD5WE
	 3Xxj+Aq1SbzDMt3Nvam+PagMmXOcy4X8qhbukOeN5N//Ngq+7eQF6odkcTdAAIg4bWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795447165;
	bh=dm8s0qDgPa7pUdycMtT3zoCfER9kJxJ23n2HE3AC5tU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tdGMnSQ4OotnXDexvVYWkUpItYjT8wguxJLdCyjtBezIzsrYJlrWOT+fGhWUUo5kO
	 dwAbKQaZxulRacVhesPQ+wSN4tMx0MozspZpUy6nsHOOHGr4Y1JwrDuu8h4MjdGTJf
	 2yXXAw/M3+agvvMvTPRvdIV5Gibh1/4vP8sZj7M7+q869QmLXnmgky2HcwPPfweb2Z
	 Trqt2UzJtinpSl3d728ljyTnbOGttBbsBIiL5FJeKlriEciItUBzq9vVWjOWH7hOJN
	 ivD7bTdLrT81SELQ5LpMvPB30PJ7wiQF/7vRrL2FxhMnNiSIBgoXNv7Kn3CqkBOe3C
	 xEWH62DuOV7fQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A58C40573;
	Mon, 23 Nov 2026 15:19:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 74DD11AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B64440060
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:19:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8b3Ujt9AOBp for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 15:19:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2806D4008F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=szv8G2Ch
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2806D4008F
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:19:22 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso3072395f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 07:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795447160; x=1796051960;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dm8s0qDgPa7pUdycMtT3zoCfER9kJxJ23n2HE3AC5tU=;
 b=szv8G2ChcOQDmVfHXczJrfGyRYEvFptjYgomhkL3n/dnD4+yJINnY9/F3RaTzUGByW
 Nj/9plwwdRiJa/1JYnfv2/uWmpqTOlkN2NX16fBz3DsFjcT1WHMt2FFEW0/lzr7sd8xb
 5X+AZ7DUs2eY1jyAXPLgqiTAo+8aST6lR9bI3LC8jSsdJyVNsVEAgyTVmYev8Q6OvmGh
 D+UHZW+qcjZDiqdVrPE3TcBgF6c9l7uxwz6OYZdzx7UvKTvgeFsS4E6sxZ7EIJSkLC3f
 VNuiZIwb8TS9oCoHWioC0jhlUb1N3P8bIHJkLqUuPJOSdqCUfTcZyoTqCr2fYVGhFum7
 +hAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795447160; x=1796051960;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dm8s0qDgPa7pUdycMtT3zoCfER9kJxJ23n2HE3AC5tU=;
 b=AefIvUmmS1aSEyFMJSWyqY+ezU3QkuWo7uOGzbZ6tjFJ7Sreh6IPYkqp4YkBUTclVf
 1sOy7JudYn8bP1K5IxmXJZKKD0ZvSg6cQHyMacsUyIwfRk9FOvDD8+rY+8IFuWNcaXc1
 3BwtzgGBzc3ZkTvwPwwj2oKvIRocHsT4sSG7sIcsVNrtwnaFN7qmNZjiA2lGUAkzFKMZ
 GseWjsCdhkF6vVlN00EeISLq+XDhJwtUlmfKjetfkbcqRkFA3dwvCgENCIzOjM7CXGRo
 3CpLoxDggqJPNx4fZFaKHBqmhZ1SNzNUdkLsTLg+XSwyjkvUusDVzHToDgCjSlJBnciL
 sMlw==
X-Gm-Message-State: APuU4Z9QEyeSExwkyrSoXjJ7ybQvQmy0tYREL6uqUPV3JwOLeI2M2bOF
 AzKq44yXDSkDFn+FY+oI969YecMioRHujP9YFW4ZYVEFnh5fgf9dmIDhwteVQPz3Rvc=
X-Gm-Gg: AZFdTZf/oka6KBsjNf+AVhwNp1aIrfm9+2K0amPN0mvR+Vz/BqmZgjioHpZXz1amX3m
 giWjUlEsoVHRsXHHmC3+wIHQwkQ7x7Jje1c+q/xYcdbrJ4szh4DsdWZYV+J0EKAVWskWnzbHQ9X
 nK5LDtQ1AXAOyYhwBSnBwFS4J3Sqk9aHG8CELoSMMiQflQyRQb6wdyrVJHzEAH+Cv6YJSakwpUl
 mDOvigeskzKaxPVq8yKgPF8V49m+GnYeyGPA0lGOtliqMQZTKNSps4v3g9bYYeXKN6SZJN1RUpN
 ro+X8EwsvPduOyx6oLe3NTHKEXOsKeegSmbcOtdLZByxrXdqWjwZsbU8KO8CXClqDgP/VfujQYE
 IOjH7M2FFt3ETFIj8FQj1UqP02Bv6Xcb/Ibht8xiRHXNyZG1zJpCU4cdxKmC3yOfVSyT4TIiDIW
 OQpAbbaLq54dJHclfKM2PV5NTZ7/INs7C4e8SD71q0A7KSOOWkD8EELeDT2P3YdLj0rCCnCJ0bh
 wexcP0zjeGurk20jFyaV02GubqvrF676Lrw3aPBdTILzbP1BltK5YJjVJRGu14clvh8Ntm3wxHX
 comKYPCOmw7ynidj6qZD8tTvyWKcRoHgGZXvkAk2jGwyXpIeQzyjDvGzd8vS2oMEI5D91A==
X-Received: by 2002:a05:6000:4812:b0:4a9:be75:8645 with SMTP id
 ffacd0b85a97d-4abb70d711dmr20877342f8f.30.1795447160520; 
 Mon, 23 Nov 2026 07:19:20 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:70cc:bff1:b74a:80fa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bc8ce06sm22272969f8f.47.2026.11.23.07.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 07:19:20 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 23 Nov 2026 15:19:18 +0000
Subject: [PATCH RFC] test: Add more tools tests to CI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ci_more_tests-v1-1-52e9984f42cb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHVZBGsC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNj3eTM+Nz8otT4ktTikmLdFBMzs5QUU1MzIwsjJaCegqLUtMwKsHn
 RSkFuzkqxEMHi0qSs1OQSkElKtbUACFwSR3YAAAA=
X-Change-ID: 20261123-ci_more_tests-d466dd556282
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
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

'make check' runs various tools tests that were not being run by the CI
scripts. Add the missing tests to the CI scripts so that CI will be a
complete super set of the local test runs such as by 'make check'.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
This patch is in response to Tom asking what is tested by 'make check'
that is not tested by CI. This is the simple answer that shows what
tests are not being run by CI. This does not claim to say whether these
tests are actually useful or not.
---
 .azure-pipelines.yml | 4 ++++
 .gitlab-ci.yml       | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fcf7aafade6..90deb4e9243 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -149,7 +149,11 @@ stages:
           # Avoid "Permission denied: 'cov'" error by using a temporary file
           COVERAGE_FILE=/tmp/.coverage ./tools/binman/binman ${TOOLPATH} test -T
           ./tools/buildman/buildman -t
+          ./tools/u_boot_pylib/u_boot_pylib
           ./tools/dtoc/dtoc -t
+          ./tools/dtoc/dtoc -T
+          ./tools/dtoc/test_fdt -t
+          ./tools/dtoc/test_fdt -T
           make O=${UBOOT_TRAVIS_BUILD_DIR} testconfig
 
   - job: pylint
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b78f7a9775a..4aaef8f27ed 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -235,7 +235,11 @@ Run binman, buildman, dtoc and Kconfig testsuites:
       ./tools/binman/binman ${TOOLPATH} test;
       ./tools/binman/binman ${TOOLPATH} test -T;
       ./tools/buildman/buildman -t;
+      ./tools/u_boot_pylib/u_boot_pylib
       ./tools/dtoc/dtoc -t;
+      ./tools/dtoc/dtoc -T
+      ./tools/dtoc/test_fdt -t
+      ./tools/dtoc/test_fdt -T
       make testconfig
 
 # Check for any pylint regressions

---
base-commit: e578056c766d653270b14557c2a9d8daec414c17
change-id: 20261123-ci_more_tests-d466dd556282

Best regards,
--  
Andrew Goodbody <andrew.goodbody@linaro.org>

