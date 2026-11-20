Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717FB606A325
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KjusnhNc;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGiaR3Ge
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4316660623;
	Fri, 20 Nov 2026 14:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E3fCqyTQ-5p7; Fri, 20 Nov 2026 14:44:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8662360628
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795185846;
	b=tM/pKZATRqKm4tEB8TmrsviF4T0+EVaIDEZnkBW8Fj2ZhycbC2ZUhgbM4nWeLRtNMZyH
	 w5yeW+fcn0c9NcJioa+hFmaD2Z/N6SrBvrIjSdUA/GKjzGotur7E2TSJR/yJEPM9oYZse
	 RVF9LSTGkjkLPLzYDkdszrtvmH0WgCfJ87gRpDEBCM5n8sfMR9ngjKSFxeoCJT4C+y/W1
	 ADklXWhjbAXQk95Cnhi4ZxZDc6/4MAhpfbxqVEhCGqmjsGYWB4CAf7rE+AbNUKp2wt8sS
	 fB3HzV8hXSlwiQWEA4AABidaLL5bPPz/BGULc1jBljsjz7wIAGd8z+cBkrkmshIyHMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795185846;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pKEcctRG12ZYlAvn7Y0pBRGlnvKzY25YAoIequaDoZQ=;
	b=rF1boPz6wQmPz+JWI0wvIbkb6NpSM+Cjx+JIcNUxYgnLpklKJlE5rj7204yExKbJEu9n
	 oXiLTM7G7vjxc5iwsSBY0mbmOE2oFbddFtq21nVXDScUEryCXTemNZXLRyPq9hI9lTqpt
	 8exQuak+S2fhgLsXHJPnLOIBEoKDQo/d/whRezsillPg9qFh1MVWZN6c2aX0y4/DFtd6e
	 B+noJpXMnNaGtOi7xJP1TrhoROm+JxFx6Xn8kI1MNGw0z0cPwXrwXnA2DZ7h+O/Z1BLWf
	 ugMR35YuSFtjAjTlZXH+bKC8lOThi/fR0RTDJABMB/zUUpn3JIf3wHafWEz2I8lPdwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGiaR3Ge;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795185846;
	bh=pKEcctRG12ZYlAvn7Y0pBRGlnvKzY25YAoIequaDoZQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KjusnhNcZPevpLnoCmQav3oDviYGdrCunvMpEBOUznUotU+MMql0CNS/uTacO5J2m
	 2Pg6vcWbGKsPUI2mXjIccO/i2Ng45R8kgngt4U3AO7N/XZb73L9OMLDJqFmCVXoQgm
	 q45734WsWU6Qe+TkQWJQ2wEMSjOazdsAZq4VEDKdukk449Gqw4n55yRy3I7+HVOHFY
	 JKEbFoVqDfwQqfSraWHGOdNcuaI2+zj4b9dOwwiqMEq1hh4F8YX5Q5a+o9HYabQ+/1
	 R6hGIsWtn0meWMNP52eG5SUpD8f1eHhYthcYGQX96b52xIi49Spx2ErWyv4y5tdUc0
	 jp15vONZ3sfsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8662360628;
	Fri, 20 Nov 2026 14:44:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AE812E52
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC03660628
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:44:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cZjOpfMARVtg for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 14:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DBCA860623
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mGiaR3Ge
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBCA860623
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:44:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DC8C432F4;
 Fri, 20 Nov 2026 14:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A60F1F000C0;
 Fri, 20 Nov 2026 14:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795185841;
 bh=pKEcctRG12ZYlAvn7Y0pBRGlnvKzY25YAoIequaDoZQ=;
 h=From:Date:Subject:To:Cc;
 b=mGiaR3GeAUqnfUPGw84G11Z/Rq8TIFIg27sJpRgDmjk9BNFuUovqageFNfEzOA1un
 irph704jlaegxFMda5pUVA631qCfi3ZG17sI6ycTJ23EXmhWZ6TxM24wPglRun1txB
 Yf1rhc2dybJKrkRLtnYwk2VuAYbtfbgjjDM4L2likHVTtSMNhmIWjYtJFUDrGQo6Af
 pnJyUDkMYCjsZqTSq7Vp875MqhVxTUlRPNMEego3iXksavVpUr2Rl0YP+URh/ul4r/
 /2jds8sFGO4ot/lv7RGnmIWudD8L0iFZ80Z9YZJ+IHWaKff39TJWiSlbeZyrZehMsm
 O83ilfQ0YYtuQ==
