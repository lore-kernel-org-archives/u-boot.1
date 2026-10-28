Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B3606A31F
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tHlW/iaR;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tR0QTLzC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7469280F55;
	Wed, 28 Oct 2026 14:47:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id edSaAqS5RO9s; Wed, 28 Oct 2026 14:47:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B87181010
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198796;
	b=sxKLUmsVMYfgLhmSN6Pzd0qLdvCHE92Hd17xKH8DWZvLIE99sR9T8cBYFSM6Ynr8U12r
	 IBZBRF3DhIw+SZ16cOA9OfX1HyvQet/+ZQaAZFHx9yiuzEjeSJ8jw2jaby6IqE9Cgg0tD
	 sC4sI+lef9UR2Hi9YNKEPdhouZHJ0ZINQAWfcXm4d0rpVMUHD6fL4qjV8uoFi6Uea91VD
	 R+jZ4aZGcwCLfLj12NcRcrfcfeMUutPuhqM/3SAB52xikLriA5pdnSVL+PkFVUjLtdnLu
	 7/+qQweltlylDaxM6YTEXdOokSX5tRdLbZOKHx48v8GT0zMRKHFI01TxrPi7pee/04A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198796;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EORD6feofv6ukFDg08PVqE0xKJhH+RRnyl7ISddVELA=;
	b=Qt3hswKmcuP9by9tjFoetJgPjHCiPgFWT4SW8t4UZnYI5ech6YYoZ3C7ayMCEsKq7WfJ
	 ybyGxKGw3aNxboavcygA1fdmyf61peCC3cyOkrXpLOlM12IiY2sVuFT7sOR8YCv6BU2Wq
	 51h8xCDbJ/bM6wS/YGOAcBQ3YB9+cI7vHnfGNzpRAl0N6s0XRCO9ZfJw74sshwUsw7ot7
	 nO8htDa7n9WziQUvi+PTdv2jWLxfnyW0N5Ckax7Bya2vSn+8J0dfYiltx+ESMGMyQrjiP
	 srvan8yoyXYFmUQc+phvI5lRQndEvekjlBiumyUtbtaSaN4whnn3rh01zuXE9PFY7WA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tR0QTLzC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198796;
	bh=EORD6feofv6ukFDg08PVqE0xKJhH+RRnyl7ISddVELA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tHlW/iaR0F0Wj8nbZCtnq0JbtKqqOoAxD4BacuH62c5UYIHKEpnyaZKNBZ/bLTUO5
	 yJ4F4XK/8kfHUxCup4av1BugYRHHV7ARx0al9MkmkTqvKYdn7g/looByHsqPtgD9ca
	 ttf9hjmVknjU350E00rJ2+k1rfRNap49QTPZbbfwFHIouvvwuA1CL6BnAWuuI035CS
	 eFRgoChXtfyU4gE0cF2/myjPeCLHrLKrnsmKfd1/T9q9kJqLnOg/UN8veQB0BiMbTA
	 1wqnFgi4RPq7sX05L6/iGC9USE2C4Y2vwVFiGuSvBxkXAo3Pohq1IQ4JxKNp9kqfDF
	 JtFgYhOYXUNRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B87181010;
	Wed, 28 Oct 2026 14:46:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54B67380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4699680BDB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PVy_c-Z6f56M for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:11:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 321E180980
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196705;
 b=kkDmYBiM5Q1++usSBoebeOUF5jezdmuZ7AuxKtUfsiNKJkPD/zO1m3nR0TAiWeQbFUrx
 BLIm82wJA3RqZL3QriEcyNpkIyIj2RLal7ZXC/PjsV7AamEmTbq8EPYRc19sB8YbUn72x
 w/cNEjtg2A8Id76CUxKSsfkc26WTMNK6gGd2EYNFrmZmInvbdadrwc3SguItCkNzXdag1
 fY/jn4netErxwQT2mWgN6IVUdnPGqjniWk1gyhPwODN+Mrrfqh2OUW5TZMkx5XKPuMC40
 pnIgCGAa/sYr6tePWJLm3dxLR8QGtPIkKTeU/JQmVtcZPrAUNOoz32ey2JVG1yd78LA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196705;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=EORD6feofv6ukFDg08PVqE0xKJhH+RRnyl7ISddVELA=;
 b=h9rARQUiWVHeAOxa5knMW0VQPJKNFeJNv11ac9EJxSUlz0nQSLyfEpbePEKMq+BImwTq
 URjc2ryQTva9ZA6gIkD+o6E8Blh4HCKx48JzyuOWJuHNEIVdyrnaQk8bZRpSxsDEH1yeh
 QkJP9ZG1qbSyRxyLa20Xkk3uFeBLFDGp0aMt7PW4VZeU6BMY0pcPRihGhcdDdxWFGCFEc
 0DFZIMV8b22Mg5oYkzSZ1Rk4Eq2s5jUBdpXICCHDO0THgu0/qF4Zj2GjKokRdS/bWP0ge
 yeXKJ/3eTnxzqeH7yI4/UZSG6kzo7JCrFT74idAJ5ZGv3S2Jqt2AaltShRTbZCxSp0A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tR0QTLzC; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=tR0QTLzC
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 321E180980
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:44 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6acbe0e4090so195001a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196703; x=1793801503;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EORD6feofv6ukFDg08PVqE0xKJhH+RRnyl7ISddVELA=;
 b=tR0QTLzCNsxlUJ+lrowFlOkK3uVe5tQkulHAKKsxDN05NTJl137F21eeBOPDGilA33
 0Ek3ms0LaU8dFidXCovn3qNnGm+rIq4Fg2OWBcXpf4QarXBu3x3hdIj+P1zZYiZwS78L
 S3ESUoVOJQP8vxu44TEN0V0uhy2tOOjWOA2cyZ7Rmz5KJiJr2EbU+rVi7bmoTqAOxn7G
 yebLbzInceZ7tosMBfAu/k1Jk7JE5PAEbgC1Drb+V4z+jicBuxV0F0SmVHmrQ0/i3ELl
 HPT11ERy9PA/lYMto9vheFlohIjxpnlmjzyU8wjyy2n076IOYByvNP7ZfvC8LRJ7I9yi
 mlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196703; x=1793801503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EORD6feofv6ukFDg08PVqE0xKJhH+RRnyl7ISddVELA=;
 b=D8PZpyXGjeEJIKbGJnWXLZpB3l+VmJWHhDtwkQPKNTffXrRtUDL4GFM97QTmMSRebk
 ADVpsSNpOF5eoH2Hi9LmC6lZ/TEH28L4Gza4SmnG2ry9hyiWn8TL6+AkdeybW23X064W
 lvQZxBs9JPb48OeIZomw85ezi/0CxnsNQGO1ECfByINWwGtCoXrY/CpTFdrgQ6eoBaQO
 0X3T31/n8ejDLWCwPcaigweg6zdKn7vqrgOD9MQ1PjMsL8X3FmBI7jq4aIPemAwjjuaP
 /f9k/IlKy1Ww+ILyhB18dBpic2+4eJuIIa0Z0P3PmuvoM0d02p+xGifX2E04VPL+rFOH
 rEwA==
