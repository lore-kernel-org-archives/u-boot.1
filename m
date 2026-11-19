Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2178606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aBpaCNhO;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=s1prhXHm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D22C40659;
	Thu, 19 Nov 2026 14:19:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lxdyxTrqqj4X; Thu, 19 Nov 2026 14:19:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C39F40A47
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097964;
	b=sJNA3Gdqngxmm75I1y7Zj1AY4q946M8yITetK9E+iVJ0jtYiURpW6IcfRDaLOsgfNok1
	 6H5AIYX0U5rERo2rwhtDpJs42iyduB953KZkGeHgZVhP7UZU8KtjgpRrESUvazK9l49F7
	 Ye8paKsMTxV0M631xjIxvtqWu+Gx+teLlCop3oV3RyMveybMsfaHutgC/dwA+wSMI5DV7
	 mzXLjwrpdF85+LpdruqqxsQNXd7TMT4PcmS1I1zSciZuavczVfh8Qc10lOFWhzpLks2ss
	 7wx1Vm6VeLEwOiMhZECeF7/g5bdKSKo8hSceJXP3QyqRo+E7lah2Q0Wu/tkp8+waFGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097964;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eONiby0OxVQAK1bqQaLfvtnouuaPlaAAn1fLsLMaNr0=;
	b=XH74NkwUguzSbl5td2NjWF7K/2B1JuYKm4PmSGL/b1DcG/Y8xA2emPcFVVOlDzWMth/B
	 QH+PbUkmR9ovt6cV206RTwVARdEgRRezhSFlE6uXAdw5gsq8iVJgrkjTeJ6ciOs15hUQO
	 alaBiZgMG57Jru8G/bvyT6eymX3rnPSx5V5RxpP5oxXfD+U/yPqXpqO7hWzJYGrYlhx63
	 BrCkBTQIPCHyJuI4zKcqy5DC+uen4AkeD1OAVlhH93LKfvV5dhuj2H4tmbZBQHZ7rdgS3
	 Sxv2P8dEplralA8fWpT0V3WHeYNlQ2eKG+hqYCe1wuWUdQIAs0W64PZlubCUwEOEMsQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795097964;
	bh=eONiby0OxVQAK1bqQaLfvtnouuaPlaAAn1fLsLMaNr0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aBpaCNhO3KwZvm71EkQ/4hSuFXEyweMXWMQVGGnKvlg5rRQGZQxvid9WeA0ZxoLzd
	 Ih1M9CoEkG09W+jPZg12KE7+sOnVRMz60r342L1n4r+3nqE34S5YVbUlwAouEHsfUx
	 1IEDAXR0GKnEPWciSI0mmcnMDKjxlqGuwNRFdl/gul7ow5eNa9KowH2uzsj+FXL3ig
	 uV5RJEVKpNkJVsye9grFgdFcLDs7tKOjlDu163BxD+TFS4EOiufZD2cH55kvroAHdw
	 D2A10qD6qEp7ZJyst0n1+Y3/dHfjZGviN4b5ZbG90adh3PcbW8Sm8YXT03g8o+36nL
	 8ZWNyFc65zKnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C39F40A47;
	Thu, 19 Nov 2026 14:19:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8F4E22B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAD804057B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:19:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGSsjSn8aony for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 14:19:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0CA5140581
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=s1prhXHm
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CA5140581
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:19:20 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so27154635e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795097959; x=1795702759;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eONiby0OxVQAK1bqQaLfvtnouuaPlaAAn1fLsLMaNr0=;
 b=s1prhXHmTt4tK5Yb2Bd/KpRsGxDFMd/a73Sgx6yn6UqZHTBLQ5JVt2U/XphCy+nbc1
 7CrP0JuPWG/L2wTvCSrVUHRKlqcmjNR/bX57mn5R5rb8gVTmRveGCIUPBfml7irepTyH
 nkeDcEj3mRyfJP8svbExpr1VU/d0V6+TcpQeN3jA7+VxUNXGAObUrni04Hs0za+U5wjE
 U8jEBVhTRcStcFtQA/VFcvyjvvMgKx6q6EGDWB6sZ4kPARA3wEsE6QxLDp/9uPiCkwbb
 YZem9LUoiXiusupt8i2toWpLSmMGeFRfaPl4AWDLVXhnyvrXSgh3e2DxXbA/SlcecDHx
 FUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795097959; x=1795702759;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eONiby0OxVQAK1bqQaLfvtnouuaPlaAAn1fLsLMaNr0=;
 b=QJnwpzSp/RExIWX1fGxY0TfipHX+3Sk7FADCwNqcJ2crwV06r5FUSPrEU4nGlkxs3H
 RaAee+lDJrRY58kgYjINASvLo7O75CuT1n5SIIpymf6ilGWQLiLspOiKdx4QHL65DM0q
 vePZkFfWPx+EMBrEk/RtJRVEDCYOuU8YcMBOiK5qmDZgIwBl9uFgkN+PhLdlxAK9JcpS
 WEAl0CaHsIRb/50sziz9GB4fictEUDWFOL4vycB/6ItKs+S61hjYQxtl9K0L/L/mSnow
 scnTstRk0A/A9x4/zhr0h+7x4pO7ExKg+kL/mH063tbefYNgI1c3S6SpntsKSFnRjgvf
 tR1g==
