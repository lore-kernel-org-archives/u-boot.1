Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148860A2600
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SHgwKCq6;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=unDbWfXE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FEAC81135;
	Tue, 20 Oct 2026 17:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KMQdFd__aKkV; Tue, 20 Oct 2026 17:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4EFCB81173
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517189;
	b=mMITN+HG1sZ/6cb0yfIWXSkSfhnMBFk5DvyVTTOsc/r6B47EjTUNzDtQND+K5Z6GT4mo
	 4Vu5dOBMkpPg7Jf61ze5MSxUtVXn+H1Mlc27EOeARSfTp2Pmha4g2QxHjzoaOziC+eQqN
	 rn95VbmdR9dAZO61zOfs2ouDHjq+ICJcVsmib/sZXvNOULC3rA9m7GlVHlEv2kijnhHxj
	 WjvEIIJPAPaPg3ouW5pFrnnI6P0Uj3o4r8zwpGNv+p0xxByN8qnJ6PSd0yHUtCM8/bs2B
	 pT30o6QPvGq0DwcxmDomQKxCDrRrn88H65/BImgbijSSNC96wxeXNg7fREbVAkAZR9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517189;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8sTc5ow0zDU27McQp023qAjV3bRJwMfcw+cFXM9l18s=;
	b=dNBDlwLU7SpFyAFTEAk04rb/xU+vqJPttwPxufXSrcZ/mgfoVxhQip2DUyD0ZeTa/39y
	 AzqG8i5o7ohp7DJSJld7YiSgHuCGopmRe/J26iF2Mx0NGIcItucay1X9MrrYgcKNc7HvX
	 itAnivvGB3aYbIirKokkll3IoXCKDW4nkbTZAITIfqzhqBY4nhRWEP7pnIfbuCSKCJvzV
	 DsJHQexn24HwPHEY6tpfZbKcFOa673lGA5zBBu2kJA8AMSzTKdD952n3s75Fa5HvavgwK
	 rDhTCANDLt2tvXKQ73UmapA3WujGiuiSx0on622PAqBQIkbb2lWDZ211h1vjeAP+quA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=unDbWfXE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517189;
	bh=8sTc5ow0zDU27McQp023qAjV3bRJwMfcw+cFXM9l18s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SHgwKCq6zbyGf6iYKMf5vCD/RwmgkKeP3zmwrDGN39VB0X4Hl1coBR22QZWcaWrrl
	 auwqNwVY47fcSVJ9KYBQuBrZxCeW/nEuDpR+Z5JNHsxUsWAKXrV5fmB0Mr2Jaiz6o/
	 ClPVniMYx/IwUAcDp+vxVkhUxH202l+xzbt/Hx8K6W1CoPxjzT5rw0LaELJCD5e8TQ
	 4t5rUf0PPIx4juvTDv46RDYsUQ2f310ZpU0J70wqMKHx4oHNMZZW2zNK+H9NKm27ng
	 VdH/RNpd+1wwrP+mOWmCsmaT0G/fHRFCTV2wNktxTiupjuwjAThP29JUJRII3P/7Id
	 p5t7BpFGOLksQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EFCB81173;
	Tue, 20 Oct 2026 17:26:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4596C1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BC18810FE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30YHzpAeaat8 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:43:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 03C2A810FB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514582;
 b=pPnJLzmeNcAsRigBmq9uuNLW2gPGN81MyvxPA/Uu3U9ZbcQwCTYX3qE4VUg8i8vIOBqW
 NeifHdpsxYBQM3AYedVs0pRtNDlUQsU7OCv33Y5V1GL2bu0fdhwEzVBdBM8Qpn1vd6H0o
 2gmMw7g1ETKKNDWud8z2VJo8je8QM1KhifUFkoNAODdBwcWSQB9qJSgERyPmodV4azQvx
 wgVeZpyqNyYJbxLfySz1pEmBexD5BZztt6HzK42o81KtnfIwIA+qcOAKjwJGPxTexwiN+
 TGXs8+y7zFptCibfbmE0DECvT2l2l3tni6q9ezFkl1IzEw7j348pn5NxAi1doeM1YKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514582;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=8sTc5ow0zDU27McQp023qAjV3bRJwMfcw+cFXM9l18s=;
 b=Talxw0WuEvhJkJKRNxfQpZH62aBVVxdU7kNKGuyb51jyarZ8Kt7Wl70n4v/1skziNIzj
 i69vDk2f02P6ZSsGEIbhSsDR/CVsXq/z636dIBvhpDD955pbjQv4zWbz1LJTTdNdGNeg4
 TAd4qQVOMGcmgYTYllgkooynNH7n59E9xpLpKfyqkGUcZuRNxCwnDMF5lOg1U+6eiS9tR
 mt+vJEJ5J3xoQm2flxE3rbYj/nL02zXEcdamXmZGyrGusM1N0VxJ8sKM3WOeOzuRf/aAw
 jeIVN2eHY3XUr1wYB1MXtkjKzmbHJdUG7Ymy+hfpQ02yp0E5MkeoCvLPYlciwL+5qgg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=unDbWfXE; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=unDbWfXE
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03C2A810FB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:01 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so34737565e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514580; x=1793119380;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8sTc5ow0zDU27McQp023qAjV3bRJwMfcw+cFXM9l18s=;
 b=unDbWfXEK/DDxNy3tCbEix+vmOV4eW58/AzvkFhSR2/C8t2iqWOqpveRDveRn23Rfx
 4qeP9BFROXDozIq1wcjlt7sSLJkeZildiyC+qvfpx7sD5EdkNefSEQl9K0o9JLsL8sQl
 4SPxTa3MjvGb8SSI3OQ85caU1SsIR7K2nbZBGVyVvrV+op2j1U9xDdgjmKJZfLicpQ45
 g8klO4esroNGCTWYfoa5YXuf4bOdzipBXapOGd7ISS4Lr25L1jHkSFPXH5M1DgTHv1L1
 uCcKT8Tk1mMXPITLthVza0tWtQ2pNIUlss4CTOCkmsr2vksBvzZbNevktRsRJdpeD1pf
 Z8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514580; x=1793119380;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8sTc5ow0zDU27McQp023qAjV3bRJwMfcw+cFXM9l18s=;
 b=No7N/hvn0USfHXUxitHc0dElX++e2obzt4xEyH/7JHBxegv3J89p9S76Jlp5SfAnxh
 fWW2K70nVrovimoLAmaKO53E1YhH1TFQcPrUeItG7NUr/5yERSAycFSWhjBJUmG3hmbS
 89fIzCr4wpAcG+8uJ76ePosZ6prQUJX9bP224wWiznmg+bkMcIIg3K53o3nR2YucO+b4
 mpDZA3OY9GGG9AvyKTQFVk5AzKOY+00foT45odG5nMWbwXqGFXDzpB0TeOMIfRhJNWA2
 br0lceDvK0pmAkzn0rA4qJnvTKfbwG30j7uOl3FIquLrVnTJBSk+FcCWJW7REBisUL4r
 a9YQ==
