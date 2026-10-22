Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE1606A31F
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zP9SPJhj;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Jyp3N9RT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 399CC4097B;
	Thu, 22 Oct 2026 09:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rvQgT8yKrOAB; Thu, 22 Oct 2026 09:26:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 94301408DE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792661194;
	b=gQ+Z4aWEQIltEjroj/DDdAUxnJ8BHA/mLapK4qlhaEfe+kqq2JY0eug9H3Qa/01xYA7P
	 0Hni3Ufwp0maqdC58vCfRa8U43LJCqPqWe1fkjmSjwGfETh5GhTJYRPjtjSphbjvGjDL+
	 75xnnikD44fhgfC+Yz9aiYyq/pb66fRhWq2UXLlCxNnEsg1NJtL0xGPja+zKTpv+iiquC
	 pt2wCqJB7ORLjkDO2zRhA0HkcQ87Jitk0UD1LFdf0T73AZ1fKRba/j30iN7Kb8lI65oQa
	 x3KDFhhyGwSY74qb89qjO/Mq0T1UYffMOHbyiea9EZQH4VBOHBzZSzXddDqqjBeEg5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792661194;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9sUOFBkE+JW9WH69tMuLSm5gV0UUNtR9yCq8E9DzgW4=;
	b=h47jmqxmITau8Vz6lYu/u7llin/XTmhfttn2BxgnwP1+zQIi385aKOleZz0gNx6p88kP
	 g6G0B6x9TzoaLFRGDy0ti35/Jm8lsM8f3MI84BK/9zsFFG6VoLf9Er9KyzNEJtazZ0jhj
	 y0LJGEG+MiXGr5mnOs0YKk0jKu+ni/QSHRGYiWKSN0rR245KK/KeHQgE5TcsodmjpSd/Q
	 Od1nYnre4eZk9aASqV8m2uzeS9xLllK5Zru1vGTR2/YxUz4vGnIL0KuvcNlRhWYlpuO9a
	 oRdJPxnYaYa4FxHBfAUsPxtddvwkfeso7zgWpvVlPrupdgdHs0+AoqxA/5V1f02fyGg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792661194;
	bh=9sUOFBkE+JW9WH69tMuLSm5gV0UUNtR9yCq8E9DzgW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zP9SPJhjXsbk/44X7ttRhecr9Y21kuDLiByv5TaUKvHFwjUG7Uy09KDOFMDcD98EJ
	 eHBz4uUE6hHaQ+RUDTo6aT8NtD3fe8T7wUv3yDvsJhbUG/sDM999E567XY1w5Covrn
	 507WjyCB03I0u+o9Rr/PiU/8osJa6nteQf74Hd6EwDP3foqpgxSs9o/aNlGaMa/mKg
	 2uxfsvrWbC3FZ/e+EKofb4r+17R43PFm1qhKDqxWFCBk88ZNUm7KsflKYk7bnMPf3n
	 c40FOZOkIGbUhDEU/ZzKp6OByAVEHvH/bJRPwEKvUb1eaqOutS69kcliBcA4JRtz5B
	 sclX9hptTqtNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94301408DE;
	Thu, 22 Oct 2026 09:26:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B845695C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA4FF4039F
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B0YXbQQsz7wk for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 09:26:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5C50C40050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792661187;
 b=N2Hz/WGVKzv54hJji7M+A4K9kgk37d7Xo1yzuptIy8Tdoe5427IKMc1migId6UYEQFh8
 99F7w/58FMpuKiNhc2MPm2ekqnemXbkivcCXo3Hkj0ej/7fRXiRVkbekLQNRKP7dWGCD7
 QIzfCXqZYvBXeHGUdF/UfpLEC5or6XKZDnBMNd2fM2/d2NiO/FAoNjGfvPOvmtzA0KObU
 6Br77LU13Sth7USQeEfFV2Icw/kN9E6rAepsIJJ2UIQKF55sM4EmNNA6lUa4mCUsquIYB
 eF6Ht3aVtB94p/r9KlnvBRLlI84v9P4C1uPR+ORTWAiQT4hW34dhU6i7p1BiqNLqoeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792661187;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=9sUOFBkE+JW9WH69tMuLSm5gV0UUNtR9yCq8E9DzgW4=;
 b=M4M0DsVBHENW28+pziSejg9jWIOPzlxOzdSsNLcfPZRRwk9oLuBGAhWm63T2iB9+Fhws
 seVW5ktwSS2B3x6mMNOzbiFOJEXLM1a9+vN2IHCrEZL6i5LDJr/cUpjt4+qMOfdxGq0g1
 arzXOq038KGGZEG/qmbjCYEam1uF/J97XI4QQHSph9gz9ek0WEuu33leU83uf4nvHZOHt
 6QisdywhHfgu50Pi06gbtSB4mGcbTlcalBm8zFMSdA23pMrDdhN6HntwwhBJLmOcQepTs
 r7bsNFOXMGzchwpYdC6TbFBn5qf7k/9z5XVJNIKqYVjWHVRbK+5hUQWCLxCnlck52sw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Jyp3N9RT; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Jyp3N9RT
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C50C40050
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:26 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so569525f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792661185; x=1793265985;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9sUOFBkE+JW9WH69tMuLSm5gV0UUNtR9yCq8E9DzgW4=;
 b=Jyp3N9RTqESWiSqUC7ukWoxAjSmyV3f86owwec1Qu23Pw7tXwbOqiuaA+b5AuydRTj
 KpDd+2pn+7Tc5IDSpqZ3ZjNwvgz57faV5DB0D5Avatth0PlyK+g7Npm+jkJxLU9sgH8R
 SV53HHHUqKzxlzF3plmK17jtRyuJOHaEshkWJ3aj7EOvEbplqVAq7rBz+1yzGgTsF70m
 d41zkr26kkoxQ5FIA8tR9wkZ/ANerMp7HNjDwFOqCfbr69KfxDLbbczlYj6c6j4sUswE
 ws2WTXKiuNUFFZc6VXfCPol+zaPANJSnM1drn89+1+rbbZFAegYpRw2UGTRadAW29YmI
 ZJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792661185; x=1793265985;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9sUOFBkE+JW9WH69tMuLSm5gV0UUNtR9yCq8E9DzgW4=;
 b=Bdp9+Xeof7pw3gSEzLYuTmAwrLtTtTsB6DEsSK7GYs71jdXyu5rfotstKCjxp7+N3N
 Uggei8ynXZ9xBp5/XnNgQ8R+jqGddKrac4RznDalXkz8iZTCplsC1LKDnvgdhawMFqCu
 5YOjom04qgpr8iZqWB15uhjPvkXXTbYl7ZTP4aXGRbIFHDXmhGT9541qlSfIA8fPkctc
 Y2gcRqRDkV24oo5M5kNbXp7YcS8lqXmk6wtG22lMfTWltAf7TdXewOKQKg2fu7WUR91H
 F7hzHnJGDlf7ZNSi3xIYYA5DZk4gKmcZUmk0sPWUcytuCDjNqdCQ7s9ewbYXiuE1OdWs
 cfBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxc1LkBX4CYhqiuS+KRpEDYhWyhy/o2/48WRD8/2Q0OXPX9dhBHC74GLGl/+KHxY2zAn/FhYGc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLxTwDsNDzfwiiPQ/LYbmcaHY7SQ/ocJb+EDM2zBHHIO3o2E38S
 r4jHW7uW+QLnZSW3H/G71KvHG87cVLHh83Qj1tmTONOPcvMCg/M+rlCzdFnNca8VfuI=
