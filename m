Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338EF606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jz8x8yFm;
	dkim=pass (2048-bit key, unprotected) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=B+IrEpnT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A16160AC1;
	Tue, 10 Nov 2026 23:32:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uJdcAjDuRJmF; Tue, 10 Nov 2026 23:32:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E2AA60AD1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794353560;
	b=e+iBg594zWBLzicdIen0p1d4pIWe5l74kxbrqMZZ4IzTmhJYAGv8ix2aCcDfONvzuePE
	 yneS+feAa99LOrYVVYX+98V0EptQ/zoT8cmrH6SQpdTmcO/nKskzmW/nLE3DTW9373kix
	 fCQF+UHYf2QTWRqLWi4dLe7lhJLviJQCpE1swab1iK+Qi5asC4oz+ti/6z+s4jSypK0Kx
	 d0w0NCqcz8L01/thciFIHwUZrGA6Qh06V5mlO22UWIWLaRMnE8utJhqP8iEeKls+6C8cT
	 bFi6HP5wdYLw/20TlebxwuBvZPPxTspr5658EZnk6qG19HP1HrgwUKvs2w0h1zVUYXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794353560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+Rbn7etzIi8EHxneJ+d2WpZUoCMBfTqbLzODVqLKTzE=;
	b=hmg26LX5462liFXpdP1kKk6YcAmGMUmMgY0WlHk4SvX2QVNDNj/mm1TKAqJ41B6lrNH+
	 U2wuMpe1lfffC0/dkPPR1cYY8F3Xsa/qEVtn25hcdTVvXKLBVsuMFdVX5s1VhZJBZYZmv
	 bQhB2nRibHIHqhZUpdG7X15EQ8yS0vFAnlvNvsWhYD9CBt8lfiBsb9d2hbgxyphp7SeKk
	 bTX8zVlxdqXOkQR5JYWkxypTLv1RDaJc5azMPLvHsT/zA3yf7HoSeJn+RvrL6Yb67COqf
	 z9zGysM11GUvLnirIHzNh4iyYwujuzbC88jCDLxvnNzH+dXLii9LZK/E8YiX/sL5k2g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=9elements.com;
	dkim=pass header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=B+IrEpnT;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794353560;
	bh=+Rbn7etzIi8EHxneJ+d2WpZUoCMBfTqbLzODVqLKTzE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jz8x8yFm/f1BNATaWuYQX9p1UsjghPnBogRaG8uMnI42a5tVl6aTpzOTE4Mjz7tQz
	 Jla72OmAdur0nYVo4sp1/73ZiX5h0pZf0bQEPoGn6n5J1Z2ZUDSZ7LNqeW0wgeVjUj
	 2hBrnzrajskVQiNAZwi+jpuLoDCVHjWP9kXdyw9/z1nVaPp/Jn+w0y8/S0J+mAKmqZ
	 JIhmsAWxCin5t/CEWqHTWVo8QF+6jwgT8MW3wW6Jp4hnpjohxhDkpnqW4cKNfy9MPT
	 /gNPjnRbO30OPlDsU5HMzuzU+PtlR92jFZzKk+a/ygpG/+L+/XeZ0p8vwEpGM3zg0q
	 VuM5pVtUw9JQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E2AA60AD1;
	Tue, 10 Nov 2026 23:32:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BE5F22FE
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 23:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3AD760ACC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 23:32:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FfD9PWyKJh6P for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 23:32:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0D2F160AC1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=B+IrEpnT
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D2F160AC1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 23:32:35 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so17693325e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1794353554; x=1794958354;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+Rbn7etzIi8EHxneJ+d2WpZUoCMBfTqbLzODVqLKTzE=;
 b=B+IrEpnTEzHOMxB8LVs57VWzloxOn94Km8vTyHjw2CcbScqqXLoZyA5FBdmPta/SSa
 R2vEhDb1PLajTeF36SdqIdmSFx5KhXEBMjTnetjQYaFBVKmB2NuzORgxprBVTgtQqTRS
 k0k6GV58ZILcUuC3gvwx8uM8vhU3775eUr8w6AOZcYhsENSE/5GMvBEWbH8/ocn/IRTw
 lGAgBnvZVutQrrqSDoG//b6wR4Eeb4pW1JUMeT57xmmk4w1c4YVhCpRjGptmh83xgmOM
 RGzKYbO+SZdI0nOwRcnSdNK0JyXVpHCTcH0RFJ/9+C+HU2CEFnFUgE9+GmwWLsyXDwBa
 +1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794353554; x=1794958354;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+Rbn7etzIi8EHxneJ+d2WpZUoCMBfTqbLzODVqLKTzE=;
 b=XITXjJhCpb1owI7xwdJMm/3Ur85qxjql4FV7mMMpuT73/JHETwAyLWaYyGGAbV9Iiv
 JrYzY+ByftQ1977Px7pqKE5nh0xMoa4scukp5V3IxrRMqXW27n/9utHwNObK6lMDzdsj
 HlvE8iI+LciPO06j3+z91A75IhsM6Vwgmp98eCFwOG/y+XVebf4jOpk7ar2h8zxTCHBR
 qsEtI3x2QRLIY2GsYT4mUhovJYA/alQqhrulQBR3DWPJspVnX3PhNvKwy+VTDn1+aOAf
 DtI/87hhpsGy2ZuHxm453FM2GEgvkOoxKHADsyhzhY46go6NGi8t9Xkt0iMH213Ml8cs
 pvrg==
