Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2A606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 04:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w9UunGVk;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=hGJNTBWS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E8DD80E50;
	Thu, 29 Oct 2026 04:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vkzDw7zVmiC8; Thu, 29 Oct 2026 04:58:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DC9C780F41
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793249932;
	b=RM8x5Q0YmUXo3yvpcd2RPR00/4t6zC4T+9HhazdBkSwiJMrmlzPguGL8lFej+v7gNPx/
	 TYEDBNb+5VYgOgsTRhBe8hIahV1Tz/sjPvI7TEh1oU9OTkDVNNzMtJUmGWhLBKbK2DDOU
	 864dZzI057oa53fE0QNqPXqC90ye6OGmVI+ZcPwS9NV9SxfdeW0bbpSHP4c5p52qXWOj0
	 vBN9ag7tm3zgvuXFM90kx5aOrR7WIWMxT6DUzTuYgsCfbyT07hLmt3WLM+KGI1p3omn7r
	 Bd2snvOobh7cz7kB5CK/mu51Is+UhG9pqchvKX4WU0aEcB2Mj+FX5wF+ODaGhHPDa/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793249932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bM2Lm3mIETiBWWg1liDs02RxMGKk5QXkRAZrduCWPxs=;
	b=q8+j3d8wJbAO7OvBWAZKWh4SSAikvyTKle3u+W8x4njjmU6WgiK4SC6JBO2QKTvuEBkx
	 jaGZeNxmt1AbBJXjlUt+Q623iX8iOiVRLYQ5MyhgdsjPcSydQUNElr4xUwJeYkjYC+VG3
	 8TpPMgVMUGxuqH5iDqoq4UnnZAZ6OJAcCEAmAyExvKr2PptEe3SpTcnN0XWmQ/IMTIP6u
	 0EG2ZirgNGiaRPsVcYcD62UTZb0NO9qSc5npjdJMaPYF0rChPa039W4desCgV699zYwsg
	 IppeM0tbwouPN+7Ji1JHKZFtO1gTNiMzZXu9Ml9DEJsUeEwSi2VfC+2JJoqO0tgUTMw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793249932;
	bh=bM2Lm3mIETiBWWg1liDs02RxMGKk5QXkRAZrduCWPxs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w9UunGVkEdgB68xJ2LFyb7L8ncg2j+iaEqO6q2bghmk1856sAbKp3ExlSZyzirv/L
	 fWWudMv6GGxL8k1Ar1Ci/OtWR/fpUlGNhY2LCV+Th4Zb2naZy0cD4GSGm9dwZQ8aAK
	 kUq6ttypUWAbMkuqV8pSlo410J0QuLfgGvKgVTATfzrqEIxti3dfWqVKzhJFWm8oUC
	 CdzG/G1HR/gTs3vfqEba1kOzKsyDVk9L7X8ScAfuI963SzOkfVMuO/PQC3XAW2xyzk
	 PnWcaNTECP46lAHCgzVf1GwW+JnKiNWw6yoMO9kW/fZ26a5WH+gUVn9WCmt0T3w/iL
	 CYn6PDEYqfS/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC9C780F41;
	Thu, 29 Oct 2026 04:58:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B1282FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 04:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4153F40735
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 04:58:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fHZXrAQ7T0o2 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 04:58:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4CC684070A
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793249929;
 b=BZmPYHVa5B51B4KmnHLyJCbFZrd10MFTteRYpjP4BeXH8cEa12PKYj5mAKyHsbOHiMRq
 P5UWQ/Jg7MOY/SMFnc9slGT7p8IkL6JJ4ajvg1v0skyR4vcWUKBSNjvx30W407i0RWQjj
 xeXhSG9h7MVL05/gTOiIxt0sqrfNinC1hEpqHyfM6a1XYZUVfnZR7QB2yvXssSXDdDcCu
 0aNQSBT3vSpuDJZjKUe+ANieHGWsW/6QbiJxtzCjdcHeq9woIseZu0AA6tVarCNhAm+Ps
 4wjQ6luCw5vKqT/9TD++/sjmk4pDxRC+AkzxTxpcUGBTVy2TTwTO407PhhGDkGtLbwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793249929;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=bM2Lm3mIETiBWWg1liDs02RxMGKk5QXkRAZrduCWPxs=;
 b=Ahgp/Yv67veRZWlEENr9uOmH0L5hHtdCzqxw9mufGvn3LmQRr4N1LjSHVkRQbpQ5zZRy
 MgMuz5ns1CkMb81k0s6duHPdGpdI8CZNuh3qIdCzdhpbbRAX02PfH+/QGPWy/5tO7YFkM
 ZDmevb50JRydq09hGQ70CZndaSOlkdeTnSvwdugM3rHEpfC87AqYYjIRWvgea1skzdbN5
 7ZOreqlLgHdf3CAlKU0MkGjRy5vxLy1r9oDJQl5MS/AeWGIJbue7V6RE5bmsM/phXkfbJ
 cCFIJocwCzBpT6I26eMqEkL9Y8AUh9IxTswDEcEU9fzbBEsEnYjjmdecQUDWIL5p9lg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=hGJNTBWS; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=hGJNTBWS
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CC684070A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 04:58:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 714621091CB; Thu, 29 Oct 2026 05:58:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793249921; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=bM2Lm3mIETiBWWg1liDs02RxMGKk5QXkRAZrduCWPxs=;
 b=hGJNTBWS0ZjiQBe5mArEx6X1u7iyYtHuyLz5B+Cm+R773s8xin7W5759U1YfMnfPu/9wfp
 yP59p8IGxnEuhHCd6aUh5bd9D6kU79+CrWlOyR1/3LriQlI81DDHospVCD1rRlRLvODC3e
 0CLaM+PMJTOhfrl2Booj0WnnvxMHqjSytq/e16g3xSYTvI2aHIGoCm9XV+ACMhOMDwe4Yt
 eG+HqP3pYpq73L8yjTw2svAkOUDKPS1sPKP4kobJnziZb4fn3DBhR5OFoK93bVD/dRYole
 MeT9HnPXthwIr+3Aj35cqjqaQnHY+p7OjFJ9vg0mKttStMBBOx6IuXl6t43k5A==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] usb: dwc3-generic: Always bind clock and reset to parent
 device
