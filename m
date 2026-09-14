Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2378AC88E73
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 21:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32F2560708;
	Mon, 14 Sep 2026 21:33:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XVtNqNlGGF1m; Mon, 14 Sep 2026 21:33:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F2457605F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789421611;
	b=SF7k9Hc5hQ5f9mckB6HAOH5afqlf60DEk+vkUSdHXXEfOkyIzWzj33z7mGgf4hH92TEw
	 0npeQFOwhHbyNYyGquNGdh9pbsQ4WasTWvZ4HqlVg5ej8rrUqjdr+TelFta03sOAGiTqX
	 Dcjc3GkiZ2yt623eMxOMP2tkNNbqUPB/fL0JSnOrR/uBexJvy7Eee8eI+65Kk+XNBK/g2
	 J+k736m4LWAz82gYNUn2VV/rKQ2Ij9DG6cL4qB3X5A1St8iPS2PZ9rhjJExmmrTYRA7jm
	 8143J3iMFo+MhOjn55WVWtgFWUwB5BuWntduMst1tGP0RbWHKzU0kfwknRlc2sGjEEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789421611;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BN6RwLaU7PfFpfoUlGZR8hxjDBCfM7qYuSm78TxyFqQ=;
	b=HASZo3JqjD9GXL7JRWJ4tBZdxypEGS1mxmj4uekoBmVWp1M4zD8QOj3EaowtbG2MmO/B
	 ds46h1kakR++N30X4qMFkfxO4MWsUdtlRHjEcrcPlHsfznQ5VXyD6MEg6leCxV0Eth73+
	 m4dGbeZqozx2GnGZ27eGW83H/zlEaQCs8rFwQuFRhZYlAM2Xx764+tnaGQBge3Bv2c3rW
	 n1V13IlRy6K5PvxBwPvmKyHJLE2DMGdM6XCu9o+WhVKdJs03eqoWXySkGcL5alCEI5HzU
	 8YaPCJ+XR2nPdkgA3XtXrs47OSxceKToM7rQTpi2WwUgaGI0hrAl2mQCdiKkWEPQBoA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789421611;
	bh=BN6RwLaU7PfFpfoUlGZR8hxjDBCfM7qYuSm78TxyFqQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Eb4vEbGzu1Jk6EmK0t+l0OU5QSirqdB5b6TiG8V8nbb9HZJV1hqurus6UFGyjCOOK
	 Yd4yNrv4+8wg656IVWKI6EM/CMPhmS3UVnNPV+oTMlggyqlxj3AafjEzxslOvxGF4i
	 8QAKJNlXRi3lYclA8YKjXhNrJoI+UsR0ipLHZlxwo2KcBTr2OM0XWQB/LzhgcLluCD
	 be2qfYAx4wfhZ2lAoKURDBfFLZ9XatdNXFOXmIPZjY7avOs2v2B3e3DQesAQ3i9gwW
	 BHG3hmO/+rfqkM+PEHiD8qOpqiVcuamB5p4FfhaE33Q3c0uAvAVay515CiGfanD2Pw
	 i62GdO95fobKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2457605F3;
	Mon, 14 Sep 2026 21:33:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FE62493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65E1440517
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a-bI8r-OcB6C for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:10:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4ABB440509
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789416635;
 b=MY4kerASMXwaxUNegCRUdOfKOIIN3s941FvL7Il9zAdepAmGPEghpuHLyREHfrEOkHeK
 qz+75BDz1hotKlcbjJxnP0k5WfwHat2pWfjIcH17xg0gro1IoueuaTABNH8pKqJTR44f2
 jF64gW4QViRi40hRBnqksY/OtW8NCssEr4qV/xi8TFZa/QZJC15XPWNfS7m+fys1R/22e
 vi6bS9lGBMLqGT4ld52GD0Vl6M7y15l81MhoNn2syLYcC94UsPMIYoNSHUc37X44vm35c
 4pLFzmTk7lN5K5MKjiJfGCnbLVt4XUDT8KoKkFA7peOxUolHgPC+ty6dPjvbffBLjmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789416635;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=BN6RwLaU7PfFpfoUlGZR8hxjDBCfM7qYuSm78TxyFqQ=;
 b=gdAIvs/SlfQXPJ5/f8a6RtyPMhySwBrGG7A6bZ4Gmp5lX3PClusCZgIpaW/OSyrFSUQJ
 7vpluOLJbhT70fCAtU47dTCHNH/zlEHD+6iEgrbUwbzkIU5yGxGledJzNDIqI+EVdkNrr
 qlBRZisew7IldzEcD+Fg/uUSAyRUncjYOquUlMA7a+YoOUcp4DOAyD73cTpXdJUf2Ps3j
 fABe/9ENoP3INlD8NFwKit/S3FaXrZwpgWgT0zEsUAFHHiblQXrSH3fJMbmom+hji8UrS
 g8aFslLOhOxYScXItq8OSvDWCBN7uFScR08mXpgyooFa9z5/Za2Ujym9VGbz3bI9O9A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iTe8YVpp; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=iTe8YVpp
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4ABB440509
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:10:34 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so3765617a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789416634; x=1790021434;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BN6RwLaU7PfFpfoUlGZR8hxjDBCfM7qYuSm78TxyFqQ=;
 b=iTe8YVpp4oh17Dn0fKRPn+sgMeGX/NAs+g3bvpaSi5LRZ4IHd2xjRYTaHPChxCn2XE
 bZZH4AqP1R6zm1iFxeJevGExI2Pl6jPMxHdesL3DaIHoFGdku8UGL0IPNk0JuIrlI2NR
 Okp3UVxiCjUIjwfcjuKoAXj4k75JWBUa8ZKEC4oSGgk2MrfLVux4oNpUK1+DuKGDVo/K
 PfGIY1iIB0kPkCeYk0nxaoDh6PumzlUNTyaD9ulYTVv1aYWHq4VOWRL03FDWtdbv7X96
 MFkzgQbSPWZKD/lhsR+uU+AsNLEJHiOcVahP14Fio9TSyQ/KGXpdumYEOtrhn5Gl4Dy7
 fviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789416634; x=1790021434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BN6RwLaU7PfFpfoUlGZR8hxjDBCfM7qYuSm78TxyFqQ=;
 b=tEGlnG9Z+Z26cf/Am10AUBakDtCiMcJxypkuJ5b37Sn/p9pA98baxn3UEMIIe33cHT
 pDYFH8Usf28NXm0cdjm23DIhliTkBVndb1QhADlsxNVmr+UmlUgkqiQYe3EwMCKaAxiJ
 mMiGfoobPPy/gVPiT3hD4TF3LwPyJWKtZKWAU2TN0/a6OAjAqw2EMCpWt5kDtmNmXTIr
 4emv5QzubkN5TbSB9F72+vQIeRWO2fz4FLn79kaX0UgEBRcAc+VEJ4IC/kILHXh+85Pu
 eccnOp9uICVE6H1Dg5P9DuJTGMETnHdoK6nqkzWi4AhcU5ippBI8ralf6PD2n9FvTUa7
 113Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPmlad1jJqYV9/ovesdfOmaFZiW0AAUGWoptlREJprGnZxFUfzXSJhDBh6JCLDESmdgleSJ4o=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kJd4a7s9qpDtN3W7FkDLEg9Y24okEVgs8ABpKcaUeKdVTmPX7k
 dB/+aBrerbvOESmxtkNEOd6TwpnTPlxO/ewL83Vuk+SK0Jy3jLRwHQeC