X-Gm-Message-State: AFq9FYLoPm0NLXh3WEBqo8jqt4r3L+BduWN0p7ybGrkjkV8YGWvY7eYO
 5yc0XiEp2NOSvqigPHwy+vykIzUmfexu+8AULbl7vjbGFMs64jO4rVhCqhiNfIAK5s8=
X-Gm-Gg: AYBFou0fwm3Fwv4z7zSGMZAMAAJSFVGf/77zmSc0+3iPtJy36LPZrIcwt/1qlVszqL1
 EIF7gIoTpfTJyve6jvB7RS2oSE1zgmYdGj4Evb9PaC3OkUUnOz5Kw6Eghf/xDny6LrwAlRtlkLC
 KYIxm0Img2sE5dyzIijPptx2Og4fPjvIy93YmakXhgBnaxgneoQNAZjbWqEwwM1jdifvhGlqk1k
 6JEEEPts9OE3agtOb22HWjNFtCNNIdrK1+ZquOTrNU2xhWuFgsxj3G4qjMSklRtKKA+ePUWrgHX
 CtOd4hyM5qvB8OzNdjeYG9QE9puBO1L8UGkj2gAXNICXAkbsIh1UP3uBE0IOAty/6SstwFNEiC3
 l/FzEM+XW81d0EDn0mmX0MlY+N/oDePryHdmtn7Y3RxVWeeC6zDPtsTCP7NuUO3oFe/Px3utz/9
 NlXD6KmQFtkWunUXNdg1T1xqKOJ+qA6Jebh/g/P9CARJQN8bSKWVWOyuJqyzusQtrRn03GoS+Wi
 x9EagDKFm8mqA0lVLjsS/6kRw09JSFfMtO6FRxiaTHG+ggTGs8tdg==
