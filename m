Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D660AC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A2236064E;
	Mon, 20 Jul 2026 08:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8WGxrGBqpXuY; Mon, 20 Jul 2026 08:23:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF9646064C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784535821;
	bh=Y/AtmA9/dAGsu2lQ/eOZ2tsd2QJUU7eAcWiLmV6F7oM=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=r1//rPeVh4hX28TZbAtFgKT3j9Kwh3gnrUCrQApnnHdUCEAbuMauolSpG6J6qpZrS
	 tZzfPUkpxH5QNJNQ/LcO/6Xrupdm9CTTvLn1ewj79MFAkEgyGIWaNiiShnXuZDAToC
	 +uXm4LfavF7uZk4vXOccR2xDjNONZDV3JgG1JsffvvpFDBkq0fv4Dtvhx3RooQGJio
	 VbxgVuI4/tvwWHeUBlvoKR3eF9Gvj58pD/lyyM/zYYpgcP6PR00dTfPoFD2kAIvm9J
	 4dXgGtXUlCdM/nNrHGVeLmVtgASXTQFa7Bz9/1G0nGf/3BnsDgPQU34lovJdUDPQaQ
	 qQnwL7Nr6sxYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF9646064C;
	Mon, 20 Jul 2026 08:23:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AF551282
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9531780BC4
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:23:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dtLAMOrYzrfn for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 08:23:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8463A80A88
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8463A80A88
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8463A80A88
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:23:38 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso16953585e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 01:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535816; x=1785140616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y/AtmA9/dAGsu2lQ/eOZ2tsd2QJUU7eAcWiLmV6F7oM=;
 b=DYKz5QqxcOXEiDdKxw+cN5bMeC0HTy0zvuKgdWZMsCfSOv86+VRG1fm6WfHc8z2wIs
 ThyyxuaJTFwqPtaz/N5uDrdPE4YjCkBC8DcZ7GY7kkV9SS8QfBXxPociOSix9/1g82z4
 CrlY4xN+5d2XL56C0uBzQV/Cm5bw5DcpixHC7hS5OgxzzI8QXgB9AQN55WRxHd2DDp/t
 5oZWquTttBfKoPUz5ydqdrQddaNqrdRwPiTorWR6fH2EypoquCrTZcNKkH4w729ZlNGX
 dTOcf1/8TOhTl5xv40lUiAfJfOwbSyc05VEI3Yttw3NJCM2qfD/5IJiuxKlDni+m+ZdE
 kWCw==
X-Gm-Message-State: AOJu0Ywxu8z6g0PsJkB0vvOkNscVp3saZqEnOcpMJhVMSy3OGVtcWHv5
 kGcw1dGCw0lGHQCtS5vZswgLzPDmNLh8/3eqnlYj31MATIBj2WrEpaV4jtQaYN1EJrU=
X-Gm-Gg: AfdE7ck85pQ3AJkabt7Prn9mYGKn+dyCTKcMExMwqf6fLKBhlH+oZGass2lWDpheW3B
 Pg0ssaOKj0DEkLmhSE7Sy7edqEl1nRLVrvf2ydDudx2z/bQ42ginTHcaNOcIZ+NeL+uXO3spqvG
 kVQsUiQDRFiS3KZxSckXz9IY3xCaUzgdLykT9ZcxmMUZL16aZGgybizsi3Y2uPBW4V8rAPOK4g7
 R8NfoidlrJ6atx1aT2vebi+Z3ZtXyvVPMIzp9oKEtmA2Rs3r+2o41jPlahZ5JYrZQD2/bNoW1OB
 11XOX44boxm2+fezS85tbfYXAv17auUUw6WOXqm8vNJnPnXbCTN5t5+5WBhUuJPwin3VIjfu0rm
 wVnZSz9W1jZDrM2xS12Z75jLJFSOZYXiax7krgJ1dlxG4YyDDHfsdy6yDXzKsfVATqAw81AOoFm
 kkWyDBYKDMaZIPxAeaYPAzP3zSpFV1LNWm5A==
X-Received: by 2002:a05:600c:1554:b0:493:a570:df7d with SMTP id
 5b1f17b1804b1-4954a402f91mr154240595e9.20.1784535816290; 
 Mon, 20 Jul 2026 01:23:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c9c940sm242852495e9.13.2026.07.20.01.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:23:35 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:23:29 +0200