X-Gm-Gg: AYBFou0t8h3fjuvTGopR0tHzqON8htFXvGkf5LAanOluRM9vLMCnnp+zyWmJIV1N8tv
 pA6+FDoUGTH5TJ6BgHgi81jSi9+5k1YaO3HUHdL++PydZlEebdKCXlikhOlg5dMUnB8xw6RJ2uc
 H9uI1lLjwVef7Cpst7AqviSA/ystwctRvob4d+Jipby9tXRFehaNRAQoWlhTaTEDCtkyBgAoVWp
 LutglQwCz6X581SmUdEKnNa0mj2mQ1MfK7ilxf0jErJ2lZ9MhYqSKTIx67a3HbZjYye1r7xogzy
 8tDb0TX4RIoFGnu4T15iKwq2V5oixXIwP96qtUzHL8VmSa/D/15TnbacsENV/prBeA7dm9uEVKv
 oBoC5O+YOxMIUW1RL73ZHiooEo7kyZJfz7sYKBgSQYIuPYeaShiNj9c90CofupbfGS/DBlpmgPk
 fjvu+G3do//Xx8CFB+FrYRQ+MnTUsnk2DzSpjS1UWRHmzCKz2Vf1LzX6KUHBRYe6tPOb2yIvKR1
 YbtV+0tbepKDEQ5GnmaQSsTjqjZsybnsqPcGy9y2HhnH0ZeenvmO0Ter7bsEccZacQFN8gpLJs/
 ShWpcpcqOH+qOSB9sm6iMf0c1P372vVR5c4xS9XWkSTP
