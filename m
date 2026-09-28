Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EA1C9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55E7180F62;
	Mon, 28 Sep 2026 13:42:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mw0WSWbL3idd; Mon, 28 Sep 2026 13:42:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7F35D80F19
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602952;
	b=izXCFZbD3Ps1+cgW0B1dliGiTT2vunJ7fb0d4YUOvT6FU2ynbLArVqsN9YuSF3077wk5
	 g7MAvsFsoR4HVPRFKo6T6jbwV5zFWoEUsPidSx/DBYfdApkmOJpGivUHg64h2Ji/7AegK
	 0WuQDp0/cSc2wGQSRJrJ2uhEUtlfTT5RHH/NDt2Mw67ne3xPQ2xLAuK+Lt6kWTMiFh7Cp
	 kRZf9oZt7hA2AP9MX5aE/wBE4kxVhMoHmz3bT2HmcHX1s6wcTRF1FCbt4YlpYhhNJmeCt
	 UJN2s30R4MQblYu4R7SKmtwGXg0dGjLILt5pWp3HrL3+r+tZ9P10pW1HezrGXBRGOMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602952;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u6OWmc0AhtQgmRZKI/0aUWw0qYBDQZ3TJcaDlL3Zigk=;
	b=W+P7JZPor+wKqi5cPUgeN4AemMnpPSc1n917xN3GoaWBUoGRVknBCjixTW6mt8m27sAm
	 IHXnlyy/QKRxfFMogTJyjygFBbcBn661aZiszxYYPVcR6Uj/PZ+A8tBlLOqoT2PM6Ioka
	 bA9lTrmmLjASAEAMNTowN+h+/WtniuSs/ApbaQomoXh2WCKxTo3BNPWeIsb6d4OCxDfHj
	 p0ZbGhe60KamuqiZlcIWZONOZPrhcGtfrmQgqqwoa5erKR1FGMoMu6akkxLDvFf7aKHdI
	 PURCaemnqJoPnSSH8E8YYiZ1+6DUrvErc5p7o1u49Ocj68HI0lSMfjUNRYgzGo143YA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602952;
	bh=u6OWmc0AhtQgmRZKI/0aUWw0qYBDQZ3TJcaDlL3Zigk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YyNtesarH5QdqAkLIvjjghAwIGIRzunlxBwv61z9QNyUhTHbU2gHcyqbAXdw1vTTH
	 JmJcfJTPzn/3StZbOJfLPUmmzFlX8CTm7CJgLD0hplrosVMv88z26klvutXe51xqHP
	 Ee8XVrMG4pQoNmyCAcJk8HTcrlLUExC+zNtxhmUGGq8FwsLztutWGBKnsqjdkHAvJf
	 7EwoM+wEfR+a4MIUpxRXp2tCczvd489RdpcR87Z0fImU2PtzoxUwMVM3pR6IuJ+bzW
	 ZJon5ZnFa0of705Eh+G40HspBzQvYRoWJayr4mwwAuRiYo0et6renIQNRzl1Bz3Yrj
	 goEzsc2xfefFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F35D80F19;
	Mon, 28 Sep 2026 13:42:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E345D361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C951B405DA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SaJp021nLOT9 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EED56405C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593518;
 b=VS6MkGXsCcBzDSshZ7+75EoV+QB5wY0wGUpFHriI+kfbxRKwSA5zfnpE7lUZOfXm3kt+
 m3NUA/+eSRmsdKpVewZkFA6qhZxmNfkkLXgxAsrB69AZd8hkmLmN5Lxe/UaX1xognZ85M
 V7Nqm3qmj4VZeYXbMMwJYD7iIqgDj+tmO244SviH18++FWATFLp1iNCqxYNjzDo7AHVV0
 c9KVE9I8LMXRs9d4RZQ0/npuIleo93ExyhktyzstbsxMke28y/f1/dl35/WxTjzyFCIJV
 G6HgoUQQjndka9aVCRxhuyF2Xsi8n38x7xiH/eRjjEspUT7V87ISfLTPb1r9Xm+5CLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593518;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=u6OWmc0AhtQgmRZKI/0aUWw0qYBDQZ3TJcaDlL3Zigk=;
 b=c23tgPtIfbScDYduvw/5e3tmNKOaJ7azYNaCgaXwkV8TJIpmDuxeT41IFwM/v9Lszdgp
 PwTokp0023Hd7gCHlakXuz1enEcCQJCiBPcWy1pckDmaDs+uhc7Vr1hKFy3NUod0ktUm+
 /aG3bzWuM66D9sCt0yoyDdMynH8lqQG36qYuex8POOHaQ7lwX1K0NCrbLjyu81OEi02xN
 kmRD31YZMgUcPB+F8YzBLuw3icHtrve0DWQOXQWxO670rn3OLoPm4N5gbd4Qcb77r2Czw
 vtU/PHC3U1HPFh7CvxM2vr2RxSJ4wfL04tXNv3NSBu7qIe2YyP8WktSGao7dQtN/cLA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PyaNtavF; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PyaNtavF
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EED56405C5
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:17 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so15477275e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593515; x=1791198315;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u6OWmc0AhtQgmRZKI/0aUWw0qYBDQZ3TJcaDlL3Zigk=;
 b=PyaNtavFdBq1tssd49o7WlbMxryTZPBWnDhh8aonVMtrPxKEnBuJyz4Z1lEMFLMeZS
 lZMcJaSMCRSQZlu9+cJqbeaM0qUQPjD2TXJoGaPerjve/C7ZH+bpbEZYAJEPn/sikvxf
 G6BVB/C2QrEodHN9MzB64y89DIsdQnUmYX4FcVQoXitgWwXCb7GRtI1wch5oT9piVGAw
 PrAQjDc3f2e1Utb6YbyB7GY1ZiVTJtJufVi8wZZMJ6isqtS1B9gwBC8H6NGFNMYW9gbR
 sfSLrKQEhJYdAn+I+mNrNZBGbkurp8lIPmJ+H1mc1xM5S/aDnUyyhXPQt6e1VAmliYYC
 YBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593515; x=1791198315;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u6OWmc0AhtQgmRZKI/0aUWw0qYBDQZ3TJcaDlL3Zigk=;
 b=tFyYAxZ3Td6pljghOgRr3zHzfbWzUxZqqsJCG52h94ta9BAeuSNxKdNTtCm/hs/4zy
 2IFa087yQUY2RLtFVr1Yjf7vPKN5/NPDeQ3C6GjOcdtBeJBw70k71f0nGyDAJGOScGGF
 QSXLlPmbQmxHavbYsldZf5zkLoNz3BS7u8RU0HnStPt4mm0GWI/YMqSNzEPccQ1d8q+M
 ageV9qNOjE+MkO60TgYdhqnieZhp1+kblJfUoWKO5Mh4uUmtNoYYBs6GycOT5eBXzVY1
 /ZTQsiI7/xZImfIEVo/AjOTC5fsViMt1HVAJBsOVtqD2XFUkO+R5HQntlg3XmR6RrGXU
 JFOA==