From: Yixun Lan <dlan@kernel.org>
Date: Fri, 20 Nov 2026 14:43:48 +0000
Subject: [PATCH] spi: fsl_qspi: Add optional clock support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-05-fsl-qspi-clock-v1-1-bacea4ebd54b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB1IImrxKsVFEid1qqjNqAji3
 U3b5Vv8f4JQZBJoshMi7Sw8Twk6z8D3dnoRcpcMRplKa6NQlRhkxI8sjH6c/YBUdKFytbHuYSF
 1S6TAx+/5bP+Wzb3Jr98RXNcNabEOUnUAAAA=
X-Change-ID: 20261120-05-fsl-qspi-clock-e3df6b72ab8a
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2240; i=dlan@kernel.org;
 h=from:subject:message-id; bh=8E2PWjb8EbKj9MmX2AXoXCrMnZ6pFF/r6T+cIkNDBvQ=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBrAFyshyb/SE8nTAn0g2gos4MewGAb1HHAH//41
 8ioSnqqjyqJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCawBcrBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3uYw/+McZuwhHtcIwmlX6kQYyl4ajufIjKJFnCau4NxMW4RO/mhvcTZvB3H
 XKK7mpKs1Ye8gnCJjsjuVAIl8CKcNN0p7h/lYl/oYh+1s/RASFHE+fQMU+Azerx4vbrbEdMkpHz
 0yfdq9ksGurqlrzEAO8Svih8eJCFOs40RkcJDizgmnBhag5GVNUpAdM48uydEOZGf9cB+A2dtpG
 EXVa87sgCzab3UJN230szDSajXGFXZeO1EXEsAX46qOgFp53/vq9JPlCKuTXRCLMM2IMyhB7zdA
 KN8iMG6hPLh8KneN2rV6VvcXlWlhUcKnJWHnu3CqWnKYIvPzJTDVE0j08DxlqbN5fVN5fSNMj+g
 zBIR9dUPTP/ZMhuBooKKX6O66PGA2+0P+hBdDs3kZTCoqHaXxtfk26+e3Zfa8h8s1UmDVGPyhuO
 xk5bp08wYR8/nxTHn4nA0Kz0TRBRO1SKMwO+2ZaoOMO0tjd4yCRhfnWiBlE/QvJdikZDhKb6/l7
 dnET681OSmJIstR360SuT3641YW5U4lJnPiwOIud8Fo5zF6Hl0c6WxzwIRvahY3ldriBuWhV5CD
 RyF1Ws8HyFGULD/ZouKy2q+aFxrOhHVtd8UfNhQoGgXoiNt+eJtIwfcjUAQNw9TtC87Fez3+/2x
 adHalAA1P8wiS9wwEO3PF2EjzladD0=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The clock required by QSPI controller may not be enabled by default,
So explicitly get and enable the clocks described by the DT node, due
to keep compatibility reason, keep the clock optional for platforms if
there is no clock framework support or no clocks property provided.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
While testing in SpacemiT K3 Platform, we found the QSPI clock need to
be explicitly enabled if boot from USB fastboot mode. While there is no
problem in booting from SPI nor flash mode which the clock already
enabled by BROM code.

In order to not break other platforms, try to set the clock optional,
so it won't abort if there is no clock framework support, or no clock
device tree property.
---
 drivers/spi/fsl_qspi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/fsl_qspi.c b/drivers/spi/fsl_qspi.c
index 5692510a558..454dfaf1814 100644
--- a/drivers/spi/fsl_qspi.c
+++ b/drivers/spi/fsl_qspi.c
@@ -23,6 +23,7 @@
  * Transition to spi-mem in spi-fsl-qspi.c
  */
 
+#include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <log.h>
@@ -716,6 +717,29 @@ static int fsl_qspi_adjust_op_size(struct spi_slave *slave,
 	return 0;
 }
 
+static int fsl_qspi_clock_setup(struct fsl_qspi *q)
+{
+	struct clk_bulk clks;
+	int ret;
+
+	ret = clk_get_bulk(q->dev, &clks);
+
+	/* Ignore if no DT clock property or no clock framework support */
+	if (ret == -ENOENT || ret == -ENOSYS)
+		return 0;
+
+	if (ret) {
+		dev_err(q->dev, "Failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable_bulk(&clks);
+	if (ret)
+		dev_err(q->dev, "Failed to enable clocks: %d\n", ret);
+
+	return ret;
+}
+
 static int fsl_qspi_default_setup(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
@@ -829,6 +853,7 @@ static int fsl_qspi_probe(struct udevice *bus)
 	dm_bus->max_hz = fdtdec_get_int(blob, node, "spi-max-frequency",
 					66000000);
 
+	fsl_qspi_clock_setup(q);
 	fsl_qspi_default_setup(q);
 
 	return 0;

---
base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
change-id: 20261120-05-fsl-qspi-clock-e3df6b72ab8a

Best regards,
--  
Yixun Lan <dlan@kernel.org>

