Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC843C982D6
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 10:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87C86811A2;
	Fri, 18 Sep 2026 10:53:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z7ljR95CGOFN; Fri, 18 Sep 2026 10:53:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B3F3781275
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728792;
	b=c+5CgxTs4FRY+7Rvm+vm3O/UFpHIxTfGbViFEmK8yaXRxtfKhFIjP6KWce2VaK/+5eaI
	 OPBK3safqXz/4PtNp0UvW4zdic0EcoHjZT+cWiHLtDFxIrP9g5UEbP5UICvszW8/khggp
	 KTHb0RRWLAEwNdV8EdT7Z2M6JARUb+5fbpsasyCzRH7XqXuSXlnZaS7YKgoKDostN/HOS
	 3WlUSkObUusKW5+a9hDc47gptm/zgeBkGZ89a6jv5huHzgtKvXkmGDjD+kEdaJzK7qmpi
	 HgWtxTZOqIXN0SUvgs3gtQzNDO2lsFCrOu5MMPajjc0OrsUdamz5JVrQibwbANiYrbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728792;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y6i8yGeqTUtR9uOuBAadsF+lbq+OK1bdc5FBkvxKNr8=;
	b=J+2Ze8mhR1C7sUuvvP1Mum2ZRj0dk+u/fmLYKMP5lTGyVKG3CXMZCqK/+oxe1tBqt+Fc
	 ZFAm3P6z5QWDcWKWV3bTTmP7AGKXpKJcDlFmpg1FTIy1lBSOyKolViZSwMMZZF0KyzVly
	 cs4yekwnlwphXiX0Svsm30ma/xi6KVDAjbedvAdUYTBMOanmPhZKQ+gbMQBt6lOFj0uiV
	 BdAUsZ4A9XkpK6GfYvUwNaO8xahH7qRnCEQvlczTRUhc6iQa13eo26f5bs0bvLAXlGX1/
	 H0+ir1KHhZrR4UOdeBejuY9faHwzPL6lhpon6z6f6eBdp8hsUj+TivmOJJqNeKyW1/Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789728792;
	bh=Y6i8yGeqTUtR9uOuBAadsF+lbq+OK1bdc5FBkvxKNr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A2oOldliAPl7IZdq6LjRNWzSY7o7khrrxbT1z4pruMJjZwEN9hH8GHfMFiwi8CtyA
	 29oYn6FL+rFhvnNsiBANmnr4+LeP9BiU+wdv6356Kr2CGjaijkkiTZfKGgi4oHYw95
	 ROBMdL1aogRydkCzdr+PQkbhnjYZ277zvl73HiUbThnZadXPgt3oWJKw01B9i8Nl6y
	 RJUyud7V10TZcjtfWlKwvmGagsRvneIecdQhZPUy1kjGY3KdzusjSOdZQxpx+iUdkJ
	 A8ZV+EM+p8X0Rbs353vz8D2/65QNi+49e2giMdPrlEUt+/zxouYpYS373+KLHym0+a
	 exe/Cl6In4RiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3F3781275;
	Fri, 18 Sep 2026 10:53:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F023042D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D70EB40049
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aqp1xEsqR1pX for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:53:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E5FFC40048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728791;
 b=a2FaclwkFPr9wTYBFg+ruDmjhaKO4iZ/5eZeY5dVELne0mnTaRUMuAjQt+rbwKYJNXeU
 7BPIDXVixOlcNfrQgnkxDMQr2hvEAga9eavQjr15aEJx8Slc/wnJFlW49sqd7a4aViFGO
 Yc9Kpni/NXcD12g5F+39CIW8zTvANRNziiu01jGaGCTdD9GI59m4dScMY+Cr6HNCQEn5Y
 itnN8vhQK9Dh23CV5B14WM7aeKn1i4KF/Su/Y5nIUA+meWKLpEE5YcMTm5kJGrdvBYQgb
 cjq0HAqFdknqIb6/2mLHGwNCDKMAJrvtIBm9eOa3mSQZpqCcsYBGvbwSQMn8+UAr42g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728791;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Y6i8yGeqTUtR9uOuBAadsF+lbq+OK1bdc5FBkvxKNr8=;
 b=cy0fAvgSsnLQuXOMzggSta9Xy9AZdTTeaCBYQ8DrBXTbwb/uJ7tdlJgrJeZGyRHm4/38
 ZVzNNhvM0NP6b8Bj5L/KWj48GNgUMdNgA/XTRpxsVEww6t+8483udTgqZYrW6MkKyYLto
 G+cqrJxX8NwaegpVvXOo6EnW8sERWzzc4iJvKKM7vwr19++hJ5QROBpU2Kod/vhe5XYk0
 7Gy0y3bD0Ob1J3o6uFRFoZaM44m/kSWZwXDWzXC/Ib2mvoPzCd+IbTn2d/UkzpObO7Pz9
 JleoAIjviK7cw1CtFMQ8gbnu1yhk2kEgP/7XpfNN7xVgvp1TrVPpIeuuCRwOV3vDm7Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=XtrsZfVZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=XtrsZfVZ
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E5FFC40048
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:10 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843172bff4so299103f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789728789; x=1790333589;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y6i8yGeqTUtR9uOuBAadsF+lbq+OK1bdc5FBkvxKNr8=;
 b=XtrsZfVZEqnyCs1RK/ORsPI/Mvg50Q+JECxZJkrB0rsd/0T9iE9Wn9imOhMhUFzVRv
 IMU2C9HypJqow5X3YuvTmFU06GM1L/wik08mMNWxtD13Qg2q0TYumFCJS/q+q57A8cJq
 LemLkPC7k7GyA1drlsP608J+2SsOA7H9Yi3w5i4LMmd1ppPUxIwbXzX9WZ7rQlPlQdCQ
 5G9wo7YM2yoaF3MnVZFL/8mavAfKi3J1DojTEg2iNzGvJK7wZbA2CHEt5sWcaSdNQeXd
 WPjLOdIjEcf7alxBVmbobDv9obHNu6c2xY6PiEvKwHuOriDQ9QqGcBBEKb9kGFQfrWYI
 vbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728789; x=1790333589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y6i8yGeqTUtR9uOuBAadsF+lbq+OK1bdc5FBkvxKNr8=;
 b=BrObOMjfwNv28NRPSfzGpNSePALfa5Zx8ac886T5y3ydURtzpK5YKuMK60njiLieSC
 z0nsurM2D64+ZjbuMuCnDIO//nXPvmQt2rrpixmXJLwUrzxaBNK+nEVJSsjiPUS9W/7r
 10NQym3fWT0YUPvuvJ03LEu7aM1fZJy8T6YlM/XS6ZcbTEumlSRr4/YT/EnJQOjPpyhF
 xXCK3vKf0muIPg7+aYyJmBbYoJodTFMzPxvNx1UyiMhe2LzwaIjtQsMkku2fDz3KfZP1
 Ju5zWLTPm5gfM4vR/xWHGMlFQRhgfrdrXnIb/YaN2m7SCJfCQqIm5mW/MiXUwNOmKKHb
 IXFw==
