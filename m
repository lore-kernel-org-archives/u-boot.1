Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC6606A31F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SXrG8kJG;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nI2dE0zi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF06140560;
	Mon, 26 Oct 2026 13:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rt4W-3P6TL8d; Mon, 26 Oct 2026 13:40:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E3241406C9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793022031;
	b=fE+5XcwOTdy6fQH/pDb25uXTXe9VvklNTCcCbWAcEIqHQVOCZ7ACVpaoqf0gcgG45JAh
	 D74sa4u0UT23VdR53fGyjTUSKlzUsBebPtxq3CDfqcrlkle8efDQN9ulBq4OKDIImxcCh
	 8tHKTXlcmt+AS2Ymw/so4/LCNI1i4QA/7Wf1Yn/C1sMItd2JuM0kdWdjVgQzz/bC/VQ5V
	 WPYgn+H+sI0CPkTPKyV4rE9hgV07ayhJLxKojNMwm0P55xnnppa23j+EU/fCIbjKxMUA5
	 5QV2eGoZWLymUhiXm3Z7K+jBYNQrUbzxkbe1ESrXXj82XESm+y9G0fC7TekmzG1P5WQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793022031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QesyLOC83yUtDHV9w5MmuFsfQYDVKF8PXPfwx6i7zmI=;
	b=YWJbPE/TX+b9krlBUVB2I/npTNbUDaDKGYZaAxAuxZ6k+77n0uHDKmXY/1epZPGmjImb
	 0N6tFkCaCIMBl0SDbvPpKF8ZS8VOLjDrdfgm2p5zfeeI5M1YlQiFregrqu/mj8pBfq56T
	 vCOqexniy+C/mzs9xS6Q8dhtLki9uVfb5Bf6bHu6WrCIbv1tKOcyO0YS59U4YkB9iqDRq
	 zQ4aoViC+yiL6giPqdHz4pkT1MUkYnmaWap5DbeXXmi9OobZq4Ht/8hX4pxDsCmA5c1kN
	 QklVXU3pUwuwoAk23bDGYJtaqHKtvqfd+qKGSGgGEz0RwwhC2CDXgdejcpAhziwx4yw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793022031;
	bh=QesyLOC83yUtDHV9w5MmuFsfQYDVKF8PXPfwx6i7zmI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SXrG8kJGXgVZ+svKKkjH3mmb3fnrqtaKLY3m4NhxQzmsrES0J6LA+3ex/kVKcLqEb
	 pPnQKmk06vC6j6cms4Euo1sv/1FEXbZukRmM6Y8pcYOTfiYFr6MUicyHqZCxCAB9Oe
	 l4+i9OnNUsLjz3o/P+287uQV7f7X0hJLBeMGvqrblUxxBvp5U91waEDnKfyXO7G9hi
	 ek89PnQaJVJRGN3QZWQcHM8A5Q2pVRjLhg0rX+kruXOhaBW0JDAY7TmRFxzPlcM1eL
	 d+7+4QKggG3EsO6E03GSBCsF7Viu92+oGJ00LhZXH7sJWNED43+ic652rAKlj/LYCe
	 U6wCkKD3P6qHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3241406C9;
	Mon, 26 Oct 2026 13:40:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 909CC279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81C5B60608
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XKn18SLSePag for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:40:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7BFD0605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793022024;
 b=NyufK0lZ2PySFhYalaJB44VUcLXLgQLI0J4/ZEjktEqJSerZJN8Vl+GCp9RsDdaR00vn
 1PoiaV7kK2WDY2bFr8JM0mQxTElypYmWnzAZ3osxfAu87aPSMBsiHYoAmjJAN4uRKbqRH
 Dd7r5q7VY7JHSIqj8kJCsWqQc0XLBSr9bSluIse2jImc9MRya5SXhcgmJujgP4MARdvT8
 BYwX3SYi/bSWu8tP50TmaS9ZaGmNAMguOMYAMPKPmKmMoMYJ+IeSg9re1ICcfiy30aIAt
 nGrfyylo0j7FNlLUrkIU9C8yWUasE0HurVvbkAWieVTvLGYQPhLSU+qla9+jEIjyI0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793022024;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=QesyLOC83yUtDHV9w5MmuFsfQYDVKF8PXPfwx6i7zmI=;
 b=Pi5VWwwdgw+FPcxouc0FYAGRbuiuR9KyYkKyE/060PwGn+f+C/LSBP2OBWrE9b05+Ely
 cE/QIy0trhLvDW/8o/4Neu0AXS6T4uP7utDOuBCpYb3414JdzAiPzXHeQqSOxnDYEAX8n
 dfLSyyy2acpRDv1IdBEzFeKZD180DxxulfOyDRJmd4CLlZW/GQip7bIAXmVzlKpfDvJ+b
 beh1QNpKMf6TNclMbNWhRzB2nbm3mkIZFJakRuk1uQtOeURTOu7QadDUdzC+0GEKtp3dp
 4c+3N6SqlXRwdF2dO36ybZM7yriBhK5gbsgNh6QmRSj3BbDCWDXUEpWmAYW5i16jvSQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nI2dE0zi; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=nI2dE0zi
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BFD0605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:24 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4956869750eso19936415e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793022022; x=1793626822;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QesyLOC83yUtDHV9w5MmuFsfQYDVKF8PXPfwx6i7zmI=;
 b=nI2dE0ziwkHQqnTYAlccci91gV1yUaGP0kbL0o3b/YExLhM+z851Cqv60ZWeCa4Nno
 2906oojg9LnecJqleG6aTy1xrzK1jdDBPbr23RMLVqoo78G7knEPj4dyhrjFx+uC+SZA
 9S+PT3hjohToIvnaYykKHFuxxD5s3ul6S/h/H1dxBwLghNTEuvF+Qq7IpTNV19ozxUtN
 gXD7pc8WhNouukQURfW317YrTE8TB+3xklNqq+8RJH9tsRGKpSztaG8yOfwgqZnsyTwc
 yMts6s60J/uQHoVcdB6VoZjF9TgYTLeEwIM9guSAj+HLOUC2j+SUIid9aSfgNGdkHRUc
 pUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793022022; x=1793626822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QesyLOC83yUtDHV9w5MmuFsfQYDVKF8PXPfwx6i7zmI=;
 b=xeuUcsqCvnXOdWTXpOnDgASfrbqqtiyPOW2q7Fboif0DMzDCDHE/EH4qwPg7JFmDKe
 MyPegUbrqOc8kcFTcMRjOCzD77Z8FFlOeZLFQype1FcO8yc3U2yGoXp2ZjdhRIcq7IJk
 PdSNARmL2RJYNJgF+fFJw+aO31sdNndGcVbka0p2506t1HO8GSzdAEuKGlS/jVHNT/MZ
 HX90WXQkzHUwC+aJv8uj7eV0zQkF2bGmyn3jbliVeRFgnpo0Vw1f4CQcwvniWB8JXsEc
 iIEckyjnwgz5IZFeVMPSs6jLWA9tKqoDEnLCbK/fh12WKfAU8G2BvYPntnAdV+xBCUA0
 MSaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqrzO9SlUmYj5XWk4n9txBcnFoB1w0cFnqAc1quNhIerGUgD2xev3GveapsMANIVWTl8Pb2cU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIWoarmqrW9QhZds39CikreDk7GjPTOisVsEp5FEwPuG9RncoX9
 jUroMpW/VgrChPAdYwlRfMB7RBg5Nt1WrDeqs1GJ9/vzniCKFxT2vy8M