Subject: [PATCH v4 1/3] tools/patman: Migrate mailing-list to
 lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260720-osuosl-ml-switch-v4-1-20ec1c334dd2@linaro.org>
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
In-Reply-To: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Heiko Stuebner <heiko@sntech.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=864;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jMqFFJna27R0nJL2DrUFja+iHMOb/f1mP6bOhHnQcDs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqXdsEAI9UA9Q8DWhGY+PzEFOoQ6AXoeBqHC7DxQii
 LTa5DueJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCal3bBAAKCRB33NvayMhJ0RYDD/
 wPpkooLrn/wRK6AyszxTSUrwaokq+Qs89NtY1BBgpa1Bthyha3RKIG2AVGsak38Wy/tTYrZZGwBgDO
 30A5wANThnU0Nx2TnK4cSTAHdQiiIizBh5Wfc7BLZy7SmKL3PGd+zgeErS6yBIPJmOxGwlbmRAwY7b
 yYFDN+SCVB+0dISNiqaoBoAY6xfiqqiny18EBSRpHUUj3Nu4JPBzeq16JKgYlsZ4na9xJ1QxkQLVMx
 KV0rBqvekpv1f6OUI4SUM8TGrhohDyXBCnTBqaY0bFIXNzV2NnEntsUC8+DmrmVqrcTm6ndeRMDcHS
 FReKC9vjOYF84HS+FUCPk2fW3RacuJQEMJLMCq3Kk8q4hceMwNIdreMSlXspJ+/uBX35VY+PF7srkq
 vFclqYEc0MwPST55OdliqKhM6nM1sxHU49Oe/OZwhxJEeK/RdtkSFqZNkKyMDX+xY9IFu6sJtKJijQ
 sTjl1Oo2FF76B1ncFmPSRNJ0EA0wLDN0KDjGq9MwqSeaon4U8zv1XVq34VPekubovznpJV9yfROhTb
 a/FKcyd/wSbaqKtPHaWvsQ9VBJnZQVGGNt7YVkO+I6TJUz8l9bEihoE+a0dJDQY70w9xGFb9KLlpNG
 Lm4Ve/3rBGaTai8+9CjmphQOgUNaLVDrRM93pj71yFPUhSGnSkgHstxBOlyQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784535816; x=1785140616;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y/AtmA9/dAGsu2lQ/eOZ2tsd2QJUU7eAcWiLmV6F7oM=;
 b=cB/u4OB5wHQ7PAB47nbyGZx3NdlpdpiPDjlIsDn3HP9qj9Z6BB9Q8vuEAUkQHKga6l
 emFoG0xsafo1j22UwsL/13eg57lnXQZr5WCzMeIYLDyo9Fh1KjH0IOkc4+6abqIKIuf0
 2xOuI4eP2EB60tC4Si4zCCwzC9ahFxhtboOkE3oScCzxRXJUumi3f/zuROrTQMpgE4jX
 bulxVUko71iQ7S6rFnFRDx1AxqU1XEB8Ext7UtTZs2N3/WSvQX7CI53cRcPVcyyhLD2H
 W5q4lDrNM0IkI6JIJdLqA/4pUu0UHSjet+9mr8I5P7Hk5vdYgOnxqkq85SkR0PzQ/5UY
 n6FQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cB/u4OB5
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
From: Neil Armstrong via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>
Message-ID: <20260720082329.v3peotOVngDohLc6oElIttWGnlUiIKM8ZL8Hl9OBJ1k@z>

The U-Boot Mailing-list is moving to the lists.u-boot-project.org
domain, so update all references of the list.denx.de to the new
domain in the patman code.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 tools/patman/settings.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/patman/settings.py b/tools/patman/settings.py
index 17229e0d823..fe65b1d3fb7 100644
--- a/tools/patman/settings.py
+++ b/tools/patman/settings.py
@@ -162,7 +162,7 @@ class _ProjectConfigParser(ConfigParser.ConfigParser):
 def ReadGitAliases(fname):
     """Read a git alias file. This is in the form used by git:
 
-    alias uboot  u-boot@lists.denx.de
+    alias uboot  u-boot@lists.u-boot-project.org
     alias wd     Wolfgang Denk <wd@denx.de>
 
     Args:

-- 
2.34.1