X-Gm-Message-State: AFuF++mFBfhIudOxrSHtSB1WVwObEuzD3BAlauGjID7RbAGPd4H00h1f
 3kTfNr0Xe8yLX1pZzZ2waL+hXVTHVqhDeu6OA/olOPjxNoN0l/CthRlbf3Dufn3Z5xs=
X-Gm-Gg: AYBFou0daPRm7kABvD1OgdSB1+UQ70DnzYaR9ZgcjTnqGXggXdr0osB/++uX0r5sqaP
 HkzfOcGrrFWhypPys5+/kVTbmPRQnY059s1nR3f+IayvvwHxuIUzd1I0jEwTTOTL6nV8TVjiTfl
 cs/X3665Oonet/Kyy1FOf1Jm3xyXMgCxT8NAT4W1dONoRPXTvY1hplIpRNBFGBCYx40h/xAlzkM
 9dFVFvefR6+XKUiTbxhTM5pu3c6YxNdgXfDCvYMYbHMQleOdMzdpRo0aH3Jo4FcU3arL6njDlwd
 FgZsaEIbHQUjniyruZzZ8TY9QQNMHlc21senWJDeutwrW5l17nFveWXoCeTf4SgvYXHCs99QN+E
 H03cvcCdprQhaXqlCwMeYrcj8qr8uBYY9enIhuKrCrhSQciAH8oB3Exxgl57Hy0OfxM/cWfNNFR
 FlHbsc3tnJgyp73PFXJaRZMsFNH2sXcb6wQ5jKM39P5/sIa0YggRKx+395ePqQWFyrSqKk9nqK/
 EL4XwgdWtaMkbqcJSwLTOUEbBGttnNsyIBguLSUxw9iAQgbv5sF
