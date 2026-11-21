Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDAE606A680
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yRTAQshp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9Jbmu0A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D633B816D3;
	Sat, 21 Nov 2026 00:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a3FdjLC8XlC5; Sat, 21 Nov 2026 00:14:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C2D7816FA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795220075;
	b=RPavwqgisYw0x9GzDbHrz5FYsq/PRzWaJDsqc1B8Y3qKPISSxdm8BW4oLb+BZzVr3+PU
	 RcRwThE93+R2EbtdweZsBjvmO97+pQZjbG1qeiRK5xc0w9R3lFFlIsWgRdUDNMj5/nRr7
	 2LR8tkBSW0gXtU2M+X+Uc33kI5OhxBV83n0cS0CoCUyUT6l7rP4JNXdR5C9LGydN0BHRo
	 6SH/wU2FaFKSIohIdUetuGkT9azUcfVWNh4iUP/2zDglUIjaNGIrSkLOofio+kuViiae2
	 psAqNoE7392oSZZRq5egwqcqCv3Go+ii1618oWmNFpcoT6+92j1rTX1CRLD2c0C6/7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795220075;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iXCMYUMxwbFsckqDJTVzXNLQbhClrh51n8bjW+R3Rik=;
	b=NCOwjE/lXB/n6uoLvBlZkWBFcTWrTKaO4r2tw0KMN6NDDQNYt52meDSl5l8oMF5nxhqU
	 tcxOt3wWEG+3PiF6NfFxjAu9bYlAuQXOJE5niZyYOHJ+e4zxUCUWueVn2RlYiMANX4YNp
	 I3gqPDKLf7+nTkrXsmIUsZrBUHASJU8RLT9wiDAE6aOXKOU9OL/d7lquDICPbp5vqAz5g
	 QdZ/2faEpYaW8pKbwmGo1iYklf4O9bzvW6Sz3JDJ6AxZqsFC2AdP4ndWbzkZ3JRmIsKKU
	 aGTZ82BCg2FZUTl1mKxUUCiQLZ4twud9mF+pxv8uG0eeZc0vORIfUn+dEJ+4Kppxnkw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795220075;
	bh=iXCMYUMxwbFsckqDJTVzXNLQbhClrh51n8bjW+R3Rik=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yRTAQshp39vIwUAHMWYJkexY/Uxm/qai93BCunz3+Cx0ENFlgXzRnP3CM+fu4Qrrd
	 3uv2ngcZlCDSq+jDSj7eBRCePA7OTw8WZx969tH+Q01jRpYp9cWpGIFmZdVn1lEG4W
	 VoJ2JmQ6KlF4WDiermoDfJbK1oYvqkLADWxh7L+Doibhy0FBT9fn/Y/6IGjsEjvnDC
	 QNFaoLgh3XW2PhBic01FpcAnb/Pu7g9/dqrpRC45UpmQCw7oWNWN5boyvc/yWInjEP
	 x+/yiqkAq+GfvWSxoRFXIqAur9FdpQm43fOcbSCa79gtugqFWQv20NVWgP45oaisGr
	 cc4EXVIDwQShw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C2D7816FA;
	Sat, 21 Nov 2026 00:14:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9332C9C1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 00:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78CBA405D7
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 00:14:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v2ESto7ZVlrN for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 00:14:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DDABF405B6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=T9Jbmu0A
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DDABF405B6
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 00:14:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6537A442A0;
 Sat, 21 Nov 2026 00:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1344A1F000CA;
 Sat, 21 Nov 2026 00:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795220070;
 bh=iXCMYUMxwbFsckqDJTVzXNLQbhClrh51n8bjW+R3Rik=;
 h=From:Date:Subject:To:Cc;
 b=T9Jbmu0AGy3bapIzTYNLenFItKAbHguheYvN9dPBfQfiabIhpyR05EFmdHK/VNvcf
 Bkl2R9lEtcXnm8eLkZ4iGSeLKIu7fCIiLa/+EqMx7BM8e4s/9s3IagNYgo8Wgbm/+p
 znFIF8scJMJAX1U3lUSNqPv+6tORTrb/p495bnZVS3fjTqWMUVfCO2UbCvedUKtGDv
 wzv7SpTof3apLaAosJaHKaVLK3o9AvvHr4gf3Eod+0+saO/QDUiSXdD002Lu6MgShr
 Oltz5B0jbr1R6XkZROJQCyElH7MZL0PeBQaBB+gi8K1eoU7q5jpJjbQIg7Pj35jFUL
 4hBj7JkAIFA0g==