X-Forwarded-Encrypted: i=1;
 AL+hErFyx4/FxrCPDVTX6sdD+N82u6p/s4xn3OoBa3hYsFmW215jxIpqCu2XTntz7veMT8Gs/QMR7UA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+D7L5rp90Zbys1k/nrKqeNZpjnAk0dA4YzI+1UidWKN/s+0Nbd
 XUaDObyoOYzsvDYDlUgsfSZ4qIjobFvwEYOSFvuwXvIOpEVjZzWtVSEmbqb752rG5BQ=
X-Gm-Gg: AYBFou39OtD5MMHY+eqeMrBnT2o0Qp5EySKrleok8xSj3D2DQvwC6OLCrULWy59AVho
 79zGZyssKvtzweBBfMEcdvPwcFdUHHWRBVv/jiljGemMBR1mS3hgfvGvW0UlLhBt/xtLTSdjSWm
 WCoypDTnxfan1YPsgP1kS1j94m3jPpI9KGW3iI16B0Z3rMn/8QhGO62cpoyNrW6eDKicDoaaRyM
 G0QvAKH8PFP8SdEHQVlQ6gExs1v8yEVzDQh1Pl3WDACHKwRyGN/TY9rsa0IU+eUO94HYhL8WNvm
 iEd+yPRVUCsg1eayCvjvBsRWqR3JXGM7yalBGL5EDoV74qL6H/uP6McLiD7Zc+4GitoqzWRJH0y
 BATw1J7fCeNZxUNrZAF0Hj5AGBoX0Ev6UIrw+eaL1P/G2FjBZGBSuO/yUAxLeKQYUTCsWEWtD+p
 2na202a2NVOoE2U9Ggupdp6uqhAP7Ar+49y99Eyz/ugsjffD3Ms+AoqgzeSTEUde9Ya7mRZMa+e
 oReIXJdFpH+Zg54zWHidkSG95+GpYu6FcOqLvX5Rv7zUUCxIdJ4UdVpcKPS/sebn9oPACAzlSLA
 oHwC9YHrBTA2E0pijRA3gARlq4yyLgHIILvx4d2f2TE+BZLyjjduXdEH7K1ugXpV5KECIesGH1J
 +bzvN424uclpYpJkWVg9LbBcbNkja1CwQ2qc=
X-Received: by 2002:a05:600c:4f15:b0:4a2:190f:cf6a with SMTP id
 5b1f17b1804b1-4ba093d4aacmr9595785e9.35.1794353553818; 
 Tue, 10 Nov 2026 15:32:33 -0800 (PST)
Received: from white-mocha.local
 (p200300e66714e500bfe47b00fa11e276.dip0.t-ipconnect.de.
 [2003:e6:6714:e500:bfe4:7b00:fa11:e276])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe2f09sm107519495e9.4.2026.11.10.15.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 15:32:33 -0800 (PST)
From: Tan Siewert <tan.siewert@9elements.com>
Date: Wed, 11 Nov 2026 00:32:22 +0100
Subject: [PATCH] clk: ast2700: Bind the SCU child nodes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-ast2700-clk-scu-v1-1-4e6c71b1cb0e@9elements.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZOS+QFmxxryI7zDSb0TGl2UQoe
 3erO36H/y9gklUMuqZAlreaPpcK1zbAt2GZBDVVgycfnHOEg60+EiHPDzTecAxEgTnFczxBrV5
 ZRv38j5f+sG3Xu/D628C+fwEo0jbucwAAAA==
X-Change-ID: 20261110-ast2700-clk-scu-f6006ccd7975
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>, 
 Pedro Maione <pedro.maione@9elements.com>, 
 Tan Siewert <tan.siewert@9elements.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794353545; l=1282;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=aBuJSMVKwa4Ojojqe3j116xu9pW0/PHDG6MOhe4gzbg=;
 b=loxnO4s+XQRu0VmhDxYapRMLLgnvoymODnQT3EV0VD6rRkWIZHSxH2mRmLsbaWGuMEz4W5ow4
 K3riiEJkBLJB98nvDyCXtzqCx/vdQ1L2ZBk2RyDXMre8XeaZvpMuCh7
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
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

From: Pedro Maione <pedro.maione@9elements.com>

The SCU nodes are bound by the clock driver, which matches their first
compatible. Their pinctrl@400 children are never scanned, so the SoC0
and SoC1 pinctrl drivers never bind, and a pinctrl-0 reference to a
state under them fails silently at probe.

Scan the children from the clock driver bind, as the generic syscon
driver would.

Signed-off-by: Pedro Maione <pedro.maione@9elements.com>
Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
---
 drivers/clk/aspeed/clk_ast2700.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/aspeed/clk_ast2700.c b/drivers/clk/aspeed/clk_ast2700.c
index ca76abef48f..30487c592fa 100644
--- a/drivers/clk/aspeed/clk_ast2700.c
+++ b/drivers/clk/aspeed/clk_ast2700.c
@@ -918,6 +918,11 @@ static int ast2700_clk_bind(struct udevice *dev)
 			debug("Warning: failed to bind reset controller: ret = %d\n", ret);
 	}
 
+	/* The SCU node is bound as a clock device, so bind its pinctrl child */
+	ret = dm_scan_fdt_dev(dev);
+	if (ret)
+		debug("Warning: failed to bind SCU children: ret = %d\n", ret);
+
 	return 0;
 }
 

---
base-commit: 8c1ea2aa66386fa3c8ea829531f581847814a569
change-id: 20261110-ast2700-clk-scu-f6006ccd7975

Best regards,
--  
Tan Siewert <tan.siewert@9elements.com>