X-Gm-Message-State: AFq9FYIWpXIg1Fisx0EhUmaBJeGU22KDtc56FjkqSl7tCWfOrGGVcDcN
 mL0PxAbP3ebDow0zyo5FhMi7+vnCiEqBlfnm7dEOA6G+g5RkwuZ5LOVQS5li9ecKedEmjkVxIHn
 u5s52
X-Gm-Gg: AYBFou3+xBWt6DCBNn/h5Vp9+pmuz3B/mntDqwoTPM5onFoTjXBptOrK1vym9trembS
 u8SpEJv1fJVYh2RmOsC3UmQlqsOsLakiG98b/yQoZUrtQLaFq+z4wVb3+xZcGfXq7GkXQnCVJzx
 sM1q1vQwd0circFx+X9ioSe+VJhLGTl/+2w20ER5MWpTyUCTM5CKh2OTz7IgRdwD4pA4b895gwD
 HOKcd7vCXuhHR6LWJZSHcY1BcpnIs8MTf4Pr4HEj2IgQZcIJPUsazEaOzl568ciOfU8gXXBa+dd
 +2KYYH7aKPqrbV6w+NAbtiYDyzR/UuRzl7bW+qqKvvWW+eRxzl8OyTgePoYK4TuPqehIckTnzCr
 UazplZ70GrtXvSce8bpq5+hYa6l6RxDS+meEhwVnH9bncaH9NPkrCN7Z0sp0obBrFNA2U8g4aUI
 PKv2F42DZFHkjAfOEJJQ8296dh8T7PQDeZ6vuAPFF/SuVvSOg7SaeAEi2lQaLgXfNptC8WK9m1/
 9Oik0ClSs4DZqG6nqdgMK7Q/7WqgbKUKqkq/JP8CsYgNbUe9/6M4YKkF8j/lCncvCwAPaj5VZUv
 vplT1u/D47kGuupILcf47kS+9iJAdIOfmhTTqFn23HBrjkAbPKls28KkjyQ+o/j65iaTuKa4OZ9
 zXL840yGSSA==
X-Received: by 2002:a17:907:d645:b0:c34:db91:aa1e with SMTP id
 a640c23a62f3a-c49bdfbbe19mr309323966b.4.1793196702666; 
 Wed, 28 Oct 2026 07:11:42 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64a02csm611738166b.44.2026.10.28.07.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:11:42 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 24/63] usb: dwc3: import from kernel v4.20
