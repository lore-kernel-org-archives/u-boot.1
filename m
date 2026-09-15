Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C27CC88E73
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 08:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4C0A40526;
	Tue, 15 Sep 2026 08:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E8lRzVO77JiE; Tue, 15 Sep 2026 08:17:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 12287404F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789460231;
	b=b+Bo3EJ245bcXJBfh1QmiNXMm6Jb1eTh0L4kpE5pQVbid8TJ5iB9hDyPuBUYyJv9EtCz
	 wSwpqQxHpDJhaf7U90hq6KW5YVXzW6icHSSVGUXp2wdQkLlAdAfS0I6jVhsQC6LjKZFTN
	 tF9meATOSoGMRwfGOXsw6SdD/Ynm+UzyGgGZgyRkeakz0N+1li+jEWhV1p8+HAe7uo1IJ
	 A0Pn4tR2tW/F4LHETY/O+hZu7ICYcXQoCDJ9OQe1Ft9c4fVofV4XJAjw1bZudyXocY2lB
	 ew387Viogy/mGgALMBLb81/KfRjZlGS8+PdQSB05WCkiw1lDdNjSvhCjUGXGbfLGawg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789460231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dW0zAKmd7zPVsBsPsGqrganyHMf/DISg3kwwtxIJjnI=;
	b=CCG+vhL15GQFGo9cutZQEwkyEqfbeep08jp11VrYEywdyd8IOtM0d8AR5DPa8VT5EltQ
	 AAEjaSVAcHaAp2P9tznMFTV5pHLLkVoa6204dG7k+i7ZNdE03g+oK9jV9v2Pqirn3ajRn
	 6/hdh0y/qc3WvbcGSAkBx2EWv2gTnfllT3yf1Ml4Yeo1drICxkAKN9hNDMNwf/BsCVyBq
	 i8sBVG69QL34fL2x+nn5PHHQC2rbeR55iSijiwOJ4K6DQ5cGX3FbPOsWyvJ412RFFNi3J
	 ZbWT6RQ1f6vPe4CTolcqykN9hG/v2g/N6iLQWmr8/+TCVgviG2cUyJPXejAs7z/OCKA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JVkjAaIY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789460231;
	bh=dW0zAKmd7zPVsBsPsGqrganyHMf/DISg3kwwtxIJjnI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=II3q64W8eUl164XWDzWGARP5klEHlmx6mrC5mkwNNl6GqwPJ1WF+Nou7nVwwYaxfv
	 9NU/5L8CMrxLUs9AhDvYS2cuyuca5qLwUZ8p2KJ+Sl7rFJsXMAyl6mLYclCBWNEfTM
	 jlJlv2nCzitznoEZ6MnoxFecGvaOBTCpBBn1Gs2ks3PmMVrhI2bbNBwGgVWBWVK9k1
	 LzP+CGJKP/hyqf/De8Mr5CuVfMn81RhIQWL3rPQ0RoP7JelXl0wt5/xr/+vA5PoyoZ
	 2WBJcN7uHnzrlxApn/bR1SIUQr01azep/VMDfZ4A+bJjzMcTo6AdbXDci7ChXRo4eC
	 c2+L8aS/QPA0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12287404F4;
	Tue, 15 Sep 2026 08:17:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B122465
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 40A8F404F4
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oLRkOt3p5BBm for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 08:17:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CDFC240475
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460229;
 b=CAh4tEAMkDfTE91R510p5MdeKBWRGDvoISFwqcOaLz5luabu1I8NoB/Lbv+n1p1nz2ld
 jz6gySdLsyD/0Xj8a4EF5VyxF3+7nn2y4Y3sMx9OgtenzDCjagO4ZG5y6hZnx6OwCBtIh
 d2S29IukrdFPnaklnTxrYEBO1G/nuzQAlz+FyTPo8DbMzic0EzVKw1rMpLgSjQ8+G6beD
 5EpzzOey/7ZdJ2DkzqVybilzGzHPoji6fNQNa28jdsMEr3VIUY9UJDeFWkNZwyYwhfOZD
 w2HiVWeLka5gEDJtN08z8peVTFMpZcIyKiHQwnijYeQ+XQkK5jCJ41211ZWtGD9K2IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460229;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=dW0zAKmd7zPVsBsPsGqrganyHMf/DISg3kwwtxIJjnI=;
 b=E1rr5YJfGQF/ZudvIXzFYnPISYJKCkfjRHQpGNI518xU4VSxHgu85tgnFbkL86VDTdkF
 6mXxsuLcAMl2JPvMt1sjIRJRcSP0m3/YeVvrLa9lLgB3j+tTF1/MEd1mpmxTuuG0bkv4q
 RKnhpAnUN0oGcw2+E3zYWN4unM6O8V2q2rUBs0OfdjbFS7ZAVryxhrG0X20VOau/fI88V
 IaE9ne6Pyds4pzLRS/4T+N7vSISJyCld1AQANUMqa6sfKbE+ETTdmTkifOYfopA/Gfh/Y
 cNasL2pf1vRKETGAkTDc8HGMYEFt5f6AfyhHoDroX8gT0bKTEnX2xJgiFHDag9yJKNg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JVkjAaIY; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JVkjAaIY
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDFC240475
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:17:07 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6356256so1045884f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 01:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789460226; x=1790065026;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dW0zAKmd7zPVsBsPsGqrganyHMf/DISg3kwwtxIJjnI=;
 b=JVkjAaIY3Xl5aXGhXaRCmasSD5tZ7e7TkIkOseqn10Qw6g7pFLJ5lPbCdMHGUU0gNO
 PaVzZAFYUxSGtmLT9pMlwVMR9LtZGMtm3HyCi6N/YZu3cpUY4gI2TympnxuJxhh9Rowe
 bhAgYs8DfcB+Dy/qJNMKNuc4gbB5Tpedh3c82sFq8vzbSUKuBRMav4V8jM9rFhMxybur
 N9H3qvDAR6/sOcApXGE2YxE+XCA+7EotPzVDNHKsfDXUCiWojUJmAnplSrGxUYXg7s34
 rMuViJqBVTHe9293FIK0YW7+gV/9VIxyvJT6/wXInHAH52uk68tC00tLf6eou7rTU8N1
 hC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460226; x=1790065026;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dW0zAKmd7zPVsBsPsGqrganyHMf/DISg3kwwtxIJjnI=;
 b=zrWAk0tLWVsPwrFgfsfBcQpcp28CbXX/ZgAyBwUdgAql/KoGshmqxXKjDl2MlLE/jE
 9vqWREPk4EH3k/h1dz/RKwZPVQefcdM9ZeyialvTr06BwQJGHiEIWR9yybu6D7tLFULh
 tPtI4P2FgsTEb3w5WBN4CNuSwOxNxgQnnusYxcdACrydxXejc0zcq7CyMPTrpl1x73Ms
 wVO/JLAaKrro/MMjEqH68+aIHiiMPkfBLz7tHPON4L+etqWOPKx6WT3MbCIOL6JZWckp
 QGTCGqD4VTSLJ8Nb86/YVDcEeNRJtj89TCelq1NstGLiJfyWx9gvBZh0LbXWINwPb4My
 DO6w==