X-Received: by 2002:a05:600c:3b92:b0:4a1:acaa:9d4c with SMTP id
 5b1f17b1804b1-4a1d76315fcmr304915535e9.25.1792514579602; 
 Tue, 20 Oct 2026 09:42:59 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:42:58 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:41:03 +0400
Subject: [PATCH v3 16/23] test: spl: Cover compressed FITs read in whole blocks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-16-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
In-Reply-To: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
To: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>, 
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794; i=alchark@flipper.net;
 h=from:subject:message-id; bh=K6y92c0zJyEg8GjhLEBdh+gD8gJDj/SGrOMSSTqwjiM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7m6dt872+plV7isZC6u3M3CmPdQjr/hxMpIg7Bjv
 f83XucV6pjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqK6MYfjIGNV6Q6en8v71E7F3PRff+LY4nRbbz+D+eNb0zeoGv/jRGhm5ppbW
 lzrH+Fu2r434VBR1Xr4/j9VjyeOYXka9fw5pfMwEA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:26:00 +0000
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

The loader tests which decompress all read single bytes, so external data
always starts at the very beginning of the buffer it is staged in. A
loader reading whole blocks stages it from the start of the block holding
it, which leaves the compressed data part way into the buffer, and none
of them covers that.

Load each compressed external FIT with a block size of 512 bytes, so that
the data starts part way into a block and has to be found past the start
of the staging buffer.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/image/spl_load.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 558e49e86cd3..d7637507a249 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -1590,3 +1590,50 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 	free(img);
 	return 0;
 }
+
+/*
+ * A loader which reads whole blocks stages external data from the start of
+ * the block holding it, so compressed data lies part way into the staging
+ * buffer. The loaders above all read single bytes, so load with a block
+ * size here.
+ */
+static int spl_test_blocks(struct unit_test_state *uts, const char *test_name,
+			   enum spl_test_image type)
+{
+	size_t img_size, img_data, blob_size, plain_size = SPL_TEST_DATA_SIZE;
+	struct spl_image_info info_write = { .name = test_name };
+	struct spl_image_info info_read = { };
+	int comp = image_compression(type);
+	char plain[SPL_TEST_DATA_SIZE];
+	struct spl_load_info load;
+	const char *blob;
+	void *img;
+
+	blob = canned_blob(comp, &blob_size);
+	info_write.size = blob_size;
+
+	img_size = create_image(NULL, type, &info_write, &img_data);
+	ut_assert(img_size);
+	/* Not at a block boundary, or the test would prove nothing */
+	ut_assert(img_data % 512);
+
+	/* Room for the whole of the last block, which the loader reads */
+	img = calloc(ALIGN(img_size, 512), 1);
+	ut_assertnonnull(img);
+	memcpy(img + img_data, blob, blob_size);
+	ut_asserteq(img_size, create_image(img, type, &info_write, NULL));
+	ut_asserteq_mem(blob, img + img_data, blob_size);
+
+	spl_load_init(&load, spl_test_read, img, 512);
+	ut_assertok(spl_load_simple_fit(&info_read, &load, 0, img));
+	ut_asserteq(plain_size, info_read.size);
+	/* The canned blob holds what this seed generates */
+	generate_data(plain, plain_size, genimg_get_comp_short_name(comp));
+	ut_asserteq_mem(plain, phys_to_virt(info_write.load_addr), plain_size);
+
+	free(img);
+	return 0;
+}
+SPL_IMG_TEST(spl_test_blocks, FIT_EXTERNAL_GZIP, 0);
+SPL_IMG_TEST(spl_test_blocks, FIT_EXTERNAL_LZMA, 0);
+SPL_IMG_TEST(spl_test_blocks, FIT_EXTERNAL_ZSTD, 0);

-- 
2.55.0

