Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85457C624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4982340AC8;
	Sat,  5 Sep 2026 09:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YWfzpoKTksnH; Sat,  5 Sep 2026 09:14:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 449C840A85
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599691;
	b=oXB15Nu6gKu5ytp5EzTS+Wac+VuhE24csc4tboQirBcIbFx1AKpQn9j/EV8JJdZ4WRzG
	 sgnbiFnv5pAOnpKKq9HN3fXKjIcL+SEDTm7J2/2+PnaxBxm+xWAmeMkF7yVjBl7LHMGBl
	 j0485GIGGwsvZkZh0xQBEnrRwqYs2ThT8RTeb+ALBGuulLvVWT87jN97mMiOGUaTSPIs6
	 SlU8ZpQm7W/PPiwvTQy4QDc2fmKWqPDLymCasLbjc9rRr86BSW/dgRxcrmqQjuFmfkbGr
	 3r6gpJaSa/SHeJkJKTKdc5UedZ18tM281daZfZ6X0WQtwHnr0s40u3T/lqvIZy6Et1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599691;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tzgrJk5Y7gKVddrLGm5lxAUqFBwGwO6BSzvfQeA+Oas=;
	b=EIJTUUy2oJAlcJvPj66rkXmdf9FiIC3NMC+ghik22aa44h1fEa/+pslb1f5x75jYzCmj
	 9GoSBBJt6rJG19CR0B7y3n77kZDDHgUxzyGnMsLNi21VYMnwMGy9eCYdejWEmVyT70DDC
	 KJHljMBYyQhU7fhFlnDXzPRIRwpwxbaafF0AiuwLj99sNBSIXFKOkwTjSW8oo9bPiDvp1
	 Qtr4MxKJZvXDsC5wTqbU1ZWQX+VLSuW95flvANW8ZVuXmssLd8vWkvqBzgsJGCxohAsYO
	 uERCBB8dIOKeYg8o0+TnMJPaClVm1YZdsV4fJ3bse43cxSSNXTLy+4JZAYSnafVtr9A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599691;
	bh=tzgrJk5Y7gKVddrLGm5lxAUqFBwGwO6BSzvfQeA+Oas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dQl5T3gxO8C24twOqd1XJyVcxEfJBRy2ijQKm3y7ZYmlVed6UmVf0A6KRKeq1ZACL
	 fkKvNBA99h+vqcttVYOvSvwrHfpVCzII6T9IScyrpxmJJRASpuzrpCLj6WtaBWxtj0
	 3n5QwOuj5bFW54WhRcu8uZmsO/qx39doP3TAeECiTmHHCOawa88wXurEcO2M0rIUJR
	 qotmn5TlST1NVWdikWiATogLlTkjafiJm+U+cwpRM1G+SP+BdblKjWo+5HodDshtvU
	 3CVbjX3931dwwlidw0pfRg2OXx6RpheNvSAcJQ9k9Q9gLrC8OQgj8A2w08uVIeaYnk
	 WzLejPMNh2HLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 449C840A85;
	Sat,  5 Sep 2026 09:14:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C0B53136A
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6C4040073
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nzYfHUZBCO1q for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:14:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E49CA40051
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599690;
 b=JugR+qp0zpS3p5xp4zrua6+IJ4ryXpq3hJHmuk9ACRknzgh/pQ7riwI7LDrtC9sSJheu
 nZU2TM0ZL3TRB38TkqX510kfy9Y6iLlnVt8OFm1cV+eXGC2tPUe+yAqKN3DsYoIBDyQCh
 dbsRdGfvph31WS7vU+ZuivO5arrKdsI9S+RrGDqak6naUeHtHCFgFUr721gg3pQIGcWFw
 ToE2JNQBmO3qwKSBQwNYnq6vqKvQZGpATDhhzTlN0q7PvEOv4WE6ji9MP3JBzGRX8p/VF
 Vre0KNQHQU9gJM6e+47EcQC32XTK1Lr6rrup96lBIQWFYK3qtG5VF35yuokB8JLvZxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599690;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=tzgrJk5Y7gKVddrLGm5lxAUqFBwGwO6BSzvfQeA+Oas=;
 b=atTQtrL2Ysofu87oyyRDmwOP81B5k6i4alNFaBt9H7cozwpoxmLf/Q5WO5y9U/yeTAZk
 Di/YnUg2uWLazJ/XTPHsNzZzLCEMoPti0jkpUKnVeqQRAqbM1D6NCgwArNF9mPVH1ANwv
 1ddnuYKMoJ5CLOQzwxz8y/YudUeba63hMMsUClzqnm6XL10i26bKuX9FIyUq6/x+gsLTW
 PNFsFA+OtZ2ex+77wB8TYvz2AOeg/mhRdzmpxLl1DnOANIY2GioFz/q9h4Z5MxQt89aQO
 uqGXjykcemlnHhGE1qwl3ZiwCS5b0wE5+JDH9WTcdbXyJjmX5XU7Lkfilj6UnRysfGg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=YXeIiBS6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=YXeIiBS6
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E49CA40051
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:49 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-381b831d535so2913899a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599689; x=1789204489;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tzgrJk5Y7gKVddrLGm5lxAUqFBwGwO6BSzvfQeA+Oas=;
 b=YXeIiBS62dpF4YtA/AcUYolan9ON+SZS5FihCPpRb1qFUSfeK1+eueAIhCpj2hEZHn
 YnOY1MORy4b4XXeBo9YZn8ZFKSIfcVpiLNSyHEnIzGh1223hVKlBpAT2bkqRBKiPdESS
 Kd9+IgYPNfJi2Tv4vd+ZLNWqk140zKXVDAwKu/4enA/0P3kcCdAbfTX4Ovz/PBLvEz60
 FqR99U3geIxpwrRtWNfWkPCCLQznjKiXEi0dy307tuQ/z9VzRrKWQ7RzZ1o/1ghspWT/
 liRH308n7SkmeITrt7q7BzhciZ4QU+11XQ3NuzhIVikGls/5jeG9ByZfA7MEiJ038jHq
 dsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599689; x=1789204489;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tzgrJk5Y7gKVddrLGm5lxAUqFBwGwO6BSzvfQeA+Oas=;
 b=D8fdjOU2obCDOpbz8njl3PEU1m8cFR2j5KwcEBiRum6kxC+BN2DWJ4bZeVV1PdnImF
 woWQqrda+tiab/8QDn0p4vjBI6aUgRPTYwxxWeOKA6GRHgDjLSfeguwY1IYHF7Tsb1Xr
 ogJdaf/OglUE48lH7B+58oNbL2d7e4of5MB2WJmkcqsmazfjsD03ncdfbYszvzESahsl
 XppQ3LuZtn8UQDtzUm6vNnsrgC0nThr8k77Satehb9ItmKkxg19dsSWIZwVtJ7+WBpUb
 HH8zVRVex80lKt6Z8BKFXIWyRnpPderepyioM5cd5ijrJhCPsLFE88wVKGAjL5dx3eQr
 W4Ng==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWwuiu1FfZqbONsfg05YmIiGRVgYZD7YyHFGmRXX9yr2XlJSxgJI0ANv+ICgV3vtlbskNcT1A=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kIW5DhF+tcKzSt91tacl43peJe1Dh8nVTQmbzYJ1OasBcnCqXY
 rIvKaFDjg6btK+sbeH9mRd6uhxJU8w7NHseE8QgBIebcyVqZ/CVz/lmo++/sEVZLqT8=
