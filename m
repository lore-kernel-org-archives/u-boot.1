Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B59CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3686140DDF;
	Fri,  2 Oct 2026 12:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xG1dWQKF18OO; Fri,  2 Oct 2026 12:26:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 572B040DD4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790943997;
	b=ZISc3YLFFJUaMFVkb3e/5Qq1xV/wTOxqXMWp9jSGrCgxA7fz/Bqx7jDstce8LJtaBGJ+
	 QlOs4mPMAJSU6BuE00xX71CEBfCl9YAC+OZJUKTqmyNvXeXytOfKjo3mjzi3P8tWhDlUj
	 jdL3Bk+5Ls+YHLkhyrdlRrGdmuWMVfSlxlIDkE3LwGDvveU3WdIg3Kz+JVJhKNILpLpgG
	 aZ7iV+E//wWUXJC1stBNhDcExJhipjjTerTqvdZwFPL/TpdKOXQzNDGXrVT+rq8jyLJRl
	 TLlrlsIUkpaYBlbfqXrrbJrIO6Qpg23McgYPSZ5zqXyNL/31bApjGu4SrZ9ySKcARhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790943997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fnJbapkTT4ioiOvzqrmz+IM+Gz6DUU4UPXlvmlmDtz8=;
	b=CnWpVJ367wU4AxF8JFXhOEp89bVfN4iKwvY3FmR6mjm0M0TDd4bOhhVTra3TsfLQnbld
	 15s+2f2XHFVD0EA0olFHYsy8GLSnlE7i08s0dvfPP5Ighhy5UCjRSb3Nv2+ly1a/AaXHH
	 Ign9zzb4y0cfoUxHO/FW7ShmOK0WfdTLezkrAbTUdozDIvMDc+iHD+DW1RTGx+jQRyKvi
	 xUWEiXgq7zvaUHOolLyCjQJsYUQ77I1OG3gHNKChNsgTYotIKEVmzz9LBXCrt5hSvtEPR
	 Uy5q44nxuzqhcvsgXi7Fd3DMxOsRo7M+ZyQ/vOS4SQbMRDVlxJZKHz9xvF56VDwJOog==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790943996;
	bh=fnJbapkTT4ioiOvzqrmz+IM+Gz6DUU4UPXlvmlmDtz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DSw0JbKpMsp7IlMaa1oCSmCT6W9baTXBx2xiwNqUaR1ybjkSMHPPUUTLyNBC19GKN
	 2i0A3fgnYBWqiaXHPLGgstOk8HJc0DXVCoAwPdF6l/T10ySPXR26C3tfoCePrHzSCj
	 ji5qtZhcXsQ74HdKJyKhNe7xkAVj3o+icelVFz1ponQ4YQX3Uaqpp1mPmHG/GlQLQN
	 gys75UvK1JRTVt6aOqRQKdtPZc2UUtw3SXjQTeZHdiSk0t1n1z82Rkjxo/OKN218es
	 dcvlYyflbzzLB0fXeSWRQ69EJin4l4CnxmZjJgEjMCMSe3OaFsxYmioRCc9v+vlnbm
	 pbxq0+Hxb3eww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 572B040DD4;
	Fri,  2 Oct 2026 12:26:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 668C632F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5874F607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bv_U9guO5_SS for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 07:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1FE8F6071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790926475;
 b=g7Th1gPhALh0FkvWnNut1HKGXuPCGQn8UU5vP2h7RAsbIzDQIuSYhEk1ZeyU7ZCj4mDN
 DdQ/TSHAqBTOiKOhGzTXGnLvN9I9TspNpRdLq2jN0z8t13Wgr9pr0sIJiR4+JmPjGL669
 44YD/9GbS1KATWvFNGT6hJpuX8qVqprKZHpRC8DDfKxmURcwufOJD/7vUpyXZVobiMdBA
 vRBnJBWyUJDzDhSHBJT34W9pUJyydvY2Avbxzpn6kFqhUPcCdkf8516cQHCl5Tt2+xKVo
 eblAawNgBdahxARQScYvzl4As1m3GAqNrHnCaas3FUyLu6tXtH/KoVDtT7MNV1VrCvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790926475;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=fnJbapkTT4ioiOvzqrmz+IM+Gz6DUU4UPXlvmlmDtz8=;
 b=rGVZSrk+u0qC4eP3Ns4vDjB04wz0zW1ULpJvUyRTaA2yexmz+gGZZCJfG/8Qqxh024ad
 2b3m/iKaXGLZHPwjw+zRHF9PH5TgpLI+lsVXz4bnyWLxmCqOh7uoDxS4K1b9QsejyBBYw
 YnEKJA2paiQsY/MDreqPLFTwvN8k1qM6uYe8gik01RON+j75DC0BFRsNibd/NFsfVWwaY
 GJbOLCGPlcv8shE9syJGUI7Nq9yFHaacNbWZB7FjvTMLFdlycBipoWIoljHXXFaV0TYp1
 39Y1aF30YY2irt1m8uEnOhpd5ObYunpI88N0pqHGMFiEQ8ycSfRmkMUUpJVQgt90l7Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=aDu1lGVS; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=aDu1lGVS
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FE8F6071D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:34 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 567233F998
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790926472;
 bh=fnJbapkTT4ioiOvzqrmz+IM+Gz6DUU4UPXlvmlmDtz8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=aDu1lGVS25w7x/VMOzyV8+XnLzyhalWzpCK8kJZuuogGfwgcrAn9Owgit0TLi5TSj
 Oo+UE0GGutsUwoTBYqvFEZ3vrUL3cSnGJPzOlWL7K44LC21zNgCXsWy9oRjchjuz/4
 UFBs3hYkZPuWn32StfpQP2BGIvQHmdI8SNgMa2e77iYllmcefmDzo9XiDyyDxv0/H5
 QSQODpjF668fEN5U4R8NWb5RNWkra2dVGf1CsdvXmnpLtgNqYeHGdvJ4CFMLbK0Oh5
 vTPaheKKGZgtVeM95WtTMI6M2ldaWIwcoDFrV7jdrAFh6JxfTGvZmOXCIN7GIGd6OQ
 H0acC2+Uj1D3m9+yq2skjRvX9mV/+pfqKEGrUxCZVbAStgu4Z71azO0Enwnjjb/WNn
 MJA31bz1N6xFX1SntjZDD1/a79aG+pDJTK7MNW6eikdkAAsVcYMKajg2om6AsSyXI7
 cMBjoLPRPUxv53OwJNQudJpzEoetLgRNu7rVdVlGRSOTHbxdge8+0DuG27yKNA0pNj
 jc/cQfz3azEsvDWPgkKQer3OpkCF5QLYD5matSwVSJSvDVr75iEI77afMGrTQfBFoy
 s1RpQ0ZlhxqFS8alAh8c/VoLmd8KN7BLwdvzQAY1uurViJEg4hP23hw191FNtOK4Sl
 rPuRGrbO7Ifz5Pj7D4aTr3VM=
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a47a81e70bso4939977a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 00:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926470; x=1791531270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fnJbapkTT4ioiOvzqrmz+IM+Gz6DUU4UPXlvmlmDtz8=;
 b=xoV7+ywML1YI0Kyn6jCxLPA3BglFfx2ke7TExFaz4QRg9lsY37zp15rzqsrM3w9hOL
 2kI6Dwij6UvZmASf+ZOUG8EbnT1lEqBowFVjhht6ZLvI/FoLjcy5nVLieLcT5LDH41qx
 nS4zXtKkFZvRxyo+qu7Cu4A0lSRK5PAgn0o5dPLvQfZFjvMzzRr+VFTiW3WgO3dsV20k
 /8YuNFindVjo+t4k296eXr5ePGV7xHfOTEKhUSpAGKxRl0Ous+w2j0h5ISWP2eLN/RFz
 vgtfm3zdDP9TQXNs38z/aMSMGOYlXiC0x75de+ogEApegoLMPIkjNaJwxyMfP1amvo1O
 3HgA==
