Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A6BC79F85
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 09:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B456580E4B;
	Sun,  6 Sep 2026 09:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D1lk2BAgDh1p; Sun,  6 Sep 2026 09:11:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DFA8E80E3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788685912;
	b=OYr2id2FXy9CfDfEsPLzfMJm8pV8ZLhkbp81lkTxCyYxiQlvNBx8pFya1HBov6uWdUH7
	 FYIYXjzl1cbm3DCH29SRWsEWxQUQvLvyhP54/ITdrw9tWlKbE7YRx5v9BpTpJXQUiv+SV
	 w/HTRE49gPyihYQuUKHEwCsQVuhqkpRMhCRIeMVtk5zH/txbdUqvZx8vi/ITw3qQPKEo+
	 g7KT8qBePcpIbvwjw7shUYm4BJnvcwhapj9OQegtcoSgxk0bKVjTQkyXmH/lwO6sBnvWS
	 TuaWDUw92ZaZCe8zdOAeCAw/2RwqXowjprBu/CxrNTo3V8BW4vFACWi9LSr3MIxJAIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788685912;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
	b=HvPCMyHVgHMV4I/lhN0ioku+MBBR6g8pTEbCvrN9UWpB31SQymwyXigCC8HGaJ+MjbdF
	 Lu8nvtJb6fmQOocSLGw7tM/K02SG8rIbK38Z0WrQyA8Tb4lFyqNxqwPdPNEllL7+PUI8C
	 EdELE7k9Sg6zLfclsnAiEVJ+Lpbr31pTDMKY7cRxs85etOjs2km0RUkd1aa2DFjhmG2/h
	 jsks/1AoLdnU1n+4HyVjJhk4hIVac19oweJK7EddLV4QKhDOaDLr0bveqIEPl9u7fK1r1
	 Tu28zLRTpF9VWdVUueT3BCPx8cXOUZJ1U8RZyXsFfUDdWfhjcu1FXVXfkR5+NH/1Eag==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788685912;
	bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q9V2NsDiE7OjuGUNhSET0+GvT9gU5Nows2tBGQKezjjajPbC2ACk/EwE2aQUNMR6E
	 OLBI+74RpyoEECoXj3oc7WqZ5BPgJCu3Qs/DFjhe+SnvUwK3ee/HJDdMny4sphnzKe
	 E5eI0J7H661inPR7F/Kljrw5hn2hLGit66OeiB9oNtkRwhH/lsgk3PrAgQ2baQ1Nhh
	 n3f+ahhy2+RgOYCnAzZF7DuliMgZaG7CWYJrrTmfb4MJRBa8aBHgkBT+zkVVniPW8z
	 xr+adeLyNiNtxXq3pFoh3EsI7SFjc86PdW4y2R3gsl5Vou0rb3OJp9HNnvzxDH+pPe
	 +A1ZuVQNbYKLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFA8E80E3E;
	Sun,  6 Sep 2026 09:11:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F733A58
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 210F04008C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gvif1tGK9DD3 for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 09:11:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5DAA14008B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788685909;
 b=Uur1CdBAC69Ir7wJ/nqZiiZtNrJ4lb94zUnxntryXLZw1caET2HemfL1bERjzxiOzipS
 5ZmpczPO9Ss8SZ4ygENWAPnI3Ljuc/7tTjvnrW2wFiL5gX/QNGSTH8nzds6E/p+tnbFuj
 sZJBj2aMQixkDgAoNPNo9PJIbe7DP0Q/YKjUf4zfaYgu8ioEnRg5/Egqi2e4t/e1TqTlJ
 7zuqN3xe0TEe1iNj5f5aw0azVNAug7qjldKwQUhRhgFle9b24EBiuk9Ba9k5nIJNrFsiK
 3jtm+4+s+igRTUR9quCJdR1JoxotIvdrc3jTm+cls9NaYKhk4DemIgJjDutYUYe2nzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788685909;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=ssDIDJU1ChSOzh3oO+BjLQu3TXSfUUrpvYHxDp/I4qr9uN/vGxcI+Wq2p5+g5nwPy2/0
 yY7n1TWI9exo6ahweP2nxzdx7QbU5mgBX5N1hMKvDu98oFj62xjgcY09xjHmmcGq8IqXu
 /zyaUMK5fix2unIFeQoMq0kQsu9yYsZt1tUzv/jcxWXK19ok6BSXTrrmRxmSH/rWwsCvM
 4Dc/VMS39zYUtSKbhYP5imRlxpMdCmuB2H69WIfUJu2+ArfhrqPt1NcufMfy/ZhtfTgDs
 ZcO586AaRZfdOcqAXspbqN9AUNfcrmV10rhJa+vosRSxnNDXVNUNlDnuwFbKbbZt3ug==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=eUOqCN9T; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=eUOqCN9T
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5DAA14008B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:48 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cc1c73645a1so1914860a12.1
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 02:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788685908; x=1789290708;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=eUOqCN9Tsr4FeA6CC9I+6ViCD5F5wFnjoR1PSSEBb4iXTApQYyOfPS5y2H/Lqmof+1
 dePwMujOO9JUKv5M6Jmr/0bf9XOnQyXrr9gEh+/6cAF7xIRG08VQsDWUSm8ArBIpC8Fq
 hIiNLJ5B8G24tSJLawQSgGwdBuUK/TsRih7xAKaB9v8faS4I7EmPU01XT1xMv29m1MVY
 2jaycJqiZwdV3P/ggmWTtBLvGdyBqQXOTD2AlZwyGH9KI6Adsjk1n+KfzJ9/nhXKvA0q
 nhCiDFOXZq2prelFLwMRJpbpI0Eg4Ez7hBwuUSQZ7vf/7WvFn+sur8odftSuSY4l8YzX
 +gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788685908; x=1789290708;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=jXpHbZYxLWcBmhVd2D3k1EFPDiteYEb2XS2Wr49Zqrw+iSWXELt6RglVG82t1ZKYAc
 GD3ptSm1N6XqgvWZMf4JES5aT+XPa3dzDCr/VkON1hjb7dV/Bfg1W1IPmSv12twSeomK
 1NlqYPMCUf4i4BpoUW8c4r7JnM+X3ghIc83JhhnWkGcPc9QdJ1fMKEbXse0udlCRTUuW
 8J4i+GMS1qpFMdS+hlNeb2v1Jz9fLJz8K369t6kGd1lsw9s1jW3kLehxIW2qsUhHQJ2P
 hO0WIL/NMQwXS4BxHv5qSq+HsuE8Ea9d5ZfKx0787+cyv6aBorFjgk3XKB3EgfAcotHU
 wLXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz41v1XvHmxIWd4f2mKuOG2e49ZdOMgXuOslMqqimNR4bgMwCg20rW7HF/sSrh2XSHh0/y0Ons=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++loQ5utwDPDOUwNgaFMOgPJKrlx0/UFw+kulpcw0nXlSQzEarBh
 GZNZ68ZuyJLj/3967+G8zrviUkMsZqdirsuFvYMhylBZf5GHPHiUyYnPxR1NOEHasO8iJUceuRM
 JB0U4
