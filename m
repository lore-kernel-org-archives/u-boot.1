Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9F606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bfL3SwhW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vd1rr0Ii
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C09B140AC7;
	Thu, 19 Nov 2026 13:33:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EFsT_bwxQUff; Thu, 19 Nov 2026 13:33:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0855340ACA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095217;
	b=NwtmtmHubF8IgatfjSUnPUTZ8kyNhr00BIW8Kh3aOt2eS2ZTFlhBlBKIGDyiuKB3IVZz
	 3Szy7MX2vfkNXBht93xIPFxDpl9cz7yFAMvvCdr9WFyppVmhoLWP22J2nXcB0EU+NepU+
	 bRAY60UA7ZAj5p/dEXbJ6LCZ9tucuEwk22YnbMwabGrVzQU0oyz/NGahrECaHz2D8ftdt
	 yW59hQnkrR9wHvZelL8aGUOFDKeQWRiPXFD/ie3++1nUNWDIyedoEZ9RKI77vUAXiv1RG
	 +bAuGbFd2+cV314gZKUNDfPisO8p8sBuYye/WuXqX9EG9ZZzGzvswgG3UKAKYfKnK6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095217;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=x3f/LRbPk8xC/bbu8PL9rA64t2qqwellQljrhYWgM2k=;
	b=VZLtDElotOMS2Q2xEARWMgC/WoKZqawPeI1bDUc9942q2Cym2I3xh8QZrBNFKis35CuG
	 6uACicBs5SJ8r5INZrlK+ZOEiUxDq2MKEKG24kptsqA9MslB7HnvhYg0hR1u7MEiDq1VG
	 1WAZfCbCyFL2pnaIOwk4QpYM2ofaYwCc2f2kMNtOt1V/GdddDp18BQmUlhdobprlALeaF
	 vCSZYHu+RG0K1+prvuplKZdIrU39T1yrvK930rqWBltgsneMhcCa+vPyPL64caKvBI8hS
	 ZRdUQqnPkEAVsoXEAKCzFTWSOsj0ZO8bmBNqqdwB/wmBFtRzTa5AGutv/BIBXEW99Pw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vd1rr0Ii;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095217;
	bh=x3f/LRbPk8xC/bbu8PL9rA64t2qqwellQljrhYWgM2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bfL3SwhWb+sJdUFsPjOx43MeuPLXkJef2Ve6Xbweiift5ztkuNJigtZcfn7SlBkBQ
	 io9kDiIl89aDnYMWeqEMF/CdSgtIzo061o1cgWih5E23ugQtfG7gVEFoT5bHZTBP3z
	 H7vgIfB8DBj8vfY2+qY2i22HcfzLPw0bP8XD07Mb318DFFVFoQjopn16jEeW4BQtHx
	 K3zUeiCeA6AhXodmGdmnzXEvL1ZYPuLcO3hKLBaxwgOR4EvUhfzY2eENTfuh4GL2RD
	 LthoOnALl9r1BAN4VrNoBWKkg1zaS7eOBz+hZLQRokKrxOswrpTTpePdz+Ebi/3FQV
	 KF9j7D60PoGZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0855340ACA;
	Thu, 19 Nov 2026 13:33:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 265AC9F8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07F9740B39
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id waLkQrj8VUa0 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A8FC040B13
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=vd1rr0Ii
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8FC040B13
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:26 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4a9be758734so444677f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095204; x=1795700004;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x3f/LRbPk8xC/bbu8PL9rA64t2qqwellQljrhYWgM2k=;
 b=vd1rr0IibExrRPBO+bPGRT7hyIH/T716rS6mvyVoV75Qwnk0/lh67uZ0WHOqLICVuj
 0qpSdtU6fPmKKCx5gZsZTN8Z7bPkmH4V7m9JaINaixDRbLTd5h4zOSK6hGoUtKCseiTI
 XoST56sJAIKwtGZ3HLHQn4g91hHo9pGX/ddEWjIrq60SVuz31Ik2aD7NRWSDQNvg57RI
 LTSGO6R9rXXv/1ZxUJF1V7c/ehtZlH5kBlHa6pdaxoqzA1LMfChzHVLZoB9gfNhcvGfB
 UxVm0K4twmS71jl5PniY3kfZYU4KAz40UXuswF1SgIYXj+otQpVr4RKukqUxTaThSy1t
 5+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095204; x=1795700004;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x3f/LRbPk8xC/bbu8PL9rA64t2qqwellQljrhYWgM2k=;
 b=f+J/dsD65BDhwHDfcbn/TQmMieGgEp32UHszLhF/dGcvadmV6c8Dc2l6739DY0eQHc
 RHaW8uPwE5kCT+3OgqF/CI+4Fp53+Utv3aKfC5mt80TlXFS8wol0AjCTKk6PBru4xaSD
 i2MnyBsugO0hu8g9nbBo5HWLlQsPbhrD3eMed46yCZRNsTUpqmlxvUsRRoE6UMO9IXWA
 689BkmmnxUXrm875f29doYzTU8Nd3Gl1/TPtoHlZ61t5Ip++SihkHR0Plgi6unsaZPJL
 icY19Bi1ioM9oAtwSvLnbRKoKDUcMFuKylM0k7Ujr8JJFsv51AOE4bD2SRTCAz356Vks
 mcSA==