X-Gm-Gg: AYBFou3b34E1O8lZVdRSWMgvLMG1njc6MyGDTQLZQejeKt/7Tikmcmd54SzFcku7QdD
 xGVFmI65S7GwswLmv5o7jE2LBZezD3aRlwwKKoF92WfzBCAOrtDCVUTbxC9n7O5+C24G7UEvtLp
 xBAJbquy41O4iGXbEZF2D7cskMERB0p4CJJ7yY6fm6dUGsferh/1ssOfKN2IaEjudmqatijimRW
 1rzUMeVOuuk5nZj1Xqwxp4GQW4kr8UYsB3w4Qp1fohZJjNu7Srv538sLTLJK5hBJ22tF9R4dd57
 dVEFQlE0L9BkwWJao6v7SXsgd47AA4iQsq19XC0/3vKV9Lx3n5yQVQ5GlBO9L6heI1Si8yOFNU7
 FYX4X4MoAZYHwBEaLZugKmVB6ZFwBWnDMiD8ZAbK+81Z30mVwtx2JTdmitsfsSeL96C/Wf8l9iB
 8lFHOkJDq/EQAUzQ/l1+BzCeOKyC0a1FEnzjzvfDCcYEisQdxeXwN5ZFFbeo7Kas3GxqFzYCYre
 4JlFGFfSpjivvGD+8GaIQpxTQpGRJX4h5TmqZ4t46/aY/vkfAjvY4RO2fQUKF2QtckOXSvkF97E
 UUG4RLHpfvbLHYFQBl/z4tSY1ZEe/blIUwB5SKTgMlt+y74GAay0SiWnGPhKqLBlGfLPAQ==
