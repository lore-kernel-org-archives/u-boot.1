Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A020C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 05:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06C3A80B49;
	Wed, 26 Aug 2026 05:30:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vg-N5g3bVnX2; Wed, 26 Aug 2026 05:30:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787722225;
	bh=cWDW4ou5ukSTQEx/TRMHbtmjvGiOxYjc6aVG0YmFKhk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bHXIfh3AoAZxsjQbL3qa3/S/H1bwv842595O0KjM2MIWFSnsuneG4NAvQ5DU7ZXCx
	 XnaLTV4jS70XJIgg+GdF9CW9bUutgH/VgI6LkQUosF3jmQHwwl+wklTr3Kom/h5k9D
	 432LMmEA0JfFxhj3Mcx07QjmL7bvQauj15Hin3OCE6ign6wKa+fPYON2KnwPyKB8Ch
	 MG4Y7yIY7H3wMdwKrf0jCSJ3XyMEejX05QPaRlryztwwhYc5ZL0TNDx9j4OxlUu4Tp
	 REQRETDR3OXoW4fZxtzZUHoyiTG87wqDjMqZYINmhWvGLcJ3hp2eO/4PBNScLxbdcl
	 +YhN07qTWHqPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB18D80AE7;
	Wed, 26 Aug 2026 05:30:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 726593C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6462B605F9
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H7NeFzkjMzhz for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 05:30:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dVb/V0O/
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B08D3605F7
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:22 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso346200fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787722221; x=1788327021;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cWDW4ou5ukSTQEx/TRMHbtmjvGiOxYjc6aVG0YmFKhk=;
 b=dVb/V0O/uUG8+JmldEM2+ZlaiP+Vlmo1IdvskbNOvJoEiUc56EcEti+qR9iwOKUFvD
 Do8jqrJAGj4Llr6xt+WP/qspN6yOiHPOLx9cvjaYgYg1tXwdDs7M/gypRkL/+Kfp+I/U
 h9cYYSS3WIfeZXalYX9b44IMx3ETqJAt1tVwQr2iiY9BTxD0Sw7isTVw6w7pv2C1c7h0
 KS9R1SrQn+C5I7Va/N/pj/IJ+YhunHxWpk/13GnO/QjHkYG2Af+5tuBxWeiHYiNbC5n5
 uy4oBoZfaXIOAoMMBdeZKW+RVn53ZMNbcl5T3o9HgcaHPYqjRbz+R/dvDQfBss1WCP+8
 SYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787722221; x=1788327021;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cWDW4ou5ukSTQEx/TRMHbtmjvGiOxYjc6aVG0YmFKhk=;
 b=dTDHKYL1q0WcNwuXdgm9KnXj2tQX/X9YaV3YIBBfFU+R100/VQXEF5mBG75xS6aG0F
 GsXyCKskTfShKmuNWVSim/5zxLtu3Nmdrxgw0/2SjLhpjLM0ZrDNbAqd+UEWKmU/ss/G
 0XhLAX24f0GWneXOfZRLIRk5ARLidRKCtgSCkI331K5mZYU6Avat5zxdcO7n1eUrmLWz
 vHVilNFkJSkKx7fM3QJ8vgtfQ5L4RLYXc7+OZQlyRsslXseeEbYXj+EM+lSq7QxHl/3l
 I796HfZj9AnC0law/EVmKP9RvkZaoPWACbUG621n3x/qOEx+T7ogH2d/ZkpUPKBS15WW
 nVrQ==
X-Gm-Message-State: AFuF++lXvL5pU3XCC/CoBs4ivQ5eL/7l149D5hh5dGqb+OrBzVf9N6UF
 5U1ZWFfsgigAb68PRa9A2Qys2eJyZxfQVRTMVM9inPw76+/jCIybVR8K
X-Gm-Gg: AR+sD10T4TNlcNOq6K79AAu2dn5aXhAFYZjORbGnGIm33YLnHeVrr0bpt2gqBzOLnsq
 2Uii+0dvI1Unl+vxmXpRVV7bUNKuC7x8KFt+k8TbH1obvWvPaZyb8KQB2gXbhwhlrr3J28+BsKR
 gtN+lFQuZ0QXBOiW6SaIZQasxQ4wq13X7GEltL0BMdUs1bBEFof3+qtb4Ei/KZIV1kcbdTbhaYR
 OSCWeSz5m8C0W6gqxhqz7P1jH9IMybVEQ3N9dZxAVJ0auEG4H8YQ0QQsWvyy3QEOnDV97AinW+C
 sID4ImfgCisaNCWrMThvIHwPsL8b9avojTsF2dyqpLDynW3KSYgiaRq16GHI2SJiSH4cMjq5y+d
 fEPtBFyUTgZwNPTzWatnzoWAv27S6e2Eox0t9TkffVkCzEl2uVcxvO9/T5+4Xmc567JB4oz9wpJ
 ewNHsOD3kKH85gGtZCLqKFDFG9SwS2kLUqbr7bXWqYo/779NEdvq04quqsnLxtKXvdukFuphYSB
 Z248FHIeSDkLkByE2z4bibI7SghGapLUPIegbtHjuW04yyTxf5009tVCDXIZzlsGbvQJqXvzjj0
 cIWPcF026DlDQllhecvtS/Of7jN2aB498YJmTe9tp932QfhFIiJ5UeBpfv7oM/bphvkFPuSYXlN
 zluzRTYRGe22UzA==
X-Received: by 2002:a05:6870:148c:b0:45e:d529:40cc with SMTP id
 586e51a60fabf-4659b6add19mr5182402fac.18.1787722221253; 
 Tue, 25 Aug 2026 22:30:21 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465b0243574sm1346401fac.15.2026.08.25.22.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 22:30:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 25 Aug 2026 23:29:40 -0600
Subject: [PATCH 01/10] net: lwip: return ERR_ABRT after aborting wget receive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-submit-lwip-runtime-netconsole-v1-v1-1-0892966aa758@gmail.com>
References: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
In-Reply-To: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>
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

altcp_abort() deallocates the connection PCB. A raw TCP receive callback
which calls it must return ERR_ABRT so the TCP input path does not access
the released PCB.

The wget receive callback instead returns ERR_BUF when storing received
data fails. Return ERR_ABRT after aborting the connection.

Fixes: e40c910e88a9 ("net-lwip: wget: add LMB and buffer checks")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/lwip/wget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 247ece18e2b..e8930da410b 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -206,7 +206,7 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
 	for (buf = pbuf; buf; buf = buf->next) {
 		if (store_block(ctx, buf->payload, buf->len) < 0) {
 			altcp_abort(pcb);
-			ret = ERR_BUF;
+			ret = ERR_ABRT;
 			goto out;
 		}
 	}

-- 
2.53.0