Date: Wed, 28 Oct 2026 15:08:50 +0100
Message-ID: <20261028140930.3025368-25-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v4.19 to v4.20.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v4.19..v4.20
Commits imported:
38317f5c0f2f Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"
2fc6d4be35fb usb: dwc3: gadget: fix ISOC TRB type on unaligned transfers
ba3a51ac32eb usb: dwc3: gadget: Properly check last unaligned/zero chain TRB
08fd9a82fda8 usb: dwc3: core: Clean up ULPI device
6af19fd10595 usb: dwc3: Fix spelling of 'optimizations'
87dd96111b0b usb: dwc3: gadget: Check ENBLSLPM before sending ep command

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  3 ++-
 drivers/usb/dwc3/gadget.c | 42 +++++++++++++++++++++------------------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 88c80fcc39f5..2f2048aa5fde 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -756,7 +756,7 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 
 	/* check if current dwc3 is on simulation board */
 	if (dwc->hwparams.hwparams6 & DWC3_GHWPARAMS6_EN_FPGA) {
-		dev_info(dwc->dev, "Running with FPGA optmizations\n");
+		dev_info(dwc->dev, "Running with FPGA optimizations\n");
 		dwc->is_fpga = true;
 	}
 
@@ -1499,6 +1499,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 err5:
 	dwc3_event_buffers_cleanup(dwc);
+	dwc3_ulpi_exit(dwc);
 
 err4:
 	dwc3_free_scratch_buffers(dwc);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2b53194081ba..9f92ee03dde7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -270,27 +270,36 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
 	u32			timeout = 1000;
+	u32			saved_config = 0;
 	u32			reg;
 
 	int			cmd_status = 0;
-	int			susphy = false;
 	int			ret = -EINVAL;
 
 	/*
-	 * Synopsys Databook 2.60a states, on section 6.3.2.5.[1-8], that if
-	 * we're issuing an endpoint command, we must check if
-	 * GUSB2PHYCFG.SUSPHY bit is set. If it is, then we need to clear it.
+	 * When operating in USB 2.0 speeds (HS/FS), if GUSB2PHYCFG.ENBLSLPM or
+	 * GUSB2PHYCFG.SUSPHY is set, it must be cleared before issuing an
+	 * endpoint command.
 	 *
-	 * We will also set SUSPHY bit to what it was before returning as stated
-	 * by the same section on Synopsys databook.
+	 * Save and clear both GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY
+	 * settings. Restore them after the command is completed.
+	 *
+	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
 	 */
 	if (dwc->gadget.speed <= USB_SPEED_HIGH) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
-			susphy = true;
+			saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
 			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 		}
+
+		if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
+			saved_config |= DWC3_GUSB2PHYCFG_ENBLSLPM;
+			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+		}
+
+		if (saved_config)
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
 
 	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
@@ -389,9 +398,9 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 		}
 	}
 
-	if (unlikely(susphy)) {
+	if (saved_config) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+		reg |= saved_config;
 		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
 
@@ -1072,7 +1081,7 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 			/* Now prepare one extra TRB to align transfer size */
 			trb = &dep->trb_pool[dep->trb_enqueue];
 			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr,
-					maxp - rem, false, 0,
+					maxp - rem, false, 1,
 					req->request.stream_id,
 					req->request.short_not_ok,
 					req->request.no_interrupt);
@@ -1116,7 +1125,7 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		/* Now prepare one extra TRB to align transfer size */
 		trb = &dep->trb_pool[dep->trb_enqueue];
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp - rem,
-				false, 0, req->request.stream_id,
+				false, 1, req->request.stream_id,
 				req->request.short_not_ok,
 				req->request.no_interrupt);
 	} else if (req->request.zero && req->request.length &&
@@ -1132,7 +1141,7 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		/* Now prepare one extra TRB to handle ZLP */
 		trb = &dep->trb_pool[dep->trb_enqueue];
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
-				false, 0, req->request.stream_id,
+				false, 1, req->request.stream_id,
 				req->request.short_not_ok,
 				req->request.no_interrupt);
 	} else {
@@ -1461,9 +1470,6 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		unsigned transfer_in_flight;
 		unsigned started;
 
-		if (dep->flags & DWC3_EP_STALL)
-			return 0;
-
 		if (dep->number > 1)
 			trb = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
 		else
@@ -1485,8 +1491,6 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		else
 			dep->flags |= DWC3_EP_STALL;
 	} else {
-		if (!(dep->flags & DWC3_EP_STALL))
-			return 0;
 
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
 		if (ret)
@@ -2250,7 +2254,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	 * with one TRB pending in the ring. We need to manually clear HWO bit
 	 * from that TRB.
 	 */
-	if ((req->zero || req->unaligned) && (trb->ctrl & DWC3_TRB_CTRL_HWO)) {
+	if ((req->zero || req->unaligned) && !(trb->ctrl & DWC3_TRB_CTRL_CHN)) {
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		return 1;
 	}
-- 
2.53.0

