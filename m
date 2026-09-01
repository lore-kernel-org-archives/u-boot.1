Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7CFC624D3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 17:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AF7A40754;
	Tue,  1 Sep 2026 17:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wxBWz4hwGyHz; Tue,  1 Sep 2026 17:09:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788282585;
	bh=cWDW4ou5ukSTQEx/TRMHbtmjvGiOxYjc6aVG0YmFKhk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kftb0gdWdG9dkCUMfDY6FADUgSAZpg9eQijgjAN2ZwfpTupvkjAL/PshnC0zYObB/
	 pMaSI/Dnz/aaxD06s6erg/sSAfQvrjBUNgTtvRmmgl7KNQiYf0Kqe1k0bCOdJUd48M
	 RR7jYGzXPj6XY7iMM3xB0HUlQJIfkx3vT1HzWtrjTrO9qe1/LPI5KYidzOl3ks0TAN
	 wRiKFQ7nB3fZSwjLRAJnLM+vcKkK4yPQUKFwej2jjP9GWNzgnN6Rg+4nFYhfxxjQTY
	 6HOyJZvmZIrqcnuVcESWa+r/QWb0Ow5T6YeZXpsjE/sG6QXel+4ZQaa844p9cstUT3
	 HfiGTdGGiQlcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FD304073C;
	Tue,  1 Sep 2026 17:09:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DE33265
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00176401ED
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HnOe0i36czOj for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 17:09:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MTymjFA+
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 320704002B
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:41 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e9ecb1e13cso5140360a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788282580; x=1788887380;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cWDW4ou5ukSTQEx/TRMHbtmjvGiOxYjc6aVG0YmFKhk=;
 b=MTymjFA+oTKLc3wxx50NeEaxzmgrLwTXU7lO74v28ZxL12rw8LxL5Qdb26DU+MwUjq
 DaAtbCGAT2NoVfvX91y0Kfh6BePWRpO0VFy3hd6yhcrxl1Syi2yTV7niI+1OIq2ZNolA
 qBlhSlDadGhRXNiGZW/YyL+pJ0v9xg7CfBdBFwOHuSCB7vSX02KCcslSVyMXLEeqjH/E
 tEEUq3AbvD4qzhz6rqqr9bJDSkUSPY7VXJ4RHARXNlzidDjBDRz5gXHTvWUeI0sFJRt1
 JyAAmKGqOtoHmWYOd7P4gDNzpXmlXunw7kBA6QINqUeSReI9wWaVmBhzBJV01C46B656
 fh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282580; x=1788887380;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cWDW4ou5ukSTQEx/TRMHbtmjvGiOxYjc6aVG0YmFKhk=;
 b=i/6AX06UGlJpDMeoi6Ljvo+u9Usnn13glDT13zVtdn7IUGflYGYVtQj+ThVwiq4vmB
 x+vWrxU7vtvCQo4jkUOutD6clnGnnuZrBqr3xt1Nn6byFGbs8cFWiItxyY1elqNSqFi/
 5ek7KsnRJvx49q4BGRNb+RFWg/nEY+BqDQv7oDNH730Zq6kbBQaqPdyU4fwRNUDXy0B0
 rnlQGE7K7YZowQGAGfAKtTF2un1PFE7+YAVQjfOh9PpOwygHPGUTihsP5Au3Dn11VOnk
 a6M3oqPKJmZy2GHZrjhtvWNxrXx1tzMQhNyWqfyUNr1tGyQPKavQ4og7KGbtpT97l7qH
 XBnw==
X-Gm-Message-State: AFuF++nAG1DfDpIqV4e5yG1xLT/6IjBXsD+IAjaoxhdL+0Da1UvcbJ+R
 qqqr/7EjMbOwQ5hKq1HwsThipGTMbPk+gZVuCf9Rv8rXGbgAJq6JYgdc
X-Gm-Gg: AR+sD10aq0JlPz0IHa+28JTfBqOoPJepl45uaeg8HgsfBV9o+mWNrldOVUxQCpdcpQx
 9fL29hDa9URtK9qImPglrdN51p1feuSl0+9Jz/pBnGfD0USoXKJmZSMLxEHUg385KlGdBRpnqFw
 UxecCz2daAq9urza2xG1BIdQjjKWAiaGfoiubvCT7jip6Ylt6hikD3uGaFMKHf5Wi+XpIMDYnax
 d9aaTSrEgVNsjMjFlY4MR2Gd6GsdOi+b6XBiBz0PM2K1VmN/rORmifG37rC75AIKpXlijM1JMBl
 HDayMbOSXKgSMaYrylqqsviVjR6EvmNhu57DanNwQ+sNlShbOHdHtcOWC2y1DzWBrdZVlD+rETo
 y0SheE3pc2TKh6X5ew9KB+KMkhBHADYfjCvIfsDdaAxYRJBQbCUBVawmNxaM8fmQ69tsfUpBDle
 W0UrlZNlrG0K4mboXjVQDX1phOLlB1t5WZ5+IOpqPt+s9E47FRnWrHEg70zIAUDUvwigwL+EP3c
 ZOYIYsRmHUICcfVt6p7HsnjxQzKCXNMdyaH2jgxyD1diRBP9k1mCNXFSTaWOS+Avn+TXrLrx1rj
 nYOW8+HdrWuGFY4uhdVzVJe0+eZ2BGZg8tLca2eIeZk/y2v+3A2fcabuADDJmbeewYZP2fPa0jA
 dIQz/MZa4CgD8Hx/9Lxo=
X-Received: by 2002:a05:6830:f8c:b0:7f4:bba7:f547 with SMTP id
 46e09a7af769-7f4f258280fmr39762636a34.10.1788282580257; 
 Tue, 01 Sep 2026 10:09:40 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99d927sm10892218a34.19.2026.09.01.10.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:09:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 01 Sep 2026 11:08:55 -0600
Subject: [PATCH v2 01/10] net: lwip: return ERR_ABRT after aborting wget
 receive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-submit-lwip-runtime-netconsole-v1-v2-1-3e3d95627cf9@gmail.com>
References: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
In-Reply-To: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>
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