X-Gm-Message-State: AFq9FYKSriIx+vZ5r8W32Ybbx8UdzgeIzbph7UVx/HdLRZqGsDlRgJDG
 KBI2sS7mUJtG8c3Xu44uRyaNVxA1LPmuEdOTkKzih3aR/Desq4e2CARQYKmWlb5gP2cAU7CfPWu
 p9oQjjTDmUWJn0Qh5S4vBmPOwvkN2IlQdnHrVoqUZN9OPjF1BrMz0sLdH/DFyAGksGyswarsE81
 8qXKR0Z/t9QuyEJxPjaw==
X-Gm-Gg: AYBFou1GFaScapTGg7x5Qtk7zZi/qv34ecAWWctHgN5j+wUtSWPHEkcBbxFfXJYS/Bg
 uk2ER+D4MD6dJzvrj5Qw3X0uVq14r96WhrsxPL8L6t5ghSFAui1ftSlKZiINnWwajL9WWLWaoFs
 T8YEdxJJFbL+BI5VjNi68w8UfOA9fuRIwJhWpMsjPA4NhCg4ihBLb832zEngcNIoYBrMiIqwgcU
 mj//1zDT8UZ9V86NOeCZYhUdWWl4YjVPFPYMJ8uy/omtg2a/SwrXgvbkCA9BM5oSpUhJ72s9zdQ
 SUFfpp6KlFC+d+TdEKp5VYMIRFFwf0f/oNrOWZIe/eTRLxuywZWJ7t6mJ9WItz+kJhrf3tSEnri
 4MhX5bObVfGobhAluB95LfVDdQ+BryJrtngmkcZR5aSVJJlAlTMk=