X-Gm-Message-State: APuU4Z8XHtRqdP1Jk6AOdJyHix6AzIhKEpHCzSWvjKm2ftwKCapIDMwC
 Ooyg9qBqa+RA5wazTVRIFILg+olpxGfNDQ0st+pK6r7T4LniBN0BmTzfEBwEkafdA7o=
X-Gm-Gg: AYBFou35KXtJlEbkatw4Ks7GyLceIcfXnqRCEogERfTxfrBuy6Uw2D8NOwqt72lXz3k
 pjWc/j1rSQO9ZdQvHfUcikF9Y8bbYe19bR/eGpftfjnKLJFafCAw9EbLM1Ki9uGiGDgmQP7M1VC
 oQcUaVJ+56nDt821JqG9uAZ1XvKTujqR2Ur9jpQsSJjAuzQDzp47H1bFxNZykUy3GBi95pca726
 ZopwsHcropC/WEYkbCvysr1GIMF3vqXAi5fYz7Dse+KjqXO/+/l/0bgx+GkLS0LPSdymf/NGxaA
 KnjjQoDzFtmFhYAiARH0RI6MKM+KXO3/b6ooN7RYjV1t/FKuFEcjpXTx2MMeGVkr2Mw3+ucPBbk
 A64WtMsEZPxwKNwdUz177SAyYK/U8XDQhNJWiKg3Lv4iymWCtG24ZwY5jbZQTpeX9Zw4ogHWFpG
 UzA1qT3e5jt1eSGgnny4GzS/3NDfh9GrxwR0v3m5RScPTeSBiud3Cr2L2lJLzODPAcBlP8Xo1+l
 UkMmf51ucr0tjRj5dQiEw2tTVBQtzJh9hU7P2guNxz9AXmUJw6SS4rSKgyx8UbcmnWR4iKRDAkJ
 hREUJihNiQnKMCWl/giBq8dQvdk8IjrTIaQ97ybLAojJBrQ/
X-Received: by 2002:a05:600c:620c:b0:4bb:665c:a078 with SMTP id
 5b1f17b1804b1-4bb7da4917bmr118122025e9.28.1795097958808; 
 Thu, 19 Nov 2026 06:19:18 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:e7a1:b979:32dc:a16b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab5490e40esm74892f8f.27.2026.11.19.06.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 06:19:18 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 19 Nov 2026 14:19:18 +0000
Subject: [PATCH] doc: develop: Update docs on testing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-doc_test_updt-v1-1-7ae6705d83a9@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGUF/2oC/yXMQQqDMBBG4avIrBtwgoh6lVLEJH/ruFDJRCmId
 2+sy2/x3kGKKFDqioMidlFZ5gx+FOTHYf7ASMgmW9qamVsTFt8naOq3NSTjKtfYqgXXaCg3a8R
 bvv/f83VbNzfBp2tC5/kDKTxMbXEAAAA=
X-Change-ID: 20261119-doc_test_updt-b4b8249e16e8
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
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

