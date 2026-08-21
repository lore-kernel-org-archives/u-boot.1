Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87E5C5DF94
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF00F40F1F;
	Fri, 21 Aug 2026 13:16:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P8RTZDzsso6G; Fri, 21 Aug 2026 13:16:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318165;
	bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n8c/R0vl2CsnrMuDjqRZkRSnlEq7UxGwdwkR3DoREdEdSF1qYK64gTxGF+M62CGXT
	 C0eXxag4Ij5VlGXqnTO9U4LQwTSrgtEx/3owZA58x7d9Qp6U32o8VFSXKMX+GY9RIr
	 mi8WvEja/iifHlre69xhSvZM7Z1j86HSTdxHd7hTKF7UsowZlaqQkIwXxsDIrm3qYn
	 UfNOIPueCFmO/ts3+2FlE9C5ea5X55FmI0uJLiJQCUgpQSF9Ej3Yq5obXRGum4A4+3
	 YfLzODKf6AQSNtWtxpueNk2fH935/AEnma1u+Vzgs9VpXrvxME30d0M0f7cL39Cd0X
	 s/HjNdUeE4byg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0287040E2C;
	Fri, 21 Aug 2026 13:16:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CB5FEEA3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C805F40073
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gj5eE-fkbTWF for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=dZhvctVc
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0761040071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:46 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a1541ea780so146651a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302365; x=1787907165;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
 b=dZhvctVcVx881fVfNS5STXiYuOfEbx4nEA+XRuXK0AgPukxCerdIuNDHHkhihVKEcl
 7a2ywk14DyFKSqBxFd1KD3ihhnCPyuPuSXUAPJe21wIBTM6inLtfYxPwj2nU/RH0Numu
 RqHMIUpl3AshFEcbTrSipwF4ndi3YEKSiMvinDYv0ylOXkeJkjBWiylgpfNEW61wRe/0
 ZGS344McrgJ4vE5vmFADHcYZi2W7AnNQvMUFPNmUzzST6YczClmJdQwJgDcMQSHj6JF5
 vX7L4uQqvxiZ8ur0QuD5noYfc971TDfIpiGJj7Ucn3LO3EyqPzpMJUOc2+haBSVUfCp+
 cAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302365; x=1787907165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
 b=bRjAJkQB29hnwyGDiGsQFZ7ouCJGa24rfRG2eQJUZINFUoBLT27lg9xgYi6r33mSQJ
 b04Mk670cU/+TonAja2UnM6teMXHLLocHVgxYxh2xBo3v9v7f2HJgHlhEWrDS7TusLOU
 Cjqv8UMaU7Gpkb5++yXSnorBmiYKsse/BiqqoJ3alprn8HyOjVvuvUU7SdxB/xcvjmEc
 WxRMU53DzwfhOHkVi4EO/s1453paPFwGrP6noFzy86W1BkBI1zslF5U9jA/ZtDWJXCjW
 eeWCebxJAQn2GZlR/vJ5+kn4+ZxWPgTo5jeYTkAo8ujFNe3jZ+bBysdHdosTRTCwZ9sV
 5nPg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rojf2/09cUp0TyE0K17bfjbzfvT1dQ87/WdftDPMac+9+/UYqVcY5AOyS3d/p3plTfu9suNLWk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kxN7mN44I8QEsDLbI+4Hw7ZSYLsTg6n8LOi2I7Hmd/86Xz3R44
 83qVeRYv813m7QaKer8hvDVoOQLneFwEq2mcXdP2lPkO87ekuy6wYpturVcgL4G0KRM=
