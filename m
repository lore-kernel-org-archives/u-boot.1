Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911E606A333
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xFtc1PQk;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3UpnGbS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CA8E606A7;
	Wed,  4 Nov 2026 13:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJMM9SBpx76u; Wed,  4 Nov 2026 13:00:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DEC4D606F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793797215;
	b=a9FJdEplZdWtohC+vbIPqkXLFUX2HWMY9hdoJqA05+I3HFBiLdVa9iAnNUCR/hZItbwp
	 3tBPx4meQaX+FbyeAZkl3WTGhGhYuzfRcnIQLZYk/HFmtI9iwl7zZH8BZ9PiN0gEewidE
	 G3DL5hm3JB/E5Q8l7qNTMIwepiTlkWbAeKiEW8kwVroJnuuvZSgkLIO+yDEE8vT9BbneM
	 U2Pz3KaYPHih4h4mZ3/xA8BjwB0AQ1nz345n2NXrAT4d0zPtF6d5aQLpJ/GG+8dFXmWYM
	 u3vmiiDdyPF4FHHlhypC92u5IsET3cfWRRWsZQRyAh9fHWLbb/EzORoVk0u/d88wD/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793797215;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=61eQ+9KyamuhStBw05JYUvJXna3GLw5FPMpoIwsMS9o=;
	b=UMOYbd56Ml98an5l4g/Zrwm9gXV1TeUlxnVHyzO1h+hhkSBslIZvCQsdLE23G3SSuQFl
	 Q7u3NO2jICH7HhZdRRpqOVoEtli6Hh3Kg46PNAxU3785jdZlMXr7KlMfRtKD+DeMkiAms
	 N3krps1NUPNdIoMHrzoSn2TrUFYfH+DZcj67sf81jOzzvmBfZ0C71Vc54to1L9lF1bwCp
	 XeastkDgFZE2I2XqDJTV3b5fLklsJ5WVAw6J7bX+i4csUm5rUI6k4tTmINcv7MzDBvHOn
	 YyWfGgqysGQ0zs7Q3v41o2Ecld4OYkHQy/i8NJfuIfpDYQw7kQUSF/x2bIo1pQluLvQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793797215;
	bh=61eQ+9KyamuhStBw05JYUvJXna3GLw5FPMpoIwsMS9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xFtc1PQkGyVEUOiS1wNxTSQKwy7fNwwtz+blgSAtpMMd/33kbB+WAr7/FA3HePtct
	 vnhcArAtzjwy2q0Ej3k9oJ+BJ2QZ9rEr2sy2HqFvb/LeYd6vF373sFQjXBKnhKK1ht
	 IN5+yMx+EJl/sEZZGTcQjiAfgd27+RavIl8XMJscf0lfL8/tbGwTZcakVvHvvnJ1cA
	 Xhw8r/9CSu2ao+wFPBG3lGyalkpzN5aMijEB9xJMz1bLRihJHfSd9FZvk7UeDeF0Ci
	 8FzW/50VrDah2dsvB9V4hNNEsUoESwoqAVTeATaAXtrs7kd3etzHEa7SJ1YOUPnPSU
	 knStWvYZGDm6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEC4D606F2;
	Wed,  4 Nov 2026 13:00:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E513FA14
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 13:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4EE5406DA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 13:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aT2UZfuY--uL for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 13:00:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E73A040731
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793797210;
 b=g2JAZZBDOGRmnGb5mRjj9Unp6g23EB+oj3Uj+bYq88UB+q/xwpzRYJ4Pk50/SBLyYNbH
 c77QiX6qIIMG+XL1cp2DY1E7Q2cisS0sMUtnCdoQcVux0rXcb9Cl/SD2NfEr5hbw0aWHu
 e8yFF4OIKQEUFU2RFJKJ7KpaJ0z1O7y0TKZFkpUKXM6pDdOUQr9hHJaiPxUArrhm/xtrc
 dizR0PawIX9YTAtVJNun6CJGRkOsl8ggVXOzb+DvvGSzoAqrGY/B5l0PwANLJVwKUoGCm
 XlNpfHkveTynW64Ye4N5yGusNZFepIH/UVd8lErEncnvvkueBQMs/oo29ppvFZ4k2dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793797210;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=61eQ+9KyamuhStBw05JYUvJXna3GLw5FPMpoIwsMS9o=;
 b=G4G+Q+R9OYQ5NgC2n3BKZgDONB2mn1zUuV01vYOoh6w5XzWcnmFXXQb29loLaupAbZnB
 9UkTFd3FKRiE4e+GfLWhgyJL2LsnYA98UJBe2aISWto81SrxMJzyJksI3JtC5vyfriPMg
 sfK9QIkIqlH7nhj3QorNAeR9sVUoVniOPFAv/7YP6pzP4EvUz2GICELetTrJS3xYy5A/i
 M7zwjgWBkrEIgP1MirMjTR+3FjxYjRECYtBMWGwu3KdnJNmWjHv1G7iI4s+9V7b7a+sDe
 x0lCNVL1tNHBhEoeUtncI0q+U+Sb/QgWmZmMGMSMxIevTt6Rx1nr16/ef/lZHZ8yLUQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=A3UpnGbS; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=A3UpnGbS
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E73A040731
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 13:00:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E3F461415;
 Wed,  4 Nov 2026 13:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CCE1F000C1;
 Wed,  4 Nov 2026 13:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793797207;
 bh=61eQ+9KyamuhStBw05JYUvJXna3GLw5FPMpoIwsMS9o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=A3UpnGbStRrP6gebY3gEnYD9yNcwaMcz6BsEUYcg/O3EtKSIl260XUhlkMwSvtrcZ
 BENYfP4/yH/TtlcjhTeUD2kVNE7/Oz6IJCBPdM1K2s7csEeb7FmEpqz4GGNADp7wym
 o12tui572Dx20hsg2oCCBaf3OPD/l/bI1vLIMJfJVZH6x6y0niT/v7W4X0wBiDVY1c
 KAcS6+bBAx0n97iHPDpzbQeaUXr7Dsk90ZW+Jy8dPjHikoZo0ebMOw3mQCNxvtPKHl
 mdO8IKUjzguRT4AcAnrTaDLyUGsJNkDztuo8T715aD9BKzTKhg2kYwQ6/xA/qSFFlc
 UDcGOtfzWK5mA==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 04 Nov 2026 12:59:51 +0000
