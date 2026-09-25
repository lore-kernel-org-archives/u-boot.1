Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C27C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 07:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1CF360BB5;
	Fri, 25 Sep 2026 07:25:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hl7PZzUsMe-H; Fri, 25 Sep 2026 07:25:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7D45860BBC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790321104;
	b=UMy+s08smLjE95ZZRMKa9fADZwWgmhoyeH/1Qfp30IMl/2xKc44kHjv9qHwngiUrtTBx
	 4jSjRySF7kMvrC+9nXnQrajvr1Z9q1FkUYkNYJLQVsytjIkkV6eO4bmOr+qaQuTYYgm9l
	 XWRO1hmTvMdGODmqyzkUfeMP4CJALU/R45Qi8qPm9EMk4jMV/ET4tuytDKHuDYph6yQk0
	 Q9RZK6xeqTnzLpmVWm+1jTPUJNnZs2pd+Za+OzgReNfvMRbDXEFMMN6dYjy1fEeC9kTL4
	 SQBDlRhImtBZtafmaW4ZyrpjghaI+RQf6dEBkFurjPBm24q8naRf4n3BlTO5DbJy0FQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790321104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7tdKULOz9aDJr9wOuaEgKDHHFsaLL7RVhYe1moMlSrc=;
	b=serSBwhzDwiVc/g86xIUismJHjNE0PsUtw+b7CnRsr9HwN+oa6727yPsXlK7BzmX2e+h
	 oL+th3yYsu3jsGUnyipVUZWGPJQe7cJChvEDK18ZYj81uZtVrj0GUId3TrFgVlOVuDW5J
	 FI/A+92Y+QWOlZzwojEdDaXRCSO2358OIdlRQ2I2Z3ilqWBhDG1A0yZxqZy0jfbuF4DC8
	 ylLFZbw8kA7CKsW66BPXJgCX4h0Kqi4S0ypcq6U9AJZi77jPGEGoZqQq3tH1FDUKbrtct
	 C7KoJv3sVd8oXKmX3gkATBjoErsjOc5hTqW/sUw+LUxu1BwKpo+oEJbVjXusDALX2Zg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790321104;
	bh=7tdKULOz9aDJr9wOuaEgKDHHFsaLL7RVhYe1moMlSrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M8/g1lry5Bk3vaVBgpvHra3h/aSPOVuvsqvP5sDnTnBAuVhYDZkgGWrpKAktwGbVH
	 Wluii5TG8jdFLAkKwceQK3rzRPCmerB720Fkn5V9qASR4lFZten+vRXXRkDheihB6B
	 c6M6CYb2Ww9IVQHjEreuaYVEsLUiWixeQXM4fZNUaMxRySkMo4ZeDzvfIYdre6GRtc
	 C0OvCUO3+X5DmWOuLW61n1oVsOM/abaLl1gUfEglONemGSf0jvMffSFcz2vENowdAr
	 HoNTJHusFHTw0R9UU6nniKTdW3LuL8+BZVkQZzpxon6RZ5zApROQ6sB1cZBXg//9JI
	 0htiMUd+8pYHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D45860BBC;
	Fri, 25 Sep 2026 07:25:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E4DF6194
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB2B440AFD
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jp63atFGVpEm for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 07:25:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F012140B20
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790321102;
 b=prc1YSXPnUE83c9j4elQJWQX/b9X006ahAHS+rWrnsy655OBXO2v0uM7lHYAtJNOaI1K
 a6wvQhA+PzJDk5sIn3CACS6Y7cAS8+WVx27kUTI7iSObcwI4TUUiWLh98SMwXo0fFNxzs
 eACUdXuIu9AGxX6M8jPzx0uu2wGnc8Bv9kWexla9hQwmKnUgYGffXJ6s+RrN/G+fnFOb0
 jssN/FbrdeaN7Eg4wCS7INritV35tTT9X48v96hw96JjjeR6lcysHIpRWNIdq0L5gK/uE
 eY4P5bi/rGL4898fKG0iMRaJ9l/fakhQkchBw6mVFM3UZwbEfZRiwRfiVnMkVYWdedQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790321102;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=7tdKULOz9aDJr9wOuaEgKDHHFsaLL7RVhYe1moMlSrc=;
 b=r6QmydGigeMFQUlAXdocQ9y3/L9YrsMMTmbg+g1qmu+hvx1SxyDgveRnPdiwdNRSya8j
 wKr0ILQc6ro1xIqWUXIlvQM3dCB893QSFRgfBnNzty/twuVVswVGn2KQIhsBV2wLq/bZA
 xvMO8NC1TiHz2YlcXeTgfMdfWBazfrQARUYCry13JJAolRjZnj7ZskvpDHzhXgcHy0W9M
 lG6/uO7s49/Je1Yjs9JdGmrCXlHKaS3OnBlYK5VB0EJtRIHECXjUiDzhjnAheZtxVGPvK
 qT/nIcu76K1YTKsFe51ZZIFISD4d+2khQtvAnSGqui6DLjuCTbE2E35YXVmTdmxwpVA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Wj8ng4D1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Wj8ng4D1
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F012140B20
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:25:01 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccc02279so395633a91.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790321101; x=1790925901;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7tdKULOz9aDJr9wOuaEgKDHHFsaLL7RVhYe1moMlSrc=;
 b=Wj8ng4D19hTfoFqvnkC0t5Bvv0eyKMIjpfzCbs5PXqjxQsguwLsnOQT1YkmButVTBM
 9NI88gUwveOxz6Q9IX4P+RXuBNLMwVgYIoKpT01jG2RLDv9WaHOxdUPeOD1NjEhg9SlC
 YDAzSrwXm1YC6WU37zpzpbfVV7gTDxxQCEwnFTiIBvjiqemCuvT2al3R6LqEHxV8Qw6B
 1FcI9cHO2b3Hsgj89WaK+UDS24KvOdg7VjR3bqjoyO1mb5jULlmCNx+OdRp48Rgx/5sB
 b3qIdy6x5ZHUYycDIuxHnqVBJT/UBJ358n0Cvm/CKqYbRL3Xbw+SSP3C4m0Hz6NYHgkD
 bpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790321101; x=1790925901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7tdKULOz9aDJr9wOuaEgKDHHFsaLL7RVhYe1moMlSrc=;
 b=hZOvr2GCcAhgiWLAuqG3uon5zc2h03mt/W9Eawr6fjdALENOdJfNd+Qu48Kjhd3OFt
 cxHGqCqMy7avXKtqkPcsmfJQ0uZ5O57pH+4xAa+xzbKL/hqVJ6OEwTWoMPaJr9AzkTiB
 NL8gAy9z+ZNrFTM1FGhy50nkwrwrkz0Yc+Bx7Qw04xhAu9hzDWwjNQIzEgEt85DG2mS9
 DI3nntPqZKmjP1poJYe0LmXHibVT/hrKVL9j7nNwTU8cMZ5eVmMQz36lb3H0ePYVrtPZ
 SeEdA1Aq2MoYJVC54Qgx00uhea7q4Y4VEcn1SnnSbdiUssO2I1BjDsqEVz68tL3r05Ri
 XUfg==