Date: Thu, 29 Oct 2026 05:58:13 +0100
Message-ID: <20261029045837.813288-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

In case a DT subnode describes the controller clocks and resets, make
sure that both the clocks and resets are bound to the parent device.

This fixes an object lifetime issue, where both reset_get_bulk() and
clk_get_bulk() internally call devm_kcalloc(dev, ...). In case the
udevice *dev passed into either function is that of a subnode instead
of the parent node, then the managed memory is also bound to the
subnode device instead of the parent device.

This triggers a problem in case the controller operates in peripheral
mode, where the peripheral is bound and unbound to the controller. If
the peripheral is unbound, which happens when DFU or FSG exits, then
the device managed memory bound to the subnode is free()d, and that
also frees the memory that was obtained in reset_get_bulk() and
clk_get_bulk() calls in case they were invoked with subnode device.
If anything rewrites that free()d memory and the controller driver
is then removed, bad things happen.

Example, enable CONFIG_DM_DEVICE_REMOVE=y , start 'ums 0 mmc N' ,
exit UMS, boot Linux kernel. U-Boot will most likely crash in
dwc3_glue_remove() due to invocation of reset_release_bulk() or
clk_release_bulk() which will attempt to use already free()d memory.

Fix this by always binding both bulk clocks and resets to the parent
device.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Fabrice GASNIER <fabrice.gasnier@foss.st.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/dwc3/dwc3-generic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2406f844617..efa07e67f98 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -670,6 +670,7 @@ int dwc3_glue_probe(struct udevice *dev)
 	struct dwc3_glue_ops *ops = (struct dwc3_glue_ops *)dev_get_driver_data(dev);
 	struct dwc3_glue_data *glue = dev_get_plat(dev);
 	struct udevice *child = NULL;
+	ofnode node = dev_ofnode(dev);
 	int index = 0;
 	int ret;
 	struct phy phy;
@@ -705,13 +706,17 @@ int dwc3_glue_probe(struct udevice *dev)
 		return 0;
 
 	if (glue->clks.count == 0) {
-		ret = dwc3_glue_clk_init(child, glue);
+		dev_set_ofnode(dev, dev_ofnode(child));
+		ret = dwc3_glue_clk_init(dev, glue);
+		dev_set_ofnode(dev, node);
 		if (ret)
 			return ret;
 	}
 
 	if (glue->resets.count == 0) {
-		ret = dwc3_glue_reset_init(child, glue);
+		dev_set_ofnode(dev, dev_ofnode(child));
+		ret = dwc3_glue_reset_init(dev, glue);
+		dev_set_ofnode(dev, node);
 		if (ret)
 			return ret;
 	}
-- 
2.53.0