X-Gm-Gg: AR+sD11Y1JjzrPOIPdFodAlOU9k/g78tOwNfsCsroxh9vXBDXUlbx8aY1eT2/6lcvvg
 0Zd3/4th8duyUK/anh5xgcN10FRGQ6+MZwhvkcV1HUcPoMhOq7pSTv85k90jz2VLJ9P58y7V/lY
 6qQ9mkXUYD7cQz8LFWoldyi5G5qHwTf2mCTglLYFelkexwDXrqTJZYtBhq5cKW5vF1iATwxvrMB
 iKNs6r5aut80kqQwgGS2RVMWouiiVteuzgNsWdLa2zIhOYWD4QY1psivF1PKZZcYnvM9E4jbiZb
 VFqDDiPvxobzz6thnFGg/S2k9kbAWJF0/+L4MdY2eZ/NFQGpz7q+cyQNmKyO4Lb3x3+0BoQq+ok
 RFjYO9TN8d9dBDhXrzxxbJar9UIzAF9blGGaeG+yWPExuErUP7Vx+F6ibwTy7EwsWwIXSk2AUhx
 qUS4nFugXlY4Fz8XzuQJNjtQ8gmHYauB8yy5HLBAhKi41v1gceLFfd44tQhQxV0gRFevDzfaGyP
 LsHb/r6nvcaUmtmLAIV9JJM
X-Received: by 2002:a05:6402:5186:b0:6a3:eb13:e74c with SMTP id
 4fb4d7f45d1cf-6a42f1a8bfdmr2913429a12.1.1787302364776; 
 Fri, 21 Aug 2026 01:52:44 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3feeca188sm5594027a12.6.2026.08.21.01.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:44 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Eugen Hristev <ehristev@kernel.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 81/87] usb: gadget: at91_udc: set endpoint capabilities
Date: Fri, 21 Aug 2026 10:47:57 +0200
Message-ID: <20260821084829.2070426-82-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:41 +0000
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

The resynced epautoconf.c matches endpoints on the caps field, not on the
name. at91_udc never fills caps in, so usb_ep_autoconfig() finds no
endpoint after the resync. Same problem dwc2 had, fixed in commit
c5c4cc4c6b98 ("usb: gadget: dwc2: Set endpoint capabilities via .caps
field").

Move the endpoint names into a table together with their capabilities,
the way the kernel driver does it, and copy the caps into the endpoint.

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/at91_udc.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index ee2af2d699ff..a8ca22c906c6 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -51,15 +51,23 @@
 #define	DRIVER_VERSION	"3 May 2006"
 
 static const char driver_name [] = "at91_udc";
-static const char * const ep_names[] = {
-	"ep0",
-	"ep1",
-	"ep2",
-	"ep3-int",
-	"ep4",
-	"ep5",
+static const struct {
+	const char *name;
+	const struct usb_ep_caps caps;
+} ep_info[] = {
+	{ "ep0", { .type_control = 1, .dir_in = 1, .dir_out = 1 } },
+	{ "ep1", { .type_iso = 1, .type_bulk = 1, .type_int = 1,
+		   .dir_in = 1, .dir_out = 1 } },
+	{ "ep2", { .type_iso = 1, .type_bulk = 1, .type_int = 1,
+		   .dir_in = 1, .dir_out = 1 } },
+	{ "ep3-int", { .type_int = 1, .dir_in = 1, .dir_out = 1 } },
+	{ "ep4", { .type_iso = 1, .type_bulk = 1, .type_int = 1,
+		   .dir_in = 1, .dir_out = 1 } },
+	{ "ep5", { .type_iso = 1, .type_bulk = 1, .type_int = 1,
+		   .dir_in = 1, .dir_out = 1 } },
 };
-#define ep0name		ep_names[0]
+
+#define ep0name		ep_info[0].name
 
 #define at91_udp_read(udc, reg) \
 	__raw_readl((udc)->udp_baseaddr + (reg))
@@ -1469,7 +1477,8 @@ int at91_udc_probe(struct at91_udc_data *pdata)
 
 	for (i = 0; i < NUM_ENDPOINTS; i++) {
 		ep = &udc->ep[i];
-		ep->ep.name = ep_names[i];
+		ep->ep.name = ep_info[i].name;
+		ep->ep.caps = ep_info[i].caps;
 		ep->ep.ops = &at91_ep_ops;
 		ep->udc = udc;
 		ep->int_mask = (1 << i);
-- 
2.53.0