X-Gm-Message-State: AFuF++nfBYQa1lcLfdDcbQ/vz8L08f9GK5Q+0ARtc5nevqO9T869Nyj3
 kxZFpszGIm0t6jFXp1WjWOBwVWpxm3UwMwGv4+eHNJ6wIZ6iJjaWtou6py0oqw==
X-Gm-Gg: AYBFou2lU+zrmKYFdXWPwpciS1VXqaFdyRlh7mplGmljgZ3ISkPkHSMNZWXIzIH5LQt
 zwea7vMrteJeQ2blWJvwT+3K4awYg+nXT0ZHJrzlaQHI3OQ6ru5z5A7tvNFYGxONH1vyTftf92R
 kH0QgXQnBNXTTUI7n3BxzgezKukVIooNahOHuJEcUO8QbAqN45oup9HmQurnZRJC2bo+GRFjpUM
 ygOkf0EHQvptftYq49bGvc59a2vggZxgFXz/yHDxi6Bw/zJdA0arNo9NdrXCXZr6RY7Q775rSO4
 q2E0wOgxcTSgG1XndGYPcMgSVfIVhqKcaZR18HTmP/DCJtTIjtz+C+lkIFl2K9VKfokv8O/0poH
 vrH9lGQ2GQX/CdG5U4gyEv6P+SvEnD/mqCw1eJZtcGQQTCf1JbUcfooaU+DME2Yjek5M/DrdqdJ
 xrPOTKqOhChnBuoRhr2Dl+SWg2sXETv2QiqNsA7LpMSxHkdDYax7KeqrbQ+aCqiWZnc0G4QGDX4
 CDWUZql8Nz7RkQfSGCZwO0qIoZtdMSf0+Dde02prLwncSFGxeyRKbotwaMGCxuPaIZkV6T4ytNn
 NuHLYrSG2/KZcs66PCv+sDZmoxAM0KzJOmKr7CBUPk32TIsRVcREaOnfXw==
X-Received: by 2002:a17:90b:3c12:b0:3a0:b210:643e with SMTP id
 98e67ed59e1d1-3a0b21068bcmr2119985a91.22.1790321101101; 
 Fri, 25 Sep 2026 00:25:01 -0700 (PDT)
