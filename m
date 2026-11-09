Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330DA606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JfkJ5zc/;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KT6szsHH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03F32407E7;
	Mon,  9 Nov 2026 21:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id giykZDFEK8cx; Mon,  9 Nov 2026 21:49:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1B3D2407E8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794260943;
	b=Wv4IuxeWXWOqpMS8nIMTJXFy+cwiq2CMPz2841FyhtWZSfb8Bgc80VzJUbn5H6OBmK3x
	 tYS6JHuLjfl/uOe8WV/JHa2NkxhlJpV4vlfNR7M2Zv5F0xROGh/DOIIMlYcsaHgXU82Fm
	 hNmCtkeDZP4wM6CDo2TtlC8wA1g/2zdbC1ocsrWPdA0czhHsTDdLP1Uhh21HGwYrF+fWN
	 W8ARaLgbIgMA1S907zol9s7zVEBUWCST3UUB2fBZ8Ypb1MB1CX+cKP1mdBvRvixA+0OjQ
	 9WWygTyEzdHHnXv5nQ9SSt849WpSVeOcNwQQUjtlNNJAkatIFsw1Ck4LPtYmbOmausg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794260943;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uCMJhMw2M6a5eVTbh6rssVJSlOvQ/no3KvEOS5fmkOk=;
	b=omDxR7c6r3erNyvRznocEAvIKU8ezwmrfeNIN9GzzzDk46f8PFGJNaAmguic0cKK/anJ
	 E/jyGu01AoW9oMMSw5UIxIOlmPWssT+npN+eMNgTBOzrT+ksYJVvJEAK/P4WSmvDFDz8x
	 x1qkSY2mWJQiycWc9uLKotBxJUCK6u+XjT1n4Q+pJYnndNPkv5PIMqqlAUDcyELbv8oK8
	 U081eptOKieyvFeRU4i3VV3UgVvdwyMONFdtgyaus7ODspRwIi1tVzLiJitUPFbofaQin
	 +DrIm3dL69Xsm5RgpwKoM46L1Ync6ydy5s9OGcpYUZsgtBG8+LES+Qbhg+4mGE86Nhg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KT6szsHH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794260943;
	bh=uCMJhMw2M6a5eVTbh6rssVJSlOvQ/no3KvEOS5fmkOk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JfkJ5zc/msLj4bne5TUOfjhliXnE37LgW9VkiGtUlw08WcG9QuUY6khK7EHYOkud8
	 diEWCSwuR2R9RpG+icMCepuuAbRA+aDoClgKng4/dGUV+0gw/7Cd+coQDW55q4S6Tv
	 UN1kTOHqXSe/BoXUbnxO7snXUXXMEwicWUhUWocYl+0x9C2xTlTaM+YlzTzZc+T6VM
	 LVGP9Ffcic89vwRz4iSSKCnDt7fTRNTZOzJHBixvl3W2cquEC2pKB0majRtdmsHCc4
	 LiLaPjVM0YPYpWggY51qvzyQTxoNOHEQqX546ainWhxkkB/qyz/XoCh3GfYJls4RiS
	 8H+mPHlwrwDjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B3D2407E8;
	Mon,  9 Nov 2026 21:49:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5649B28C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 455444074F
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FjCbeL0uFyWf for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:48:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B79A40768
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KT6szsHH
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B79A40768
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:56 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so13978445e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794260934; x=1794865734;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uCMJhMw2M6a5eVTbh6rssVJSlOvQ/no3KvEOS5fmkOk=;
 b=KT6szsHHHqr3lOHZ6TiRhqpN+qatxentC5mERPXlzQdfaQegLkrGT44bi3s2zbuw85
 aEdMi8GxQF2+kcGUPXHCOkEUWE69S3GL98g/YtmJbmd+vFDDmlIhbqDrd+mBIb4q2hKn
 3bThJCK5c+y1jX/Sk7etYVqWAZiDxGSXmHbVNJLbW87ZrnNIK4Ef8cIeU/Q3Y9zgGY5J
 5C+0LGznbACZun5U7xWnIvqo6FHp8FdktLtA4i4PGyDfAuzlZHSxuRfgQKbrvwxpM2GZ
 WI+AD/eObWa7bwU9wq317EItLIRURGIUMg16/bj75krY8WhU2hT0GFzH+8WP4E7T7xmo
 37dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260934; x=1794865734;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uCMJhMw2M6a5eVTbh6rssVJSlOvQ/no3KvEOS5fmkOk=;
 b=w7WTYHFVy0A+hguGdkPUCzTXehL4GkPD/L4qbhf2OpieeVWu2pcpnNbrCDGT+9yadN
 5Kid6upU2EkNJpk+JOrWhPwu8eHyfzEplhHjhXqxv1MxP+tZB6KQonuANsZNk2js3RGG
 0dArYazNGQRPDt6hvMVXhWOBmPLHh3G6PZ3rugGU2Yu1bMqd6vVIiteCJyo9XoI9T4tB
 d1LGVFIt2FjIfmlT8oByidAjJZCrdfVAC5F/ppBPLCKT/JtIJnfJf+ZXoNWLMzJFup0c
 dAi2zjTg1AdeLb5gzItNSoXktFyXIbanvysVMet405ijX2SftWV9SEz16/HKwBcVHsj3
 F6jA==