X-Gm-Gg: AYBFou0f6oVPwtfDXl6v38wJIAYREDENIswaBVsFZnz1//dfxpbizT6aH9JxNVOtqsy
 rN8WokiHt1Yu8ERxkD/ie5uB5e1waeHA/142oGbNQ7OSPJnkjRcpHc97GCF3cVrfSMYG/qrvfCa
 fudEdYd9Bv2x1nuZgPT06hEg2FGtPxh90KHe6F2s96kVgyKLEXaA3LCN9CjsQFi8KPW7gHGdSQd
 Qjoi12r9BLiF/Y/FJ3deXgzwnB9u5eTplzzOwmy/jWWrghqE//USf/H8k0tPkqiEx4uLDjHEV2w
 g1J06mGhlb7/tttTaWoXuN5EpdOwd76Zm+q9T+pmgO6BK7zX20IsychwcwGdZmA5bydSCioqHNy
 vWbzyaACWaIbB7UECmOIfzoASjfy/VFTFDbbqePIW/eEenKfpJ9VkC1hjFTtD9Q51l6PPG6R4zK
 beFiBDbfWVl2BCwNhii7wgrmrA5EGXNFW94t2mtxlPm76WeVMhU3QDm+Zm2WkN862cPwtYv3qAP
 vlaaJjHuG+GsOfVpOLj4klmPGw1QIHcWC7212Z9n7y4E+YQN30Rfj1Ou1wdDr68DHEiicNxd0te
 X5Ok9pMwxG/V84TKuv2XoQLZFQ==
X-Received: by 2002:a17:90b:3d48:b0:396:5f7f:52f5 with SMTP id
 98e67ed59e1d1-39b260e13e0mr16830292a91.3.1788599688647; 
 Sat, 05 Sep 2026 02:14:48 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:14:48 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:24 +0800
Subject: [PATCH v11 11/17] riscv: dts: spacemit: k1-musepi-pro: set default
 console baud rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-11-235eacd94fe0@riscstar.com>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
In-Reply-To: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
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

From: Andre Heider <a.heider@gmail.com>

Allow serial output with the same uboot/opensbi settings so the
console works without providing a cmdline.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Link: https://patch.msgid.link/20260513071958.29574-7-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: f125c6085fd775f09a316f61cc89a0ae86826895 ]

(cherry picked from commit 5a2fd40a11e3de8b4308b739971ab1dd4ed9ae5d)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index 898b537ba0bc..4aef287353ca 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -22,7 +22,7 @@
 	};
 
 	chosen {
-		stdout-path = "serial0";
+		stdout-path = "serial0:115200n8";
 	};
 
 	leds {

-- 
2.51.0

