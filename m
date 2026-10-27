Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99F606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U9lSwkud;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LoCOJDbl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3832A605EA;
	Wed, 28 Oct 2026 00:36:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kv4hpZZHKVw2; Wed, 28 Oct 2026 00:36:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64A9E60611
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793147814;
	b=HKGH1hdufBfZm3i4ecZQvfrwu0roLJTqxEx1FbFmhd2Ji24bfS1VuF9K5V008NYsFLJM
	 5hrKcQwVhyHtrcVaGrcR9M7AFvQaRExWR5Yq6CqorBXH5fQtDzSPgoePfVsfh2HeVasfP
	 ztKS53VnNDclFDMQfRpvG19qD9I2ADsF/ai36GbBXdpUYaZIF/hjb2rrXcdvAhCASglKq
	 7cvzPzuDgTcoSDBLkA724eqNg8ac3XYAMEjq59l0ZXn/hI4Q6yKngTrTHLjRKdVfmWCbh
	 jsXF4SOfRVDZz0ByjdS87xYLnuHqB1uOtD+dYNExyzFVFmIqgoH/S9bzbfAeQcYw5WA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793147814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g1EFN/p0nbhG/2b0pt9u/WPyUAmMHFRQxjC+8t+AK3A=;
	b=QI5NdlqpdsawwdYIZuSxmBcxwGJTQmVDCwySuK3Zbj9zgOm5fALRwzuY6HfUolld9AuS
	 WHayMb8bQ91qinEx+IHpVp3WZhiPwOiGUkmu226RV0+br83c++v1bCfskPUKUBu7DmW3Z
	 26m8RoYsrJlKLMh1ptb643zvyGiL7nYfMyrkmmkhH7l+ZgS3NOSfPL9+buQ1xTIwbFsCe
	 e0bfPnCty6i9/0YrnZS85lnBUOa7k8BAPALxYlOVI+LgjpsqZzNJof9BUd6qM23Tsx9rR
	 UWnPVbA9Q8/SHCNw1ypNLw3UXfCEm2KCb1UhW7oOU7QXq/iJPeA2ROUokUueJBpoIVA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793147814;
	bh=g1EFN/p0nbhG/2b0pt9u/WPyUAmMHFRQxjC+8t+AK3A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U9lSwkudbij16gcsM/hU4t3+V9ai14Idf6cuLsyWNuTUFUcK88wE8UYknRgqsKuRt
	 AUWRjVZRPR+yxn2YktlfhzWwWgCiHhRTcLQ6cX0KXqngfNJwpQuPBzz1EJov3vQJ0b
	 DnvKOtyW39MANFn5/YykwfW1UnsJHhZC+TkNTzXz4gKGZMEtyn8auHo3MmQVidTw6g
	 OTWLb836d/iYHMFXaUnOG4vpN/bzYJrAesPNCcT9YvrxkgBYDV3j3LvneOIEfl1KWg
	 uHRe+AMDRjs9IbYf5HK3xCTy7ksXMhBkkz7lw4eUZiAdVQsr1KPl+DXqf6Zz/l1TiX
	 Nu1zSFHpoAF2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64A9E60611;
	Wed, 28 Oct 2026 00:36:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B0BDF729
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 20:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 957CE400B1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 20:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klGXxfm69WuG for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 20:45:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A680C4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793133917;
 b=JkmRQGcoAY57T/e6w2p+rYA/3qIZsGgFHBIqNgBzNE3L19/p/MBdgH9vP6EBC6+0TLim
 7GSryDql7kCRsJAZ2olEBggTiEUDa7zJFlcUu7HJIcRbV6MGkgEnstwv8xk+0BSSKpsK5
 bWUhCVj1xfqZ4EVrXfOFw7V6QBZkE/A0v2wgohRZe6Xepz52Oqq3Uk2N23GjCuv3zvyP7
 5kPDXahqi9PKbnOJ9wBLCPKST8HXw+BTJoDpSWNO4pdv0qRjjWcAahMGwBcOEhiMSkMQ3
 lwYheDetUin2y2RC/p6J56fU13zqOGpyVqwFS8fMK8qFpmUQhLyhmUwI4pXxfgDXQXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793133917;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=g1EFN/p0nbhG/2b0pt9u/WPyUAmMHFRQxjC+8t+AK3A=;
 b=Zi0pt4cc9nXz3h0RVf97VJ+IoZ0cL4ji/Ri8DGJE/5O7NoLnckG4KT0W4XyICTlthiSz
 zgrAgTpnXANi8jx3+Hj1vqyzcjP86aZZF3ckDvXVIelTJP798nmpfgiJtNo+iiKc2x2gA
 VrzVBk18ssATO6LJ7EdnCK2qLQMsKjzPGUlO4/AYVmXlnQRNNudz7JIlF+7pqqdSyAzwA
 tgyimfWnbU1R+byw05YKhp1d7lwoYcywulZ0ogRbCC4nKqlWiWCTP20PImQGawl2XD+Ur
 J9CWTkjg84ACgRhpm7g6ZNhslb8bXToQfY+4NfBdQFE0am1/9swVaKeQmAxu3cj91JA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=LoCOJDbl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=LoCOJDbl
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A680C4006F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 20:45:17 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-91c75267b0fso4880706d6.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793133916; x=1793738716;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g1EFN/p0nbhG/2b0pt9u/WPyUAmMHFRQxjC+8t+AK3A=;
 b=LoCOJDblYoFDHVXJmiM8GBOyqgSqtVd7NPleI28nNJ5focvUB+FyanVJuvBbM2Sj5R
 bus+Ky0Dzdfq+YlVvEgIbQ8Xmsx+6WKYkazRmcBPSlUJfiOghyWvF/gTfhfNgc3PE3Rp
 XD9SYO7qpuju9xXzJoHJ4NpY3tXcuzfdVnuc8yblzvwZMrPZ8uu+PUryXCoxICdTgWbl
 fUMgTQu/lJd3JOvkql6hwB1ZgkXZkIv1cQ42ZiSp8e0MqJGGWhMLRKnzmyDY0ubeF6Vd
 g0g86hHdyGPWTjuvYD5G+yTrkOtfKBPZLOrkyYTmbNnA3RGdRBVeVarzI/NcWtUonMFb
 tLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793133916; x=1793738716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g1EFN/p0nbhG/2b0pt9u/WPyUAmMHFRQxjC+8t+AK3A=;
 b=mOPK41mxIm5uz+JLhS71MH4nDqS2oTo9mnomw6GfO5Vg5V/085JJuXXVvtfQgRzyGw
 fMqFWielGDKofdgqHHN/bSqKvU/7S1Ok2dteCz8iPbCi/BWIX8DPmACAj83ie4uCD+IY
 9EXgOqakvU4ViXlGqXe+5aPaLOAH+zUFVefcclvmrTFlyvJ8PAEdGllNLU/CCuqXgbST
 9wzGxc7U65D/oE/lqlaXUX8b/WfVZ/ume98lA4E6poTnWIXsdm9nTssozgafI5v/4pDA
 bruL8nIeJxuIS+EO5Bm7DSQPOqz7NzOTHYm51rkR/4yUSBort+EM6w/LWAY19boXzQDh
 PzDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQNlampFu6y4nJlllYDv2BFfp8QTXDLWEqpfNq7eDkP8BjEaXmw4bOzlvtMGv4vVGKMmUWRFc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJXho/f/DK+Ly3DdME47h/UNxSgH+Dlx2rPLdyQjAn8D0A0fzDo
 VjN3gmEF0Dhe6gF754fmVFqMo7teEnClvDr4k9fDDxdw07jJBIIsfaKa
