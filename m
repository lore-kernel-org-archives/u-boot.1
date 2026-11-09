Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D96E606D839
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pbz9ed8V;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=jSws6LfQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20A3C40766;
	Mon,  9 Nov 2026 14:23:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zjMzEqbAyjs2; Mon,  9 Nov 2026 14:22:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E27040761
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794234179;
	b=YhkFk1wiNFwRLD9HqMKPgeEu1Wx54ZYDCmaoXhC7tSz66OFFGPaM8zLhxGl+eYS6OidF
	 LPhQQuZXCFqwRaWVCVIi0F/ocvcizDP6iWpB+XogczBROuA8XMVB/hrxgnL04LoupzdRs
	 cqCafgqXJ8oEW2bX1Gs8LdNLSZKeJ9e0CIRTxbzwTOdkyy/aNjhIChHbcCG+risjOGUy8
	 GhNQkFCwyiQ4aS/JGmKUg6zx9Y9tf0hbIBQsGgeQfuRJbwnT0ER1iCD0OC/aIS3MEziRJ
	 GSiz79Uu41SwP7d0jMUdYXu+KUhNOBoSeEr1Ss8kg+tv1d7vxp13V+dJx69t4mnb6mA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794234179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cCt1XIpnjP+y2trPaY+czaNUTIGgsFIZ4SYjRFhBIQY=;
	b=b0UkfPdGXVxW5tsuz4m3rGvh8a6os5OCq8OzTMtsn3WwxNVgx+8Bsv4d1wCpHgfxk8Z0
	 E9M1oI3X5xtkVTk0VM+lPn0Hv/xxbx842/1pubWjtfGjpQEQU7i3tCEhjNSlon06jALuf
	 dUnNHZpjj+ln+3mwr9YrK6VAApOV28TLWTwnbBqsPqao5vJ+7Z046oyQwVDM2/LoZfilN
	 sPJ21zSjRdbY6KNdG/8WX/O/HRr3Rl2NUFhxNfJLVAVsYP+wt5eXgte7v4tlv9fipeSsk
	 blGlxN6sZM59ZdyJ/8DNS0OR2RdnqjkJJZr9fkP31MIJKVuWEipV/JfnkG5w0O1qIfA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794234179;
	bh=cCt1XIpnjP+y2trPaY+czaNUTIGgsFIZ4SYjRFhBIQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pbz9ed8VHUlN0Z0vX125TkKedBl/kAPVL68NfN1TMKjns3xKkVVH4wkCWdojyrCuo
	 q1rWe9uaJElqJsennr0XdmKoYqEQIBGFsEaikc04TllfWcWg1kMvQ1RN4OP0SoUvbf
	 BbCnXQnAPH67BvnY5HOyaP9q+eGvgAvwnrThCfe767Zy9ySCUGAKngNe89jBooBzAO
	 dZZA3/nN1GHx8akZA/0mzmhTQkuZh4f25vqngOjuhAqGqJ4SMWQHRRV0BD+0sYZUNo
	 zj4nAVc7cHhv7IPEGGwD/bkVD34ijugEbaQmx8hbadE2QHXOOqTC60MV7dBEle3Fex
	 EcPC3XGTfN4FA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E27040761;
	Mon,  9 Nov 2026 14:22:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 355F3932
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26FCA607BC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L6JZktiK8XmR for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 14:22:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2EB2D607B1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=84.16.66.169
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.169;
 helo=smtp-42a9.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=jSws6LfQ
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EB2D607B1
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:22:54 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jNX7J3c70zdGb;
 Mon,  9 Nov 2026 15:22:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794234172;
 bh=cCt1XIpnjP+y2trPaY+czaNUTIGgsFIZ4SYjRFhBIQY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jSws6LfQaHDOgTTyQkQrHxnp4bBBdvDGdpS2NJS4h5cJCcB+uvuoBOWwFXqhBtC/N
 SlxaurTfnEOn3rUMlPSrXbAJTuKkMePQhp6heoGYGs1jVZDOq8tzyGDublnMqis0Iw
 flT0n9eNjqXyOMAWulRQWptHbH/pAylM+I8CNqNMeP9Sh2pCoMt5H5KTlTayeVBdkk
 SBFMciUdcyRLUCSntB1KbY/06lxCFE6HAn8DDS8/ErHSaQWQRt2F04nNRCVh66gAQu
 vval4s2cVGNK/hO/RVGSCLe6VFcJrorWMjtNfTZJxDfQoeunLRZFd6NorM/ZC8iD14
 MhNT3EiX7Jozg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jNX7H2068zb5w; Mon,  9 Nov 2026 15:22:51 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 09 Nov 2026 15:22:27 +0100
Subject: [PATCH 1/2] MAINTAINERS: remove Kever from Rockchip custodians
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-rockchip-maintainers-update-v1-1-d8f568818a1a@cherry.de>
References: <20261109-rockchip-maintainers-update-v1-0-d8f568818a1a@cherry.de>
In-Reply-To: <20261109-rockchip-maintainers-update-v1-0-d8f568818a1a@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, chenjh@rock-chips.com
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

Kever has a new position at Rockchip for some months already and doesn't
have time to manage U-Boot custodianship anymore.

This has been confirmed to me in private last week.

In any case, it matches the current state as Kever doesn't have an
account on the new GitLab so cannot do anything related to Rockchip
there anymore.

We thank Kever for his work as a custodian for the last 7 years. I
believe his custodianship is one of the many reasons Rockchip has such a
vibrant community and I hope Rockchip will keep working with us to
support their new and existing SoCs for years to come.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b6ce499d0c20..adea20d5f36b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -547,7 +547,6 @@ F:	drivers/usb/host/xhci-rcar*
 
 ARM ROCKCHIP
 M:	Quentin Schulz <u-boot@0leil.net>
-M:	Kever Yang <kever.yang@rock-chips.com>
 R:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git

-- 
2.56.0