X-Received: by 2002:a05:6000:4029:b0:487:af3:836 with SMTP id
 ffacd0b85a97d-4871e36ce8bmr2540787f8f.45.1789728788679; 
 Fri, 18 Sep 2026 03:53:08 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm3673449f8f.32.2026.09.18.03.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:53:08 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 14:52:32 +0400
Subject: [PATCH v2 05/11] spl: fit: Decompress any supported algorithm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spl-fit-compression-v2-5-28e946f57357@flipper.net>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907; i=alchark@flipper.net;
 h=from:subject:message-id; bh=7QHbKXOVqX2X2l4Wb3orWLfxrm5QZ8+VlQX5Zzw11cs=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStFf/brCvynuNr7ZuQmQf/rfyc61Mix2ZiynZhwpJVx
 0I4soPyOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhqpUpGhr1XvvKsCtyTs2/XoeQtSc3zpCz+HNlnIXlNmtey/NqHe72MDF+CZQ3
 uJ3ev0VFZd2HfojudXOXvmu/vn5PwVeHBuqnWHRwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

load_simple_fit() open-codes gzip and lzma in two places, so a FIT built
with any of the other five algorithms image_decomp() implements is
silently copied to its load address without decompression and jumped into,
causing a hang with nothing on the console to aid debugging.

Call image_decomp() instead, which can handle all compression algorigthms
enabled in the config, and will abort on an unknown one instead of trying
to silently jump into it.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/spl_fit.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index e02c746af5d3..9a93487bf0b2 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -6,7 +6,6 @@
 
 #include <errno.h>
 #include <fpga.h>
-#include <gzip.h>
 #include <image.h>
 #include <log.h>
 #include <memalign.h>
@@ -260,7 +259,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	ulong load_addr;
 	void *load_ptr;
 	void *src;
-	uint8_t image_comp = -1, type = -1;
+	u8 image_comp = IH_COMP_NONE, type = IH_TYPE_INVALID;
 	const void *data;
 	const void *fit = ctx->fit;
 	bool external_data = false;
@@ -364,8 +363,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		}
 		read_offset = fit_offset + aligned_offset;
 
-		if (spl_decompression_enabled() &&
-		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
+		if (image_comp != IH_COMP_NONE)
 			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
 		else
 			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
@@ -429,25 +427,18 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS))
 		board_fit_image_post_process(fit, node, &src, &length);
 
-	load_ptr = map_sysmem(load_addr, length);
-	if (IS_ENABLED(CONFIG_SPL_GZIP) && image_comp == IH_COMP_GZIP) {
-		size = length;
-		if (gunzip(load_ptr, CONFIG_SYS_BOOTM_LEN, src, &size)) {
-			puts("Uncompressing error\n");
-			return -EIO;
-		}
-		length = size;
-	} else if (IS_ENABLED(CONFIG_SPL_LZMA) && image_comp == IH_COMP_LZMA) {
-		size = CONFIG_SYS_BOOTM_LEN;
-		ulong loadEnd;
+	if (image_comp != IH_COMP_NONE) {
+		ulong load_end;
 
-		if (image_decomp(IH_COMP_LZMA, CONFIG_SYS_LOAD_ADDR, 0, 0,
-				 load_ptr, src, length, size, &loadEnd)) {
+		load_ptr = map_sysmem(load_addr, max_size);
+		if (image_decomp(image_comp, load_addr, (ulong)src, type,
+				 load_ptr, src, length, max_size, &load_end)) {
 			puts("Uncompressing error\n");
 			return -EIO;
 		}
-		length = loadEnd - CONFIG_SYS_LOAD_ADDR;
+		length = load_end - load_addr;
 	} else {
+		load_ptr = map_sysmem(load_addr, length);
 		memmove(load_ptr, src, length);
 	}
 

-- 
2.55.0