X-Gm-Gg: AYBFou3FfBodpLOAT4Ufp7J05JXn9/wFbWGlBf6mIdNE0CXiboGRvyeJPwki91IOlPd
 vsjXr4u0AisMTo6timoTymAZlDX54q92OeY2UVcbcZKLumluG6ktzdim5cOuL7Vc2yjWKa78oDt
 PA17U2kIKE/PwFuuO0WarU++bODe8PWATlwO85lfzZHV4OOyPdAyGEAJe0YbumT4dXiEzlXbjUo
 miXX8SZy4VsXerDKua5di7KFYZm6fqh783qYqsLvTdEim20XlV+2TBR/8HVBO0ghD6YV2Pe8k8L
 rCrGjFqgkTjO+bfb/dIjfB3d4KqSBThnUNr9SverYpXZjILMm2pns1pfcozUYsuujem0tYedsH8
 WF8NmPF3QCKmJdkC73u3hDiSmPSeXyTyFPsdW/n/pbd/QjVBK+k/RaKB/E8h+DxWbiMn9aqz2TA
 XWXOo5kIFmhA7Inu4QBR8SxxMIE8MAIILRZmFkC0RpSpljqngm6kILe9N4bixYiw+/bzpsudmvz
 81Q4Pa+TKWzOa0cI0RZ93KJzuGk8EpD6FqMGvU0jKav+5wBioe7n+coyGlhyFAmyW8xYqnNaSDG
 N9M=
X-Received: by 2002:a05:620a:838d:b0:93e:f4f4:346 with SMTP id
 af79cd13be357-94408a96a06mr17271385a.39.1793133915890; 
 Tue, 27 Oct 2026 13:45:15 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47bd01cdsm111161496d6.7.2026.10.27.13.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 13:45:15 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] net: designware: Claim the reset GPIO in probe and free it on
 failure
Date: Tue, 27 Oct 2026 16:45:04 -0400
Message-ID: <20261027204509.143007-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 00:36:52 +0000
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