X-Received: by 2002:a17:90b:1f86:b0:38e:6a44:671b with SMTP id
 98e67ed59e1d1-39debdfb22cmr9003906a91.0.1789416634052; 
 Mon, 14 Sep 2026 13:10:34 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfd9c557asm1005407a91.2.2026.09.14.13.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:10:33 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: trini@konsulko.com,
	u-boot@lists.u-boot-project.org
Cc: ludwig.nussel@siemens.com, jonas@kwiboo.se, sjg@chromium.org,
 daniel@makrotopia.org, anton@binarly.io, Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH 0/2] Close the FIT signature fail-open on the image gate
Date: Tue, 15 Sep 2026 08:09:03 +1200
Message-ID: <20260914200905.280557-1-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 21:33:29 +0000
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

This follows up my report of 2026-09-08, "[SECURITY] FIT signature
enforcement fails open when the control DTB has no /signature node":

  https://lore.kernel.org/u-boot/CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com/

Tom asked for a fix and a test following the sending_patches process, so
here they are. Everything below was measured on sandbox at
commit a44f46af0aa1 ("MAINTAINERS: tee: update Jens Wiklander's email
address").


The fail-open
-------------

fit_image_verify_required_sigs() at boot/image-fit-sig.c:187 looks up the
"/signature" node of the U-Boot control devicetree and returns success
when it is absent, at boot/image-fit-sig.c:203-207:

	/* Work out what we need to verify */
	*no_sigsp = 1;
	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
	if (key_node < 0) {
		debug("%s: No signature node found: %s\n", __func__,
		      fdt_strerror(key_node));
		return 0;
	}

With no /signature node there are no keys marked 'required', so nothing
downstream can fail the image. The only indication is a debug() call,
compiled out of a normal build.

'iminfo' at this HEAD verifies images but not configurations, so it
reaches this gate directly. Against a control devicetree with no
/signature node at all, and a FIT whose configuration signature carries
no 'value':

  ## Checking hash(es) for FIT Image at 10400100 ...
     Hash(es) for Image 0 (kernel): sha256+
     Hash(es) for Image 1 (fdt-1): sha256+

That '+' is fit_image_verify_with_data() reporting the signature
verified, on a board holding no keys whatsoever. The comment beside it in
boot/image-fit.c is correct that only 'required' keys can fail an image,
and that is precisely what makes a missing /signature node fatal to the
security property rather than to the boot.

With CONFIG_FIT_REQUIRE_CONFIG_SIGS=y the same command gives:

  ## Checking hash(es) for FIT Image at 10400100 ...
     Hash(es) for Image 0 (kernel): No signature node in control FDT: FDT_ERR_NOTFOUND
   error!
  Unable to verify required signature for '' hash node in 'kernel' image node
  Bad hash in FIT image!


Relationship to Ludwig Nussel's series
--------------------------------------

The same early return exists in the configuration path, at
boot/image-fit-sig.c:686-690, and that half is already being addressed.
Ludwig Nussel's "Improve FIT signature handling" series has been fixing
it since April and is at v8:

  v7 4/8, direct link:
  https://lore.kernel.org/u-boot/20260618144742.v7.4.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid/

  v8 4/8 review thread:
  https://lore.kernel.org/u-boot/66a3267d-1980-4b86-be3a-791707373554@kwiboo.se/

That series introduces CONFIG_FIT_REQUIRE_CONFIG_SIGS, closes the
configuration gate, and also restructures the closing check at
boot/image-fit-sig.c:733 to cover the case where /signature exists but
holds no required="conf" keys, where reqd_sigs stays 0 and the check
cannot fire. The v7 form was applied to u-boot/next on 2026-06-30 and
then dropped after CI failed.

This series is complementary, not competing. v2 through v8 change only
fit_config_verify_required_keys(); fit_image_verify_required_sigs() is
untouched throughout. That image gate is what these patches close. The
Kconfig symbol here is deliberately Ludwig's FIT_REQUIRE_CONFIG_SIGS
rather than a new name, so that whichever lands first the other reduces
to a smaller change rather than a conflicting one. If 4/8 lands first,
all that remains of patch 1/2 is the image-gate hunk.


Kconfig name and default
------------------------

CONFIG_FIT_REQUIRE_CONFIG_SIGS, depends on FIT_SIGNATURE, default n,
plus SPL_FIT_REQUIRE_CONFIG_SIGS which selects it.

Default n is a measured choice, not caution. Full test_vboot suite on
sandbox with these patches applied:

  option at its default (not set):  32 passed,  0 failed
  CONFIG_FIT_REQUIRE_CONFIG_SIGS=y: 19 passed, 13 failed

The 13 are not a defect in the patch. test_vboot's first step is

  test/py/tests/test_vboot.py:312
  run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-', True)

which boots an unsigned-images FIT against a devicetree that has no keys
yet and asserts that it boots. That assertion encodes the old contract,
so enforcing correctly breaks it:

  E  assert 'dev-' in "... No signature node in control FDT: FDT_ERR_NOTFOUND
     Bad Data Hash ... ERROR -2: ... can't get kernel image!"

This is the same class of CI breakage that got v7 dropped from next.
Making the option default y would require test_vboot to be restructured
first, which is what Ludwig's 5/8 does. Until that lands, default n keeps
the shipped configuration byte-for-byte unchanged in behaviour.


The console message is conditional
----------------------------------

The message is printed only when the option is enabled; the debug() call
is kept otherwise. Jonas Karlman objected to making it unconditional:

  https://lore.kernel.org/u-boot/44dbc75b-13e6-4242-a1a9-43264f379391@kwiboo.se/

  "Yes, printing a verbose error message for something that should not
   always be treated as an error is an issue."

Rockchip enables FIT_SIGNATURE for image hash integrity alone and has no
/signature node by design, so an unconditional message is noise on every
boot there. Gating it means a board that has not asked for enforcement
sees no change at all. Measured with the option off: the string
"No signature node in control FDT" appears 0 times in the boot output,
and 'iminfo' prints the same 'sha256+' lines as an unpatched build.

printf() is used rather than log_err() so that this applies to main
standalone; log_err() in this file requires Ludwig's 3/8. If these are
ever squashed together, log_err() is the better choice.


NOT TESTED
----------

Being explicit, because some of this matters for review:

- SPL: SPL_FIT_REQUIRE_CONFIG_SIGS is added and compiles through
  CONFIG_IS_ENABLED, but I have not built or run any SPL configuration.
  Compile coverage only. It needs someone with SPL verified boot.
- Host tools: mkimage and fit_check_sign build with the patch, but I have
  not exercised any fit_check_sign behaviour change. CONFIG_IS_ENABLED
  is false in the host build since tools/Makefile only defines
  CONFIG_FIT_SIGNATURE, so host behaviour should be unchanged -- argued,
  not measured.
- Sandbox only. I have no signed-boot hardware. Everything above is
  sandbox_defconfig on x86-64.
- Jonas's Rockchip setup: not reproduced. I reasoned that the off path
  stays quiet and then measured that it does on sandbox, which is not the
  same as booting an RK3588.


No Fixes: tag
-------------

The early return is original behaviour rather than a regression. The
oldest commit touching it in this path is commit b983cc2da0ba
("lib: rsa: decouple rsa from FIT image verification"), and that one
moves the code from common/image-sig.c to common/image-fit-sig.c rather
than introducing it. I could not identify an introducing commit with
enough confidence to tag one, so I have not.

Eva Crystal (2):
  image-fit-sig: also require signatures on the image gate
  test: vboot: add coverage for a control FDT with no /signature node

 boot/Kconfig                | 27 +++++++++++
 boot/image-fit-sig.c        | 15 ++++++
 test/py/tests/test_vboot.py | 96 +++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)

-- 
2.53.0

