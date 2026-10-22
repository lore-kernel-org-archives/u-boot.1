Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6998606A322
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pKqeb2VF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S5cHQPQd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C302E81270;
	Thu, 22 Oct 2026 19:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CE2RtnpVPrj5; Thu, 22 Oct 2026 19:41:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0918C8120B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792698080;
	b=X5EKMFcCk24JRexqqKsqwGRm2oCM8mnpuOc6thA7uPiOu3jvMBF8G3+Mnw58nnA/6nZU
	 GwGiLO7MiLRdB+mi+wOLokh6Wn5BQcxzhG22I88tWQQlHtlCcA7Ia2GF08FSc1xNkEDPd
	 qoj4yN2pRWF4Z+NO3sRpx7n0nd34vNk7J03xZhmWOBFJqg3gWKdbUo1IyoHcUMazOTgPH
	 UXpCTC1W+lNNjF9LjsChoDPRTYqMn6rEo/RXtXe4epUYTUgcsSq3ttY09dUXNViOOulYs
	 pOAwQH3gYBU+M6BI+OGnEaR3ypeV/z6bt9BW+QN79R/yojBLj8y6F85kAJEAtfHDIPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792698080;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
	b=NYRip6R6JL7uH8dllVgMC10p1eO01t/F4rGZZ4qdvgG8apb+efPzAY+UDAqeo6dso3EI
	 GfkdTzoTw2J5soTw1S81YUP0NC/Ni2y0I9weVhNmIm+PQgA/mxqCjglruGcnpWdNLk4sS
	 d/eDdbqnFndg8OeB4YEarpD3Hzh65ipBc5FKJWhKUW/Q+UEAbmmdu4axeA08UbhkRgVtq
	 gesLJ/3UntEEr0mj5KKDvUw5GYmIIZ20k5UxhwsPy30Sw7CA/XzVLKHSCyW+o6ilDX2Ck
	 zHB1CasVsaEZrvlpqWrD71wdtFHAc6vvlf5t5sxr0JBNFHptDLG1hTxTNV/XfcRA1rA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792698080;
	bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pKqeb2VFDvIPZdh35394hw0S6x9H8wAgUmhOD+KE4XEiofxm+ZU22AhqxBiNk3OSg
	 t5Q8rK2Baqh8GLoWDkcDyuuEi6QLfMRYgvv2qfj4QwlGgrA1Qw93FjTyLB8XOz2V62
	 pPDb3GECY0Ta7HXCblUXavAVgOSxAofbc66HqzkzmTKsBRqi7MOCFXtmKIr+nSnP6x
	 R1HQhhq7gNzjH7d/eYliv18DIXGe7BuNO8z3+XCp5O+6gMNuK4nx2GW2g0CuUdZpdP
	 KigNy6vsUGKo6h7umB7ky23FDqEcCG1ILLUF0B7O4I24N2CqWQHjrpPvIKIlf/ZPZG
	 3mffaXZaR1fhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0918C8120B;
	Thu, 22 Oct 2026 19:41:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A9313A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B3A8409AC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jui7M2YBdCWK for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:41:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0FB3F4099A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792698073;
 b=Cj0o8RI1Z/gKTuZd9ECghm2/3Oq7q+KfGNH14SBcijmO/l+rkvj4B2okj8LJVfim7tN6
 yn9qjPs+MK+i+YTXz1ks2Els77QeoS7RgvJ9vJnpWaCgP5xRXVzXZ+21Xdj5BrOVcoNJw
 zh5LNcovgW9sax27WVZgSdt8GLYnxrgTaxRYf7q0xAFeXLILVhhLYestYr6vBw1VJdMu+
 M1Y4sEm3nNkjeCfkVTgl5PhjYATssOeF5S0ZjZXlVMmbLpwaKRoI8lPbvWNUVDQ0Q6Krg
 O+iMYgEnw89mc58fEsycl7x1FbnW5RO6+KidC6lQ8kRKy1KATwDZE8yS4izje3PfwfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792698073;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=H9Kmg0xlZImh42LxVIk0g1JKutLe35SAEfJ9INvpwfIaMNk60GsseslQ0a/VYNo9OGhW
 c/Ibg4/EQtTXfbxEAuWiY24Mfcwg+QbwVgbAlfdwpZ0oa0b/TRh0tvLV2kecKrBtkvdlp
 aEE4VW4ftunT7K7TIkbWCYQA97A1Vf3nD1Ytr5udnz0HOoR/yjnu8C4xt802foHBpyHKY
 L7fFzN15SGaldRGAaWXZ8TnWfeS6cT9fR2Tjw62FWIrS3tWC7p6CDJ8HJm5WuJLhCWzUP
 PhDK5nKWD7xbbfDDdEbB6oCd+A78u8La61YYo939wcPPcnQ4Zi61J9LPiFF/hVk3+bA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=S5cHQPQd; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=S5cHQPQd
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FB3F4099A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:11 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1e266fca2so1435905e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792698070; x=1793302870;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=S5cHQPQd7xRg1QtN19QkLILdeYLdKHPmp0CFrmNpvwv2kQNdY3Opm6stfFVt7+yHH8
 zAby2o2V4GTl5os4x3g1EW1UshFMpm5VGqlvlL0XNKTBuqwNTWPRT5ytz0ImYax1Vl4c
 OEzsODDKKCVypPg1qx7wCdZeRAuU3Sjho9IQipRsg4yMjTTbq+naoRXZd6QMbL/bRmEi
 ikLFbELwAbbWTF+dTO4D9YI6TemuN1X5+emg7j7c6U4bfP2BPmP3sCuBL44TQLoI3vUZ
 B1HsP9LNKsEOAo2Jf+xWJg1iYsI6ScDTGTxOTx9gABSvr4uU3PJj47G9NzYkptDh/Oln
 F5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792698070; x=1793302870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LQqAjfNYPZ/92kcsWjWoLNe08OJUI1ADRPkXQI9EiEM=;
 b=hk0YEHq/a/3GYbSmSns3ZFKl8PYh8H/7Z8aCmOVSaxM+kxH3siyrqaSOefJ2PhsDCy
 Q97TeQnUAlVx8my1TlQC1kFU9FHtHRSs54nEoEtsjcBbNSWDRSlv2ETHPXcsYyymE9Dq
 zoWf45dEfdAofaeEfZrU4let3EZDPe3NZJ2gPiW+amMhMeh9GCX7IOOvRkiLhD+0hCbQ
 gGqSENohduE2kQ/K406Mgnpzj9OjLsAg80qMJPwCZIZJSv9bK25QG0UH3KBXrsOf2xP3
 rTHT6VliX6OaX1ODhjBkNVHszNxmYlW5i/wV5aflQXkSvGIHJt/Ia1ImyGEHXFFNRiUS
 XHEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxb/BOmkS4enWw1uhyh3gd5oBCeSAl91wlXRzDGkeIughVUwm0jsChs6lHCIcpBbS46Zf20YxU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKf06Yw6VBJ8M6nZv1K+BLdb5elfeFg3U5GqYVj1MmklJT4RT6I
 oW5rJ+MqHScHunzldyKL6doDa1iQinx0JPo4b9mfwLI8mu3lGIW7Pg/V