designware_eth_of_to_plat() requests the "snps,reset-gpio" PHY reset
GPIO, but the driver never frees it: not when of_to_plat() itself fails
afterwards (no "snps,reset-delays-us" property), not when the probe
fails and not in designware_eth_remove().

When DM_DEVICE_REMOVE is enabled, a failed probe ends in device_free(),
which clears DM_FLAG_PLATDATA_VALID, so the next probe attempt runs
of_to_plat() again. The GPIO is still claimed from the first attempt, so
gpio_request_by_name() returns -EBUSY and every later probe attempt
fails. The eth uclass retries the probe on later network commands, so
one failure, e.g. dw_phy_init() finding no PHY, leaves the interface
failing with -EBUSY until the next reset. The same happens when
eth_post_probe() rejects the device because it has no valid MAC
address: device_probe() removes the device again, and once ethaddr is
set, the next probe fails with -EBUSY.

While the GPIO is claimed in of_to_plat() the driver cannot release it
on all of these paths: failures in the glue drivers and in
device_probe() before the probe method runs never reach driver code.
Parse the GPIO in of_to_plat() with gpio_parse_by_name() and request it
in designware_eth_probe() with gpio_request_parsed() right before the
MDIO bus is set up, as doc/develop/driver-model/design.rst asks. Free it
on the probe error path and in designware_eth_remove().

The parsed spec is kept in priv next to the descriptor rather than in
plat, because dwmac_s700 allocates only a struct eth_pdata as its plat.
The glue drivers do not use designware_eth_remove() as their remove
method, so removing a glue device still leaves the GPIO claimed.

The GPIO is now claimed after the clocks, the PHY supply and the default
pinctrl state are set up. The PHY is still reset through it before the
bus is scanned for the PHY.

Fixes: 90b7fc924adf ("net: designware: support phy reset device-tree bindings")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/net/designware.c | 22 ++++++++++++++++++++--
 drivers/net/designware.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 9470804ebd1..378586c708e 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -972,6 +972,15 @@ int designware_eth_probe(struct udevice *dev)
 	priv->interface = pdata->phy_interface;
 	priv->max_speed = pdata->max_speed;
 
+#if CONFIG_IS_ENABLED(DM_GPIO)
+	ret = gpio_request_parsed(dev, &priv->reset_gpio_spec,
+				  &priv->reset_gpio);
+	if (ret && ret != -ENOENT) {
+		err = ret;
+		goto gpio_err;
+	}
+#endif
+
 #if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
 	if (dev_read_bool(dev, "snps,bitbang-mii")) {
 		ret = dw_bb_mdio_init(dev->name, dev);
@@ -1003,6 +1012,11 @@ int designware_eth_probe(struct udevice *dev)
 	mdio_unregister(priv->bus);
 	mdio_free(priv->bus);
 mdio_err:
+#if CONFIG_IS_ENABLED(DM_GPIO)
+	if (dm_gpio_is_valid(&priv->reset_gpio))
+		dm_gpio_free(dev, &priv->reset_gpio);
+gpio_err:
+#endif
 
 #ifdef CONFIG_CLK
 clk_err:
@@ -1021,6 +1035,10 @@ static int designware_eth_remove(struct udevice *dev)
 	free(priv->phydev);
 	mdio_unregister(priv->bus);
 	mdio_free(priv->bus);
+#if CONFIG_IS_ENABLED(DM_GPIO)
+	if (dm_gpio_is_valid(&priv->reset_gpio))
+		dm_gpio_free(dev, &priv->reset_gpio);
+#endif
 
 #ifdef CONFIG_CLK
 	return clk_release_all(priv->clocks, priv->clock_count);
@@ -1061,8 +1079,8 @@ int designware_eth_of_to_plat(struct udevice *dev)
 	if (dev_read_bool(dev, "snps,reset-active-low"))
 		reset_flags |= GPIOD_ACTIVE_LOW;
 
-	ret = gpio_request_by_name(dev, "snps,reset-gpio", 0,
-		&priv->reset_gpio, reset_flags);
+	ret = gpio_parse_by_name(dev, "snps,reset-gpio", 0, reset_flags,
+				 &priv->reset_gpio_spec);
 	if (ret == 0) {
 		ret = dev_read_u32_array(dev, "snps,reset-delays-us",
 					 dw_pdata->reset_delays, 3);
diff --git a/drivers/net/designware.h b/drivers/net/designware.h
index 3618300f4c5..072e97ff89e 100644
--- a/drivers/net/designware.h
+++ b/drivers/net/designware.h
@@ -237,6 +237,7 @@ struct dw_eth_dev {
 	struct eth_mac_regs *mac_regs_p;
 	struct eth_dma_regs *dma_regs_p;
 #if CONFIG_IS_ENABLED(DM_GPIO)
+	struct gpio_dt_spec reset_gpio_spec;
 	struct gpio_desc reset_gpio;
 #endif
 #ifdef CONFIG_CLK
-- 
2.43.0