X-Received: by 2002:a17:90b:4a92:b0:3a5:56:6934 with SMTP id
 98e67ed59e1d1-3a6ce7993d8mr1771501a91.34.1790926470166; 
 Fri, 02 Oct 2026 00:34:30 -0700 (PDT)
X-Received: by 2002:a17:90b:4a92:b0:3a5:56:6934 with SMTP id
 98e67ed59e1d1-3a6ce7993d8mr1771491a91.34.1790926469715; 
 Fri, 02 Oct 2026 00:34:29 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd44c2c9sm3172004a91.6.2026.10.02.00.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 00:34:29 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, Aristo Chen <aristo.chen@canonical.com>,
 Vignesh R <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>
Subject: [PATCH v1 1/6] mtd: spi-nor: drop the duplicate EN4B/EX4B opcode
 definitions
Date: Fri,  2 Oct 2026 07:31:51 +0000
Message-ID: <20261002073357.382228-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002073357.382228-1-aristo.chen@canonical.com>
References: <20261002073357.382228-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
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

SPINOR_OP_EN4B and SPINOR_OP_EX4B are defined twice in a row with the
same values. The second pair came in with the Macronix Octal DTR
opcodes in commit df3d5f9e410c ("mtd: spi-nor: add support for
Macronix Octal flash").

Drop the second pair. No functional change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 include/linux/mtd/spi-nor.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4eef4ab0488..b427253b910 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -125,8 +125,6 @@
 /* Used for Macronix and Winbond flashes. */
 #define SPINOR_OP_EN4B		0xb7	/* Enter 4-byte mode */
 #define SPINOR_OP_EX4B		0xe9	/* Exit 4-byte mode */
-#define SPINOR_OP_EN4B			0xb7		/* Enter 4-byte mode */
-#define SPINOR_OP_EX4B			0xe9		/* Exit 4-byte mode */
 #define SPINOR_OP_RD_CR2		0x71		/* Read configuration register 2 */
 #define SPINOR_OP_WR_CR2		0x72		/* Write configuration register 2 */
 #define SPINOR_OP_MXIC_DTR_RD		0xee		/* Fast Read opcode in DTR mode */
-- 
2.43.0