X-Forwarded-Encrypted: i=1;
 AL+hErEwP+bovgDskPiUXTKnjKMgy4AbTervnRTkB2iPYR3NV4VAhn9b2/Iz9pPtGM4vWwAklAD1dRs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z98PEverlZfd9GLwIBSjbh0J7FR8MAiqKV3CSsaGBCxDyZ6hlTv
 u5mg06iwHYEd5o9kqs+Gl9lyA4M6FNQ7WuV655Pz2SNdsjeJ2m+NY9ogPmA1ithkBMM=
X-Gm-Gg: AYBFou1EF5DRDMAU3MCua/vOivWlDgmgSsG1BA3m0ltJnUWsGf4qbsnREIUVbekY+QQ
 eibfo+Ue65gqXEOk/PNRPI7KGf2XmeA7D86gNLkQjZ+HomVis4YyWazeeM26HWjMsx73A+CYmwC
 n63cqB7L5Z+cZtcuabxNKekn/FCeMyNTE1Jicq1Dy/5GB03pCVw5Wqe7Mjz0QRp3p5X8vVL4r41
 Om9KhLXKLLrX9OPTX3cQU+JCSEG3a3UUVJm4Vj7N/dzFzYfQl0jBQJ7magbUBxThz4mNv6yQ3ro
 jIowG9HXdIMgJv3N4n31AcjYvCZvGIxiEDJHMDhsHSZr7Vw4oGXbZaKBAZoSF6h+lTE6KDU30sD
 YfYfImly/UynPi2cPNrVbgnl7Gg12zEgLFUekldTOkvAH6ZDt/WatayphdfLrmnssajbOefqXyn
 AQp/BYmNgKb+zcU85PDZLzgaBiVXam+AZzRhrRG58dG5EuqevXB0dD9CLgyHs5GnV2KSpeBjFRx
 U5uTjl57w2SxXPtxiVZo5Lu88jJLCeCSegzF18cH61/I8tKCsEfa6ofKgF4v2IQfpSnT5t6ZGVe
 /emXO0lGCZhnmDSVR+TFKnw0tcbPAR0eQh9ZpkXzR8jae3BU/NMiunlaxiyg77Phbs+Aiaw1Tis
 Vbevf5lbL+/lETIgRNg==
X-Received: by 2002:a05:600c:4f4b:b0:4b1:32c8:27db with SMTP id
 5b1f17b1804b1-4ba0234bd12mr10455315e9.22.1794260934481; 
 Mon, 09 Nov 2026 13:48:54 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835f1772dsm1169903f8f.31.2026.11.09.13.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:48:54 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 09 Nov 2026 22:48:21 +0100
Subject: [PATCH v4 4/7] boot: fit: reject configurations with missing or
 invalid overlays
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-ccaione-upstream-fdt-fit-v4-4-5323cbfcc9f3@baylibre.com>
References: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
In-Reply-To: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
To: Julius Werner <jwerner@chromium.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>
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

An overlay listed in a FIT configuration is part of the requested
devicetree, not an optional addition. Currently, a failed load or hash
check can be ignored and boot continues with that overlay missing.
For signed configurations, this also means using a combination that
was not signed.

Reject the devicetree if any listed overlay cannot be loaded or
verified. A missing image must be treated as an error too, rather
than falling back to the default configuration's base devicetree.

This also affects bootm, even when fdt fit is disabled. Boards which
previously booted despite a broken overlay will now stop at the error.

Add a bootm regression test covering a valid overlay, a corrupted
overlay hash and a missing overlay image.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/image-fit.c          | 12 +++++-----
 test/py/tests/test_fit.py | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 1909a6a2cb4..6e7c7a4a509 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2676,7 +2676,7 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	void *ovcopy = NULL;
 	void *base_buf = NULL;
 	ulong base_buf_size = 0;