X-Gm-Gg: AYBFou1RJ2SqUdnQiUM7UKj89wJYBgcoCQWP3GLfp8QKggL44omDNkpXKeO5U7S1OcB
 LxMSnlx8q8ZAmEefQWiWk4oEH9bo4cqZvKWJhJ3l1Tg2Qvnqns4sFIGCCMQQz/TdwY1BHM/UjJ2
 zk9SDUSDi3Y4vVwVkOQAjn2zitOMX+/4BGpIYib6JvcF1hoc7K7fG+aixXO/gcB6hE5oN1d4Vcr
 YHlcPkBosX+1RhsTx6PtCg5ARHf8X+Gs0Vh2bo6GzcbJf+/2WNr2XmbtKDE8PsMJod94Svvlvwg
 uJF//Ss9YhNtC5vgnaKRk8hIH1o5wrvpygevI+bfEttQrAAwh2UQW74RoimmEq0BO7X+XQ5Lx/B
 1tQhzhxWGfnBM0RQnLxhPYgh2DAGHQft7Hd/E6Ljru148ukH+obzbNLYq/VRUK6RbckYGiMVZwj
 GnjaFjUB1/7ynEEZcZuDvnYorB9+BMUEbwUlkeVrGpKgPF89cJXY8MlUL/sOlRVxx4lI+U5VzDy
 LkpqkTI72RaztRjkhBrpVAulJrjn6KSgsWvIbXywQEaQc6R9+LiScoOa0uBH1X83pPBfya4MFqv
 XjbsfU+ABulmIV1gQnxJHhPVLq58Y3zV9fhMLg+0uBCKvclJxmqjQQzBsKIP
X-Received: by 2002:a05:600c:3b25:b0:4a2:1a:a128 with SMTP id
 5b1f17b1804b1-4a35ac9f1ecmr135221795e9.19.1793022022132; 
 Mon, 26 Oct 2026 06:40:22 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2c0458sm194344375e9.11.2026.10.26.06.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:40:21 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Daniel Golle <daniel@makrotopia.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Randolph Sapp <rs@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v10 4/8] misc: fs_loader: validate requested offset on reading
 file
