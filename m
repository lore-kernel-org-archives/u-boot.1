Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06533CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4319886BD5;
	Sun, 24 Sep 2023 21:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WBvlAXcC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D50486A63; Sun, 24 Sep 2023 21:26:27 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D2886B9A
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34fcd361e91so16679875ab.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583575; x=1696188375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEWCGBRjswkiM944lEOstW+kzsaSSKRcVK15+m62t18=;
 b=WBvlAXcCHJjyVZW/jV9OQorELQsUQ1hXqFwtGb5rgH7gdkROQiZLrmeGRbCo127nOp
 7+0gkcrMiiVr/HYy+2zOwH6ubUrXCaiIYpTwDPOo/zPqq4UCUn9L0eEPg7QRzWCX0dkW
 COfhnibxIM4OkFBx35z3H6sr/mTxoUAi+xk7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583575; x=1696188375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEWCGBRjswkiM944lEOstW+kzsaSSKRcVK15+m62t18=;
 b=Sax2MHkqVtmvgyeOs2Jrzt8RkoC+w442mB+T+RO3ABEVfGT91QI9tnJVTVnhbJ36T+
 lTA7Bn7nlCtsZPx5B6bPrwgM59WfTZ5NwKVH9Itee8NxANIm+6f0zGquYhwFAQoDLTVy
 CdpphzPkPxysVw/LK2TfIiPG5B7ba2zg8Xa4MURDH0KyLsxzk0SgqbNFeb/0J5XD0VM3
 hdwaB7t6PygFzlheQq5mjr+GQpNrFYDOd+hurmM82PrKjPnbF4eWOvXMAMf7ru/Yvz9B
 XRSrE5o5s/76O6JhOVzbLqY/jMGgFRNbqCNjyM05/2qbhmiId6l/g1IRpaKOpnV87gnu
 ZTxA==
X-Gm-Message-State: AOJu0YxMCRJbZxrilyBw/wHVg2IvZBCPAflZutRN3XXb6BTsvYtCIe06
 IWeYy4EDecz4i+yswBKu0X+3iraWgytUzFSIhno=
X-Google-Smtp-Source: AGHT+IH7Q2u1SxsjAUW/BkESWlzRVgIZrkiSDOBbJmDf8MYmBWkCCkYCdRXiKBks4g3pUN7eEw8aSw==
X-Received: by 2002:a05:6e02:2167:b0:351:ab2:2626 with SMTP id
 s7-20020a056e02216700b003510ab22626mr6765683ilv.24.1695583575416; 
 Sun, 24 Sep 2023 12:26:15 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v3 30/38] dm: core: Add tests for oftree_path()
Date: Sun, 24 Sep 2023 13:25:15 -0600
Message-ID: <20230924192536.1812799-31-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add a few simple tests for getting the root node, since this is handled
as a special case in the implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/dm/ofnode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index e078a9755a83..a5bc43aea4e7 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -228,6 +228,9 @@ static int dm_test_ofnode_read(struct unit_test_state *uts)
 	ofnode node;
 	int size;
 
+	node = oftree_path(oftree_default(), "/");
+	ut_assert(ofnode_valid(node));
+
 	node = ofnode_path("/a-test");
 	ut_assert(ofnode_valid(node));
 
@@ -256,6 +259,9 @@ static int dm_test_ofnode_read_ot(struct unit_test_state *uts)
 	ofnode node;
 	int size;
 
+	node = oftree_path(otree, "/");
+	ut_assert(ofnode_valid(node));
+
 	node = oftree_path(otree, "/node/subnode");
 	ut_assert(ofnode_valid(node));
 
-- 
2.42.0.515.g380fc7ccd1-goog