Received: from 0xiviel.ip (122-63-128-121.mobile.spark.co.nz. [122.63.128.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976cacbesm8904742a91.13.2026.09.25.00.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 00:25:00 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Eva Crystal <0xiviel@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] test: vboot: add coverage for a control FDT with no
 /signature node
Date: Fri, 25 Sep 2026 19:27:41 +1200
Message-ID: <20260925072741.1966573-3-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925072741.1966573-1-0xiviel@gmail.com>
References: <20260925072741.1966573-1-0xiviel@gmail.com>
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

Build a control devicetree with no "/signature" node and an unsigned
FIT, then check that the boot is refused when
CONFIG_FIT_REQUIRE_IMAGE_SIGS is enabled, and that the historical
fail-open behaviour is kept when it is not.

The missing node is reported whether or not the option is enabled, so
the warning is expected in both cases and only the boot outcome
differs.

Cc: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 test/py/tests/test_vboot.py | 109 ++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index fd63d8b4e0..4e361bf18a 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -950,3 +950,112 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
     # keys created in test_vboot test
 
     test_add_pubkey(sha_algo, padding, sign_options)
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('fit_signature')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtget')
+@pytest.mark.requiredtool('openssl')
+def test_vboot_no_sig_node(ubman):
+    """Test a control FDT which contains no /signature node.
+
+    fit_image_verify_required_sigs() looks up the "/signature" node of the
+    U-Boot control devicetree to work out which keys are marked required.
+    When that node is absent there are no required keys, so nothing
+    downstream can fail the image and a FIT whose signatures are absent or
+    invalid verifies successfully.
+
+    The missing node is reported with log_warning() whether or not
+    CONFIG_FIT_REQUIRE_IMAGE_SIGS is enabled, so the warning is expected in
+    both cases and only the boot outcome differs. With the option the image
+    gate fails and the boot must be refused. Without it the historical
+    fail-open behaviour is kept, so that boards using FIT_SIGNATURE only for
+    image hash integrity keep booting.
+
+    This works using sandbox only as it needs to control the device tree
+    used by U-Boot.
+    """
+    sha_algo = 'sha256'
+
+    def run_bootm(test_type, expect_strings, boots):
+        """Run a 'bootm' command in U-Boot.
+
+        Args:
+            test_type: A string identifying the test type.
+            expect_strings: A list of strings which are all expected in the
+                    output.
+            boots: True if the image is expected to boot, False if the boot
+                    is expected to be refused.
+        """
+        ubman.restart_uboot()
+        with ubman.log.section('Verified boot %s %s' % (sha_algo, test_type)):
+            output = ubman.run_command_list(
+                ['host load hostfs - 100 %s' % fit,
+                 'fdt addr 100',
+                 'bootm 100'])
+        text = ''.join(output)
+        for expect_string in expect_strings:
+            assert expect_string in text
+        if boots:
+            assert 'sandbox: continuing, as we cannot run' in text
+        else:
+            assert 'sandbox: continuing, as we cannot run' not in text
+
+    tmpdir = os.path.join(ubman.config.result_dir, 'no-sig-node') + '/'
+    if not os.path.exists(tmpdir):
+        os.mkdir(tmpdir)
+    datadir = ubman.config.source_dir + '/test/py/tests/vboot/'
+    fit = '%stest.fit' % tmpdir
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    dtc_args = '-I dts -O dtb -i %s' % tmpdir
+    dtb = '%ssandbox-u-boot.dtb' % tmpdir
+
+    bcfg = ubman.config.buildconfig
+    require_image_sigs = bcfg.get('config_fit_require_image_sigs', False)
+
+    # Create a kernel image filled with zeroes
+    with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
+        fd.write(500 * b'\0')
+
+    # We need to use our own device tree file. Remember to restore it
+    # afterwards.
+    old_dtb = ubman.config.dtb
+    try:
+        ubman.config.dtb = dtb
+
+        # Compile the control devicetree. sandbox-u-boot.dts holds no keys,
+        # and mkimage is deliberately not asked to add any, so the resulting
+        # blob has no /signature node at all.
+        dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+
+        # Confirm the premise of the test: no /signature node is present.
+        out = utils.run_and_log(ubman, 'fdtget -l %s /' % dtb)
+        assert 'signature' not in out
+
+        # Build a FIT whose configuration signature has no 'value', i.e. it
+        # is unsigned.
+        ubman.log.action('%s: Test unsigned FIT with no keys in control FDT'
+                         % sha_algo)
+        make_fit('sign-configs-%s.its' % sha_algo, ubman, mkimage, dtc_args,
+                 datadir, fit)
+
+        # The missing "/signature" node is reported either way, so the
+        # warning is expected in both branches and only the outcome differs.
+        warning = 'No signature node in control FDT'
+        if require_image_sigs:
+            # The image gate fails and the boot is refused.
+            run_bootm('no signature node',
+                      [warning, 'Unable to verify required signature'],
+                      False)
+        else:
+            # Fail-open is kept: the image still verifies and the board
+            # boots, but the condition is no longer silent.
+            run_bootm('no signature node',
+                      [warning, 'Verifying Hash Integrity'],
+                      True)
+    finally:
+        # Go back to the original U-Boot with the correct dtb.
+        ubman.config.dtb = old_dtb
+        ubman.restart_uboot()
-- 
2.53.0