Date: Mon, 26 Oct 2026 14:39:57 +0100
Message-ID: <20261026134002.109025-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026134002.109025-1-ansuelsmth@gmail.com>
References: <20261026134002.109025-1-ansuelsmth@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make sure we are not requesting an offset for the requesting file beyond
the size of the file.

If it's such the case, log an error and return -EINVAL.

Code is reworked and split in various subfunction to permit re-preparing
the filesystem after a fs_close (called by fs_size) and reduce patch delta
of upcoming support for reading ONLY the size of the requested firmware.

Dedicated mount function are created to mount relevant filesystem only once
and follow the same if-else logic pattern used by the prepare functions.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fs_loader.c | 97 ++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index b1eb0311dd2b..7f7403403611 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -49,6 +49,16 @@ static int mount_ubifs(char *mtdpart, char *ubivol)
 }
 #endif
 
+static int mount_fs_dev(struct fw_loader_plat *plat)
+{
+	if (plat->phandlepart.phandle)
+		return 0;
+	else if (plat->mtdpart && plat->ubivol)
+		return mount_ubifs(plat->mtdpart, plat->ubivol);
+	else
+		return 0;
+}
+
 static int select_fs_dev(struct fw_loader_plat *plat)
 {
 	int ret;
@@ -63,10 +73,6 @@ static int select_fs_dev(struct fw_loader_plat *plat)
 			ret = fs_set_blk_dev_with_part(desc,
 				plat->phandlepart.partition);
 	} else if (plat->mtdpart && plat->ubivol) {
-		ret = mount_ubifs(plat->mtdpart, plat->ubivol);
-		if (ret)
-			return ret;
-
 		ret = fs_set_blk_dev("ubi", NULL, FS_TYPE_UBIFS);
 	} else {
 		debug("Error: unsupported storage device.\n");
@@ -79,18 +85,26 @@ static int select_fs_dev(struct fw_loader_plat *plat)
 	return ret;
 }
 
-/**
- * fw_get_filesystem_firmware - load firmware into an allocated buffer.
- * @dev: An instance of a driver.
- *
- * Return: Size of total read, negative value when error.
- */
-static int fw_get_filesystem_firmware(struct udevice *dev)
+static int fw_get_filesystem_mount(struct udevice *dev)
+{
+	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
+	struct fw_loader_env_info info = { };
+
+	generic_fw_loader_env_info(&info);
+
+	if (info.storage_interface && info.dev_part)
+		return 0;
+	else if (info.storage_interface && info.ubi_mtdpart &&
+		 info.ubi_volume)
+		return mount_ubifs(info.ubi_mtdpart, info.ubi_volume);
+	else
+		return mount_fs_dev(plat);
+}
+
+static int fw_get_filesystem_prepare(struct udevice *dev)
 {
-	struct firmware *upriv = dev_get_uclass_priv(dev);
 	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
 	struct fw_loader_env_info info = { };
-	loff_t actread = 0;
 	int ret;
 
 	generic_fw_loader_env_info(&info);
@@ -100,10 +114,6 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 				     info.dev_part, FS_TYPE_ANY);
 	} else if (info.storage_interface && info.ubi_mtdpart &&
 		   info.ubi_volume) {
-		ret = mount_ubifs(info.ubi_mtdpart, info.ubi_volume);
-		if (ret)
-			return ret;
-
 		if (!strcmp("ubi", info.storage_interface))
 			ret = fs_set_blk_dev(info.storage_interface, NULL,
 					     FS_TYPE_UBIFS);
@@ -113,6 +123,55 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 		ret = select_fs_dev(plat);
 	}
 
+	return ret;
+}
+
+static void fw_get_filesystem_release(struct udevice *dev)
+{
+#ifdef CONFIG_CMD_UBIFS
+	umount_ubifs();
+#endif
+}
+
+static int __fw_get_filesystem_firmware_size(struct udevice *dev,
+					     const char *name, loff_t *size)
+{
+	int ret;
+
+	ret = fw_get_filesystem_prepare(dev);
+	if (ret)
+		return ret;
+
+	return fs_size(name, size);
+}
+
+/**
+ * fw_get_filesystem_firmware - load firmware into an allocated buffer.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+static int fw_get_filesystem_firmware(struct udevice *dev)
+{
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	loff_t size, actread = 0;
+	int ret;
+
+	ret = fw_get_filesystem_mount(dev)
+	if (ret)
+		goto out;
+
+	ret = __fw_get_filesystem_firmware_size(dev, upriv->name, &size);
+	if (ret)
+		goto out;
+
+	if (upriv->offset > size) {
+		log_err("Invalid offset. Entry too small\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = fw_get_filesystem_prepare(dev);
 	if (ret)
 		goto out;
 
@@ -127,9 +186,7 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 	}
 
 out:
-#ifdef CONFIG_CMD_UBIFS
-	umount_ubifs();
-#endif
+	fw_get_filesystem_release(dev);
 	return ret;
 }
 
-- 
2.55.0

