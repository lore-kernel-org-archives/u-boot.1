Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966566082BCD
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JXAEE04O;
	dkim=pass (1024-bit key, unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=VzqGk3n0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55571606F6;
	Tue,  3 Nov 2026 09:53:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 24yHPZD9Je4K; Tue,  3 Nov 2026 09:53:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A3DE6606A2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793699620;
	b=JefjlmmywWLou+x1brVMSQbUpXj7oL9cT6yMESCLdABtumkoYjksHa1m9+Orp83XGJln
	 Hwt39Vy8YV8xZZQmZKp/B3WooOWL1rALkuJXUdc+XGCuvgHNhNZBbhkbxYJgiGnNzu39t
	 rccnPbAg9gfKecXtOarDbYAM1wSInFwck+pQb//oLJzoAkiXe7mx9reXYckanFjWuQael
	 IHHx1lNn8UJnKyOfVz3gcHCe5qIDyhxXhb0ayp9g5qc/dhphAG38Ht/JIdFRzD1aUbevX
	 iUasEcDXDJod3bR4VJztJ2bTobMGT/SNlCHclkiFvvCyIaD1MBoFIISDPfVKZZUm4Uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793699620;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/5Q+tNrpkgYhnNo1ZhVBuZ8iquGdXCfX22W4C9iCuR8=;
	b=Kg268uK0spNIW+V8asV/WETejRVcB0AtsJNkpa+YxtwLbRA4gn93GuBv/8RBfQgswUvf
	 lJJ6wywMbXKk/HTHD0fmHQBOSpRssV72xs7n/C79DfH9ftbNqhUzZl7szVqBdikO4BD1y
	 8PXtszRw5ltOMYnYzXbiWzjXFGpCi3WwTTS2LCAER5nTe4Rh0bd1MlCKbiN9cLWfcpUiV
	 tZ9qxTFYKJ41rqSbiviZPOzf85EAnc5Jq1UaAN7GtFQXd+tq0VlmBQqbxL2U1pSpFQfI3
	 n5NukjRPft+jTaY3d1OJa479In9dApe+C3NRixejjp9wutUnimXpASnfsGN2bIjF0UQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=maquefel.me;
	dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=VzqGk3n0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793699620;
	bh=/5Q+tNrpkgYhnNo1ZhVBuZ8iquGdXCfX22W4C9iCuR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JXAEE04OU1k72MesyTwOY18bLa8Nz2um3YOfLW4uOwD+LR/RktrWUmWOkc1nSjveC
	 nJviqfMgg6b+4DxPaXcsSPH1Z/woNFg0m27oUfTR/wE0kVZGb+LLw2RO7J842uXYCl
	 qKkKFJZ/w3mIT8iHcZp4V0tGCXp/W4f2Rz2aN/UcUDBbnrX0RQ4gJJ8xu5HQx4pcIO
	 wQjaldgcRqCMRSlJprLOevQVBEtoy7iZwjzdN9a6V3ASNmX4HeK3o2TNU8pxkku9qY
	 C9NM8YDWTzadLV65rp8WiimlXHjTV68u7HDT5hRopAa19TAHuTaMkn4i712jG1eXq+
	 2Dd3EJtL3+L7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3DE6606A2;
	Tue,  3 Nov 2026 09:53:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 057F5235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB5E46069A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A_ttGzoHJ1tM for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:53:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 51758606A0
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699617;
 b=DDXw9ztKJX/yV2m/Dgve7Pomj081RYE/2USI/bG4nNy9Urj3Tpp0I90YKEQQOc6/qyny
 L3nHkyYvpRrMscvAbJQIp5mKVYqdowggMzmPhtNtv1YBEUo5VJzvTxNtCeX6NzvYJa3pz
 t/283CXIkZgflpprJBhfHSwQkiJGe0wd+bRBCIfh2rSLewIu/6feuW7hdSRuyIiMkjzos
 5sHOM2Tx6q9lLGXRgNZL/LrJ2CCw+dsegMsUh5wb4Nme0PklEaCtcQuCGHyr5WLj+PMbM
 gkBs+0bjKbibbAAP/tebTisclXCo+g9P/1Wa5mXr0HyEq9r/AseYdTouGmGr48cgd0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699617;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=/5Q+tNrpkgYhnNo1ZhVBuZ8iquGdXCfX22W4C9iCuR8=;
 b=RCyexCTLObhbb70ck119kds6tJlkafbeySX147S9BLww3RQDxS15v9phXzUYoJyeVwuZ
 bZcRO4XArSqvZO7rLy5WO+2Pb4eGmVxnpvvuFiuqx+jA+Q5eSi0eH9MiIiViHprS/Yn2M
 TYt02itKYrqUe0VG3kHhRiybaWTg2wc67UPJnGrSl6nmcg9Lm1QtU3rpjl5Ce9ahfTRve
 RkpUzGJZ65dDNnJ2/iGcu/6Wuimf6kCYfSRGGXZqgFlTOAEXO0b9CE3Lj7Z6MpezCBEmJ
 ITGocMATSVPnQENtoMwJCIgYCmiVAltQIu/GDLX790rdAsWTNu2Y97cPfSEeAXD+zyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=maquefel.me;
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=VzqGk3n0; 
 arc=none smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c0e:500:1:45:d181:d102; helo=forward102a.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=VzqGk3n0
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51758606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:35 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-70
 (mail-nwsmtp-smtp-production-main-70.yp-c.yandex.net)
 by forward102a.mail.yandex.net (postfix) with ESMTPS id B9B0AC0C2F;
 Tue, 03 Nov 2026 12:53:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70 with ESMTPSA id
 OrH94I7pRiE0-dvSBKYvI; Tue, 03 Nov 2026 12:53:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1793699610; bh=/5Q+tNrpkgYhnNo1ZhVBuZ8iquGdXCfX22W4C9iCuR8=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=VzqGk3n0JFsv6ujWlYaKRbNk9Ojx3CgU+zz8QPnOd9El7B/XHufMMADE3D+7vd/ib
 9rplbo218lHBibkOVOqLKtUQuHpD4pagV2738JzkzsE0gToQuSTWVZ+AkPJsFO8GQs
 V7Z49W0xnFjtX75VUiOsyAjUGopOqr9k9JbkfJwk=
Authentication-Results: mail-nwsmtp-smtp-production-main-70;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Tue, 03 Nov 2026 12:53:01 +0300
Subject: [PATCH v3 2/6] common: spl: ram: Add LOAD_FIT_FULL support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-riscv-full-fit-support-v3-2-e1dcdc9638e5@maquefel.me>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
In-Reply-To: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793699606; l=1063;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=CxCY3471A3B5kKnJnj80pcsNBt3NzhxOKfj6A5hMkEo=;
 b=4EBGvpheJ01Yz1pclosSeH7l8ZkLftl5E2OH0Fh/Wjo+fksNF/ET+QnIiAtus1UY7l+nzF1yy
 42es3VWdRMsD2Sr3adui7Y14s6qYNWg/YuiL5i77uoFPrp8Efa1eL98
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The simple FIT loader lacks support for full image verification
(CONFIG_SPL_FIT_FULL_CHECK). The full parser (spl_load_fit_image)
provides this feature.

Enable it when CONFIG_SPL_LOAD_FIT_FULL is selected. If the full load
fails, fall back to the simple loader to preserve compatibility.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 common/spl/spl_ram.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 0c501cf02f2..641aff6efca 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -84,6 +84,13 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found FIT\n");
+		if (CONFIG_IS_ENABLED(LOAD_FIT_FULL)) {
+			ret = spl_load_fit_image(spl_image, header);
+			if (!ret)
+				return 0;
+			debug("Loading FULL FIT failed, trying SIMPLE FIT\n");
+		}
+
 		spl_load_init(&load, spl_ram_load_read, NULL, 1);
 		ret = spl_load_simple_fit(spl_image, &load, 0, header);
 	} else {

-- 
2.55.0