X-Gm-Message-State: AFuF++kxLiXLIqEl3kr5cK81PxuyyKFFmjW6luOdQIhV+LtPk3CqT9BU
 E8FKkgHDcB74a9EbHvwhTI2mnFMOv4hEa9E7YPL5GLeDNgernhWgZ+bJ/PfkzjzOp8Jtfx+jYX2
 LRXCC9qY=
X-Gm-Gg: AYBFou26tyt0sGHy28U75/R3yK85fNpNVvYd4N1cXYuhWuYUBEGdKL6L2Wle5z7UwOU
 pa5Cm2a19VH/phkBbL0CUXH4pNjtg0NuGji+j6w7Wv/FhPEE4OKAPNg7kEbess5+zFV4806LAIZ
 lbu3DFreMOrXLJJT7LPF8xTReo+innm3D0QNayTn7Vruzyd+rn/y2NuUxd2JEuYV+dEDa6OgBjG
 r314RO+ylpIqGJXAmf0TbiFaMh+uZvpu+WUIwedAWYqVEQrHMOCWbYYWZZiHaLlONtvLIm4hmNM
 A8DkdpaOnao78jep9Ofh0qb586WWuddZOP0WymLqDz7fOQGuRJU8o0ZkOUGpy9c5Plp87qGXvtz
 6XYnTqfPl2wBfj+NI2jxiDknfZXlv5bjuAZKxqwMdVC+yX0kEP46wky5NndGwAVV2KoGFWFdQzX
 xl/3mwdysi/EgukoFYqGo9X7GlMPfDoOG3vqqg8DXZDtTXg8K/Nb0YABricZ9LQ+1Vs7FXVPVst
 TSXrQPnPjq7Rlh/ByIas4XpRig1+bShTYvA+e6mNxnVB/NtBo4sdAYiGxUdf8nJvVYWZVhn/s3Y
 inXoSWg2pVcwbkr37ZQ/wcFBG1EihX6jrxO8amIxRS0uaWYK5yQE2Ew=