X-Received: by 2002:a5d:5312:0:b0:48e:1ceb:e8a4 with SMTP id
 ffacd0b85a97d-48e2d11d800mr3282237f8f.17.1792661184579; 
 Thu, 22 Oct 2026 02:26:24 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-21-165-229.retail.telecomitalia.it. [79.21.165.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583522esm11426793f8f.35.2026.10.22.02.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:26:24 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 22 Oct 2026 11:26:16 +0200
Subject: [PATCH v5 2/4] arm: mediatek: enable U-Boot fastboot DAs on Genio
 510 and 700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-ccaione-upstream-mt8390-da-v5-2-58982fe11312@baylibre.com>
References: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
In-Reply-To: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prefer fastboot in U-Boot proper when the complete download agent fits
the BootROM SRAM limit. Its shell and boot commands support provisioning
and recovery beyond the SPL agent's flashing operations, without relying
on the installed firmware.

This variant requires BL31 and an external DDR loader.

Use the same eMMC boot preparation as the SPL agent so provisioning a
blank device does not depend on the chosen agent. Keep 16 MiB of heap for
sparse writes; the download buffer is reserved separately in DRAM.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi    |  2 +
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi         |  3 ++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi    |  2 +
 arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi | 62 ++++++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                   | 31 ++++++++++++
 arch/arm/mach-mediatek/download_agent.c          | 15 ++++++
 arch/arm/mach-mediatek/spl.c                     |  3 ++
 configs/mt8370-genio-da-uboot-fastboot.config    | 29 +++++++++++
 configs/mt8370_genio_510_evk_da_uboot_defconfig  |  2 +
 configs/mt8390_genio_700_evk_da_uboot_defconfig  |  2 +
 10 files changed, 151 insertions(+)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 2ee7fb1f40c..f81ae1c82e2 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -16,5 +16,7 @@
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#define MTK_DA_DESCRIPTION "MediaTek Genio 510 download agent"
+#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 510 DA bootloaders"
 #include "mt8370-genio-da-u-boot.dtsi"
 #endif
diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
index f37ec34b0f0..249441fdf0e 100644
--- a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
@@ -12,6 +12,9 @@
 
 #include "mtk-genio-binman-u-boot.dtsi"
 #include "mtk-genio-da-binman-u-boot.dtsi"
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
+#include "mtk-genio-da-fit-binman-u-boot.dtsi"
+#endif
 
 &ssusb0 {
 	dr_mode = "peripheral";
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 4fedbda9b3f..395241173a0 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -16,5 +16,7 @@
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#define MTK_DA_DESCRIPTION "MediaTek Genio 700 download agent"
+#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 700 DA bootloaders"
 #include "mt8370-genio-da-u-boot.dtsi"
 #endif
diff --git a/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi
new file mode 100644
index 00000000000..a605ad2504a
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+&da {
+	fit {
+		description = MTK_DA_FIT_DESCRIPTION;
+		offset = <CONFIG_MTK_GENIO_DA_FIT_OFFSET>;
+		size = <CONFIG_MTK_GENIO_DA_FIT_MAX_SIZE>;
+		#address-cells = <1>;
+
+		images {
+			uboot {
+				description = "U-Boot fastboot download agent";
+				type = "firmware";
+				os = "u-boot";
+				arch = "arm64";
+				compression = "gzip";
+				compress = "gzip";
+				load = <CONFIG_TEXT_BASE>;
+				entry = <CONFIG_TEXT_BASE>;
+
+				u-boot {
+				};
+
+				hash {
+					algo = "sha256";
+				};
+			};
+
+			atf {
+				description = "ARM Trusted Firmware BL31";
+				type = "firmware";
+				os = "arm-trusted-firmware";
+				arch = "arm64";
+				compression = "gzip";
+				compress = "gzip";
+				load = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
+				entry = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
+
+				atf-bl31 {
+				};
+
+				hash {
+					algo = "sha256";
+				};
+			};
+		};
+
+		configurations {
+			default = "conf";
+
+			conf {
+				description = MTK_DA_DESCRIPTION;
+				firmware = "atf";
+				loadables = "uboot";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 8b2534a19fc..4b2417801fd 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -275,8 +275,39 @@ config SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
 	  downloads it into RAM. The download agent also configures the eMMC
 	  boot partition so that a newly flashed board can boot normally.
 
+config MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
+	bool "Run download-agent fastboot from U-Boot"
+	depends on SPL_RAM_DEVICE
+	depends on USB_FUNCTION_FASTBOOT
+	depends on FASTBOOT_FLASH_MMC
+	select BOARD_LATE_INIT
+	select MTK_BROM_DOWNLOAD_AGENT
+	help
+	  Build a small SPL which loads BL31 and U-Boot from a FIT already
+	  copied to DRAM by the external DDR loader. U-Boot proper then
+	  prepares the eMMC boot settings and provides USB fastboot.
+
 endchoice
 
+if MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
+
+config MTK_GENIO_DA_FIT_OFFSET
+	hex "Download-agent FIT offset"
+	default 0x70000 if TARGET_MT8188
+	help
+	  Offset of the directly parseable FIT in the BootROM-loaded download
+	  agent. This must match the external loader's DA_FIT_OFFSET value.
+
+config MTK_GENIO_DA_FIT_MAX_SIZE
+	hex "Maximum download-agent FIT size"
+	default 0x8f000 if TARGET_MT8188
+	help
+	  Fixed region reserved for the download-agent FIT and the maximum FIT
+	  size accepted by this image layout. This must match the external
+	  loader's DA_FIT_SIZE value while the loader copies the complete region.
+
+endif
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/arch/arm/mach-mediatek/download_agent.c b/arch/arm/mach-mediatek/download_agent.c
index da17fb4b309..193817cce98 100644
--- a/arch/arm/mach-mediatek/download_agent.c
+++ b/arch/arm/mach-mediatek/download_agent.c
@@ -6,6 +6,7 @@
 
 #include <dm/uclass.h>
 #include <fastboot.h>
+#include <init.h>
 #include <mmc.h>
 #include <spl.h>
 #include <stdio.h>
@@ -55,6 +56,7 @@ static int mtk_mmc_boot_prepare(void)
 	return 0;
 }
 
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 	int ret;
@@ -68,3 +70,16 @@ void spl_board_init(void)
 	if (ret)
 		printf("Fastboot failed: %d\n", ret);
 }
+#else
+int board_late_init(void)
+{
+	int ret;
+
+	ret = mtk_mmc_boot_prepare();
+	if (ret)
+		printf("MMC boot preparation failed: %d\n", ret);
+
+	/* Keep fastboot available even if storage preparation failed. */
+	return 0;
+}
+#endif
diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 125ebcd784f..95e2157b507 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -33,6 +33,9 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
+	if (IS_ENABLED(CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT))
+		return BOOT_DEVICE_RAM;
+
 	if (CONFIG_IS_ENABLED(SPI))
 		return BOOT_DEVICE_SPI;
 	if (CONFIG_IS_ENABLED(MMC))
diff --git a/configs/mt8370-genio-da-uboot-fastboot.config b/configs/mt8370-genio-da-uboot-fastboot.config
new file mode 100644
index 00000000000..d5766c34e25
--- /dev/null
+++ b/configs/mt8370-genio-da-uboot-fastboot.config
@@ -0,0 +1,29 @@
+#include <configs/mt8370-genio-da.config>
+
+CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT=y
+# Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_CMD_FASTBOOT=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x41000000
+CONFIG_SPL_MAX_SIZE=0x25000
+CONFIG_SPL_CRC32=y
+CONFIG_SPL_GZIP=y
+# CONFIG_SPL_MMC is not set
+# CONFIG_SPL_LIBDISK_SUPPORT is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
+CONFIG_BOOTDELAY=0
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fastboot usb 0"
+CONFIG_ENV_IS_NOWHERE=y
+# CONFIG_ENV_IS_IN_MMC is not set
+# CONFIG_BOOTSTD_FULL is not set
+# CONFIG_CMD_BOOTFLOW is not set
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/mt8370_genio_510_evk_da_uboot_defconfig b/configs/mt8370_genio_510_evk_da_uboot_defconfig
new file mode 100644
index 00000000000..c696e89c892
--- /dev/null
+++ b/configs/mt8370_genio_510_evk_da_uboot_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8370_genio_510_evk_defconfig>
+#include <configs/mt8370-genio-da-uboot-fastboot.config>
diff --git a/configs/mt8390_genio_700_evk_da_uboot_defconfig b/configs/mt8390_genio_700_evk_da_uboot_defconfig
new file mode 100644
index 00000000000..102f61a3afc
--- /dev/null
+++ b/configs/mt8390_genio_700_evk_da_uboot_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8390_genio_700_evk_defconfig>
+#include <configs/mt8370-genio-da-uboot-fastboot.config>

-- 
2.56.0