X-Gm-Gg: AYBFou1iXXSQwtB3spe+q4mr5nJMCTNUVrHOs39kNztCNd4CwAmcxaAHxNyme54+Mjs
 2ukZn6DaccpS9faiDDSAkR+l/tNgIJlSsEXQ5XsM9FM74pQRb3VZuxuQuD6AWwI9rqR/1l0nagi
 OfAgq5mKX4DdrbiPzj33VG9bW5bNfPuxwLq/X5+1dC7bkglMqKXRP20YU6CK2g9BJ44D0IxBUxt
 GFnMY8TQgzj4f7SuM9990GsY0RoxIAAdKam/+8C8l3Qv5VVwXJC9fIhgkGEX3LUjK2QYMGa7nlG
 WZs5NYI6mUoH2KNuv4rNlfeB6vTKJbExGmy2gsp+y1nWtnHLHH+wHxhYVc/t+fUK5cBStY+d+wy
 Z7lQSsX3EORlvMujvpH2vXDIO3+X/u5x2g4eUdDAOliD8tZEP5PPpcOGz7O3j7joqZJnncJK7Zx
 BkY1Oc96W9TVJdMgaO9Np9MDZTMTH9tUz3fnSm3nSNUO1Nn9iRWvwB6lKPKMZA5h7YkYFyfpJuB
 qFsGGcAaz6H0IbNLvE3lFWAl8lxYHg1TQIlx8gLvEXJqZPQgvYQnd5JcnO6kQFf7PCEK9kct0up
 QtxsOxW6MznC8RWGrClydQGUxaOPDJYwDCHUp24i+ivH/Sc88sD6le5TNkXmOAsgLofO3ahD8io
 YW7kZOA==
