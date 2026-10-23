Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7D0606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CXdzB+w2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9RTdU7z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D49E40AB4;
	Fri, 23 Oct 2026 22:18:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CljuuMjd9sf1; Fri, 23 Oct 2026 22:18:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9CC2F40ABC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792793934;
	b=JbwxuQcd6sfAoANNm3cSz1LghbOJBgaw/N629Qmccadsnplm9sKDiIe5JbLVmvv5h9vm
	 MtEeKeLHc3x5S9b3H/NeoSUe+qrpjoXInsYZSxtD8C9gX5J6sOUoImMZ3L5QLAuLcTdKW
	 JTr19ezQjFCL+zjZXFSnX8ans5L3DeXrQeJJ8YvnUzfSUqvQEykNh7U3JnG1VoGX4n+vK
	 ZvOHtAxOPNMydip539CU6Krx7ggRBHPdhng4OVsIayUw3jOUrgmYZOmxy6cSSjfAAR2Wk
	 yfuEOF+CfCrL5CXQlizIBjD0fBaNYt8hU3aW8nUGlkKPBO13YEUIttvT527LMAMPDfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792793934;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sDaNkgRGFwFmKDvq/EAoc3JwKGtCkl9xxlfAP01fhWs=;
	b=dvmSuNA5ofLGpY34OAH6d0gYw0ax5eg+R+wzIQrdNX2LdKXy6TH7on80r9umsoqcmtsT
	 PfGhahYADCbNzKgT0su4nyGn+nuxtka2a7HjWl/mATBjRUinyi2TtQWLptsMi8poUYaaa
	 Z3zHm/FoCEDBNF+JHEUqU2NZzlGzrg44Jcgp1817WhW/PUTbKyNy4O2qaDhVkJTJV1/EK
	 Qi7AFaQ/eGTlqwhNX5+oJGlcDxns1LXEabl2hXOSpRgZIvrxIrULc4q9HZKD7XJFRx+HG
	 fFndkH3i+pt2qaUqE5/at3RMM4dnEPSaDniRdmjnoKbBIQE/wEAeaB2kFcQ68GWVJ0g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792793934;
	bh=sDaNkgRGFwFmKDvq/EAoc3JwKGtCkl9xxlfAP01fhWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CXdzB+w2DOutH/Nah2EN31pCZvFYDmUW7M0xjCEcjaxHqaWid8u6NrKVrfr5mPrNp
	 EO9jB8yYjxrACKHj2nzavaX4WY+bYFNKc8gx4rFBXrJwugXTouHgeoQr7M/mng0k4L
	 Mo3ZIh+dV0WtFo3wdZyFJonwkHQ3qu8aRlKKL/Lj3wXFBAhCSQh3mOyMhBuLrZlgKP
	 2KpZ6MDXrue0qBVRclXww0LozYQiKNE2ip7eL76i9pTHv68uh4ZMfPeQDiWruESx4e
	 Hej6c/aUfRQapezM42AItQSdmky6unydTQYy6KEBGz0mfUj3UXdGZEXJoui6FayuOa
	 HsMioZtv7XEGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CC2F40ABC;
	Fri, 23 Oct 2026 22:18:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 71A1C79F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F79240488
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BDWoar7lLChZ for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:18:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BDF264016D
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792793928;
 b=CYvBuVhSYyLfjKpalw8Zp3eGZzYDHK+BgY1/6kZ+Hf11HAUyVFYdTVofA57t7JTgVLWS
 VdScaZ75Yslc9jjr/z64SWspHvrgPFS6P6mepla5LiBeoX040JqOFBuxl3X6p+HsUgYVk
 RXAkmVAkl4r9XvX1TIMNti20K+Rb8fMurkXKC4aJetQsr43o4noyj5gHzsj0IclFrc6vl
 dcSMrOGXN1MHjlNmyKsHI35jhnUZ+HQG4CdP6pMVq+Nza6gnHLHs/tQwwPR6g0BgJtvCu
 4MFGliGiZ2Da6t1NC8SiAByOM8dNiD+Y/8LX2uV4FWzQ23zLWQZNsuzxkDkxJLnvH+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792793928;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=sDaNkgRGFwFmKDvq/EAoc3JwKGtCkl9xxlfAP01fhWs=;
 b=H0Dc0Gv99+pFXuVtXrT/+Sri0fLkkSRaN7k54IfQNiu8j8AgjWF13rBU3ME9xSHTVh3R
 uqeZu52Slft+X4KUkD0xFJ+Qq2zDF33pulM2RWhptF2lPG8t3rKlSt9ekpcvkTeneT+bI
 G1+e/n9Rutnv4lffX142rZDSAgDWxYOuQbsHCZM3zsquZerhnK6gyyGeTeQ61FtfABvqa
 PvnntQwYFZr6jN+7spOOvXJkt+hrVz0naPRpLY18/4SPuApDQnDBTR92nQxA8/b3dyQ55
 OcOcUOsDVGtcRb+jAxBq9VhkgwfFKdRAqAMl+MF+4/iwBm5sAxYbNIrXrqKQwSSnGsQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=O9RTdU7z; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=O9RTdU7z
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDF264016D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B03ED6022B;
 Fri, 23 Oct 2026 22:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFAA1F01825;
 Fri, 23 Oct 2026 22:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792793927;
 bh=sDaNkgRGFwFmKDvq/EAoc3JwKGtCkl9xxlfAP01fhWs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=O9RTdU7zJVa72zxzvTgDrvYOrd1PamV0bj8ePw3WvrI14PhigXIgln3iF/VXmS6b2
 l3qqGgbfyJQ5COx6abVSphQLVEMynwcUeqg/gPQNgL+j21hqTunmLbiColoNpBdj85
 GuOzEmYyN3Ep231BJAb8EFgWHw6T9KwfhCL1XLu1brS7sfmLujfSYYG2pdPQdcIUGX
 HKt1BDWs2KSZpuzvUw2aLFxrC7J5i81QbZYLQ8iPSKCnSfr3ALOCBFjcrT0fLhY0ft
 FfUammGuy/Sb4CVY+8hm/EooMALgyTfyuWXg9j9Ov9wSpMhOLKUkWFi2X4G9euKp+I
 nKc8v7sdqJ5sg==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 24 Oct 2026 00:18:34 +0200
Subject: [PATCH v8 7/8] ARM: dts: ux500: Harmonize GPIO key names
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-ux500-external-sdcard-v8-7-badcdf6db2ea@kernel.org>
References: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
In-Reply-To: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot want to use the volume down key for activating fastboot mode,
however the code there relies on using the key label, and this
differs betweem Golden and the other devices, so harmonize this
by using the same label as the other devices.

Signed-off-by: Linus Walleij <linusw@kernel.org>

[ upstream commit: 18fb6f060ebaf10aa69f7411868dcde376c528c2 ]
---
 dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts b/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
index d4f364ec8685..1bb667300ed3 100644
--- a/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
+++ b/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
@@ -391,21 +391,21 @@
 		label = "GPIO Buttons";
 
 		volume-up {
-			label = "Volume Up";
+			label = "VOL+";
 			/* GPIO67 (VOL_UP) */
 			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
 		volume-down {
-			label = "Volume Down";
+			label = "VOL-";
 			/* GPIO92 (VOL_DOWN) */
 			gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
 		home {
-			label = "Home";
+			label = "HOME";
 			/* GPIO91 (HOME_KEY) */
 			gpios = <&gpio2 27 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOMEPAGE>;

-- 
2.56.0