-	int i, err, noffset, ov_noffset;
+	int i, err, ov_noffset;
 #endif
 
 	fit_uname = fit_unamep ? *fit_unamep : NULL;
@@ -2753,9 +2753,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	/* apply extra configs in FIT first, followed by args */
 	for (i = 1; ; i++) {
 		if (i < count) {
-			noffset = fit_conf_get_prop_node_index(fit, cfg_noffset,
-							       FIT_FDT_PROP, i);
-			uname = fit_get_name(fit, noffset, NULL);
+			uname = fdt_stringlist_get(fit, cfg_noffset,
+						   FIT_FDT_PROP, i, NULL);
 			uconfig = NULL;
 		} else {
 			if (!next_config)
@@ -2787,8 +2786,9 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 			BOOTSTAGE_ID_FIT_FDT_START,
 			FIT_LOAD_IGNORED, &ovload, &ovlen);
 		if (ov_noffset < 0) {
-			printf("load of %s failed\n", uname);
-			continue;
+			printf("load of %s failed\n", uname ? uname : uconfig);
+			fdt_noffset = ov_noffset;
+			goto out;
 		}
 		debug("%s loaded at 0x%08lx len=0x%08lx\n",
 				uname, ovload, ovlen);
diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 0edf875a9e1..3113209d911 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -397,6 +397,66 @@ class TestFitImage:
         self.check_not_equal(params, 'ramdisk', 'ramdisk_out',
                              'Ramdisk loaded but should not be')
 
+    @pytest.mark.buildconfigspec('cmd_bootm')
+    @pytest.mark.buildconfigspec('cmd_fdt')
+    @pytest.mark.buildconfigspec('of_libfdt_overlay')
+    @pytest.mark.requiredtool('fdtput')
+    @pytest.mark.parametrize('overlay_state', ['valid', 'bad-hash', 'missing'])
+    def test_fit_overlay_load(self, ubman, fsetup, overlay_state):
+        """bootm must not skip a listed overlay that fails to load or verify"""
+        overlay_dts = '''
+/dts-v1/;
+/plugin/;
+
+&{/} {
+        test-overlay = "applied";
+};
+'''
+        overlay_image = '''
+                overlay-1 {
+                        data = /incbin/("%(overlay)s");
+                        type = "flat_dt";
+                        arch = "sandbox";
+                        compression = "none";
+                        hash-1 {
+                                algo = "sha256";
+                        };
+                };
+'''
+        params = dict(fsetup, overlay=fit_util.make_dtb(
+            ubman, overlay_dts, 'bootm-overlay'))
+        its = BASE_ITS.replace('        images {',
+                               '        images {' + overlay_image)
+        its = its.replace('fdt = "fdt-1";', 'fdt = "fdt-1", "overlay-1";')
+        fit = fit_util.make_fit(ubman, params['mkimage'], its, params,
+                                basename=f'bootm-overlay-{overlay_state}.fit')
+        if overlay_state == 'bad-hash':
+            utils.run_and_log(ubman, [
+                'fdtput', '-t', 'x', fit, '/images/overlay-1/hash-1',
+                'value', *(['0'] * 8)])
+        elif overlay_state == 'missing':
+            utils.run_and_log(ubman, ['fdtput', '-r', fit, '/images/overlay-1'])
+
+        try:
+            ubman.run_command('setenv verify yes')
+            output = ubman.run_command(
+                f'host load hostfs 0 {params["fit_addr"]:x} {fit}')
+            assert 'bytes read' in output
+            output = ubman.run_command(
+                f'bootm start {params["fit_addr"]:x}#conf-1; echo rc=$?')
+            if overlay_state == 'valid':
+                assert output.rstrip().endswith('rc=0'), output
+                assert 'test-overlay = "applied"' in ubman.run_command(
+                    'fdt print / test-overlay')
+            else:
+                assert output.rstrip().endswith('rc=1'), output
+                assert 'load of overlay-1 failed' in output
+                assert 'Booting using the fdt blob' not in output
+                if overlay_state == 'bad-hash':
+                    assert 'Bad hash value' in output
+        finally:
+            ubman.restart_uboot()
+
     def test_fit_kernel_fdt_ramdisk_load(self, ubman, fsetup):
         """Test loading a FIT image with kernel, FDT, and ramdisk"""
         cmds, params, _ = self.prepare(

-- 
2.56.0