Subject: [PATCH 1/2] gpio: spacemit: cache pinctrl dev
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-02-k3-gpio-pull-flag-v1-1-de9f0a9b7669@kernel.org>
References: <20261104-02-k3-gpio-pull-flag-v1-0-de9f0a9b7669@kernel.org>
In-Reply-To: <20261104-02-k3-gpio-pull-flag-v1-0-de9f0a9b7669@kernel.org>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=dlan@kernel.org;
 h=from:subject:message-id; bh=7MRSxoKpBY3gTETgYSbX9fhUi6wT236xJVOQTPlCU7Y=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq6yxLuMTkDItGBYsbGOXzDkH53vbYCi8BkdIUJ
 sJ3JfBtrVOJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaussSxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2ZMQ/+IIFoG0QxJ1Q0Bd6ZKMOuKNzByfbNJ6fnvLmF3oyyH8BmxnX2r9A34
 N6Nlvqjr+QzpGHu62Sy+BUC4zQ7K6moIr7ekuQOL6oSlWlSfdSliw+ebn8+D4wIvUkNiuaQuOl/
 QEOh5SRiQwP3ZbFx+KoBJ2CF0BJtXhMx9B/bQhLDlcHXjPure/eg8Sx4Ee4ImqAVvh6BS/VmsvX
 bbrBleDk9CBR6Vz0F1lL+UzT+PnlhIQMAPZFyYMRJqC+0AG1QXVc9J4bWO52emFHD0ENJsf2m39
 p1gSrhX6mHEciDtIBfyC4Wf/OXeM+huE9ysMm9gaJFib+sHtFZyNxC2FDxN9Q5A0SXZDHHLJH3L
 3y6QqeCiMTkSMfrUM90ZEsPlGx8wOKfWcEaziEzOOqRsbl/qbrmS7HiJ6xNuqGi108YWOeCRsZm
 onxPcvKZp9kVXrEOEgWC6ECdPOMq65cKIGXsUdU03qp26+6fdFqT8v/Gmv9gqgmZlCqAEzu/6bG
 qODjJHPSXsKB9LAWkDhgwzAGb36NlpWxzbR7h96PlA27tGdBLkyGo8JX0fqDQD1dLUfRsF1Isqt
 iTIkDHfSRA9i4zUXptbnLF9oyF35vzMwr8zEyccqtCnADataJ3EHbS4CIvK774q/VMhTJJHtrVE
 eQOVjIxIs2NO+//plJB6+Hwu1F/CgA=
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

Cache the pinctrl device during probe phase and reuse it later
for bias configuration and GPIO request/free operations, instead
of requesting it every time when needed.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/gpio/spacemit_gpio.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/spacemit_gpio.c b/drivers/gpio/spacemit_gpio.c
index e0716a84dfc..6c8184a9818 100644
--- a/drivers/gpio/spacemit_gpio.c
+++ b/drivers/gpio/spacemit_gpio.c
@@ -40,6 +40,7 @@ struct spacemit_gpio_data {
 
 struct spacemit_gpio_priv {
 	void __iomem *regs;
+	struct udevice *pinctrl;
 	const struct spacemit_gpio_data *data;
 };
 
@@ -152,13 +153,9 @@ static int spacemit_gpio_set_flags(struct udevice *dev, unsigned int offset,
 static int spacemit_gpio_request(struct udevice *dev, unsigned int offset,
 				 const char *label)
 {
+	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
+	struct udevice *pctldev = priv->pinctrl;
 	const struct pinctrl_ops *ops;
-	struct udevice *pctldev;
-	int ret;
-
-	ret = uclass_first_device_err(UCLASS_PINCTRL, &pctldev);
-	if (ret)
-		return ret;
 
 	ops = pinctrl_get_ops(pctldev);
 	if (!ops->gpio_request_enable)
@@ -169,13 +166,9 @@ static int spacemit_gpio_request(struct udevice *dev, unsigned int offset,
 
 static int spacemit_gpio_rfree(struct udevice *dev, unsigned int offset)
 {
+	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
+	struct udevice *pctldev = priv->pinctrl;
 	const struct pinctrl_ops *ops;
-	struct udevice *pctldev;
-	int ret;
-
-	ret = uclass_first_device_err(UCLASS_PINCTRL, &pctldev);
-	if (ret)
-		return ret;
 
 	ops = pinctrl_get_ops(pctldev);
 	if (!ops->gpio_disable_free)
@@ -224,6 +217,10 @@ static int spacemit_gpio_probe(struct udevice *dev)
 		dev_err(dev, "Fail to enable bulk clks\n");
 		goto out;
 	}
+	ret = uclass_first_device_err(UCLASS_PINCTRL, &priv->pinctrl);
+	if (ret)
+		return ret;
+
 	return 0;
 out:
 	clk_release_bulk(&clks);

-- 
2.56.0