X-Gm-Gg: AYBFou2HHUR2lZ2xoK0zvZ7NYUxUH3HlXWRRw3LbwimrRk/m4oZS/2lONm1tM/trfts
 I8r4mvhxYV1NiOKY07tbMTX1AdJmHXoWoABHYxXUOVXnzExsihAc1XaNt2RUrSI8GtECmIAU8rr
 prB0B5JHR+DT42EEbbIKX91ZuskwC3zea/MQXb39Dbpq5aEhmIJwubFIpfL0umtcyo7/7siqGq1
 hrlbOs6IFSXTpFSEgagLfrqjH0kMtH+bUYpyfdU3cIDxNmTkRVouDt3XJj1+zo4IjbzWx4cbcDT
 6auahh1LYRz+W2tRfyXuzp5yerrjF4PIwL86CRBKwT8yLcHoO3o2hqKaDFip0ErGj1lNdl/cXxB
 sJcLP8DaktsMZW9+QvjrM/OSnW/U2DJaG/DyvdJAn3WxvDJAGPGooQBMjjcOShzyW+Z7nXSohPW
 94K89NwZKl8POxKlNXiUDO3S8H1b833ah3dXTb3oiMaKOM3MjoK1OWCzGNGxhTyNnnuVCPXztfz
 gzaKC5XVPcK9zk5ZJnV2v5NWmqWvUlZxgDhFfTIGKe+7DhU8AcjIHBUL5AY5BdlGIaB3H6Gw3p/
 eQIiI4P2JjLFM2mW67abeChOx1M=
X-Received: by 2002:a05:6a21:9211:b0:3d9:215f:9ed7 with SMTP id
 adf61e73a8af0-3da3a001c90mr27437635637.17.1788685908362; 
 Sun, 06 Sep 2026 02:11:48 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f44d7sm18845384eec.22.2026.09.06.02.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 02:11:47 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 06 Sep 2026 17:11:07 +0800
Subject: [PATCH v12 5/7] MAINTAINER: update Spacemit K1 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-m4-v12-5-89eb5a8f879d@riscstar.com>
References: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
In-Reply-To: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Update the maintainer for Spacemit K1 from Guodong to Eric.

Add mmc driver to maintained files.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Add mmc driver to maintained files.
v4:
- Update the maintainer.
---
 board/spacemit/k1/MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 32d47ecc8f1e..4b2bc4ecfc10 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,6 @@
 BananaPi F3
 M:	Huan Zhou <pericycle.cc@gmail.com>
-M:	Guodong Xu <guodong.xu@riscstar.com>
+M:	Eric Chung <eric.chung@riscstar.com>
 L:	u-boot-spacemit@groups.io
 S:	Maintained
 F:	arch/riscv/dts/k1-*-u-boot.dtsi
@@ -9,6 +9,7 @@ F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
 F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
+F:	drivers/mmc/spacemit_sdhci.c
 F:	drivers/pinctrl/spacemit/
 F:	drivers/power/pmic/pmic_spacemit_p1.c
 F:	drivers/power/regulator/spacemit_p1_regulator.c

-- 
2.51.0