Update, clarify and correct the documentation about 'make check' and
similar. The current docs do not accurately describe what 'make check'
and similar targets do nor what is needed to be able to successfully run
them.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 doc/develop/codingstyle.rst |  7 +++---
 doc/develop/testing.rst     | 55 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index b8d2bf23a54..e91bdcb7e53 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -378,9 +378,10 @@ Some minor things:
 Tests
 -----
 
-Please add tests when you add code. Please change or expand tests when you change code.
+Please add tests when you add code or change code not already covered by
+existing tests. Please change or expand tests when you change code.
 
-Run the tests with::
+Run the tests for the sandbox platform with::
 
    make check
    make qcheck   (skips some tests)
@@ -392,5 +393,5 @@ will be much faster (10-100x or more) if they can directly call run_command()
 and ut_check_console_line() instead of using Python to send commands over a
 pipe to U-Boot.
 
-Tests run all supported CI systems (GitLab, Azure) using scripts in the root of
+Tests are run by supported CI systems (GitLab, Azure) using scripts in the root of
 the U-Boot tree.
diff --git a/doc/develop/testing.rst b/doc/develop/testing.rst
index 1d19b49e82c..4a741a02d0a 100644
--- a/doc/develop/testing.rst
+++ b/doc/develop/testing.rst
@@ -7,6 +7,34 @@ U-Boot has a large amount of code. This file describes how this code is
 tested and what tests you should write when adding a new feature.
 
 
+Test dependencies
+-----------------
+
+Some of the tests below use external utilities to prepare files that are
+needed by the tests. In most cases these need to be installed to be able to
+run the tests successfully. These dependencies are in addition to those needed
+to build U-Boot.
+
+On Debian or Ubuntu::
+
+   apt install yamllint cgpt xilinx-bootgen u-boot-tools softhsm2 \
+     vboot-kernel-utils opensc coreboot-utils libengine-pkcs11-openssl
+
+You also need the utility fiptool which is built from the Trusted FIrmware-A
+source code::
+
+   cd ~/src
+   git clone --recurse-submodules \
+     "https://review.trustedfirmware.org/TF-A/trusted-firmware-a"
+   cd trusted-firmware-a
+   make fiptool
+   mkdir ~/bin
+   cp ~/src/trusted-firmware-a/build/fvp/release/tools/fiptool/fiptool ~/bin
+
+If ~/bin did not exist previously you may need to logout/login so that it is
+included in PATH.
+
+
 Running tests
 -------------
 
@@ -14,27 +42,36 @@ To run most tests on sandbox, type this::
 
     make check
 
-in the U-Boot directory. Note that only the pytest suite is run using this
-command.
+in the U-Boot directory. This runs the pytest suite on various configs of
+sandbox. It also runs self tests on binman, u_boot_pylib, buildman, fdt and
+dtoc. Code coverage tests are also run on binman, fdt and dtoc.
 
-Some tests take ages to run and are marked with @pytest.mark.slow. To run just
-the quick ones, type this::
+Some tests take longer to run and are marked with @pytest.mark.slow. To run
+the tests but excluding these marked slow ones, type this::
 
     make qcheck
 
-It is also possible to run just the tests for tools (binman, buildman, etc.).
-Such tests are included with those tools, i.e. no actual U-Boot unit tests are
-run. Type this::
+It is also possible to run the tests for tools (binman, buildman, etc.). This
+does exclude the main pytest suite run on sandbox but does run the quicker
+ones. Type this::
 
     make tcheck
 
-You can also run a selection of tests in parallel with::
+You can also run a selection of tests in parallel, but not including the code
+coverage tests, with::
 
     make pcheck
 
-All of the above use the test/run script with a paremeter to select which tests
+All of the above use the test/run script with a parameter to select which tests
 are run. See :doc:`pytest/usage` for more information.
 
+As the tests are run on various configs of sandbox the unit tests will be
+testing mostly core U-Boot code and the few drivers used by sandbox. These
+tests will not be testing your platform code and probably none of the drivers.
+
+For testing your platform code and drivers please see the section on "Testing
+real hardware" in :doc:`pytest/usage`
+
 
 Sandbox
 -------

---
base-commit: f6e8f09ed39347359ebddd983b96993c78b4ec7d
change-id: 20261119-doc_test_updt-b4b8249e16e8

Best regards,
--  
Andrew Goodbody <andrew.goodbody@linaro.org>