From: Yixun Lan <dlan@kernel.org>
Date: Sat, 21 Nov 2026 00:14:23 +0000
Subject: [PATCH] mmc: spacemit: k3: Add compatible string
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-05-spacemit-k3-sdhci-v1-1-0c9eff3d6b71@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5DQBCA4VeROZtkd9G0XkV6YHYwbYrsqEjEu
 1scv8P/b6AchBXKZIPAi6iMQ4RNE6C+HjpG8dHgjHtY6yyaAnWqiX8y4zdD9T0JPj29PBeUO5N
 BTKfArazXtnrf1n/zYZrPF+z7ASRGQC94AAAA
X-Change-ID: 20261121-05-spacemit-k3-sdhci-8dc9de5c4203
To: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=dlan@kernel.org;
 h=from:subject:message-id; bh=KA/kE6Ohk5zyq5edmvHFoyzxbPfdeoPtH088d8tN/j8=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBrAOJhrXjjZg+eWqF4EBazYo/UZWwkqNxj0f8w9
 dZAPzTAAHWJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCawDiYRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1XPw//aRGXsMLngx6eJFL9ONTqGlj73Fz4VDkKx5DZXqtAIh2wQerWsk2sA
 8GkJLLBb8j769XueiadhWXma4wZ+ByB9a0d0s4U6vvDsHEBCZBSM9Fio7VxN8+uQ3jVf3GrrrEf
 BvChPS2JJGtnG44Mn60dXik+3VuRdVtEB2fG8ZooLMeHo/OKoZ+DXNfJfnc7HfJHyOt9Rw282OB
 /4Pp45ZdVl/Rw9TfWOQez8gv20UdvTAizc4Ugreui8IxinV0hSD3OCn7F7KCWyG2wwj/ERvyXJm
 7oWOE0EaRs/o7BP9PJgbB0OU7onHDDtoZ4Hp1d1f/2wVPYOZED9yH6x343EH0yA7bQxWc9mBn4Y
 nKCNmE9S8ZIQNzd5igieNgOUMtY5ezFbEE7ICvvpcY5aGcTlHdBuOCT5zcVhLW+PRkw8Sc2xPTy
 Yg2knl/27l9JxR2ORM6ntwZe4EimCvTXpuPiRfcDtkZhFCi6OYqeF+PFAiwyhgnQtsKXAw052Wu
 ufm+6YO7C7lwaGf2iB1Uevdh0mH3jI7yYZkOTzXWkZYGCC4KlRJC+FZFZ9nqT15ousoRb4Hsy6Z
 WoR5pIi1OoVuCE4/3OVRlBAd/nyB+fgtvwF19W9FUcFnSojzCN2W4kSivXFecxi3RZYroUqjVcu
 Wo0U9tWoWoFSz9X4jDv/1zARJZhw2Q=
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add compatible string for SpacemiT K3 SoC to enable support for
the SDHCI controller which necessary for bring up eMMC and SdCard.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
This is necessary for enabling SDHCI controller in SpacemiT K3 SoC
platform, as there is no fallback compatible defined in device tree
documentation.

I've tested in K3 CoM260 IFX board.
---
 drivers/mmc/spacemit_sdhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index fdedb9a301a..35f6c0a7cd7 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -660,6 +660,7 @@ static int spacemit_sdhci_bind(struct udevice *dev)
 
 static const struct udevice_id spacemit_sdhci_ids[] = {
 	{ .compatible = "spacemit,k1-sdhci" },
+	{ .compatible = "spacemit,k3-sdhci" },
 	{ }
 };
 

---
base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
change-id: 20261121-05-spacemit-k3-sdhci-8dc9de5c4203

Best regards,
--  
Yixun Lan <dlan@kernel.org>