X-Gm-Message-State: AFuF++lQm8j06n8CJxrX2e0PlJfcHApuRLPXQ0afXUEaSt/hOCe5cQs2
 wEdzYe8nNF4MSxQttc8xI54Dd+wcczrsHP4d+0pdoF9jLhVoboh6Jc2dQmg6Kkc+/gg=
X-Gm-Gg: AYBFou0TV8AAWLF2bDK9GRsbZQw3cZs4L6QbzlLGUD5oJiT11yv4hkOfMsRu00VU2+W
 SY/XbBdYeE814W8kIJLVKbePh3+2+zeSZHqPcohxwLV9Evj+yMhmz3AMP8RrtD887OhnMzRPaTc
 tj2hMqNMwW9XUZLl+pkDStr1YcrJ21YxLbmTa1leXva6zkQddFKqT7FhMXBk0RJMtYdmxAlV2Ku
 S+IT5ypwuDodHwmAPUlb0jn3HEf3uldVNi4JiYE2H3tQNxGUZv2ymOQBx1wjStJhqkWSkpom7vT
 kMJqbgBokQyvLVQZrTjIvsijqY2q8+BMitVuq/0hs7ZQ109nl1maxWCuGx6r85Gr/T3v6rCRhmd
 WDU9Y8jxS8ZoK6wXew1s9RJOxn7xGmYqWsCVs+7d/ALnA/T4VNrceu4M7x9FaQu43QMc9I0t3m1
 e+zjWsi+h52/TrYHq3LfP+FG59zAiAeXPb+6oXuG1rodQHwL81OO7XYVJcrtAsqkz+QvkxCdAqq
 pcMxYsxkfNS0qe6IX+HPtlUXmL9dZvi+4/+3KTOgWFiu71PAIbruP+KjuPvXDhHtYTPmKNxXSHd
 e8lN/6V+rV1wIEv6FI2yxe0yjzMeleKISs5ZxYF7kA==
X-Received: by 2002:a05:600c:1d1c:b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-49ff06bcd5fmr158242345e9.8.1790593515410; 
 Mon, 28 Sep 2026 04:05:15 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.05.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:05:14 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH next 08/13] xpl: Pass the make jobserver to the xPL link
Date: Mon, 28 Sep 2026 13:04:29 +0200
Message-ID: <20260928110434.70686-9-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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

With LTO, the SPL, TPL and VPL are linked through the compiler driver,
and GCC's lto-wrapper runs the LTO code generation through make. The
link rule is not marked as recursive, so make does not pass its
jobserver to that command. With Debian's GCC 12.2 and make 4.3, the SPL
link of turris_1x_sdcard, which the next patch switches to LTO, then
fails at -j8:

  make[3]: *** write jobserver: Bad file descriptor.  Stop.
  lto-wrapper: fatal error: make returned 2 exit status

Prefix the recipe with '+', as the U-Boot link rule in the top Makefile
already is.

Tested with Debian's GCC 12.2, where that link now passes, and GCC 14.2,
where the '+' does not change the images of three mpc85xx LTO builds.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Marek Behún <kabel@kernel.org>
---
GCC 14.2 (Debian 14.2.0-19) links without the '+' as well, at -j8; the
LTO images of turris_1x_sdcard, P2020RDB-PC_NAND and T2080RDB_NAND are
byte for byte the same with and without it.
---
 scripts/Makefile.xpl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 69b35d6ffb6..601de94f5c9 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -549,7 +549,7 @@ endif
 $(obj)/$(SPL_BIN): $(u-boot-spl-platdata) $(u-boot-spl-init) \
 		$(u-boot-spl-main) $(u-boot-spl-keep-syms-lto) \
 		$(obj)/u-boot-spl.lds FORCE
-	$(call if_changed,u-boot-spl)
+	+$(call if_changed,u-boot-spl)
 
 $(sort $(u-boot-spl-init) $(u-boot-spl-main)): $(u-boot-spl-dirs) ;
 
-- 
2.54.0 (Apple Git-157)

