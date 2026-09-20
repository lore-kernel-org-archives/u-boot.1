Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD356C982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 883ED40F18;
	Sun, 20 Sep 2026 15:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ARrpUAuhJVk; Sun, 20 Sep 2026 15:49:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7132840F1E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919377;
	b=Rwog80jOKw/KpGn7d93bxp/IIfGynih/sHxoGUZTCnXXHQlp3TAF8On0cF7PM6Kkhlww
	 ORzfgAQDX4AFaTDxvMAfF8pBIYyloud5iGn57Yyzl8UA3g210ZXfv/UGv2VVFqKrXoWjF
	 KtrnMTEIDWI4TSKgcbLy06WoZrqIvnS2XLuTZFEeJYlAPwiT0ZYKBPDOsYKmFomjcyFtc
	 vY48Hf05/a4V2oDdn3tPYqh7UNh6W1wi8/dQkTMMmerrufIB/VlI/6Unq/YZSEkdKKEJh
	 eCGh71jY+RVxDZu2FURQKi8jeETf46//Cc0+IxRvaIiBxURm+0ouSKd5CohHjSPay+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bDGDgGxhwGbuxJdr2gksQc4btmbuNW1E00/nWJ/qnz4=;
	b=kqhlRAXOeUQYsa8dG5KQWFV283/BWQQK0xSiZPlTbbhjYfN37tGjp5IILa3YzpQcegj6
	 thHNaIUDXhF+FBqw26K4VElfIEuCqIDBN5PWtY0K9tZUnZQXME5CDMMug251WSRmWDNe/
	 tTd2akOtQ1Dux6srbskIxiqBEKe/RVHdMHTfIZvUDKkpalNDn9LKVHu77xzX3bZ1yvrl+
	 Ngeb0d7c21QpfgzRFIQLefcSvvxi1OM+WU2bpbxAWcuX7i7glXAf8Am9brd6U3EGvhnja
	 V//29hVBOgjUXWMzKSa+gzSGOBunvt5MzQ5jwud8FOkweedegoYLOprA4hm/R5fFcbg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qy2VHls6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919377;
	bh=bDGDgGxhwGbuxJdr2gksQc4btmbuNW1E00/nWJ/qnz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hrUpI1+qpuFa7O1ynDrqDtscAe6G4Z+gp01Krn9mycRdVrsBGkDoqi8t1GNayG3q+
	 ekbTST1aKH0ptTiibTXECb0a2F9zPMkbPjVIlGS7sTuAfceopd1Ai6nJOzVxiSlGJj
	 MaZH/i45sICCRwi8A6GnqYzWQZwcafZi0oBKiw7yGGnbyLfo7Wsj4avMEddFZmuU4C
	 gA5uCt6F383QvSIwSkw4CQYF7ON2JKPn0CT88wcObsAMUiCstheTGxPEUqECUJ6EXf
	 ca/JM3w/VBlnMxK2S4tTEeuekBjcdwhxpgBROBsSDcij7cVvyyErcxoUDNuQ9/h6T0
	 WjDXfgGTF78/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7132840F1E;
	Sun, 20 Sep 2026 15:49:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E2F5371
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9005840E09
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mhymf2AjWpPt for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 14:16:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BA7E240E32
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789913795;
 b=QBMHBgYKAOvop0OUdd4fShEDyBit1cS8fUQQc6Hri/jr185QEW6zZfdQ3P8QACxj33hD
 t/3q0ExrlBlOHNrBH2DFW8hiFn6PJFGuJnGOjjyeAG7RlXcRXO0i1SG9xTE8p1S6M14MI
 lmeu53FvjcvpvKomG5HKttTGKQQeoXNkBYzHfXz9a3qu6qb4Eqh/92Ok8TlhGBW083xDf
 gcXlBraykKCfERMo+NtiLu/bM21zrxJwU3IXMNfTjjCKFOqoZl/6DD43R0RScbv5G/vdt
 xILYW6VryAmSAdTwwWnZHgwTQ7RjeatzsT0VpomByXZppfObqF9hcaz9kxOn3dx2GDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789913795;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=bDGDgGxhwGbuxJdr2gksQc4btmbuNW1E00/nWJ/qnz4=;
 b=MkY7+oRKp/PtLztQLdsU3efPdS1eVJL2ior/V+ArhLe3lhhv6FesjBH4SbYR1lmEUz0T
 3Gm+L+0eXOHeS8dakUlpeNVGOxrkdS/yy3PGSmMBnbiwfw32kfIaqwWy/2XneEo/Mb2oy
 1xIgY4Hk/43Qf9DMLTyXkiuqoRvyzaXHEVezlWgJkEueRWnR2fjL1WwSBSVK6t1/AccFH
 bgWTVco/InbZzFe6wjbTWd6ynTyNGXoztRp8MsPfutQRVzYefaG5x9FDGtTfZ0Fnn/tsD
 qbBL5LLAuihSRMoBWYKX+ugHC5uw+Hg4bl9X0bp32IdixPOpHf9QmXnAK2YHI753Zmw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qy2VHls6; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qy2VHls6
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA7E240E32
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:34 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so29962735e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789913793; x=1790518593;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bDGDgGxhwGbuxJdr2gksQc4btmbuNW1E00/nWJ/qnz4=;
 b=qy2VHls6Tdida8Y6Dnh+0qswLOevTyl+1dWm3c5CsyW64eusWSNFi+rGUHU1Njzsvd
 de9rL+AgXHpMe//v0jBIHSBfWfI6l8mwt9ThIgLnLjEWuyGZ9Xo416f9Syd+VWG7zVq+
 86Bhn5Faa5nsp5dC8AGNjWiFjFYStOIQ+mAPiXya8CKK6nUo6IQqNX0/jKhW26gtkaTY
 4zRXwz5ATFni/w64RME+nKzYwNDRHqWq+mzE4oeWW+DZML4+ygtLRlZqQ9ZaQ0OXzikY
 5hgsQusrofB5XIS5JXrF8hzVnrXfIAGnYzik5HDeQh4+Ud8MM8qxQ6ju/0Ps9dyDtmTa
 1x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789913793; x=1790518593;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bDGDgGxhwGbuxJdr2gksQc4btmbuNW1E00/nWJ/qnz4=;
 b=l0HvAvpJiF6UpN92vbI9rX6Vh6X+MVHiyeULpuXsjGjUzaTZJcDHAgw5AH8V3Sjqqg
 kgFoFbSC5QjsqvyjZccv5RVdaPDpjs8XmC2HDodxb356ns+dYRYZtlNtHJSH0gUv9R6M
 /j5yKMtWkUqEMQCxKp2IDNL89pPUMsaDqfqmkftixO2/2xoenXLznNbJ1NY94WS4BEmv
 cdSg9Nf+vOh1j3+035TMXbFxWfLlWW+ynvrG1FpRcz84cjBl+NvCTY7WKX9G5hMNr+mV
 diMH2xh6j9VDRs3Lseioa2ItY0tqVSY6JZENWRJLtzrwKeApGKzgjRn2I4Hmge3oqNHi
 PhJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAmc8R2nar395HvcryQr65G1CcajZIimVJvP9ecRMEMxLJYNkSSi/IXwwyo/YNlhqQ+vfJZd8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kpIsjauTqcCyoOnD7lSZX8DhT/TB7/J5sbIkUIX5KrSWA99IaL
 5cB43ExNq34gWioCfe4/rf7I7D6amZ2X8n1ydvMWeIuCsej7TeejQqMH