X-Received: by 2002:a05:600c:4f92:b0:49e:63cc:6324 with SMTP id
 5b1f17b1804b1-49e7d72afb1mr40603895e9.6.1789460224889; 
 Tue, 15 Sep 2026 01:17:04 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d6bf4desm65319565e9.15.2026.09.15.01.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 01:17:04 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 15 Sep 2026 10:17:22 +0200
Subject: [PATCH] phy: reject drivers without operations at bind time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-phy-reject-driver-without-ops-v1-1-64bb49f7ba13@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMAyA4VchPduEkQbFVzEekBVXD2xpB2oI7
 87Q43f4/xWMVdjgWq2gvIhJnArcqYIh9NOTUXwxNHXT1p0jTOGLyi8eMnqVhRXfkkOcM8ZkSNT
 6Czl/Jt9BeSTlUT6//+3+t82Poz6msG07IbVp84EAAAA=
X-Change-ID: 20260914-phy-reject-driver-without-ops-446d841d74d9
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>
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

phy_dev_ops() returns dev->driver->ops without checking it, and every
generic_phy_*() helper dereferences the result unconditionally. A PHY
driver registered without an operations table therefore faults on the
first PHY access.

Add a uclass post_bind hook rejecting such drivers, as the pinctrl
uclass already does, instead of open-coding a NULL check in each helper.
Return -ENODEV so that lists_bind_fdt() only skips the offending device
instead of failing the whole device tree scan.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
While developing a new PHY driver, I forgot to add the ops table, and my
U-Boot crashed: phy_dev_ops() hands out dev->driver->ops without
checking it, and the generic_phy_*() helpers dereference the result
unconditionally.

No in-tree driver is affected today.

Other uclasses, such as pinctrl and remoteproc, do this kind of check
either in post_bind (pinctrl) or in post_probe (remoteproc).

Add a post_bind callback in the PHY uclass to add this check. A note on
the error code: the equivalent check in the pinctrl uclass returns
-EINVAL. This series deliberately returns -ENODEV instead:
lists_bind_fdt() treats -ENODEV as "Driver refuses to bind" but does not
break the boot, while any other error code interrupts the boot. IMHO, a
PHY driver not binding should not break the build. Maybe pinctrl should
move to -ENODEV too, but that is left out of this series.

One note: I checked all 9 members of struct phy_ops, and every one is
individually guarded (of_xlate, init, exit, reset, power_on, power_off,
configure, set_mode, set_speed) and has a fallback return value. This
implies that none of the ops callbacks is mandatory.

So maybe a better fix is to add a default empty ops {}? I would be happy
to switch to this if necessary.
---
 drivers/phy/phy-uclass.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index f8d4fb3b41b..6ba4cc593df 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -85,6 +85,20 @@ static int phy_alloc_counts(struct phy *phy, struct udevice *supply)
 	return 0;
 }
 
+static int phy_uclass_post_bind(struct udevice *dev)
+{
+	/*
+	 * The uclass dereferences the driver operations unconditionally,
+	 * so refuse to bind a driver which does not provide any.
+	 */
+	if (!phy_dev_ops(dev)) {
+		dev_err(dev, "PHY driver has no ops\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int phy_uclass_pre_probe(struct udevice *dev)
 {
 	struct list_head *uc_priv = dev_get_uclass_priv(dev);
@@ -552,6 +566,7 @@ int generic_shutdown_phy(struct phy *phy)
 UCLASS_DRIVER(phy) = {
 	.id		= UCLASS_PHY,
 	.name		= "phy",
+	.post_bind	= phy_uclass_post_bind,
 	.pre_probe	= phy_uclass_pre_probe,
 	.pre_remove	= phy_uclass_pre_remove,
 	.per_device_auto = sizeof(struct list_head),

---
base-commit: 5437f0d7943e352ebe126f66275edf4f8206b545
change-id: 20260914-phy-reject-driver-without-ops-446d841d74d9

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