X-Received: by 2002:a05:600c:3e8d:b0:4a2:967:dfb8 with SMTP id
 5b1f17b1804b1-4a211f01474mr838375e9.20.1792698069357; 
 Thu, 22 Oct 2026 12:41:09 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a211be8f79sm3185715e9.14.2026.10.22.12.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:41:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v8 3/7] misc: fw_loader: implement generic
 get_fw_loader_from_node()
Date: Thu, 22 Oct 2026 21:40:38 +0200
Message-ID: <20261022194049.670889-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022194049.670889-1-ansuelsmth@gmail.com>
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement a generic function to get a FW loader dev from a node.

There is currently only get_fs_loader() but that is limited to chosen
node and is limited only to FS loader.

Introduce get_fw_loader_from_node() that will parse the
"firmware-loader" from a specified node and will search and probe a
matching FW loader device, if found.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fw_loader-uclass.c | 24 +++++++++++++++++++++++
 include/fw_loader.h                       | 14 +++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
index 0d95fac8f42b..7f19d6c4af4c 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -7,6 +7,8 @@
 #include <blk.h>
 #include <dm.h>
 #include <dm/device.h>
+#include <dm/device-internal.h>
+#include <dm/uclass.h>
 #include <env.h>
 #include <errno.h>
 #include <fw_loader.h>
@@ -137,6 +139,28 @@ UCLASS_DRIVER(fw_loader) = {
 	.per_device_auto = sizeof(struct firmware),
 };
 
+int get_fw_loader_from_node(ofnode node, struct udevice **dev)
+{
+	struct udevice *fw_dev;
+	int ret;
+
+	node = ofnode_parse_phandle(node, "firmware-loader", 0);
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_FIRMWARE_LOADER,
+					  node, &fw_dev);
+	if (ret)
+		return ret;
+
+	ret = device_probe(fw_dev);
+	if (ret)
+		return ret;
+
+	*dev = fw_dev;
+	return 0;
+}
+
 /**
  * _request_firmware_prepare - Prepare firmware struct.
  *
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 56f5e3be6195..99c47380a172 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -6,8 +6,22 @@
 #ifndef _FW_LOADER_H_
 #define _FW_LOADER_H_
 
+#include <dm/ofnode_decl.h>
+
 struct udevice;
 
+/**
+ * get_fw_loader_from_node - Get FW loader dev from @node.
+ *
+ * @node: ofnode where "firmware-loader" phandle is stored.
+ * @dev: pointer where to store the FW loader dev.
+ *
+ * Search and probe a matching FW loader device, if found.
+ *
+ * Return: Negative value if fail, 0 for successful.
+ */
+int get_fw_loader_from_node(ofnode node, struct udevice **dev);
+
 /**
  * request_firmware_into_buf - Load firmware into a previously allocated buffer.
  * @dev: An instance of a driver.
-- 
2.55.0