X-Gm-Gg: AYBFou33iqgRVYM6hlMpWTCA7QW6w05MisbJcR25joAMizif5aopW2bmWNhr4qx6Pf/
 vKlANeCw4x29iBbDY61jTaGlvcLmD6gvoHZJgvGLX+N3HYaCW31smxQhGc7wLD24L0spvVONNLW
 Z8NWoMP9rSlImzEs83CAipY4eG5mPXTNh4vODvp3gyBOao0GwGgDeWMTeGDe5c0n4OqdKymgJAl
 kKlzdrsT8DlpqGpEuKvsoB2Kg0Ed9k5O5visO29/+TgYNg7S+gdhOQBlNsu4r0D1E+KNHMWsJPe
 xqia8EiyL9hA9K4GfJ+Y+rQcjqswnJ+75mINrz6I50BmaH2Z+RTpW8PvJWflUpTs3oiDl48yIEl
 O4/wnUzJS6YcHCNtSsB2Ml9z/uRyD6HoFj56cWAyyMwB8hm1lYjlpurjEmzL3Fq8ILIjPmQrACw
 htxhF6u+ug+0kJMom1u/duhLWW4eHNZzxBPndnjDaeaunI0wtRNSQ935hiuVkdFbfgFG/QcJgq8
 qb8a5Cr
X-Received: by 2002:a05:600c:198b:b0:49c:fc6e:8cbd with SMTP id
 5b1f17b1804b1-49fc574f05dmr120633885e9.33.1789913792740; 
 Sun, 20 Sep 2026 07:16:32 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.151.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm184107005e9.3.2026.09.20.07.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:16:32 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 20 Sep 2026 16:15:52 +0200
Subject: [PATCH RFC 08/11] arm: rockchip: print reset cause only when available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-reset-v1-8-42820216369f@gmail.com>
References: <20260920-reset-v1-0-42820216369f@gmail.com>
In-Reply-To: <20260920-reset-v1-0-42820216369f@gmail.com>
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Levin Du <djw@t-chip.com.cn>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Alexey Charkov <alchark@flipper.net>, Fabio Estevam <festevam@nabladev.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Chris Morgan <macromorgan@hotmail.com>, 
 Coia Prant <coiaprant@gmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>, Andy Yan <andyshrk@163.com>, 
 Liangbin Lian <jjm2473@gmail.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Tianling Shen <cnsztl@gmail.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jiehui He <jiehui.he@foxmail.com>, 
 John Clark <inindev@gmail.com>, Sebastian Kropatsch <seb-dev@mail.de>, 
 Jagan Teki <jagan@edgeble.ai>, Ilya Katsnelson <me@0upti.me>, 
 Niu Zhihong <zhihong@nzhnb.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Akash Gajjar <gajjar04akash@gmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Eugen Hristev <ehristev@kernel.org>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, 
 Martin Herren <sputnik@on-the-web.ch>, Torsten Duwe <duwe@lst.de>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:49:13 +0000
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

Do not print the useless "Reset cause: <NULL>" line when reset cause is
unavailable due to missing overriding implementation or error. On the
other hand, I always feel uncomfortable for providing - knowingly - a
NULL pointer as printf() argument for a '%s' conversion specifier.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-rockchip/cpu-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 823a2c6b89d..79ea3e17185 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -55,7 +55,8 @@ int print_cpuinfo(void)
 	if (rockchip_print_soc())
 		printf("SoC: Rockchip %s\n", CONFIG_SYS_SOC);
 
-	printf("Reset cause: %s\n", cause);
+	if (cause)
+		printf("Reset cause: %s\n", cause);
 
 	/**
 	 * reset_reason env is used by rk3288, due to special use case

-- 
2.34.1