X-Gm-Message-State: APuU4Z+MKbePYHgn6Xh5wf0PMClf/EGZxtOPrNHTWwTzN80o5UPiSbO6
 qr5RfgdH8Ud0DxY7WKoAWt/QoaIJzg0Zv4vchbAgNMbog8Ebl62Pg3TeILnrD6RR
X-Gm-Gg: AZFdTZeGtu+YCBO6K/yv0RhLcUV48zum0FlRbDjXjmaWAmiV27a7AldEzJMgLhM41fZ
 Xqx3X/Pkh1ExWIK96nCHa9X0LnvLjQphPw1rMI1RNFlJs1dYlQRx24iL55+9kJmFZyrAMfxd2w2
 AlmE4G0a+bV4hzSf7bbyXts63fSbay7W8j35EeY8nlSWv1nOWwuI/U6VBpomyZ5f9LWicGZatqY
 MyyINSTIescnCce4It0DDonO6mcWzogOMTkq76ivlMNq5OYSe+ApWCcJTThCqwJm8yTmos2wA1x
 QW7LmVzPTtTdTl7C1aY4iJj8SQZ4MJE5r1p5RHzlWHM/k4R+fJpslUg+csNDGntkck+84btEEU/
 DSWhUGN/piFAGW4jNm/OUnAMOR/yW2Wdgxq+enhiRqzNLjxSzobHbNoLWrQvWLPVm3SQpnbetlI
 EqCcjeEOPrFDOpfUlw0NgLyG3bkISoWm+A865Jw9AZ2vG8c7zEtp+0k6pXu+ZHsADfyAMP5nq18
 ez6t2X6bFfLiMuSE/Bw12uIo2K86WUCT7/LEKMt93cMuv51lJsFQAi8Ru+peXs0iEYypJByw5HQ
 gJR0Elk8iTtDDnMH+SyONTR+ckNfmbfK2snake+4XvJ4j69OPPI0Rnl5X77gbrYvHQiEjEZ4Gfu
 TA1/onzVF2rJM9I4Cx0nz/gtTWeQMa52HEhnolWumOlYVcUoX+686ntrFJf5ZeYA1WVQrOxiPKd
 HKxCFB8OraQTNphV59nOXtdmwk7BGk+XkhnGPkzBh1LbwIsOmpT4y6
X-Received: by 2002:a05:6000:2483:b0:4a7:69c3:94d5 with SMTP id
 ffacd0b85a97d-4a769c39869mr10170535f8f.28.1795095204298; 
 Thu, 19 Nov 2026 05:33:24 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:23 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v3 09/14] xpl: Pass the make jobserver to the xPL link
Date: Thu, 19 Nov 2026 14:33:05 +0100
Message-ID: <20261119133310.22732-10-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With LTO, SPL, TPL and VPL are linked through the compiler driver, and
GCC's lto-wrapper runs code generation through make. The link recipe
is not marked recursive, so make does not pass its jobserver to that
command.

With Debian's GCC 12.2 and make 4.3 in a Debian bookworm container, the
SPL link of turris_1x_sdcard, which the next patch switches to LTO,
therefore fails at -j8:

  make[3]: *** write jobserver: Bad file descriptor.  Stop.
  lto-wrapper: fatal error: make returned 2 exit status

Prefix the recipe with '+', as the top-level U-Boot link rule does.

Tested with Debian's GCC 12.2, where the link now succeeds, and GCC
14.2, where '+' does not change the images of three mpc85xx LTO
builds.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Marek Behún <kabel@kernel.org>
---
Changes in v3:
- name the container in which the link fails

Changes in v2:
- shorter commit message

With Debian's GCC 14.2.0-19, the link also succeeds without '+' at
-j8. The LTO images of turris_1x_sdcard, P2020RDB-PC_NAND and
T2080RDB_NAND are identical with and without it.

The GCC 12.2 failure was seen with the bookworm container emulated on
an arm64 host, for v2 and again for v3. On a native amd64 GitHub
Actions runner, the same build linked without the '+'.
---
 scripts/Makefile.xpl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 77746ec07cd..cfc1ad17822 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -544,7 +544,7 @@ endif
 $(obj)/$(SPL_BIN): $(u-boot-spl-platdata) $(u-boot-spl-init) \
 		$(u-boot-spl-main) $(u-boot-spl-keep-syms-lto) \
 		$(obj)/u-boot-spl.lds FORCE
-	$(call if_changed,u-boot-spl)
+	+$(call if_changed,u-boot-spl)
 
 $(sort $(u-boot-spl-init) $(u-boot-spl-main)): $(u-boot-spl-dirs) ;
 
-- 
2.54.0 (Apple Git-157)

